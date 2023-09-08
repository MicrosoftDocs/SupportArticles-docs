---
title: Use DBCC MEMORYSTATUS to monitor memory usage
description: This article describes how to use the DBCC MEMORYSTATUS command to monitor memory usage.
ms.date: 05/19/2023
ms.custom: sap:Performance
ms.reviewer: Bobward, jopilov
ms.topic: how-to
---
# Use the DBCC MEMORYSTATUS command to monitor memory usage on SQL Server

This article describes how to use the `DBCC MEMORYSTATUS` command to monitor memory usage.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 907877

## Summary

This article discusses the output of the `DBCC MEMORYSTATUS` command. This command is frequently used to troubleshoot Microsoft SQL Server memory consumption issues.

This article describes the elements of the output for Memory Manager, the summary of memory usage, the aggregate memory information, the buffer pool information, and the procedure cache information. It also describes the output of global memory objects, query memory objects, optimization, and memory brokers.

## Introduction

The `DBCC MEMORYSTATUS` command provides a snapshot of the current memory status of SQL Server. You can use the output from this command to troubleshoot memory consumption issues in SQL Server or to troubleshoot specific out of memory errors (many out of memory errors automatically print this output in the error log). You may run this command and provide the output when you contact Microsoft Support for an error that may be associated with a low-memory condition.

> [!NOTE]
> Performance Monitor (PerfMon) and Task Manager don't account for memory correctly if Address Windowing Extensions (AWE) support is enabled.

This article describes some of the data that you can obtain from the output of the `DBCC MEMORYSTATUS` command.

## More information

> [!IMPORTANT]
> The `DBCC MEMORYSTATUS` command is intended to be a diagnostic tool for Microsoft Customer Support Services. The format of the output and the level of detail that is provided are subject to change between service packs and product releases. The functionality that the `DBCC MEMORYSTATUS` command provides may be replaced by a different mechanism in later product versions. Therefore, in later product versions, this command may no longer function. No additional warnings will be made before this command is changed or removed. Therefore, applications that use this command may break without warning.

The output of the `DBCC MEMORYSTATUS` command has changed from earlier releases of SQL Server. Now, it contains several tables that were unavailable in earlier product versions.

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

