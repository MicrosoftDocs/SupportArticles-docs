---
title: Virtual host drivers lead to data consistency
description: This article provides resolutions for the problem where using virtual host drivers can lead to SQL Server Database Engine data consistency problems.
ms.date: 09/25/2020
ms.custom: sap:Administration and Management
ms.reviewer: sureshka
---
# Use of virtual host drivers can lead to SQL Server Database Engine data consistency problems

This article helps you resolve the problem where using virtual host drivers can lead to SQL Server Database Engine data consistency problems.

_Original product version:_ &nbsp; SQL Server 2008  
_Original KB number:_ &nbsp; 2600089

## Symptoms

You may notice that an instance of Microsoft SQL Server reports one or more of the following error messages in the SQL Server Error log and in the Application event log:

- Error message 1

    > Error 824 : SQL Server detected a logical consistency-based I/O error: incorrect pageid (expected 1:425920; actual 65535:0). It occurred during a read of page (1:425920) in database ID 2 at offset 0x000000cff80000 in file 'D:\DBName.mdf'. Additional messages in the SQL Server error log or system event log may provide more detail. This is a severe error condition that threatens database integrity and must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). This error can be caused by many factors; for more information, see SQL Server Books Online.

- Error message 2

    > 2011-02-24 00:20:32.55 spid65 Error: 605, Severity: 21, State: 3.
    2011-02-24 00:20:32.55 spid65 Attempt to fetch logical page (1:17479052) in database 8 failed. It belongs to allocation unit 0 not to 72057610609819648.

- Error message 3

    > Error 823 The operating system returned error incorrect pageid (expected 1:306208; actual 65535:0) to SQL Server during a read at offset 0x00000095840000 in file 'R:\DBName.mdf'. Additional messages in the SQL Server error log and system event log may provide more detail. This is a severe system-level error condition that threatens database integrity and must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). This error can be caused by many factors; for more information, see SQL Server Books Online.

- Error message 4

    > Error 18400 The background checkpoint thread has encountered an unrecoverable error. The checkpoint process is terminating so that the thread can clean up its resources. This is an informational message only. No user action is required.

- Error message 5

    > Backup detected log corruption in database DBName. Context is FirstSector. LogFile: 2 'R:\DBName.LDF' VLF SeqNo: x3c1c3 VLFBase: x6a850000 LogBlockOffset: x6bbcde00 SectorStatus: 2 LogBlock.StartLsn.SeqNo: x560053 LogBlock.StartLsn.Blk: x2d0043 Size: x53 PrevSize: x5c.

You may also notice that the `DBCC CHECKDB` command reports database consistency problems.

## Cause

Microsoft Customer Support and Services team (CSS) determined that the following virtual host driver can cause the behavior:

Driver Name: `C:\WINDOWS\SYSTEM32\DRIVERS\XGVHBA.SYS`  
Vendor Name: `Xsigo Systems`  

Xsigo Systems (vendor of the virtual host driver) indicates that this is a problem with the *XGVHBA.SYS* virtual host driver when the version is between 2.6.0.0 and 2.7.1.0.

## Resolution

Contact Xsigo Systems to obtain a version of the driver that is fixed. The fixed version is version 2.7.3.0 and later versions. Then, configure Xsigo Virtual HBA adapters to use the updated drivers.

## More information

- [MSSQLSERVER_824](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error)
- [MSSQLSERVER_823](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

