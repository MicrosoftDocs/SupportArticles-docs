---
title: Troubleshoot Slow Performance After an Edition Change
description: Diagnose SQL Server performance problems after an edition change, such as high CPU, slow queries, memory grant waits, and slow backups or recovery.
ms.date: 08/07/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Troubleshoot performance problems after changing the SQL Server edition

_Applies to:_ &nbsp; SQL Server

## Summary

This article helps you diagnose and fix SQL Server performance regressions after an edition change, such as higher CPU utilization, longer query duration, memory grant pressure and spills, or slower index maintenance, backup, and recovery operations. Regressions occur most often after a downgrade to an edition that has lower compute capacity and buffer pool limits, such as a move from Enterprise to Standard, Web, or Express edition, or to an edition that doesn't support a query processing feature the workload relied on. An upgrade can also regress a specific query when a newly available feature, such as automatic indexed-view matching or batch mode on rowstore, leads the optimizer to choose a different execution plan. The same diagnostic steps apply in both directions.

## Symptoms

After changing the SQL Server edition, you might notice one or more of the following symptoms:

| Symptom | Go to |
| --- | --- |
| CPU utilization increased | [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) |
| Queries take longer to complete after changing editions | [Scenario 2](#scenario-2-queries-take-longer-to-complete-after-changing-editions) |
| Reporting queries or large scans became slower | [Scenario 2](#scenario-2-queries-take-longer-to-complete-after-changing-editions) |
| Throughput decreased under concurrency | [Scenario 2](#scenario-2-queries-take-longer-to-complete-after-changing-editions) |
| Only certain queries became slower | [Scenario 2](#scenario-2-queries-take-longer-to-complete-after-changing-editions) |
| Index rebuilds, reorganizations, or consistency checks became slower | [Scenario 3](#scenario-3-maintenance-or-recovery-operations-became-slower-after-changing-editions) |
| Backups or restores take longer to complete | [Scenario 3](#scenario-3-maintenance-or-recovery-operations-became-slower-after-changing-editions) |
| Database startup, failover, or crash recovery takes longer | [Scenario 3](#scenario-3-maintenance-or-recovery-operations-became-slower-after-changing-editions) |

## Methodology for diagnosing edition-change performance issues

:::image type="content" source="media/troubleshoot-performance-edition-change/edition-change-diagnostic-flow.png" alt-text="Screenshot of a SQL Server flowchart for choosing a performance diagnostic based on CPU, query duration, and physical read symptoms.":::

## Capture a performance baseline before the edition change

Before changing the SQL Server edition, collect baseline performance data from the current environment. Baseline data is invaluable when comparing performance before and after the edition change.

### Collect a SQL LogScout baseline

For production systems, establish a performance baseline by using [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) before changing editions. Without baseline measurements, it might be difficult to determine whether the observed behavior is new or existed before the edition change.

Run SQL LogScout by using the `DetailedPerf` scenario during a representative workload period.

Use `DetailedPerf` instead of `GeneralPerf` because it collects execution plans and more detailed query activity. This information is important after an edition change because the target edition might select a different plan, stop using an edition-specific query processing feature, or run the same plan with different runtime characteristics. A `GeneralPerf` collection can identify broad resource pressure, but it might not contain enough query-level evidence to determine which plan or edition capability changed.

The `DetailedPerf` scenario collects information used to compare the source and target environments, including:

- SQL Server configuration
- SQL Server version and edition information
- CPU and memory information
- Database configuration options
- Wait statistics
- Performance Monitor counters
- Detailed query activity
- Query execution plans
- Operating system information
- Query Store reports

Because `DetailedPerf` collects more data than `GeneralPerf`, run it for a bounded period that includes a representative workload. Account for the additional collection overhead and output size, especially on a busy production system.

Save the SQL LogScout output in a location that remains accessible after the edition change.

If performance issues occur after changing editions, collect a second SQL LogScout `DetailedPerf` capture during a comparable workload period. Compare query plans, query runtime information, waits, and resource usage with the baseline collection.

## Confirm that the environments are comparable

The following troubleshooting scenarios assume that you perform the edition change in place on the same hardware, or that you move SQL Server to hardware with similar CPU, memory, storage, and virtualization characteristics. Significant hardware differences can change query plans, resource availability, and runtime performance independently of the SQL Server edition. If the hardware changed, investigate and account for the environment differences first, before treating the edition change as the primary cause.

Compare the source and target environments as follows:

- Compare the amount of physical memory and the memory available to SQL Server. A server with 64 GB of memory isn't directly comparable to a server with 256 GB because the additional memory can cache more data pages, index pages, query plans, and sort or hash worktables.
- Compare CPU count, socket and core topology, and processor clock speed. A server with 24 logical processors can behave differently from one with 96 logical processors, even when both run the same workload.
- Verify that both servers use comparable power plans. A **Balanced** power plan can reduce processor clock speed compared with the **High performance** power plan.
- Compare the hosting model and configuration, including virtual machine (VM) versus physical hardware, Hyper-V versus VMware, virtual CPU allocation, and host contention.
- Compare the storage configuration, including the placement of data, log, and `tempdb` files, available IOPS and throughput, and read and write latency under a comparable workload.
- Verify that the SQL Server version and build, database compatibility level, server configuration, and database-scoped configuration are otherwise comparable. These differences can also affect plan selection and performance.
- Use the before-and-after SQL LogScout collections to compare the same representative workload period. If workload volume, concurrency, or data distribution differs, account for those differences before attributing the regression to the edition.

To compare the maximum processor clock speed reported by Windows, run the following PowerShell command on both servers:

```powershell
Get-CimInstance Win32_Processor | Select-Object -Expand MaxClockSpeed
```

If the reported clock speeds or CPU benchmark results aren't comparable, investigate the power plan, CPU allocation, virtualization layer, and host configuration first. For CPU comparison tests and more environment checks, see [Troubleshoot a query that shows a significant performance difference between two servers](troubleshoot-query-perf-between-servers.md#diagnose-environment-differences).

## Scenario 1: CPU utilization increased after changing editions

### Symptoms of increased CPU utilization

After changing the SQL Server edition, you might notice one or more of the following symptoms:

- SQL Server CPU utilization is consistently higher than before the edition change.
- Queries require more CPU time, and throughput decreases even though the workload hasn't changed.
- Response times or application timeouts increase during peak activity.
- `SOS_SCHEDULER_YIELD` or `THREADPOOL` waits increase.

### Why CPU utilization can increase after an edition change

Some SQL Server editions limit the CPU resources available to the Database Engine. For example, SQL Server 2019 Standard Edition is limited to the lesser of four sockets or 24 cores, whereas Enterprise Edition can use the operating system maximum. For the full compute capacity limit of each edition, see [Compute capacity limits by edition of SQL Server](/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server). A workload that previously had access to more CPUs might have less compute capacity after an edition change.

CPU utilization can also increase if execution plans change after the edition transition or if the workload loses access to edition-specific scalability features.

### Step 1: Determine how many CPUs SQL Server can currently use

In the SQL LogScout collection, review CPU information in the raw `MiscDiagInfo.out` file. If you imported the collection into SQL Nexus, review the `tbl_dm_os_sys_info` table. Compare the results from before and after the edition change.

Alternatively, capture the data manually from the current instance by running the following query:

```sql
SELECT
    cpu_count,
    scheduler_count,
    hyperthread_ratio,
    numa_node_count
FROM sys.dm_os_sys_info;
```

`cpu_count` is the number of logical processors visible to SQL Server, `scheduler_count` is the number of schedulers available for work, and `numa_node_count` is the number of visible NUMA nodes. Lower current values can indicate reduced compute capacity.

### Step 2: Check for contention for CPU resources

In the SQL LogScout collection, review wait statistics in the raw `MiscDiagInfo.out` file. If you imported the collection into SQL Nexus, review the `tbl_dm_os_wait_stats` table. Compare `SOS_SCHEDULER_YIELD` and `THREADPOOL` waits from before and after the edition change over equivalent representative workload periods.

Alternatively, capture the data manually from the current instance by running the following query:

```sql
SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type IN
(
    'SOS_SCHEDULER_YIELD',
    'THREADPOOL'
)
ORDER BY wait_time_ms DESC;
```

| Wait type | Meaning |
| --- | --- |
| `SOS_SCHEDULER_YIELD` | Workers are voluntarily yielding while waiting for CPU time |
| `THREADPOOL` | Worker thread exhaustion might be occurring |

Large or rapidly increasing `SOS_SCHEDULER_YIELD` waits can indicate CPU contention. `THREADPOOL` waits can indicate that the workload requires more concurrent workers than are available.

### Step 3: Determine whether CPU demand increased for specific queries

If you imported the SQL LogScout collection into [SQL Nexus](https://github.com/microsoft/SqlNexus), review the top CPU queries by joining `ReadTrace.tblBatches` and `ReadTrace.tblUniqueBatches`. If ReadTrace data isn't available, use `tbl_Hist_Top10_CPU_Queries_ByQueryHash`. In the raw SQL LogScout `DetailedPerf` collection, review `*_HighCPU_perfstats*.out`, `*_Perfmon*.blg`, and `*_xevent_SQLLogScout*.xel` in the `output` or `output_<timestamp>` folder.

Alternatively, identify the queries that currently consume the most CPU time by running the following query:

```sql
SELECT TOP (20)
       total_worker_time / 1000 AS total_cpu_ms,
       execution_count,
       total_worker_time / execution_count / 1000 AS avg_cpu_ms,
       SUBSTRING(st.text,
                 (qs.statement_start_offset/2)+1,
                 (
                    (
                        CASE qs.statement_end_offset
                             WHEN -1 THEN DATALENGTH(st.text)
                             ELSE qs.statement_end_offset
                        END
                        - qs.statement_start_offset
                    ) / 2
                 ) + 1
       ) AS statement_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY total_worker_time DESC;
```

If only a few queries consume significantly more CPU, focus on those queries and compare their execution plans. If CPU usage increased across many queries, continue with the next steps.

### Step 4: Determine whether execution plans changed

Capture actual execution plans for affected queries and compare them with plans from the previous environment, if available.

Look for:

- Additional scans
- Different join types
- Increased parallelism
- Reduced parallelism
- Increased estimated cost
- Large cardinality estimation errors

An edition change can result in different execution plans even when the SQL Server version remains unchanged. If only specific queries are affected, see [Step 7: Determine whether only specific queries regressed](#step-7-determine-whether-only-specific-queries-regressed).

### Step 5: Examine parallelism behavior

In the SQL LogScout collection, review `max degree of parallelism` and `cost threshold for parallelism` in the raw `MiscDiagInfo.out` file. If you imported the collection into SQL Nexus, review these settings in the `tbl_Sys_Configurations` table. Compare the settings from before and after the edition change.

Alternatively, capture the current settings manually by running the following commands:

```sql
EXEC sp_configure 'max degree of parallelism';
GO

EXEC sp_configure 'cost threshold for parallelism';
GO
```

Don't use `CXPACKET` or `CXCONSUMER` waits alone to conclude that parallelism is misconfigured. These waits are expected during parallel query execution and are most useful when correlated with high CPU utilization, affected queries, and actual execution plans.

Use the following findings to decide what to do next:

- If an affected query has a lower actual DOP after the edition change, confirm whether the target edition's batch-mode DOP limit or the lower scheduler count explains the difference. Compare elapsed time, CPU time, and rows processed per thread in the before-and-after actual plans.
- If a plan changed, check for inaccurate cardinality estimates, additional scans, different join types, or loss of batch-mode operators. Update stale statistics, tune indexes or the query, or use Query Store to test and, when supported on the target edition, force the previous known good plan.
- If a parallel plan has uneven row distribution across threads, investigate data skew, inaccurate estimates, and repartitioning operators. Correct the estimates or query and indexing strategy before changing instance-wide parallelism settings.
- If CPU increased across many queries, review `MAXDOP` and cost threshold for parallelism for the target hardware, NUMA topology, scheduler count, and workload. Test changes under a representative workload instead of carrying over settings from the previous edition without validation.
- If only a few queries use excessive CPU, tune those queries first. A server-wide reduction in `MAXDOP` can reduce concurrency pressure, but it can also make analytical queries take longer.

### Potential resolutions for increased CPU utilization

Depending on your findings, consider the following actions:

- Verify whether the new edition imposes lower CPU limits than the previous edition. For the compute capacity limit of each edition, see [Compute capacity limits by edition of SQL Server](/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server).
- Compare visible schedulers and high-CPU query plans before and after the edition change.
- Tune or rewrite queries with excessive CPU consumption.
- Review `MAXDOP` and cost threshold for parallelism settings. For guidance on these options, see [Server configuration: max degree of parallelism](/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option) and [Server configuration: cost threshold for parallelism](/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option).
- If the workload exceeds the new edition's compute capacity, scale the hardware or move to an edition that supports more CPU resources. Compare the compute capacity limits in [Compute capacity limits by edition of SQL Server](/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server) before choosing a target edition.

## Scenario 2: Queries take longer to complete after changing editions

### Symptoms of longer query duration

After changing the SQL Server edition, you might notice one or more of the following symptoms:

- Queries take longer to complete or become slower.
- Application response times increase.
- Reports run slower.
- ETL jobs require more time to finish.
- Batch processes no longer complete within expected time windows.
- Query timeouts occur.
- Only some queries are affected.
- Throughput decreases or response times increase only under concurrent load.

### Why query duration can increase after an edition change

Even when the workload, application, SQL Server version, database compatibility level, and hardware stay the same, the target edition can have different resource limits, query processing features, and scalability optimizations. These differences can change a query plan or make the same plan take longer to run.

The following table lists the differences that are most likely to affect query duration. The exact differences depend on the SQL Server version and the source and target editions.

| Edition difference | Possible effect after moving to a lower edition | Most useful evidence |
| --- | --- | --- |
| Buffer pool memory limit | More data pages are evicted from cache, causing more physical reads and longer I/O waits. | Lower target server memory, lower page life expectancy, and higher physical reads or `PAGEIOLATCH_*` waits |
| Columnstore segment cache limit | Columnstore segments are read from storage more often. | Columnstore workload is affected and physical reads increased |
| Batch-mode degree of parallelism limit | In SQL Server 2017 and later versions, [batch-mode](/sql/relational-databases/query-processing-architecture-guide#batch-mode-execution) operations are limited to degree of parallelism (DOP) 2 in Standard edition and DOP 1 in Web and Express editions. A plan can keep batch-mode operators but use fewer workers. | The actual plan uses batch mode and reports a lower DOP |
| [Intelligent Query Processing](/sql/relational-databases/performance/intelligent-query-processing) feature availability | A plan might no longer use [batch mode on rowstore](/sql/relational-databases/performance/intelligent-query-processing-details#batch-mode-on-rowstore), [adaptive joins](/sql/relational-databases/performance/joins#adaptive-joins), or [memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-memory-grant-feedback). SQL Server 2022 and later versions also have edition differences for cardinality estimation feedback, DOP feedback, and memory grant feedback persistence. | A before-and-after plan or Query Store history shows that one of these features was previously used |
| Automatic [indexed-view](/sql/relational-databases/views/create-indexed-views) matching | The optimizer can automatically use an indexed view in Enterprise edition, but not in lower editions. In lower editions, a query must reference the view and use the `NOEXPAND` hint to use its index. | The previous plan used an indexed view that the query didn't reference directly |
| [Columnstore](/sql/relational-databases/indexes/columnstore-indexes-overview) scalability enhancements | Aggregate pushdown, string predicate pushdown, and SIMD optimizations are Enterprise edition scalability enhancements. For more information, see [What's new in columnstore indexes](/sql/relational-databases/indexes/columnstore-indexes-what-s-new). | Affected queries use columnstore indexes and show more rows processed, more CPU, or longer batch-mode operators |
| Read-ahead and advanced scanning | These scan optimizations are available only in Enterprise edition. Large scans can cause more synchronous I/O or share less work after a downgrade. | Scan-heavy queries have higher elapsed time, physical reads, or `PAGEIOLATCH_*` waits |
| Data warehouse optimizations | Star join optimizations, parallel query processing on partitioned tables and indexes, and global batch aggregation are Enterprise-only features. | Compared with the Enterprise-edition plan, the target plan processes more fact rows without selective bitmap filters, has a lower DOP or less even per-thread distribution across partitions, or sends more rows through parallel exchanges because aggregation occurs later. |
| Workload isolation under concurrency | [Resource Governor](/sql/relational-databases/resource-governor/resource-governor) is available only in Enterprise edition in SQL Server 2022 and earlier versions. Starting with SQL Server 2025, Resource Governor is also available in Standard edition. After a downgrade to an edition or version that doesn't support Resource Governor, workloads that were previously assigned separate resource pools can compete directly for CPU and query-execution memory. Lower edition CPU and memory limits can amplify this contention. | Throughput regresses only under concurrent load, Resource Governor previously classified the affected workload, and the target instance shows increased `SOS_SCHEDULER_YIELD`, `THREADPOOL`, or `RESOURCE_SEMAPHORE` waits or sustained **Memory Grants Pending**. |
| NUMA-aware large-page memory and buffer-array allocation | On large NUMA systems, memory allocation and locality can be less scalable outside Enterprise edition. | The regression occurs mainly under concurrency on a multi-NUMA-node server |

Some features exist in all editions but have lower capacity in Standard, Web, or Express editions. For example, columnstore and In-Memory OLTP are available across editions in supported releases, but their memory capacity and some scalability behavior differ. Therefore, the presence of an index or database feature doesn't by itself rule out an edition-related regression.

For the authoritative feature matrix for each release, see:

- [Editions and supported features of SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016)
- [Editions and supported features of SQL Server 2017](/sql/sql-server/editions-and-components-of-sql-server-2017)
- [Editions and supported features of SQL Server 2019](/sql/sql-server/editions-and-components-of-sql-server-2019)
- [Editions and supported features of SQL Server 2022](/sql/sql-server/editions-and-components-of-sql-server-2022)
- [Editions and supported features of SQL Server 2025](/sql/sql-server/editions-and-components-of-sql-server-2025)

> [!IMPORTANT]
> Edition support doesn't prove that a query used a feature before the change. Confirm the cause by comparing plans, runtime statistics, waits, or baseline data from the source and target environments.

### Step 1: Determine whether all queries are slower or only specific queries

Ask the following questions:

- Is the entire application slower?
- Are all databases affected?
- Are only specific reports or queries affected?
- Did query time increase for all users or only some users?
- Does the regression reproduce with one session, or only when many sessions run concurrently?

#### Interpret the scope of the regression

| Observation | Next step |
| --- | --- |
| Most queries are slower | Continue to Step 2 |
| Only a few queries are slower | Go to Step 4 |
| Reporting or large scan operations are slower | Go to [Step 5](#step-5-check-edition-specific-patterns-for-the-affected-queries) |
| Throughput decreases only under concurrent load | Continue to Step 2, review [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) for CPU and worker pressure, and complete the memory grant checks in [Step 6](#step-6-determine-whether-memory-grant-pressure-increased) |
| CPU utilization also increased | Review [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) |

### Step 2: Identify the exact source and target editions

Run the following query on the current instance and compare the results with the baseline from the previous instance:

```sql
SELECT
    SERVERPROPERTY('Edition') AS edition,
    SERVERPROPERTY('EngineEdition') AS engine_edition,
    SERVERPROPERTY('ProductVersion') AS product_version,
    SERVERPROPERTY('ProductLevel') AS product_level;

SELECT
    name,
    compatibility_level
FROM sys.databases
WHERE name = DB_NAME();
```

Use the feature matrix for that SQL Server version to compare the source edition with the target edition. If the SQL Server version or database compatibility level also changed, don't attribute the regression to edition alone. Those changes can independently affect optimizer behavior and plan selection.

### Step 3: Determine whether physical reads increased

#### Why memory can be reduced after an edition change

Each SQL Server edition imposes a maximum buffer pool size. Enterprise edition can use the operating system maximum, but lower editions enforce a hard cap:

| Edition | Maximum buffer pool memory |
| --- | --- |
| Enterprise | Operating system maximum |
| Standard | 128 GB (SQL Server 2016 through SQL Server 2022); 256 GB (SQL Server 2025) |
| Web | 64 GB |
| Express | 1,410 MB |

If the workload previously relied on a buffer pool larger than the target edition's limit, the new instance can't cache the same amount of data regardless of the physical memory installed on the server. SQL Server enforces the edition cap at startup; it isn't a configurable setting.

#### Why physical reads increase when buffer pool memory is reduced

When the buffer pool is smaller, data pages that were previously cached are evicted sooner. Queries that previously satisfied reads from the buffer pool must now read pages from storage. The effect is:

- Higher physical read counts per query.
- Longer elapsed time due to I/O latency.
- Increased `PAGEIOLATCH_*` waits while workers wait for pages to be read from disk.
- Lower page life expectancy (PLE), because pages cycle out of the cache faster.

The same workload running the same plan can take substantially longer if the working set no longer fits in the buffer pool.

#### Check buffer pool counters in Performance Monitor

The following Performance Monitor counters provide the same evidence and can be compared across the before-and-after SQL LogScout `DetailedPerf` collections:

| Counter | What it shows |
| --- | --- |
| `SQLServer:Buffer Manager\Page life expectancy` | How long pages stay in the buffer pool. A sustained drop after the edition change supports a smaller effective cache. |
| `SQLServer:Buffer Manager\Page reads/sec` | Physical reads from storage. A sustained increase under the same workload supports more cache misses. |
| `SQLServer:Buffer Manager\Buffer cache hit ratio` | Percentage of reads satisfied from the buffer pool. A drop correlates with the memory-limit hypothesis. |
| `SQLServer:Memory Manager\Target Server Memory (KB)` | The amount of memory SQL Server can commit to the buffer pool. This value reflects the edition cap and should be compared directly with the previous environment. |
| `SQLServer:Memory Manager\Total Server Memory (KB)` | The amount of memory SQL Server currently has committed. If this value is at or near the target and below the previous environment's value, the edition cap is the constraint. |
| `LogicalDisk\Avg. Disk sec/Read` | Average read latency on the data volume. An increase confirms that the additional physical reads are adding elapsed time. |

If Performance Monitor data is available from both SQL LogScout collections, compare the counters during equivalent workload periods. A before-and-after difference in these counters is stronger evidence than a single point-in-time snapshot.

#### Check buffer pool memory with DMVs

Compare `committed_target_kb` with the previous environment and with the documented buffer pool limit for the target edition.

```sql
SELECT
    physical_memory_kb / 1024 AS physical_memory_mb,
    committed_kb / 1024 AS committed_memory_mb,
    committed_target_kb / 1024 AS target_memory_mb
FROM sys.dm_os_sys_info;
```

Check page life expectancy.

```sql
SELECT
    object_name,
    counter_name,
    cntr_value
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Page life expectancy'
  AND object_name LIKE '%Buffer Manager%';
```

Check I/O-related waits. Wait statistics are cumulative since the last restart or reset, so compare deltas over equivalent representative workload periods.

```sql
SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms,
    signal_wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type LIKE 'PAGEIOLATCH[_]%'
ORDER BY wait_time_ms DESC;
```

#### Interpret the physical read findings

The following before-and-after observations support an edition-specific memory limit as the cause of increased physical reads:

- `Target Server Memory (KB)` or `committed_target_kb` is lower on the target instance and close to the edition's documented buffer pool cap.
- `Page life expectancy` decreased compared to the baseline.
- `Page reads/sec` or the query-level physical-read count increased during the same workload.
- `PAGEIOLATCH_*` wait time increased.
- `Avg. Disk sec/Read` increased, which confirms that extra I/O adds latency.

If `Target Server Memory` doesn't decrease and physical reads don't increase, an edition-specific memory limit is less likely to explain the regression. In that case, continue to Step 4 to compare execution plans.

### Step 4: Compare execution plans and execution modes

Compare a plan captured before the edition change with a plan for the same query captured after the change. Use actual execution plans when available because they include runtime information such as actual row counts, resource usage, and runtime warnings.

Before comparing the plans, verify that they represent the same query or statement. Also verify that the parameter values, data volume, database compatibility level, and relevant configuration settings are comparable. A difference in one of these inputs can change a plan independently of the edition.

#### Compare saved plan files from SQL LogScout

Use this method when the before-and-after plans are in separate SQL LogScout `DetailedPerf` collections:

1. In each collection, identify the execution plan captured for the affected query. Save or export each plan as an execution plan file (`.sqlplan`) if it isn't already in that format.
1. Open the plan from before the edition change in SQL Server Management Studio (SSMS). You can select **File** > **Open** > **File**, or drag the file into SSMS.
1. Right-click a blank area of the plan, and then select **Compare Showplan**.
1. Select the corresponding plan captured after the edition change.
1. In the comparison window, use the dual **Properties** pane to identify properties marked with the not-equal sign. Use **Showplan Analysis** to highlight operations that don't match similar plan segments.

Plan Comparison is available in SSMS version 16 and later versions, works offline, and can compare `.sqlplan` files from older SQL Server versions. For the complete procedure, see [Compare execution plans](/sql/relational-databases/performance/compare-execution-plans).

#### Compare plans in Query Store

Use this method when Query Store contains both the before-and-after plans for the same query:

1. In SSMS Object Explorer, expand the database, expand **Query Store**, and then open **Regressed Queries** or **Top Resource Consuming Queries**.
1. Select the affected query and review its plans and runtime statistics for the periods before and after the edition change.
1. Hold the **Shift** key and select the two plans to compare.
1. Select **Compare the plans for the selected query in a separate window**.

For more information, see [Compare execution plans in Query Store](/sql/relational-databases/performance/compare-execution-plans#compare-execution-plans-in-query-store) and [Use the Regressed Queries feature](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store#use-the-regressed-queries-feature).

When you compare the plans, look for:

- A change from batch mode to row mode
- A lower actual DOP for batch-mode operators
- Loss of an adaptive join
- Loss of an automatically matched indexed view
- Different join types or additional scans
- A substantially different memory grant, spills to `tempdb`, or `RESOURCE_SEMAPHORE` waits
- More rows entering a columnstore aggregate, which can indicate that aggregate or predicate pushdown is no longer occurring
- Differences between estimated and actual rows, especially when they occur early in the plan
- Changes in actual elapsed time, CPU time, logical or physical reads, and rows processed

Don't use estimated subtree cost by itself to decide which plan is better. Compare actual runtime metrics over equivalent workload periods and determine whether the observed difference matches a documented edition capability.

#### Interpret the execution plan differences

Match the observed plan difference to the feature matrix for the installed SQL Server version. The following table describes important Enterprise-edition capabilities and the evidence that can help identify their loss after an edition change:

| Starting version | Enterprise-edition capability | What to compare in the execution plans or Query Store |
| --- | --- | --- |
| SQL Server 2016 | Automatic [indexed-view matching](/sql/relational-databases/views/create-indexed-views) | The Enterprise-edition plan can contain an index seek or scan whose **Object** property names an indexed view even when the query references only its base tables. After a downgrade, the indexed view is absent and the plan accesses and joins or aggregates the base tables instead. |
| SQL Server 2016 | [Columnstore aggregate and string-predicate pushdown](/sql/relational-databases/indexes/columnstore-indexes-what-s-new) | Compare the columnstore scan's **Actual Number of Rows** and **Number of Rows Read**, and the rows passed to filter and aggregate operators. Loss of pushdown can result in more rows leaving the scan and more work in separate filter or aggregate operators. SIMD use isn't exposed as a distinct plan operator, so an unchanged plan with higher CPU can still indicate loss of this Enterprise-edition optimization. |
| SQL Server 2017 | [Batch-mode adaptive joins](/sql/relational-databases/performance/joins#adaptive-joins) | The Enterprise-edition plan can contain an **Adaptive Join** operator with **Adaptive Threshold Rows**, **Estimated Join Type**, and, in an actual plan, **Actual Join Type** properties. The target plan might instead contain a fixed hash join or nested loops join. |
| SQL Server 2017 | [Batch-mode memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-memory-grant-feedback#batch-mode-memory-grant-feedback) | Compare repeated actual plans for changes in the root operator's **Memory Grant Info**, especially **Granted Memory**, and check whether spills stop after later executions. Starting with SQL Server 2019, actual plans can also show `IsMemoryGrantFeedbackAdjusted` and `LastRequestedMemory`. |
| SQL Server 2017 | [Automatic tuning](/sql/relational-databases/automatic-tuning/automatic-tuning) | Automatic plan correction doesn't add a distinctive plan operator. In Query Store, determine whether the previous good plan was automatically forced and whether that forcing or tuning recommendation is absent after the edition change. |
| SQL Server 2019 | [Batch mode on rowstore](/sql/relational-databases/performance/intelligent-query-processing-details#batch-mode-on-rowstore) | In operator properties, the Enterprise-edition plan can show **Actual Execution Mode = Batch** even though the query accesses only rowstore heaps or B-tree indexes. After a downgrade, the corresponding operators show **Row** mode and the plan shape can also change. |
| SQL Server 2019 | [Row-mode memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-memory-grant-feedback#row-mode-memory-grant-feedback) | In repeated actual plans, inspect `IsMemoryGrantFeedbackAdjusted`, `LastRequestedMemory`, **Granted Memory**, and spill warnings. On a lower edition, an inaccurate grant and its spills or unused memory can persist across executions. |
| SQL Server 2022 | [Cardinality estimation feedback](/sql/relational-databases/performance/intelligent-query-processing-cardinality-estimation-feedback) | Compare estimated and actual rows and the resulting join order or join types. Because feedback isn't reliably identified from plan shape alone, use [sys.query_store_plan_feedback](/sql/relational-databases/system-catalog-views/sys-query-store-plan-feedback) to confirm a `CE Feedback` record and its state for the Enterprise-edition plan. |
| SQL Server 2022 | [DOP feedback](/sql/relational-databases/performance/intelligent-query-processing-degree-parallelism-feedback) | Compare the plan's actual DOP and parallel operators across repeated executions. Use `sys.query_store_plan_feedback` to confirm a `DOP Feedback` record; a DOP difference by itself can also result from configuration or workload conditions. |
| SQL Server 2022 | [Memory grant feedback persistence and percentile mode](/sql/relational-databases/performance/intelligent-query-processing-memory-grant-feedback#percentile-and-persistence-mode-memory-grant-feedback) | In an actual plan, `IsMemoryGrantFeedbackAdjusted` can show **Yes: Percentile Adjusting**. Use `sys.query_store_plan_feedback` to confirm persisted `Memory Grant Feedback`; without this capability, feedback history doesn't persist in the same way. |
| SQL Server 2025 | Cardinality estimation feedback for expressions | Look for large estimate-versus-actual row differences around expressions and for a resulting change in access method, join order, or join type. Use `sys.query_store_plan_feedback` to confirm the feedback record because the plan doesn't provide a unique expression-feedback operator. |

These features also have version, database compatibility level, and other eligibility requirements. A feature shown as supported might not be active for a particular query.

If the plan is unchanged, compare actual execution statistics. The same plan can run more slowly because the target edition has a lower batch-mode DOP, a smaller cache, or fewer scan optimizations.

### Step 5: Check edition-specific patterns for the affected queries

Use the affected objects and operators to select the next check:

| Query pattern | Where and what to inspect | Evidence that supports an edition-related cause |
| --- | --- | --- |
| Rowstore analytical query | Select the scan, filter, join, and aggregate operators and compare **Actual Execution Mode**. Confirm from each scan's **Object** property that the query accesses rowstore heaps or B-tree indexes rather than columnstore indexes. | The Enterprise-edition plan uses **Batch** mode, but the target-edition plan uses **Row** mode for corresponding operators. If both plans use the same execution mode, loss of batch mode on rowstore doesn't explain the regression. |
| Query with batch-mode operators | Select the root `SELECT` operator and compare **Degree of Parallelism** in the actual plans. Also compare parallel exchange operators and per-thread row counts when available. | The Enterprise-edition plan runs above DOP 2, while the Standard-edition plan is limited to DOP 2, or the Web or Express plan is limited to DOP 1. First confirm that `MAXDOP`, Resource Governor, available schedulers, and workload conditions don't explain the lower DOP. |
| Query that could use an indexed view | In the source plan, inspect the **Object** property of index seek and scan operators. Determine whether the object is an indexed view that isn't named in the query text. In the target plan, identify the corresponding base-table scans, joins, and aggregates. | The Enterprise-edition plan automatically accesses the indexed view, while the target-edition plan expands the work to the base tables. If neither plan uses the indexed view, automatic indexed-view matching isn't the cause. Confirm that the required session `SET` options are the same before testing a direct view reference with `NOEXPAND`. |
| Columnstore aggregation or string filter | Select the columnstore scan and compare **Actual Number of Rows**, **Number of Rows Read**, predicates, and the rows entering separate filter or aggregate operators. Also compare **Actual Execution Mode** and actual DOP. | The target-edition plan reads or passes substantially more rows to separate filter or aggregate operators, changes to row mode, or runs at a lower DOP. These changes support loss of Enterprise-edition columnstore pushdown or scalability enhancements. SIMD use and columnstore segment-cache pressure don't have unique plan operators, so use higher CPU, physical reads, and I/O waits as supporting evidence. |
| Query with a join whose input size varies | Look for an **Adaptive Join** in the Enterprise-edition plan. Inspect **Adaptive Threshold Rows**, **Estimated Join Type**, and **Actual Join Type**. Compare it with the corresponding join in the target plan. | The Enterprise-edition plan uses an Adaptive Join, while the target-edition plan uses a fixed hash join or nested loops join that performs poorly for the captured row count. If neither plan contains an Adaptive Join, loss of adaptive joins isn't the direct cause. |
| Large table or partition scan | Compare scan and partition-elimination predicates, **Actual Number of Rows**, **Number of Rows Read**, actual DOP, elapsed time, and CPU time. Use the matching SQL LogScout interval to compare physical reads, read latency, and `PAGEIOLATCH_*` waits. | The plan shape and row counts remain similar, but the target execution has higher physical I/O or latency. This pattern can support loss of Enterprise-edition read-ahead or advanced scanning. These optimizations aren't represented by a unique plan operator, so plan comparison alone can't confirm the cause. |
| Star-schema query | Compare bitmap filters, hash joins, join order, fact-table **Actual Number of Rows** and **Number of Rows Read**, and the rows entering joins. | The Enterprise-edition plan eliminates fact rows earlier by using selective bitmap filters or a more efficient star-join plan, while the target plan processes substantially more fact rows. A bitmap difference alone doesn't prove that the edition caused the change, so compare equivalent parameters, statistics, and estimates. |
| Query that joins partitioned tables or indexes | Compare partition-elimination predicates, partitions accessed, actual DOP, parallel exchange operators, and per-thread row distribution. For collocated tables, also compare whether matching partitions are joined separately. | The Enterprise-edition plan parallelizes partition processing or uses a more efficient partition-aware join, while the target plan processes partitions serially or has less effective parallel distribution. Confirm that `MAXDOP`, available schedulers, and partition alignment are otherwise comparable. |
| Batch-mode query with a large aggregation | Compare local and global aggregate operators, rows entering each aggregate, rows crossing parallel exchanges, actual execution mode, DOP, CPU, and elapsed time. | The Enterprise-edition plan reduces rows in an earlier batch aggregation stage, while the target plan sends more rows through exchanges or performs more work in a later aggregate. Global batch aggregation has no single conclusive plan property, so use the runtime differences as supporting evidence. |
| Query against a distributed partitioned view | Identify remote member tables and compare remote-query operators, member tables accessed, rows transferred from linked servers, and whether `CHECK` constraints eliminate unneeded members. | Distributed partitioned views are Enterprise-only. If the source workload used one, the capability isn't available after moving to a lower edition. Treat this as a cause only when the affected query actually depends on remote partition members. |
| Backup, restore, failover, database startup, or consistency check on a large-memory server | For SQL Server 2022, review the SQL Server error log for long buffer-pool-scan messages or capture the `buffer_pool_scan_complete` extended event. Compare the operation, duration, buffers scanned, and available CPU across editions. | Buffer pool parallel scan is available in Enterprise and Standard editions, but not Web or Express editions. A move to Web or Express can make operations that scan a large buffer pool take longer. This optimization concerns internal buffer-pool scans, not ordinary reporting table or index scans. |
| Sort, hash join, or hash aggregate that spills | Inspect the root operator's **Memory Grant Info**, including requested, granted, and maximum used memory. Inspect sort and hash operators for spill warnings, spill level, and data written to or read from `tempdb`. Compare repeated executions for `IsMemoryGrantFeedbackAdjusted` and `LastRequestedMemory`. | The target plan repeatedly receives an inaccurate grant or continues to spill, while later Enterprise-edition executions adjust the grant and reduce or eliminate spills. Correlate this evidence with `RESOURCE_SEMAPHORE` waits; a spill alone can also result from estimate errors or insufficient memory. |
| Repeated query with large estimate errors | Compare estimated and actual rows at the first operator where they diverge, then compare downstream access methods, join order, join types, and DOP. For SQL Server 2022 and later versions, query `sys.query_store_plan_feedback` for the plan. | Query Store records valid `CE Feedback` or `DOP Feedback` for the Enterprise-edition plan, and the target plan lacks that feedback and retains the poorer estimates, join strategy, or DOP. A plan-shape difference without a feedback record doesn't by itself prove that loss of a feedback feature caused the regression. |

### Step 6: Determine whether memory grant pressure increased

#### Why memory grant pressure can increase after an edition change

Query execution memory grants are workspace memory that SQL Server allocates to sort, hash join, and hash aggregate operators within a query plan. SQL Server gets this workspace memory from the overall memory it has, which the edition's buffer pool limit constrains.

An edition change can increase memory grant pressure in two ways:

- **Less total memory available for grants.** When the edition imposes a lower buffer pool cap, the memory available for query execution grants is also reduced. The same workload competes for a smaller pool of grant memory, which can cause queries to wait longer for a grant (`RESOURCE_SEMAPHORE` waits) or receive a smaller grant than they need, resulting in spills to `tempdb`.
- **Loss of memory grant feedback.** In Enterprise edition, SQL Server 2017 and later versions can adjust a query's memory grant based on previous executions. Batch-mode memory grant feedback (SQL Server 2017), row-mode memory grant feedback (SQL Server 2019), and memory grant feedback persistence with percentile mode (SQL Server 2022) are Enterprise-only features. After moving to a lower edition, a query that previously had its grant corrected by feedback might revert to the optimizer's original estimate. If that estimate is inaccurate, the query spills repeatedly and each execution pays the `tempdb` I/O cost.

#### Check memory grant counters in Performance Monitor

The following Performance Monitor counters help confirm memory grant pressure:

| Counter | What it shows |
| --- | --- |
| `SQLServer:Memory Manager\Memory Grants Outstanding` | Number of queries currently holding a memory grant. A sustained increase suggests more concurrent grant holders competing for a smaller pool. |
| `SQLServer:Memory Manager\Memory Grants Pending` | Number of queries waiting for a memory grant. Any sustained value above zero indicates grant contention. |
| `SQLServer:Memory Manager\Total Server Memory (KB)` | Current committed memory. Compare with the previous environment to confirm the edition cap is the constraint. |
| `SQLServer:Memory Manager\Target Server Memory (KB)` | The memory target SQL Server is working toward. A lower target directly reduces the grant workspace. |

Compare these counters across the before-and-after SQL LogScout `DetailedPerf` collections during equivalent workload periods.

#### Check memory grants with DMVs

Check active requests that are waiting for or have received a query execution memory grant.

```sql
SELECT
    session_id,
    request_time,
    grant_time,
    requested_memory_kb,
    granted_memory_kb,
    required_memory_kb,
    used_memory_kb,
    max_used_memory_kb,
    wait_time_ms
FROM sys.dm_exec_query_memory_grants
ORDER BY requested_memory_kb DESC;
```

A non-null `wait_time_ms` with a null `grant_time` indicates a request that is currently waiting for a memory grant.

Check cumulative memory grant waits.

```sql
SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type = 'RESOURCE_SEMAPHORE';
```

Check the memory grant workspace pool size.

```sql
SELECT
    pool_id,
    name,
    max_memory_kb,
    used_memory_kb,
    target_memory_kb
FROM sys.dm_exec_query_resource_semaphores;
```

If `target_memory_kb` is lower than the value from the previous environment, the edition's memory cap is reducing the workspace available for grants.

#### Interpret the memory grant findings

The following observations support edition-related memory grant pressure:

- `RESOURCE_SEMAPHORE` waits are new or significantly higher after the edition change.
- `Memory Grants Pending` is frequently above zero during the workload.
- `target_memory_kb` in `sys.dm_exec_query_resource_semaphores` is lower than in the previous environment.
- Actual execution plans show sort or hash spill warnings that weren't present before, or that `IsMemoryGrantFeedbackAdjusted` is absent when it was previously active.
- `Target Server Memory (KB)` is at or near the edition's buffer pool cap and below the previous environment's value.

If `RESOURCE_SEMAPHORE` waits didn't increase and grant sizes are unchanged, memory grant pressure is less likely to be the cause. In that case, continue to Step 7 to identify whether only specific queries regressed.

### Step 7: Determine whether only specific queries regressed

Identify the queries that consume the most resources.

```sql
SELECT TOP (20)
    qs.execution_count,
    qs.total_elapsed_time / 1000 AS total_elapsed_ms,
    (qs.total_elapsed_time / NULLIF(qs.execution_count, 0)) / 1000 AS avg_elapsed_ms,
    qs.total_worker_time / 1000 AS total_cpu_ms,
    qs.total_logical_reads,
    qs.total_physical_reads,
    SUBSTRING
    (
        st.text,
        (qs.statement_start_offset / 2) + 1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset
          END - qs.statement_start_offset) / 2) + 1
    ) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY total_elapsed_time DESC;
```

#### Interpret the query-level findings

If only a small number of queries become slower, the problem is more likely related to:

- Execution plan regressions
- An edition-specific optimizer or execution feature used by those queries
- Indexed-view matching
- Columnstore or batch-mode limits
- Different memory grant behavior

rather than an edition-wide resource limitation.

### Potential resolutions for longer query duration

Depending on the findings:

- Review memory utilization and the target edition's memory limits as described in [Step 3](#step-3-determine-whether-physical-reads-increased) and [Step 6](#step-6-determine-whether-memory-grant-pressure-increased). During equivalent workload periods, compare `Target Server Memory (KB)`, `Total Server Memory (KB)`, page life expectancy, physical reads, `PAGEIOLATCH_*` and `RESOURCE_SEMAPHORE` waits, and **Memory Grants Pending**. If the memory target is near the edition limit and cache churn or grant pressure increased, reduce the workload's memory demand by tuning high-read queries and indexes, correcting excessive memory grants, or reducing peak concurrency. If the working set still doesn't fit, distribute the workload or select an edition with a sufficient memory limit.
- Compare before-and-after actual execution plans for the same query, parameter values, data volume, and representative workload conditions by following [Step 4](#step-4-compare-execution-plans-and-execution-modes). Compare plan shape, actual execution mode and DOP, estimated and actual rows, scans, join types, memory grants and spills, CPU time, elapsed time, and logical and physical reads. Use the first meaningful difference to choose a corrective action, such as updating statistics, adding or adjusting an index, rewriting the query, correcting parameter-sensitive behavior, or addressing an edition-specific feature loss.
- Use Query Store **Regressed Queries** to compare plans and runtime statistics for the affected query across time intervals before and after the edition change. Select a previous plan only after confirming that it doesn't depend on a feature unavailable in the target edition, then test it under representative parameter values and concurrency. If it consistently restores acceptable performance, force the plan and monitor execution failures, runtime, CPU, reads, and plan-forcing status. Unforce the plan if performance worsens, the forcing operation fails, or later schema, index, statistics, or workload changes make the plan unsuitable.
- For an indexed view, test explicitly referencing the view with `NOEXPAND` on editions that don't support automatic matching.
- Tune affected queries and indexes for the capabilities of the target edition.
- Determine whether the workload exceeds the target edition's CPU or memory capacity by testing a representative workload at expected peak concurrency. For CPU, compare sustained utilization, runnable work, `SOS_SCHEDULER_YIELD` or `THREADPOOL` waits, and throughput with the number of schedulers the edition can use. For memory, confirm whether `Target Server Memory (KB)` is near the edition limit and whether lower page life expectancy, increased physical reads, `RESOURCE_SEMAPHORE` waits, or sustained **Memory Grants Pending** occur at the same time as the regression. If demand exceeds the limit, reduce concurrency or workload demand, tune the highest-resource queries, or distribute the workload across instances. Adding CPU or memory to the server doesn't help when the SQL Server edition prevents the Database Engine from using the additional capacity. In that case, move to an edition with sufficient CPU or memory limits.
- If the workload appears to depend on an Enterprise-only optimizer or scalability feature, first confirm the dependency by matching the before-and-after plan or runtime evidence to the feature matrix for the installed SQL Server version. Test alternatives supported by the target edition, such as explicitly referencing an indexed view with `NOEXPAND`, adding or adjusting indexes, rewriting the query, updating statistics, or forcing a known good plan that remains valid on the target edition. Measure the result under a representative workload against the required response-time and throughput targets. If the supported alternatives still don't meet those targets, select an edition that supports the identified capability, validate the workload on that edition in a test environment, and then plan the edition change.

### Next steps

| Additional symptom | Go to |
| --- | --- |
| CPU utilization increased | [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) |
| Large scans or reporting workloads became slower | [Scenario 2, Step 5](#step-5-check-edition-specific-patterns-for-the-affected-queries) |
| Throughput decreases under concurrency | Review [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) and the memory grant checks in [Scenario 2, Step 6](#step-6-determine-whether-memory-grant-pressure-increased) |
| Only specific queries regressed | [Scenario 2, Step 7](#step-7-determine-whether-only-specific-queries-regressed) |
| Index maintenance, backups, restores, or recovery became slower | [Scenario 3](#scenario-3-maintenance-or-recovery-operations-became-slower-after-changing-editions) |

## Scenario 3: Maintenance or recovery operations became slower after changing editions

### Symptoms of slower maintenance or recovery

After changing the SQL Server edition, you might notice one or more of the following symptoms:

- Index rebuilds or reorganizations take longer, or they block queries and applications for longer than before.
- `DBCC CHECKDB` or other consistency checks take longer to complete.
- Full, differential, or transaction log backups take longer to complete, or the backup files are larger than before.
- Restores take longer to complete.
- Database startup, an Always On failover cluster instance or availability group failover, or crash recovery takes longer, or the database stays unavailable longer than expected.

### Why maintenance and recovery can take longer after an edition change

Several SQL Server maintenance and recovery capabilities are available only in Enterprise edition, or aren't available in Web or Express edition. Losing access to one of these capabilities after an edition change can make routine maintenance take longer, make maintenance block concurrent activity that it previously didn't block, or extend the time a database is unavailable during startup, failover, or recovery, even though the workload, hardware, and data volume didn't change.

| Edition difference | Possible effect after moving to a lower edition | Most useful evidence |
| --- | --- | --- |
| [Online index create and rebuild](/sql/relational-databases/indexes/perform-index-operations-online) | Enterprise edition can create or rebuild an index while the table remains available for queries and updates. Without this capability, an index operation takes a blocking lock for its duration. | The maintenance job step takes longer, and blocking waits appear on the affected table only during the maintenance window. |
| [Resumable online index rebuilds](/sql/relational-databases/indexes/guidelines-for-online-index-operations#resumable-index-considerations) | Enterprise edition can pause a rebuild and resume it later without losing progress. Without this capability, a paused, failed, or canceled rebuild must restart from the beginning. | Job history shows a rebuild step running for its full duration again after an interruption, instead of resuming. |
| Online nonclustered columnstore index rebuild | Enterprise edition can rebuild a nonclustered columnstore index online. Without this capability, the rebuild blocks access to the table for its duration. | A columnstore index maintenance step blocks concurrent activity that it previously didn't block. |
| Parallel index maintenance operations | Enterprise edition can build or rebuild an index using multiple CPUs. Outside Enterprise edition, `CREATE INDEX` and `ALTER INDEX ... REBUILD` run on a single thread regardless of `MAXDOP` or the number of CPUs available. | The index operation's duration increases roughly in proportion to table size, and only one worker thread is active for the operation even though more schedulers are available. |
| Parallel consistency check | Enterprise edition can [check objects in parallel](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#check-objects-in-parallel) during `DBCC CHECKDB`, `DBCC CHECKTABLE`, and `DBCC CHECKFILEGROUP`. Outside Enterprise edition, these commands always run the check on a single thread, regardless of `MAXDOP`, [trace flag 2528](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf2528), or the number of CPUs available. | Consistency-check duration increases roughly in proportion to database or table size, and only one worker thread is active for the check even though more schedulers are available. |
| [Backup compression](/sql/relational-databases/backup-restore/backup-compression-sql-server) | Enterprise, Standard, and Developer editions support backup compression. Web and Express editions don't. | Backups are larger and take longer, `sys.configurations` shows `backup compression default` can't take effect, and `msdb.dbo.backupset` shows `compressed_backup_size` equal to `backup_size`. |
| Online page and file restore | Enterprise edition can restore individual pages or files while the rest of the database stays online. Without this capability, the database or the affected file must be taken offline for the restore. | A page or file restore that previously kept the database online now requires the database or file to go offline. |
| [Fast recovery](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server#recovery-and-the-transaction-log) | Enterprise edition can bring a database online for user access after the redo phase of recovery finishes, without waiting for the undo phase to complete. Without this capability, the database isn't available until all recovery phases finish. | After a failover or restart, the database remains unavailable for noticeably longer, especially when a long-running transaction was active at the time of the crash. |
| Buffer pool parallel scan | As described in [Scenario 2, Step 5](#step-5-check-edition-specific-patterns-for-the-affected-queries), Enterprise and Standard editions can scan the buffer pool in parallel during startup or recovery. Web and Express editions can't. | The SQL Server error log or the `buffer_pool_scan_complete` extended event shows a longer buffer-pool-scan duration on a large-memory server. |
| [Accelerated Database Recovery (ADR)](/sql/relational-databases/accelerated-database-recovery-concepts) | ADR (SQL Server 2019 and later versions) makes recovery time largely independent of long-running transactions. ADR isn't available in Express edition. | `sys.databases.is_accelerated_database_recovery_on` is `1` on the previous environment but ADR can't be enabled on the current edition. |

For the authoritative feature matrix for each release, see the links in [Scenario 2](#scenario-2-queries-take-longer-to-complete-after-changing-editions).

### Step 1: Determine which operation is affected

Ask the following questions:

- Did index or statistics maintenance, or consistency checks, become slower or more disruptive?
- Did backups or restores become slower, or did backup files become larger?
- Did database startup, failover, or crash recovery take longer?

#### Interpret the affected operation

| Observation | Next step |
| --- | --- |
| Index rebuilds, reorganizations, or consistency checks became slower or more blocking | Continue to Step 2 |
| Backups or restores became slower, or backup files became larger | Go to [Step 3](#step-3-determine-whether-backup-or-restore-duration-increased) |
| Startup, failover, or recovery became slower | Go to [Step 4](#step-4-determine-whether-startup-failover-or-recovery-duration-increased) |
| CPU utilization also increased | Review [Scenario 1](#scenario-1-cpu-utilization-increased-after-changing-editions) |

### Step 2: Determine whether index or consistency-check maintenance lost online or resumable operations

Confirm the current edition:

```sql
SELECT
    SERVERPROPERTY('Edition') AS edition,
    SERVERPROPERTY('EngineEdition') AS engine_edition;
```

Review the index and maintenance job or script definitions for `WITH (ONLINE = ON)` or `WITH (RESUMABLE = ON)`. On an edition that doesn't support these options, the statement fails instead of silently running offline, so also check the SQL Server error log and job history for failed maintenance steps.

Compare maintenance job step duration before and after the edition change:

```sql
SELECT
    j.name AS job_name,
    h.step_name,
    h.run_date,
    h.run_time,
    h.run_duration,
    h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j
    ON j.job_id = h.job_id
WHERE j.name = N'<maintenance_job_name>'
ORDER BY h.run_date DESC, h.run_time DESC;
```

`run_duration` is stored as `HHMMSS`. Compare recent runs with runs captured before the edition change.

Check for blocking during the maintenance window:

```sql
SELECT
    r.session_id,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time,
    r.command,
    t.text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0;
```

Lock waits (`LCK_M_*`) that appear only while index maintenance runs, and that weren't present before the edition change, support a loss of online index operations as the cause.

Index rebuilds and `DBCC CHECKDB`, `DBCC CHECKTABLE`, and `DBCC CHECKFILEGROUP` also use parallel processing only in Enterprise edition. Outside Enterprise edition, these operations always run on a single thread, regardless of `MAXDOP` or how many CPUs the edition allows. While the operation is running, confirm how many worker threads it's using:

```sql
SELECT
    t.session_id,
    t.request_id,
    t.exec_context_id,
    r.command
FROM sys.dm_os_tasks t
JOIN sys.dm_exec_requests r
    ON r.session_id = t.session_id
    AND r.request_id = t.request_id
WHERE r.command IN ('DBCC', 'CREATE INDEX', 'ALTER INDEX');
```

Multiple rows with different `exec_context_id` values for the same `session_id` indicate that the operation is running in parallel. If only one row appears regardless of the server's CPU count or `MAXDOP` setting, the current edition doesn't support parallel index maintenance or parallel consistency checking, and the longer duration is expected for that edition.

### Step 3: Determine whether backup or restore duration increased

Check whether backup compression is configured and confirm it's supported on the current edition:

```sql
SELECT
    name,
    value_in_use
FROM sys.configurations
WHERE name = 'backup compression default';
```

Compare backup size and duration using backup history:

```sql
SELECT
    bs.database_name,
    bs.backup_start_date,
    bs.backup_finish_date,
    DATEDIFF(SECOND, bs.backup_start_date, bs.backup_finish_date) AS duration_seconds,
    bs.backup_size,
    bs.compressed_backup_size
FROM msdb.dbo.backupset bs
WHERE bs.database_name = N'<database_name>'
ORDER BY bs.backup_start_date DESC;
```

If `compressed_backup_size` equals `backup_size`, the backup wasn't compressed. Compare `backup_size` and `duration_seconds` across backups taken before and after the edition change.

If a restore previously used online page or file restore to keep the database available, confirm whether that option is still supported on the current edition. On an edition that doesn't support it, the equivalent restore requires the database or file to go offline.

#### Interpret the backup and restore findings

The following observations support an edition-specific cause for slower backups or restores:

- Backups taken after the edition change aren't compressed, and `backup compression default` can't be enabled on the current edition.
- Backup duration increased in proportion to the increase in backup size.
- A restore that previously kept the database or file online now requires it to go offline, and the current edition doesn't support online page or file restore.

If backup compression and backup size are unchanged and the restore method didn't change, an edition-specific cause is less likely. Compare storage and network throughput between the source and target environments instead.

### Step 4: Determine whether startup, failover, or recovery duration increased

Review the SQL Server error log for the affected startup, failover, or recovery event. Note the timestamps for the start of recovery and the point at which the database became available.

Check whether Accelerated Database Recovery is enabled:

```sql
SELECT
    name,
    is_accelerated_database_recovery_on
FROM sys.databases
WHERE name = N'<database_name>';
```

- If ADR isn't enabled and isn't supported on the current edition, recovery time can increase with the size of the longest transaction that was active at the time of the shutdown or failover, instead of remaining largely constant.

- If the server has a large amount of memory, also check the buffer-pool-scan duration as described in [Scenario 2, Step 5](#step-5-check-edition-specific-patterns-for-the-affected-queries).

#### Interpret the startup, failover, and recovery findings

The following observations support an edition-specific cause for slower startup, failover, or recovery:

- The previous environment was Enterprise edition and relied on Fast Recovery to make the database available after the redo phase, and the current edition doesn't support Fast Recovery.
- A long-running transaction was active at the time of the crash or failover, ADR isn't enabled or isn't supported on the current edition, and recovery time is roughly proportional to the size of that transaction.
- The buffer-pool-scan duration increased on a large-memory server that moved to Web or Express edition.

If none of these conditions apply, review storage latency and the size of the transaction log that needed to be processed during recovery. Those factors affect recovery time independently of the edition.

### Potential resolutions for slower maintenance or recovery

Depending on your findings, consider the following actions:

- If online index operations aren't available, schedule blocking index maintenance during a low-activity window. Use `REORGANIZE` instead of `REBUILD` where appropriate because reorganizing an index is always an online operation. Process tables in smaller batches to reduce the duration of each blocking operation.
- If resumable online index rebuilds aren't available, plan for a rebuild to run to completion, and monitor for conditions that could cause it to be canceled.
- If backup compression isn't available, enable it explicitly by using `WITH COMPRESSION` where the edition supports it. Or, evaluate the storage and network impact of uncompressed backups on Web or Express edition.
- If online page or file restore isn't available, include the additional offline time in the recovery time objective (RTO) for the affected database.
- If Fast Recovery isn't available, account for the additional time that a database stays unavailable after a failover or restart. Consider enabling Accelerated Database Recovery on editions that support it to reduce the effect of long-running transactions on recovery time.
- If the workload depends on an Enterprise-only maintenance or recovery capability and the additional time isn't acceptable, move the workload to an edition that supports the required capability.
