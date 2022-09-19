- For currently executing statements, check **total_elapsed_time** and **cpu_time** columns in [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql). Run the following query to get the data:

   ```sql
   SELECT 
      req.session_id
      , req.total_elapsed_time AS duration_ms
      , req.cpu_time AS cpu_time_ms
      , req.total_elapsed_time - req.cpu_time AS wait_time
      , req.logical_reads
      , SUBSTRING (REPLACE (REPLACE (SUBSTRING (ST.text, (req.statement_start_offset/2) + 1, 
         ((CASE statement_end_offset
             WHEN -1
             THEN DATALENGTH(ST.text)  
             ELSE req.statement_end_offset
           END - req.statement_start_offset)/2) + 1) , CHAR(10), ' '), CHAR(13), ' '), 
        1, 512)  AS statement_text  
   FROM sys.dm_exec_requests AS req
      CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) AS ST
   ORDER BY total_elapsed_time DESC;
   ```

- For past executions of the query, check **last_elapsed_time** and **last_worker_time** columns in [sys.dm_exec_query_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql). Run the following query to get the data:

   ```sql
   SELECT t.text,
       (qs.total_elapsed_time/1000) / qs.execution_count AS avg_elapsed_time,
       (qs.total_worker_time/1000) / qs.execution_count AS avg_cpu_time,
       ((qs.total_elapsed_time/1000) / qs.execution_count ) - ((qs.total_worker_time/1000) / qs.execution_count) AS avg_wait_time,
       qs.total_logical_reads / qs.execution_count AS avg_logical_reads,
       qs.total_logical_writes / qs.execution_count AS avg_writes,
       (qs.total_elapsed_time/1000) AS cumulative_elapsed_time_all_executions
   FROM sys.dm_exec_query_stats qs
       CROSS apply sys.Dm_exec_sql_text (sql_handle) t
   WHERE t.text like '<Your Query>%'
   -- Replace <Your Query> with your query or the beginning part of your query. The special chars like '[','_','%','^' in the query should be escaped.
   ORDER BY (qs.total_elapsed_time / qs.execution_count) DESC
   ```

  > [!Note]
  > If `avg_wait_time` shows a negative value, it's a [parallel query](../../performance/troubleshoot-query-perf-between-servers.md#parallel-queries---runner-or-waiter).

- If you can execute the query on demand in SQL Server Management Studio (SSMS) or Azure Data Studio, run it with [SET STATISTICS TIME](/sql/t-sql/statements/set-statistics-time-transact-sql) `ON` and [SET STATISTICS IO](/sql/t-sql/statements/set-statistics-io-transact-sql) `ON`.

   ```sql
   SET STATISTICS TIME ON
   SET STATISTICS IO ON
   <YourQuery>
   SET STATISTICS IO OFF
   SET STATISTICS TIME OFF
   ```

  Then from **Messages**, you'll see the CPU time, elapsed time, and logical reads like this:

   ```output
    Table 'tblTest'. Scan count 1, logical reads 3, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

    SQL Server Execution Times:
      CPU time = 460 ms,  elapsed time = 470 ms.
   ```

- <a name="query_timestats_from_plan"></a>If you can collect a query plan, check the data from the [Execution plan properties](/sql/ssms/scripting/use-the-properties-window-in-management-studio#to-view-the-properties-of-a-showplan-operator).

  1. Run the query with **Include Actual Execution Plan** on.
  1. Select the left-most operator from **Execution plan**.
  1. From **Properties**, expand **QueryTimeStats** property.
  1. Check **ElapsedTime** and **CpuTime**.

     :::image type="content" source="../../media/collect-query-time-logical-reads/query-time-stats-from-query-plan.png" alt-text="Screenshot of the SQL Server execution plan properties window with the property QueryTimeStats expanded.":::
