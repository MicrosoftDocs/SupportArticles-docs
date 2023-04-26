---
title: Use DBCC MEMORYSTATUS to monitor memory usage
description: This article describes how to use the DBCC MEMORYSTATUS command to monitor memory usage.
ms.date: 11/09/2020
ms.custom: sap:Performance
ms.reviewer: BorisB, Borisb, Bobward
ms.topic: how-to
ms.prod: sql
---
# Use the DBCC MEMORYSTATUS command to monitor memory usage on SQL Server

This article describes how to use the `DBCC MEMORYSTATUS` command to monitor memory usage.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 907877

## Summary

This article discusses the output of the `DBCC MEMORYSTATUS` command. This command is frequently used to troubleshoot Microsoft SQL Server memory consumption issues.

This article describes the elements of the output for Memory Manager, the summary of memory usage, the aggregate memory information, the buffer distribution information, the buffer pool information, and the procedure cache information. It also describes the output about global memory objects, query memory objects, optimization, and memory brokers.

## Introduction

The `DBCC MEMORYSTATUS` command provides a snapshot of the current memory status of SQL Server. You can use the output from this command to troubleshoot memory consumption issues in SQL Server or to troubleshoot specific out of memory errors. (Many out of memory errors automatically print this output in the error log.) You may run this command and provide the output when you contact Microsoft Support for an error that may be associated with a low-memory condition.

> [!NOTE]
> Performance Monitor (PerfMon) and Task Manager don't account for memory correctly if Address Windowing Extentions (AWE) support is enabled.

This article describes some of the data that you can obtain from the output of the `DBCC MEMORYSTATUS` command. Several sections of this article include proprietary implementation details that aren't explained here. Microsoft Customer Support Services won't answer any questions or provide more information about the meaning of specific counters beyond the information that is supplied in this article.

## More information

> [!IMPORTANT]
> The `DBCC MEMORYSTATUS` command is intended to be a diagnostic tool for Microsoft Customer Support Services. The format of the output and the level of detail that is provided are subject to change between service packs and product releases. The functionality that the `DBCC MEMORYSTATUS` command provides may be replaced by a different mechanism in later product versions. Therefore, in later product versions, this command may no longer function. No additional warnings will be made before this command is changed or removed. Therefore, applications that use this command may break without warning.

The output of the `DBCC MEMORYSTATUS` command has changed from earlier releases of SQL Server. Now, it contains several sections that were unavailable in earlier product versions.

## Process/System Counts

The first section of the output is `Process/System Counts`.

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

## Memory Manager

This `Memory Manager` section shows overall memory consumption by SQL Server.

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

The elements in this section are the following:

- VM Reserved: This value shows the overall amount of virtual address space (VAS) that SQL Server has reserved.
- VM Committed: This value shows the overall amount of VAS that SQL Server has committed. VAS that is committed has been associated with physical memory.
- AWE Allocated: This value shows the overall amount of memory that is allocated through the AWE mechanism on the 32-bit version of SQL Server. Or, this value shows the overall amount of memory that locked pages consume on the 64-bit version of the product.
- Reserved Memory: This value shows the memory that is reserved for the dedicated administrator connection (DAC).
- Reserved Memory In Use: This value shows the reserved memory that is being used.

## Summary of memory usage

The Memory Manager section is followed by a summary of memory usage for each memory node. In a non-uniform memory access (NUMA) enabled system, there's a corresponding Memory node entry for each hardware NUMA node. In an SMP system, there's a single Memory node entry.

> [!NOTE]
> The `memory node ID` may not correspond to the hardware node ID.

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
> These values show the memory that is allocated by threads that are running on this NUMA node. These values are not the memory that is local to the NUMA node.

The elements in this section are the following:

- VM Reserved: This value shows the VAS that is reserved by threads that are running on this node.

- VM Committed: This value shows the VAS that is committed by threads that are running on this node.

- AWE Allocated: This value shows the memory that is allocated through the AWE mechanism on the 32-bit version of the product. Or, this value shows the overall amount of memory that is consumed by locked pages on the 64-bit version of the product.

  In a NUMA-enabled system, this value can be incorrect or negative. However, the overall AWE Allocated value in the Memory Manager section is a correct value. To track memory that is allocated by individual NUMA nodes, use SQL Server: Buffer Node performance objects. (For more information, see SQL Server Books Online.)

