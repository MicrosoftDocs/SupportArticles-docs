---
title: Understand and Resolve SQL Server Blocking Problems
description: Learn how to troubleshoot SQL Server blocking problems, identify head blockers, diagnose long-running transactions, and resolve common scenarios.
ms.date: 08/04/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Understand and resolve SQL Server blocking problems

_Applies to:_ &nbsp; SQL Server, Azure SQL Managed Instance

_Original KB number:_ &nbsp; 224453

## Summary

Blocking is normal in any lock-based relational database, but persistent or long-running blocking degrades throughput and causes application timeouts. This article describes what blocking is in SQL Server, how to capture blocking data from dynamic management views (DMVs) and Extended Events, and how to identify the head blocker. It then walks through the most common blocking scenarios and their resolutions.

In this article, the term *connection* refers to a single logged-on session of the database. Each connection appears as a session ID (SPID) or `session_id` in many DMVs. Each SPID is often called a "process," but it isn't a separate operating system process. It's the server-side resources and data structures that service one client connection. A single client application can have one or more connections. From SQL Server's perspective, connections from many clients and many connections from one client are treated the same. One connection can block another connection, regardless of the source client.

> [!NOTE]
> **This article focuses on SQL Server instances, including Azure SQL Managed Instance.** For information specific to troubleshooting blocking in Azure SQL Database, see [Understand and resolve Azure SQL Database blocking problems](/azure/azure-sql/database/understand-resolve-blocking).

## What is blocking

Blocking is an unavoidable and by-design characteristic of any relational database management system (RDBMS) with lock-based concurrency. As mentioned previously, in SQL Server, blocking occurs when one session holds a lock on a specific resource and a second SPID attempts to acquire a conflicting lock type on the same resource. Typically, the time frame for which the first SPID locks the resource is small. When the owning session releases the lock, the second connection is then free to acquire its own lock on the resource and continue processing. Blocking as described here is normal behavior and may happen many times throughout the course of a day with no noticeable effect on system performance.

The duration and transaction context of a query determine how long its locks are held and, thereby, their effect on other queries. If the query isn't executed within a transaction (and no lock hints are used), the locks for SELECT statements will only be held on a resource at the time it's actually being read, not during the query. For INSERT, UPDATE, and DELETE statements, the locks are held during the query, both for data consistency and to allow the query to be rolled back if necessary.

For queries executed within a transaction, the type of query, the transaction isolation level, and whether lock hints are used in the query determine the duration for which the locks are held. For a description of locking, lock hints, and transaction isolation levels, see the following articles:

* [Locking in the Database Engine](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide)
* [Customizing Locking and Row Versioning](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#customizing-locking-and-row-versioning)
* [Lock Modes](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#lock_modes)
* [Lock Compatibility](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#lock_compatibility)
* [Row Versioning-based Isolation Levels in the Database Engine](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#Row_versioning)
* [Transactions](/sql/t-sql/language-elements/transactions-transact-sql)

When locking and blocking persist to the point where they cause a detrimental effect on system performance, they result from one of the following reasons:

* An SPID holds locks on a set of resources for an extended period of time before releasing them. This type of blocking resolves itself over time but can cause performance degradation.

* An SPID holds locks on a set of resources and never releases them. This type of blocking doesn't resolve itself and prevents access to the affected resources indefinitely.

In the first scenario, the situation can be very fluid as different SPIDs cause blocking on different resources over time, creating a moving target. These situations are difficult to troubleshoot using [SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms) to narrow down the issue to individual queries. In contrast, the second situation results in a consistent state that can be easier to diagnose.

## Applications and blocking

When you encounter a blocking problem, you might focus on server-side tuning and platform issues. However, paying attention only to the database might not lead to a resolution. It can absorb time and energy that you could better direct at examining the client application and the queries it submits. No matter what level of visibility the application exposes regarding the database calls it makes, a blocking problem frequently requires both the inspection of the exact SQL statements the application submits and the application's exact behavior regarding query cancellation, connection management, fetching all result rows, and so on. If the development tool doesn't allow explicit control over connection management, query cancellation, query timeout, result fetching, and so on, you might not be able to resolve blocking problems. Examine this potential closely before selecting an application development tool for SQL Server, especially for performance sensitive OLTP environments.

Pay attention to database performance during the design and construction phase of the database and application. In particular, evaluate the resource consumption, isolation level, and transaction path length for each query. Each query and transaction should be as lightweight as possible. Exercise good connection management discipline. Without it, the application might appear to have acceptable performance at low numbers of users, but performance might degrade significantly as the number of users scales upward.

With proper application and query design, SQL Server can support many thousands of simultaneous users on a single server, with little blocking.

## Troubleshoot blocking

Regardless of which blocking situation you're in, the methodology for troubleshooting locking is the same. These logical separations dictate the rest of the composition of this article. The concept is to find the head blocker and identify what that query is doing and why it's blocking. Once you identify the problematic query (that is, what is holding locks for the prolonged period), the next step is to analyze and determine why the blocking is happening. After you understand why, you can make changes by redesigning the query and the transaction.

Steps in troubleshooting:

1. Identify the main blocking session (head blocker).

1. Find the query and transaction that cause the blocking (what holds locks for a prolonged period).

1. Analyze and understand why the prolonged blocking occurs.

1. Resolve the blocking issue by redesigning the query and transaction.

Now let's dive in to discuss how to pinpoint the main blocking session with an appropriate data capture.

## Gather blocking information

To counteract the difficulty of troubleshooting blocking problems, a database administrator can use SQL scripts that constantly monitor the state of locking and blocking on SQL Server.
To gather this data, there are two complimentary methods.

The first method is to query dynamic management objects (DMOs) and store the results for comparison over time. Some objects referenced in this article are dynamic management views (DMVs) and some are dynamic management functions (DMFs).

The second method is to use [Extended Events](/sql/relational-databases/extended-events/extended-events) (XEvents) or [SQL Profiler Traces](/sql/relational-databases/sql-trace/sql-trace) to capture what is executing. Since SQL Trace and SQL Server Profiler are deprecated, this troubleshooting guide focuses on XEvents.

## Gather information from DMVs

To troubleshoot blocking, use DMVs to identify the SPID (session ID) at the head of the blocking chain and the SQL statement. Look for victim SPIDs that are blocked. If a SPID is blocked by another SPID, investigate the SPID that owns the resource (the blocking SPID). Is that owner SPID blocked as well? You can follow the chain to find the head blocker and then investigate why it maintains its lock.

To do this, use one of the following methods:

* In SQL Server Management Studio (SSMS) Object Explorer, right-click the top-level server object, expand **Reports**, expand **Standard Reports**, and then select **Activity - All Blocking Transactions**. This report shows current transactions at the head of a blocking chain. If you expand the transaction, the report will show the transactions that are blocked by the head transaction. This report will also show the **Blocking SQL Statement** and the **Blocked SQL Statement**.

* Open Activity Monitor in SSMS and refer to the **Blocked By** column. For more information, see [Activity Monitor](/sql/relational-databases/performance-monitor/activity-monitor).

More detailed query-based methods are also available using DMVs:

* The `sp_who` and `sp_who2` commands are older commands that show all current sessions. The DMV `sys.dm_exec_sessions` returns more data in a result set that's easier to query and filter. You'll find `sys.dm_exec_sessions` at the core of other queries.

* If you already identified a particular session, use `DBCC INPUTBUFFER(<session_id>)` to find the last statement that a session submitted. Similar results are returned by the `sys.dm_exec_input_buffer` dynamic management function (DMF), in a result set that's easier to query and filter, providing the session_id and the request_id. For example, to return the most recent query submitted by session_id 66 and request_id 0:

```sql
SELECT * FROM sys.dm_exec_input_buffer (66,0);
```

* Refer to the `sys.dm_exec_requests` and reference the `blocking_session_id` column. When `blocking_session_id` = 0, a session isn't blocked. While `sys.dm_exec_requests` lists only requests currently executing, `sys.dm_exec_sessions` lists any connection (active or not). Build on this common join between `sys.dm_exec_requests` and `sys.dm_exec_sessions` in the next query. Keep in mind that to be returned by `sys.dm_exec_requests`, the query must be actively executing with SQL Server.

* Run this sample query to find the actively executing queries and their current SQL batch text or input buffer text, using the [sys.dm_exec_sql_text](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sql-text-transact-sql) or [sys.dm_exec_input_buffer](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-input-buffer-transact-sql) DMVs. If the data returned by the `text` column of `sys.dm_exec_sql_text` is NULL, the query isn't currently executing. In that case, the `event_info` column of `sys.dm_exec_input_buffer` will contain the last command string passed to the SQL engine. This query can also be used to identify sessions blocking other sessions, including a list of session_ids blocked per session_id.

```sql
WITH cteBL (session_id, blocking_these) AS 
(SELECT s.session_id, blocking_these = x.blocking_these FROM sys.dm_exec_sessions s 
CROSS APPLY    (SELECT isnull(convert(varchar(6), er.session_id),'') + ', '  
                FROM sys.dm_exec_requests as er
                WHERE er.blocking_session_id = isnull(s.session_id ,0)
                AND er.blocking_session_id <> 0
                FOR XML PATH('') ) AS x (blocking_these)
)
SELECT s.session_id, blocked_by = r.blocking_session_id, bl.blocking_these
, batch_text = t.text, input_buffer = ib.event_info, * 
FROM sys.dm_exec_sessions s 
LEFT OUTER JOIN sys.dm_exec_requests r on r.session_id = s.session_id
INNER JOIN cteBL as bl on s.session_id = bl.session_id
OUTER APPLY sys.dm_exec_sql_text (r.sql_handle) t
OUTER APPLY sys.dm_exec_input_buffer(s.session_id, NULL) AS ib
WHERE blocking_these is not null or r.blocking_session_id > 0
ORDER BY len(bl.blocking_these) desc, r.blocking_session_id desc, r.session_id;
```

* Run this more elaborate sample query, provided by Microsoft Support, to identify the head of a multiple session blocking chain, including the query text of the sessions involved in a blocking chain.

```sql
WITH cteHead ( session_id,request_id,wait_type,wait_resource,last_wait_type,is_user_process,request_cpu_time
,request_logical_reads,request_reads,request_writes,wait_time,blocking_session_id,memory_usage
,session_cpu_time,session_reads,session_writes,session_logical_reads
,percent_complete,est_completion_time,request_start_time,request_status,command
,plan_handle,sql_handle,statement_start_offset,statement_end_offset,most_recent_sql_handle
,session_status,group_id,query_hash,query_plan_hash) 
AS ( SELECT sess.session_id, req.request_id, LEFT (ISNULL (req.wait_type, ''), 50) AS 'wait_type'
    , LEFT (ISNULL (req.wait_resource, ''), 40) AS 'wait_resource', LEFT (req.last_wait_type, 50) AS 'last_wait_type'
    , sess.is_user_process, req.cpu_time AS 'request_cpu_time', req.logical_reads AS 'request_logical_reads'
    , req.reads AS 'request_reads', req.writes AS 'request_writes', req.wait_time, req.blocking_session_id,sess.memory_usage
    , sess.cpu_time AS 'session_cpu_time', sess.reads AS 'session_reads', sess.writes AS 'session_writes', sess.logical_reads AS 'session_logical_reads'
    , CONVERT (decimal(5,2), req.percent_complete) AS 'percent_complete', req.estimated_completion_time AS 'est_completion_time'
    , req.start_time AS 'request_start_time', LEFT (req.status, 15) AS 'request_status', req.command
    , req.plan_handle, req.[sql_handle], req.statement_start_offset, req.statement_end_offset, conn.most_recent_sql_handle
    , LEFT (sess.status, 15) AS 'session_status', sess.group_id, req.query_hash, req.query_plan_hash
    FROM sys.dm_exec_sessions AS sess
    LEFT OUTER JOIN sys.dm_exec_requests AS req ON sess.session_id = req.session_id
    LEFT OUTER JOIN sys.dm_exec_connections AS conn on conn.session_id = sess.session_id 
    )
, cteBlockingHierarchy (head_blocker_session_id, session_id, blocking_session_id, wait_type, wait_duration_ms,
wait_resource, statement_start_offset, statement_end_offset, plan_handle, sql_handle, most_recent_sql_handle, [Level])
AS ( SELECT head.session_id AS head_blocker_session_id, head.session_id AS session_id, head.blocking_session_id
    , head.wait_type, head.wait_time, head.wait_resource, head.statement_start_offset, head.statement_end_offset
    , head.plan_handle, head.sql_handle, head.most_recent_sql_handle, 0 AS [Level]
    FROM cteHead AS head
    WHERE (head.blocking_session_id IS NULL OR head.blocking_session_id = 0)
    AND head.session_id IN (SELECT DISTINCT blocking_session_id FROM cteHead WHERE blocking_session_id != 0)
    UNION ALL
    SELECT h.head_blocker_session_id, blocked.session_id, blocked.blocking_session_id, blocked.wait_type,
    blocked.wait_time, blocked.wait_resource, h.statement_start_offset, h.statement_end_offset,
    h.plan_handle, h.sql_handle, h.most_recent_sql_handle, [Level] + 1
    FROM cteHead AS blocked
    INNER JOIN cteBlockingHierarchy AS h ON h.session_id = blocked.blocking_session_id and h.session_id!=blocked.session_id --avoid infinite recursion for latch type of blocking
    WHERE h.wait_type COLLATE Latin1_General_BIN NOT IN ('EXCHANGE', 'CXPACKET') or h.wait_type is null
    )
SELECT bh.*, txt.text AS blocker_query_or_most_recent_query 
FROM cteBlockingHierarchy AS bh 
OUTER APPLY sys.dm_exec_sql_text (ISNULL ([sql_handle], most_recent_sql_handle)) AS txt;
```

* To catch long-running or uncommitted transactions, use another set of DMVs for viewing current open transactions, including [sys.dm_tran_database_transactions](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-database-transactions-transact-sql), [sys.dm_tran_session_transactions](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-session-transactions-transact-sql), [sys.dm_exec_connections](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-connections-transact-sql), and `sys.dm_exec_sql_text`. For more DMVs associated with tracking transactions, see [DMVs on transactions](/sql/relational-databases/system-dynamic-management-views/transaction-related-dynamic-management-views-and-functions-transact-sql).

```sql
SELECT [s_tst].[session_id],
[database_name] = DB_NAME (s_tdt.database_id),
[s_tdt].[database_transaction_begin_time], 
[sql_text] = [s_est].[text] 
FROM sys.dm_tran_database_transactions [s_tdt]
INNER JOIN sys.dm_tran_session_transactions [s_tst] ON [s_tst].[transaction_id] = [s_tdt].[transaction_id]
INNER JOIN sys.dm_exec_connections [s_ec] ON [s_ec].[session_id] = [s_tst].[session_id]
CROSS APPLY sys.dm_exec_sql_text ([s_ec].[most_recent_sql_handle]) AS [s_est];
```

* Reference [sys.dm_os_waiting_tasks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-waiting-tasks-transact-sql) that's at the thread/task layer of SQL Server. This DMV returns information about what SQL wait_type the request is currently experiencing. Like `sys.dm_exec_requests`, only active requests are returned by `sys.dm_os_waiting_tasks`.

>[!Note]
> For more information about wait types, including aggregated wait stats over time, see the DMV [sys.dm_db_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql).

* Use the [sys.dm_tran_locks](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-locks-transact-sql) DMV for more granular information on what locks have been placed by queries. This DMV can return large amounts of data on a production SQL Server instance, and is useful for diagnosing what locks are currently held.

Due to the INNER JOIN on `sys.dm_os_waiting_tasks`, the following query restricts the output from `sys.dm_tran_locks` only to currently blocked requests, their wait status, and their locks:

```sql
SELECT table_name = schema_name(o.schema_id) + '.' + o.name
, wt.wait_duration_ms, wt.wait_type, wt.blocking_session_id, wt.resource_description
, tm.resource_type, tm.request_status, tm.request_mode, tm.request_session_id
FROM sys.dm_tran_locks AS tm
INNER JOIN sys.dm_os_waiting_tasks as wt ON tm.lock_owner_address = wt.resource_address
LEFT OUTER JOIN sys.partitions AS p on p.hobt_id = tm.resource_associated_entity_id
LEFT OUTER JOIN sys.objects o on o.object_id = p.object_id or tm.resource_associated_entity_id = o.object_id
WHERE resource_database_id = DB_ID()
AND object_name(p.object_id) = '<table_name>';
```

With DMVs, storing the query results over time will provide data points that will allow you to review blocking over a specified time interval to identify persisted blocking or trends. The go-to tool for CSS to troubleshoot such issues is using the PSSDiag data collector. This tool uses the "SQL Server Perf Stats" to collect result sets from DMVs referenced above, over time. As this tool is constantly evolving, review the latest public version of [DiagManager on GitHub](https://github.com/Microsoft/DiagManager).

## Gather information from extended events

In addition to the preceding information, you often need to capture a trace of the activities on the server to thoroughly investigate a blocking problem in SQL Server. For example, if a session executes multiple statements within a transaction, only the last statement that the session submits is represented. However, one of the earlier statements might be the reason locks are still held. A trace enables you to see all the commands that a session executes within the current transaction.

You can capture traces in SQL Server by using two methods: [Extended Events (XEvents)](/sql/relational-databases/extended-events/extended-events) and Profiler Traces. However, SQL traces that use the [SQL Server Profiler](/sql/tools/sql-server-profiler/sql-server-profiler) are deprecated. XEvents is the newer, superior tracing platform that offers more versatility and less impact to the observed system. Its interface is integrated into SSMS.

In Object Explorer, under the menu for XEvent Profiler, you can find pre-made Extended Event sessions that are ready to start in SSMS. For more information, see [XEvent Profiler](/sql/relational-databases/extended-events/use-the-ssms-xe-profiler). You can also create your own custom Extended Event sessions in SSMS. For more information, see [Extended Events New Session Wizard](/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server). For troubleshooting blocking problems, typically you capture:

* Category Errors:
  * Attention
  * Blocked_process_report**
  * Error_reported (Channel Admin)
  * Exchange_spill
  * Execution_warning  

**To configure the threshold and frequency at which blocked process reports are generated, use the sp_configure command to [configure the blocked process threshold option](/sql/database-engine/configure-windows/blocked-process-threshold-server-configuration-option), which can be set in seconds. By default, no blocked process reports are produced.

* Category Warnings:
  * Hash_warning
  * Missing_column_statistics
  * Missing_join_predicate
  * Sort_warning

* Category Execution:
  * Rpc_completed
  * Rpc_starting
  * Sql_batch_completed
  * Sql_batch_starting

* Category Lock
  * Lock_deadlock

* Category Session
  * Existing_connection
  * Login
  * Logout

## Identify and resolve common blocking scenarios

By examining the preceding information, you can determine the cause of most blocking problems. The rest of this article discusses how to use this information to identify and resolve some common blocking scenarios. This discussion assumes you use the blocking scripts (referenced earlier) to capture information on the blocking SPIDs and capture application activity by using an XEvent session.

## Analyze blocking data

* Examine the output of the DMVs `sys.dm_exec_requests` and `sys.dm_exec_sessions` to determine the heads of the blocking chains, using `blocking_these` and `session_id`. This output clearly identifies which requests are blocked and which are blocking. Look further into the sessions that are blocked and blocking. Is there a common or root to the blocking chain? They likely share a common table, and one or more of the sessions involved in a blocking chain is performing a write operation.

* Examine the output of the DMVs `sys.dm_exec_requests` and `sys.dm_exec_sessions` for information on the SPIDs at the head of the blocking chain. Look for the following columns:

  * `sys.dm_exec_requests.status`  

    This column shows the status of a particular request. Typically, a sleeping status indicates that the SPID completed execution and is waiting for the application to submit another query or batch. A runnable or running status indicates that the SPID is currently processing a query. The following table gives brief explanations of the various status values.

    | Status | Meaning |
    |:-|:-|
    | Background | The SPID is running a background task, such as deadlock detection, log writer, or checkpoint. |
    | Sleeping | The SPID isn't currently executing. This usually indicates that the SPID is awaiting a command from the application. |
    | Running | The SPID is currently running on a scheduler. |
    | Runnable | The SPID is in the runnable queue of a scheduler and waiting to get scheduler time. |
    | Suspended | The SPID is waiting for a resource, such as a lock or a latch. |

  * `sys.dm_exec_sessions.open_transaction_count`  

    This column shows the number of open transactions in this session. If this value is greater than 0, the SPID is within an open transaction and might be holding locks acquired by any statement within the transaction. The open transaction could be created either by a currently active statement or by a statement request that ran in the past and isn't active any longer.

  * `sys.dm_exec_requests.open_transaction_count`  

    Similarly, this column shows the number of open transactions in this request. If this value is greater than 0, the SPID is within an open transaction and might be holding locks acquired by any active statement within the transaction. Unlike `sys.dm_exec_sessions.open_transaction_count`, if there isn't an active request, this column shows 0.  

  * `sys.dm_exec_requests.wait_type`, `wait_time`, and `last_wait_type`  

    If the `sys.dm_exec_requests.wait_type` is NULL, the request isn't currently waiting for anything. The `last_wait_type` value indicates the last `wait_type` that the request encountered. For more information about `sys.dm_os_wait_stats` and a description of the most common wait types, see [sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql). The `wait_time` value can be used to determine if the request is making progress. When a query against the `sys.dm_exec_requests` table returns a value in the `wait_time` column that is less than the `wait_time` value from a previous query of `sys.dm_exec_requests`, this condition indicates that the prior lock was acquired and released and is now waiting on a new lock (assuming non-zero `wait_time`). You can verify this condition by comparing the `wait_resource` between `sys.dm_exec_requests` output, which displays the resource for which the request is waiting.

  * `sys.dm_exec_requests.wait_resource`

    This column indicates the resource that a blocked request is waiting on. The following table lists common `wait_resource` formats and their meaning:

    | Resource | Format | Example | Explanation |
    |:-|:-|:-|:-|
    | Table | DatabaseID:ObjectID:IndexID | TAB: 5:261575970:1 | In this case, database ID 5 is the pubs sample database and `object_id` 261575970 is the titles table and 1 is the clustered index. |
    | Page | DatabaseID:FileID:PageID | PAGE: 5:1:104 | In this case, database ID 5 is pubs, file ID 1 is the primary data file, and page 104 is a page belonging to the titles table. To identify the object_id the page belongs to, use the dynamic management function [sys.dm_db_page_info](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-page-info-transact-sql), passing in the DatabaseID, FileId, PageId from the `wait_resource`. |
    | Key | DatabaseID:Hobt_id (Hash value for index key) | KEY: 5:72057594044284928 (3300a4f361aa) | In this case, database ID 5 is Pubs, Hobt_ID 72057594044284928 corresponds to index_id 2 for object_id 261575970 (titles table). Use the `sys.partitions` catalog view to associate the `hobt_id` to a particular `index_id` and `object_id`. There's no way to unhash the index key hash to a specific key value. |
    | Row | DatabaseID:FileID:PageID:Slot(row) | RID: 5:1:104:3 | In this case, database ID 5 is pubs, file ID 1 is the primary data file, page 104 is a page belonging to the titles table, and slot 3 indicates the row's position on the page. |

  * `sys.dm_tran_active_transactions`
    The [sys.dm_tran_active_transactions](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-active-transactions-transact-sql) DMV contains data about open transactions that can be joined to other DMVs for a complete picture of transactions awaiting commit or rollback. Use the following query to return information on open transactions, joined to other DMVs including [sys.dm_tran_session_transactions](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-session-transactions-transact-sql). Consider a transaction's current state, `transaction_begin_time`, and other situational data to evaluate whether it could be a source of blocking.

    ```sql
    SELECT tst.session_id, [database_name] = db_name(s.database_id)
    , tat.transaction_begin_time
    , transaction_duration_s = datediff(s, tat.transaction_begin_time, sysdatetime()) 
    , transaction_type = CASE tat.transaction_type  WHEN 1 THEN 'Read/write transaction'
                                                    WHEN 2 THEN 'Read-only transaction'
                                                    WHEN 3 THEN 'System transaction'
                                                    WHEN 4 THEN 'Distributed transaction' END
    , input_buffer = ib.event_info, tat.transaction_uow     
    , transaction_state  = CASE tat.transaction_state    
                WHEN 0 THEN 'The transaction has not been completely initialized yet.'
                WHEN 1 THEN 'The transaction has been initialized but has not started.'
                WHEN 2 THEN 'The transaction is active - has not been committed or rolled back.'
                WHEN 3 THEN 'The transaction has ended. This is used for read-only transactions.'
                WHEN 4 THEN 'The commit process has been initiated on the distributed transaction.'
                WHEN 5 THEN 'The transaction is in a prepared state and waiting resolution.'
                WHEN 6 THEN 'The transaction has been committed.'
                WHEN 7 THEN 'The transaction is being rolled back.'
                WHEN 8 THEN 'The transaction has been rolled back.' END 
    , transaction_name = tat.name, request_status = r.status
    , tst.is_user_transaction, tst.is_local
    , session_open_transaction_count = tst.open_transaction_count  
    , s.host_name, s.program_name, s.client_interface_name, s.login_name, s.is_user_process
    FROM sys.dm_tran_active_transactions tat 
    INNER JOIN sys.dm_tran_session_transactions tst  on tat.transaction_id = tst.transaction_id
    INNER JOIN Sys.dm_exec_sessions s on s.session_id = tst.session_id 
    LEFT OUTER JOIN sys.dm_exec_requests r on r.session_id = s.session_id
    CROSS APPLY sys.dm_exec_input_buffer(s.session_id, null) AS ib;
    ```

  * Other columns

    The remaining columns in [sys.dm_exec_sessions](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql) and [sys.dm_exec_request](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) can provide insight into the root of a problem as well. Their usefulness varies depending on the circumstances of the problem. For example, you can determine if the problem happens only from certain clients (`hostname`), on certain network libraries (`client_interface_name`), when the last batch submitted by an SPID was `last_request_start_time` in `sys.dm_exec_sessions`, how long a request had been running using `start_time` in `sys.dm_exec_requests`, and so on.

## Common blocking scenarios

The table below maps common symptoms to their probable causes.  

The `wait_type`, `open_transaction_count`, and `status` columns refer to information returned by [sys.dm_exec_request](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql), other columns may be returned by [sys.dm_exec_sessions](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql). The "Resolves?" column indicates whether or not the blocking will resolve on its own, or whether the session should be killed via the `KILL` command. For more information, see [KILL (Transact-SQL)](/sql/t-sql/language-elements/kill-transact-sql).

| Scenario | Wait_type | Open_Tran | Status | Resolves? | Other Symptoms |  
|-|-|-|-|-|-|
| 1 | NOT NULL | >= 0 | runnable | Yes, when query finishes. | In `sys.dm_exec_sessions`, `reads`, `cpu_time`, and/or `memory_usage` columns will increase over time. Duration for the query will be high when completed. |  
| 2 | NULL | \>0 | sleeping | No, but SPID can be killed. | An attention signal may be seen in the Extended Event session for this SPID, indicating a query timeout or cancel has occurred. |
| 3 | NULL | \>= 0 | runnable | No. Won't resolve until client fetches all rows or closes connection. SPID can be killed, but it may take up to 30 seconds. | If open_transaction_count = 0, and the SPID holds locks while the transaction isolation level is default (READ COMMITTED), this is a likely cause. |  
| 4 | Varies | \>= 0 | runnable | No. Won't resolve until client cancels queries or closes connections. SPIDs can be killed, but may take up to 30 seconds. | The `hostname` column in `sys.dm_exec_sessions` for the SPID at the head of a blocking chain will be the same as one of the SPID it's blocking. |  
| 5 | NULL | \>0 | rollback | Yes. | An attention signal may be seen in the Extended Events session for this SPID, indicating a query timeout or cancel has occurred, or simply a rollback statement has been issued. |  
| 6 | NULL | \>0 | sleeping | Eventually. When Windows NT determines the session is no longer active, the connection will be broken. | The `last_request_start_time` value in `sys.dm_exec_sessions` is much earlier than the current time. |

## Detailed blocking scenarios

### Scenario 1: Blocking caused by a normally running query with a long execution time

In this scenario, an actively running query has acquired locks, and the locks aren't released (it's affected by the transaction isolation level). So other sessions will wait on the locks until they're released.

**Resolution**:

To resolve this blocking problem, optimize the query. This type of blocking problem might be a performance problem. Treat it as such. For information on troubleshooting a specific slow-running query, see [How to troubleshoot slow-running queries on SQL Server](troubleshoot-slow-running-queries.md). For more information, see [Monitor and Tune for Performance](/sql/relational-databases/performance/monitor-and-tune-for-performance).

Reports built in to SSMS from the [Query Store](/sql/relational-databases/performance/best-practice-with-the-query-store) (introduced in SQL Server 2016) are also a highly recommended and valuable tool for identifying the most costly queries and suboptimal execution plans.

If you have a long-running query blocking other users and you can't optimize it, consider moving it from an OLTP environment to a dedicated reporting system. You can also use Always On availability groups to synchronize a [read-only replica of the database](/sql/database-engine/availability-groups/windows/active-secondaries-readable-secondary-replicas-always-on-availability-groups).

> [!NOTE]
> Blocking during query execution could be caused by query escalation, a scenario when row or page locks escalated to table locks. Microsoft SQL Server dynamically determines when to perform lock escalation. The simplest and safest way to prevent lock escalation is to keep transactions short and to reduce the lock footprint of expensive queries so that the lock escalation thresholds aren't exceeded. For more information on detecting and preventing excessive lock escalation, see [Resolve blocking problem caused by lock escalation](resolve-blocking-problems-caused-lock-escalation.md).

### Scenario 2: Blocking caused by a sleeping SPID that has an uncommitted transaction

You can often identify this type of blocking by an SPID that's sleeping or awaiting a command with a transaction nesting level (`@@TRANCOUNT`, `open_transaction_count` from `sys.dm_exec_requests`) greater than zero. This situation can occur if the application experiences a query timeout or issues a cancel without issuing the required number of ROLLBACK and/or COMMIT statements. When an SPID receives a query timeout or a cancel, it terminates the current query and batch but doesn't automatically roll back or commit the transaction. The application is responsible for this action, as SQL Server can't assume that an entire transaction must be rolled back due to a single query being canceled. The query timeout or cancel appears as an ATTENTION signal event for the SPID in the Extended Event session.

To demonstrate an uncommitted explicit transaction, issue the following query:

```sql
CREATE TABLE #test (col1 INT);
INSERT INTO #test SELECT 1;
GO
BEGIN TRAN
UPDATE #test SET col1 = 2 where col1 = 1;
```

Then, execute this query in the same window:

```sql
SELECT @@TRANCOUNT;
ROLLBACK TRAN
DROP TABLE #test;
```

The output of the second query indicates that the transaction count is one. All the locks acquired in the transaction are still held until the transaction was committed or rolled back. If applications explicitly open and commit transactions, a communication or other error could leave the session and its transaction in an open state.

Use the script earlier in this article based on `sys.dm_tran_active_transactions` to identify currently uncommitted transactions across the instance.

**Resolutions**:

* This class of blocking problem might also be a performance problem. If you can reduce the query execution time, the query timeout or cancel might not occur. It's important that the application can handle the timeout or cancel scenarios should they arise, but you might also benefit from examining the performance of the query.

* Applications must properly manage transaction nesting levels, or they might cause a blocking problem following the cancellation of the query in this manner. Consider the following:  

  * In the error handler of the client application, execute `IF @@TRANCOUNT > 0 ROLLBACK TRAN` following any error, even if the client application doesn't believe a transaction is open. Checking for open transactions is required because a stored procedure called during the batch could have started a transaction without the client application's knowledge. Certain conditions, such as canceling the query, prevent the procedure from executing past the current statement, so even if the procedure has logic to check `IF @@ERROR <> 0` and abort the transaction, this rollback code won't be executed in such cases.

  * If you're using connection pooling in an application that opens the connection and runs a few queries before releasing the connection back to the pool, such as a Web-based application, temporarily disabling connection pooling might help alleviate the problem until the client application is modified to handle the errors appropriately. By disabling connection pooling, releasing the connection causes a physical disconnect of the SQL Server connection, resulting in the server rolling back any open transactions.

  * Use `SET XACT_ABORT ON` for the connection or in any stored procedures that begin transactions and aren't cleaning up following an error. In the event of a run-time error, this setting aborts any open transactions and returns control to the client. For more information, review [SET XACT_ABORT (Transact-SQL)](/sql/t-sql/statements/set-xact-abort-transact-sql).

> [!NOTE]
> The connection isn't reset until it's reused from the connection pool, so it's possible that a user could open a transaction and then release the connection to the connection pool, but it might not be reused for several seconds, during which time the transaction would remain open. If the connection isn't reused, the transaction will be aborted when the connection times out and is removed from the connection pool. Thus, it's optimal for the client application to abort transactions in their error handler or use `SET XACT_ABORT ON` to avoid this potential delay.

> [!CAUTION]
> Following `SET XACT_ABORT ON`, T-SQL statements following a statement that causes an error won't be executed. This could affect the intended flow of existing code.

### Scenario 3: Blocking caused by an SPID whose corresponding client application didn't fetch all result rows to completion

After sending a query to the server, all applications must immediately fetch all result rows to completion. If an application doesn't fetch all result rows, it can leave locks on the tables that block other users. If you're using an application that transparently submits SQL statements to the server, the application must fetch all result rows. If it doesn't (and if it can't be configured to do so), you might be unable to resolve the blocking problem. To avoid the problem, restrict poorly behaved applications to a reporting or a decision-support database, separate from the main OLTP database.

**Resolution**:

Rewrite the application to fetch all rows of the result to completion. This doesn't rule out the use of [OFFSET and FETCH in the ORDER BY clause](/sql/t-sql/queries/select-order-by-clause-transact-sql#using-offset-and-fetch-to-limit-the-rows-returned) of a query to perform server-side paging.

### Scenario 4: Blocking caused by a distributed client/server deadlock

Unlike a conventional deadlock, a distributed deadlock is not detectable using the RDBMS lock manager. This is because only one of the resources involved in the deadlock is a SQL Server lock. The other side of the deadlock is at the client application level, over which SQL Server has no control. The following two sections show examples of how this can happen and possible ways the application can avoid it.

#### Example A: Client/server distributed deadlock with a single client thread

If the client has multiple open connections and a single thread of execution, the following distributed deadlock can occur. Note, the term `dbproc` used here refers to the client connection structure.

```console
 SPID1------blocked on lock------->SPID2
   /\ (waiting to write results back to client)
   | 
   | |
   | | Server side
   | ================================|==================================
   | <-- single thread --> | Client side
   | \/
   dbproc1 <------------------- dbproc2
   (waiting to fetch (effectively blocked on dbproc1, awaiting
   next row) single thread of execution to run)
 ```

   In the preceding case, a single client application thread has two open connections. It asynchronously submits a SQL operation on dbproc1. This means it doesn't wait on the call to return before proceeding. The application then submits another SQL operation on dbproc2, and awaits the results to start processing the returned data. When data starts coming back (whichever dbproc first responds - assume this is dbproc1), it processes to completion all the data returned on that dbproc. It fetches results from dbproc1 until SPID1 gets blocked on a lock held by SPID2 (because the two queries are running asynchronously on the server). At this point, dbproc1 waits indefinitely for more data. SPID2 isn't blocked on a lock, but tries to send data to its client, dbproc2. However, dbproc2 is effectively blocked on dbproc1 at the application layer as the single thread of execution for the application is in use by dbproc1. This situation results in a deadlock that SQL Server can't detect or resolve because only one of the resources involved is a SQL Server resource.

#### Example B: Client/server distributed deadlock with a thread per connection

Even if a separate thread exists for each connection on the client, a variation of this distributed deadlock can still occur as shown by the following example.

```console
SPID1------blocked on lock-------->SPID2
  /\ (waiting on net write) Server side
  | |
  | |
  | INSERT |SELECT
  | ================================|==================================
  | <-- thread per dbproc --> | Client side
  | \/
  dbproc1 <-----data row------- dbproc2
  (waiting on (blocked on dbproc1, waiting for it
  insert) to read the row from its buffer)
```

This case is similar to Example A, except dbproc2 and SPID2 are running a `SELECT` statement with the intention of performing row-at-a-time processing and handing each row through a buffer to dbproc1 for an `INSERT`, `UPDATE`, or `DELETE` statement on the same table. Eventually, SPID1 (performing the `INSERT`, `UPDATE`, or `DELETE`) becomes blocked on a lock held by SPID2 (performing the `SELECT`). SPID2 writes a result row to the client dbproc2. Dbproc2 then tries to pass the row in a buffer to dbproc1, but finds dbproc1 is busy (it's blocked waiting on SPID1 to finish the current `INSERT`, which is blocked on SPID2). At this point, dbproc2 is blocked at the application layer by dbproc1 whose SPID (SPID1) is blocked at the database level by SPID2. Again, this results in a deadlock that SQL Server can't detect or resolve because only one of the resources involved is a SQL Server resource.

Both examples A and B are fundamental issues that application developers must be aware of. They must code applications to handle these cases appropriately.

**Resolution**:

When you provide a query timeout, if the distributed deadlock occurs, the timeout breaks the deadlock. For more information about using a query timeout, see your connection provider documentation.

### Scenario 5: Blocking caused by a session in a rollback state

When you kill or cancel a data modification query outside of a user-defined transaction, the query rolls back. This rollback can also happen as a side effect of the client network session disconnecting, the client computer restarting, or the request being selected as a deadlock victim. You often can't roll back a data modification query any faster than the changes were initially applied. For example, if a `DELETE`, `INSERT`, or `UPDATE` statement ran for an hour, it could take at least an hour to roll back. This behavior is expected, because if the changes aren't rolled back, transactional and physical integrity in the database would be compromised. Because this rollback must complete, SQL Server marks the session in a KILLED/ROLLBACK state, and you can't kill the session again or select it as a deadlock victim. You can often identify this state by observing the output of `sys.dm_exec_requests`, where the `command` column reports `KILLED/ROLLBACK` and the `percent_complete` column shows progress.

> [!NOTE]
> Lengthy rollbacks are rare when the [Accelerated Database Recovery feature](/sql/relational-databases/accelerated-database-recovery-concepts) is enabled. This feature was introduced in SQL Server 2019.

**Resolution**:

Wait for the session to finish rolling back the changes.

If you shut down the instance in the middle of this operation, the database is in recovery mode upon restarting, and it's inaccessible until all open transactions are processed. Startup recovery takes essentially the same amount of time per transaction as run-time recovery, and the database is inaccessible during this period. Thus, forcing the server down to fix an SPID in a rollback state is often counterproductive. In SQL Server 2019 with Accelerated Database Recovery enabled, this situation shouldn't occur.
  
To avoid this situation, don't perform large batch write operations or index creation or maintenance operations during busy hours on OLTP systems. If possible, perform such operations during periods of low activity.

### Scenario 6:  Blocking caused by an orphaned transaction

This is a common problem scenario and overlaps partly with [Scenario 2](#scenario-2-blocking-caused-by-a-sleeping-spid-that-has-an-uncommitted-transaction). If the client application stops, the client workstation is restarted, or there's a batch-aborting error, these all may leave a transaction open. This situation can occur if the application doesn't roll back the transaction in the application's `CATCH` or `FINALLY` blocks or if it doesn't otherwise handle this situation.

In this scenario, while the execution of a SQL batch has been canceled, the application leaves the SQL transaction open. From the SQL Server instance's perspective, the client still appears to be present, and any locks acquired are retained.

To demonstrate an orphaned transaction, execute the following query, which simulates a batch-aborting error by inserting data into a non-existent table:

```sql
CREATE TABLE #test2 (col1 INT);
INSERT INTO #test2 SELECT 1;
go
BEGIN TRAN
UPDATE #test2 SET col1 = 2 where col1 = 1;
INSERT INTO #NonExistentTable values (10)
```

Then, execute this query in the same window:

```sql
SELECT @@TRANCOUNT;
```

The output of the second query indicates that the transaction count is one. All the locks acquired in the transaction are still held until the transaction is committed or rolled back. Since the batch is already aborted by the query, the application that executes it may continue running other queries on the same session without cleaning up the transaction that's still open. The lock will be held until the session is killed or the SQL Server instance is restarted.

**Resolutions**:

* The best way to prevent this condition is by improving application error and exception handling, especially for unexpected terminations. Make sure you use a `Try-Catch-Finally` block in the application code and roll back the transaction in the case of an exception.
* Consider using `SET XACT_ABORT ON` for the session or in any stored procedures that begin transactions and aren't cleaning up following an error. In the event of a run-time error that aborts the batch, this setting automatically rolls back any open transactions and returns control to the client. For more information, see [SET XACT_ABORT (Transact-SQL)](/sql/t-sql/statements/set-xact-abort-transact-sql).
* To resolve an orphaned connection of a client application that has disconnected without appropriately cleaning up its resources, you can terminate the SPID by using the `KILL` command. For reference, see [KILL (Transact-SQL)](/sql/t-sql/language-elements/kill-transact-sql).

The `KILL` command takes the SPID value as input. For example, to kill SPID 9, run the following command:

```sql
KILL 99
```

> [!NOTE]
> The `KILL` command may take up to 30 seconds to complete, due to the interval between checks for the `KILL` command.

## Related content

* [Monitoring performance by using the Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
* [Resolve blocking problems that are caused by lock escalation in SQL Server](../performance/resolve-blocking-problems-caused-lock-escalation.md)
* [Transaction Locking and Row Versioning Guide](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide)
* [SET TRANSACTION ISOLATION LEVEL](/sql/t-sql/statements/set-transaction-isolation-level-transact-sql)
* [Quickstart: Extended events in SQL Server](/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server)
