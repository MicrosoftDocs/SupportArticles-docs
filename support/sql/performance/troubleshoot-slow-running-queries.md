---
title: Troubleshoot slow-running queries
description: This article describes how to handle a performance issue that applications may experience in conjunction with Microsoft SQL Server.
ms.date: 08/11/2022
ms.custom: sap:Performance
ms.prod: sql
---
# Troubleshoot slow-running queries on SQL Server

## Introduction

This article describes how to handle a performance issue that applications may experience in conjunction with SQL Server: slow performance of a specific query or group of queries. If you are troubleshooting a performance issue, but you have not isolated the problem to a specific query or small group of queries that perform slower than expected, see [Monitor and Tune for Performance](/sql/relational-databases/performance/monitor-and-tune-for-performance) before you continue.

This article assumes that you have used the article 298475 to narrow down the scope of the problem, and that you have captured a SQL Profiler trace with the specific events and data columns that are detailed in the article 224587.

Tuning database queries can be a multi-faceted endeavor. The following sections discuss common items to examine when you are investigating query performance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 243589

## Slow performance troubleshooting methodology

### 1. Find slow queries

To establish that you have query performance issues on your SQL Server instance, start by examining queries by their execution time (elapsed time). Check if the time exceeds a threshold you have set (in milliseconds), based on a established baseline performance. For example, for your workload the threshold may be set for queries that run longer than 300 ms. You can identify all queries that exceed that threshold, focusing on each individual query and its pre-established performance baseline duration. Ultimately, business users care about the execution duration of their database queries; therefore, the focus is on execution duration.

[!INCLUDE [collect query data and logical reads](../includes/performance/collect-cpu-time-elapsed-time-logical-reads.md)]


### 2. Running vs. waiting: Why are queries slow?

If you find queries that exceed your predefined threshold, next examine why they could be slow. The cause of performance problems can be grouped into two categories: RUNNING or WAITING
o	WAITING: Queries can be slow because they are waiting on a bottleneck for a long time. See types of Waits.
o	RUNNING: Queries can be slow because they are running (executing) for a long time. This means these queries are actively using CPU resources.
A query can be running for some time and waiting for some time in its lifetime (duration). However, you want to establish which is the dominant category that contributes to its long elapsed time. Therefore, the first task is to establish in which category the queries fall. 
It is simple: if a query is not running, then it is waiting. Ideally, a query spends most of its elapsed time in running state and very little time waiting for resources. Also, in the best-case scenario a query runs within or below a predetermined baseline. Compare the elapsed time and CPU time of the query to determine the issue type for both servers.

[!INCLUDE [[establish runner or waiter perf type]](../includes/performance/establish-runner-waiter-perf-type.md)]


### 3. Diagnose and resolve waiting queries

[!INCLUDE [diagnose waits](../includes/performance/diagnose-waits-or-bottlenecks.md)]



### 4. Diagnose and resolve running queries

If CPU (worker) time is very close to the overall elapsed duration, that means the query spent most of its lifetime executing. Typically, when the SQL Server engine is reported to drive high CPU, it is high-CPU queries that drive a large number of logical reads that are the root cause. 

[!INCLUDE [identify cpu bound queries](../includes/performance/identify-cpu-bound-queries.md)]


#### Common methods to resolve long-running, CPU-bound queries

-	[Examine the query plan of the query](/sql/relational-databases/performance/display-an-actual-execution-plan)
- [Update Statistics](/sql/t-sql/statements/update-statistics-transact-sql)
- Identify and apply [Missing Indexes](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-missing-index-details-transact-sq). See [Tune nonclustered indexes with missing index suggestions](/sql/relational-databases/indexes/tune-nonclustered-missing-index-suggestions) for steps on how to identify missing indexes.
- Re-design or re-write the queries
- Identify and resolve [parameter-sensitive plans](troubleshoot-high-cpu-usage-issues.md#step-5-investigate-and-resolve-parameter-sensitive-issues)
- Identify and resolve [SARG-ability issues](troubleshoot-high-cpu-usage-issues.md#step-6-investigate-and-resolve-sargability-issues)
- Assess and resolve [cardinality estimation](/sql/relational-databases/performance/cardinality-estimation-sql-server) issues. See [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md)
- Identify high CPU performance issues; see [Troubleshoot high-CPU-usage issues in SQL Server](troubleshoot-high-cpu-usage-issues.md)
- Increase computing resources on the system (CPUs)

## Recommended resources
- [Detectable types of query performance bottlenecks in SQL Server and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/identify-query-performance-issues?view=azuresql)
- [Performance Monitoring and Tuning Tools](/sql/relational-databases/performance/performance-monitoring-and-tuning-tools)
- [Auto-Tuning Options in SQL Server](/sql/relational-databases/automatic-tuning/automatic-tuning)
- [Index architecture and Design Guidelines](/sql/relational-databases/sql-server-index-design-guide#General_Design)
