---
title: Troubleshoot Always On Availability Group Failover
description: This article provides troubleshooting steps to help you determine why your availability group failed over. 
ms.date: 04/04/2023
ms.custom: sap:Availability Groups
ms.prod: sql
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: cmathews
---

# Troubleshoot Always On Availability Group Failover

This article provides troubleshooting steps to help you determine why your availability group failed over.

## Symptoms and effects of Always On health issue or failover

Always On implements robust health monitoring through different mechanisms to ensure the health of the SQL Server instance hosting the primary replica, the underlying Cluster, and the system health. When a health condition is detected by Windows Cluster or Always On, there is a temporary interruption to your production workload.

When a health condition is detected the following sequence of events usually occur. Going forward in this troubleshooter, whenever a health event is mentioned, it is in reference to these events.

- Availability group replicas and databases transition from primary role to resolving role.

- Availability group databases transition to offline and are no longer accessible.

- Windows Cluster marks the availability group clustered resource as failed.

- Windows Cluster attempts to bring the availability group role back online (on original or automatic failover partner replica).

- Availability group online is successful if it's detected to be healthy by Always On and Windows Cluster health monitoring.

If successful, the availability group replicas and databases transition to the primary role and the availability group databases come online and are accessible by your application.

### Applications fail to access the availability group database(s)

When a health condition is detected, the availability group replica and databases transition to the Resolving role and the availability group databases are taken offline. Once the replica comes online in the primary role (on the original replica server or the failover partner replica server), the replica and databases again transition to online. While the replica and databases are resolving and are offline, applications that attempting to access those availability group databases will fail with error 983 `Unable to access availability database...`. This error is also recorded in the SQL Server error log if SQL Server is configured to record failed login attempts.

```output
2023-03-10 11:43:38.070 Logon Error: 983, Severity: 14, State: 1.

2023-03-10 11:43:38.070 Logon Unable to access availability database '<databasename>' because the database replica is not in the PRIMARY or SECONDARY role. Connections to an availability database is permitted only when the database replica is in the PRIMARY or SECONDARY role. Try the operation again later.
```

The period in which the availability group is in the Resolving role before coming back online in Primary role is typically sub-second or a matter of seconds.

## Identify and diagnose Always On availability group health events or failover

### Review the cluster log when your availability group failed or failed over

The Windows Cluster log is the most comprehensive log for identifying the type of Always On or cluster health event and the detected health condition that caused it. Follow these steps to generate and open the cluster log.

1. Use Windows PowerShell to generate the Windows Cluster log on the cluster node hosting the primary replica at the time of the health event.

1. Run the following cmdlet in an elevated PowerShell window, with 'sql19agn1' as the SQL Server name:

```PowerShell
`get-clusterlog -Node sql19agn1 -UseLocalTime`
```


> [!NOTE]
> By default, the log file is created in %WINDIR%\cluster\reports

### Identify Always On health trends

You might investigate a single Always On health event or there may be a recent or ongoing trend of health issues that are intermittently interrupting production. Some questions can help you narrow and correlate recent changes in your production environment that may be related to these health issues.

- When did the Always On or cluster health events trend begin?
- Do the health events occur on a certain day?
- Do the health events occur on a certain time of the day?
- Do the health events occur on a certain day or week of the month?

If you detect a trend, check scheduled maintenance on the system (on host system if this is a virtual environment), ETL batches and other jobs that may correlate when these health issues occur. If the system is a virtual machine, investigate the host system for changes that might have been introduced at the time of the outages.

Consider busy ad-hoc production workloads that might correlate to the time of the health issue: when users first log on to the system at 8 AM? After users return from lunch?

> [!NOTE]
> This is a good time to consider collecting performance data throughout the week and month, to understand when the system is busiest by measuring Windows performance monitor counters such as Processor Information::% Processor Time, Memory::Available MBytes, MSSQLServer:SQL Statistics::Batch Requests/sec, and so on.

### Find the health event in the cluster log

Always On uses different health monitoring mechanisms to monitor availability group health. Aside from a Windows Cluster health event (in which Windows Cluster detects a health issue among the cluster nodes), Always On has four different types of health checks:

- SQL Server service is not alive
- SQL Server lease time-out
- SQL Server health check time-out
- SQL Server internal health issue

You can locate any of these Always On specific health events by searching the cluster log for the string `[hadrag] Resource Alive result 0`, which is saved in the cluster log when any of these events are detected. Following is an example:

```output
00001334.00002ef4::2019/06/24-18:24:36.153 ERR [RES] SQL Server Availability Group : [hadrag] Resource Alive result 0.
```

You can use a tool to locate all the health events in the cluster log, so that you can generate a summary report of Always On health issues in the cluster log. This can be useful to identify chronological trends (described earlier) and determine if a particular type of Always On health condition is recurring. Here is an example that shows how to find all the lines in the cluster log which contains the string `[hadrag] Resource Alive result 0` by using a tool like NotePad++:

Insert image here

## Determine the type of health issue that was detected which triggered the failover

Match the event you find in the cluster log of the primary replica to one of the examples of each of these types of health issues, as shown in the next few sections.

### Cluster health event

Microsoft Windows cluster monitors the health of the member servers in the cluster. If a health issue is detected, a cluster member server may be removed from the Cluster and the cluster resources, including the availability group role hosted on that removed cluster member server will be moved to the availability group failover partner replica if configured for automatic failover. Here is an example of a cluster health event in the cluster log. You can search for 'Lost quorum' or 'Cluster service has terminated', which might be present during the availability group role change or failover:

```output
00000fe4.00001628::2022/12/15-14:26:02.654 WARN [QUORUM] Node 1: Lost quorum (1)

00000fe4.00001628::2022/12/15-14:26:02.654 WARN [QUORUM] Node 1: goingAway: 0, core.IsServiceShutdown: 0

00000fe4.00001628::2022/12/15-14:26:02.654 WARN lost quorum (status = 5925)

00000fe4.00001628::2022/12/15-14:26:02.654 INFO [NETFT] Cluster Service preterminate succeeded.

00000fe4.00001628::2022/12/15-14:26:02.654 WARN lost quorum (status = 5925), executing OnStop

00000fe4.00001628::2022/12/15-14:26:02.654 INFO [DM]: Shutting down, so unloading the cluster database.

00000fe4.00001628::2022/12/15-14:26:02.654 INFO [DM] Shutting down, so unloading the cluster database (waitForLock: false).

000019cc.000019d0::2022/12/15-14:26:02.654 WARN [RHS] Cluster service has terminated. Cluster.Service.Running.Event got signaled.
```

Another way to identify this event is in the Windows system event log.

```output
12/15/2022 06:26:02 AM Critical SQL19AGN1.CSSSQL 1135 Microsoft-Windows-FailoverClusterin Node Mgr NT AUTHORITY\SYSTEM Cluster node 'SQL19AGN2' was removed from the active failover cluster membership. The Cluster service on this node may have stopped. This could also be due to the node having lost communication with other active nodes in the failover cluster. Run the Validate a Configuration wizard to check your network configuration. If the condition persists, check for hardware or software errors related to the network adapters on this node. Also check for failures in any other network components to which the node is connected such as hubs, switches, or bridges.

12/15/2022 06:26:02 AM Critical SQL19AGN1.CSSSQL 1177 Microsoft-Windows-FailoverClusterin Quorum Manager NT AUTHORITY\SYSTEM The Cluster service is shutting down because quorum was lost. This could be due to the loss of network connectivity between some or all nodes in the cluster, or a failover of the witness disk. Run the Validate a Configuration wizard to check your network configuration. If the condition persists, check for hardware or software errors related to the network adapter. Also check for failures in any other network components to which the node is connected such as hubs, switches, or bridges.
```

#### Diagnose a cluster health event

The errors in the Windows event log (events 1135 and 1177) suggest network connectivity is a problem, and this is the most common reason a cluster health issue is detected. The following example shows that other cluster member servers couldn't communicate with this server hosting the availability group primary replica and this triggered the removal of the cluster node from the cluster.

You can search the cluster log for evidence of a connection failure to the node. From the location in the cluster log where you found `Lost quorum`, search backwards for strings like `Failed to connect to remote endpoint`, `unreachable` and `is broken`:

```output
00000fe4.00001edc::2022/12/14-22:44:36.870 INFO [NODE] Node 1: New join with n3: stage: 'Attempt Initial Connection' status (10060) reason: 'Failed to connect to remote endpoint 20.1.19.103:~3343~'

00000fe4.00001620::2022/12/15-14:26:02.050 INFO [IM] got event: Remote endpoint 10.1.19.102:~3343~ unreachable from 10.1.19.101:~3343~

00000fe4.00001620::2022/12/15-14:26:02.050 WARN [NDP] All routes for route (virtual) local fe80::38b9:a16d:77b2:d2d:~0~ to remote fe80::9087:71d9:495b:27bd:~0~ are down

00000fe4.0000179c::2022/12/15-14:26:02.053 WARN [NODE] Node 1: Connection to Node 2 is broken. Reason GracefulClose(1226)' because of 'channel to remote endpoint fe80::9087:71d9:495b:27bd%14:~3343~ is closed'
```

#### Resolve a cluster health event

Ensure Cluster health monitoring is appropriate for the host environment. For more information on SQL Server AlwaysOn availability groups hosted in Microsoft Azure, see [Windows Server Failover Cluster overview - SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/hadr-windows-server-failover-cluster-overview?view=azuresql).

