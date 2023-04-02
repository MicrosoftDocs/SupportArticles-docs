---
title: Troubleshoot out of memory or low memory issues caused by memory grants in SQL Server
description: Provides troubleshooting steps to identify and reduce memory grant memory consumption in SQL Server.
author: pijocoder
ms.author: jopilov
ms.reviewer: pijocoder
ms.date: 03/27/2023
ms.prod: sql
ms.topic: troubleshooting
ms.custom: sap:Performance
---

# Troubleshoot out of memory or low memory issues caused by memory grants in SQL Server

## What are Memory Grants?

Memory grants, also referred to as Query Execution (QE) Reservations, Query Execution Memory, Workspace memory and Memory Reservations are all terms that describe the usage of memory at query execution time. SQL Server allocates this memory during query execution for the following purposes:

- Sort operations
- Hash operations
- Bulk copy operations (less frequently an issue)
- Index creation including inserting into Columnstore indexes because hash dictionaries/tables are used at run time for index building

During its lifetime a query may request memory from different memory allocators or clerks depending on what it needs to do. For example, when a query is parsed and compiled initially, it will consume compile or optimizer memory. Once the query is compiled that memory is released and the resulting query plan is stored in plan cache. For that, the plan will consume plan cache memory and remains in that cache until SQL Server is restarted or memory pressure causes it to be released. Once a plan is cached, the query is ready for execution. If the query happens to be performing any sort operations or hash match (join or aggregates), or inserting into a columnstore index, then it will first reserve and later be granted to use part or all of the reserved memory for sort results or hash buckets. This memory allocated during query execution is what is referred to memory grants. As you can imagine, once the query execution operation completes, the memory is released back to SQL Server to use for other things. Therefore, memory grants allocations are temporary in nature, but keep in mind that still can last a long time. For example, if a query execution performs a sort of a very large rowset in memory, the sort may take many seconds and the granted workspace memory will be used for the lifetime of that sort.

### Terminology

Let's review the different terms that you may encounter referring to this memory consumer. Again, all these describe concepts that relate to the same memory allocations.

- Query Execution Memory (QE Memory):  This term is used to highlight the fact that sort/hash memory is used during the execution of a query and is commonly the largest memory consumer of memory during execution.

- Query Execution (QE) Reservations or Memory Reservations: When a query needs memory for sort or hash operations, during execution it will make a reservation request based on a value stored in the query plan. That reservation request is calculated at compile time based on estimated cardinality. Then later, when the query executes it requests the memory and SQL Server will grant that request partially or fully depending on memory availability. In the end the query may use a percentage of the granted memory. There is a memory clerk (accountant of memory) named 'MEMORYCLERK_SQLQERESERVATIONS' that keeps track of these memory allocations (check out DBCC MEMORYSTATUS or `sys.dm_os_memory_clerks`).

Memory Grants: When SQL Server grants the requested memory to an executing query it is said that a memory grant has occurred. There is a Perfmon counter that keeps track of how many queries have been granted the requested memory: Memory Grants Outstanding . Another counter shows how many queries have requested sort/hash memory and have to wait for it because the Query Execution memory has run out (QE Reservation memory clerk has given all of it away): Memory Grants Pending . These two only display the count of memory grants and do not account for size. That is, one query alone could have consumed say 4 GB of memory to perform a sort, but that will not be reflected in either of these.

Workspace Memory: This is yet another term that describes the same memory. Often you will see this in the Perfmon counter Granted Workspace Memory (KB) which reflects the overall amount of memory currently used for sort, hash, bulk copy, and index creation operations. operations, expressed in KB.

The Maximum Workspace Memory (KB) accounts for the maximum amount of workspace memory available for executing processes, such as hash, sort, bulk copy, and index creation operations. In my opinion, the term Workspace Memory is a legacy one used to describe this memory allocator in SQL Server 7.0 and 2000 and was later superseded by the memory clerks terminology after SQL Server 2005.






