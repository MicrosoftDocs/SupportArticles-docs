---
title: Errors 17053 and 926 when you run a DBCC CHECK command
description: Error 17053, error 926, and underlying OS errors 112, 665, or 1450 may be reported when you run a DBCC command in SQL Server.
ms.reviewer: sureshka, pijocoder
ms.date: 05/10/2023
ms.custom: sap:Administration and Management
---
# Errors 17053 and 926 may be logged in the error log after you run a DBCC command in SQL Server

This article introduces [error 17053](/sql/relational-databases/errors-events/mssqlserver-17053-database-engine-error) and [error 926](/sql/relational-databases/errors-events/mssqlserver-926-database-engine-error) that may be reported when you run a `DBCC` command in SQL Server and provides troubleshooting steps of the underlying operating system (OS) errors 112, 665 or 1450.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 926070

## Symptoms

You run one of the following `DBCC` commands in Microsoft SQL Server:

- `DBCC CHECKDB`
- `DBCC CHECKALLOC`
- `DBCC CHECKTABLE`
- `DBCC CHECKCATALOG`
- `DBCC CHECKFILEGROUP`

The command may fail, and you may get errors 17053, 926, and other error messages in the client application output and the SQL Server error log.

## Errors

Error 926 indicates that the database is marked as suspect. This error message refers to the internal snapshot and not to the actual database. The status of the database is online, and the database is functional.

Error 17053 is a SQL Server error used to disclose the underlying OS error. It contains the name of the files that are used for the internal snapshot. The error message indicates the real reason for the problem.

