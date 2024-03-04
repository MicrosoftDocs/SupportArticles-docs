---
title: Memory-optimized tempdb metadata out of memory errors
description: This article helps you to troubleshoot out-of-memory issues with memory-optimized tempdb metadata.
ms.date: 03/04/2024
ms.custom: sap:Database Engine
ms.reviewer: jopilov, hesha, randolphwest
author: Hemin-msft
ms.author: jopilov
---

# Memory-optimized tempdb metadata (HkTempDB) out of memory errors

This article provides resolutions to troubleshoot out of memory issues related to the memory-optimized `tempdb` metadata feature.

## Symptoms

After you enable the memory-optimized `tempdb` metadata (HkTempDB) feature, you may see the error [701](/sql/relational-databases/errors-events/mssqlserver-701-database-engine-error) indicating out of memory exceptions for `tempdb` allocations and SQL Server Service crashes. In addition, you may see that the memory clerk `MEMORYCLERK_XTP` for In-Memory OLTP (Hekaton) is growing gradually or rapidly and doesn't shrink back. As the XTP memory grows without an upper limit, you see the following error message in SQL Server:

> Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'default'. See '`http://go.microsoft.com/fwlink/?LinkId=510837`' for more information.

When you run a query on the [DMV](/sql/relational-databases/system-dynamic-management-views/system-dynamic-management-views) [dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql), you can see that pages memory allocated is high for memory clerk `MEMORYCLERK_XTP`. For example:

```sql
SELECT type, memory_node_id, pages_kb 
FROM sys.dm_os_memory_clerks
WHERE type = 'MEMORYCLERK_XTP'
```

Result:
  
```output
type                    memory_node_id                     pages_kb
------------------------------------------------------------ -------------- --------------------
MEMORYCLERK_XTP         0                                  60104496
MEMORYCLERK_XTP         64                                 0
```

## Diagnose the issue

To collect data to diagnose the issue, follow these steps:

1. Collect a lightweight trace or extended event (XEvent) to understand `tempdb` workload, and find out if the workload has any long-running explicit transactions with DDL statements on temporary tables.

1. Collect the output of the following DMVs to analyze further.

   ```sql
   SELECT * FROM sys.dm_os_memory_clerks
   SELECT * FROM sys.dm_exec_requests
   SELECT * FROM sys.dm_exec_sessions
   
   -- from tempdb
   SELECT * FROM tempdb.sys.dm_xtp_system_memory_consumers 
   SELECT * FROM tempdb.sys.dm_db_xtp_memory_consumers
   
   SELECT * FROM tempdb.sys.dm_xtp_transaction_stats
   SELECT * FROM tempdb.sys.dm_xtp_gc_queue_stats
   SELECT * FROM tempdb.sys.dm_db_xtp_object_stats
   
   SELECT * FROM tempdb.sys.dm_db_xtp_transactions
   SELECT * FROM tempdb.sys.dm_tran_session_transactions
   SELECT * FROM tempdb.sys.dm_tran_database_transactions
   SELECT * FROM tempdb.sys.dm_tran_active_transactions
   ```

## Cause and resolution

