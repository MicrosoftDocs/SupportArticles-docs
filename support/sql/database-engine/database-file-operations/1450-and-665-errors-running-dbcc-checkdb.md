---
title: Operating System errors 665 and 1450 are reported for database files
description: This article provides resolutions for the problem where OS errors 1450 and 665 are reported for SQL Server database files.
author: PiJoCoder 
ms.author: jopilov
ms.date: 12/12/2022
ms.reviewer: v-jayaramanp
ms.custom: sap:Administration and Management
---

# OS errors 665 and 1450 are reported for SQL Server files

This article helps you resolve the problem where OS errors 1450 and 665 are reported for database files while executing `DBCC CHECKDB`, creating a Database Snapshot, or file growth.

_Original product version:_ &nbsp; SQL Server   
_Original KB number:_ &nbsp; 2002606

## Symptoms

Assume that you perform one of the following actions on a computer that's running SQL Server:

- You create a database snapshot on a large database. Then, you perform numerous data modification or maintenance operations in the source database.
- You create a database snapshot on a mirror database.
- You execute the `DBCC CHECKDB` family of commands to check the consistency of a large database, and you also perform a large number of data changes in that database.

> [!NOTE]
> SQL Server uses [sparse files](/windows/win32/fileio/sparse-files) for these operations: database snapshot and `DBCC CHECKDB`.

- Backup or restore of databases.
- You perform bulk copy via [BCP](/sql/tools/bcp-utility) to multiple files using parallel BCP executions and writing to the same volume.

As a result of these operations, you might notice one or more of these errors reported in the SQL Server Error log depending on the environment SQL Server is running on.

```output
The operating system returned error 665(The requested operation could not be completed due to a file system limitation) to SQL Server during a write at offset 0x00002a3ef96000 in file 'Sam.mdf:MSSQL_DBCC18'
```