The following sections show the detailed error messages you may get. For more clarification regarding these error messages, see the [More information](#more-information) section.

### OS error 112 - not enough disk space

Error messages that show the underlying OS error 112, "There is not enough space on the disk." may be logged in the SQL Server error log.

```output
2022-09-01 17:33:24.48 spid54 35 transactions rolled forward in database 'ProductionData' (11). This is an informational message only. No user action is required.
2022-09-01 17:35:39.16 spid54 4 transactions rolled back in database 'ProductionData' (11). This is an informational message only. No user action is required.
2022-09-01 17:36:31.76 spid53 Error: 17053, Severity: 16, State: 1.
2022-09-01 17:36:31.76 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2022-09-01 17:36:31.76 spid53 Error: 17053, Severity: 16, State: 1.
2022-09-01 17:36:31.76 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2022-09-01 17:36:31.77 spid53 Error: 17053, Severity: 16, State: 1.
2022-09-01 17:36:31.77 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2022-09-01 17:36:31.80 spid54 DBCC CHECKDB (ProductionData) executed by DomainName\UserName found 0 errors and repaired 0 errors. Elapsed time: 0 hours 3 minutes 19 seconds.
2022-09-01 17:36:31.90 spid53 Error: 17053, Severity: 16, State: 1.
2022-09-01 17:36:31.90 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2022-09-01 17:36:31.90 spid53 Error: 17053, Severity: 16, State: 1.
2022-09-01 17:36:31.90 spid53 E:\SQLData\ProductionData.mdf:MSSQL_DBCC11: Operating system error 112(There is not enough space on the disk.) encountered.
2022-09-01 17:36:32.30 spid54 Error: 926, Severity: 21, State: 6.
2022-09-01 17:36:32.30 spid54 Database 'ProductionData' cannot be opened. It has been marked SUSPECT by recovery. See the SQL Server errorlog for more information.
```

In some cases, you may receive the following error message:

```output
Msg 5128, Level 17, State 2, Line 6
Write to sparse file `E:\CreateFile\ProductionData.mdf:MSSQL_DBCC11` failed due to lack of disk space.
```

In these cases, the client application that runs the `DBCC` commands may show the following entries in the application result set:

```output
DBCC results for 'ProductionData'.
CHECKDB found 0 allocation errors and 0 consistency errors in database 'ProductionData'.
Msg 926, Level 21, State 6, Line 1
Database 'ProductionData' cannot be opened. It has been marked SUSPECT by recovery. See the SQL Server errorlog for more information.
Msg 0, Level 20, State 0, Line 0
A severe error occurred on the current command. The results, if any, should be discarded.
```

If the internal database snapshot that the `DBCC` commands use couldn't be created at all, you receive the following errors in the client application that issues the `DBCC` commands:

```output
Msg 1823, Level 16, State 1, Line 1
A database snapshot cannot be created because it failed to start.

Msg 7928, Level 16, State 1, Line 1
The database snapshot for online checks could not be created. Either the reason is given in a previous error or one of the underlying volumes does not support sparse files or alternate streams. Attempting to get exclusive access to run checks offline.

Msg 5030, Level 16, State 12, Line 1
The database could not be exclusively locked to perform the operation.

Msg 7926, Level 16, State 1, Line 1
Check statement aborted. The database could not be checked as a database snapshot could not be created and the database or table could not be locked. See Books Online for details of when this behavior is expected and what workarounds exist. Also see previous errors for more details.

Msg 5106, Level 17, State 2, Line 1
Write to sparse file 'E:\Data\LogFUllTest_Data.mdf:MSSQL_DBCC10' failed due to lack of disk space.
```

### OS error 665 - file system limitation, OS error 1450 -insufficient system resources

If the internal database snapshot runs into 1450 or 665 errors, here's a typical sequence you may notice in the SQL Server error log:

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
2008-05-21 13:36:48.37 spid500 DBCC CHECKDB (MYDATABASE) executed by DomainName\UserName found 0 errors and repaired 0 errors. Elapsed time: 0 hours 33 minutes 16 seconds. Internal database snapshot has split point LSN = 0000759c:002547bc:0040 and first LSN = 0000759c:0023696d:0049. This is an informational message only. No user action is required.
```

### More information

- These error messages are from different active sessions (SPIDs). `SPID 54` is the session ID that executes the `DBCC` command. `SPID 53` is the session ID that executes a user transaction.
- These error messages indicate rolling forward transactions and rolling back transactions. The messages are generated during the initial phase of the `DBCC` command execution. When you run a `DBCC` command, the `DBCC` command first tries to create an internal snapshot. When the snapshot is created, database recovery is performed against this snapshot to bring the snapshot into a consistent state. The error messages reflect this activity.
- The internal database snapshot uses the same name as the actual database. Therefore, these error messages contain the name of the database.
- Even though the error log message indicates that `DBCC CHECKDB` completed, it should be regarded as an abnormal termination. You should rerun the `DBCC CHECKDB` command to allow it to run until it's completed to assess the consistency of the database. In these situations, refer to the output from the `DBCC CHECKDB` command sent back to the client to understand which objects were checked and reported clean.

## Cause

In SQL Server, `DBCC` commands use internal read-only database snapshots. For more information, see [How DBCC CHECKDB creates an internal snapshot database beginning with SQL Server 2014](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#how-dbcc-checkdb-creates-an-internal-snapshot-database-beginning-with-sql-server-2014). These database snapshots are created on the same drive where the corresponding database data files are located. Database snapshots grow in proportion to data changes in the database where `DBCC` commands run. If transactional activity continues in the user database, the internal database snapshots created by `DBCC` commands may continue to grow and may encounter disk space issues. See [Disk Space Requirements for Database Snapshots](/sql/relational-databases/databases/database-snapshots-sql-server#DiskSpace). Because the database snapshot files and the actual data files reside on the same disk drive, both sets of files compete for disk space. In this case, application transactions or user transactions are given preference. The internal database snapshot used by `DBCC` is marked as suspect. Therefore, the `DBCC` commands produce errors and can't complete.

Writes to the internal database snapshot may fail due to insufficient disk space. Other issues, such as OS error 665, can also lead to similar problems and render the internal database snapshot to a suspect state.

## Resolution

Use the resolution section that corresponds to one of the issues you may have countered:

### OS error 112

To resolve OS error 112 that's raised inside SQL Server error 17053, use one or more of these alternatives:

- Free disk space on the drive where the database resides so that `DBCC CHECKDB` can create a database snapshot.
- Run `DBCC CHECKDB` [WITH TABLOCK](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#tablock) to prevent the creation of an internal snapshot.
- Use a replication technology such as Availability Groups, Log Shipping, Backup/Restore or SQL Server Replication and create a copy of the database on another server. Then run the `DBCC CHECKDB` command on that server.

### OS errors 665 and 1450

To resolve OS errors 665 or 1450 raised inside error 17053, use one or more of the solutions provided in [OS errors 665 and 1450 are reported for SQL Server files](1450-and-665-errors-running-dbcc-checkdb.md#resolution).
