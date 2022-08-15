---
title: Troubleshoot a out of memory or low memory issues in SQL Server
description: Provides troubleshooting steps addressing low memory conditions in SQL Server.
ms.date: 08/15/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.reviewer: shaunbe
author: pijocoder
ms.author: jopilov
---

# Troubleshoot a out of memory or low memory issues in SQL Server


## Out of memory Symptoms 

SQL Server uses a complex [memory architecture](/sql/relational-databases/memory-management-architecture-guide) that corresponds to the complex and the rich feature set. Because of the many memory uses, there could be many sources of memory consumption, memory pressure and ultimately causing out of memory conditions. 

There are common errors that indicate low memory in SQL Server. Examples of errors include: 

- 701 - failure to allocate sufficient memory to run a query
- 802 - failure to get memory to allocate pages in the buffer pool (data or index pages), 
- 1204 - failure to allocate memory for locks
- 6322 - failure allocate memory for XML parser
- 6513 - failure to initialize CLR due to memory pressure 
- 6533 - AppDomain unloaded due to out of memory
- 8356 or 8359 - ETW or SQL trace fail to run due to low memory 
- 8556 - failure to load MSDTC due to insufficient memory
- 8645 - failure to execute a query due to no memory for memory grants (sorting and hashing) (see [How to troubleshoot SQL Server error 8645](https://support.microsoft.com/en-us/topic/how-to-troubleshoot-sql-server-error-8645-a1bbec30-e71e-08f7-bc35-0e3bc34bed76) )
- 8902 - failure to allocate memory during DBCC execution
- 8318 - failure to load SQL performance counters due to insufficient memory
- 9695 or 9695 - failure to allocate memory for Service Broker operations
- 17131 or 17132 - Server startup failure due to insufficient memory
- 22986 or 22987 - Change data capture failures due to insufficient memory
- 25601 - Xevent engine is out of memory
- 26053 - SQL network interfaces fail to initialize due to insufficient memory
- 30085, 30086, 30094  - SQL full-text operations fail due to insufficient memory

Insufficient memory can be caused by a number of factors that include operating system settings, physical memory availability, other components use memory inside SQL Server, or memory limits on the current workload. In most cases, the transaction that failed isn't the cause of this error. Overall, the causes can be grouped into three:

### External or OS memory pressure
  External pressure refers to high memory utilization coming from a component outside of the process that leads to insufficient memory for SQL Server. You have to find if other applications on the system are consuming memory and contribute to low memory availability. SQL Server is one of the few applications designed to respond to OS memory pressure by cutting back its memory use. This means, if some application or driver asks for memory, the OS sends a signal to all applications to free up memory and SQL Server will respond by reducing its own memory usage. Very few other applications respond because they aren't designed to listen for that notification. Therefore, if SQL Server starts cutting back its memory usage, its memory pool is reduced and whichever components need memory may not get it. You start getting 701 or other memory-related errors. For more information, see [SQL Server Memory Architecture](../memory-management-architecture-guide.md#sql-server-memory-architecture)

### Internal memory pressure, not coming from SQL Server

Internal memory pressure refers to low memory availability caused by factors inside the SQL Server process. There are components that may run inside the SQL Server process that are "external" to the SQL Server engine. Examples include DLLs like linked servers, SQLCLR components, extended procedures (XPs), and OLE Automation (`sp_OA*`). Others include anti-virus or other security programs that inject DLLs inside a process for monitoring purposes. An issue or poor design in any of these components could lead to large memory consumption. For example, consider a linked server caching 20 million rows of data that come from an external source into SQL Server memory. As far as SQL Server is concerned, no memory clerk will report high memory usage, but memory consumed inside the SQL Server process will be high. This memory growth from a linked server DLL, for example, would cause SQL Server to start cutting its memory usage (see above) and will create low-memory conditions of for components inside SQL Server, causing out of memory errors.


### Internal memory pressure, coming from SQL Server component(s)
  
Internal memory pressure coming from components inside SQL Server Engine can also lead to out of memory errors. There are hundreds of components, tracked via [memory clerks](../system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql.md), that allocate memory in SQL Server. You must identify which memory clerk(s) are responsible for the largest memory allocations to be able to resolve this further. For example, if you find that the OBJECTSTORE_LOCK_MANAGER memory clerk is showing the large memory allocation, you need to further understand why the Lock Manager is consuming so much memory. You may find there are queries that acquire a large number of locks and optimize them by using indexes, or shorten transactions that hold locks for long periods, or check if lock escalation is disabled. Each memory clerk or component has a unique way of accessing and using memory. For more information, see [memory clerk types](../system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql.md) and their descriptions.

## User action  

If an out-of-memory error appears occasionally or for a brief period, there may be a short-lived memory issue that resolved itself. You may not need to take action in those cases. However, if the error occurs multiple times, on multiple connections and persists for periods of seconds or longer, follow the steps to troubleshoot further.

The following list outlines general steps that will help in troubleshooting memory errors. 

### Diagnostic tools and capture

The diagnostics tools that will allow you to collect troubleshooting data are **Performance Monitor**, **[sys.dm_os_memory_clerks](../system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql.md)**, and **[DBCC MEMORYSTATUS](/troubleshoot/sql/performance/dbcc-memorystatus-monitor-memory-usage)**. 

Configure and collect the following counters with Performance Monitor: 
  - **Memory:Available MB**
  - **Process:Working Set**
  - **Process:Private Bytes**
  - **SQL Server:Memory Manager: (all counters)**
  - **SQL Server:Buffer Manager: (all counters)**

Collect periodic outputs of this query on the impacted SQL Server

  ```tsql
  SELECT pages_kb, type, name, virtual_memory_committed_kb, awe_allocated_kb
  FROM sys.dm_os_memory_clerks
  ORDER BY pages_kb DESC
  ```

### Pssdiag or SQL LogScout

An alternative, automated way to capture these data points is to use tools like [PSSDIAG](https://github.com/microsoft/DiagManager/releases) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases). 

- If you use Pssdiag, configure to capture **Perfmon** collector and the **Custom Diagnostics\SQL Memory Error** collector
- If you use SQL LogScout, configure to capture the **Memory** scenario

The following sections describe more detailed steps for each scenario - external or internal memory pressure. 

### External pressure: diagnostics and solutions

- To diagnose low memory conditions on the system outside of SQL Server process, collect Performance monitor counters. Investigate if applications or services other than SQL Server are consuming memory on this server by looking at these counters:

  - **Memory:Available MB**
  - **Process:Working Set**
  - **Process:Private Bytes**

  Here is a sample Perfmon log collection using PowerShell

  ```PowerShell
  clear
  $serverName = $env:COMPUTERNAME
  $Counters = @(
     ("\\$serverName" +"\Memory\Available MBytes"),
     ("\\$serverName" +"\Process(*)\Working Set"),
     ("\\$serverName" +"\Process(*)\Private Bytes")
  )
  
  Get-Counter -Counter $Counters -SampleInterval 2 -MaxSamples 1 | ForEach-Object  {
  $_.CounterSamples | ForEach-Object 	  {
     [pscustomobject]@{
        TimeStamp = $_.TimeStamp
        Path = $_.Path
        Value = ([Math]::Round($_.CookedValue, 3)) }
   }
  }
  ```


- Review the System Event log and look for memory related errors (for example, low virtual memory). 
- Review the Application Event log for application-related memory issues.

  Here is a sample PowerShell script to query the System and Applicaiton Event logs for the keyword "memory". Feel free to use other strings like "resource" for your search:
  
  ```PowerShell
  Get-EventLog System -ComputerName "$env:COMPUTERNAME" -Message "*memory*"
  Get-EventLog Application -ComputerName "$env:COMPUTERNAME" -Message "*memory*"
  ```

- Address any code or configuration issues for less critical applications or services to reduce their memory usage.  
- If applications besides [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] are consuming resources, try stopping or rescheduling these applications, or consider running them on a separate server. These steps will remove external memory pressure.

### Internal memory pressure, not coming from SQL Server: diagnostics and solutions

To diagnose internal memory pressure caused by modules (DLLs) inside SQL Server, use the following approach:

- If SQL Server isn't* using [Locked Pages in Memory](../../database-engine/configure-windows/enable-the-lock-pages-in-memory-option-windows.md) (AWE API), then most its memory is reflected in the **Process:Private Bytes** counter (`SQLServr` instance) in Performance Monitor. The overall memory usage coming from within SQL Server engine is reflected in **SQL Server:Memory Manager: Total Server Memory (KB)** counter. If you find a significant difference between the value **Process:Private Bytes** and **SQL Server:Memory Manager: Total Server Memory (KB)**, then that difference is likely coming from a DLL (linked server, XP, SQLCLR, etc.). For example if **Private bytes** is 300 GB and **Total Server Memory** is 250 GB, then approximately 50 GB of the overall memory in the process is coming from outside SQL Server engine.

- If SQL Server is using Locked Pages in Memory (AWE API), then it is more challenging to identify the issue because Performance monitor doesn't offer AWE counters that track memory usage for individual processes. The overall memory usage coming from within SQL Server engine is reflected in **SQL Server:Memory Manager: Total Server Memory (KB)** counter. Typical **Process:Private Bytes** values may vary between 300 MB and 1-2 GB overall. If you find a significant usage of **Process:Private Bytes** beyond this typical use, then the difference is likely coming from a DLL (linked server, XP, SQLCLR, etc.). For example, if **Private bytes** counter is 5-4 GB and SQL Server is using Locked Pages in Memory (AWE), then a large part of the Private bytes may be coming from outside SQL Server engine. This is an approximation technique.

- Use the Tasklist utility to identify any DLLs that are loaded inside SQL Server space:

  ```console
   tasklist /M /FI "IMAGENAME eq sqlservr.exe"
  ```

- You could also use this query to examine loaded modules (DLLs) and see if something isn't expected to be there

  ```sql
  SELECT * FROM sys.dm_os_loaded_modules
  ```

- If you suspect that a Linked Server module is causing significant memory consumption, then you can configure it to run out of process by disabling **Allow inprocess** option. See [Create Linked Servers](../linked-servers/create-linked-servers-sql-server-database-engine.md) for more information. Not all linked server OLEDB providers may run out of process; contact the product manufacturer for more information.

- In the rare case that OLE automation objects are used (`sp_OA*`), you may configure the object to run in a process outside SQL Server by setting *context* = 4 (Local (.exe) OLE server only.). For more information, see [sp_OACreate](../system-stored-procedures/sp-oacreate-transact-sql.md).


### Internal memory usage by SQL Server engine: diagnostics and solutions

- Start collecting performance monitor counters for [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)]:**SQL Server:Buffer Manager**, **SQL Server: Memory Manager**.  

- Query the SQL Server memory clerks DMV multiple times to see where the highest consumption of memory occurs inside the engine:

  ```sql
  SELECT pages_kb, type, name, virtual_memory_committed_kb, awe_allocated_kb
  FROM sys.dm_os_memory_clerks
  ORDER BY pages_kb DESC
  ```

- Alternatively, you can observe the more detailed DBCC MEMORYSTATUS output and the way it changes when you see these error messages.  

  ```sql
  DBCC MEMORYSTATUS
  ```

- If you identify a clear offender among the memory clerks, focus on addressing the specifics of memory consumption for that component. Here are several examples:

  - If MEMORYCLERK_SQLQERESERVATIONS memory clerk is consuming memory, identify queries that are using huge memory grants and optimize them via indexes, rewrite them (remove ORDER by for example), or apply query hints.
  - If a large number of ad-hoc query plans are cached, then the CACHESTORE_SQLCP memory clerk would use large amounts of memory. Identify non-parameterized queries whose query plans can’t be reused and parameterize them by either converting to stored procedures, or by using sp_executesql, or by using FORCED parameterization.
  - If object plan cache store CACHESTORE_OBJCP is consuming much memory, then do the following: identify which stored procedures, functions, or triggers are using lots of memory and possibly redesign the application. Commonly this may happen due to large amounts of database or schemas with hundreds of procedures in each.
  - If the OBJECTSTORE_LOCK_MANAGER memory clerk is showing the large memory allocations, identify queries that apply many locks and optimize them by using indexes. Shorten transactions that cause locks not to be released for long periods in certain isolation levels, or check if lock escalation is disabled.

## Quick relief that may make memory available

The following actions may free some memory and make it available to [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)]:  

- Check the following SQL Server memory configuration parameters and consider increasing **max server memory** if possible:  
  
  - **max server memory**  
  - **min server memory**  
  
    Notice unusual settings. Correct them as necessary. Account for increased memory requirements. Default settings are listed in [Server memory configuration options](../../database-engine/configure-windows/server-memory-server-configuration-options.md).
  
- If you haven't configured **max server memory** especially with Locked Pages in Memory, consider setting to a particular value to allow some memory for the OS. See [Locked Pages in Memory](../../database-engine/configure-windows/server-memory-server-configuration-options.md#lock-pages-in-memory-lpim) server configuration option. 

- Check the query workload: number of concurrent sessions, currently executing queries and see if there are less critical applications that may be stopped temporarily or moved to another SQL Server.

- If you're running SQL Server on a virtual machine (VM), ensure the memory for the VM isn't overcommitted. For ideas on how to configure memory for VMs, see this blog [Virtualization – Overcommitting memory and how to detect it within the VM](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/virtualization-8211-overcommitting-memory-and-how-to-detect-it/ba-p/367623) and  [Troubleshooting ESX/ESXi virtual machine performance issues (memory overcommitment)](https://kb.vmware.com/s/article/2001003#Memory) 

- You can run the following DBCC commands to free several [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)] memory caches.  
  
  - DBCC FREESYSTEMCACHE
  
  - DBCC FREESESSIONCACHE  
  
  - DBCC FREEPROCCACHE  

- If you're using Resource Governor, we recommend that you check the resource pool or workload group settings and see if they aren't limiting memory too drastically. 
- If the problem continues, you'll need to investigate further and possibly increase server resources (RAM).





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

[!INCLUDE [collect query data and logical reads](../includes/performance/collect-cpu-time-elapsed-time-logical-reads.md)]

Compare the elapsed time and CPU time of the query to determine the issue type for both servers.


[!INCLUDE [establish runner or waiter perf type](../includes/performance/establish-runner-waiter-perf-type.md)]


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

[!INCLUDE [diagnose environment differences](../includes/performance/diagnose-environment-differences.md)]

## Diagnose waits or bottlenecks

[!INCLUDE [diagnose waits](../includes/performance/diagnose-waits-or-bottlenecks.md)]

## Diagnose query plan differences

[!INCLUDE [diagnose query plan differences](../includes/performance/diagnose-query-plan-differences.md)]
