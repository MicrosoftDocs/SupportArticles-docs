---
title: Can't add unenumerated disks to a DPM disk pool
description: Describes an issue that occurs when you try to add disks that are physically attached to a server running System Center 2012 Data Protection Manager to the DPM disk pool.
ms.date: 07/27/2020
---
# Some disks aren't enumerated when you add them to a Data Protection Manager disk pool

This article helps you resolve an issue in which some disks aren't enumerated so that these disks cannot be added to a Data Protection Manager (DPM) disk pool.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager, Microsoft System Center 2012 Data Protection Manager Service Pack 1, System Center 2012 R2 Data Protection Manager  
_Original KB number:_ &nbsp; 3032775

## Symptoms

When you have disks that are physically attached to a server that's running Microsoft System Center 2012 Data Protection Manager, the disks are displayed in Disk Management as expected. (These may be basic or dynamic disks that have had no volumes ever created on them and that have never been used before.) However, when you try to add these disks to the Data Protection Manager disk pool, Data Protection Manager doesn't enumerate some of the disks. Therefore, these disks cannot be added to the pool. No error is generated in the GUI, and a rescan does not help. When you use the `get-dpmdisk` command in the Data Protection Manager Management Shell, these disks are not enumerated.

## Cause

The disk has an extent type that's incompatible with Data Protection Manager.

## Resolution 1: Use the DiskPart command

Use the `clean` or `clean all` option, as shown in the following example:

```console
C:\>diskpart
```

> Microsoft DiskPart version 6.2.9200  
> Copyright (C) 1999-2012 Microsoft Corporation.  
> On computer: Computer1  

```console
DISKPART> list disk
```

> |Disk ###|Status|Size|Free|Dyn|Gpt|
> |---|---|---|---|---|---|
> |Disk 0|Online|126 GB|0 B|||
> |Disk 1|Online|240 GB|17 GB|*||
> |Disk 2|Online|100 GB|99 GB|||

```console
DISKPART> select disk 2
```

> Disk 2 is now the selected disk.

```console
DISKPART> detail disk
```

> Microsoft Virtual Disk  
> Disk ID: 0336D3B1  
> Type : SCSI  
> Status : Online  
> Path : 0  
> Target : 0  
> LUN ID : 1  
> Location Path : UNAVAILABLE  
> Current Read-only State : No  
> Read-only : No  
> Boot Disk : No  
> Pagefile Disk : No  
> Hibernation File Disk : No  
> Crashdump Disk : No  
> Clustered Disk : No  
> There are no volumes.  

```console
DISKPART> clean all
```

> DiskPart succeeded in cleaning the disk.

## Resolution 2: Use the Server Manager interface

Use the **Reset Disk** option, as shown here:

:::image type="content" source="media/disks-not-enumeratd-fail-to-add/reset-disk-option.png" alt-text="Select the Reset Disk option by using the Server Manager interface.":::

## More information

In this scenario, neither the DPM interface nor the shell generates any error messages. Instead, they list a subset of the disks that you want to add to the disk pool. However, the disks do appear in the Disk Management console.

When you examine the MSDPM *.errlog file for the time during which you rescan for disks from the console, you see entries that resemble the following:

> 0CA0 0DE4 12/24 08:59:30.144 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 8] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.144 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 8] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.160 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 8] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0DE4 12/24 08:59:30.160 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 7] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.160 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 7] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.160 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 7] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0DE4 12/24 08:59:30.176 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 6] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.176 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 6] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.191 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 5] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.191 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 5] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.207 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 4] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.222 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 4] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.222 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 4] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0DE4 12/24 08:59:30.222 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 3] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.222 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 3] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.222 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 3] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0DE4 12/24 08:59:30.238 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 2] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.238 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 2] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.238 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 2] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0DE4 12/24 08:59:30.254 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 0] ActualDiskSizeInMB = 4070, TotalSizeInMB = 4070  
0CA0 0DE4 12/24 08:59:30.254 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 0] FreeExtentSizeInMB = 0, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.269 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 0] ActualDiskSizeInMB = 102399, TotalSizeInMB = 102399  
0CA0 0DE4 12/24 08:59:30.269 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 0] FreeExtentSizeInMB = 0, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.332 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 1] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0DE4 12/24 08:59:30.332 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 1] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0DE4 12/24 08:59:30.332 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 1] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.717 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 8] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.717 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 8] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.717 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 8] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.733 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 7] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.733 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 7] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.733 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 7] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.748 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 6] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.748 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 6] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.764 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 5] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.764 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 5] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.780 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 4] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.780 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 4] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.780 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 4] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.795 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 3] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.795 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 3] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.795 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 3] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.811 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 2] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.811 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 2] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.811 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 2] cannot be added to SPM: Contains Special Volume of type: 7  
0CA0 0224 12/24 08:59:36.811 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 0] ActualDiskSizeInMB = 4070, TotalSizeInMB = 4070  
0CA0 0224 12/24 08:59:36.811 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 0] FreeExtentSizeInMB = 0, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.842 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 0] ActualDiskSizeInMB = 102399, TotalSizeInMB = 102399  
0CA0 0224 12/24 08:59:36.842 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 0] FreeExtentSizeInMB = 0, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.873 11 spmdisk.cpp(663) NORMAL Disk [NTDiskNo = 1] ActualDiskSizeInMB = 3815447, TotalSizeInMB = 3815319  
0CA0 0224 12/24 08:59:36.873 11 spmdisk.cpp(667) NORMAL Disk [NTDiskNo = 1] FreeExtentSizeInMB = 3815317, UnusableExtentSizeInMB = 0  
0CA0 0224 12/24 08:59:36.873 11 spmdisk.cpp(372) NORMAL Disk [NTDiskNo = 1] cannot be added to SPM: Contains Special Volume of type: 7  

When you examine the `tbl_SPM_Disk` table, all these disks are marked as **0** (zero) against `CanAddToStoragePool`.

Notice also that the **type** that's mentioned here pertains to `VDS_DISK_EXTENT_TYPE` as described in [VDS_DISK_EXTENT_TYPE enumeration](/windows/win32/api/vds/ne-vds-vds_disk_extent_type?redirectedfrom=MSDN).

This article mentions the following types:

- VDS_DET_UNKNOWN = 0
- VDS_DET_FREE = 1
- VDS_DET_DATA = 2
- VDS_DET_OEM = 3
- VDS_DET_ESP = 4
- VDS_DET_MSR = 5
- VDS_DET_LDM = 6
- VDS_DET_CLUSTER = 7
- VDS_DET_UNUSABLE = 0x7FFF

Data Protection Manager can use `VDS_DISK_EXTENT_TYPE` 1, 2, 5, 6, and 0x7FFF. For any other type, it generates an error that resembles the error in the earlier example. In that example, the type is displayed as **7**. This type is `VDS_DET_CLUSTER`.

The resolution that's provided here wipes out the disk. This means that the extents will also be cleared.
