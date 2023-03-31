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

Terminology and Troubleshooting Tools

Let's review the different terms that you may encounter referring to this memory consumer. Again, all these describe concepts that relate to the same memory allocations:


Query Execution Memory (QE Memory):  This term is used to highlight the fact that sort/hash memory is used during the execution of a query and is the largest memory consumption that may come from a query during execution.


Query Execution (QE) Reservations or Memory Reservations: When a query needs memory for sort/hash operations, during execution it will make a reservation request based on the original query plan which contained a sort or a hash operator. Then as the query executes, it requests the memory and SQL Server will grant that request partially or fully depending on memory availability. There is a memory clerk (accountant) named 'MEMORYCLERK_SQLQERESERVATIONS' that keep track of these memory allocations (check out DBCC MEMORYSTATUS or `sys.dm_os_memory_clerks`).

Memory Grants: When SQL Server grants the requested memory to an executing query it is said that a memory grant has occurred. There is a Perfmon counter that keeps track of how many queries have been granted the requested memory: Memory Grants Outstanding . Another counter shows how many queries have requested sort/hash memory and have to wait for it because the Query Execution memory has run out (QE Reservation memory clerk has given all of it away): Memory Grants Pending . These two only display the count of memory grants and do not account for size. That is, one query alone could have consumed say 4 GB of memory to perform a sort, but that will not be reflected in either of these.

## How to Identify Memory grants?

### Find individual queries at run time

To view individual requests, and the memory size they have requested and have been granted, you can query the `sys.dm_exec_query_memory_grants` DMV. This shows information about currently executing queries, not historically. Here's a query that accesses that view and many others to give you a thourough view of the sessions and their grants. Note that this query would return two rows per each query or session due to the use of `sys.dm_exec_query_resource_semaphores`: one row for the regular resource semaphore and another row for the small-query resource semaphore

```sql
SELECT    CONVERT (varchar(30), @runtime, 121) as runtime
         , r.session_id
         , mg.request_time  --Date and time when this query requested the memory grant.
         , mg.grant_time --NULL means memory has not been granted
         , mg.requested_memory_kb
          / 1024 requested_memory_mb --Total requested amount of memory in megabytes
         , mg.granted_memory_kb
          / 1024 AS granted_memory_mb --Total amount of memory actually granted in megabytes. NULL if not granted
         , mg.required_memory_kb
          / 1024 AS required_memory_mb--Minimum memory required to run this query in megabytes. 
         , max_used_memory_kb
          / 1024 AS max_used_memory_mb
         , mg.query_cost --Estimated query cost.
         , mg.timeout_sec --Time-out in seconds before this query gives up the memory grant request.
         , mg.resource_semaphore_id --Nonunique ID of the resource semaphore on which this query is waiting.
         , mg.wait_time_ms AS memory_grant_wait_time_ms --Wait time in milliseconds. NULL if the memory is already granted.
         , CASE mg.is_next_candidate --Is this process the next candidate for a memory grant
           WHEN 1 THEN 'Yes'
           WHEN 0 THEN 'No'
           ELSE 'Memory has been granted'
         END AS 'Next Candidate for Memory Grant'
         , r.command
         , ltrim(rtrim(replace(replace (substring (q.text, 1, 1000), char(10), ' '), char(13), ' '))) [text]
         , rs.target_memory_kb
          / 1024 AS server_target_grant_memory_mb --Grant usage target in megabytes.
         , rs.max_target_memory_kb
          / 1024 AS server_max_target_grant_memory_mb --Maximum potential target in megabytes. NULL for the small-query resource semaphore.
         , rs.total_memory_kb
          / 1024 AS server_total_resource_semaphore_memory_mb --Memory held by the resource semaphore in megabytes. 
         , rs.available_memory_kb
          / 1024 AS server_available_memory_for_grants_mb --Memory available for a new grant in megabytes.
         , rs.granted_memory_kb
          / 1024 AS server_total_granted_memory_mb  --Total granted memory in megabytes.
         , rs.used_memory_kb
          / 1024 AS server_used_granted_memory_mb --Physically used part of granted memory in megabytes.
         , rs.grantee_count AS successful_grantee_count--Number of active queries that have their grants satisfied.
         , rs.waiter_count AS grant_waiters_count--Number of queries waiting for grants to be satisfied.
         , rs.timeout_error_count --Total number of time-out errors since server startup. NULL for the small-query resource semaphore.
         , rs.forced_grant_count --Total number of forced minimum-memory grants since server startup. NULL for the small-query resource semaphore.
         , mg.dop --Degree of parallelism 
         , r.blocking_session_id
         , r.cpu_time
         , r.total_elapsed_time
         , r.reads
         , r.writes
         , r.logical_reads
         , r.row_count
         , wait_time
         , wait_type
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

FROM     sys.dm_exec_requests r
         JOIN sys.dm_exec_connections c
           ON r.connection_id = c.connection_id
         JOIN sys.dm_exec_sessions s
           ON c.session_id = s.session_id
         JOIN sys.databases d
           ON r.database_id = d.database_id
         JOIN sys.dm_exec_query_memory_grants mg
           ON s.session_id = mg.session_id
         INNER JOIN sys.dm_exec_query_resource_semaphores rs
           ON mg.resource_semaphore_id = rs.resource_semaphore_id
         CROSS APPLY sys.dm_exec_sql_text (r.sql_handle ) AS q
ORDER BY wait_time DESC
OPTION (MAX_GRANT_PERCENT = 3, MAXDOP 1)
```

