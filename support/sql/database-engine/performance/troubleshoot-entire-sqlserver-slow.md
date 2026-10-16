---
title: Troubleshoot Slow SQL Server Performance Across All Queries
description: Troubleshoot when all queries on SQL Server or a database application are slow by checking the application, OS, network, CPU, I/O, memory, blocking, and schedulers.
ms.date: 10/16/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Troubleshoot entire SQL Server or database application that appears to be slow

_Applies to:_ &nbsp; SQL Server

## Summary

When all queries against a SQL Server instance or a particular database application are slow, the cause is often outside any single query. This article helps database administrators and application developers troubleshoot slow SQL Server performance by working through nine layers in order: the application, operating system (OS), network, CPU, I/O, memory, blocking, schedulers, and tracing overhead. Each step explains the symptoms to look for and provides detailed information for troubleshooting. Following these steps helps you find the layer that's causing the slowdown and avoid tuning individual queries when the problem is elsewhere.

## Step 1: Troubleshoot application issues that make SQL Server appear slow

Check the application layer. Take a query from the application, run it manually on a SQL Server instance, and see how it runs. Test several queries this way. If queries are faster on the SQL Server instance, the problem could be on the application or application servers' layer.

> [!NOTE]
> Be mindful of the [query performance differences between database application and SSMS](../performance/troubleshoot-application-slow-ssms-fast.md).

