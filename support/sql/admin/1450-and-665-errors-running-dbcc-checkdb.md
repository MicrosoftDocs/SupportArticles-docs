---
title: OS errors 1450 and 665 are reported
description: This article provides resolutions for the problem where OS errors 1450 and 665 are reported for database files 
ms.date: 10/01/2022
ms.custom: sap:Administration and Management
ms.prod: sql
---
# OS errors 1450 and 665 are reported for database files


_Original product version:_ &nbsp; SQL Server 2008 - 2022
_Original KB number:_ &nbsp; 2002606

This article helps you resolve the problem where OS errors 1450 and 665 are reported for database files during `DBCC CHECKDB` or Database Snapshot Creation, or file growth.


## Symptoms

On a SQL Server computer, assume that you perform one of the following actions:

- **Sparse database files**

  - You create a database snapshot on a large database. Then you perform numerous data modification operations or maintenance operations in the source database.
  - You create a database snapshot on a mirror database.
  - You execute `DBCC CHECKDB` family of commands to check the consistency of a large database and you also perform a large number of data changes in that database.

  SQL Server uses [sparse files](/windows/win32/fileio/sparse-files) for these operations: database snapshot and DBCC CHECKDB

- **Regular files**

  - Backup or restore of databases
  - You BCP of data out to multiple file using parallel BCP executions and writing to the same location. Since the output location is shared, as each copy of BCP writes data to a file, the writes may leap frog each other on the same physical media leading to fragmentation. Each of the BCP output streams can  exhaust the attribute storage as none of them were acquiring adjacent storage.



As a result of these operations you may notice  one or more of these errors reported in the SQL Server Error log depending on the environment SQL Server is running on.

```output
The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00002a3ef96000 in file 'Sam.mdf:MSSQL_DBCC18'
```

```output
The operating system returned error 1450 (Insufficient system resources exist to complete the requested service.) to SQL Server during a write at offset 0x00002a3ef96000 in file with handle 0x0000000000000D5C. This is usually a temporary condition and the SQL Server will keep retrying the operation. If the condition persists, then immediate action must be taken to correct it.
```

In addition to these errors, you may also notice the following **Latch Timeout** errors:

```output
Timeout occurred while waiting for latch: class *'DBCC_MULTIOBJECT_SCANNER'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  
```

```output
Timeout occurred while waiting for latch: class *'ACCESS_METHODS_HOBT_COUNT'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  
```

Additionally, you may also notice blocking when you view various dynamic management views (DMV) like `sys.dm_exec_requests`, `sys.dm_os_waiting_tasks`, etc.

## Cause

This problem occurs if a large number of `ATTRIBUTE_LIST_ENTRY` instances are needed to maintain a heavily fragmented file in NFTS.   If the space is next to a cluster that is already tracked by the file system, then the attributes are compressed into a single entry.  However, if the space is fragmented, it has to be tracked with multiple attributes. Thus, heavy file fragmentation can lead to attribute exhaustion and the resulting 665 error. This behavior is explained in the following KB article: [A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)

The sparse files created by SQL Server for the database snapshots can get fragmented to these levels when large amounts of data modifications happen for the life of these snapshot files.

