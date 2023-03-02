---
title: Troubleshooting intermittent connection timeouts between availability group replicas
description: This article helps you diagnose intermittent connection timeouts that are reported between availability group replicas. 
ms.date: 02/28/2023
ms.custom: sap:Availability Groups
ms.prod: sql
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: ramakoni, cmathews
---

# Troubleshooting intermittent connection timeouts between availability group replicas

This article helps you diagnose intermittent connection timeouts that are reported between availability group replicas.

## Symptoms and effects of intermittent availability group replica connection timeouts

### Querying secondary returns different results than the primary replica

Read only workloads, which query secondary replicas may query stale data. If there are intermittent replica connection timeouts, changes to data on the primary replica database aren't yet reflected in the secondary database when querying the same data. For more information, see the section [Data latency on secondary replica](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups).

### Secondary replica may not be failover ready if configured for automatic failover

If you configure the availability group for automatic failover and the synchronous commit failover partner is intermittently disconnected from the primary, automatic failover may be unsuccessful.

### Various diagnostic features report availability group not synchronized

The Always On dashboard in SQL Server Management Studio may report an unhealthy availability group with replicas in a **Not Synchronizing** state. You may also observe the Always On dashboard report replicas in the **Not synchronizing** state.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state.png" alt-text="Screenshot that shows the Always On dashboard report replicas in the Not Synchronizing state." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state.png":::

When you review the SQL Server error logs of those replicas, you might observe messages like the following, which indicate that there was a connection timeout between the replicas in the availability group.

**Error log from the primary replica**

```output
2023-02-15 07:10:55.500 spid43s Always On availability groups connection with secondary database terminated for primary database 'agdb' on the availability replica 'SQL19AGN2' with Replica ID: {85682e51-07e1-4b9a-9d66-d7ca5e9164ad}. This is an informational message only. No user action is required.
```

**Error log from the secondary replica**

```output
2023-02-15 07:11:03.100 spid31s A connection timeout has occurred on a previously established connection to availability replica 'SQL19AGN1' with id [17116239-4815-4B9B-8097-26F68DED0653]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

2023-02-15 07:11:03.100 spid31s Always On Availability Groups connection with primary database terminated for secondary database 'agdb' on the availability replica 'SQL19AGN1' with Replica ID: {17116239-4815-4b9b-8097-26f68ded0653}. This is an informational message only. No user action is required.
```

### Intermittent connection problems can affect a secondary replica's failover readiness

You can query `sys.dm_hadr_database_replica_cluster_states` to determine if the availability group database is failover ready at that moment. Here's an example of the results when the mirroring endpoint has been stopped on the secondary replica.

```sql
SELECT drcs.database_name, drcs.is_failover_ready, ar.replica_server_name, ars.role_desc, ars.connected_state_desc,
ars.last_connect_error_description, ars.last_connect_error_number, ar.endpoint_url
FROM sys.dm_hadr_availability_replica_states ars JOIN sys.availability_replicas ar ON ars.replica_id=ar.replica_id
JOIN sys.dm_hadr_database_replica_cluster_states drcs ON ar.replica_id=drcs.replica_id
WHERE ars.role_desc='SECONDARY'
```

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/sqlerrorlog-failover-ready.png" alt-text="Screenshot that shows when the mirroring endpoint has been stopped on the secondary replica." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/sqlerrorlog-failover-ready.png":::

Automatic failover may fail to bring the availability group online in the primary role on the failover partner machine if failover coincides with a replica connection timeout.

## What do the connection timeout errors indicate?

The default availability group replica `SESSION_TIMEOUT` setting is 10 seconds. This setting is configured for each replica and determines how long the replica waits to receive a response from its partner replica before reporting a connection timeout. When a replica hasn't had a response from the partner replica, it reports a connection timeout in the SQL Server error log and the Windows application event log. The replica that reports the timeout will immediately attempt to reconnect and will continue to reconnect every five seconds.

