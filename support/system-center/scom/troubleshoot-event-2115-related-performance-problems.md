---
title: Troubleshoot event 2115-related performance problems
description: Discusses how to troubleshoot event ID 2115-related performance problems in Systems Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: nicholad
---
# Troubleshoot event ID 2115-related performance problems in Operations Manager

This article helps you identify and troubleshoot performance problems that affect Operations Manager (OpsMgr) database and data warehouse data insertion time. It applies to all supported versions of System Center Operations Manager

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2681388

A typical sign of Operations Manager database performance issues is the presence of event ID 2115 events in the Operations Manager event log. These events typically indicate that performance issues exist on the management server or on the server that's running Microsoft SQL Server and that's hosting the Operations Manager or Operations Manager data warehouse databases.

## Background

Database and data warehouse write action workflows run on the management servers. These workflows first retain the data that they receive from the agents and gateway servers in an internal buffer. Then, they gather this data from the internal buffer and insert it into the database and data warehouse. When the first data insertion is completed, the workflows create another batch.

The size of each batch of data depends on how much data is available in the buffer when the batch is created. However, there is a maximum limit of 5,000 data items in a batch. If the rate of incoming data items increases, or if the data item insertion throughput to the Operation Manager and data warehouse databases throughput is reduced, the buffer accumulates more data and the batch size increases.

There are several write action workflows that run on a management server. For example, the following workflows handle data insertion to the Operations Manager and data warehouse databases for different data types:

- Microsoft.SystemCenter.DataWarehouse.CollectEntityHealthStateChange
- Microsoft.SystemCenter.DataWarehouse.CollectPerformanceData
- Microsoft.SystemCenter.DataWarehouse.CollectEventData
- Microsoft.SystemCenter.CollectAlerts
- Microsoft.SystemCenter.CollectEntityState
- Microsoft.SystemCenter.CollectPublishedEntityState
- Microsoft.SystemCenter.CollectDiscoveryData
- Microsoft.SystemCenter.CollectSignatureData
- Microsoft.SystemCenter.CollectEventData

When a database or data warehouse write action workflow on a management server experiences slow data batch insertion (for example, in excess of 60 seconds), the workflow begins to log event ID 2115 to the Operations Manager event log. This event is logged every minute until the data batch is inserted into the database or data warehouse, or the data is dropped by the write action workflow module. Therefore, event ID 2115 is logged because of the latency that occurs during the insertion of data into the database or data warehouse. The following is an example of an event that is logged because data is dropped by the write action workflow module:

> Event Type: Error  
> Event Source: HealthService  
> Event Category: None  
> Event ID: 4506  
> Computer: \<RMS NAME>  
> Description:  
> Data was dropped due to too much outstanding data in rule "Microsoft.SystemCenter.OperationalDataReporting.SubmitOperationalDataFailed.Alert" running for instance \<RMS NAME> with id:"{F56EB161-4ABE-5BC7-610F-4365524F294E}" in management group \<MANAGEMENT GROUP NAME>.

### Take a deeper look

Event ID 2115 contains two significant pieces of information:

- The name of the workflow that is experiencing the issue
- The elapsed time since the workflow began to insert the last batch of data

For example:

> Log Name: Operations Manager  
> Source: HealthService  
> Event ID: 2115  
> Level: Warning  
> Computer: \<RMS NAME>  
> Description:  
> A Bind Data Source in Management Group \<MANAGEMENT GROUP NAME> has posted items to the workflow, but has not received a response in 300 seconds. This indicates a performance or functional problem with the workflow.  
> Workflow Id : Microsoft.SystemCenter.CollectPublishedEntityState  
> Instance : \<RMS NAME>  
> Instance Id : {88676CDF-E284-7838-AC70-E898DA1720CB}

The `Microsoft.SystemCenter.CollectPublishedEntityState` workflow writes Entity State data to the Operations Manager database. The event ID 2115 message indicates that the `Microsoft.SystemCenter.CollectPublishedEntityState` workflow is trying to insert a batch of Entity State data, and that it started 300 seconds ago. In this example, the insertion of the Entity State data is not finished. Usually, the insertion of a batch of data should finish within 60 seconds.

