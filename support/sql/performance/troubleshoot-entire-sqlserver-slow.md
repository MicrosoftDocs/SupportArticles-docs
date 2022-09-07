---
title: Troubleshoot entire server is slow 
description: This article describes how to troubleshoot a situation when the entire SQL Server seems to be slow
ms.date: 09/01/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: pijocoder
ms.author: jopilov
---

# Entire SQL Server or database application is slow


## Symptoms:

Entire SQL Server seems slow (all queries submitted to it are slow) or all queries from a particular application are slow.


## Step 1. Application issues 

Check the application layer first. Take a query from the application and run it manually on the SQL Server and see how it runs in comparison to that from the application. Test this for several queries. If queries are faster on the SQL Server, then the problem could be on the application or application servers' layer

But be mindful of differences between application and SSMS [Troubleshoot query performance difference between database application and SSMS](/troubleshoot/sql/performance/troubleshoot-application-slow-ssms-fast)

If the application is running on a different server, then check performance of the application server (see Step 2. OS issues for troubleshooting), you may need to engage the application development team to check for any issues with the application.

## Step 2. OS issues

Check the operating system where SQL Server is running. Is the system slow in its response - mouse moves slowly and windows don't respond for long periods of time.  

Common issues include:
   - **High CPU across all CPUs** - could be caused by other applications, the OS or drivers running on the system. 
 
     **Troubleshooting**: Use Task manager, Performance Monitor/Resource Monitor to identify this issue. See [High CPU usage troubleshooting guidance](/troubleshoot/windows-server/performance/troubleshoot-high-cpu-usage-guidance)

   - **Low physical/virtual memory** - caused by applications, drivers, or OS consuming entire memory.

     ### Troubleshooting 
     - Check the Application event log for errors like `Your system is low on virtual memory.`
     - Use Task manager -> **Performance tab** -> **Memory** to check for memory being consumed entirely. 
     - Use Perfomon and monitor these counters:
        - **Process\Working Set** - to check individual apps' memory usage
        - **Memory\Available Memory (MB)** - to check overall memory usage

   - **Slow I/O** - local drives are overwhelmed with I/O beyond their capacity

     ### Troubleshooting 
     - Use Task manager -> Performance tab -> Disk (*) to check for disks being pushed to maximum capacity. 
     - Use Perfomon and monitor these counters:
        - **Logical Disk\Disk Bytes/Sec**
        - **Logical Disk\Avg. Disk sec/Transfer**

   - Caused by another service/app - perfmon
   - Check if a Power Plan configuration is causing CPU underperformance. For more information, see  [Slow performance on Windows Server when using the Balanced power plan](/troubleshoot/windows-server/performance/slow-performance-when-using-power-plan)

For other OS performance problems, see [Windows Server performance troubleshooting documentation](/troubleshoot/windows-server/performance/performance-overview)
   
## Step 3. Network issues

  The problem could be in the network layer causing slow communication between application and SQL Server. 
 ### Troubleshooting 
   - One symptom of that could be ASYNC_NETWORK_IO waits on the SQL Server side. For more information, see [Troubleshoot ASYNC_NETWORK_IO waits](/troubleshoot/sql/performance/troubleshoot-query-async-network-io)
  - Work with your network administrator to check for network issues (firewall, routing, etc.) 
  - Collect a Network trace and check for network reset and retransmit events. For troubleshooting ideas, see [Intermittent or Periodic Network Issue]( https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0300-Intermittent-or-Periodic-Network-Issue)
  - Enable Perfmon counters to check network performance at the network interface level (NIC). There should be zero discarded and error packets. Check the network interface bandwidth
    - **Network Interface\Packets Received Discarded**
    - **Network Interface\Packets Received Errors**
    - **Network Interface\Packets Outbound Discarded**
    - **Network Interface\Packets Outbound Errors**
    - **Network Interface\Bytes Total/Sec**
    - **Network Interface\Current Bandwidth**

