---
title: Troubleshoot Azure Files SMB connectivity and access issues
description: Troubleshoot problems connecting to and accessing SMB Azure file shares from Windows and Linux clients, and see possible resolutions.
services: storage
ms.service: azure-file-storage
ms.custom: sap:Connectivity, devx-track-azurepowershell, linux-related-content
ms.date: 05/29/2026
ms.reviewer: kendownie, jarrettr, v-weizhu, v-six, hanagpal, justingross
---
# Troubleshoot Azure Files connectivity and access problems (SMB)

This article lists common problems that might occur when you try to connect to and access Server Message Block (SMB) Azure file shares from Windows or Linux clients. It also provides possible causes and resolutions for these problems.

[!INCLUDE [Feedback](../../../../includes/feedback.md)]

> [!IMPORTANT]
> This article applies only to SMB shares. For details about Network File System (NFS) shares, see [Troubleshoot Azure NFS file shares](/azure/storage/files/files-troubleshoot-linux-nfs).

## Applies to

| File share type | SMB | NFS |
|-|:-:|:-:|
| Standard file shares (GPv2), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/yes-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/no-icon.png" border="false"::: |
| Standard file shares (GPv2), GRS/GZRS | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/yes-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/no-icon.png" border="false"::: |
| Premium file shares (FileStorage), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/yes-icon.png" border="false"::: | :::image type="icon" source="media/files-troubleshoot-smb-connectivity/no-icon.png" border="false"::: |

## Can't connect to or mount an Azure file share

Select the Windows or Linux tab depending on the client operating system that you're using to access Azure file shares.

### [Windows](#tab/windows)

When you try to connect to an Azure file share in Windows, you might receive the following error messages.

### <a id="error5"></a>Error 5 when you mount an Azure file share

- System error 5 has occurred. Access is denied.

#### Cause 1: Unencrypted communication channel

For security, connections to Azure file shares are blocked if the communication channel isn't encrypted and the connection attempt isn't made from the same datacenter where the Azure file shares reside. If the **Secure transfer required** setting or the **Require encryption in transit for SMB** setting is enabled on the storage account, unencrypted connections within the same datacenter are also blocked. An encrypted communication channel is only provided if the user's client OS supports SMB encryption.

Windows 8, Windows Server 2012, and later versions of each system negotiate requests that include SMB 3.*x*, which supports encryption.

#### Solution for cause 1

1. Connect from a client that supports SMB encryption (Windows 8/Windows Server 2012 or later).
1. Connect from a virtual machine (VM) in the same datacenter as the Azure storage account that's used for the Azure file share.
1. If the client doesn't support SMB encryption, verify that both the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting and the [Require encryption in transit for SMB](/azure/storage/files/files-smb-protocol#smb-security-settings) setting are disabled on the storage account.

#### Cause 2: Virtual network or firewall rules are enabled on the storage account

Network traffic is denied if the virtual network (VNET) and firewall rules are configured on the storage account, unless the client IP address or virtual network is allow-listed.

#### Solution for cause 2

Verify that virtual network and firewall rules are configured properly on the storage account. To test if the virtual network or firewall rules are causing the issue, temporarily change the setting on the storage account to **Allow access from all networks**. To learn more, see [Configure Azure Storage firewalls and virtual networks](/azure/storage/common/storage-network-security).

#### Cause 3: Share-level permissions are incorrect when using identity-based authentication

If users are accessing the Azure file share using identity-based authentication, access to the file share fails with the "Access is denied" error if share-level permissions are incorrect.

#### Solution for cause 3

Validate that share-level permissions are configured correctly. See [Assign share-level permissions](/azure/storage/files/storage-files-identity-assign-share-level-permissions).

### <a id="error53-67-87"></a>Error 53, Error 67, or Error 87 when you mount or unmount an Azure file share

When you try to mount a file share from on-premises or a different datacenter, you might receive the following errors:

- System error 53 has occurred. The network path was not found.
- System error 67 has occurred. The network name cannot be found.
- System error 87 has occurred. The parameter is incorrect.

#### Cause 1: Port 445 is blocked

