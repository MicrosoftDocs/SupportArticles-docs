---
title: Troubleshoot high CPU usage issues
description: Provides step-by-step procedure to help fix high CPU usage issues for a server that is running SQL Server.
ms.date: 11/05/2021
ms.prod-support-area-path: Performance
ms.topic: troubleshooting
ms.prod: sql
author: cobibi 
ms.author: v-yunhya
---

# Troubleshoot high CPU usage issues in SQL Server

This article provides step-by-step procedure to diagnose and fix high CPU usage issues on a computer that is running SQL Server.

See the following possible causes of most high CPU usage issues:

- High logical reads that are caused by table or index scans because of:
  - Out-of-date statistics
  - Missing indexes
  - [Parameter sensitive plan (PSP) issues](/azure/azure-sql/identify-query-performance-issues)
  - Poorly designed queries
- Increase in workload

You can use the following steps to troubleshoot high CPU usage issues in SQL Server.

## Step 1: Verify that SQL Server is causing high CPU

You can use one of the following tools to check if SQL Server process is indeed contributing to high CPU:

- Task Manager (Under Process tab, check CPU value for *SQL Server Windows NT-64 Bit* is close to 100%)
- Performance and Resource Monitor ([perfmon](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731067(v=ws.11)))
  - Counter: Process/%User Time, % Privileged Time
  - Instance:sqlservr
  > If you notice that % User Time is consistently above 90%, then it is a confirmation that SQL Server process is causing high CPU. But, if you notice that % Privileged time is consistently above 90% it is an indication that either anti-virus software or other drivers or another OS component on the computer are contributing to the high CPU. You should work with your system administartor to analyze the root cause of this behavior.

## Step 2: Identify queries contributing to CPU usage 

If the sqlservr.exe process is indeed causing the high CPU, identify the queries that are contributing to high CPU by using the following query:

```sql
SELECT TOP 10 s.session_id,
           r.status,
           r.cpu_time,
           r.logical_reads,
           r.reads,
           r.writes,
           r.total_elapsed_time / (1000 * 60) 'Elaps M',
           SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
           ((CASE r.statement_end_offset
                WHEN -1 THEN DATALENGTH(st.TEXT)
                ELSE r.statement_end_offset
            END - r.statement_start_offset) / 2) + 1) AS statement_text,
           COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
           + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
           r.command,
           s.login_name,
           s.host_name,
           s.program_name,
           s.last_request_end_time,
           s.login_time,
           r.open_transaction_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
WHERE r.session_id != @@SPID
ORDER BY r.cpu_time DESC
```

## Step 3: Update statistics

