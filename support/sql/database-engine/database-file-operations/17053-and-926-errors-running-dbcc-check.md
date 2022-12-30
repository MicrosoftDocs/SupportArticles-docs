---
title: Error may be logged after you run a DBCC CHECK command
description: This article describes how to interpret "Error:17053" and other error messages that may be reported when you run a DBCC command in SQL Server.
ms.date: 11/03/2020
ms.custom: sap:Administration and Management
ms.reviewer: sureshka
ms.prod: sql
---
# Error 17053 may be logged in the error log after you run a DBCC command in SQL Server

This article describes how to interpret "Error: 17053" and other error messages that may be reported when you run a DBCC command in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 926070

## Symptoms

You run one of the following DBCC commands in Microsoft SQL Server:

- `DBCC CHECKDB`
- `DBCC CHECKALLOC`
- `DBCC CHECKTABLE`
- `DBCC CHECKCATALOG`
- `DBCC CHECKFILEGROUP`

After you do this, error messages that resemble the following may be logged in the SQL Server error log:

```output
2006-09-01 17:33:24.48 spid54 35 transactions rolled forward in database 'ProductionData' (11). This is an informational message only. No user action is required.
2006-09-01 17:35:39.16 spid54 4 transactions rolled back in database 'ProductionData' (11). This is an informational message only. No user action is required.
2006-09-01 17:36:31.76 spid53 Error: 17053, Severity: 16, State: 1.
2006-09-01 17:36:31.76 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2006-09-01 17:36:31.76 spid53 Error: 17053, Severity: 16, State: 1.
2006-09-01 17:36:31.76 spid53 E:\ SQLData \ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2006-09-01 17:36:31.77 spid53 Error: 17053, Severity: 16, State: 1.
2006-09-01 17:36:31.77 spid53 E:\ SQLData \ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2006-09-01 17:36:31.80 spid54 DBCC CHECKDB (ProductionData) executed by DomainName \ UserName found 0 errors and repaired 0 errors. Elapsed time: 0 hours 3 minutes 19 seconds.
2006-09-01 17:36:31.90 spid53 Error: 17053, Severity: 16, State: 1.
2006-09-01 17:36:31.90 spid53 E:\ SQLData \ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2006-09-01 17:36:31.90 spid53 Error: 17053, Severity: 16, State: 1.
2006-09-01 17:36:31.90 spid53 E:\ SQLData \ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2006-09-01 17:36:32.30 spid54 Error: 926, Severity: 21, State: 6.
2006-09-01 17:36:32.30 spid54 Database 'ProductionData' cannot be opened. It has been marked SUSPECT by recovery. See the SQL Server errorlog for more information.
```

## Cause

In SQL Server, DBCC commands use internal read-only database snapshots. These database snapshots are created on the same drive where the corresponding database data files are located. Database snapshots grow in proportion to the amount of changed data in the database against which the DBCC commands run. If transactional activity continues on this database, the database snapshots that are created by DBCC commands may experience disk space issues. Because the database snapshot files and the actual data files reside on the same disk drive, both sets of files compete for disk space. In this case, application transactions or user transactions are given preference. The internal database snapshot used by DBCC is marked as suspect. Therefore, the DBCC commands experience errors and cannot finish.

Disk Space is one reason that writes to the internal database snapshot may fail. Other reasons such as OS error codes 1450 and 665 can also contribute to similar issues and render the internal database snapshot to a suspect state.

## Status

This behavior is by design.

## More information

