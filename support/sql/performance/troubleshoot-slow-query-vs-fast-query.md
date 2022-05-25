---
title: Troubleshoot a query that is slow on one server, but fast on another server
description: This article provides a methodology to help you resolve a slow query as compared to the same query on another server
ms.date: 03/02/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.reviewer: shaunbe
author: pijocoder
ms.author: jopilov
---
# Troubleshoot a query that is slow on one server, but fast on another server

_Applies to:_ &nbsp; SQL Server

This article provides a methodology to diagnose and fix slow performing query (s) on one server as compared to a faster performing query on another server.


You can use the following steps to troubleshoot high-CPU-usage issues in SQL Server.

## Step 1: Determine if a single or multiple queries are slow when comparing servers

### What to do?

- If a single query is performing differently, while other queries are performing the same, the issue is more likely specific to the individual query, rather than environment. Proceed to Step 2.

- If multiple queries are slower on one server compared to another, the most likely cause is differences in server or data environment. 



### How to do it?

- Manually test two or more queries to see if there's a difference in performance between the two SQL Servers. Compare them based on elapsed time (duration). Consider the following criteria in selecting a query to troubleshoot. The query is:
    - Significantly faster on one server vs. the other
    - Important to the user/application
	- Frequently executed or you're able to reproduce the issue on demand
    - Sufficiently long to be able to capture data on it (for example, instead of 5-milliseconds query, choose a 10-seconds query)

- If you've collected PSSDIAG/SQL LogScout data on the two servers, you can import via SQL Nexus and compare queries from two servers using [Performance Comparison between two log collections (Slow and Fast for example)](https://github.com/microsoft/SqlNexus/wiki/Reports-via-SQL-Queries#performance-comparison-between-two-log-collections-slow-and-fast-for-example)


## Step2. Determine if the selected query is slower because of CPU usage or waiting on a bottleneck?

### What to do?

Compare (or subtract) the Elapsed time (Duration) and CPU time of a query to determine whether a query is CPU-bound or waiting on a bottleneck. You must do this for the query on both servers you're comparing. 


- **CPU-Bound (Runner)**
To determine if a query is CPU-bound, compare Duration and CPU times (Elapsed time vs. CPU time) and see if those  values are close to each other (or Duration minus CPU is approximately 0 ms). This means most the query duration was spent executing on the CPU. If CPU time is close, equal to, or higher than Elapsed time, then you can treat this as a CPU-bound query. An example of a CPU-bound query is Elapsed time = 3000 milliseconds and CPU time = 2900 milliseconds, where most the Elapsed time is spent on the CPU. 

  Note: If the CPU time is greater than the Duration, then a parallel query was being executed where multiple threads are using the CPU at the same time the clock is ticking. (see Parallel queries section for more information).


- **Waiting on a bottleneck (Waiter)**
  A query is waiting on a bottleneck if the Duration (Elapsed time) is significantly greater than the CPU time. Elapsed time includes the time executing the query on the CPU (CPU time) and the time waiting for a resource to be released (wait time). For example, if 2000 milliseconds is elapsed time and 300 milliseconds is CPU time, then 1700 milliseconds of the overall duration is waiting time (2000 - 300 = 1700).  For types of bottlenecks or waits, see [wait stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql).

- **Parallel queries - Runner or a Waiter**
Parallel queries may use more CPU time than the overall duration. In fact, that is the goal of parallelism - to allow multiple threads to run parts of a query simultaneously. This means in 1 second of clock time, a query may use 8 seconds of CPU by executing 8 parallel threads. Therefore, it becomes challenging to determine a CPU-bound or a waiting query based the difference of Elapsed and CPU times. However, as a general rule, follow the principle listed earlier: a duration much longer than CPU time means a bottleneck wait issue. If the CPU time is much greater than the elapsed time, consider this a Runner as it is mostly CPU-bound. 

### How to do it?

