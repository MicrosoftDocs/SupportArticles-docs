---
title: Memory Optimized Tempdb Metadata (HkTempDB) Out of memory errors
description: This article describes how to troubleshoot out-of-memory (OOM) issues with Memory-Optimized Tempdb Metadata
ms.date: 11/05/2020
ms.custom: sap:Database Engine
ms.reviewer: PijoCoder, Hemin-MSFT
ms.prod: sql
---

# Memory-Optimized Tempdb Metadata (HkTempDB) Out of memory errors

## Problem Description

After enabling Memory-Optimized TempDB Metadata (HkTempDB), error 701 - Out of Memory exceptions for TempDB Allocations are observed and could crash SQL Server Service.

### Observations:

- You may observe the memory clerk for hekaton- MEMORYCLERK_XTP  is growing steadily or rapidly and doesn’t shrink back
- As the XTP memory grows with no cap, you may observe out-of-memory issues on the SQL Server overall
- Currently, other than sys.sp_xtp_force_gc there's no way to free up HK Memory manually. However it won't help if the difference between Used Bytes and Allocated Bytes isn't large

### Error Message
You'll see messages similar to below where MEMORYCLERK_XTP will be the major culprit
 
`2021-03-19 14:17:33.20 spid21s     Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'default'. See 'http://go.microsoft.com/fwlink/?LinkId=510837' for more information. `

A query on **sys.dm_os_memory_clerks** may show Pages allocated to be very high for MEMORYCLERK_XTP

```sql
SELECT type, memory_node_id, pages_kb 
FROM sys.dm_os_memory_clerks
WHERE type = 'MEMORYCLERK_XTP'
```

Result:
 
```output
type                                                         memory_node_id pages_kb
------------------------------------------------------------ -------------- --------------------
MEMORYCLERK_XTP                                              0              60104496
MEMORYCLERK_XTP                                              64             0
```

## Cause

Several scenarios have been identified that could lead to the symptoms described:

- Situations with gradual increase in XTP memory consumption
   - Scenario 1 large difference between Allocated Bytes and Used Bytes as show by **tempdb.sys.dm_xtp_system_memory_consumers** or **tempdb.sys.dm_db_xtp_memory_consumers**
   - Scenario 2 high values for Allocated and Used bytes in VARHEAP LOOKASIDE as show by **tempdb.sys.dm_xtp_system_memory_consumers**
   - Scenario 3 high values for Allocated and Used bytes in LOB_ALLOCATOR/TABLE HEAP where Object_ID, XTP_Object_ID and Index_ID are NULL
   - Scenario 4 Continuously-growing "VARHEAP\Storage internal heap" XTP DB memory consumer
- Situations with sudden spike or rapid increase in XTP memory consumption
   - Scenario 5 high values for Allocated and Used bytes in TABLE HEAP where Object_ID IS NOT NULL.



#### Gradual increase in XTP memory consumption

1. The DMVs **tempdb.sys.dm_xtp_system_memory_consumers** or **tempdb.sys.dm_db_xtp_memory_consumers** may show large difference between Allocated Bytes and Used Bytes
  
   **Resolution**: SQL Server 2019 CU13 has sys.sp_xtp_force_gc to free up Allocated but Unused bytes on demand by running the following commands:

   ```sql
   /* Yes, 2 times for both*/
   Exec sys.sp_xtp_force_gc 'tempdb'
   GO
   Exec sys.sp_xtp_force_gc 'tempdb'
   GO
   Exec sys.sp_xtp_force_gc
   GO
   Exec sys.sp_xtp_force_gc
   ```

1. The DMV **tempdb.sys.dm_xtp_system_memory_consumers** may show high values for Allocated and Used bytes for VARHEAP LOOKASIDE

   **Resolution**: Check for Long running Transactions and resolve from application side by keeping transactions short. You can easily reproduce this issue in a test environment by creating an explicit BEGIN TRAN with DDL on a temp table and leaving it open for a long time while other activity takes place.

1. The DMV **tempdb.sys.dm_db_xtp_memory_consumers** may show high values for Allocated and Used bytes in LOB_ALLOCATOR/TABLE HEAP where Object_ID, XTP_Object_ID and Index_ID are NULL

   **Resolution**: Root cause has been identified on this issue and a product fix is being examined

