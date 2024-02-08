---
title: Troubleshoot live migration issues
description: Provides information on solving the problem of live migration in windows server 2016.
ms.date: 08/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: adjudele, cpuckett, kaushika
ms.custom: sap:live-migration, csstroubleshoot
ms.subservice: hyper-v
---
# Troubleshoot live migration issues

This article provides information on solving the issues when live migrating virtual machines.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 4558514

## Basic troubleshooting checklist

- Check the hosts are at the same level of patching and whether they can update to the latest rollup.
- Update the BIOS, firmware and third party drivers.
- Check whether the virtual machines have the latest matching integration services.
- Check whether the migration is authorized on each side.
- Check whether the protocol used is identical on each side.
- Check whether the TCP Port 6600 and 3343 (for clustering) are listening on both sides.
- Check compatibilities issues by running a `Compare-VM` command. Provide the name of the VM and the destination host. For example:

  ```powershell
  Compare-VM -Name <vm_name> -DestinationHost <host_name>
  ```

- Check whether any group policy object is preventing the migration from occurring. Verify that the following policy have at least the default settings.
  - Open *GPEDIT.MSC* and navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**.  
    Open **Create symbolic links** and check whether the following user accounts are listed:  
    - Administrators  
    - NT VIRTUAL MACHINE\Virtual Machines  
    - Log on as a service  
    - NT SERVICE\ALL SERVICES  
    - NT VIRTUAL MACHINE\Virtual Machines

- Check for the antivirus exclusions. For more information, see [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md).
- Check the corruption of the *Registry.pol* file:  
  Run notepad and open *C:\\Windows\\System32\\GroupPolicy\\Machine\\Registry.pol*. The file must start with the **PReg** signature.
- Compare permissions on the folders containing the virtual machines files with a working host with the same operating system level.

Next, find the event IDs that you encounter during live migration issue from the following sections.

## Event ID 21502

### Information regarding Event ID 21502

#### Live migration failed because a virtual switch used by the VM doesn't exist on the destination node "Host2"

**Description**

Live migration of VM failed. VM failed to live migrate because a virtual switch used by the VM doesn't exist on the destination node "Host2".

**Action**

The virtual switch must have the same name on all nodes.  

If a virtual machine is connected to a virtual switch that doesn't exist on the destination node, then live migration fails at < 10%.

Give the virtual networks identical names. Refresh the virtual machine configuration so that network changes are reflected in cluster, and then try the live migration again.  

**Resolution**

Open the **Hyper-V Manager** console and select **Virtual Switch Manager**. If the virtual switch doesn't exist, create or rename it with the same name and settings such as in other hosts.

Make sure to select the correct virtual switch under the VM's settings.  

#### Live migration failed because the action "Move" didn't complete. Error Code: 0x80071398

**Description**

Live migration of VM failed.

**Action**

Right-click **virtual machine** > **Information details** > **Show details**. You see the following information:

The action "Move" didn't complete.

Error Code: 0x80071398

The operation failed because either the specified cluster node isn't the owner of the group, or the node isn't a possible owner of the group.

:::image type="content" source="media/troubleshoot-live-migration-issues/error-code-0x80071398.png" alt-text="Screenshot of The action Move did not complete error.":::

0x1398 5016 ERROR_HOST_NODE_NOT_GROUP_OWNER

 The operation failed because either the specified cluster node isn't the owner of the group, or the node isn't a possible owner of the group.  

**Resolution**

Open **Windows PowerShell** with **Run as administrator**, and run the following cmdlets:

- Get-clusterResource -name "Virtual Machine VM1" | Get-clusterOwnerNode
- Get-clusterResource -name "Virtual Machine Configuration VM1" | Get-clusterOwnerNode

The owner node must have all cluster nodes.

Alternatively, open the Failover Cluster Manager (FCM) under roles, select the virtual machine like shown in the following screenshot. On the bottom tab, select **Resource**, right-click **Virtual MachineVM1**, select the **Advanced Policies** tab. Check that all nodes are selected. Do the same for "**Virtual Machine Configuration VM1**. Make sure the VM has the same virtual switch on all nodes.

