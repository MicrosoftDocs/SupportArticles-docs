---
title: Troubleshooting operating system disk sector size greater than 4 KB
description: This article troubleshoots SQL Server installation or startup failures related to some new storage devices and device drivers exposing a disk sector size greater than the supported 4 KB sector size.
ms.date: 12/17/2021
ms.prod-support-area-path: Administration and Management
ms.reviewer: ramakoni, dplessMSFT, briancarrig, suresh-kandoth 
ms.prod: sql
author: WilliamDAssafMSFT
ms.author: wiassaf
---
# Troubleshoot errors related to system disk sector size greater than 4 KB

This article provides solutions for troubleshooting errors during installation or starting SQL Server on Windows 11 related to system disk sector size greater than 4 KB.

## Symptoms

**Scenario #1:** When you attempt to install SQL Server 2019, SQL Server 2017, or SQL Server 2016 on a Windows 11 device. You encounter errors similar to the following for the Database Engine Services component of SQL Server: 

```output
Feature: Database Engine Services 
Status: Failed 
Reason for failure: An error occurred during the setup process of the feature. 
Next Step: Use the following information to resolve the error, uninstall this feature, and then run the setup process again. 
Component name: SQL Server Database Engine Services Instance Features 
Component error code: 0x851A001A 
Error description: Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes. 
```

**Scenario #2:** You install SQL Server 2019, SQL Server 2017, or SQL Server 2016 on a Windows 10 device. You upgrade the OS on the device to Windows 11. You attempt to start SQL Server 2019, SQL Server 2017, or SQL Server 2016 on a Windows 11 device. The service fails to start and in the SQL Server error log, you notice entries similar to: 

```output
2021-11-05 23:42:47.14 spid9s There have been 256 misaligned log IOs which required falling back to synchronous IO. The current IO is on file C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master.mdf. 
```

**Scenario #3:** You install SQL Server 2019, SQL Server 2017, or SQL Server 2016 on a Windows 10 device. You upgrade the OS on the device to Windows 11. You attempt to start SQL Server 2019, SQL Server 2017, or SQL Server 2016 on a Windows 11 device. The service fails to start and in the SQL Server error log, you notice entries similar to: 

```output
Faulting application name: sqlservr.exe, version: 2019.150.2000.5, time stamp: 0x5d8a9215 
Faulting module name: ntdll.dll, version: 10.0.22000.120, time stamp: 0x50702a8c 
Exception code: 0xc0000005 
Fault offset: 0x00000000000357ae 
Faulting process id: 0x1124 
Faulting application start time: 0x01d7bf67449d262c 
Faulting application path: C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\sqlservr.exe 
Faulting module path: C:\Windows\SYSTEM32\ntdll.dll 
```

> [!Note]
> You might encounter the failures mentioned in the above scenarios for a SQL Server instance you install manually, or on a LocalDB instance installed by applications. 
 
## Cause

During service startup, SQL Server begins the database recovery process to ensure database consistency. Part of this database recovery process involves consistency checks on the underlying filesystem before attempting the activity of opening system and user database files.  

On systems running Windows 11, some new storage devices and device drivers will expose a disk sector size greater than the supported 4 KB sector size. 
  
When this occurs, SQL Server will be unable to start due to the unsupported file system as SQL Server currently supports sector storage sizes of 512 bytes and 4 KB. 

You can confirm that you encounter this specific issue by executing the command:

```console
fsutil fsinfo sectorinfo <volume pathname>
```

For example, to analyze the E: volume, execute the following command:

```console
fsutil fsinfo sectorinfo E:
```

Look for the value `PhysicalBytesPerSectorForAtomicity`, returned in bytes. A value of 4096 indicates a sector storage size of 4 KB.

## Resolution

Microsoft is currently investigating this problem. Consider the following resolutions: 

