---
title: Error 0x8007232B "DNS name does not exist" when activating Windows
description: 
ms.date: 05/21/2026
ms.collection: windows
ai.usage: ai-assisted
ms.reviewer: cwhitley, scotro, v-leedennis, kaushika, v-appelgatet
ms.custom: 
  - sap:Windows Activation\Windows activation issues
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0x8007232B "DNS name does not exist" when activating Windows

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
**Error: 0x8007232B** DNS name does not exist.
```

## Cause

This error message appears when the Key Management Services (KMS) client can't find the server resource records (SRV RRs) for the KMS host in DNS.

By default, the KMS clients locate KMS hosts automatically by querying DNS for a list of servers that have published `_vlmcs` SRV records within the membership zone of the client. DNS returns the list of KMS hosts in a random order. The client picks a KMS host and tries to establish a session on it. If this attempt works, the client caches the name of the KMS host and tries to use it for the next renewal attempt. If the attempt fails, the client randomly picks another KMS host. We highly recommend that you use the automatic discovery process.

The most common causes of this issue include the following scenarios:

- Firewall rules or Network Security Group (NSG) rules block DNS resolution.
- The `slmgr.vbs /skms` was used to configure the client to use an incorrect name for the KMS host, or a KMS host that's not valid.
- The KMS host didn't publish KMS SRV records to the DNS server that the client uses, and the DNS server doesn't have a forwarding or recursion path to a DNS server that has the records.

## Resolution

To get the best results from these procedures, install the [PsPing](/sysinternals/downloads/psping) tool on the affected computer. If you have a self-hosted KMS server, install the PSPing tool on that computer as well.

You should also be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Make sure that a KMS host is available, or use the Azure KMS service

To use KMS activation, you have to have a KMS host in your environment for the clients to activate against. If your clients are Azure virtual machines, you can use the Azure KMS service. If you don't have a self-hosted KMS host and you can't use Azure KMS, use one of the following methods:

- Method 1: [Configure a self-hosted KMS server](#method-1-configure-a-self-hosted-kms-server)
- Method 2: [Use an MAK product key instead of KMS](#method-2-use-an-mak-product-key-instead-of-kms)

#### Method 1: Configure a self-hosted KMS server

If there are no KMS hosts configured in your environment, and you can't use the Azure KMS service, install one. Then use an appropriate KMS host key to activate it. After you configure a computer on the network to host the KMS software, publish the Domain Name System (DNS) settings.

For information about the KMS host configuration process, see [Activate using Key Management Service](/windows/deployment/volume-activation/activate-using-key-management-service-vamt) and [Install and Configure VAMT](/windows/deployment/volume-activation/install-configure-vamt).

After you configure a KMS host, try to activate again. If activation fails and generates the same error as before, continue to [Step 2](#step-2-check-the-client-kms-key).

#### Method 2: Use an MAK product key instead of KMS

If you can't install a KMS host or, for some other reason, you can't use KMS activation, use an MAK product key. If you downloaded Windows images from Microsoft, the stock-keeping units (SKUs) that are associated with the images are generally volume licensed-media, and the product key that's provided for these images is an MAK key.

To use an MAK product key, open an administrative Command Prompt window, and then run the following command:

```cmd
   slmgr -/ipk <xxxxx-xxxxx-xxxxx-xxxxx-xxxxx>
```

> [!NOTE]  
> In this command, \<xxxxx-xxxxx-xxxxx-xxxxx-xxxxx> represents your MAK product key.

To try again to activate, run the following command:

```cmd
cscript c:\windows\system32\slmgr.vbs /ato
```

If activation fails and generates the same error as before, continue to [Step 2](#step-2-check-the-client-kms-key).

### Step 2: Check the client KMS key

1. To verify that the client has the correct [KMS client setup key](/windows-server/get-started/kms-client-activation-keys), run the following command at the command prompt:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

1. If the product key is incorrect, run the following command to install the correct KMS client setup key:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

1. After the script finishes, restart the client.

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If activation fails and generates the same error as before, continue to Step 3.

### Step 3: Activate by using a particular KMS host

To bypass the automatic discovery process, you can use the slmgr script to specify a KMS host.

1. Open an administrative Command Prompt window on the client.

1. To clear any existing KMS host setting, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   ```

