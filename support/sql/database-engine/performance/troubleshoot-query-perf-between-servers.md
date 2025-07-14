---
title: Troubleshoot a query that shows different performance between two servers
description: Provides troubleshooting steps for an issue where a query shows significantly different performance on two servers.
ms.date: 06/10/2022
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.topic: troubleshooting
ms.reviewer: shaunbe, haiyingyu
author: pijocoder
ms.author: jopilov
---

# Troubleshoot a query that shows a significant performance difference between two servers

_Applies to:_ &nbsp; SQL Server

This article provides troubleshooting steps for a performance issue where a query runs slower on one server than on another server.

## Symptoms

Assume there are two servers with SQL Server installed. One of the SQL Server instances contains a copy of a database in the other SQL Server instance. When you run a query against the databases on both servers, the query runs slower on one server than the other.

The following steps can help troubleshoot this issue.

## Step 1: Determine whether it's a common issue with multiple queries

Use one of the following two methods to compare the performance for two or more queries on the two servers:

- Manually test the queries on both servers:

    1. Choose several queries for testing with priority placed on queries that are:
       - Significantly faster on one server than on the other.
       - Important to the user/application.
       - Frequently executed or designed to reproduce the issue on demand.
       - Sufficiently long to capture data on it (for example, instead of a 5-milliseconds query, choose a 10-seconds query).
    1. Run the queries on the two servers.
    1. Compare the elapsed time (duration) on two servers for each query.