If the application is running on a different server, check the performance of the application server (see [Step 2: Troubleshoot OS issues that slow SQL Server](#step-2-troubleshoot-os-issues-that-slow-sql-server) for troubleshooting). You might need to engage the application development team to check for any issues with the application.

## Step 2: Troubleshoot OS issues that slow SQL Server

Check if the operating system where SQL Server is running is responding slowly. For example, the mouse moves slowly, windows don't respond for long periods, remote desktop access to the server is slow, or connecting to a share on the server is slow.

Another service or application can cause this issue. Use Performance Monitor (Perfmon) to troubleshoot. For more information, see [Troubleshoot issues using Performance Monitor](/troubleshoot/windows-server/support-tools/troubleshoot-issues-performance-monitor).

For other OS performance problems, see [Windows Server performance troubleshooting documentation](../../../windows-server/performance/performance-overview.md).

Common issues include:

### [High CPU usage across all CPUs](#tab/highcpu)

Other applications, the OS, or drivers running on the system can cause this issue.

To troubleshoot this issue, use Task Manager, Performance Monitor, or Resource Monitor to identify the problem. For more information, see [High CPU usage troubleshooting guidance](../../../windows-server/performance/troubleshoot-high-cpu-usage-guidance.md).

### [Low physical or virtual memory](#tab/low-physical-or-virtual-memory)

Applications, drivers, or the OS can consume all available memory. Use the following methods to troubleshoot this issue:

- Check the Application event log for errors like "Your system is low on virtual memory."
- Open **Task Manager**, select **Performance** > **Memory** to check if memory is fully consumed.
- Use Perfmon and monitor these counters:

  - **Process\Working Set** - to check individual apps' memory usage.
  - **Memory\Available MBytes** - to check overall memory usage.

### [Slow I/O](#tab/slow-io)

Local drives are overwhelmed with I/O beyond their capacity. Use the following methods to troubleshoot this issue:

- Open **Task Manager**, select **Performance** > **Disk (*)** to check if disks are pushed to maximum capacity.
- Use Perfmon and monitor these counters:

  - **LogicalDisk\Disk Bytes/sec**
  - **LogicalDisk\Avg. Disk sec/Transfer**

### [Power plan configuration is causing CPU underperformance](#tab/power-plan-configuration-is-causing-cpu-underperformance)

For more information, see [Slow performance on Windows Server when using the Balanced power plan](../../../windows-server/performance/slow-performance-when-using-power-plan.md).

---

## Step 3: Troubleshoot network issues between the application and SQL Server

The problem could be in the network layer, causing slow communication between the application and SQL Server. Use the following methods to troubleshoot this issue:

- One symptom of that problem could be `ASYNC_NETWORK_IO` waits on the SQL Server side. For more information, see [Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type](../performance/troubleshoot-query-async-network-io.md).
- Work with your network administrator to check for network issues (firewall, routing, and so on).
- Collect a network trace and check for the network reset and retransmission events. For information about tracing tools, see [Consistent SQL Server network connectivity issues](../connect/consistent-sql-network-connectivity-issue.md#tracing-tools-to-capture). For troubleshooting ideas, see [Intermittent or Periodic Network Issue](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0300-Intermittent-or-Periodic-Network-Issue).
- Enable Perfmon counters to check network performance at the network interface level (NIC). There should be zero discarded packets and error packets. Check the network interface bandwidth:

  - **Network Interface\Packets Received Discarded**
  - **Network Interface\Packets Received Errors**
  - **Network Interface\Packets Outbound Discarded**
  - **Network Interface\Packets Outbound Errors**
  - **Network Interface\Bytes Total/Sec**
  - **Network Interface\Current Bandwidth**

## Step 4: Troubleshoot high CPU usage in SQL Server

If CPU-intensive queries are running on the system, they can cause other queries to starve for CPU capacity. More frequently, however, high CPU usage coming from queries can be an indication that queries need to be optimized. To troubleshoot high CPU usage issues, follow the steps in [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md).

## Step 5: Troubleshoot excessive I/O causing slowness in SQL Server

Another common reason for the perceived overall slowness of SQL Server workloads is I/O issues. I/O slowness can affect most or all queries on the system. Use the following methods to troubleshoot the issue:

- <a name="check-for-hardware-issues"></a>Check for hardware issues:

  - SAN misconfiguration (switch, cables, HBA, storage).
  - Exceeded I/O capacity (unbalanced throughout the entire SAN network, not just back-end storage, check I/O throughput of all servers sharing the SAN).
  - Drivers or firmware issues or updates.

- Check for suboptimal SQL Server queries that cause lots of I/O and saturate disk volumes with I/O requests.

  - Find the queries that cause a high number of logical reads (or writes) and tune those queries to minimize disk I/O. Using [appropriate indexes](/sql/relational-databases/indexes/tune-nonclustered-missing-index-suggestions) is the first step.
  - Keep statistics updated as they provide the query optimizer with sufficient information to choose the best plan.
  - Redesigning queries and sometimes tables might help with improved I/O.

- Filter drivers: The SQL Server I/O response can be severely impacted if file-system filter drivers process heavy I/O traffic.

  - Exclude data folders from antivirus scanning and have filter driver issues corrected by software vendors to prevent an impact on I/O performance.

- Other applications: Another application on the same machine with SQL Server can saturate the I/O path with excessive read or write requests. This situation might push the I/O subsystem beyond capacity limits and cause I/O slowness for SQL Server. Identify the application and tune it or move it elsewhere to eliminate its effect on the I/O stack.

  This problem can also be caused by applications running on other machines but sharing the same SAN with this SQL Server machine. Work with your SAN administrator to balance I/O traffic (see [Check for hardware issues](#check-for-hardware-issues)).

For detailed troubleshooting of I/O-related issues with SQL Server, see [Troubleshoot slow SQL Server performance caused by I/O issues](../performance/troubleshoot-sql-io-performance.md).

## Step 6: Troubleshoot memory issues that cause SQL Server slowness

Low memory on the system overall or inside SQL Server can lead to slowness when queries are waiting for memory grants (`RESOURCE_SEMAPHORE`) or compile memory (`RESOURCE_SEMAPHORE_QUERY_COMPILE`). For more information about memory grant waits, see [Troubleshoot slow performance or low memory issues caused by memory grants in SQL Server](../performance/troubleshoot-memory-grant-issues.md). 

Use the following methods to troubleshoot the issue:

- Check for external memory at the OS level by using Perfmon counters:

  - **Memory\Available MBytes**
  - **Process(*)\Working Set** (all instances)
  - **Process(*)\Private Bytes** (all instances)

- For internal memory pressure, use SQL Server queries to query [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) or use [DBCC MEMORYSTATUS](dbcc-memorystatus-monitor-memory-usage.md).

- Check the SQL Server error log for [701](/sql/relational-databases/errors-events/mssqlserver-701-database-engine-error) errors.

For detailed troubleshooting steps, see [Troubleshoot an out of memory or low memory issues in SQL Server](../performance/troubleshoot-memory-issues.md).

## Step 7: Troubleshoot blocking issues that make all queries wait

Lock acquisition protects resources in a database system. If a session holds locks for a long time and other sessions wait for those locks, you have a blocking scenario.

Short blocking happens on database systems like SQL Server frequently. But prolonged blocking, especially when most or all queries wait for a lock, might result in the entire server being perceived as unresponsive.

Use the following steps to troubleshoot the issue:

1. Identify the head blocking session by looking at the `blocking_session_id` column in [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) DMV output or the `BlkBy` column in `sp_who2` stored procedure output.
1. Find the query(s) that the head blocking chain executes (what is holding locks for a prolonged period).

    If no queries are actively running on the head blocking session, an orphaned transaction might exist due to application issues.

1. Redesign or tune the head blocking query to run faster, or reduce the number of queries inside a transaction.
1. Examine the transaction isolation used in the query and adjust it.

For detailed troubleshooting of blocking scenarios, see [Understand and resolve SQL Server blocking problems](../performance/understand-resolve-blocking.md#detailed-blocking-scenarios).

## Step 8: Troubleshoot scheduler issues (non-yielding, deadlocked scheduler, non-yielding IOCP listener, resource monitor)

SQL Server uses a cooperative scheduling mechanism (Schedulers) to expose its threads to the OS for scheduling on the CPU. If there are issues related to SQL schedulers, SQL Server threads might stop processing queries, logins, logouts, and so on. As a result, SQL Server might seem unresponsive, partially or completely, depending on how many schedulers are affected.

Scheduler issues might result from a wide range of problems, including product bugs, external and filter drivers, and hardware issues. Follow these steps to troubleshoot these issues.

### Identify scheduler errors in the SQL Server error log

Check your SQL Server Error log for errors like the following ones at the time of the reported lack of response from SQL Server:

- ```output
  ***********************************************
  *
  * BEGIN STACK DUMP:
  * 03/10/22 21:16:35 spid 22548
  *
  * Non-yielding Scheduler
  *
  ***********************************************
  ```

- ```output
  **********************************************
  *
  * BEGIN STACK DUMP:
  * 03/25/22 08:50:29 spid 355
  *
  * Deadlocked Schedulers
  *
  * ********************************************
  ```

- ```output
  * *******************************************************************************
  *
  * BEGIN STACK DUMP:
  * 09/07/22 23:01:04 spid 0
  *
  * Non-yielding IOCP Listener
  *
  * *******************************************************************************
  ```

- ```output
  * ********************************************
  *
  * BEGIN STACK DUMP:
  * 07/25/22 11:44:21 spid 2013
  *
  * Non-yielding Resource Monitor
  *
  * ********************************************
  ```

### Resolve scheduler errors

If you find one of the errors described in the previous section, follow these steps:

1. Identify which Cumulative Update (CU) version of SQL Server you're using. Check if there are any fixed issues in CUs shipped after your current CU. For the SQL Server fixes, see [Latest updates available for currently supported versions of SQL Server](https://support.microsoft.com/help/321185#latest-updates-available-for-currently-supported-versions-of-sql-server). For a detailed fix list, you can download this [Excel file](https://aka.ms/sqlserverbuilds).

1. Refer to [Troubleshooting SQL Server Scheduling and Yielding](https://techcommunity.microsoft.com/t5/sql-server-support-blog/troubleshooting-sql-server-scheduling-and-yielding/ba-p/319148) for more ideas.

1. Check for heavy blocking scenarios or massive parallelism queries that can lead to deadlock schedulers. For detailed information, see [The Tao of a Deadlocked Scheduler](https://techcommunity.microsoft.com/t5/sql-server-support-blog/the-tao-of-a-deadlock-scheduler-in-sql-server/ba-p/333991).

1. For a non-yielding IOCP listener, check if your system is low on memory and SQL Server is being paged out. Another reason could be anti-virus or intrusion prevention software intercepts I/O API calls and slows the thread activity down. For more information, see [Is the IOCP listener actually listening?](https://techcommunity.microsoft.com/t5/sql-server-support-blog/is-the-iocp-listener-actually-listening/ba-p/333989) and [Performance and consistency issues when certain modules or filter drivers are loaded](performance-consistency-issues-filter-drivers-modules.md).

1. For Resource Monitor issues, you might not necessarily be concerned with this issue in some cases. For more information, see [Resource Monitor enters a non-yielding condition on a server running SQL Server](../performance/resource-monitor-nonyielding-condition.md).

1. If these resources don't help, open a support ticket with Microsoft and upload the memory dump created in the \LOG subdirectory for analysis.

## Step 9: Look for resource-intensive Profiler or Extended Events traces

Look for active Extended Events or SQL Server Profiler traces, especially those with filtering on text columns (database name, login name, query text, and so on). If possible, disable the traces and see if query performance improves. Depending on the event selected, each thread might consume extra CPU causing overall slowness.

To identify the active traces for Extended Events, see [sys.dm_xe_sessions](/sql/relational-databases/system-dynamic-management-views/sys-dm-xe-sessions-transact-sql). For Profiler traces, see [sys.traces](/sql/relational-databases/system-catalog-views/sys-traces-transact-sql).

   ```sql
   SELECT * FROM sys.dm_xe_sessions
   GO
   SELECT * FROM sys.traces
   ```

> [!NOTE]
> [SQL Server Profiler](/sql/tools/sql-server-profiler/sql-server-profiler) and SQL Trace are deprecated. Use [Extended Events](/sql/relational-databases/extended-events/extended-events) instead.

## Related content

- [Troubleshoot slow-running queries in SQL Server](troubleshoot-slow-running-queries.md)
- [Troubleshoot query time-out errors](troubleshoot-query-timeouts.md)
- [sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql)
- [Monitor performance by using the Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