System error 53 or System error 67 can occur if port 445 outbound communication to an Azure Files datacenter is blocked. To see the summary of ISPs that allow or disallow access from port 445, go to [TechNet](https://social.technet.microsoft.com/wiki/contents/articles/32346.azure-summary-of-isps-that-allow-disallow-access-from-port-445.aspx).

To check if your firewall or ISP is blocking port 445, use the [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Windows) tool or the `Test-NetConnection` cmdlet.

To use the `Test-NetConnection` cmdlet, the Azure PowerShell module must be installed. See [Install Azure PowerShell module](/powershell/azure/install-azure-powershell) for more information. Remember to replace `<your-storage-account-name>` and `<your-resource-group-name>` with the relevant names for your storage account.

```azurepowershell
$resourceGroupName = "<your-resource-group-name>"
$storageAccountName = "<your-storage-account-name>"

# This command requires you to be logged into your Azure account and set the subscription your storage account is under, run:
# Connect-AzAccount -SubscriptionId 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
# if you haven't already logged in.
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

# The ComputerName, or host, is <storage-account>.file.core.windows.net for Azure Public Regions.
# $storageAccount.Context.FileEndpoint is used because non-Public Azure regions, such as sovereign clouds
# or Azure Stack deployments, will have different hosts for Azure file shares (and other storage resources).
Test-NetConnection -ComputerName ([System.Uri]::new($storageAccount.Context.FileEndPoint).Host) -Port 445
```

If the connection was successful, you should see the following output:

```output
ComputerName     : <your-storage-account-name>
RemoteAddress    : <storage-account-ip-address>
RemotePort       : 445
InterfaceAlias   : <your-network-interface>
SourceAddress    : <your-ip-address>
TcpTestSucceeded : True
```

> [!NOTE]
> This command returns the current IP address of the storage account. This IP address isn't guaranteed to remain the same, and it may change at any time. Don't hardcode this IP address into any scripts or into a firewall configuration.

#### Solutions for cause 1

**Solution 1 — Use Azure File Sync as a QUIC endpoint** You can use Azure File Sync as a workaround to access Azure Files from clients that have port 445 blocked. Although Azure Files doesn't directly support SMB over QUIC, Windows Server 2022 Azure Edition does support the QUIC protocol. You can create a lightweight cache of your Azure file shares on a Windows Server 2022 Azure Edition VM using Azure File Sync. This configuration uses port 443, which is widely open outbound to support HTTPS, instead of port 445. To learn more about this option, see [SMB over QUIC with Azure File Sync](/azure/storage/files/storage-files-networking-overview#smb-over-quic).

**Solution 2 — Use VPN or Azure ExpressRoute** By setting up a virtual private network (VPN) or ExpressRoute from on-premises to your Azure storage account, with Azure Files exposed on your internal network using private endpoints, the traffic goes through a secure tunnel as opposed to over the internet. Follow the [instructions to setup a VPN](/azure/storage/files/storage-files-configure-p2s-vpn-windows) to access Azure Files from Windows.

**Solution 3 — Unblock port 445 with help from your ISP/IT admin** Work with your IT department or ISP to open port 445 outbound to [Azure IP ranges](https://www.microsoft.com/download/details.aspx?id=56519).

**Solution 4 — Use REST API-based tools like Storage Explorer or PowerShell** Azure Files also supports REST in addition to SMB. REST access works over port 443 (standard tcp). Various tools that are written using REST API enable a rich UI experience. [Storage Explorer](/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows) is one of them. [Download and Install Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) and connect to your file share backed by Azure Files. You can also use [PowerShell](/azure/storage/files/storage-how-to-use-files-portal) that also uses REST API.

#### Cause 2: NTLMv1 is enabled

System error 53 or system error 87 can occur if NTLMv1 communication is enabled on the client. Azure Files supports only NTLMv2 authentication. Having NTLMv1 enabled creates a less-secure client. Therefore, communication is blocked for Azure Files.

To determine whether this is the cause of the error, verify that the following registry subkey isn't set to a value less than 3:

**HKLM\SYSTEM\CurrentControlSet\Control\Lsa > LmCompatibilityLevel**

For more information, see the [LmCompatibilityLevel](/previous-versions/windows/it-pro/windows-2000-server/cc960646(v=technet.10)) topic on TechNet.

##### Solution for cause 2

Revert the `LmCompatibilityLevel` value to the default value of 3 in the following registry subkey:

`HKLM\SYSTEM\CurrentControlSet\Control\Lsa`  

#### Cause 3: The file share name doesn't exist or there's a typo in the share name

Error 67 can occur when the storage account exists and the SMB endpoint is reachable, but the SMB namespace or share path can't be resolved. This problem isn't a DNS issue, an authentication issue, or a permissions issue.

##### Solution for cause 3

Double check the file share name. Azure file share names must be exact. Check for an extra character, missing characters, or an incorrect share name copied from the Azure portal. Retry mounting the share.

### <a id="error-64"></a> Error 64 when you mount an Azure file share

When you mount a file share from on-premises or another datacenter, you might see the following error message:

> System error 64 has occurred. The specified network name is no longer available.

#### Cause

A proxy server or another type of Network Address Translation (NAT) device in the datapath blocks the connection to map the Azure file share. In this case, the PowerShell cmdlet `Test-NetConnection` might still test connectivity on port 445 successfully.

This problem occurs when the Active Directory computer or user account corresponding to the Azure storage account that hosts the FSLogix user profiles can't process Kerberos authentications. The underlying reasons might include incorrect modifications to the `msDS-SupportedEncryptionTypes` attribute, or the rotation of the storage account's access keys without updating the new keys on the Active Directory account.

#### Solution

To resolve this problem, reproduce it and collect a network trace to get more information about the error's origin. In most cases, you must work with your network or firewall administrator to allow the content to pass through the network device.

You can see Kerberos errors in a network trace, such as flows labeled as KRB Error in a `netsh` trace. To resolve them, [enable Active Directory Domain Services authentication for Azure file shares](/azure/storage/files/storage-files-identity-ad-ds-enable) to set up the authentication parameters properly.

### <a id="error-0x800704b3"></a> Failed with error code 0x800704b3

When you try to mount an Azure file share, you receive the following error message:

> Error code: 0x800704b3  
> Symbolic Name: ERROR_NO_NET_OR_BAD_PATH  
> Error description: The network path was either typed incorrectly, doesn't exist, or the network provider isn't currently available. Retype the path or contact your network administrator.

#### Cause

This error can occur if any core Windows network related services are disabled. Any service that explicitly depends on those network services fails to start.  

#### Solution

Check if any of the following services are in a **Stopped** state in the Windows VM:

- Network Connections  
- Network List Service  
- Network Location Awareness  
- Network Store Interface Service  
- DHCP Client  
- TCP/IP NetBIOS Helper  
- Workstation

If you find any, start the service(s) and retry mounting the Azure file share. 

### <a id="cannotaccess"></a>Application or service can't access a mounted Azure Files drive

#### Cause

You mount drives per user. If your application or service runs under a different user account than the one that mounts the drive, the application can't see the drive.

#### Solution

Use one of the following solutions:

- Mount the drive from the same user account that contains the application. You can use a tool such as PsExec.
- Pass the storage account name and key in the user name and password parameters of the `net use` command.
- Use the `cmdkey` command to add the credentials into Credential Manager. Perform this action from a command line under the service account context, either through an interactive sign-in or by using `runas`.
  
    ```console
    cmdkey /add:<storage-account-name>.file.core.windows.net /user:AZURE\<storage-account-name> /pass:<storage-account-key>
    ```

- Map the share directly without using a mapped drive letter. Some applications might not reconnect to the drive letter properly, so using the full UNC path might be more reliable:

  `net use * \\storage-account-name.file.core.windows.net\share`

After you follow these instructions, you might receive the following error message when you run `net use` for the system or network service account: "System error 1312 has occurred. A specified logon session does not exist. It may already have been terminated." If this error appears, make sure that the user name that you pass to `net use` includes domain information (for example: `[storage account name].file.core.windows.net`).

### <a id="shareismissing"></a>No folder with a drive letter in "My Computer" or "This PC"

If you map an Azure file share as an administrator by using the `net use` command, the share appears to be missing.

#### Cause

By default, Windows File Explorer doesn't run as an administrator. If you run `net use` from an administrative command prompt, you map the network drive as an administrator. Because mapped drives are user-centric, the user account that is logged in doesn't display the drives if they're mounted under a different user account.

#### Solution

Mount the share from a non-administrator command line. Alternatively, you can follow [this TechNet topic](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee844140(v=ws.10)) to configure the `EnableLinkedConnections` registry value.

### <a id="netuse"></a>Net use command fails if the storage account contains a forward slash

#### Cause

The `net use` command interprets a forward slash (/) as a command-line option. If your user account name starts with a forward slash, the drive mapping fails.

#### Solution

To work around this problem, use either of the following steps:

- Run the following PowerShell command:

    ```powershell
    New-SmbMapping -LocalPath y: -RemotePath \\server\share -UserName accountName -Password "password can contain / and \ etc"
    ```

  From a batch file, you can run the command this way:

  `Echo new-smbMapping ... | powershell -command –`

- Put double quotation marks around the key to work around this problem unless the forward slash is the first character. If it is, either use the interactive mode and enter your password separately, or regenerate your keys to get a key that doesn't start with a forward slash.

### <a id="newpsdrive"></a>New-PSDrive command fails with "the network resource type is not correct" error

#### Cause

You might see this error message if the file share isn't accessible. For example, [port 445 is blocked](#cause-1-port-445-is-blocked) or there's a DNS resolution issue.

#### Solution

Make sure port 445 is open and [check DNS resolution and connectivity to your file share](files-troubleshoot.md#check-dns-resolution-and-connectivity-to-your-azure-file-share).

### [Linux](#tab/linux)

Linux clients can use [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Linux) to automate symptom detection and ensure that they have the correct prerequisites.

Common causes for this problem include:

- You're using a Linux distribution with an outdated SMB client. See [Use Azure Files with Linux](/azure/storage/files/storage-how-to-use-files-linux) for more information on common Linux distributions available in Azure that have compatible clients.
- SMB utilities (cifs-utils) aren't installed on the client.
- The minimum SMB version, 2.1, isn't available on the client.
- SMB 3.x encryption isn't supported on the client. The preceding table provides a list of Linux distributions that support mounting from on-premises and cross-region using encryption. Other distributions require kernel 4.11 and later versions.
- You're trying to connect to an Azure file share from an Azure VM, and the VM isn't in the same region as the storage account.
- If the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting or the [Require encryption in transit for SMB](/azure/storage/files/files-smb-protocol#smb-security-settings) setting is enabled on the storage account, Azure Files accepts only connections that use SMB 3.x with encryption.

### Solution

If the client doesn't support SMB encryption, verify that both the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting and the [Require encryption in transit for SMB](/azure/storage/files/files-smb-protocol#smb-security-settings) setting are disabled on the storage account.

You can use the [troubleshooting tool for Azure Files mounting errors on Linux](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Linux) to resolve the problem. This tool:

- Helps you to validate the client running environment.
- Detects the incompatible client configuration that would cause access failure for Azure Files.
- Gives prescriptive guidance on self-fixing.
- Collects the diagnostics traces.

#### <a id="mounterror13"></a>"Mount error(13): Permission denied" when you mount an Azure file share

##### Cause 1: Unencrypted communication channel

For security reasons, connections to Azure file shares are blocked if the communication channel isn't encrypted and the connection attempt isn't made from the same datacenter where the Azure file shares reside. Unencrypted connections within the same datacenter can also be blocked if the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting is enabled on the storage account. An encrypted communication channel is only provided if the user's client OS supports SMB encryption.

To learn more, see [Prerequisites for mounting an Azure file share with Linux and the cifs-utils package](/azure/storage/files/storage-how-to-use-files-linux#prerequisites).

##### Solution for cause 1

1. Connect from a client that supports SMB encryption or connect from a virtual machine in the same datacenter as the Azure storage account that's used for the Azure file share.
1. Verify the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting is disabled on the storage account if the client doesn't support SMB encryption.

##### Cause 2: Virtual network or firewall rules are enabled on the storage account, or port 445 is blocked

If virtual network (VNET) and firewall rules are configured on the storage account, network traffic is denied unless the client IP address or virtual network is allowed access. This restriction includes scenarios where the storage account firewall blocks the VM's subnet, even when the VM and storage account are in the same region. In addition, if your company or ISP blocks port 445 outbound, you can't mount the share.

##### Solution for cause 2

Verify that the VM's subnet is allowlisted in the storage account firewall, and that port 445 isn't blocked. To test if virtual networks or firewall rules cause the issue, you can temporarily change the setting on the storage account to **Allow access from all networks**. 

To check and update the virtual network rules, use the Azure portal or Azure CLI.

To use the Azure portal, follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to your storage account.
1. Under **Security + networking**, select **Networking**.
1. On the **Firewalls and virtual networks** tab, confirm that **Enabled from selected virtual networks and IP addresses** is selected and that your VM's virtual network and subnet appear under **Virtual networks**.
1. If the subnet isn't listed, select **+ Add existing virtual network**, select the virtual network and subnet, and then select **Add**. Select **Save** to apply the changes.

To list the current virtual network rules by using Azure CLI, run the following command:

```azurecli
az storage account network-rule list --resource-group "<resource-group>" --account-name "<storage-account>" --query virtualNetworkRules
```

To add your VM's subnet, run:

```azurecli
subnetid=$(az network vnet subnet show --resource-group "<resource-group>" --vnet-name "<vnet-name>" --name "<subnet-name>" --query id --output tsv)
az storage account network-rule add --resource-group "<resource-group>" --account-name "<storage-account>" --subnet $subnetid
```

To test SMB connectivity after verifying the network rules, use the [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Windows) tool.

For more information, see [Configure Azure Storage firewalls and virtual networks](/azure/storage/common/storage-network-security).

##### Cause 3: SMB client is configured to use NTLMv1

Azure Files only supports NTLMv2 (storage account key only) and Kerberos authentication for SMB file shares. NTLMv1 isn't supported. Kernel 3.3 and later versions default to NTLMv2 unless overridden with the `sec` mount option. Kernel 4.4 and later versions enable NTLMv2 by default and disable LANMAN. Under default configurations, NTLMv1 is kept as a negotiation only option. For more information, see your OS documentation.

##### Solution for cause 3

Ensure that SMB mount commands don't override the default NTLMv2 authentication via the `sec` option. The `sec` option should never use `ntlm` or `ntlmi` when connecting to SMB Azure file shares. If you set global options in */etc/samba/smb.conf*, ensure that you don't disable NTLMv2.

##### Cause 4: Storage account key access is disabled or disallowed via a policy

When you disable or disallow storage account key access for a storage account, SAS tokens and access keys stop working.

##### Solution for cause 4

Use identity-based authentication instead. For prerequisites and instructions, see [Enable Active Directory authentication over SMB for Linux clients accessing Azure Files](/azure/storage/files/storage-files-identity-auth-linux-kerberos-enable).

##### Cause 5: SMB channel encryption is set to AES-256-GCM only

If you configure your Azure storage account to use only AES-256-GCM for SMB channel encryption, mount operations fail when the client defaults to AES-128-GCM.

##### Solution for cause 5

Configure the client to require AES-256-GCM by enabling the `require_gcm_256` option:

```bash
# Load the CIFS module
modprobe cifs

# Set the parameter at runtime
echo 1 | sudo tee /sys/module/cifs/parameters/require_gcm_256

# Persist the configuration
echo "options cifs require_gcm_256=1" | sudo tee -a /etc/modprobe.d/cifs.conf
```
You can also use a Kubernetes DaemonSet to enforce AES-256-GCM on every node. See the following example:

[support-cifs-aes-256-gcm.yaml](https://github.com/andyzhangx/demo/blob/master/aks/support-cifs-aes-256-gcm.yaml)
#### <a id="error115"></a>"Mount error(115): Operation now in progress" when you mount Azure Files by using SMB 3.x

##### Cause

Some Linux distributions don't yet support encryption features in SMB 3.x. Users might receive a "115" error message if they try to mount Azure Files by using SMB 3.x because of a missing feature. SMB 3.x with full encryption is supported only on the latest version of a Linux distro.

##### Solution

The encryption feature for SMB 3.x for Linux was introduced in the 4.11 kernel. This feature enables the mounting of an Azure file share from on-premises or a different Azure region. Some Linux distributions might backport changes from the 4.11 kernel to older versions of the Linux kernel that they maintain. To help determine if your version of Linux supports SMB 3.x with encryption, consult [Use Azure Files with Linux](/azure/storage/files/storage-how-to-use-files-linux).

If your Linux SMB client doesn't support encryption, mount Azure Files by using SMB 2.1 from a Linux VM that's in the same Azure datacenter as the file share. Verify that the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) setting is disabled on the storage account.

#### <a id="error112"></a>"Mount error(112): Host is down" because of a reconnection time-out

A "112" mount error occurs on the Linux client when the client is idle for a long time. After an extended idle time, the client disconnects, and the connection times out.  

##### Cause

The connection can be idle for the following reasons:

- Network communication failures that prevent re-establishing a TCP connection to the server when the default "soft" mount option is used.
- Recent reconnection fixes that aren't present in older kernels.

##### Solution

This reconnection problem in the Linux kernel is now fixed as part of the following changes:

- [Fix reconnect to not defer smb3 session reconnect long after socket reconnect](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/cifs?id=4fcd1813e6404dd4420c7d12fb483f9320f0bf93)
- [Call echo service immediately after socket reconnect](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8c600120fc87d53642476f48c8055b38d6e14c7)
- [CIFS: Fix a possible memory corruption during reconnect](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=53e0e11efe9289535b060a51d4cf37c25e0d0f2b)
- [CIFS: Fix a possible double locking of mutex during reconnect (for kernel v4.9 and later)](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=96a988ffeb90dba33a71c3826086fe67c897a183)

However, these changes might not be ported yet to all Linux distributions. If you're using a popular Linux distribution, you can check [Use Azure Files with Linux](/azure/storage/files/storage-how-to-use-files-linux) to see which version of your distribution has the necessary kernel changes.

##### Workaround

You can work around this problem by specifying a hard mount. A hard mount forces the client to wait until a connection is established or until it's explicitly interrupted. Use it to prevent errors because of network time-outs. However, this workaround might cause indefinite waits. Be prepared to stop connections as necessary.

If you can't upgrade to the latest kernel versions, you can work around this problem by keeping a file in the Azure file share that you write to every 30 seconds or less. This operation must be a write operation, such as rewriting the created or modified date on the file. Otherwise, you might get cached results, and your operation might not trigger the reconnection.

---

## Unable to access, modify, or delete an Azure file share (or share snapshot)

### "The user name or password is incorrect" error after a customer-initiated failover

In a customer-initiated failover scenario with geo-redundant storage accounts, the failover process doesn't retain file handles and leases. Clients must unmount and remount the file shares.

### <a id="noaaccessfailureportal"></a>Error "No access" when you try to access or delete an Azure file share

When you try to access or delete an Azure file share by using the Azure portal, you might receive the following error:

> No access Error code: 403

#### Cause 1: Virtual network or firewall rules are enabled on the storage account

##### Solution for Cause 1

Verify that virtual network and firewall rules are configured properly on the storage account. To test if virtual network or firewall rules are causing the issue, temporarily change the setting on the storage account to **Allow access from all networks**. To learn more, see [Configure Azure Storage firewalls and virtual networks](/azure/storage/common/storage-network-security).

#### Cause 2: Your user account doesn't have access to the storage account

##### Solution for cause 2

Browse to the storage account in which the Azure file share is located, select **Access control (IAM)**, and verify that your user account has access to the storage account. To learn more, see [How to secure your storage account with Azure role-based access control (Azure RBAC)](/azure/storage/blobs/security-recommendations#data-protection).

### File locks and leases

If you can't modify or delete an Azure file share or snapshot, file locks or leases might be the cause. Azure Files provides two ways to prevent accidental modification or deletion of Azure file shares and share snapshots:  

- **Storage account resource locks**: All Azure resources, including the storage account, support [resource locks](/azure/azure-resource-manager/management/lock-resources). An administrator or services such as Azure Backup can put locks on the storage account. Two variations of resource locks exist: **modify**, which prevents all modifications to the storage account and its resources, and **delete**, which only prevents deletions of the storage account and its resources. When you modify or delete shares through the `Microsoft.Storage` resource provider, Azure Files and share snapshots enforce resource locks. Most portal operations, Azure PowerShell cmdlets for Azure Files with `Rm` in the name (for example, `Get-AzRmStorageShare`), and Azure CLI commands in the `share-rm` command group (for example, `az storage share-rm list`) use the `Microsoft.Storage` resource provider. Some tools and utilities such as Storage Explorer, legacy Azure Files PowerShell management cmdlets without `Rm` in the name (for example, `Get-AzStorageShare`), and legacy Azure Files CLI commands under the `share` command group (for example, `az storage share list`) use legacy APIs in the FileREST API that bypass the `Microsoft.Storage` resource provider and resource locks. For more information on legacy management APIs exposed in the FileREST API, see [control plane in Azure Files](/rest/api/storageservices/file-service-rest-api#control-plane).

- **Share and share snapshot leases**: Share leases are a kind of proprietary lock for Azure file shares and file share snapshots. Administrators can put leases on individual Azure file shares or share snapshots by calling the API through a script or by value-added services such as Azure Backup. When a lease is put on an Azure file share or share snapshot, you can modify or delete the file share or share snapshot by using the lease ID. Admins can also release the lease before modification operations, which requires the lease ID, or break the lease, which doesn't require the lease ID. For more information on share leases, see [lease share](/rest/api/storageservices/lease-share).

Because resource locks and leases might interfere with intended administrator operations on your storage account/file shares, you might wish to remove any resource locks or leases that an administrator or value-added services such as Azure Backup put on your resources. The following script removes all resource locks and leases. Remember to replace `<resource-group>` and `<storage-account>` with the appropriate values for your environment.

Before running the following script, [install the latest version](https://www.powershellgallery.com/packages/Az.Storage/) of the Azure Storage PowerShell module.

> [!Important]
> Value-added services that take resource locks and share or share snapshot leases on your Azure Files might periodically reapply locks and leases. Modifying or deleting locked resources by value-added services might impact the regular operation of those services, such as deleting share snapshots that were managed by Azure Backup.

```powershell
# Parameters for storage account resource
$resourceGroupName = "<resource-group>"
$storageAccountName = "<storage-account>"

# Get reference to storage account
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName

# Remove resource locks
Get-AzResourceLock `
        -ResourceType "Microsoft.Storage/storageAccounts" `
        -ResourceGroupName $storageAccount.ResourceGroupName `
        -ResourceName $storageAccount.StorageAccountName | `
    Remove-AzResourceLock -Force | `
    Out-Null

# Remove share and share snapshot leases
Get-AzStorageShare -Context $storageAccount.Context | `
    Where-Object { $_.Name -eq $fileShareName } | `
    ForEach-Object {
        try {
            $leaseClient = [Azure.Storage.Files.Shares.Specialized.ShareLeaseClient]::new($_.ShareClient)
            $leaseClient.Break() | Out-Null
        } catch { }
    }
```

## <a id="open-handles"></a>Unable to modify, move, rename, or delete a file or directory

Select the Windows or Linux tab depending on the client operating system you're using to access Azure file shares.

## [Windows](#tab/windows)

In Windows, you might see the following errors.

### Orphaned file handles or leases

One of the key purposes of a file share is that multiple users and applications can simultaneously interact with files and directories in the share. To assist with this interaction, file shares provide several ways of mediating access to files and directories.

When you open a file from a mounted Azure file share over SMB, your application or operating system requests a file handle, which is a reference to the file. Among other things, your application specifies a file-sharing mode when it requests a file handle. This mode specifies the level of exclusivity of your access to the file that Azure Files enforces:

- `None`: you have exclusive access.
- `Read`: others can read the file while you have it open.
- `Write`: others can write to the file while you have it open.
- `ReadWrite`: a combination of both the `Read` and `Write` sharing modes.
- `Delete`: others can delete the file while you have it open.

Although the FileREST protocol is a stateless protocol and doesn't have a concept of file handles, it does provide a similar mechanism to mediate access to files and folders that your script, application, or service can use: file leases. When you lease a file, treat it as equivalent to a file handle with a file sharing mode of `None`.

Although file handles and leases serve an important purpose, sometimes they're orphaned. When this situation occurs, it can cause problems in modifying or deleting files. You might see error messages like:

- The process can't access the file because the file is being used by another process.
- The action can't be completed because the file is open in another program.
- The document is locked for editing by another user.
- The specified resource is marked for deletion by an SMB client.

The resolution to this issue depends on whether an orphaned file handle or lease causes the problem.

> [!NOTE]
> Applications use REST leases to prevent files from being deleted or modified. Before breaking any leases, identify which application is acquiring them. Otherwise, you might break the application behavior.

#### Cause 1

A file handle prevents a file or directory from being modified or deleted. Use the [Get-AzStorageFileHandle](/powershell/module/az.storage/get-azstoragefilehandle) PowerShell cmdlet to view open handles.

If all SMB clients close their open handles on a file or directory and the issue continues to occur, you can force close a file handle.

#### Solution 1

To force close a file handle, use the [Close-AzStorageFileHandle](/powershell/module/az.storage/close-azstoragefilehandle) PowerShell cmdlet.

> [!NOTE]  
> The `Get-AzStorageFileHandle` and `Close-AzStorageFileHandle` cmdlets are included in Az PowerShell module version 2.4 or later. To install the latest Az PowerShell module, see [Install the Azure PowerShell module](/powershell/azure/install-azure-powershell).

#### Cause 2

A file lease prevents a file from being modified or deleted. You can check if a file has a file lease by using the following PowerShell commands. Replace `<resource-group>`, `<storage-account>`, `<file-share>`, and `<path-to-file>` with the appropriate values for your environment.

```powershell
# Set variables 
$resourceGroupName = "<resource-group>"
$storageAccountName = "<storage-account>"
$fileShareName = "<file-share>"
$fileForLease = "<path-to-file>"

# Get reference to storage account
$storageAccount = Get-AzStorageAccount `
        -ResourceGroupName $resourceGroupName `
        -Name $storageAccountName

# Get reference to file
$file = Get-AzStorageFile `
        -Context $storageAccount.Context `
        -ShareName $fileShareName `
        -Path $fileForLease

$fileClient = $file.ShareFileClient

# Check if the file has a file lease
$fileClient.GetProperties().Value
```

If a file has a lease, the returned object contains the following properties:

```output
LeaseDuration         : Infinite
LeaseState            : Leased
LeaseStatus           : Locked
```

#### Solution 2

To remove a lease from a file, release the lease or break the lease. To release the lease, you need the LeaseId of the lease, which you set when you create the lease. You don't need the LeaseId to break the lease.

The following example shows how to break the lease for the file indicated in cause 2 (this example continues with the PowerShell variables from cause 2):

```powershell
$leaseClient = [Azure.Storage.Files.Shares.Specialized.ShareLeaseClient]::new($fileClient)
$leaseClient.Break() | Out-Null
```

## [Linux](#tab/linux)

Linux clients can use [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Linux) to automate symptom detection and ensure that they have the correct prerequisites.

In Linux, you might see the following issues.

### Open handles on files or directories

#### Cause

This issue typically occurs if the file or directory has an open handle.

#### Solution

If the SMB clients close all open handles and the issue continues, perform the following steps:

- Use the [Get-AzStorageFileHandle](/powershell/module/az.storage/get-azstoragefilehandle) PowerShell cmdlet to view open handles.

- Use the [Close-AzStorageFileHandle](/powershell/module/az.storage/close-azstoragefilehandle) PowerShell cmdlet to close open handles.

> [!NOTE]  
> The `Get-AzStorageFileHandle` and `Close-AzStorageFileHandle` cmdlets are included in Az PowerShell module version 2.4 or later. To install the latest Az PowerShell module, see [Install the Azure PowerShell module](/powershell/azure/install-azure-powershell).

---

## Can't mount an Azure file share snapshot on Linux

### <a id="mounterror22"></a>"Mount error(22): Invalid argument" when trying to mount an Azure file share snapshot on Linux

#### Cause

If you don't pass the `snapshot` option for the `mount` command in a recognized format, the `mount` command fails with this error. To confirm it, check kernel log messages (`dmesg`). The `dmesg` output shows a log entry such as `cifs: Bad value for 'snapshot'`.

#### Solution

Make sure you're passing the `snapshot` option for the `mount` command in the correct format. Refer to the `mount.cifs` manual page (for example, `man mount.cifs`). A common error is passing the GMT timestamp in the wrong format, such as using hyphens or colons in place of periods. For more information, see [Mount a file share snapshot](/azure/storage/files/storage-how-to-use-files-linux#mount-a-file-share-snapshot).

### <a id="badsnapshottoken"></a>"Bad snapshot token" when trying to mount an Azure file share snapshot on Linux

#### Cause

If you pass the snapshot `mount` option starting with `@GMT`, but the format is still wrong (such as using hyphens and colons instead of periods), the `mount` command fails with this error.

#### Solution

Make sure you're passing the GMT timestamp in the correct format, which is `@GMT-year.month.day-hour.minutes.seconds`. For more information, see [Mount a file share snapshot](/azure/storage/files/storage-how-to-use-files-linux#mount-a-file-share-snapshot).

### <a id="mounterror2"></a>"Mount error(2): No such file or directory" when trying to mount an Azure file share snapshot

#### Cause

If the snapshot you want to mount doesn't exist, the `mount` command returns this error. To confirm it, check kernel log messages (`dmesg`). The `dmesg` output shows a log entry such as:

```output
[Mon Dec 12 10:34:09 2022] CIFS: Attempting to mount \\snapshottestlinux.file.core.windows.net\snapshot-test-share1
[Mon Dec 12 10:34:09 2022] CIFS: VFS: cifs_mount failed w/return code = -2
```

#### Solution

Make sure the snapshot you want to mount exists. For more information on how to list the available snapshots for a given Azure file share, see [Mount a file share snapshot](/azure/storage/files/storage-how-to-use-files-linux#mount-a-file-share-snapshot).

## Disk quota or network errors from too many open handles

Select the Windows or Linux tab depending on the client operating system you're using to access Azure file shares.

## [Windows](#tab/windows)

### <a id="error1816"></a>Error 1816 - Not enough quota is available to process this command

#### Cause

Error 1816 occurs when you reach the upper limit of concurrent open handles that are allowed for a file or directory on the Azure file share. For more information, see [Azure Files scale targets](/azure/storage/files/storage-files-scale-targets#azure-files-scale-targets).

#### Solution

Reduce the number of concurrent open handles by closing some handles, and then retry. For more information, see [Microsoft Azure Storage performance and scalability checklist](/azure/storage/blobs/storage-performance-checklist?toc=/azure/storage/files/toc.json).

To view open handles for a file share, directory, or file, use the [Get-AzStorageFileHandle](/powershell/module/az.storage/get-azstoragefilehandle) PowerShell cmdlet.  

To close open handles for a file share, directory, or file, use the [Close-AzStorageFileHandle](/powershell/module/az.storage/close-azstoragefilehandle) PowerShell cmdlet.

> [!NOTE]
> The `Get-AzStorageFileHandle` and `Close-AzStorageFileHandle` cmdlets are included in Az PowerShell module version 2.4 or later. To install the latest Az PowerShell module, see [Install the Azure PowerShell module](/powershell/azure/install-azure-powershell).

### <a id="networkerror59"></a>ERROR_UNEXP_NET_ERR (59) when doing any operations on a handle

#### Cause

If you cache or hold a large number of open handles for a long time, you might see this server-side failure due to throttling. When the client caches many handles, many of those handles enter a reconnect phase at the same time. This phase builds up a queue on the server that needs to be throttled. The retry logic and the throttling on the backend for reconnect take longer than the client's timeout. This situation manifests itself as a client not being able to use an existing handle for any operation, with all operations failing with ERROR_UNEXP_NET_ERR (59).

There are also edge cases in which the client handle becomes disconnected from the server (for example, a network outage lasting several minutes) that could cause this error.

#### Solution

Don't keep a large number of handles cached. Close handles, and then retry. Use `Get-AzStorageFileHandle` and `Close-AzStorageFileHandle` PowerShell cmdlets to view and close open handles.

If you're using Azure file shares to store profile containers or disk images for a large-scale virtual desktop deployment or other workloads that open handles on files, directories, and/or the root directory, you might reach the upper [scale limits](/azure/storage/files/storage-files-scale-targets) for concurrent open handles. In this case, use an additional Azure file share and distribute the containers or images between the shares.

## [Linux](#tab/linux)

Linux clients can use [AzFileDiagnostics](https://github.com/Azure-Samples/azure-files-samples/tree/master/AzFileDiagnostics/Linux) to automate symptom detection and ensure that they have the correct prerequisites.

### <a id="permissiondenied"></a>"[permission denied] Disk quota exceeded" error when you try to open a file

In Linux, you might receive an error message that resembles the following:

> \<filename> [permission denied] Disk quota exceeded

#### Cause

You reached the upper limit of concurrent open handles that are allowed for a file or directory.

Azure Files supports 10,000 open handles on the root directory and 2,000 open handles per file and directory within the share.

#### Solution

Reduce the number of concurrent open handles by closing some handles, and then retry the operation.

To view open handles for a file share, directory, or file, use the [Get-AzStorageFileHandle](/powershell/module/az.storage/get-azstoragefilehandle) PowerShell cmdlet.  

To close open handles for a file share, directory, or file, use the [Close-AzStorageFileHandle](/powershell/module/az.storage/close-azstoragefilehandle) PowerShell cmdlet.

> [!NOTE]  
> The `Get-AzStorageFileHandle` and `Close-AzStorageFileHandle` cmdlets are included in Az PowerShell module version 2.4 or later. To install the latest Az PowerShell module, see [Install the Azure PowerShell module](/powershell/azure/install-azure-powershell).

---

## <a id="doesnotsupportencryption"></a>Error "You are copying a file to a destination that does not support encryption"

When you copy a file over the network, the source computer decrypts the file, transmits it in plaintext, and re-encrypts it at the destination. However, you might see the following error when you're trying to copy an encrypted file: "You are copying the file to a destination that does not support encryption."

### Cause
This problem can occur if you're using Encrypting File System (EFS). You can copy BitLocker-encrypted files to Azure Files. However, Azure Files doesn't support NTFS EFS.

### Workaround
To copy a file over the network, you must first decrypt it. Use one of the following methods:

- Use the **copy /d** command. It allows the encrypted files to be saved as decrypted files at the destination.
- Set the following registry key:
  - Path = HKLM\Software\Policies\Microsoft\Windows\System
  - Value type = DWORD
  - Name = CopyFileAllowDecryptedRemoteDestination
  - Value = 1

Setting the registry key affects all copy operations that are made to network shares.

## Error ConditionHeadersNotSupported from a Web Application using Azure Files from Browser

The ConditionHeadersNotSupported error occurs when accessing content hosted in Azure Files through an application that makes use of conditional headers, such as a web browser, access fails. The error states that condition headers aren't supported.

:::image type="content" source="media/files-troubleshoot-smb-connectivity/conditionalerror.png" alt-text="Screenshot that shows the ConditionHeadersNotSupported error message.":::

### Cause

Conditional headers aren't yet supported. Applications implementing them need to request the full file every time the file is accessed.

### Workaround

When you upload a new file, the **CacheControl** property defaults to **no-cache**. To make the application request the file every time, update the file's **CacheControl** property from **no-cache** to **no-cache, no-store, must-revalidate**. You can make this change by using Azure Storage Explorer.

:::image type="content" source="media/files-troubleshoot-smb-connectivity/storage-explorer-cache.png" alt-text="Screeshot that shows the CacheControl file property." lightbox="media/files-troubleshoot-smb-connectivity/storage-explorer-cache.png":::

## See also

- [Troubleshoot Azure Files](files-troubleshoot.md)
- [Troubleshoot Azure Files performance](../performance/files-troubleshoot-performance.md)
- [Troubleshoot Azure Files authentication and authorization (SMB)](../security/files-troubleshoot-smb-authentication.md)
- [Troubleshoot Azure Files general SMB issues on Linux](../security/files-troubleshoot-linux-smb.md)
- [Troubleshoot Azure Files general NFS issues on Linux](../security/files-troubleshoot-linux-nfs.md)
- [Troubleshoot Azure File Sync issues](../file-sync/file-sync-troubleshoot.md)

 
