---
title: Cumulative update 27 for SQL Server 2019 (KB5037331)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 27 (KB5037331).
ms.date: 04/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5037331
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5037331 - Cumulative Update 27 for SQL Server 2019

_Release Date:_ &nbsp; June 13, 2024  
_Version:_ &nbsp; 15.0.4375.4

## Summary

This article describes Cumulative Update package 27 (CU27) for Microsoft SQL Server 2019. This update contains 13 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 26, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4375.4**, file version: **2019.150.4375.4**
- Analysis Services - Product version: **15.0.35.45**, file version: **2018.150.35.45**

## Known issues in this update

### Issue one: Excessive logging of asynchronous API call warning in the error log

The newly-created warning message in issue [2901635](#2901635) might fill up the SQL Server error log with thousands of occurrences. The message is "WARNING Long asynchronous API Call: The scheduling fairness of scheduler can be impacted by an asynchronous API invocation unexpectedly exceeding xxx ms." This is due to an incorrect code change during the build process. If you experience this issue and prefer not to uninstall the CU as a solution, contact [Microsoft Support](https://support.microsoft.com/contactus/?ws=support).

This issue is fixed in [SQL Server 2019 CU28](cumulativeupdate28.md#3312461).

### Issue two: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

### Issue three: Patching error for secondary replicas in an availability group with databases enabled replication or CDC

[!INCLUDE [patching-error-2019](../includes/patching-error-2019.md)]

### Issue four: Possibility of error 1204 due to disabled lock escalation

SQL Server 2019 CU26 introduced a regression that can disable lock escalation, which causes error 1204 "The instance of the SQL Server Database Engine cannot obtain a LOCK resource at this time."

To work around this issue, you can uninstall the CU26.

This issue is fixed in [SQL Server 2019 CU28](cumulativeupdate28.md#3282395).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component | Platform |
|------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|-------------------------------------------|----------|
| <a id=3099327>[3099327](#3099327) </a> | Fixes an issue that can cause the "Network path not found" error when you use a domain account on a non-domain controller machine. | Master Data Services| Master Data Services| Windows|
| <a id=3110965>[3110965](#3110965) </a> | Fixes an issue in which maintenance plan logs might report garbled characters when the message reported involves non-ASCII characters. | SQL Server Client Tools | Management Services | Windows|
| <a id=2897797>[2897797](#2897797) </a> | Fixes an issue in which the remote secondary replica shows **Not Synchronizing** for several minutes after successive failovers between local replicas. It occurs when configured in multi-subnet, multi-region configurations in the cloud with two or more local replicas and one or more remote replicas. | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=2994446>[2994446](#2994446) </a> | Fixes an issue in which the secondary databases of an availability group might fail to be online intermittently. Additionally, you see the following error message: </br></br>Database 'DatabaseName' (database ID \<IDNumber>) startup failed with error 3602, severity 25, state 145.| SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3018480>[3018480](#3018480) </a> | Fixes an assertion failure (Location: HadrArProxy.cpp:4314; Expression: !CFeatureSwitchesMin::GetCurrentInstance()->FHadrCheckXClusterAgUcsSizeEnabled() \|\| cbBlob < x_cbMsgBodyMax) that you might encounter when you use read-scale availability groups without a cluster configuration. | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3088136>[3088136](#3088136) </a> | Fixes an assertion dump issue (Location: hadrlogcapture.cpp:\<LineNumber>; Expression: m_pFsManager->GetEnqueuedBlockId () < capturedLogBlockId \|\| capturedLogBlockId == m_pDbPartner->GetFirstLogBlockIdToCapture ()) that you encounter when there are FILESTREAM transactions in an Always On availability group (AG). | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3157054>[3157054](#3157054) </a> | Adds performance monitor counters to the cluster log report when the health check timeout is reported. | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=3207518>[3207518](#3207518) </a> | [FIX: Memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server (KB5042369)](../sqlserver-2022/memory-exceed-configured-limits-memory-memorylimitmb.md) | SQL Server Engine | Linux | Linux|
| <a id=2955030>[2955030](#2955030) </a> | Fixes an assertion failure (Location: sosmemobj.cpp:2744; Expression: pvb->FInUse()) in `CVariableInfo::PviRelease` that you encounter when you use UTF-8 collations and the `WITH RESULT SETS` clause. | SQL Server Engine | Programmability | All|
| <a id=2962248>[2962248](#2962248) </a> | Fixes an issue in which change tracking auto cleanup consumes CPU in cycles every 30 minutes even if change tracking isn't enabled on any databases. </br></br>**Note**: After applying the fix, if you see some rows in `sys.syscommittab` or `dbo.MSchange_tracking_history` tables in databases where change tracking is disabled, you need to re-enable and then disable change tracking on these databases. This will clean all tracking data. For more information, see [Enable and Disable Change Tracking](/sql/relational-databases/track-changes/enable-and-disable-change-tracking-sql-server).| SQL Server Engine | Replication | All|
| <a id=3015695>[3015695](#3015695) </a> | Fixes the following error that you encounter when running `sys.sp_flush_CT_internal_table_on_demand` in a SQL Server instance that has the Case-sensitive (_CS) collation option: </br></br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Total rows deleted: (null). </br>Total rows deleted: (null). | SQL Server Engine | Replication | All|
| <a id=2901635>[2901635](#2901635) </a> | Adds the following log message when high I/O latencies are detected in Bufferpool Lazy Writer (`ntdll!ZwWriteFile` system call) due to a performance issue in the underlying storage: </br></br>WARNING Long asynchronous API Call: The scheduling fairness of scheduler can be impacted by an asynchronous API invocation unexpectedly exceeding xxx ms.| SQL Server Engine | SQL OS| All|
| <a id=3065392>[3065392](#3065392) </a> | Fixes a dump issue that you might encounter in `sqlmin.dll!ParallelRedoManager::ReleaseDelayedTran`. | SQL Server Engine | Transaction Services| All|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU27 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5037331)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5037331-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5037331-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5037331-x64.exe| 196DDC07628722ED996A801410E1019D109A6C8C7CE8ED5BC6736D897411F1AE |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| asplatformhost.dll                                        | 2018.150.35.45  | 292928    | 10-Jun-2024 | 18:29 | x64      |
| mashupcompression.dll                                     | 2.87.142.0      | 140672    | 10-Jun-2024 | 18:29 | x64      |
| microsoft.analysisservices.minterop.dll                   | 15.0.35.45      | 758328    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 175552    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 199616    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 202176    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 198608    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 214976    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197568    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 193472    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 252464    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 174016    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197072    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.dll             | 15.0.35.45      | 1098688   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.45      | 567344    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 54736     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59328     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59840     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58816     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 61888     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58320     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 67632     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 53696     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 18992     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 10-Jun-2024 | 18:29 | x64      |
| microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 10-Jun-2024 | 18:29 | x64      |
| microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 10-Jun-2024 | 18:29 | x64      |
| microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 10-Jun-2024 | 18:29 | x64      |
| microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 10-Jun-2024 | 18:29 | x86      |
| msmdctr.dll                                               | 2018.150.35.45  | 38448     | 10-Jun-2024 | 18:29 | x64      |
| msmdlocal.dll                                             | 2018.150.35.45  | 47785008  | 10-Jun-2024 | 18:29 | x86      |
| msmdlocal.dll                                             | 2018.150.35.45  | 66260928  | 10-Jun-2024 | 18:29 | x64      |
| msmdpump.dll                                              | 2018.150.35.45  | 10187200  | 10-Jun-2024 | 18:29 | x64      |
| msmdredir.dll                                             | 2018.150.35.45  | 7957440   | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 16848     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 17456     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 18480     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 16832     | 10-Jun-2024 | 18:29 | x86      |
| msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 10-Jun-2024 | 18:29 | x86      |
| msmdsrv.errorcategories.xml                               | n/a             | 4882      | 10-Jun-2024 | 18:29 | n/a      |
| msmdsrv.exe                                               | 2018.150.35.45  | 65798080  | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 833600    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1628224   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1454128   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1643064   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1608768   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1001536   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 992816    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1537080   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1521728   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 811056    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrv.rll                                               | 2018.150.35.45  | 1596480   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 832560    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1624640   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1451064   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1637944   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1604672   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 998960    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 991280    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1532992   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1518144   | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 810032    | 10-Jun-2024 | 18:29 | x64      |
| msmdsrvi.rll                                              | 2018.150.35.45  | 1591856   | 10-Jun-2024 | 18:29 | x64      |
| msmgdsrv.dll                                              | 2018.150.35.45  | 8280120   | 10-Jun-2024 | 18:29 | x86      |
| msmgdsrv.dll                                              | 2018.150.35.45  | 10186176  | 10-Jun-2024 | 18:29 | x64      |
| msolap.dll                                                | 2018.150.35.45  | 8607168   | 10-Jun-2024 | 18:29 | x86      |
| msolap.dll                                                | 2018.150.35.45  | 11013072  | 10-Jun-2024 | 18:29 | x64      |
| msolui.dll                                                | 2018.150.35.45  | 286256    | 10-Jun-2024 | 18:29 | x86      |
| msolui.dll                                                | 2018.150.35.45  | 306752    | 10-Jun-2024 | 18:29 | x64      |
| powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 10-Jun-2024 | 18:29 | x86      |
| private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 10-Jun-2024 | 18:29 | x64      |
| sqlboot.dll                                               | 2019.150.4375.4 | 215096    | 10-Jun-2024 | 18:29 | x64      |
| sqlceip.exe                                               | 15.0.4375.4     | 296896    | 10-Jun-2024 | 18:29 | x86      |
| sqldumper.exe                                             | 2019.150.4375.4 | 321592    | 10-Jun-2024 | 18:29 | x86      |
| sqldumper.exe                                             | 2019.150.4375.4 | 378832    | 10-Jun-2024 | 18:29 | x64      |
| system.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 10-Jun-2024 | 18:29 | x86      |
| tmapi.dll                                                 | 2018.150.35.45  | 6178352   | 10-Jun-2024 | 18:29 | x64      |
| tmcachemgr.dll                                            | 2018.150.35.45  | 4917712   | 10-Jun-2024 | 18:29 | x64      |
| tmpersistence.dll                                         | 2018.150.35.45  | 1184816   | 10-Jun-2024 | 18:29 | x64      |
| tmtransactions.dll                                        | 2018.150.35.45  | 6807104   | 10-Jun-2024 | 18:29 | x64      |
| xmsrv.dll                                                 | 2018.150.35.45  | 35460032  | 10-Jun-2024 | 18:29 | x86      |
| xmsrv.dll                                                 | 2018.150.35.45  | 26025520  | 10-Jun-2024 | 18:29 | x64      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| batchparser.dll                      | 2019.150.4375.4 | 165928    | 10-Jun-2024 | 18:29 | x86      |
| batchparser.dll                      | 2019.150.4375.4 | 182312    | 10-Jun-2024 | 18:29 | x64      |
| instapi150.dll                       | 2019.150.4375.4 | 75816     | 10-Jun-2024 | 18:29 | x86      |
| instapi150.dll                       | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 18:29 | x64      |
| microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4375.4 | 104488    | 10-Jun-2024 | 18:29 | x64      |
| microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.rmo.dll          | 15.0.4375.4     | 550848    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.rmo.dll          | 15.0.4375.4     | 550864    | 10-Jun-2024 | 18:29 | x86      |
| msasxpress.dll                       | 2018.150.35.45  | 27184     | 10-Jun-2024 | 18:29 | x86      |
| msasxpress.dll                       | 2018.150.35.45  | 32304     | 10-Jun-2024 | 18:29 | x64      |
| pbsvcacctsync.dll                    | 2019.150.4375.4 | 75832     | 10-Jun-2024 | 18:29 | x86      |
| pbsvcacctsync.dll                    | 2019.150.4375.4 | 92200     | 10-Jun-2024 | 18:29 | x64      |
| sqldumper.exe                        | 2019.150.4375.4 | 321592    | 10-Jun-2024 | 18:29 | x86      |
| sqldumper.exe                        | 2019.150.4375.4 | 378832    | 10-Jun-2024 | 18:29 | x64      |
| sqlftacct.dll                        | 2019.150.4375.4 | 59328     | 10-Jun-2024 | 18:29 | x86      |
| sqlftacct.dll                        | 2019.150.4375.4 | 79808     | 10-Jun-2024 | 18:29 | x64      |
| sqlmanager.dll                       | 2019.150.4375.4 | 743376    | 10-Jun-2024 | 18:29 | x86      |
| sqlmanager.dll                       | 2019.150.4375.4 | 878632    | 10-Jun-2024 | 18:29 | x64      |
| sqlmgmprovider.dll                   | 2019.150.4375.4 | 378936    | 10-Jun-2024 | 18:29 | x86      |
| sqlmgmprovider.dll                   | 2019.150.4375.4 | 432064    | 10-Jun-2024 | 18:29 | x64      |
| sqlsvcsync.dll                       | 2019.150.4375.4 | 276536    | 10-Jun-2024 | 18:29 | x86      |
| sqlsvcsync.dll                       | 2019.150.4375.4 | 358336    | 10-Jun-2024 | 18:29 | x64      |
| svrenumapi150.dll                    | 2019.150.4375.4 | 1161168   | 10-Jun-2024 | 18:29 | x64      |
| svrenumapi150.dll                    | 2019.150.4375.4 | 911296    | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| microsoft.ssdqs.core.dll  | 15.0.4375.4  | 600000    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.ssdqs.core.dll  | 15.0.4375.4  | 600104    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.ssdqs.infra.dll | 15.0.4375.4  | 1857472   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.ssdqs.infra.dll | 15.0.4375.4  | 1857472   | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| dreplayclient.exe     | 2019.150.4375.4 | 137168    | 10-Jun-2024 | 18:29 | x86      |
| dreplaycommon.dll     | 2019.150.4375.4 | 667688    | 10-Jun-2024 | 18:29 | x86      |
| dreplayutil.dll       | 2019.150.4375.4 | 305088    | 10-Jun-2024 | 18:29 | x86      |
| instapi150.dll        | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 18:29 | x64      |
| sqlresourceloader.dll | 2019.150.4375.4 | 38864     | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| dreplaycommon.dll     | 2019.150.4375.4 | 667688    | 10-Jun-2024 | 18:29 | x86      |
| dreplaycontroller.exe | 2019.150.4375.4 | 366632    | 10-Jun-2024 | 18:29 | x86      |
| instapi150.dll        | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 18:29 | x64      |
| sqlresourceloader.dll | 2019.150.4375.4 | 38864     | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| aetm-enclave-simulator.dll                 | 2019.150.4375.4 | 4658232   | 10-Jun-2024 | 19:07 | x64      |
| aetm-enclave.dll                           | 2019.150.4375.4 | 4612536   | 10-Jun-2024 | 19:07 | x64      |
| aetm-sgx-enclave-simulator.dll             | 2019.150.4375.4 | 4931904   | 10-Jun-2024 | 19:07 | x64      |
| aetm-sgx-enclave.dll                       | 2019.150.4375.4 | 4873648   | 10-Jun-2024 | 19:07 | x64      |
| azureattest.dll                            | 10.0.18965.1000 | 255056    | 10-Jun-2024 | 19:20 | x64      |
| azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 10-Jun-2024 | 19:20 | x64      |
| batchparser.dll                            | 2019.150.4375.4 | 182312    | 10-Jun-2024 | 19:07 | x64      |
| c1.dll                                     | 19.16.27034.0   | 2438520   | 10-Jun-2024 | 19:20 | x64      |
| c2.dll                                     | 19.16.27034.0   | 7239032   | 10-Jun-2024 | 19:20 | x64      |
| cl.exe                                     | 19.16.27034.0   | 424360    | 10-Jun-2024 | 19:20 | x64      |
| clui.dll                                   | 19.16.27034.0   | 541048    | 10-Jun-2024 | 19:20 | x64      |
| datacollectorcontroller.dll                | 2019.150.4375.4 | 280616    | 10-Jun-2024 | 19:20 | x64      |
| dcexec.exe                                 | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 19:20 | x64      |
| exacorepredict.dll                         | n/a             | 58408368  | 10-Jun-2024 | 19:07 | x64      |
| exacorepredictsql.dll                      | n/a             | 40344     | 10-Jun-2024 | 19:07 | x64      |
| fssres.dll                                 | 2019.150.4375.4 | 96296     | 10-Jun-2024 | 19:20 | x64      |
| hadrres.dll                                | 2019.150.4375.4 | 206888    | 10-Jun-2024 | 19:20 | x64      |
| hkcompile.dll                              | 2019.150.4375.4 | 1292344   | 10-Jun-2024 | 19:20 | x64      |
| hkengdef.h                                 | n/a             | 2804      | 10-Jun-2024 | 19:07 | n/a      |
| hkenggen.h                                 | n/a             | 16783     | 10-Jun-2024 | 19:07 | n/a      |
| hkengine.dll                               | 2019.150.4375.4 | 5793832   | 10-Jun-2024 | 19:07 | x64      |
| hkengine.lib                               | n/a             | 99126     | 10-Jun-2024 | 19:07 | n/a      |
| hkgenlib.h                                 | n/a             | 57242     | 10-Jun-2024 | 19:07 | n/a      |
| hkgenlib.lib                               | n/a             | 3004946   | 10-Jun-2024 | 19:07 | n/a      |
| hkrtdef.h                                  | n/a             | 9434      | 10-Jun-2024 | 19:07 | n/a      |
| hkrtgen.h                                  | n/a             | 29067     | 10-Jun-2024 | 19:07 | n/a      |
| hkruntime.dll                              | 2019.150.4375.4 | 182208    | 10-Jun-2024 | 19:07 | x64      |
| hkruntime.lib                              | n/a             | 37422     | 10-Jun-2024 | 19:07 | n/a      |
| hktempdb.dll                               | 2019.150.4375.4 | 63424     | 10-Jun-2024 | 19:07 | x64      |
| libcmt.amd64.pdb                           | n/a             | 323584    | 10-Jun-2024 | 19:20 | n/a      |
| libcmt.lib                                 | n/a             | 2036034   | 10-Jun-2024 | 19:20 | n/a      |
| libvcruntime.amd64.pdb                     | n/a             | 274432    | 10-Jun-2024 | 19:20 | n/a      |
| libvcruntime.lib                           | n/a             | 1082768   | 10-Jun-2024 | 19:20 | n/a      |
| link.exe                                   | 14.16.27034.0   | 1707936   | 10-Jun-2024 | 19:20 | x64      |
| microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4375.4     | 235560    | 10-Jun-2024 | 19:20 | x86      |
| microsoft.sqlserver.types.dll              | 2019.150.4375.4 | 391104    | 10-Jun-2024 | 19:20 | x86      |
| microsoft.sqlserver.xevent.linq.dll        | 2019.150.4375.4 | 325672    | 10-Jun-2024 | 19:20 | x64      |
| microsoft.sqlserver.xevent.targets.dll     | 2019.150.4375.4 | 92096     | 10-Jun-2024 | 19:20 | x64      |
| model_msdbdata.mdf                         | n/a             | 14090240  | 10-Jun-2024 | 19:20 | n/a      |
| model_msdblog.ldf                          | n/a             | 524288    | 10-Jun-2024 | 19:20 | n/a      |
| model_replicatedmaster.ldf                 | n/a             | 524288    | 10-Jun-2024 | 19:20 | n/a      |
| model_replicatedmaster.mdf                 | n/a             | 4718592   | 10-Jun-2024 | 19:20 | n/a      |
| msdb110_upgrade.sql                        | n/a             | 2564756   | 10-Jun-2024 | 19:20 | n/a      |
| msobj140.dll                               | 14.16.27034.0   | 134008    | 10-Jun-2024 | 19:20 | x64      |
| mspdb140.dll                               | 14.16.27034.0   | 632184    | 10-Jun-2024 | 19:20 | x64      |
| mspdbcore.dll                              | 14.16.27034.0   | 632184    | 10-Jun-2024 | 19:20 | x64      |
| mssqlsystemresource.ldf                    | n/a             | 1310720   | 10-Jun-2024 | 19:20 | n/a      |
| mssqlsystemresource.mdf                    | n/a             | 41943040  | 10-Jun-2024 | 19:20 | n/a      |
| msvcp140.dll                               | 14.16.27034.0   | 628200    | 10-Jun-2024 | 19:20 | x64      |
| qds.dll                                    | 2019.150.4375.4 | 1189928   | 10-Jun-2024 | 19:20 | x64      |
| rsfxft.dll                                 | 2019.150.4375.4 | 51256     | 10-Jun-2024 | 19:20 | x64      |
| secforwarder.dll                           | 2019.150.4375.4 | 79824     | 10-Jun-2024 | 19:07 | x64      |
| sqagtres.dll                               | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 19:20 | x64      |
| sqlaamss.dll                               | 2019.150.4375.4 | 108488    | 10-Jun-2024 | 19:20 | x64      |
| sqlaccess.dll                              | 2019.150.4375.4 | 493624    | 10-Jun-2024 | 19:20 | x64      |
| sqlagent.exe                               | 2019.150.4375.4 | 731192    | 10-Jun-2024 | 19:20 | x64      |
| sqlagentctr150.dll                         | 2019.150.4375.4 | 71720     | 10-Jun-2024 | 19:20 | x86      |
| sqlagentctr150.dll                         | 2019.150.4375.4 | 79808     | 10-Jun-2024 | 19:20 | x64      |
| sqlboot.dll                                | 2019.150.4375.4 | 215096    | 10-Jun-2024 | 19:20 | x64      |
| sqlceip.exe                                | 15.0.4375.4     | 296896    | 10-Jun-2024 | 19:20 | x86      |
| sqlcmdss.dll                               | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 19:20 | x64      |
| sqlctr150.dll                              | 2019.150.4375.4 | 116776    | 10-Jun-2024 | 19:20 | x86      |
| sqlctr150.dll                              | 2019.150.4375.4 | 145344    | 10-Jun-2024 | 19:20 | x64      |
| sqldk.dll                                  | 2019.150.4375.4 | 3180496   | 10-Jun-2024 | 19:20 | x64      |
| sqldtsss.dll                               | 2019.150.4375.4 | 108496    | 10-Jun-2024 | 19:20 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 1595328   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3508280   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3704888   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4171816   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4290616   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3422248   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3586088   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4163640   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4020264   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4069416   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 2226216   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 2176960   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3876904   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3553336   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4024360   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3827752   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3823552   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3618872   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3508264   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 1542184   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 3917760   | 10-Jun-2024 | 19:07 | x64      |
| sqlevn70.rll                               | 2019.150.4375.4 | 4036544   | 10-Jun-2024 | 19:07 | x64      |
| sqllang.dll                                | 2019.150.4375.4 | 40077368  | 10-Jun-2024 | 19:20 | x64      |
| sqlmin.dll                                 | 2019.150.4375.4 | 40640056  | 10-Jun-2024 | 19:20 | x64      |
| sqlolapss.dll                              | 2019.150.4375.4 | 108600    | 10-Jun-2024 | 19:20 | x64      |
| sqlos.dll                                  | 2019.150.4375.4 | 43064     | 10-Jun-2024 | 19:07 | x64      |
| sqlpowershellss.dll                        | 2019.150.4375.4 | 84008     | 10-Jun-2024 | 19:20 | x64      |
| sqlrepss.dll                               | 2019.150.4375.4 | 88016     | 10-Jun-2024 | 19:20 | x64      |
| sqlresourceloader.dll                      | 2019.150.4375.4 | 51152     | 10-Jun-2024 | 19:20 | x64      |
| sqlscm.dll                                 | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 19:20 | x64      |
| sqlscriptdowngrade.dll                     | 2019.150.4375.4 | 38848     | 10-Jun-2024 | 19:20 | x64      |
| sqlscriptupgrade.dll                       | 2019.150.4375.4 | 5806120   | 10-Jun-2024 | 19:20 | x64      |
| sqlserverspatial150.dll                    | 2019.150.4375.4 | 673848    | 10-Jun-2024 | 19:20 | x64      |
| sqlservr.exe                               | 2019.150.4375.4 | 628688    | 10-Jun-2024 | 19:20 | x64      |
| sqlsvc.dll                                 | 2019.150.4375.4 | 182328    | 10-Jun-2024 | 19:20 | x64      |
| sqltses.dll                                | 2019.150.4375.4 | 9119680   | 10-Jun-2024 | 19:20 | x64      |
| sqsrvres.dll                               | 2019.150.4375.4 | 280512    | 10-Jun-2024 | 19:20 | x64      |
| ssis_hotfix_install.sql                    | n/a             | 11872     | 10-Jun-2024 | 19:20 | n/a      |
| stretchcodegen.exe                         | 15.0.4375.4     | 59344     | 10-Jun-2024 | 19:07 | x86      |
| svl.dll                                    | 2019.150.4375.4 | 161832    | 10-Jun-2024 | 19:07 | x64      |
| u_tables.sql                               | n/a             | 20021     | 10-Jun-2024 | 19:20 | n/a      |
| vcruntime140.dll                           | 14.16.27034.0   | 85992     | 10-Jun-2024 | 19:20 | x64      |
| xe.dll                                     | 2019.150.4375.4 | 722896    | 10-Jun-2024 | 19:20 | x64      |
| xesospkg.mof                               | n/a             | 366466    | 10-Jun-2024 | 19:20 | n/a      |
| xesqlminpkg.mof                            | n/a             | 2025775   | 10-Jun-2024 | 19:07 | n/a      |
| xesqlpkg.mof                               | n/a             | 851691    | 10-Jun-2024 | 19:07 | n/a      |
| xpadsi.exe                                 | 2019.150.4375.4 | 116776    | 10-Jun-2024 | 19:20 | x64      |
| xplog70.dll                                | 2019.150.4375.4 | 92200     | 10-Jun-2024 | 19:20 | x64      |
| xpqueue.dll                                | 2019.150.4375.4 | 92216     | 10-Jun-2024 | 19:20 | x64      |
| xprepl.dll                                 | 2019.150.4375.4 | 120768    | 10-Jun-2024 | 19:20 | x64      |
| xpstar.dll                                 | 2019.150.4375.4 | 473024    | 10-Jun-2024 | 19:20 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| batchparser.dll                                              | 2019.150.4375.4 | 182312    | 10-Jun-2024 | 18:29 | x64      |
| batchparser.dll                                              | 2019.150.4375.4 | 165928    | 10-Jun-2024 | 18:29 | x86      |
| commanddest.dll                                              | 2019.150.4375.4 | 264144    | 10-Jun-2024 | 18:29 | x64      |
| commons-collections-3.2.1.jar                                | n/a             | 575389    | 10-Jun-2024 | 18:29 | n/a      |
| datacollectortasks.dll                                       | 2019.150.4375.4 | 227264    | 10-Jun-2024 | 18:29 | x64      |
| distrib.exe                                                  | 2019.150.4375.4 | 243752    | 10-Jun-2024 | 18:29 | x64      |
| dteparse.dll                                                 | 2019.150.4375.4 | 124864    | 10-Jun-2024 | 18:29 | x64      |
| dteparsemgd.dll                                              | 2019.150.4375.4 | 133056    | 10-Jun-2024 | 18:29 | x64      |
| dtepkg.dll                                                   | 2019.150.4375.4 | 149440    | 10-Jun-2024 | 18:29 | x64      |
| dtexec.exe                                                   | 2019.150.4375.4 | 73768     | 10-Jun-2024 | 18:29 | x64      |
| dts.dll                                                      | 2019.150.4375.4 | 3143736   | 10-Jun-2024 | 18:29 | x64      |
| dtscomexpreval.dll                                           | 2019.150.4375.4 | 501688    | 10-Jun-2024 | 18:29 | x64      |
| dtsconn.dll                                                  | 2019.150.4375.4 | 522280    | 10-Jun-2024 | 18:29 | x64      |
| dtshost.exe                                                  | 2019.150.4375.4 | 107456    | 10-Jun-2024 | 18:29 | x64      |
| dtsmsg150.dll                                                | 2019.150.4375.4 | 567232    | 10-Jun-2024 | 18:29 | x64      |
| dtspipeline.dll                                              | 2019.150.4375.4 | 1329192   | 10-Jun-2024 | 18:29 | x64      |
| dtswizard.exe                                                | 15.0.4375.4     | 886824    | 10-Jun-2024 | 18:29 | x64      |
| dtuparse.dll                                                 | 2019.150.4375.4 | 100408    | 10-Jun-2024 | 18:29 | x64      |
| dtutil.exe                                                   | 2019.150.4375.4 | 151080    | 10-Jun-2024 | 18:29 | x64      |
| exceldest.dll                                                | 2019.150.4375.4 | 280520    | 10-Jun-2024 | 18:29 | x64      |
| excelsrc.dll                                                 | 2019.150.4375.4 | 309184    | 10-Jun-2024 | 18:29 | x64      |
| execpackagetask.dll                                          | 2019.150.4375.4 | 186320    | 10-Jun-2024 | 18:29 | x64      |
| flatfiledest.dll                                             | 2019.150.4375.4 | 411584    | 10-Jun-2024 | 18:29 | x64      |
| flatfilesrc.dll                                              | 2019.150.4375.4 | 427968    | 10-Jun-2024 | 18:29 | x64      |
| log4j-1.2.17.jar                                             | n/a             | 489884    | 10-Jun-2024 | 18:29 | n/a      |
| logread.exe                                                  | 2019.150.4375.4 | 722880    | 10-Jun-2024 | 18:29 | x64      |
| mergetxt.dll                                                 | 2019.150.4375.4 | 75816     | 10-Jun-2024 | 18:29 | x64      |
| microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4375.4     | 59344     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4375.4     | 43064     | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4375.4     | 391224    | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.replication.dll                          | 2019.150.4375.4 | 1697728   | 10-Jun-2024 | 18:29 | x64      |
| microsoft.sqlserver.replication.dll                          | 2019.150.4375.4 | 1640384   | 10-Jun-2024 | 18:29 | x86      |
| microsoft.sqlserver.rmo.dll                                  | 15.0.4375.4     | 550864    | 10-Jun-2024 | 18:29 | x86      |
| msdtssrvrutil.dll                                            | 2019.150.4375.4 | 112576    | 10-Jun-2024 | 18:29 | x64      |
| msgprox.dll                                                  | 2019.150.4375.4 | 301096    | 10-Jun-2024 | 18:29 | x64      |
| msoledbsql.dll                                               | 2018.187.2.0    | 2754584   | 10-Jun-2024 | 18:30 | x64      |
| msoledbsql.dll                                               | 2018.187.2.0    | 153624    | 10-Jun-2024 | 18:29 | x64      |
| msxmlsql.dll                                                 | 2019.150.4375.4 | 1497144   | 10-Jun-2024 | 18:30 | x64      |
| oledbdest.dll                                                | 2019.150.4375.4 | 280512    | 10-Jun-2024 | 18:29 | x64      |
| oledbsrc.dll                                                 | 2019.150.4375.4 | 313280    | 10-Jun-2024 | 18:29 | x64      |
| osql.exe                                                     | 2019.150.4375.4 | 92200     | 10-Jun-2024 | 18:29 | x64      |
| qrdrsvc.exe                                                  | 2019.150.4375.4 | 501712    | 10-Jun-2024 | 18:29 | x64      |
| rawdest.dll                                                  | 2019.150.4375.4 | 227264    | 10-Jun-2024 | 18:29 | x64      |
| rawsource.dll                                                | 2019.150.4375.4 | 211000    | 10-Jun-2024 | 18:29 | x64      |
| rdistcom.dll                                                 | 2019.150.4375.4 | 915496    | 10-Jun-2024 | 18:29 | x64      |
| recordsetdest.dll                                            | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:29 | x64      |
| repldp.dll                                                   | 2019.150.4375.4 | 313384    | 10-Jun-2024 | 18:29 | x64      |
| replerrx.dll                                                 | 2019.150.4375.4 | 182208    | 10-Jun-2024 | 18:29 | x64      |
| replisapi.dll                                                | 2019.150.4375.4 | 395304    | 10-Jun-2024 | 18:29 | x64      |
| replmerg.exe                                                 | 2019.150.4375.4 | 563240    | 10-Jun-2024 | 18:29 | x64      |
| replprov.dll                                                 | 2019.150.4375.4 | 862264    | 10-Jun-2024 | 18:29 | x64      |
| replrec.dll                                                  | 2019.150.4375.4 | 1034280   | 10-Jun-2024 | 18:29 | x64      |
| replsub.dll                                                  | 2019.150.4375.4 | 473128    | 10-Jun-2024 | 18:29 | x64      |
| replsync.dll                                                 | 2019.150.4375.4 | 165928    | 10-Jun-2024 | 18:29 | x64      |
| slf4j-log4j12-1.7.5.jar                                      | n/a             | 8869      | 10-Jun-2024 | 18:29 | n/a      |
| spresolv.dll                                                 | 2019.150.4375.4 | 276536    | 10-Jun-2024 | 18:29 | x64      |
| sqlcmd.exe                                                   | 2019.150.4375.4 | 264232    | 10-Jun-2024 | 18:29 | x64      |
| sqldiag.exe                                                  | 2019.150.4375.4 | 1140776   | 10-Jun-2024 | 18:29 | x64      |
| sqldistx.dll                                                 | 2019.150.4375.4 | 251944    | 10-Jun-2024 | 18:29 | x64      |
| sqllogship.exe                                               | 15.0.4375.4     | 104384    | 10-Jun-2024 | 18:29 | x64      |
| sqlmergx.dll                                                 | 2019.150.4375.4 | 399400    | 10-Jun-2024 | 18:29 | x64      |
| sqlprovider.types.ps1xml                                     | n/a             | 17234     | 10-Jun-2024 | 18:29 | n/a      |
| sqlresourceloader.dll                                        | 2019.150.4375.4 | 51152     | 10-Jun-2024 | 18:29 | x64      |
| sqlresourceloader.dll                                        | 2019.150.4375.4 | 38864     | 10-Jun-2024 | 18:30 | x86      |
| sqlscm.dll                                                   | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 18:29 | x64      |
| sqlscm.dll                                                   | 2019.150.4375.4 | 79912     | 10-Jun-2024 | 18:30 | x86      |
| sqlsvc.dll                                                   | 2019.150.4375.4 | 182328    | 10-Jun-2024 | 18:29 | x64      |
| sqlsvc.dll                                                   | 2019.150.4375.4 | 149456    | 10-Jun-2024 | 18:30 | x86      |
| sqltaskconnections.dll                                       | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:29 | x64      |
| ssis_commons_collections_3_2_2_jar_sql.64                    | n/a             | 588337    | 10-Jun-2024 | 18:29 | n/a      |
| ssradd.dll                                                   | 2019.150.4375.4 | 84008     | 10-Jun-2024 | 18:29 | x64      |
| ssravg.dll                                                   | 2019.150.4375.4 | 83920     | 10-Jun-2024 | 18:29 | x64      |
| ssrdown.dll                                                  | 2019.150.4375.4 | 75728     | 10-Jun-2024 | 18:29 | x64      |
| ssrmax.dll                                                   | 2019.150.4375.4 | 84008     | 10-Jun-2024 | 18:29 | x64      |
| ssrmin.dll                                                   | 2019.150.4375.4 | 83920     | 10-Jun-2024 | 18:29 | x64      |
| ssrpub.dll                                                   | 2019.150.4375.4 | 79824     | 10-Jun-2024 | 18:29 | x64      |
| ssrup.dll                                                    | 2019.150.4375.4 | 75712     | 10-Jun-2024 | 18:29 | x64      |
| txagg.dll                                                    | 2019.150.4375.4 | 391224    | 10-Jun-2024 | 18:29 | x64      |
| txbdd.dll                                                    | 2019.150.4375.4 | 190400    | 10-Jun-2024 | 18:29 | x64      |
| txdatacollector.dll                                          | 2019.150.4375.4 | 473128    | 10-Jun-2024 | 18:29 | x64      |
| txdataconvert.dll                                            | 2019.150.4375.4 | 317376    | 10-Jun-2024 | 18:29 | x64      |
| txderived.dll                                                | 2019.150.4375.4 | 640976    | 10-Jun-2024 | 18:29 | x64      |
| txlookup.dll                                                 | 2019.150.4375.4 | 542760    | 10-Jun-2024 | 18:29 | x64      |
| txmerge.dll                                                  | 2019.150.4375.4 | 247744    | 10-Jun-2024 | 18:29 | x64      |
| txmergejoin.dll                                              | 2019.150.4375.4 | 309184    | 10-Jun-2024 | 18:29 | x64      |
| txmulticast.dll                                              | 2019.150.4375.4 | 145344    | 10-Jun-2024 | 18:29 | x64      |
| txrowcount.dll                                               | 2019.150.4375.4 | 141248    | 10-Jun-2024 | 18:29 | x64      |
| txsort.dll                                                   | 2019.150.4375.4 | 288704    | 10-Jun-2024 | 18:29 | x64      |
| txsplit.dll                                                  | 2019.150.4375.4 | 624576    | 10-Jun-2024 | 18:29 | x64      |
| txunionall.dll                                               | 2019.150.4375.4 | 198592    | 10-Jun-2024 | 18:29 | x64      |
| xe.dll                                                       | 2019.150.4375.4 | 722896    | 10-Jun-2024 | 18:29 | x64      |
| xmlsub.dll                                                   | 2019.150.4375.4 | 297000    | 10-Jun-2024 | 18:29 | x64      |

SQL Server 2019 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| commonlauncher.dll            | 2019.150.4375.4 | 96192     | 10-Jun-2024 | 18:29 | x64      |
| exthost.exe                   | 2019.150.4375.4 | 239656    | 10-Jun-2024 | 18:29 | x64      |
| java-lang-extension.zip       | n/a             | 362852    | 10-Jun-2024 | 18:29 | n/a      |
| launchpad.exe                 | 2019.150.4375.4 | 1230888   | 10-Jun-2024 | 18:29 | x64      |
| mssql-java-lang-extension.jar | n/a             | 12630     | 10-Jun-2024 | 18:29 | n/a      |
| sqlsatellite.dll              | 2019.150.4375.4 | 1026000   | 10-Jun-2024 | 18:29 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |     Date    |  Time | Platform |
|:--------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| fd.dll         | 2019.150.4375.4 | 686016    | 10-Jun-2024 | 18:29 | x64      |
| fdhost.exe     | 2019.150.4375.4 | 128976    | 10-Jun-2024 | 18:29 | x64      |
| fdlauncher.exe | 2019.150.4375.4 | 79808     | 10-Jun-2024 | 18:29 | x64      |
| sqlft150ph.dll | 2019.150.4375.4 | 92216     | 10-Jun-2024 | 18:29 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| imrdll.dll | 15.0.4375.4  | 30656     | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| commanddest.dll                                               | 2019.150.4375.4 | 227368    | 10-Jun-2024 | 18:30 | x86      |
| commanddest.dll                                               | 2019.150.4375.4 | 264144    | 10-Jun-2024 | 18:30 | x64      |
| commons-collections-3.2.1.jar                                 | n/a             | 575389    | 10-Jun-2024 | 18:30 | n/a      |
| commons-collections-3.2.1.jar                                 | n/a             | 575389    | 10-Jun-2024 | 18:30 | n/a      |
| dteparse.dll                                                  | 2019.150.4375.4 | 112576    | 10-Jun-2024 | 18:30 | x86      |
| dteparse.dll                                                  | 2019.150.4375.4 | 124864    | 10-Jun-2024 | 18:30 | x64      |
| dteparsemgd.dll                                               | 2019.150.4375.4 | 116792    | 10-Jun-2024 | 18:30 | x86      |
| dteparsemgd.dll                                               | 2019.150.4375.4 | 133056    | 10-Jun-2024 | 18:30 | x64      |
| dtepkg.dll                                                    | 2019.150.4375.4 | 133160    | 10-Jun-2024 | 18:30 | x86      |
| dtepkg.dll                                                    | 2019.150.4375.4 | 149440    | 10-Jun-2024 | 18:30 | x64      |
| dtexec.exe                                                    | 2019.150.4375.4 | 64976     | 10-Jun-2024 | 18:30 | x86      |
| dtexec.exe                                                    | 2019.150.4375.4 | 73768     | 10-Jun-2024 | 18:30 | x64      |
| dts.dll                                                       | 2019.150.4375.4 | 2762792   | 10-Jun-2024 | 18:30 | x86      |
| dts.dll                                                       | 2019.150.4375.4 | 3143736   | 10-Jun-2024 | 18:30 | x64      |
| dtscomexpreval.dll                                            | 2019.150.4375.4 | 444352    | 10-Jun-2024 | 18:30 | x86      |
| dtscomexpreval.dll                                            | 2019.150.4375.4 | 501688    | 10-Jun-2024 | 18:30 | x64      |
| dtsconn.dll                                                   | 2019.150.4375.4 | 432064    | 10-Jun-2024 | 18:30 | x86      |
| dtsconn.dll                                                   | 2019.150.4375.4 | 522280    | 10-Jun-2024 | 18:30 | x64      |
| dtsdebughost.exe                                              | 2019.150.4375.4 | 113192    | 10-Jun-2024 | 18:30 | x64      |
| dtsdebughost.exe                                              | 2019.150.4375.4 | 94760     | 10-Jun-2024 | 18:30 | x86      |
| dtshost.exe                                                   | 2019.150.4375.4 | 107456    | 10-Jun-2024 | 18:30 | x64      |
| dtshost.exe                                                   | 2019.150.4375.4 | 89552     | 10-Jun-2024 | 18:30 | x86      |
| dtsmsg150.dll                                                 | 2019.150.4375.4 | 555048    | 10-Jun-2024 | 18:30 | x86      |
| dtsmsg150.dll                                                 | 2019.150.4375.4 | 567232    | 10-Jun-2024 | 18:30 | x64      |
| dtspipeline.dll                                               | 2019.150.4375.4 | 1120208   | 10-Jun-2024 | 18:30 | x86      |
| dtspipeline.dll                                               | 2019.150.4375.4 | 1329192   | 10-Jun-2024 | 18:30 | x64      |
| dtswizard.exe                                                 | 15.0.4375.4     | 886824    | 10-Jun-2024 | 18:30 | x64      |
| dtswizard.exe                                                 | 15.0.4375.4     | 890832    | 10-Jun-2024 | 18:30 | x86      |
| dtuparse.dll                                                  | 2019.150.4375.4 | 100408    | 10-Jun-2024 | 18:30 | x64      |
| dtuparse.dll                                                  | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 18:30 | x86      |
| dtutil.exe                                                    | 2019.150.4375.4 | 130616    | 10-Jun-2024 | 18:30 | x86      |
| dtutil.exe                                                    | 2019.150.4375.4 | 151080    | 10-Jun-2024 | 18:30 | x64      |
| exceldest.dll                                                 | 2019.150.4375.4 | 235456    | 10-Jun-2024 | 18:30 | x86      |
| exceldest.dll                                                 | 2019.150.4375.4 | 280520    | 10-Jun-2024 | 18:30 | x64      |
| excelsrc.dll                                                  | 2019.150.4375.4 | 260152    | 10-Jun-2024 | 18:30 | x86      |
| excelsrc.dll                                                  | 2019.150.4375.4 | 309184    | 10-Jun-2024 | 18:30 | x64      |
| execpackagetask.dll                                           | 2019.150.4375.4 | 149544    | 10-Jun-2024 | 18:30 | x86      |
| execpackagetask.dll                                           | 2019.150.4375.4 | 186320    | 10-Jun-2024 | 18:30 | x64      |
| flatfiledest.dll                                              | 2019.150.4375.4 | 358456    | 10-Jun-2024 | 18:30 | x86      |
| flatfiledest.dll                                              | 2019.150.4375.4 | 411584    | 10-Jun-2024 | 18:30 | x64      |
| flatfilesrc.dll                                               | 2019.150.4375.4 | 370640    | 10-Jun-2024 | 18:30 | x86      |
| flatfilesrc.dll                                               | 2019.150.4375.4 | 427968    | 10-Jun-2024 | 18:30 | x64      |
| isdbupgradewizard.exe                                         | 15.0.4375.4     | 120872    | 10-Jun-2024 | 18:30 | x86      |
| isdbupgradewizard.exe                                         | 15.0.4375.4     | 120872    | 10-Jun-2024 | 18:30 | x86      |
| isserverexec.exe                                              | 15.0.4375.4     | 149544    | 10-Jun-2024 | 18:30 | x86      |
| isserverexec.exe                                              | 15.0.4375.4     | 145464    | 10-Jun-2024 | 18:30 | x64      |
| log4j-1.2.17.jar                                              | n/a             | 489884    | 10-Jun-2024 | 18:30 | n/a      |
| log4j-1.2.17.jar                                              | n/a             | 489884    | 10-Jun-2024 | 18:30 | n/a      |
| microsoft.sqlserver.astasks.dll                               | 15.0.4375.4     | 116672    | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4375.4     | 59344     | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4375.4     | 509904    | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4375.4     | 510008    | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4375.4     | 43064     | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4375.4     | 391224    | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4375.4     | 59328     | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4375.4     | 59448     | 10-Jun-2024 | 18:30 | x86      |
| microsoft.sqlserver.scripttask.dll                            | 15.0.4375.4     | 141352    | 10-Jun-2024 | 18:30 | x86      |
| msdtssrvr.exe                                                 | 15.0.4375.4     | 219088    | 10-Jun-2024 | 18:30 | x64      |
| msdtssrvrutil.dll                                             | 2019.150.4375.4 | 100304    | 10-Jun-2024 | 18:30 | x86      |
| msdtssrvrutil.dll                                             | 2019.150.4375.4 | 112576    | 10-Jun-2024 | 18:30 | x64      |
| msmdpp.dll                                                    | 2018.150.35.45  | 10062904  | 10-Jun-2024 | 18:27 | x64      |
| odbcdest.dll                                                  | 2019.150.4375.4 | 321488    | 10-Jun-2024 | 18:30 | x86      |
| odbcdest.dll                                                  | 2019.150.4375.4 | 370640    | 10-Jun-2024 | 18:30 | x64      |
| odbcsrc.dll                                                   | 2019.150.4375.4 | 329680    | 10-Jun-2024 | 18:30 | x86      |
| odbcsrc.dll                                                   | 2019.150.4375.4 | 383016    | 10-Jun-2024 | 18:30 | x64      |
| oledbdest.dll                                                 | 2019.150.4375.4 | 239552    | 10-Jun-2024 | 18:30 | x86      |
| oledbdest.dll                                                 | 2019.150.4375.4 | 280512    | 10-Jun-2024 | 18:30 | x64      |
| oledbsrc.dll                                                  | 2019.150.4375.4 | 264248    | 10-Jun-2024 | 18:30 | x86      |
| oledbsrc.dll                                                  | 2019.150.4375.4 | 313280    | 10-Jun-2024 | 18:30 | x64      |
| rawdest.dll                                                   | 2019.150.4375.4 | 190400    | 10-Jun-2024 | 18:30 | x86      |
| rawdest.dll                                                   | 2019.150.4375.4 | 227264    | 10-Jun-2024 | 18:30 | x64      |
| rawsource.dll                                                 | 2019.150.4375.4 | 178112    | 10-Jun-2024 | 18:30 | x86      |
| rawsource.dll                                                 | 2019.150.4375.4 | 211000    | 10-Jun-2024 | 18:30 | x64      |
| recordsetdest.dll                                             | 2019.150.4375.4 | 174016    | 10-Jun-2024 | 18:30 | x86      |
| recordsetdest.dll                                             | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:30 | x64      |
| slf4j-log4j12-1.7.5.jar                                       | n/a             | 8869      | 10-Jun-2024 | 18:30 | n/a      |
| slf4j-log4j12-1.7.5.jar                                       | n/a             | 8869      | 10-Jun-2024 | 18:30 | n/a      |
| sqlceip.exe                                                   | 15.0.4375.4     | 296896    | 10-Jun-2024 | 18:30 | x86      |
| sqldest.dll                                                   | 2019.150.4375.4 | 276416    | 10-Jun-2024 | 18:30 | x64      |
| sqldest.dll                                                   | 2019.150.4375.4 | 239552    | 10-Jun-2024 | 18:30 | x86      |
| sqltaskconnections.dll                                        | 2019.150.4375.4 | 169920    | 10-Jun-2024 | 18:30 | x86      |
| sqltaskconnections.dll                                        | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:30 | x64      |
| ssis_commons_collections_3_2_2_jar_sql.32                     | n/a             | 588337    | 10-Jun-2024 | 18:30 | n/a      |
| ssis_commons_collections_3_2_2_jar_sql.64                     | n/a             | 588337    | 10-Jun-2024 | 18:30 | n/a      |
| txagg.dll                                                     | 2019.150.4375.4 | 329768    | 10-Jun-2024 | 18:30 | x86      |
| txagg.dll                                                     | 2019.150.4375.4 | 391224    | 10-Jun-2024 | 18:30 | x64      |
| txbdd.dll                                                     | 2019.150.4375.4 | 153640    | 10-Jun-2024 | 18:30 | x86      |
| txbdd.dll                                                     | 2019.150.4375.4 | 190400    | 10-Jun-2024 | 18:30 | x64      |
| txbestmatch.dll                                               | 2019.150.4375.4 | 546752    | 10-Jun-2024 | 18:30 | x86      |
| txbestmatch.dll                                               | 2019.150.4375.4 | 653264    | 10-Jun-2024 | 18:30 | x64      |
| txcache.dll                                                   | 2019.150.4375.4 | 165944    | 10-Jun-2024 | 18:30 | x86      |
| txcache.dll                                                   | 2019.150.4375.4 | 198592    | 10-Jun-2024 | 18:30 | x64      |
| txcharmap.dll                                                 | 2019.150.4375.4 | 272320    | 10-Jun-2024 | 18:30 | x86      |
| txcharmap.dll                                                 | 2019.150.4375.4 | 313296    | 10-Jun-2024 | 18:30 | x64      |
| txcopymap.dll                                                 | 2019.150.4375.4 | 165928    | 10-Jun-2024 | 18:30 | x86      |
| txcopymap.dll                                                 | 2019.150.4375.4 | 198592    | 10-Jun-2024 | 18:30 | x64      |
| txdataconvert.dll                                             | 2019.150.4375.4 | 276536    | 10-Jun-2024 | 18:30 | x86      |
| txdataconvert.dll                                             | 2019.150.4375.4 | 317376    | 10-Jun-2024 | 18:30 | x64      |
| txderived.dll                                                 | 2019.150.4375.4 | 559040    | 10-Jun-2024 | 18:30 | x86      |
| txderived.dll                                                 | 2019.150.4375.4 | 640976    | 10-Jun-2024 | 18:30 | x64      |
| txfileextractor.dll                                           | 2019.150.4375.4 | 182208    | 10-Jun-2024 | 18:30 | x86      |
| txfileextractor.dll                                           | 2019.150.4375.4 | 219072    | 10-Jun-2024 | 18:30 | x64      |
| txfileinserter.dll                                            | 2019.150.4375.4 | 182328    | 10-Jun-2024 | 18:30 | x86      |
| txfileinserter.dll                                            | 2019.150.4375.4 | 214976    | 10-Jun-2024 | 18:30 | x64      |
| txgroupdups.dll                                               | 2019.150.4375.4 | 255952    | 10-Jun-2024 | 18:30 | x86      |
| txgroupdups.dll                                               | 2019.150.4375.4 | 313384    | 10-Jun-2024 | 18:30 | x64      |
| txlineage.dll                                                 | 2019.150.4375.4 | 128960    | 10-Jun-2024 | 18:30 | x86      |
| txlineage.dll                                                 | 2019.150.4375.4 | 153656    | 10-Jun-2024 | 18:30 | x64      |
| txlookup.dll                                                  | 2019.150.4375.4 | 468944    | 10-Jun-2024 | 18:30 | x86      |
| txlookup.dll                                                  | 2019.150.4375.4 | 542760    | 10-Jun-2024 | 18:30 | x64      |
| txmerge.dll                                                   | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:30 | x86      |
| txmerge.dll                                                   | 2019.150.4375.4 | 247744    | 10-Jun-2024 | 18:30 | x64      |
| txmergejoin.dll                                               | 2019.150.4375.4 | 247744    | 10-Jun-2024 | 18:30 | x86      |
| txmergejoin.dll                                               | 2019.150.4375.4 | 309184    | 10-Jun-2024 | 18:30 | x64      |
| txmulticast.dll                                               | 2019.150.4375.4 | 116672    | 10-Jun-2024 | 18:30 | x86      |
| txmulticast.dll                                               | 2019.150.4375.4 | 145344    | 10-Jun-2024 | 18:30 | x64      |
| txpivot.dll                                                   | 2019.150.4375.4 | 206784    | 10-Jun-2024 | 18:30 | x86      |
| txpivot.dll                                                   | 2019.150.4375.4 | 239568    | 10-Jun-2024 | 18:30 | x64      |
| txrowcount.dll                                                | 2019.150.4375.4 | 112696    | 10-Jun-2024 | 18:30 | x86      |
| txrowcount.dll                                                | 2019.150.4375.4 | 141248    | 10-Jun-2024 | 18:30 | x64      |
| txsampling.dll                                                | 2019.150.4375.4 | 157752    | 10-Jun-2024 | 18:30 | x86      |
| txsampling.dll                                                | 2019.150.4375.4 | 194512    | 10-Jun-2024 | 18:30 | x64      |
| txscd.dll                                                     | 2019.150.4375.4 | 198592    | 10-Jun-2024 | 18:30 | x86      |
| txscd.dll                                                     | 2019.150.4375.4 | 235576    | 10-Jun-2024 | 18:30 | x64      |
| txsort.dll                                                    | 2019.150.4375.4 | 231360    | 10-Jun-2024 | 18:30 | x86      |
| txsort.dll                                                    | 2019.150.4375.4 | 288704    | 10-Jun-2024 | 18:30 | x64      |
| txsplit.dll                                                   | 2019.150.4375.4 | 550848    | 10-Jun-2024 | 18:30 | x86      |
| txsplit.dll                                                   | 2019.150.4375.4 | 624576    | 10-Jun-2024 | 18:30 | x64      |
| txtermextraction.dll                                          | 2019.150.4375.4 | 8644544   | 10-Jun-2024 | 18:30 | x86      |
| txtermextraction.dll                                          | 2019.150.4375.4 | 8701888   | 10-Jun-2024 | 18:30 | x64      |
| txtermlookup.dll                                              | 2019.150.4375.4 | 4139064   | 10-Jun-2024 | 18:30 | x86      |
| txtermlookup.dll                                              | 2019.150.4375.4 | 4184104   | 10-Jun-2024 | 18:30 | x64      |
| txunionall.dll                                                | 2019.150.4375.4 | 161832    | 10-Jun-2024 | 18:30 | x86      |
| txunionall.dll                                                | 2019.150.4375.4 | 198592    | 10-Jun-2024 | 18:30 | x64      |
| txunpivot.dll                                                 | 2019.150.4375.4 | 182208    | 10-Jun-2024 | 18:30 | x86      |
| txunpivot.dll                                                 | 2019.150.4375.4 | 214976    | 10-Jun-2024 | 18:30 | x64      |
| xe.dll                                                        | 2019.150.4375.4 | 632888    | 10-Jun-2024 | 18:30 | x86      |
| xe.dll                                                        | 2019.150.4375.4 | 722896    | 10-Jun-2024 | 18:30 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| dms.dll                                                              | 15.0.1968.0     | 559576    | 10-Jun-2024 | 19:11 | x86      |
| dmsnative.dll                                                        | 2018.150.1968.0 | 152520    | 10-Jun-2024 | 19:11 | x64      |
| dwengineservice.dll                                                  | 15.0.1968.0     | 45112     | 10-Jun-2024 | 19:11 | x86      |
| dwengineservice.exe.config                                           | n/a             | 252094    | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_cacerts_pem.64                     | n/a             | 204761    | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_dsmessages_xml.64                  | n/a             | 17245     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_mdmessages_xml.64                  | n/a             | 10191     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_mongodbodbc_did.64                 | n/a             | 272       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdrivermongo_2321_odbcmessages_xml.64                | n/a             | 88581     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_openssl64_dlla_manifest.64         | n/a             | 282       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdrivermongo_2321_schemamapmessages_xml.64           | n/a             | 1884      | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_sqlenginemessages_xml.64           | n/a             | 40943     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_2321_thirdpartynotices_txt.64           | n/a             | 52677     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_cacerts_pem.64                      | n/a             | 255048    | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_dsmessages_xml.64                   | n/a             | 10067     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_mdmessages_xml.64                   | n/a             | 9574      | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_mongodbodbc_did.64                  | n/a             | 272       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdrivermongo_238_odbcmessages_xml.64                 | n/a             | 77846     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_openssl64_dlla_manifest.64          | n/a             | 282       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdrivermongo_238_schemamapmessages_xml.64            | n/a             | 1884      | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_sqlenginemessages_xml.64            | n/a             | 39334     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongo_238_thirdpartynotices_txt.64            | n/a             | 52677     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongodb233_ini.64                             | n/a             | 229       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdrivermongodb238_ini.64                             | n/a             | 241       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriveroracle_802_msodbc_lic.64                      | n/a             | 2564      | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriveroracle_802_thirdpartynotices_txt.64           | n/a             | 65069     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1028 | n/a             | 156536    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1031 | n/a             | 226168    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1033 | n/a             | 205688    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1036 | n/a             | 230264    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1040 | n/a             | 226168    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1041 | n/a             | 172920    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1042 | n/a             | 172920    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1046 | n/a             | 222072    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1049 | n/a             | 222072    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_2052 | n/a             | 156536    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_3082 | n/a             | 226168    | 10-Jun-2024 | 19:11 | x64      |
| eng_polybase_odbcdriverteradata_162000_dsmessages_xml.64             | n/a             | 10247     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_162000_odbcmessages_xml.64           | n/a             | 78296     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_162000_sqlenginemessages_xml.64      | n/a             | 39647     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_162000_tdmessages_xml.64             | n/a             | 20320     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_162000_teradataodbc_did.64           | n/a             | 272       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_162000_thirdpartynotices_txt.64      | n/a             | 28881     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_dsmessages_xml.64             | n/a             | 15676     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_odbcmessages_xml.64           | n/a             | 88551     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_sqlenginemessages_xml.64      | n/a             | 40943     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_tdmessages_xml.64             | n/a             | 32305     | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_teradataodbc_did.64           | n/a             | 272       | 10-Jun-2024 | 19:11 | n/a      |
| eng_polybase_odbcdriverteradata_170000_thirdpartynotices_txt.64      | n/a             | 28881     | 10-Jun-2024 | 19:11 | n/a      |
| enginediagnosticsconfig.xml                                          | n/a             | 155186    | 10-Jun-2024 | 19:11 | n/a      |
| externalaccessconfig.xml                                             | n/a             | 68870     | 10-Jun-2024 | 19:11 | n/a      |
| externalobjectsconfig.xml                                            | n/a             | 1834      | 10-Jun-2024 | 19:11 | n/a      |
| externaloptimizationconfig.xml                                       | n/a             | 18756     | 10-Jun-2024 | 19:11 | n/a      |
| externalworkersconfig.xml                                            | n/a             | 1416      | 10-Jun-2024 | 19:11 | n/a      |
| icudt58.dll                                                          | 58.3.0.0        | 27110344  | 10-Jun-2024 | 19:11 | x64      |
| icudt58.dll                                                          | 58.2.0.0        | 27109768  | 10-Jun-2024 | 19:11 | x64      |
| icudt58.dll                                                          | 58.2.0.0        | 27109832  | 10-Jun-2024 | 19:11 | x64      |
| icudt58.dll                                                          | 58.3.0.0        | 27110344  | 10-Jun-2024 | 19:11 | x64      |
| icuin58.dll                                                          | 58.3.0.0        | 2562504   | 10-Jun-2024 | 19:11 | x64      |
| icuin58.dll                                                          | 58.2.0.0        | 2425288   | 10-Jun-2024 | 19:11 | x64      |
| icuin58.dll                                                          | 58.2.0.0        | 2431880   | 10-Jun-2024 | 19:11 | x64      |
| icuin58.dll                                                          | 58.3.0.0        | 2551752   | 10-Jun-2024 | 19:11 | x64      |
| icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 10-Jun-2024 | 19:11 | x64      |
| icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 10-Jun-2024 | 19:11 | x64      |
| icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 10-Jun-2024 | 19:11 | x64      |
| icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 10-Jun-2024 | 19:11 | x64      |
| icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 10-Jun-2024 | 19:11 | x64      |
| instapi150.dll                                                       | 2019.150.4375.4 | 88104     | 10-Jun-2024 | 19:11 | x64      |
| libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 10-Jun-2024 | 19:11 | x64      |
| libcrypto                                                            | 1.1.1.11        | 4321232   | 10-Jun-2024 | 19:11 | x64      |
| libcrypto                                                            | 1.1.1.4         | 2953680   | 10-Jun-2024 | 19:11 | x64      |
| libcrypto                                                            | 1.1.1.14        | 4085336   | 10-Jun-2024 | 19:11 | x64      |
| libsasl.dll                                                          | 2.1.26.0        | 292224    | 10-Jun-2024 | 19:11 | x64      |
| libsasl.dll                                                          | 2.1.26.0        | 521664    | 10-Jun-2024 | 19:11 | x64      |
| libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 10-Jun-2024 | 19:11 | x64      |
| libssl                                                               | 1.1.1.11        | 1322960   | 10-Jun-2024 | 19:11 | x64      |
| libssl                                                               | 1.1.1.14        | 1195600   | 10-Jun-2024 | 19:11 | x64      |
| libssl                                                               | 1.1.1.4         | 798160    | 10-Jun-2024 | 19:11 | x64      |
| microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1968.0     | 67656     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1968.0     | 293432    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1968.0     | 1957960   | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1968.0     | 169544    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1968.0     | 649672    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1968.0     | 246344    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1968.0     | 139320    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1968.0     | 79816     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1968.0     | 51144     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1968.0     | 88632     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1968.0     | 1129416   | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1968.0     | 80952     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1968.0     | 70712     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1968.0     | 35384     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1968.0     | 31288     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1968.0     | 46536     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1968.0     | 21560     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1968.0     | 26696     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1968.0     | 131536    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1968.0     | 86584     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1968.0     | 100824    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1968.0     | 293336    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 120376    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 138296    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 141256    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 137688    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 150488    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 139832    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 134616    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 176600    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 117816    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1968.0     | 136664    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1968.0     | 72648     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1968.0     | 21960     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1968.0     | 37320     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1968.0     | 128976    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1968.0     | 3064888   | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1968.0     | 3955768   | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 118344    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 133176    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 137672    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 133688    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 148536    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 134192    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 130632    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 171064    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 115272    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1968.0     | 132168    | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1968.0     | 67544     | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1968.0     | 2682936   | 10-Jun-2024 | 19:11 | x86      |
| microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1968.0     | 2436552   | 10-Jun-2024 | 19:11 | x86      |
| mpdwinterop.dll                                                      | 2019.150.4375.4 | 452648    | 10-Jun-2024 | 19:11 | x64      |
| mpdwsvc.exe                                                          | 2019.150.4375.4 | 7407656   | 10-Jun-2024 | 19:11 | x64      |
| msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 10-Jun-2024 | 19:11 | x64      |
| odbc32.dll                                                           | 10.0.17763.1    | 720792    | 10-Jun-2024 | 19:11 | x64      |
| odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 10-Jun-2024 | 19:11 | x64      |
| odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 10-Jun-2024 | 19:11 | x64      |
| polybase odbc driver for mongodb.ini                                 | n/a             | 231       | 10-Jun-2024 | 19:11 | n/a      |
| polybase odbc driver for oracle.ini                                  | n/a             | 207       | 10-Jun-2024 | 19:11 | n/a      |
| polybase odbc driver for sql server.ini                              | n/a             | 317       | 10-Jun-2024 | 19:11 | n/a      |
| polybase odbc driver for teradata.ini                                | n/a             | 235       | 10-Jun-2024 | 19:11 | n/a      |
| saslplain.dll                                                        | 2.1.26.0        | 170880    | 10-Jun-2024 | 19:11 | x64      |
| saslplain.dll                                                        | 2.1.26.0        | 377792    | 10-Jun-2024 | 19:11 | x64      |
| secforwarder.dll                                                     | 2019.150.4375.4 | 79824     | 10-Jun-2024 | 19:11 | x64      |
| sharedmemory.dll                                                     | 2018.150.1968.0 | 61496     | 10-Jun-2024 | 19:11 | x64      |
| sqldk.dll                                                            | 2019.150.4375.4 | 3180496   | 10-Jun-2024 | 19:11 | x64      |
| sqldumper.exe                                                        | 2019.150.4375.4 | 378832    | 10-Jun-2024 | 19:11 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 1595328   | 10-Jun-2024 | 19:05 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 4171816   | 10-Jun-2024 | 19:05 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 3422248   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 4163640   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 4069416   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 2226216   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 2176960   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 3827752   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 3823552   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 1542184   | 10-Jun-2024 | 19:06 | x64      |
| sqlevn70.rll                                                         | 2019.150.4375.4 | 4036544   | 10-Jun-2024 | 19:06 | x64      |
| sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 10-Jun-2024 | 19:11 | x64      |
| sqlnclir17e.rll                                                      | n/a             | 206768    | 10-Jun-2024 | 19:11 | x64      |
| sqlos.dll                                                            | 2019.150.4375.4 | 43064     | 10-Jun-2024 | 19:11 | x64      |
| sqlsortpdw.dll                                                       | 2018.150.1968.0 | 4841416   | 10-Jun-2024 | 19:11 | x64      |
| sqltses.dll                                                          | 2019.150.4375.4 | 9119680   | 10-Jun-2024 | 19:11 | x64      |
| tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 10-Jun-2024 | 19:11 | x64      |
| tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 10-Jun-2024 | 19:11 | x64      |
| terasso.dll                                                          | 17.0.0.28       | 2357064   | 10-Jun-2024 | 19:11 | x64      |
| terasso.dll                                                          | 16.20.0.13      | 2158896   | 10-Jun-2024 | 19:11 | x64      |
| zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 10-Jun-2024 | 19:11 | x64      |
| zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 10-Jun-2024 | 19:11 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| smrdll.dll | 15.0.4375.4  | 30656     | 10-Jun-2024 | 18:29 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| autoadmin.dll                                                | 2019.150.4375.4 | 1632296   | 10-Jun-2024 | 18:44 | x86      |
| dtaengine.exe                                                | 2019.150.4375.4 | 219192    | 10-Jun-2024 | 18:44 | x86      |
| dteparse.dll                                                 | 2019.150.4375.4 | 112576    | 10-Jun-2024 | 18:44 | x86      |
| dteparse.dll                                                 | 2019.150.4375.4 | 124864    | 10-Jun-2024 | 18:44 | x64      |
| dteparsemgd.dll                                              | 2019.150.4375.4 | 116792    | 10-Jun-2024 | 18:44 | x86      |
| dteparsemgd.dll                                              | 2019.150.4375.4 | 133056    | 10-Jun-2024 | 18:44 | x64      |
| dtepkg.dll                                                   | 2019.150.4375.4 | 133160    | 10-Jun-2024 | 18:44 | x86      |
| dtepkg.dll                                                   | 2019.150.4375.4 | 149440    | 10-Jun-2024 | 18:44 | x64      |
| dtexec.exe                                                   | 2019.150.4375.4 | 64976     | 10-Jun-2024 | 18:44 | x86      |
| dtexec.exe                                                   | 2019.150.4375.4 | 73768     | 10-Jun-2024 | 18:44 | x64      |
| dts.dll                                                      | 2019.150.4375.4 | 2762792   | 10-Jun-2024 | 18:44 | x86      |
| dts.dll                                                      | 2019.150.4375.4 | 3143736   | 10-Jun-2024 | 18:44 | x64      |
| dtscomexpreval.dll                                           | 2019.150.4375.4 | 444352    | 10-Jun-2024 | 18:44 | x86      |
| dtscomexpreval.dll                                           | 2019.150.4375.4 | 501688    | 10-Jun-2024 | 18:44 | x64      |
| dtsconn.dll                                                  | 2019.150.4375.4 | 432064    | 10-Jun-2024 | 18:44 | x86      |
| dtsconn.dll                                                  | 2019.150.4375.4 | 522280    | 10-Jun-2024 | 18:44 | x64      |
| dtshost.exe                                                  | 2019.150.4375.4 | 89552     | 10-Jun-2024 | 18:44 | x86      |
| dtshost.exe                                                  | 2019.150.4375.4 | 107456    | 10-Jun-2024 | 18:44 | x64      |
| dtsmsg.h                                                     | n/a             | 779773    | 10-Jun-2024 | 18:44 | n/a      |
| dtsmsg150.dll                                                | 2019.150.4375.4 | 555048    | 10-Jun-2024 | 18:44 | x86      |
| dtsmsg150.dll                                                | 2019.150.4375.4 | 567232    | 10-Jun-2024 | 18:44 | x64      |
| dtspipeline.dll                                              | 2019.150.4375.4 | 1120208   | 10-Jun-2024 | 18:44 | x86      |
| dtspipeline.dll                                              | 2019.150.4375.4 | 1329192   | 10-Jun-2024 | 18:44 | x64      |
| dtswizard.exe                                                | 15.0.4375.4     | 890832    | 10-Jun-2024 | 18:44 | x86      |
| dtswizard.exe                                                | 15.0.4375.4     | 886824    | 10-Jun-2024 | 18:44 | x64      |
| dtuparse.dll                                                 | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 18:44 | x86      |
| dtuparse.dll                                                 | 2019.150.4375.4 | 100408    | 10-Jun-2024 | 18:44 | x64      |
| dtutil.exe                                                   | 2019.150.4375.4 | 130616    | 10-Jun-2024 | 18:44 | x86      |
| dtutil.exe                                                   | 2019.150.4375.4 | 151080    | 10-Jun-2024 | 18:44 | x64      |
| exceldest.dll                                                | 2019.150.4375.4 | 280520    | 10-Jun-2024 | 18:44 | x64      |
| exceldest.dll                                                | 2019.150.4375.4 | 235456    | 10-Jun-2024 | 18:44 | x86      |
| excelsrc.dll                                                 | 2019.150.4375.4 | 309184    | 10-Jun-2024 | 18:44 | x64      |
| excelsrc.dll                                                 | 2019.150.4375.4 | 260152    | 10-Jun-2024 | 18:44 | x86      |
| flatfiledest.dll                                             | 2019.150.4375.4 | 411584    | 10-Jun-2024 | 18:44 | x64      |
| flatfiledest.dll                                             | 2019.150.4375.4 | 358456    | 10-Jun-2024 | 18:44 | x86      |
| flatfilesrc.dll                                              | 2019.150.4375.4 | 427968    | 10-Jun-2024 | 18:44 | x64      |
| flatfilesrc.dll                                              | 2019.150.4375.4 | 370640    | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.astasks.dll                              | 15.0.4375.4     | 116672    | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4375.4     | 403392    | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4375.4     | 403400    | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.configuration.sco.dll                    | 15.0.4375.4     | 3004456   | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.configuration.sco.dll                    | 15.0.4375.4     | 3004472   | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4375.4     | 43064     | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4375.4     | 59448     | 10-Jun-2024 | 18:44 | x86      |
| microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 10-Jun-2024 | 18:44 | x86      |
| msdtssrvrutil.dll                                            | 2019.150.4375.4 | 100304    | 10-Jun-2024 | 18:44 | x86      |
| msdtssrvrutil.dll                                            | 2019.150.4375.4 | 112576    | 10-Jun-2024 | 18:44 | x64      |
| msmgdsrv.dll                                                 | 2018.150.35.45  | 8280120   | 10-Jun-2024 | 18:44 | x86      |
| oledbdest.dll                                                | 2019.150.4375.4 | 239552    | 10-Jun-2024 | 18:44 | x86      |
| oledbdest.dll                                                | 2019.150.4375.4 | 280512    | 10-Jun-2024 | 18:44 | x64      |
| oledbsrc.dll                                                 | 2019.150.4375.4 | 264248    | 10-Jun-2024 | 18:44 | x86      |
| oledbsrc.dll                                                 | 2019.150.4375.4 | 313280    | 10-Jun-2024 | 18:44 | x64      |
| sqlresourceloader.dll                                        | 2019.150.4375.4 | 38864     | 10-Jun-2024 | 18:44 | x86      |
| sqlresourceloader.dll                                        | 2019.150.4375.4 | 51152     | 10-Jun-2024 | 18:44 | x64      |
| sqlscm.dll                                                   | 2019.150.4375.4 | 79912     | 10-Jun-2024 | 18:44 | x86      |
| sqlscm.dll                                                   | 2019.150.4375.4 | 88000     | 10-Jun-2024 | 18:44 | x64      |
| sqlsvc.dll                                                   | 2019.150.4375.4 | 149456    | 10-Jun-2024 | 18:44 | x86      |
| sqlsvc.dll                                                   | 2019.150.4375.4 | 182328    | 10-Jun-2024 | 18:44 | x64      |
| sqltaskconnections.dll                                       | 2019.150.4375.4 | 169920    | 10-Jun-2024 | 18:44 | x86      |
| sqltaskconnections.dll                                       | 2019.150.4375.4 | 202688    | 10-Jun-2024 | 18:44 | x64      |
| txdataconvert.dll                                            | 2019.150.4375.4 | 276536    | 10-Jun-2024 | 18:44 | x86      |
| txdataconvert.dll                                            | 2019.150.4375.4 | 317376    | 10-Jun-2024 | 18:44 | x64      |
| xe.dll                                                       | 2019.150.4375.4 | 632888    | 10-Jun-2024 | 18:44 | x86      |
| xe.dll                                                       | 2019.150.4375.4 | 722896    | 10-Jun-2024 | 18:44 | x64      |

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
- [Overview of SQL Server Servicing Installation](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

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