```output
The operating system returned error 1450 (Insufficient system resources exist to complete the requested service.) to SQL Server during a write at offset 0x00002a3ef96000 in file with handle 0x0000000000000D5C. This is usually a temporary condition and the SQL Server will keep retrying the operation. If the condition persists, then immediate action must be taken to correct it.`
```

In addition to these errors, you may also notice the following Latch Timeout errors:

```output
Timeout occurred while waiting for latch: class *'DBCC_MULTIOBJECT_SCANNER'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  
```

```output
Timeout occurred while waiting for latch: class *'ACCESS_METHODS_HOBT_COUNT'*, id 000000002C61DF40, type 4, Task 0x00000000038089B8 : 16, waittime 600, flags 0x1a, owning task 0x0000000006A09828. Continuing to wait.  
```

Additionally, you might also notice blocking when you view various dynamic management views (DMV), such as `sys.dm_exec_requests` and `sys.dm_os_waiting_tasks`.

In rare cases, you may observe a non-yielding scheduler issue reported in the SQL Server error log and that SQL Server generates a memory dump.

## Cause

This problem occurs if a large number of `ATTRIBUTE_LIST_ENTRY` instances are needed to maintain a heavily fragmented file in NTFS. If the space is next to a cluster that's already tracked by the file system, then the attributes are compressed into a single entry. However, if the space is fragmented, it has to be tracked with multiple attributes. Thus, heavy file fragmentation can lead to attribute exhaustion and the resulting 665 error. This behavior is explained in the following KB article: [A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351).

Both regular and sparse files created by SQL Server or other applications can get fragmented to these levels when large amounts of data modifications happen for the life of these snapshot files.

If you perform database backups across a stripe set of files all located on the same volume, or if you're bulk copying (BCP-ing) data out to multiple files on the same volume, the writes may end up in adjacent locations but belonging to different files. For example, one stream writes to offset between 201 and 400, the other stream writes from 401 to 600, the third stream can write from 601 to 800. This process continues for other streams as well. This will lead to file fragmentation on the same physical media. Each of the backup files or BCP output streams can exhaust the attribute storage as none of them get adjacent storage.

For a complete background of how SQL Server Engine uses NTFS sparse files and alternate data streams, see [More information](#more-information).

## Resolution

Consider using one or more of the following options to resolve this issue:

1. Place the database files on a [Resilient File System (ReFS)](/windows-server/storage/refs/refs-overview) volume, which doesn't have the same `ATTRIBUTE_LIST_ENTRY` limits that [NTFS](/windows-server/storage/file-server/ntfs-overview) presents. If you want to use the current NTFS volume, you must reformat using ReFS after moving your database files elsewhere temporarily. Using ReFS is the best long-term solution to deal with this issue.

   > [!NOTE]
   > SQL Server 2012 and earlier versions used named [file streams](/windows/win32/fileio/file-streams) instead of sparse files to create `CHECKDB` snapshots. ReFS doesn't support file streams. Running `DBCC CHECKDB` on SQL Server 2012 files in ReFS might result in errors. For more information, see the note in [How DBCC CHECKDB creates an internal snapshot database beginning with SQL Server 2014](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#how-dbcc-checkdb-creates-an-internal-snapshot-database-beginning-with-sql-server-2014).

1. De-fragment the volume where the database files reside. Be sure your defragmentation utility is transactional. For more information on defragmenting drives where SQL Server files reside, see [Precautions when you defragment SQL Server database drives and Recommendations](defragmenting-database-disk-drives.md). You must shut down SQL Server to perform this operation on the files. We recommend that you create full database backups before you defragment the files as a safety measure. Defragmentation works differently on solid-state drives (SSD) media and typically doesn't address the problem. Copying the file(s) and allowing the SSD firmware to repack the physical storage is often a better solution. For more information, see [Operating System Error (665 - File System Limitation) Not just for DBCC Anymore](/archive/blogs/psssql/operating-system-error-665-file-system-limitation-not-just-for-dbcc-anymore).

1. File copy - performing a copy of the file may allow better space acquisition because the bytes might be tightly packed together in the process. Copying the file (or moving it to a different volume) may reduce attribute usage and may prevent the OS error 665. Copy one or more of the database files to another drive. Then, you may leave the file on the new volume or copy it back to the original volume.

1. Format the NTFS volume by using the **/L** option to obtain a large FRS. This choice may provide relief to this problem because it makes the `ATTRIBUTE_LIST_ENTRY` larger. This choice might not be helpful when using `DBCC CHECKDB` because the latter creates a sparse file for the database snapshot.

    > [!NOTE]
    > For systems running Windows Server 2008 R2 and Vista, you first need to apply the hotfix from the [KB article 967351](https://support.microsoft.com/topic/a-heavily-fragmented-file-in-an-ntfs-volume-may-not-grow-beyond-a-certain-size-da1c0dfd-a5a1-90b4-4bf7-b65b13ef9d35) before using the `/L` option with the `format` command.

1. Break up a large database into smaller files. For example, if you have one 8-TB data file, you can break it up into eight 1-TB data files. This option might help because fewer modifications would happen on smaller files, thus less likely to introduce attribute exhaustion. Also, in the process of moving data around, the files will be organized compactly and fragmentation would be reduced. The following are high-level steps, which outline the process:
   1. Add the seven new 1-TB files to the same file group.
   1. Rebuild the clustered indexes of the existing tables, which will automatically spread the data of each table among the eight files. If a table doesn't have a clustered index, then create one and drop it to accomplish the same.
   1. Shrink the original 8-TB file, which is now about 12% full.

1. Database Auto-grow setting: Adjust the auto [growth increment](/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options#:~:text=to%20FILESTREAM%20filegroups.-,growth_increment%20Is,-the%20amount%20of) database setting to acquire sizes conducive to production performance and packing of NTFS attributes. The less frequent the auto growth occurrences and the larger the growth increment size, the less likely the possibility of file fragmentation.

1. Reduce the lifetime of `DBCC CHECK` commands using the performance enhancements and thus avoid the 665 errors: [Improvements for the DBCC CHECKDB command may result in faster performance when you use the PHYSICAL_ONLY option](https://support.microsoft.com/kb/2634571). Keep in mind that running `DBCC CHECKDB` with `PHYSICAL_ONLY` switch doesn't provide a guarantee that you'll avoid this error, but it will reduce the likelihood in many cases.

1. If you're performing database backups across many files (stripe set), carefully plan the  number of files, `MAXTRANSFERSIZE` and `BLOCKSIZE` (see [BACKUP](/sql/t-sql/statements/backup-transact-sql)). The goal is to reduce the fragments on the file system which is generally accomplished by writing the larger byte chunks together to a file. You might consider striping the files across multiple volumes for faster performance and reduction of fragmentation.

1. If you're using BCP to write multiple files simultaneously, adjust utility write sizes, for example increase the BCP [batch size](/sql/tools/bcp-utility). Also, consider writing multiple streams to different volumes to avoid fragmentation, or reduce the number of parallel writes.

1. To execute `DBCC CHECKDB`, you can consider setting up an Availability Group or Log Shipping/Standby server. Or use a second server where you can run the `DBCC CHECKDB` commands to offload the work and avoid running into the issues caused by the heavy fragmentation of sparse files.

1. When you execute `DBCC CHECKDB`, if you run the command at a time when there's little activity on the database server, then the sparse files will be lightly populated. The fewer writes to the files will reduce the likelihood of exhausting attributes on the NTFS. Less activity is another reason to run `DBCC CHECKDB` on a second read-only server, when possible.

1. If you're running SQL Server 2014, upgrade to the latest Service Pack. For more information, see [FIX: OS error 665 when you execute DBCC CHECKDB command for database that contains columnstore index in SQL Server 2014](https://support.microsoft.com/kb/3029977/EN-US).

## More information

- [How It Works: SQL Server 2005 Database Snapshots (Replica)](/archive/blogs/psssql/how-it-works-sql-server-2005-database-snapshots-replica)
- [SQL Server reports operating system error 1450 or 1452 or 665 (retries)](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-reports-operating-system-error-1450-or-1452-or-665/ba-p/315507)
- [How It Works: SQL Server Sparse Files (DBCC and Snapshot Databases) Revisited](/archive/blogs/psssql/how-it-works-sql-server-sparse-files-dbcc-and-snapshot-databases-revisited)
- [How Database Snapshots Work](/sql/relational-databases/databases/database-snapshots-sql-server)
- [DBCC CHECKDB (Transact-SQL) [See "Internal Database Snapshot" section]](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql)
- [New extended event to track writes to the snapshot sparse file](/archive/blogs/psssql/new-extended-event-to-track-writes-to-the-snapshot-sparse-file)
- [Sparse File Errors: 1450 or 665 due to file fragmentation: Fixes and Workarounds](/archive/blogs/psssql/sparse-file-errors-1450-or-665-due-to-file-fragmentation-fixes-and-workarounds)