1. Issue [14087445](https://support.microsoft.com/en-us/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9#bkmk_14087445) already identified and resolved in SQL Server 17 CU25 is under examination to be ported over to SQL Server 2019: Continuously growing "VARHEAP\Storage internal heap" XTP DB memory consumer leads to out-of-memory error 41805.


#### Sudden spike or rapid increase in XTP memory consumption

The DMV **tempdb.sys.dm_db_xtp_memory_consumers** may show high Allocated/Used bytes for TABLE HEAP where Object_ID IS NOT NULL. The most common cause for this issue is a long-running, explicitly open transaction with DDL on temp table(s). For example:

   ```sql
   BEGIN TRAN
   	CREATE TABLE #T(sn int)
   	…
   	…
   COMMIT
   ```

Explicit open transaction with DDL on temp tables won't allow Table Heap and possibly Varheap: Lookaside Heap to be freed up for subsequent transactions utilizing TempDB metadata

### Internal details

Lookaside in In-Memory OLTP is a thread-local memory allocator to help achieve fast transaction processing. Each thread object contains a collection of lookaside memory allocators. Each lookaside associated with each thread has a pre-defined upper limit on how much memory it can allocate. Once the limit is reached, the thread allocates memory from a spill-over shared memory pool (VARHEAP). The DMV **sys.dm_xtp_system_memory_consumers**  aggregates data for each lookaside type (memory_consumer_type_desc = 'LOOKASIDE') and the shared memory pool (memory_consumer_type_desc = 'VARHEAP' AND memory_consumer_desc = 'Lookaside heap')

#### System-Level Consumers: **tempdb.sys.dm_xtp_system_memory_consumers**

About 25 LOOKASIDE memory consumer types are capped so when threads need more memory from those LookAsides, the memory spills over to and is satisfied from Varheap: LookAside Heap. High Used Bytes could be an indicator of constant heavy TempDB workload and/or long-running open transaction using Temp objects.

```output
memory_consumer_type_desc memory_consumer_desc                       allocated_bytes      used_bytes
------------------------- ------------------------------------------ -------------------- --------------------
VARHEAP                   Lookaside heap                             0                    0
PGPOOL                    256K page pool                             0                    0
PGPOOL                    4K page pool                               0                    0
VARHEAP                   System heap                                458752               448000
LOOKASIDE                 Transaction list element                   0                    0
LOOKASIDE                 Delta tracker cursor                       0                    0
LOOKASIDE                 Transaction delta tracker                  0                    0
LOOKASIDE                 Creation Statement Id Map Entry            0                    0
LOOKASIDE                 Creation Statement Id Map                  0                    0
LOOKASIDE                 Log IO proxy                               0                    0
LOOKASIDE                 Log IO completion                          0                    0
LOOKASIDE                 Sequence object insert row                 0                    0
LOOKASIDE                 Sequence object map entry                  0                    0
LOOKASIDE                 Sequence object values map                 0                    0
LOOKASIDE                 Redo transaction map entry                 0                    0
LOOKASIDE                 Transaction recent rows                    0                    0
LOOKASIDE                 Heap cursor                                0                    0
LOOKASIDE                 Range cursor                               0                    0
LOOKASIDE                 Hash cursor                                0                    0
LOOKASIDE                 Transaction dependent ring buffer          0                    0
LOOKASIDE                 Transaction save-point set entry           0                    0
LOOKASIDE                 Transaction FK validation sets             0                    0
LOOKASIDE                 Transaction partially-inserted rows set    0                    0
LOOKASIDE                 Transaction constraint set                 0                    0
LOOKASIDE                 Transaction save-point set                 0                    0
LOOKASIDE                 Transaction write set                      0                    0
LOOKASIDE                 Transaction scan set                       0                    0
LOOKASIDE                 Transaction read set                       0                    0
LOOKASIDE                 Transaction                                0                    0
```

#### Database-Level Consumers: **tempdb.sys.dm_db_xtp_memory_consumers**

- LOB_Allocator is used for system tables LOB/Off-row data
- Table Heap: Used for system tables rows

High Used Bytes could be the indicator of constant heavy TempDB workload and/or long running open transaction using Temp objects.

## Resolution

The following steps will highlight what data to collect to diagnose the problem and how to alleviate the issue

### Data to Collect

If you face the issues described:

1. Collect a light Trace/XE to understand TempDB workload and find out if the workload has any explicit long-running transactions with DDL on temp tables
1. Collect the output of these DMVs to analyze further

   ```sql
   SELECT * FROM  sys.dm_os_memory_clerks
   SELECT * FROM  sys.dm_tran_database_transactions
   SELECT * FROM  sys.dm_tran_active_transactions
   -- from tempdb
   SELECT * FROM  tempdb.sys.dm_xtp_system_memory_consumers 
   SELECT * FROM  tempdb.sys.dm_xtp_transaction_stats
   SELECT * FROM  tempdb.sys.dm_xtp_gc_queue_stats
   SELECT * FROM  tempdb.sys.dm_db_xtp_object_stats
   SELECT * FROM  tempdb.sys.dm_db_xtp_memory_consumers
   ```

### Mitigation Steps to try to keep memory-optimized tempdb metadata memory in check:

1. Avoid or resolve long-running transactions that perform temp table DDL operations. General guidance is to keep transactions short.
1. Increase `max server memory` to allow for enough memory to operate in the presence of Tempdb-heavy workloads
1. Execute sys.sp_xtp_force_gc periodically
1. To protect the server from potential out-of-memory conditions, you can bind tempdb to a resource pool. This is done through the ALTER SERVER command. This change also requires a restart to take effect, even if memory-optimized tempdb metadata is already enabled. For more information see [Configuring memory-optimized tempdb metadata](/sql/relational-databases/databases/tempdb-database#configuring-and-using-memory-optimized-tempdb-metadata)
   ```sql
   ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON (RESOURCE_POOL = 'pool_name');
   ```
1. Memory-optimized tempDB metadata feature is not for every workload. For example, using explicit transactions with DDL on temp tables that run for a long time will lead to many of the scenarios described. If you have such transactions in your workload and you cannot control their duration, then perhaps this features is not appropriate for your environment. You should test extensively before using HkTempDB.

