---
title: Fix Availability Group Replica Connection Timeouts
description: Diagnose intermittent connection timeouts between SQL Server availability group replicas, identify network or scheduler causes, and apply mitigations.
ms.date: 06/17/2026
ms.custom: sap:Always On Availability Groups (AG)
ms.reviewer: jopilov, v-shaywood
---

# Troubleshoot intermittent connection timeouts between availability group replicas

## Summary

In a SQL Server Always On availability group, a connection timeout occurs when a replica doesn't receive a response from its partner replica within the `SESSION_TIMEOUT` period. The SQL Server error log reports these intermittent timeouts as errors 35201, 35206, and 35267. These timeouts can leave the availability group in a **Not Synchronizing** state. Common causes include an application problem, such as high CPU utilization or a non-yielding scheduler, or a network problem, such as latency or dropped packets. This article helps you interpret the connection timeout errors and diagnose the root cause by using the SQL Server error logs, Always On dynamic management views (DMVs), extended events, and network traces. It also explains how to mitigate the timeouts, including how to adjust the availability group replica `SESSION_TIMEOUT` setting.

## Symptoms and effects of intermittent connection timeouts

### Primary and secondary replicas return different results

Read-only workloads that query secondary replicas might query stale data. If intermittent replica connection timeouts occur, changes to data on the primary replica database aren't yet reflected in the secondary database when you query the same data. For more information, see the [Data latency on secondary replica](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups) section.

### Diagnostics report availability group not synchronized

The [Always On dashboard](/sql/database-engine/availability-groups/windows/use-the-always-on-dashboard-sql-server-management-studio) in SQL Server Management Studio (SSMS) might report an unhealthy availability group that has replicas in the **Not Synchronizing** state.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state-small.png" alt-text="Screenshot of the Always On dashboard reporting replicas in the Not Synchronizing state." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state-big.png":::

When you review the SQL Server error logs for those replicas, you might see messages such as the following that indicate a connection timeout between the replicas in the availability group.

Here's the error log from the primary replica.

```output
2023-02-15 07:10:55.500 spid43s Always On availability groups connection with secondary database terminated for primary database 'agdb' on the availability replica 'SQL19AGN2' with Replica ID: {<replicaid>}. This is an informational message only. No user action is required.
```

Here's the error log from the secondary replica.

```output
2023-02-15 07:11:03.100 spid31s A connection time-out has occurred on a previously established connection to availability replica 'SQL19AGN1' with id [<replicaid>]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

2023-02-15 07:11:03.100 spid31s Always On Availability Groups connection with primary database terminated for secondary database 'agdb' on the availability replica 'SQL19AGN1' with Replica ID: {<replicaid>}. This is an informational message only. No user action is required.
```

### Intermittent connection problems can affect a secondary replica's failover readiness

If you configure the availability group for automatic failover, and the synchronous-commit failover partner intermittently disconnects from the primary, automatic failover might fail.

You can query [sys.dm_hadr_database_replica_cluster_states](/sql/relational-databases/system-dynamic-management-views/sys-dm-hadr-database-replica-cluster-states-transact-sql) to check whether the availability group database is failover-ready. Here's an example of the results if the mirroring endpoint is stopped on the secondary replica.

```sql
SELECT drcs.database_name, drcs.is_failover_ready, ar.replica_server_name, ars.role_desc, ars.connected_state_desc,
ars.last_connect_error_description, ars.last_connect_error_number, ar.endpoint_url
FROM sys.dm_hadr_availability_replica_states ars JOIN sys.availability_replicas ar ON ars.replica_id=ar.replica_id
JOIN sys.dm_hadr_database_replica_cluster_states drcs ON ar.replica_id=drcs.replica_id
WHERE ars.role_desc='SECONDARY'
```

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/sqlerrorlog-failover-ready-small.png" alt-text="Screenshot of the mirroring endpoint stopped on the secondary replica." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/sqlerrorlog-failover-ready-big.png":::

Automatic failover might not bring the availability group online in the primary role on the failover partner computer if failover coincides with a replica connection timeout.

## Meaning of the connection timeout errors

The default value for the availability group replica setting `SESSION_TIMEOUT` is 10 seconds. You configure this setting for each replica. It determines how long the replica waits to receive a response from its partner replica before it reports a connection timeout. If a replica gets no response from the partner replica, it reports a connection timeout in the Microsoft SQL Server error log and the Windows Application log. The replica that reports the timeout immediately tries to reconnect, and continues to try every five seconds.