By using the DMVs to verify the cause, you may see different scenarios of the issue. These scenarios can be divided into the following two categories. To resolve the issue, you can use the corresponding resolution for each scenario. For more information on how to alleviate the issue, see [Mitigation steps to keep memory-optimized tempdb metadata memory in check](#mitigation-steps-to-keep-memory-optimized-tempdb-metadata-memory-in-check).

### Gradual increase in XTP memory consumption

- Scenario 1

    The DMV [tempdb.sys.dm_xtp_system_memory_consumers](/sql/relational-databases/system-dynamic-management-views/sys-dm-xtp-system-memory-consumers-transact-sql) or [tempdb.sys.dm_db_xtp_memory_consumers](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-xtp-memory-consumers-transact-sql) shows a large difference between allocated bytes and used bytes.

    **Resolution**: To resolve the issue, you can run the following commands in [SQL Server 2019 CU13](https://support.microsoft.com/topic/kb5005679-cumulative-update-13-for-sql-server-2019-5c1be850-460a-4be4-a569-fe11f0adc535), [SQL Server 2022 CU1](../../releases/sqlserver-2022/cumulativeupdate1.md), or a later version that has a new procedure `sys.sp_xtp_force_gc` to free up allocated but unused bytes.

    > [!NOTE]
    > Starting with [SQL Server 2022 CU1](../../releases/sqlserver-2022/cumulativeupdate1.md), you need to execute the stored procedure only once.

    ```sql
    /* Yes, 2 times for both*/
    EXEC sys.sp_xtp_force_gc 'tempdb'
    GO
    EXEC sys.sp_xtp_force_gc 'tempdb'
    GO
    EXEC sys.sp_xtp_force_gc
    GO
    EXEC sys.sp_xtp_force_gc
    ```

- Scenario 2

    The DMV `tempdb.sys.dm_xtp_system_memory_consumers` shows high values for allocated and used bytes for memory consumer types `VARHEAP` and `LOOKASIDE`.

    **Resolution**: Check for long-running explicit transactions involving DDL statements on temporary tables and resolve from the application side by keeping transactions short.

    > [!NOTE]
    > To reproduce this issue in a test environment, you can create an explicit [transaction](/sql/t-sql/language-elements/begin-transaction-transact-sql) by using Data Definition Language (DDL) statements on temporary table(s) and leave it open for a long time when other activity takes place.

- Scenario 3

    The DMV `tempdb.sys.dm_db_xtp_memory_consumers` shows high values for allocated and used bytes in a large object (LOB) allocator or table heap where `Object_ID`, `XTP_Object_ID`, and `Index_ID` are `NULL`.

    **Resolution**: Apply [SQL Server 2019 CU16](https://support.microsoft.com/topic/kb5011644-cumulative-update-16-for-sql-server-2019-74377be1-4340-4445-93a7-ff843d346896) for the issue [14535149](https://support.microsoft.com/topic/kb5011644-cumulative-update-16-for-sql-server-2019-74377be1-4340-4445-93a7-ff843d346896?msclkid=f1148209c24811ecbfa6aa36a20ffa89#bkmk_14535149).

- Scenario 4

    Continuously growing "VARHEAP\Storage internal heap" XTP database memory consumer leads to out of memory error 41805.

    **Resolution**: The issue [14087445](https://support.microsoft.com/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9#bkmk_14087445) already identified and resolved in [SQL Server 17 CU25](https://support.microsoft.com/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9) and later versions is under examination to be ported over to SQL Server 2019.

### Sudden spike or rapid increase in XTP memory consumption

- Scenario 5

     The DMV `tempdb.sys.dm_db_xtp_memory_consumers` shows high values for allocated or used bytes in a table heap where `Object_ID` isn't `NULL`. The most common cause of this issue is a long-running, explicitly open transaction with DDL statements on temporary table(s). For example:

     ```sql
     BEGIN TRAN
         CREATE TABLE #T(sn int)
         …
         …
     COMMIT
     ```

     An explicitly open transaction with DDL statements on temporary tables won't allow the table heap and lookaside heap to be freed up for subsequent transactions by using `tempdb` metadata.

     **Resolution**: Check for long-running explicit transactions involving DDL statements on temporary tables and resolve from the application side by keeping transactions short.

## Mitigation steps to keep memory-optimized tempdb metadata memory in check

1. To avoid or resolve long-running transactions that use DDL statements on temporary tables, the general guidance is to keep transactions short.

1. Increase **max server memory** to allow for enough memory to operate in the presence of tempdb-heavy workloads.

1. Run `sys.sp_xtp_force_gc` periodically.

1. To protect the server from potential out of memory conditions, you can bind tempdb to a [Resource Governor resource pool](/sql/relational-databases/resource-governor/resource-governor-resource-pool). For example, create a resource pool by using `MAX_MEMORY_PERCENT = 30`. Then, use the following [ALTER SERVER CONFIGURATION](/sql/t-sql/statements/alter-server-configuration-transact-sql) command to bind the resource pool to memory-optimized tempdb metadata.

   ```sql
   ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON (RESOURCE_POOL = '<PoolName>');
   ```

   This change requires a restart to take effect, even if memory-optimized `tempdb` metadata is already enabled. For more information, see:

   - [Configure and use memory-optimized tempdb metadata](/sql/relational-databases/databases/tempdb-database#configure-and-use-memory-optimized-tempdb-metadata).

   - [Create a Resource Pool](/sql/relational-databases/resource-governor/create-a-resource-pool).

   > [!WARNING]
   > After binding HktempDB to a pool, the pool may reach its maximum setting, and any queries that use `tempdb` may fail with out-of-memory errors. For example:
   >
   > Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'HkTempDB'. See '`http://go.microsoft.com/fwlink/?LinkId=510837`' for more information. XTP failed page allocation due to memory pressure: FAIL_PAGE_ALLOCATION 8
   >
   > Under certain circumstances, the SQL Server service could potentially stop if an out-of-memory error occurs. To reduce the chance of this happening, set the memory pool's `MAX_MEMORY_PERCENT` to a high value.

1. The memory-optimized `tempdb` metadata feature doesn't support every workload. For example, using explicit transactions with DDL statements on temporary tables that run for a long time will lead to the scenarios described. If you have such transactions in your workload and you can't control their duration, then perhaps this feature isn't appropriate for your environment. You should test extensively before using `HkTempDB`.

## More information

These sections provide more details about some of the memory components involved in memory-optimized `tempdb` metadata.

### Lookaside memory allocator

Lookaside in In-Memory OLTP is a thread-local memory allocator to help achieve fast transaction processing. Each thread object contains a collection of lookaside memory allocators. Each lookaside associated with each thread has a pre-defined upper limit on how much memory it can allocate. When the limit is reached, the thread allocates memory from a spill-over shared memory pool (`VARHEAP`). The DMV `sys.dm_xtp_system_memory_consumers` aggregates data for each lookaside type (`memory_consumer_type_desc = 'LOOKASIDE'`) and the shared memory pool (`memory_consumer_type_desc = 'VARHEAP'` and  `memory_consumer_desc = 'Lookaside heap'`).

### System-level consumers: tempdb.sys.dm_xtp_system_memory_consumers

About 25 lookaside memory consumer types are the upper limit. When threads need more memory from those lookasides, the memory spills over to and is satisfied with lookaside heap. High values for used bytes could be an indicator of constant heavy `tempdb` workload and/or long-running open transaction that uses temporary objects.

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

### Database-level consumers: tempdb.sys.dm_db_xtp_memory_consumers

- LOB allocator is used for system tables LOB/Off-row data.

- Table heap is used for system tables rows.

High values for used bytes could be the indicator of constant heavy `tempdb` workload and/or long-running open transaction that uses temporary objects.