#### Failed to get the network address for the destination node "Host2": A cluster Network isn't available for this operation. (0x000013AB)  

**Description**

Live migration of "VM" failed.

Failed to get the network address for the destination node "Host2": A cluster Network isn't available for this operation. (0x000013AB).

**Action**

0x13ab 5035 ERROR_NETWORK_NOT_AVAILABLE

A cluster network isn't available for this operation. winerror.h

**Resolution**

Open **Windows PowerShell** with **Run as administrator**  and run the following cmdlet:  

```powershell
Get-ClusterNetwork
```  

:::image type="content" source="media/troubleshoot-live-migration-issues/get-clusternetwork.png" alt-text="Screenshot of the Get-ClusterNetwork command result." border="false":::

Make sure the cluster network isn't configured and that **Allow cluster network communication on this network** is selected. For more information, see [Configuring Network Prioritization on a Failover Cluster](https://techcommunity.microsoft.com/t5/failover-clustering/configuring-network-prioritization-on-a-failover-cluster/ba-p/371683).  

**Workaround**

Currently, live migration cross site does not work in Azure Stack HCI 22H2 and later versions. To work around this issue, use one of the following solutions:

- Use quick migration to perform cross site migration.  
- Set the live migration preferred network to a stretched VLAN (single subnet) that includes all the nodes of the cluster.

#### Live migration failed with error code (0x8007271D)  

**Description**

Live migration fails With (0x8007271D).

 **Action**

As Win32 error code "0x271d"

0x271d 10013 WSAEACCES

 An attempt was made to access a socket in a way forbidden by its access permissions.  

 **Resolution**

 Here's how to fix this issue:  

1. Check Firewall settings and Antivirus exclusion.
2. Check if TCP ports 6600 and 3343 (for clustering) are listening on both sides by running the following cmdlet:

    ```console
    C:\>netstat -ano | findstr /I /C:"6600"
    ```

#### Failed to create partition: Insufficient system resources exist to complete the requested service. (0x800705AA)  

**Description**

Live migration fails before 10%, quick migration fails during virtual machine online.

 **Action**

Insufficient RAM in destination node

 On the destination node, Hyper-V-Worker event: Failed to create partition: Insufficient system resources exist to complete the requested service. (0x800705AA)  

 **Resolution**

Reduce the memory assigned to the virtual machine or turn off some virtual machines on the destination node.  

#### Failed to restore with Error **"** A virtual disk support provider for the specified file was not found." (0xC03A0014)

**Description**

Live migration of "VM" failed.

Virtual machine migration operation for "VM" failed at migration destination "HYP1."

"VM" Synthetic SCSI Controller: Failed to restore with Error "A virtual disk support provider for the specified file was not found." (0xC03A0014).

 "VM": Attachment "C:\ClusterStorage\library\SW_DVD9_NTRL_SQL_Svr_Standard_Edtn_2019Dec2019_64Bit_English_OEM_VL_X22-22109.ISO" failed to open because of error: "A virtual disk support provider for the specified file was not found." (0xC03A0014).  

**Action**

Need to remove the ISO.

0xc03a0014 -1069940716 ERROR_VIRTDISK_PROVIDER_NOT_FOUND

 A virtual disk support provider for the specified file wasn't found.  

**Resolution**

Check the VM setting under the DVD file, make sure the **None** option is selected as shown:

:::image type="content" source="media/troubleshoot-live-migration-issues/select-none.png" alt-text="Screenshot shows the None option is selected in the Media area.":::

#### Live migration failed because "Test" failed at migration source "HOST3."

**Description**

Live migration of "VM" failed.

‎Virtual machine migration operation for "Test" failed at migration source "HOST3."

The Virtual Machine Management Service failed to establish a connection for a Virtual Machine migration with host "host2": No connection could be made because the target machine actively refused it. (0x8007274D)

