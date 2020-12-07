---
title: Understand and resolve blocking problems
description: This article provide instruction on first understanding what blocking is in terms of SQL Server and furthermore how to investigate its occurrence.
ms.date: 09/25/2020
ms.prod-support-area-path: Performance
ms.reviewer: ramakoni
ms.prod: sql
---
# Understand and resolve SQL Server blocking problems

## Objective

The intention of this article is to provide instruction on first understanding what blocking is in terms of SQL Server and furthermore how to investigate its occurrence.  

In this article, the term **connection** refers to a single logged-on session of the database. Each connection appears as a Session ID (SPID). Each of these SPIDs is often referred to as a process, although it is not a separate process context in the usual sense. Rather, each SPID consists of the server resources and data structures necessary to service the requests of a single connection from a given client. A single client application may have one or more connections. From the perspective of SQL Server, there is no difference between multiple connections from a single client application on a single client computer and multiple connections from multiple client applications or multiple client computers; they are atomic. One connection can block another connection, regardless of the source client.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 224453

## What is blocking

Blocking is an unavoidable and by-design characteristic of any relational database management system (RDBMS) with lock-based concurrency. As mentioned previously, in SQL Server, blocking occurs when one session holds a lock on a specific resource and a second SPID attempts to acquire a conflicting lock type on the same resource. Typically, the time frame for which the first SPID locks the resource is small. When the owning session releases the lock, the second connection is then free to acquire its own lock on the resource and continue processing. This is normal behavior and may happen many times throughout the course of a day with no noticeable effect on system performance.

The duration and transaction context of a query determine how long its locks are held and, thereby, their impact on other queries. If the query is not executed within a transaction (and no lock hints are used), the locks for SELECT statements will only be held on a resource at the time it is actually being read, not for the duration of the query. For INSERT, UPDATE, and DELETE statements, the locks are held for the duration of the query, both for data consistency and to allow the query to be rolled back if necessary.

For queries executed within a transaction, the duration for which the locks are held are determined by the type of query, the transaction isolation level, and whether lock hints are used in the query. For a description of locking, lock hints, and transaction isolation levels, see the following topics in SQL Server Books Online:

- Locking in the Database Engine
- Customizing Locking and Row Versioning
- Lock Modes
- Lock Compatibility
- Row Versioning-based Isolation Levels in the Database Engine
- Controlling Transactions (Database Engine)

When locking and blocking persists to the point where there is a detrimental effect on system performance, it is due to one of the following reasons:

- A SPID holds locks on a set of resources for an extended period of time before releasing them. This type of blocking resolves itself over time but can cause performance degradation.

- A SPID holds locks on a set of resources and never releases them. This type of blocking does not resolve itself and prevents access to the affected resources indefinitely.

In the first scenario above, the situation can be very fluid as different SPIDs cause blocking on different resources over time, creating a moving target. For this reason, these situations can be difficult to troubleshoot using SQL Server Management Studio (the go to tool for managing SQL server) and to narrow down the issue to individual queries. In contrast, the second situation results in a consistent state that can be easier to diagnose.

## Methodology for troubleshooting blocking

Regardless of which blocking situation we are in, the methodology for troubleshooting locking is the same. These logical separations are what will dictate the rest of the composition of this article. The concept is to find the head blocker and identify what that query is doing and why it is blocking. Once the problematic query is identified (that is, what is holding locks for the prolonged period), the next step is to analyze and determine why the blocking happening. After we understand the why, we can then make changes by redesigning the query and the transaction.

To briefly enumerate this:

1. Identify the main blocking session (head blocker)

1. Find what query and transaction is causing the blocking (what is holding locks for a prolonged period)

1. Analyze/understand why the prolonged blocking occurs

1. Resolve blocking issue by redesigning query and transaction

Now let’s dive in to discuss how to pinpoint the main blocking session with an appropriate data capture.

## Gathering blocking information

To counteract the difficulty of troubleshooting blocking problems, a database administrator can use SQL scripts that constantly monitor the state of locking and blocking on SQL Server. To gather this data, there are essentially two methods. The first is to snapshot DMVs within SQL Server, and the second is to use XEvents/Profiler Traces to diagnose what was running.