## Step 4. High CPU in SQL Server

If CPU-intensive queries are being executed on the system, they can cause other queries to be starved of CPU capacity. More frequently, however, high-CPU coming from queries can be an indication that queries need to be optimized. Here are basic steps on how to approach these issues:

### Troubleshooting

- First, found out if SQL Server is causing high CPU usage (using Perfmon counters)
- Identify queries contributing to CPU usage
- Update statistics
- Add missing indexes
- Investigate and resolve parameter-sensitive issues
- Investigate and resolve SARGability issues
- Disable heavy tracing
- Fix SOS_CACHESTORE spinlock contention
- Configure your virtual machine
- Scale up system by adding more CPUs

For detailed troubleshooting steps, see [Troubleshoot high-CPU-usage issues in SQL Server](/sql/performance/troubleshoot-high-cpu-usage-issues)

## Step 5. Excessive I/O causing slowness in SQL Server

Another common reason for perceived overall slowness of SQL Server workloads is I/O issues. I/O slowness can impact most or all queries on the system.

### Troubleshooting

- Check for Hardware issues: 
    - SAN misconfiguration (switch, cables, HBA, storage)
    - Exceeded I/O capacity (unbalanced throughout the entire SAN network, not just back-end storage, check I/O throughput of all servers sharing the SAN)
    - Drivers or firmware issues/updates
    
- Check for suboptimal SQL Server queries that are causing lots of I/O and saturating disk volumes with I/O requests. 
   - Find the queries that are causing a high number of logical reads (or writes) and tune those queries to minimize disk I/O-using appropriate indexes is the first step to do that 
   - Keep statistics updated as they provide the query optimizer with sufficient information to choose the best plan. 
   - Redesigning queries and sometimes tables may help with improved I/O.

- Filter drivers: The SQL Server I/O response can be severely impacted if file-system filter drivers process heavy I/O traffic. 
   - Exclude data folders from anti-virus scanning and have filter driver issues be corrected by software vendors to prevent the impact on I/O performance.

- Other application(s): Another application on the same machine with SQL Server can saturate the I/O path with excessive read or write requests. This situation may push the I/O subsystem beyond capacity limits and cause I/O slowness for SQL Server. Identify the application and tune it or move it elsewhere to eliminate its effect on the I/O stack. This issue can be caused by other applications running on other machines but sharing the same SAN with this SQL Server machine. Work with your SAN administrator to balance I/O traffic (see check for hardware issues above)
  
For detailed troubleshooting of I/O related issue with SQL Server, see [Troubleshoot slow SQL Server performance caused by I/O issues](/sql/performance/troubleshoot-sql-io-performance)
  
## Step 6. Memory issues 

Low memory on the system overall or inside SQL Server can lead to slowness when queries are waiting for memory grants (RESOURCE_SEMAPHORE) or compile memory (RESOURCE_SEMAPHORE_QUERY_COMPILE).

### Troubleshooting

- Check for external memory at the OS level by using Perfmon counters
  - **Memory\Available MBytes**
  - **Process(*)\Working Set** (all instances)
  - **Process(*)\Private Bytes**  (all instances)

- For internal memory pressure use SQL Server queries to query **sys.dm_os_memory_clerks** or use `DBCC MEMORYSTATUS`

- Check the SQL Server error log for 701 errors


For detailed troubleshooting steps, see [Troubleshoot an out of memory or low memory issues in SQL Server](/sql/performance/troubleshoot-memory-issues)

## Step 7. Blocking issues

Lock acquisition is used to protect resources in a database system. If locks are acquired for a long time and other sessions end up waiting for those locks, then you're faced with a blocking scenario.
Short blocking happens on database systems like SQL Server all the time. But prolonged blocking and especially one where most or all queries are waiting for a lock  may result in entire server being perceived as not responding.


### Troubleshooting