If it's necessary, consider opening a support incident with Microsoft Windows High Availability support.

### Always On health event: The SQL Server service is down

Always On health monitoring can detect if the SQL Server service hosting the availability group primary replica is no longer running. Here is a sample of the cluster log report with availability group role 'ag' has indicated failure because `QueryServiceStatusEx` returned a process ID `0`.

```output
00001898.0000185c::2023/02/27-13:27:41.121 ERR [RES] SQL Server Availability Group <ag>: [hadrag] QueryServiceStatusEx returned a process id 0

00001898.0000185c::2023/02/27-13:27:41.121 ERR [RES] SQL Server Availability Group <ag>: [hadrag] SQL server service is not alive

00001898.0000185c::2023/02/27-13:27:41.121 ERR [RES] SQL Server Availability Group <ag>: [hadrag] Resource Alive result 0.

00001898.0000185c::2023/02/27-13:27:41.121 WARN [RHS] Resource ag IsAlive has indicated failure.
```

#### Diagnose and resolve SQL Service shutdown event

Check the Windows system event log and SQL Server error log for a graceful or unexpected SQL Server shutdown.

If SQL Server was shut down by a system shutdown or an administrative shutdown, you would see the following message in the SQL Server error log:

```output
2023-03-10 09:38:46.73 spid9s SQL Server is terminating in response to a 'stop' request from Service Control Manager. This is an informational message only. No user action is required.
```

The Windows system event log would show the following message:

```output
Information 3/10/2023 9:41:06 AM Service Control Manager 7036 None The SQL Server (MSSQLSERVER) service entered the stopped state.
```

The Windows system event log will report the following error if SQL Server shuts down unexpectedly:

```output
Error 3/10/2023 8:37:46 AM Service Control Manager 7034 None The SQL Server (MSSQLSERVER) service terminated unexpectedly. It has done this 1 time(s).
```

Check the end of SQL Server error log for clues. If the error log ends abruptly, it means that it was shut down by force. For instance, the SQL Server error report wouldn't reveal any information about any internal issues that might have caused the process to shut down if SQL Server was terminated using Task Manager.

If a SQL Server internal health issue led to SQL Server terminating unexpectedly, there may be clues of a possible fatal exception (including generating a possible dump diagnostic file) at the end of the SQL error log. Review the clues and take the necessary action. If there is a dump diagnostic, consider opening a case with Microsoft SQL Server support and provide the SQL Server error logs and dump diagnostic file for further investigation.

### Always On health event: Lease time-out

Always On uses a "lease" mechanism to monitor health of the computer where SQL Server is installed. The default lease time-out is 20 seconds. Here is a sample output of an Always On lease time-out from the cluster log. You can search these strings to locate a lease time=out in the cluster log:

```output
00001a0c.00001c5c::2023/01/04-15:36:54.762 ERR [RES] SQL Server Availability Group : [hadrag] Availability Group lease is no longer valid 
00001a0c.00001c5c::2023/01/04-15:36:54.762 ERR [RES] SQL Server Availability Group : [hadrag] Resource Alive result 0. 
00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] Lease timeout detected, logging perf counter data collected so far
00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] Date/Time, Processor time(%), Available memory(bytes), Avg disk read(secs), Avg disk write(secs)
00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] 1/4/2023 15:35:57.0, 98.068572, 509227008.000000, 0.000395, 0.000350 00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] 1/4/2023 15:36:7.0, 12.314941, 451817472.000000, 0.000278, 0.000266 00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] 1/4/2023 15:36:17.0, 17.270742, 416096256.000000, 0.000376, 0.000292 00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] 1/4/2023 15:36:27.0, 38.399895, 416301056.000000, 0.000446, 0.000304 00001a0c.00001c5c::2023/01/04-15:36:54.762 WARN [RES] SQL Server Availability Group: [hadrag] 1/4/2023 15:36:37.0, 100.000000, 417517568.000000, 0.001292, 0.000666
```

For more information on lease time-out, see the [Lease Mechanism](/sql/database-engine/availability-groups/windows/availability-group-lease-healthcheck-timeout) section in [Mechanics and guidelines of lease, cluster, and health check timeouts for Always On availability groups](/sql/database-engine/availability-groups/windows/availability-group-lease-healthcheck-timeout).

#### Diagnose and resolve Always On lease time-out event

There are two main types of issues that can trigger a lease time-out:

- SQL Server dump diagnostic occurs: When SQL Server detects certain internal health events, like an access violation, an assertion, or scheduler deadlock, it will produce a dump diagnostic file *.mdmp* in the SQL Server *\LOG* folder.

- A system wide performance issue: A lease time-out doesn't necessarily indicate a SQL Server health problem but instead a system wide health issue that can also affect the SQL Server health.

### SQL Server dump diagnostic

