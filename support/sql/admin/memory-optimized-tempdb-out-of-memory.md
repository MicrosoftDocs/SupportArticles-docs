---
title: Memory optimized tempdb metadata out of memory errors
description: Provides resolutions to troubleshoot out of memory issues with memory-optimized tempdb metadata.
ms.date: 2/22/2022
ms.custom: sap:Database Engine
ms.reviewer: pijocoder, Hemin-msft
author: Hemin-msft
ms.author: pijocoder
ms.prod: sql
---

# Memory-optimized tempdb metadata (HkTempDB) out of memory errors

This article provides resolutions to troubleshoot out of memory issues related to the memory-optimized tempdb metadata feature.

## Symptoms

After you enable the memory-optimized tempdb metadata (HkTempDB) feature, error 701 - out of memory exceptions for tempdb allocations are observed and SQL Server Service crashes.

### Observations

- You may observe the memory clerk `MEMORYCLERK_XTP` for In-Memory OLTP (Hekaton) is growing steadily or rapidly and doesn't shrink back.

- As the XTP memory grows without an upper limit, you may observe the out of memory issues in SQL Server.

### Error message

You can see the following error message where `MEMORYCLERK_XTP` is the major cause.
 
> Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'default'. See '`http://go.microsoft.com/fwlink/?LinkId=510837`' for more information.

> [!NOTE]
> A query on the DMV `dm_os_memory_clerks` may show pages memory allocated to be high for memory clerk `MEMORYCLERK_XTP`. For example:
> 
> ```sql
> SELECT type, memory_node_id, pages_kb 
> FROM sys.dm_os_memory_clerks
> WHERE type = 'MEMORYCLERK_XTP'
> ```
> Result:
>  
> ```output
> type                    memory_node_id                     pages_kb
> ------------------------------------------------------------ -------------- --------------------
> MEMORYCLERK_XTP         0                                  60104496
> MEMORYCLERK_XTP         64                                 0
> ```

## Cause and resolution

The causes of the symptoms can be divided into the following two categories:

### Gradual increase in XTP memory consumption