Failed to send data for a Virtual Machine migration: An existing connection was forcibly closed by the remote host. (0x80072746)

 Failed to establish a connection with host "S1": A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond. (0x8007274C)  

**Action**

0x274d 10061 WSAECONNREFUSED

No connection could be made because the target machine actively refused it

0x2746 10054 WSAECONNRESET

An existing connection was forcibly closed by the remote host.  

**Resolution**

Check if the TCP ports 6600 and 3343 (for clustering) are listening on both sides by running the following cmdlet:

```console
netstat -ano | findstr /I /C:"6600"
```

Check the cluster network metrics by running the following cmdlet:

```powershell
Get-ClusterNetwork
```

For more information, see the following websites:

- [Network Recommendations for a Hyper-V Cluster in Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn550728%28v=ws.11%29)  
- [Simplified SMB Multichannel and Multi-NIC Cluster Networks](/windows-server/failover-clustering/smb-multichannel)  
- [A live migration of a virtual machine by using Virtual Machine Manager fails with error 0x8007274D](https://support.microsoft.com/help/2853203)  

#### Live migration failed because the hardware on the destination computer isn't compatible with the hardware requirements of this virtual machine

**Description**

The virtual machine cannot be moved to the destination computer. The hardware on the destination computer isn't compatible with the hardware requirements of this virtual machine.

**Action**

Check the compatibility setup.

**Resolution**

Here's how to fix this issue:

1. Open the **Hyper-V Manager** console and select **Virtual Machine** > **Settings** > **Processor** > **Compatibility > OK.**

    :::image type="content" source="media/troubleshoot-live-migration-issues/hyper-v-manager-console.png" alt-text="Screenshot shows the options in the Hyper-V Manager console.":::

2. Open **Windows PowerShell** with **Run as administrator** and run the following cmdlet:

    ```powershell
     PS C:\> Set-VMProcessor TestVM -CompatibilityForMigrationEnabled $true  
    ```

#### Failed live migrate because "Virtual Machine Name" is using processor-specific features not supported on host "Node 1."

**Description**

Virtual machine "Virtual Machine Name" is using processor-specific features not supported on host "Node 1."

**Action**

To allow for migration of this virtual machine to a server with a different processor, modify the virtual machine settings to limit the processor features used by the virtual machine.

 **Resolution**

Here's how to fix this issue:

1. Check if the processor compatibility is flagged. Open the **Hyper-V Manager** console, select **Virtual Machine Settings** > **Processor** > **Processor Compatibility**.
2. Make sure the BIOS of the host has the same settings.
3. Make sure the **Spectre** or **Meltdown** patch exposes different features of the CPU. For more information, see [Protecting guest virtual machines from CVE-2017-5715 (branch target injection)](/virtualization/hyper-v-on-windows/CVE-2017-5715-and-hyper-v-vms).
4. Run the [Get-SpeculationControlSettings](https://support.microsoft.com/help/4074629) cmdlet and check the results. It should be the same on all nodes.  

#### Live migration failed because "Virtual Machine Name" failed at migration source "Source Host Name"

**Description**

Virtual machine migration operation for "Virtual Machine Name" failed at migration source "Source Host Name"

**Action**

The Virtual Machine Management Service disabled the listener for Virtual Machine migration connections.

**Resolution**

Open a **Command Prompt** with **Run as administrator** and run the following cmdlet:

```console
gpupdate /force
```

If the computer policy couldn't be updated successfully, you receive this error message:

The processing of Group Policy failed. Windows couldn't apply the registry-based policy settings for the Group Policy object LocalGPO. Group Policy settings won't be resolved until this event is resolved. View the event details for more information on the file name and path that caused the failure.

In this case, restore a backup or copy the **GroupPolicy** folder in the path **C:\Windows\System32\\** to the problematic server from a working server.  

#### Live migration failed because "vm1" couldn't initialize memory: Ran out of memory (0x8007000E)

**Description**

Live migration of "Virtual Machine vm1" failed.

Virtual machine migration operation for "vm1" failed at migration destination "S2D1".

 "vm1" could not initialize memory: Ran out of memory (0x8007000E).  

**Action**

Performance issue.

**Resolution**

Check the available memory on the destination host.  

#### Failed to establish a connection with host computer name: No credentials are available in the security package 0x8009030E

**Description**

Virtual machine migration operation failed at migration Source. Failed to establish a connection with host computer name: No credentials are available in the security package 0x8009030E.

**Action**

0x8009030e -2146893042 SEC_E_NO_CREDENTIALS

 No credentials are available in the security package.  

**Resolution**

Here's how to fix this issue:

 :::image type="content" source="media/troubleshoot-live-migration-issues/hyper-v-settings-s2d2.png" alt-text="Screenshot shows steps to fix this issue.":::

See [Live Migration via Constrained Delegation with Kerberos in Windows Server 2016](https://techcommunity.microsoft.com/t5/virtualization/live-migration-via-constrained-delegation-with-kerberos-in/ba-p/382334) for details.  

#### Failed to establish a connection with host "DESTINATION-SERVER": The credentials supplied to the package were not recognized (0x8009030D)

**Description**

Virtual machine migration Operation failed at migration source.

Failed to establish a connection with host "DESTINATION-SERVER": The credentials supplied to the package were not recognized (0x8009030D).

 The Virtual Machine Management Service failed to authenticate the connection for a virtual machine migration at the source host: no suitable credentials available. Make sure the operation is initiated on the source host of the migration, or the source host is configured to use Kerberos for the authentication of migration connections and constrained delegation is enabled for the host in active directory.  

**Action**

0x8009030d -2146893043 SEC_E_UNKNOWN_CREDENTIALS The credentials supplied to the package were not recognized.

**Resolution**

Here's how to fix this issue:

1. Enable Kerberos Authentication for live migrations on both Hyper-V hosts. To do so, select **Hyper-V Settings**  > **Live Migrations** > **Advanced Features** > **Use Kerberos under Authentication Protocol**.
2. Set Constrained Delegation for both Hyper-V hosts by following these steps:
      1. Open **Active Directory Users and Computers**, find the Hyper-V host computer account. Open the **Properties** dialog, and select the **Delegation** tab.
      2. Select the **Trust this computer for delegation to specified services only** and **Use any authentication protocol** options.
      3. Select **Add**, and select the computer account of another Hyper-V host.
      4. Add **cifs** (required to migrate storage) and **Microsoft Virtual System Migration Service** (required to migrate virtual machine).

Wait up to 15 minutes for Keberos tickets to time out. Or run the **KLIST PURGE -li 0x3e7** cmdlet.  

#### Failed to create Planned Virtual Machine at migration destination: Logon failure

**Description**

Live migration of "Virtual Machine VM name" failed.

Failed to create Planned Virtual Machine at migration destination: Logon failure: the user has not been granted the requested logon type at this computer. (0x80070569)

Virtual machines running on Windows Server 2012 Hyper-V hosts may fail to start. And you may receive an error message that's similar to the following example:

> Error 0x80070569 ("VM_NAME" failed to start worker process: Logon Failure: The user has not been granted the requested logon type at this computer.)  

**Action**

0x569 1385 ERROR_LOGON_TYPE_NOT_GRANTED

Logon failure: the user has not been granted the requested logon type at this computer

Besides, when you perform a recovery checkpoint and try to convert it to a reference point by using the ConvertToReferencePoint method, the conversion may fail. You may receive an error message that's similar to the following example:

> Failed to write VHD attachment "VHDX_NAME" to "VM_NAME": Account restrictions are preventing this user from signing in. For example, blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced. (0x8007052f)

0x52f 1327 ERROR_ACCOUNT_RESTRICTION Account restrictions are preventing this user from signing in. For example: blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced.

**Resolution**
  
For more information, see [Starting or Live Migrating Hyper-V virtual machines may fail with error 0x80070569 on Windows Server 2012-based computers](https://support.microsoft.com/help/2779204).  

#### Failed to establish a connection for a Virtual Machine migration with host "HOST3": A connection attempt failed

**Description**

The Virtual Machine Management Service failed to establish a connection for a Virtual Machine migration with host "HOST3": A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond. (0x8007274C).

**Action**

0x274c 10060 WSAETIMEDOUT

 A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.  

**Resolution**

Here's how to fix this issue:

1. Check for various corruptions of the **Registry.pol** under the **C:\Windows\System32\GroupPolicy\Machine** path.
2. Open the file in Notepad. It must start with the **`PReg`** signature.  

#### Fail to live migrate because the target principal name is incorrect. (0x80090322)  

**Description** 

The Virtual Machine Management Service failed to establish a connection for a Virtual Machine migration with host "HOST5": The target principal name is incorrect. (0x80090322).

**Action**

Migration was cross-cluster but as per Live Migration Network order, the private Network was selected.

0x80090322 -2146893022 SEC_E_WRONG_PRINCIPAL

 The target principal name is incorrect.  

**Resolution**

Change the Live Migration Network order for cross-cluster and change it back after the migration.  

#### Fail to live migrate because virtual machine migration operation for "VM01" failed at migration source "Node3"

**Description**

Live migration of "SCVMM VM01" failed

Virtual machine migration operation for "VM01" failed at migration source "Node3".

 The Virtual Machine Management Service initiated the live migration of virtual machine "VM01" to destination host "Node11."

**Action**

NetApp storage

Failed to get last write time of file "<\\\NetApp12\vol03\V01\Virtual Machines\D...17.VMRS>" with error 59! Returning cached write time.  

Failed to read configuration data in binary format from stream.  

HRESULT = 0x80048054  

 0x3b 59 ERROR_UNEXP_NET_ERR An unexpected network error occurred.  

**Resolution**

Enable or disable `oplocks` and lease `oplocks` on a `qtree`. If `oplocks` and lease `oplocks` are enabled at the storage system level, enable or disable `oplocks` and lease `oplocks` on an individual `qtree` by running the respective cmdlets:

- `qtree oplocks qtree_name enable`  
- `qtree oplocks qtree_name disable`

If the **cifs.oplocks.enable** option is set to **On**, the `qtree oplocks` cmdlet for a `qtree` takes effect immediately. If the **cifs.oplocks.enable** option is set to **Off**, the `qtree oplocks` command doesn't take effect until you change the option to **On**.

Here's how to fix this issue:

1. Replace the **NetApp** filer with a Windows 2016 based File server. Alternatively, update the **NetApp** file to the latest `Ontap` 9.*. version.
2. Make sure that the Windows Server 2016 based Hyper-V nodes are updated with the latest cumulative update. Similar issues are resolved after you applying [CU Feb 2019](https://support.microsoft.com/help/4487044/) or a later version.  

#### Failed live migration of 'Virtual Machine VM1' at migration source 'CLU8N1' with error codes 80042001 and 8007000D

**Description**

Live migration of 'Virtual Machine VM1' failed.

Virtual machine migration operation for 'VM1' failed at migration source 'CLU8N1'.  

 When running an SMB live migration between nodes in a Windows 2019 (RS5) Hyper-V cluster, a failure occurs on all VMs that point to a specific node:

Virtual machine migration operation for 'VM1' failed at migration source 'CLU8N1'.  

**Action**

Filter error codes 80042001 and 8007000D on the VM name to collect VML traces on the source.

Under RS5, live migration through SMB of all the VMs to a specific node fails on the source because the HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName: ComputerName isn't in UPPERCASE.  

**Resolution**

Make sure there's a REG_SZ value ComputerName with the name of the computer in UPPERCASE.

## Event ID 20413

**Description**

Live migration fails at 90%~100%, and quick migration fails during virtual machine configuration online.

**Action**

Nodes in cluster have different system drive letters assigned.

**Resolution**

On the destination node, the Hyper-V VMMS event displays the following error message:

The Virtual Machine Management Service failed to register the configuration for the virtual machine "\<vmID>" at "\<localpath>": The system cannot find the path.

 Set all nodes to use the same system driver letter on the cluster.  

## Event ID 20417

**Description**

The Virtual Machine Management service successfully completed the live migration of virtual machine "VM" with an unexpectedly long blackout time of 63.1 seconds.

**Action**

The message comes from a lower performance network when you try the live migration.

**Resolution**

Make sure there's enough bandwidth available for the live migration.  

Try to reduce the memory during the live migration. For more information, see [Virtual Machine Live Migration Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831435%28v=ws.11%29?redirectedfrom=MSDN).  

## Event ID 21024

**Description**

Both live migration and quick migration succeeds, but virtual machine loses network connectivity after migration.

**Action**

Virtual machine loses network connectivity after migration even though network settings are configured correctly.

**Resolution**

Make sure the virtual machine network settings are correct.

 Check if the source and destination virtual network are in the same subnet. If the aren't, run the **ipconfig /renew** cmdlet to resume the network connectivity. Alternatively, assign a new IP address to the virtual machine if a static IP address is used.  

## Event ID 21125

**Description**

Configuration setup for live migration failed on the destination node.

**Action**

Make sure that name of the virtual network is the same on the source and destination nodes and try the live migration again.

**Resolution**

Here's how to resolve this issue:  

1. Open the **Hyper-V Manager** console on the source and destination nodes.
2. Select **Virtual Network Manager**.
3. Verify if the virtual network names matched between source and destination nodes. Virtual switches must have the same name.
4. Click **OK** to close the **Virtual Network Manager** window.
5. Right-click the virtual machine on the source node and select **Settings**.
6. Verify if the virtual machine is configured to use the correct virtual network.
7. Click **OK** to close the **Virtual Machine Settings** window.
8. Close the **Hyper-V Manager** console on the source and destination nodes.
9. Open the **Failover Cluster Manager** console on the source node.
10. Expand roles and then select the virtual machine.
11. On the **Actions** pane, click **More Actions** > **Refresh virtual machine configuration**.
12. Perform a live migration of the virtual machine on the destination node.

## Event ID 21501

**Description**

Live migration of "VM" failed.

Virtual machine migration operation for "VM" failed at migration source "Host5."

> Failed to perform migration on virtual machine "VM" because virtual machine migration limit "2" was reached, please wait for completion of an ongoing migration operation.  

**Action**

Wait to finish other live migrations or increase the number of simultaneous live migrations.

**Resolution**

To fix this issue, open the **Hyper-V Manager** console, click **Hyper-V Settings** > **Live Migrations** **>** **Simultaneous live migrations**.
> [!NOTE]
> Consider host performance when changing this number.  

## Data collection

Here's how to collect information before contacting Microsoft Support:

1. Download [TSS Windows CMD based universal Troubleshooting Script tool set](https://github.com/CSS-Windows/WindowsDiag/tree/master/ALL/TSS) on all nodes and unzip it in the **C:\tss_tool** folder.  
2. Open **Command Prompt** with **Run as administrator** and move it to the **C:\tss_tool** folder.
3. Start the trace by running the cmdlet on the source and destination nodes.

    ```console
    TSS rOn VML:verbose
    ```

4. Perform the repro steps for the issue and follow instructions to stop the traces after that repro steps are completed.

    > [!NOTE]
    > Collect the trace on both nodes.

5. Download the [psSDP](https://github.com/CSS-Windows/WindowsDiag/tree/master/ALL/psSDP) tool to collect the logs from the source and destination nodes.
6. Unzip the file and run the following cmdlet on both nodes:

    ```console
    .\GetpsSDP.ps1 HyperV -localNodeOnly
    ```

7. Collect all logs. zip and upload the collection on the workspace.