## Gathering DMV information

Referencing DMVs to troubleshoot blocking has the goal of identifying the SPID (Session ID) at the head of the blocking chain and the SQL Statement. Look for victim SPIDs that are being blocked. If any SPID is being blocked by another SPID, then investigate the SPID owning the resource (the blocking SPID). Is that owner SPID being blocked as well or not (the head blocker)? You essentially want to walk the chain to find the head blocker then investigate why it is maintaining its lock. To do this, you can use one of the following methods:

- Right-click the server object, **expand Reports**, expand **Standard Reports**, and then click **Activity – All Blocking Transactions**. This report shows the transactions at the head of blocking chain. If you expand the transaction, the report will show the transactions that are blocked by the head transaction. This report will also show the **Blocking SQL Statement** and the **Blocked SQL Statement**.

- If you already have a particular session identified, you can use `DBCC INPUTBUFFER(<spid>)` to find the last statement that was submitted by a SPID.

- Run the query below to find the actively executing queries and their input buffer. Keep in mind to be populated in sys.dm_exec_requests, the query must be actively executing with SQL.

  ```sql
  select * from sys.dm_exec_requests er cross apply sys.dm_exec_sql_text (sql_handle)
  ```

- Refer to the `master.sys.sysprocesses` listing and reference the blocked column. More information on [sys.sysprocesses](/sql/relational-databases/system-compatibility-views/sys-sysprocesses-transact-sql) here. Any process (active or not) will be listed in `sys.sysprocesses`.

- Open Activity Monitor in SSMS and refer to the **Blocked By** column. Find more information about [Activity Monitor](/sql/relational-databases/performance-monitor/activity-monitor) here.

- Use the sp_who built in stored procedure to query sessions and refer to the **blk** column. More information about [sp_who](/sql/relational-databases/system-stored-procedures/sp-who-transact-sql) here.

- Use the `sys.dm_tran_locks` DMV. More information about [sys.dm_tran_locks](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-locks-transact-sql) here.

- Want to see if you have a long-term open transaction? Run DBCC OPENTRAN. Keep in mind this isn’t great at walking the chain, but rather seeing if you happen to have a long running transaction that may be causing a blocking chain. More information on [DBCC OPENTRAN](/sql/t-sql/database-console-commands/dbcc-opentran-transact-sql) here.

- Reference sys.dm_os_waiting_tasks that is at the thread/task layer of SQL. More information on [sys.dm_os_waiting_tasks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-waiting-tasks-transact-sql) here.

