---
title: Use DBCC MEMORYSTATUS to monitor memory usage
description: This article describes how to use the DBCC MEMORYSTATUS command to monitor memory usage.
ms.date: 09/25/2023
ms.custom: sap:Performance
ms.reviewer: jopilov, Bobward
ms.topic: how-to
---
# Use the DBCC MEMORYSTATUS command to monitor memory usage on SQL Server

This article describes how to use the `DBCC MEMORYSTATUS` command to monitor memory usage.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 907877

## Summary

This article discusses the output of the `DBCC MEMORYSTATUS` command. The output includes sections for Memory Manager, summary of memory usage, the aggregate memory information, the buffer pool information, and the procedure cache information. It also describes the output of global memory objects, query memory objects, optimization, and memory brokers. 

## Introduction

The `DBCC MEMORYSTATUS` command provides a snapshot of the current memory status of SQL Server. The command provides one of the most detailed outputs of memory distribution and usage in SQL Server. You can use the output from this command to troubleshoot memory consumption issues in SQL Server or to troubleshoot specific out of memory errors (many out of memory errors automatically print this output in the error log). You may run this command and provide the output when you contact Microsoft Support for an error that may be associated with a low-memory condition.

> [!NOTE]
> Performance Monitor (PerfMon) and Task Manager don't account for full memory usage if Locked Pages in Memory - Address Windowing Extensions (AWE) - is enabled.


> [!IMPORTANT]
> The `DBCC MEMORYSTATUS` command is intended to be a diagnostic tool for Microsoft Customer Support Services. The format of the output and the level of detail that is provided are subject to change between service packs and product releases. The functionality that the `DBCC MEMORYSTATUS` command provides may be replaced by a different mechanism in later product versions. Therefore, in later product versions, this command may no longer function. No additional warnings will be made before this command is changed or removed. Therefore, applications that use this command may break without warning.

The output of the `DBCC MEMORYSTATUS` command has changed from earlier releases of SQL Server. Now, it contains several tables that were unavailable in earlier product versions.

## How to use DBCC MEMORYSTATUS 

DBCC MEMORYSTATUS is typically used to investigate low memory issues reported by SQL Server. Low memory can occur if there's either external memory pressure that comes from outside of the SQL Server process or internal pressure that originates within the process. Internal pressure on its part, may stem from SQL Server database engine, or from other components that run inside the process (linked servers, XPs, SQLCLR, intrusion protection or anti-virus software, etc.). For more information on troubleshooting memory pressure, see [Troubleshoot out of memory or low memory issues in SQL Server](troubleshoot-memory-issues.md).

Here are the general steps on how to use the command and interpret its results. Specific scenarios may require that you approach the output a bit differently, but the overall approach is outlined here.

