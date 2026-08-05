---
title: Troubleshoot High CPU Usage Issues in SQL Server
description: Troubleshoot high CPU usage in SQL Server by identifying CPU-intensive queries and apply targeted fixes to restore performance.
ms.date: 08/05/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.topic: troubleshooting
ms.reviewer: prmadhes, jopilov
ai-usage: ai-assisted
---

# Troubleshoot high-CPU-usage issues in SQL Server

_Applies to:_ &nbsp; SQL Server

## Summary

High CPU usage in Microsoft SQL Server (the `sqlservr.exe` process consuming excessive processor time) commonly stems from inefficient queries, missing indexes, outdated statistics, parameter-sensitive plans, or an increase in workload. This article walks you through an ordered troubleshooting procedure to first confirm that SQL Server is the source of the CPU pressure, and then identify the top CPU-consuming queries. It then explains targeted fixes such as updating statistics, adding missing indexes, resolving parameter sniffing and SARGability issues, disabling heavy tracing, and mitigating spinlock contention. Finally, it covers operating system and virtual machine tuning, including the Windows power plan, and guidance on when to scale up to more CPUs. Use these steps to reduce sustained CPU utilization, restore query performance, and decide when hardware scale-up is required.

## Common causes of high CPU usage in SQL Server

Although many possible causes exist for high CPU usage in SQL Server, the following causes are the most common:

- High logical reads that are caused by table or index scans because of the following conditions:
  - Out-of-date statistics
  - Missing indexes
  - [Parameter sensitive plan (PSP) issues](/azure/azure-sql/identify-query-performance-issues)
  - Poorly designed queries
- Increase in workload

Use the following steps to troubleshoot high-CPU-usage problems in SQL Server.

## Step 1: Verify that SQL Server is causing high CPU usage

Use one of the following tools to check whether the SQL Server process is actually contributing to high CPU usage:

- Task Manager: On the **Process** tab, check whether the **CPU** column value for **SQL Server Windows NT-64 Bit** is close to 100 percent.
- Performance and Resource Monitor ([perfmon](/sql/relational-databases/performance-monitor/monitor-resource-usage-system-monitor))
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

- [Performance Dashboard](/sql/relational-databases/performance/performance-dashboard): In [SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms), right click **\<SQLServerInstance\>** and select **Reports** > **Standard Reports** > **Performance Dashboard**.

  The dashboard illustrates a graph titled **System CPU Utilization** with a bar chart. The darker color indicates the SQL Server engine CPU utilization, while the lighter color represents the overall operating system CPU utilization (see the legend on the graph for reference). Select the circular refresh button or <kbd>F5</kbd> to see the updated utilization.

## Step 2: Identify queries contributing to CPU usage

If the `Sqlservr.exe` process is causing high CPU usage, by far, the most common reason is SQL Server queries that perform table or index scans, followed by sort and hash operations and loops (nested loop operator or WHILE (T-SQL)). To get an idea of how much CPU the queries are currently using, out of overall CPU capacity, run the following statement:

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