Typically, only one replica detects and reports the connection timeout. But both replicas might report the connection timeout at the same time. Different versions of this message exist, depending on whether the connection timeout occurred on a previously established connection or a new connection.

```output
Message 35206 A connection timeout has occurred on a previously established connection to availability replica '<replicaname>' with id [<replicaid>]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

Message 35201 A connection timeout has occurred while attempting to establish a connection to availability replica '<replicaname>' with id [<replicaid>]. Either a networking or firewall issue exists, or the endpoint address provided for the replica is not the database mirroring endpoint of the host server instance.
```

The partner replica might not detect a timeout. If it does, it might report message 35201 or 35206. If it doesn't, it reports a connection loss to each of the availability group databases.

```output
Message 35267 Always On Availability Groups connection with primary/secondary database terminated for primary/secondary database '<databasename>' on the availability replica '<replicaname>' with Replica ID: {<replicaid>}. This is an informational message only. No user action is required.
```

Here's an example of what SQL Server reports to the error log. If you stop the mirroring endpoint on the primary replica, the secondary replica detects a connection timeout, and messages 35206 and 35267 are reported in the secondary replica error log.

```output
2023-02-15 07:11:03.100 spid31s A connection timeout has occurred on a previously established connection to availability replica 'SQL19AGN1' with id [<replicaid>]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

2023-02-15 07:11:03.100 spid31s Always On Availability Groups connection with primary database terminated for secondary database 'agdb' on the availability replica 'SQL19AGN1' with Replica ID:[<replicaid>]. This is an informational message only. No user action is required.
```

In this example, the primary replica didn't detect a connection timeout because it could still communicate with the secondary replica. It reported message 35267 for each database in the availability group. Here, there's only one database, 'agdb'.

```output
2023-02-15 07:10:55.500 spid43s Always On Availability Groups connection with secondary database terminated for primary database 'agdb' on the availability replica 'SQL19AGN2' with Replica ID: {<replicaid>}. This is an informational message only. No user action is required.
```

## Causes of replica connection timeouts

### Application issue

SQL Server might be too busy to service the [mirroring endpoint](/sql/database-engine/database-mirroring/the-database-mirroring-endpoint-sql-server) connection within the availability group `SESSION_TIMEOUT` period, which causes the connection timeout. Here are some common reasons:

- SQL Server experiences 100 percent CPU utilization. This condition means that SQL Server or some other application is consuming all available CPU for seconds at a time.

- SQL Server experiences non-yielding scheduler events. SQL Server threads are responsible for yielding the scheduler (CPU) to other threads to complete their work. If a thread doesn't yield in a timely fashion, it can delay the mirroring endpoint connection and cause a timeout.

- SQL Server experiences worker thread exhaustion, out-of-memory problems, or application problems that affect its ability to service the mirroring endpoint connection.

### Network issue

Collect network traces on the primary and secondary replicas when the error occurs, and then examine them for network latency and dropped packets.

## Diagnose replica connection timeouts

This section explains how to analyze the SQL Server logs to diagnose application problems that prevent SQL Server from servicing the connection with the partner replica. These tips can help you identify the root cause of the replica connection timeouts. It ends with more advanced guidance about collecting network traces when the connection timeouts occur so that you can check the network status.

### Assess timing and location of replica connection timeouts

Review the history, the frequency, and trends of the connection timeouts. The messages in the SQL Server error log are a good source for this review. Where are the connection timeouts reported? Are they consistently reported on the primary or the secondary replica? When did the errors occur? Did they occur in a certain week of the month, day of the week, or time of day? Does other scheduled maintenance or batch processing correspond to the times at which the connection timeouts are observed? This assessment can help you scope and correlate the connection timeouts to identify the root cause.

### Review the AlwaysOn_health extended event session

The [AlwaysOn_health](/sql/database-engine/availability-groups/windows/always-on-extended-events) extended event session was enhanced to include the `ucs_connection_setup` event, which is triggered when a replica is establishing a connection with its partner replica. This event can help when you troubleshoot connection timeout problems.

