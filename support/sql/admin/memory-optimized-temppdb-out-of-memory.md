# Memory Optimized Tempdb Metadata (HkTempDB) Out of memory errors

## Problem Description

After enabling Memory-Optimized TempDB Metadata (HkTempDB), error 701 - Out of Memory exceptions for TempDB Allocations are observed and could crash SQL Server Service.

### Observations:

- You may observe the memory clerk for hekaton- MEMORYCLERK_XTP  is growing steadily or rapidly and doesn’t shrink back
- As the XTP grows (with no cap) you may observe out-of-memory issues on the SQL Server overall
- Currently, other than sys.sp_xtp_force_gc there is no way to free up HK Memory manually (will not help if the difference between Used Bytes and Allocated Bytes is not huge)

### Error Message
You will see messages similar to below where MEMORYCLERK_XTP will be the major culprit
 
`2021-03-19 14:17:33.20 spid21s     Disallowing page allocations for database 'tempdb' due to insufficient memory in the resource pool 'default'. See 'http://go.microsoft.com/fwlink/?LinkId=510837' for more information. `

DBCC MEMORYSTATUS may show Pages Allocated to be very high for MEMORYCLERK_XTP
 
```output
MEMORYCLERK_XTP (Total)                         KB
---------------------------------------- ----------
VM Reserved                                       0
VM Committed                                      0
Locked Pages Allocated                            0
SM Reserved                                       0
SM Committed                                      0
Pages Allocated                            60104496
2021-03-19 14:17:33.21 spid70      
```

## Cause

This issue could be caused by In-Memory OLTP (Hekaton) memory leaks and a limitation where the Cleanup of the Hekaton memory is triggered only when SQL OS detects memory-pressure and notifies Hekaton to cleanup. Alternatively, this could be caused by an explicit long-running transactions with DDL on temp tables.

### Different variations of this issue:

There are two main symtom-based variation of this issue:

1. Gradual increase in XTP memory consumption
1. Sudden spike or rapid increase in XTP memory consumption

#### Gradual increase in XTP memory consumption

1. The stored procedures **tempdb.sys.dm_xtp_system_memory_consumers** or **tempdb.sys.dm_db_xtp_memory_consumers** may show high difference between Allocated Bytes and Used Bytes
  
   **Resolution**: SQL Server 2019 CU13 has sys.sp_xtp_force_gc to free up Allocated but Unused bytes on demand by running the following:

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

1. The stored procedure **tempdb.sys.dm_xtp_system_memory_consumers** may show high Allocated/Used bytes for VARHEAP LOOKASIDE

   **Resolution**: Check for Long running Transactions and resolve this from application side. Microsoft can reproduce this by creating an explicit BEGIN TRAN with DDL on a temp table

1. The stored procedure **tempdb.sys.dm_db_xtp_memory_consumers** may show high Allocated/Used bytes for LOB_ALLOCATOR/TABLE HEAP where Object_ID, XTP_Object_ID and Index_ID are NULL

   **Resolution**: Root cause has been identified on this issue and a product fix is being examined

1. Issue [14087445](https://support.microsoft.com/en-us/topic/kb5003830-cumulative-update-25-for-sql-server-2017-357b80dc-43b5-447c-b544-7503eee189e9#bkmk_14087445) already identified and resolved in SQL Server 17 CU25 is under examination to be ported over to SQL Server 2019: Contniously-growing "VARHEAP\Storage internal heap" XTP DB memory consumer leads to out-of-memory error 41805.


#### Sudden spike or rapid increase in XTP memory consumption

The stored procedure **tempdb.sys.dm_db_xtp_memory_consumers** may show high Allocated/Used bytes for TABLE HEAP where Object_ID IS NOT NULL. The most common cause for this is a long-running, explicitly-open transaction with DDL on temp table(s). For example:

   ```sql
   BEGIN TRAN
   	CREATE TABLE #T(sn int)
   	…
   	…
   COMMIT
   ```

Explicit open transaction with DDL on temp tables will not allow Table Heap and possibly Varheap: Lookaside Heap to be freed up for subsequent transactions utilizing TempDB metadata

### Internal details

#### System-Level Consumers: **tempdb.sys.dm_xtp_system_memory_consumers**

About 25 LOOKASIDE memory consumer types are capped so when threads need more memory from those LookAsides, the memory spills over to and is satisfied from Varheap: LookAside Heap. High Used Bytes could be an indicator of constant heavy TempDB workload and/or long-running open transaction using Temp objects.

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
   SELECT OBJECT_NAME(object_id),(rows_expired-rows_expired_removed) DIF,* from tempdb.sys.dm_db_xtp_index_stats
   ```

### Mitigation Steps to try to keep memory-optimized tempdb metadata memory in check:

1. Avoid long-running transactions that perform temp table DDL operations
1. Increase `max server memory` to allow for enough memory to operate in the presence of Tempdb-heavy workloads
1. Execute sys.sp_xtp_force_gc periodically
1. Last resort: restart SQL Service or Disabling HkTempDB feature