- Analyze performance data with [SQL Nexus](https://github.com/microsoft/SqlNexus).

  1. Collect [PSSDiag/SQLdiag](https://github.com/microsoft/DiagManager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) data for the queries on the two servers.
  1. Import the collected data files with SQL Nexus and compare the queries from the two servers. For more information, see [Performance Comparison between two log collections (Slow and Fast for example)](https://github.com/microsoft/SqlNexus/wiki/Reports-via-SQL-Queries#performance-comparison-between-two-log-collections-slow-and-fast-for-example).

### Scenario 1: Only one single query performs differently on the two servers

If only one query performs differently, the issue is more likely specific to the individual query rather than to the environment. In this case, go to [Step 2: Collect data and determine the type of performance issue](#step-2-collect-data-and-determine-the-type-of-performance-issue).

### Scenario 2: Multiple queries perform differently on the two servers

If multiple queries run slower on one server than the other, the most probable cause is the differences in server or data environment. Go to [Diagnose environment differences](#diagnose-environment-differences) and see if the comparison between the two servers is valid.

## Step 2: Collect data and determine the type of performance issue

### Collect Elapsed time, CPU time, and Logical Reads

To collect elapsed time and CPU time of the query on both servers, use one of the following methods that best fits your situation:

[!INCLUDE [collect query data and logical reads](../../includes/performance/collect-cpu-time-elapsed-time-logical-reads.md)]

Compare the elapsed time and CPU time of the query to determine the issue type for both servers.

[!INCLUDE [establish runner or waiter perf type](../../includes/performance/establish-runner-waiter-perf-type.md)]


## Step 3: Compare data from both servers, figure out the scenario, and troubleshoot the issue

Let's assume that there are two machines named Server1 and Server2. And the query runs slower on Server1 than on Server2. Compare the times from both servers and then follow the actions of the scenario that best matches yours from the following sections.

### Scenario 1: The query on Server1 uses more CPU time, and the logical reads are higher on Server1 than on Server2

If the CPU time on Server1 is much greater than on Server2 and the elapsed time matches the CPU time closely on both servers, there are no major waits or bottlenecks. The increase in CPU time on Server1 is most likely caused by an increase in logical reads. A significant change in logical reads typically indicates a difference in query plans. For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   3100          | 3000        | 300000        |
|Server2 |   1100          | 1000        |  90200        |

#### Action: Check execution plans and environments

1. Compare execution plans of the query on both servers. To do this, use one of the two methods:
   - Compare execution plans visually. For more information, see [Display an Actual Execution Plan](/sql/relational-databases/performance/display-an-actual-execution-plan).
   - Save the execution plans and compare them by using [SQL Server Management Studio Plan Comparison feature](/sql/relational-databases/performance/compare-execution-plans).
1. Compare environments. Different environments may lead to query plan differences or direct differences in CPU usage. Environments include server versions, database or server configuration settings, trace flags, CPU count or clock speed, and Virtual Machine versus Physical Machine. See [Diagnose query plan differences](#diagnose-query-plan-differences) for details.

### Scenario 2: The query is a waiter on Server1 but not on Server2

If the CPU times for the query on both servers are similar but the elapsed time on Server1 is much greater than on Server2, the query on Server1 spends a much longer time [waiting on a bottleneck](#type-2-waiting-on-a-bottleneck-waiter). For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   4500          |  1000       |  90200        |
|Server2 |   1100          |  1000       |  90200        |

- Waiting time on Server1: 4500 - 1000 = 3500 ms
- Waiting time on Server2: 1100 - 1000 = 100 ms

#### Action: Check wait types on Server1

Identify and eliminate the bottleneck on Server1. Examples of waits are blocking (lock waits), latch waits, disk I/O waits, network waits, and memory waits. To troubleshoot common bottleneck issues, proceed to [Diagnose waits or bottlenecks](#diagnose-waits-or-bottlenecks).

### Scenario 3: The queries on both servers are waiters, but the wait types or times are different

For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   8000          |  1000       |  90200        |
|Server2 |   3000          |  1000       |  90200        |

- Waiting time on Server1: 8000 - 1000 = 7000 ms
- Waiting time on Server2: 3000 - 1000 = 2000 ms

In this case, the CPU times are similar on both servers, which indicates query plans are likely the same. The queries would perform equally on both servers if they don't wait for the bottlenecks. So the duration differences come from the different amounts of wait time. For example, the query waits on locks on Server1 for 7000 ms while it waits on I/O on Server2 for 2000 ms.

#### Action: Check wait types on both servers

Address each bottleneck wait individually on each server and speed up executions on both servers. Troubleshooting this issue is labor-intensive because you need to eliminate bottlenecks on both servers and make the performance comparable. To troubleshoot common bottleneck issues, proceed to [Diagnose waits or bottlenecks](#diagnose-waits-or-bottlenecks).

### Scenario 4: The query on Server1 uses more CPU time than on Server2, but the logical reads are close

For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   3000          | 3000        |  90200        |
|Server2 |   1000          | 1000        |  90200        |

If the data matches the following conditions:

- The CPU time on Server1 is much greater than on Server2.
- The elapsed time matches the CPU time closely on each server, which indicates no waits.
- The logical reads, typically the highest driver of CPU time, are similar on both servers.

Then the additional CPU time comes from some other CPU-bound activities. This scenario is the rarest of all the scenarios.

#### Causes: Tracing, UDFs and CLR integration

This issue may be caused by:

- XEvents/SQL Server tracing, especially with filtering on text columns (database name, login name, query text, and so on). If tracing is enabled on one server but not on the other, this could be the reason for the difference.
- User-defined functions (UDFs) or other T-SQL code that performs CPU-bound operations. This would typically be the cause when other conditions are different on Server1 and Server2, such as data size, CPU clock speed, or Power plan.
- [SQL Server CLR integration](/dotnet/framework/data/adonet/sql/introduction-to-sql-server-clr-integration) or [Extended Stored procedures (XPs)](/sql/relational-databases/extended-stored-procedures-programming/database-engine-extended-stored-procedures-programming) that may drive CPU but don't perform logical reads. Differences in the DLLs may lead to different CPU times.
- Difference in SQL Server functionality that is CPU-bound (e.g., string-manipulation code).

#### Action: Check traces and queries

1. Check traces on both servers for the following:
    1. If there's any trace enabled on Server1 but not on Server2.
    1. If any trace is enabled, disable the trace and run the query again on Server1.
    1. If the query runs faster this time, enable the trace back but remove text filters from it, if there are any.

1. Check if the query uses UDFs that do string manipulations or do extensive processing on data columns in the `SELECT` list.
1. Check if the query contains loops, function recursions, or nestings.

## Diagnose environment differences

Check the following questions and determine whether the comparison between the two servers is valid.

[!INCLUDE [diagnose environment differences](../../includes/performance/diagnose-environment-differences.md)]

## Diagnose waits or bottlenecks

[!INCLUDE [diagnose waits](../../includes/performance/diagnose-waits-or-bottlenecks.md)]

## Diagnose query plan differences

[!INCLUDE [diagnose query plan differences](../../includes/performance/diagnose-query-plan-differences.md)]
