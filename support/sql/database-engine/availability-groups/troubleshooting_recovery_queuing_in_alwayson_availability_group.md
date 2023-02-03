---
title: Troubleshooting recovery queuing in an AlwaysOn availability group
description: This article provides resolutions for the common problem about Always On configuration on SQL server.
ms.date: 08/03/2020
ms.custom: sap:Availability Groups
ms.prod: sql
---

## What is recovery queueing?

Changes made to an availability group database on the primary replica are sent to all secondary replicas defined in the same availability group. Once those arrive at the secondary replica, they are first written to the transaction log file of the availability group database. SQL Server then uses the 'recovery' or 'redo' operation to update the database file(s).

If the changes to an availability group arrive and harden on the database transaction log file faster than they can be recovered, then a recovery 'queue' is formed. This is composed of hardened transaction log transactions that haven't been recovered into the database.

## Symptoms and impact of recovery (redo) queueing

**Querying secondary replica returns different results than the primary replica** - Read only workloads which query secondary replicas may query stale data. If there is recovery queuing, changes to data on the primary replica database might not reflect in the secondary database when querying the same data.

Although changes arrive at the secondary and are written to the database log file, the changes won’t be queried until they are 'recovered' into the database files. The recovery operation is what makes those changes readable.

For more information, see the section [Data latency on secondary replica in Differences between availability modes for an Always On availability group](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups?view=sql-server-ver16).

**Failover Time is Longer or Recovery Time Objective (RTO) is violated** - RTO is the maximum database downtime an organization can handle or how quickly the organization can regain access to the database after an outage. If substantial recovery queueing is present on a secondary replica and a failover occurs, recovery may take longer before the database will transition to the primary role and represent the state of the database prior to the failover. This can delay the resumption of production after failover.

**Various diagnostic features report availability group recovery queuing** - When there is recovery queueing, the Always On dashboard in SQL Server Management Studio might report an unhealthy availability group.

## How to check for recovery (redo) queueing

Recovery queue is a per-database measurement and can be checked using the Always On dashboard on the primary replica or using the `sys.dm_hadr_database_replica_states` DMV on the primary or secondary replica. There are Performance Monitor counters for checking recovery queuing and recovery rate. The performance monitor counters must be checked against the secondary replica.

The next few sections provide ways you can actively monitor your availability group database recovery queue.

**Query sys.dm_hadr_database_replica_states** - The DMV `sys.dm_hadr_database_replica_states` report a row for each availability group database and one column is the `redo_queue_size`. The `redo_queue_size` reports the recovery queue size in kilobytes. You can set up a query that resembles the following query to monitor any trend in the redo queue size every 30 seconds. The query is being run on the primary replica and it uses the predicate `is_local=0` to report the data for the secondary replica, where `redo_queue_size` and `redo_rate` are relevant.

```sql
WHILE 1=1
BEGIN
SELECT drcs.database_name, ars.role_desc, drs.redo_queue_size, drs.redo_rate,
ars.recovery_health_desc, ars.connected_state_desc, ars.operational_state_desc, ars.synchronization_health_desc, *
FROM sys.dm_hadr_availability_replica_states ars JOIN sys.dm_hadr_database_replica_cluster_states drcs ON ars.replica_id=drcs.replica_id
JOIN sys.dm_hadr_database_replica_states drs ON drcs.group_database_id=drs.group_database_id
WHERE ars.role_desc='SECONDARY' AND drs.is_local=0
waitfor delay '00:00:30'
END
```

Here is what the output looks like:

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/dm_hadr_database_replica_states_output.png" alt-text="Report the data for the secondary replica, where redo_queue_size and redo_rate are relevant.":::

**Review the Recovery Queue in AlwaysOn Dashboard**

To review the recovery queue, perform the following steps:

1. Open the AlwaysOn Dashboard in SQL Server Management Studio (SSMS).
1. Right-click on an availability group in the SSMS Object Explorer and select **Show Dashboard**.

    The availability group databases are listed last, and there’s some data reported on the databases. Although Redo Queue Size (KB) and Redo Rate (KB/sec) aren't listed by default, they can be added to this view, as shown in the following screenshot.

1. To add these counters, right-click the header above the database reports and choose from the list of columns that can be added.

1. Right-click on the header highlighted in red in the following screenshot, to add **Redo Queue Size (KB)** and **Redo Rate (KB/sec)**.
  
    :::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/add_redo_queue_size_rate.png" alt-text="Add the counters Redo Queue Size (KB) and Redo Rate (KB/sec)":::

1. By default, the Always On dashboard auto refreshes **Redo Queue Size (KB)** and **Redo Rate (KB/sec)** every 60 seconds.

    :::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/add_redo_queue_size_rate_refreshes_60.png" alt-text="Refresh counters every 60 seconds.":::

**Review the Recovery Queue in performance monitor**

The recovery queue size is unique to each secondary replica and database. Therefore, to review the recovery queue of an availability group database, perform the following steps.

1. Open the Performance Monitor on the secondary replica.

1. Click the **Add** (counter) button.

1. Under **Available counters**, select **SQLServer:Database Replica** and select **Recovery Queue** and **Redone Bytes/sec** counters.

1. In the **Instance** box, select the availability group database you wish to monitor for recovery queuing.

1. Select **Add** and **OK**.

Here is a screenshot of what increasing recovery queueing might look like:

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/increase_recovery_queueing_graph.png" alt-text="Increase recovery queueing.":::

## How to Diagnose Recovery (Redo) Queueing

