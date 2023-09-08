---
title: SQL Server diagnostics detects unreported I/O problems
description: This article helps you resolve the errors 605, 823, 3448, and 3456 using the SQL Server Diagnostics.
ms.date: 01/16/2023
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni1, v-jayaramanp
---

# SQL Server diagnostics detects unreported I/O problems due to stale reads or lost writes

This article explains how SQL Server Diagnostics helps detect unreported input or output problems that occur due to stale reads or lost writes.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 826433

## Symptoms

If operating system, driver, or hardware problems cause lost write or stale read conditions in the I/O path, you may see data integrity-related error messages such as errors 605, 823, 3448, and 3456 in SQL Server. You may receive error messages that are similar to the following examples:

```output
2003-07-24 16:43:04.57 spid63 Getpage: bstat=0x9, sstat=0x800, cache
2003-07-24 16:43:04.57 spid63 pageno is/should be: objid is/should be:
2003-07-24 16:43:04.57 spid63 (1:7040966)/(1:7040966) 2093354622/2039782424
2003-07-24 16:43:04.57 spid63 ... IAM indicates that page is allocated to this object
2003-07-24 16:52:37.67 spid63 Error: 605, Severity: 21, State: 1
2003-07-24 16:52:37.67 spid63 Attempt to fetch logical page (1:7040966) in database 'pubs' belongs to object 'authors', not to object 'titles'..
2003-07-24 16:52:40.99 spid63 Error: 3448, Severity: 21, State: 1
2003-07-24 16:52:40.99 spid63 Could not undo log record (63361:16876:181), for transaction ID (0:159696956), on page (1:7040977), database 'pubs' (database ID 12). Page information: LSN = (63192:958360:10), type = 2. Log information: OpCode = 2, context 1..
2003-07-09 14:31:35.92 spid66 Error: 823, Severity: 24, State: 2
2003-07-09 14:31:35.92 spid66 I/O error (bad page ID) detected during read at offset 0x00000016774000 in file 'h:\sql\MSSQL\data\tempdb.mdf'..
2010-02-06 15:57:24.14 spid17s Error: 3456, Severity: 21, State: 1.
2010-02-06 15:57:24.14 spid17s Could not redo log record (58997:5252:28), for transaction ID (0:109000187), on page (1:480946), database 'MyDatabase' (database ID 17). Page: LSN = (58997:5234:17), type = 3. Log: OpCode = 2, context 5, PrevPageLSN: (58997:5243:17). Restore from a backup of the database, or repair the database.
```

## New I/O diagnostic capabilities in SQL Server