- Identify the head blocking session by looking at blocking_session_id in `sys.dm_exec_requests` DMV output or BlkBy column in `sp_who2` stored procedure output
- Then find the query(s) that the head blocking chain executes  (what is holding locks for a prolonged period)
  - If no queries are actively running on the head blocking session, then there could have been an orphaned transaction due to application issues
- Redesign or tune the head blocking query to run faster, or reduce the number of queries inside a transaction
- Examine the transaction isolation used in the query and adjust 

For detailed troubleshooting of blocking scenarios, refer to [Understand and resolve SQL Server blocking problems](/sql/performance/understand-resolve-blocking#detailed-blocking-scenarios)

## Step 8. Scheduler Issues (Non-yielding, Deadlocked Scheduler, Non-yielding IOCP Listener, Resource Monitor)

SQL Server uses a cooperative scheduling mechanism (Schedulers) to expose its threads to the OS for scheduling on the CPU. If there are issues related to SQL schedulers, then SQL Server threads may stop processing queries, logins, logouts, etc. As a result, SQL Server may seem unresponsive, partially or completely depending on how many schedulers are affected. Scheduler issues are caused by a wide range of problems from product bugs, to external drivers or filter drivers, to hardware issues. See the steps below for ideas on how to troubleshoot these issues. 

### Troubleshooting

1. Check your SQL Server Error log for errors like these at the time of the reported lack of response from SQL Server:

```output
 ***********************************************
 *
 * BEGIN STACK DUMP:
 *   03/10/22 21:16:35 spid 22548
 *
 * Non-yielding Scheduler
 *
 ***********************************************
```

```output
**********************************************
*
* BEGIN STACK DUMP:
* 03/25/22 08:50:29 spid 355
*
* Deadlocked Schedulers
*
* ********************************************
```

```output
* ********************************************
*
* BEGIN STACK DUMP:
* 07/25/22 11:44:21 spid 2013
*
*
* Non-yielding Resource Monitor
*
* ********************************************
```

1. If you locate one of these errors, find identify which version (Cumulative Update) of SQL Server you are on and see if there are any fixed issues in Cumulative updates shipped after your current CU. You can browse the SQL Server fixes starting here [Latest updates available for currently supported versions of SQL Server](/general/determine-version-edition-update-level#latest-updates-available-for-currently-supported-versions-of-sql-server) or to see a detailed fix list for you can download this [Excel file](https://download.microsoft.com/download/d/6/5/d6583d78-9956-45c1-901d-eff8b5270896/SQL%20Server%20Builds%20V4.xlsx)

1. Use [Troubleshooting SQL Server Scheduling and Yielding](https://techcommunity.microsoft.com/t5/sql-server-support-blog/troubleshooting-sql-server-scheduling-and-yielding/ba-p/319148) for more ideas


1. Check for heavy blocking scenarios or massive parallelism queries that can lead to deadlock schedulers. For detailed information, see [The Tao of a Deadlocked Scheduler](https://techcommunity.microsoft.com/t5/sql-server-support-blog/the-tao-of-a-deadlock-scheduler-in-sql-server/ba-p/333991)
 
1. For Non-yielding IOCP listener, check if your system is low on memory and SQL Server is being paged out. Another reason could be anti-virus or intrusion prevention software may intercept I/O API calls and slow down thread activity. For more information, see [Is the IOCP listener actually listening?](https://techcommunity.microsoft.com/t5/sql-server-support-blog/is-the-iocp-listener-actually-listening/ba-p/333989) and [Performance and consistency issues when certain modules or filter drivers are loaded](performance-consistency-issues-filter-drivers-modules.md)

1. For Resource Monitor issues, you may not necessarily be concerned with this issue in some cases. For more information [Resource Monitor enters a non-yielding condition on a server running SQL Server](resource-monitor-nonyielding-condition.md)
1. If these resources don't help, locate the memory dump created in the \LOG subdirectory and open a support ticket with Microsoft CSS by uploading the memory dump for analysis. 