The connection timeout typically is detected and reported by only one replica but sometimes the connection timeout might be reported by both replicas at the same time. There are a couple of different versions of this message depending on whether the connection timeout occurred with a previously established connection or a new connection attempt.

```output
Message 35206 A connection timeout has occurred on a previously established connection to availability replica '<replicaname>' with id [<replicaid>]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

Message 35201 A connection timeout has occurred while attempting to establish a connection to availability replica '<replicaname>' with id [<replicaid>]. Either a networking or firewall issue exists, or the endpoint address provided for the replica is not the database mirroring endpoint of the host server instance.
```

The partner replica may or may not detect a timeout. If it does, it might report the message 35201 or 35206, if it doesn't, it reports connection loss to each of the availability group databases.

```output
Message 35267 Always On Availability Groups connection with primary/secondary database terminated for primary/secondary database '<databasename>' on the availability replica '<replicaname>' with Replica ID: {<replicaid>}. This is an informational message only. No user action is required.
```

Here's an example of what SQL Server reports to the error log. For example, if you stop the mirroring endpoint on the primary replica, the secondary replica detects a connection timeout and messages 35206 and 36267 are reported in the secondary replica error log:

```output
2023-02-15 07:11:03.100 spid31s A connection timeout has occurred on a previously established connection to availability replica 'SQL19AGN1' with id [17116239-4815-4B9B-8097-26F68DED0653]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

2023-02-15 07:11:03.100 spid31s Always On Availability Groups connection with primary database terminated for secondary database 'agdb' on the availability replica 'SQL19AGN1' with Replica ID: {17116239-4815-4b9b-8097-26f68ded0653}. This is an informational message only. No user action is required.
```

The primary replica didn't detect any connection timeout since it was still able to communicate with the secondary and reports message 35267 for each availability group database (in this case there's just one database, 'agdb'):

```output
2023-02-15 07:10:55.500 spid43s Always On Availability Groups connection with secondary database terminated for primary database 'agdb' on the availability replica 'SQL19AGN2' with Replica ID: {85682e51-07e1-4b9a-9d66-d7ca5e9164ad}. This is an informational message only. No user action is required.
```

## What causes replica connection timeouts?

### Application issue

SQL Server may be busy, for several reasons, and doesn't service the mirroring endpoint connection within the availability group `SESSION_TIMEOUT` period, resulting in the connection timeout. Some causes are:

- SQL Server experiences 100% CPU utilization. SQL or some other application is driving CPU for seconds at a time.

- SQL Server experiences non-yielding scheduler events.

- SQL Server threads are responsible for yielding the scheduler (CPU) to other threads to complete their work if a thread doesn't yield in a timely fashion.

- SQL Server experiences worker thread exhaustion, out of memory, or application problems that affect its ability to service the mirroring endpoint connection.

### Network issue

This requires collecting network trace logs on the primary and secondary replicas, during the period in which the error is triggered by looking for network latency and dropped packets.

## How to diagnose replica connection timeouts?