After you identify the queries that consume the most CPU, [update statistics](/sql/relational-databases/statistics/statistics#UpdateStatistics) for the tables these queries use. Use the `sp_updatestats` system stored procedure to update the statistics for all user-defined and internal tables in the current database. For example:

```sql
exec sp_updatestats
```

> [!NOTE]
> The `sp_updatestats` system stored procedure runs `UPDATE STATISTICS` against all user-defined and internal tables in the current database. For regular maintenance, ensure that your scheduled maintenance keeps statistics up to date. Use solutions such as [Adaptive Index Defrag](https://github.com/Microsoft/tigertoolbox/tree/master/AdaptiveIndexDefrag) to automatically manage index defragmentation and statistics updates for one or more databases. This procedure automatically chooses whether to rebuild or reorganize an index according to its fragmentation level, among other parameters, and updates statistics with a linear threshold.

For more information about `sp_updatestats`, see [sp_updatestats](/sql/relational-databases/system-stored-procedures/sp-updatestats-transact-sql).

If SQL Server still uses excessive CPU capacity, go to the next step.

## Step 4: Add missing indexes

[!INCLUDE [add-missing-indexes](../../includes/performance/add-missing-indexes.md)]

## Step 5: Investigate and resolve parameter-sensitive issues

[!INCLUDE [parameter-sniffing-issues](../../includes/performance/parameter-sniffing-issues.md)]

## Step 6: Investigate and resolve SARGability issues

[!INCLUDE [no-sargability-issue](../../includes/performance/no-sargability-issue.md)]

## Step 7: Disable heavy tracing

Check for [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) or [XEvent tracing](/sql/relational-databases/extended-events/extended-events) that affects the performance of SQL Server and causes high CPU usage. For example, using the following events might cause high CPU usage if you trace heavy SQL Server activity:

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

## Step 8: Fix high CPU usage caused by spinlock contention

To solve common high CPU usage caused by spinlock contention, see the following sections.

### SOS_CACHESTORE spinlock contention

If your SQL Server instance experiences heavy `SOS_CACHESTORE` spinlock contention or you notice that your query plans are often removed on unplanned query workloads, see the following article and enable [trace flag `T174`](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql) by using the `DBCC TRACEON (174, -1)` command:

[FIX: SOS_CACHESTORE spinlock contention on ad hoc SQL Server plan cache causes high CPU usage in SQL Server](https://support.microsoft.com/topic/kb3026083-fix-sos-cachestore-spinlock-contention-on-ad-hoc-sql-server-plan-cache-causes-high-cpu-usage-in-sql-server-798ca4a5-3813-a3d2-f9c4-89eb1128fe68).

If the high-CPU condition is resolved by using `T174`, enable it as a [startup parameter](/sql/tools/configuration-manager/sql-server-properties-startup-parameters-tab) by using SQL Server Configuration Manager.

### Random high CPU usage due to SOS_BLOCKALLOCPARTIALLIST spinlock contention on large-memory machines

On large-memory machines, `SOS_BLOCKALLOCPARTIALLIST` spinlock contention can produce random spikes in CPU usage. Use the following steps to reduce contention on the single, server-wide partial-block-allocation list by partitioning it across multiple lists.

1. **Confirm the contention.** Check `sys.dm_os_spinlock_stats` for elevated `collisions` and `spins` values on the `SOS_BLOCKALLOCPARTIALLIST` spinlock. If the contention correlates with the CPU spikes, continue with the following steps.

1. **Temporarily mitigate the CPU spike.** Running [`DBCC DROPCLEANBUFFERS`](/sql/t-sql/database-console-commands/dbcc-dropcleanbuffers-transact-sql) releases the partial-block-allocation list and provides temporary mitigation while you plan the permanent fix.

1. **Ensure your SQL Server build includes the fix.** The partitioning behavior is delivered through trace flags 8142 and 8145 and was first introduced in the [SQL Server 2019 Cumulative Update 21](../../releases/sqlserver-2019/cumulativeupdate21.md) to address [bug 2410400](../../releases/sqlserver-2019/cumulativeupdate21.md#2410400). If you're on an older build, apply the latest cumulative update for your version before you enable the trace flags.

1. **Enable trace flag 8142.** Enable [trace flag 8142](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8142) as a global startup parameter. This trace flag partitions the spinlock-protected list by CPU, up to 64 partitions, which is typically sufficient to eliminate the contention.

1. **If contention persists, enable trace flag 8145.** On systems where 64 CPU partitions aren't enough, additionally enable [trace flag 8145](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8145) as a global startup parameter. Trace flag 8145 modifies the partitioning enabled by trace flag 8142 to be per soft-NUMA node, instead of per CPU. It has no effect unless trace flag 8142 is also enabled.

1. **Restart the SQL Server service** so the startup trace flags take effect, then re-check `sys.dm_os_spinlock_stats` to confirm the contention has dropped and CPU usage has stabilized.

### High CPU usage due to spinlock contention on XVB_list on high-end machines

If your SQL Server instance experiences a high CPU scenario caused by spinlock contention on the `XVB_LIST` spinlock on high configuration machines (high-end systems with a large number of newer generation processors (CPUs)), enable the trace flag [TF8102](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8102) together with [TF8101](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8101).

> [!NOTE]
> High CPU usage may result from spinlock contention on many other spinlock types. For more information on spinlocks, see [Diagnose and resolve spinlock contention on SQL Server](/sql/relational-databases/diagnose-resolve-spinlock-contention).

## Step 9: Check your power plan settings at the OS level

SQL Server workloads might experience reduced performance and cause high CPU on the system when Windows is configured with the default **Balanced** power plan. The **Balanced** power plan setting might lower the CPU clock speed to conserve energy. For example, a processor rated at 3.00 GHz might throttle down to 1.2 GHz. As a result, workloads that typically consume around 30% CPU might reach 100% utilization due to the reduced clock speed. To maintain consistent and optimal performance for compute-intensive SQL Server workloads, configure the system to use the **High Performance** power plan. This setting ensures the CPU operates at its full rated speed, helping to avoid performance bottlenecks. For more information, see [Slow performance on Windows Server when using the Balanced power plan](../../../windows-server/performance/slow-performance-when-using-power-plan.md).  

## Step 10: Configure your virtual machine

If you're using a virtual machine, ensure that you aren't overprovisioning CPUs and that they're configured correctly. For more information, see [Troubleshooting ESX/ESXi virtual machine performance issues (2001003)](https://kb.vmware.com/s/article/2001003#CPU%20constraints).

## Step 11: Scale up system to use more CPUs

If individual query instances use little CPU capacity, but the overall workload of all queries together causes high CPU consumption, consider scaling up your computer by adding more CPUs. Use the following query to find the number of queries that exceed a certain threshold of average and maximum CPU consumption per execution and run many times on the system. Make sure that you modify the values of the two variables to match your environment:

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

## Related content

- [High CPU or memory grants may occur with queries that use optimized nested loop or batch sort](decreased-perf-high-cpu-optimized-nested-loop.md)
- [Recommended updates and configuration options for SQL Server 2017 and 2016 with high-performance workloads](recommended-updates-configuration-workloads.md)
- [Monitor and tune for performance](/sql/relational-databases/performance/monitor-and-tune-for-performance)
- [Best practices with the Query Store](/sql/relational-databases/performance/best-practice-with-the-query-store)
