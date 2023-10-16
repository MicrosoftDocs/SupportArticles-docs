---
title: Maintain and troubleshoot databases
description: This article provides detailed information about how to maintain and troubleshoot BizTalk Server databases.
ms.date: 05/11/2023
ms.custom: sap:Management and Operations
ms.reviewer: v-jayaramanp
ms.topic: how-to
---
# Maintain and troubleshoot BizTalk Server databases

This article provides detailed information about how to maintain and troubleshoot BizTalk Server databases.

_Original product version:_ &nbsp; BizTalk Server databases  
_Original KB number:_ &nbsp; 952555

## Summary

The health of the Microsoft BizTalk Server databases is important for a successful BizTalk Server messaging environment. This article discusses important things to consider when you work with BizTalk Server databases. These considerations include the following:

- You must disable the `auto update statistics` and `auto create statistics` SQL Server options.
- You must set the `max degree of parallelism` (MAXDOP) option correctly.
- Determine when you can rebuild BizTalk Server indexes.
- Locking, deadlocking, or blocking may occur.
- You may experience issues with large databases or tables.
- BizTalk SQL Server Agent jobs.
- Service instances may be suspended.
- You may experience SQL Server and BizTalk Server performance issues.
- You should follow best practices in BizTalk Server.

## Introduction

This article describes how to maintain BizTalk Server databases and how to troubleshoot BizTalk Server database issues.

## You must disable the auto create statistics and auto update statistics options

You must keep the `auto create statistics` and `auto update statistics` options disabled on the `BizTalkMsgBoxDb` database. To determine whether these settings are disabled, execute the following stored procedures in SQL Server:

```sql
EXEC sp_dboption 'BizTalkMsgBoxDB', 'auto create statistics'
EXEC sp_dboption 'BizTalkMsgBoxDB', 'auto update statistics'
```

You should set the current setting to `off`. If this setting is set to `on`, turn it off by executing the following stored procedures in SQL Server:

```sql
EXEC sp_dboption 'BizTalkMsgBoxDB', 'auto create statistics', 'off'
EXEC sp_dboption 'BizTalkMsgBoxDB', 'auto update statistics', 'off'
```

## You must set the Max Degree of Parallelism property correctly

On the computer that is running SQL Server and hosting the `BizTalkMsgBoxDb` database, set the max degree of parallelism `run_value` and `config_value` properties to a value of **1**. In later SQL versions, it's also possible to specify this setting per database instead of per SQL instance. For more information, see [Set MAXDOP](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql). To determine the `max degree of parallelism` setting, execute the following stored procedure against the Master database in SQL Server:

```sql
EXEC sp_configure 'show advanced options', 1;
GO
EXEC sp_configure 'max degree of parallelism'
```

If the `run_value` and `config_value` properties aren't set to a value of **1**, execute the following stored procedure in SQL Server to set them to **1**:

```sql
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sp_configure 'max degree of parallelism', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
```

## Determine when you can rebuild BizTalk Server indexes

Most BizTalk Server indexes are clustered (index ID: 1). You can use the `DBCC SHOWCONTIG` SQL Server statement to display fragmentation information for the BizTalk Server tables.

The BizTalk Server indexes are GUID-based. Therefore, fragmentation typically occurs. If the Scan Density value that's returned by the `DBCC SHOWCONTIG` statement is less than 30 percent, the BizTalk Server indexes can be rebuilt during downtime.

Many BizTalk Server tables contain columns that use `DataType` definitions. Online indexing can't be performed in these columns. Therefore, you should never rebuild the BizTalk Server indexes while BizTalk Server processes data.

## Locking, deadlocking, or blocking may occur

Typically, locks and blocks occur in a BizTalk Server environment. However, these locks or blocks don't remain for an extended time. Therefore, blocking, and deadlocking indicate a potential problem.

## You may experience issues with large databases or tables

We have seen that when the `BizTalkMsgBoxDb` database is larger, performance problems can occur. Ideally, the `BizTalkMsgBoxDb` database shouldn't be holding any data. The `BizTalkMsgBoxDb` database should be considered a buffer until the data is processed or moved to the `BizTalkDTADb` or BAM database.