In addition, you can capture the Actual Query Execution plan and find an XML element called <Query plan> which will contain an attribute showing the size of the memory grant (KB) as in the following example:

`<QueryPlan DegreeOfParallelism="8" MemoryGrant ="2009216"`

Another DMV- `sys.dm_exec_requests` - contains a column granted_query_memory which reports the size in 8 KB pages. For example a value of 1000 would mean 1000 * 8 KB , or 8000 KB of memory granted.


## Performance impact of large QE memory utilization

When a thread requests memory inside SQL Server and the memory is not available, the request fails with an out of memory error. However, there are a couple of exception scenarios where if there's no memory available, the thread waits until the memory becomes available. One of those scenarios is memory grants and the other is query compilation memory.  SQL Server uses a thread synchronization object called a [semaphore](/windows/win32/sync/semaphore-objects) to keep track of how much memory has been granted for query execution. If SQL Server runs out of the predefined workspace memory/QE memory, then instead of failing the query with an out-of-memory error, it causes the query to wait. Given that workspace memory is a significant percentage of overall SQL Server memory (up to 90%), waiting on memory indicates that a large number of concurrent queries have requested execution memory or perhaps a small number of concurrent queries have each requested very large grants. Such a condition would suggest that all kinds of performance issues are occurring on the system:

- Data and index pages from buffer cache have likely been flushed out to make space for the large memory grant requests. This would mean that page reads would have to be satisfied from disk - a much slower operation.
- Requests may fail with out of memory due to the fact that memory is tied up by sort, hash or index building requests
- Requests that need workspace/execution memory are waiting for memory to become available and are therefore taking a long time to complete