1. To specify a KMS host for activation, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms <KMSHost_fqdn>:<KMSHost_Port>
   ```

   > [!NOTE]  
   >
   > - In this command, \<KMSHost_fqdn> represents the fully qualified domain name (FQDN) of the KMS host, and \<KMSHost_Port> represents the port that the KMS host uses.
   > - To activate a virtual machine by using the Azure KMS service, use `azkms.core.windows.net` for \<KMSHost_fqdn> and use `1688` for \<KMSHost_Port.

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If activation fails and generates the same error as before, continue to Step 4.

### Step 4: Make sure that activation traffic can pass between the client and the KMS host

1. Run the following command at the command prompt on the client:

   ```cmd
   psping <KMSHost-ip>:1688
   ```

   > [!NOTE]  

   > - In this command, \<KMSHost_ip> represents the IP address of the KMS host.
   > - If the client is a virtual machine and you're using the Azure KMS service for activation, use `20.118.99.224` or `40.83.235.53` for \<KMSHost-ip>.

1. If you're using a self-hosted KMS host, open an administrative Command Prompt window on the KMS host, and then run the following command:

   ```cmd
   psping <KMSClient-ip>:1688
   ```

   > [!NOTE]  
   > In this command, \<KMSClient_ip> represents the IP address of the client.

1. If `psping` fails in either case, follow these steps:

   1. For a VM, check any network security groups (NSGs) that might affect the VM (such as NSGs that are set at the network interface, subnet, or virtual network level). Make sure that any NSG allows traffic between the VM and the DNS server on UDP/TCP port 53.

   1. Make sure that any firewall (including Windows Firewall on the client) allows traffic between the client and the KMS server on UDP/TCP port 1688.

   1. To verify that traffic is unblocked, run `psping` again.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If activation fails and generates the same error as before, continue to Step 5.

### Step 5: Check the DNS configuration

1. To check the DNS configuration, run the following command at the command prompt on the client:

   ```cmd
   nslookup <KMSHost_fqdn> <intendedDNS_name>
   ```

   > [!NOTE]  
   >
   > - In this command, \<KMSHost_fqdn> represents the FQDN of the KMS host, and \<intendedDNS_name> represents the FQDN or IP address of the DNS server that the client should use to contact the host.
   > - If the client is a VM that uses the Azure DNS service, use `168-63-129-16` for \<intendedDNS_name>.

1. If the client is a VM and you're using the Azure KMS service, and the `nslookup` command failed, see the following articles to troubleshoot your DNS configuration:
   - [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)
   - [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

1. If you're using a self-hosted KMS host, take one of the following actions:

   - If the DNS server didn't resolve the FQDN to an IP address, go to [Step 6](#step-6-self-hosted-kms-host-only-check-that-the-kms-host-can-connect-to-the-dns-infrastructure).
   - If the DNS server resolved the FQDN to an IP address, go to [Step 7](#step-7-self-hosted-kms-host-only-verify-that-the-kms-host-is-configured-to-register-dns-records).

### Step 6 (Self-hosted KMS host only): Check that the KMS host can connect to the DNS infrastructure

1. On the KMS host, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /all
   ```

   The output of this command should resemble the following examples:

   ```output
   DNS Servers . . . . . . . . . . . : 168.63.129.16
   ```

   ```output
   DNS Servers . . . . . . . . . . . : 10.0.3.5
                                       10.0.3.4
   ```

   > [!NOTE]  
   > In this example, `168.63.129.16` is the IP address that VMs use when they connect to the Azure DNS infrastructure. The other IP addresses represent custom DNS servers.

1. Verify that each of the DNS server addresses is correct.

   > [!IMPORTANT]  
   > When you use custom DNS servers for VMs, don't configure the DNS server settings on the VM itself. Specify DNS servers at the level of the network interface or the virtual network.

1. If the list is empty or doesn't include the correct DNS server addresses, see the following articles for more information:

   - VMs: [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
   - [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
   - [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)

1. If you change any of the DNS settings, restart the KMS host.

1. After the KMS host restarts, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /flushdns
   ```

   This command flushes and rebuilds the DNS cache.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If the activation fails and generates the same error as previously, continue to Step 7.

### Step 7 (Self-hosted KMS host only): Verify that the KMS host is configured to register DNS records

To determine whether the KMS host is registering with DNS, check the registry of the KMS host computer. By default, a KMS host computer dynamically registers a DNS SRV record one time every 24 hours.

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

To check this setting, follow these steps:

1. Start Registry Editor. To do this, right-click **Start** > **Run**, type **regedit**, and then press Enter.
1. Locate the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform` subkey, and check the value of the `DisableDnsPublishing` entry. This entry has the following possible values:

   - `0` or undefined (default): The KMS host registers an SRV record once every 24 hours.
   - `1`: The KMS host doesn't automatically register SRV records. If your implementation doesn't support dynamic updates, see [Manually create a KMS SRV record](/windows-server/get-started/common-troubleshooting-procedures-kms-dns#manually-create-a-kms-srv-record).

   > [!NOTE]  
   > Windows Server 2008 and Windows Vista used `SL` in the subkey instead of `SoftwareProtectionPlatform`.

1. If the `DisableDnsPublishing` entry is missing, create it (the type is DWORD). If your infrastructure uses dynamic DNS registration, leave the value undefined or set it to `0`.

1. If you want your KMS host to support clients in multiple domains, see [Configure the KMS host to publish in multiple DNS domains](/windows-server/get-started/common-troubleshooting-procedures-kms-dns#configure-the-kms-host-to-publish-in-multiple-dns-domains).

1. If you made any changes to the KMS host configuration, restart the KMS host.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If the activation still fails, contact Microsoft Support.

## References

- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)
- [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
- [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16)