An environment that uses a powerful SQL Server at the back end and many long-running orchestrations may have a `BizTalkMsgBoxDb` database that is larger than 5 GB. A high-volume environment that uses no long-running orchestrations should have a `BizTalkMsgBoxDb` database that is much smaller than 5 GB.

The `BizTalkDTADb` database does not have a set size. However, if performance decreases, the database is probably too large. For some customers 20 GB may be considered too large, while for others that with 200 GB might work fine with a highly strong SQL server running on multiple CPUs, lots of memory, and a fast network and storage. When you have large BizTalk Server databases, you may experience the following issues:

- The `BizTalkMsgBoxDb` database continues to grow. However, both the log file and the data size remain large.

- BizTalk Server takes a longer time than usual to process even a simple message flow scenario.

- BizTalk admin console or Health and Activity Tracking (HAT) queries take a longer time than usual and may time out.

- The database log file is never truncated.

- The BizTalk SQL Server Agent jobs run slower than usual.

- Some tables are larger or have too many rows compared to the usual table size.

Databases can become large for various reasons. These reasons may include the following:

- BizTalk SQL Server Agent jobs are not running
- Large number of suspended instances
- Disk failures
- Tracking
- Throttling
- SQL Server performance
- Network latency

Make sure that you know what is expected in your environment to determine whether a data issue is occurring.

By default, tracking is enabled on the default host. BizTalk requires that the Allow Host Tracking option be checked on a single host. When tracking is enabled, the Tracking Data Decode Service (TDDS) moves the tracking event data from the `BizTalkMsgBoxDb` database to the `BizTalkDTADb` database. If the tracking host is stopped, TDDS doesn't move the data to the `BizTalkDTADb` database and the `TrackingData_x_x` tables in the `BizTalkMsgBoxDb` database will grow.

It's recommended that you dedicate one host to tracking. To allow for TDDS to maintain new tracking events in high-volume scenarios, create multiple instances of a single tracking host. No more than one tracking host should exist.

There can be too many rows in a table. There is no set number of rows that are too many. Additionally, this number of rows varies by what kind of data is stored in the table. For example, a `dta_DebugTrace` table that has more than 1 million rows probably has too many rows. A `<HostName>Q_Suspended` table that has more than 200,000 rows probably has too many rows.

## Use the correct BizTalk SQL Server Agent jobs

The BizTalk SQL Server Agent jobs are important for managing the BizTalk Server databases and for maintaining high performance.

The Backup BizTalk Server SQL Server Agent job is the only supported method to back up the BizTalk Server databases when SQL Server Agent and the BizTalkServer host instances are started. This job requires all BizTalk Server databases use a Full Recovery Model. You should configure this job for a healthy BizTalk Server environment. The SQL Server methods can be used to back up the BizTalk Server databases only if SQL Server Agent is stopped and if all BizTalk Server host instances are stopped.

The `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` SQL Server Agent job runs infinitely. Therefore, the SQL Server Agent job history never displays a successful completion. If a failure occurs, the job restarts within one minute and continues to run infinitely. Therefore, you can safely ignore the failure. Additionally, the job history can be cleared. You should only be concerned if the job history reports that this job constantly fails and restarts.

The `MessageBox_Message_Cleanup_BizTalkMsgBoxDb` SQL Server Agent job is the only BizTalk Server job that shouldn't be enabled because it's started by the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` SQL Server Agent job.

The DTA Purge and Archive SQL Server Agent job helps maintain the `BizTalkDTADb` database by purging and archiving tracked messages. This job reads every row in the table and compares the time stamp to determine whether the record should be removed.

All BizTalk SQL Server Agent jobs except the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` SQL Server Agent job should be running successfully.

## Service instances may be suspended

Service instances can be suspended (resumable) or suspended (not resumable). These service instances may be Messaging, Orchestration, or Port.

