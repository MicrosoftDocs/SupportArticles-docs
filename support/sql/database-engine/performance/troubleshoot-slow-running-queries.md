---
title: Troubleshoot slow-running queries
description: This article describes how to handle a performance issue that applications may experience when using SQL Server.
ms.date: 08/22/2022
ms.custom: sap:Performance
---
# Troubleshoot slow-running queries in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 243589

## Introduction

This article describes how to handle a performance issue that database applications may experience when using SQL Server: slow performance of a specific query or group of queries. The following methodology will help you narrow down the cause of the slow queries issue and direct you towards resolution.

## Find slow queries

To establish that you have query performance issues on your SQL Server instance, start by examining queries by their execution time (elapsed time). Check if the time exceeds a threshold you have set (in milliseconds) based on an established performance baseline. For example, in a stress testing environment, you may have established a threshold for your workload to be no longer than 300 ms, and you can use this threshold. Then, you can identify all queries that exceed that threshold, focusing on each individual query and its pre-established performance baseline duration. Ultimately, business users care about the overall duration of database queries; therefore, the main focus is on execution duration. Other metrics like CPU time and logical reads are gathered to help with narrowing down the investigation.

[!INCLUDE [collect query data and logical reads](../../includes/performance/collect-cpu-time-elapsed-time-logical-reads.md)]

## Running vs. Waiting: why are queries slow?

If you find queries that exceed your predefined threshold, examine why they could be slow. The cause of performance problems can be grouped into two categories, running or waiting:

- **WAITING**: Queries can be slow because they're waiting on a bottleneck for a long time. See a detailed list of bottlenecks in [types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).

- **RUNNING**: Queries can be slow because they're running (executing) for a long time. In other words, these queries are actively using CPU resources.

A query can be running for some time and waiting for some time in its lifetime (duration). However, your focus is to determine which is the dominant category that contributes to its long elapsed time. Therefore, the first task is to establish in which category the queries fall. It's simple: if a query isn't running, it's waiting. Ideally, a query spends most of its elapsed time in a running state and very little time waiting for resources. Also, in the best-case scenario, a query runs within or below a predetermined baseline. Compare the elapsed time and CPU time of the query to determine the issue type.

[!INCLUDE [establish runner or waiter perf type](../../includes/performance/establish-runner-waiter-perf-type.md)]

### High-level visual representation of the methodology

:::image type="content" source="media/troubleshoot-slow-queries/slow-queries-flow.svg" alt-text="The screenshot shows a high-level visual representation of the methodology for troubleshooting slow queries.":::

## Diagnose and resolve waiting queries

If you established that your queries of interest are waiters, your next step is to focus on resolving bottleneck issues. Otherwise, go to step 4: [Diagnose and resolve running queries](#diagnose-and-resolve-running-queries).

[!INCLUDE [diagnose waits](../../includes/performance/diagnose-waits-or-bottlenecks.md)]

## Diagnose and resolve running queries

If CPU (worker) time is very close to the overall elapsed duration, the query spends most of its lifetime executing. Typically, when the SQL Server engine drives high CPU usage, the high CPU usage is coming from queries that drive a large number of logical reads (the most common reason).

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
- Identify and resolve quries that seem no never complete, see [Troubleshoot queries that seem to never end in SQL Server](../performance/troubleshoot-never-ending-query.md)
- Identify and resolve [slow queries affected by optimizer timeout](troubleshoot-optimizer-timeout-performance.md)
- Identify high CPU performance issues. For more information, see [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md)
- [Troubleshoot a query that shows a significant performance difference between two servers](../performance/troubleshoot-query-perf-between-servers.md)
- Increase computing resources on the system (CPUs)
- [Troubleshoot UPDATE performance issues with narrow and wide plans](../performance/troubleshoot-performance-narrow-vs-wide-plans.md)

## Recommended resources

- [Detectable types of query performance bottlenecks in SQL Server and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/identify-query-performance-issues)
- [Performance Monitoring and Tuning Tools](/sql/relational-databases/performance/performance-monitoring-and-tuning-tools)
- [Auto-Tuning Options in SQL Server](/sql/relational-databases/automatic-tuning/automatic-tuning)
- [Index architecture and Design Guidelines](/sql/relational-databases/sql-server-index-design-guide#General_Design)
- [Troubleshoot query time-out errors](../performance/troubleshoot-query-timeouts.md)
- [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md)
- [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](../performance/decreased-query-perf-after-upgrade.md)
