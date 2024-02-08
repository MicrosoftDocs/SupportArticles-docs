---
title: Troubleshoot slow performance or low memory issues caused by memory grants
description: Provides troubleshooting steps to identify and reduce memory grant memory consumption in SQL Server.
author: pijocoder
ms.author: jopilov
ms.reviewer: pijocoder
ms.date: 05/05/2023
ms.custom: sap:Performance
---

# Troubleshoot slow performance or low memory issues caused by memory grants in SQL Server

## What are memory grants?

Memory grants, also referred to as Query Execution (QE) Reservations, Query Execution Memory, Workspace Memory, and Memory Reservations, describe the usage of memory at query execution time. SQL Server allocates this memory during query execution for one or more of the following purposes:

- Sort operations
- Hash operations
- Bulk copy operations (not a common issue)
- Index creation, including inserting into COLUMNSTORE indexes because hash dictionaries/tables are used at runtime for index building (not a common issue)

To provide some context, during its lifetime, a query may request memory from different memory allocators or clerks depending on what it needs to do. For example, when a query is parsed and compiled initially, it consumes compilation memory. Once the query is compiled, that memory is released, and the resulting query plan is stored in the plan cache memory. Once a plan is cached, the query is ready for execution. If the query does any sort operations, hash match operations (JOIN or aggregates), or insertions into a COLUMNSTORE indexes, it uses memory from query execution allocator. Initially, the query asks for that execution memory, and later if this memory is granted, the query uses all or part of the memory for sort results or hash buckets. This memory allocated during query execution is what is referred to as memory grants. As you can imagine, once the query execution operation completes, the memory grant is released back to SQL Server to use for other work. Therefore, memory grant allocations are temporary in nature but can still last a long time. For example, if a query execution performs a sort operation on a very large rowset in memory, the sort may take many seconds or minutes, and the granted memory is used for the lifetime of the query.

### Example of a query with a memory grant

Here's an example of a query that uses execution memory and its query plan showing the grant:

```sql
SELECT * 
FROM sys.messages
ORDER BY message_id
```

This query selects a rowset of over 300,000 rows and sorts it. The sort operation induces a memory grant request. If you run this query in SSMS, you can view its query plan. When you select the left-most `SELECT` operator of the query plan, you can view the memory grant information for the query (press <kbd>F4</kbd> to show **Properties**):

:::image type="content" source="media/troubleshoot-memory-grants/simple-memory-grant-query-example.png" alt-text="Screenshot of a query with a memory grant and query plan." lightbox="media/troubleshoot-memory-grants/simple-memory-grant-query-example.png":::

Also, if you right-click in the white space in the query plan, you can choose **Show Execution Plan XML...** and locate an XML element that shows the same memory grant information.

```xml
 <MemoryGrantInfo SerialRequiredMemory="512" SerialDesiredMemory="41232" RequiredMemory="5248" DesiredMemory="46016" RequestedMemory="46016" GrantWaitTime="0" GrantedMemory="46016" MaxUsedMemory="45816" MaxQueryMemory="277688" LastRequestedMemory="0" IsMemoryGrantFeedbackAdjusted="No: First Execution" />
```