These service instances can make the `BizTalkMsgBoxDb` database grow unnecessarily and can be terminated. You can use the Group Hub to query, resume or terminate messages. You can also use _Terminate.vbs_ script or BizTalk Health Monitor (BHM) tool to query, purge, and maintain BizTalk databases. In some situations, there can be orphaned or zombie messages left in the system. The BHM tool can help to correct these situations.

For more information about the _Terminate.vbs_ script, see [Removing Suspended Service Instances](/biztalk/core/technical-reference/removing-suspended-service-instances).

Caching instances don't appear in the **Group Hub** page, and you can't suspend or terminate them. This restriction is a common cause of table growth. To prevent new zombie messages for the cache service instances in BizTalk Server 2006, install the hotfix in Microsoft Knowledge Base article 936536. This issue is fixed in BizTalk Server 2006 R2 and later versions.

> [!NOTE]
> A zombie message is a message that was routed but not consumed.

For a description of zombie messages, visit the following MSDN website: [BizTalk Core Engine's WebLog](/archive/blogs/biztalk_core_engine/)

## You may experience SQL Server and BizTalk Server performance issues

BizTalk Server makes hundreds of short, quick transactions to SQL Server within a minute. If the SQL Server can't sustain this activity, BizTalk Server may experience performance issues. In Performance Monitor, monitor the **Avg. Disk sec/Read**, **Avg. Disk sec/Transfer**, and **Avg. Disk sec/Write** Performance Monitor counters in the PhysicalDisk performance object. The optimal value is less than 10 ms (milliseconds). A value of 20 ms or larger is considered poor performance.

- [Troubleshooting Performance Problems in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966540(v=technet.10))

- [Providing High Availability for BizTalk Server Databases](/biztalk/core/providing-high-availability-for-biztalk-server-databases)

- [How to troubleshoot SQL Server performance issues](https://support.microsoft.com/help/298475)

## Best practices in BizTalk Server

Start SQL Server Agent on the SQL Server. When the SQL Server Agent is stopped, the built-in BizTalk SQL Server Agent jobs that are responsible for database maintenance cannot run. This behavior causes database growth, and this growth may cause performance issues.

Put the SQL Server Log Database File (LDF) and Main Database File (MDF) files on separate drives. When the LDF and MDF files for the `BizTalkMsgBoxDb` and `BizTalkDTADb` databases are on the same drive, disk contention can occur.

If you don't benefit from message body tracking, don't enable this feature. However, it's a good idea to enable message body tracking while you develop and troubleshoot a solution. If you do this, make sure that you disable message body tracking when you are finished. When message body tracking is enabled, the BizTalk Server databases grow. If there is a business need that requires enabling message body tracking, confirm that the `TrackedMessages_Copy_BizTalkMsgBoxDb` and DTA Purge and Archive SQL Server Agent jobs are running successfully.

Typically, smaller transaction logs cause better performance. To keep the transaction logs smaller, configure the Backup BizTalk Server SQL Server Agent job to run more frequently.

The `sp_ForceFullBackup` stored procedure in the `BizTalkMgmtDb` database can also be used to help perform an ad-hoc full backup of the data and log files. The stored procedure updates the `adm_ForceFullBackup` table with a value 1. The next time the Backup BizTalk Server job runs, a full database backup set is created.

BizTalk Health Monitor (BHM) tool can be used to evaluate an existing BizTalk Server deployment. BHM performs numerous database-related checks.

## Troubleshooting

The best troubleshooting steps for the BizTalk Server SQL Server databases depend on the kind of database issue, such as blocking or deadlocking. To troubleshoot a BizTalk Server database issue, follow these steps.

## Step 1: Enable and run all required BizTalk SQL Server Agent jobs

All the BizTalk SQL Server Agent jobs except the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` job should be enabled and running successfully. Don't disable any other job.

If a failure occurs, use the **View History** option in SQL Server to view the error information, and then troubleshoot the failure accordingly. Remember that the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` SQL Server Agent job runs infinitely. Therefore, you should only be concerned if the job history reports that the job constantly fails and restarts.

## Step 2: Use the BizTalk Health Monitor (BHM)/MsgBoxViewer tool

Collect BHM report while you reproduce an issue.

The BHM tool is useful for troubleshooting because it provides an HTML report that has detailed information about table sizes and the row count. The report can also help determine whether BizTalk Server is throttling. Additionally, the tool provides a snapshot view of the BizTalk Server databases and the BizTalk Server configuration.

For more information about throttling in BizTalk Server, see [How BizTalk Server Implements Host Throttling](/biztalk/core/how-biztalk-server-implements-host-throttling).

When BizTalk Server is running slower than usual, run the BHM tool, and then review the generated HTML report for any problems. The **Summary** section lists warnings in yellow and potential problems in red.

Additionally, you can use the BHM tool output to determine which tables are the largest and have the most records. The following table lists the BizTalk Server tables that typically grow the largest. You can use this data to determine where a potential problem may exist.

|Table|Description|
|---|---|
|`<HostName>Q_Suspended`|This table contains a reference to messages in the `Spool` table that are associated with suspended instances for the particular host. This table is in the `BizTalkMsgBoxDb` database.|
|`<HostName>Q`|This table contains a reference to messages in the `Spool` table that are associated with the particular host and aren't suspended. This table is in the `BizTalkMsgBoxDb` database.|
|`Spool`<br/><br/>`Parts`<br/><br/>`Fragments`|These tables store actual message data in the `BizTalkMsgBoxDb` database.|
|`Instances`|This table stores all instances and their current status in the `BizTalkMsgBoxDb` database.|
|`TrackingData_0_x`|These four tables store the Business Activity Monitoring (BAM) tracked events in the `BizTalkMsgBoxDb` database for TDDS to move the events to the `BAMPrimaryImport` database.|
|`TrackingData_1_x`|These four tables store the tracked events in the `BizTalkMsgBoxDb` database for TDDS to move the events to the `BizTalkDTADB` database.|
|`Tracking_Fragmentsx` <br/>`Tracking_Partsx` <br/>`Tracking_Spoolx`|Two of each of these tables is in the `BizTalkMsgBoxDb` and `BizTalkDTADb` databases. One is online, and the other is offline.<br/><br/>In BizTalk Server 2004 SP2 and in later versions, the `TrackedMessages_Copy_BizTalkMsgBoxDb` SQL Server Agent job moves tracked message bodies directly to these tables in the `BizTalkDTADb` database.<br/><br/>In BizTalk Server 2004 Service Pack 1 (SP1) and in earlier versions of BizTalk Server 2004, the `TrackedMessages_Copy_BizTalkMsgBoxDb` SQL Server Agent job copies tracked message bodies into these tables in the `BizTalkMsgBoxDb` database. The `TrackingSpool_Cleanup_BizTalkMsgBoxDb` SQL Server Agent job purges the offline tables and makes the tables online while the job also takes the online tables offline.|
|`dta_ServiceInstances`|This table stores tracked events for service instances in the `BizTalkDTADb` database. If this table is large, the `BizTalkDTADb` database is probably large.|
|`dta_DebugTrace`|This table stores the Orchestration debugger events in the BizTalkDTADb database.|
|`dta_MessageInOutEvents`|This table stores tracked event messages in the `BizTalkDTADb` database. These tracked event messages include message context information.|
|`dta_ServiceInstanceExceptions`|This table stores error information for any suspended service instance in the `BizTalkDTADb` database.|
  
Consider the following scenarios.

- **`<HostName>Q_Suspended` tables**

  If the `<HostName>Q_Suspended` tables have many records, the tables could be valid suspended instances that appear in **Group Hub** or in HAT. These instances can be terminated. If these instances don't appear in **Group Hub** or in HAT, the instances are probably caching instances or orphaned routing failure reports. When suspended instances are terminated, the items in this table and their associated rows in the `Spool` and `Instances` tables are cleaned up.

  In this scenario, handle the suspended instances by resuming them or terminating them. The BHM tool can also be used.

- **`<HostName>Q` tables**

  If the `<HostName>Q` tables have many records, the following kinds of instances may exist:

  - Ready-to-run instances
  - Active instances
  - Dehydrated instances BizTalk Server needs time to "catch up" and process the instances.

  This table can grow when the incoming rate of processing outpaces the outgoing rate of processing. This scenario can occur when another problem occurs, such as a large `BizTalkDTADb` database or SQL Server disk delays.

- **`Spool`, `Parts`, and `Fragments` tables**

    If the `Spool`, `Parts`, and `Fragments` tables have many records, many messages are currently active, dehydrated, or suspended. Depending on the size, the number of parts, and the fragmentation settings in these tables, a single message may spawn all these tables. Each message has exactly one row in the `Spool` table and at least one row in the `Parts` table.

- **`Instances` table**

  The BizTalk Administrator shouldn't allow many suspended instances to remain in the `Instances` table. Dehydrated instances should only remain if business logic requires long-running orchestrations. Remember that one service instance can be associated with many messages on the `Spool` table.

- **`TrackingData_x_x` tables**

  If the `TrackingData_x_x` tables are large, the Tracking host (TDDS) isn't running  successfully. If the tracking host instance is running, review the event logs and the `TDDS_FailedTrackingData` table in the `BizTalkDTADb` database for error information. If BizTalk is throttling with a state of 6 (large database), these tables can also be truncated by using the BizTalk Terminator tool if data isn't needed.

  If there is a large gap between the sequence numbers in the `BizTalkMsgBoxDb` `TrackingData_x_x` tables and the `BAMPrimaryImport` or `BizTalkDTADb` `TDDS_StreamStatus` tables, then TDDS may not move the data from the `BizTalkMsgBoxDb` database. To correct this, use the BHM tool to purge these tables and reset the sequence number.

- **`dta_DebugTrace` and `dta_MessageInOutEvents` tables**

  The `dta_DebugTrace` table is populated when **Shape start and end** are enabled on an orchestration. If the `dta_DebugTrace` table has many records, these orchestration debugging events are being used or were being used. If orchestration debugging isn't required for regular operations, clear the **Shape start and end** check box in the **Orchestration** properties.

  The `dta_MessageInOutEvents` table is populated when **Message send and receive** is enabled on orchestrations and/or pipelines. If these tracking events aren't needed, clear the check box for this option in the orchestration and/or pipeline properties.

  If these trace events are disabled or if a backlog exists in the `BizTalkMsgBoxDb` database, these tables may continue to grow because TDDS continues to move this data into these tables.

  By default, global tracking is enabled. If global tracking isn't necessary, it can be disabled. For more information, see [How to Turn Off Global Tracking](/biztalk/core/how-to-turn-off-global-tracking).

  If the `dta_DebugTrace` table and/or the `dta_messageInOutEvents` table in the `BizTalkDTADb` database are too large, you can truncate the tables manually after you stop the tracking host. The BHM tool also provides this functionality.
  
  To truncate all tracking tables in the `BizTalkMsgBoxDb` database, use the BHM tool. The BHM tool is available externally at the Microsoft Download Center.

  For more information about tracking database sizing guidelines, visit the following MSDN website: [Tracking Database Sizing Guidelines](/biztalk/core/tracking-database-sizing-guidelines).

- **`dta_ServiceInstanceExceptions` table**

  The `dta_ServiceInstanceExceptions` table typically becomes large in an environment that regularly has suspended instances.

## Step 3: Investigate deadlock scenarios

In a deadlock scenario, enable DBCC tracing on the SQL Server so that the deadlock information is written to the SQLERROR log.

In SQL Server 2005 and later versions, execute the following statement:

```sql
DBCC TRACEON (1222,-1)
```

In SQL Server 2000, execute the following statement:

```sql
DBCC TRACEON (1204)
```

Additionally, use the PSSDiag utility to collect data on the `Lock:Deadlock` event and the `Lock:Deadlock` Chain event.

The `BizTalkMsgBoxDB` database is a high-volume and high-transaction Online Transaction Processing (OLTP) database. Some deadlocking is expected, and this deadlocking is handled internally by the BizTalk Server engine. When this behavior occurs, no errors are listed in the error logs. When you investigate a deadlock scenario, the deadlock that you are investigating in the output must be correlated with a deadlock error in the event logs.

The dequeue command and some SQL Server Agent jobs are expected to deadlock. Typically, these jobs are selected as deadlock victims. These jobs will appear in a deadlock trace. However, no errors are listed in the event logs. Therefore, this deadlocking is expected, and you can safely ignore the deadlocking with these jobs.

If frequent deadlocks appear in a deadlock trace and if a correlating error is listed in the event logs, you may want the deadlock.

## Step 4: Look for blocked processes

Use Activity Monitor in SQL Server to obtain the server process identifier (SPID) of a locking system process. Then, run SQL Profiler to determine the SQL statement that's executing in the locking SPID.

To troubleshoot a locking and blocking issue in SQL Server, use the PSSDiag for SQL utility to capture all the Transact-SQL events that have the blocking script enabled.

In SQL Server 2005 and later versions, you can specify the **blocked process threshold** setting to determine which SPID or SPIDs are blocking longer than the threshold that you specify.

For more information about the **blocked process threshold** setting, see [blocked process threshold Server Configuration Option](/sql/database-engine/configure-windows/blocked-process-threshold-server-configuration-option).

> [!NOTE]
> When you experience a locking or blocking issue in SQL Server, it's recommended that you contact Microsoft Customer Support Services. Microsoft Customer Support Services can help you configure the correct PSSDiag utility options.

## Step 5: Install the Latest BizTalk Server Service Pack and Cumulative Update

BizTalk Server later versions have moved to a Cumulative Update (CU) model. The cumulative updates will contain the latest fixes.

## Delete all the data

If the databases are too large or if the preferred method is to delete all data, all the data can be deleted.

> [!CAUTION]
> Don't use this method in any environment where the data is business critical or if the data is needed.

## BizTalkMsgBoxDb database purging steps

To delete all data in the `BizTalkMsgBoxDb` database, use the BizTalk Health Monitor (BHM) tool.

## BizTalkDTADb database purging options

To delete all data from the `BizTalkDTADb` database, use the BizTalk Health Monitor (BHM) tool. Otherwise, use one of the following methods.

> [!NOTE]
> While both methods delete all messages, method 2 is faster.

- Method 1:

  1. Back up all BizTalk Server databases.
  1. Execute the `dtasp_PurgeAllCompletedTrackingData` stored procedure. For more information about the `dtasp_PurgeAllCompletedTrackingData` stored procedure, see [How to Manually Purge Data from the BizTalk Tracking Database](/biztalk/core/how-to-manually-purge-data-from-the-biztalk-tracking-database).

     > [!NOTE]
     > This action deletes all completed messages.

- Method 2:
  1. Back up all BizTalk databases.
  1. Execute the `dtasp_CleanHMData` stored procedure. Use this option only if the `BizTalkDTADb` database contains many incomplete instances that must be removed.

     To do this, follow these steps:

     1. Stop all BizTalk hosts, services, and custom isolated adapters. If you use HTTP or the SOAP adapter, restart the IIS services.
     1. Execute the `dtasp_CleanHMData` stored procedure on the `BizTalkDTADb` database.
     1. Restart all hosts and BizTalk Server services.

## BizTalk Server 2004-only steps

> [!NOTE]
> If you must have the tracking data, back up the `BizTalkDTADb` database, restore the database to another SQL Server, and then purge the original `BizTalkDTADb` database.

If you need help to analyze the BHM data or the PSSDiag output, contact Microsoft Customer Support Services. For a complete list of Customer Support Services telephone numbers and information about support costs, see [Contact Microsoft Support](https://support.microsoft.com/home/expcontact/).

> [!NOTE]
> Before you contact Customer Support Services, compress the BHM report data, the PSSDiag output, and the updated event logs (.evt files). You may have to send these files to a BizTalk Server support engineer.

## Applies to

- BizTalk Server 2009
- BizTalk Server 2010
- BizTalk Server 2013
- BizTalk Server 2013 R2
- BizTalk Server 2016
- BizTalk Server 2020
