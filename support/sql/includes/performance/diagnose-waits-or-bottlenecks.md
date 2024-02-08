To optimize a query that's waiting on bottlenecks, identify how long the wait is and where the bottleneck is (the wait type). Once the [wait type](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes) is confirmed, reduce the wait time or eliminate the wait completely.

To calculate the approximate wait time, subtract the CPU time (worker time) from the elapsed time of a query. Typically, the CPU time is the actual execution time, and the remaining part of the lifetime of the query is waiting.

Examples of how to calculate approximate wait duration:

|Elapsed Time (ms)|CPU Time (ms)|Wait time (ms)|
|-----------------|-------------|--------------|
|   3200          | 3000        | 200          |
|   7080          | 1000        | 6080         |

### Identify the bottleneck or wait

- To identify historical long-waiting queries (for example, >20% of the overall elapsed time is wait time), run the following query. This query uses performance statistics for cached query plans since the start of SQL Server. 

   ```sql
   SELECT t.text,
           qs.total_elapsed_time / qs.execution_count
           AS avg_elapsed_time,
           qs.total_worker_time / qs.execution_count
           AS avg_cpu_time,
           (qs.total_elapsed_time - qs.total_worker_time) / qs.execution_count
           AS avg_wait_time,
           qs.total_logical_reads / qs.execution_count
           AS avg_logical_reads,
           qs.total_logical_writes / qs.execution_count
           AS avg_writes,
           qs.total_elapsed_time
           AS cumulative_elapsed_time
   FROM sys.dm_exec_query_stats qs
           CROSS apply sys.Dm_exec_sql_text (sql_handle) t
   WHERE (qs.total_elapsed_time - qs.total_worker_time) / qs.total_elapsed_time
           > 0.2
   ORDER BY qs.total_elapsed_time / qs.execution_count DESC
   ```

- To identify currently executing queries with waits longer than 500 ms, run the following query:

   ```sql
   SELECT r.session_id, r.wait_type, r.wait_time AS wait_time_ms
   FROM sys.dm_exec_requests r 
     JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id 
   WHERE wait_time > 500
   AND is_user_process = 1
   ```

- If you can collect a query plan, check the **WaitStats** from the [execution plan properties](/sql/ssms/scripting/use-the-properties-window-in-management-studio#to-view-the-properties-of-a-showplan-operator) in SSMS:
  1. Run the query with **Include Actual Execution** Plan on.
  1. Right-click the left-most operator in the **Execution plan** tab
  1. Select **Properties** and then **WaitStats** property.
  1. Check the **WaitTimeMs** and **WaitType**.


- If you're familiar with [PSSDiag/SQLdiag](https://github.com/microsoft/diagmanager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) LightPerf/GeneralPerf scenarios, consider using either of them to collect performance statistics and identify waiting queries on your SQL Server instance. You can import the collected data files and analyze the performance data with [SQL Nexus](https://github.com/microsoft/SqlNexus).

### References to help eliminate or reduce waits

The causes and resolutions for each wait type vary. There's no one general method to resolve all wait types. Here are articles to troubleshoot and resolve common wait type issues:

- [Understand and resolve blocking issues (LCK_M_*)](../../performance/understand-resolve-blocking.md)
- [Understand and resolve Azure SQL Database blocking problems](/azure/azure-sql/database/understand-resolve-blocking)
- [Troubleshoot slow SQL Server performance caused by I/O issues (PAGEIOLATCH_*, WRITELOG, IO_COMPLETION, BACKUPIO)](../../performance/troubleshoot-sql-io-performance.md)
- [Resolve last-page insert PAGELATCH_EX contention in SQL Server](../../performance/resolve-pagelatch-ex-contention.md)
- [Memory grants explanations and solutions (RESOURCE_SEMAPHORE)](../../database-engine/performance/troubleshoot-memory-grant-issues.md)
- [Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type](../../performance/troubleshoot-query-async-network-io.md)
- [Troubleshooting High HADR_SYNC_COMMIT wait type with Always On Availability Groups](https://techcommunity.microsoft.com/t5/sql-server-blog/troubleshooting-high-hadr-sync-commit-wait-type-with-always-on/ba-p/385369)
- [How It Works: CMEMTHREAD and Debugging Them](https://techcommunity.microsoft.com/t5/sql-server-support-blog/how-it-works-cmemthread-and-debugging-them/ba-p/317488)
- [Making parallelism waits actionable (CXPACKET and CXCONSUMER)](https://techcommunity.microsoft.com/t5/sql-server-blog/making-parallelism-waits-actionable/ba-p/385691)
- [THREADPOOL wait](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#threadpool)

For descriptions of many Wait types and what they indicate, see the table in [Types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).