> [!NOTE]
> The `ucs_connection_setup` extended event is available starting with SQL Server 2019 CU15. For more information, see [Configure Extended Events for availability groups](/sql/database-engine/availability-groups/windows/always-on-extended-events#ucsucs_connection_setup).

### Query Always On dynamic management views (DMVs)

You can query Always On DMVs for more information about the replica's connected state. This query reports only the connected state and any errors that are associated with the connection timeout at the time that the issues occur. If the connection issues are intermittent, the query might not capture the disconnected state easily.

```sql
SELECT ar.replica_server_name, ars.role_desc, ars.connected_state_desc,
ars.last_connect_error_description, ars.last_connect_error_number, ar.endpoint_url
FROM sys.dm_hadr_availability_replica_states ars JOIN sys.availability_replicas ar ON ars.replica_id=ar.replica_id
```

The following example shows a sustained disconnected state because the mirroring endpoint on the primary replica was stopped. When you query the primary replica, the Always On DMV can report on the primary and all secondary replicas (the endpoint is disabled on the primary replica).

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-primary-replica-small.png" alt-text="Screenshot of a sustained disconnected state because the mirroring endpoint on the primary replica was stopped." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-primary-replica-big.png":::

When you query the secondary replica, the Always On DMV reports on only the secondary replica.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-secondary-replica-small.png" alt-text="Screenshot of a sustained disconnected state because the mirroring endpoint on the secondary replica was stopped." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-secondary-replica-big.png":::

### Review the Always On extended event session

1. Connect to each replica by using SSMS Object Explorer, and open the `AlwaysOn_health` extended event files.

1. In SSMS, go to **File** > **Open**, and then select **Merge Extended Event Files**.

1. Select the **Add** button.

1. In the **File Open** dialog box, go to the files in the *SQL Server \LOG* directory.

1. Select and hold **Ctrl**, and then select the files whose name begins with *AlwaysOn_healthxxx.xel*.

1. Select **Open**, and then select **OK**.

   A new tabbed window appears in SSMS that shows the AlwaysOn events.

    The following screenshot shows the `AlwaysOn_health` data from the secondary replica. The first outlined box shows the connection loss after the endpoint on the primary replica is stopped. The second outlined box shows the connection failure that occurs the next time that the secondary replica tries to connect to the primary replica.

    :::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-health-data-secondary-replica-small.png" alt-text="Screenshot of the AlwaysOn_health data from the secondary replica." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-health-data-secondary-replica-big.png":::

### Check whether non-yielding events cause connection timeouts

One of the most common reasons that an availability replica can't service the partner replica connection is a non-yielding scheduler. For more information about non-yielding schedulers, see [Troubleshooting SQL Server Scheduling and Yielding](https://techcommunity.microsoft.com/t5/sql-server-support-blog/troubleshooting-sql-server-scheduling-and-yielding/ba-p/319148).

SQL Server tracks non-yielding scheduler events that are as short as 5 to 10 seconds. It reports these events in the `TrackingNonYieldingScheduler` data point in the `sp_server_diagnostics query_processing` component output.

To check for non-yielding events that might cause replica connection timeouts, follow these steps.

1. Create a SQL Agent job that records [sp_server_diagnostics](/sql/relational-databases/system-stored-procedures/sp-server-diagnostics-transact-sql) every five seconds.

1. Schedule this job on the server that doesn't report the connection timeout. That is, suppose the Server A replica reports the connection timeout in its error log. In that case, set up the SQL Agent job on the partner replica, Server B. Alternatively, if you're seeing connection timeouts on both replicas, create the job on both replicas.

1. Run the following T-SQL script to create a job that runs `sp_server_diagnostics` every five seconds, appends the output to a text file, and then starts the job. In the following example, the `sp_server_diagnostics 5` command executes every five seconds. So, there's no need to schedule this job to run every five seconds. Just start the job, and it runs until stopped, every five seconds.

    ```sql
    USE [msdb]
    GO
    DECLARE @ReturnCode INT
    SELECT @ReturnCode = 0
    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name=N'Run sp_server_diagnostics',
    @owner_login_name=N'sa', @job_id = @jobId OUTPUT
    /****** Object: Step [Run SP_SERVER_DIAGNOSTICS] Script Date: 2/15/2023 4:20:41 PM ******/
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run SP_SERVER_DIAGNOSTICS',
    @subsystem=N'TSQL',
    @command=N'sp_server_diagnostics 5',
    @database_name=N'master',
    @output_file_name=N'D:\cases\2423\sp_server_diagnostics_output.out',
    @flags=2
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
    EXEC sp_start_job 'Run sp_server_diagnostics'
    ```

   > [!NOTE]
   > In these commands, change `@output_file_name` to a valid path and provide a file name.

### Analyze the results

When a connection timeout occurs, note the timestamp of the timeout event that appears in the SQL Server error log. For the replicas in the following example, `SQL19AGN1` reports the replica connection timeouts. Therefore, you create a SQL Agent job on `SQL19AGN2`, the partner replica. Then, a connection timeout is reported in the `SQL19AGN1` error log at 07:24:31.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/analyze-event-timestamp-timeout-small.png" alt-text="Screenshot of the connection timeout reported in the SQL19AGN1 error log." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/analyze-event-timestamp-timeout-big.png":::

Next, check the output from the SQL Agent job that runs `sp_server_diagnostics` at around the reported time. Specifically, review the `TrackingNonYieldingScheduler` data point in the `query_processing` component output. The output reports that a non-yielding scheduler was tracked (as a non-zero hexadecimal value) on server `SQL19AGN2` (at 07:24:33) around the time that the replica connection timeout was reported on `SQL19AGN1` (at 07:24:31).

> [!NOTE]
> The following `sp_server_diagnostics` output is concatenated to show both the `create_time` (timestamp) and `query_processing TrackingNonYieldingScheduler` results.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/create-time-timestamp-query-processing-small.png" alt-text="Screenshot of concatenated sp_server_diagnostics output showing create_time and query_processing results." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/create-time-timestamp-query-processing-big.png":::

### Investigate a non-yielding scheduler event

If you verify from the earlier diagnosis steps that a non-yielding event caused the replica connection timeout, follow these steps.

1. Identify the workloads that are running in SQL Server at the time that the non-yielding events occur.

1. Similar to the replica connection timeouts, look for trends in these events during the month, day, or week that they occur.

1. Collect performance monitor tracing on the system where the non-yielding event was detected.

1. Collect key performance counters for system resources, including **Processor::% Processor Time**, **Memory::Available MBytes**, **Logical Disk::Avg Disk Queue Length**, and **Logical Disk::Avg Disk sec/Transfer**.

1. If necessary, open a SQL Server support incident for further assistance in finding the root cause of these non-yielding events. Share the logs that you collected for further analysis.

### Collect a network trace during a connection timeout

If the previous diagnosis of the SQL Server application doesn't yield a root cause, check the network. To successfully analyze the network, you need to collect a network trace that covers the time of the connection timeout.

The following procedure starts a Windows `netsh` network trace on the replicas on which the connection timeouts are reported in the SQL Server error logs. A Windows scheduled task is triggered when one of the SQL Server connection errors is recorded in the Application log. The scheduled task runs a command to stop the `netsh` network trace so that the key network trace data isn't overwritten. These steps also assume a path of *F:\* for the batch and tracing logs. Adjust this path to your environment.

1. Start a network trace on the two replicas where the connection timeouts occur, as shown in the following code snippet.

    ```console
    netsh trace start capture=yes persistent=yes overwrite=yes maxsize=500 tracefile=f:\trace.etl
    ```

1. Create *stoptrace.bat*. You can create this file at an administrative command prompt.

    ```console
    echo netsh trace stop > F:\stoptrace.bat
    ```

1. Create Windows scheduled tasks that stop the `netsh` trace on events 35206 or 35267. You can create these tasks at an administrative command prompt.

    ```console
    schtasks /Create /tn Event35206Task /tr F:\stoptrace.bat /SC ONEVENT /EC Application /MO *[System/EventID=35206] /f /RL HIGHEST
    schtasks /Create /tn Event35267Task /tr F:\stoptrace.bat /SC ONEVENT /EC Application /MO *[System/EventID=35267] /f /RL HIGHEST
    ```

1. After the event occurs and the network traces are stopped and captured, delete the `ONEVENT` tasks.

    ```console
    schtasks /Delete /tn Event35206Task /F
    schtasks /Delete /tn Event35267Task /F
    ```

Analysis of the network trace is outside the scope of this troubleshooter. If you can't interpret the network trace, contact the Microsoft SQL Server Support team and provide the trace along with other requested log files for root cause analysis.

## Mitigate the connection timeouts

You might be able to mitigate the connection timeouts by adjusting the availability group replica [SESSION_TIMEOUT](/sql/t-sql/statements/alter-availability-group-transact-sql) property. This setting is per replica, so adjust it for the primary and each affected secondary replica. The default value is 10 seconds, so you could try 15 seconds as the next value. Here's an example of the syntax.

```sql
ALTER AVAILABILITY GROUP ag
MODIFY REPLICA ON 'SQL19AGN1' WITH (SESSION_TIMEOUT = 15);
```

## Related content

- [What is an Always On availability group?](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server)
- [Troubleshoot failover of Always On Availability Groups](troubleshooting-availability-group-failover.md)
- [Availability Replica is Disconnected in an Availability Group](availability-replica-is-disconnected.md)
- [Use AGDiag to diagnose availability group health events](use-agdiag-diagnose-availability-group-health-events.md)