After you identify the queries with the highest CPU consumption, [update statistics](/sql/relational-databases/statistics/statistics#UpdateStatistics) for relevant tables, which are involved in these queries.

Then, if SQL is still using high CPU, proceed to the next step.

## Step 4: Add potential missing indexes

1. Use the following query to get the estimated execution plan of the highest CPU bound query.

    ```sql
    -- Captures the Total CPU time spent by a query along with the plan handle
    SELECT highest_cpu_queries.plan_handle,
           highest_cpu_queries.total_worker_time,
           q.dbid,
           q.objectid,
           q.number,
           q.encrypted,
           q.[text]
    FROM
      (SELECT TOP 50 qs.plan_handle,
                  qs.total_worker_time
       FROM sys.dm_exec_query_stats qs
       ORDER BY qs.total_worker_time DESC) AS highest_cpu_queries CROSS apply sys.dm_exec_sql_text(plan_handle) AS q
    ORDER BY highest_cpu_queries.total_worker_time DESC 
    
    -- Replace the Plan handle with the value obtained from above query.
    SELECT *
    FROM sys.dm_exec_query_plan (plan_handle)
    ```

1. Review the execution plan and tune the query by implementing the required changes.
1. Use the following [Dynamic Management View](/analysis-services/instances/use-dynamic-management-views-dmvs-to-monitor-analysis-services) (DMV) query to check the missing indexes and apply any recommended indexes with high improvement measures.

    ```sql
    SELECT CONVERT (VARCHAR(30),
        GETDATE(),
        126) AS runtime,
        mig.index_group_handle,
        mid.index_handle,
        CONVERT (DECIMAL (28, 1),
                migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) AS improvement_measure,
                'CREATE INDEX missing_index_' + CONVERT (VARCHAR, mig.index_group_handle) + '_' + CONVERT (VARCHAR, mid.index_handle) 
                + ' ON ' + mid.statement + ' (' + ISNULL (mid.equality_columns,
                '') + CASE WHEN mid.equality_columns IS NOT NULL
                            AND mid.inequality_columns IS NOT NULL THEN ','
                        ELSE ''
                      END + ISNULL (mid.inequality_columns,
                    '') + ')' + ISNULL (' INCLUDE (' + mid.included_columns + ')',
                    '') AS create_index_statement,
        migs.*,
        mid.database_id,
        mid.[object_id]
    FROM sys.dm_db_missing_index_groups mig
    INNER JOIN sys.dm_db_missing_index_group_stats migs ON migs.group_handle = mig.index_group_handle
    INNER JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
    WHERE CONVERT (DECIMAL (28, 1),
                   migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) > 10
    ORDER BY migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans) DESC
    ```

## Step 5: Investigate parameter sensitive issues

Use the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command to check whether the high CPU usage issue is fixed.

If the issue still exists, you can add a `RECOMPILE` query hint to each of the high CPU queries that are identified in [step 2](#step-2-check-any-possible-queries-that-cause-the-issue).

If the issue is fixed, it's an indication of parameter sensitive problem (PSP/parameter sniffing issue). To mitigate the parameter sensitive issues, you can use the following methods. Each method has associated tradeoffs and drawbacks:

- Use the [RECOMPILE](/sql/t-sql/queries/hints-transact-sql-query#recompile) query hint at each query execution. This workaround balances compilation time and increased CPU for better plan quality. For workloads that require high throughput, the recompile option is usually not possible.

- Use the [option (OPTIMIZE FOR…)](/sql/t-sql/queries/hints-transact-sql-query#optimize-for--variable_name--unknown---literal_constant-_---n--) query hint to override the actual parameter value with a typical parameter value that produces a plan that's good enough for most parameter value possibilities. This option requires a full understanding of optimal parameter values and associated plan characteristics.

- Use the [option (OPTIMIZE FOR UNKNOWN)](/sql/t-sql/queries/hints-transact-sql-query#optimize-for-unknown) query hint to override the actual parameter value with density vector average. You can also do this by capturing the incoming parameter values in local variables and then using the local variables within the predicates instead of using the parameters themselves. For this fix, the average density must be good enough.

- Use the [DISABLE_PARAMETER_SNIFFING](/sql/t-sql/queries/hints-transact-sql-query#use_hint) query hint to disable parameter sniffing entirely.

- Use the [KEEPFIXED PLAN](/sql/t-sql/queries/hints-transact-sql-query#keepfixed-plan) query hint to prevent recompilations in cache. This workaround assumes that the good enough common plan is the one in cache already. You can also disable automatic statistics updates to reduce the chances that the good plan will be evicted and a new bad plan will be compiled.

- Using the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command is a temporary solution until the application code is fixed.

## Step 6: Disable heavy tracing

Check [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) or XEvent tracing that impacts SQL performance and causes high CPU usage. For example, the events are SQL Audit, events cause high XML plans, statement event level events, login/logout, locks, and waits.

Run these queries to identify active XEvent or Server traces:

```sql
PRINT '--Profiler trace summary--'
SELECT traceid, property, CONVERT (VARCHAR(1024), value) AS value FROM :: fn_trace_getinfo(default)
GO
PRINT '--Trace event details--'
      SELECT trace_id,
            status,
            CASE WHEN row_number = 1 THEN path ELSE NULL end AS path,
            CASE WHEN row_number = 1 THEN max_size ELSE NULL end AS max_size,
            CASE WHEN row_number = 1 THEN start_time ELSE NULL end AS start_time,
            CASE WHEN row_number = 1 THEN stop_time ELSE NULL end AS stop_time,
            max_files, 
            is_rowset, 
            is_rollover,
            is_shutdown,
            is_default,
            buffer_count,
            buffer_size,
            last_event_time,
            event_count,
            trace_event_id, 
            trace_event_name, 
            trace_column_id,
            trace_column_name,
            expensive_event   
      FROM 
            (SELECT t.id AS trace_id, 
                  row_number() over (PARTITION BY t.id order by te.trace_event_id, tc.trace_column_id) AS row_number, 
                  t.status, 
                  t.path, 
                  t.max_size, 
                  t.start_time,
                  t.stop_time, 
                  t.max_files, 
                  t.is_rowset, 
                  t.is_rollover,
                  t.is_shutdown,
                  t.is_default,
                  t.buffer_count,
                  t.buffer_size,
                  t.last_event_time,
                  t.event_count,
                  te.trace_event_id, 
                  te.name AS trace_event_name, 
                  tc.trace_column_id,
                  tc.name AS trace_column_name,
                  CASE WHEN te.trace_event_id in (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
                  THEN CAST(1 as bit) ELSE CAST(0 AS BIT) END AS expensive_event
            FROM sys.traces t 
                  CROSS APPLY ::fn_trace_geteventinfo(t .id) AS e 
                  JOIN sys.trace_events te ON te.trace_event_id = e.eventid 
                  JOIN sys.trace_columns tc ON e.columnid = trace_column_id) AS x
GO
PRINT '--XEvent Session Details--'
SELECT sess.NAME 'session_name', event_name,xe_event_name, trace_event_id,
CASE
 WHEN xemap.trace_event_id IN ( 23, 24, 40, 41,44, 45, 51, 52,54, 68, 96, 97,98, 113, 114, 122,146, 180 )
 THEN Cast(1 AS BIT) ELSE Cast(0 AS BIT)
END AS expensive_event
FROM sys.dm_xe_sessions sess
  JOIN sys.dm_xe_session_events evt
  ON sess.address = evt.event_session_address
INNER JOIN sys.trace_xe_event_map xemap
  ON evt.event_name = xemap.xe_event_name
GO
```

## Step 7: Fix SOS_CACHESTORE spinlock contention

If your SQL Server experiences heavy `SOS_CACHESTORE spinlock` contention or you notice that your query plans are often evicted on ad hoc query workloads, review the following article and enable trace flag T174 by using the `DBCC TRACEON (174, -1)` command. If the high CPU condition is resolved with T174, enable it as a [startup parameter](/sql/tools/configuration-manager/sql-server-properties-startup-parameters-tab) by using SQL Server configuration manager.

[FIX: SOS_CACHESTORE spinlock contention on ad hoc SQL Server plan cache causes high CPU usage in SQL Server](https://support.microsoft.com/topic/kb3026083-fix-sos-cachestore-spinlock-contention-on-ad-hoc-sql-server-plan-cache-causes-high-cpu-usage-in-sql-server-798ca4a5-3813-a3d2-f9c4-89eb1128fe68)

## Step 8: Configure your virtual machine

If you are using a virtual machine, ensure that you aren't overprovisioning CPUs and that they are configured properly. For more information, see [Troubleshooting ESX/ESXi virtual machine performance issues (2001003)](https://kb.vmware.com/s/article/2001003#CPU%20constraints).

## Step 9: Scale up SQL Server

If individual query instances are using little CPU, but the workload of them reaches a high CPU level, you should consider scaling up your computer by adding more CPUs.

## See also

- [High CPU usage occurs in your queries](high-cpu-use-occurs-queries.md)
- [Updates and configuration for workloads](recommended-updates-configuration-options.md) (SQL Server 2012 and SQL Server 2014 versions)
- [Recommended updates and configuration options for SQL Server 2016 and later versions with high-performance workloads](recommended-updates-configuration-workloads.md)
