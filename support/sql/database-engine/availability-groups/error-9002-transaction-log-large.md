---
title: Error 9002 when transaction log is large
description: This article describes troubleshooting steps that may help resolve problems that occur when the transaction log becomes large or runs out of space in SQL Server.
ms.date: 07/22/2020
ms.custom: sap:Availability Groups
ms.reviewer: ramakoni, amamun
---
# Error 9002: The transaction log for database is full due to AVAILABILITY_REPLICA error message in SQL Server

This article helps you resolve the 9002 error that occurs when the transaction log becomes large or runs out of space in SQL Server.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 2922898

## Symptoms

Consider the following scenario:

- You have Microsoft SQL Server 2012 or a later version installed on a server.
- The instance of SQL Server is a primary replica in Always On Availability Groups environment.
- The **autogrow** option for transaction log files is set in SQL Server.

In this scenario, the transaction log may become large and run out of disk space or exceed the **MaxSize** option set for the transaction log at the primary replica and you receive an error message that resembles the following:

> Error: 9002, Severity: 17, State: 9.
The transaction log for database '%.*ls' is full due to 'AVAILABILITY_REPLICA'

## Cause

This occurs when the logged changes at primary replica aren't yet hardened on the secondary replica. For more information regarding data synchronization process in Always On environment, see [Data Synchronization Process](/sql/database-engine/availability-groups/windows/monitor-performance-for-always-on-availability-groups#data-synchronization-process).

## Troubleshooting

There are two scenarios that can lead to log growth in an availability database and the `'AVAILABILITY_REPLICA' log_reuse_wait_desc`:

- Scenario 1: Latency delivering logged changes to secondary

    When transactions change data in the primary replica, these changes are encapsulated into log record blocks and these logged blocks are delivered and hardened to the database log file at the secondary replica. The primary replica can't overwrite log blocks in its own log file until those log blocks have been delivered and hardened to the corresponding database log file in all secondary replicas. Any delay in the delivery or hardening of these blocks to any replica in the Availability Group will prevent truncation of those logged changes in the database at the primary replica and cause its log file usage to grow.

    For more information, see [High network latency or low network throughput causes log build-up on the primary replica](/sql/database-engine/availability-groups/windows/troubleshoot-availability-group-exceeded-rpo?view=sql-server-2017#BKMK_LATENCY&preserve-view=true).

- Scenario 2: Redo Latency  

    Once hardened to the secondary database log file, a dedicated redo thread in the secondary replica instance applies the contained log records to the corresponding data file(s). The primary replica can't overwrite log blocks in its own log file until all redo threads in all secondary replicas have applied the contained log records.

    If the redo operation on any secondary replica isn't able to keep up with the speed at which log blocks are hardened at that secondary replica, it will lead to log growth at the primary replica. The primary replica can only truncate and reuse its own transaction log up to the point that all secondary replica's redo threads have applied. If there is more than one secondary, compare the `truncation_lsn` column of the `sys.dm_hadr_database_replica_states` dynamic management view across the multiple secondaries to identify which secondary database is delaying log truncation the most.

    You can use the Always On Dashboard and `sys.dm_hadr_database_replica_states` dynamic management views to help monitor the log send queue and redo queue. Some key fields are:

    | Field| Description |
    |---|---|
    | `log_send_queue_size`| Amount of log records that have not arrived at the secondary replica |
    | `log_send_rate`| Rate at which log records are being sent to the secondary databases. |
    | `redo_queue_size`| The amount of log records in the log files of the secondary replica that hasn't yet been redone, in kilobytes (KB). |
    | `redo_rate`| The rate at which the log records are being redone on a given secondary database, in kilobytes (KB)/second. |
    | `last_redone_lsn`| Actual log sequence number of the last log record that was redone on the secondary database. `last_redone_lsn` is always less than `last_hardened_lsn`. |
    | `last_received_lsn`| The log block ID identifying the point up to which all log blocks have been received by the secondary replica that hosts this secondary database. Reflects a log-block ID padded with zeroes. It's not an actual log sequence number. |

    For example, execute the following query against the primary replica to report the replica with the earliest `truncation_lsn` and is the upper bound that the primary can reclaim in its own transaction log:

    ```sql
    SELECT ag.name AS [availability_group_name]
    , d.name AS [database_name]
    , ar.replica_server_name AS [replica_instance_name]
    , drs.truncation_lsn , drs.log_send_queue_size
    , drs.redo_queue_size
    FROM sys.availability_groups ag
    INNER JOIN sys.availability_replicas ar
        ON ar.group_id = ag.group_id
    INNER JOIN sys.dm_hadr_database_replica_states drs
        ON drs.replica_id = ar.replica_id
    INNER JOIN sys.databases d
        ON d.database_id = drs.database_id
    WHERE drs.is_local=0
    ORDER BY ag.name ASC, d.name ASC, drs.truncation_lsn ASC, ar.replica_server_name ASC
    ```

    Corrective measures may include but aren't limited to the following:

    - Make sure that there's no resource or performance bottleneck at the secondary.
    - Make sure that the Redo thread isn't blocked at the secondary. Use the `lock_redo_blocked` extended event to identify when this occurs and on what objects the redo thread is blocked.

## Workaround

After you identify the secondary database that makes this occur, try one or more of the following methods to work around this issue temporarily:

- Take the database out of the availability group for the offending secondary.

    > [!NOTE]
    > This method will result in the loss of the High Availability/Disaster Recovery scenario for the secondary. You may have to set up the Availability Group again in the future.

- If the redo thread is frequently blocked, disable the `Readable Secondary` feature by changing the `ALLOW_CONNECTIONS` parameter of the `SECONDARY_ROLE` for the replica to **NO**.

    > [!NOTE]
    > This will prevent users from reading the data in the secondary replica, which is the root cause of the blocking. Once the redo queue has dropped to an acceptable size, consider enabling the feature again.

- Enable the **autogrow** setting if it's disabled and there is available disk space.
- Increase the MaxSize value for the transaction log file if it has been reached and there is available disk space.
- Add an additional transaction log file if the current one has reached the system maximum of 2 TB or if additional space is available on another available volume.

## More information

- For more information about why a transaction log grows unexpectedly or becomes full in SQL Server, see [Troubleshoot a Full Transaction Log (SQL Server Error 9002)](/sql/relational-databases/logs/troubleshoot-a-full-transaction-log-sql-server-error-9002).

- For more information about the Redo operation blocking problem, see [AlwaysON - HADRON Learning Series: lock_redo_blocked/redo worker Blocked on Secondary Replica](https://techcommunity.microsoft.com/t5/SQL-Server-Support/AlwaysON-HADRON-Learning-Series-lock-redo-blocked-redo-worker/ba-p/317628).

- For more information about AVAILABILITY_REPLICA-based log_reuse_wait columns, see [Factors that can delay log truncation](/previous-versions/sql/sql-server-2008-r2/ms345414(v=sql.105)).

- For more information about the `sys.dm_hadr_database_replica_states` view, see [sys.dm_hadr_database_replica_states (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-hadr-database-replica-states-transact-sql?redirectedfrom=MSDN).

- For more information about how to monitor and troubleshoot logged changes that aren't arriving and aren't being applied in a timely manner, see [Monitor performance for Always On availability groups](/previous-versions/sql/sql-server-2012/dn135338(v=sql.110)).

## Applies to

- SQL Server 2012 Enterprise
- SQL Server 2014 Enterprise
- SQL Server 2014 Business Intelligence
- SQL Server 2014 Standard
- SQL Server 2016 Enterprise
- SQL Server 2016 Standard
- SQL Server 2017 Enterprise
- SQL Server 2017 Standard Windows
