---
title: Delete a Storage Spaces Direct Storage Pool and Reset the Physical Disks
description: Explains how to gracefully delete an S2D storage pool so that you can reuse the disks elsewhere.
ms.date: 01/07/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, kanchan.sharadhi, sbathija, v-appelgatet
ms.custom:
- sap:backup, recovery, disk, and storage\Storage Spaces Direct (S2D)
- pcy:WinComm Storage High Avail
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Delete a Storage Spaces Direct storage pool and reset the physical disks

## Summary

This article describes how to safely remove a Storage Spaces Direct (S2D) storage pool and prepare the physical disks for reuse. Follow these steps to avoid rendering the disks or storage pool unusable.

When you remove disks from a storage pool incorrectly, both the disks and the storage pool can enter an unusable state. This article provides a step-by-step procedure to gracefully delete an S2D storage pool and clean the disks so that you can reuse them in a different configuration. For more information about these issues and related events, see [More information](#more-information).

> [!CAUTION]  
> Make sure that you back up any data that's in the storage pool. The steps in this article delete all data from the disks.

The steps in this article don't affect the  current Windows Server Failover Cluster (WSFC) configuration. These steps modify only the S2D configuration.

## Introduction to the example

This example uses the following steps to completely remove the S2D configuration and prepare the disks for reuse:

1. [Review the current S2D configuration](#step-1-review-the-current-s2d-configuration).
1. [Remove the virtual disks from the storage pool](#step-2-remove-the-virtual-disks-from-the-storage-pool).
1. [Remove the storage pool](#step-3-remove-the-storage-pool).
1. [Disable S2D](#step-4-disable-s2d).
1. [Verify that everything is removed](#step-5-verify-that-everything-is-removed).
1. [Clean up the physical disks](#step-6-clean-up-the-physical-disks).

The example in this section uses the following configuration:

- **S2D on S2DclusterNew**: S2D storage pool. It includes two virtual disks that host volumes (ClusterPerformanceHistory and userdata01)
- Cluster configuration:
  - **S2D-1.contoso.com**: Cluster node that has three attached disks (1002, 1003, and 1004)
  - **S2D-2.contoso.com**: Cluster node that has three attached disks (2002, 2003, and 2004)
- **Disk 0**: Operating system disk
- **Disk 1**: Temporary disk

> [!IMPORTANT]  
> This example was created and tested in an Azure test lab environment. Therefore, each of the disks in the earlier list appears in the command output examples as "Msft Virtual Disk" even though the example treats them as physical disks.

To use the procedures from this example, make sure that the following permissions are set:

- You have access to PowerShell in administrator mode. The following steps require you to run Windows PowerShell commands in an administrative PowerShell Command Prompt window.
- You have the necessary permissions to run the commands on the target system.

## Step 1: Review the current S2D configuration

1. To see the properties of the S2D storage pool, open an administrative PowerShell Command Prompt window. Then, run the following command:

   ```powershell
   C:\Users\SQLVMADMIN> Get-StoragePool
   ```

   The output of this command resembles the following example:

   ```output
   FriendlyName         OperationalStatus HealthStatus IsPrimordial IsReadOnly      Size AllocatedSize
   -------------------- ----------------- ------------ ------------ ---------- --------- -------------
   Primordial           OK                Healthy      True         False         564 GB     380.99 GB
   Primordial           OK                Healthy      True         False         564 GB     380.99 GB
   S2D on S2DclusterNew OK                Healthy      False        False      377.99 GB       44.5 GB
   ```

1. To see the properties of the physical disks, run the following command at the PowerShell command prompt:

   ```powershell
   C:\Users\SQLVMADMIN> Get-PhysicalDisk
   ```

   > [!NOTE]  
   >
   > - If you don't specify a node when you run `Get-PhysicalDisk` on any node within an S2D cluster, the output includes all physical disks across all nodes in the cluster. This behavior is by design. Each node maintains awareness of the entire pool's disk inventory--not only the disks that are physically attached to it.
   > - In the command output, the **CanPool** property of the 64-GB disks (1002-1004 and 2002-2004) is **False**. This value means that the disks already belong to a storage pool.

   ```output
   Number FriendlyName      SerialNumber MediaType   CanPool OperationalStatus HealthStatus Usage         Size
   ------ ----------------- ------------ ----------- ------- ----------------- ------------ ----------- ------
   0      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 127 GB
   1      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select  32 GB
   2003   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   2002   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   1004   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   1003   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   1002   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   2004   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   ```

1. To identify the physical disks that are directly attached to each node, run the following commands:

   ```powershell
   PS C:\Users\SQLVMADMIN> Get-StorageNode -name "S2D-1.contoso.com" | Get-PhysicalDisk -PhysicallyConnected
   ```

   ```output
   Number FriendlyName      SerialNumber MediaType   CanPool OperationalStatus HealthStatus Usage         Size
   ------ ----------------- ------------ ----------- ------- ----------------- ------------ ----------- ------
   0      Msft Virtual Disk              Unspecified False   OK                Healthy      Auto-Select 127 GB
   1      Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  32 GB
   1004   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   1003   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   1002   Msft Virtual Disk              HDD         False   OK                Healthy      Auto-Select  64 GB
   ```

   ```powershell
   PS C:\Users\SQLVMADMIN> Get-StorageNode -name "S2D-2.contoso.com" | Get-PhysicalDisk -PhysicallyConnected
   ```

   ```output
   Number FriendlyName      Serial Number MediaType CanPool OperationalStatus HealthStatus Usage        Size
   ------ ----------------- ------------- --------- ------- ----------------- ------------ ----------- -----
   2003   Msft Virtual Disk               HDD       False   OK                Healthy      Auto-Select 64 GB
   2002   Msft Virtual Disk               HDD       False   OK                Healthy      Auto-Select 64 GB
   2004   Msft Virtual Disk               HDD       False   OK                Healthy      Auto-Select 64 GB
   ```

1. To review information about the virtual disks, run the following command:

   ```powershell
   PS C:\Users\SQLVMADMIN> Get-VirtualDisk
   ```

   ```output
   FriendlyName              ResiliencySettingName FaultDomainRedundancy OperationalStatus HealthStatus     Size FootprintOnPool StorageEfficiency
   ------------ ------------ --------------------- --------------------- ----------------- ------------ -------- --------------- -----------------
   ClusterPerformanceHistory Mirror                1                     OK                Healthy         21 GB           43 GB            48.84%
   userdata01                                                            OK                Healthy      50.25 GB        101.5 GB            49.51%
   ```

1. To review information about the storage tiers that can be used together with virtual disks, run the following command:

   ```powershell
   PS C:\Users\SQLVMADMIN> Get-StorageTier
   ```

   ```output
   FriendlyName      TierClass MediaType ResiliencySettingName FaultDomainRedundancy Size FootprintOnPool StorageEfficiency
   ------------      --------- --------- --------------------- --------------------- ---- --------------- -----------------
   MirrorOnHDD       Unknown   HDD       Mirror                1                      0 B             0 B
   NestedParityOnHDD Unknown   HDD       Parity                1                      0 B             0 B
   Capacity          Unknown   HDD       Mirror                1                      0 B             0 B
   NestedMirrorOnHDD Unknown   HDD       Mirror                3                      0 B             0 B
   ```

## Step 2: Remove the virtual disks from the storage pool

To gracefully remove the virtual disks from the storage pool, run the following command:

```powershell
PS C:\Users\SQLVMADMIN> Get-StoragePool "S2D on S2DclusterNew" | Get-VirtualDisk | Remove-VirtualDisk
```

To get confirmation of the operation, type *Y* at the command prompt. The output of this command resembles the following example:

```output
Confirm
Are you sure you want to perform this action?
This will remove the VirtualDisk "Userdata01" and will erase all of the data that it contains.
[Y] Yes [A] Yes to All [N] No [L] No to All [S] Suspend [?] Help (default is "Y"): Y
Confirm
Are you sure you want to perform this action?
This will remove the VirtualDisk "ClusterPerformanceHistory" and will erase all of the data that it contains.
[Y] Yes [A] Yes to All [N] No [L] No to All [S] Suspend [?] Help (default is "Y"): Y
```

## Step 3: Remove the storage pool

To remove the storage pool and all the associated storage tiers, run the following command:

```powershell
PS C:\Users\SQLVMADMIN> Remove-StoragePool -FriendlyName "S2D on S2DclusterNew"
```

To get confirmation of the operation, type *Y* at the command prompt. The output of this command resembles the following example:

```output
Confirm
Are you sure you want to perform this action?
This will remove the StoragePool "S2D on S2DclusterNew".
[Y] Yes [A] Yes to All [N] No [L] No to All [S] Suspend [?] Help (default is "Y"): Y
```

## Step 4: Disable S2D

To finish removing the storage pool and disable the S2D functionality, run the following command:

```powershell
PS C:\Users\SQLVMADMIN> Disable-ClusterS2D
```

To get confirmation of the operation, type *Y* at the command prompt. The output of this command resembles the following example:

```output
Confirm
Are you sure you want to perform this action?
Performing operation 'Disable Storage Spaces Direct' on Target 'S2D on S2DclusterNew'.
[Y] Yes [A] Yes to All [N] No [L] No to All [S] Suspend [?] Help (default is "Y"): Y
```

## Step 5: Verify that everything is removed

To verify that the virtual disks, storage tiers, and the storage pool don't exist, run the following commands:

```powershell
PS C:\Users\SQLVMADMIN> Get-StoragePool
```

The output of this command resembles the following example. Notice that the primordial storage pool is still present.

```output
FriendlyName OperationalStatus HealthStatus IsPrimordial IsReadOnly   Size AllocatedSize
------------ ----------------- ------------ ------------ ---------- ------ -------------
Primordial   OK                Healthy      True         False      351 GB           0 B
Primordial   OK                Healthy      True         False      351 GB           0 B
```

```powershell
PS C:\Users\SQLVMADMIN> Get-VirtualDisk

PS C:\Users\SQLVMADMIN> Get-StorageTier
```

## Step 6: Clean up the physical disks

To clean up the physical disks, use the script that's provided in the [Step 3.1: Clean drives](/windows-server/storage/storage-spaces/deploy-storage-spaces-direct#step-31-clean-drives) section of "Deploy Storage Spaces Direct on Windows Server." The script removes any old partitions or other data, but doesn't affect the operating system disk.

As described in the referenced article, substitute your cluster node or server names for the variables in the script. Run the script at a PowerShell command prompt.

In this example, we run the script on each cluster node separately. On S2D-1, the script generates output that resembles the following example.

:::image type="content" source="media/delete-s2d-storage-pool-reuse-disks/cleanup-script-node-s2d-1-output.png" alt-text="Script output from node S2D-1 that shows the clean-up process for physical disks." lightbox="media/delete-s2d-storage-pool-reuse-disks/cleanup-script-node-s2d-1-output-expanded.png":::

On S2D-2, the script generates output that resembles the following example.

:::image type="content" source="media/delete-s2d-storage-pool-reuse-disks/cleanup-script-node-s2d-2-output.png" alt-text="Script output from node S2D-2 that shows the clean-up process for physical disks." lightbox="media/delete-s2d-storage-pool-reuse-disks/cleanup-script-node-s2d-2-output-expanded.png":::

After the script finishes, verify the disk status by running the following command:

```powershell
PS C:\Users\SQLVMADMIN> Get-PhysicalDisk
```

The output of this command resembles the following example. The **CanPool** property of each disk changed from "False" to "True." The disks don't belong to a storage pool anymore, but they're available to assign to a new storage pool.

```output
Number FriendlyName      SerialNumber MediaType    CanPool OperationalStatus HealthStatus Usage         Size
------ ----------------- ------------ -----------  ------- ----------------- ------------ ----------- ------
0      Msft Virtual Disk              Unspecified  False   OK                Healthy      Auto-Select 127 GB
1      Msft Virtual Disk              Unspecified  False   OK                Healthy      Auto-Select  32 GB
1004   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
1003   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
1002   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
2003   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
2002   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
2004   Msft Virtual Disk              HDD          True    OK                Healthy      Auto-Select  64 GB
```

## More information

If you remove a physical disk from the storage pool infrastructure without using the process that this article provides, both the storage pool and the disk become unusable. For example, if you remove a disk from one node, the System log of that node generates Event ID 157:

```output
Log Name:      System
Source:        disk
Date:          MM/DD/YYYY 2:42:11 PM
Event ID:      157
Task Category: None
Level:         Warning
Keywords:      Classic
User:          N/A
Computer:      S2D-1.contoso.com
Description:
Disk 4 has been surprise removed.
```

The node's Storagespaces-Driver/Operational event log generates Event ID 205:

```output
Log Name:      Microsoft-Windows-StorageSpaces-Driver/Operational
Source:        Microsoft-Windows-StorageSpaces-Driver
Date:          MM/DD/YYYY 2:42:12 PM
Event ID:      205
Task Category: None
Level:         Warning
Keywords:
User:          SYSTEM
Computer:      S2D-1.contoso.com
Description:
Windows lost communication with physical disk {aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb}. This can occur if a cable failed or was disconnected, or if the disk itself failed.
This disk may be located using the following information:
Drive Manufacturer: Msft
Drive Model Number: Virtual Disk
Drive Serial Number: NULL
If this disk is in an enclosure, it may be located using the following information:
Enclosure Manufacturer: NULL
Enclosure Model Number: NULL
Enclosure Serial Number: NULL
Enclosure Slot: -1
More information can be obtained using this PowerShell command:
Get-PhysicalDisk | ?{ $_.ObjectId -Match "{aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb}" }
To view the virtual disks affected, run this command in PowerShell:
Get-PhysicalDisk | ?{ $_.ObjectId -Match "{aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb}" } | Get-VirtualDisk
```

When you run the `Get-StoragePool` command, you see output that resembles the following example:

```output
FriendlyName         OperationalStatus HealthStatus IsPrimordial IsReadOnly      Size AllocatedSize
-------------------- ----------------- ------------ ------------ ---------- --------- -------------
Primordial           OK                Healthy      True         False         479 GB      317.5 GB
Primordial           OK                Healthy      True         False         479 GB      317.5 GB
S2D on S2DclusterNew Degraded          Warning      False        False      377.99 GB       99.5 GB
```

The storage pool is unhealthy and in a degraded state.

If you connect the disk to a new server, the disk might appear to be healthy, but it remains in an unusable state. For example, if you view the disk in Disk Manager, the disk appears to be inaccessible.

:::image type="content" source="media/delete-s2d-storage-pool-reuse-disks/diskmgr-error-detail.png" alt-text="View in Disk Manager that shows a disk that was improperly moved from a storage pool to a separate server." lightbox="media/delete-s2d-storage-pool-reuse-disks/diskmgr-error-detail-expanded.png":::

According to Disk Manager, the disk still belongs to the storage pool.