You can get Elapsed time and CPU time metrics of a query from multiple sources. Pick the one that best fits your situation:


 - For currently executing statement See **Total_elapsed_time** and **Cpu_time** columns in [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) 

   ```sql
   SELECT 
      req.session_id
      , req.total_elapsed_time AS duration_ms
      , req.cpu_time AS cpu_time_ms
      , req.total_elapsed_time  - req.cpu_time AS wait_time
	  , SUBSTRING (REPLACE (REPLACE (SUBSTRING (ST.text, (req.statement_start_offset/2) + 1, 
   	  ((CASE statement_end_offset
             WHEN -1
             THEN DATALENGTH(ST.text)  
             ELSE req.statement_end_offset
           END - req.statement_start_offset)/2) + 1) , CHAR(10), ' '), CHAR(13), ' '), 
        1, 512)  AS statement_text  
   FROM sys.dm_exec_requests AS req  
      CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) as ST
   ORDER BY cpu_time desc;
   ```

- For past executions of the query, look at **last_elapsed_time** and **last_worker_time** in [sys.dm_exec_query_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql) 

   ```sql
   SELECT t.text,
       (qs.total_elapsed_time/1000) / qs.execution_count   AS   avg_elapsed_time,
       (qs.total_worker_time/1000) / qs.execution_count    AS   avg_cpu_time,
       ((qs.total_elapsed_time/1000) / qs.execution_count ) - ((qs.total_worker_time/1000) / qs.execution_count) AS avg_wait_time,
	   qs.total_logical_reads / qs.execution_count  AS   avg_logical_reads,
       qs.total_logical_writes / qs.execution_count AS   avg_writes,
       (qs.total_elapsed_time/1000)  AS   cumulative_elapsed_time_all_executions
   FROM   sys.dm_exec_query_stats qs
       CROSS apply sys.Dm_exec_sql_text (sql_handle) t
   --WHERE t.text like '<your query or beginning parts of it>%'
   ORDER  BY (qs.total_elapsed_time / qs.execution_count) DESC
   ```

  Note: If avg_wait_time shows a negative value that means it's a parallel query. 
 
- If you're able to execute the query on demand in SSMS or Azure Data Studio, you can run it with [SET STATISTICS TIME ON](/sql/t-sql/statements/set-statistics-time-transact-sql)
   ```sql
   SET STATISTICS TIME ON
   <query here>
   SET STATISTICS TIME OFF
   ```
  In the text output, look for numbers similar to this:

  ```output
   SQL Server Execution Times:
     CPU time = 460 ms,  elapsed time = 470 ms.
  ```