- MultiPage Allocator: This value shows the memory that is allocated through the multipage allocator by threads that are running on this node. This memory comes from outside the buffer pool.

- SinglePage Allocator: This value shows the memory that is allocated through the single-page allocator by threads that are running on this node. This memory is stolen from the buffer pool.

> [!NOTE]
> The sums of the VM Reserved values and the VM Committed values on all memory nodes will be slightly less than the corresponding values that are reported in the Memory Manager section.

## Aggregate memory

The next section contains aggregate memory information for each clerk type and for each NUMA node. For a NUMA-enabled system, you may see output that is similar to the following.

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

(7 row(s) affected)

MEMORYCLERK_SQLGENERAL (node 1) KB
---------------------------------------------------------------- --------------------
VM Reserved                     0
VM Committed                    0
AWE Allocated                   0
SM Reserved                     0
SM Commited                     0
SinglePage Allocator            136
MultiPage Allocator             0

(7 row(s) affected)

MEMORYCLERK_SQLGENERAL (Total)  KB
---------------------------------------------------------------- --------------------
VM Reserved                     0
VM Committed                    0
AWE Allocated                   0
SM Reserved                     0
SM Commited                     0
SinglePage Allocator            728
MultiPage Allocator             2160

(7 row(s) affected)
```

> [!NOTE]
> These node IDs correspond to the NUMA node configuration of the computer that is running SQL Server. The node IDs include possible software NUMA nodes that are defined on top of hardware NUMA nodes or on top of an SMP system. To find mapping between node IDs and CPUs for each node, view Information event ID number 17152. This event is logged in the Application log in Event Viewer when you start SQL Server.

For an SMP system, you see only one section for each clerk type. This section is similar to the following.

```output
MEMORYCLERK_SQLGENERAL (Total)     KB
---------------------------------------------------------------- --------------------
VM Reserved                        0
VM Committed                       0
AWE Allocated                      0
SM Reserved                        0
SM Commited                        0
SinglePage Allocator               768
MultiPage Allocator                2160

(7 row(s) affected)
```

Other information in these sections is about shared memory:

- SM Reserved: This value shows the VAS that is reserved by all clerks of this kind that are using the memory-mapped files API. This API is also known as *shared memory*.

- SM Committed: This value shows the VAS that is committed by all clerks of this kind that are using memory-mapped files API.

You can obtain summary information for each clerk type for all memory nodes by using the sys.`dm_os_memory_clerks` dynamic management view (DMV). To do this, run the following query:

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

### Buffer distribution

The next section shows the distribution of 8 kilobyte (KB) buffers in the buffer pool.

```output
Buffer Distribution    Buffers
------------------------------ -----------
Stolen                 553
Free                   103
Cached                 161
Database (clean)       1353
Database (dirty)       38
I/O                    0
Latched                0

(7 row(s) affected)
```

```output
Buffer Pool                         Pages
----------------------------------------------
Database                            5404
Simulated                           0
Target                              16384000
Dirty                               298
In IO                               0
Latched                             0
IO error                            125
In Internal Pool                    0
Page Life Expectancy                3965

Buffer Pool Current Clock Status    Count
----------------------------------------------
Never Used                          0
Stolen or Free                      0
Above Cutoff (HOT)                  0
Not on LRU                          0
Single Use                          0
Long IO Queue                       0
In IO                               0
In Allocation                       0
Preemptive                          0
Skip Pool                           0
Moved to L2                         0
Evicted                             0
Evicted Mapped                      0