Several terms need explanation here. A query may desire a certain amount of execution memory (**DesiredMemory**) and would commonly request that amount (**RequestedMemory**). At runtime, SQL Server grants all or part of the requested memory depending on availability (**GrantedMemory**). In the end, the query may use more or less of the initially requested memory (**MaxUsedMemory**). If the query optimizer has overestimated the amount of memory needed, it uses less than the requested size. But that memory is wasted as it could have been used by another request. On the other hand, if the optimizer has underestimated the size of memory needed, the excess rows may be spilled to disk to get the work done at execution time. Instead of allocating more memory than the initially requested size, SQL Server pushes the extra rows over to disk and uses it as a temporary workspace. For more information, see Workfiles and Worktables in [Memory Grant Considerations](/sql/relational-databases/memory-management-architecture-guide#memory-grant-considerations).

### Terminology

Let's review the different terms you may encounter regarding this memory consumer. Again, all these describe concepts that relate to the same memory allocations.

- **Query Execution Memory (QE Memory):**  This term is used to highlight the fact that sort or hash memory is used during the execution of a query. Commonly QE memory is the largest consumer of memory during the life of a query.

- **Query Execution (QE) Reservations or Memory Reservations:** When a query needs memory for sort or hash operations, it makes a reservation request for memory. That reservation request is calculated at compile time based on estimated cardinality. Later, when the query executes, SQL Server grants that request partially or fully depending on memory availability. In the end, the query may use a percentage of the granted memory. There's a memory clerk (accountant of memory) named 'MEMORYCLERK_SQLQERESERVATIONS' that keeps track of these memory allocations (check out [DBCC MEMORYSTATUS](dbcc-memorystatus-monitor-memory-usage.md) or [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql)).

- **Memory Grants:** When SQL Server grants the requested memory to an executing query, it's said that a memory grant has occurred. There are a few performance counters that use the term "grant." These counters, `Memory Grants Outstanding` and `Memory Grants Pending`, display the count of memory grants satisfied or waiting. They don't account for the memory grant size. One query alone could have consumed, for example, 4 GB of memory to perform a sort, but that isn't reflected in either of these counters.

- **Workspace Memory** is another term that describes the same memory. Often, you may see this term in the Perfmon counter `Granted Workspace Memory (KB)`, which reflects the overall amount of memory currently used for sort, hash, bulk copy, and index creation operations, expressed in KB. The `Maximum Workspace Memory (KB)`, another counter, accounts for the maximum amount of workspace memory available for any requests that may need to do such hash, sort, bulk copy, and index creation operations. The term Workspace Memory is encountered infrequently outside of these two counters.

## Performance impact of large QE memory utilization

In most cases, when a thread requests memory inside SQL Server to get something done and the memory isn't available, the request fails with an out of memory error. However, there are a couple of exception scenarios where the thread doesn't fail but waits until memory does become available. One of those scenarios is memory grants, and the other is query compilation memory. SQL Server uses a thread synchronization object called a [semaphore](/windows/win32/sync/semaphore-objects) to keep track of how much memory has been granted for query execution. If SQL Server runs out of the predefined QE workspace, instead of failing the query with an out of memory error, it causes the query to wait. Given that workspace memory is allowed to take a significant percentage of overall SQL Server memory, waiting on memory in this space has serious performance implications. A large number of concurrent queries have requested execution memory, and together, they've exhausted the QE memory pool, or a few concurrent queries have each requested very large grants. Either way, the resulting performance issues may have the following symptoms:

- Data and index pages from a buffer cache have likely been flushed out to make space for the large memory grant requests. This means that page reads coming from query requests have to be satisfied from disk (a significantly slower operation).
- Requests for other memory allocations may fail with out of memory errors because the resource is tied up with sort, hash, or index-building operations.
- Requests that need execution memory are waiting for the resource to become available and are taking a long time to complete. In other words, to the end user, these queries are slow.

Therefore, if you observe waits on query execution memory in Perfmon, dynamic management views (DMVs), or `DBCC MEMORYSTATUS`, you must act to resolve this issue, particularly if the issue occurs frequently. For more information, see [What can a developer do about sort and hash operations](#what-can-a-developer-do-about-sort-and-hash-operations).

## How to identify waits for query execution memory

There are multiple ways to determine waits for QE reservations. Pick the ones that serve you best to see the larger picture at the server level. Some of these tools may not be available to you (for example, Perfmon isn't available in Azure SQL Database). Once you identify the issue, you must drill down at the individual query level to see which queries need tuning or rewrites.

- At the server level, use the following methods:

  - [Resource semaphore DMV sys.dm_exec_query_resource_semaphores](#resource-semaphore-dmv-sysdm_exec_query_resource_semaphores) For more information, see [sys.dm_exec_query_resource_semaphores](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-resource-semaphores-transact-sql).
  - [Performance Monitor counters](#performance-monitor-counters) For more information, see [SQL Server Memory Manager object](/sql/relational-databases/performance-monitor/sql-server-memory-manager-object).
  - [DBCC MEMORYSTATUS](#dbcc-memorystatus) For more information, see [DBCC MEMORYSTATUS](dbcc-memorystatus-monitor-memory-usage.md).
  - [Memory clerks DMV sys.dm_os_memory_clerks](#memory-clerks-dmv-sysdm_os_memory_clerks) For more information, see [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql).
  - [Identify memory grants using Extended Events (XEvents)](#identify-memory-grants-using-extended-events-xevents) For more information, see [Extended Events (XEvents)](/sql/relational-databases/extended-events/extended-events).

- At the individual query level, use the following methods:

  - [Identify specific queries with sys.dm_exec_query_memory_grants](#identify-specific-queries-with-sysdm_exec_query_memory_grants): Currently executing queries. For more information, see [sys.dm_exec_query_memory_grants](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-memory-grants-transact-sql).
  - [Identify specific queries with sys.dm_exec_requests](#identify-specific-queries-with-sysdm_exec_requests): Currently executing queries. For more information, see [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql).
  - [Identify specific queries with sys.dm_exec_query_stats](#identify-specific-queries-with-sysdm_exec_query_stats): Historical statistics on queries. For more information, see [sys.dm_exec_query_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql).
  - [Identify specific queries using Query Store (QDS) with sys.query_store_runtime_stats](#identify-specific-queries-using-query-store-qds-with-sysquery_store_runtime_stats): Historical statistics on queries with QDS. For more information, see [sys.query_store_runtime_stats](/sql/relational-databases/system-catalog-views/sys-query-store-runtime-stats-transact-sql).

### Aggregate memory usage statistics

#### Resource semaphore DMV sys.dm_exec_query_resource_semaphores

This DMV breaks down the query reservation memory by resource pool (internal, default, and user-created) and `resource_semaphore` (regular and small query requests). A useful query may be:

```sql
SELECT 
  pool_id
  ,total_memory_kb
  ,available_memory_kb
  ,granted_memory_kb
  ,used_memory_kb
  ,grantee_count, waiter_count 
  ,resource_semaphore_id
FROM sys.dm_exec_query_resource_semaphores rs
```

The following sample output shows that around 900 MB of query execution memory is used by 22 requests, and 3 more are waiting. This takes place in the default pool (`pool_id` = 2) and the regular query semaphore (`resource_semaphore_id` = 0).

```output
pool_id total_memory_kb available_memory_kb granted_memory_kb used_memory_kb grantee_count waiter_count resource_semaphore_id
------- --------------- ------------------- ----------------- -------------- ------------- ------------ ---------------------
1       30880           30880               0                 0              0             0            0
1       5120            5120                0                 0              0             0            1
2       907104          0                   907104            898656         22            3            0
2       40960           40960               0                 0              0             0            1

(4 rows affected)
```

#### Performance Monitor counters

Similar information is available via Performance Monitor counters, where you can observe the currently granted requests (`Memory Grants Outstanding`), the waiting grant requests (`Memory Grants Pending`), and the amount of memory used by memory grants (`Granted Workspace Memory (KB)`). In the following picture, the outstanding grants are 18, the pending grants are 2, and the granted workspace memory is 828,288 KB. The `Memory Grants Pending` Perfmon counter with a nonzero value indicates that memory has been exhausted.

:::image type="content" source="media/troubleshoot-memory-grants/memory-grants-performance-monitor.png" alt-text="Screenshot of memory grants waiting and satisfied." lightbox="media/troubleshoot-memory-grants/memory-grants-performance-monitor.png":::

For more information, see [SQL Server Memory Manager object](/sql/relational-databases/performance-monitor/sql-server-memory-manager-object).

- **SQLServer, Memory Manager:  Maximum Workspace Memory (KB)**
- **SQLServer, Memory Manager:  Memory Grants Outstanding**
- **SQLServer, Memory Manager:  Memory Grants Pending**
- **SQLServer, Memory Manager:  Granted Workspace Memory (KB)**

#### DBCC MEMORYSTATUS

Another place where you can see details on query reservation memory is `DBCC MEMORYSTATUS` ([Query Memory Objects section](dbcc-memorystatus-monitor-memory-usage.md#query-memory-objects)). You can look at the `Query Memory Objects (default)` output for user queries. If you have enabled Resource Governor with a resource pool named *PoolAdmin*, for example, you can look at both `Query Memory Objects (default)` and `Query Memory Objects (PoolAdmin)`.

Here's a sample output from a system where 18 requests have been granted query execution memory, and 2 requests are waiting for memory. The available counter is zero, which indicates there's no more workspace memory available. This fact explains the two waiting requests. The `Wait Time` shows the elapsed time in milliseconds since a request was put in the wait queue. For more information on these counters, see [Query memory objects](dbcc-memorystatus-monitor-memory-usage.md#query-memory-objects).

```output
Query Memory Objects (default)                                           Value
------------------------------------------------------------------------ -----------
Grants                                                                   18
Waiting                                                                  2
Available                                                                0
Current Max                                                              103536
Future Max                                                               97527
Physical Max                                                             139137
Next Request                                                             5752
Waiting For                                                              8628
Cost                                                                     16
Timeout                                                                  401
Wait Time                                                                2750

(11 rows affected)

Small Query Memory Objects (default)                                     Value
------------------------------------------------------------------------ -----------
Grants                                                                   0
Waiting                                                                  0
Available                                                                5133
Current Max                                                              5133
Future Max                                                               5133
```

`DBCC MEMORYSTATUS` also displays information about the memory clerk that keeps track of query execution memory. The following output shows that the pages allocated for query execution (QE) reservations exceed 800 MB.

```output
MEMORYCLERK_SQLQERESERVATIONS (node 0)                                   KB
------------------------------------------------------------------------ -----------
VM Reserved                                                              0
VM Committed                                                             0
Locked Pages Allocated                                                   0
SM Reserved                                                              0
SM Committed                                                             0
Pages Allocated                                                          824640
```

#### Memory clerks DMV sys.dm_os_memory_clerks

If you need more of a tabular result set, different from the section-based `DBCC MEMORYSTATUS`, then you can use [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) for similar information. Look for the `MEMORYCLERK_SQLQERESERVATIONS` memory clerk. The Query Memory Objects are not available in this DMV, however.

```sql
SELECT type, memory_node_id, pages_kb 
FROM sys.dm_os_memory_clerks
WHERE type = 'MEMORYCLERK_SQLQERESERVATIONS'
```

Here's a sample output:

```output
type                                            memory_node_id pages_kb
----------------------------------------------- -------------- --------------
MEMORYCLERK_SQLQERESERVATIONS                   0              824640
MEMORYCLERK_SQLQERESERVATIONS                   64             0
```

#### Identify memory grants using Extended Events (XEvents)

There are multiple extended events that provide memory grant information and enable you to capture this information via a trace:

- **sqlserver.additional_memory_grant**: Occurs when a query tries to get more memory grant during execution. Failure to get this additional memory grant may cause the query slowdown.
- **sqlserver.query_memory_grant_blocking**: Occurs when a query is blocking other queries while waiting for a memory grant.
- **sqlserver.query_memory_grant_info_sampling**: Occurs at the end of the randomly sampled queries providing memory grant information (it can be used, for example, for telemetry).
- **sqlserver.query_memory_grant_resource_semaphores**: Occurs at five-minute intervals for each resource governor resource pool.
- **sqlserver.query_memory_grant_usage**: Occurs at the end of query processing for queries with memory grants over 5 MB to let users know about memory grant inaccuracies.
- **sqlserver.query_memory_grants**: Occurs at five-minute intervals for each query with a memory grant.

##### Memory grant feedback extended events

For information on query processing memory grant feedback features, see [Memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-feedback#memory-grant-feedback).

- **sqlserver.memory_grant_feedback_loop_disabled**: Occurs when memory grant feedback loop is disabled.
- **sqlserver.memory_grant_updated_by_feedback**: Occurs when memory grant is updated by feedback.

##### Query execution warnings that relate to memory grants

- **sqlserver.execution_warning**: Occurs when a T-SQL statement or stored procedure waits more than one second for a memory grant or when the initial attempt to get memory fails. Use this event in combination with events that identify waits to troubleshoot contention issues that impact performance.
- **sqlserver.hash_spill_details**: Occurs at the end of hash processing if there's insufficient memory to process the build input of a hash join. Use this event together with any of the `query_pre_execution_showplan` or `query_post_execution_showplan` events to determine which operation in the generated plan is causing the hash spill.
- **sqlserver.hash_warning**: Occurs when there's insufficient memory to process the build input of a hash join. This results in either a hash recursion when the build input is partitioned or a hash bailout when the partitioning of the build input exceeds the maximum recursion level. Use this event together with any of the `query_pre_execution_showplan` or `query_post_execution_showplan` events to determine which operation in the generated plan is causing the hash warning.
- **sqlserver.sort_warning**: Occurs when the sort operation on an executing query doesn't fit into memory. This event isn't generated for sort operations caused by index creation, only for sort operations in a query. (For example, an `Order By` in a `Select` statement.) Use this event to identify queries that perform slowly because of the sort operation, particularly when the `warning_type` = 2, indicating multiple passes over the data were required to sort.

##### Plan generating events that contain memory grant information

The following query plan generating extended events contain **granted_memory_kb** and **ideal_memory_kb** fields by default:

- **sqlserver.query_plan_profile**
- **sqlserver.query_post_execution_plan_profile**
- **sqlserver.query_post_execution_showplan**
- **sqlserver.query_pre_execution_showplan**

##### Column store index building

One of the areas covered via XEvents is the execution memory used during column store building. This is a list of events available:

- **sqlserver.column_store_index_build_low_memory**: Storage Engine detected a low memory condition, and the rowgroup size was reduced. There are several columns of interest here.
- **sqlserver.column_store_index_build_memory_trace**: Trace memory usage during the index build.
- **sqlserver.column_store_index_build_memory_usage_scale_down**: Storage Engine scaled down.
- **sqlserver.column_store_index_memory_estimation**: Shows the memory estimation result during the COLUMNSTORE rowgroup build.

### Identify specific queries

There are two kinds of queries that you may find when looking at the individual request level. The queries that are consuming a large amount of query execution memory and those that are waiting for the same memory. The latter group may consist of requests with modest needs for memory grants, and if so, you may focus your attention elsewhere. But they could also be the culprits if they're requesting huge memory sizes. Focus on them if you find that to be the case. It may be common to find that one particular query is the offender, but many instances of it are spawned. Those instances that get the memory grants are causing other instances of the same query to wait for the grant. Regardless of specific circumstances, ultimately, you must identify the queries and the size of the requested execution memory.

#### Identify specific queries with sys.dm_exec_query_memory_grants

To view individual requests and the memory size they've requested and have been granted, you can query the `sys.dm_exec_query_memory_grants` dynamic management view. This DMV shows information about currently executing queries, not historical information.

The following statement gets data from the DMV and also fetches the query text and the query plan as a result:

```sql
SELECT 
  session_id
  ,requested_memory_kb
  ,granted_memory_kb
  ,used_memory_kb
  ,queue_id
  ,wait_order
  ,wait_time_ms
  ,is_next_candidate
  ,pool_id
  ,text
  ,query_plan
FROM sys.dm_exec_query_memory_grants
  CROSS APPLY sys.dm_exec_sql_text(sql_handle)
  CROSS APPLY sys.dm_exec_query_plan(plan_handle)
```

Here's an abbreviated sample output of the query during active QE memory consumption. Most queries have their memory granted, as shown by `granted_memory_kb` and `used_memory_kb` being non-NULL numeric values. The queries that didn't get their request granted are waiting for execution memory, and the `granted_memory_kb` = `NULL`. Also, they're placed in a wait queue with a `queue_id` = 6. Their `wait_time_ms` indicates about 37 seconds of waiting. Session 72 is next in line to get a grant as indicated by `wait_order` = 1, while session 74 comes after it with `wait_order` = 2.

```output
session_id requested_memory_kb  granted_memory_kb    used_memory_kb       queue_id wait_order  wait_time_ms         is_next_candidate pool_id
---------- -------------------- -------------------- -------------------- -------- ----------- -------------------- ----------------- -------
80         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
83         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
84         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
74         41232                NULL                 NULL                 6        2           37438                0                 2      
78         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
81         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
71         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
75         41232                NULL                 NULL                 6        0           37438                1                 2      
82         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
76         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
79         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
85         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
70         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
55         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
59         41232                NULL                 NULL                 6        3           37438                0                 2      
62         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
54         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
77         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
52         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
72         41232                NULL                 NULL                 6        1           37438                0                 2      
69         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
73         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
66         41232                NULL                 NULL                 6        4           37438                0                 2      
68         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
63         41232                41232                40848                NULL     NULL        NULL                 NULL              2      
```

#### Identify specific queries with sys.dm_exec_requests

There's a [wait type](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes) in SQL Server that indicates a query is waiting for memory grant `RESOURCE_SEMAPHORE`. You may observe this wait type in `sys.dm_exec_requests` for individual requests. This latter DMV is the best starting point to identify which queries are victims of insufficient grant memory. You can also observe the `RESOURCE_SEMAPHORE` wait in [sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql) as aggregated data points at the SQL Server level. This wait type shows up when a query memory request can't be granted due to other concurrent queries having used up the memory. A high count of waiting requests and long wait times indicate an excessive number of concurrent queries using execution memory or large memory request sizes.

> [!NOTE]
> The wait time for memory grants is finite. After an excessive wait (for example, over 20 minutes), SQL Server times the query out and raises error [8645](/sql/relational-databases/errors-events/mssqlserver-8645-database-engine-error), "A timeout occurred while waiting for memory resources to execute the query. Rerun the query." You may see the timeout value set at the server level by looking at `timeout_sec` in `sys.dm_exec_query_memory_grants`. The timeout value may vary slightly between SQL Server versions.

With the use of `sys.dm_exec_requests`, you can see which queries have been granted memory and the size of that grant. Also, you can identify which queries are currently waiting for a memory grant by looking for the `RESOURCE_SEMAPHORE` wait type. Here's a query that shows you both the granted and the waiting requests:

```sql
SELECT session_id, wait_type, wait_time, granted_query_memory, text
FROM sys.dm_exec_requests 
  CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE granted_query_memory > 0 
       OR wait_type = 'RESOURCE_SEMAPHORE'
```

A sample output shows two requests have been granted memory, and two dozen others are waiting for grants. The `granted_query_memory` column reports the size in 8-KB pages. For example, a value of 34,709 means 34,709 * 8 KB = 277,672 KB of memory granted.

```output
session_id wait_type               wait_time   granted_query_memory text
---------- ----------------------------------- -------------------- -------------------------------------------------------------------
65         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
66         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
67         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
68         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
69         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
70         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
71         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
72         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
73         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
74         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
75         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
76         ASYNC_NETWORK_IO        11          34709                select * from sys.messages order by message_id option (maxdop 1)
77         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
78         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
79         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
80         RESOURCE_SEMAPHORE      161435      0                    select * from sys.messages order by message_id option (maxdop 1)
81         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
82         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
83         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
84         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
85         ASYNC_NETWORK_IO        14          34709                select * from sys.messages order by message_id option (maxdop 1)
86         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
87         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
88         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
89         RESOURCE_SEMAPHORE      161439      0                    select * from sys.messages order by message_id option (maxdop 1)
```

#### Identify specific queries with sys.dm_exec_query_stats

If the memory grant issue isn't happening at this moment, but you would like to identify the offending queries, you can look at historical query data via `sys.dm_exec_query_stats`. The lifetime of the data is tied to the query plan of each query. When a plan is removed from the plan cache, the corresponding rows are eliminated from this view. In other words, the DMV keeps statistics in memory that aren't preserved after a SQL Server restart or after memory pressure causes a plan cache release. That being said, you can find the information here valuable, particularly for aggregate query statistics. Someone may have recently reported seeing large memory grants from queries, but when you look at the server workload, you may discover the problem is gone. In this situation, `sys.dm_exec_query_stats` can provide the insights that other DVMs can't. Here's a sample query that can help you find the top 20 statements that consumed the largest amounts of execution memory. This output displays individual statements even if their query structure is the same. For example, `SELECT Name FROM t1 JOIN t2 ON t1.Id = t2.Id WHERE t1.Id = 5` is a separate row from `SELECT Name FROM t1 JOIN t2 ON t1.Id = t2.Id WHERE t1.Id = 100` (only the filter predicate value varies). The query gets the top 20 statements with a maximum grant size greater than 5 MB.

```sql
SELECT TOP 20
  SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,  
    ((CASE statement_end_offset   
        WHEN -1 THEN DATALENGTH(ST.text)  
        ELSE QS.statement_end_offset END   
            - QS.statement_start_offset)/2) + 1) AS statement_text  
  ,CONVERT(DECIMAL (10,2), max_grant_kb /1024.0) AS max_grant_mb
  ,CONVERT(DECIMAL (10,2), min_grant_kb /1024.0) AS max_grant_mb
  ,CONVERT(DECIMAL (10,2), (total_grant_kb / execution_count) /1024.0) AS avg_grant_mb
  ,CONVERT(DECIMAL (10,2), max_used_grant_kb /1024.0) AS max_grant_used_mb
  ,CONVERT(DECIMAL (10,2), min_used_grant_kb /1024.0) AS min_grant_used_mb
  ,CONVERT(DECIMAL (10,2), (total_used_grant_kb/ execution_count)  /1024.0) AS avg_grant_used_mb
  ,CONVERT(DECIMAL (10,2), (total_ideal_grant_kb/ execution_count)  /1024.0) AS avg_ideal_grant_mb
  ,CONVERT(DECIMAL (10,2), (total_ideal_grant_kb/ 1024.0)) AS total_grant_for_all_executions_mb
  ,execution_count
FROM sys.dm_exec_query_stats QS
  CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST
WHERE max_grant_kb > 5120 -- greater than 5 MB
ORDER BY max_grant_kb DESC
```

Even more powerful insight can be gained by looking at the queries aggregated by `query_hash`. This example illustrates how to find the average, maximum, and minimum grant sizes for a query statement across all of its instances since the query plan was first cached.

```sql
SELECT TOP 20
  MAX(SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,  
    ((CASE statement_end_offset   
        WHEN -1 THEN DATALENGTH(ST.text)  
        ELSE QS.statement_end_offset END   
            - QS.statement_start_offset)/2) + 1)) AS sample_statement_text  
  ,CONVERT(DECIMAL (10,2), SUM(max_grant_kb) /1024.0) AS max_grant_mb
  ,CONVERT(DECIMAL (10,2), SUM(min_grant_kb) /1024.0) AS min_grant_mb
  ,CONVERT(DECIMAL (10,2), (SUM(total_grant_kb) / SUM(execution_count)) /1024.0) AS avg_grant_mb
  ,CONVERT(DECIMAL (10,2), SUM(max_used_grant_kb) /1024.0) AS max_grant_used_mb
  ,CONVERT(DECIMAL (10,2), SUM(min_used_grant_kb) /1024.0) AS min_grant_used_mb
  ,CONVERT(DECIMAL (10,2), (SUM(total_used_grant_kb)/ SUM(execution_count)) /1024.0) AS avg_grant_used_mb
  ,CONVERT(DECIMAL (10,2), (SUM(total_ideal_grant_kb)/ SUM(execution_count))  /1024.0) AS avg_ideal_grant_mb
  ,CONVERT(DECIMAL (10,2), SUM(total_grant_kb) /1024.0) AS total_grant_all_executions_mb
  ,SUM(execution_count) AS execution_count
  ,query_hash
FROM sys.dm_exec_query_stats QS
  CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST
GROUP BY query_hash
HAVING SUM(max_grant_kb) > 5120 -- greater than 5 MB
ORDER BY SUM(max_grant_kb) DESC
OPTION (MAX_GRANT_PERCENT = 5)
```

The `Sample_Statement_Text` column shows an example of the query structure that matches the query hash, but it should be read without regard to specific values in the statement. For example, if a statement contains `WHERE Id = 5`, you may read it in its more generic form: `WHERE Id = @any_value`.

Here's an abbreviated sample output of the query with only selected columns shown:

```output
sample_statement_text                      max_grant_mb  avg_grant_mb  max_grant_used_mb avg_grant_used_mb avg_ideal_grant_mb total_grant_all_executions_mb execution_count 
-----------------------------------------  ------------  ------------- ----------------- ----------------- ------------------ ----------------------------- ----------------
select     de.ObjectName,de.CounterName,d  282.45        282.45        6.50              6.50              282.45             282.45                        1               
SELECT SCHEMA_NAME(udf.schema_id) AS [Sch  33.86         8.55          7.80              1.97              8.55               42.74                         5               
insert into #tmpCounterDateTime (CounterD  32.45         32.45         3.11              3.11              32.45              32.45                         1               
select db_id() dbid, db_name() dbname, *   20.80         1.30          5.75              0.36              1.30               20.80                         16              
SELECT SCHEMA_NAME(obj.schema_id) AS [Sch  20.55         5.19          5.13              1.28              5.19               25.93                         5               
SELECT xmlplan FROM (SELECT ROW_NUMBER()   19.69         1.97          1.09              0.11              1.97               19.69                         10              
if ( select max(cast(countervalue as floa  16.39         8.20          0.77              0.38              8.20               16.39                         2               
SELECT udf.name AS [Name], udf.object_id   11.36         5.08          1.66              0.83              5.08               20.33                         4               
select --*                     Database_I  10.94         5.47          1.98              0.99              5.47               10.94                         2               
IF (select max(cast(dat.countervalue as f  8.00          1.00          0.00              0.00              0.53               8.00                          8               
insert into #tmpCounterDateTime (CounterD  5.72          2.86          1.98              0.99              2.86               5.72                          2               
INSERT INTO #tmp (CounterDateTime, Counte  5.39          1.08          1.64              0.33              1.08               6.47                          6               
```

#### Identify specific queries using Query Store (QDS) with sys.query_store_runtime_stats

If you have Query Store enabled, you can take advantage of its persisted historical statistics. Contrary to data from `sys.dm_exec_query_stats`, these statistics survive a SQL Server restart or memory pressure because they're stored in a database. QDS also has size limits and a retention policy. For more information, see the [Set the optimal Query Store Capture Mode](/sql/relational-databases/performance/manage-the-query-store#set-the-optimal-query-store-capture-mode) and [Keep the most relevant data in Query Store](/sql/relational-databases/performance/manage-the-query-store#keep-the-most-relevant-data-in-query-store) sections in [Best practices for managing the Query Store](/sql/relational-databases/performance/manage-the-query-store).

1. Identify if your databases have Query Store enabled using this query:

   ```sql
   SELECT name, is_query_store_on 
   FROM sys.databases
   WHERE is_query_store_on = 1
   ```

1. Run the following diagnostic query in the context of a specific database you want to investigate:

   ```sql
   SELECT
      MAX(qtxt.query_sql_text) AS sample_sql_text
      ,CONVERT(DECIMAL(10,2), SUM(rts.avg_query_max_used_memory) / 128) AS avg_mem_grant_used_mb
      ,CONVERT(DECIMAL(10,2), SUM(rts.min_query_max_used_memory) / 128) AS min_mem_grant_used_mb
      ,CONVERT(DECIMAL(10,2), SUM(rts.max_query_max_used_memory) / 128) AS max_mem_grant_used_mb
      ,CONVERT(DECIMAL(10,2), SUM(rts.stdev_query_max_used_memory) / 128) AS stdev_mem_grant_used_mb
      ,CONVERT(DECIMAL(10,2), SUM(rts.last_query_max_used_memory) / 128) AS last_mem_grant_used_mb
      ,SUM(count_executions) AS count_query_executions
   FROM sys.query_store_runtime_stats rts
   JOIN sys.query_store_plan p
     ON p.plan_id = rts.plan_id
   JOIN sys.query_store_query q
     ON p.query_id = q.query_id
   LEFT OUTER JOIN sys.query_store_query_text qtxt
     ON q.query_text_id = qtxt.query_text_id
   GROUP BY q.query_hash
   HAVING SUM(rts.avg_query_max_used_memory) /128 > 5 -- greater than 5 MB
   ORDER BY SUM(avg_query_max_used_memory) DESC
   OPTION (MAX_GRANT_PERCENT = 5)
   ```

   The principles here are the same as `sys.dm_exec_query_stats`; you see aggregate statistics for the statements. However, one difference is that with QDS, you're looking at only queries in the scope of this database, not the entire SQL Server. So you may need to know the database in which a particular memory grant request was executed. Otherwise, run this diagnostic query in multiple databases until you find the sizable memory grants.

   Here's an abbreviated sample output:

   ```output
   sample_sql_text                           avg_mem_grant_used_mb  min_mem_grant_used_mb  max_mem_grant_used_mb  stdev_mem_grant_used_mb  last_mem_grant_used_mb  count_query_executions
   ----------------------------------------- ---------------------- ---------------------- ---------------------- ------------------------ ----------------------- ----------------------
   SELECT   qtxt.query_sql_text  ,CONVERT(D  550.16                 550.00                 550.00                 0.00                     550.00                  1
   SELECT   qtxt.query_sql_text  ,rts.avg_q  61.00                  36.00                  65.00                  10.87                    51.00                   14
   SELECT   qtxt.query_sql_text  ,q.*  ,rts  25.46                  25.00                  25.00                  0.00                     25.00                   2
   insert into #tmpStats select 5 'Database  13.69                  13.00                  13.00                  0.03                     13.00                   16
   SELECT   q.*  ,rts                        11.93                 11.00                  12.00                  0.23                     12.00                   2
   SELECT *  ,rts.avg_query_max_used_memory  9.70                   9.00                   9.00                   0.00                     9.00                    1
   SELECT   qtxt.query_sql_text  ,rts.avg_q  9.32                   9.00                   9.00                   0.00                     9.00                    1
   select db_id() dbid, db_name() dbname, *  7.33                   7.00                   7.00                   0.00                     7.00                    9
   SELECT q.*  ,rts.avg_query_max_used_memo  6.65                   6.00                   6.00                   0.00                     6.00                    1
   (@_msparam_0 nvarchar(4000),@_msparam_1   5.17                   4.00                   5.00                   0.68                     4.00                    2
   ```

### A custom diagnostic query

Here's a query that combines data from multiple views, including the three listed previously. It provides a more thorough view of the sessions and their grants via `sys.dm_exec_requests` and `sys.dm_exec_query_memory_grants`, in addition to the server-level statistics provided by `sys.dm_exec_query_resource_semaphores`.

> [!NOTE]
> This query would return two rows per session due to the use of `sys.dm_exec_query_resource_semaphores` (one row for the regular resource semaphore and another for the small-query resource semaphore).

```sql
SELECT    CONVERT (varchar(30), GETDATE(), 121) as runtime
         , r.session_id
         , r.wait_time
         , r.wait_type
         , mg.request_time 
         , mg.grant_time 
         , mg.requested_memory_kb
          / 1024 requested_memory_mb 
         , mg.granted_memory_kb
          / 1024 AS granted_memory_mb 
         , mg.required_memory_kb
          / 1024 AS required_memory_mb 
         , max_used_memory_kb
          / 1024 AS max_used_memory_mb
         , rs.pool_id as resource_pool_id
         , mg.query_cost 
         , mg.timeout_sec 
         , mg.resource_semaphore_id 
         , mg.wait_time_ms AS memory_grant_wait_time_ms 
         , CASE mg.is_next_candidate 
           WHEN 1 THEN 'Yes'
           WHEN 0 THEN 'No'
           ELSE 'Memory has been granted'
         END AS 'Next Candidate for Memory Grant'
         , r.command
         , ltrim(rtrim(replace(replace (substring (q.text, 1, 1000), char(10), ' '), char(13), ' '))) [text]
         , rs.target_memory_kb
          / 1024 AS server_target_grant_memory_mb 
         , rs.max_target_memory_kb
          / 1024 AS server_max_target_grant_memory_mb 
         , rs.total_memory_kb
          / 1024 AS server_total_resource_semaphore_memory_mb 
         , rs.available_memory_kb
          / 1024 AS server_available_memory_for_grants_mb 
         , rs.granted_memory_kb
          / 1024 AS server_total_granted_memory_mb 
         , rs.used_memory_kb
          / 1024 AS server_used_granted_memory_mb 
         , rs.grantee_count AS successful_grantee_count 
         , rs.waiter_count AS grant_waiters_count 
         , rs.timeout_error_count 
         , rs.forced_grant_count 
         , mg.dop 
         , r.blocking_session_id
         , r.cpu_time
         , r.total_elapsed_time
         , r.reads
         , r.writes
         , r.logical_reads
         , r.row_count
         , s.login_time
         , d.name
         , s.login_name
         , s.host_name
         , s.nt_domain
         , s.nt_user_name
         , s.status
         , c.client_net_address
         , s.program_name
         , s.client_interface_name
         , s.last_request_start_time
         , s.last_request_end_time
         , c.connect_time
         , c.last_read
         , c.last_write
         , qp.query_plan
FROM     sys.dm_exec_requests r
         INNER JOIN sys.dm_exec_connections c
           ON r.connection_id = c.connection_id
         INNER JOIN sys.dm_exec_sessions s
           ON c.session_id = s.session_id
         INNER JOIN sys.databases d
           ON r.database_id = d.database_id
         INNER JOIN sys.dm_exec_query_memory_grants mg
           ON s.session_id = mg.session_id
         INNER JOIN sys.dm_exec_query_resource_semaphores rs
           ON mg.resource_semaphore_id = rs.resource_semaphore_id
         CROSS APPLY sys.dm_exec_sql_text (r.sql_handle ) AS q
         CROSS APPLY sys.dm_exec_query_plan(mg.plan_handle) qp
OPTION (MAXDOP 1, LOOP JOIN )
```

> [!NOTE]
> The `LOOP JOIN` hint is used in this diagnostic query to avoid a memory grant by the query itself, and no `ORDER BY` clause is used. If the diagnostic query ends up waiting for a grant itself, its purpose of diagnosing memory grants would be defeated. The `LOOP JOIN` hint could potentially cause the diagnostic query to be slower, but in this case, it's more important to get the diagnostic results.

Here's an abbreviated sample output from this diagnostic query with only selected columns.

|session_id|wait_time|wait_type         |requested_memory_mb|granted_memory_mb |required_memory_mb |max_used_memory_mb|resource_pool_id|
|--------- |---------|---------         |---------          |---------         |---------          |---------         |---------       |
|60        |0        |NULL              |9                  |9                 |7                  |1                 |1               |
|60        |0        |NULL              |9                  |9                 |7                  |1                 |2               |
|75        |1310085  |RESOURCE_SEMAPHORE|40                 |NULL              |0                  |NULL              |1               |
|75        |1310085  |RESOURCE_SEMAPHORE|40                 |NULL              |0                  |NULL              |2               |
|86        |1310129  |RESOURCE_SEMAPHORE|40                 |NULL              |0                  |NULL              |1               |
|86        |1310129  |RESOURCE_SEMAPHORE|40                 |NULL              |0                  |NULL              |2               |

The sample output clearly illustrates how a query submitted by `session_id` = 60 successfully got the 9-MB memory grant it requested, but only 7 MB were required to successfully start query execution. In the end, the query used only 1 MB of the 9 MB it received from the server. The output also shows that sessions 75 and 86 are waiting for memory grants, thus the `RESOURCE_SEMAPHORE` `wait_type`. Their wait time has been over 1,300 seconds (21 minutes), and their `granted_memory_mb` is `NULL`.

This diagnostic query is a sample, so feel free to modify it in any way that fits your needs. A version of this query is also used in diagnostic tools that Microsoft SQL Server support uses.

## Diagnostic tools

There are diagnostic tools that Microsoft SQL Server technical support uses to collect logs and more efficiently troubleshoot issues. [SQL LogScout](https://github.com/microsoft/sql_logscout) and [Pssdiag Configuration Manager](https://github.com/microsoft/diagmanager) (together with [SQLDiag](/sql/tools/sqldiag-utility)) collect outputs of the previously described DMVs and Performance Monitor counters that can help you diagnose memory grant issues.

If you run SQL LogScout with *LightPerf*, *GeneralPerf*, or *DetailedPerf* scenarios, the tool collects the necessary logs. You can then manually examine the YourServer_PerfStats.out and look for `-- dm_exec_query_resource_semaphores --` and `-- dm_exec_query_memory_grants --` outputs. Or, instead of manual examination, you can use [SQL Nexus](https://github.com/microsoft/sqlnexus) to import the output coming from SQL LogScout or PSSDIAG into a SQL Server database. SQL Nexus creates two tables, `tbl_dm_exec_query_resource_semaphores` and `tbl_dm_exec_query_memory_grants`, which contain the information needed to diagnose memory grants. SQL LogScout and PSSDIAG also collect Perfmon logs in the form of *.BLG* files, which can be used to review the performance counters described in the [Performance Monitor counters](#performance-monitor-counters) section.

## Why are memory grants important to a developer or DBA

Based on Microsoft support experience, memory grant issues tend to be some of the most common memory-related problems. Applications often execute seemingly simple queries that may end up causing performance issues on the SQL Server due to huge sort or hash operations. Such queries not only consume a lot of SQL Server memory but also cause other queries to wait for memory to become available, thus the performance bottleneck.

Using the tools outlined here (DMVs, Perfmon counters, and actual query plans), you can identify which queries are large-grant consumers. Then you can tune or rewrite these queries to resolve or reduce the workspace memory usage.

## What can a developer do about sort and hash operations

Once you identify specific queries that consume a large amount of query reservation memory, you can take steps to reduce the memory grants by redesigning these queries.

### What causes sort and hash operations in queries

The first step is to become aware of what operations in a query may lead to memory grants.

**Reasons why a query would use a SORT operator:**

- [ORDER BY (T-SQL)](/sql/t-sql/queries/select-order-by-clause-transact-sql) leads to rows being sorted before being streamed as a final result.

- [GROUP BY (T-SQL)](/sql/t-sql/queries/select-group-by-transact-sql) may introduce a sort operator in a query plan prior to grouping if an underlying index isn't present that orders the grouped columns.

- [DISTINCT (T-SQL)](/sql/t-sql/queries/select-transact-sql) behaves similarly to `GROUP BY`. To identify distinct rows, the intermediate results are ordered, and then duplicates are removed. The optimizer uses a `Sort` operator prior to this operator if the data isn't already sorted due to an ordered index seek or scan.

- The [Merge Join](/sql/relational-databases/performance/joins#merge) operator, when selected by the query optimizer, requires that both joined inputs are sorted. SQL Server may trigger a sort if a clustered index isn't available on the join column in one of the tables.

**Reasons why a query would use a HASH query plan operator:**

This list isn't exhaustive but includes the most commonly encountered reasons for Hash operations. [Analyze the query plan](/sql/relational-databases/performance/analyze-an-actual-execution-plan) to identify the Hash match operations.

- [JOIN (T-SQL)](/sql/relational-databases/performance/joins): When joining tables, SQL Server has a choice between three physical operators, `Nested Loop`, `Merge Join`, and `Hash Join`. If SQL Server ends up choosing a [Hash Join](/sql/relational-databases/performance/joins#hash), it needs QE memory for intermediate results to be stored and processed. Typically, a lack of good indexes may lead to this most resource-expensive join operator, `Hash Join`. To [Examine the query plan](/sql/relational-databases/performance/analyze-an-actual-execution-plan) to identify `Hash Match`, see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference).

- [DISTINCT (T-SQL)](/sql/t-sql/queries/select-transact-sql): A `Hash Aggregate` operator could be used to eliminate duplicates in a rowset. To look for a `Hash Match` (`Aggregate`) in the query plan, see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference).

- [UNION (T-SQL)](/sql/t-sql/language-elements/set-operators-union-transact-sql): This is similar to `DISTINCT`. A `Hash Aggregate` could be used to remove the duplicates for this operator.

- [SUM/AVG/MAX/MIN (T-SQL)](/sql/t-sql/functions/aggregate-functions-transact-sql): Any aggregate operation could potentially be performed as a `Hash Aggregate`. To look for a `Hash Match` (`Aggregate`) in the query plan, see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference).

Knowing these common reasons can help you eliminate, as much as possible, the large memory grant requests coming to SQL Server.

### Ways to reduce sort and hash operations or the grant size

- Keep [statistics](/sql/relational-databases/statistics/statistics) up to date. This fundamental step, which improves performance for queries on many levels, ensures that the query optimizer has the most accurate information when selecting query plans. SQL Server determines what size to request for its memory grant based on statistics. Out-of-date statistics can cause overestimation or underestimation of the grant request and thus lead to an unnecessarily high grant request or to spilling results to disk, respectively. Ensure that [auto-update statistics](/sql/t-sql/statements/alter-database-transact-sql-set-options#auto_update_statistics) is enabled in your databases and/or keep statics updated with [UPDATE STATISTICS](/sql/t-sql/statements/update-statistics-transact-sql) or [sp_updatestats](/sql/relational-databases/system-stored-procedures/sp-updatestats-transact-sql).
- Reduce the number of rows coming from tables. If you use a more restrictive WHERE filter or a JOIN and reduce the number of rows, a subsequent sort in the query plan gets to order or aggregate a smaller result set. A smaller intermediate result set requires less working set memory. This is a general rule that developers can follow not only for saving working set memory but also to reduce CPU and I/O (this step isn't always possible). If well-written and resource-efficient queries are already in place, this guideline has been met.
- Create indexes on join columns to aid merge joins. The intermediate operations in a query plan are affected by the indexes on the underlying table. For example, if a table has no index on a join column, and a merge join is found to be the most cost-efficient join operator, all the rows from that table have to be sorted before the join is performed. If, instead, an index exists on the column, a sort operation can be eliminated.
- Create indexes to help avoid hash operations. Commonly, basic query tuning starts with checking if your queries have appropriate indexes to help them reduce reads and minimize or eliminate large sorts or hash operations where possible. Hash joins are commonly selected to process large, unsorted, and nonindexed inputs. Creating indexes may change this optimizer strategy and speed up data retrieval. For assistance in creating indexes, see [Database Engine Tuning Advisor](/sql/relational-databases/performance/database-engine-tuning-advisor) and [Tune nonclustered indexes with missing index suggestions](/sql/relational-databases/indexes/tune-nonclustered-missing-index-suggestions).
- Use COLUMNSTORE indexes where appropriate for aggregation queries that use `GROUP BY`. Analytics queries that deal with very large rowsets and typically perform "group by" aggregations may need large memory chunks to get work done. If an index isn't available that provides ordered results, a sort is automatically introduced in the query plan. A sort of a very large result may lead to an expensive memory grant.
- Remove the `ORDER BY` if you don't need it. In cases where results are streamed to an application that sorts the results in its own way or allows the user to modify the order of the data viewed, you don't need to perform a sort on the SQL Server side. Just stream the data out to the application in the order the server produces it and let the end user sort it on their own. Reporting applications like Power BI or Reporting Services are examples of such applications that allow end users to sort their data.
- Consider, albeit cautiously, the use of a [LOOP JOIN](/sql/t-sql/queries/hints-transact-sql-query#-loop--merge--hash--join) hint when joins exist in a T-SQL query. This technique may avoid hash or merge joins that use memory grants. However, this option is only suggested as a last resort because forcing a join might lead to a significantly slower query. Stress test your workload to ensure this is an option. In some cases, a nested loop join may not even be an option. In this case, SQL Server may fail with error MSSQLSERVER_8622, "Query processor could not produce a query plan because of the hints defined in this query."

### Memory grant query hint

Since SQL Server 2012 SP3, a query hint has existed that allows you to control the size of your memory grant per query. Here's an example of how you can use this hint:

```sql
SELECT Column1,  Column2
FROM Table1 
ORDER BY Column1 
OPTION (MIN_GRANT_PERCENT = 3, MAX_GRANT_PERCENT = 5 )
```

We recommend that you use conservative values here, especially in the cases where you expect many instances of your query to be executed concurrently. Ensure you stress test your workload to match your production environment and determine what values to use.

For more information, see [MAX_GRANT_PERCENT and MIN_GRANT_PERCENT](/sql/t-sql/queries/hints-transact-sql-query#max_grant_percent--numeric_value).

### Resource Governor

QE Memory is the memory that Resource Governor actually limits when the [MIN_MEMORY_PERCENT and MAX_MEMORY_PERCENT](/sql/relational-databases/resource-governor/resource-governor-resource-pool#min_memory_percent-and-max_memory_percent) settings are used. Once you identify queries that cause large memory grants, you can limit the memory used by sessions or applications. It's worth mentioning that the `default` workload group allows a query to take up to 25% of memory that can be granted on a SQL Server instance. For more information, see [Resource Governor Resource Pools](/sql/relational-databases/resource-governor/resource-governor-resource-pool) and [CREATE WORKLOAD GROUP](/sql/t-sql/statements/create-workload-group-transact-sql).

### Adaptive query processing and memory grant feedback

SQL Server 2017 introduced the memory grant feedback feature. It allows the query execution engine to adjust the grant given to the query based on prior history. The goal is to reduce the size of the grant when possible or increase it when more memory is needed. This feature has been released in three waves:

1. Batch mode memory grant feedback in SQL Server 2017
1. Row mode memory grant feedback in SQL Server 2019
1. Memory grant feedback on-disk persistence using the Query Store and  percentile grant in SQL Server 2022

For more information, see [Memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-feedback#memory-grant-feedback). The memory grant feature may reduce the size of the memory grants for queries at execution time and thus reduce the problems stemming from large grant requests. With this feature in place, especially on SQL Server 2019 and later versions, where row mode adaptive processing is available, you may not even notice any memory issues coming from query execution. However, if you have this feature in place (on by default) and still see large QE memory consumption, apply the steps discussed previously to rewrite queries.

### Increase SQL Server or OS memory

After you've taken the steps to reduce unnecessary memory grants for your queries, if you still experience related low memory issues, the workload likely requires more memory. Therefore, consider increasing the memory for SQL Server using the `max server memory` setting if there's sufficient physical memory on the system to do so. Follow the recommendations on leaving about 25% of the memory for the OS and other needs. For more information, see [Server memory configuration options](/sql/database-engine/configure-windows/server-memory-server-configuration-options#recommendations). If no sufficient memory is available on the system, then consider adding physical RAM, or if it's a virtual machine, increase the dedicated RAM for your VM.

## Memory grant internals

To learn more about some internals on query execution memory, see the [Understanding SQL server memory grant](https://techcommunity.microsoft.com/t5/sql-server-blog/understanding-sql-server-memory-grant/ba-p/383595) blog post.

## How to create a performance scenario with heavy memory grant usage

Finally, the following example illustrates how to simulate large consumption of query execution memory and to introduce queries waiting on `RESOURCE_SEMAPHORE`. You can do this to learn how to use the diagnostic tools and techniques described in this article.

> [!WARNING]
> Don't use this on a production system. This simulation is provided to help you understand the concept and to help you learn it better.

1. On a test server, install [RML Utilities](../../tools/replay-markup-language-utility.md) and SQL Server.

1. Use a client application like SQL Server Management Studio to lower the max server memory setting of your SQL Server to 1,500 MB:

   ```sql
   EXEC sp_configure 'max server memory', 1500
   RECONFIGURE
   ```

1. Open a Command Prompt and change the directory to the RML utilities folder:

   ```cmd
   cd C:\Program Files\Microsoft Corporation\RMLUtils   
   ```

1. Use *ostress.exe* to spawn multiple simultaneous requests against your test SQL Server. This example uses 30 simultaneous sessions, but you can change that value:

   ```cmd
   ostress.exe -E -S. -Q"select * from sys.messages order by message_id option (maxdop 1)" -n30
   ```

1. Use the diagnostic tools described previously to identify the memory grant issues.

## Summary of ways to deal with large memory grants

- Rewrite queries.
- Update statistics and keep them updated regularly.
- Create appropriate indexes for the query or queries identified. Indexes may reduce the large number of rows processed, thus changing the `JOIN` algorithms and reducing the size of grants or completely eliminating them.
- Use the `OPTION` ([min_grant_percent = XX](/sql/t-sql/queries/hints-transact-sql-query#min_grant_percent--numeric_value), [max_grant_percent = XX](/sql/t-sql/queries/hints-transact-sql-query#max_grant_percent--numeric_value)) hint.
- Use [Resource Governor](/sql/relational-databases/resource-governor/resource-governor).
- SQL Server 2017 and 2019 use adaptive query processing, allowing the memory grant feedback mechanism to adjust memory grant size dynamically at runtime. This feature may prevent memory grant issues in the first place.
- Increase SQL Server or OS memory.