If the Workflow ID contains the term **DataWarehouse**, the problem involves the Operations Manager data warehouse database. Otherwise, the problem involves the insertion of data into the Operations Manager database.

## Cause

Any of the following issues can cause these kinds of problems.  

### Insertion problems

This problem may indicate a database performance problem or that there is too much data sent by the agents. The event ID 2115 description indicates only that there is a backlog that affects the insertion of data into the database (either Operations Manager or Operations Manager data warehouse). These events can occur for many reasons. For example, there could be a sudden, large amount of Discovery data. Or, there could be a database connectivity issue. Or, the database may be full. Or, there might be is a disk-related or network-related constraint.

In Operations Manager, discovery data insertion is a relatively labor-intensive process. It can also come in bursts, where there is a significant amount of data being received by the management server. These bursts can cause temporary instances of event IDs 2115, but if event ID 2115 consistently appears for discovery data collection, this can indicate either a database or data warehouse insertion problem or discovery rules in a management pack collecting too much discovery data.

Operations Manager configuration updates caused by instance space changes or management pack imports have a direct effect on CPU utilization on the database server. This can affect database insertion times. After a management pack import or a large instance space change, you expect to see event ID 2115 messages. For more information, see [Detect and troubleshoot frequent configuration changes in Operations Manager](detect-troubleshoot-configuration-changes.md).

In Operations Manager, expensive user interface queries can also affect resource utilization on the database that can lead to latency in database insertion times. When a user performs an expensive user interface operation, you might see event ID 2115 messages logged.  

### Databases full or offline

If the Operations Manager or Operations Manager data warehouse databases are out of space or are offline, you expect that the management server will continue to log event ID 2115 messages to the Operations Manager Event log. Also, the pending time will increase.

If the write action workflows cannot connect to the Operations Manager or Operations Manager data warehouse databases, or if they are using invalid credentials to establish their connection, the data insertion is blocked and event ID 2115 messages are logged until this scenario is resolved.  

### Configuration and environmental issues

Event ID 2115 messages can also indicate a performance problem if the Operations Manager database, the data warehouse databases, and all of the supporting environment are not configured correctly. The following are some possible causes of this problem:

- The SQL Server log or `TempDB` database is too small or is out of space.
- The network link from the Operations Manager and data warehouse database to the management server is bandwidth constrained or the latency is large. In this scenario, we recommend that you put the management server on the same LAN as the Operations Manager and data warehouse servers.
- The data disk that hosts the database, the logs, or the `TempDB` that's used by the Operations Manager and data warehouse databases is slow or experiences a functionality problem. In this scenario, we recommend that you use RAID 10 and also that you enable battery-backed write cache on the array controller.
- The Operations Manager database or data warehouse server doesn't have sufficient memory or CPU resources.
- The SQL Server instance that hosts the Operations Manager database or data warehouse is offline.

We also recommend that you put the management server on the same LAN as the Operations Manager and data warehouse database server.

Event ID 2115 messages can also occur if the disk subsystem that hosts the database, the logs, or the `TempDB` that's used by the Operations Manager and data warehouse databases is slow or experiences a functionality problem. We recommend that you use RAID 10 and also enable battery-backed write cache on the array controller.  

## Resolution

The first step to troubleshoot the performance-related event ID 2115 messages is to identify which data items are returned within the event. For example, the workflow ID indicates which type of data items (such as Discovery, Alerts, Event, Perf) and which database is involved. If the workflow ID contains the term **DataWarehouse**, the troubleshooting focus should be on the Operations Manager data warehouse database. In other cases, the focus should be on the Operations Manager database.  

### Scenario 1

In the following example, the problem involves the `Microsoft.SystemCenter.CollectSignatureData` workflow:

> Event Type:  
> Warning Event Source: HealthService  
> Event Category: None  
> Event ID: 2115  
> Computer: \<RMS NAME>  
> Description: A Bind Data Source in Management Group \<MANAGEMENT GROUP NAME> has posted items to the workflow, but has not received a response in 300 seconds. This indicates a performance or functional problem with the workflow.  
> Workflow Id : Microsoft.SystemCenter.CollectSignatureData  
> Instance : \<RMS NAME>  
> Instance Id : {F56EB161-4ABE-5BC7-610F-4365524F294E}

**Resolution**

