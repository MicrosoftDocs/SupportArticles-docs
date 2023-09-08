---
title: Resolve blocking problem caused by lock escalation
description: This article describes how to determine if lock escalation is causing blocking and how to resolve the problem.
ms.date: 04/07/2021
ms.custom: sap:Performance
ms.reviewer: BARTD
---
# Resolve blocking problems caused by lock escalation in SQL Server

## Summary

Lock escalation is the process of converting many fine-grained locks (such as row or page locks) to table locks. Microsoft SQL Server dynamically determines when to do lock escalation. When it makes this decision, SQL Server considers the number of locks that are held on a particular scan, the number of locks that are held by the whole transaction, and the memory that's used for locks in the system as a whole. Typically, SQL Server's default behavior causes lock escalation to occur only at those times when it would improve performance or when you must reduce excessive system lock memory to a more reasonable level. However, some application or query designs might trigger lock escalation at a time when this action not desirable, and the escalated table lock might block other users. This article discusses how to determine whether lock escalation is causing blocking and how to deal with undesirable lock escalation.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 323630

## Determine whether lock escalation is causing blocking

Lock escalation doesn't cause most blocking problems. To determine whether lock escalation is occurring at or near the time when you experience blocking issues, start an Extended Events session that includes the `lock_escalation` event. If you don't see any `lock_escalation` events, lock escalation isn't occurring on your server, and the information in this article doesn't apply to your situation.

If lock escalation is occurring, verify that the escalated table lock is blocking other users.

