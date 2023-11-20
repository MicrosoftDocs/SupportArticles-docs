---
title: Troubleshooting operating system disk sector size greater than 4 KB
description: This article troubleshoots SQL Server installation or startup failures related to some new storage devices and device drivers exposing a disk sector size greater than the supported 4-KB sector size.
ms.date: 11/20/2023
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni, dplessMSFT, briancarrig, suresh-kandoth, rdorr 
author: WilliamDAssafMSFT
ms.author: wiassaf
---

# Troubleshoot errors related to system disk sector size greater than 4 KB

This article provides solutions for troubleshooting errors during installation or starting an instance of SQL Server on Windows 11 and Windows Server 2022. This article is valid for all released versions of SQL Server.

The errors discussed in this article are related to system disk sector size greater than 4 KB.

_Applies to_: &nbsp; SQL Server all versions

## Symptoms

**Scenario #1:** You install any version of SQL Server on a Windows 11 device. Then, you see errors similar to the following message for the Database Engine Services component of SQL Server:

```output
Feature: Database Engine Services 
Status: Failed 
Reason for failure: An error occurred during the setup process of the feature. 
Next Step: Use the following information to resolve the error, uninstall this feature, and then run the setup process again. 
Component name: SQL Server Database Engine Services Instance Features 
Component error code: 0x851A001A 
Error description: Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes. 
```

**Scenario #2:** You install any version of SQL Server on a Windows 10 device. Then, you upgrade the OS on the device to Windows 11. When you try to start SQL Server on a Windows 11 device, the service fails to start and in the SQL Server error log, you notice entries similar to:

```output
2021-11-05 23:42:47.14 spid9s There have been 256 misaligned log IOs which required falling back to synchronous IO. The current IO is on file C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master.mdf. 
```

**Scenario #3:** You install any version of SQL Server on a Windows 10 device. Then, you upgrade the OS on the device to Windows 11. When you try to start SQL Server on a Windows 11 device, the service fails to start. In the SQL Server error log, you notice entries similar to:

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

**Scenario #4:** You install LocalDB on a Windows 11 device. The setup fails and in the SQL Server error log, you notice entries similar to:

```output
2021-12-15 23:25:04.28 spid5s      Cannot use file 'C:\Users\Administrator\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\TestInstance\master.mdf' because it was originally formatted with sector size 4096 and is now on a volume with sector size 16384. Move the file to a volume with a sector size that is the same as or smaller than the original sector size.
```

In the Windows 11 Application Event Log, you notice entries similar to:

```output
Message            : Windows API call WaitForMultipleObjects returned error code: 575. Windows system error message is: {Application Error}
                     The application was unable to start correctly (0x%lx). Click OK to close the application.
                     Reported at line: 3621.
Source             : SQLLocalDB 11.0
```

> [!Note]
> You might encounter the failures mentioned in the previous scenarios for a SQL Server instance you installed manually or on a LocalDB instance installed by applications.

**Scenario #5:** If you try to use sector size that is higher than 4 KB, you see the following error message:

```output
Error: 5179, Severity: 16, State: 1.
Cannot use file 'data file path', because it is on a volume with sector size 8192. SQL Server supports a maximum sector size of 4096 bytes. Move the file to a volume with a compatible sector size.
```

## Cause

During service startup, SQL Server begins the database recovery process to ensure database consistency. Part of this database recovery process involves consistency checks on the underlying filesystem before you try to open system and user database files.  

On systems running Windows 11, some new storage devices and device drivers exposes a disk sector size greater than the supported 4-KB sector size.
  
When this occurs, SQL Server will be unable to start due to the unsupported file system as SQL Server currently supports sector storage sizes of 512 bytes and 4 KB.

You can confirm that you encounter this specific issue by running the command:

```console
fsutil fsinfo sectorinfo <volume pathname>
```

For example, to analyze the E: volume, run the following command:

```console
fsutil fsinfo sectorinfo E:
```

Look for the values `PhysicalBytesPerSectorForAtomicity` and `PhysicalBytesPerSectorForPerformance`, returned in bytes, and if they're different, retain the _largest_ one to ascertain the disk sector size. A value of 4096 indicates a sector storage size of 4 KB.

Additionally, be aware of the Windows support policy for file system and storage sector size support. For more information, see the [Microsoft support policy for 4-KB sector hard drives in Windows](../../../windows-server/backup-and-storage/support-policy-4k-sector-hard-drives.md) article.

