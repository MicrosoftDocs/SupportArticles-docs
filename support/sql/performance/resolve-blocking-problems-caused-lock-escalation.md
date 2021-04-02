---
title: Resolve blocking problem caused by lock escalation
description: This article describes how to determine whether lock escalation is causing blocking and how to deal with undesirable lock escalation.
ms.date: 11/18/2020
ms.prod-support-area-path: Performance
ms.reviewer: BARTD
ms.topic: how-to
ms.prod: sql
---
# Resolve blocking problems that are caused by lock escalation in SQL Server

## Summary

Lock escalation is the process of converting many fine-grained locks (such as row or page locks) into table locks. Microsoft SQL Server dynamically determines when to perform lock escalation. When making this decision, SQL Server considers the number of locks that are held on a particular scan, the number of locks that are held by the whole transaction, and the memory that is being used for locks in the system as a whole. Typically, SQL Server's default behavior results in lock escalation occurring only at those points where it would improve performance or when you must reduce excessive system lock memory to a more reasonable level. However, some application or query designs may trigger lock escalation at a time when it is not desirable, and the escalated table lock may block other users. This article discusses how to determine whether lock escalation is causing blocking and how to deal with undesirable lock escalation.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 323630

## Determine whether lock escalation is causing blocking

Lock escalation does not cause most blocking problems. To determine whether lock escalation is occurring around the time when you experience blocking issues, start a SQL Profiler trace that includes the `Lock:Escalation` event. If you do not see any `Lock:Escalation` events, lock escalation is not occurring on your server and the information in this article does not apply to your situation.

If lock escalation is occurring, verify that the escalated table lock is blocking other users.