Buffer Pool Previous Clock Status   Count
----------------------------------------------
Never Used                          0
Stolen or Free                      0
Above Cutoff (HOT)                  0
Not on LRU                          0
Single Use                          0
Long IO Queue                       0
In IO                               0
In Allocation                       0
Preemptive                          0
Skip Pool                           0
Moved to L2                         0
Evicted                             0
Evicted Mapped                      0
```

The elements in this section are the following:

- Stolen: Stolen memory describes 8-KB buffers that the server uses for miscellaneous purposes. These buffers serve as generic memory store allocations. Different components of the server use these buffers to store internal data structures. The lazywriter process isn't permitted to flush Stolen buffers out of the buffer pool.
- Free: This value shows committed buffers that aren't currently being used. These buffers are available for holding data. Or, other components may request these buffers and then mark these buffers as Stolen.
- Cached: This value shows the buffers that are used for various caches.
- Database (clean): This value shows the buffers that have database content and that haven't been modified.
- Database (dirty): This value shows the buffers that have database content and that have been modified. These buffers contain changes that must be flushed to disk.
- I/O: This value shows the buffers that are waiting for a pending I/O operation.

- Latched: This value shows the *latched* buffers. A buffer is latched when a thread is reading or modifying the contents of a page. A buffer is also latched when the page is being read from disk or written to disk. A latch is used to maintain physical consistency of the data in the page while it's being read or modified. A lock is used to maintain logical and transactional consistency.

## Buffer pool details

You can obtain detailed information about buffer pool buffers for database pages by using the `sys.dm_os_buffer_descriptors` DMV. And you can obtain detailed information about buffer pool pages that are being used for miscellaneous server purposes by using the `sys.dm_os_memory_clerks` DMV.

The next section lists details about the buffer pool plus additional information.

```console
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

Buffer Pool Current Clock Status                  Count
-------------------------------------------------------
Never Used                                        0
Stolen or Free                                    0
Above Cutoff (HOT)                                0
Not on LRU                                        0
Single Use                                        0
Long IO Queue                                     0
In IO                                             0
In Allocation                                     0
Preemptive                                        0
Skip Pool                                         0
Moved to L2                                       0
Evicted                                           0
Evicted Mapped                                    0

Buffer Pool Previous Clock Status                 Count
-------------------------------------------------------
Never Used                                        0
Stolen or Free                                    0
Above Cutoff (HOT)                                0
Not on LRU                                        0
Single Use                                        0
Long IO Queue                                     0
In IO                                             0
In Allocation                                     0
Preemptive                                        0
Skip Pool                                         0
Moved to L2                                       0
Evicted                                           0
Evicted Mapped                                    0
```

The elements in this section are the following:

- Committed: This value shows the total buffers that are committed. Buffers that are committed have physical memory associated with them. The Committed value is the current size of the buffer pool. This value includes the physical memory that is allocated if AWE support is enabled.
- Target: This value shows the target size of the buffer pool. If the Target value is larger than the Committed value, the buffer pool is growing. If the Target value is less than the Committed value, the buffer pool is shrinking.
- Hashed: This value shows the data pages and index pages that are stored in the buffer pool.
- Stolen Potential: This value shows the maximum pages that can be stolen from the buffer pool.
- ExternalReservation: This value shows the pages that have been reserved for queries that perform a sort operation or a hash operation. These pages haven't yet been stolen.
- Min Free: This value shows the pages that the buffer pool tries to have on the free list.
- Visible: This value shows the buffers that are concurrently visible. These buffers can be directly accessed at the same time. This value is equal to the total buffers. However, when AWE support is enabled, this value may be less than the total buffers.
- Available Paging File: This value shows the memory that is available to be committed. This value is expressed as the number of 8-KB buffers. For more information, see [GlobalMemoryStatusEx function](/windows/win32/api/sysinfoapi/nf-sysinfoapi-globalmemorystatusex).

## Procedure cache

The next section describes the makeup of the procedure cache.

```output
Procedure Cache         Value
------------------------------ -----------
TotalProcs              4
TotalPages              25
InUsePages              0