In the previous section [What causes replica connection timeouts](#what-causes-replica-connection-timeouts), one key reason for connection timeouts was application issues, which prevent SQL Server from servicing the connection with the partner replica. This section explains how to analyze the SQL Server logs, which may lead to root cause for the replica connection timeouts. This section ends with a more advanced section on how to collect network traces when the connection timeouts occur so that you can check the network.

### Assess timing and location of replica connection timeouts

Review the history, the frequency, and trends of the connection timeouts. The messages described in the last section found in the SQL Server error log is a great way to do this. Where are the connection timeouts reported? Are they consistently reported on the primary or the secondary replica? When did the errors occur? Do they occur in a certain week of the month, day of the week, or time of day? Is there other scheduled maintenance or batch processing that correspond to the times the connection timeouts are observed? This assessment can help you scope and correlate the connection timeouts, which can lead to the root cause.

### Review the AlwaysOn_health extended event session

The `AlwaysOn_health` extended event session has been enhanced to include the `ucs_connection_setup`event, which is triggered when a replica is establishing a connection with its partner replica. This can be helpful when troubleshooting connection timeout issues.

> [!NOTE]
> Extended event `ucs_connection_setup` was added to the latest cumulative updates in SQL Server, you must be running the latest cumulative updates to observe this extended event.

### Query Always On Distributed Management Views (DMVs)

You can also query more information about the replica's connected state. This query only reports the connected state and any errors associated with the connection timeout at point in time and if the connection issues are intermittent, it might not capture the disconnected state easily.

```sql
SELECT ar.replica_server_name, ars.role_desc, ars.connected_state_desc,
ars.last_connect_error_description, ars.last_connect_error_number, ar.endpoint_url
FROM sys.dm_hadr_availability_replica_states ars JOIN sys.availability_replicas ar ON ars.replica_id=ar.replica_id
```

In this example, there's a sustained disconnected state because the mirroring endpoint on the primary replica has been stopped. By querying the primary replica, the Always On DMV can report on the primary and all secondary replicas (the endpoint is disabled on the primary replica).

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-primary-replica.png" alt-text="Screenshot that shows sustained disconnected state because the mirroring endpoint on the primary replica has been stopped." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-primary-replica.png":::

By querying the secondary replica, the Always On DMVs only report on the secondary replica.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-secondary-replica.png" alt-text="Screenshot that shows sustained disconnected state because the mirroring endpoint on the secondary replica has been stopped." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/query-secondary-replica.png":::

## Review the AlwaysOn extended event session

1. Connect to each replica using SQL Server Management Studio (SSMS) Object Explorer and open the `AlwaysOn_health` extended event files.

1. In **SSMS**, go to **File** > **Open** and then **Merge Extended Event Files**.

1. Select the **Add** button and using the **File Open** dialog box and then, navigate to the files in the *SQL Server \LOG* directory.

1. Press **Control** and select the files whose name begins with *'AlwaysOn_healthxxx.xel'*.

1. Select **Open** and then select **OK**.
   You should see a new tabbed window in SSMS with the AlwaysOn events.

    The following screenshot shows the `AlwaysOn_health` data from the secondary replica. The first outlined box shows the connection loss after the endpoint on the primary replica is stopped. The second outlined box shows the connection failure the next time the secondary replica attempts to connect to the primary replica.

    :::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-health-data-secondary-replica.png" alt-text="Screenshot that shows the AlwaysOn_health data from the secondary replica." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-health-data-secondary-replica.png":::

### Investigate SQL Server application ability to service replica connection

One of the most common reasons an availability replica can't service the partner replica connection is a non-yielding scheduler. For more information on what a non-yielding scheduler is, see [Troubleshooting SQL Server Scheduling and Yielding](https://techcommunity.microsoft.com/t5/sql-server-support-blog/troubleshooting-sql-server-scheduling-and-yielding/ba-p/319148).

SQL Server will track non-yielding scheduler events as short as 5 to 10 seconds. It  begins tracking these shorter non-yielding events and reports them in the `TrackingNonYieldingScheduler` data point in the `sp_server_diagnostics query_processing` component output.

To check for non-yielding events that might cause replica connection timeouts, follow these steps:

1. Create a SQL Agent job that records `sp_server_diagnostics` every five seconds.

1. Schedule this job on the server that doesn't report the connection timeout, in other words, if Server A replica reports the replica connection timeout in its error log, set up the SQL Agent job on the partner replica Server B. Alternatively, if you are seeing connection timeouts on both replicas, create the job on both replicas.

    The following batch creates a job that executes `sp_server_diagnostics` every five seconds and appends the output to a text file and then starts the job.

1. Change the `@output_file_name` to a valid path and file name.

    ```vb
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

### Analyze the results

When a connection timeout is reported, make a note of the timestamp of the timeout event in the SQL Server error log. For the following replicas, `SQL19AGN1` has been reporting the replica connection timeouts, so a SQL Agent job was created on `SQL19AGN2`, the partner replica. Then a connection timeout was reported in the SQL19AGN1 error log at 07:24:31:

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/analyze-event-timestamp-timeout.png" alt-text="Screenshot that shows the connection timeout reported in SQL19AGN1 error log." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/analyze-event-timestamp-timeout.png":::

Next, the output from the SQL Agent job running sp_server_diagnostics was checked at around that time, specifically reviewing the `TrackingNonYieldingScheduler` data point in the `query_processing` component output. The output reports a non-yielding scheduler was tracked (as a non-zero hexadecimal value) on server SQL19AGN2 (at 07:24:33) around the time the replica connection timeout was reported on SQL19AGN1 (at 07:24:31).

> [!NOTE]
> The following `sp_server_diagnostics` output has been concatenated to show both the `create_time` (timestamp) and `query_processing TrackingNonYieldingScheduler` results.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/create-time-timestamp-query-processing.png" alt-text="Screenshot that shows sp_server_diagnostics output has been concatenated." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/create-time-timestamp-query-processing.png":::

### Investigate a non-yielding scheduler event

If you've confirmed from the earlier diagnosis steps that a non-yielding event caused the replica connection timeout:

1. Identify the workloads that are running in SQL Server at the time of the non-yielding events are being run.

1. Similar to the replica connection timeouts, look for trends in these events during the month, day, or week that they occur.

1. Collect performance monitor tracing on the system where the non-yielding event was detected.

1. Collect key performance counters for system resources including **Processor::% Processor Time, Memory::Available MBytes**, **Logical Disk::Avg Disk Queue Length**, and **Logical Disk::Avg Disk sec/Transfer**.

1. If necessary, open a support incident with the SQL Server support team for further assistance in finding root cause for these non-yielding events and share the logs you've collected for further analysis.

### Advanced Data Collection - collect network trace during connection timeout

If the previous diagnosis of the SQL Server application didn't yield root cause, the network should be checked. Successful analysis of the network requires collecting a network trace that covers the time of the connection timeout.

The following instructions start a Windows `netsh` network tracing on the replicas where the connection timeouts are being reported in the SQL Server error logs. A Windows scheduled event task is triggered when one of the SQL Server connection errors is recorded in the application event log. The scheduled task runs a command to stop the `netsh` network trace, so that the key network trace data isn't overwritten. The instructions also assume a path of *F:\* for the batch and tracing logs. Adjust this path to your environment:

1. Start network trace as shown in the following code snippet on the two replicas where the connection timeouts have been occurring.

    ```console
    netsh trace start capture=yes persistent=yes overwrite=yes maxsize=500 tracefile=f:\trace.etl
    ```

1. Create Windows scheduled tasks that stop the `netsh` trace on events 35206 or 35267. You can create these tasks from an administrative command line:

    ```console
    schtasks /Create /tn Event35206Task /tr F:\stoptrace.bat /SC ONEVENT /EC Application /MO *[System/EventID=35206] /f /RL HIGHEST
    
    schtasks /Create /tn Event35267Task /tr F:\stoptrace.bat /SC ONEVENT /EC Application /MO *[System/EventID=35267] /f /RL HIGHEST
    ```

1. When the event occurs and the network traces are stopped and captured, you can delete the `ONEVENT` tasks:

    ```console
    PS C:\Users\sqladmin> Schtasks /Delete /tn Event35206Task /F
    PS C:\Users\sqladmin> Schtasks /Delete /tn Event35206Task /F
    ```

Analysis of the network trace is outside the scope of this troubleshooter. If you can't interpret the network trace, open a case with the Microsoft SQL Server support team and provide the trace along with other requested log files for root cause analysis.

## What else can I do to mitigate the connection timeouts?

The default availability group `SESSION_TIMEOUT` is configured for 10 seconds. You may be able to mitigate the connection timeouts by adjusting the availability group replica `SESSION_TIMEOUT` property. This setting is per replica. Adjust it for the primary and each affected secondary replica. Here's an example of the syntax. The default `SESSION_TIMEOUT` is 10, so you could use 15 as the next value.

```sql
ALTER AVAILABILITY GROUP ag
MODIFY REPLICA ON 'SQL19AGN1' WITH (SESSION_TIMEOUT = 15);
```