- If you can collect a query plan, examine the [Actual Execution plan properties](/sql/ssms/scripting/use-the-properties-window-in-management-studio#to-view-the-properties-of-a-showplan-operator) and locate the QueryTimeStats: **ElapsedTime** and **CpuTime** on the left-most operator in the query plan


 :::image type="content" source="media/troubleshoot-slow-query-comparison/query-time-stats-from-query-plan.png" alt-text="Query-Time-stats-from-query-plan":::

## Step 3. Compare times from both servers and choose a t-shooting path

### What to do and how to do it?

Once you complete step 2 and have collected the CPU and Elapsed times from both servers, you compare the two queries to establish if: 

- **Scenario 1:** Query is slower on Server1 because it's using more CPU than the same query on Server2 

  For example, the query used 1000 millisecond of CPU on one server compared to 3000 milliseconds on the other server.  The elapsed times match the CPU times closely therefore no major waits/bottlenecks. The increase in CPU in the slower query is most likely caused by an increase in logical reads. A significant change in logical reads indicates a difference in query plans. 

  |Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
  |--------|-----------------|-------------|---------------|
  |Server1 |   1100          | 1000        |  90200        |
  |Server2 |   3100          | 3000        | 300000        |

  If this is your scenario go to [here](#scenario-1%3A-query-is-slower-on-server-1-because-it-is-using-more-cpu-than-the-same-query-on-server-2)

- **Scenario 2:** Query is slower on Server1 because it's waiting on bottlenecks (Waiter), while the same query on Server2 isn't waiting

  For example, the CPU times for the query on both servers are similar (1000 vs. 1000), but one of the queries spent a much longer time waiting (4500 - 1000 = 3500 ms vs. 1100 - 1000 = 100 ms):

  |Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
  |--------|-----------------|-------------|---------------|
  |Server1 |   4500          |  1000       |  90200        |
  |Server2 |   1100          |  1000       |  90200        |
  
  
  If this is your scenario go to [here](#scenario-2%3A-query-is-slower-on-server-1-because-it-is-waiting-on-some-bottlenecks-(waiter)%2C-while-the-same-query-on-server-2-is-not-waiting-(cpu-and-duration-are-close-in-value))

- **Scenario 3:** Query is slower on Server1 because it is waiting for some bottlenecks (Waiter), while the same query on Server2 is also waiting (Waiter) but either on different bottlenecks and/or shorter waits (Waiter).

  For example, one query waited for about 7000 milliseconds on the first server (8000 - 1000 ms), and on the other server the query waited for about 2000 milliseconds (3000 - 1000). 

  |Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
  |--------|-----------------|-------------|---------------|
  |Server1 |   8000          |  1000       |  90200        |
  |Server2 |   3000          |  1000       |  90200        |

  If this is your scenario go to [here](#scenario-3%3A-query-is-slower-on-server-1-because-it-is-waiting-for-some-bottlenecks%2C-while-the-same-query-on-server-2-is-also-waiting-on-bottlenecks%2C-but-either-different-bottlenecks-and/or-shorter-waits)

- **Scenario 4:** Query is slower on Server1 because it's using more CPU than the same query on Server2 but the additional CPU isn't caused by logical reads.

  For example, the query used 1000 milliseconds of CPU on one server compared to 3200 milliseconds on the other server.  However, the logical reads, typically the highest driver of CPU time, are similar on both servers. The additional CPU comes from some other CPU-bound activity.

  |Server  |Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
  |--------|-----------------|-------------|---------------|
  |Server1 |   3000          | 3000        |  90200        |
  |Server2 |   1000          | 1000        |  90200        |
  
  
  If this is your scenario go to [here](#scenario-4%3A-query-is-slower-on-server-1-because-it-is-using-more-cpu-than-the-same-query-on-server-2-but-the-additional-cpu-is-not-caused-by-logical-reads)

## Step 4. Follow the performance scenario that matches your environment 

### Scenario 1: Query is slower on Server 1 because it's using more CPU than the same query on Server 2 

### What to do? 

You've established that both queries are CPU-bound (Runners) and query CPU times are significantly different. This is a common scenario. Most likely the increase in CPU in the slower query is caused by a query plan change. The next step is to:
 - Compare query plans and if they're different, establish the reason for difference
 - Compare Environments: different environments can lead to query plan differences or to direct difference in CPU usage. Environments include server versions, database or server configuration settings, trace flags, CPU count or clock speed, VM vs. hardware systems, and so on.


### How to do it?

- Compare query plans

  - You can compare execution plans visually. To display execution plans, see [Display an Actual Execution Plan](/sql/relational-databases/performance/display-an-actual-execution-plan)
  - You can save the execution plans and compare them using [SQL Server Management Studio Plan Comparison feature](/sql/relational-databases/performance/compare-execution-plans)

-  Compare environments: see [Diagnose environment differences](#diagnose-environment-differences)




### Scenario 2: Query is slower on Server 1 because it's waiting on some bottlenecks (Waiter), while the same query on Server 2 is not waiting (CPU and Duration are close in value) 

### What to do 
  In this scenario, your goal towards resolution is to identify and eliminate the bottleneck (wait) on the slower server. Examples of waits include blocking (lock waits), latch waits, I/O waits, network waits, memory waits, etc. 

### How to do it?



### Scenario 3: Query is slower on Server 1 because it is waiting for some bottlenecks, while the same query on Server 2 is also waiting on bottlenecks, but either different bottlenecks and/or shorter waits

In this case CPU times are similar, which indicates query plans are likely the same and the query would perform equally, if it weren't for the bottlenecks. The duration differences in this scenario come from waits on different resources. 
 

### What to do?

To illustrate this scenario, the slower query could be waiting on locks on Server 1, while the faster query is waiting on I/O on Server 2. In this case, you address each bottleneck wait individually on each server and speed up executions on both servers. Troubleshooting this issue is labor-intensive because you need to eliminate bottlenecks on both servers for performance to be comparable

### How to do it?

Use the [Diagnose and Resolve waits/bottlenecks](#diagnose-and-resolve-waits/bottlenecks) section to get you started on t-shooting common bottlenecks.


### Scenario 4: Query is slower on Server 1 because it's using more CPU than the same query on Server 2 but the additional CPU isn't caused by logical reads

### What to do?

This is the least common of all scenarios. Some of the causes include:
 - XEvents/SQL server tracing, especially with filtering on text columns (database name, login name, query text, etc.). If tracing is enabled on one server but not on the other, this could be the reason for the difference.
 - UDFs or other T-SQL code that performs CPU-bound operations. Other conditions are required to be different for this item to be the cause - different data size, or different CPU clock speed, or Power plan difference are examples.
 - SQLCLR or XPs may drive CPU that doesn't perform logical reads. Differences in the DLLs may lead to the CPU difference.
 - Internal SQL function difference, if different versions of SQL Server


### How to do it?

 - Look for any tracing and disable temporarily to see if the issue goes away. If so, remove text filters. 
 - Examine the query text and look for use of UDFs that do string manipulations or do extensive processing on data columns in the SELECT list. Look for loops, function recursion or nesting. 



The sections below are referenced in the methodology above and can be used based on the applicable scenario 

## Diagnose environment differences

First establish if the comparison between the two servers/databases is valid.

1. Are the two SQL Servers the same version (build)? If not, there could be some fixes that caused the differences. Run the following to get version information on both servers:
   ```sql
   SELECT @@VERSION
   ```
1. Is the amount of physical memory similar? If one server 64 GB of memory, while the other 256 GB of memory that is a significant difference. More memory is available to cache data/index pages, to cache query plans and the query could be optimized differently based on hardware resource availability.


1. Are CPU-related hardware configurations similar?
 a. Number of CPUs vary between machines (24 CPUs on one machine vs. 96 CPUs on the other)
 b. Power Plans - balanced vs. high performance
 c. Virtual Machine (VM) vs. physical (bare metal) machine
 d. Hyper-V vs. VMware - difference in configuration
 e. Fewer CPUs on one machine vs. more on the other
 f. Clock speed differences (lower clock speed vs. higher clock speed). For example: 2 GHz vs. 3.5 GHz can make a difference. To get the clock speed, run this PowerShell command on both servers:

   ```PowerShell
   Get-CimInstance Win32_Processor | Select-Object -Expand MaxClockSpeed
   ```
	
	Here are two ways you can test the machines CPU speed and see if they produce comparable results.  If they don't, then the issue is outside SQL Server (power plan difference, fewer CPUs, VM-software issue, clock speed, etc.)
	
	Run the following script on both machines and compare times. Did it take the same time to perform the same number of loops on each machine?
	
    ```PowerShell
    $bf = [System.DateTime]::Now
  		 
    For ($i = 0; $i -le 20000000; $i++)
    {}
    $af = [System.DateTime]::Now 
    Write-Host ($af - $bf).Milliseconds  " milliseconds"
    Write-Host ($af - $bf).Seconds  " Seconds" 
    ```
   
    Or you can run the same example in T-SQL if preferred.

    ```sql
	  
    set nocount on 
    declare @spins int = 0
    declare @start_time datetime = getdate(), @time_millisecond int
    
    while (@spins < 20000000)
    begin 
      set @spins = @spins +1
    end
    
    select @time_millisecond = DATEDIFF(millisecond, @start_time, getdate())
    
    select @spins Spins, @time_millisecond Time_ms,  @spins / @time_millisecond Spins_Per_ms
    ```


### Diagnose and resolve Waits/bottlenecks

To identify queries that are waiting on bottlenecks, you need to discover how long the waits are and what the bottleneck is. See [wait types](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql). Once you identify the wait type, your goal is to reduce it or eliminate it completely.

The wait time is roughly calculated by subtracting the CPU time (worker time) from the elapsed time of a query. The CPU time is actual execution time, the remaining part of the lifetime of the query is waiting.

#### Identify the bottleneck or wait

- Here's a query to help identify historical long-waiting queries (>20% of overall elapsed time) since the start of SQL Server:

   ```sql
   SELECT t.text, 
           qs.total_elapsed_time / qs.execution_count 
           avg_elapsed_time, 
           qs.total_worker_time / qs.execution_count 
           avg_cpu_time, 
           ( qs.total_elapsed_time - qs.total_worker_time ) / qs.   execution_count AS 
           avg_wait_time, 
           qs.total_logical_reads / qs.execution_count 
           avg_logical_reads, 
           qs.total_logical_writes / qs.execution_count 
           avg_writes, 
           qs.total_elapsed_time 
           cumulative_elapsed_time 
   FROM   sys.dm_exec_query_stats qs 
           CROSS apply sys.Dm_exec_sql_text (sql_handle) t 
   WHERE  ( qs.total_elapsed_time - qs.total_worker_time ) / qs.   total_elapsed_time 
           > 0.2 
   ORDER  BY qs.total_elapsed_time / qs.execution_count DESC
   ```

- Here's a query to help identify currently executing queries with waits longer than 500 milliseconds:

   ```sql
   SELECT r.session_id, r.wait_type, r.wait_time as wait_time_ms
   FROM sys.dm_exec_requests r 
     JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id 
   WHERE wait_time > 500
   AND is_user_process = 1
   ```
- If you can collect a query plan, examine the [Actual Execution plan properties](/sql/ssms/scripting/use-the-properties-window-in-management-studio#to-view-the-properties-of-a-showplan-operator) and locate the WaitStats on left-most operator in the query plan (typically SELECT).

- Also if you're familiar with  [PSSDIAG](https://github.com/microsoft/diagmanager#readme) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout/#readme) LightPerf or GeneralPerf scenarios, consider using either of them to collect performance statistics and identify waiting queries on your SQL Server instance. 

#### Eliminate or reduce the wait

The cause and steps to eliminate them vary with each wait type. Therefore, there's no general method to resolve all wait types. 
Here are resources to address common wait types: 

- [Understanding and Resolving Blocking issues](/troubleshoot/sql/performance/understand-resolve-blocking)
- [Troubleshoot slow SQL Server performance caused by I/O issues](/troubleshoot/sql/performance/troubleshoot-sql-io-performance)
- [WRITELOG waits and common causes](troubleshoot/sql/performance//troubleshoot-sql-io-performance#writelog)
- [Resolve last-page insert PAGELATCH_EX contention in SQL Server](/troubleshoot/sql/performance/resolve-pagelatch-ex-contention)
- [Memory grants explanation and solutions](https://techcommunity.microsoft.com/t5/sql-server-support-blog/memory-grants-the-mysterious-sql-server-memory-consumer-with/ba-p/333994)
- [Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type](/troubleshoot/sql/performance/troubleshoot-query-async-network-io)

### Diagnose query plan differences

If you establish that query plans are different, then you can investigate why query plans are different. The following are common causes for differences in query plans:

  - **Data size or data values differences** 
    
	Is same database being used on both servers - using the same database backup? Has the data been modified on one server compared to the other? Data difference can lead to different query plans. For example, joining T1 (1000 rows) with T2 (2,000,000 rows) is different from joining T1 (100 rows) with T2 (2,000,000 rows) - the type and speed of join can be significantly different.
 
  - **Statistics** 
  
    Have statistics been updated on one database and not on the other? Have statistics been updated with a different sample rate (for example 30% vs 100%- full scan)? Ensure that you update statistics on both sides with the same sample rate.

  - **Database compatibility level differences** 
  
    Is the compatibility level of the databases different between the two servers. Use this query to find the DB Compatibility level. 
	
	```sql
    SELECT name, compatibility_level  
    FROM sys.databases 
    WHERE name = '<yourDatabase>'  
    ```
  - **Server version/build differences** 
    
	Is the version (builds) of SQL Server different between the two servers? For example is one server SQL Server version 2014 and the other SQL Server version 2016? There could be product changes that can lead to change in how a query plan is selected. Make sure you compare the same builds of SQL Server. 

    ```sql
    SELECT ServerProperty('ProductVersion')
    ```
	
  - Cardinality Estimator (CE) version differences
    ```sql
    SELECT name, value, is_value_default 
    FROM sys.database_scoped_configurations
    WHERE name = 'LEGACY_CARDINALITY_ESTIMATION'
    ```
  - Optimizer hotfixes on/offs

    See [SQL Server query optimizer hotfix trace flag 4199 servicing model](https://support.microsoft.com/en-us/topic/kb974006-sql-server-query-optimizer-hotfix-trace-flag-4199-servicing-model-cd3ebf5c-465c-6dd8-7178-d41fdddccc28)

    ```sql
    --check at server level for TF 4199
    DBCC TRACESTATUS (-1)

    --check at database level
    use <yourDatabase>

    SELECT name, value, is_value_default 
    FROM sys.database_scoped_configurations
    WHERE name = 'QUERY_OPTIMIZER_HOTFIXES'
    ```


  - Trace flags differences
  Some trace flags affect query plan selection. Check if there are trace flags enabled on one server that aren't enabled on the other. Run this query on both servers and compare results

    ```SQL
    --check at server level for TFs
    DBCC TRACESTATUS (-1)
    ```

  - Hardware differences (CPU count, Memory size)
    ```sql
    SELECT cpu_count, physical_memory_kb/1024/1024 PhysicalMemory_GB 
    FROM sys.dm_os_sys_info
    ```

   - Hardware differences according to Query optimizer. You can examine a query plan's OptimizerHardwareDependentProperties in XML element and see if SQL Server considers hardware differences significant for a plan change. 

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
    CROSS APPLY qp.query_plan.nodes('//OptimizerHardwareDependentProperties') as t(OptHardw)
    CROSS APPLY sys.dm_exec_sql_text (CP.plan_handle) txt
    WHERE text like '%part or all of your query here%'
    ```

  - Is there an [Optimizer timeout](https://techcommunity.microsoft.com/t5/sql-server-support-blog/understanding-optimizer-timeout-and-how-complex-queries-can-be/ba-p/319188). Query optimizer can stop evaluating plan options if the query being executed is very complex. When it stops, it picks the plan with the lowest cost that's available at the time.  This can lead to an arbitrary plan choice on one server vs. another server.
  
  - SET options. Some SET options are plan-affecting. For example, see [SET ARITHABORT](/sql/t-sql/statements/set-arithabort-transact-sql#remarks). For more information on SET options that affect query plan, see [sys.dm_exec_plan_attributes](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-plan-attributes-transact-sql#set-options)

  - Query Hint differences. Does one query use [query hints](sql/t-sql/queries/hints-transact-sql-query) and the other not? You have to examine query text manually to establish the presence of query hints.
  
  - Parameter Sensitive plans (parameter sniffing issue). Are you testing the query the exact same parameter values? If not, then you may start there. Also, could it be that a plan was compiled earlier that was based on a different parameter value than the plan on the other server? You may test the two queries using the RECOMPILE query hint to ensure there is no plan reuse taking place. See [Investigate and resolve parameter-sensitive issues](/troubleshoot/sql/performance/troubleshoot-high-cpu-usage-issues#step-5-investigate-and-resolve-parameter-sensitive-issues)  

  - Are the same database options /scoped configuration settings used on both servers? For example there are database options that influence plan choices, database compatibility, Legacy CE vs. Default CE, Parameter sniffing, and so on. You can use the following method to compare the database options on both servers.

    ```sql
    --on server1 add a linked server to server2 
    
    EXEC master.dbo.sp_addlinkedserver @server = N'server2', @srvproduct=N'SQL Server'
    
    -- run a join between the two servers to compare settings side by side
    SELECT 
      s1.name AS srv1_config_name, 
      s2.name AS srv2_config_name,
      s1.value_in_use AS srv1_value_in_use, 
      s2.value_in_use AS srv2_value_in_use, 
      Variance = CASE WHEN ISNULL(s1.value_in_use, '##') != ISNULL(s2.value_in_use,'##') THEN 'Different' ELSE '' END
    FROM 
      sys.configurations s1 
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

 - Are any plan guides used for your queries on one of the servers and not on the other? Run the following to establish differences. 

   ```sql
   select * from sys.plan_guides
   ```