(3 row(s) affected)
```

The elements in this section are the following:

- TotalProcs: This value shows the total cached objects that are currently in the procedure cache. This value matches the entries in the `sys.dm_exec_cached_plans` DMV.

  > [!NOTE]
  > Because of the dynamic nature of this information, the match may not be exact. You can use PerfMon to monitor the SQL Server: Plan Cache object and the `sys.dm_exec_cached_plans` DMV for detailed information about the type of cached objects, such as triggers, procedures, and ad hoc objects.

- TotalPages: This value shows the cumulative pages that you must have to store all the cached objects in the procedure cache.
- InUsePages: This value shows the pages in the procedure cache that belong to procedures that are currently running. These pages can't be discarded.

## Global memory objects

The next section contains information about various global memory objects. This section also contains information about how much memory the global memory objects use.

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

The elements in this section are the following:

- Resource: This value shows the memory that the Resource object uses. The Resource object is used by the storage engine and for various server-wide structures.
- Locks: This value shows the memory that Lock Manager uses.
- XDES: This value shows the memory that Transaction Manager uses.
- SETLS: This value shows the memory that is used to allocate the Storage Engine-specific per-thread structure that uses thread local storage.
- SE Dataset Allocators: This value shows the memory that is used to allocate structures for table access through the **Access Methods** setting.
- SubpDesc Allocators: This value shows the memory that is used for managing subprocesses for parallel queries, backup operations, restore operations, database operations, file operations, mirroring, and asynchronous cursors. These subprocesses are also known as *parallel processes*.
- SE SchemaManager: This value shows the memory that Schema Manager uses to store Storage Engine-specific metadata.
- SQLCache: This value shows the memory that is used to store the text of ad hoc statements and of prepared statements.
- Replication: This value shows the memory that the server uses for internal replication subsystems.
- ServerGlobal: This value shows the global server memory object that is used generically by several subsystems.
- XP Global: This value shows the memory that extended stored procedures use.
- Sort Tables: This value shows the memory that sort tables use.

## Query memory objects

The next section describes Query Memory grant information. This section includes a snapshot of the query memory usage. Query memory is also known as *workspace memory*.

```output
Query Memory Objects (Internal)           Value
------------------------------------------------
Grants                                    0
Waiting                                   0
Available                                 384950
Current Max                               384950
Future Max                                384950
Physical Max                              439010
Next Request                              0
Waiting For                               0
Cost                                      0
Timeout                                   0
Wait Time                                 0

Small Query Memory Objects (Internal)     Value
----------------------------------------------------
Grants                                    0
Waiting                                   0
Available                                 20260
Current Max                               20260
Future Max                                20260

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

Small Query Memory Objects (default)     Value
----------------------------------------------------
Grants                                    0
Waiting                                   0
Available                                 22963
Current Max                               22963
Future Max                                22963
```

If the size and the cost of a query satisfy "small" query memory thresholds, the query is put in a small query queue. This behavior prevents smaller queries from being delayed behind larger queries that are already in the queue.

The elements in this section are the following:

- Grants: This value shows the running queries that have memory grants.
- Waiting: This value shows the queries that are waiting to obtain memory grants.
- Available: This value shows the buffers that are available to queries for use as hash workspace and as sort workspace. The Available value is updated periodically.
- Maximum: This value shows the total buffers that can be given to all queries for use as workspace.
- Limit: This value shows the query execution target for the large query queue. This value differs from the Maximum (Buffers) value because the Maximum (Buffers) value isn't updated until there's change in the queue.
- Next Request: This value shows the memory request size, in buffers, for the next waiting query.
- Waiting For: This value shows the amount of memory that must be available to run the query to which the Next Request value refers. The Waiting For value is the Next Request value multiplied by a headroom factor. This value effectively guarantees that a specific amount of memory will be available when the next waiting query is run.
- Cost: This value shows the cost of the next waiting query.
- Timeout: This value shows the time-out, in seconds, for the next waiting query.
- Wait Time: This value shows the elapsed time, in milliseconds, since the next waiting query was put in the queue.
- Last Target: This value shows the overall memory limit for query execution. This value is the combined limit for both the large query queue and the small query queue.

## Optimization

The next section is a summary of the users who are trying to optimize queries at the same time.

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

Queries are submitted to the server for compilation. The compilation process includes parsing, algebraization, and optimization. Queries are classified based on the amount of memory that each query consumes during the compilation process.

> [!NOTE]
> This amount does not include the memory that is required to run the query.

When a query starts, there's no limit on how many queries can be compiled. As the memory consumption increases and reaches a threshold, the query must pass a gateway to continue. There's a progressively decreasing limit of simultaneously compiled queries after each gateway. The size of each gateway depends on the platform and the load. Gateway sizes are chosen to maximize scalability and throughput.

If the query can't pass a gateway, the query waits until memory is available. Or, the query returns a time-out error (Error 8628). Additionally, the query may not acquire a gateway if the user cancels the query or if a deadlock is detected. If a query passes several gateways, the query doesn't release the smaller gateways until the compilation process has completed.

This behavior lets only a few memory-intensive compilations occur at the same time. Additionally, this behavior maximizes throughput for smaller queries.

## Memory brokers

The following tables show information about memory brokers that control cached memory, stolen memory, and reserved memory. Information that these sections provide can only be used for internal diagnostics. Therefore, this information isn't detailed here.

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
