---
title: Troubleshoot a query that shows different performance on two servers
description: Provides troubleshooting steps for an issue where a query shows significantly different performance on two servers.
ms.date: 05/27/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.reviewer: shaunbe
author: pijocoder
ms.author: jopilov
---

# Troubleshoot a query that shows significant performance difference between two servers

_Applies to:_ &nbsp; SQL Server

This article provides troubleshooting steps for a performance issue where a query runs slower on one server than on another server.

## Symptoms

Assume there are two servers with SQL Server installed. One of the SQL Server instances contains a copy of a database in the other SQL Server instance. When you run a query against the databases on both servers, the query runs slower on one server while it runs faster on the other server.

Follow the following steps to troubleshoot this issue.

## Step 1: Determine whether it's a common issue with multiple queries

Use one of the following two methods to compare query performance on the two servers:

- Manually test two or more queries on both servers:

    1. Choose several queries for testing with considering the queries are:
       - Significantly faster on one server than on the other
       - Important to the user/application
       - Frequently executed or designed to reproduce the issue on demand
       - Sufficiently long to capture data on it (for example, instead of a 5-milliseconds query, choose a 10-seconds query)
    1. Run the queries on the two servers.
    1. Compare the elapsed time (duration) on two servers for each query.

- Analyze performance data with [SQL Nexus](https://github.com/microsoft/SqlNexus).

  1. Collect [PSSDiag/SQLdiag](https://github.com/microsoft/DiagManager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) data on the two servers.
  1. Import the collected data files with SQL Nexus and compare queries from two servers. For more information, see [Performance Comparison between two log collections (Slow and Fast for example)](https://github.com/microsoft/SqlNexus/wiki/Reports-via-SQL-Queries#performance-comparison-between-two-log-collections-slow-and-fast-for-example).

### Scenario 1: Only one single query performs differently on the two servers

If only one single query performs differently, the issue is more likely specific to the individual query, rather than to the environment. In this case, go to [Step 2: Collect data and determine the type of the performance issue](#step-2-collect-data-and-determine-the-type-of-the-performance-issue).

### Scenario 2: Multiple queries perform differently on the two servers

If multiple queries run slower on one server compared to the other, the most probable cause is the differences in server or data environment. Go to [Diagnose environment differences](#diagnose-environment-differences) and see if the comparison between the two servers is valid.

## Step 2: Collect data and determine the type of the performance issue

### Collect Elapsed time and CPU time

To collect elapsed time and CPU time of the query on both servers, use one of the following methods that best fits your situation:

- For currently executing statements, check **total_elapsed_time** and **cpu_time** columns in [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql). Run the following query to get the data:

   ```sql
   SELECT 
      req.session_id
      , req.total_elapsed_time AS duration_ms
      , req.cpu_time AS cpu_time_ms
      , req.total_elapsed_time - req.cpu_time AS wait_time
      , SUBSTRING (REPLACE (REPLACE (SUBSTRING (ST.text, (req.statement_start_offset/2) + 1, 
         ((CASE statement_end_offset
             WHEN -1
             THEN DATALENGTH(ST.text)  
             ELSE req.statement_end_offset
           END - req.statement_start_offset)/2) + 1) , CHAR(10), ' '), CHAR(13), ' '), 
        1, 512)  AS statement_text  
   FROM sys.dm_exec_requests AS req
      CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) AS ST
   ORDER BY cpu_time DESC;
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
  > If `avg_wait_time` shows a negative value that means it's a [parallel query](#parallel-queries---runner-or-waiter).

- If you can execute the query on demand in SQL Server Management Studio (SSMS) or Azure Data Studio, run it with [SET STATISTICS TIME](/sql/t-sql/statements/set-statistics-time-transact-sql) `ON`.

   ```sql
   SET STATISTICS TIME ON
   <Your Query>
   SET STATISTICS TIME OFF
   ```

  Then from **Messages**, you'll see the CPU time and elapsed time like this:

   ```output
    SQL Server Execution Times:
      CPU time = 460 ms,  elapsed time = 470 ms.
   ```

- If you can collect a query plan, check the data from [Execution plan properties](/sql/ssms/scripting/use-the-properties-window-in-management-studio#to-view-the-properties-of-a-showplan-operator).

  1. Run the query with **Include Actual Execution Plan** on.
  1. Select the left-most operator from **Execution plan**.
  1. From **Properties**, expand **QueryTimeStats** property
  1. Check **ElapsedTime** and **CpuTime**.

  :::image type="content" source="media/troubleshoot-slow-query-comparison/query-time-stats-from-query-plan.png" alt-text="CPU-and-Elapsed-Time-in-execution-plan":::

Compare the elapsed time and CPU time of the query to determine the issue type for both servers.

### Type 1: CPU-bound (runner)

If the CPU time is close, equal to, or higher than the elapsed time, then you can treat it as a CPU-bound query. For example, if the elapsed time is 3000 milliseconds (ms) and the CPU time is 2900 ms, that means the most of the elapsed time is spent on the CPU. Then we can say it's a CPU-bound query.

> [!Note]
> If the CPU time is greater than the duration, then a parallel query was being executed while multiple threads were using the CPU at the same time when the clock was ticking. For more information, see [Parallel queries - runner or waiter](#parallel-queries---runner-or-waiter).

### Type 2: Waiting on a bottleneck (waiter)

A query is waiting on a bottleneck if the elapsed time is significantly greater than the CPU time. The elapsed time includes the time executing the query on the CPU (CPU time) and the time waiting for a resource to be released (wait time). For example, if the elapsed time is 2000 ms and the CPU time is 300 ms, then the wait time is 1700 ms (2000 - 300 = 1700). For more information, see [Types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).

### Parallel queries - runner or waiter

Parallel queries may use more CPU time than the overall duration. In fact, that is the goal of parallelism - to allow multiple threads to run parts of a query simultaneously. It means in one second of clock time, a query may use eight seconds of CPU by executing eight parallel threads. Therefore, it becomes challenging to determine a CPU-bound or a waiting query based on the difference of the elapsed time and CPU time. However, as a general rule, follow the principles listed in the above two sections. The summary is:

- If the elapsed time is much greater than the CPU time, consider it a waiter.
- If the CPU time is much greater than the elapsed time, consider it a runner.

## Step 3: Compare data from both servers, figure out the scenario and troubleshoot the issue

Let's assume that there are two machines named Server1 and Server2. And the query runs slower on Server1 than on Server2. Compare the times from both servers and then follow the actions of the scenario that best matches yours from the following sections.

### Scenario 1: The query on Server1 uses more CPU time and the logical reads is higher on Server1 than on Server2

If the CPU time on Server1 is much greater than on Server2 and the elapsed time matches the CPU time closely on both servers, then there are no major waits or bottlenecks. The increase in CPU time on Server1 is most likely caused by an increase in logical reads. A significant change in logical reads indicates a difference in query plans. For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   3100          | 3000        | 300000        |
|Server2 |   1100          | 1000        |  90200        |

#### Action: Check execution plans and environments

1. Compare execution plans of the query on both Servers. To do this, user one of the two methods:
   - Compare execution plans visually. For more information, see [Display an Actual Execution Plan](/sql/relational-databases/performance/display-an-actual-execution-plan).
   - Save the execution plans and compare them by using [SQL Server Management Studio Plan Comparison feature](/sql/relational-databases/performance/compare-execution-plans).
1. Compare environments. Different environments may lead to query plan differences or to direct difference in CPU usage. Environments include server versions, database or server configuration settings, trace flags, CPU count or clock speed, Virtual Machine versus Physical Machine. See [Diagnose query plan differences](#diagnose-query-plan-differences) for details.

### Scenario 2: The query is a waiter on Server1 but not on Server2

If the CPU times for the query on both servers are similar but the elapsed time on Server1 is much greater than on Server2, the query on Server1 spends much longer time [waiting on a bottleneck](#type-2-waiting-on-a-bottleneck-waiter). For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   4500          |  1000       |  90200        |
|Server2 |   1100          |  1000       |  90200        |

- Waiting time on Server1: 4500 - 1000 = 3500 ms
- Waiting time on Server2: 1100 - 1000 = 100 ms

#### Action: Check wait types on Server1

Identify and eliminate the bottleneck on Server1. Examples of waits are blocking (lock waits), latch waits, disk I/O waits, network waits, memory waits. To troubleshoot common bottleneck issues, step to [Diagnose waits/bottlenecks](#diagnose-waitsbottlenecks).

### Scenario 3: The queries on both servers are waiters, but the wait types are different

For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   8000          |  1000       |  90200        |
|Server2 |   3000          |  1000       |  90200        |

- Waiting time on Server1: 8000 - 1000 = 7000 ms
- Waiting time on Server2: 3000 - 1000 = 2000 ms

In this case, the CPU times are similar on both servers, that indicates query plans are likely the same. The queries would perform equally on both servers if they don't wait for the bottlenecks. So the duration differences come from the waits on different resources. For example, the query waits on locks on Server1 while it waits on I/O on Server2.

#### Action: Check wait types on both servers

Address each bottleneck wait individually on each server and speed up executions on both servers. Troubleshooting this issue is labor-intensive because you need to eliminate bottlenecks on both servers and make the performance comparable. To troubleshoot common bottleneck issues, step to [Diagnose waits/bottlenecks](#diagnose-waitsbottlenecks).

### Scenario 4: The query on Server1 uses more CPU time than on Server2 but the logical reads are close

For example:

|Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|--------|-----------------|-------------|---------------|
|Server1 |   3000          | 3000        |  90200        |
|Server2 |   1000          | 1000        |  90200        |

If the data matches the following conditions:

- The CPU time on Server1 is much greater than on Server2
- The elapsed time matches the CPU time closely on both servers
- The logical reads, typically the highest driver of CPU time, are similar on both servers.

Then the additional CPU time comes from some other CPU-bound activities. It's the least common one of all the scenarios.

#### Causes: tracing, UDFs and CLR intergration

This issue may be caused by:

- XEvents/SQL Server tracing, especially with filtering on text columns (database name, login name, query text, and so on). If tracing is enabled on one server but not on the other, this could be the reason for the difference.
- User-defined functions (UDFs) or other T-SQL code that performs CPU-bound operations. This would typically be the cause when other conditions are different on Server1 and Server2, such as data size, CPU clock speed, or Power plan.
- [SQL Server CLR integration](/dotnet/framework/data/adonet/sql/introduction-to-sql-server-clr-integration) or [Extended Stored procedures (XPs)](/sql/relational-databases/extended-stored-procedures-programming/database-engine-extended-stored-procedures-programming) that may drive CPU but doesn't perform logical reads. Differences in the DLLs may lead to different CPU times.
- Difference in SQL Server functionality that is CPU-bound (e.g. string-manipulation code).

#### Action: Check traces and queries

1. Check traces on both servers.
    1. If there's any trace enabled on Server1 but not on Server2.
    1. If yes, disable the trace and run the query again on Server1.
    1. If the query runs faster this time, enable the trace back but remove text filters from it, if there are any.

1. Check if the query uses UDFs that do string manipulations or do extensive processing on data columns in the `SELECT` list.
1. Check if the query contains loops, function recursions or nestings.

## Diagnose environment differences

Check the following questions and determine whether the comparison between the two servers is valid.

- Are the two SQL Server instances the same version or build?

  If not, there could be some fixes that caused the differences. Run the following query to get version information on both servers:

   ```sql
   SELECT @@VERSION
   ```

- Is the amount of physical memory similar on both servers?

  If one server has 64 GB of memory while the other has 256 GB of memory, that would be a significant difference. With more memory available o cache data/index pages and query plans, the query could be optimized differently based on hardware resource availability.

- Are CPU-related hardware configurations similar on both servers? For example:

  - Number of CPUs varies between machines (24 CPUs on one machine versus 96 CPUs on the other)
  - Power Plans - balanced versus high performance
  - Virtual Machine (VM) versus physical (bare metal) machine
  - Hyper-V versus VMware - difference in configuration
  - Clock speed difference (lower clock speed versus higher clock speed). For example: 2 GHz versus 3.5 GHz can make a difference. To get the clock speed on a server, run the following PowerShell command:

     ```powershell
     Get-CimInstance Win32_Processor | Select-Object -Expand MaxClockSpeed
     ```

  Use one of the following two ways to test the CPU speed of the servers. If they don't produce comparable results, the issue is outside of SQL Server. It could be power plan difference, fewer CPUs, VM-software issue or clock speed difference.

  - Run the following PowerShell script on both servers and compare the outputs.

     ```powershell
     $bf = [System.DateTime]::Now
     for ($i = 0; $i -le 20000000; $i++) {}
     $af = [System.DateTime]::Now
     Write-Host ($af - $bf).Milliseconds " milliseconds"
     Write-Host ($af - $bf).Seconds " Seconds"
     ```
  
  - Run the following Transact-SQL code on both servers and compare the outputs.

     ```sql
     SET NOCOUNT ON 
     DECLARE @spins INT = 0
     DECLARE @start_time DATETIME = GETDATE(), @time_millisecond INT
     
     WHILE (@spins < 20000000)
     BEGIN
       SET @spins = @spins +1
     END
     
     SELECT @time_millisecond = DATEDIFF(millisecond, @start_time, getdate())
     
     SELECT @spins Spins, @time_millisecond Time_ms,  @spins / @time_millisecond Spins_Per_ms
     ```

## Diagnose waits/bottlenecks

To optimize a query that is waiting on bottlenecks, identify how long the wait is and where the bottleneck is. Once the [wait type](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes) is confirmed, reduce the wait time or eliminate the wait completely.

To get the wait time roughly, subtract the CPU time (worker time) from the elapsed time of a query. Typically, the CPU time is the actual execution time, and the remaining part of the lifetime of the query is waiting.

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

- If you can collect a query plan, check the **WaitStats** from the execution plan properties. Check the last item in [Collect Elapsed time and CPU time](#collect-elapsed-time-and-cpu-time) section for detailed steps.

- If you're familiar with [PSSDiag/SQLdiag](https://github.com/microsoft/diagmanager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) LightPerf/GeneralPerf scenarios, consider using either of them to collect performance statistics and identify waiting queries on your SQL Server instance. Check the second method introduced in [Step 1](#step-1-determine-whether-its-a-common-issue-with-multiple-queries) section.

### Resources to eliminate or reduce the wait

The causes and resolutions vary according to the wait types. There's no general method to resolve all wait types. Here are articles to troubleshoot and resolve common wait type issues:

- [Understanding and resolving blocking issues](understand-resolve-blocking.md)
- [Troubleshoot slow SQL Server performance caused by I/O issues](troubleshoot-sql-io-performance.md)
- [WRITELOG waits and common causes](troubleshoot-sql-io-performance.md#writelog)
- [Resolve last-page insert PAGELATCH_EX contention in SQL Server](resolve-pagelatch-ex-contention.md)
- [Memory grants explanation and solutions](https://techcommunity.microsoft.com/t5/sql-server-support-blog/memory-grants-the-mysterious-sql-server-memory-consumer-with/ba-p/333994)
- [Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type](troubleshoot-query-async-network-io.md)

## Diagnose query plan differences

Here're some common causes for differences in query plans:

- Data size or data values differences

  Is same database being used on both servers - using the same database backup? Has the data been modified on one server compared to the other? Data difference can lead to different query plans. For example, joining table T1 (1000 rows) with table T2 (2,000,000 rows) is different from joining table T1 (100 rows) with table T2 (2,000,000 rows) - the type and speed of join operation can be significantly different.

- Statistics differences

  Have [statistics](/sql/t-sql/statements/update-statistics-transact-sql) been updated on one database and not on the other? Have statistics been updated with a different sample rate (for example 30% versus 100% - full scan)? Ensure that you update statistics on both sides with the same sample rate.

- Database compatibility level differences

  Check if the compatibility levels of the databases are different between the two servers. To get the database compatibility level, run the following query:

   ```sql
   SELECT name, compatibility_level
   FROM sys.databases
   WHERE name = '<Your Database>'
   ```

- Server version/build differences
  
  Are the versions or builds of SQL Server different between the two servers? For example, is one server SQL Server version 2014 and the other SQL Server version 2016? There could be product changes that can lead to changes of how a query plan is selected. Make sure you compare the same version and build of SQL Server.

   ```sql
   SELECT ServerProperty('ProductVersion')
   ```

- Cardinality Estimator (CE) version differences

  Check if the legacy cardinality estimator is activated at the database level. For more information about CE, see [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server).

   ```sql
   SELECT name, value, is_value_default
   FROM sys.database_scoped_configurations
   WHERE name = 'LEGACY_CARDINALITY_ESTIMATION'
   ```

- Optimizer hotfixes enabled/disabled

  If the query optimizer hotfixes are enabled on one server but disabled on the other, then different query plans can be generated. For more information, see [SQL Server query optimizer hotfix trace flag 4199 servicing model](https://support.microsoft.com/topic/kb974006-sql-server-query-optimizer-hotfix-trace-flag-4199-servicing-model-cd3ebf5c-465c-6dd8-7178-d41fdddccc28).

  To get the state of query optimizer hotfixes, run the following query:

   ```sql
   -- Check at server level for TF 4199
   DBCC TRACESTATUS (-1)
   -- Check at database level
   USE <YourDatabase>
   SELECT name, value, is_value_default 
   FROM sys.database_scoped_configurations
   WHERE name = 'QUERY_OPTIMIZER_HOTFIXES'
   ```

- Trace flags differences

  Some trace flags affect query plan selection. Check if there are trace flags enabled on one server that aren't enabled on the other. Run the following query on both servers and compare the results:

   ```SQL
   -- Check at server level for trace flags
   DBCC TRACESTATUS (-1)
   ```

- Hardware differences (CPU count, Memory size)

  To get the hardware information, run the following query:

   ```sql
   SELECT cpu_count, physical_memory_kb/1024/1024 PhysicalMemory_GB 
   FROM sys.dm_os_sys_info
   ```

- Hardware differences according to the query optimizer

  Check the `OptimizerHardwareDependentProperties` of a query plan and see if hardware differences are considered significantly for different plans.

   ```sql
   WITH xmlnamespaces(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
   SELECT
    txt.text,
    t.OptHardw.value('@EstimatedAvailableMemoryGrant', 'INT') AS EstimatedAvailableMemoryGrant , 
    t.OptHardw.value('@EstimatedPagesCached', 'INT') AS EstimatedPagesCached, 
    t.OptHardw.value('@EstimatedAvailableDegreeOfParallelism', 'INT') AS EstimatedAvailDegreeOfParallelism,
    t.OptHardw.value('@MaxCompileMemory', 'INT') AS MaxCompileMemory
   FROM sys.dm_exec_cached_plans AS cp
   CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
   CROSS APPLY qp.query_plan.nodes('//OptimizerHardwareDependentProperties') AS t(OptHardw)
   CROSS APPLY sys.dm_exec_sql_text (CP.plan_handle) txt
   WHERE text Like '%<Part of Your Query>%'
   ```

- Optimizer timeout

  Is there an [optimizer timeout](https://techcommunity.microsoft.com/t5/sql-server-support-blog/understanding-optimizer-timeout-and-how-complex-queries-can-be/ba-p/319188). The query optimizer can stop evaluating plan options if the query being executed is too complex. When it stops, it picks the plan with the lowest cost that's available at the time. This can lead to an arbitrary plan choice on one server versus another server.
  
- SET options

  Some SET options are plan-affecting, such as [SET ARITHABORT](/sql/t-sql/statements/set-arithabort-transact-sql#remarks). For more information, see [SET Options](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-plan-attributes-transact-sql#set-options).

- Query Hint differences

  Does one query use [query hints](/sql/t-sql/queries/hints-transact-sql-query) and the other not? Check the query text manually to establish the presence of query hints.
  
- Parameter-sensitive plans (parameter sniffing issue)

  Are you testing the query the exact same parameter values? If not, then you may start there. Was the plan compiled earlier on one server based on a different parameter value? Test the two queries by using the RECOMPILE query hint to ensure there's no plan reuse taking place. For more information, see [Investigate and resolve parameter-sensitive issues](troubleshoot-high-cpu-usage-issues.md#step-5-investigate-and-resolve-parameter-sensitive-issues).

- Different database options/scoped configuration settings

  Are the same database options/scoped configuration settings used on both servers? Some database options may influence plan choices. For example, database compatibility, legacy CE versus default CE, parameter sniffing. Run the following query from one server to compare the database options used on the two servers:

   ```sql
   -- On Server1 add a linked server to Server2 
   EXEC master.dbo.sp_addlinkedserver @server = N'Server2', @srvproduct=N'SQL Server'
   
   -- Run a join between the two servers to compare settings side by side
   SELECT 
     s1.name AS srv1_config_name, 
     s2.name AS srv2_config_name,
     s1.value_in_use AS srv1_value_in_use, 
     s2.value_in_use AS srv2_value_in_use, 
     Variance = CASE WHEN ISNULL(s1.value_in_use, '##') != ISNULL(s2.value_in_use,'##') THEN 'Different' ELSE '' END
   FROM sys.configurations s1 
   FULL OUTER JOIN [server2].master.sys.configurations s2 ON s1.name = s2.name
   
   
   SELECT 
     s1.name AS srv1_config_name,
     s2.name AS srv2_config_name,
     s1.value srv1_value_in_use,
     s2.value srv2_value_in_use,
     s1.is_value_default,
     s2.is_value_default,
     Variance = CASE WHEN ISNULL(s1.value, '##') != ISNULL(s2.value, '##') THEN 'Different' ELSE '' END
   FROM sys.database_scoped_configurations s1
   FULL OUTER JOIN [server2].master.sys.database_scoped_configurations s2 ON s1.name = s2.name
   ```

- Plan guides

  Are any plan guides used for your queries on one server but not on the other? Run the following query to establish differences:

   ```sql
   SELECT * FROM sys.plan_guides
   ```