Therefore if you observe waits on workspace memory either in Perfmon, in DMVs, or DBCC MEMORYSTATUS you have a clear signal to act and resolve this issue (see [What can a developer co about Sort and Hash operations](#what-can-a-developer-co-about-sort-and-hash-operations)).

## How to identify waits for query execution memory
 
There are multiple ways to determine waits for execution memory. You can use whichever ones serve you best to see the big picture at the server level. Then you must drill down at the individual query level to see which queries need tuning or re-writes.

- At server level using aggregate memory usage statistics
  - [sys.dm_exec_query_resource_semaphores](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-resource-semaphores-transact-sql) DMV
  - Performance monitor counters (SQLServer, Memory Manager)
  - DBCC MEMORYSTATUS
  - [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) DMV

- At individual query level
  - [sys.dm_exec_query_memory_grants](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-memory-grants-transact-sql)
  - [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) (**granted_query_memory** column)

Next, you can find information about each of these methods

### Resource semaphore DMV `sys.dm_exec_query_resource_semaphores`

This DMV breaks down the query reservation memory by resource pool (internal, default, and user-created) and resource_semaphore (regular and small query requests). A useful query may be this:

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

Here's a sample output that shows around 900 MB of query execution memory used by 22 requests and 3 more are waiting. This takes place in the default pool (pool_id = 2) and the regular query semaphore (resource_semaphore_id = 0).

```output
pool_id     total_memory_kb      available_memory_kb  granted_memory_kb    used_memory_kb       grantee_count waiter_count resource_semaphore_id
----------- -------------------- -------------------- -------------------- -------------------- ------------- ------------ ---------------------
1           30880                30880                0                    0                    0             0            0
1           5120                 5120                 0                    0                    0             0            1
2           907104               0                    907104               898656               22            3            0
2           40960                40960                0                    0                    0             0            1

(4 rows affected)
```

### Performance Monitor counters

Similar information is available via Performance Monitor counters, where you can observe the currently granted requests (`Memory Grants Outstanding`), the waiting grant requests (`Memory Grants Pending`), and the amount of memory used by memory grants (`Granted Workspace Memory (KB)`). In the following image, the outstanding grants = 18, the pending grants = 2, and the granted workspace memory = 828288 KB. The `Memory Grants Pending` Perfmon counter with a non-zero value indicates that memory has been exhausted.

:::image type="content" source="media/troubleshoot-memory-grants/memory-grants-performance-monitor.png" alt-text="memory grants waiting and satisfied":::

For more information, see ([SQL Server Memory Manager](/sql/relational-databases/performance-monitor/sql-server-memory-manager-object))

- SQLServer, Memory Manager:  Maximum Workspace Memory (KB)
- SQLServer, Memory Manager:  Memory Grants Outstanding
- SQLServer, Memory Manager:  Memory Grants Pending
- SQLServer, Memory Manager:  Granted Workspace Memory (KB)


### DBCC MEMORYSTATUS

Another place where you can see indication for waiting is  DBCC MEMORYSTATUS ([Query Memory Objects section](dbcc-memorystatus-monitor-memory-usage.md#query-memory-objects)). You can look at the Query Memory Objects (default) output for user queries. If you have enabled Resource Governor with a resource pool named 'PoolAdmin' for example, then you can look at both `Query Memory Objects (default)` and `Query Memory Objects (PoolAdmin)`.

Here's a sample output from a system where 18 requests have been granted query execution memory and 2 requests are waiting for memory. The Available metric = 0, which indicates there is no more workspace memory available. This explains the 2 waiting requests. The 'Wait Time' shows the elapsed time, in milliseconds, since the next waiting query was put in the queue. For more information on more of these counters, see [Query memory objects](dbcc-memorystatus-monitor-memory-usage.md#query-memory-objects) section in DBCC MEMORYSTATUS informational article.

```output
Query Memory Objects (default)                     Value
-------------------------------------------------- -----------
Grants                                             18
Waiting                                            2
Available                                          0
Current Max                                        103536
Future Max                                         97527
Physical Max                                       139137
Next Request                                       5752
Waiting For                                        8628
Cost                                               16
Timeout                                            401
Wait Time                                          2750

(11 rows affected)

Small Query Memory Objects (default)               Value
-------------------------------------------------- -----------
Grants                                             0
Waiting                                            0
Available                                          5133
Current Max                                        5133
Future Max                                         5133

```

DBCC MEMORYSTATUS also displays information about a memory clerk that keeps track of query execution memory. The following output illustrates the pages allocated for query execution (QA) reservations exceeds 800 megabytes.

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

### Memory clerks DMV `sys.dm_os_memory_clerks`

If you want more of a tabular result set, different from the section-based DBCC MEMORYSTATUS, the same memory clerk information is present in [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql). Look for the `MEMORYCLERK_SQLQERESERVATIONS` memory clerk. 

```sql
SELECT type, memory_node_id, pages_kb 
FROM sys.dm_os_memory_clerks
WHERE type = 'MEMORYCLERK_SQLQERESERVATIONS'
```

Here's an sample output

```output
type                                                         memory_node_id pages_kb
------------------------------------------------------------ -------------- --------------------
MEMORYCLERK_SQLQERESERVATIONS                                0              824640
MEMORYCLERK_SQLQERESERVATIONS                                64             0
```

### Identify specific queries

There are two kinds of queries that you may find when looking at the query level. Those that consume large amount of query execution/workspace memory and those that are waiting for workspace memory. The latter group of queries may be requests with very modest needs for memory grants and if so, you may focus your attention elsewhere. But they could also be the culprits in the case where memory is available and they can be the massive drivers of memory consumption. It may be common to find that only one query is the culprit but many instances of it are running. So those instances that get the memory grants are causing other instance of the same exact query to wait for grant memory. Ultimately, you must identify the size of the requested execution memory and the amount granted by SQL Server.


### Identify specific queries with `sys.dm_exec_query_memory_grants`

To view individual requests, and the memory size they have requested and have been granted, you can query the `sys.dm_exec_query_memory_grants` DMV. This DMV shows information about currently executing queries, not historical information.

The following columns in [sys.dm_exec_query_memory_grants](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-memory-grants-transact-sql) are indicators as well  **wait_time_ms** , **granted_memory_kb = NULL**, **timeout_sec**.

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

Here's a sample output of the query above during active query execution memory consumption. Most queries have their memory granted as shown by **granted_memory_kb** and **used_memory_kb** being non-NULL, numeric values. The queries that did not get their request granted for memory, are waiting for execution memory, and the **granted_memory_kb** = NULL. Also, they are placed in a wait queue with a queue_id = 6, their wait_time_ms indicates about 37 seconds of waiting and session 72 is next in line to get a grant indicated by wait_order = 1, while session 74 comes after it with wait_order = 2.

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


### Identify specific queries with `sys.dm_exec_requests`

There is a wait type in SQL Server that indicates a query is waiting for a memory grant – `RESOURCE_SEMAPHORE`. You may observe this wait type in `sys.dm_exec_requests` for individual requests and this is a great starting point to identify which queries are victims of insufficient execution memory. You can also observe the `RESOURCE_SEMAPHORE` wait in `sys.dm_os_wait_stats` as aggregated data point at the server level. This wait shows up when a query memory request can't be granted due to other concurrent queries having used up the memory. High count of waiters and long wait times indicate excessive number of concurrent queries using execution memory, or large memory request sizes. After an excessive wait of this type (over 20 minutes), the query is ultimately timed out and SQL Server raises error [8645](/sql/relational-databases/errors-events/mssqlserver-8645-database-engine-error), "A time out occurred while waiting for memory resources to execute the query. Rerun the query." You may see the timeout value set at the server level by looking at the **timeout_sec** in `sys.dm_exec_query_memory_grants`.

```sql
An example goes here
```


### A custom-built diagnostic query

 Here's a query that accesses that view and many others to give you a thourough view of the sessions and their grants. Note that this query would return two rows per each query or session due to the use of `sys.dm_exec_query_resource_semaphores`: one row for the regular resource semaphore and another row for the small-query resource semaphore

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

Note that LOOP JOIN hint is used in this diagnostic query to avoid a memory grant being requested by the query itself. It would defeat the purpose of using this query for diagnosing waiting memory grants if it is also waiting for a grant itself. The join hint could potentially lead to a slower query but in this case this is less important than getting the diagnostic results.

Here's an abbreviated sample output from this diagnostic query


|session_id|wait_time|wait_type |requested_memory_mb  |granted_memory_mb  |required_memory_mb  |max_used_memory_mb  |
|--------- |---------|---------         |---------|---------|---------|---------|
|75        |1310085  |RESOURCE_SEMAPHORE|40         |NULL         |0         |NULL         |
|86        |1310129  |RESOURCE_SEMAPHORE|40         |NULL         |0         |NULL         |
|91        |1310135  |RESOURCE_SEMAPHORE|40         |NULL         |0         |NULL         |


Here's another example where grants were successful. 

|session_id|wait_time|wait_type |requested_memory_mb  |granted_memory_mb  |required_memory_mb  |max_used_memory_mb  |
|--------- |---------|---------|---------|---------|---------|---------|
|60        |0  |NULL|9         |9         |7         |1         |
|60        |0  |NULL|9         |9         |7         |1         |


## Diagnostic tools

SQL LogScout and SQL Nexus ...


## Why are Memory Grants important to a developer or DBA

Based on Microsoft support experience, memory grant issues tend to be some of the most common memory-related problems. Applications often execute seemingly simple queries that sometimes end up causing performance issues on the SQL Server side because of huge sort or hash operations.  Such queries not only end up consuming much SQL Server memory during execution, but also cause other queries to have to wait for memory to become available – thus the performance bottleneck.

Using the tools outlined here (DMVs, Perfmon counters and actual query plan), you can identify which queries are large-grant consumers. Then you can tune or re-write these queries to resolve or reduces the workspace memory usage.

## What can a developer co about Sort and Hash operations

Once you identify specific queries that are consuming large amount of query reservation memory, you can take steps to reduce the memory grants by re-designing these queries.

### What causes sort and hash operations in queries

The first step is become aware what operations in a query may lead to memory grants.

**Reasons why a query would use a SORT operator (not all inclusive list):**

- [ORDER BY (T-SQL)](/sql/t-sql/queries/select-order-by-clause-transact-sql) this clause  causes results to be sorted before streamed as a final result.

- [GROUP BY (T-SQL)](/sql/t-sql/queries/select-group-by-transact-sql) may introduce a sort operator in a query plan prior to grouping if an underlying index is not present that orders the grouped columns.

- [DISTINCT (T-SQL)](/sql/t-sql/queries/select-transact-sql) behaves similarly to GROUP BY. To identify distinct rows, the intermediate results are ordered and then duplicates removed. The optimizer will use a Sort operator prior to this operator if the data is not already sorted due to an ordered index seek or scan.

- [Merge Join](/sql/relational-databases/performance/joins#merge) operator, when selected by the query optimizer, requires that both joined inputs are sorted. SQL Server may trigger a sort if a clustered index is not available on the join column in one of the tables.

**Reasons why a query would use a HASH query plan operator:**

This is not a complete  list, but includes most commonly encountered reasons for Hash operations. [Analyze the query plan](/sql/relational-databases/performance/analyze-an-actual-execution-plan) to identify the Hash match operations. 

- [JOIN (T-SQL)](/sql/relational-databases/performance/joins) – when joining tables, SQL Server has a choice between 3 physical operators - Nested Loop, Merge Join, Hash Join. If SQL Server ends up choosing a [Hash Join](/sql/relational-databases/performance/joins#hash) due to lowest cost, working set memory will be required for intermediate results to be stored in memory. Typically, lack of good indexes may lead to the most resource-expensive of join operators – Hash Join. [Examine the query plan](/sql/relational-databases/performance/analyze-an-actual-execution-plan) to identify Hash Match (see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference)).

- [DISTINCT (T-SQL)](/sql/t-sql/queries/select-transact-sql) – a Hash Aggregate operator could be used to eliminates duplicates in a rowset. Look for a Hash Match (Aggregate) in the query plan (see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference)).

- [UNION (T-SQL)](/sql/t-sql/language-elements/set-operators-union-transact-sql) – similar to DISTINCT, a Hash Aggregate could be used to remove the duplicates for this operator.

- [SUM/AVG/MAX/MIN (T-SQL)](/sql/t-sql/functions/aggregate-functions-transact-sql)– any aggregate operation could potentially be performed as a Hash Aggregate.  Look for a Hash Match (Aggregate) in the query plan (see [Logical and Physical operators reference](/sql/relational-databases/showplan-logical-and-physical-operators-reference)).


Knowing these common reasons can help you eliminate, as much as possible, the large memory grant requests coming to SQL Server.


### Ways to reduce sort and hash operations

- Reduce the number of rows coming from tables. If you use a more restrictive WHERE filter or JOIN and reduce the number of rows, then a subsequent sort in the query plan will order a smaller result set. Smaller intermediate rowset requires less working set memory. This is a general rule that developers can follow not only for saving working set memory but also reduce CPU and I/O. Of course this is not always possible and if well-written and resource-efficient queries are already in place, this guideline has been met.
- Create indexes on join columns to aid merge joins. The number of intermediate results coming from a table in a query plan is affected by the indexes on the underling table. For example if a table has no index on a join column, and a Merge join is found to be the most cost-efficient join operator, then all the rows from that table have to be sorted before the join is performed. If instead an index exists on the column, a sort operation can be eliminated.
- Create indexes to help avoid hash operations- commonly, basic query tuning starts with checking if your queries have appropriate indexes to help them reduce reads, minimize or eliminate large sorts or hash operations where possible. Hash Joins are commonly selected to process large, unsorted, nonindexed inputs. Creating indexes may change this optimizer strategy and speed up data retrieval.
- Use Columnstore indexes where appropriate for aggregation queries that use GROUP BY. Analytics queries that deal with very large rowsets and typically perform group by aggregations. If index is not available that provides ordered resuts a sort will be automatically introduced in query plan. A sort on a very large result may lead to an expensive memory grant.
- Remove the ORDER BY if you don't need it. In cases where results are streamed to an application that sorts the results in its own way or allows the user to modify the order of the data viewed, you don't need to perform a sort on the SQL Server side. Simply stream the data out to the application in whatever order the server produces it and let the end user sort it however they see fit. Reporting applications like PowerBI or Reporting Services are examples of such applications that allow end user to sort their data.
- Consider, albeit very cautiously, the use of a [LOOP JOIN](/sql/t-sql/queries/hints-transact-sql-query#-loop--merge--hash--join)  hint in the case of joins in a query. This may avoid hash or merge joins that may use memory grants. However, this option should be a last resort because forcing a join may lead to a significantly slower query and in some cases may not even be an option. In this latter case SQL Server may fail with error [MSSQLSERVER_8623](/sql/relational-databases/errors-events/mssqlserver-8623-database-engine-error), which indicates that SQL Server could not produce a query plan.


### Memory grant query hint

Since SQL Server 2012 SP3, a query hint exists that allows you to control the size of your memory grant per query. Here is an example of how you can use this hint:

```sql
SELECT Column1,  Column2
FROM Table1 
ORDER BY Column1 
OPTION (min_grant_percent = 3, max_grant_percent = 5 )
```

For more information, see [MAX_GRANT_PERCENT and MIN_GRANT_PERCENT](/sql/t-sql/queries/hints-transact-sql-query#max_grant_percent--numeric_value)

### Resource Governor

QE Memory is the memory that Resource Governor actually limits, when the [MIN_MEMORY_PERCENT and MAX_MEMORY_PERCENT](/sql/relational-databases/resource-governor/resource-governor-resource-pool#min_memory_percent-and-max_memory_percent) settings are used. Once you identify queries that are causing large memory grants, you can limit the memory used for the sessions or applications that submits these queries.  See [Resource Governor Resource Pools](/sql/relational-databases/resource-governor/resource-governor-resource-pool) for more information.

### Adaptive query processing and Memory grant feedback

SQL Server 2017 introduced the Memory grant feedback feature which allows the query execution engine to adjust the grant given to the query based on prior history. The goal is to reduce the size of the grant when possible or increase it when more memory is needed. This feature has been released in three waves. Batch mode memory grant feedback in SQL Server 2017, followed by row mode memory grant feedback in SQL Server 2019, and memory grant feedback on-disk persistence using the Query Store and an improved algorithm known as percentile grant in SQL Server 2022. For more information, see [Memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-feedback#memory-grant-feedback). The Memory grant feature may reduce the size of the memory grants for queries at execution time and thus reduce the problems stemming from large grant requests. With this feature in place especially on SQL Server 2019 and later where row mode adapative processing is available, you may not notice that have memory issues coming from query execution. However, if you have this feature in place and you still see large memory consumption, apply the steps discussed previous to re-writer queries. 


## Memory Grant Internals

To learn more about some internals refer to [Understanding SQL server memory grant](https://techcommunity.microsoft.com/t5/sql-server-blog/understanding-sql-server-memory-grant/ba-p/383595) blog post




## Summary of Ways to Deal with Large Grants:

- Re-write queries
- Use Resource Governor
- Find appropriate indexes for the query which may reduce the large number of rows processed and thus change the JOIN algorithms (see Database Engine Tuning Advisor and Missing Indexes DMVs)
- Use OPTION (min_grant_percent = XX, max_grant_percent = XX ) hint
- SQL Server 2017 and 2019 introduce Adaptive query processing allowing for Memory Grant feedback mechanism to adjust memory grant size dynamically at run-time.