1. Run the DBCC MEMORYSTATUS command 
1. Use the **Process/System Counts**  and **Memory Manager** sections to establish if there's external memory pressure, for example if the computer is low on physical or virtual memory or if SQL Server working set is paged out. Also use these sections to determine how much memory the SQL Server database engine hasallocated in comparison with overall memory on the system.
1. If you establish that there's external memory pressure, then address that by reducing other applications' memory usage, OS usage, or by adding more RAM. 
1. If you establish that SQL Server engine is using most the memory (internal memory pressure), then you can use the remaining sections of DBCC MEMORYSTATUS to identify which component(s) (Memory clerk, Userstore, Cachestore, or Objectstore) is the largest contributor to this memory usage.
1. Examine each MEMORYCLEARK, CACHESTORE, USERSTORE, or OBJECTSTORE and look at its Pages Allocated to determine how much memory that component is consuming inside SQL Server. For a brief description of most database engine memory components, see the following table [Memory Clerk types](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql#types)
    1. In rare cases the allocation is direct virtual allocation, so look at the VM Committed value under the specific component, instead of Pages Allocated.
    1. If your machine uses NUMA, then some memory components are broken out per node. In those cases, you can see for example OBJECTSTORE_LOCK_MANAGER (node 0), OBJECTSTORE_LOCK_MANAGER (node 1), OBJECTSTORE_LOCK_MANAGER (node 2), and so on, and finally a total summed value of each node in OBJECTSTORE_LOCK_MANAGER (Total). The best place to start is with the section reporting the total value and only later look at the break down if necessary. For more information, see [Memory usage with NUMA nodes](#memory-usage-with-numa-nodes). 
1. There are sections in the DBCC MEMORYSTATUS with detailed, specialized information about particular memory allocators. You can use those if you need to understand more details, and further breakdown of the allocations within a memory clerk. Examples, with such detailed information include Buffer Pool (data and index cache), Procedure Cache/ plan cache, Query Memory Objects (memory grants), Optimization Queue  and small, medium and big gateways (optimizer memory), and a few others. If you already know that a particular component of memory in SQL Server is the source of memory pressure, you may choose to dive directly into the specific section. For example, if you established in some other way that there's a high usage of working set/memory grants which leads to memory errors, you can examine the Query memory objects sections directly. 

The remainder of this article describes some of the useful counters in the DBCC MEMORYSTATUS output that can allow you to diagnose memory issues more effectively.

## Process/System Counts

The first table of the output is `Process/System Counts`.

```output
Process/System Counts                Value
--------------------------------------------------
Available Physical Memory            5060247552
Available Virtual Memory             140710048014336
Available Paging File                7066804224
Working Set                          430026752
Percent of Committed Memory in WS    100
Page Faults                          151138
System physical memory high          1
System physical memory low           0
Process physical memory low          0
Process virtual memory low           0
```

For more information about the elements in this output, see:

- **Available Physical Memory**: This value shows the overall amount of free memory on the computer. In the example, the free memory is 5,060,247,552 bytes.
- **Available Virtual Memory**: This value shows the overall amount of free virtual memory for SQL Server process is 140,710,048,014,336 bytes (128 TB). For more information, see [Memory and Address Space Limits](/windows/win32/memory/memory-limits-for-windows-releases#memory-and-address-space-limits).
- **Available Paging File**: This value shows the free paging file space. In the example, the value is 7,066,804,224 bytes.
- **Working Set**: This value shows the overall amount of virtual memory that the SQL Server process has in RAM (isn't paged out) is 430,026,752 bytes.
- **Percent of Committed Memory in WS**: This value shows the percentage of virtual memory allocated to the SQL Server process compared how much of this memory is in RAM (or is Working Set). The value of 100% shows that all of the committed memory is stored in RAM and 0% of it's paged out.
- **Page Faults**: This value shows the overall amount of hard and soft page faults for the SQL Server. In the example, the value is 151,138.
- The remaining four values are binary or boolean. **System physical memory high** value of 1 indicates that SQL Server considers the available physical memory on the computer is high. That's why the value of **System physical memory low** is 0, which means no low memory. Similar logic is applied to **Process physical memory low** and **Process virtual memory low**, where 0 means it's false, and 1 is true. In this example both values are 0, which means there's plenty of physical and virtual memory for the SQL Server process.

## Memory Manager

This `Memory Manager` table shows the overall memory consumption by SQL Server.

```output
Memory Manager             KB
------------------------------ --------------------
VM Reserved                36228032
VM Committed               326188
Locked Pages Allocated     0
Large Pages Allocated      0
Emergency Memory           1024
Emergency Memory In Use    16
Target Committed           14210416
Current Committed          326192
Pages Allocated            161904
Pages Reserved             0
Pages Free                 5056
Pages In Use               286928
Page Alloc Potential       15650992
NUMA Growth Phase          0
Last OOM Factor            0
Last OS Error              0
```

For more information about the elements in this output, see:

- **VM Reserved**: This value shows the overall amount of virtual address space (VAS) or virtual memory (VM) that SQL Server has reserved. Virtual memory reservation of memory doesn't actually use physical memory; it simply means that virtual addresses are set aside from within the large VAS. For more information, see [VirtualAlloc(), MEM_RESERVE](/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc#:~:text=be%20MEM_COMMIT.-,MEM_RESERVE,-0x00002000)
- **VM Committed**: This value shows the overall amount of virtual memory that SQL Server has committed. VM that is committed is memory actually used by the process that is backed by physical memory or less frequently by page file. The previously reserved memory addresses are now backed by a physical storage, that is they're allocated. If Locked Pages in Memory is enabled, SQL Server uses an alternative method to allocate memory - AWE API, and most the memory isn't be reflected here. See Locked Pages Allocated for those allocations. For more information, see [VirtualAlloc(), MEM_COMMIT](/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc#:~:text=Meaning-,MEM_COMMIT,-0x00001000)
- **Pages Allocated**: This value shows the total number of memory pages allocated by SQL Server. 
- **Locked Pages Allocated**: This value represents the amount of memory, in kilobytes (KB), that SQL Server has allocated and locked in physical RAM using the AWE API. It indicates how much memory SQL Server is actively using and has requested to be kept in memory to optimize performance. By locking pages in memory, SQL Server ensures that critical database pages are readily available and not swapped to disk. For more information, see [Address Windows Extensions (AWE) memory](/sql/relational-databases/memory-management-architecture-guide#address-windows-extensions-awe-memory). A value of zero indicates that the "locked pages in memory" feature is currently disabled and SQL Server uses virtual memory instead. In that case the VM Committed value would represent the allocated memory to SQL Server.  
- **Large Pages Allocated**: This value represents the amount of memory allocated by SQL Server using Large Pages. Large Pages is a memory management feature provided by the operating system. Instead of using the standard page size (typically 4 KB), this feature uses a larger page size, such as 2 MB or 4 MB. A value of zero indicates that the feature isn't enabled. For more information, see [Virtual Alloc(), MEM_LARGE_PAGES](/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc#:~:text=Meaning-,MEM_LARGE_PAGES,-0x20000000)
- **Target Committed**: This value indicates the target amount of memory that SQL Server aims to have committed, an ideal amount of memory SQL Server could consume, based on recent workload.
- **Current Committed**: This value indicates the amount of the operating system's memory (in KB) the SQL Server memory manager has currently committed (allocated in physical store). This value includes either "locked pages in memory" (AWE API) or virtual memory. Therefore, this value is close to or the same as VM Committed or Locked Pages Allocated. Note that when SQL Server uses the AWE API, some memory is still allocated by the OS Virtual Memory Manager and will be reflected as VM Committed.
- **NUMA Growth Phase**: This value indicates whether SQL Server is currently in a NUMA growth phase. For more information about this initial ramp up of memory when NUMA nodes exist on the machine, see [How It Works: SQL Server (NUMA Local, Foreign and Away Memory Blocks)](https://techcommunity.microsoft.com/t5/sql-server-support-blog/how-it-works-sql-server-numa-local-foreign-and-away-memory/ba-p/317461)
- **Last OS Error**: This value shows the last OS error that occurred when there was a memory pressure on the system. SQL Server records that OS error and shows it in the output here. For a full list of OS error, see [System Error Codes](/windows/win32/debug/system-error-codes--0-499-)

## Memory usage with NUMA nodes

The `Memory Manager` table is followed by a summary of memory usage for each memory node. In a non-uniform memory access (NUMA) enabled system, there's a corresponding Memory node entry for each hardware NUMA node. In an SMP system, there's a single Memory node entry. The same patter is applied to other memory sections. 

```output
Memory node Id = 0      KB
----------------------  -----------
VM Reserved             21289792
VM Committed            272808
Locked Pages Allocated  0
Pages Allocated         168904
Pages Free              3040
Target Committed        6664712
Current Committed       272808
Foreign Committed       0
Away Committed          0
Taken Away Committed    0
```

> [!NOTE]
> - The `Memory node Id` may not correspond to the hardware node ID.
> - These values show the memory that is allocated by threads that are running on this NUMA node. These values are not the memory that is local to the NUMA node.
> - The sums of the VM Reserved values and the VM Committed values on all memory nodes will be slightly less than the corresponding values that are reported in the Memory Manager table.
> - NUMA node 64 (node 64) is reserved for DAC and is rarely of interest in memory investigation since this connection uses limited memory resources. For more information about dedicated administrator connection (DAC), see [Diagnostic connection for database administrators](/sql/database-engine/configure-windows/diagnostic-connection-for-database-administrators)

For more information about the elements in this output, see:

- VM Reserved: This value shows the virtual address space (VAS) that is reserved by threads that are running on this node.
- VM Committed: This value shows the VAS that is committed by threads that are running on this node.

## Aggregate memory

The next table contains aggregate memory information for each clerk type and for each NUMA node. For a NUMA-enabled system, you may see output that is similar to the following one:

```output
MEMORYCLERK_SQLGENERAL (node 0) KB
---------------------------------------------------------------- --------------------
VM Reserved                     0
VM Committed                    0
Locked Pages Allocated          0
SM Reserved                     0
SM Commited                     0
Pages Allocated                 5416

MEMORYCLERK_SQLGENERAL (node 1) KB
---------------------------------------------------------------- --------------------
VM Reserved                     0
VM Committed                    0
Locked Pages Allocated          0
SM Reserved                     0
SM Commited                     0
Pages Allocated                 136

MEMORYCLERK_SQLGENERAL (Total)  KB
---------------------------------------------------------------- --------------------
VM Reserved                     0
VM Committed                    0
Locked Pages Allocated          0
SM Reserved                     0
SM Commited                     0
Pages Allocated                 5552
```

The value of `Pages Allocated` shows the overall amount of the memory pages allocated to a process.

> [!NOTE]
> These node IDs correspond to the NUMA node configuration of the computer that is running SQL Server. The node IDs include possible software NUMA nodes that are defined on top of hardware NUMA nodes or on top of an SMP system. To find mapping between node IDs and CPUs for each node, see Information Event ID 17152. This event is logged in the Application log in Event Viewer when you start SQL Server.

For an SMP system, you see only one table for each clerk type. This table is similar to the following one:

```output
MEMORYCLERK_SQLGENERAL (Total)     KB
---------------------------------------------------------------- --------------------
VM Reserved                        0
VM Committed                       0
AWE Allocated                      0
SM Reserved                        0
SM Commited                        0
Pages Allocated                    2928
```

Other information in these tables is about shared memory:

- SM Reserved: This value shows the VAS that is reserved by all clerks of this kind that are using the memory-mapped files API. This API is also known as *shared memory*.
- SM Committed: This value shows the VAS that is committed by all clerks of this kind that are using memory-mapped files API.

As an alternative method, you can obtain summary information for each clerk type for all memory nodes by using the [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) dynamic management view (DMV). To do this, run the following query:

```sql
SELECT
  TYPE,
  SUM(virtual_memory_reserved_kb) AS [VM Reserved],
  SUM(virtual_memory_committed_kb) AS [VM Committed],
  SUM(awe_allocated_kb) AS [AWE Allocated],
  SUM(shared_memory_reserved_kb) AS [SM Reserved],
  SUM(shared_memory_committed_kb) AS [SM Committed],
  -- SUM(multi_pages_kb) AS [MultiPage Allocator],          /*Applies to: SQL Server 2008   (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
  -- SUM(single_pages_kb) AS [SinlgePage Allocator],        /*Applies to: SQL Server 2008   (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
  SUM(pages_kb) AS [Page Allocated]                      /*Applies to: SQL Server 2012 (11.  x) and later.*/
FROM sys.dm_os_memory_clerks
GROUP BY TYPE
```

## Buffer pool details

This is a specialized section that provides a breakdown of different states data and index pages inside the Buffer pool, also known as data cache. 
This table lists details about the buffer pool plus additional information.

```output
Buffer Pool                                        Pages
--------------------------------------------------------
Database                                          5404
Simulated                                         0
Target                                            16384000
Dirty                                             298
In IO                                             0
Latched                                           0
IO error                                          125
In Internal Pool                                  0
Page Life Expectancy                              3965
```

For more information about the elements in this output, see:

- Database: This value shows the number of buffers (pages) that have database content (data and index pages).
- Target: This value shows the target size of the buffer pool (buffer count). See Target Committed memory discussion in previous sections of this article. 
- Dirty: This value shows the pages that have database content and have been modified. These buffers contain changes that must be flushed to disk typically by the checkpoint process.
- In IO: This value shows the buffers that are waiting for a pending I/O operation. This means the contents of these pages is either being written to or read from storage. 
- Latched: This value shows the latched buffers. A buffer is latched when a thread is reading or modifying the contents of a page. A buffer is also latched when the page is being read from disk or written to disk. A latch is used to maintain the physical consistency of the data on the page while it's being read or modified. In contrast, a lock is used to maintain logical and transactional consistency. 
- IO error: This value shows the count of buffers that may have encountered any I/O-related OS errors (this doesn't necessarily indicate a problem).
- Page Life Expectancy: This counter measures the amount of time in seconds that the oldest page has stayed in the buffer pool.


You can obtain detailed information about buffer pool for database pages by using the `sys.dm_os_buffer_descriptors` DMV. But use this DMV with caution as it can run a long time and produce a huge output if your SQL Server is allowed to have lots of RAM at its disposal.  

## Plan cache

The next table describes the makeup of the plan cache (used to be referred to as procedure cache).

```output
Procedure Cache         Value
------------------------------ -----------
TotalProcs              4
TotalPages              25
InUsePages              0
```

For more information about the elements in this output, see:

- TotalProcs: This value shows the total cached objects currently in the procedure cache. This value matches the entries in the `sys.dm_exec_cached_plans` DMV.

  > [!NOTE]
  > Because of the dynamic nature of this information, the match may not be exact. You can use PerfMon to monitor the SQL Server: Plan Cache object and the `sys.dm_exec_cached_plans` DMV for detailed information about the type of cached objects, such as triggers, procedures, and ad hoc objects.

- TotalPages: This value shows the cumulative pages used to store all the cached objects in the plan/procedure cache.
- InUsePages: This value shows the pages in the procedure cache that belong to procedures that are currently running. These pages can't be discarded.

## Global memory objects

The next table contains information about various global memory objects. This table also contains information about how much memory the global memory objects use.

```output
Global Memory Objects               Buffers
---------------------------------------------------
Resource                            576
Locks                               96
XDES                                61
DirtyPageTracking                   52
SETLS                               8
SubpDesc Allocators                 8
SE SchemaManager                    139
SE Column Metadata Cache            159
SE Column Metadata Cache Store      2
SE Column Store Metadata Cache      8
SQLCache                            224
Replication                         2
ServerGlobal                        1509
XP Global                           2
SortTables                          3
```

For more information about the elements in this output, see:

- Resource: This value shows the memory that the Resource object uses. The Resource object is used by the storage engine and for various server-wide structures.
- Locks: This value shows the memory that Lock Manager uses.
- XDES: This value shows the memory that Transaction Manager uses.
- SETLS: This value shows the memory that is used to allocate the Storage Engine-specific per-thread structure that uses thread local storage (TLS). For more information, see [Thread Local Storage](/windows/win32/procthread/thread-local-storage)
- SubpDesc Allocators: This value shows the memory that is used for managing subprocesses for parallel queries, backup operations, restore operations, database operations, file operations, mirroring, and asynchronous cursors. These subprocesses are also known as *parallel processes*.
- SE SchemaManager: This value shows the memory that Schema Manager uses to store Storage Engine-specific metadata.
- SQLCache: This value shows the memory that is used to store the text of ad hoc statements and of prepared statements.
- Replication: This value shows the memory that the server uses for internal replication subsystems.
- ServerGlobal: This value shows the global server memory object that is used generically by several subsystems.
- XP Global: This value shows the memory that extended stored procedures use.
- SortTables: This value shows the memory that sort tables use.

## Query memory objects

The next table describes Query Memory grant information. This table includes a snapshot of the query memory usage. Query memory is also known as *workspace memory*.

```output
Query Memory Objects (default)           Value
------------------------------------------------
Grants                                    0
Waiting                                   0
Available                                 436307
Current Max                               436307
Future Max                                436307
Physical Max                              436307
Next Request                              0
Waiting For                               0
Cost                                      0
Timeout                                   0
Wait Time                                 0
```

If the size and the cost of a query satisfy "small" query memory thresholds, the query is put in a small query queue. This behavior prevents smaller queries from being delayed behind larger queries that are already in the queue.

For information about the elements in this output:

- Grants: This value shows the running queries that have memory grants.
- Waiting: This value shows the queries that are waiting to obtain memory grants.
- Available: This value shows the buffers that are available to queries for use as hash workspace and as sort workspace. The Available value is updated periodically.
- Next Request: This value shows the memory request size, in buffers, for the next waiting query.
- Waiting For: This value shows the amount of memory that must be available to run the query to which the Next Request value refers. The Waiting For value is the Next Request value multiplied by a headroom factor. This value effectively guarantees that a specific amount of memory will be available when the next waiting query is run.
- Cost: This value shows the cost of the next waiting query.
- Timeout: This value shows the time-out, in seconds, for the next waiting query.
- Wait Time: This value shows the elapsed time, in milliseconds, since the next waiting query was put in the queue.
- Current Max: This value shows the overall memory limit for query execution. This value is the combined limit for both the large query queue and the small query queue.

For more information on how what memory grants are, what many of these values mean, and how to troubleshoot memory grants, see [Troubleshoot slow performance or low memory issues caused by memory grants in SQL Server](troubleshoot-memory-grant-issues.md). 

## Optimization memory

The next table provides details of memory waits happening due to insufficient memory for query optimization.

```output
Optimization Queue (internal)      Value
---------------------------------------------------
Overall Memory                     4013162496
Target Memory                      3673882624
Last Notification                  1
Timeout                            6
Early Termination Factor           5

Small Gateway (internal)           Value
---------------------------------------------------
Configured Units                   32
Available Units                    32
Acquires                           0
Waiters                            0
Threshold Factor                   380000
Threshold                          380000

Medium Gateway (internal)          Value
---------------------------------------------------
Configured Units                   8
Available Units                    8
Acquires                           0
Waiters                            0
Threshold Factor                   12
Threshold                          -1

Big Gateway (internal)             Value
---------------------------------------------------
Configured Units                   1
Available Units                    1
Acquires                           0
Waiters                            0
Threshold Factor                   8
Threshold                          -1

Optimization Queue (default)       Value
---------------------------------------------------
Overall Memory                     4013162496
Target Memory                      3542319104
Last Notification                  1
Timeout                            6
Early Termination Factor           5

Small Gateway (default)            Value
---------------------------------------------------
Configured Units                   32
Available Units                    32
Acquires                           0
Waiters                            0
Threshold Factor                   380000
Threshold                          380000

Medium Gateway (default)           Value
---------------------------------------------------
Configured Units                   8
Available Units                    82
Acquires                           0
Waiters                            2
Threshold Factor                   12
Threshold                          -1

Big Gateway (default)              Value
---------------------------------------------------
Configured Units                   1
Available Units                    1
Acquires                           0
Waiters                            0
Threshold Factor                   8
Threshold                          -1
```

Queries are submitted to the server for compilation. The compilation process includes parsing, algebraization, and optimization. Queries are classified based on the memory each query consumes during the compilation process.

> [!NOTE]
> This amount doesn't include the memory that is required to run the query.

When a query starts, there's no limit on how many queries can be compiled. As the memory consumption increases and reaches a threshold, the query must pass a gateway to continue. There's a progressively decreasing limit of simultaneously compiled queries after each gateway. The size of each gateway depends on the platform and the load. Gateway sizes are chosen to maximize scalability and throughput.

If the query can't pass a gateway, it waits until memory is available or returns a time-out error (Error 8628). Additionally, the query may not acquire a gateway if the user cancels the query or if a deadlock is detected. If the query passes several gateways, it doesn't release the smaller gateways until the compilation process has completed.

This behavior lets only a few memory-intensive compilations occur at the same time. Additionally, this behavior maximizes throughput for smaller queries.

## Memory brokers

The following tables show information about memory brokers that control cached memory, stolen memory, and reserved memory. Information that these tables provide can only be used for internal diagnostics. Therefore, this information isn't detailed here.

```output
MEMORYBROKER_FOR_CACHE (internal)       Value
-----------------------------------------------------
Allocations                             20040
Rate                                    0
Target Allocations                      3477904
Future Allocations                      0
Overall                                 3919104
Last Notification                       1

MEMORYBROKER_FOR_STEAL (internal)       Value
-----------------------------------------------------
Allocations                             129872
Rate                                    40
Target Allocations                      3587776
Future Allocations                      0
Overall                                 3919104
Last Notification                       1

MEMORYBROKER_FOR_RESERVE (internal)      Value
-----------------------------------------------------
Allocations                             0
Rate                                    0
Target Allocations                      3457864
Future Allocations                      0
Overall                                 3919104
Last Notification                       1

MEMORYBROKER_FOR_CACHE (default)        Value
-----------------------------------------------------
Allocations                             44592
Rate                                    8552
Target Allocations                      3511008
Future Allocations                      0
Overall                                 3919104
Last Notification                       1

MEMORYBROKER_FOR_STEAL (default)        Value
-----------------------------------------------------
Allocations                             1432
Rate                                    -520
Target Allocations                      3459296
Future Allocations                      0
Overall                                 3919104
Last Notification                       1

MEMORYBROKER_FOR_RESERVE (default)      Value
-----------------------------------------------------
Allocations                             0
Rate                                    0
Target Allocations                      3919104
Future Allocations                      872608
Overall                                 3919104
Last Notification                       1
```
