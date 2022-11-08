---
title: OS errors 1450 and 665 are reported
description: This article provides resolutions for the problem where OS errors 1450 and 665 are reported for database files during DBCC CHECKDB or Database Snapshot Creation.
ms.date: 10/01/2022
ms.custom: sap:Administration and Management
ms.prod: sql
---
# OS errors 1450 and 665 are reported for database files during DBCC CHECKDB or Database Snapshot Creation

This article helps you resolve the problem where OS errors 1450 and 665 are reported for database files during `DBCC CHECKDB` or Database Snapshot Creation.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008  
_Original KB number:_ &nbsp; 2002606

## Symptoms

On a SQL Server computer, assume that you perform one of the following actions:

- You create a database snapshot on a large database. After this you perform numerous data modification operations or maintenance operations in the source database.
- You create a database snapshot on a mirror database.
- You execute `DBCC CHECKDB` family of commands to check the consistency of a large database and you also perform a large number of data changes in that database.

In this scenario, you notice the following errors reported in the SQL Server Error log depending on the environment SQL Server is running on.

**Windows Server 2003** 

> The operating system returned error 1450 (Insufficient system resources exist to complete the requested service.) to SQL Server during a write at offset 0x00002a3ef96000 in file with handle 0x0000000000000D5C. This is usually a temporary condition and the SQL Server will keep retrying the operation. If the condition persists, then immediate action must be taken to correct it.

**Windows Server 2008, Windows Vista, and later versions of server and client operating systems** 

> The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00002a3ef96000 in file 'Sam.mdf:MSSQL_DBCC18'

In addition to these errors, you may also notice the following **Latch Timeout** errors:

- > Timeout occurred while waiting for latch: class *'DBCC_MULTIOBJECT_SCANNER'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  

- > Timeout occurred while waiting for latch: class *'ACCESS_METHODS_HOBT_COUNT'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  

Additionally, you may also notice blocking when you view various dynamic management views (DMV) like `sys.dm_exec_requests`, `sys.dm_os_waiting_tasks`, etc.

## Cause

This problem occurs if a large number of `ATTRIBUTE_LIST_ENTRY` instances are needed to maintain a heavily fragmented file in NFTS. This behavior is explained in the following KB article:

[A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)

The sparse files created by SQL Server for the database snapshots can get fragmented to these levels when large amounts of data modifications happen for the life of these snapshot files.

For a complete background of how SQL Server Engine uses NTFS sparse files and alternate data streams, refer to the following links:

- [How It Works: SQL Server 2005 Database Snapshots (Replica)](/archive/blogs/psssql/how-it-works-sql-server-2005-database-snapshots-replica)

- [SQL Server reports operating system error 1450 or 1452 or 665 (retries)](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-reports-operating-system-error-1450-or-1452-or-665/ba-p/315507)

- [How It Works: SQL Server Sparse Files (DBCC and Snapshot Databases) Revisited](/archive/blogs/psssql/how-it-works-sql-server-sparse-files-dbcc-and-snapshot-databases-revisited)

- [How Database Snapshots Work](/sql/relational-databases/databases/database-snapshots-sql-server)

- [DBCC CHECKDB (Transact-SQL) [See "Internal Database Snapshot" section]](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql)

- [New extended event to track writes to the snapshot sparse file](/archive/blogs/psssql/new-extended-event-to-track-writes-to-the-snapshot-sparse-file)  

## Resolution

1. Break up the large database into smaller files. For example, if you have one 8-TB data file you can break it up into eight 1-TB data files. Following are high-level steps to accomplish this:
   1. Add the 7 new 1 TB files to the same file group.
   2. Rebuild the clustered indexes of the existing tables and this will automatically spread the data of each table among the 8 files. If a table doesn't have a clustered index, then create one and then drop it to accomplish the same.
   3. Shrink the original 8 TB file down, now that is about 12-15% full.
2. Consider placing the database files on ReFS volume which doesn't have the same `ATTRIBUTE_LIST_ENTRY` limits that NTFS presents. You must reformat the current NTFS volume using ReFS.
3. Consider defragmenting the volume where the database files reside. For more information, see [Operating System Error (665 - File System Limitation) Not just for DBCC Anymore](/archive/blogs/psssql/operating-system-error-665-file-system-limitation-not-just-for-dbcc-anymore).
4. Format the volume by using the **/L** option to obtain large FRS.

    > [!NOTE]
    > For systems running Windows Server 2008 R2 and Vista, you first need to apply the hotfix from the KB article 967351 before using the `/L` option with format command.

5. [FIX: OS error 665 when you execute DBCC CHECKDB command for database that contains columnstore index in SQL Server 2014](https://support.microsoft.com/kb/3029977/EN-US)

6. Reduce the lifetime of `DBCC CHECK` commands by using the performance enhancements and consequently avoid the 665 errors: [Improvements for the DBCC CHECKDB command may result in faster performance when you use the PHYSICAL_ONLY option](https://support.microsoft.com/kb/2634571)

Under certain conditions, you might still encounter the previously mentioned errors even after applying these fixes. In that scenario, you can evaluate some of the workarounds discussed in the following blog post:

[Sparse File Errors: 1450 or 665 due to file fragmentation: Fixes and Workarounds](/archive/blogs/psssql/sparse-file-errors-1450-or-665-due-to-file-fragmentation-fixes-and-workarounds)

For more information, see [DBCC CHECKDB behavior when the SQL Server database is located on an ReFS volume](https://support.microsoft.com/kb/2974455).
