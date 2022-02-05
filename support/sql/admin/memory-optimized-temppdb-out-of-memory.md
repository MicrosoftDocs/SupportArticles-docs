# SQL 2019 Memory Optimized Tempdb Metadata (HkTempDB) Out of memory errors


## Problem Description
After enabling HkTempDB - Memory Optimized TempDB Metadata, error 701 - Out of Memory exceptions for TempDB Allocations are observed and could crash SQL Server Service.

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

This is currently due to possible HK Memory Leaks and a limitation where the Cleanup of the Hekaton memory kicks in only when SQL OS detects memory-pressure and notify Hekaton to cleanup.
Or due to explicit long running transactions with DDL on temp tables.

### Different variations of this issue: 

Slow Gradual Increase in XTP memory consumption

1. tempdb.sys.dm_xtp_system_memory_consumers or tempdb.sys.dm_db_xtp_memory_consumers will show high difference in Allocated Bytes and Used Bytes
	- SQL19 CU13 has sys.sp_xtp_force_gc to free up Allocated but Unused bytes on demand by running the following:

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
	
1. tempdb.sys.dm_xtp_system_memory_consumers will show high Allocated/Used bytes for VARHEAP LOOKASIDE
	- Waiting on PG for further analysis and updates RFC 14327018:
	Hotfix 14508625: This is to backport improvements done by Hugh for sys.dm_xtp_system_memory_consumers and improvements that can shrink LOOKASIDES.
	DMV improvements should help narrow down the consumers at granular level for further troubleshooting
	- Check for Long running Transactions, we can repro this internally with explicit BEGIN TRAN with DDL on temp table
	
1. tempdb.sys.dm_db_xtp_memory_consumers will show high Allocated/Used bytes for LOB_ALLOCATOR/TABLE HEAP where Object_ID, XTP_Object_ID and Index_ID are NULL
	- Waiting on PG to confirm if the fixes will be part of CU16
	- Ref: hkruntime.cpp - OpenGrok cross reference for /Sql/Ntdbms/Hekaton/runtime/src/hkruntime.cpp
	Hotfix 14535149: Opened for the same. Root cause identified by PG.

1. Hotfix 14332252:Port from SQL17 RTM CU25 to SQL19 RTM CU15: Evergrowing "VARHEAP\Storage internal heap" XTP DB memory consumer brings OOM error 41805


Sudden Spike/Rapid Increase in XTP memory consumption
	A. tempdb.sys.dm_db_xtp_memory_consumers will show high Allocated/Used bytes for TABLE HEAP where Object_ID IS NOT NULL
	- Most likely due to long running open explicit transaction with DDL on temp table
	- For e.g.
	
```sql
BEGIN TRAN
	CREATE TABLE #T(sn int)
	…
	…
COMMIT
```
	
- Explicit open transaction with DDL on temp tables will not allow Table Heap and possibly Varheap: Lookaside Heap to be freed up for subsequent transactions utilizing TempDB metadata


**INTERNALS HERE???**
**ARE THEY REALLY SO SECRETIVE INTERNAL?**

## Resolution

The following steps will highlight what data to collect to diagnose the problem and how to alleviate the issue

### Data to Collect

If you face similar issue
1. Collect a Light weight PSSDIAG or Trace/XE to understand TempDB workload + if the workload has any explicit long running transactions with DDL on temp tables
1. Collect the below DMVs to analyze further

```sql
select * from sys.dm_os_memory_clerks
select * from sys.dm_tran_database_transactions
select * from sys.dm_tran_active_transactions
-- from tempdb
select * from tempdb.sys.dm_xtp_system_memory_consumers 
select * from tempdb.sys.dm_xtp_transaction_stats
select * from tempdb.sys.dm_xtp_gc_queue_stats
select * from tempdb.sys.dm_db_xtp_object_stats
Select * from tempdb.sys.dm_db_xtp_memory_consumers
select OBJECT_NAME(object_id),(rows_expired-rows_expired_removed) DIF,* from tempdb.sys.dm_db_xtp_index_stats
```

### Mitigation Steps to try to keep HkTempDB memory in check:

1. Avoid long running transactions doing temp table DDL operations 
1. Bump up max server memory so that we have enough room to operate in the presence of Tempdb-heavy workloads. 
1. Executing sys.sp_xtp_force_gc 
1. SQL Service Restart or Disabling HkTempDB feature
