---
title: Cumulative update 26 for SQL Server 2019 (KB5035123)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 26 (KB5035123).
ms.date: 01/29/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5035123
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5035123 - Cumulative Update 26 for SQL Server 2019

_Release Date:_ &nbsp; April 11, 2024  
_Version:_ &nbsp; 15.0.4365.2

## Summary

This article describes Cumulative Update package 26 (CU26) for Microsoft SQL Server 2019. This update contains 23 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 25, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4365.2**, file version: **2019.150.4365.2**
- Analysis Services - Product version: **15.0.35.45**, file version: **2018.150.35.45**

## Known issues in this update

### Issue one: Access violation when session is reset

[!INCLUDE [av-sesssion_context-2019](../includes/av-sesssion_context-2019.md)]


### Issue two: Possibility of error 1204 due to disabled lock escalation

SQL Server 2019 CU26 introduced a regression that can disable lock escalation, which causes error 1204 "The instance of the SQL Server Database Engine cannot obtain a LOCK resource at this time."

To work around this issue, you can uninstall the CU26 or install the [CU28](cumulativeupdate28.md).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component | Platform|
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|-------------|
| <a id=3004867>[3004867](#3004867) </a> | [FIX: "9003 error, sev 20, state 1" error when a backup operation fails on a secondary replica that is running in asynchronous-commit mode (KB4458880)](https://support.microsoft.com/help/4458880) | SQL Server Engine | Backup Restore| All |
| <a id=2347022>[2347022](#2347022) </a> | Fixes an issue in which the automatic seeding operation for a database remains in `LIMIT_CONCURRENT_BACKUPS` after adding the database to a new availability group or an existing one created with automatic seeding, even though this SQL Server instance doesn't have any other active seeding, virtual device interface (VDI), or backup threads. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=2893029>[2893029](#2893029) </a> | Fixes an issue in which the global primary or forwarder in a distributed availability group can't connect to the listener of the other availability group for a while after the local availability group fails over between replicas in multi-subnet configurations. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=2937599>[2937599](#2937599) </a> | Fixes an issue in which the `sp_server_diagnostics` stored procedure doesn't respond to the Always On availability group (AG) resource DLL within the `HealthCheckTimeout` when the I/O takes a long time, which causes unnecessary restart and failover. For example, when the `sp_server_diagnostics` stored procedure is waiting for the `PREEMPTIVE_OS_GETFINALFILEPATHBYHANDLE` wait type. </br></br>**Note**: To apply this fix, you need to turn on trace flag 16301, which is off by default. Tracing is added for this event regardless of the trace flag.| SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=2920065>[2920065](#2920065) </a> | Fixes an issue in which an unreliable network connection causes an unsuccessful status during backup to a network share, which causes the SQL Server instance to stop responding.| SQL Server Engine | Linux | Linux |
| <a id=2984804>[2984804](#2984804) </a> | Fixes an issue in the lock manager that might cause random access violations and dumps on secondary replicas when the primary replica has 16 or more processors, and the secondary replicas have less than 16 processors.| SQL Server Engine | Metadata| All |
| <a id=2936214>[2936214](#2936214) </a> </br><a id=2936218>[2936218](#2936218) </a> </br><a id=2941530>[2941530](#2941530) </a> </br><a id=2950263>[2950263](#2950263) </a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581)| SQL Server Engine | Programmability | All |
| <a id=2950261>[2950261](#2950261) </a> | Fixes the following SQL Server assertion failure: </br></br>Error: 17065, Severity: 16, State: 1. </br>Server Assertion: File: \<FileName>, line = \<LineNumber> Failed Assertion = 'false' Invalid comparison due to NO COLLATION.| SQL Server Engine | Programmability | All |
| <a id=2884531>[2884531](#2884531) </a> | Fixes an issue in which using the `INSERT` statement with the `CAST` or `CONVERT` function from a string representing negative zero to a decimal or numeric datatype succeeds, but you see the following error message on `DBCC CHECKDB` and `DBCC CHECKTABLE`: </br></br>Msg 2570, Level 16, State 3, Line \<LineNumber></br>Page (1:360), slot 0 in object ID \<ObjectID>, index ID \<IndexID>, partition ID \<PartitionID>, alloc unit ID \<UnitID> (type "In-row data"). Column "\<ColumnName>" value is out of range for data type "decimal". Update column to a legal value.| SQL Server Engine | Query Execution | All |
| <a id=2916485>[2916485](#2916485) </a> | Adds a new advanced option `'max RPC request params (KB)'` configured by using `sp_configure` to limit the maximum memory allocated for handling remote procedure call (RPC) request parameters. | SQL Server Engine | Query Execution | All |
| <a id=2693196>[2693196](#2693196) </a> | Fixes the following errors that you encounter when using `sp_addsubscription` to create the Subscriber on secondary replicas if the distribution database is in an availability group: </br></br>Msg 20032, Level 16, State 1, Procedure distribution.dbo.sp_MSadd_subscription, Line \<LineNumber> [Batch Start Line 33] </br>\<SubscriberName> is not defined as a Subscriber for \<PublisherName>. </br>Msg 14070, Level 16, State 1, Procedure sys.sp_MSrepl_changesubstatus, Line \<LineNumber> [Batch Start Line 33]</br>Could not update the distribution database subscription table. The subscription status could not be changed. </br>Msg 14057, Level 16, State 1, Procedure sys.sp_MSrepl_addsubscription_article, Line \<LineNumber> [Batch Start Line 33] </br>The subscription could not be created. | SQL Server Engine | Replication | All |
| <a id=2937228>[2937228](#2937228) </a> | Fixes an issue in which [error 18482](/sql/relational-databases/errors-events/mssqlserver-18482-database-engine-error) is caused when using `sp_adddistributor` to add a remote distributor if the Publisher server name contains lowercase characters and the Distributor server has the case-sensitive (_CS) collation.| SQL Server Engine | Replication | All |
| <a id=2877235>[2877235](#2877235) </a> | Adds the following fields to the `sqlserver.fulltext_filter_usage` Extended Event (XEvent) to improve the telemetry reporting for the XEvent: </br></br>- min_input_size </br>- max_input_size </br>- min_output_size </br>- max_output_size | SQL Server Engine | Search| Windows |
| <a id=2924913>[2924913](#2924913) </a> | Fixes an issue in which the full-text auto crawl function might stop working when you use full-text search. | SQL Server Engine | Search | All |
| <a id=2958811>[2958811](#2958811) </a> | Fixes an overflow issue of the word occurrence that you encounter during the full-text merging process.| SQL Server Engine | Search| All |
| <a id=3014264>[3014264](#3014264) </a> | Limits the extra number of user tokens created by `sys.sysprocesses` or `sys.dm_exec_requests` by using trace flag 4673. | SQL Server Engine | Security Infrastructure | All |
| <a id=2907885>[2907885](#2907885) </a> | Fixes an issue that causes the SQL Server Agent to terminate with the following error message: </br></br>Exception 5 caught at line \<LineNumber> of file \<FileName>. SQLServerAgent initiating self-termination. | SQL Server Engine |SQL Agent| All |
| <a id=2963638>[2963638](#2963638) </a> </br><a id=2963641>[2963641](#2963641) </a> | Fixes an assertion failure (Location: setypes.cpp:1274; Expression: !IsInRowDiff()) that you might encounter at `FAILED_ASSERTION_42ac_sqlmin.dll!VersionRecPtr::IsNull` when you have multiple nested inserts. </br></br>**Note**: You can enable trace flag (TF) 7117 to mitigate the issue. Turn off TF 7117 after the mitigation is done, which means after the version cleaner cleans the problematic page. | SQL Server Engine | SQL Server Engine | All |
| <a id=2945166>[2945166](#2945166) </a> | Fixes an access violation caused by a race between a database and a parallel redo shutdown.| SQL Server Engine | Transaction Services| All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU26 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5035123)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202019) contains this SQL Server 2019 CU and previously released SQL Server 2019 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2019 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2019 Release Notes](/sql/linux/sql-server-linux-release-notes-2019).

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update for Big Data Clusters (BDC)</b></summary>

To upgrade Microsoft SQL Server 2019 Big Data Clusters (BDC) on Linux to the latest CU, see the [Big Data Clusters Deployment Guidance](/sql/big-data-cluster/deployment-guidance).

Starting in SQL Server 2019 CU1, you can perform in-place upgrades for Big Data Clusters from the production supported releases (SQL Server 2019 GDR1). For more information, see [How to upgrade SQL Server Big Data Clusters](/sql/big-data-cluster/deployment-upgrade).

For more information, see the [Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2019-KB5035123-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5035123-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5035123-x64.exe| 284A8582369D896F0229E8639BF21A3EB0FA354367BC9E92330B4178408EBF5C |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.45  | 292928    | 29-Mar-2024 | 23:49 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.45      | 758328    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 175552    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 199616    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 202176    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 198608    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 214976    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197568    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 193472    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 252464    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 174016    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197072    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.45      | 1098688   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.45      | 567344    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 54736     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59328     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59840     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58816     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 61888     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58320     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 67632     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 53696     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 18992     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 29-Mar-2024 | 23:49 | x86      |
| Msmdctr.dll                                               | 2018.150.35.45  | 38448     | 29-Mar-2024 | 23:49 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.45  | 47785008  | 29-Mar-2024 | 23:49 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.45  | 66260928  | 29-Mar-2024 | 23:49 | x64      |
| Msmdpump.dll                                              | 2018.150.35.45  | 10187200  | 29-Mar-2024 | 23:49 | x64      |
| Msmdredir.dll                                             | 2018.150.35.45  | 7957440   | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16848     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17456     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 18480     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16832     | 29-Mar-2024 | 23:49 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 29-Mar-2024 | 23:49 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.45  | 65798080  | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 833600    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1628224   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1454128   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1643064   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1608768   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1001536   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 992816    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1537080   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1521728   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 811056    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1596480   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 832560    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1624640   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1451064   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1637944   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1604672   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 998960    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 991280    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1532992   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1518144   | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 810032    | 29-Mar-2024 | 23:49 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1591856   | 29-Mar-2024 | 23:49 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.45  | 8280120   | 29-Mar-2024 | 23:49 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.45  | 10186176  | 29-Mar-2024 | 23:49 | x64      |
| Msolap.dll                                                | 2018.150.35.45  | 8607168   | 29-Mar-2024 | 23:49 | x86      |
| Msolap.dll                                                | 2018.150.35.45  | 11013072  | 29-Mar-2024 | 23:49 | x64      |
| Msolui.dll                                                | 2018.150.35.45  | 286256    | 29-Mar-2024 | 23:49 | x86      |
| Msolui.dll                                                | 2018.150.35.45  | 306752    | 29-Mar-2024 | 23:49 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 29-Mar-2024 | 23:49 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 29-Mar-2024 | 23:49 | x64      |
| Sqlboot.dll                                               | 2019.150.4365.2 | 215080    | 29-Mar-2024 | 23:49 | x64      |
| Sqlceip.exe                                               | 15.0.4365.2     | 296896    | 29-Mar-2024 | 23:49 | x86      |
| Sqldumper.exe                                             | 2019.150.4365.2 | 321592    | 29-Mar-2024 | 23:49 | x86      |
| Sqldumper.exe                                             | 2019.150.4365.2 | 378816    | 29-Mar-2024 | 23:49 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 29-Mar-2024 | 23:49 | x86      |
| Tmapi.dll                                                 | 2018.150.35.45  | 6178352   | 29-Mar-2024 | 23:49 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.45  | 4917712   | 29-Mar-2024 | 23:49 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.45  | 1184816   | 29-Mar-2024 | 23:49 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.45  | 6807104   | 29-Mar-2024 | 23:49 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.45  | 35460032  | 29-Mar-2024 | 23:49 | x86      |
| Xmsrv.dll                                                 | 2018.150.35.45  | 26025520  | 29-Mar-2024 | 23:49 | x64      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4365.2 | 165840    | 29-Mar-2024 | 23:50 | x86      |
| Batchparser.dll                      | 2019.150.4365.2 | 182208    | 29-Mar-2024 | 23:50 | x64      |
| Instapi150.dll                       | 2019.150.4365.2 | 75816     | 29-Mar-2024 | 23:50 | x86      |
| Instapi150.dll                       | 2019.150.4365.2 | 88104     | 29-Mar-2024 | 23:50 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4365.2 | 104400    | 29-Mar-2024 | 23:50 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4365.2 | 88104     | 29-Mar-2024 | 23:50 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4365.2     | 550864    | 29-Mar-2024 | 23:50 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4365.2     | 550952    | 29-Mar-2024 | 23:50 | x86      |
| Msasxpress.dll                       | 2018.150.35.45  | 27184     | 29-Mar-2024 | 23:50 | x86      |
| Msasxpress.dll                       | 2018.150.35.45  | 32304     | 29-Mar-2024 | 23:50 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4365.2 | 75712     | 29-Mar-2024 | 23:50 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4365.2 | 92200     | 29-Mar-2024 | 23:50 | x64      |
| Sqldumper.exe                        | 2019.150.4365.2 | 321592    | 29-Mar-2024 | 23:50 | x86      |
| Sqldumper.exe                        | 2019.150.4365.2 | 378816    | 29-Mar-2024 | 23:50 | x64      |
| Sqlftacct.dll                        | 2019.150.4365.2 | 59448     | 29-Mar-2024 | 23:50 | x86      |
| Sqlftacct.dll                        | 2019.150.4365.2 | 79912     | 29-Mar-2024 | 23:50 | x64      |
| Sqlmanager.dll                       | 2019.150.4365.2 | 743360    | 29-Mar-2024 | 23:50 | x86      |
| Sqlmanager.dll                       | 2019.150.4365.2 | 878536    | 29-Mar-2024 | 23:50 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4365.2 | 378920    | 29-Mar-2024 | 23:50 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4365.2 | 432080    | 29-Mar-2024 | 23:50 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4365.2 | 276520    | 29-Mar-2024 | 23:50 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4365.2 | 358352    | 29-Mar-2024 | 23:50 | x64      |
| Svrenumapi150.dll                    | 2019.150.4365.2 | 1161256   | 29-Mar-2024 | 23:50 | x64      |
| Svrenumapi150.dll                    | 2019.150.4365.2 | 911296    | 29-Mar-2024 | 23:50 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4365.2  | 600104    | 29-Mar-2024 | 23:51 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4365.2  | 600016    | 29-Mar-2024 | 23:51 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4365.2  | 1857472   | 29-Mar-2024 | 23:51 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4365.2  | 1857472   | 29-Mar-2024 | 23:51 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4365.2 | 137256    | 29-Mar-2024 | 23:51 | x86      |
| Dreplaycommon.dll     | 2019.150.4365.2 | 667584    | 29-Mar-2024 | 23:51 | x86      |
| Dreplayutil.dll       | 2019.150.4365.2 | 305208    | 29-Mar-2024 | 23:51 | x86      |
| Instapi150.dll        | 2019.150.4365.2 | 88104     | 29-Mar-2024 | 23:51 | x64      |
| Sqlresourceloader.dll | 2019.150.4365.2 | 38952     | 29-Mar-2024 | 23:51 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4365.2 | 667584    | 29-Mar-2024 | 23:52 | x86      |
| Dreplaycontroller.exe | 2019.150.4365.2 | 366648    | 29-Mar-2024 | 23:52 | x86      |
| Instapi150.dll        | 2019.150.4365.2 | 88104     | 29-Mar-2024 | 23:52 | x64      |
| Sqlresourceloader.dll | 2019.150.4365.2 | 38952     | 29-Mar-2024 | 23:52 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4365.2 | 4658216   | 30-Mar-2024 | 00:21 | x64      |
| Aetm-enclave.dll                           | 2019.150.4365.2 | 4612648   | 30-Mar-2024 | 00:21 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4365.2 | 4931904   | 30-Mar-2024 | 00:21 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4365.2 | 4873032   | 30-Mar-2024 | 00:21 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 30-Mar-2024 | 00:14 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 30-Mar-2024 | 00:14 | x64      |
| Batchparser.dll                            | 2019.150.4365.2 | 182208    | 30-Mar-2024 | 00:21 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 30-Mar-2024 | 00:21 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 30-Mar-2024 | 00:21 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 30-Mar-2024 | 00:21 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 30-Mar-2024 | 00:21 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4365.2 | 280616    | 30-Mar-2024 | 00:21 | x64      |
| Dcexec.exe                                 | 2019.150.4365.2 | 88016     | 30-Mar-2024 | 00:21 | x64      |
| Fssres.dll                                 | 2019.150.4365.2 | 96208     | 30-Mar-2024 | 00:21 | x64      |
| Hadrres.dll                                | 2019.150.4365.2 | 206784    | 30-Mar-2024 | 00:21 | x64      |
| Hkcompile.dll                              | 2019.150.4365.2 | 1292328   | 30-Mar-2024 | 00:21 | x64      |
| Hkengine.dll                               | 2019.150.4365.2 | 5793744   | 30-Mar-2024 | 00:21 | x64      |
| Hkruntime.dll                              | 2019.150.4365.2 | 182208    | 30-Mar-2024 | 00:21 | x64      |
| Hktempdb.dll                               | 2019.150.4365.2 | 63424     | 30-Mar-2024 | 00:21 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 30-Mar-2024 | 00:21 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4365.2     | 235456    | 30-Mar-2024 | 00:21 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4365.2 | 391104    | 30-Mar-2024 | 00:21 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4365.2 | 325584    | 30-Mar-2024 | 00:21 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4365.2 | 92096     | 30-Mar-2024 | 00:21 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 30-Mar-2024 | 00:21 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 30-Mar-2024 | 00:21 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 30-Mar-2024 | 00:21 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 30-Mar-2024 | 00:21 | x64      |
| Qds.dll                                    | 2019.150.4365.2 | 1189928   | 30-Mar-2024 | 00:21 | x64      |
| Rsfxft.dll                                 | 2019.150.4365.2 | 51240     | 30-Mar-2024 | 00:21 | x64      |
| Secforwarder.dll                           | 2019.150.4365.2 | 79808     | 30-Mar-2024 | 00:21 | x64      |
| Sqagtres.dll                               | 2019.150.4365.2 | 88016     | 30-Mar-2024 | 00:21 | x64      |
| Sqlaamss.dll                               | 2019.150.4365.2 | 108480    | 30-Mar-2024 | 00:21 | x64      |
| Sqlaccess.dll                              | 2019.150.4365.2 | 493520    | 30-Mar-2024 | 00:21 | x64      |
| Sqlagent.exe                               | 2019.150.4365.2 | 731072    | 30-Mar-2024 | 00:21 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4365.2 | 71616     | 30-Mar-2024 | 00:21 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4365.2 | 79912     | 30-Mar-2024 | 00:21 | x64      |
| Sqlboot.dll                                | 2019.150.4365.2 | 215080    | 30-Mar-2024 | 00:14 | x64      |
| Sqlceip.exe                                | 15.0.4365.2     | 296896    | 30-Mar-2024 | 00:21 | x86      |
| Sqlcmdss.dll                               | 2019.150.4365.2 | 88000     | 30-Mar-2024 | 00:21 | x64      |
| Sqlctr150.dll                              | 2019.150.4365.2 | 116776    | 30-Mar-2024 | 00:21 | x86      |
| Sqlctr150.dll                              | 2019.150.4365.2 | 145448    | 30-Mar-2024 | 00:21 | x64      |
| Sqldk.dll                                  | 2019.150.4365.2 | 3180480   | 30-Mar-2024 | 00:21 | x64      |
| Sqldtsss.dll                               | 2019.150.4365.2 | 108600    | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 1595344   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3508264   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3704784   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4171816   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4290600   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3422248   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3586000   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4163520   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4020264   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4069416   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 2226128   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 2177080   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3876904   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3553320   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4024360   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3827648   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3823552   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3618856   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3508264   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 1542184   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 3917864   | 30-Mar-2024 | 00:21 | x64      |
| Sqlevn70.rll                               | 2019.150.4365.2 | 4036560   | 30-Mar-2024 | 00:21 | x64      |
| Sqllang.dll                                | 2019.150.4365.2 | 40056872  | 30-Mar-2024 | 00:21 | x64      |
| Sqlmin.dll                                 | 2019.150.4365.2 | 40643112  | 30-Mar-2024 | 00:21 | x64      |
| Sqlolapss.dll                              | 2019.150.4365.2 | 108496    | 30-Mar-2024 | 00:21 | x64      |
| Sqlos.dll                                  | 2019.150.4365.2 | 42944     | 30-Mar-2024 | 00:21 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4365.2 | 83904     | 30-Mar-2024 | 00:21 | x64      |
| Sqlrepss.dll                               | 2019.150.4365.2 | 88016     | 30-Mar-2024 | 00:21 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4365.2 | 51136     | 30-Mar-2024 | 00:21 | x64      |
| Sqlscm.dll                                 | 2019.150.4365.2 | 88016     | 30-Mar-2024 | 00:21 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4365.2 | 38848     | 30-Mar-2024 | 00:21 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4365.2 | 5806016   | 30-Mar-2024 | 00:21 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4365.2 | 673832    | 30-Mar-2024 | 00:21 | x64      |
| Sqlservr.exe                               | 2019.150.4365.2 | 628672    | 30-Mar-2024 | 00:21 | x64      |
| Sqlsvc.dll                                 | 2019.150.4365.2 | 182312    | 30-Mar-2024 | 00:21 | x64      |
| Sqltses.dll                                | 2019.150.4365.2 | 9119680   | 30-Mar-2024 | 00:21 | x64      |
| Sqsrvres.dll                               | 2019.150.4365.2 | 280512    | 30-Mar-2024 | 00:21 | x64      |
| Stretchcodegen.exe                         | 15.0.4365.2     | 59448     | 30-Mar-2024 | 00:21 | x86      |
| Svl.dll                                    | 2019.150.4365.2 | 161728    | 30-Mar-2024 | 00:21 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 30-Mar-2024 | 00:21 | x64      |
| Xe.dll                                     | 2019.150.4365.2 | 722896    | 30-Mar-2024 | 00:21 | x64      |
| Xpadsi.exe                                 | 2019.150.4365.2 | 116688    | 30-Mar-2024 | 00:21 | x64      |
| Xplog70.dll                                | 2019.150.4365.2 | 92200     | 30-Mar-2024 | 00:21 | x64      |
| Xpqueue.dll                                | 2019.150.4365.2 | 92216     | 30-Mar-2024 | 00:21 | x64      |
| Xprepl.dll                                 | 2019.150.4365.2 | 120768    | 30-Mar-2024 | 00:21 | x64      |
| Xpstar.dll                                 | 2019.150.4365.2 | 473144    | 30-Mar-2024 | 00:21 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4365.2 | 182208    | 29-Mar-2024 | 23:49 | x64      |
| Batchparser.dll                                              | 2019.150.4365.2 | 165840    | 29-Mar-2024 | 23:49 | x86      |
| Commanddest.dll                                              | 2019.150.4365.2 | 264128    | 29-Mar-2024 | 23:49 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4365.2 | 227384    | 29-Mar-2024 | 23:49 | x64      |
| Distrib.exe                                                  | 2019.150.4365.2 | 243648    | 29-Mar-2024 | 23:49 | x64      |
| Dteparse.dll                                                 | 2019.150.4365.2 | 124968    | 29-Mar-2024 | 23:49 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4365.2 | 133176    | 29-Mar-2024 | 23:49 | x64      |
| Dtepkg.dll                                                   | 2019.150.4365.2 | 153640    | 29-Mar-2024 | 23:49 | x64      |
| Dtexec.exe                                                   | 2019.150.4365.2 | 73664     | 29-Mar-2024 | 23:49 | x64      |
| Dts.dll                                                      | 2019.150.4365.2 | 3143616   | 29-Mar-2024 | 23:49 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4365.2 | 501800    | 29-Mar-2024 | 23:49 | x64      |
| Dtsconn.dll                                                  | 2019.150.4365.2 | 522280    | 29-Mar-2024 | 23:49 | x64      |
| Dtshost.exe                                                  | 2019.150.4365.2 | 107576    | 29-Mar-2024 | 23:49 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4365.2 | 567336    | 29-Mar-2024 | 23:49 | x64      |
| Dtspipeline.dll                                              | 2019.150.4365.2 | 1329192   | 29-Mar-2024 | 23:49 | x64      |
| Dtswizard.exe                                                | 15.0.4365.2     | 886824    | 29-Mar-2024 | 23:49 | x64      |
| Dtuparse.dll                                                 | 2019.150.4365.2 | 100392    | 29-Mar-2024 | 23:49 | x64      |
| Dtutil.exe                                                   | 2019.150.4365.2 | 151080    | 29-Mar-2024 | 23:49 | x64      |
| Exceldest.dll                                                | 2019.150.4365.2 | 280512    | 29-Mar-2024 | 23:49 | x64      |
| Excelsrc.dll                                                 | 2019.150.4365.2 | 309184    | 29-Mar-2024 | 23:49 | x64      |
| Execpackagetask.dll                                          | 2019.150.4365.2 | 186304    | 29-Mar-2024 | 23:49 | x64      |
| Flatfiledest.dll                                             | 2019.150.4365.2 | 411584    | 29-Mar-2024 | 23:49 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4365.2 | 428072    | 29-Mar-2024 | 23:49 | x64      |
| Logread.exe                                                  | 2019.150.4365.2 | 723000    | 29-Mar-2024 | 23:49 | x64      |
| Mergetxt.dll                                                 | 2019.150.4365.2 | 75832     | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4365.2     | 59432     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4365.2     | 43048     | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4365.2     | 391104    | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4365.2 | 1697728   | 29-Mar-2024 | 23:49 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4365.2 | 1640384   | 29-Mar-2024 | 23:49 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4365.2     | 550864    | 29-Mar-2024 | 23:49 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4365.2 | 112680    | 29-Mar-2024 | 23:49 | x64      |
| Msgprox.dll                                                  | 2019.150.4365.2 | 301096    | 29-Mar-2024 | 23:49 | x64      |
| Msoledbsql.dll                                               | 2018.187.2.0    | 2754584   | 29-Mar-2024 | 23:49 | x64      |
| Msoledbsql.dll                                               | 2018.187.2.0    | 153624    | 29-Mar-2024 | 23:49 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4365.2 | 1497128   | 29-Mar-2024 | 23:49 | x64      |
| Oledbdest.dll                                                | 2019.150.4365.2 | 280632    | 29-Mar-2024 | 23:49 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4365.2 | 313296    | 29-Mar-2024 | 23:49 | x64      |
| Osql.exe                                                     | 2019.150.4365.2 | 92200     | 29-Mar-2024 | 23:49 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4365.2 | 501696    | 29-Mar-2024 | 23:49 | x64      |
| Rawdest.dll                                                  | 2019.150.4365.2 | 227368    | 29-Mar-2024 | 23:49 | x64      |
| Rawsource.dll                                                | 2019.150.4365.2 | 210984    | 29-Mar-2024 | 23:49 | x64      |
| Rdistcom.dll                                                 | 2019.150.4365.2 | 915392    | 29-Mar-2024 | 23:49 | x64      |
| Recordsetdest.dll                                            | 2019.150.4365.2 | 202688    | 29-Mar-2024 | 23:49 | x64      |
| Repldp.dll                                                   | 2019.150.4365.2 | 313296    | 29-Mar-2024 | 23:49 | x64      |
| Replerrx.dll                                                 | 2019.150.4365.2 | 182312    | 29-Mar-2024 | 23:49 | x64      |
| Replisapi.dll                                                | 2019.150.4365.2 | 395320    | 29-Mar-2024 | 23:49 | x64      |
| Replmerg.exe                                                 | 2019.150.4365.2 | 563240    | 29-Mar-2024 | 23:49 | x64      |
| Replprov.dll                                                 | 2019.150.4365.2 | 862248    | 29-Mar-2024 | 23:49 | x64      |
| Replrec.dll                                                  | 2019.150.4365.2 | 1034176   | 29-Mar-2024 | 23:49 | x64      |
| Replsub.dll                                                  | 2019.150.4365.2 | 473024    | 29-Mar-2024 | 23:49 | x64      |
| Replsync.dll                                                 | 2019.150.4365.2 | 165928    | 29-Mar-2024 | 23:49 | x64      |
| Spresolv.dll                                                 | 2019.150.4365.2 | 276536    | 29-Mar-2024 | 23:49 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4365.2 | 264128    | 29-Mar-2024 | 23:49 | x64      |
| Sqldiag.exe                                                  | 2019.150.4365.2 | 1140672   | 29-Mar-2024 | 23:49 | x64      |
| Sqldistx.dll                                                 | 2019.150.4365.2 | 251840    | 29-Mar-2024 | 23:49 | x64      |
| Sqllogship.exe                                               | 15.0.4365.2     | 104384    | 29-Mar-2024 | 23:49 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4365.2 | 399400    | 29-Mar-2024 | 23:49 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4365.2 | 51136     | 29-Mar-2024 | 23:49 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4365.2 | 38952     | 29-Mar-2024 | 23:49 | x86      |
| Sqlscm.dll                                                   | 2019.150.4365.2 | 88016     | 29-Mar-2024 | 23:49 | x64      |
| Sqlscm.dll                                                   | 2019.150.4365.2 | 79800     | 29-Mar-2024 | 23:49 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4365.2 | 182312    | 29-Mar-2024 | 23:49 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4365.2 | 149544    | 29-Mar-2024 | 23:49 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4365.2 | 202792    | 29-Mar-2024 | 23:49 | x64      |
| Ssradd.dll                                                   | 2019.150.4365.2 | 84008     | 29-Mar-2024 | 23:49 | x64      |
| Ssravg.dll                                                   | 2019.150.4365.2 | 84008     | 29-Mar-2024 | 23:49 | x64      |
| Ssrdown.dll                                                  | 2019.150.4365.2 | 75816     | 29-Mar-2024 | 23:49 | x64      |
| Ssrmax.dll                                                   | 2019.150.4365.2 | 84024     | 29-Mar-2024 | 23:49 | x64      |
| Ssrmin.dll                                                   | 2019.150.4365.2 | 84024     | 29-Mar-2024 | 23:49 | x64      |
| Ssrpub.dll                                                   | 2019.150.4365.2 | 79928     | 29-Mar-2024 | 23:49 | x64      |
| Ssrup.dll                                                    | 2019.150.4365.2 | 75816     | 29-Mar-2024 | 23:49 | x64      |
| Txagg.dll                                                    | 2019.150.4365.2 | 391104    | 29-Mar-2024 | 23:49 | x64      |
| Txbdd.dll                                                    | 2019.150.4365.2 | 194616    | 29-Mar-2024 | 23:49 | x64      |
| Txdatacollector.dll                                          | 2019.150.4365.2 | 473040    | 29-Mar-2024 | 23:49 | x64      |
| Txdataconvert.dll                                            | 2019.150.4365.2 | 317376    | 29-Mar-2024 | 23:49 | x64      |
| Txderived.dll                                                | 2019.150.4365.2 | 640960    | 29-Mar-2024 | 23:49 | x64      |
| Txlookup.dll                                                 | 2019.150.4365.2 | 542672    | 29-Mar-2024 | 23:49 | x64      |
| Txmerge.dll                                                  | 2019.150.4365.2 | 247760    | 29-Mar-2024 | 23:49 | x64      |
| Txmergejoin.dll                                              | 2019.150.4365.2 | 309184    | 29-Mar-2024 | 23:49 | x64      |
| Txmulticast.dll                                              | 2019.150.4365.2 | 145344    | 29-Mar-2024 | 23:49 | x64      |
| Txrowcount.dll                                               | 2019.150.4365.2 | 141352    | 29-Mar-2024 | 23:49 | x64      |
| Txsort.dll                                                   | 2019.150.4365.2 | 288824    | 29-Mar-2024 | 23:49 | x64      |
| Txsplit.dll                                                  | 2019.150.4365.2 | 624680    | 29-Mar-2024 | 23:49 | x64      |
| Txunionall.dll                                               | 2019.150.4365.2 | 198696    | 29-Mar-2024 | 23:49 | x64      |
| Xe.dll                                                       | 2019.150.4365.2 | 722896    | 29-Mar-2024 | 23:49 | x64      |
| Xmlsub.dll                                                   | 2019.150.4365.2 | 297016    | 29-Mar-2024 | 23:49 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |     Date    |  Time | Platform |
|:------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4365.2 | 96192     | 29-Mar-2024 | 23:51 | x64      |
| Exthost.exe        | 2019.150.4365.2 | 239672    | 29-Mar-2024 | 23:51 | x64      |
| Launchpad.exe      | 2019.150.4365.2 | 1230784   | 29-Mar-2024 | 23:51 | x64      |
| Sqlsatellite.dll   | 2019.150.4365.2 | 1025984   | 29-Mar-2024 | 23:51 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |     Date    |  Time | Platform |
|:--------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4365.2 | 686120    | 29-Mar-2024 | 23:50 | x64      |
| Fdhost.exe     | 2019.150.4365.2 | 128960    | 29-Mar-2024 | 23:50 | x64      |
| Fdlauncher.exe | 2019.150.4365.2 | 79824     | 29-Mar-2024 | 23:50 | x64      |
| Sqlft150ph.dll | 2019.150.4365.2 | 92200     | 29-Mar-2024 | 23:50 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4365.2  | 30672     | 29-Mar-2024 | 23:51 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4365.2 | 264128    | 29-Mar-2024 | 23:48 | x64      |
| Commanddest.dll                                               | 2019.150.4365.2 | 227384    | 29-Mar-2024 | 23:48 | x86      |
| Dteparse.dll                                                  | 2019.150.4365.2 | 112696    | 29-Mar-2024 | 23:48 | x86      |
| Dteparse.dll                                                  | 2019.150.4365.2 | 124968    | 29-Mar-2024 | 23:48 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4365.2 | 116792    | 29-Mar-2024 | 23:48 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4365.2 | 133176    | 29-Mar-2024 | 23:48 | x64      |
| Dtepkg.dll                                                    | 2019.150.4365.2 | 133072    | 29-Mar-2024 | 23:48 | x86      |
| Dtepkg.dll                                                    | 2019.150.4365.2 | 153640    | 29-Mar-2024 | 23:48 | x64      |
| Dtexec.exe                                                    | 2019.150.4365.2 | 64960     | 29-Mar-2024 | 23:48 | x86      |
| Dtexec.exe                                                    | 2019.150.4365.2 | 73664     | 29-Mar-2024 | 23:48 | x64      |
| Dts.dll                                                       | 2019.150.4365.2 | 2762792   | 29-Mar-2024 | 23:48 | x86      |
| Dts.dll                                                       | 2019.150.4365.2 | 3143616   | 29-Mar-2024 | 23:48 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4365.2 | 444472    | 29-Mar-2024 | 23:48 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4365.2 | 501800    | 29-Mar-2024 | 23:48 | x64      |
| Dtsconn.dll                                                   | 2019.150.4365.2 | 432184    | 29-Mar-2024 | 23:48 | x86      |
| Dtsconn.dll                                                   | 2019.150.4365.2 | 522280    | 29-Mar-2024 | 23:48 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4365.2 | 113088    | 29-Mar-2024 | 23:48 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4365.2 | 94760     | 29-Mar-2024 | 23:48 | x86      |
| Dtshost.exe                                                   | 2019.150.4365.2 | 107576    | 29-Mar-2024 | 23:48 | x64      |
| Dtshost.exe                                                   | 2019.150.4365.2 | 89640     | 29-Mar-2024 | 23:48 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4365.2 | 554960    | 29-Mar-2024 | 23:48 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4365.2 | 567336    | 29-Mar-2024 | 23:48 | x64      |
| Dtspipeline.dll                                               | 2019.150.4365.2 | 1120192   | 29-Mar-2024 | 23:48 | x86      |
| Dtspipeline.dll                                               | 2019.150.4365.2 | 1329192   | 29-Mar-2024 | 23:48 | x64      |
| Dtswizard.exe                                                 | 15.0.4365.2     | 886824    | 29-Mar-2024 | 23:48 | x64      |
| Dtswizard.exe                                                 | 15.0.4365.2     | 890816    | 29-Mar-2024 | 23:48 | x86      |
| Dtuparse.dll                                                  | 2019.150.4365.2 | 100392    | 29-Mar-2024 | 23:48 | x64      |
| Dtuparse.dll                                                  | 2019.150.4365.2 | 88120     | 29-Mar-2024 | 23:48 | x86      |
| Dtutil.exe                                                    | 2019.150.4365.2 | 130496    | 29-Mar-2024 | 23:48 | x86      |
| Dtutil.exe                                                    | 2019.150.4365.2 | 151080    | 29-Mar-2024 | 23:48 | x64      |
| Exceldest.dll                                                 | 2019.150.4365.2 | 235560    | 29-Mar-2024 | 23:48 | x86      |
| Exceldest.dll                                                 | 2019.150.4365.2 | 280512    | 29-Mar-2024 | 23:48 | x64      |
| Excelsrc.dll                                                  | 2019.150.4365.2 | 260136    | 29-Mar-2024 | 23:48 | x86      |
| Excelsrc.dll                                                  | 2019.150.4365.2 | 309184    | 29-Mar-2024 | 23:48 | x64      |
| Execpackagetask.dll                                           | 2019.150.4365.2 | 149456    | 29-Mar-2024 | 23:48 | x86      |
| Execpackagetask.dll                                           | 2019.150.4365.2 | 186304    | 29-Mar-2024 | 23:48 | x64      |
| Flatfiledest.dll                                              | 2019.150.4365.2 | 358456    | 29-Mar-2024 | 23:48 | x86      |
| Flatfiledest.dll                                              | 2019.150.4365.2 | 411584    | 29-Mar-2024 | 23:48 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4365.2 | 370728    | 29-Mar-2024 | 23:48 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4365.2 | 428072    | 29-Mar-2024 | 23:48 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4365.2     | 120784    | 29-Mar-2024 | 23:48 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4365.2     | 120784    | 29-Mar-2024 | 23:48 | x86      |
| Isserverexec.exe                                              | 15.0.4365.2     | 149560    | 29-Mar-2024 | 23:41 | x86      |
| Isserverexec.exe                                              | 15.0.4365.2     | 145448    | 29-Mar-2024 | 23:41 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4365.2     | 116688    | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4365.2     | 59432     | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4365.2     | 59448     | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4365.2     | 509904    | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4365.2     | 509992    | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4365.2     | 43048     | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4365.2     | 391104    | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4365.2     | 59432     | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4365.2     | 59328     | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4365.2     | 141352    | 29-Mar-2024 | 23:48 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4365.2     | 141248    | 29-Mar-2024 | 23:48 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4365.2     | 219072    | 29-Mar-2024 | 23:48 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4365.2 | 100408    | 29-Mar-2024 | 23:48 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4365.2 | 112680    | 29-Mar-2024 | 23:48 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.45  | 10062904  | 29-Mar-2024 | 23:41 | x64      |
| Odbcdest.dll                                                  | 2019.150.4365.2 | 370624    | 29-Mar-2024 | 23:48 | x64      |
| Odbcdest.dll                                                  | 2019.150.4365.2 | 321472    | 29-Mar-2024 | 23:48 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4365.2 | 382912    | 29-Mar-2024 | 23:48 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4365.2 | 329784    | 29-Mar-2024 | 23:48 | x86      |
| Oledbdest.dll                                                 | 2019.150.4365.2 | 280632    | 29-Mar-2024 | 23:48 | x64      |
| Oledbdest.dll                                                 | 2019.150.4365.2 | 239656    | 29-Mar-2024 | 23:48 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4365.2 | 313296    | 29-Mar-2024 | 23:48 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4365.2 | 264232    | 29-Mar-2024 | 23:48 | x86      |
| Rawdest.dll                                                   | 2019.150.4365.2 | 190520    | 29-Mar-2024 | 23:48 | x86      |
| Rawdest.dll                                                   | 2019.150.4365.2 | 227368    | 29-Mar-2024 | 23:48 | x64      |
| Rawsource.dll                                                 | 2019.150.4365.2 | 178216    | 29-Mar-2024 | 23:48 | x86      |
| Rawsource.dll                                                 | 2019.150.4365.2 | 210984    | 29-Mar-2024 | 23:48 | x64      |
| Recordsetdest.dll                                             | 2019.150.4365.2 | 174136    | 29-Mar-2024 | 23:48 | x86      |
| Recordsetdest.dll                                             | 2019.150.4365.2 | 202688    | 29-Mar-2024 | 23:48 | x64      |
| Sqlceip.exe                                                   | 15.0.4365.2     | 296896    | 29-Mar-2024 | 23:48 | x86      |
| Sqldest.dll                                                   | 2019.150.4365.2 | 276416    | 29-Mar-2024 | 23:48 | x64      |
| Sqldest.dll                                                   | 2019.150.4365.2 | 239656    | 29-Mar-2024 | 23:48 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4365.2 | 202792    | 29-Mar-2024 | 23:48 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4365.2 | 170040    | 29-Mar-2024 | 23:48 | x86      |
| Txagg.dll                                                     | 2019.150.4365.2 | 329784    | 29-Mar-2024 | 23:48 | x86      |
| Txagg.dll                                                     | 2019.150.4365.2 | 391104    | 29-Mar-2024 | 23:48 | x64      |
| Txbdd.dll                                                     | 2019.150.4365.2 | 157752    | 29-Mar-2024 | 23:48 | x86      |
| Txbdd.dll                                                     | 2019.150.4365.2 | 194616    | 29-Mar-2024 | 23:48 | x64      |
| Txbestmatch.dll                                               | 2019.150.4365.2 | 546856    | 29-Mar-2024 | 23:48 | x86      |
| Txbestmatch.dll                                               | 2019.150.4365.2 | 653352    | 29-Mar-2024 | 23:48 | x64      |
| Txcache.dll                                                   | 2019.150.4365.2 | 174136    | 29-Mar-2024 | 23:48 | x86      |
| Txcache.dll                                                   | 2019.150.4365.2 | 198696    | 29-Mar-2024 | 23:48 | x64      |
| Txcharmap.dll                                                 | 2019.150.4365.2 | 272424    | 29-Mar-2024 | 23:48 | x86      |
| Txcharmap.dll                                                 | 2019.150.4365.2 | 313384    | 29-Mar-2024 | 23:48 | x64      |
| Txcopymap.dll                                                 | 2019.150.4365.2 | 174136    | 29-Mar-2024 | 23:48 | x86      |
| Txcopymap.dll                                                 | 2019.150.4365.2 | 202792    | 29-Mar-2024 | 23:48 | x64      |
| Txdataconvert.dll                                             | 2019.150.4365.2 | 276520    | 29-Mar-2024 | 23:48 | x86      |
| Txdataconvert.dll                                             | 2019.150.4365.2 | 317376    | 29-Mar-2024 | 23:48 | x64      |
| Txderived.dll                                                 | 2019.150.4365.2 | 559040    | 29-Mar-2024 | 23:48 | x86      |
| Txderived.dll                                                 | 2019.150.4365.2 | 640960    | 29-Mar-2024 | 23:48 | x64      |
| Txfileextractor.dll                                           | 2019.150.4365.2 | 182328    | 29-Mar-2024 | 23:48 | x86      |
| Txfileextractor.dll                                           | 2019.150.4365.2 | 219072    | 29-Mar-2024 | 23:48 | x64      |
| Txfileinserter.dll                                            | 2019.150.4365.2 | 182328    | 29-Mar-2024 | 23:48 | x86      |
| Txfileinserter.dll                                            | 2019.150.4365.2 | 214976    | 29-Mar-2024 | 23:48 | x64      |
| Txgroupdups.dll                                               | 2019.150.4365.2 | 255936    | 29-Mar-2024 | 23:48 | x86      |
| Txgroupdups.dll                                               | 2019.150.4365.2 | 313280    | 29-Mar-2024 | 23:48 | x64      |
| Txlineage.dll                                                 | 2019.150.4365.2 | 129080    | 29-Mar-2024 | 23:48 | x86      |
| Txlineage.dll                                                 | 2019.150.4365.2 | 153640    | 29-Mar-2024 | 23:48 | x64      |
| Txlookup.dll                                                  | 2019.150.4365.2 | 469048    | 29-Mar-2024 | 23:48 | x86      |
| Txlookup.dll                                                  | 2019.150.4365.2 | 542672    | 29-Mar-2024 | 23:48 | x64      |
| Txmerge.dll                                                   | 2019.150.4365.2 | 206904    | 29-Mar-2024 | 23:48 | x86      |
| Txmerge.dll                                                   | 2019.150.4365.2 | 247760    | 29-Mar-2024 | 23:48 | x64      |
| Txmergejoin.dll                                               | 2019.150.4365.2 | 247744    | 29-Mar-2024 | 23:48 | x86      |
| Txmergejoin.dll                                               | 2019.150.4365.2 | 309184    | 29-Mar-2024 | 23:48 | x64      |
| Txmulticast.dll                                               | 2019.150.4365.2 | 120872    | 29-Mar-2024 | 23:48 | x86      |
| Txmulticast.dll                                               | 2019.150.4365.2 | 145344    | 29-Mar-2024 | 23:48 | x64      |
| Txpivot.dll                                                   | 2019.150.4365.2 | 206888    | 29-Mar-2024 | 23:48 | x86      |
| Txpivot.dll                                                   | 2019.150.4365.2 | 239656    | 29-Mar-2024 | 23:48 | x64      |
| Txrowcount.dll                                                | 2019.150.4365.2 | 112696    | 29-Mar-2024 | 23:48 | x86      |
| Txrowcount.dll                                                | 2019.150.4365.2 | 141352    | 29-Mar-2024 | 23:48 | x64      |
| Txsampling.dll                                                | 2019.150.4365.2 | 161832    | 29-Mar-2024 | 23:48 | x86      |
| Txsampling.dll                                                | 2019.150.4365.2 | 194600    | 29-Mar-2024 | 23:48 | x64      |
| Txscd.dll                                                     | 2019.150.4365.2 | 198592    | 29-Mar-2024 | 23:48 | x86      |
| Txscd.dll                                                     | 2019.150.4365.2 | 235560    | 29-Mar-2024 | 23:48 | x64      |
| Txsort.dll                                                    | 2019.150.4365.2 | 231464    | 29-Mar-2024 | 23:48 | x86      |
| Txsort.dll                                                    | 2019.150.4365.2 | 288824    | 29-Mar-2024 | 23:48 | x64      |
| Txsplit.dll                                                   | 2019.150.4365.2 | 550952    | 29-Mar-2024 | 23:48 | x86      |
| Txsplit.dll                                                   | 2019.150.4365.2 | 624680    | 29-Mar-2024 | 23:48 | x64      |
| Txtermextraction.dll                                          | 2019.150.4365.2 | 8644544   | 29-Mar-2024 | 23:48 | x86      |
| Txtermextraction.dll                                          | 2019.150.4365.2 | 8701992   | 29-Mar-2024 | 23:48 | x64      |
| Txtermlookup.dll                                              | 2019.150.4365.2 | 4138960   | 29-Mar-2024 | 23:48 | x86      |
| Txtermlookup.dll                                              | 2019.150.4365.2 | 4184104   | 29-Mar-2024 | 23:48 | x64      |
| Txunionall.dll                                                | 2019.150.4365.2 | 161848    | 29-Mar-2024 | 23:48 | x86      |
| Txunionall.dll                                                | 2019.150.4365.2 | 198696    | 29-Mar-2024 | 23:48 | x64      |
| Txunpivot.dll                                                 | 2019.150.4365.2 | 182312    | 29-Mar-2024 | 23:48 | x86      |
| Txunpivot.dll                                                 | 2019.150.4365.2 | 215080    | 29-Mar-2024 | 23:48 | x64      |
| Xe.dll                                                        | 2019.150.4365.2 | 632872    | 29-Mar-2024 | 23:48 | x86      |
| Xe.dll                                                        | 2019.150.4365.2 | 722896    | 29-Mar-2024 | 23:48 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1968.0     | 559576    | 30-Mar-2024 | 00:12 | x86      |
| Dmsnative.dll                                                        | 2018.150.1968.0 | 152520    | 30-Mar-2024 | 00:12 | x64      |
| Dwengineservice.dll                                                  | 15.0.1968.0     | 45112     | 30-Mar-2024 | 00:12 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 30-Mar-2024 | 00:12 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 30-Mar-2024 | 00:12 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 30-Mar-2024 | 00:12 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 30-Mar-2024 | 00:12 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 30-Mar-2024 | 00:12 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 30-Mar-2024 | 00:12 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 30-Mar-2024 | 00:12 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 30-Mar-2024 | 00:12 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 30-Mar-2024 | 00:12 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 30-Mar-2024 | 00:12 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 30-Mar-2024 | 00:12 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 30-Mar-2024 | 00:12 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 30-Mar-2024 | 00:12 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 30-Mar-2024 | 00:12 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 30-Mar-2024 | 00:12 | x64      |
| Instapi150.dll                                                       | 2019.150.4365.2 | 88104     | 30-Mar-2024 | 00:12 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 30-Mar-2024 | 00:12 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 30-Mar-2024 | 00:12 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 30-Mar-2024 | 00:12 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 30-Mar-2024 | 00:12 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 30-Mar-2024 | 00:12 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 30-Mar-2024 | 00:12 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 30-Mar-2024 | 00:12 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 30-Mar-2024 | 00:12 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 30-Mar-2024 | 00:12 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 30-Mar-2024 | 00:12 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1968.0     | 67656     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1968.0     | 293432    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1968.0     | 1957960   | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1968.0     | 169544    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1968.0     | 649672    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1968.0     | 246344    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1968.0     | 139320    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1968.0     | 79816     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1968.0     | 51144     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1968.0     | 88632     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1968.0     | 1129416   | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1968.0     | 80952     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1968.0     | 70712     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1968.0     | 35384     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1968.0     | 31288     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1968.0     | 46536     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1968.0     | 21560     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1968.0     | 26696     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1968.0     | 131536    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1968.0     | 86584     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1968.0     | 100824    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1968.0     | 293336    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 120376    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 138296    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 141256    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 137688    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 150488    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 139832    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 134616    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 176600    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 117816    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 136664    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1968.0     | 72648     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1968.0     | 21960     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1968.0     | 37320     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1968.0     | 128976    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1968.0     | 3064888   | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1968.0     | 3955768   | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 118344    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 133176    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 137672    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 133688    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 148536    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 134192    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 130632    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 171064    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 115272    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 132168    | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1968.0     | 67544     | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1968.0     | 2682936   | 30-Mar-2024 | 00:12 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1968.0     | 2436552   | 30-Mar-2024 | 00:12 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4365.2 | 452648    | 30-Mar-2024 | 00:12 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4365.2 | 7407552   | 30-Mar-2024 | 00:12 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 30-Mar-2024 | 00:12 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 30-Mar-2024 | 00:12 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 30-Mar-2024 | 00:12 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 30-Mar-2024 | 00:12 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 30-Mar-2024 | 00:12 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 30-Mar-2024 | 00:12 | x64      |
| Secforwarder.dll                                                     | 2019.150.4365.2 | 79808     | 30-Mar-2024 | 00:12 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1968.0 | 61496     | 30-Mar-2024 | 00:12 | x64      |
| Sqldk.dll                                                            | 2019.150.4365.2 | 3180480   | 30-Mar-2024 | 00:12 | x64      |
| Sqldumper.exe                                                        | 2019.150.4365.2 | 378816    | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 1595344   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 4171816   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 3422248   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 4163520   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 4069416   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 2226128   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 2177080   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 3827648   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 3823552   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 1542184   | 30-Mar-2024 | 00:12 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4365.2 | 4036560   | 30-Mar-2024 | 00:12 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 30-Mar-2024 | 00:12 | x64      |
| Sqlos.dll                                                            | 2019.150.4365.2 | 42944     | 30-Mar-2024 | 00:12 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1968.0 | 4841416   | 30-Mar-2024 | 00:12 | x64      |
| Sqltses.dll                                                          | 2019.150.4365.2 | 9119680   | 30-Mar-2024 | 00:12 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 30-Mar-2024 | 00:12 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 30-Mar-2024 | 00:12 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 30-Mar-2024 | 00:12 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 30-Mar-2024 | 00:12 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 30-Mar-2024 | 00:12 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 30-Mar-2024 | 00:12 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4365.2  | 30760     | 29-Mar-2024 | 23:51 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4365.2 | 1632312   | 30-Mar-2024 | 00:04 | x86      |
| Dtaengine.exe                                                | 2019.150.4365.2 | 219072    | 30-Mar-2024 | 00:04 | x86      |
| Dteparse.dll                                                 | 2019.150.4365.2 | 112696    | 30-Mar-2024 | 00:04 | x86      |
| Dteparse.dll                                                 | 2019.150.4365.2 | 124968    | 30-Mar-2024 | 00:04 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4365.2 | 116792    | 30-Mar-2024 | 00:04 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4365.2 | 133176    | 30-Mar-2024 | 00:04 | x64      |
| Dtepkg.dll                                                   | 2019.150.4365.2 | 133072    | 30-Mar-2024 | 00:04 | x86      |
| Dtepkg.dll                                                   | 2019.150.4365.2 | 153640    | 30-Mar-2024 | 00:04 | x64      |
| Dtexec.exe                                                   | 2019.150.4365.2 | 64960     | 30-Mar-2024 | 00:04 | x86      |
| Dtexec.exe                                                   | 2019.150.4365.2 | 73664     | 30-Mar-2024 | 00:04 | x64      |
| Dts.dll                                                      | 2019.150.4365.2 | 2762792   | 30-Mar-2024 | 00:04 | x86      |
| Dts.dll                                                      | 2019.150.4365.2 | 3143616   | 30-Mar-2024 | 00:04 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4365.2 | 444472    | 30-Mar-2024 | 00:04 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4365.2 | 501800    | 30-Mar-2024 | 00:04 | x64      |
| Dtsconn.dll                                                  | 2019.150.4365.2 | 432184    | 30-Mar-2024 | 00:04 | x86      |
| Dtsconn.dll                                                  | 2019.150.4365.2 | 522280    | 30-Mar-2024 | 00:04 | x64      |
| Dtshost.exe                                                  | 2019.150.4365.2 | 89640     | 30-Mar-2024 | 00:04 | x86      |
| Dtshost.exe                                                  | 2019.150.4365.2 | 107576    | 30-Mar-2024 | 00:04 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4365.2 | 554960    | 30-Mar-2024 | 00:04 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4365.2 | 567336    | 30-Mar-2024 | 00:04 | x64      |
| Dtspipeline.dll                                              | 2019.150.4365.2 | 1120192   | 30-Mar-2024 | 00:04 | x86      |
| Dtspipeline.dll                                              | 2019.150.4365.2 | 1329192   | 30-Mar-2024 | 00:04 | x64      |
| Dtswizard.exe                                                | 15.0.4365.2     | 890816    | 30-Mar-2024 | 00:04 | x86      |
| Dtswizard.exe                                                | 15.0.4365.2     | 886824    | 30-Mar-2024 | 00:04 | x64      |
| Dtuparse.dll                                                 | 2019.150.4365.2 | 88120     | 30-Mar-2024 | 00:04 | x86      |
| Dtuparse.dll                                                 | 2019.150.4365.2 | 100392    | 30-Mar-2024 | 00:04 | x64      |
| Dtutil.exe                                                   | 2019.150.4365.2 | 130496    | 30-Mar-2024 | 00:04 | x86      |
| Dtutil.exe                                                   | 2019.150.4365.2 | 151080    | 30-Mar-2024 | 00:04 | x64      |
| Exceldest.dll                                                | 2019.150.4365.2 | 235560    | 30-Mar-2024 | 00:04 | x86      |
| Exceldest.dll                                                | 2019.150.4365.2 | 280512    | 30-Mar-2024 | 00:04 | x64      |
| Excelsrc.dll                                                 | 2019.150.4365.2 | 260136    | 30-Mar-2024 | 00:04 | x86      |
| Excelsrc.dll                                                 | 2019.150.4365.2 | 309184    | 30-Mar-2024 | 00:04 | x64      |
| Flatfiledest.dll                                             | 2019.150.4365.2 | 358456    | 30-Mar-2024 | 00:04 | x86      |
| Flatfiledest.dll                                             | 2019.150.4365.2 | 411584    | 30-Mar-2024 | 00:04 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4365.2 | 370728    | 30-Mar-2024 | 00:04 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4365.2 | 428072    | 30-Mar-2024 | 00:04 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4365.2     | 116688    | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4365.2     | 403392    | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4365.2     | 403408    | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4365.2     | 3004368   | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4365.2     | 3004456   | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4365.2     | 43048     | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4365.2     | 43048     | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4365.2     | 59432     | 30-Mar-2024 | 00:04 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 30-Mar-2024 | 00:04 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4365.2 | 100408    | 30-Mar-2024 | 00:04 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4365.2 | 112680    | 30-Mar-2024 | 00:04 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.45  | 8280120   | 29-Mar-2024 | 23:53 | x86      |
| Oledbdest.dll                                                | 2019.150.4365.2 | 239656    | 30-Mar-2024 | 00:04 | x86      |
| Oledbdest.dll                                                | 2019.150.4365.2 | 280632    | 30-Mar-2024 | 00:04 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4365.2 | 264232    | 30-Mar-2024 | 00:04 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4365.2 | 313296    | 30-Mar-2024 | 00:04 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4365.2 | 38952     | 30-Mar-2024 | 00:04 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4365.2 | 51136     | 30-Mar-2024 | 00:04 | x64      |
| Sqlscm.dll                                                   | 2019.150.4365.2 | 79800     | 30-Mar-2024 | 00:04 | x86      |
| Sqlscm.dll                                                   | 2019.150.4365.2 | 88016     | 30-Mar-2024 | 00:04 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4365.2 | 149544    | 30-Mar-2024 | 00:04 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4365.2 | 182312    | 30-Mar-2024 | 00:04 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4365.2 | 170040    | 30-Mar-2024 | 00:04 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4365.2 | 202792    | 30-Mar-2024 | 00:04 | x64      |
| Txdataconvert.dll                                            | 2019.150.4365.2 | 276520    | 30-Mar-2024 | 00:04 | x86      |
| Txdataconvert.dll                                            | 2019.150.4365.2 | 317376    | 30-Mar-2024 | 00:04 | x64      |
| Xe.dll                                                       | 2019.150.4365.2 | 632872    | 30-Mar-2024 | 00:04 | x86      |
| Xe.dll                                                       | 2019.150.4365.2 | 722896    | 30-Mar-2024 | 00:04 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2019.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Hybrid environment deployment</b></summary>

When you deploy an update to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the update:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply an update:
    >
    > - Install the update on the passive node.
    > - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2019**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
