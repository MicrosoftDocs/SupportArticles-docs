---
title: Cumulative update 24 for SQL Server 2019 (KB5031908)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 24 (KB5031908).
ms.date: 01/29/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5031908
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5031908 - Cumulative Update 24 for SQL Server 2019

_Release Date:_ &nbsp; December 14, 2023  
_Version:_ &nbsp; 15.0.4345.5

## Summary

This article describes Cumulative Update package 24 (CU24) for Microsoft SQL Server 2019. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 23, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4345.5**, file version: **2019.150.4345.5**
- Analysis Services - Product version: **15.0.35.41**, file version: **2018.150.35.41**

## Known issues in this update

### Issue one: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

### Issue two: Read-scale availability group not displayed in dm_hadr_database_replica_cluster_states

SQL Server 2019 CU24 introduced [fix 2714260](#2714260), which causes an issue with `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups that results in the **Availability Databases** folder in SQL Server Management Studio (SSMS) not showing the databases in the availability group (AG). To mitigate this issue, roll back the patch to CU23.

Microsoft is working on a fix for this issue and it will be available in a future CU.

This issue is fixed in [SQL Server 2019 CU25](cumulativeupdate25.md#2926845).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area | Component | Platform |
|-----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2795899>[2795899](#2795899) </a> | Fixes an issue in which the **Find Parent** feature fails if the target of the feature is a node that is searched. | Master Data Services | Master Data Services| Windows|
| <a id=2802020>[2802020](#2802020) </a> | Fixes an issue in which downloading an attachment fails if an entity newly created uses a code value existing in a deletion record.| Master Data Services | Master Data Services| Windows|
| <a id=2714260>[2714260](#2714260) </a> | Fixes unexpected characters that you encounter in the `name` column of the `sys.availability_groups_cluster` dynamic management view (DMV) when you use the read-scale availability group. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=2763676>[2763676](#2763676) </a> | Fixes an issue in which running `sys.dm_db_xtp_transactions` might fail with the following error if a large number of transactions are in the In-Memory OLTP database engine: </br></br>Msg 701, Level 17, State 157, Line \<LineNumber> </br>There is insufficient system memory in resource pool 'default' to run this query.| SQL Server Engine| In-Memory OLTP| All|
| <a id=2672219>[2672219](#2672219) </a> | Fixes an issue in which overriding the `MakeGenerationInterval` parameter that uses a custom value doesn't work properly when you run *replmerg.exe*.| SQL Server Engine| Replication | Windows|
| <a id=2814458>[2814458](#2814458) </a> | Fixes an issue in which the distribution agent fails when you set up transactional replication with memory-optimized tables at the Subscriber that has the "replication support only" option. Additionally, you receive the following error message: </br></br>MSupd_articlename stored procedure fails with error 12302 when the subscription is created with @sync_type = "replication support only".| SQL Server Engine| Replication | Windows|
| <a id=2783439>[2783439](#2783439) </a> | Consider the following scenario: </br></br>- You create a table that has a full-text index. </br>- The full-text index fragment is partitioned because it's too large. </br>- You clone the database and then run `DBCC CHECKDB` to check the clone database. </br></br>In this scenario, the command fails and the following error 2601 occurs: </br></br>Msg 2601, Level 14, State 1, Line \<LineNumber> </br>Cannot insert duplicate key row in object '\<ObjectName>' with unique index '\<IndexName>'. The duplicate key value is \<KeyValue>.| SQL Server Engine| Search| All|
| <a id=2736124>[2736124](#2736124) </a> | Adds additional telemetry to the security caches to improve the debuggability. | SQL Server Engine| Security Infrastructure | All|
| <a id=2789529>[2789529](#2789529) </a> | Fixes the following error 9833 that you encounter when running the `sp_helplogins` stored procedure against a database with UTF-8 character encoding: </br></br>Msg 9833, Level 16, State 2, Procedure sp_helplogins, Line \<LineNumber> [Batch State Line 0] </br>Invalid data for UTF8-encoded characters | SQL Server Engine| Security Infrastructure | All|
| <a id=2606385>[2606385](#2606385) </a> | Updates the errors 1101 and 1105 to explicitly reflect the fact that even `UNLIMITED` database files are limited to 16 TB. </br></br>Error message: </br></br>1101: Could not allocate a new page for database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full due to lack of storage space or database files reaching the maximum allowed size. Note that UNLIMITED files are still limited to 16TB. Create the necessary space by dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. </br></br>1105: Could not allocate space for object '\<ObjectName>' in database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full due to lack of storage space or database files reaching the maximum allowed size. Note that UNLIMITED files are still limited to 16TB. Create the necessary space by dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. | SQL Server Engine| Storage Management| All|
| <a id=2726326>[2726326](#2726326) </a> | Fixes an assertion failure (Location: "cxrowset.cpp":2006; Expression: cstePrefix >= 1) that you encounter when updating statistics fails with the following error: </br></br>Msg 3624, Level 20, State 1, Line \<LineNumber> </br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. | SQL Server Engine| Table Index Partition | All|
| <a id=2724959>[2724959](#2724959) </a> | Fixes an issue in which the setup might fail to add the `SQL_SNAC_SDK` feature when you install SQL Server if the machine has a later version of the `SQL_SNAC_CORE` feature in *msoledbsql.msi* installed than that of the SQL Server installation media. After applying the fix, SQL Server Setup detects this condition, and it will block a new installation and prevent a failure during the installation. </br></br>**Note**: To work around this issue and unblock SQL Server Setup, go to **Uninstall or change a program** in the Control Panel, select **Microsoft OLE DB Driver for SQL Server**, and then select **Change** to install all features in **Microsoft OLE DB Driver for SQL Server Setup**. Rerun SQL Server Setup when it's finished.| SQL Setup| Deployment Platform | Windows|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU24 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5031908)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5031908-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5031908-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5031908-x64.exe| DA3FAC3717A28C3307EBB762E0607959D1E1300E028EDD4E35BA59AA4FA97599 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |   Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.41  | 292760    | 04-Dec-2023 | 15:17 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.41      | 758168    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 175560    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 199624    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 202184    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 198600    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 214936    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197576    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 193480    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 252360    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 174024    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197064    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.41      | 1098648   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.41      | 567240    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 54728     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59336     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59840     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58776     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 61896     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58312     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 67528     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 53656     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 18888     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 04-Dec-2023 | 15:17 | x86      |
| Msmdctr.dll                                               | 2018.150.35.41  | 38296     | 04-Dec-2023 | 15:17 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 66299800  | 04-Dec-2023 | 15:17 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 47788440  | 04-Dec-2023 | 15:17 | x86      |
| Msmdpump.dll                                              | 2018.150.35.41  | 10189768  | 04-Dec-2023 | 15:17 | x64      |
| Msmdredir.dll                                             | 2018.150.35.41  | 7957912   | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 18328     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 04-Dec-2023 | 15:17 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 04-Dec-2023 | 15:17 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.41  | 65837512  | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 833432    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1628056   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1453976   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1642904   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1608600   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1001368   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 992664    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1536920   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1521560   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 810904    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1596312   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 832408    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1624472   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1450904   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1637784   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1604504   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 998808    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 991128    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1532824   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1517976   | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 809880    | 04-Dec-2023 | 15:17 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1591704   | 04-Dec-2023 | 15:17 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 10187160  | 04-Dec-2023 | 15:17 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 8281032   | 04-Dec-2023 | 15:17 | x86      |
| Msolap.dll                                                | 2018.150.35.41  | 11017160  | 04-Dec-2023 | 15:17 | x64      |
| Msolap.dll                                                | 2018.150.35.41  | 8609176   | 04-Dec-2023 | 15:17 | x86      |
| Msolui.dll                                                | 2018.150.35.41  | 306584    | 04-Dec-2023 | 15:17 | x64      |
| Msolui.dll                                                | 2018.150.35.41  | 286104    | 04-Dec-2023 | 15:17 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 04-Dec-2023 | 15:17 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 04-Dec-2023 | 15:17 | x64      |
| Sqlboot.dll                                               | 2019.150.4345.5 | 215080    | 04-Dec-2023 | 15:17 | x64      |
| Sqlceip.exe                                               | 15.0.4345.5     | 297000    | 04-Dec-2023 | 15:17 | x86      |
| Sqldumper.exe                                             | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:17 | x86      |
| Sqldumper.exe                                             | 2019.150.4345.5 | 366632    | 04-Dec-2023 | 15:17 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 04-Dec-2023 | 15:17 | x86      |
| Tmapi.dll                                                 | 2018.150.35.41  | 6178200   | 04-Dec-2023 | 15:17 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.41  | 4917704   | 04-Dec-2023 | 15:17 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.41  | 1184664   | 04-Dec-2023 | 15:17 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.41  | 6806936   | 04-Dec-2023 | 15:17 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 26026440  | 04-Dec-2023 | 15:17 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 35460504  | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4345.5 | 165928    | 04-Dec-2023 | 15:21 | x86      |
| Batchparser.dll                      | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:21 | x64      |
| Instapi150.dll                       | 2019.150.4345.5 | 75816     | 04-Dec-2023 | 15:21 | x86      |
| Instapi150.dll                       | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:21 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4345.5 | 104488    | 04-Dec-2023 | 15:21 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:21 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4345.5     | 550952    | 04-Dec-2023 | 15:21 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 27032     | 04-Dec-2023 | 15:17 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 32152     | 04-Dec-2023 | 15:17 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4345.5 | 75816     | 04-Dec-2023 | 15:21 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 15:21 | x64      |
| Sqldumper.exe                        | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:21 | x86      |
| Sqldumper.exe                        | 2019.150.4345.5 | 366632    | 04-Dec-2023 | 15:21 | x64      |
| Sqlftacct.dll                        | 2019.150.4345.5 | 59432     | 04-Dec-2023 | 15:21 | x86      |
| Sqlftacct.dll                        | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 15:21 | x64      |
| Sqlmanager.dll                       | 2019.150.4345.5 | 743464    | 04-Dec-2023 | 15:21 | x86      |
| Sqlmanager.dll                       | 2019.150.4345.5 | 878632    | 04-Dec-2023 | 15:21 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4345.5 | 378920    | 04-Dec-2023 | 15:21 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4345.5 | 432168    | 04-Dec-2023 | 15:21 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4345.5 | 276520    | 04-Dec-2023 | 15:21 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4345.5 | 358440    | 04-Dec-2023 | 15:21 | x64      |
| Svrenumapi150.dll                    | 2019.150.4345.5 | 1161256   | 04-Dec-2023 | 15:21 | x64      |
| Svrenumapi150.dll                    | 2019.150.4345.5 | 911400    | 04-Dec-2023 | 15:21 | x86      |

SQL Server 2019 Data Quality

|        File   name        | File version | File size |   Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4345.5  | 600104    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4345.5  | 600104    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4345.5  | 1857576   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4345.5  | 1857576   | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4345.5 | 137256    | 04-Dec-2023 | 15:17 | x86      |
| Dreplaycommon.dll     | 2019.150.4345.5 | 667688    | 04-Dec-2023 | 15:17 | x86      |
| Dreplayutil.dll       | 2019.150.4345.5 | 305192    | 04-Dec-2023 | 15:17 | x86      |
| Instapi150.dll        | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:17 | x64      |
| Sqlresourceloader.dll | 2019.150.4345.5 | 38952     | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 sql_dreplay_controller

|      File   name      |   File version  | File size |   Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4345.5 | 667688    | 04-Dec-2023 | 15:18 | x86      |
| Dreplaycontroller.exe | 2019.150.4345.5 | 366632    | 04-Dec-2023 | 15:18 | x86      |
| Instapi150.dll        | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:17 | x64      |
| Sqlresourceloader.dll | 2019.150.4345.5 | 38952     | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 Database Services Core Instance

|                 File   name                |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4345.5 | 4658216   | 04-Dec-2023 | 16:19 | x64      |
| Aetm-enclave.dll                           | 2019.150.4345.5 | 4612640   | 04-Dec-2023 | 16:19 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4345.5 | 4932520   | 04-Dec-2023 | 16:19 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4345.5 | 4873136   | 04-Dec-2023 | 16:19 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 04-Dec-2023 | 15:18 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 04-Dec-2023 | 15:18 | x64      |
| Batchparser.dll                            | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 16:19 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 04-Dec-2023 | 16:19 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 04-Dec-2023 | 16:19 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 04-Dec-2023 | 16:19 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 04-Dec-2023 | 16:19 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 16:19 | x64      |
| Dcexec.exe                                 | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:19 | x64      |
| Fssres.dll                                 | 2019.150.4345.5 | 96296     | 04-Dec-2023 | 16:19 | x64      |
| Hadrres.dll                                | 2019.150.4345.5 | 206888    | 04-Dec-2023 | 16:19 | x64      |
| Hkcompile.dll                              | 2019.150.4345.5 | 1292328   | 04-Dec-2023 | 16:19 | x64      |
| Hkengine.dll                               | 2019.150.4345.5 | 5793832   | 04-Dec-2023 | 16:19 | x64      |
| Hkruntime.dll                              | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 16:19 | x64      |
| Hktempdb.dll                               | 2019.150.4345.5 | 63528     | 04-Dec-2023 | 16:19 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 04-Dec-2023 | 16:19 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4345.5     | 235560    | 04-Dec-2023 | 16:19 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4345.5 | 391208    | 04-Dec-2023 | 16:19 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4345.5 | 325672    | 04-Dec-2023 | 16:19 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 16:19 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 04-Dec-2023 | 16:19 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 04-Dec-2023 | 16:19 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 04-Dec-2023 | 16:19 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 04-Dec-2023 | 16:19 | x64      |
| Qds.dll                                    | 2019.150.4345.5 | 1189928   | 04-Dec-2023 | 16:19 | x64      |
| Rsfxft.dll                                 | 2019.150.4345.5 | 51240     | 04-Dec-2023 | 16:19 | x64      |
| Secforwarder.dll                           | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 16:19 | x64      |
| Sqagtres.dll                               | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:19 | x64      |
| Sqlaamss.dll                               | 2019.150.4345.5 | 108584    | 04-Dec-2023 | 16:19 | x64      |
| Sqlaccess.dll                              | 2019.150.4345.5 | 493608    | 04-Dec-2023 | 16:19 | x64      |
| Sqlagent.exe                               | 2019.150.4345.5 | 731176    | 04-Dec-2023 | 16:19 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4345.5 | 71720     | 04-Dec-2023 | 16:19 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 16:19 | x64      |
| Sqlboot.dll                                | 2019.150.4345.5 | 215080    | 04-Dec-2023 | 16:19 | x64      |
| Sqlceip.exe                                | 15.0.4345.5     | 297000    | 04-Dec-2023 | 16:19 | x86      |
| Sqlcmdss.dll                               | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:19 | x64      |
| Sqlctr150.dll                              | 2019.150.4345.5 | 145448    | 04-Dec-2023 | 16:19 | x64      |
| Sqlctr150.dll                              | 2019.150.4345.5 | 116776    | 04-Dec-2023 | 16:19 | x86      |
| Sqldk.dll                                  | 2019.150.4345.5 | 3180584   | 04-Dec-2023 | 16:19 | x64      |
| Sqldtsss.dll                               | 2019.150.4345.5 | 108584    | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 1599528   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3508264   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3704872   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4171816   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4286504   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3418152   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3586088   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4163624   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4016168   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4069416   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 2226216   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 2177064   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3876904   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3549224   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4024360   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3827752   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3823656   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3618856   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3508264   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 1542184   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 3913768   | 04-Dec-2023 | 16:19 | x64      |
| Sqlevn70.rll                               | 2019.150.4345.5 | 4036648   | 04-Dec-2023 | 16:19 | x64      |
| Sqllang.dll                                | 2019.150.4345.5 | 40036392  | 04-Dec-2023 | 16:19 | x64      |
| Sqlmin.dll                                 | 2019.150.4345.5 | 40631848  | 04-Dec-2023 | 16:19 | x64      |
| Sqlolapss.dll                              | 2019.150.4345.5 | 108584    | 04-Dec-2023 | 16:19 | x64      |
| Sqlos.dll                                  | 2019.150.4345.5 | 43048     | 04-Dec-2023 | 16:19 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4345.5 | 84008     | 04-Dec-2023 | 16:19 | x64      |
| Sqlrepss.dll                               | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:19 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4345.5 | 51240     | 04-Dec-2023 | 16:19 | x64      |
| Sqlscm.dll                                 | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:19 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4345.5 | 38952     | 04-Dec-2023 | 16:19 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4345.5 | 5806120   | 04-Dec-2023 | 16:19 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4345.5 | 673832    | 04-Dec-2023 | 16:19 | x64      |
| Sqlservr.exe                               | 2019.150.4345.5 | 628776    | 04-Dec-2023 | 16:19 | x64      |
| Sqlsvc.dll                                 | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 16:19 | x64      |
| Sqltses.dll                                | 2019.150.4345.5 | 9119784   | 04-Dec-2023 | 16:19 | x64      |
| Sqsrvres.dll                               | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 16:19 | x64      |
| Stretchcodegen.exe                         | 15.0.4345.5     | 59432     | 04-Dec-2023 | 16:19 | x86      |
| Svl.dll                                    | 2019.150.4345.5 | 161832    | 04-Dec-2023 | 16:19 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 04-Dec-2023 | 16:19 | x64      |
| Xe.dll                                     | 2019.150.4345.5 | 722984    | 04-Dec-2023 | 16:19 | x64      |
| Xpadsi.exe                                 | 2019.150.4345.5 | 116776    | 04-Dec-2023 | 16:19 | x64      |
| Xplog70.dll                                | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 16:19 | x64      |
| Xpqueue.dll                                | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 16:19 | x64      |
| Xprepl.dll                                 | 2019.150.4345.5 | 120872    | 04-Dec-2023 | 16:19 | x64      |
| Xpstar.dll                                 | 2019.150.4345.5 | 473128    | 04-Dec-2023 | 16:19 | x64      |

SQL Server 2019 Database Services Core Shared

|                          File   name                         |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:17 | x64      |
| Batchparser.dll                                              | 2019.150.4345.5 | 165928    | 04-Dec-2023 | 15:17 | x86      |
| Commanddest.dll                                              | 2019.150.4345.5 | 264232    | 04-Dec-2023 | 15:17 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4345.5 | 227368    | 04-Dec-2023 | 15:17 | x64      |
| Distrib.exe                                                  | 2019.150.4345.5 | 243752    | 04-Dec-2023 | 15:17 | x64      |
| Dteparse.dll                                                 | 2019.150.4345.5 | 124968    | 04-Dec-2023 | 15:17 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4345.5 | 133160    | 04-Dec-2023 | 15:17 | x64      |
| Dtepkg.dll                                                   | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:17 | x64      |
| Dtexec.exe                                                   | 2019.150.4345.5 | 73768     | 04-Dec-2023 | 15:17 | x64      |
| Dts.dll                                                      | 2019.150.4345.5 | 3143720   | 04-Dec-2023 | 15:17 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4345.5 | 501800    | 04-Dec-2023 | 15:17 | x64      |
| Dtsconn.dll                                                  | 2019.150.4345.5 | 522280    | 04-Dec-2023 | 15:17 | x64      |
| Dtshost.exe                                                  | 2019.150.4345.5 | 107560    | 04-Dec-2023 | 15:17 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4345.5 | 567336    | 04-Dec-2023 | 15:17 | x64      |
| Dtspipeline.dll                                              | 2019.150.4345.5 | 1329192   | 04-Dec-2023 | 15:17 | x64      |
| Dtswizard.exe                                                | 15.0.4345.5     | 886824    | 04-Dec-2023 | 15:17 | x64      |
| Dtuparse.dll                                                 | 2019.150.4345.5 | 100392    | 04-Dec-2023 | 15:17 | x64      |
| Dtutil.exe                                                   | 2019.150.4345.5 | 151080    | 04-Dec-2023 | 15:17 | x64      |
| Exceldest.dll                                                | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:17 | x64      |
| Excelsrc.dll                                                 | 2019.150.4345.5 | 309288    | 04-Dec-2023 | 15:17 | x64      |
| Execpackagetask.dll                                          | 2019.150.4345.5 | 186408    | 04-Dec-2023 | 15:17 | x64      |
| Flatfiledest.dll                                             | 2019.150.4345.5 | 411688    | 04-Dec-2023 | 15:17 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4345.5 | 428072    | 04-Dec-2023 | 15:17 | x64      |
| Logread.exe                                                  | 2019.150.4345.5 | 722984    | 04-Dec-2023 | 15:17 | x64      |
| Mergetxt.dll                                                 | 2019.150.4345.5 | 75816     | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4345.5     | 59432     | 04-Dec-2023 | 15:08 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4345.5     | 43048     | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4345.5     | 391208    | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4345.5 | 1697832   | 04-Dec-2023 | 15:17 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4345.5 | 1640488   | 04-Dec-2023 | 15:17 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4345.5     | 550952    | 04-Dec-2023 | 15:17 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4345.5 | 112680    | 04-Dec-2023 | 15:17 | x64      |
| Msgprox.dll                                                  | 2019.150.4345.5 | 301096    | 04-Dec-2023 | 15:17 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 2729960   | 04-Dec-2023 | 15:17 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 153560    | 04-Dec-2023 | 15:17 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4345.5 | 1497128   | 04-Dec-2023 | 15:17 | x64      |
| Oledbdest.dll                                                | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:17 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:17 | x64      |
| Osql.exe                                                     | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 15:17 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4345.5 | 501800    | 04-Dec-2023 | 15:17 | x64      |
| Rawdest.dll                                                  | 2019.150.4345.5 | 227368    | 04-Dec-2023 | 15:17 | x64      |
| Rawsource.dll                                                | 2019.150.4345.5 | 210984    | 04-Dec-2023 | 15:17 | x64      |
| Rdistcom.dll                                                 | 2019.150.4345.5 | 915496    | 04-Dec-2023 | 15:17 | x64      |
| Recordsetdest.dll                                            | 2019.150.4345.5 | 202792    | 04-Dec-2023 | 15:17 | x64      |
| Repldp.dll                                                   | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:17 | x64      |
| Replerrx.dll                                                 | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:17 | x64      |
| Replisapi.dll                                                | 2019.150.4345.5 | 395304    | 04-Dec-2023 | 15:17 | x64      |
| Replmerg.exe                                                 | 2019.150.4345.5 | 563240    | 04-Dec-2023 | 15:17 | x64      |
| Replprov.dll                                                 | 2019.150.4345.5 | 862248    | 04-Dec-2023 | 15:17 | x64      |
| Replrec.dll                                                  | 2019.150.4345.5 | 1034280   | 04-Dec-2023 | 15:17 | x64      |
| Replsub.dll                                                  | 2019.150.4345.5 | 473128    | 04-Dec-2023 | 15:17 | x64      |
| Replsync.dll                                                 | 2019.150.4345.5 | 165928    | 04-Dec-2023 | 15:17 | x64      |
| Spresolv.dll                                                 | 2019.150.4345.5 | 276520    | 04-Dec-2023 | 15:17 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4345.5 | 264232    | 04-Dec-2023 | 15:17 | x64      |
| Sqldiag.exe                                                  | 2019.150.4345.5 | 1140776   | 04-Dec-2023 | 15:17 | x64      |
| Sqldistx.dll                                                 | 2019.150.4345.5 | 251944    | 04-Dec-2023 | 15:17 | x64      |
| Sqllogship.exe                                               | 15.0.4345.5     | 104488    | 04-Dec-2023 | 15:17 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4345.5 | 399400    | 04-Dec-2023 | 15:17 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4345.5 | 51240     | 04-Dec-2023 | 15:17 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4345.5 | 38952     | 04-Dec-2023 | 15:17 | x86      |
| Sqlscm.dll                                                   | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 15:17 | x86      |
| Sqlscm.dll                                                   | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:17 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:17 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:17 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4345.5 | 202792    | 04-Dec-2023 | 15:17 | x64      |
| Ssradd.dll                                                   | 2019.150.4345.5 | 84008     | 04-Dec-2023 | 15:17 | x64      |
| Ssravg.dll                                                   | 2019.150.4345.5 | 84008     | 04-Dec-2023 | 15:17 | x64      |
| Ssrdown.dll                                                  | 2019.150.4345.5 | 75816     | 04-Dec-2023 | 15:17 | x64      |
| Ssrmax.dll                                                   | 2019.150.4345.5 | 84008     | 04-Dec-2023 | 15:17 | x64      |
| Ssrmin.dll                                                   | 2019.150.4345.5 | 84008     | 04-Dec-2023 | 15:17 | x64      |
| Ssrpub.dll                                                   | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 15:17 | x64      |
| Ssrup.dll                                                    | 2019.150.4345.5 | 75816     | 04-Dec-2023 | 15:17 | x64      |
| Txagg.dll                                                    | 2019.150.4345.5 | 391208    | 04-Dec-2023 | 15:17 | x64      |
| Txbdd.dll                                                    | 2019.150.4345.5 | 190504    | 04-Dec-2023 | 15:17 | x64      |
| Txdatacollector.dll                                          | 2019.150.4345.5 | 473128    | 04-Dec-2023 | 15:17 | x64      |
| Txdataconvert.dll                                            | 2019.150.4345.5 | 317480    | 04-Dec-2023 | 15:17 | x64      |
| Txderived.dll                                                | 2019.150.4345.5 | 641064    | 04-Dec-2023 | 15:17 | x64      |
| Txlookup.dll                                                 | 2019.150.4345.5 | 542760    | 04-Dec-2023 | 15:17 | x64      |
| Txmerge.dll                                                  | 2019.150.4345.5 | 247848    | 04-Dec-2023 | 15:17 | x64      |
| Txmergejoin.dll                                              | 2019.150.4345.5 | 309288    | 04-Dec-2023 | 15:17 | x64      |
| Txmulticast.dll                                              | 2019.150.4345.5 | 145448    | 04-Dec-2023 | 15:17 | x64      |
| Txrowcount.dll                                               | 2019.150.4345.5 | 141352    | 04-Dec-2023 | 15:17 | x64      |
| Txsort.dll                                                   | 2019.150.4345.5 | 288808    | 04-Dec-2023 | 15:17 | x64      |
| Txsplit.dll                                                  | 2019.150.4345.5 | 624680    | 04-Dec-2023 | 15:17 | x64      |
| Txunionall.dll                                               | 2019.150.4345.5 | 198696    | 04-Dec-2023 | 15:17 | x64      |
| Xe.dll                                                       | 2019.150.4345.5 | 722984    | 04-Dec-2023 | 15:17 | x64      |
| Xmlsub.dll                                                   | 2019.150.4345.5 | 297000    | 04-Dec-2023 | 15:17 | x64      |

SQL Server 2019 sql_extensibility

|     File   name    |   File version  | File size |   Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4345.5 | 96296     | 04-Dec-2023 | 15:17 | x64      |
| Exthost.exe        | 2019.150.4345.5 | 239656    | 04-Dec-2023 | 15:17 | x64      |
| Launchpad.exe      | 2019.150.4345.5 | 1230888   | 04-Dec-2023 | 15:17 | x64      |
| Sqlsatellite.dll   | 2019.150.4345.5 | 1026088   | 04-Dec-2023 | 15:17 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |   Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4345.5 | 686120    | 04-Dec-2023 | 15:17 | x64      |
| Fdhost.exe     | 2019.150.4345.5 | 129064    | 04-Dec-2023 | 15:17 | x64      |
| Fdlauncher.exe | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 15:17 | x64      |
| Sqlft150ph.dll | 2019.150.4345.5 | 92200     | 04-Dec-2023 | 15:17 | x64      |

SQL Server 2019 sql_inst_mr

| File   name | File version | File size |   Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Imrdll.dll  | 15.0.4345.5  | 30760     | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 Integration Services

|                          File   name                          |   File version  | File size |   Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4345.5 | 227368    | 04-Dec-2023 | 15:27 | x86      |
| Commanddest.dll                                               | 2019.150.4345.5 | 264232    | 04-Dec-2023 | 15:27 | x64      |
| Dteparse.dll                                                  | 2019.150.4345.5 | 112680    | 04-Dec-2023 | 15:27 | x86      |
| Dteparse.dll                                                  | 2019.150.4345.5 | 124968    | 04-Dec-2023 | 15:27 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4345.5 | 116776    | 04-Dec-2023 | 15:27 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4345.5 | 133160    | 04-Dec-2023 | 15:27 | x64      |
| Dtepkg.dll                                                    | 2019.150.4345.5 | 133160    | 04-Dec-2023 | 15:27 | x86      |
| Dtepkg.dll                                                    | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:27 | x64      |
| Dtexec.exe                                                    | 2019.150.4345.5 | 65064     | 04-Dec-2023 | 15:27 | x86      |
| Dtexec.exe                                                    | 2019.150.4345.5 | 73768     | 04-Dec-2023 | 15:27 | x64      |
| Dts.dll                                                       | 2019.150.4345.5 | 2762792   | 04-Dec-2023 | 15:27 | x86      |
| Dts.dll                                                       | 2019.150.4345.5 | 3143720   | 04-Dec-2023 | 15:27 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4345.5 | 444456    | 04-Dec-2023 | 15:27 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4345.5 | 501800    | 04-Dec-2023 | 15:27 | x64      |
| Dtsconn.dll                                                   | 2019.150.4345.5 | 432168    | 04-Dec-2023 | 15:27 | x86      |
| Dtsconn.dll                                                   | 2019.150.4345.5 | 522280    | 04-Dec-2023 | 15:27 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4345.5 | 113192    | 04-Dec-2023 | 15:27 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4345.5 | 94760     | 04-Dec-2023 | 15:27 | x86      |
| Dtshost.exe                                                   | 2019.150.4345.5 | 107560    | 04-Dec-2023 | 15:27 | x64      |
| Dtshost.exe                                                   | 2019.150.4345.5 | 89640     | 04-Dec-2023 | 15:27 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4345.5 | 555048    | 04-Dec-2023 | 15:27 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4345.5 | 567336    | 04-Dec-2023 | 15:27 | x64      |
| Dtspipeline.dll                                               | 2019.150.4345.5 | 1120296   | 04-Dec-2023 | 15:27 | x86      |
| Dtspipeline.dll                                               | 2019.150.4345.5 | 1329192   | 04-Dec-2023 | 15:27 | x64      |
| Dtswizard.exe                                                 | 15.0.4345.5     | 886824    | 04-Dec-2023 | 15:27 | x64      |
| Dtswizard.exe                                                 | 15.0.4345.5     | 890920    | 04-Dec-2023 | 15:27 | x86      |
| Dtuparse.dll                                                  | 2019.150.4345.5 | 100392    | 04-Dec-2023 | 15:27 | x64      |
| Dtuparse.dll                                                  | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:27 | x86      |
| Dtutil.exe                                                    | 2019.150.4345.5 | 130600    | 04-Dec-2023 | 15:27 | x86      |
| Dtutil.exe                                                    | 2019.150.4345.5 | 151080    | 04-Dec-2023 | 15:27 | x64      |
| Exceldest.dll                                                 | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:27 | x64      |
| Exceldest.dll                                                 | 2019.150.4345.5 | 235560    | 04-Dec-2023 | 15:27 | x86      |
| Excelsrc.dll                                                  | 2019.150.4345.5 | 260136    | 04-Dec-2023 | 15:27 | x86      |
| Excelsrc.dll                                                  | 2019.150.4345.5 | 309288    | 04-Dec-2023 | 15:27 | x64      |
| Execpackagetask.dll                                           | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:27 | x86      |
| Execpackagetask.dll                                           | 2019.150.4345.5 | 186408    | 04-Dec-2023 | 15:27 | x64      |
| Flatfiledest.dll                                              | 2019.150.4345.5 | 358440    | 04-Dec-2023 | 15:27 | x86      |
| Flatfiledest.dll                                              | 2019.150.4345.5 | 411688    | 04-Dec-2023 | 15:27 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4345.5 | 370728    | 04-Dec-2023 | 15:27 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4345.5 | 428072    | 04-Dec-2023 | 15:27 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4345.5     | 120872    | 04-Dec-2023 | 15:27 | x86      |
| Isserverexec.exe                                              | 15.0.4345.5     | 145448    | 04-Dec-2023 | 15:27 | x64      |
| Isserverexec.exe                                              | 15.0.4345.5     | 149544    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4345.5     | 116776    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4345.5     | 59432     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4345.5     | 509992    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4345.5     | 509992    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4345.5     | 43048     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4345.5     | 391208    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4345.5     | 59432     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4345.5     | 59432     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4345.5     | 141352    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4345.5     | 141352    | 04-Dec-2023 | 15:27 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4345.5     | 219176    | 04-Dec-2023 | 15:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4345.5 | 100392    | 04-Dec-2023 | 15:27 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4345.5 | 112680    | 04-Dec-2023 | 15:27 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.41  | 10065304  | 04-Dec-2023 | 15:18 | x64      |
| Odbcdest.dll                                                  | 2019.150.4345.5 | 321576    | 04-Dec-2023 | 15:27 | x86      |
| Odbcdest.dll                                                  | 2019.150.4345.5 | 370728    | 04-Dec-2023 | 15:27 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4345.5 | 329768    | 04-Dec-2023 | 15:27 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4345.5 | 383016    | 04-Dec-2023 | 15:27 | x64      |
| Oledbdest.dll                                                 | 2019.150.4345.5 | 239656    | 04-Dec-2023 | 15:27 | x86      |
| Oledbdest.dll                                                 | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:27 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4345.5 | 264232    | 04-Dec-2023 | 15:27 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:27 | x64      |
| Rawdest.dll                                                   | 2019.150.4345.5 | 190504    | 04-Dec-2023 | 15:27 | x86      |
| Rawdest.dll                                                   | 2019.150.4345.5 | 227368    | 04-Dec-2023 | 15:27 | x64      |
| Rawsource.dll                                                 | 2019.150.4345.5 | 178216    | 04-Dec-2023 | 15:27 | x86      |
| Rawsource.dll                                                 | 2019.150.4345.5 | 210984    | 04-Dec-2023 | 15:27 | x64      |
| Recordsetdest.dll                                             | 2019.150.4345.5 | 174120    | 04-Dec-2023 | 15:27 | x86      |
| Recordsetdest.dll                                             | 2019.150.4345.5 | 202792    | 04-Dec-2023 | 15:27 | x64      |
| Sqlceip.exe                                                   | 15.0.4345.5     | 297000    | 04-Dec-2023 | 15:27 | x86      |
| Sqldest.dll                                                   | 2019.150.4345.5 | 239656    | 04-Dec-2023 | 15:27 | x86      |
| Sqldest.dll                                                   | 2019.150.4345.5 | 276520    | 04-Dec-2023 | 15:27 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4345.5 | 170024    | 04-Dec-2023 | 15:27 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4345.5 | 202792    | 04-Dec-2023 | 15:27 | x64      |
| Txagg.dll                                                     | 2019.150.4345.5 | 329768    | 04-Dec-2023 | 15:27 | x86      |
| Txagg.dll                                                     | 2019.150.4345.5 | 391208    | 04-Dec-2023 | 15:27 | x64      |
| Txbdd.dll                                                     | 2019.150.4345.5 | 153640    | 04-Dec-2023 | 15:27 | x86      |
| Txbdd.dll                                                     | 2019.150.4345.5 | 190504    | 04-Dec-2023 | 15:27 | x64      |
| Txbestmatch.dll                                               | 2019.150.4345.5 | 546856    | 04-Dec-2023 | 15:27 | x86      |
| Txbestmatch.dll                                               | 2019.150.4345.5 | 653352    | 04-Dec-2023 | 15:27 | x64      |
| Txcache.dll                                                   | 2019.150.4345.5 | 174120    | 04-Dec-2023 | 15:27 | x86      |
| Txcache.dll                                                   | 2019.150.4345.5 | 198696    | 04-Dec-2023 | 15:27 | x64      |
| Txcharmap.dll                                                 | 2019.150.4345.5 | 272424    | 04-Dec-2023 | 15:27 | x86      |
| Txcharmap.dll                                                 | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:27 | x64      |
| Txcopymap.dll                                                 | 2019.150.4345.5 | 165928    | 04-Dec-2023 | 15:27 | x86      |
| Txcopymap.dll                                                 | 2019.150.4345.5 | 198696    | 04-Dec-2023 | 15:27 | x64      |
| Txdataconvert.dll                                             | 2019.150.4345.5 | 276520    | 04-Dec-2023 | 15:27 | x86      |
| Txdataconvert.dll                                             | 2019.150.4345.5 | 317480    | 04-Dec-2023 | 15:27 | x64      |
| Txderived.dll                                                 | 2019.150.4345.5 | 559144    | 04-Dec-2023 | 15:27 | x86      |
| Txderived.dll                                                 | 2019.150.4345.5 | 641064    | 04-Dec-2023 | 15:27 | x64      |
| Txfileextractor.dll                                           | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:27 | x86      |
| Txfileextractor.dll                                           | 2019.150.4345.5 | 219176    | 04-Dec-2023 | 15:27 | x64      |
| Txfileinserter.dll                                            | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:27 | x86      |
| Txfileinserter.dll                                            | 2019.150.4345.5 | 215080    | 04-Dec-2023 | 15:27 | x64      |
| Txgroupdups.dll                                               | 2019.150.4345.5 | 256040    | 04-Dec-2023 | 15:27 | x86      |
| Txgroupdups.dll                                               | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:27 | x64      |
| Txlineage.dll                                                 | 2019.150.4345.5 | 129064    | 04-Dec-2023 | 15:27 | x86      |
| Txlineage.dll                                                 | 2019.150.4345.5 | 153640    | 04-Dec-2023 | 15:27 | x64      |
| Txlookup.dll                                                  | 2019.150.4345.5 | 469032    | 04-Dec-2023 | 15:27 | x86      |
| Txlookup.dll                                                  | 2019.150.4345.5 | 542760    | 04-Dec-2023 | 15:27 | x64      |
| Txmerge.dll                                                   | 2019.150.4345.5 | 206888    | 04-Dec-2023 | 15:27 | x86      |
| Txmerge.dll                                                   | 2019.150.4345.5 | 247848    | 04-Dec-2023 | 15:27 | x64      |
| Txmergejoin.dll                                               | 2019.150.4345.5 | 247848    | 04-Dec-2023 | 15:27 | x86      |
| Txmergejoin.dll                                               | 2019.150.4345.5 | 309288    | 04-Dec-2023 | 15:27 | x64      |
| Txmulticast.dll                                               | 2019.150.4345.5 | 120872    | 04-Dec-2023 | 15:27 | x86      |
| Txmulticast.dll                                               | 2019.150.4345.5 | 145448    | 04-Dec-2023 | 15:27 | x64      |
| Txpivot.dll                                                   | 2019.150.4345.5 | 206888    | 04-Dec-2023 | 15:27 | x86      |
| Txpivot.dll                                                   | 2019.150.4345.5 | 239656    | 04-Dec-2023 | 15:27 | x64      |
| Txrowcount.dll                                                | 2019.150.4345.5 | 116776    | 04-Dec-2023 | 15:27 | x86      |
| Txrowcount.dll                                                | 2019.150.4345.5 | 141352    | 04-Dec-2023 | 15:27 | x64      |
| Txsampling.dll                                                | 2019.150.4345.5 | 161832    | 04-Dec-2023 | 15:27 | x86      |
| Txsampling.dll                                                | 2019.150.4345.5 | 194600    | 04-Dec-2023 | 15:27 | x64      |
| Txscd.dll                                                     | 2019.150.4345.5 | 198696    | 04-Dec-2023 | 15:27 | x86      |
| Txscd.dll                                                     | 2019.150.4345.5 | 235560    | 04-Dec-2023 | 15:27 | x64      |
| Txsort.dll                                                    | 2019.150.4345.5 | 231464    | 04-Dec-2023 | 15:27 | x86      |
| Txsort.dll                                                    | 2019.150.4345.5 | 288808    | 04-Dec-2023 | 15:27 | x64      |
| Txsplit.dll                                                   | 2019.150.4345.5 | 550952    | 04-Dec-2023 | 15:27 | x86      |
| Txsplit.dll                                                   | 2019.150.4345.5 | 624680    | 04-Dec-2023 | 15:27 | x64      |
| Txtermextraction.dll                                          | 2019.150.4345.5 | 8644648   | 04-Dec-2023 | 15:27 | x86      |
| Txtermextraction.dll                                          | 2019.150.4345.5 | 8701992   | 04-Dec-2023 | 15:27 | x64      |
| Txtermlookup.dll                                              | 2019.150.4345.5 | 4139048   | 04-Dec-2023 | 15:27 | x86      |
| Txtermlookup.dll                                              | 2019.150.4345.5 | 4184104   | 04-Dec-2023 | 15:27 | x64      |
| Txunionall.dll                                                | 2019.150.4345.5 | 161832    | 04-Dec-2023 | 15:27 | x86      |
| Txunionall.dll                                                | 2019.150.4345.5 | 198696    | 04-Dec-2023 | 15:27 | x64      |
| Txunpivot.dll                                                 | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:27 | x86      |
| Txunpivot.dll                                                 | 2019.150.4345.5 | 215080    | 04-Dec-2023 | 15:27 | x64      |
| Xe.dll                                                        | 2019.150.4345.5 | 632872    | 04-Dec-2023 | 15:27 | x86      |
| Xe.dll                                                        | 2019.150.4345.5 | 722984    | 04-Dec-2023 | 15:27 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |   Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1964.0     | 559536    | 04-Dec-2023 | 16:05 | x86      |
| Dmsnative.dll                                                        | 2018.150.1964.0 | 152496    | 04-Dec-2023 | 16:05 | x64      |
| Dwengineservice.dll                                                  | 15.0.1964.0     | 45016     | 04-Dec-2023 | 16:05 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 04-Dec-2023 | 16:05 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 04-Dec-2023 | 16:05 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 04-Dec-2023 | 16:05 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 04-Dec-2023 | 16:05 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 04-Dec-2023 | 16:05 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 04-Dec-2023 | 16:05 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 04-Dec-2023 | 16:05 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 04-Dec-2023 | 16:05 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 04-Dec-2023 | 16:05 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 04-Dec-2023 | 16:05 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 04-Dec-2023 | 16:05 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 04-Dec-2023 | 16:05 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 04-Dec-2023 | 16:05 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 04-Dec-2023 | 16:05 | x64      |
| Instapi150.dll                                                       | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 16:05 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 04-Dec-2023 | 16:05 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 04-Dec-2023 | 16:05 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 04-Dec-2023 | 16:05 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 04-Dec-2023 | 16:05 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 04-Dec-2023 | 16:05 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 04-Dec-2023 | 16:05 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 04-Dec-2023 | 16:05 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 04-Dec-2023 | 16:05 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 04-Dec-2023 | 16:05 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 04-Dec-2023 | 16:05 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1964.0     | 67544     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1964.0     | 293328    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1964.0     | 1957848   | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1964.0     | 169392    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1964.0     | 649648    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1964.0     | 246192    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1964.0     | 139184    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1964.0     | 79776     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1964.0     | 51104     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1964.0     | 88496     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1964.0     | 1129392   | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1964.0     | 80816     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1964.0     | 70616     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1964.0     | 35248     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1964.0     | 31192     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1964.0     | 46552     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1964.0     | 21448     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1964.0     | 26528     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1964.0     | 131536    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1964.0     | 86488     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1964.0     | 100824    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1964.0     | 293328    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 120240    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 138160    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 141232    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 137680    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 150448    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 139696    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 134608    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 176600    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 117664    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 136656    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1964.0     | 72664     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1964.0     | 21936     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1964.0     | 37280     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1964.0     | 128928    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1964.0     | 3064752   | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1964.0     | 3955672   | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 118232    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133024    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 137688    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133584    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 148440    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 134088    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 130464    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 170912    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 115144    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 132056    | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1964.0     | 67544     | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1964.0     | 2682800   | 04-Dec-2023 | 16:05 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1964.0     | 2436568   | 04-Dec-2023 | 16:05 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4345.5 | 452648    | 04-Dec-2023 | 16:05 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4345.5 | 7407656   | 04-Dec-2023 | 16:05 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 04-Dec-2023 | 16:05 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 04-Dec-2023 | 16:05 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 04-Dec-2023 | 16:05 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 04-Dec-2023 | 16:05 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 04-Dec-2023 | 16:05 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 04-Dec-2023 | 16:05 | x64      |
| Secforwarder.dll                                                     | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 16:05 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1964.0 | 61400     | 04-Dec-2023 | 16:05 | x64      |
| Sqldk.dll                                                            | 2019.150.4345.5 | 3180584   | 04-Dec-2023 | 16:05 | x64      |
| Sqldumper.exe                                                        | 2019.150.4345.5 | 366632    | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 1599528   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 4171816   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 3418152   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 4163624   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 4069416   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 2226216   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 2177064   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 3827752   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 3823656   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 1542184   | 04-Dec-2023 | 16:05 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4345.5 | 4036648   | 04-Dec-2023 | 16:05 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 04-Dec-2023 | 16:05 | x64      |
| Sqlos.dll                                                            | 2019.150.4345.5 | 43048     | 04-Dec-2023 | 16:05 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1964.0 | 4841432   | 04-Dec-2023 | 16:05 | x64      |
| Sqltses.dll                                                          | 2019.150.4345.5 | 9119784   | 04-Dec-2023 | 16:05 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 04-Dec-2023 | 16:05 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 04-Dec-2023 | 16:05 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 04-Dec-2023 | 16:05 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 04-Dec-2023 | 16:05 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 04-Dec-2023 | 16:05 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 04-Dec-2023 | 16:05 | x64      |

SQL Server 2019 sql_shared_mr

| File   name | File version | File size |   Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Smrdll.dll  | 15.0.4345.5  | 30760     | 04-Dec-2023 | 15:17 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File   name                         |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4345.5 | 1632296   | 04-Dec-2023 | 15:42 | x86      |
| Dtaengine.exe                                                | 2019.150.4345.5 | 219176    | 04-Dec-2023 | 15:42 | x86      |
| Dteparse.dll                                                 | 2019.150.4345.5 | 112680    | 04-Dec-2023 | 15:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4345.5 | 124968    | 04-Dec-2023 | 15:27 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4345.5 | 116776    | 04-Dec-2023 | 15:27 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4345.5 | 133160    | 04-Dec-2023 | 15:27 | x64      |
| Dtepkg.dll                                                   | 2019.150.4345.5 | 133160    | 04-Dec-2023 | 15:27 | x86      |
| Dtepkg.dll                                                   | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:27 | x64      |
| Dtexec.exe                                                   | 2019.150.4345.5 | 65064     | 04-Dec-2023 | 15:27 | x86      |
| Dtexec.exe                                                   | 2019.150.4345.5 | 73768     | 04-Dec-2023 | 15:27 | x64      |
| Dts.dll                                                      | 2019.150.4345.5 | 3143720   | 04-Dec-2023 | 15:27 | x64      |
| Dts.dll                                                      | 2019.150.4345.5 | 2762792   | 04-Dec-2023 | 15:27 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4345.5 | 501800    | 04-Dec-2023 | 15:27 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4345.5 | 444456    | 04-Dec-2023 | 15:27 | x86      |
| Dtsconn.dll                                                  | 2019.150.4345.5 | 522280    | 04-Dec-2023 | 15:27 | x64      |
| Dtsconn.dll                                                  | 2019.150.4345.5 | 432168    | 04-Dec-2023 | 15:27 | x86      |
| Dtshost.exe                                                  | 2019.150.4345.5 | 107560    | 04-Dec-2023 | 15:27 | x64      |
| Dtshost.exe                                                  | 2019.150.4345.5 | 89640     | 04-Dec-2023 | 15:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4345.5 | 555048    | 04-Dec-2023 | 15:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4345.5 | 567336    | 04-Dec-2023 | 15:27 | x64      |
| Dtspipeline.dll                                              | 2019.150.4345.5 | 1120296   | 04-Dec-2023 | 15:27 | x86      |
| Dtspipeline.dll                                              | 2019.150.4345.5 | 1329192   | 04-Dec-2023 | 15:27 | x64      |
| Dtswizard.exe                                                | 15.0.4345.5     | 886824    | 04-Dec-2023 | 15:27 | x64      |
| Dtswizard.exe                                                | 15.0.4345.5     | 890920    | 04-Dec-2023 | 15:27 | x86      |
| Dtuparse.dll                                                 | 2019.150.4345.5 | 100392    | 04-Dec-2023 | 15:27 | x64      |
| Dtuparse.dll                                                 | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4345.5 | 130600    | 04-Dec-2023 | 15:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4345.5 | 151080    | 04-Dec-2023 | 15:27 | x64      |
| Exceldest.dll                                                | 2019.150.4345.5 | 235560    | 04-Dec-2023 | 15:27 | x86      |
| Exceldest.dll                                                | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:27 | x64      |
| Excelsrc.dll                                                 | 2019.150.4345.5 | 260136    | 04-Dec-2023 | 15:27 | x86      |
| Excelsrc.dll                                                 | 2019.150.4345.5 | 309288    | 04-Dec-2023 | 15:27 | x64      |
| Flatfiledest.dll                                             | 2019.150.4345.5 | 358440    | 04-Dec-2023 | 15:27 | x86      |
| Flatfiledest.dll                                             | 2019.150.4345.5 | 411688    | 04-Dec-2023 | 15:27 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4345.5 | 428072    | 04-Dec-2023 | 15:27 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4345.5 | 370728    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4345.5     | 116776    | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4345.5     | 403496    | 04-Dec-2023 | 15:42 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4345.5     | 3004456   | 04-Dec-2023 | 15:42 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4345.5     | 43048     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4345.5     | 43048     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4345.5     | 59432     | 04-Dec-2023 | 15:27 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 04-Dec-2023 | 15:42 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4345.5 | 100392    | 04-Dec-2023 | 15:27 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4345.5 | 112680    | 04-Dec-2023 | 15:27 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.41  | 8281032   | 04-Dec-2023 | 15:17 | x86      |
| Oledbdest.dll                                                | 2019.150.4345.5 | 280616    | 04-Dec-2023 | 15:27 | x64      |
| Oledbdest.dll                                                | 2019.150.4345.5 | 239656    | 04-Dec-2023 | 15:27 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4345.5 | 313384    | 04-Dec-2023 | 15:27 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4345.5 | 264232    | 04-Dec-2023 | 15:27 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4345.5 | 38952     | 04-Dec-2023 | 15:42 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4345.5 | 51240     | 04-Dec-2023 | 15:42 | x64      |
| Sqlscm.dll                                                   | 2019.150.4345.5 | 79912     | 04-Dec-2023 | 15:42 | x86      |
| Sqlscm.dll                                                   | 2019.150.4345.5 | 88104     | 04-Dec-2023 | 15:42 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4345.5 | 149544    | 04-Dec-2023 | 15:42 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4345.5 | 182312    | 04-Dec-2023 | 15:42 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4345.5 | 170024    | 04-Dec-2023 | 15:27 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4345.5 | 202792    | 04-Dec-2023 | 15:27 | x64      |
| Txdataconvert.dll                                            | 2019.150.4345.5 | 276520    | 04-Dec-2023 | 15:27 | x86      |
| Txdataconvert.dll                                            | 2019.150.4345.5 | 317480    | 04-Dec-2023 | 15:27 | x64      |
| Xe.dll                                                       | 2019.150.4345.5 | 632872    | 04-Dec-2023 | 15:27 | x86      |
| Xe.dll                                                       | 2019.150.4345.5 | 722984    | 04-Dec-2023 | 15:27 | x64      |

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