- If you have multiple drives on this system, you can specify a different location for the database files upon installation of SQL Server. Make sure that drive reflects a supported sector size when querying the `fsutil` command. SQL Server currently supports sector storage sizes of 512 bytes and 4096 bytes. 

- You can start SQL Server by specifying the trace flag 1800, For more information, see [DBCC TRACEON](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1800). This trace flag is not enabled by default. Trace flag 1800 forces SQL Server to use 4 KB as the sector size for all read and writes. When you are running SQL Server on disks with physical sector size greater than 4 KB, using the trace flag 1800 will simulate a native 4 KB drive which is the supported sector size for SQL Server.

- Install SQL Server on available Windows 10 devices instead.

- Additionally, be aware of the Windows support policy for file system and storage sector size support. For more information, see [Microsoft support policy for 4 KB sector hard drives in Windows](../../windows-server/backup-and-storage/support-policy-4k-sector-hard-drives.md).

> [!NOTE]
> There is no released version of SQL Server compatible with sector sizes greater than 4 KB. For more information, see [Hard disk drive sector-size support boundaries in SQL Server](https://support.microsoft.com/topic/hard-disk-drive-sector-size-support-boundaries-in-sql-server-4d5b73fa-7dc4-1d8a-2735-556e6b60d046).

## More information

Windows 11 native NVMe drivers were updated to include the actual sector size reported directly by the NVMe storage devices, rather than relying on the information that is emulated from the filesystem drivers.  

The Windows 10 drivers do not report the source sector size of the physical storage.  

The improved Windows 11 drivers disregard the emulation that common NVMe storage devices are using. As an example, `fsutil` displays a sector size of 8 KB or 16 KB, rather than emulating the required 4 KB sector size needed by Windows. 

Below is a comparison of the sector sizes reported by the operating systems. This example illustrates the differences between Windows 10 and Windows 11 using the same storage device. For the value of `PhysicalBytesPerSectorForAtomicity`, Windows 10 displays 4 KB and Windows 11 displays 16 KB.

**Sample output of `fsutil fsinfo sectorinfo <volume pathname>`**


| **Windows 10** | **Windows 11** | 
|:-|:-|
| `LogicalBytesPerSector : 512` | `LogicalBytesPerSector : 512` |
| `PhysicalBytesPerSectorForAtomicity :    4096` | `PhysicalBytesPerSectorForAtomicity :    16384` |
| `PhysicalBytesPerSectorForPerformance :  4096` | `PhysicalBytesPerSectorForPerformance :  16384` |
| `FileSystemEffectivePhysicalBytesPerSectorForAtomicity : 4096` | `FileSystemEffectivePhysicalBytesPerSectorForAtomicity : 4096` |
| `Device Alignment :  Aligned (0x000)` | `Device Alignment :  Aligned (0x000)` |
| `Partition alignment on device :  Aligned (0x000)` | `Partition alignment on device :   Aligned (0x000)` |
| `No Seek Penalty` | `No Seek Penalty` |
| `Trim Supported` | `Trim Supported` |
| `Not DAX capable` | `Not DAX capable` |
| `Not Thinly-Provisioned` | `Not Thinly-Provisioned` |
|||


## See also

- [Hard disk drive sector-size support boundaries in SQL Server](https://support.microsoft.com/topic/hard-disk-drive-sector-size-support-boundaries-in-sql-server-4d5b73fa-7dc4-1d8a-2735-556e6b60d046)
- [SQL Server 2019 Storage types for data files](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15#StorageTypes)
- [KB3009974 - FIX: Slow synchronization when disks have different sector sizes for primary and secondary replica log files in SQL Server AG and Logshipping environments](https://support.microsoft.com/topic/kb3009974-fix-slow-synchronization-when-disks-have-different-sector-sizes-for-primary-and-secondary-replica-log-files-in-sql-server-ag-and-logshipping-environments-ed181bf3-ce80-b6d0-f268-34135711043c)
- [SQL Server LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb)
 