In addition, you can capture the Actual Query Execution plan and find an XML element called <Query plan> which will contain an attribute showing the size of the memory grant (KB) as in the following example:

`<QueryPlan DegreeOfParallelism="8" MemoryGrant ="2009216"`

Another DMV- `sys.dm_exec_requests` - contains a column granted_query_memory which reports the size in 8 KB pages. For example a value of 1000 would mean 1000 * 8 KB , or 8000 KB of memory granted.

### SQL Server overall memory usage trends

- Perfmon counters ([SQL Server Memory Manager](/sql/relational-databases/performance-monitor/sql-server-memory-manager-object))
  - SQLServer, Memory Manager:  Maximum Workspace Memory (KB)
  - SQLServer, Memory Manager:  Memory Grants Outstanding
  - SQLServer, Memory Manager:  Memory Grants Pending
  - SQLServer, Memory Manager:  Granted Workspace Memory (KB)

- DBCC MEMORYSTATUS ([Query Memory Objects section](dbcc-memorystatus-monitor-memory-usage.md#query-memory-objects))
- Memory clerks via [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) 

Workspace Memory: This is yet another term that describes the same memory. Often you will see this in the Perfmon counter Granted Workspace Memory (KB) which reflects the overall amount of memory currently used for sort, hash, bulk copy, and index creation operations. operations, expressed in KB.

The Maximum Workspace Memory (KB) accounts for the maximum amount of workspace memory available for executing processes, such as hash, sort, bulk copy, and index creation operations. In my opinion, the term Workspace Memory is a legacy one used to describe this memory allocator in SQL Server 7.0 and 2000 and was later superseded by the memory clerks terminology after SQL Server 2005.

Resource Semaphore: To add more complications to this concept, SQL Server uses a thread synchronization object called a semaphore to keep track of how much memory has been granted. The idea is this: if SQL Server runs out of workspace memory/QE memory, then instead of failing the query execution with an out-of-memory error, it will cause the query to wait for memory. In this context, the Memory Grants Pending Perfmon counter makes sense. And so do wait_time_ms , granted_memory_kb = NULL, timeout_sec in `sys.dm_exec_query_memory_grants` . BTW, this and compile memory are the only places in SQL Server where a query will actually be made to wait for memory if it is not available; in all other cases, the query will fail outright with a 701 error – out of memory.

There is a Wait type in SQL Server that shows that a query is waiting for a memory grant – RESOURCE_SEMAPHORE. As the documentation states, this "occurs when a query memory request cannot be granted immediately due to other concurrent queries. High waits and wait times may indicate excessive number of concurrent queries, or excessive memory request amounts." You will observe this wait type in `sys.dm_exec_requests` for individual sessions. Here is a KB article written primarily for SQL Server 2000 which describes how to troubleshoot this issue and also what happens when a query finally "gets tired" of waiting for a memory grant.


## Why are Memory Grants important to a developer or DBA?

Based on Microsoft support experience, memory grant issues tend to be some of the most common memory-related problems. Applications often execute seemingly simple queries that sometimes end up causing performance issues on the SQL Server side because of huge sort or hash operations.  Such queries not only end up consuming much SQL Server memory during execution, but also cause other queries to have to wait for memory to become available – thus the performance bottleneck.

Using the tools outlined here (DMVs, Perfmon counters and actual query plan), you can identify which queries are large-grant consumers. Then you can tune or re-write these queries to resolve or reduces the workspace memory usage.

## What Can a Developer Do about Sort/Hash Operations?

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


## Memory Grant Internals

To learn more about internals refer [Understanding SQL server memory grant](https://techcommunity.microsoft.com/t5/sql-server-blog/understanding-sql-server-memory-grant/ba-p/383595) blog post




## Summary of Ways to Deal with Large Grants:

- Re-write queries
- Use Resource Governor
- Find appropriate indexes for the query which may reduce the large number of rows processed and thus change the JOIN algorithms (see Database Engine Tuning Advisor and Missing Indexes DMVs)
- Use OPTION (min_grant_percent = XX, max_grant_percent = XX ) hint
- SQL Server 2017 and 2019 introduce Adaptive query processing allowing for Memory Grant feedback mechanism to adjust memory grant size dynamically at run-time.