- Cause 1

    The DMV `tempdb.sys.dm_xtp_system_memory_consumers` or `tempdb.sys.dm_db_xtp_memory_consumers` shows large difference between allocated bytes and used bytes.

    **Resolution**: To resolve the issue, you can run the following commands in [SQL Server 2019 CU13](https://support.microsoft.com/topic/kb5005679-cumulative-update-13-for-sql-server-2019-5c1be850-460a-4be4-a569-fe11f0adc535) or a later version that has a new procedure `sys.sp_xtp_force_gc` to free up allocated but unused bytes.

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

- Cause 2

    The DMV `tempdb.sys.dm_xtp_system_memory_consumers` shows high values for allocated and used bytes for memory consumer types VARHEAP and LOOKASIDE.

    **Resolution**: Check for long running transactions and resolve from application side by keeping transactions short.

    > [!NOTE]
    > To reproduce this issue in a test environment, you can create an explicit [BEGIN TRANSACTION](/sql/t-sql/language-elements/begin-transaction-transact-sql) by using Data Definition Language (DDL) in a temporal table and leave it open for a long time while other activity takes place.

- Cause 3

    The DMV `tempdb.sys.dm_db_xtp_memory_consumers` shows high values for allocated and used bytes in a large object (LOB) allocator or table heap where `Object_ID`, `XTP_Object_ID` and `Index_ID` are `NULL`.

    **Resolution**: Root cause has been identified on this issue and a product fix is being examined.

- Cause 4

    Continuously growing "VARHEAP\Storage internal heap" XTP DB memory consumer leads to out of memory error 41805.

    **Resolution** The issue [14087445](https://support.microsoft.com/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9#bkmk_14087445) already identified and resolved in [SQL Server 17 CU25](https://support.microsoft.com/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9) and later versions is under examination to be ported over to SQL Server 2019.

### Sudden spike or rapid increase in XTP memory consumption

   - Cause 5

     The DMV `tempdb.sys.dm_db_xtp_memory_consumers` shows high allocated or used bytes for table heap where `Object_ID` isn't `NULL`. The most common cause for this issue is a long-running, explicitly open transaction with DDL in temporal table(s). For example:
        
     ```sql
     BEGIN TRAN
         CREATE TABLE #T(sn int)
         …
         …
     COMMIT
     ```

     Explicit open transaction with DDL in temporal tables won't allow table heap and Lookaside heap to be freed up for subsequent transactions using TempDB metadata.

## Internal details

Lookaside in In-Memory OLTP is a thread-local memory allocator to help achieve fast transaction processing. Each thread object contains a collection of lookaside memory allocators. Each lookaside associated with each thread has a pre-defined upper limit on how much memory it can allocate. Once the limit is reached, the thread allocates memory from a spill-over shared memory pool (VARHEAP). The DMV `sys.dm_xtp_system_memory_consumers` aggregates data for each lookaside type (`memory_consumer_type_desc = 'LOOKASIDE'`) and the shared memory pool (`memory_consumer_type_desc = 'VARHEAP'` and  `memory_consumer_desc = 'Lookaside heap'`).

## System-level consumers: tempdb.sys.dm_xtp_system_memory_consumers

About 25 lookaside memory consumer types are the upper limit, when threads need more memory from those lookasides, the memory spills over to and is satisfied from lookaside heap. High used bytes could be an indicator of constant heavy tempdb workload and/or long-running open transaction using temporary objects.

```sql
-- system memory consumers @ instance  
SELECT memory_consumer_type_desc, memory_consumer_desc, allocated_bytes, used_bytes
FROM sys.dm_xtp_system_memory_consumers 
```

```output
memory_consumer_type_desc     memory_consumer_desc                   allocated_bytes      used_bytes
------------------------- ------------------------------------------ -------------------- --------------------
VARHEAP                       Lookaside heap                             0                    0
PGPOOL                        256K page pool                             0                    0
PGPOOL                        4K page pool                               0                    0
VARHEAP                       System heap                                458752               448000
LOOKASIDE                     Transaction list element                   0                    0
LOOKASIDE                     Delta tracker cursor                       0                    0
LOOKASIDE                     Transaction delta tracker                  0                    0
LOOKASIDE                     Creation Statement Id Map Entry            0                    0
LOOKASIDE                     Creation Statement Id Map                  0                    0
LOOKASIDE                     Log IO proxy                               0                    0
LOOKASIDE                     Log IO completion                          0                    0
LOOKASIDE                     Sequence object insert row                 0                    0
LOOKASIDE                     Sequence object map entry                  0                    0
LOOKASIDE                     Sequence object values map                 0                    0
LOOKASIDE                     Redo transaction map entry                 0                    0
LOOKASIDE                     Transaction recent rows                    0                    0
LOOKASIDE                     Heap cursor                                0                    0
LOOKASIDE                     Range cursor                               0                    0
LOOKASIDE                     Hash cursor                                0                    0
LOOKASIDE                     Transaction dependent ring buffer          0                    0
LOOKASIDE                     Transaction save-point set entry           0                    0
LOOKASIDE                     Transaction FK validation sets             0                    0
LOOKASIDE                     Transaction partially-inserted rows set    0                    0
LOOKASIDE                     Transaction constraint set                 0                    0
LOOKASIDE                     Transaction save-point set                 0                    0
LOOKASIDE                     Transaction write set                      0                    0
LOOKASIDE                     Transaction scan set                       0                    0
LOOKASIDE                     Transaction read set                       0                    0
LOOKASIDE                     Transaction                                0                    0
```

## Database-level consumers: tempdb.sys.dm_db_xtp_memory_consumers

- LOB allocator is used for system tables LOB/Off-row data.

- Table heap is used for system tables rows.

High used bytes could be the indicator of constant heavy tempdb workload and/or long running open transaction using temporary objects.

## Diagnose and alleviate the issue

The following steps highlight what data to collect to diagnose the problem and how to alleviate the issue.

### Data to collect

To diagnose the problem, run the following steps:

1. Collect a lightweight trace or extended event (XEvent) to understand tempdb workload, and find out if the workload has any explicit long-running transactions with DDL in temporal tables.

1. Collect the output of the following DMVs to analyze further.

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

### Mitigation steps to keep memory-optimized tempdb metadata memory in check

1. Avoid or resolve long-running transactions that use DDL in temporal tables. General guidance is to keep transactions short.

1. Increase **max server memory** to allow for enough memory to operate in the presence of tempdb-heavy workloads.

1. Execute `sys.sp_xtp_force_gc` periodically.

1. To protect the server from potential out of memory conditions, you can bind tempdb to a Resource Governor resource pool. For example, create a resource pool by using `MAX_MEMORY_PERCENT = 30`. Then use the following [ALTER SERVER CONFIGURATION](/sql/t-sql/statements/alter-server-configuration-transact-sql) command to bind the resource pool to memory-optimized tempdb metadata. This change requires a restart to take effect, even if memory-optimized tempdb metadata is already enabled. For more information, see [Configuring memory-optimized tempdb metadata](/sql/relational-databases/databases/tempdb-database#configuring-and-using-memory-optimized-tempdb-metadata).

   ```sql
   ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON (RESOURCE_POOL = 'pool_name');
    ```

   > [!WARNING]
   > After binding HktempDB to a pool, the pool may reach its maximum setting and any queries using tempdb may fail with out of memory errors. SQL Service will continue functioning but tempdb-heavy workload may be impacted. You may see the following error:
   >
   > > Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'HkTempDB'. See '`http://go.microsoft.com/fwlink/?LinkId=510837`' for more information. XTP failed page allocation due to memory pressure: FAIL_PAGE_ALLOCATION 8

1. Memory-optimized tempdb metadata feature isn't for every workload. For example, using explicit transactions with DDL in temporal tables that run for a long time will lead to many of the scenarios described. If you have such transactions in your workload and you can't control their duration, then perhaps this feature isn't appropriate for your environment. You should test extensively before using HkTempDB.