For a complete background of how SQL Server Engine uses NTFS sparse files and alternate data streams, refer to the [Usage of sparse files section](#usage-of-sparse-files-in-sql-server-databases).

Regular database files may also be affected by heavy fragmentation.

## Resolution

1. Break up the large database into smaller files. For example, if you have one 8-TB data file you can break it up into eight 1-TB data files. The following are high-level steps outline the process:
   1. Add the seven new 1-TB files to the same file group.
   1. Rebuild the clustered indexes of the existing tables and this will automatically spread the data of each table among the eight files. If a table doesn't have a clustered index, then create one and then drop it to accomplish the same.
   1. Shrink the original 8-TB file down, now that is about 12-15% full.
1. Place the database files on an [Resilient File System (ReFS)](/windows-server/storage/refs/refs-overview) volume, which doesn't have the same `ATTRIBUTE_LIST_ENTRY` limits that NTFS presents. You must reformat the current NTFS volume using ReFS. Using ReFS may be the best long-term solution to deal with this issue. 

   > [!NOTE]
   > SQL Server 2012 and earlier versions used named [file streams](/windows/win32/fileio/file-streams) instead of sparce files to create CHECKDB snapshots. ReFS does not support file streams. Running DBCC CHECKDB on SQL Server 2012 files placed on ReFS may result in errors. For more information, see the Note in How (DBCC CHECKDB creates an internal snapshot database beginning with SQL Server 2014](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#how-dbcc-checkdb-creates-an-internal-snapshot-database-beginning-with-sql-server-2014)

1. Defragment the volume where the database files reside.  Be sure your defragmentation utility is transactional; see [Precautions when you defragment SQL Server database drives and Recommendations](defragmenting-database-disk-drives.md). You must shut SQL Server down to perform this operation on the files. Defragmentation works differently on SSD media and typically doesn't address the problem. Copying the file(s) and allowing the SSD firmware to repack the physical storage is often a better solution. For more information, see [Operating System Error (665 - File System Limitation) Not just for DBCC Anymore](/archive/blogs/psssql/operating-system-error-665-file-system-limitation-not-just-for-dbcc-anymore).

1. File copy - performing a copy of the file may allow better space acquisition because the bytes may be tightly packed together in the process. Copying the file may reduce attribute usage and may prevent the OS error 665.

1. Adjust the auto [growth increment](/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options?view=sql-server-ver15#:~:text=to%20FILESTREAM%20filegroups.-,growth_increment%20Is,-the%20amount%20of) database setting to acquire sizes conducive for production performance and packing of NTFS attributes. The less frequent the auto growths occurrences and the larger the growth increment size, the less likely is the possibility of file fragmentation.

1. Format the NTFS volume by using the **/L** option to obtain large FRS. This may provide relief of this problem because it makes the ATTRIBUTE_LIST_ENTRY larger. This may not be helpful when using DBCC CHECKDB because the latter creates a sparse file for the database snapshot.

    > [!NOTE]
    > For systems running Windows Server 2008 R2 and Vista, you first need to apply the hotfix from the [KB article 967351](https://support.microsoft.com/topic/a-heavily-fragmented-file-in-an-ntfs-volume-may-not-grow-beyond-a-certain-size-da1c0dfd-a5a1-90b4-4bf7-b65b13ef9d35) before using the `/L` option with format command.

1. [FIX: OS error 665 when you execute DBCC CHECKDB command for database that contains columnstore index in SQL Server 2014](https://support.microsoft.com/kb/3029977/EN-US)

1. Reduce the lifetime of `DBCC CHECK` commands by using the performance enhancements and thus avoid the 665 errors: [Improvements for the DBCC CHECKDB command may result in faster performance when you use the PHYSICAL_ONLY option](https://support.microsoft.com/kb/2634571). Keep in mind that running DBCC CHECKDB with PHYSICAL_ONLY switch doesn't provide a guarantee that you'll avoid this error, but it may do so in many cases.

1. If you're performing database backups across many files (stripe set), carefully plan number of files, MAXTRANSFERSIZE and BLOCKSIZE (see [BACKUP](/sql/t-sql/statements/backup-transact-sql)). The goal is to reduce the fragments on the file system. You may consider striping the files across multiple volumes for faster performance and reduction of fragmentation.

1. If you're using BCP to write multiple files simultaneously, adjust utility write sizes, for example increase the BCP batch size. Also if consider writing multiple streams to different volumes to avoid fragmentation, or reduce the number of parallel writes.

## More information: 

### Usage of sparse files in SQL Server databases

- [How It Works: SQL Server 2005 Database Snapshots (Replica)](/archive/blogs/psssql/how-it-works-sql-server-2005-database-snapshots-replica)

- [SQL Server reports operating system error 1450 or 1452 or 665 (retries)](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-reports-operating-system-error-1450-or-1452-or-665/ba-p/315507)

- [How It Works: SQL Server Sparse Files (DBCC and Snapshot Databases) Revisited](/archive/blogs/psssql/how-it-works-sql-server-sparse-files-dbcc-and-snapshot-databases-revisited)

- [How Database Snapshots Work](/sql/relational-databases/databases/database-snapshots-sql-server)

- [DBCC CHECKDB (Transact-SQL) [See "Internal Database Snapshot" section]](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql)

- [New extended event to track writes to the snapshot sparse file](/archive/blogs/psssql/new-extended-event-to-track-writes-to-the-snapshot-sparse-file)  


### How to deal with OS error 665 when it affects database files


- [Sparse File Errors: 1450 or 665 due to file fragmentation: Fixes and Workarounds](/archive/blogs/psssql/sparse-file-errors-1450-or-665-due-to-file-fragmentation-fixes-and-workarounds)