After you have identified recovery queuing for a specific secondary replica availability group database, connect to the secondary replica and query `sys.dm_exec_requests` to determine the `wait_type` and `wait_time` for recovery threads. Here is a query that can be executed in a loop. We are looking for a high frequency of one or more wait types and even wait times for those wait types. Here is a sample query that runs every second and reports the wait types and wait times for the availability group 'agdb':

```sql
WHILE (1=1)
BEGIN
SELECT db_name(database_id) AS dbname, command, session_id, database_id, wait_type, wait_time,
os.runnable_tasks_count, os.pending_disk_io_count FROM sys.dm_exec_requests der join sys.dm_os_schedulers os
ON der.scheduler_id=os.scheduler_id
WHERE command IN('PARALLEL REDO HELP TASK', 'PARALLEL REDO TASK', 'DB STARTUP')
AND database_id= db_id('agdb')
waitfor delay '00:00:05.000'
END
```

> [!IMPORTANT]
> For meaningful waittype output, recovery queueing should be observed to be increasing using one of the preceding methods described when monitoring this condition.

In this example, there are some I/O related wait types reported (PAGEIOLATCH_UP, PAGEIOATCH_EX), monitors to check if these wait types continue to have the largest `wait_times` reported in the next column.

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/input_output_related_waittimes.png" alt-text="Largest wait_times reported in the next column.":::

**SQL Server redo wait types** - When a wait type is identified, review the following article [SQL Server 2016/2017: Availability group secondary replica redo model and performance - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/sql-server/sql-server-2016-2017-availability-group-secondary-replica-redo/ba-p/385905%22%20/t%20%22_blank) as a cross-reference for common wait types that cause recovery queuing and how to resolve.

## Other possible cause of recovery queuing - Blocked redo

If your solution directs reporting (querying) against availability group databases on the secondary replica, these read-only queries acquire schema stability (Sch-S) locks. These Sch-S locks can block redo threads from acquiring schema modification (Sch-M) locks to make any data definition language (DDL) changes such as `ALTER TABLE` or `ALTER INDEX` for example. A blocked redo thread can't apply log records until it's unblocked and this can lead to recovery queuing.

To check for historical evidence of blocked Redo, open the **AlwaysOn_health Xevent** trace files on the secondary replica using SQL Server Management Studio. Look for `lock_redo_blocked` events:

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/alwayson_health_xevent.png" alt-text="Check for historical evidence of blocked Redo.":::

Use Performance Monitor to actively monitor blocked redo impact to recovery queue. Add the **SQL Server::Database Replica::Redo blocked/sec** and **SQL Server::Database Replica::Recovery Queue** counters. The following screenshot shows when an `ALTER TABLE ALTER COLUMN` command is run against the primary replica while a long running query is run against the same table on the secondary replica. The **Redo blocked/sec** counter indicates the `ALTER TABLE ALTER COLUMN` command is run. While the long running query is running on the same table on the secondary replica, any subsequent changes on the primary will result in increasing the redo queue.

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/monitor_blocked_redo_impact_to_recovery_queue.png" alt-text="Monitor for schema modification lock wait type.":::

Monitor for schema modification lock wait type using the query described earlier to monitor the wait types reported for redo operations, against `sys.dm_exec_requests`. You can observe the increasing wait time for the `LCK_M_SCH_M` (schema modification locks the redo thread is attempting to acquire) from ongoing redo blockage:

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/increase_wait_time_lck_m_sch_m.png" alt-text="observe the increasing wait time for the LCK_M_SCH_M.":::

## Other possible causes of recovery queuing - Single Threaded Redo

SQL Server introduced parallel recovery for secondary replica databases in SQL Server 2016. If you are experiencing recovery queuing while running SQL Server 2012 or SQL Server 2014, upgrading to newer versions may improve redo performance in your production environment.

Single threaded redo can occur even on later, more advanced SQL Server versions where parallel recovery architecture is used, On these versions, a SQL Server instance can use up to 100 threads for parallel redo. Depending on the number of processors and availability group databases, parallel redo threads are allocated and the number approaches 100 total threads. In such a case, when the 100 thread redo thread limit is reached some databases in the availability group are assigned a single redo thread.

To determine if your availability group database is using parallel recovery, connect to the secondary replica and use the following query to determine the number of rows (threads) that apply recovery for the availability group database. In the following example, if the 'agdb' database is a single thread and its command is `DB STARTUP`, the recovery workload may benefit from parallel recovery.

```sql
SELECT db_name(database_id) AS dbname, command, session_id, database_id, wait_type, wait_time,
os.runnable_tasks_count, os.pending_disk_io_count FROM sys.dm_exec_requests der join sys.dm_os_schedulers os
ON der.scheduler_id=os.scheduler_id
WHERE command IN('PARALLEL REDO HELP TASK', 'PARALLEL REDO TASK', 'DB STARTUP')
AND database_id= db_id('agdb')
```

:::image type="content" source="media/troubleshooting-recovery-queuing-in-alwayson-availability-group/single_thread_db_startup,png.png" alt-text="Determine the number of rows (threads) that apply recovery for the availability group.":::

If you have confirmed your database is using single threaded redo, review the algorithm described previously to determine if SQL Server is exceeding the number of 100 worker threads dedicated for parallel recovery. This might be the reason that the 'agdb’ database is using a single thread only for recovery.

SQL Server 2022 now implements a new parallel recovery algorithm so that worker threads are assigned for parallel recovery based on the workload, which eliminates the chances of a busy database remaining in single threaded recovery. For more information, see [Thread Usage by Availability Groups](/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability).