We can identify the Performance Signature Data Collection rules in this example by running the following SQL query. This query should be run in SQL Server Management Studio against the Operations Manager database.

```sql
-- Return all Performance Signature Collection Rules
Use OperationsManager
select
managementpack.mpname,
rules.rulename
from performancesignature with (nolock)
inner join rules with (nolock)
on rules.ruleid = performancesignature.learningruleid
inner join managementpack with(nolock)
on rules.managementpackid = managementpack.managementpackid
group by managementpack.mpname, rules.rulename
order by managementpack.mpname, rules.rulename
```

This query returns all Performance Signature Collection rules and their respective management pack name. A column is returned for the management pack name and rule name.

The following Performance Monitor counters on a management server provide information about database and data warehouse write action insertion batch size and time:

- OpsMgr DB Write Action modules(*)\Avg. batch size
- OpsMgr DB Write Action modules(*)\Avg. processing time
- OpsMgr DW Writer module(*)\Avg. batch processing time, ms
- OpsMgr DW Writer module(*)\Avg. batch size

If the batch size is increasing (for example, the default batch size is 5,000 items), this indicates either that the management server is slow to insert the data to the database or data warehouse, or that it's receiving a burst of data items from the agents or the gateway servers.

By examining the database and data warehouse write action account **Average Processing Time** counter, we can understand how long it takes on average to write a batch of data to the database and data warehouse. Depending on the time that it takes to write a batch of data to the database, this may provide an opportunity for tuning.

### Scenario 2

If the SQL Server instance that hosts the Operations Manager database or data warehouse database is offline, event ID 2115 and event ID 29200 are logged to the Operations Manager event log. For example:

> Log Name: Operations Manager  
> Source: HealthService  
> Date:  
> Event ID: 2115  
> Level: Warning  
> Description:  
> A Bind Data Source in Management Group MSFT has posted items to the workflow, but has not received a response in 60 seconds. This indicates a performance or functional problem with the workflow.  
> Workflow Id: Microsoft.SystemCenter.CollectEventData  
> Instance: name.contoso.local  
> Instance Id: {88676CDF-E284-7838-AC70-E898DA1720CB}

> Log Name: Operations Manager  
> Source: OpsMgr Config Service  
> Event ID: 29200  
> Level: Error  
> Description:  
> OpsMgr Config Service has lost connectivity to the OpsMgr database, therefore it can not get any updates from the database. This may be a temporary issue that may be recovered from automatically. If the problem persists, it usually indicates a problem with the database. Reason:  
> A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)

**Resolution**

To resolve this issue, follow these steps:

1. Connect to the server that hosts the Operations Manager database.
2. Open the **Services** applet.
3. Verify that the **SQL Server (MSSQLSERVER)** service is started and running.
4. If the **SQL Server (MSSQLSERVER)** service is not started and running, start the service.

After database connectivity is restored, workflows should successfully start to store data again in the respective database. Event ID 31554 confirms that the information has been written successfully:

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Event ID: 31554  
> Task Category: Data Warehouse  
> Level: Information  
> Description:  
> Workflow succeeded storing data in the Data Warehouse  
> One or more workflows were affected by this.  
> Workflow name: Microsoft.SystemCenter.DataWarehouse.CollectEventData  
> Instance name: name.contoso.local  
> Instance ID: {88676CDF-E284-7838-AC70-E898DA1720CB}

### Scenario 3

Event ID 2115 is caused by invalid RunAs credentials.

**Resolution**

Examine the Operations Manager event log for the following events. These events typically indicate that **Data Warehouse SQL Server Authentication Account** may have incorrect credentials.

> Log Name: Operations Manager  
> Source: HealthService  
> Event ID: 7000  
> Task Category: Health Service  
> Level: Error  
> Description: The Health Service could not log on the RunAs account \<ACCOUNT NAME> for management group \<MANAGEMENT GROUP NAME>. The error is Logon failure: unknown user name or bad password.(1326L). This will prevent the health service from monitoring or performing actions using this RunAs account

> Log Name: Operations Manager  
> Source: HealthService  
> Event ID: 7015  
> Task Category: Health Service  
> Level: Error  
> Description:  
The Health Service cannot verify the future validity of the RunAs account \<ACCOUNT NAME> for management group \<MANAGEMENT GROUP NAME>. The error is Logon failure: unknown user name or bad password.(1326L).