For more information about how to identify the head blocker and the lock resource that's held by the head blocker and that's blocking other server process IDs (SPIDs), see [INF: Understanding and resolving SQL Server blocking problems](https://support.microsoft.com/help/224453).

If the lock that's blocking other users is anything other than a TAB (table-level) lock that has a lock mode of S (shared), or X (exclusive), lock escalation isn't the problem. In particular, if the TAB lock is an intent lock (such as a lock mode of IS, IU, or IX), this isn't caused by lock escalation. If your blocking problems are not caused by lock escalation, see the [INF: Understanding and resolving SQL Server blocking problems](https://support.microsoft.com/help/224453) troubleshooting steps.

## Prevent lock escalation

The simplest and safest method to prevent lock escalation is to keep transactions short and reduce the lock footprint of expensive queries so that the lock escalation thresholds are not exceeded. There are several methods to achieve this goal, including the following strategies:

- Break up large batch operations into several smaller operations. For example, you run the following query to remove 100,000+ old records from an audit table, and then you determine that the query caused a lock escalation that blocked other users:

    ```sql
    DELETE FROM LogMessages WHERE LogDate < '20020102';
    ```

  By removing these records a few hundred at a time, you can dramatically reduce the number of locks that accumulate per transaction. This will prevent lock escalation. For example, you run the following query:

    ```sql
    DECLARE @done bit = 0;
    WHILE (@done = 0)
    BEGIN
        DELETE TOP(1000) FROM LogMessages WHERE LogDate < '20020102';
        IF @@rowcount < 1000 SET @done = 1;
    END;
    ```

- Reduce the query's lock footprint by making the query as efficient as possible. Large scans or many bookmark lookups can increase the chance of lock escalation. Additionally, these increase the chance of deadlocks, and adversely affect concurrency and performance. After you identify that the query that causes lock escalation, look for opportunities to create new indexes or to add columns to an existing index to remove index or table scans and to maximize the efficiency of index seeks. Review the execution plan and potentially create new nonclustered indexes to improve query performance. For more information, see [SQL Server Index Architecture and Design Guide](/sql/relational-databases/sql-server-index-design-guide).

  One goal of this optimization is to make index seeks return as few rows as possible to minimize the cost of bookmark lookups (maximize the selectivity of the index for the query). If SQL Server estimates that a Bookmark Lookup logical operator will return many rows, it might use a `PREFETCH` clause to do the bookmark lookup. If SQL Server does use `PREFETCH` for a bookmark lookup, it must increase the transaction isolation level of a portion of the query to "repeatable read" for a portion of the query. This means that what may look like a `SELECT` statement at a "read-committed" isolation level might acquire many thousands of key locks (on both the clustered index and one nonclustered index). This can cause such a query to exceed the lock escalation thresholds. This is especially important if you find that the escalated lock is a shared table lock, although these are not commonly seen at the default "read-committed" isolation level. If a Bookmark Lookup WITH `PREFETCH` clause is causing the escalation, consider adding columns to the nonclustered index that appears in the Index Seek, or the Index Scan logical operator below the Bookmark Lookup logical operator in the query plan. It might be possible to create a covering index (an index that includes all columns in a table that were used in the query), or at least an index that covers the columns that were used for join criteria or in the WHERE clause if it's impractical to include everything in the "select column" list.

  A Nested Loop join might also use `PREFETCH`, and this causes the same locking behavior.

- Lock escalation can't occur if a different SPID is currently holding an incompatible table lock. Lock escalation always escalates to a table lock, and never to a page lock. Additionally, if a lock escalation attempt fails because another SPID holds an incompatible TAB lock, the query that tried the escalation doesn't block while waiting for a TAB lock. Instead, it continues to acquire locks at its original, more granular level (row, key, or page), periodically making additional escalation attempts. Therefore, one method to prevent lock escalation on a particular table is to acquire and hold a lock on a different connection that isn't compatible with the escalated lock type. An IX (intent exclusive) lock at the table level doesn't lock any rows or pages, but it is still not compatible with an escalated S (shared) or X (exclusive) TAB lock. For example, assume that you must run a batch job that modifies many rows in the mytable table and that caused blocking because of lock escalation. If this job always finishes in less than one hour, you might create a Transact-SQL job that contains the following code, and schedule the new job to start several minutes before the batch job start time:

    ```sql
    BEGIN TRAN;
    SELECT * FROM mytable (UPDLOCK, HOLDLOCK) WHERE 1 = 0;
    WAITFOR DELAY '1:00:00';
    COMMIT TRAN;
    ```

  This query acquires and holds an IX lock on mytable for one hour. This prevents lock escalation on the table during that time. This batch doesn't modify any data or block other queries (unless the other query forces a table lock by using the TABLOCK hint or if an administrator has disabled page or row locks using [ALTER INDEX](/sql/t-sql/statements/alter-index-transact-sql)).

- Eliminate lock escalation caused by lack of SARGability, a relational database term used to describe whether a query can use indexes for predicates and join columns. For more information on SARGability, see [Inside Design Guide Query Considerations](/sql/relational-databases/sql-server-index-design-guide#query-considerations). For example, a fairly simple query that doesn't appear to be requesting many rows — or perhaps a single row — may still end up scanning an entire table/index. This may occur if there's a function or computation in the left side of a WHERE clause. Such examples that lack SARGability include implicit or explicit data type conversions, the ISNULL() system function, a user-defined function with the column passed as a parameter, or a computation on the column, such as `WHERE CONVERT(INT, column1) = @a` or `WHERE Column1*Column2 = 5`. In such cases, the query can't SEEK the existing index, even if it contains the appropriate columns, because all column values must be retrieved first and passed to the function. This leads to a scan of the entire table or index and results in acquisition of a large number of locks. In such circumstances SQL Server can reach the lock count escalation threshold. The solution is to avoid using functions against columns in the WHERE clause, ensuring SARGable conditions.

## Disable lock escalation

Although it's possible to disable lock escalation in SQL Server, we don't recommended it. Instead, use the prevention strategies that are described in the [Prevent Lock Escalation](#prevent-lock-escalation) section. 
- **Table level:** You can disable lock escalation at the table level. See [`ALTER TABLE ... SET (LOCK_ESCALATION = DISABLE)`](/sql/t-sql/statements/alter-table-transact-sql). To determine which table to target, examine the T-SQL queries. If that's not possible, use [Extended events](/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server), enable the _lock_escalation_ event, and examine the _object_id_ column. Alternatively use the [Lock:Escalation event](/sql/relational-databases/event-classes/lock-escalation-event-class) and examine the `ObjectID2` column by using SQL Profiler.
- **Instance Level:** You can disable lock escalation by enabling either of the trace flags [1211](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1211) or [1224](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1224) or both for the instance. However, these trace flags disable all lock escalation globally in the instance of SQL Server. Lock escalation serves a useful purpose in SQL Server by maximizing the efficiency of queries that are otherwise slowed down by the overhead of acquiring and releasing several thousands of locks. Lock escalation also helps to minimize the required memory to keep track of locks. The memory that SQL Server can dynamically allocate for lock structures is finite. Therefore, if you disable lock escalation, and the lock memory grows large enough, any attempt to allocate additional locks for any query might fail and generate the following error entry:

> Error: 1204, Severity: 19, State: 1  
The SQL Server can't obtain a LOCK resource at this time. Rerun your statement when there are fewer active users or ask the system administrator to check the SQL Server lock and memory configuration.

> [!NOTE]
> When a 1204 error occurs, it stops the processing of the current statement and causes a rollback of the active transaction. The rollback itself may block users or cause a long database recovery time if you restart the SQL Server service.

You can add these trace flags (-T1211 or -T1224) by using [SQL Server Configuration Manager](/sql/database-engine/configure-windows/scm-services-configure-server-startup-options).  You must restart the SQL Server service for a new startup parameter to take effect. If you run the `DBCC TRACEON (1211, -1)` or `DBCC TRACEON (1224, -1)` query, the trace flag takes effect immediately.  
However, if you don't add the -T1211 or -T1224 as a startup parameter, the effect of a `DBCC TRACEON` command is lost when the SQL Server service is restarted. Turning on the trace flag prevents any future lock escalations, but it doesn't reverse any lock escalations that have already occurred in an active transaction.

If you use a lock hint, such as ROWLOCK, this only alters the initial lock plan. Lock hints don't prevent lock escalation.

## Lock escalation thresholds

Lock escalation may occur under one of the following conditions:

- **Memory threshold is reached** - A memory threshold of 40 percent of lock memory is reached. When lock memory exceeds 24 percent of the buffer pool, a lock escalation can be triggered. Lock memory is limited to 60 percent of the visible buffer pool. The lock escalation threshold is set at 40 percent of the lock memory. This is 40 percent of 60 percent of the buffer pool, or 24 percent. If lock memory exceeds the 60 percent limit (this is much more likely if lock escalation is disabled), all attempts to allocate additional locks fail, and `1204` errors are generated.

- **A lock threshold is reached** - After memory threshold is checked, the number of locks acquired on the current table or index is assessed. If the number exceeds 5,000, a lock escalation is triggered.

To understand which threshold was reached, use Extended events, enable the  _lock_escalation_ event, and examine the _escalated_lock_count_ and _escalation_cause_  columns. Alternatively, use the [Lock:Escalation event](/sql/relational-databases/event-classes/lock-escalation-event-class), and examine the `EventSubClass` value, where "0 - LOCK_THRESHOLD" indicates that the statement exceeded the lock threshold, and "1 - MEMORY_THRESHOLD" indicates that the statement exceeded the memory threshold. Also, examine the `IntegerData` and `IntegerData2` columns.

## Recommendations

The methods that are discussed in the [Prevent Lock Escalation](#prevent-lock-escalation) section are better options than disabling escalation at the table or instance level. Additionally, the preventive methods generally produce better performance for the query than disabling lock escalation. Microsoft recommends that you enable this trace flag only to mitigate severe blocking that is caused by lock escalation while other options, such as those discussed in this article, are being investigated. 

## See also

- [Understand and resolve SQL Server blocking problems](understand-resolve-blocking.md)
- [Troubleshoot slow-running queries on SQL Server](troubleshoot-slow-running-queries.md)
