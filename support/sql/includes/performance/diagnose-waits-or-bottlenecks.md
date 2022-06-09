To optimize a query that's waiting on bottlenecks, identify how long the wait is and where the bottleneck is. Once the [wait type](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes) is confirmed, reduce the wait time or eliminate the wait completely.

To get the rough wait time, subtract the CPU time (worker time) from the elapsed time of a query. Typically, the CPU time is the actual execution time, and the remaining part of the lifetime of the query is waiting.

### Identify the bottleneck or wait

- To identify historical long-waiting queries (>20% of the overall elapsed time) since the start of SQL Server, run the following query:

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

- If you can collect a query plan, check the **WaitStats** from the execution plan properties. Check the last item in [Collect Elapsed time, CPU time and Logical Reads](../../performance/troubleshoot-query-perf-between-servers.md#collect-elapsed-time-cpu-time-and-logical-reads) section for detailed steps.

- If you're familiar with [PSSDiag/SQLdiag](https://github.com/microsoft/diagmanager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) LightPerf/GeneralPerf scenarios, consider using either of them to collect performance statistics and identify waiting queries on your SQL Server instance. Check the second method to [compare the performance for two or more queries](../../performance/troubleshoot-query-perf-between-servers.md#step-1-determine-whether-its-a-common-issue-with-multiple-queries).

### Resources to eliminate or reduce the wait

The causes and resolutions vary according to the wait types. There's no general method to resolve all wait types. Here are articles to troubleshoot and resolve common wait type issues:

- [Understanding and resolving blocking issues](../../performance/understand-resolve-blocking.md)
- [Troubleshoot slow SQL Server performance caused by I/O issues](../../performance/troubleshoot-sql-io-performance.md)
- [WRITELOG waits and common causes](../../performance/troubleshoot-sql-io-performance.md#writelog)
- [Resolve last-page insert PAGELATCH_EX contention in SQL Server](../../performance/resolve-pagelatch-ex-contention.md)
- [Memory grants explanation and solutions](https://techcommunity.microsoft.com/t5/sql-server-support-blog/memory-grants-the-mysterious-sql-server-memory-consumer-with/ba-p/333994)
- [Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type](../../performance/troubleshoot-query-async-network-io.md)