> [!NOTE]
> There's no released version of SQL Server compatible with sector sizes greater than 4 KB. For more information, see the [Hard disk drive sector-size support boundaries in SQL Server](https://support.microsoft.com/topic/hard-disk-drive-sector-size-support-boundaries-in-sql-server-4d5b73fa-7dc4-1d8a-2735-556e6b60d046) article.

## Resolutions

Microsoft is currently investigating this problem.

Consider _one_ of the following solutions:

- If you have multiple drives on this system, you can specify a different location for the database files after installation of SQL Server is complete. Make sure that drive reflects a supported sector size when querying the `fsutil` commands. SQL Server currently supports sector storage sizes of 512 bytes and 4096 bytes.

- You can add a registry key, which will cause the behavior of Windows 11 and later to be similar to Windows 10. This forces the sector size to be emulated as 4 KB. To add the `ForcedPhysicalSectorSizeInBytes` registry key, use the [Registry Editor](#registryeditor) or run commands as described in the [PowerShell as Administrator](#powershellasadmin) section. You must reboot the device after adding the registry key in order for this change to take effect.
  
  > [!IMPORTANT]
  > This section contains steps that tell you how to modify the Windows registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see the [How to back up and restore the registry in Windows](../../../windows-server/performance/windows-registry-advanced-users.md#back-up-the-registry) article.
  
    <a id="registryeditor"></a>**Registry Editor**
  
    1. Navigate to `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device`.
    1. On the **Edit** menu, point to **New**, and then select **Multi-String value**. Name it `ForcedPhysicalSectorSizeInBytes`.
    1. Modify the new value, type in `* 4095`. Select **OK** and close the Registry editor.
  
    <a id="commandpromptadmin"></a>**Command Prompt as Administrator**

    1. Add the key.
  
       ```console
       REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "ForcedPhysicalSectorSizeInBytes" /t   REG_MULTI_SZ /d "* 4095" /f
       ```

    2. Validate if the key was added successfully.

       ```console
       REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "ForcedPhysicalSectorSizeInBytes"
       ```
  
    <a id="powershellasadmin"></a>**PowerShell as Administrator**

    1. Add the key.

       ```Powershell
       New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" -Name   "ForcedPhysicalSectorSizeInBytes" -PropertyType MultiString        -Force -Value "* 4095"
       ```

    2. Validate if the key was added successfully.

       ```Powershell
        Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" -Name   "ForcedPhysicalSectorSizeInBytes"
       ```

- You can start SQL Server by specifying the trace flag 1800. For more information, see [DBCC TRACEON](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1800). This trace flag isn't enabled by default. Trace flag 1800 forces SQL Server to use 4 KB as the sector size for all read and write operations. When you are running SQL Server on disks with physical sector size greater than 4 KB, using the trace flag 1800 will simulate a native 4 KB drive, which is the supported sector size for SQL Server.

- Install SQL Server on available Windows 10 devices instead.



## More information

Windows 11 native NVMe drivers were updated to include the actual sector size reported directly by the NVMe storage devices. This was done rather than relying on the information that's emulated from the filesystem drivers.  

The Windows 10 drivers don't report the source sector size of the physical storage.  

The improved Windows 11 drivers disregard the emulation that common NVMe storage devices are using. As an example, `fsutil` displays a sector size of 8 KB or 16 KB, rather than emulating the required 4-KB sector size required by Windows.

The following table provides a comparison of the sector sizes reported by the operating systems. This example illustrates the differences between Windows 10 and Windows 11 using the same storage device. For the values of `PhysicalBytesPerSectorForAtomicity` and `PhysicalBytesPerSectorForPerformance`, Windows 10 displays 4 KB and Windows 11 displays 16 KB.

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
  
## See also

- [SQL Server storage types for data files](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver16&preserve-view=true#StorageTypes)
- [KB3009974 - FIX: Slow synchronization when disks have different sector sizes for primary and secondary replica log files in SQL Server AG and Logshipping environments](https://support.microsoft.com/topic/kb3009974-fix-slow-synchronization-when-disks-have-different-sector-sizes-for-primary-and-secondary-replica-log-files-in-sql-server-ag-and-logshipping-environments-ed181bf3-ce80-b6d0-f268-34135711043c)
- [SQL Server LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb)
