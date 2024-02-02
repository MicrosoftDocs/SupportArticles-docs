---
title: Query performance degradation on secondary replicas
description: This article helps you resolve the problem where you experience query performance issues on read-only secondary replicas.
ms.date: 09/25/2020
ms.custom: sap:Availability Groups
---
# Query execution takes longer on SQL Server Always On secondary replicas

This article helps you resolve the problem where you experience query performance issues on read-only secondary replicas.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4040549

## Symptoms

Assume that you have a Microsoft SQL Server Always On Availability Group member database that contains one or more large tables that have a `clustered row-store` index. A query of one or more of the large tables completes faster on the primary replica than on a secondary replica.

**Notes**

- The query causes a clustered index scan of a large part of the table.
- The query uses the **NOLOCK** hint.
- The execution plan operators and operator order are identical for both fast and slow executions.
- Querying [sys.dm_db_index_physical_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-index-physical-stats-transact-sql) reveals significant fragmentation of the clustered index.
- Unjoining the database from the Always On Availability Group improves performance on the same (former) secondary replica instance, so that it is similar to performance on the primary replica.

## Cause

When Snapshot Isolation is enforced, **NOLOCK** hints are ignored. The discrepancy in execution duration between the primary and secondary replicas occurs because the **NOLOCK** hint is ignored on the read-only secondary replica where Snapshot Isolation is enforced but not on the primary replica where Snapshot Isolation is not enforced by default. This causes the scan of the clustered index to have key order enforced on the secondary replica. On the primary replica, the **NOLOCK** hint takes precedence and does affect behavior. When the clustered index is highly fragmented, the enforcement of key order for the scan on the read-only secondary replica causes SQL Server to issue single-page reads. But on the primary replica, SQL Server does an allocation unit scan to read multiple pages per IO request.

## Resolution

To fix this issue, rebuild the index on the primary replica. This operation then propagates to secondary replicas. For more information, see [Recommendations for Index Maintenance with Always On Availability Groups](/archive/blogs/alwaysonpro/recommendations-for-index-maintenance-with-alwayson-availability-groups).

## More information

The `SET STATISTICS IO` and execution plan Actual I/O Statistics information may not help in diagnosis when this problem occurs. These give you information about the number of pages that are read but not the number of IO operations to read the pages.

Instead, first look for fragmentation of the clustered index. Additionally, you might collect the Performance Monitor IO Read Operations/sec and IO Read Bytes/sec [Process Counters](/previous-versions/ms804621(v=msdn.10)) two times-once when you run the query with the database in the Availability Group, and again from the same instance when the database is removed from the Availability Group and brought online. If index fragmentation is causing single-page reads on the secondary replica but not on the primary replica, you would expect to see a larger number of read IO/sec and a smaller number of read bytes/sec when the database is in the Availability Group as compared to when it's not.

Additionally, this behavior may occur but not noticeably manifest in all environments. For example, an IO subsystem that can handle the increased level of IO/sec with minimal latency and similar throughput could allow for this issue to go unnoticed.