With DMVs, taking snapshots over time will provide data points that will allow you to review blocking over a specified time interval to identify persisted blocking or trends. The go-to tool for CSS to troubleshoot such issues is using the PSSDiag data collector. This tool uses the “SQL Server Perf Stats” to snapshot DMVs referenced above over time. As this tool is constantly evolving, please review the latest public version of [DiagManager](https://github.com/Microsoft/DiagManager) on GitHub.

## Gathering SQL Server trace information

In addition to the above information, it is often necessary to capture a trace of the activities on the server to thoroughly investigate a blocking problem on SQL Server. For example, if a session executes multiple statements within a transaction, only the last statement that was submitted will be represented. However, one of the earlier commands may be the reason locks are still being held. A trace will enable you to see all the commands executed by a session within the current transaction.  

There are now two ways to capture traces in SQL Server; Xevents and Profiler Traces. [SQL Server Profiler](/sql/tools/sql-server-profiler/sql-server-profiler) is the original trace technology and [Xevent Profiler](/sql/relational-databases/extended-events/extended-events) is the newer tracing technology that allows more versatility. Overall there is more flexibility with Xevents and they have less overhead than SQL Server Profiler. For more advanced troubleshooting or longer duration captures, Xevents are better. For shorter capture duration and less intensive events, SQL Server Profiler trace would be sufficient. Due to SQL Server Profiler having a longer presence in the SQL Server product, it is commonly the default tracing tool used but may not always be best.

## SQL Server Profiler trace

Reference the steps identified for [SQL Server Profiler](/sql/tools/sql-server-profiler/create-a-trace-sql-server-profiler) here.

If you choose to not use a default template, keep in mind you’ll want to select Show all events and Show all columns. Additionally, if you are running in a high-volume production environment, you may decide to use only the events in Table 1 as they are typically sufficient to troubleshoot most blocking problems. Including the appended events in Table 2 may make it easier to quickly determine the source of a problem (or these events may be necessary to identify the culprit statement in a multi-statement procedure) at the cost of adding further load on the system and increase the trace output size.

- Table 1: Event types

    |Heading |Event |
    |-|-|
    |Errors and Warnings |Exception |
    |Errors and Warnings |Attention |
    |Security Audit |Audit Login |
    |Security Audit |Audit Logout |
    |Sessions |Existing Connection |
    |Stored Procedures |RPC:Starting |
    |TSQL |SQL:BatchStarting |
    |||

- Table 2: Additional Event types

    |Heading |Event |
    |-|-|
    |Transactions |SQLTransaction |
    |Transactions  |SQLTransaction |
    |Stored Procedures  |RPC:Completed |
    |TSQL|SQL:BatchCompleted |
    |Stored Procedures |SP:StmtStarting |
    |Stored Procedures |SP:StmtCompleted |
    |||

## XEvent Trace

Refer to the document that explains how to use the [Xevent Profiler](/sql/relational-databases/extended-events/use-the-ssms-xe-profiler). With the same trade-off in mind as what’s mentioned in the Profiler section above, we typically will capture:

- Errors:

  - Attention

  - Error_reported

  - Blocked_process_report

  - Exchange_spill

  - Execution_warning

  - Hash_warning

  - Missing_column_statistics

  - Missing_join_predicate

  - Sort_warning

- Execution:

  - Rpc_completed

  - Rpc_starting

  - Sp_cache_remove

  - Sql_batch_completed

  - Sql_batch_starting

  - Sql_statement_recompile

- Lock

  - Lock_deadlock

  - Lock_escalation

  - Lock_timeout

- Session

  - Existing_connection

  - Login

  - Logout

To configure the threshold and frequency at which blocked process reports are generated, use the sp_configure command to configure the blocked process threshold option, which can be set in seconds. By default, no blocked process reports are produced.

## Identifying and resolving common blocking scenarios

By examining the above information, you can determine the cause of most blocking problems. The rest of this article is a discussion of how to use this information to identify and resolve some common blocking scenarios. This discussion assumes you have used the blocking scripts (referenced earlier) to capture information on the blocking SPIDs and have made a XEvent or Profiler trace with the events described above.

## Viewing the blocking script output

- Examine the `sys.sysprocesses` output to determine the heads of the blocking chains

  If you did not specify fast mode for the blocking scripts, there will be a section titled **SPIDs at the head of blocking chains** that lists the SPIDs that are blocking other SPIDs in the script output.

  If you specified the fast option, you can still determine the blocking heads by looking at the `sys.sysprocesses` output and following the hierarchy of the SPID that is reported in the blocked column.

- Examine the `sys.sysprocesses` output for information on the SPIDs at the head of the blocking chain.

  It is important to evaluate the following `sys.sysprocesses` fields:

  Status

  This column shows the status of a particular SPID. Typically, a sleeping status indicates that the SPID has completed execution and is waiting for the application to submit another query or batch. A runnable, running, or `sos_scheduler_yield` status indicates that the SPID is currently processing a query. The following table gives brief explanations of the various status values.

    |Status|Meaning|
    |-|-|
    |Background|The SPID is running a background task, such as deadlock detection.|
    |Sleeping|The SPID is not currently executing. This usually indicates that the SPID is awaiting a command from the application.|
    |Running|The SPID is currently running on a scheduler. |
    |Runnable|The SPID is in the runnable queue of a scheduler and waiting to get scheduler time. |
    |Sos_scheduler_yield|The SPID was running, but it has voluntarily yielded its time slice on the scheduler to allow another SPID to acquire scheduler time.|
    |Suspended|The SPID is waiting for an event, such as a lock or a latch. |
    |Rollback|The SPID is in rollback of a transaction. |
    |Defwakeup|Indicates that the SPID is waiting for a resource that is in the process of being freed. The `waitresource` field should indicate the resource in question. |
    |||

  - `Open_tran`

      This field tells you the transaction nesting level of the SPID. If this value is greater than 0, the SPID is within an open transaction and may be holding locks acquired by any statement within the transaction.

  - `Lastwaittype`, `waittype`, and `waittime`

      The `lastwaittype` field is a string representation of the `waittype` field, which is a reserved internal binary column. If the `waittype` is **0x0000**, the SPID is not currently waiting for anything and the `lastwaittype` value indicates the last `waittype` that the SPID had. If the `waittype` is not zero, the `lastwaittype` value indicates the current `waittype` of the SPID.

      For more information about `sys.dm_os_wait_stats` and a brief description of the different `lastwaittype` and `waittype` values, see SQL Server Books Online.
    
      The `waittime` value can be used to determine if the SPID is making progress. When a query against the `sys.sysprocesses` table returns a value in the `waittime` column that is less than the `waittime` value from a previous query of `sys.sysprocesses`, this indicates that the prior lock was acquired and released and is now waiting on a new lock (assuming non-zero `waittime`). This can be verified by comparing the `waitresource` between `sys.sysprocesses` output.

  - `Waitresource`

      This field indicates the resource that a SPID is waiting on. The following table lists common `waitresource` formats and their meaning:

    |Resource|Format|Example|
    |-|-|-|
    |Table|DatabaseID:ObjectID:IndexID |TAB: 5:261575970:1 <br/>In this case, database ID 5 is the pubs sample database and object ID 261575970 is the titles table and 1 is the clustered index.|
    |Page|DatabaseID:FileID:PageID|PAGE: 5:1:104 <br/>In this case, database ID 5 is pubs, file ID 1 is the primary data file, and page 104 is a page belonging to the titles table.<br/> To identify the object id that the page belongs to, use the DBCC PAGE (dbid, fileid, pageid, output_option) command, and look at the m_objId. For example:<br/>DBCC TRACEON (3604)<br/>DBCC PAGE (5, 1, 104, 3) |
    |Key|DatabaseID:Hobt_id (Hash value for index key) |KEY: 5:72057594044284928 (3300a4f361aa) <br/>In this case, database ID 5 is Pubs, Hobt_ID 72057594044284928 corresponds to non clustered index_id 2 for object id 261575970 (titles table). Use the sys.partitions catalog view to associate the hobt_id to a particular index id and object id. There is no way to unhash the index key hash to a specific index key value. |
    |Row|DatabaseID:FileID:PageID:Slot(row) |RID: 5:1:104:3 <br/>In this case, database ID 5 is pubs, file ID 1 is the primary data file, page 104 is a page belonging to the titles table, and slot 3 indicates the row's position on the page. |
    |Compile|DatabaseID:FileID:PageID:Slot(row)|RID: 5:1:104:3 <br/>In this case, database ID 5 is pubs, file ID 1 is the primary data file, page 104 is a page belonging to the titles table, and slot 3 indicates the row's position on the page. |
    ||||

  - Other columns

      The remaining `sys.sysprocesses` columns can provide insight into the root of a problem as well. Their usefulness varies depending on the circumstances of the problem. For example, you can determine if the problem happens only from certain clients (hostname), on certain network libraries (net_library), when the last batch submitted by a SPID was (last_batch), and so on.

## Examine the DBCC INPUTBUFFER output

For any SPID at the head of a blocking chain or with a non-zero `waittype`, the blocking script will execute `DBCC INPUTBUFFER` to determine the current query for that SPID.

In many cases, this is the query that is causing the locks that are blocking other users to be held. However, if the SPID is within a transaction, the locks may have been acquired by a previously executed query, not the current one. Therefore, you should also view the Profiler output for the SPID, not just the `inputbuffer`.

> [!NOTE]
> Because the blocking script consists of multiple steps, it is possible that a SPID may appear in the first section as the head of a blocking chain, but by the time the DBCC `INPUTBUFFER` query is executed, it is no longer blocking and the `INPUTBUFFER` is not captured. This indicates that the blocking is resolving itself for that SPID and it may or may not be a problem. At this point, you can either use the fast version of the blocking script to try to ensure you capture the `inputbuffer` before it clears (although there is still no guarantee), or view the Profiler data from that time frame to determine what queries the SPID was executing.

## Viewing the Profiler data

Viewing Profiler data efficiently is valuable in resolving blocking issues. The most important thing to realize is that you do not have to look at everything you captured; be selective. Profiler provides capabilities to help you effectively view the captured data. In the **Properties** dialog box (on the **File** menu, click **Properties**), Profiler allows you to limit the data displayed by removing data columns or events, grouping (sorting) by data columns and applying filters. You can search the whole trace or only a specific column for specific values (on the **Edit** menu, click **Find**). You can also save the Profiler data to a SQL Server table (on the **File** menu, point to **Save As** and then click **Table**) and run SQL queries against it.

Be careful that you *perform filtering only on a previously saved trace file*. If you perform these steps on an active trace, you risk losing data that has been captured since the trace was started. Save an active trace to a file or table first (on the **File** menu, click **Save As**) and then reopen it (on the **File** menu, click **Open**) before proceeding. When working on a saved trace file, the filtering does not permanently remove the data being filtered out, it just does not display all the data. You can add and remove events and data columns as needed to help focus your searches.

What to look for:

- What commands has the SPID at the head of a blocking chain executed within the current transaction?
Filter the trace data for a particular SPID that is at the head of a blocking chain (on the File menu, click Properties; then on the **Filters** tab, specify the **SPID** value). You can then examine the commands it has executed prior to the time it was blocking other SPIDs. If you include the Transaction events, they can easily identify when a transaction was started. Otherwise, you can search the `Text` column for `BEGIN`, `SAVE`, `COMMIT`, or `ROLLBACK TRANSACTION` operations. Use the `open_tran` value from the `sysprocesses` table to ensure that you catch all of the transaction events. Knowing the commands executed and the transaction context will allow you to determine why a SPID is holding locks.

  Remember, you can remove events and data columns. Instead of looking at both starting and completed events, choose one. If the blocking SPIDs are not stored procedures, remove the `SP:Starting` or `SP:Completed` events; the SQLBatch and RPC events will show the procedure call. Only view the SP events when you need to see that level of detail.

- What is the duration of the queries for SPIDs at the head of blocking chains?

  If you include the completed events above, the Duration column will show the query execution time. This can help you identify long-running queries that are causing blocking. To determine why the query is performing slowly, view the CPU, Read, and Writes columns, as well as the Execution Plan event.

## Categorizing common blocking scenarios

The table below maps common symptoms to their probable causes. The number indicated in the Scenario column corresponds to the number in the [Common Blocking Scenarios and Resolutions](#common-blocking-scenarios-and-resolutions) section of this article below. The `Waittype`, `Open_Tran`, and `Status` columns refer to `sysprocesses` information. The Resolves? column indicates whether or not the blocking will resolve on its own.

|Scenario|Waittype|Open_Tran|Status|Resolves?|Other Symptoms|
|---|---|---|---|---|---|
|1|Non-zero|>= 0|runnable|Yes, when query finishes.|Physical_IO, CPU and/or **Memusage** columns will increase over time. Duration for the query will be high when completed.|
|2|0x0000|>0|sleeping|No, but SPID can be killed.|An attention signal may be seen in the Profiler trace for this SPID, indicating a query timeout or cancel has occurred.|
|3|0x0000|>= 0|runnable|No. Will not resolve until client fetches all rows or closes connection. SPID can be killed, but it may take up to 30 seconds.|If open_tran = 0, and the SPID holds locks while the transaction isolation level is default (READ COMMMITTED), this is a likely cause.|
|4|Varies|>= 0|runnable|No. Will not resolve until client cancels queries or closes connections. SPIDs can be killed, but may take up to 30 seconds.|The hostname column in `sysprocesses` for the SPID at the head of a blocking chain will be the same as one of the SPID it is blocking.|
|5|0x0000|>0|rollback|Yes.|An attention signal may be seen in the Profiler trace for this SPID, indicating a query timeout or cancel has occurred, or simply a rollback statement has been issued.|
|6|0x0000|>0|sleeping|Eventually. When Windows NT determines the session is no longer active, the SQL Server connection will be broken.|The last_batch value in `sysprocesses` is much earlier than the current time.|
|||||||

## Common blocking scenarios and resolutions

The scenarios listed below will have the characteristics listed in the table above. This section provides additional details when applicable, as well as paths to resolution.

1. Blocking Caused by a Normally Running Query with a Long Execution Time

   Resolution:

   The solution to this type of blocking problem is to look for ways to optimize the query. Actually, this class of blocking problem may just be a performance problem, and require you to pursue it as such. For information on troubleshooting a specific slow-running query, see [How to troubleshoot slow-running queries on SQL Server 7.0 or on later versions](https://support.microsoft.com/help/243589).

   For more information, see [Performance Monitoring and Tuning How-to Topics](/previous-versions/sql/sql-server-2008-r2/ms187830(v=sql.105)).

   If you have a long-running query that is blocking other users and cannot be optimized, consider moving it from an OLTP environment to a decision support system.

2. Blocking Caused by a Sleeping SPID That Has Lost Track of the Transaction Nesting Level

   This type of blocking can often be identified by a SPID that is sleeping or awaiting a command, yet whose transaction nesting level (`@@TRANCOUNT`, `open_tran` from `sysprocesses`) is greater than zero. This can occur if the application experiences a query timeout, or issues a cancel without also issuing the required number of ROLLBACK and/or COMMIT statements. When a SPID receives a query timeout or a cancel, it will terminate the current query and batch, but does not automatically roll back or commit the transaction. The application is responsible for this, as SQL Server cannot assume that an entire transaction must be rolled back due to a single query being canceled. The query timeout or cancel will appear as an ATTENTION signal event for the SPID in the Profiler trace.

   To demonstrate this, issue the following query from Query Analyzer:

    ```sql
    BEGIN TRAN
    SELECT * FROM SYSOBJECTS S1, SYSOBJECTS S2

    -- Issue this after canceling query
    SELECT @@TRANCOUNT
    ROLLBACK TRAN
    ```

   While the query is executing, click the red **Cancel** button. After the query is canceled, `SELECT @@TRANCOUNT` indicates that the transaction nesting level is one. Had this been a `DELETE` or an `UPDATE` query, or had `HOLDLOCK` been used on the `SELECT`, all the locks acquired would still be held. Even with the query above, if another query had acquired and held locks earlier in the transaction, they would still be held when the above `SELECT` was canceled.

   Resolutions:

   - Applications must properly manage transaction nesting levels, or they may cause a blocking problem following the cancellation of the query in this manner. This can be accomplished in one of several ways:

     1. In the error handler of the client application, submit an `IF @@TRANCOUNT > 0 ROLLBACK TRAN` following any error, even if the client application does not believe a transaction is open. This is required, because a stored procedure called during the batch could have started a transaction without the client application's knowledge. Certain conditions, such as canceling the query, prevent the procedure from executing past the current statement, so even if the procedure has logic to check `IF @@ERROR <> 0` and abort the transaction, this rollback code will not be executed in such cases.

     1. Use `SET XACT_ABORT ON` for the connection, or in any stored procedures that begin transactions and are not cleaning up following an error. In the event of a run-time error, this setting will abort any open transactions and return control to the client.

        > [!NOTE]
        > T-SQL statements following the statement that caused the error will not be executed.

     1. If connection pooling is being used in an application that opens the connection and runs a small number of queries before releasing the connection back to the pool, such as a Web-based application, temporarily disabling connection pooling may help alleviate the problem until the client application is modified to handle the errors appropriately. By disabling connection pooling, releasing the connection will cause a physical logout of the SQL Server connection, resulting in the server rolling back any open transactions.

     1. If connection pooling is enabled and the destination server is SQL Server 2000, upgrading the client computer to MDAC 2.6 or later may be beneficial. This version of the MDAC components adds code to the ODBC driver and OLE DB provider so that the connection would be reset before it is reused. This call to `sp_reset_connection` aborts any server-initiated transactions (DTC transactions initiated by the client app are not affected), resets the default database, SET options, and so forth.

        > [!NOTE]
        > The connection is not reset until it is reused from the connection pool, so it is possible that a user could open a transaction and then release the connection to the connection pool, but it might not be reused for several seconds, during which time the transaction would remain open. If the connection is not reused, the transaction will be aborted when the connection times out and is removed from the connection pool. Thus, it is optimal for the client application to abort transactions in their error handler or use `SET XACT_ABORT ON` to avoid this potential delay.

   - Actually, this class of blocking problem may also be a performance problem, and require you to pursue it as such. If the query execution time can be diminished, the query timeout or cancel would not occur. It is important that the application be able to handle the timeout or cancel scenarios should they arise, but you may also benefit from examining the performance of the query.

3. Blocking Caused by a SPID Whose Corresponding Client Application Did Not Fetch All Result Rows to Completion

   After sending a query to the server, all applications must immediately fetch all result rows to completion. If an application does not fetch all result rows, locks can be left on the tables, blocking other users. If you are using an application that transparently submits SQL statements to the server, the application must fetch all result rows. If it does not (and if it cannot be configured to do so), you may be unable to resolve the blocking problem. To avoid the problem, you can restrict poorly behaved applications to a reporting or a decision-support database.

   Resolution:

   The application must be rewritten to fetch all rows of the result to completion.

4. Blocking Caused by a Distributed Client/Server Deadlock

   Unlike a conventional deadlock, a distributed deadlock is not detectable using the RDBMS lock manager. This is due to the fact that only one of the resources involved in the deadlock is a SQL Server lock. The other side of the deadlock is at the client application level, over which SQL Server has no control. The following are two examples of how this can happen, and possible ways the application can avoid it.

   - Client/Server Distributed Deadlock with a Single Client Thread

     If the client has multiple open connections, and a single thread of execution, the following distributed deadlock may occur. For brevity, the term `dbproc` used here refers to the client connection structure.

        ```console
        SPID1------blocked on lock------->SPID2
         /\ (waiting to write results
         | back to client)
         | |
         | | Server side
         | ================================|==================================
         | <-- single thread --> | Client side
         | \/
         dbproc1 <------------------- dbproc2
         (waiting to fetch (effectively blocked on dbproc1, awaiting
         next row) single thread of execution to run)
        ```

     In the case shown above, a single client application thread has two open connections. It asynchronously submits a SQL operation on dbproc1. This means it does not wait on the call to return before proceeding. The application then submits another SQL operation on dbproc2, and awaits the results to start processing the returned data. When data starts coming back (whichever dbproc first responds--assume this is dbproc1), it processes to completion all the data returned on that dbproc. It fetches results from dbproc1 until SPID1 gets blocked on a lock held by SPID2 (because the two queries are running asynchronously on the server). At this point, dbproc1 will wait indefinitely for more data. SPID2 is not blocked on a lock, but tries to send data to its client, dbproc2. However, dbproc2 is effectively blocked on dbproc1 at the application layer as the single thread of execution for the application is in use by dbproc1. This results in a deadlock that SQL Server cannot detect or resolve because only one of the resources involved is a SQL Server resource.

   - Client/Server Distributed Deadlock with a Thread per Connection

     Even if a separate thread exists for each connection on the client, a variation of this distributed deadlock may still occur as shown by the following.

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

     This case is similar to Example A, except dbproc2 and SPID2 are running a `SELECT` statement with the intention of performing row-at-a-time processing and handing each row through a buffer to dbproc1 for an `INSERT`, `UPDATE`, or `DELETE` statement on the same table. Eventually, SPID1 (performing the `INSERT`, `UPDATE`, or `DELETE`) becomes blocked on a lock held by SPID2 (performing the `SELECT`). SPID2 writes a result row to the client dbproc2. Dbproc2 then tries to pass the row in a buffer to dbproc1, but finds dbproc1 is busy (it is blocked waiting on SPID1 to finish the current `INSERT`, which is blocked on SPID2). At this point, dbproc2 is blocked at the application layer by dbproc1 whose SPID (SPID1) is blocked at the database level by SPID2. Again, this results in a deadlock that SQL Server cannot detect or resolve because only one of the resources involved is a SQL Server resource.

5. Both examples A and B are fundamental issues that application developers must be aware of. They must code applications to handle these cases appropriately.

   Resolutions:

   Two reliable solutions are to use either a query timeout or bound connections.

   - Query Timeout

     When a query timeout has been provided, if the distributed deadlock occurs, it will be broken when timeout happens. See the DB-Library or ODBC documentation for more information on using a query timeout.

   - Bound Connections

      This feature allows a client having multiple connections to bind them into a single transaction space, so the connections do not block each other. For more information, see the "Using Bound Connections" topic in SQL Server 7.0 Books Online.

6. Blocking Caused by a SPID That Is in a Golden, or Rollback, State

   A data modification query that is KILLed, or canceled outside of a user-defined transaction, will be rolled back. This can also occur as a side effect of the client computer restarting and its network session disconnecting. Likewise, a query selected as the deadlock victim will be rolled back. A data modification query often cannot be rolled back any faster than the changes were initially applied. For example, if a `DELETE`, `INSERT`, or `UPDATE` statement had been running for an hour, it could take at least an hour to roll back. This is expected behavior, because the changes made must be rolled back, or transactional and physical integrity in the database would be compromised. Because this must happen, SQL Server marks the SPID in a golden or rollback state (which means it cannot be KILLed or selected as a deadlock victim). This can often be identified by observing the output of `sp_who`, which may indicate the ROLLBACK command. The Status column of `sys.sysprocesses` will indicate a ROLLBACK status, which will also appear in `sp_who` output or in SQL Server Management Studio Activity Monitor.

   Resolution:

   You must wait for the SPID to finish rolling back the changes that were made.

   If the server is shut down in the middle of this operation, the database will be in recovery mode upon restarting, and it will be inaccessible until all open transactions are processed. Startup recovery takes essentially the same amount of time per transaction as run-time recovery, and the database is inaccessible during this period. Thus, forcing the server down to fix a SPID in a rollback state will often be counterproductive.

   To avoid this situation, do not perform large batch `INSERT`, `UPDATE`, or `DELETE` operations during busy hours on OLTP systems. If possible, perform such operations during periods of low activity.

7. Blocking Caused by an Orphaned Connection

   If the client application traps or the client workstation is restarted, the network session to the server may not be immediately canceled under some conditions. From the server's perspective, the client still appears to be present, and any locks acquired may still be retained. For more information, see [How to troubleshoot orphaned connections in SQL Server](https://support.microsoft.com/help/137983).

   Resolution:

   If the client application has disconnected without appropriately cleaning up its resources, you can terminate the SPID by using the `KILL` command. The `KILL` command takes the SPID value as input. For example, to kill SPID 9, issue the following command:

   ```console
   KILL 9
   ```

   > [!NOTE]
   > The `KILL` command may take up to 30 seconds to complete, due to the interval between checks for the `KILL` command.

## Application involvement in blocking problems

There may be a tendency to focus on server-side tuning and platform issues when facing a blocking problem. However, this does not usually lead to a resolution, and can absorb time and energy better directed at examining the client application and the queries it submits. No matter what level of visibility the application exposes regarding the database calls being made, a blocking problem nonetheless frequently requires both the inspection of the exact SQL statements submitted by the application and the application's exact behavior regarding query cancellation, connection management, fetching all result rows, and so on. If the development tool does not allow explicit control over connection management, query cancellation, query timeout, result fetching, and so on, blocking problems may not be resolvable. This potential should be closely examined before selecting an application development tool for SQL Server, especially for business-critical OLTP environments.

It is vital that great care be exercised during the design and construction phase of the database and application. In particular, the resource consumption, isolation level, and transaction path length should be evaluated for each query. Each query and transaction should be as lightweight as possible. Good connection management discipline must be exercised. If this is not done, it is possible that the application may appear to have acceptable performance at low numbers of users, but the performance may degrade significantly as the number of users scales upward.

With proper application and query design, SQL Server is capable of supporting many thousands of simultaneous users on a single server, with little blocking.
