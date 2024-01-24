---
title: Troubleshoot high-CPU-usage issues in SQL Server
description: This article provides a procedure to help you fix high-CPU-usage issues on a server that is running SQL Server.
ms.date: 03/02/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.reviewer: jopilov, v-jayaramanp
author: prmadhes-msft
ms.author: prmadhes
---
# Troubleshoot high-CPU-usage issues in SQL Server

_Applies to:_ &nbsp; SQL Server

This article provides procedures to diagnose and fix issues that are caused by high CPU usage on a computer that's running Microsoft SQL Server. Although there are many possible causes of high CPU usage that occur in SQL Server, the following ones are the most common causes:

- High logical reads that are caused by table or index scans because of the following conditions:
  - Out-of-date statistics
  - Missing indexes
  - [Parameter sensitive plan (PSP) issues](/azure/azure-sql/identify-query-performance-issues)
  - Poorly designed queries
- Increase in workload

You can use the following steps to troubleshoot high-CPU-usage issues in SQL Server.

## Step 1: Verify that SQL Server is causing high CPU usage

Use one of the following tools to check whether the SQL Server process is actually contributing to high CPU usage:

- Task Manager: On the **Process** tab, check whether the **CPU** column value for **SQL Server Windows NT-64 Bit** is close to 100 percent.
- Performance and Resource Monitor ([perfmon](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731067(v=ws.11)))
  - Counter: `Process/%User Time`, `% Privileged Time`
  - Instance: sqlservr
  
- You can use the following PowerShell script to collect the counter data over a 60-second span:

    ```powershell
    $serverName = $env:COMPUTERNAME
    $Counters = @(
        ("\\$serverName" + "\Process(sqlservr*)\% User Time"), ("\\$serverName" + "\Process(sqlservr*)\% Privileged Time")
    )
    Get-Counter -Counter $Counters -MaxSamples 30 | ForEach {
        $_.CounterSamples | ForEach {
            [pscustomobject]@{
                TimeStamp = $_.TimeStamp
                Path = $_.Path
                Value = ([Math]::Round($_.CookedValue, 3))
            }
            Start-Sleep -s 2
        }
    }
    ```

If `% User Time` is consistently greater than 90 percent (% User Time is the sum of processor time on each processor, its maximum value is 100% * (no of CPUs)), the SQL Server process is causing high CPU usage. However, if `% Privileged time` is consistently greater than 90 percent, your antivirus software, other drivers, or another OS component on the computer is contributing to high CPU usage. You should work with your system administrator to analyze the root cause of this behavior.

## Step 2: Identify queries contributing to CPU usage

If the `Sqlservr.exe` process is causing high CPU usage, by far, the most common reason is SQL Server queries that perform table or index scans, followed by sort, hash operations and loops (nested loop operator or WHILE (T-SQL)). To get an idea of how much CPU the queries are currently using, out of overall CPU capacity, run the following statement:

```sql
DECLARE @init_sum_cpu_time int,
        @utilizedCpuCount int 
--get CPU count used by SQL Server
SELECT @utilizedCpuCount = COUNT( * )
FROM sys.dm_os_schedulers
WHERE status = 'VISIBLE ONLINE' 
--calculate the CPU usage by queries OVER a 5 sec interval 
SELECT @init_sum_cpu_time = SUM(cpu_time) FROM sys.dm_exec_requests
WAITFOR DELAY '00:00:05'
SELECT CONVERT(DECIMAL(5,2), ((SUM(cpu_time) - @init_sum_cpu_time) / (@utilizedCpuCount * 5000.00)) * 100) AS [CPU from Queries as Percent of Total CPU Capacity] 
FROM sys.dm_exec_requests
```

[!INCLUDE [identify-cpu-bound-queries](../../includes/performance/identify-cpu-bound-queries.md)]

## Step 3: Update statistics