For more information about how to identify the head blocker and how to identify the lock resource held by the head blocker that is blocking other server process IDs (SPIDs), see [INF: Understanding and resolving SQL Server blocking problems](https://support.microsoft.com/help/224453).

If the lock that is blocking other users is anything other than a TAB (table-level) lock with a lock mode of S (shared), or X (exclusive), lock escalation is not the issue. In particular, if the TAB lock is an intent lock (such as a lock mode of IS, IU, or IX), this is not the result of lock escalation. If your blocking problems are not being caused by lock escalation, see [INF: Understanding and resolving SQL Server blocking problems](https://support.microsoft.com/help/224453) troubleshooting steps.

## Prevent lock escalation

The simplest and safest way to prevent lock escalation is to keep transactions short and to reduce the lock footprint of expensive queries so that the lock escalation thresholds are not exceeded. There are several ways to obtain this goal, many of which are listed:

- Break up large batch operations into several smaller operations. For example, suppose you ran the following query to remove several hundred thousand old records from an audit table, and then you found that it caused a lock escalation that blocked other users:

    ```sql
    DELETE FROM LogMessages WHERE LogDate < '2/1/2002'
    ```

  By removing these records a few hundred at a time, you can dramatically reduce the number of locks that accumulate per transaction and prevent lock escalation. For example:

    ```sql
    SET ROWCOUNT 500
    delete_more:
    DELETE FROM LogMessages WHERE LogDate < '2/1/2002'
    IF @@ROWCOUNT > 0 GOTO delete_more
    SET ROWCOUNT 0
    ```

- Reduce the query's lock footprint by making the query as efficient as possible. Large scans or large numbers of Bookmark Lookups may increase the chance of lock escalation; additionally, it increases the chance of deadlocks, and adversely affects concurrency and performance. After you find the query that causes lock escalation, look for opportunities to create new indexes or to add columns to an existing index to remove index or table scans and to maximize the efficiency of index seeks. Consider pasting the query into a Query Analyzer query window to perform an automatic index analysis on it. To do so, on the Query menu, click Index Tuning Wizard in SQL Server 2000, or click Perform Index Analysis in SQL Server 7.0.

  One goal of this optimization is to make index seeks return as few rows as possible to minimize the cost of Bookmark Lookups (maximize the selectivity of the index for the query). If SQL Server estimates that a Bookmark Lookup logical operator may return many rows, it may use a `PREFETCH` to perform the bookmark lookup. If SQL Server does use `PREFETCH` for a bookmark lookup, it must increase the transaction isolation level of a portion of the query to repeatable read for a portion of the query. This means that what may look like a `SELECT` statement at a read-committed isolation level may acquire many thousands of key locks (on both the clustered index and one nonclustered index), which can cause such a query to exceed the lock escalation thresholds. This is especially important if you find that the escalated lock is a shared table lock, which, however, is not commonly seen at the default read-committed isolation level. If a Bookmark Lookup WITH `PREFETCH` clause is causing the escalation, consider adding additional columns to the nonclustered index that appears in the Index Seek or the Index Scan logical operator below the Bookmark Lookup logical operator in the query plan. It may be possible to create a covering index (an index that includes all columns in a table that were used in the query), or at least an index that covers the columns that were used for join criteria or in the WHERE clause if including everything in the select column list is impractical.

  A Nested Loop join may also use `PREFETCH`, and this causes the same locking behavior.

- Lock escalation cannot occur if a different SPID is currently holding an incompatible table lock. Lock escalation always escalates to a table lock, and never to page locks. Additionally, if a lock escalation attempt fails because another SPID holds an incompatible TAB lock, the query that attempted escalation does not block while waiting for a TAB lock. Instead, it continues to acquire locks at its original, more granular level (row, key, or page), periodically making additional escalation attempts. Therefore, one method to prevent lock escalation on a particular table is to acquire and to hold a lock on a different connection that is not compatible with the escalated lock type. An IX (intent exclusive) lock at the table level does not lock any rows or pages, but it is still not compatible with an escalated S (shared) or X (exclusive) TAB lock. For example, assume that you must run a batch job that modifies many rows in the mytable table and that has caused blocking that occurs because of lock escalation. If this job always completes in less than an hour, you might create a Transact-SQL job that contains the following code, and schedule the new job to start several minutes before the batch job's start time:

    ```sql
    BEGIN TRAN
    SELECT * FROM mytable (UPDLOCK, HOLDLOCK) WHERE 1=0
    WAITFOR DELAY '1:00:00'
    COMMIT TRAN
    ```

  This query acquires and holds an IX lock on mytable for one hour, which prevents lock escalation on the table during that time. This batch does not modify any data or block other queries (unless the other query forces a table lock with the TABLOCK hint or if an administrator has disabled page or row locks by using an `sp_indexoption` stored procedure).

## Disable Lock Escalation 

Disabling lock escalation is possible in SQL Server but is not the recommended method. Use the prevention strategies described in the Prevent Lock Escalation section, instead. 
- **Table level:** You can disable lock escalation at the table level. See [`ALTER TABLE ... SET (LOCK_ESCALATION = DISABLE)`](https://docs.microsoft.com/sql/t-sql/statements/alter-table-transact-sql). To determine which table to target, examine the T-SQL queries. If that is not possible, use [Extended events](https://docs.microsoft.com/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server), enable _lock_escalation_ event and examine the _object_id_ column. Alternatively use the [Lock:Escalation event](https://docs.microsoft.com/sql/relational-databases/event-classes/lock-escalation-event-class) and examine the ObjectID2 column with SQL Profiler.
- **Server Level:** You can disable lock escalation by enabling trace flag 1211 at the server. However, this trace flag disables all lock escalation globally in the instance of SQL Server. Lock escalation serves a useful purpose in SQL Server by maximizing the efficiency of queries that are otherwise slowed down by the overhead of acquiring and releasing several thousands of locks. Lock escalation also helps to minimize the required memory to keep track of locks. The memory that SQL Server can dynamically allocate for lock structures is finite, so if you disable lock escalation and the lock memory grows large enough, attempts to allocate additional locks for any query may fail and the following error occurs:

> Error: 1204, Severity: 19, State: 1  
The SQL Server cannot obtain a LOCK resource at this time. Rerun your statement when there are fewer active users or ask the system administrator to check the SQL Server lock and memory configuration.

> [!NOTE]
> When a 1204 error occurs, it stops the processing of the current statement and causes a rollback of the active transaction. The rollback itself may block users or lead to a long database recovery time if you restart the SQL Server service. 
You can add this trace flag (-T1211), using [SQL Server Configuration Manager](/sql/database-engine/configure-windows/scm-services-configure-server-startup-options).  You must restart the SQL Server service for a new startup parameter to take effect. If you run the query `DBCC TRACEON (1211, -1)` the trace flag takes effect immediately.  
> However, if you do not add the -T1211 startup parameter, the effect of a `DBCC TRACEON` command is lost when the SQL Server service is restarted. Turning on the trace flag prevents any future lock escalations, but it does not reverse any lock escalations that have already occurred in an active transaction.

Using a lock hint such as ROWLOCK only alters the initial lock plan. Lock hints do not prevent lock escalation.

## Lock Escalation Thresholds

Lock escalation may occur under one of two conditions:
1. **Memory threshold is reached** A  memory threshold of 40% of lock memory is reached. When lock memory exceeds 24% of buffer pool a lock escalation may be triggered. Lock memory is limited to 60% of visible buffer pool. Lock escalation threshold is set at 40% of the lock memory, which is 40% of 60% of the buffer pool, which is 24%. If lock memory exceeds the 60% limit (this is much more likely if lock escalation is disabled), all attempts to allocate additional locks fail and `1204` errors are generated.

1. **A lock threshold is reached** After memory threshold is checked, the number of locks acquired on the current object is assessed. If the number has exceeded 5000, a lock escalation is triggered.

To understand which threshold was reached, use Extended events, enable the  _lock_escalation_ event and examine the _escalated_lock_count_ and _escalation_cause_  columns. Alternatively, use the [Lock:Escalation event](https://docs.microsoft.com/sql/relational-databases/event-classes/lock-escalation-event-class) and examine the EventSubClass, where 0 - LOCK_THRESHOLD indicates the statement exceeded the lock threshold and 1 - MEMORY_THRESHOLD indicates the statement exceeded the memory threshold. Also examine IntegerData and IntegerData2 columns.

## Recommmednations:
The methods that are discussed in the Preventing Lock Escalation section are better options than disabling escalation at table or server level. Additionally, the preventive methods generally result in better performance for the query than disabling lock escalation. Microsoft recommends enabling this trace flag only to mitigate severe blocking that is caused by lock escalation while other options, such as those discussed earlier in this article, are being investigated. To enable a trace flag so that it is turned on whenever SQL Server is started, add it as a server startup parameter.
