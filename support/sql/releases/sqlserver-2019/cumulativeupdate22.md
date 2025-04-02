---
title: Cumulative update 22 for SQL Server 2019 (KB5027702)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 22 (KB5027702).
ms.date: 12/22/2023
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5027702
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5027702 - Cumulative Update 22 for SQL Server 2019

_Release Date:_ &nbsp; August 14, 2023  
_Version:_ &nbsp; 15.0.4322.2

## Summary

This article describes Cumulative Update package 22 (CU22) for Microsoft SQL Server 2019. This update contains 20 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 21, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4322.2**, file version: **2019.150.4322.2**
- Analysis Services - Product version: **15.0.35.41**, file version: **2018.150.35.41**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion_context-2019](../includes/av-sesssion_context-2019.md)]


## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area | Component | Platform |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2445012>[2445012](#2445012) </a> | Fixes an issue in which an alias error occurs during a database upgrade if you apply the name "en" to an attribute. | Master Data Services | Master Data Services| Windows|
| <a id=2469366>[2469366](#2469366) </a> | Fixes an issue in which the validation of a custom input mask fails. After applying this fix, you can use a custom input mask with the time part. | Master Data Services | Master Data Services| Windows|
| <a id=2517054>[2517054](#2517054) </a> | Fixes an issue in which you can't see the **Created By** and **Updated By** fields in the **View History** window when you use the Master Data Services (MDS) Add-in for Excel. | Master Data Services |Master Data Services |Windows |
| <a id=2518620>[2518620](#2518620) </a> | Fixes an issue in which an error may occur when you download an attachment uploaded previously in a Master Data Services model. | Master Data Services | Master Data Services| Windows|
| <a id=1999783>[1999783](#1999783) </a> | Fixes an access violation in `sqllang!FReadDataDirect` that you encounter during network exchanges between an instance of SQL Server and a client. | SQL Connectivity | SQL Connectivity| All |
| <a id=2387353>[2387353](#2387353) </a> | Fixes an access violation dump issue that you encounter when dropping a distributed availability group (AG) that has a suspect AG database on a forwarder.| SQL Server Engine| High Availability and Disaster Recovery |All |
| <a id=2460204>[2460204](#2460204) </a> | Fixes an issue caused by a change introduced in SQL Server 2019 CU20 for the [Managed Instance link](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview) feature. For more information, see [Issue three](cumulativeupdate20.md#issue-three). | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=2504040>[2504040](#2504040) </a> | Fixes a stack overflow in `HaDrUndoMgr::InitSystemPages` that's caused by a loop getting all the Page Free Space (PFS) pages from the primary availability group. | SQL Server Engine| High Availability and Disaster Recovery |All |
| <a id=2555121>[2555121](#2555121) </a> | Fixes an issue in which a pointer is outside the empty result buffer when the output of `CONCAT_WS` is empty. This fix adds a check for the empty result before doing the pointer arithmetic. | SQL Server Engine| In-Memory OLTP|All |
| <a id=2355421>[2355421](#2355421) </a> | Fixes an intra-query deadlock that you might encounter when running some query plans that involve nested loop joins in batch mode. | SQL Server Engine|Query Execution|All |
| <a id=2111946>[2111946](#2111946) </a> | Increases the threshold for the number of `OR` clauses that can be converted to Index Union plans.| SQL Server Engine|Query Optimizer|All |
| <a id=2472432>[2472432](#2472432) </a> | Enables trace flag 9135 (`TRCFLG_QP_DONT_USE_INDEXED_VIEWS`) in retail builds to allow the `EXPAND VIEWS` behavior without the per-query hint. | SQL Server Engine| Query Optimizer | All|
| <a id=2434847>[2434847](#2434847) </a> | Fixes an issue in which a thread deadlock between Query Store (QDS) background tasks blocks the database shutdown.| SQL Server Engine| Query Store | All|
| <a id=2506723>[2506723](#2506723) </a> | Improves `sp_addpublication_snapshot` by exposing additional parameters (`@distributor_security_mode`, `@distributor_login`, and `@distributor_password`). With these parameters, you can configure the Snapshot Agent to connect to the Distributor using SQL Server Authentication. Before this fix, the Snapshot Agent connects to the Distributor with Windows Authentication, and you can't configure it to connect to the Distributor using SQL Server Authentication.| SQL Server Engine| Replication | All|
| <a id=2491017>[2491017](#2491017) </a> | Fixes an issue in which running `sp_change_users_login` reports the following error if the database collation is `Chinese_PRC_CI_AS`: </br></br>Msg 9833, Level 16, State 3, Line \<LineNumber> </br>Invalid data for DBCS-encoded characters.| SQL Server Engine| Security Infrastructure | All|
| <a id=2330261>[2330261](#2330261) </a> | Fixes an assertion dump issue (Location: sebind.h:1206; Expression: bufferLen >= colLen) that you encounter when running an `INSERT` statement against the table that has the **nvarchar(n)** column as an index column.| SQL Server Engine| SQL Server Engine |All |
| <a id=2497934>[2497934](#2497934) </a> | Fixes a latch time-out issue that you might encounter in the ghost cleanup process or version cleaner when there's a long chain of Index Allocation Map (IAM) pages for a table. | SQL Server Engine| SQL Server Engine |All |
| <a id=2332831>[2332831](#2332831) </a> | Fixes an issue in which running `DBCC CHECKTABLE` may create snapshot files, even if a user fails the table-level permission check. | SQL Server Engine| Storage Management| All|
| <a id=2126481>[2126481](#2126481) </a> | Fixes an access violation dump issue that you might encounter when resuming an index rebuild that includes partitions (for example, `ALTER INDEX [index_name] ON [schema].[TableName] RESUME WITH ( MAX_DURATION = 1, MAXDOP = 1 )`). | SQL Server Engine| Table Index Partition | All|
| <a id=2491768>[2491768](#2491768) </a> | Fixes an issue in which the number of the Log Writer threads is inconsistent when the SQL Server instance is affinitized to a subset of NUMA nodes. | SQL Server Engine|Transaction Services |All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU22 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5027702)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5027702-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5027702-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5027702-x64.exe| 485CA89F201C3E9E3990D43FDACF9AA70A1DDA589814E395F082C4B4E7C910D6 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.41  | 292760    | 27-Jul-23 | 18:40 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 27-Jul-23 | 18:40 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.41      | 758168    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 175560    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 199624    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 202184    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 198600    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 214936    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197576    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 193480    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 252360    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 174024    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197064    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.41      | 1098648   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.41      | 567240    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 54728     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59336     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59840     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58776     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 61896     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58312     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 67528     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 53656     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 18888     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 27-Jul-23 | 18:40 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 27-Jul-23 | 18:40 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 27-Jul-23 | 18:40 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 27-Jul-23 | 18:40 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 27-Jul-23 | 18:40 | x86      |
| Msmdctr.dll                                               | 2018.150.35.41  | 38296     | 27-Jul-23 | 18:40 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 47788440  | 27-Jul-23 | 18:40 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 66299800  | 27-Jul-23 | 18:40 | x64      |
| Msmdpump.dll                                              | 2018.150.35.41  | 10189768  | 27-Jul-23 | 18:40 | x64      |
| Msmdredir.dll                                             | 2018.150.35.41  | 7957912   | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 18328     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 27-Jul-23 | 18:40 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 27-Jul-23 | 18:40 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.41  | 65837512  | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 833432    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1628056   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1453976   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1642904   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1608600   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1001368   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 992664    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1536920   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1521560   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 810904    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1596312   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 832408    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1624472   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1450904   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1637784   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1604504   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 998808    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 991128    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1532824   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1517976   | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 809880    | 27-Jul-23 | 18:40 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1591704   | 27-Jul-23 | 18:40 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 8281032   | 27-Jul-23 | 18:40 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 10187160  | 27-Jul-23 | 18:40 | x64      |
| Msolap.dll                                                | 2018.150.35.41  | 8609176   | 27-Jul-23 | 18:40 | x86      |
| Msolap.dll                                                | 2018.150.35.41  | 11017160  | 27-Jul-23 | 18:40 | x64      |
| Msolui.dll                                                | 2018.150.35.41  | 286104    | 27-Jul-23 | 18:40 | x86      |
| Msolui.dll                                                | 2018.150.35.41  | 306584    | 27-Jul-23 | 18:40 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 27-Jul-23 | 18:40 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 27-Jul-23 | 18:40 | x64      |
| Sqlboot.dll                                               | 2019.150.4322.2 | 214936    | 27-Jul-23 | 18:40 | x64      |
| Sqlceip.exe                                               | 15.0.4322.2     | 292816    | 27-Jul-23 | 18:40 | x86      |
| Sqldumper.exe                                             | 2019.150.4322.2 | 153496    | 27-Jul-23 | 18:40 | x86      |
| Sqldumper.exe                                             | 2019.150.4322.2 | 186304    | 27-Jul-23 | 18:40 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 27-Jul-23 | 18:40 | x86      |
| Tmapi.dll                                                 | 2018.150.35.41  | 6178200   | 27-Jul-23 | 18:40 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.41  | 4917704   | 27-Jul-23 | 18:40 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.41  | 1184664   | 27-Jul-23 | 18:40 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.41  | 6806936   | 27-Jul-23 | 18:40 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 35460504  | 27-Jul-23 | 18:40 | x86      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 26026440  | 27-Jul-23 | 18:40 | x64      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4322.2 | 165784    | 27-Jul-23 | 18:45 | x86      |
| Batchparser.dll                      | 2019.150.4322.2 | 182208    | 27-Jul-23 | 18:45 | x64      |
| Instapi150.dll                       | 2019.150.4322.2 | 75672     | 27-Jul-23 | 18:45 | x86      |
| Instapi150.dll                       | 2019.150.4322.2 | 87960     | 27-Jul-23 | 18:45 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4322.2 | 100248    | 27-Jul-23 | 18:45 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4322.2 | 88016     | 27-Jul-23 | 18:45 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4322.2     | 550848    | 27-Jul-23 | 18:45 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4322.2     | 550816    | 27-Jul-23 | 18:45 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 27032     | 27-Jul-23 | 18:45 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 32152     | 27-Jul-23 | 18:45 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4322.2 | 75672     | 27-Jul-23 | 18:45 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4322.2 | 92048     | 27-Jul-23 | 18:45 | x64      |
| Sqldumper.exe                        | 2019.150.4322.2 | 153496    | 27-Jul-23 | 18:45 | x86      |
| Sqldumper.exe                        | 2019.150.4322.2 | 186304    | 27-Jul-23 | 18:45 | x64      |
| Sqlftacct.dll                        | 2019.150.4322.2 | 59296     | 27-Jul-23 | 18:45 | x86      |
| Sqlftacct.dll                        | 2019.150.4322.2 | 79776     | 27-Jul-23 | 18:45 | x64      |
| Sqlmanager.dll                       | 2019.150.4322.2 | 743328    | 27-Jul-23 | 18:45 | x86      |
| Sqlmanager.dll                       | 2019.150.4322.2 | 878488    | 27-Jul-23 | 18:45 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4322.2 | 378768    | 27-Jul-23 | 18:45 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4322.2 | 432032    | 27-Jul-23 | 18:45 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4322.2 | 276376    | 27-Jul-23 | 18:45 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4322.2 | 358336    | 27-Jul-23 | 18:45 | x64      |
| Svrenumapi150.dll                    | 2019.150.4322.2 | 1161152   | 27-Jul-23 | 18:45 | x64      |
| Svrenumapi150.dll                    | 2019.150.4322.2 | 911256    | 27-Jul-23 | 18:45 | x86      |

SQL Server 2019 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4322.2  | 599968    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4322.2  | 599968    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4322.2  | 1857432   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4322.2  | 1857424   | 27-Jul-23 | 18:40 | x86      |

SQL Server 2019 sql_dreplay_client

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4322.2 | 137152    | 27-Jul-23 | 18:40 | x86      |
| Dreplaycommon.dll     | 2019.150.4322.2 | 667536    | 27-Jul-23 | 18:40 | x86      |
| Dreplayutil.dll       | 2019.150.4322.2 | 305088    | 27-Jul-23 | 18:40 | x86      |
| Instapi150.dll        | 2019.150.4322.2 | 87960     | 27-Jul-23 | 18:40 | x64      |
| Sqlresourceloader.dll | 2019.150.4322.2 | 38848     | 27-Jul-23 | 18:40 | x86      |

SQL Server 2019 sql_dreplay_controller

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4322.2 | 667536    | 27-Jul-23 | 18:40 | x86      |
| Dreplaycontroller.exe | 2019.150.4322.2 | 366528    | 27-Jul-23 | 18:40 | x86      |
| Instapi150.dll        | 2019.150.4322.2 | 87960     | 27-Jul-23 | 18:40 | x64      |
| Sqlresourceloader.dll | 2019.150.4322.2 | 38848     | 27-Jul-23 | 18:40 | x86      |

SQL Server 2019 Database Services Core Instance

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4322.2 | 4658112   | 27-Jul-23 | 19:18 | x64      |
| Aetm-enclave.dll                           | 2019.150.4322.2 | 4612496   | 27-Jul-23 | 19:18 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4322.2 | 4938040   | 27-Jul-23 | 19:18 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4322.2 | 4873504   | 27-Jul-23 | 19:18 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 27-Jul-23 | 19:32 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 27-Jul-23 | 19:32 | x64      |
| Batchparser.dll                            | 2019.150.4322.2 | 182208    | 27-Jul-23 | 19:17 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 27-Jul-23 | 19:32 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 27-Jul-23 | 19:32 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 27-Jul-23 | 19:32 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 27-Jul-23 | 19:32 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4322.2 | 280512    | 27-Jul-23 | 19:32 | x64      |
| Dcexec.exe                                 | 2019.150.4322.2 | 88016     | 27-Jul-23 | 19:32 | x64      |
| Fssres.dll                                 | 2019.150.4322.2 | 96208     | 27-Jul-23 | 19:32 | x64      |
| Hadrres.dll                                | 2019.150.4322.2 | 206800    | 27-Jul-23 | 19:32 | x64      |
| Hkcompile.dll                              | 2019.150.4322.2 | 1292224   | 27-Jul-23 | 19:32 | x64      |
| Hkengine.dll                               | 2019.150.4322.2 | 5793728   | 27-Jul-23 | 19:32 | x64      |
| Hkruntime.dll                              | 2019.150.4322.2 | 182208    | 27-Jul-23 | 19:32 | x64      |
| Hktempdb.dll                               | 2019.150.4322.2 | 63424     | 27-Jul-23 | 19:32 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 27-Jul-23 | 19:32 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4322.2     | 235408    | 27-Jul-23 | 19:32 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4322.2 | 391104    | 27-Jul-23 | 19:32 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4322.2 | 325536    | 27-Jul-23 | 19:32 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4322.2 | 92096     | 27-Jul-23 | 19:32 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 27-Jul-23 | 19:32 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 27-Jul-23 | 19:32 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 27-Jul-23 | 19:32 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 27-Jul-23 | 19:32 | x64      |
| Qds.dll                                    | 2019.150.4322.2 | 1189784   | 27-Jul-23 | 19:32 | x64      |
| Rsfxft.dll                                 | 2019.150.4322.2 | 51104     | 27-Jul-23 | 19:32 | x64      |
| Secforwarder.dll                           | 2019.150.4322.2 | 79760     | 27-Jul-23 | 19:32 | x64      |
| Sqagtres.dll                               | 2019.150.4322.2 | 87968     | 27-Jul-23 | 19:32 | x64      |
| Sqlaamss.dll                               | 2019.150.4322.2 | 108432    | 27-Jul-23 | 19:32 | x64      |
| Sqlaccess.dll                              | 2019.150.4322.2 | 493456    | 27-Jul-23 | 19:32 | x64      |
| Sqlagent.exe                               | 2019.150.4322.2 | 731024    | 27-Jul-23 | 19:32 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4322.2 | 79808     | 27-Jul-23 | 19:32 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4322.2 | 71616     | 27-Jul-23 | 19:32 | x86      |
| Sqlboot.dll                                | 2019.150.4322.2 | 214936    | 27-Jul-23 | 19:32 | x64      |
| Sqlceip.exe                                | 15.0.4322.2     | 292816    | 27-Jul-23 | 19:32 | x86      |
| Sqlcmdss.dll                               | 2019.150.4322.2 | 87960     | 27-Jul-23 | 19:32 | x64      |
| Sqlctr150.dll                              | 2019.150.4322.2 | 116640    | 27-Jul-23 | 19:32 | x86      |
| Sqlctr150.dll                              | 2019.150.4322.2 | 145296    | 27-Jul-23 | 19:32 | x64      |
| Sqldk.dll                                  | 2019.150.4322.2 | 3180480   | 27-Jul-23 | 19:32 | x64      |
| Sqldtsss.dll                               | 2019.150.4322.2 | 108480    | 27-Jul-23 | 19:32 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 1595296   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3508112   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3700632   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4171672   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4286368   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3418008   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3585952   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4163480   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4016016   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4069272   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 2226072   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 2172816   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3876768   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3549088   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4020128   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3827616   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3823552   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3618720   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3508160   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 1537936   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 3913624   | 27-Jul-23 | 19:18 | x64      |
| Sqlevn70.rll                               | 2019.150.4322.2 | 4036496   | 27-Jul-23 | 19:18 | x64      |
| Sqllang.dll                                | 2019.150.4322.2 | 40032160  | 27-Jul-23 | 19:32 | x64      |
| Sqlmin.dll                                 | 2019.150.4322.2 | 40629712  | 27-Jul-23 | 19:32 | x64      |
| Sqlolapss.dll                              | 2019.150.4322.2 | 108480    | 27-Jul-23 | 19:32 | x64      |
| Sqlos.dll                                  | 2019.150.4322.2 | 42944     | 27-Jul-23 | 19:17 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4322.2 | 83904     | 27-Jul-23 | 19:32 | x64      |
| Sqlrepss.dll                               | 2019.150.4322.2 | 87960     | 27-Jul-23 | 19:32 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4322.2 | 51104     | 27-Jul-23 | 19:32 | x64      |
| Sqlscm.dll                                 | 2019.150.4322.2 | 87960     | 27-Jul-23 | 19:32 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4322.2 | 38864     | 27-Jul-23 | 19:32 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4322.2 | 5806016   | 27-Jul-23 | 19:32 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4322.2 | 673696    | 27-Jul-23 | 19:32 | x64      |
| Sqlservr.exe                               | 2019.150.4322.2 | 628632    | 27-Jul-23 | 19:32 | x64      |
| Sqlsvc.dll                                 | 2019.150.4322.2 | 182208    | 27-Jul-23 | 19:32 | x64      |
| Sqltses.dll                                | 2019.150.4322.2 | 9119648   | 27-Jul-23 | 19:32 | x64      |
| Sqsrvres.dll                               | 2019.150.4322.2 | 280512    | 27-Jul-23 | 19:32 | x64      |
| Stretchcodegen.exe                         | 15.0.4322.2     | 59280     | 27-Jul-23 | 19:18 | x86      |
| Svl.dll                                    | 2019.150.4322.2 | 161728    | 27-Jul-23 | 19:18 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 27-Jul-23 | 19:32 | x64      |
| Xe.dll                                     | 2019.150.4322.2 | 722880    | 27-Jul-23 | 19:32 | x64      |
| Xpadsi.exe                                 | 2019.150.4322.2 | 116624    | 27-Jul-23 | 19:32 | x64      |
| Xplog70.dll                                | 2019.150.4322.2 | 92096     | 27-Jul-23 | 19:32 | x64      |
| Xpqueue.dll                                | 2019.150.4322.2 | 92112     | 27-Jul-23 | 19:32 | x64      |
| Xprepl.dll                                 | 2019.150.4322.2 | 120768    | 27-Jul-23 | 19:32 | x64      |
| Xpstar.dll                                 | 2019.150.4322.2 | 472984    | 27-Jul-23 | 19:32 | x64      |

SQL Server 2019 Database Services Core Shared

|                          File   name                         |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4322.2 | 165784    | 27-Jul-23 | 18:40 | x86      |
| Batchparser.dll                                              | 2019.150.4322.2 | 182208    | 27-Jul-23 | 18:40 | x64      |
| Commanddest.dll                                              | 2019.150.4322.2 | 264080    | 27-Jul-23 | 18:40 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4322.2 | 231320    | 27-Jul-23 | 18:40 | x64      |
| Distrib.exe                                                  | 2019.150.4322.2 | 243648    | 27-Jul-23 | 18:40 | x64      |
| Dteparse.dll                                                 | 2019.150.4322.2 | 124816    | 27-Jul-23 | 18:40 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4322.2 | 133008    | 27-Jul-23 | 18:40 | x64      |
| Dtepkg.dll                                                   | 2019.150.4322.2 | 149456    | 27-Jul-23 | 18:40 | x64      |
| Dtexec.exe                                                   | 2019.150.4322.2 | 72640     | 27-Jul-23 | 18:40 | x64      |
| Dts.dll                                                      | 2019.150.4322.2 | 3143576   | 27-Jul-23 | 18:40 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4322.2 | 501648    | 27-Jul-23 | 18:40 | x64      |
| Dtsconn.dll                                                  | 2019.150.4322.2 | 522128    | 27-Jul-23 | 18:40 | x64      |
| Dtshost.exe                                                  | 2019.150.4322.2 | 106384    | 27-Jul-23 | 18:40 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4322.2 | 567184    | 27-Jul-23 | 18:40 | x64      |
| Dtspipeline.dll                                              | 2019.150.4322.2 | 1329088   | 27-Jul-23 | 18:40 | x64      |
| Dtswizard.exe                                                | 15.0.4322.2     | 886688    | 27-Jul-23 | 18:40 | x64      |
| Dtuparse.dll                                                 | 2019.150.4322.2 | 100248    | 27-Jul-23 | 18:40 | x64      |
| Dtutil.exe                                                   | 2019.150.4322.2 | 149456    | 27-Jul-23 | 18:40 | x64      |
| Exceldest.dll                                                | 2019.150.4322.2 | 280472    | 27-Jul-23 | 18:40 | x64      |
| Excelsrc.dll                                                 | 2019.150.4322.2 | 309144    | 27-Jul-23 | 18:40 | x64      |
| Execpackagetask.dll                                          | 2019.150.4322.2 | 186256    | 27-Jul-23 | 18:40 | x64      |
| Flatfiledest.dll                                             | 2019.150.4322.2 | 411552    | 27-Jul-23 | 18:40 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4322.2 | 427984    | 27-Jul-23 | 18:40 | x64      |
| Logread.exe                                                  | 2019.150.4322.2 | 722832    | 27-Jul-23 | 18:40 | x64      |
| Mergetxt.dll                                                 | 2019.150.4322.2 | 75712     | 27-Jul-23 | 18:40 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4322.2     | 59296     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4322.2     | 42904     | 27-Jul-23 | 18:40 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4322.2     | 391104    | 27-Jul-23 | 18:40 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4322.2 | 1697744   | 27-Jul-23 | 18:40 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4322.2 | 1640384   | 27-Jul-23 | 18:40 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4322.2     | 550848    | 27-Jul-23 | 18:40 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4322.2 | 112536    | 27-Jul-23 | 18:40 | x64      |
| Msgprox.dll                                                  | 2019.150.4322.2 | 301008    | 27-Jul-23 | 18:40 | x64      |
| Msoledbsql.dll                                               | 2018.186.6.0    | 2729992   | 27-Jul-23 | 18:40 | x64      |
| Msoledbsql.dll                                               | 2018.186.6.0    | 153608    | 27-Jul-23 | 18:40 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4322.2 | 1496984   | 27-Jul-23 | 18:40 | x64      |
| Oledbdest.dll                                                | 2019.150.4322.2 | 280480    | 27-Jul-23 | 18:40 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4322.2 | 313232    | 27-Jul-23 | 18:40 | x64      |
| Osql.exe                                                     | 2019.150.4322.2 | 92056     | 27-Jul-23 | 18:40 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4322.2 | 497552    | 27-Jul-23 | 18:40 | x64      |
| Rawdest.dll                                                  | 2019.150.4322.2 | 227224    | 27-Jul-23 | 18:40 | x64      |
| Rawsource.dll                                                | 2019.150.4322.2 | 210848    | 27-Jul-23 | 18:40 | x64      |
| Rdistcom.dll                                                 | 2019.150.4322.2 | 915408    | 27-Jul-23 | 18:40 | x64      |
| Recordsetdest.dll                                            | 2019.150.4322.2 | 202640    | 27-Jul-23 | 18:40 | x64      |
| Repldp.dll                                                   | 2019.150.4322.2 | 313232    | 27-Jul-23 | 18:40 | x64      |
| Replerrx.dll                                                 | 2019.150.4322.2 | 182224    | 27-Jul-23 | 18:40 | x64      |
| Replisapi.dll                                                | 2019.150.4322.2 | 395200    | 27-Jul-23 | 18:40 | x64      |
| Replmerg.exe                                                 | 2019.150.4322.2 | 563136    | 27-Jul-23 | 18:40 | x64      |
| Replprov.dll                                                 | 2019.150.4322.2 | 862160    | 27-Jul-23 | 18:40 | x64      |
| Replrec.dll                                                  | 2019.150.4322.2 | 1034136   | 27-Jul-23 | 18:40 | x64      |
| Replsub.dll                                                  | 2019.150.4322.2 | 473040    | 27-Jul-23 | 18:40 | x64      |
| Replsync.dll                                                 | 2019.150.4322.2 | 165840    | 27-Jul-23 | 18:40 | x64      |
| Spresolv.dll                                                 | 2019.150.4322.2 | 276416    | 27-Jul-23 | 18:40 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4322.2 | 264128    | 27-Jul-23 | 18:40 | x64      |
| Sqldiag.exe                                                  | 2019.150.4322.2 | 1140632   | 27-Jul-23 | 18:40 | x64      |
| Sqldistx.dll                                                 | 2019.150.4322.2 | 251856    | 27-Jul-23 | 18:40 | x64      |
| Sqllogship.exe                                               | 15.0.4322.2     | 104344    | 27-Jul-23 | 18:40 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4322.2 | 399264    | 27-Jul-23 | 18:40 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4322.2 | 38848     | 27-Jul-23 | 18:40 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4322.2 | 51104     | 27-Jul-23 | 18:40 | x64      |
| Sqlscm.dll                                                   | 2019.150.4322.2 | 79776     | 27-Jul-23 | 18:40 | x86      |
| Sqlscm.dll                                                   | 2019.150.4322.2 | 87960     | 27-Jul-23 | 18:40 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4322.2 | 182208    | 27-Jul-23 | 18:40 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4322.2 | 149392    | 27-Jul-23 | 18:40 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4322.2 | 202656    | 27-Jul-23 | 18:40 | x64      |
| Ssradd.dll                                                   | 2019.150.4322.2 | 83904     | 27-Jul-23 | 18:40 | x64      |
| Ssravg.dll                                                   | 2019.150.4322.2 | 83856     | 27-Jul-23 | 18:40 | x64      |
| Ssrdown.dll                                                  | 2019.150.4322.2 | 75728     | 27-Jul-23 | 18:40 | x64      |
| Ssrmax.dll                                                   | 2019.150.4322.2 | 83920     | 27-Jul-23 | 18:40 | x64      |
| Ssrmin.dll                                                   | 2019.150.4322.2 | 83904     | 27-Jul-23 | 18:40 | x64      |
| Ssrpub.dll                                                   | 2019.150.4322.2 | 79808     | 27-Jul-23 | 18:40 | x64      |
| Ssrup.dll                                                    | 2019.150.4322.2 | 75672     | 27-Jul-23 | 18:40 | x64      |
| Txagg.dll                                                    | 2019.150.4322.2 | 391072    | 27-Jul-23 | 18:40 | x64      |
| Txbdd.dll                                                    | 2019.150.4322.2 | 190360    | 27-Jul-23 | 18:40 | x64      |
| Txdatacollector.dll                                          | 2019.150.4322.2 | 472976    | 27-Jul-23 | 18:40 | x64      |
| Txdataconvert.dll                                            | 2019.150.4322.2 | 317376    | 27-Jul-23 | 18:40 | x64      |
| Txderived.dll                                                | 2019.150.4322.2 | 640960    | 27-Jul-23 | 18:40 | x64      |
| Txlookup.dll                                                 | 2019.150.4322.2 | 542656    | 27-Jul-23 | 18:40 | x64      |
| Txmerge.dll                                                  | 2019.150.4322.2 | 247696    | 27-Jul-23 | 18:40 | x64      |
| Txmergejoin.dll                                              | 2019.150.4322.2 | 309152    | 27-Jul-23 | 18:40 | x64      |
| Txmulticast.dll                                              | 2019.150.4322.2 | 149400    | 27-Jul-23 | 18:40 | x64      |
| Txrowcount.dll                                               | 2019.150.4322.2 | 141216    | 27-Jul-23 | 18:40 | x64      |
| Txsort.dll                                                   | 2019.150.4322.2 | 288664    | 27-Jul-23 | 18:40 | x64      |
| Txsplit.dll                                                  | 2019.150.4322.2 | 624576    | 27-Jul-23 | 18:40 | x64      |
| Txunionall.dll                                               | 2019.150.4322.2 | 198544    | 27-Jul-23 | 18:40 | x64      |
| Xe.dll                                                       | 2019.150.4322.2 | 722880    | 27-Jul-23 | 18:40 | x64      |
| Xmlsub.dll                                                   | 2019.150.4322.2 | 296896    | 27-Jul-23 | 18:40 | x64      |

SQL Server 2019 sql_extensibility

|     File   name    |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4322.2 | 96192     | 27-Jul-23 | 18:40 | x64      |
| Exthost.exe        | 2019.150.4322.2 | 239568    | 27-Jul-23 | 18:40 | x64      |
| Launchpad.exe      | 2019.150.4322.2 | 1230752   | 27-Jul-23 | 18:40 | x64      |
| Sqlsatellite.dll   | 2019.150.4322.2 | 1025984   | 27-Jul-23 | 18:40 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4322.2 | 685976    | 27-Jul-23 | 18:40 | x64      |
| Fdhost.exe     | 2019.150.4322.2 | 128960    | 27-Jul-23 | 18:40 | x64      |
| Fdlauncher.exe | 2019.150.4322.2 | 79808     | 27-Jul-23 | 18:40 | x64      |
| Sqlft150ph.dll | 2019.150.4322.2 | 92096     | 27-Jul-23 | 18:40 | x64      |

SQL Server 2019 sql_inst_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll  | 15.0.4322.2  | 30656     | 27-Jul-23 | 18:40 | x86      |

SQL Server 2019 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4322.2 | 227216    | 27-Jul-23 | 18:46 | x86      |
| Commanddest.dll                                               | 2019.150.4322.2 | 264080    | 27-Jul-23 | 18:46 | x64      |
| Dteparse.dll                                                  | 2019.150.4322.2 | 124816    | 27-Jul-23 | 18:46 | x64      |
| Dteparse.dll                                                  | 2019.150.4322.2 | 112536    | 27-Jul-23 | 18:46 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4322.2 | 116640    | 27-Jul-23 | 18:46 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4322.2 | 133008    | 27-Jul-23 | 18:46 | x64      |
| Dtepkg.dll                                                    | 2019.150.4322.2 | 133024    | 27-Jul-23 | 18:46 | x86      |
| Dtepkg.dll                                                    | 2019.150.4322.2 | 149456    | 27-Jul-23 | 18:46 | x64      |
| Dtexec.exe                                                    | 2019.150.4322.2 | 72640     | 27-Jul-23 | 18:46 | x64      |
| Dtexec.exe                                                    | 2019.150.4322.2 | 63888     | 27-Jul-23 | 18:46 | x86      |
| Dts.dll                                                       | 2019.150.4322.2 | 2881472   | 27-Jul-23 | 18:46 | x86      |
| Dts.dll                                                       | 2019.150.4322.2 | 3143576   | 27-Jul-23 | 18:46 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4322.2 | 444312    | 27-Jul-23 | 18:46 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4322.2 | 501648    | 27-Jul-23 | 18:46 | x64      |
| Dtsconn.dll                                                   | 2019.150.4322.2 | 522128    | 27-Jul-23 | 18:46 | x64      |
| Dtsconn.dll                                                   | 2019.150.4322.2 | 432016    | 27-Jul-23 | 18:46 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4322.2 | 112024    | 27-Jul-23 | 18:46 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4322.2 | 93600     | 27-Jul-23 | 18:46 | x86      |
| Dtshost.exe                                                   | 2019.150.4322.2 | 106384    | 27-Jul-23 | 18:46 | x64      |
| Dtshost.exe                                                   | 2019.150.4322.2 | 88992     | 27-Jul-23 | 18:46 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4322.2 | 554944    | 27-Jul-23 | 18:40 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4322.2 | 567184    | 27-Jul-23 | 18:40 | x64      |
| Dtspipeline.dll                                               | 2019.150.4322.2 | 1120144   | 27-Jul-23 | 18:46 | x86      |
| Dtspipeline.dll                                               | 2019.150.4322.2 | 1329088   | 27-Jul-23 | 18:46 | x64      |
| Dtswizard.exe                                                 | 15.0.4322.2     | 886688    | 27-Jul-23 | 18:46 | x64      |
| Dtswizard.exe                                                 | 15.0.4322.2     | 890816    | 27-Jul-23 | 18:46 | x86      |
| Dtuparse.dll                                                  | 2019.150.4322.2 | 100248    | 27-Jul-23 | 18:46 | x64      |
| Dtuparse.dll                                                  | 2019.150.4322.2 | 87952     | 27-Jul-23 | 18:46 | x86      |
| Dtutil.exe                                                    | 2019.150.4322.2 | 130496    | 27-Jul-23 | 18:46 | x86      |
| Dtutil.exe                                                    | 2019.150.4322.2 | 149456    | 27-Jul-23 | 18:46 | x64      |
| Exceldest.dll                                                 | 2019.150.4322.2 | 280472    | 27-Jul-23 | 18:46 | x64      |
| Exceldest.dll                                                 | 2019.150.4322.2 | 235424    | 27-Jul-23 | 18:46 | x86      |
| Excelsrc.dll                                                  | 2019.150.4322.2 | 309144    | 27-Jul-23 | 18:46 | x64      |
| Excelsrc.dll                                                  | 2019.150.4322.2 | 259984    | 27-Jul-23 | 18:46 | x86      |
| Execpackagetask.dll                                           | 2019.150.4322.2 | 149400    | 27-Jul-23 | 18:46 | x86      |
| Execpackagetask.dll                                           | 2019.150.4322.2 | 186256    | 27-Jul-23 | 18:46 | x64      |
| Flatfiledest.dll                                              | 2019.150.4322.2 | 358296    | 27-Jul-23 | 18:46 | x86      |
| Flatfiledest.dll                                              | 2019.150.4322.2 | 411552    | 27-Jul-23 | 18:46 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4322.2 | 370592    | 27-Jul-23 | 18:46 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4322.2 | 427984    | 27-Jul-23 | 18:46 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4322.2     | 120728    | 27-Jul-23 | 18:46 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4322.2     | 120728    | 27-Jul-23 | 18:46 | x86      |
| Isserverexec.exe                                              | 15.0.4322.2     | 145344    | 27-Jul-23 | 18:46 | x64      |
| Isserverexec.exe                                              | 15.0.4322.2     | 149456    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4322.2     | 116672    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4322.2     | 59296     | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4322.2     | 509888    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4322.2     | 509840    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4322.2     | 42904     | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4322.2     | 391104    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4322.2     | 59296     | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4322.2     | 59328     | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4322.2     | 141248    | 27-Jul-23 | 18:46 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4322.2     | 141248    | 27-Jul-23 | 18:46 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4322.2     | 219088    | 27-Jul-23 | 18:46 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4322.2 | 100248    | 27-Jul-23 | 18:46 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4322.2 | 112536    | 27-Jul-23 | 18:46 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.41  | 10065304  | 27-Jul-23 | 18:40 | x64      |
| Odbcdest.dll                                                  | 2019.150.4322.2 | 370624    | 27-Jul-23 | 18:46 | x64      |
| Odbcdest.dll                                                  | 2019.150.4322.2 | 321440    | 27-Jul-23 | 18:46 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4322.2 | 329632    | 27-Jul-23 | 18:46 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4322.2 | 382880    | 27-Jul-23 | 18:46 | x64      |
| Oledbdest.dll                                                 | 2019.150.4322.2 | 280480    | 27-Jul-23 | 18:46 | x64      |
| Oledbdest.dll                                                 | 2019.150.4322.2 | 239504    | 27-Jul-23 | 18:46 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4322.2 | 313232    | 27-Jul-23 | 18:46 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4322.2 | 264088    | 27-Jul-23 | 18:46 | x86      |
| Rawdest.dll                                                   | 2019.150.4322.2 | 227224    | 27-Jul-23 | 18:46 | x64      |
| Rawdest.dll                                                   | 2019.150.4322.2 | 190352    | 27-Jul-23 | 18:46 | x86      |
| Rawsource.dll                                                 | 2019.150.4322.2 | 210848    | 27-Jul-23 | 18:46 | x64      |
| Rawsource.dll                                                 | 2019.150.4322.2 | 178080    | 27-Jul-23 | 18:46 | x86      |
| Recordsetdest.dll                                             | 2019.150.4322.2 | 173968    | 27-Jul-23 | 18:46 | x86      |
| Recordsetdest.dll                                             | 2019.150.4322.2 | 202640    | 27-Jul-23 | 18:46 | x64      |
| Sqlceip.exe                                                   | 15.0.4322.2     | 292816    | 27-Jul-23 | 18:46 | x86      |
| Sqldest.dll                                                   | 2019.150.4322.2 | 239504    | 27-Jul-23 | 18:46 | x86      |
| Sqldest.dll                                                   | 2019.150.4322.2 | 276368    | 27-Jul-23 | 18:46 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4322.2 | 169872    | 27-Jul-23 | 18:46 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4322.2 | 202656    | 27-Jul-23 | 18:46 | x64      |
| Txagg.dll                                                     | 2019.150.4322.2 | 329624    | 27-Jul-23 | 18:46 | x86      |
| Txagg.dll                                                     | 2019.150.4322.2 | 391072    | 27-Jul-23 | 18:46 | x64      |
| Txbdd.dll                                                     | 2019.150.4322.2 | 153496    | 27-Jul-23 | 18:46 | x86      |
| Txbdd.dll                                                     | 2019.150.4322.2 | 190360    | 27-Jul-23 | 18:46 | x64      |
| Txbestmatch.dll                                               | 2019.150.4322.2 | 546720    | 27-Jul-23 | 18:46 | x86      |
| Txbestmatch.dll                                               | 2019.150.4322.2 | 653248    | 27-Jul-23 | 18:46 | x64      |
| Txcache.dll                                                   | 2019.150.4322.2 | 165784    | 27-Jul-23 | 18:46 | x86      |
| Txcache.dll                                                   | 2019.150.4322.2 | 198552    | 27-Jul-23 | 18:46 | x64      |
| Txcharmap.dll                                                 | 2019.150.4322.2 | 272272    | 27-Jul-23 | 18:46 | x86      |
| Txcharmap.dll                                                 | 2019.150.4322.2 | 313280    | 27-Jul-23 | 18:46 | x64      |
| Txcopymap.dll                                                 | 2019.150.4322.2 | 173976    | 27-Jul-23 | 18:46 | x86      |
| Txcopymap.dll                                                 | 2019.150.4322.2 | 198560    | 27-Jul-23 | 18:46 | x64      |
| Txdataconvert.dll                                             | 2019.150.4322.2 | 276368    | 27-Jul-23 | 18:46 | x86      |
| Txdataconvert.dll                                             | 2019.150.4322.2 | 317376    | 27-Jul-23 | 18:46 | x64      |
| Txderived.dll                                                 | 2019.150.4322.2 | 559040    | 27-Jul-23 | 18:46 | x86      |
| Txderived.dll                                                 | 2019.150.4322.2 | 640960    | 27-Jul-23 | 18:46 | x64      |
| Txfileextractor.dll                                           | 2019.150.4322.2 | 182176    | 27-Jul-23 | 18:46 | x86      |
| Txfileextractor.dll                                           | 2019.150.4322.2 | 219040    | 27-Jul-23 | 18:46 | x64      |
| Txfileinserter.dll                                            | 2019.150.4322.2 | 182176    | 27-Jul-23 | 18:46 | x86      |
| Txfileinserter.dll                                            | 2019.150.4322.2 | 214944    | 27-Jul-23 | 18:46 | x64      |
| Txgroupdups.dll                                               | 2019.150.4322.2 | 255904    | 27-Jul-23 | 18:46 | x86      |
| Txgroupdups.dll                                               | 2019.150.4322.2 | 313240    | 27-Jul-23 | 18:46 | x64      |
| Txlineage.dll                                                 | 2019.150.4322.2 | 128920    | 27-Jul-23 | 18:46 | x86      |
| Txlineage.dll                                                 | 2019.150.4322.2 | 153504    | 27-Jul-23 | 18:46 | x64      |
| Txlookup.dll                                                  | 2019.150.4322.2 | 468880    | 27-Jul-23 | 18:46 | x86      |
| Txlookup.dll                                                  | 2019.150.4322.2 | 542656    | 27-Jul-23 | 18:46 | x64      |
| Txmerge.dll                                                   | 2019.150.4322.2 | 206744    | 27-Jul-23 | 18:46 | x86      |
| Txmerge.dll                                                   | 2019.150.4322.2 | 247696    | 27-Jul-23 | 18:46 | x64      |
| Txmergejoin.dll                                               | 2019.150.4322.2 | 247704    | 27-Jul-23 | 18:46 | x86      |
| Txmergejoin.dll                                               | 2019.150.4322.2 | 309152    | 27-Jul-23 | 18:46 | x64      |
| Txmulticast.dll                                               | 2019.150.4322.2 | 116632    | 27-Jul-23 | 18:46 | x86      |
| Txmulticast.dll                                               | 2019.150.4322.2 | 149400    | 27-Jul-23 | 18:46 | x64      |
| Txpivot.dll                                                   | 2019.150.4322.2 | 206744    | 27-Jul-23 | 18:46 | x86      |
| Txpivot.dll                                                   | 2019.150.4322.2 | 239512    | 27-Jul-23 | 18:46 | x64      |
| Txrowcount.dll                                                | 2019.150.4322.2 | 112544    | 27-Jul-23 | 18:46 | x86      |
| Txrowcount.dll                                                | 2019.150.4322.2 | 141216    | 27-Jul-23 | 18:46 | x64      |
| Txsampling.dll                                                | 2019.150.4322.2 | 157600    | 27-Jul-23 | 18:46 | x86      |
| Txsampling.dll                                                | 2019.150.4322.2 | 194448    | 27-Jul-23 | 18:46 | x64      |
| Txscd.dll                                                     | 2019.150.4322.2 | 198560    | 27-Jul-23 | 18:46 | x86      |
| Txscd.dll                                                     | 2019.150.4322.2 | 235424    | 27-Jul-23 | 18:46 | x64      |
| Txsort.dll                                                    | 2019.150.4322.2 | 231320    | 27-Jul-23 | 18:46 | x86      |
| Txsort.dll                                                    | 2019.150.4322.2 | 288664    | 27-Jul-23 | 18:46 | x64      |
| Txsplit.dll                                                   | 2019.150.4322.2 | 550800    | 27-Jul-23 | 18:46 | x86      |
| Txsplit.dll                                                   | 2019.150.4322.2 | 624576    | 27-Jul-23 | 18:46 | x64      |
| Txtermextraction.dll                                          | 2019.150.4322.2 | 8644560   | 27-Jul-23 | 18:46 | x86      |
| Txtermextraction.dll                                          | 2019.150.4322.2 | 8701888   | 27-Jul-23 | 18:46 | x64      |
| Txtermlookup.dll                                              | 2019.150.4322.2 | 4138904   | 27-Jul-23 | 18:46 | x86      |
| Txtermlookup.dll                                              | 2019.150.4322.2 | 4184000   | 27-Jul-23 | 18:46 | x64      |
| Txunionall.dll                                                | 2019.150.4322.2 | 161696    | 27-Jul-23 | 18:46 | x86      |
| Txunionall.dll                                                | 2019.150.4322.2 | 198544    | 27-Jul-23 | 18:46 | x64      |
| Txunpivot.dll                                                 | 2019.150.4322.2 | 182168    | 27-Jul-23 | 18:46 | x86      |
| Txunpivot.dll                                                 | 2019.150.4322.2 | 214928    | 27-Jul-23 | 18:46 | x64      |
| Xe.dll                                                        | 2019.150.4322.2 | 632768    | 27-Jul-23 | 18:46 | x86      |
| Xe.dll                                                        | 2019.150.4322.2 | 722880    | 27-Jul-23 | 18:46 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1964.0     | 559536    | 27-Jul-23 | 19:22 | x86      |
| Dmsnative.dll                                                        | 2018.150.1964.0 | 152496    | 27-Jul-23 | 19:22 | x64      |
| Dwengineservice.dll                                                  | 15.0.1964.0     | 45016     | 27-Jul-23 | 19:22 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 27-Jul-23 | 19:22 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 27-Jul-23 | 19:22 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 27-Jul-23 | 19:22 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 27-Jul-23 | 19:22 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 27-Jul-23 | 19:22 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 27-Jul-23 | 19:22 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 27-Jul-23 | 19:22 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 27-Jul-23 | 19:22 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 27-Jul-23 | 19:22 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 27-Jul-23 | 19:22 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 27-Jul-23 | 19:22 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 27-Jul-23 | 19:22 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 27-Jul-23 | 19:22 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 27-Jul-23 | 19:22 | x64      |
| Instapi150.dll                                                       | 2019.150.4322.2 | 87960     | 27-Jul-23 | 19:22 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 27-Jul-23 | 19:22 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 27-Jul-23 | 19:22 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 27-Jul-23 | 19:22 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 27-Jul-23 | 19:22 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 27-Jul-23 | 19:22 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 27-Jul-23 | 19:22 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 27-Jul-23 | 19:22 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 27-Jul-23 | 19:22 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 27-Jul-23 | 19:22 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 27-Jul-23 | 19:22 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1964.0     | 67544     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1964.0     | 293328    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1964.0     | 1957848   | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1964.0     | 169392    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1964.0     | 649648    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1964.0     | 246192    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1964.0     | 139184    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1964.0     | 79776     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1964.0     | 51104     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1964.0     | 88496     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1964.0     | 1129392   | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1964.0     | 80816     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1964.0     | 70616     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1964.0     | 35248     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1964.0     | 31192     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1964.0     | 46552     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1964.0     | 21448     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1964.0     | 26528     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1964.0     | 131536    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1964.0     | 86488     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1964.0     | 100824    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1964.0     | 293328    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 120240    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 138160    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 141232    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 137680    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 150448    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 139696    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 134608    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 176600    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 117664    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 136656    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1964.0     | 72664     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1964.0     | 21936     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1964.0     | 37280     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1964.0     | 128928    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1964.0     | 3064752   | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1964.0     | 3955672   | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 118232    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133024    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 137688    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133584    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 148440    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 134088    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 130464    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 170912    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 115144    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 132056    | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1964.0     | 67544     | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1964.0     | 2682800   | 27-Jul-23 | 19:22 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1964.0     | 2436568   | 27-Jul-23 | 19:22 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4322.2 | 452544    | 27-Jul-23 | 19:22 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4322.2 | 7403472   | 27-Jul-23 | 19:22 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 27-Jul-23 | 19:22 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 27-Jul-23 | 19:22 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 27-Jul-23 | 19:22 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 27-Jul-23 | 19:22 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 27-Jul-23 | 19:22 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 27-Jul-23 | 19:22 | x64      |
| Secforwarder.dll                                                     | 2019.150.4322.2 | 79760     | 27-Jul-23 | 19:22 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1964.0 | 61400     | 27-Jul-23 | 19:22 | x64      |
| Sqldk.dll                                                            | 2019.150.4322.2 | 3180480   | 27-Jul-23 | 19:22 | x64      |
| Sqldumper.exe                                                        | 2019.150.4322.2 | 186304    | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 1595296   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 4171672   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 3418008   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 4163480   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 4069272   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 2226072   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 2172816   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 3827616   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 3823552   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 1537936   | 27-Jul-23 | 19:22 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4322.2 | 4036496   | 27-Jul-23 | 19:22 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 27-Jul-23 | 19:22 | x64      |
| Sqlos.dll                                                            | 2019.150.4322.2 | 42944     | 27-Jul-23 | 19:22 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1964.0 | 4841432   | 27-Jul-23 | 19:22 | x64      |
| Sqltses.dll                                                          | 2019.150.4322.2 | 9119648   | 27-Jul-23 | 19:22 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 27-Jul-23 | 19:22 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 27-Jul-23 | 19:22 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 27-Jul-23 | 19:22 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 27-Jul-23 | 19:22 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 27-Jul-23 | 19:22 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 27-Jul-23 | 19:22 | x64      |

SQL Server 2019 sql_shared_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll  | 15.0.4322.2  | 30616     | 27-Jul-23 | 18:40 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File   name                         |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4322.2 | 1632152   | 27-Jul-23 | 19:12 | x86      |
| Dtaengine.exe                                                | 2019.150.4322.2 | 219032    | 27-Jul-23 | 19:12 | x86      |
| Dteparse.dll                                                 | 2019.150.4322.2 | 112536    | 27-Jul-23 | 19:12 | x86      |
| Dteparse.dll                                                 | 2019.150.4322.2 | 124816    | 27-Jul-23 | 19:12 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4322.2 | 116640    | 27-Jul-23 | 19:12 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4322.2 | 133008    | 27-Jul-23 | 19:12 | x64      |
| Dtepkg.dll                                                   | 2019.150.4322.2 | 133024    | 27-Jul-23 | 19:12 | x86      |
| Dtepkg.dll                                                   | 2019.150.4322.2 | 149456    | 27-Jul-23 | 19:12 | x64      |
| Dtexec.exe                                                   | 2019.150.4322.2 | 63888     | 27-Jul-23 | 19:12 | x86      |
| Dtexec.exe                                                   | 2019.150.4322.2 | 72640     | 27-Jul-23 | 19:12 | x64      |
| Dts.dll                                                      | 2019.150.4322.2 | 2881472   | 27-Jul-23 | 19:12 | x86      |
| Dts.dll                                                      | 2019.150.4322.2 | 3143576   | 27-Jul-23 | 19:12 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4322.2 | 444312    | 27-Jul-23 | 19:12 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4322.2 | 501648    | 27-Jul-23 | 19:12 | x64      |
| Dtsconn.dll                                                  | 2019.150.4322.2 | 432016    | 27-Jul-23 | 19:12 | x86      |
| Dtsconn.dll                                                  | 2019.150.4322.2 | 522128    | 27-Jul-23 | 19:12 | x64      |
| Dtshost.exe                                                  | 2019.150.4322.2 | 106384    | 27-Jul-23 | 19:12 | x64      |
| Dtshost.exe                                                  | 2019.150.4322.2 | 88992     | 27-Jul-23 | 19:12 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4322.2 | 554944    | 27-Jul-23 | 19:12 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4322.2 | 567184    | 27-Jul-23 | 19:12 | x64      |
| Dtspipeline.dll                                              | 2019.150.4322.2 | 1120144   | 27-Jul-23 | 19:12 | x86      |
| Dtspipeline.dll                                              | 2019.150.4322.2 | 1329088   | 27-Jul-23 | 19:12 | x64      |
| Dtswizard.exe                                                | 15.0.4322.2     | 886688    | 27-Jul-23 | 19:12 | x64      |
| Dtswizard.exe                                                | 15.0.4322.2     | 890816    | 27-Jul-23 | 19:12 | x86      |
| Dtuparse.dll                                                 | 2019.150.4322.2 | 100248    | 27-Jul-23 | 19:12 | x64      |
| Dtuparse.dll                                                 | 2019.150.4322.2 | 87952     | 27-Jul-23 | 19:12 | x86      |
| Dtutil.exe                                                   | 2019.150.4322.2 | 130496    | 27-Jul-23 | 19:12 | x86      |
| Dtutil.exe                                                   | 2019.150.4322.2 | 149456    | 27-Jul-23 | 19:12 | x64      |
| Exceldest.dll                                                | 2019.150.4322.2 | 235424    | 27-Jul-23 | 19:12 | x86      |
| Exceldest.dll                                                | 2019.150.4322.2 | 280472    | 27-Jul-23 | 19:12 | x64      |
| Excelsrc.dll                                                 | 2019.150.4322.2 | 259984    | 27-Jul-23 | 19:12 | x86      |
| Excelsrc.dll                                                 | 2019.150.4322.2 | 309144    | 27-Jul-23 | 19:12 | x64      |
| Flatfiledest.dll                                             | 2019.150.4322.2 | 358296    | 27-Jul-23 | 19:12 | x86      |
| Flatfiledest.dll                                             | 2019.150.4322.2 | 411552    | 27-Jul-23 | 19:12 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4322.2 | 370592    | 27-Jul-23 | 19:12 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4322.2 | 427984    | 27-Jul-23 | 19:12 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4322.2     | 116624    | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4322.2     | 403344    | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4322.2     | 403360    | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4322.2     | 3004304   | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4322.2     | 3004312   | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4322.2     | 42904     | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4322.2     | 59328     | 27-Jul-23 | 19:12 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 27-Jul-23 | 19:12 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4322.2 | 100248    | 27-Jul-23 | 19:12 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4322.2 | 112536    | 27-Jul-23 | 19:12 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.41  | 8281032   | 27-Jul-23 | 18:40 | x86      |
| Oledbdest.dll                                                | 2019.150.4322.2 | 239504    | 27-Jul-23 | 19:12 | x86      |
| Oledbdest.dll                                                | 2019.150.4322.2 | 280480    | 27-Jul-23 | 19:12 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4322.2 | 313232    | 27-Jul-23 | 19:12 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4322.2 | 264088    | 27-Jul-23 | 19:12 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4322.2 | 51104     | 27-Jul-23 | 19:12 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4322.2 | 38848     | 27-Jul-23 | 19:12 | x86      |
| Sqlscm.dll                                                   | 2019.150.4322.2 | 79776     | 27-Jul-23 | 19:12 | x86      |
| Sqlscm.dll                                                   | 2019.150.4322.2 | 87960     | 27-Jul-23 | 19:12 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4322.2 | 149392    | 27-Jul-23 | 19:12 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4322.2 | 182208    | 27-Jul-23 | 19:12 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4322.2 | 169872    | 27-Jul-23 | 19:12 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4322.2 | 202656    | 27-Jul-23 | 19:12 | x64      |
| Txdataconvert.dll                                            | 2019.150.4322.2 | 276368    | 27-Jul-23 | 19:12 | x86      |
| Txdataconvert.dll                                            | 2019.150.4322.2 | 317376    | 27-Jul-23 | 19:12 | x64      |
| Xe.dll                                                       | 2019.150.4322.2 | 632768    | 27-Jul-23 | 19:12 | x86      |
| Xe.dll                                                       | 2019.150.4322.2 | 722880    | 27-Jul-23 | 19:12 | x64      |

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