SQL Server introduced new I/O diagnostic capabilities starting with SQL Server 2000 Service Pack 4 and these diagnostics have been part of the product since then. These capabilities are designed to help detect external I/O related problems and to troubleshoot the error messages described in the [Symptoms](#symptoms) section.

If you receive any of the error messages that are listed in the [Symptoms](#symptoms) section and they aren't explained by an event like a physical drive failure, then review any known problems with SQL Server, the operating system, the drivers, and the hardware. The diagnostics try to provide information about the following two conditions:

- *Lost Write*: A successful call to the WriteFile API, but the operating system, a driver, or the caching controller doesn't correctly flush the data to the physical media even though SQL Server is informed that the write was successful.

- *Stale Read*: A successful call to the ReadFile API, but the operating system, a driver, or the caching controller incorrectly returns an older version of the data.

To illustrate, Microsoft has confirmed scenarios where a WriteFile API call returns a status of success, but an immediate, successful read of the same data block returns older data, including data that's likely stored in a hardware read cache. Sometimes, this problem occurs because of a read cache problem. In other cases, the write data is never written to the physical disk.

## How to enable the diagnostics

In SQL Server 2017 and later versions, this diagnostic capability is enabled by default. In SQL Server 2016 and earlier versions these diagnostics can only be enabled by using trace flag 818. You can specify trace flag [818](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf818) as a startup parameter, -T818, for the SQL Server instance, or you can run the following T-SQL statement to enable them at runtime:

```sql
DBCC TRACEON(818, -1)
```

Trace flag 818 enables an in-memory ring buffer that's used for tracking the last 2,048 successful write operations that're performed by the computer running SQL Server, not including sort and workfile I/Os. When errors such as 605, 823, or 3448 occur, the incoming buffer's log sequence number (LSN) value is compared to the recent write list. If the LSN that's retrieved during the read operation is older than the one used in the write operation, a new error message is logged in the SQL Server error log. Most SQL Server write operations occur as checkpoints or as lazy writes (a lazy write is a background task that uses asynchronous I/O). The implementation of the ring buffer is lightweight and the performance effect on the system is negligible.

## Details about the message in the error log

The following message doesn't show any explicit errors from the WriteFile API or the ReadFile API calls that SQL Server. Instead, it shows a logical I/O error that resulted when the LSN was reviewed, and its expected value wasn't correct:

Starting with SQL Server 2005, the error message displayed is:

> SQL Server detected a logical consistency-based I/O error: Stale Read. It occurred during a `<Read/Write>` of page `<PAGEID>` in database ID `<DBID>` at offset `<PHYSICAL OFFSET>` in file `<FILE NAME>`. Additional messages in the SQL Server error log or system event log may provide more detail. This is a severe error condition that threatens database integrity and must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). This error can be caused by many factors. For more information, see SQL Server Books Online.

For more information on error 824, see [MSSQLSERVER_824](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error).

At the point or reporting this error, either the read cache contains an older version of the page, or the data wasn't correctly written to the physical disk. In either case (a lost write or a stale read), SQL Server reports an external problem with the operating system, the driver, or the hardware layers.

If error 3448 occurs when you try to rollback a transaction that has error 605 or 823, the SQL Server instance automatically closes the database and tries to open and recover it. The first page that experiences error 605 or 823 is considered a bad page, and the page ID is kept by the computer running SQL Server. During recovery (before the redo phase) when the bad page ID is read, the primary details about the page header are logged in the SQL Server error log. This action is important because it helps to distinguish between Lost Write and Stale Read scenarios.

## Behavior observed with stale reads and lost writes

You may see the following two common behaviors in stale read scenarios:

- If the database files are closed and then opened, the correct and most recently written data is returned during recovery.

- When you issue a checkpoint and run the `DBCC DROPCLEANBUFFERS` statement (to remove all database pages from the memory), and then run the `DBCC CHECKDB` statement on the database, the most recently written data is returned.

The behaviors mentioned in the preceding paragraph indicate a read caching problem and they're frequently solved by disabling the read cache. The actions that're outlined in the preceding paragraph typically force a cache invalidation and the successful reads that occur show that the physical media is correctly updated. The lost write behavior occurs when the page that's read back is still the older version of the data, even after a forced flush of the caching mechanisms.

Sometimes, the problem may not be specific to a hardware cache. It may be a problem with a filter driver. In such cases, review your software, including backup utilities and antivirus software, and then see if there are problems with the filter driver.

## Description of various stale reads and lost writes scenarios

Microsoft has also noted conditions that don't meet the criteria for error 605 or 823 but are caused by the same stale read or lost write activity. In some instances, a page appears to be updated twice but with the same LSN value. This behavior may occur if the Object ID and the Page ID are correct (page already allocated to the object), and a change is made to the page and flushed to the disk. The next page retrieval returns an older image, and then a second change is made. The SQL Server transaction log shows that the page was updated twice with the same LSN value. This action becomes a problem when you try to restore a transaction log sequence or with data consistency problems, such as foreign key failures or missing data entries. The following error message illustrates one example of this condition:

> Error: 3456, Severity: 21, State: 1 Could not redo log record (276666:1664:19), for transaction ID (0:825853240), on page (1:1787100), database 'authors' (7). Page: LSN = (276658:4501:9), type = 1. Log: OpCode = 4, context 2, PrevPageLSN: (275565:3959:31)..

Some scenarios are outlined in more detail in the following lists:

```output
LSN SequenceAction
1   Checkpoint
2   Begin Transaction
3   Table created or truncated
4   Inserts (Pages allocated)
5   Newly allocated page written to disk by Lazy Writer
6   Select from table - Scans IAM chain, newly allocated page read back from disk (LRU | HASHED = 0x9 in getpage message), encounters Error 605 - Invalid Object ID
7   Rollback of transaction initiated
```

```output
LSN SequenceAction
1   Checkpoint
2   Begin Transaction
3   Page Modification
4   Page written to disk by Lazy Writer
5   Page read in for another modification (stale image returned)
6   Page Modified for a second time but because of stale image does not see first modification 
7   Rollback - Fails - Transaction Log shows two different log records with the same PREV LSN for the page
```

SQL Server `sort` operators perform I/O activities, commonly in the `tempdb` database. These I/O operations are similar to the buffer I/O operations; however, they've already been designed to use read retry logic to try to resolve similar issues. The additional diagnostics explained in this article don't apply to these I/O operations.

Microsoft has noted that the root cause for the following sort read failures is generally a stale read or a lost write:

```output
2003-04-01 20:13:31.38 spid122 SQL Server Assertion: File: <p:\sql\ntdbms\storeng\drs\include\record.inl>, line=1447 Failed Assertion = 'm_SizeRec > 0 && m_SizeRec <= MAXDATAROW'.
2003-03-29 09:51:41.12 spid57 Sort read failure (bad page ID). pageid = (0x1:0x13e9), dbid = 2, file = e:\program files\Microsoft SQL Server\mssql\data\tempdb.mdf. Retrying.
2003-03-29 09:51:41.13 spid57 Error: 823, Severity: 24, State: 7
2003-03-29 09:51:41.13 spid57 I/O error (bad page ID) detected during read at offset 0x000000027d2000 in file 'e:\program files\Microsoft SQL Server\mssql\data\tempdb.mdf'..
* 00931097 Module(sqlservr+00531097) (utassert_fail+000002E3)
* 005B1DA8 Module(sqlservr+001B1DA8) (RecBase::Resize+00000091)
* 00407EE7 Module(sqlservr+00007EE7) (RecBase::LocateColumn+00000012)
* 00852520 Module(sqlservr+00452520) (mergerow+000000A4)
* 008522B3 Module(sqlservr+004522B3) (merge_getnext+00000285)
* 0085207D Module(sqlservr+0045207D) (mergenext+0000000D)
* 004FC5FB Module(sqlservr+000FC5FB) (getsorted+00000021)
```

Because a stale read or a lost write results in data storage that isn't expected, a wide variety of behaviors may occur. It may appear as missing data, but some of the more common effects of missing data appear as index corruptions, such as error 644 or 625:

> Error 644 Severity Level 21 Message Text Could not find the index entry for RID '%.*hs' in index page %S_PGID, index ID %d, database '%.*ls'.

> Error 625 Severity Level 21 Message Text Cannot retrieve row from page %S_PGID by RID because the slotid (%d) is not valid.

Some customers have reported missing rows after they perform row count activities. This problem occurs because of a lost write. Perhaps, the page was supposed to be linked to the clustered index page chain. If the write was physically lost, the data is also lost.

> [!IMPORTANT]
> If you experience any of the behaviors, or if you're suspicious of similar problems together with disabling caching mechanisms, Microsoft strongly recommends that you obtain the latest update for SQL Server. Microsoft also strongly encourages that you perform a strict review of your operating system and its associated configurations.

Note that Microsoft has confirmed that under rare and heavy I/O loads, some hardware platforms can return a stale read. If the extended diagnostics indicate a possible stale read or lost write condition, contact your hardware vendor for immediate follow-up and test with the [SQLIOSim](../../tools/sqliosim-utility-simulate-activity-disk-subsystem.md) utility.

SQL Server requires systems to support guaranteed delivery to stable media as outlined under the [SQL Server I/O Reliability Program Requirements](https://support.microsoft.com/topic/kb826433-sql-server-diagnostics-added-to-detect-unreported-i-o-problems-due-to-stale-reads-or-lost-writes-ca3f00af-2ee2-04e3-e6dc-e09169328982?preview=true). For more information about the input and output requirements for the SQL Server database engine, see [Microsoft SQL Server Database Engine Input/Output Requirements](database-engine-input-output-requirements.md).

