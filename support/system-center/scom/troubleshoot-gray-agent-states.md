---
title: Troubleshoot gray agent states
description: Describes how to troubleshoot problems in which an agent, a management server, or a gateway is unavailable or grayed out in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: manojpa, adoyle, jochan
---
# Troubleshoot gray agent states in System Center Operations Manager

This article describes how to troubleshoot problems in which an agent, a management server, or a gateway is unavailable or **grayed out** in System Center Operations Manager (OpsMgr).

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2288515

An agent, a management server, or a gateway can have one of the following states, as indicated by the color of the agent name and icon in the **Monitoring** pane.

|State|Appearance|Description|
|---|---|---|
|Healthy|Green check mark|The agent or management server is running normally.|
|Critical|Red check mark|There is a problem on the agent or management server.|
|Unknown|Gray agent name, gray check mark|The health service watcher on the management server that is watching the health service on the monitored computer is not receiving heartbeats from the agent anymore. The health service watcher had received heartbeats previously and the state was reported as healthy. This also means that the management servers are no longer receiving any information from the agent.<br/><br/>This issue may occur if the computer that's running the agent isn't running or there are connectivity issues.|
|Unknown|Green circle, no check mark|The status of the discovered item is unknown. There is no monitor available for this specific discovered item.|
  
## Causes of a gray state

An agent, a management server, or a gateway may become unavailable for any of the following reasons:

- Heartbeat failure
- Invalid configuration
- System workflows failure
- Operations Manager database or data warehouse performance issues
- Management server or gateway server performance issues
- Network or authentication issues
- Health service is not running

## Issue scope

Before you begin to troubleshoot the agent grayed out issue, you should first understand the Operations Manager topology, and then define the scope of the issue. The following questions may help you to define the scope of the issue:

- How many agents are affected?
- Are the agents experiencing the issue in the same network segment?
- Do the agents report to the same management server?
- How often do the agents enter and remain in a gray state?
- How do you typically recover from this situation (for example, restart the agent health service, clear the cache, rely upon automatic recovery)?
- Are the heartbeat failure alerts generated for these agents?
- Does this issue occur during a specific time of the day?
- Does this issue persist if you fail over these agents to another management server or gateway?
- When did this problem start?
- Were any changes made to the agents, the management servers, or the gateway or management group?
- Are the affected agents Windows clustered systems?
- Is the Health Service State folder excluded from antivirus scanning?

## Troubleshooting strategy

Your troubleshooting strategy will be dictated by which component is inactive, where that component falls within the topology, and how widespread the problem is. Consider the following conditions:

- If the agents that report to a particular management server or gateway are unavailable, troubleshooting should start at the management server or gateway level.
- If the gateways that report to a particular management server are unavailable, troubleshooting should start at the management server level.
- For agentless systems, for network devices, and for Unix and Linux servers, troubleshooting should start at the agent, management server, or gateway that is monitoring these objects.
- Troubleshooting typically starts at the level immediately above the unavailable component.

## Scenario 1

Only a few agents are affected by the issue. These agents report to different management servers. Agents remain unavailable on a regular basis. Although you are able to clear the agent cache to help resolve the issue temporarily, the problem recurs after a few days.

### Resolution for scenario 1

To resolve the issue in this scenario, follow these steps:

1. Apply the appropriate hotfix to the affected operating systems.
1. Exclude the agent cache from antivirus scanning. For more information, see [Recommendations for antivirus exclusions that relate to Operations Manager](antivirus-exclusions-recommendations.md).
1. Stop the health service.
1. Clear the agent cache.
1. Start the health service.

## Scenario 2

Only a few agents are affected by the issue. These agents report to different management servers. Agents remain inactive constantly. Although you are able to clear the agent cache, this doesn't resolve the issue.

### Resolution for scenario 2

To resolve the issue in this scenario, follow these steps:

1. Determine whether the health service is turned on and is currently running on the management server or gateway. If the health service has stopped responding, generate an ADPlus dump in a service hang mode to help determine the cause of the problem. For more information, see [How to use ADPlus.vbs to troubleshoot "hangs" and "crashes"](https://support.microsoft.com/help/286350)

2. Examine the Operations Manager event log on the agent to locate any of the following events:

    > Event ID: 1102  
    > Event Source: HealthService  
    > Event Description:  
    > Rule/Monitor "%4" running for instance "%3" with id:"%2" cannot be initialized and will not be loaded. Management group "%1"

    > Event ID: 1103  
    > Event Source: HealthService  
    > Event Description:  
    > Summary: %2 rule(s)/monitor(s) failed and got unloaded, %3 of them reached the failure limit that prevents automatic reload. Management group "%1". This is summary only event, please see other events with descriptions of unloaded rule(s)/monitor(s).

    > Event ID: 1104  
    > Event Source: HealthService  
    > Event Description:  
    > RunAs profile in workflow "%4", running for instance "%3" with id:"%2" cannot be resolved. Workflow will not be loaded. Management group "%1"

    > Event ID: 1105  
    > Event Source: HealthService  
    > Event Description:  
    > Type mismatch for RunAs profile in workflow "%4", running for instance "%3" with id:"%2". Workflow will not be loaded. Management group "%1"

    > Event ID: 1106  
    > Event Source: HealthService  
    > Event Description:  
    > Cannot access plain text RunAs profile in workflow "%4", running for instance "%3" with id:"%2". Workflow will not be loaded. Management group "%1"

    > Event ID: 1107  
    > Event Source: HealthService  
    > Event Description:  
    > Account for RunAs profile in workflow "%4", running for instance "%3" with id:"%2" is not defined. Workflow will not be loaded. Please associate an account with the profile. Management group "%1"

    > Event ID: 1108  
    > Event Source: HealthService  
    > Event Description:  
    > An Account specified in the Run As Profile "%7" cannot be resolved. Specifically, the account is used in the Secure Reference Override "%6". %n%n This condition may have occurred because the Account is not configured to be distributed to this computer. To resolve this problem, you need to open the Run As Profile specified below, locate the Account entry as specified by its SSID, and either choose to distribute the Account to this computer if appropriate, or change the setting in the Profile so that the target object does not use the specified Account. %n%nManagement Group: %1 %nRun As Profile: %7 %nSecureReferenceOverride name: %6 %nSecureReferenceOverride ID: %4 %nObject name: %3 %nObject ID: %2 %nAccount SSID: %5

    > Event ID: 4000  
    > Event Source: HealthService  
    > Event Description:  
    > A monitoring host is unresponsive or has crashed. The status code for the host failure was %1.

    > Event ID: 21016  
    > Event Source: OpsMgr Connector  
    > Event Description:  
    > OpsMgr was unable to set up a communications channel to %1 and there are no failover hosts. Communication will resume when %1 is available and communication from this computer is allowed.

    > Event ID: 21006  
    > Event Source: OpsMgr Connector  
    > Event Description:  
    > The OpsMgr Connector could not connect to %1:%2. The error code is %3(%4). Please verify there is network connectivity, the server is running and has registered its listening port, and there are no firewalls blocking traffic to the destination.

    > Event ID: 20070  
    > Event Source: OpsMgr Connector  
    > Event Description:  
    > The OpsMgr Connector connected to %1, but the connection was closed immediately after authentication occurred. The most likely cause of this error is that the agent is not authorized to communicate with the server, or the server has not received configuration. Check the event log on the server for the presence of 20000 events, indicating that agents which are not approved are attempting to connect.

    > Event ID: 20051  
    > Event Source: OpsMgr Connector  
    > Event Description:  
    > The specified certificate could not be loaded because the certificate is not currently valid. Verify that the system time is correct and re-issue the certificate if necessary%n Certificate Valid Start Time : %1%n Certificate Valid End Time : %2

    > Event Source: ESE  
    > Event Category: Transaction Manager  
    > Event ID: 623  
    > Description: HealthService (\<_PID_>) The version store for instance \<_instance_>("\<_name_>") has reached its maximum size of \<_value_> Mb. It is likely that a long-running transaction is preventing cleanup of the version store and causing it to build up in size. Updates will be rejected until the long-running transaction has been completely committed or rolled back. Possible long-running transaction:  
    > SessionId: \<_value_>  
    > Session-context: \<_value_>  
    > Session-context ThreadId: \<_value_>.  
    > Cleanup: \<_value_>

3. If you locate the following specific events, follow these guidelines:

   - Events 1102 and 1103: These events indicate that some of the workflows failed to load. If these are the core system workflows, these events could cause the issue. In this case, focus on resolving these events.
   - Events 1104, 1105, 1106, 1107, and 1108: These events may cause Events 1102 and 1103 to occur. Typically, this would occur because of misconfigured Run As accounts. For example, the Run As accounts are configured to be used with the wrong class or are not configured to be distributed to the agent.
   - Event 4000: This event indicates that the Monitoringhost.exe process crashed. If this problem is caused by a DLL mismatch or by missing registry keys, you may be able to resolve the problem by reinstalling the agent. If the problem persists, try to resolve it by using the following methods:

     - Run a Process Monitor capture until the point the process crashes. For more information, see [Process Monitor v3.53](/sysinternals/downloads/procmon).
     - Generate an ADPlus dump in crash mode. For more information, see [How to use ADPlus.vbs to troubleshoot "hangs" and "crashes"](https://support.microsoft.com/help/286350)

   - Event ID 21006: This event indicates that communication issues exist between the agent and the management server. If the agent uses a certificate for mutual authentication, verify that the certificate is not expired and that the agent is using the correct certificate. If Kerberos is being used, verify that the agent can communicate with Active Directory. If authentication is working correctly, this may mean that the packets from the agent are not reaching the management server or gateway. Try to establish a telnet to port 5723 from the agent to the management server. Additionally, run a simultaneous network trace between the agent and the management server while you reproduce the communication failures. This can help you to determine whether the packets are reaching the management server, and whether any device between the two components is trying to optimize the traffic or is dropping some packets. For more information, see [Collect data using Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon).

   - Event ID 623: This event typically occurs in a large Operations Manager environment in which a management server or an agent computer manages many workflows. For more information, see [One or more management servers and their managed devices are dimmed in the Operations Manager console](management-servers-devices-dimmed.md).

## Scenario 3

All the agents that report to a particular management server or gateway are unavailable.

### Resolution for scenario 3

To resolve the issue in this scenario, follow these steps:

1. Try to determine what kind of workloads the management server or gateway is monitoring. Such workloads might include network devices, cross-platform agents, synthetic transactions, Windows agents, and agentless computers.
2. Determine whether the health service is running on the management server or gateway.
3. Determine whether the management server is running in maintenance mode. If it's necessary, remove the server from maintenance mode.
4. Examine the Operations Manager event log on the agent for any of the events that are listed in [Scenario 2](#scenario-2). If there is event ID 21006, follow the same guidelines that are mentioned in [Resolution for scenario 2](#resolution-for-scenario-2). Additionally in this case, this event indicates that management server or gateway cannot communicate with its parent server. For a gateway, the parent server may be any management server. (Refer to step 3 in the [Resolution for scenario 2](#resolution-for-scenario-2).)
5. Examine the Operations Manager event log for the following events. These events typically indicate that performance issues exist on the management server or Microsoft SQL Server that is hosting the `OperationsManager` or `OperationsManagerDW` database:

    > Event ID: 2115  
    > Event Source: HealthService  
    > Event Description:  
    > A Bind Data Source in Management Group %1 has posted items to the workflow, but has not received a response in %5 seconds. This indicates a performance or functional problem with the workflow.%n Workflow Id : %2%n Instance : %3%n Instance Id : %4%n

    > Event ID: 5300  
    > Event Source: HealthService  
    > Event Description:  
    > Local health service is not healthy. Entity state change flow is stalled with pending acknowledgement. %n%nManagement Group: %2 %nManagement Group ID: %1

    > Event ID: 4506  
    > Event Source: HealthService  
    > Event Description: Operations Manager  
    > Data was dropped due to too much outstanding data in rule "%2" running for instance "%3" with id:"%4" in management group "%1".

    > Event ID: 31551  
    > Event Source: Health Service Modules  
    > Event Description:  
    > Failed to store data in the Data Warehouse. The operation will be retried.%rException '%5': %6 %n%nOne or more workflows were affected by this. %n%nWorkflow name: %2 %nInstance name: %3 %nInstance ID: %4 %nManagement group: %1

    > Event ID: 31552  
    > Event Source: Health Service Modules  
    > Event Description:  
    > Failed to store data in the Data Warehouse.%rException '%5': %6 %n%nOne or more workflows were affected by this. %n%nWorkflow name: %2 %nInstance name: %3 %nInstance ID: %4 %nManagement group: %1

    > Event ID: 31553  
    > Event Source: Health Service Modules  
    > Event Description:  
    > Data was written to the Data Warehouse staging area but processing failed on one of the subsequent operations.%rException '%5': %6 %n%nOne or more workflows were affected by this. %n%nWorkflow name: %2 %nInstance name: %3 %nInstance ID: %4 %nManagement group: %1

    > Event ID: 31557  
    > Event Source: Health Service Modules  
    > Event Description:  
    > Failed to obtain synchronization process state information from Data Warehouse database. The operation will be retried.%rException '%5': %6 %n%nOne or more workflows were affected by this. %n%nWorkflow name: %2 %nInstance name: %3 %nInstance ID: %4 %nManagement group: %1

6. Event ID 3155X may also be logged because of incorrect Run As account configurations or missing permissions for the Run As accounts.

> [!NOTE]
> To troubleshoot management server or gateway performance and SQL Server performance, see the [Resolution for scenario 4](#resolution-for-scenario-4) section.

## Scenarios 4

All the agents that report to a specific management server alternate intermittently between healthy and gray states. Or, all the agents in the environment alternate intermittently between healthy and gray states.

### Resolution for scenario 4

To resolve the issue, first determine the cause of the issue. Common causes of temporary server unavailability include the following:

- The parent server of the agents is temporarily offline.
- Agents are flooding the management server with operational data, such as alerts, states, discoveries, and so on. This may cause an increased use of system resources on the Operations Manager database and on the Operations Manager servers.
- Network outages caused a temporary communication failure between the parent server and the agents.
- Management pack (MP) changes occurred. In the Operations Manager console, these changes require an Operations Manager configuration and an MP redistribution to the agents. If the change affects a larger agent base, this may cause increased use of system resources usage on the Operations Manager database and Operations Manager servers.

The key to troubleshooting in these scenarios is to understand the duration of the server unavailability and the time of day during which it occurred. This will help you to quickly narrow the scope of the problem.

## Troubleshooting management server and gateway performance

### Management server

During a configuration update burst (that is caused by MP import and discovery), the typical bottlenecks are, first, the CPU, and second, the Operations Manager installation disk I/O. The management server is responsible of forwarding configuration files to the target agents.

For operational data collection, bottlenecks are typically caused by the CPU. The disk I/O may also be at maximum capacity, but that is not as likely. The management server is responsible for decompressing and decrypting incoming operational data, and inserting it into the Operational database. It also sends acknowledgments (ACKs) back to the agents or gateways after it receives operational data, and uses disk queuing to temporarily store these outgoing ACKs.

### Gateway

The gateway is both CPU-bound and I/O-bound. When the gateway is relaying a large amount of data, both the CPU and I/O operations may show high usage. Most of the CPU usage is caused by the decompression, compression, encryption, and decryption of the incoming data, and also by the transfer of that data. All data that is received by the gateway and from the agents is stored in a persistent queue on disk, to be read and forwarded to the management server by the gateway Health service. This can cause heavy disk usage. This usage can be significant when the gateway is taken temporarily offline and must then handle accumulated agent data that the agents generated and tried to send when the gateway was still offline.

To troubleshoot the issue in this situation, collect the following information for each affected management server or gateway:

- Exact Windows version, edition, and build number
- Number of processors
- Amount of RAM
- Drive that contains the Health Service State folder
- Whether the antivirus software is configured to exclude the Health Service store

    > [!NOTE]
    > For more information, see [Recommendations for antivirus exclusions that relate to Operations Manager](antivirus-exclusions-recommendations.md).

- RAID level (`0`, `1`, `5`, `0+1` or `1+0`) for the drive that is used by the Health Service State
- Number of disks used for the RAID
- Whether battery-backed write cache is enabled on the array controller

## Troubleshooting SQL Server performance

### Operational database (OperationsManager)

For the `OperationsManager` database, the most likely bottleneck is the disk array. If the disk array is not at maximum I/O capacity, the next most likely bottleneck is the CPU. The database will experience occasional slowdowns and operational data storms (high incidences of events, alerts, and performance data or state changes that persist for a relatively long time). A short burst typically does not cause any significant delay for an extended period of time.

During operational data insertion, the database disks are primarily used for writes. CPU use is caused by SQL Server churn. This may occur when you have large and complex queries, heavy data insertion, and the grooming of large tables (which, by default, occurs at midnight). Typically, the grooming of even large events and performance data tables doesn't consume excessive CPU or disk resources. However, the grooming of the alert and state change tables can be CPU-intensive for large tables.

The database is also CPU-bound when it handles configuration redistribution bursts, which are caused by MP imports or by a large instance space change. In these cases, the Config service queries the database for new agent configuration. This usually causes CPU spikes to occur on the database before the service sends the configuration updates to the agents.

### Data warehouse (OperationsManagerDW)

For the `OperationsManagerDW` database, the most likely bottleneck is the disk array. This usually occurs because of large operational data insertions. In these cases, the disks are mostly busy performing writes. Usually, the disks are performing few reads, except to handle manually generated Reporting views because these run queries on the data warehouse.

CPU usage is caused by SQL Server churn. CPU spikes may occur during heavy partitioning activity (when tables become large and then get partitioned), the generation of complex reports, and large amounts of alerts in the database, with which the data warehouse must constantly sync up.

#### General troubleshooting

To troubleshoot the issue in this situation, collect the following information for each affected management server or gateway:

- Exact Windows version, edition, and build number
- Number of processors
- Amount of RAM
- Amount of memory that is allocated to SQL Server
- Whether SQL Server is 32-bit and is AWE enabled

    You can find most of this information in SQL Server Management Studio or in SQL Server Enterprise Manager. To do this, open the **Properties** window of the server, and then select the **General** and **Memory** tabs. The **General** tab includes the SQL Server version, the Windows version, the platform, the amount of RAM, and the number of processors. The **Memory** tab includes the memory that is allocated to SQL Server. In Microsoft SQL Server 2008, the **Memory** tab also includes the AWE option.

    If OS is 32-bit and RAM is 4 GB or greater, check whether the `/pae` or `/3gb` switches exist in the Boot.ini. file. These options could be configured incorrectly if the server was originally installed by having 4 GB or less of RAM, and if the RAM was later upgraded.

    For 32-bit servers that have 4 GB of RAM, the `/3gb` switch in Boot.ini increases the amount of memory that SQL Server can address (from 2 GB to 3 GB). For 32-bit servers that have more than 4 GB of RAM, the `/3gb` switch in Boot.ini could actually limit the amount of memory that SQL Server can address. For these systems, add the `/pae` switch to Boot.ini, and then enable AWE in SQL Server.

    On a multi-processor system, check the **Max Degree of Parallelism (MAXDOP)** setting. In SQL Server 2008, this option is on the **Advanced** tab in the **Properties** dialog box for the server.

    The default value is **0**, which means that all available processors will be used. A setting of **0** is fine for servers that have eight or fewer processors. For servers that have more than eight processors, the time that it takes SQL Server to coordinate the use of all processors may be counterproductive. Therefore, for servers that have more than eight processors, you generally should set **Max Degree of Parallelism** to a value of **8**. To do this, run the following command in SQL Query Analyzer:

    ```sql
    sp_configure 'show advanced options', 1
    GO
    RECONFIGURE WITH OVERRIDE
    GO
    sp_configure 'max degree of parallelism', 8
    GO
    RECONFIGURE WITH OVERRIDE
    GO
    ```

- Drive letters that contain data warehouse, Operations Manager DB, and Tempdb files
- Whether the antivirus software is configured to exclude SQL data and log files (Scanning SQL Server database files with antivirus software can degrade performance.)
- Amount of free space on drives that contain data warehouse, Operations Manager DB, and Tempdb files
- Storage type (SAN or local)
- RAID level (0, 1, 5, 0+1 or 1+0) for drives that are used by SQL Server
- If SAN storage is used: number of spindles on each LUN that's used by SQL Server
- If the converted Exchange 2007 management pack is being used or has ever been used: number of rows in the `LocalizedText` table in the Operations Manager database and in the `EventPublisher` table in the data warehouse database

  To determine the row amounts, run the following commands:

  ```sql
  USE OperationsManager SELECT COUNT(*) FROM LocalizedText
  USE OperationsManagerDW SELECT COUNT(*) FROM EventPublisher
  ```

#### Counters to identify memory pressure

|Performance counter name|Description|
|-|-|
|MSSQL$\<instance>:&nbsp;Buffer&nbsp;Manager:&nbsp;Page&nbsp;life&nbsp;expectancy|How long pages persist in the buffer pool. If this value is below 300 seconds, it may indicate that the server could use more memory. It could also result from index fragmentation.|
|MSSQL$\<instance>: Buffer Manager: Lazy writes/sec|Lazy writer frees space in the buffer by moving pages to disk. Generally, the value should not consistently exceed 20 writes per second. Ideally, it would be close to zero.|
|Memory: Available Mbytes| Values below 100 MB may indicate memory pressure. Memory pressure is clearly present when this amount is less than 10 MB.|
|Process: Private Bytes: _Total|This is the amount of memory (physical and page) being used by all processes combined.|
|Process: Working Set: _Total|This is the amount of physical memory being used by all processes combined. If the value for this counter is significantly below the value for `Process: Private Bytes: _Total`, it indicates that processes are paging too heavily. A difference of more than 10% is probably significant.|

#### Counters to identify disk pressure

Capture these physical disk counters for all drives that contain SQL data or log files:

- **% Idle Time**: How much disk idle time is being reported. Anything below 50 percent could indicate a disk bottleneck.
- **Avg. Disk Queue Length**: This value should not exceed twice the number of spindles on a LUN. For example, if a LUN has 25 spindles, a value of 50 is acceptable. However, if a LUN has 10 spindles, a value of 25 is too high. You could use the following formulas based on the RAID level and number of disks in the RAID configuration:
  - **RAID 0**: All of the disks are doing work in a RAID 0 set
  - **Average Disk Queue Length** <= # (Disks in the array) *2
  - **RAID 1**: half the disks are doing work; therefore, only half of them can be counted toward disk queue
  - **Average Disk Queue Length** <= # (Disks in the array/2) *2
  - **RAID 10**: half the disks are "doing work"; therefore, only half of them can be counted toward disk queue
  - **Average Disk Queue Length** <= # (Disks in the array/2) *2
  - **RAID 5**: All of the disks are doing work in a RAID 5 set
  - **Average Disk Queue Length** <= # Disks in the array *2
  - **Avg. Disk sec/Transfer**: The number of seconds it takes to complete one disk I/O
  - **Avg. Disk sec/Read**: The average time, in seconds, to read data from the disk
  - **Avg. Disk sec/Write**: The average time, in seconds, to write data to the disk

    The last three counters in this list should consistently have values of approximately **.020** (20 ms) or lower and should never exceed **.050** (50 ms). The following are the thresholds that are documented in the [SQL Server performance troubleshooting guide](https://download.microsoft.com/download/d/b/d/dbde7972-1eb9-470a-ba18-58849db3eb3b/tshootperfprobs2008.docx):

    - Less than 10 ms: very good
    - Between 10 - 20 ms: okay
    - Between 20 - 50 ms: slow, needs attention
    - Greater than 50 ms: serious I/O bottleneck
  
  - **Disk Bytes/sec**: The number of bytes being transferred to or from the disk per second
  - **Disk Transfers/sec**: The number of input and output operations per second (IOPS)
  
  When **% Idle Time** is low (10 percent or less), this means that the disk is fully utilized. In this case, the last two counters in this list (**Disk Bytes/sec** and **Disk Transfers/sec**) provide a good indication of the maximum throughput of the drive in bytes and in IOPS, respectively. The throughput of a SAN drive is highly variable, depending on the number of spindles, the speed of the drives, and the speed of the channel. The best bet is to check with the SAN vendor to find out how many bytes and IOPS the drive should support. If **% Idle Time** is low, and the values for these two counters don't meet the expected throughput of the drive, engage the SAN vendor to troubleshoot.

[SQL Server performance troubleshooting guide](https://download.microsoft.com/download/d/b/d/dbde7972-1eb9-470a-ba18-58849db3eb3b/tshootperfprobs2008.docx) provide deeper insight into troubleshooting SQL Server performance.

### Operations Manager performance counters

The following sections describe the performance counters that you can use to monitor and troubleshoot Operations Manager performance.

#### Gateway server role

##### Overall performance counters

These counters indicate the overall performance of the gateway:

|Performance counter name|
|-|
|Processor(\_Total)\\% Processor Time|
|Memory\\% Committed Bytes In Use|
|Network Interface(\*)\\Bytes Total/sec|
|LogicalDisk(\*)\\% Idle Time|
|LogicalDisk(\*)\\Avg. Disk Queue Length|

##### Operations Manager process generic performance counters

These counters indicate the overall performance of Operations Manager processes on the gateway:

| Performance counter name                   | Description                                                                                                            |
|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| Process(HealthService)\\% Processor Time   |                                                                                                                        |
| Process(HealthService)\\Private Bytes      | Depending on how many agents this gateway is managing, this number may vary and could be several hundred megabytes |
| Process(HealthService)\\Thread Count       |                                                                                                                        |
| Process(HealthService)\\Virtual Bytes      |                                                                                                                        |
| Process(HealthService)\\Working Set        |                                                                                                                        |
| Process(MonitoringHost*)\\%&nbsp;Processor&nbsp;Time |                                                                                                                        |
| Process(MonitoringHost*)\\Private Bytes    |                                                                                                                        |
| Process(MonitoringHost*)\\Thread Count     |                                                                                                                        |
| Process(MonitoringHost*)\\Virtual Bytes    |                                                                                                                        |
| Process(MonitoringHost*)\\Working Set      |                                                                                                                        |

##### Operations Manager specific performance counters

These counters are Operations Manager specific counters that indicate the performance of specific aspects of Operations Manager on the gateway:

|Performance counter name|Description|
|-|-|
|Health Service\Workflow Count||
|Health Service Management Groups(\*)\Active File Uploads|The number of file transfers that this gateway is handling. This represents the number of management pack files that are being uploaded to agents. If this value remains at a high level for a long time, and there is not much management pack importing at a given moment, these conditions may generate a problem that affects file transfer.|
|Health&nbsp;Service&nbsp;Management&nbsp;Groups(\*)\Send&nbsp;Queue&nbsp;%&nbsp;Used|The size of persistent queue. If this value remains higher than 10 for a long time, and it does not drop, this indicates that the queue is backed up. This condition is caused by an overloaded Operations Manager system because the management server or database is too busy or is offline.|
|OpsMgr Connector\Bytes Received|The number of network bytes received by the gateway - that is, the number of incoming bytes before decompression.|
|OpsMgr Connector\Bytes Transmitted|The number network bytes sent by the gateway - that is, the number of outgoing bytes after compression.|
|OpsMgr Connector\Data Bytes Received|The number of data bytes received by the gateway - that is, the amount of incoming data after decompression.|
|OpsMgr Connector\Data Bytes Transmitted|The number of data bytes sent by the gateway - that is, the amount of outgoing data before compression.|
|OpsMgr Connector\Open Connections|The number of connections that are open on gateway. This number should be same as the number of agents or management servers that are directly connected to the gateway.|

#### Management server role

##### Overall performance counters

These counters indicate the overall performance of the management server:

|Performance counter name|
|-|
|Processor(\_Total)\\% Processor Time|
|Memory\\% Committed Bytes In Use|
|Network Interface(\*)\\Bytes Total/sec|
|LogicalDisk(\*)\\% Idle Time|
|LogicalDisk(\*)\\Avg. Disk Queue Length|

##### Operations Manager process generic performance counters

These counters indicate the overall performance of Operations Manager processes on the management server:

| Performance counter name                   | Description                                                                                                                         |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| Process(HealthService)\\% Processor Time   |                                                                                                                                     |
| Process(HealthService)\Private Bytes       | Depending on how many agents this management server is managing, this number may vary, and it could be several hundred megabytes.|
| Process(HealthService)\Thread Count        |                                                                                                                                     |
| Process(HealthService)\Virtual Bytes       |                                                                                                                                     |
| Process(HealthService)\Working Set         |                                                                                                                                     |
| Process(MonitoringHost\*)\\%&nbsp;Processor&nbsp;Time|                                                                                                                                     |
| Process(MonitoringHost\*)\Private Bytes     |                                                                                                                                     |
| Process(MonitoringHost\*)\Thread Count      |                                                                                                                                     |
| Process(MonitoringHost\*)\Virtual Bytes     |                                                                                                                                     |
| Process(MonitoringHost\*)\Working Set       |                                                                                                                                     |

##### Operations Manager specific performance counters

These counters are Operations Manager specific counters that indicate the performance of specific aspects of Operations Manager on the management server:

| Performance counter name|Description|
|-|-|
|Health Service\Workflow Count|The number of workflows that are running on this management server.|
|Health Service Management Groups(\*)\Active File Uploads|The number of file transfers that this management server is handling. This represents the number of management pack files that are being uploaded to agents. If this value remains at a high level for a long time, and there is not much management pack importing at a given moment, these conditions may generate a problem that affects file transfer.|
|Health Service Management Groups(\*)\Send Queue % Used|The size of the persistent queue. If this value remains higher than 10 for a long time, and it does not drop, this indicates that the queue is backed up. This condition is caused by an overloaded Operations Manager system because the Operations Manager system (for example, the root management server) is too busy or is offline.|
|Health Service Management Groups(\*)\Bind Data Source Item Drop Rate|The number of data items that are dropped by the management server for database or data warehouse data collection write actions. When this counter value is not `0`, the management server or database is overloaded because it can't handle the incoming data item fast enough or because a data item burst is occurring. The dropped data items will be resent by agents. After the overload or burst situation is finished, these data items will be inserted into the database or into the data warehouse.|
|Health&nbsp;Service&nbsp;Management&nbsp;Groups(\*)\Bind&nbsp;Data&nbsp;Source&nbsp;Item&nbsp;Incoming&nbsp;Rate|The number of data items received by the management server for database or data warehouse data collection write actions.|
|Health Service Management Groups(\*)\Bind Data Source Item Post Rate|The number of data items that the management server wrote to the database or data warehouse for data collection write actions.|
|OpsMgr Connector\Bytes Received|The number of network bytes received by the management server - that is, the size of incoming bytes before decompression.|
|OpsMgr Connector\Bytes Transmitted|The number of network bytes sent by the management server - that is, the size of outgoing bytes after compression.|
|OpsMgr Connector\Data Bytes Received|The number of data bytes received by the management server - that is, the size of incoming data after decompress.|
|OpsMgr Connector\Data Bytes Transmitted|The number of data bytes sent by the management server - that is, the size of outgoing data before compression.|
|OpsMgr Connector\Open Connections|The number of connections open on management server. It should be same as the number of agents or root management server that are directly connected to it.|
|OpsMgr database Write Action Modules(\*)\Avg. Batch Size|The number of data items or batches that are received by database write action modules. If this number is 5,000, a data item burst is occurring.|
|OpsMgr DB Write Action Modules(\*)\Avg. Processing Time|The number of seconds a database write action modules takes to insert a batch into database. If this number is often greater than 60, a database insertion performance issue is occurring.|
|OpsMgr DW Writer Module(\*)\Avg. Batch Processing Time, ms|The number of milliseconds for data warehouse write action to insert a batch of data items into a data warehouse.|
|OpsMgr DW Writer Module(\*)\Avg. Batch Size|The average number of data items or batches received by data warehouse write action modules.|
|OpsMgr DW Writer Module(\*)\Batches/sec|The number of batches received by data warehouse write action modules per second.|
|OpsMgr DW Writer Module(\*)\Data Items/sec|The number of data items received by data warehouse write action modules per second.|
|OpsMgr DW Writer Module(\*)\Dropped Data Item Count|The number of data items dropped by data warehouse write action modules.|
|OpsMgr DW Writer Module(\*)\Total Error Count|The number of errors that occurred in a data warehouse write action module.|