- Available Physical Memory: This value shows the overall amount of free memory on the system is 5,060,247,552 bytes.
- Available Virtual Memory: This value shows the overall amount of free virtual memory for SQL, or any process is 140,710,048,014,336 bytes (128 TB). For more information, see [Memory and Address Space Limits](/windows/win32/memory/memory-limits-for-windows-releases#memory-and-address-space-limits).
- Available Paging File: This value shows the free paging file space is 7,066,804,224 bytes.
- Working Set: This value shows the overall amount of virtual memory that the SQL Server process has in RAM is 430,026,752 bytes.
- Percent of Committed Memory in WS: This value shows the percentage of virtual memory allocated to running processes or applications compared to the total amount of virtual memory available is 100%.
- Page Faults: This value shows the overall amount of page faults for all processes is 151,138.

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

- VM Reserved: This value shows the overall amount of virtual address space (VAS) that SQL Server has reserved.
- VM Committed: This value shows the overall amount of VAS that SQL Server has committed. VAS that is committed has been associated with physical memory.
- Pages Allocated: This value shows the total number of memory pages allocated to a process.
- Locked Pages Allocated: This value represents the amount of memory, in kilobytes (KB), that SQL Server has allocated and locked in physical RAM using the AWE API. It indicates how much memory SQL Server is actively using and has requested to be kept in memory to optimize performance. By locking pages in memory, SQL Server ensures that critical database pages are readily available and not swapped to disk. For more information, see [Address Windows Extensions (AWE) memory](/sql/relational-databases/memory-management-architecture-guide#address-windows-extensions-awe-memory). A value of zero indicates that the "locked pages in memory" feature is currently disabled and SQL Server uses virtual memory instead.
- Large Pages Allocated: This value represents the amount of memory allocated by SQL Server using Large Pages. Large Pages is a memory management feature provided by the operating system. Instead of using the standard page size (typically 4 KB), this feature uses a larger page size, such as 2 MB or 4 MB. A value of zero indicates that the feature isn't enabled.
- Target Committed: This value indicates the target amount of memory that SQL Server aims to have committed, an ideal amount of memory SQL Server could consume, based on recent workload.
- Current Committed: This value indicates the amount of the operating system's memory (in KB) the SQL Server memory manager currently has committed. This value includes either "locked pages in memory" (AWE) or virtual memory. Therefore, this value is close to VM Committed or Locked Pages Allocated.

## Summary of memory usage

The `Memory Manager` table is followed by a summary of memory usage for each memory node. In a non-uniform memory access (NUMA) enabled system, there's a corresponding Memory node entry for each hardware NUMA node. In an SMP system, there's a single Memory node entry.

```output
Memory node Id = 0      KB
------------------------------ --------------------
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

For more information about the elements in this output, see:

- VM Reserved: This value shows the VAS that is reserved by threads that are running on this node.
- VM Committed: This value shows the VAS that is committed by threads that are running on this node.

## Aggregate memory

The next table contains aggregate memory information for each clerk type and for each NUMA node. For a NUMA-enabled system, you may see output that is similar to the following one:

> [!NOTE]
> The following table contains only part of the output.

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

You can obtain summary information for each clerk type for all memory nodes by using the [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) dynamic management view (DMV). To do this, run the following query:

```sql
SELECT
TYPE,
SUM(virtual_memory_reserved_kb) AS [VM Reserved],
SUM(virtual_memory_committed_kb) AS [VM Committed],
SUM(awe_allocated_kb) AS [AWE Allocated],
SUM(shared_memory_reserved_kb) AS [SM Reserved],
SUM(shared_memory_committed_kb) AS [SM Committed],
-- SUM(multi_pages_kb) AS [MultiPage Allocator],          /*Applies to: SQL Server 2008 (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
-- SUM(single_pages_kb) AS [SinlgePage Allocator],        /*Applies to: SQL Server 2008 (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
SUM(pages_kb) AS [Page Allocated]                      /*Applies to: SQL Server 2012 (11.x) and later.*/
FROM
sys.dm_os_memory_clerks
GROUP BY TYPE
```

## Buffer pool details

You can obtain detailed information about buffer pool buffers for database pages by using the `sys.dm_os_buffer_descriptors` DMV. And you can obtain detailed information about buffer pool pages that are being used for miscellaneous server purposes by using the `sys.dm_os_memory_clerks` DMV.

The next table lists details about the buffer pool plus additional information.

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

- Database: This value shows the number of buffers that have database content (data and index pages).
- Target: This value shows the target size of the buffer pool (buffer count).
- Dirty: This value shows the buffers that have database content and that have been modified. These buffers contain changes that must be flushed to disk.
- In IO: This value shows the buffers that are waiting for a pending I/O operation.
- Latched: This value shows the latched buffers. A buffer is latched when a thread is reading or modifying the contents of a page. A buffer is also latched when the page is being read from disk or written to disk. A latch is used to maintain the physical consistency of the data on the page while it's being read or modified. A lock is used to maintain logical and transactional consistency.
- IO error: This value shows the count of buffers that may have encountered any I/O-related OS errors (this doesn't necessarily indicate a problem).
- Page Life Expectancy: This counter measures the amount of time in seconds that the oldest page stays in the buffer pool.

## Procedure cache

The next table describes the makeup of the procedure cache.

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

- TotalPages: This value shows the cumulative pages that you must have to store all the cached objects in the procedure cache.
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
- SETLS: This value shows the memory that is used to allocate the Storage Engine-specific per-thread structure that uses thread local storage.
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

For more information about the elements in this output, see:

- Grants: This value shows the running queries that have memory grants.
- Waiting: This value shows the queries that are waiting to obtain memory grants.
- Available: This value shows the buffers that are available to queries for use as hash workspace and as sort workspace. The Available value is updated periodically.
- Next Request: This value shows the memory request size, in buffers, for the next waiting query.
- Waiting For: This value shows the amount of memory that must be available to run the query to which the Next Request value refers. The Waiting For value is the Next Request value multiplied by a headroom factor. This value effectively guarantees that a specific amount of memory will be available when the next waiting query is run.
- Cost: This value shows the cost of the next waiting query.
- Timeout: This value shows the time-out, in seconds, for the next waiting query.
- Wait Time: This value shows the elapsed time, in milliseconds, since the next waiting query was put in the queue.
- Current Max: This value shows the overall memory limit for query execution. This value is the combined limit for both the large query queue and the small query queue.

## Optimization

The next table is a summary for the users who are trying to optimize queries at the same time.

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
