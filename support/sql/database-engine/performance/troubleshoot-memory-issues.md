---
title: Troubleshoot out of memory or low memory issues in SQL Server
description: Provides troubleshooting steps to address out of memory or low memory issues in SQL Server.
ms.date: 04/14/2023
ms.custom: sap:Performance
ms.reviewer: shaunbe
author: pijocoder
ms.author: jopilov
---

# Troubleshoot out of memory or low memory issues in SQL Server

## Symptoms

SQL Server uses a complex [memory architecture](/sql/relational-databases/memory-management-architecture-guide) that corresponds to the complex and rich feature set. Because of the variety of memory needs, there could be many sources of memory consumption and memory pressure, ultimately causing out of memory conditions.

There are common errors that indicate low memory in SQL Server. Examples of errors include:

- [701](/sql/relational-databases/errors-events/mssqlserver-701-database-engine-error): Failure to allocate sufficient memory to run a query.
- [802](/sql/relational-databases/errors-events/mssqlserver-802-database-engine-error): Failure to get memory to allocate pages in the buffer pool (data or index pages).
- [1204](/sql/relational-databases/errors-events/mssqlserver-1204-database-engine-error): Failure to allocate memory for locks.
- 6322: Failure to allocate memory for XML parser.
- 6513:Failure to initialize CLR due to memory pressure.
- 6533: AppDomain unloaded due to out of memory.
- 8318: Failure to load SQL performance counters due to insufficient memory.
- 8356 or 8359: ETW or SQL trace fails to run due to low memory.
- 8556: Failure to load MSDTC due to insufficient memory.
- [8645](/sql/relational-databases/errors-events/mssqlserver-8645-database-engine-error): Failure to execute a query due to no memory for memory grants (sorting and hashing) For more information, see [How to troubleshoot SQL Server error 8645](https://support.microsoft.com/topic/how-to-troubleshoot-sql-server-error-8645-a1bbec30-e71e-08f7-bc35-0e3bc34bed76). 
- 8902: Failure to allocate memory during DBCC execution.
- 9695 or 9696: Failure to allocate memory for Service Broker operations.
- 17131 or [17132](/sql/relational-databases/errors-events/mssqlserver-17132-database-engine-error): Server startup failure due to insufficient memory.
- [17890](/sql/relational-databases/errors-events/mssqlserver-17890-database-engine-error): Failure to allocate memory due to SQL memory being paged out by the OS.
- 22986 or 22987: Change data capture failures due to insufficient memory.
- 25601: Xevent engine is out of memory.
- 26053: SQL network interfaces fail to initialize due to insufficient memory.
- 30085, 30086, 30094: SQL full-text operations fail due to insufficient memory.

## Cause

Many factors can cause insufficient memory. Such factors include operating system settings, physical memory availability, components that use memory inside SQL Server, and memory limits on the current workload. In most cases, the query that fails with an out of memory error isn't the cause of this error. Overall, the causes can be grouped into three categories:

### Cause 1: External or OS memory pressure

External pressure refers to high memory utilization coming from a component outside of the process that leads to insufficient memory for SQL Server. You have to find out if other applications on the system are consuming memory and contributing to low memory availability. SQL Server is one of the very few applications designed to respond to OS memory pressure by cutting back its memory use. This means if an application or driver requests memory, the OS sends a signal to all applications to free up memory, and SQL Server will respond by reducing its own memory usage. Few other applications respond because they aren't designed to listen for that notification. Therefore, if SQL Server starts cutting back its memory usage, its memory pool is reduced, and whichever components need memory may not get it. As a result, you start getting 701 or other memory-related errors. For more information on how SQL dynamically allocates and frees memory, see [SQL Server Memory Architecture](/sql/relational-databases/memory-management-architecture-guide#sql-server-memory-architecture). For more detailed diagnostics and solutions for the issue, see [External memory pressure](#external-memory-pressure) in this article.

There are three broad categories of problems that can cause OS memory pressure:

- Application-related issues: One or many applications together exhaust the available physical memory. The OS will respond to new application requests for resources by trying to free some memory. The common approach is to find which applications are exhausting the memory and take necessary steps to balance the memory among them without leading to RAM exhaustion.
- Device driver issues: Device drivers may cause working set paging of all processes if the driver incorrectly calls a memory allocation function.
- Operation system product issues.

For a detailed explanation of these and troubleshooting steps, refer to [MSSQLSERVER_17890](/sql/relational-databases/errors-events/mssqlserver-17890-database-engine-error).

### Cause 2: Internal memory pressure, not coming from SQL Server

Internal memory pressure refers to low memory availability caused by factors inside the SQL Server process. Some components that may run inside the SQL Server process are "external" to the SQL Server engine. Examples include OLE DB providers (DLLs) like linked servers, SQLCLR procedures or functions, extended procedures (XPs), and OLE Automation (`sp_OA*`). Others include anti-virus or other security programs that inject DLLs inside a process for monitoring purposes. An issue or poor design in any of these components could lead to large memory consumption. For example, consider a linked server caching 20 million rows of data from an external source into SQL Server memory. As far as SQL Server is concerned, no memory clerk will report high memory usage, but memory consumed inside the SQL Server process will be high. This memory growth from a linked server DLL, for example, would cause SQL Server to start cutting its memory usage (see above) and will create low memory conditions for components inside SQL Server, causing out of memory errors. For more detailed diagnostics and solutions on the issue, see [Internal memory pressure, not coming from SQL Server](#internal-memory-pressure-not-coming-from-sql-server).

> [!NOTE]
> A few Microsoft DLLs used in the SQL Server process space (for example, [MSOLEDBSQL](/sql/connect/oledb/oledb-driver-for-sql-server), [SQL Native Client](/sql/relational-databases/native-client/sql-server-native-client)) are able to interface with SQL Server memory infrastructure for reporting and allocation. You can run `select * from sys.dm_os_memory_clerks where type='MEMORYCLERK_HOST'` to get a list of them and track that memory consumption for some of their allocations.

### Cause 3: Internal memory pressure coming from SQL Server component(s)
  
Internal memory pressure coming from components inside the SQL Server engine can also lead to out of memory errors. There are hundreds of components tracked via [memory clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) that allocate memory in SQL Server. You must identify which memory clerk(s) are responsible for the largest memory allocations to resolve this issue. For example, if you find that the `OBJECTSTORE_LOCK_MANAGER` memory clerk is showing a large memory allocation, you need to understand why the Lock Manager is consuming so much memory. You may find there are queries that acquire many locks. You can optimize these queries by using indexes, shortening any transactions that hold locks for a long time, or checking if lock escalation is disabled. Each memory clerk or component has a unique way of accessing and using memory. For more information, see [memory clerk types](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) and their descriptions. For more detailed diagnostics and solutions on the issue, see [Internal memory usage by SQL Server engine](#internal-memory-usage-by-sql-server-engine).

## Visual representation of the memory pressure types

The following graph illustrates the types of pressure that can lead to out of memory conditions in SQL Server:

:::image type="content" source="media/troubleshoot-out-of-memory/out-of-memory-issues.svg" alt-text="Screenshot of memory pressure types.":::

## Diagnostic tools to collect troubleshooting data

You can use the following diagnostic tools to collect troubleshooting data:

### Performance Monitor

Configure and collect the following counters with Performance Monitor:

- **Memory:Available MBytes**
- **Process:Working Set**
- **Process:Private Bytes**
- **SQL Server:Memory Manager: (all counters)**
- **SQL Server:Buffer Manager: (all counters)**

### DMVs or DBCC MEMORYSTATUS

You can use [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) or [DBCC MEMORYSTATUS](dbcc-memorystatus-monitor-memory-usage.md) to observe overall memory usage inside SQL Server.


### Memory Consumption Standard Report in SSMS

View memory usage in SQL Server Management Studio:

1. Launch SQL Server Management Studio and connect to a server.
1. In **Object Explorer**, right-click the SQL Server instance name.
1. In the context menu, select **Reports** > **Standard Reports** > **Memory Consumption**.

### PSSDiag or SQL LogScout

An alternative, automated way to capture these data points is to use tools like [PSSDiag](https://github.com/microsoft/DiagManager/releases) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases).

- If you use PSSDiag, configure it to capture the **Perfmon** collector and the **Custom Diagnostics\SQL Memory Error** collector.

- If you use SQL LogScout, configure it to capture the **Memory** scenario.

The following sections describe more detailed steps for each scenario (external or internal memory pressure).

## Troubleshooting methodology

If an out of memory error occasionally appears or for a brief period, there may be a short-lived memory issue that resolves itself. You may not need to take action in those cases. However, if the error occurs multiple times on multiple connections and persists for periods of seconds or longer, follow the diagnostics and solutions in following sections to troubleshoot memory errors further.

### External memory pressure

To diagnose low memory conditions on the system outside of the SQL Server process, use the following methods:

- Collect Performance Monitor counters. Investigate if applications or services other than SQL Server are consuming memory on this server by looking at these counters:

  - **Memory:Available MBytes**
  - **Process:Working Set**
  - **Process:Private Bytes**

  Here's an example of Perfmon log collection using PowerShell:

  ```PowerShell
  clear
  $serverName = $env:COMPUTERNAME
  $Counters = @(
     ("\\$serverName" +"\Memory\Available MBytes"),
     ("\\$serverName" +"\Process(*)\Working Set"),
     ("\\$serverName" +"\Process(*)\Private Bytes")
  )
  
  Get-Counter -Counter $Counters -SampleInterval 2 -MaxSamples 1 | ForEach-Object  {
  $_.CounterSamples | ForEach-Object   {
     [pscustomobject]@{
        TimeStamp = $_.TimeStamp
        Path = $_.Path
        Value = ([Math]::Round($_.CookedValue, 3)) }
   }
  }
  ```

- Review the System Event log and look for memory-related errors (for example, low virtual memory).
- Review the Application Event log for application-related memory issues.

  Here's an example of a PowerShell script to query the System and Application Event logs for the keyword "memory." Feel free to use other strings like "resource" for your search:
  
  ```PowerShell
  Get-EventLog System -ComputerName "$env:COMPUTERNAME" -Message "*memory*"
  Get-EventLog Application -ComputerName "$env:COMPUTERNAME" -Message "*memory*"
  ```

- Address any code or configuration issues for less critical applications or services to reduce their memory usage.  
- If applications besides SQL Server are consuming resources, try stopping or rescheduling these applications, or consider running them on a separate server. These steps will remove external memory pressure.

### Internal memory pressure, not coming from SQL Server

To diagnose internal memory pressure caused by modules (DLLs) inside SQL Server, use the following methods:

- If SQL Server doesn't use [Locked Pages in Memory](/sql/database-engine/configure-windows/enable-the-lock-pages-in-memory-option-windows) (AWE API), most of its memory is reflected in the **Process:Private Bytes** counter (`SQLServr` instance) in Performance Monitor. The overall memory usage coming from within the SQL Server engine is reflected in the **SQL Server:Memory Manager: Total Server Memory (KB)** counter. If you find a significant difference between the value **Process:Private Bytes** and **SQL Server:Memory Manager: Total Server Memory (KB)**, that difference is likely coming from a DLL (linked server, XP, SQLCLR, and so on). For example, if **Private bytes** is 300 GB and **Total Server Memory** is 250 GB, approximately 50 GB of the overall memory in the process is coming from outside the SQL Server engine.

- If SQL Server is using Locked Pages in Memory (AWE API), it's more challenging to identify the issue because the Performance Monitor doesn't offer AWE counters that track memory usage for individual processes. The overall memory usage within the SQL Server engine is reflected in the **SQL Server:Memory Manager: Total Server Memory (KB)** counter. Typical **Process:Private Bytes** values may vary between 300 MB and 1-2 GB overall. If you find a significant usage of **Process:Private Bytes** beyond this typical use, the difference is likely coming from a DLL (linked server, XP, SQLCLR, and so on). For example, if the **Private bytes** counter is 4-5 GB, and SQL Server is using Locked Pages in Memory (AWE), a large part of the Private bytes may be coming from outside the SQL Server engine. This is an approximation technique.

- Use the Tasklist utility to identify any DLLs that are loaded inside SQL Server space:

  ```console
   tasklist /M /FI "IMAGENAME eq sqlservr.exe"
  ```

- You could also use the following query to examine loaded modules (DLLs) and see if anything unexpected is there.

  ```sql
  SELECT * FROM sys.dm_os_loaded_modules
  ```

- If you suspect a Linked Server module is causing significant memory consumption, you can configure it to run out of process by disabling the **Allow inprocess** option. See [Create Linked Servers](/sql/relational-databases/linked-servers/create-linked-servers-sql-server-database-engine) for more information. Not all linked server OLE DB providers may run out of process. For more information, contact the product manufacturer.

- In the rare case where OLE automation objects (`sp_OA*`) are used, you may configure the object to run in a process outside SQL Server by specifying a context value of **4** (Local (.exe) OLE server only). For more information, see [sp_OACreate](/sql/relational-databases/system-stored-procedures/sp-oacreate-transact-sql).

### Internal memory usage by SQL Server engine

To diagnose internal memory pressure coming from components inside the SQL Server engine, use the following methods:

- Start collecting Performance Monitor counters for SQL Server: **SQL Server:Buffer Manager** and **SQL Server: Memory Manager**.  

- Query the SQL Server memory clerks DMV multiple times to see where the highest consumption of memory occurs inside the engine:

  ```sql
  SELECT pages_kb, type, name, virtual_memory_committed_kb, awe_allocated_kb
  FROM sys.dm_os_memory_clerks
  ORDER BY pages_kb DESC
  ```

- Alternatively, you can observe the more detailed `DBCC MEMORYSTATUS` output and the way it changes when you see these error messages.  

  ```sql
  DBCC MEMORYSTATUS
  ```

- If you identify a clear offender among the memory clerks, focus on addressing the specifics of memory consumption for that component. Here are several examples:

  - If the memory clerk `MEMORYCLERK_SQLQERESERVATIONS` is consuming memory, identify queries that are using huge memory grants and optimize them via indexes, rewrite them (remove `ORDER by`, for example), or apply memory grant query hints (see [min_grant_percent and max_grant_percent hints](https://support.microsoft.com/topic/kb3107401-new-query-memory-grant-options-are-available-min-grant-percent-and-max-grant-percent-in-sql-server-2012-74c4c363-5f65-faa2-5cba-68cc1d689cd5) ). You can also [create a resource governor pool](/sql/relational-databases/resource-governor/create-a-resource-pool) to control the usage of memory grant memory. For detailed information on memory grants, see [Troubleshoot slow performance or low memory issues caused by memory grants in SQL Server](troubleshoot-memory-issues.md).
  - If a large number of ad-hoc query plans are cached, the `CACHESTORE_SQLCP` memory clerk would use large amounts of memory. Identify non-parameterized queries whose query plans can't be reused and parameterize them by converting to stored procedures, using `sp_executesql`, or by using `FORCED` parameterization. If you have enabled [trace flag 174](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf174), you may disable it to see if this resolves the problem.
  - If the object plan cache store `CACHESTORE_OBJCP` is consuming too much memory, identify which stored procedures, functions, or triggers are using large amounts of memory and possibly redesign the application. Commonly, this may happen due to large amounts of databases or schemas with hundreds of procedures in each.
  - If the `OBJECTSTORE_LOCK_MANAGER` memory clerk shows large memory allocations, identify queries that apply many locks and optimize them by using indexes. Shorten transactions that cause locks not to be released for long periods in certain isolation levels or check if lock escalation is disabled.
  - If you observe very large `TokenAndPermUserStore` (`select type, name, pages_kb from sys.dm_os_memory_clerks where name = 'TokenAndPermUserStore'`), you can use [trace flag 4618](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf4618) to limit the size of the cache.
  - If you observe memory issues with In-Memory OLTP coming from the `MEMORYCLERK_XTP` memory clerk, you can refer to [Monitor and Troubleshoot Memory Usage for In-Memory OLTP](/sql/relational-databases/in-memory-oltp/monitor-and-troubleshoot-memory-usage) and [Memory-optimized tempdb metadata (HkTempDB) out of memory errors](../performance/memory-optimized-tempdb-out-of-memory.md).

## Quick relief that may make memory available

The following actions may free some memory and make it available to SQL Server:  

### Change memory configuration settings

Check the following SQL Server memory configuration parameters and consider increasing **max server memory** if possible:  
  
- **max server memory**  
- **min server memory**  
  
> [!NOTE]
> If you notice unusual settings, correct them as necessary and account for increased memory requirements. Default settings are listed in [Server memory configuration options](/sql/database-engine/configure-windows/server-memory-server-configuration-options).
  
If you haven't configured **max server memory**, especially with Locked Pages in Memory, consider setting it to a particular value to allow some memory for the OS. See the [Locked Pages in Memory](/sql/database-engine/configure-windows/server-memory-server-configuration-options#lock-pages-in-memory-lpim) server configuration option.

### Change or move workload off the system

Investigate the query workload: number of concurrent sessions, currently executing queries, and see if there are less critical applications that may be stopped temporarily or moved to another SQL Server.

For read-only workloads, consider moving them to a read-only secondary replica in an Always On environment. For more information, see [Offload read-only workload to secondary replica of an Always On availability group](/sql/database-engine/availability-groups/windows/active-secondaries-readable-secondary-replicas-always-on-availability-groups) and [Configure read-only access to a secondary replica of an Always On availability group](/sql/database-engine/availability-groups/windows/configure-read-only-access-on-an-availability-replica-sql-server).

### Ensure proper memory configuration for virtual machines

If you're running SQL Server on a virtual machine (VM), ensure the memory for the VM isn't overcommitted. For ideas on how to configure memory for VMs, see [Virtualization - Overcommitting memory and how to detect it within the VM](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/virtualization-8211-overcommitting-memory-and-how-to-detect-it/ba-p/367623) and [Troubleshooting ESX/ESXi virtual machine performance issues (memory overcommitment)](https://kb.vmware.com/s/article/2001003#Memory).

### Release memory inside SQL Server

You can run one or more of the following DBCC commands to free several SQL Server memory caches:
  
- `DBCC FREESYSTEMCACHE`
  
- `DBCC FREESESSIONCACHE`  
  
- `DBCC FREEPROCCACHE`  

### Restart SQL Server service

In some cases, if you need to deal with critical exhaustion of memory and SQL Server isn't able to process queries, you can consider restarting the service.

### Consider using Resource Governor for specific scenarios

If you're using Resource Governor, we recommend that you check the resource pool and workload group settings to see if they aren't limiting memory too drastically.

### Add more RAM on the physical or virtual server

If the problem continues, you need to investigate further and possibly increase server resources (RAM).