After you identify the queries that have the highest CPU consumption, [update statistics](/sql/relational-databases/statistics/statistics#UpdateStatistics) of the tables that are used by these queries. You can use the `sp_updatestats` system stored procedure to update the statistics of all user-defined and internal tables in the current database. For example:

```sql
exec sp_updatestats
```

> [!NOTE]
> The `sp_updatestats` system stored procedure runs `UPDATE STATISTICS` against all user-defined and internal tables in the current database. For regular maintenance, ensure that regularly schedule maintenance is keeping statistics up to date. Use solutions such as [Adaptive Index Defrag](https://github.com/Microsoft/tigertoolbox/tree/master/AdaptiveIndexDefrag) to automatically manage index defragmentation and statistics updates for one or more databases. This procedure automatically chooses whether to rebuild or reorganize an index according to its fragmentation level, among other parameters, and update statistics with a linear threshold.

For more information about `sp_updatestats`, see [sp_updatestats](/sql/relational-databases/system-stored-procedures/sp-updatestats-transact-sql).

If SQL Server is still using excessive CPU capacity, go to the next step.

## Step 4: Add missing indexes

[!INCLUDE [add-missing-indexes](../../includes/performance/add-missing-indexes.md)]

## Step 5: Investigate and resolve parameter-sensitive issues

[!INCLUDE [parameter-sniffing-issues](../../includes/performance/parameter-sniffing-issues.md)]

## Step 6: Investigate and resolve SARGability issues

[!INCLUDE [no-sargability-issue](../../includes/performance/no-sargability-issue.md)]

## Step 7: Disable heavy tracing

Check for [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) or XEvent tracing that affects the performance of SQL Server and causes high CPU usage. For example, using the following events may cause high CPU usage if you trace heavy SQL Server activity:

- Query plan XML events (`query_plan_profile`, `query_post_compilation_showplan`, `query_post_execution_plan_profile`, `query_post_execution_showplan`, `query_pre_execution_showplan`)
- Statement-level events (`sql_statement_completed`, `sql_statement_starting`, `sp_statement_starting`, `sp_statement_completed`)
- Log-in and log-out events (`login`, `process_login_finish`, `login_event`, `logout`)
- Lock events (`lock_acquired`, `lock_cancel`, `lock_released`)
- Wait events (`wait_info`, `wait_info_external`)
- SQL Audit events (depending on the group audited and SQL Server activity in that group)

Run the following queries to identify active XEvent or Server traces:

```sql
PRINT '--Profiler trace summary--'
SELECT traceid, property, CONVERT(VARCHAR(1024), value) AS value FROM::fn_trace_getinfo(
    default)
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
     row_number() over(PARTITION BY t.id order by te.trace_event_id, tc.trace_column_id) AS row_number,
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
     CASE WHEN te.trace_event_id in (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) THEN CAST(1 as bit) ELSE CAST(0 AS BIT) END AS expensive_event FROM sys.traces t CROSS APPLY::fn_trace_geteventinfo(t.id) AS e JOIN sys.trace_events te ON te.trace_event_id = e.eventid JOIN sys.trace_columns tc ON e.columnid = trace_column_id) AS x
GO
PRINT '--XEvent Session Details--'
SELECT sess.NAME 'session_name', event_name, xe_event_name, trace_event_id,
    CASE WHEN xemap.trace_event_id IN(23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
    THEN Cast(1 AS BIT)
ELSE Cast(0 AS BIT)
END AS expensive_event
FROM sys.dm_xe_sessions sess
JOIN sys.dm_xe_session_events evt
ON sess.address = evt.event_session_address
INNER JOIN sys.trace_xe_event_map xemap
ON evt.event_name = xemap.xe_event_name
GO
```

## Step 8: Fix high CPU usage with spinlock contention

To solve common high CPU usage with spinlock contention, see the following sections.

> [!NOTE]
> High CPU may result from spinlock contention on many other spinlock types. For more information on spinlocks, see [Diagnose and resolve spinlock contention on SQL Server](/sql/relational-databases/diagnose-resolve-spinlock-contention).

### SOS_CACHESTORE spinlock contention

If your SQL Server instance experiences heavy `SOS_CACHESTORE` spinlock contention or you notice that your query plans are often removed on unplanned query workloads, see the following article and enable trace flag `T174` by using the `DBCC TRACEON (174, -1)` command:

[FIX: SOS_CACHESTORE spinlock contention on ad hoc SQL Server plan cache causes high CPU usage in SQL Server](https://support.microsoft.com/topic/kb3026083-fix-sos-cachestore-spinlock-contention-on-ad-hoc-sql-server-plan-cache-causes-high-cpu-usage-in-sql-server-798ca4a5-3813-a3d2-f9c4-89eb1128fe68).

If the high-CPU condition is resolved by using `T174`, enable it as a [startup parameter](/sql/tools/configuration-manager/sql-server-properties-startup-parameters-tab) by using SQL Server Configuration Manager.

### Random high CPU due to SOS_BLOCKALLOCPARTIALLIST spinlock contention on large-memory machine

If your SQL Server instance experiences random high CPU due to `SOS_BLOCKALLOCPARTIALLIST` spinlock contention, we recommend that you apply [Cumulative Update 21 for SQL Server 2019](/troubleshoot/sql/releases/sqlserver-2019/cumulativeupdate21). For more information on how to solve the issue, see bug reference [2410400](../../releases/sqlserver-2019/cumulativeupdate21.md#2410400) and [DBCC DROPCLEANBUFFERS](/sql/t-sql/database-console-commands/dbcc-dropcleanbuffers-transact-sql) which provides temporary mitigation.

### Higher CPU with spinlock contention on XVB_list for a high end machine

If your SQL Server instance experiences high CPU scenario caused by spinlock contention on the `XVB_list` spinlock for a high config machine (high-end systems with a large number of newer generation processors (CPUs)), enable the trace flag [TF8102](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8102) together with [TF8101](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8101).

## Step 9: Configure your virtual machine

If you're using a virtual machine, ensure that you aren't overprovisioning CPUs and that they're configured correctly. For more information, see [Troubleshooting ESX/ESXi virtual machine performance issues (2001003)](https://kb.vmware.com/s/article/2001003#CPU%20constraints).

## Step 10: Scale up system to use more CPUs

If individual query instances are using little CPU capacity, but the overall workload of all queries together causes high CPU consumption, consider scaling up your computer by adding more CPUs. Use the following query to find the number of queries that have exceeded a certain threshold of average and maximum CPU consumption per execution and have run many times on the system (make sure that you modify the values of the two variables to match your environment):

```sql
-- Shows queries where Max and average CPU time exceeds 200 ms and executed more than 1000 times
DECLARE @cputime_threshold_microsec INT = 200*1000
DECLARE @execution_count INT = 1000
SELECT qs.total_worker_time/1000 total_cpu_time_ms,
       qs.max_worker_time/1000 max_cpu_time_ms,
       (qs.total_worker_time/1000)/execution_count average_cpu_time_ms,
       qs.execution_count,
       q.[text]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
WHERE (qs.total_worker_time/execution_count > @cputime_threshold_microsec
        OR qs.max_worker_time > @cputime_threshold_microsec )
        AND execution_count > @execution_count
ORDER BY  qs.total_worker_time DESC 
```

## See also

- [High CPU or memory grants may occur with queries that use optimized nested loop or batch sort](decreased-perf-high-cpu-optimized-nested-loop.md)
- [Recommended updates and configuration options for SQL Server with high-performance workloads](recommended-updates-configuration-options.md)
- [Recommended updates and configuration options for SQL Server 2017 and 2016 with high-performance workloads](recommended-updates-configuration-workloads.md)