To resolve this issue, follow these steps:

1. Open the Operations Manager console.
2. Select **Administration**.
3. Select **Run As Configuration\Accounts**.
4. Configure the appropriate credentials for **Data Warehouse SQL Server Authentication Account**.

### Scenario 4

Event ID 2115 caused by disk performance issues. This can occur when the data disk that hosts the database, logs, or TempDB that is used by the Operations Manager and data warehouse databases is slow or experiences a problem. In this scenario, we recommend that you use RAID 10 and also enable battery-backed write cache on the array controller.

**Resolution**

First, capture the following physical disk counters for all drives that contain SQL Server data or log files:

- **% Idle Time**: How much disk idle time is being reported. Anything less than 50 percent could indicate a disk bottleneck.

- **Avg. Disk Queue Length**: This value should not exceed twice the number of spindles that are on a LUN. For example, if a LUN has 25 spindles, a value of **50** is acceptable. However, if a LUN has 10 spindles, a value of **25** is too high. You could use the following formulas based on the RAID level and number of disks in the RAID configuration:

  - **RAID 0**: All of the disks are doing work in a RAID 0 set.

    `Average Disk Queue Length <= # (Disks in the array) *2`

  - **RAID 1**: Half the disks are doing work. Therefore, only half of them can be counted toward disks queue.

    `Average Disk Queue Length <= # (Disks in the array/2) *2`

  - **RAID 10**: Half the disks are doing work. Therefore, only half of them can be counted toward disks queue.

    `Average Disk Queue Length <= # (Disks in the array/2) *2`

  - **RAID 5**: All the disks are doing work in a RAID 5 set.

    `Average Disk Queue Length <= # (Disks in the array/2) *2`

    **Avg. Disk sec/Transfer**: The number of seconds that are required to complete one disk I/O.  
    **Avg. Disk sec/Read**: The average time, in seconds, to read data from the disk.  
    **Avg. Disk sec/Write**: The average time, in seconds, to write data to the disk.  
    **Disk Bytes/sec**: The number of bytes per second that are being transferred to or from the disk.  
    **Disk Transfers/sec**: The number of input and output operations per second (IOPS).

    > [!NOTE]
    > The last three counters in this list should consistently have values of approximately **.020 (20 ms)** or less and should never exceed **.050 (50 ms)**.

    The following thresholds are documented in the SQL Server performance troubleshooting guide:

    - Less than 10 ms: Very good
    - 10-20 ms: Good
    - 20-50 ms: Slow, requires attention
    - Greater than 50 ms: Serious I/O bottleneck
    - Disk Bytes/sec: The number of bytes per second that are transferred to or from the disk
    - Disk Transfers/sec: The number of input and output operations per second (IOPS)

  When **% Idle Time** is low (10 percent or less), this means that the disk is fully utilized. In this case, the last two counters in this list (**Disk Bytes/sec** and **Disk Transfers/sec**) provide a good indication of the maximum throughput of the drive in bytes and in IOPS, respectively. The throughput of a SAN drive is highly variable, depending on the number of spindles, the speed of the drives, and the speed of the channel. We recommend that you ask the SAN vendor about how many bytes and IOPS the drive should support. If **% Idle Time** is low, and the values for these two counters don't meet the expected throughput of the drive, ask the SAN vendor for more troubleshooting help.

The following articles provide deeper insight into how to troubleshoot SQL Server performance issues:

- [Troubleshooting Performance Problems in SQL Server 2008](/previous-versions/sql/sql-server-2008/dd672789(v=sql.100)?redirectedfrom=MSDN)
- [Troubleshooting Performance Problems in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966540(v=technet.10)?redirectedfrom=MSDN)
- [SQL Server Performance Survival Guide](https://social.technet.microsoft.com/wiki/contents/articles/5957.sql-server-performance-survival-guide.aspx)
- [Microsoft SQL Server 2012 Performance Dashboard Reports](https://www.microsoft.com/download/details.aspx?id=29063)
- [How To: Troubleshooting SQL Server I/O bottlenecks](/archive/blogs/sqljourney/how-to-troubleshooting-sql-server-io-bottlenecks)

### Scenario 5

Event ID 2115 is logged and a management server generates an **unable to write data to the Data Warehouse** alert in Operations Manager. You also experience the following symptoms on the management server computer:

- The management server generates one or more alerts that resemble the following:

  > Log Name:      Operations Manager  
  > Source:        Health Service Modules  
  > Date:          1/1/2022 12:00:00 PM  
  > Event ID:      31551  
  > Task Category: Data Warehouse  
  > Level:         Error  
  > Keywords:      Classic  
  > User:          N/A  
  > Computer:      \<ManagementServerFQDN>  
  > Description:  
  > Failed to store data in the Data Warehouse. The operation will be retried.  
  > Exception 'SqlException': Cannot open database "OperationsManagerDW" requested by the login. The login failed.  
  > Login failed for user 'CONTOSO\Action_Account'.  
  >  
  > One or more workflows were affected by this.  
  >  
  > Workflow name: Microsoft.SystemCenter.DataWarehouse.CollectPerformanceData  
  > Instance name: \<ManagementServerFQDN>  
  > Instance ID: {AEC38E5Z-67A9-0406-20DB-ACC33BB9C494}  
  > Management group: \<ManagementGroupName>

- The following event is logged in the Operations Manager event log on the management server:

  > Log Name:      Operations Manager  
  > Source:        HealthService  
  > Date:          1/1/2022 12:00:00 PM  
  > Event ID:      2115  
  > Task Category: None  
  > Level:         Warning  
  > Keywords:      Classic  
  > User:          N/A  
  > Computer:      \<ManagementServerFQDN>  
  > Description:  
  > A Bind Data Source in Management Group \<ManagementGroupName> has posted items to the workflow, but has not received a response in 22560 seconds.  This indicates a performance or functional problem with the workflow.  
  > Workflow Id : Microsoft.SystemCenter.DataWarehouse.CollectPerformanceData  
  > Instance    : \<ManagementServerFQDN>  
  > Instance Id : {AEC38E5Z-67A9-0406-20DB-ACC33BB9C494}

**Resolution**

This issue can occur if the management server does not have accounts that are specified for its data warehouse RunAs profiles. This issue is more likely to affect a secondary management server. To resolve this problem, follow these steps:

1. On the computer that's running Operations Manager, open the Operations console.
1. In the navigation pane, select **Administration**.
1. Expand **Security**, and then select **Run As Profiles**.
1. In the **Run As Profiles** view, double-click **Data Warehouse Account**.
1. In the **Run As Profile Properties - Data Warehouse Account** properties dialog box, select the **Run As Accounts** tab, and then select **New**.
1. In the **Run As Account** list, select **Data Warehouse Action Account**.
1. In the **Name** list, select the management server that generated the alert.
1. Select **OK** twice.
1. Follow steps 4 through 8 to assign the appropriate RunAs account to the following profiles:

   - Data Warehouse Configuration Synchronization Reader Account
   - Data Warehouse Report Deployment Account
   - Data Warehouse SQL Server Authentication Account

1. For each profile, select the RunAs account that matches the name of the RunAs profile. For example, make the following assignments:

   - Assign the Data Warehouse Configuration Synchronization Reader Account to the Data Warehouse Configuration Synchronization Reader Account profile.
   - Assign the Data Warehouse Report Deployment Account to the Data Warehouse Report Deployment Account profile.
   - Assign the Data Warehouse SQL Server Authentication Account to the Data Warehouse SQL Server Authentication Account profile.

1. On the management server that generated the alert, restart **OpsMgr Health Service**.
1. In the Operations Manager event log on the management server, verify that event ID 31554 events are logged. Event ID 31554 indicates that the monitor state has changed to **Healthy**. This change resolves the alert.

### Scenario 6

Event ID 2115 occurs on a server that's running HP MPIO FF DSM XP 3.01, to which there are no LUNs presented. When the user opens Performance Monitor and tries to add a counter, Performance Monitor hangs, and the handle count for this application increases rapidly.

**Workaround**

There are two workarounds for this issue:

- Rename the HPPerfProv.dll file, and then restart Windows. Performance Monitor will work without issues when the file is renamed and not loaded.
- Have at least one LUN present on the system.
