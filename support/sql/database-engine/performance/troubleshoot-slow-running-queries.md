---
title: Troubleshoot Slow-Running Queries in SQL Server
description: Learn how to diagnose and fix slow-running queries in SQL Server by determining whether a query is waiting on a bottleneck or running on the CPU.
ms.date: 08/06/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# Troubleshoot slow-running queries in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 243589

## Summary

This article describes how to troubleshoot slow-running queries in SQL Server, one of the most common performance issues that database applications experience. It provides a methodology that determines whether a query is slow because it's *waiting* on a bottleneck, or because it's *running* (executing) on the CPU for a long time. After you identify which category a query falls into, you can apply the matching resolution, such as reducing waits, tuning indexes, updating statistics, examining the query plan, or resolving parameter-sensitive plans.

This methodology applies to SQL Server. The high-level approach of separating waiting queries from running queries can also help when you troubleshoot [query performance in Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/identify-query-performance-issues), although the available tools, permissions, and resource options differ in those products.

## How to identify slow-running queries in SQL Server

To establish that you have query performance issues on your SQL Server instance, start by examining queries by their execution time (elapsed time). Check whether the time exceeds a threshold (in milliseconds) that you set based on an established performance baseline. For example, in a stress testing environment, you might establish a threshold of no longer than 300 ms for your workload, and then use that threshold.

Next, identify all queries that exceed that threshold, focusing on each individual query and its pre-established baseline duration. Ultimately, business users care about the overall duration of database queries, so the main focus is on execution duration. Other metrics like CPU time and logical reads are gathered to help narrow down the investigation.

If [Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) is enabled on the database, you can also use the built-in reports to find the highest-duration queries and compare their performance over time.

[!INCLUDE [collect query data and logical reads](../../includes/performance/collect-cpu-time-elapsed-time-logical-reads.md)]

## Running vs. waiting: why are queries slow in SQL Server?

If you find queries that exceed your predefined threshold, examine why they could be slow. The cause of query performance problems in SQL Server falls into two categories: running or waiting.

- **WAITING**: Queries can be slow because they're waiting on a bottleneck for a long time. See a detailed list of bottlenecks in [types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).

- **RUNNING**: Queries can be slow because they're running (executing) for a long time. In other words, these queries actively use CPU resources.

A query can be running for some time and waiting for some time in its lifetime (duration). However, your focus is to determine which is the dominant category that contributes to its long elapsed time. Therefore, the first task is to establish in which category the queries fall. It's simple: if a query isn't running, it's waiting. Ideally, a query spends most of its elapsed time in a running state and very little time waiting for resources. Also, in the best-case scenario, a query runs within or below a predetermined baseline. Compare the elapsed time and CPU time of the query to determine the issue type.

[!INCLUDE [establish runner or waiter perf type](../../includes/performance/establish-runner-waiter-perf-type.md)]

### High-level visual representation of the troubleshooting methodology

:::image type="content" source="media/troubleshoot-slow-queries/slow-queries-flow.svg" alt-text="Screenshot of a flowchart that shows how to troubleshoot slow-running queries in SQL Server by separating waiting queries from running queries.":::

## Diagnose and resolve waiting queries in SQL Server

If you establish that your queries of interest are waiters, focus on resolving bottleneck issues. Otherwise, go to [Diagnose and resolve running queries](#diagnose-and-resolve-running-queries-in-sql-server).

[!INCLUDE [diagnose waits](../../includes/performance/diagnose-waits-or-bottlenecks.md)]

## Diagnose and resolve running queries in SQL Server

If CPU (worker) time is very close to the overall elapsed duration, the query spends most of its lifetime executing. Typically, when the SQL Server engine drives high CPU usage, the high CPU usage comes from queries that drive a large number of logical reads (the most common reason).

[!INCLUDE [identify cpu bound queries](../../includes/performance/identify-cpu-bound-queries.md)]

### Common methods to resolve long-running, CPU-bound queries

- [Examine the query plan of the query](/sql/relational-databases/performance/display-an-actual-execution-plan)
- [Update Statistics](/sql/t-sql/statements/update-statistics-transact-sql)
- Identify and apply [Missing Indexes](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-missing-index-details-transact-sql). For more steps on how to identify missing indexes, see [Tune nonclustered indexes with missing index suggestions](/sql/relational-databases/indexes/tune-nonclustered-missing-index-suggestions)
- Redesign or rewrite the queries
- Identify and resolve [parameter-sensitive plans](../performance/troubleshoot-high-cpu-usage-issues.md#step-5-investigate-and-resolve-parameter-sensitive-issues)
- Identify and resolve [SARG-ability issues](../performance/troubleshoot-high-cpu-usage-issues.md#step-6-investigate-and-resolve-sargability-issues)
- Identify and resolve [Row goal](/archive/blogs/queryoptteam/row-goals-in-action) issues where long-running nested loops can be caused by TOP, EXISTS, IN, FAST, SET ROWCOUNT, OPTION (FAST N). For more information, see [Row Goals Gone Rogue](/archive/blogs/bartd/row-goals-gone-rogue) and [Showplan enhancements - Row Goal EstimateRowsWithoutRowGoal](https://techcommunity.microsoft.com/t5/sql-server-blog/more-showplan-enhancements-8211-row-goal/ba-p/385839)
- Assess and resolve [cardinality estimation](/sql/relational-databases/performance/cardinality-estimation-sql-server) issues. For more information, see [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md)
- Identify and resolve queries that seem to never complete. For more information, see [Troubleshoot queries that seem to never end in SQL Server](../performance/troubleshoot-never-ending-query.md).
- Identify and resolve [slow queries affected by optimizer timeout](troubleshoot-optimizer-timeout-performance.md)
- Identify high CPU performance issues. For more information, see [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md)
- [Troubleshoot a query that shows a significant performance difference between two servers](../performance/troubleshoot-query-perf-between-servers.md)
- Increase computing resources on the system (CPUs)
- [Troubleshoot UPDATE performance issues with narrow and wide plans](../performance/troubleshoot-performance-narrow-vs-wide-plans.md)

## Related content

- [Detectable types of query performance bottlenecks in SQL Server and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/identify-query-performance-issues)
- [Performance monitoring and tuning tools](/sql/relational-databases/performance/performance-monitoring-and-tuning-tools)
- [Automatic tuning in SQL Server](/sql/relational-databases/automatic-tuning/automatic-tuning)
- [SQL Server index architecture and design guide](/sql/relational-databases/sql-server-index-design-guide#General_Design)
- [Troubleshoot query time-out errors in SQL Server](../performance/troubleshoot-query-timeouts.md)
- [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md)
- [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](../performance/decreased-query-perf-after-upgrade.md)