The following important information applies to the error messages that are mentioned in the [Symptoms](#symptoms) section:

- These error messages are from different active server process identifiers (SPIDs). SPID 54 is the session ID that executes the DBCC command. SPID 53 is the session ID that executes a user transaction.

- These error messages indicate rolling forward transactions and rolling back transactions. These messages are generated during the initial phase of DBCC command execution. When you run a DBCC command, the DBCC command first tries to create an internal snapshot. When the snapshot is created, database recovery is performed against this snapshot to bring the snapshot into a consistent state. The error messages reflect this activity.

- Error message 926 indicates that the database is marked as suspect. This error message actually refers to the internal snapshot and not to the actual database. The status of the database is "online," and the database is functional.

- Error message 17053 contains the name of the NTFS file system alternate streams that are used for the internal snapshot. This error message indicates the real reason for the problem.

- The internal database snapshot uses the same name as the actual database. Therefore, these error messages contain the name of the database.

- Even though the error log message indicates that DBCC CHECKDB completed, it should be regarded as an Abnormal Termination. You should rerun the DBCC CHECKDB command to allow for it to run until it is completed to access the consistency of the database. In these situations, refer to the output from the DBCC CHECKDB command sent back to the client to understand which objects were checked and reported clean.

For more information about this problem, see the following topics in SQL Server Books Online:

- DBCC Internal Database Snapshot Usage

- Understanding Sparse File Sizes in Database Snapshots. Follow steps that are documented in these topics to avoid space usage issues. After you correct any problem, rerun the DBCC commands.

In addition to the error messages that are mentioned in the [Symptoms](#symptoms) section, you may receive the following error message:

> Msg 5128, Level 17, State 2, Line 6

Write to sparse file `E:\CreateFile\ProductionData.mdf:MSSQL_DBCC11` failed due to lack of disk space.

In this case, the client application that runs the DBCC commands will have the following entries in the application result set:

> DBCC results for 'ProductionData'.
>
> CHECKDB found 0 allocation errors and 0 consistency errors in database 'ProductionData'.
>
> Msg 926, Level 21, State 6, Line 1
>
> Database 'ProductionData' cannot be opened. It has been marked SUSPECT by recovery. See the SQL Server errorlog for more information.
>
> Msg 0, Level 20, State 0, Line 0
>
> A severe error occurred on the current command. The results, if any, should be discarded.

If the snapshot could not be created at all, you receive error messages that resemble the following in the client application that issues the DBCC commands:

> Msg 1823, Level 16, State 1, Line 1
>
> A database snapshot cannot be created because it failed to start.
>
> Msg 7928, Level 16, State 1, Line 1
>
> The database snapshot for online checks could not be created. Either the reason is given in a previous error or one of the underlying volumes does not support sparse files or alternate streams. Attempting to get exclusive access to run checks offline.
>
> Msg 5030, Level 16, State 12, Line 1
>
> The database could not be exclusively locked to perform the operation.
>
> Msg 7926, Level 16, State 1, Line 1
>
> Check statement aborted. The database could not be checked as a database snapshot could not be created and the database or table could not be locked. See Books Online for details of when this behavior is expected and what workarounds exist. Also see previous errors for more details.
>
> Msg 5106, Level 17, State 2, Line 1
>
> Write to sparse file 'E:\Data\LogFUllTest_Data.mdf:MSSQL_DBCC10' failed due to lack of disk space.

If the internal database snapshot runs into 1450 or 665 errors, here is a typical sequence you will notice in the SQL Server error log:

```output
2008-05-21 13:03:45.67 spid500 272 transactions rolled forward in database 'MYDATABASE' (12). This is an informational message only. No user action is required.
2008-05-21 13:03:45.84 spid500 2 transactions rolled back in database 'MYDATABASE' (12). This is an informational message only. No user action is required.
2008-05-21 13:03:46.97 spid500 Recovery completed for database MYDATABASE (database ID 12) in 5 second(s) (analysis 602 ms, redo 3954 ms, undo 105 ms.) This is an informational message only. No user action is required.
2008-05-21 13:36:48.25 spid480 The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00001b35138000 in file 'I:\MSSQL\DATA\mscrm_data1.ndf:MSSQL_DBCC12'.
2008-05-21 13:36:48.26 spid480 Error: 17053, Severity: 16, State: 1.
2008-05-21 13:36:48.26 spid480 C:\MSSQL\DATA\MyDatabase.mdf:MSSQL_DBCC12: Operating system error 665(The requested operation could not be completed due to a file system limitation) encountered.
2008-05-21 13:36:48.27 spid480 The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00001b35138000 in file 'C:\MSSQL\DATA\MyDatabase.mdf:MSSQL_DBCC12'.
2008-05-21 13:36:48.27 spid480 Error: 17053, Severity: 16, State: 1.
2008-05-21 13:36:48.27 spid480 C:\MSSQL\DATA\MyDatabase.mdf:MSSQL_DBCC12: Operating system error 665(The requested operation could not be completed due to a file system limitation) encountered.
2008-05-21 13:36:48.37 spid480 The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00001b35138000 in file 'C:\MSSQL\DATA\MyDatabase.mdf:MSSQL_DBCC12'.
2008-05-21 13:36:48.37 spid480 Error: 17053, Severity: 16, State: 1.
2008-05-21 13:36:48.37 spid480 C:\MSSQL\DATA\MyDatabase.mdf:MSSQL_DBCC12: Operating system error 665(The requested operation could not be completed due to a file system limitation) encountered.
2008-05-21 13:36:48.37 spid500 DBCC CHECKDB (MYDATABASE) executed by DomainName \ UserName found 0 errors and repaired 0 errors. Elapsed time: 0 hours 33 minutes 16 seconds. Internal database snapshot has split point LSN = 0000759c:002547bc:0040 and first LSN = 0000759c:0023696d:0049. This is an informational message only. No user action is required.
```

## Reference

[MSSQLSERVER_17053](/sql/relational-databases/errors-events/mssqlserver-17053-database-engine-error)
