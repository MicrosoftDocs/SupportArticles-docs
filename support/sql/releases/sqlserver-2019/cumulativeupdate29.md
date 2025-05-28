---
title: Cumulative update 29 for SQL Server 2019 (KB5046365)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 29 (KB5046365).
ms.date: 04/30/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5046365
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5046365 - Cumulative Update 29 for SQL Server 2019

_Release Date:_ &nbsp; October 31, 2024  
_Version:_ &nbsp; 15.0.4405.4

## Summary

This article describes Cumulative Update package 29 (CU29) for Microsoft SQL Server 2019. This update contains 18 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 28, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4405.4**, file version: **2019.150.4405.4**
- Analysis Services - Product version: **15.0.35.51**, file version: **2018.150.35.51**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fixes area | Component | Platform |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=3426566>[3426566](#3426566) </a> | Fixes an issue in which Data Analysis Expressions (DAX) queries that use `SUMMARIZECOLUMNS` and `ROLLUPGROUP` with multidimensional models might produce incorrect results when running multiple queries that have different sub-selects without clearing the cache, which causes inaccurate totals starting from the second query. | Analysis Services| Analysis Services | Windows|
| <a id=3515480>[3515480](#3515480) </a> | Adds *SQL2019_SSIS.cat*, a digitally-signed catalog file in *%SystemRoot%\System32\CatRoot\\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}*, to sign *Attunity.SqlServer.CDCControlTask.dll*, *Attunity.SqlServer.CDCDesign.dll*, *Attunity.SqlServer.CDCSplit.dll*, *Attunity.SqlServer.CDCSrc.dll* and their resource assemblies for catalog signing. | Integration Services | Integration Services| Windows|
| <a id=3354260>[3354260](#3354260) </a> | Fixes a domain account authentication issue in the configuration tool by adding an auto-retry method to the account validation part, which will use the **UPN** format and try to authenticate using three separate authentication methods after the authentication fails in **SAM** format and default.| Master Data Services | Master Data Services| Windows|
| <a id=3459328>[3459328](#3459328) </a> | Fixes an issue in which the SQL Server Volume Shadow Copy Service (VSS) Writer can't freeze the database during a VSS-based backup. For more information, see [known issue three of SQL Server 2019 CU28](cumulativeupdate28.md#issue-three-sql-server-vss-writer-might-fail-to-perform-a-backup-because-no-database-is-available-to-freeze). | SQL Server Engine| Backup Restore| Windows|
| <a id=3539961>[3539961](#3539961) </a> | Fixes an issue in which database striped backups using virtual device interface (VDI) tools might fail to restore with [error 3456](../../database-engine/backup-restore/backup-multistriped-vdi-issue.md). | SQL Server Engine| Backup Restore| All |
| <a id=3287653>[3287653](#3287653) </a> | Fixes an assertion failure (Location: ListenerSpec.cpp:480; Expression: totalUsed + cbListenerName <= cbObj) that you encounter when creating a [distributed availability group (DAG)](/sql/database-engine/availability-groups/windows/distributed-availability-groups) and incorrectly specifying the number of availability groups in it to be other than two. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3407955>[3407955](#3407955) </a> | Fixes an issue in which a log backup stops responding on the primary replica after the secondary replica restarts if no additional workloads exist on the primary database. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3418490>[3418490](#3418490) </a> | Fixes a patching error that you encounter in secondary replicas of an availability group with databases that have SQL replication or change data capture (CDC) enabled. For more information, see [known issue two of SQL Server 2019 CU28](cumulativeupdate28.md#issue-two-patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-or-cdc) or [known issue three of SQL Server 2019 CU27](cumulativeupdate27.md#issue-three-patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-or-cdc). | SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=3336595>[3336595](#3336595) </a> | Adds a validation for the `MODEL` parameter when running `PREDICT` to avoid errors due to the input of wrong models.| SQL Server Engine| Query Execution | All |
| <a id=3362873>[3362873](#3362873) </a> | Fixes an issue with checkpoint operation in which the following error 2601 occurs when SQL Server tries to perform a checkpoint operation on the database that has change tracking enabled: </br></br>\<DateTime> Error: 2601, Severity: 14, State: 1. </br>\<DateTime> Cannot insert duplicate key row in object '\<ObjectName>' with unique index '\<IndexName>'. The duplicate key value is \<KeyValue>. | SQL Server Engine| Replication | All|
| <a id=3419782>[3419782](#3419782) </a> | Allows you to disable [OLE DB streaming](/sql/relational-databases/replication/agents/replication-distribution-agent) by passing `-UseOledbStreaming 0` for the Replication Distribution Agent to avoid the error mentioned in [Error message when you run the Distribution Agent in SQL Server](../../database-engine/replication/error-run-distribution-agent.md). | SQL Server Engine| Replication | All|
| <a id=3466004>[3466004](#3466004) </a> | Fixes an issue in which the full-text auto crawl monitor is aborted when you use full-text search.| SQL Server Engine| Search| All|
| <a id=3540450>[3540450](#3540450) </a> | Makes trace flag 7617 available to skip dropping full-text index fragments marked as deletion during a database recovery process. | SQL Server Engine| Search| Windows|
| <a id=3495196>[3495196](#3495196) </a> | Fixes an issue in which the SQL Server error log might include invalid characters for SQL Server Agent login attempts when the Agent runs a job on a scheduler configured to run automatically once the Agent starts. | SQL Server Engine| SQL Agent | Windows|
| <a id=3370476>[3370476](#3370476) </a> | Adds trace flag 6981 to handle large objects (LOBs) when rebuilding the index that has an assertion issue (Location: blobbase.cpp:345; Expression: IS_ON (BLB_TI_END, m_status)). After turning on this trace flag and rebuilding the affected index, the assertion dump shouldn't be generated again.| SQL Server Engine| Storage Management| All|
| <a id=3409332>[3409332](#3409332) </a> | Fixes an issue in which table and column names that are read from database metadata aren't correctly quoted in some cases when building internal SQL Server batches in stored procedures that manage temporal tables. After applying the fix, quoting is completed correctly. | SQL Server Engine| Temporal| All|
| <a id=3180085>[3180085](#3180085) </a> | Fixes a performance issue that you might encounter only when `sp_lock` is called frequently from multiple connections, which might cause a memory leak. The memory isn't cleaned up until you restart the SQL Server service. </br></br>**Note**: You need to turn on trace flag 15915. | SQL Server Engine| Transaction Services| All|
| <a id=3417392>[3417392](#3417392) </a> | Fixes a contention issue with high `KTM_RECOVERY_MANAGER` wait times that you might encounter when running XA distributed transactions. </br></br>**Note**: You need to turn on trace flag 8531 as a startup trace flag.| SQL Server Engine| Transaction Services| All|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU29 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5046365)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5046365-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5046365-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5046365-x64.exe| 2B50A55EE3F8EDF54FE9EB1E5C70DEF24FDD3320C86AB2DC44276E675AFCDC29 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.51  | 292912    | 23-Oct-2024 | 09:20 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.51      | 758344    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 175680    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 199728    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 202296    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 198704    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 215088    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 197680    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 193584    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 252464    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 174120    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 197160    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.51      | 1098840   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.51      | 567344    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 54856     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 59440     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 59992     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 62024     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58304     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58440     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 67656     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 53696     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58440     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17992     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17976     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 19032     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 23-Oct-2024 | 09:20 | x86      |
| Msmdctr.dll                                               | 2018.150.35.51  | 38472     | 23-Oct-2024 | 09:20 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.51  | 47784504  | 23-Oct-2024 | 09:20 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.51  | 66261560  | 23-Oct-2024 | 09:20 | x64      |
| Msmdpump.dll                                              | 2018.150.35.51  | 10187312  | 23-Oct-2024 | 09:20 | x64      |
| Msmdredir.dll                                             | 2018.150.35.51  | 7957576   | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16952     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17456     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17464     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17480     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17464     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 18488     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16960     | 23-Oct-2024 | 09:20 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 23-Oct-2024 | 09:20 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.51  | 65799240  | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 833592    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1628208   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1454144   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1643056   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1608752   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1001520   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 992808    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1537080   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1521712   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 811056    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1596472   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 832568    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1624624   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1451064   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1637936   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1604656   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 998968    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 991280    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1532976   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1518136   | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 810040    | 23-Oct-2024 | 09:20 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1591848   | 23-Oct-2024 | 09:20 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.51  | 8280112   | 23-Oct-2024 | 09:20 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.51  | 10186288  | 23-Oct-2024 | 09:20 | x64      |
| Msolap.dll                                                | 2018.150.35.51  | 8607168   | 23-Oct-2024 | 09:20 | x86      |
| Msolap.dll                                                | 2018.150.35.51  | 11013184  | 23-Oct-2024 | 09:20 | x64      |
| Msolui.dll                                                | 2018.150.35.51  | 286256    | 23-Oct-2024 | 09:20 | x86      |
| Msolui.dll                                                | 2018.150.35.51  | 306624    | 23-Oct-2024 | 09:20 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 23-Oct-2024 | 09:20 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 23-Oct-2024 | 09:20 | x64      |
| Sqlboot.dll                                               | 2019.150.4405.4 | 215096    | 23-Oct-2024 | 09:20 | x64      |
| Sqlceip.exe                                               | 15.0.4405.4     | 297000    | 23-Oct-2024 | 09:20 | x86      |
| Sqldumper.exe                                             | 2019.150.4405.4 | 321576    | 23-Oct-2024 | 09:20 | x86      |
| Sqldumper.exe                                             | 2019.150.4405.4 | 378920    | 23-Oct-2024 | 09:20 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 23-Oct-2024 | 09:20 | x86      |
| Tbb.dll                                                   | 2019.0.2019.410 | 442688    | 23-Oct-2024 | 09:20 | x64      |
| Tbbmalloc.dll                                             | 2019.0.2019.410 | 270144    | 23-Oct-2024 | 09:20 | x64      |
| Tmapi.dll                                                 | 2018.150.35.51  | 6178352   | 23-Oct-2024 | 09:20 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.51  | 4917808   | 23-Oct-2024 | 09:20 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.51  | 1184816   | 23-Oct-2024 | 09:20 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.51  | 6807088   | 23-Oct-2024 | 09:20 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.51  | 26025544  | 23-Oct-2024 | 09:20 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.51  | 35460152  | 23-Oct-2024 | 09:20 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4405.4 | 165968    | 23-Oct-2024 | 09:20 | x86      |
| Batchparser.dll                      | 2019.150.4405.4 | 182352    | 23-Oct-2024 | 09:21 | x64      |
| Instapi150.dll                       | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:21 | x64      |
| Instapi150.dll                       | 2019.150.4405.4 | 75816     | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4405.4 | 104504    | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4405.4     | 550952    | 23-Oct-2024 | 09:20 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4405.4     | 550968    | 23-Oct-2024 | 09:21 | x86      |
| Msasxpress.dll                       | 2018.150.35.51  | 32304     | 23-Oct-2024 | 09:20 | x64      |
| Msasxpress.dll                       | 2018.150.35.51  | 27184     | 23-Oct-2024 | 09:21 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4405.4 | 92216     | 23-Oct-2024 | 09:20 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4405.4 | 75848     | 23-Oct-2024 | 09:21 | x86      |
| Sqldumper.exe                        | 2019.150.4405.4 | 378920    | 23-Oct-2024 | 09:21 | x64      |
| Sqldumper.exe                        | 2019.150.4405.4 | 321576    | 23-Oct-2024 | 09:21 | x86      |
| Sqlftacct.dll                        | 2019.150.4405.4 | 79928     | 23-Oct-2024 | 09:21 | x64      |
| Sqlftacct.dll                        | 2019.150.4405.4 | 59456     | 23-Oct-2024 | 09:21 | x86      |
| Sqlmanager.dll                       | 2019.150.4405.4 | 878672    | 23-Oct-2024 | 09:21 | x64      |
| Sqlmanager.dll                       | 2019.150.4405.4 | 743480    | 23-Oct-2024 | 09:21 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4405.4 | 432192    | 23-Oct-2024 | 09:21 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4405.4 | 378920    | 23-Oct-2024 | 09:21 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4405.4 | 358440    | 23-Oct-2024 | 09:21 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4405.4 | 276520    | 23-Oct-2024 | 09:21 | x86      |
| Svrenumapi150.dll                    | 2019.150.4405.4 | 911416    | 23-Oct-2024 | 09:20 | x86      |
| Svrenumapi150.dll                    | 2019.150.4405.4 | 1161256   | 23-Oct-2024 | 09:21 | x64      |

SQL Server 2019 Data Quality

| File name                 | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.core.dll  | 15.0.4405.4  | 600104    | 23-Oct-24 | 09:20 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4405.4  | 600144    | 23-Oct-24 | 09:20 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4405.4  | 1857576   | 23-Oct-24 | 09:20 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4405.4  | 1857592   | 23-Oct-24 | 09:20 | x86      |
| Dqsinstaller.exe          | 15.0.4405.4  | 2771008   | 23-Oct-24 | 09:20 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4405.4 | 137296    | 23-Oct-2024 | 09:20 | x86      |
| Dreplaycommon.dll     | 2019.150.4405.4 | 667704    | 23-Oct-2024 | 09:20 | x86      |
| Dreplayutil.dll       | 2019.150.4405.4 | 305208    | 23-Oct-2024 | 09:20 | x86      |
| Instapi150.dll        | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:20 | x64      |
| Sqlresourceloader.dll | 2019.150.4405.4 | 38976     | 23-Oct-2024 | 09:20 | x86      |

SQL Server 2019 sql_dreplay_controller

| File name             | File version    | File size | Date        | Time  | Platform |
|-----------------------|-----------------|-----------|-------------|-------|----------|
| Dreplaycommon.dll     | 2019.150.4405.4 | 667704    | 23-Oct-2024 | 09:20 | x86      |
| Dreplaycontroller.exe | 2019.150.4405.4 | 366656    | 23-Oct-2024 | 09:20 | x86      |
| Instapi150.dll        | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:20 | x64      |
| Sqlresourceloader.dll | 2019.150.4405.4 | 38976     | 23-Oct-2024 | 09:20 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4405.4 | 4658232   | 23-Oct-2024 | 09:54 | x64      |
| Aetm-enclave.dll                           | 2019.150.4405.4 | 4612640   | 23-Oct-2024 | 09:54 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4405.4 | 4932528   | 23-Oct-2024 | 09:54 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4405.4 | 4873136   | 23-Oct-2024 | 09:54 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 23-Oct-2024 | 09:54 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 23-Oct-2024 | 09:54 | x64      |
| Batchparser.dll                            | 2019.150.4405.4 | 182352    | 23-Oct-2024 | 09:54 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 23-Oct-2024 | 09:54 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 23-Oct-2024 | 09:54 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 23-Oct-2024 | 09:54 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 23-Oct-2024 | 09:54 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4405.4 | 280632    | 23-Oct-2024 | 09:54 | x64      |
| Dcexec.exe                                 | 2019.150.4405.4 | 88144     | 23-Oct-2024 | 09:54 | x64      |
| Fssres.dll                                 | 2019.150.4405.4 | 96312     | 23-Oct-2024 | 09:54 | x64      |
| Hadrres.dll                                | 2019.150.4405.4 | 206904    | 23-Oct-2024 | 09:54 | x64      |
| Hkcompile.dll                              | 2019.150.4405.4 | 1292328   | 23-Oct-2024 | 09:54 | x64      |
| Hkengine.dll                               | 2019.150.4405.4 | 5793832   | 23-Oct-2024 | 09:54 | x64      |
| Hkruntime.dll                              | 2019.150.4405.4 | 182352    | 23-Oct-2024 | 09:54 | x64      |
| Hktempdb.dll                               | 2019.150.4405.4 | 63528     | 23-Oct-2024 | 09:54 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 23-Oct-2024 | 09:54 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4405.4     | 235560    | 23-Oct-2024 | 09:54 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4405.4 | 391224    | 23-Oct-2024 | 09:54 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4405.4 | 325712    | 23-Oct-2024 | 09:54 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4405.4 | 92200     | 23-Oct-2024 | 09:54 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 23-Oct-2024 | 09:54 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 23-Oct-2024 | 09:54 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 23-Oct-2024 | 09:54 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 23-Oct-2024 | 09:54 | x64      |
| Qds.dll                                    | 2019.150.4405.4 | 1189960   | 23-Oct-2024 | 09:54 | x64      |
| Rsfxft.dll                                 | 2019.150.4405.4 | 51272     | 23-Oct-2024 | 09:54 | x64      |
| Secforwarder.dll                           | 2019.150.4405.4 | 79928     | 23-Oct-2024 | 09:54 | x64      |
| Sqagtres.dll                               | 2019.150.4405.4 | 88120     | 23-Oct-2024 | 09:54 | x64      |
| Sqlaamss.dll                               | 2019.150.4405.4 | 108600    | 23-Oct-2024 | 09:54 | x64      |
| Sqlaccess.dll                              | 2019.150.4405.4 | 493624    | 23-Oct-2024 | 09:54 | x64      |
| Sqlagent.exe                               | 2019.150.4405.4 | 731176    | 23-Oct-2024 | 09:54 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4405.4 | 79928     | 23-Oct-2024 | 09:54 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4405.4 | 71760     | 23-Oct-2024 | 09:54 | x86      |
| Sqlboot.dll                                | 2019.150.4405.4 | 215096    | 23-Oct-2024 | 09:54 | x64      |
| Sqlceip.exe                                | 15.0.4405.4     | 297000    | 23-Oct-2024 | 09:54 | x86      |
| Sqlcmdss.dll                               | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:54 | x64      |
| Sqlctr150.dll                              | 2019.150.4405.4 | 145448    | 23-Oct-2024 | 09:54 | x64      |
| Sqlctr150.dll                              | 2019.150.4405.4 | 116816    | 23-Oct-2024 | 09:54 | x86      |
| Sqldk.dll                                  | 2019.150.4405.4 | 3180584   | 23-Oct-2024 | 09:54 | x64      |
| Sqldtsss.dll                               | 2019.150.4405.4 | 108608    | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 1599544   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3508280   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3704888   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4171832   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4290600   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3422264   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3590200   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4167720   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4020280   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4073528   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 2226216   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 2177064   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3876904   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3553336   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4024360   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3831848   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3827752   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3622968   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3508280   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 1542200   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 3917864   | 23-Oct-2024 | 09:54 | x64      |
| Sqlevn70.rll                               | 2019.150.4405.4 | 4036664   | 23-Oct-2024 | 09:54 | x64      |
| Sqllang.dll                                | 2019.150.4405.4 | 40093752  | 23-Oct-2024 | 09:54 | x64      |
| Sqlmin.dll                                 | 2019.150.4405.4 | 40653888  | 23-Oct-2024 | 09:54 | x64      |
| Sqlolapss.dll                              | 2019.150.4405.4 | 108600    | 23-Oct-2024 | 09:54 | x64      |
| Sqlos.dll                                  | 2019.150.4405.4 | 43048     | 23-Oct-2024 | 09:54 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4405.4 | 84008     | 23-Oct-2024 | 09:54 | x64      |
| Sqlrepss.dll                               | 2019.150.4405.4 | 88128     | 23-Oct-2024 | 09:54 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4405.4 | 51256     | 23-Oct-2024 | 09:54 | x64      |
| Sqlscm.dll                                 | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:54 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4405.4 | 38952     | 23-Oct-2024 | 09:54 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4405.4 | 5810232   | 23-Oct-2024 | 09:54 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4405.4 | 673872    | 23-Oct-2024 | 09:54 | x64      |
| Sqlservr.exe                               | 2019.150.4405.4 | 628816    | 23-Oct-2024 | 09:54 | x64      |
| Sqlsvc.dll                                 | 2019.150.4405.4 | 182328    | 23-Oct-2024 | 09:54 | x64      |
| Sqltses.dll                                | 2019.150.4405.4 | 9119800   | 23-Oct-2024 | 09:54 | x64      |
| Sqsrvres.dll                               | 2019.150.4405.4 | 280616    | 23-Oct-2024 | 09:54 | x64      |
| Stretchcodegen.exe                         | 15.0.4405.4     | 59448     | 23-Oct-2024 | 09:54 | x86      |
| Svl.dll                                    | 2019.150.4405.4 | 161872    | 23-Oct-2024 | 09:54 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 23-Oct-2024 | 09:54 | x64      |
| Xe.dll                                     | 2019.150.4405.4 | 723000    | 23-Oct-2024 | 09:54 | x64      |
| Xpadsi.exe                                 | 2019.150.4405.4 | 116792    | 23-Oct-2024 | 09:54 | x64      |
| Xplog70.dll                                | 2019.150.4405.4 | 92224     | 23-Oct-2024 | 09:54 | x64      |
| Xpqueue.dll                                | 2019.150.4405.4 | 92216     | 23-Oct-2024 | 09:54 | x64      |
| Xprepl.dll                                 | 2019.150.4405.4 | 120896    | 23-Oct-2024 | 09:54 | x64      |
| Xpstar.dll                                 | 2019.150.4405.4 | 473128    | 23-Oct-2024 | 09:54 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version   | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4405.4  | 182352    | 23-Oct-2024 | 09:20 | x64      |
| Batchparser.dll                                              | 2019.150.4405.4  | 165968    | 23-Oct-2024 | 09:21 | x86      |
| Commanddest.dll                                              | 2019.150.4405.4  | 264232    | 23-Oct-2024 | 09:20 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4405.4  | 227368    | 23-Oct-2024 | 09:20 | x64      |
| Distrib.exe                                                  | 2019.150.4405.4  | 243776    | 23-Oct-2024 | 09:21 | x64      |
| Dteparse.dll                                                 | 2019.150.4405.4  | 124968    | 23-Oct-2024 | 09:21 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4405.4  | 133176    | 23-Oct-2024 | 09:21 | x64      |
| Dtepkg.dll                                                   | 2019.150.4405.4  | 149560    | 23-Oct-2024 | 09:21 | x64      |
| Dtexec.exe                                                   | 2019.150.4405.4  | 73768     | 23-Oct-2024 | 09:21 | x64      |
| Dts.dll                                                      | 2019.150.4405.4  | 3143760   | 23-Oct-2024 | 09:21 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4405.4  | 501816    | 23-Oct-2024 | 09:21 | x64      |
| Dtsconn.dll                                                  | 2019.150.4405.4  | 522296    | 23-Oct-2024 | 09:21 | x64      |
| Dtshost.exe                                                  | 2019.150.4405.4  | 107576    | 23-Oct-2024 | 09:21 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4405.4  | 567376    | 23-Oct-2024 | 09:21 | x64      |
| Dtspipeline.dll                                              | 2019.150.4405.4  | 1329232   | 23-Oct-2024 | 09:21 | x64      |
| Dtswizard.exe                                                | 15.0.4405.4      | 886824    | 23-Oct-2024 | 09:21 | x64      |
| Dtuparse.dll                                                 | 2019.150.4405.4  | 100408    | 23-Oct-2024 | 09:21 | x64      |
| Dtutil.exe                                                   | 2019.150.4405.4  | 151096    | 23-Oct-2024 | 09:21 | x64      |
| Exceldest.dll                                                | 2019.150.4405.4  | 280632    | 23-Oct-2024 | 09:21 | x64      |
| Excelsrc.dll                                                 | 2019.150.4405.4  | 309304    | 23-Oct-2024 | 09:21 | x64      |
| Execpackagetask.dll                                          | 2019.150.4405.4  | 186424    | 23-Oct-2024 | 09:21 | x64      |
| Flatfiledest.dll                                             | 2019.150.4405.4  | 411688    | 23-Oct-2024 | 09:21 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4405.4  | 428072    | 23-Oct-2024 | 09:21 | x64      |
| Logread.exe                                                  | 2019.150.4405.4  | 723000    | 23-Oct-2024 | 09:20 | x64      |
| Mergetxt.dll                                                 | 2019.150.4405.4  | 75832     | 23-Oct-2024 | 09:20 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4405.4      | 59456     | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4405.4      | 43064     | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4405.4      | 391224    | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4405.4  | 1697832   | 23-Oct-2024 | 09:21 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4405.4  | 1640528   | 23-Oct-2024 | 09:21 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4405.4      | 550968    | 23-Oct-2024 | 09:21 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4405.4  | 112696    | 23-Oct-2024 | 09:21 | x64      |
| Msgprox.dll                                                  | 2019.150.4405.4  | 301136    | 23-Oct-2024 | 09:21 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 2750472   | 23-Oct-2024 | 09:21 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 153608    | 23-Oct-2024 | 09:21 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4405.4  | 1497128   | 23-Oct-2024 | 09:21 | x64      |
| Oledbdest.dll                                                | 2019.150.4405.4  | 280616    | 23-Oct-2024 | 09:20 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4405.4  | 313384    | 23-Oct-2024 | 09:20 | x64      |
| Osql.exe                                                     | 2019.150.4405.4  | 92240     | 23-Oct-2024 | 09:20 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4405.4  | 501816    | 23-Oct-2024 | 09:20 | x64      |
| Rawdest.dll                                                  | 2019.150.4405.4  | 227384    | 23-Oct-2024 | 09:20 | x64      |
| Rawsource.dll                                                | 2019.150.4405.4  | 210984    | 23-Oct-2024 | 09:20 | x64      |
| Rdistcom.dll                                                 | 2019.150.4405.4  | 915496    | 23-Oct-2024 | 09:20 | x64      |
| Recordsetdest.dll                                            | 2019.150.4405.4  | 202808    | 23-Oct-2024 | 09:20 | x64      |
| Repldp.dll                                                   | 2019.150.4405.4  | 313384    | 23-Oct-2024 | 09:21 | x64      |
| Replerrx.dll                                                 | 2019.150.4405.4  | 182352    | 23-Oct-2024 | 09:21 | x64      |
| Replisapi.dll                                                | 2019.150.4405.4  | 395304    | 23-Oct-2024 | 09:21 | x64      |
| Replmerg.exe                                                 | 2019.150.4405.4  | 563240    | 23-Oct-2024 | 09:21 | x64      |
| Replprov.dll                                                 | 2019.150.4405.4  | 862264    | 23-Oct-2024 | 09:21 | x64      |
| Replrec.dll                                                  | 2019.150.4405.4  | 1034296   | 23-Oct-2024 | 09:21 | x64      |
| Replsub.dll                                                  | 2019.150.4405.4  | 473168    | 23-Oct-2024 | 09:21 | x64      |
| Replsync.dll                                                 | 2019.150.4405.4  | 165944    | 23-Oct-2024 | 09:21 | x64      |
| Spresolv.dll                                                 | 2019.150.4405.4  | 276536    | 23-Oct-2024 | 09:20 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4405.4  | 264248    | 23-Oct-2024 | 09:20 | x64      |
| Sqldiag.exe                                                  | 2019.150.4405.4  | 1140776   | 23-Oct-2024 | 09:20 | x64      |
| Sqldistx.dll                                                 | 2019.150.4405.4  | 251968    | 23-Oct-2024 | 09:20 | x64      |
| Sqllogship.exe                                               | 15.0.4405.4      | 104528    | 23-Oct-2024 | 09:20 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4405.4  | 399440    | 23-Oct-2024 | 09:20 | x64      |
| Sqlnclirda11.dll                                             | 2011.110.5069.66 | 3478208   | 23-Oct-2024 | 09:20 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4405.4  | 51256     | 23-Oct-2024 | 09:20 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4405.4  | 38976     | 23-Oct-2024 | 09:21 | x86      |
| Sqlscm.dll                                                   | 2019.150.4405.4  | 88104     | 23-Oct-2024 | 09:20 | x64      |
| Sqlscm.dll                                                   | 2019.150.4405.4  | 79952     | 23-Oct-2024 | 09:21 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4405.4  | 182328    | 23-Oct-2024 | 09:20 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4405.4  | 149544    | 23-Oct-2024 | 09:21 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4405.4  | 202792    | 23-Oct-2024 | 09:20 | x64      |
| Ssradd.dll                                                   | 2019.150.4405.4  | 84032     | 23-Oct-2024 | 09:21 | x64      |
| Ssravg.dll                                                   | 2019.150.4405.4  | 84040     | 23-Oct-2024 | 09:21 | x64      |
| Ssrdown.dll                                                  | 2019.150.4405.4  | 75840     | 23-Oct-2024 | 09:21 | x64      |
| Ssrmax.dll                                                   | 2019.150.4405.4  | 84048     | 23-Oct-2024 | 09:21 | x64      |
| Ssrmin.dll                                                   | 2019.150.4405.4  | 84008     | 23-Oct-2024 | 09:21 | x64      |
| Ssrpub.dll                                                   | 2019.150.4405.4  | 79944     | 23-Oct-2024 | 09:21 | x64      |
| Ssrup.dll                                                    | 2019.150.4405.4  | 75840     | 23-Oct-2024 | 09:21 | x64      |
| Txagg.dll                                                    | 2019.150.4405.4  | 391208    | 23-Oct-2024 | 09:21 | x64      |
| Txbdd.dll                                                    | 2019.150.4405.4  | 190504    | 23-Oct-2024 | 09:21 | x64      |
| Txdatacollector.dll                                          | 2019.150.4405.4  | 473144    | 23-Oct-2024 | 09:21 | x64      |
| Txdataconvert.dll                                            | 2019.150.4405.4  | 317496    | 23-Oct-2024 | 09:21 | x64      |
| Txderived.dll                                                | 2019.150.4405.4  | 641064    | 23-Oct-2024 | 09:21 | x64      |
| Txlookup.dll                                                 | 2019.150.4405.4  | 542776    | 23-Oct-2024 | 09:21 | x64      |
| Txmerge.dll                                                  | 2019.150.4405.4  | 247864    | 23-Oct-2024 | 09:21 | x64      |
| Txmergejoin.dll                                              | 2019.150.4405.4  | 309288    | 23-Oct-2024 | 09:21 | x64      |
| Txmulticast.dll                                              | 2019.150.4405.4  | 145448    | 23-Oct-2024 | 09:21 | x64      |
| Txrowcount.dll                                               | 2019.150.4405.4  | 141368    | 23-Oct-2024 | 09:21 | x64      |
| Txsort.dll                                                   | 2019.150.4405.4  | 288808    | 23-Oct-2024 | 09:21 | x64      |
| Txsplit.dll                                                  | 2019.150.4405.4  | 624696    | 23-Oct-2024 | 09:21 | x64      |
| Txunionall.dll                                               | 2019.150.4405.4  | 198696    | 23-Oct-2024 | 09:21 | x64      |
| Xe.dll                                                       | 2019.150.4405.4  | 723000    | 23-Oct-2024 | 09:21 | x64      |
| Xmlsub.dll                                                   | 2019.150.4405.4  | 297040    | 23-Oct-2024 | 09:21 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |     Date    |  Time | Platform |
|:------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4405.4 | 96312     | 23-Oct-2024 | 09:20 | x64      |
| Exthost.exe        | 2019.150.4405.4 | 239696    | 23-Oct-2024 | 09:20 | x64      |
| Launchpad.exe      | 2019.150.4405.4 | 1230928   | 23-Oct-2024 | 09:20 | x64      |
| Sqlsatellite.dll   | 2019.150.4405.4 | 1026088   | 23-Oct-2024 | 09:20 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |     Date    |  Time | Platform |
|:--------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4405.4 | 686120    | 23-Oct-2024 | 09:20 | x64      |
| Fdhost.exe     | 2019.150.4405.4 | 129080    | 23-Oct-2024 | 09:20 | x64      |
| Fdlauncher.exe | 2019.150.4405.4 | 79936     | 23-Oct-2024 | 09:20 | x64      |
| Sqlft150ph.dll | 2019.150.4405.4 | 92200     | 23-Oct-2024 | 09:20 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4405.4  | 30760     | 23-Oct-2024 | 09:20 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4405.4 | 264232    | 23-Oct-2024 | 09:22 | x64      |
| Commanddest.dll                                               | 2019.150.4405.4 | 227400    | 23-Oct-2024 | 09:22 | x86      |
| Dteparse.dll                                                  | 2019.150.4405.4 | 112680    | 23-Oct-2024 | 09:22 | x86      |
| Dteparse.dll                                                  | 2019.150.4405.4 | 124968    | 23-Oct-2024 | 09:22 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4405.4 | 116776    | 23-Oct-2024 | 09:22 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4405.4 | 133176    | 23-Oct-2024 | 09:22 | x64      |
| Dtepkg.dll                                                    | 2019.150.4405.4 | 133176    | 23-Oct-2024 | 09:22 | x86      |
| Dtepkg.dll                                                    | 2019.150.4405.4 | 149560    | 23-Oct-2024 | 09:22 | x64      |
| Dtexec.exe                                                    | 2019.150.4405.4 | 65088     | 23-Oct-2024 | 09:22 | x86      |
| Dtexec.exe                                                    | 2019.150.4405.4 | 73768     | 23-Oct-2024 | 09:22 | x64      |
| Dts.dll                                                       | 2019.150.4405.4 | 2762808   | 23-Oct-2024 | 09:22 | x86      |
| Dts.dll                                                       | 2019.150.4405.4 | 3143760   | 23-Oct-2024 | 09:22 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4405.4 | 444496    | 23-Oct-2024 | 09:22 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4405.4 | 501816    | 23-Oct-2024 | 09:22 | x64      |
| Dtsconn.dll                                                   | 2019.150.4405.4 | 432184    | 23-Oct-2024 | 09:22 | x86      |
| Dtsconn.dll                                                   | 2019.150.4405.4 | 522296    | 23-Oct-2024 | 09:22 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4405.4 | 94776     | 23-Oct-2024 | 09:22 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4405.4 | 113208    | 23-Oct-2024 | 09:22 | x64      |
| Dtshost.exe                                                   | 2019.150.4405.4 | 89656     | 23-Oct-2024 | 09:22 | x86      |
| Dtshost.exe                                                   | 2019.150.4405.4 | 107576    | 23-Oct-2024 | 09:22 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4405.4 | 555048    | 23-Oct-2024 | 09:22 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4405.4 | 567376    | 23-Oct-2024 | 09:22 | x64      |
| Dtspipeline.dll                                               | 2019.150.4405.4 | 1120320   | 23-Oct-2024 | 09:22 | x86      |
| Dtspipeline.dll                                               | 2019.150.4405.4 | 1329232   | 23-Oct-2024 | 09:22 | x64      |
| Dtswizard.exe                                                 | 15.0.4405.4     | 890936    | 23-Oct-2024 | 09:22 | x86      |
| Dtswizard.exe                                                 | 15.0.4405.4     | 886824    | 23-Oct-2024 | 09:22 | x64      |
| Dtuparse.dll                                                  | 2019.150.4405.4 | 88120     | 23-Oct-2024 | 09:22 | x86      |
| Dtuparse.dll                                                  | 2019.150.4405.4 | 100408    | 23-Oct-2024 | 09:22 | x64      |
| Dtutil.exe                                                    | 2019.150.4405.4 | 130632    | 23-Oct-2024 | 09:22 | x86      |
| Dtutil.exe                                                    | 2019.150.4405.4 | 151096    | 23-Oct-2024 | 09:22 | x64      |
| Exceldest.dll                                                 | 2019.150.4405.4 | 235560    | 23-Oct-2024 | 09:22 | x86      |
| Exceldest.dll                                                 | 2019.150.4405.4 | 280632    | 23-Oct-2024 | 09:22 | x64      |
| Excelsrc.dll                                                  | 2019.150.4405.4 | 260152    | 23-Oct-2024 | 09:22 | x86      |
| Excelsrc.dll                                                  | 2019.150.4405.4 | 309304    | 23-Oct-2024 | 09:22 | x64      |
| Execpackagetask.dll                                           | 2019.150.4405.4 | 149560    | 23-Oct-2024 | 09:22 | x86      |
| Execpackagetask.dll                                           | 2019.150.4405.4 | 186424    | 23-Oct-2024 | 09:22 | x64      |
| Flatfiledest.dll                                              | 2019.150.4405.4 | 358440    | 23-Oct-2024 | 09:22 | x86      |
| Flatfiledest.dll                                              | 2019.150.4405.4 | 411688    | 23-Oct-2024 | 09:22 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4405.4 | 370728    | 23-Oct-2024 | 09:22 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4405.4 | 428072    | 23-Oct-2024 | 09:22 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4405.4     | 120904    | 23-Oct-2024 | 09:22 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4405.4     | 120872    | 23-Oct-2024 | 09:22 | x86      |
| Isserverexec.exe                                              | 15.0.4405.4     | 145448    | 23-Oct-2024 | 09:22 | x64      |
| Isserverexec.exe                                              | 15.0.4405.4     | 149560    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4405.4     | 116800    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4405.4     | 59456     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4405.4     | 59448     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4405.4     | 510008    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4405.4     | 510032    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4405.4     | 43064     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4405.4     | 43048     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4405.4     | 391224    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4405.4     | 59448     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4405.4     | 59472     | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4405.4     | 141376    | 23-Oct-2024 | 09:22 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4405.4     | 141376    | 23-Oct-2024 | 09:22 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4405.4     | 219192    | 23-Oct-2024 | 09:22 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4405.4 | 100392    | 23-Oct-2024 | 09:22 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4405.4 | 112696    | 23-Oct-2024 | 09:22 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.51  | 10062896  | 23-Oct-2024 | 09:22 | x64      |
| Odbcdest.dll                                                  | 2019.150.4405.4 | 321592    | 23-Oct-2024 | 09:22 | x86      |
| Odbcdest.dll                                                  | 2019.150.4405.4 | 370760    | 23-Oct-2024 | 09:22 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4405.4 | 329808    | 23-Oct-2024 | 09:22 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4405.4 | 383016    | 23-Oct-2024 | 09:22 | x64      |
| Oledbdest.dll                                                 | 2019.150.4405.4 | 239656    | 23-Oct-2024 | 09:22 | x86      |
| Oledbdest.dll                                                 | 2019.150.4405.4 | 280616    | 23-Oct-2024 | 09:22 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4405.4 | 264232    | 23-Oct-2024 | 09:22 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4405.4 | 313384    | 23-Oct-2024 | 09:22 | x64      |
| Rawdest.dll                                                   | 2019.150.4405.4 | 227384    | 23-Oct-2024 | 09:22 | x64      |
| Rawdest.dll                                                   | 2019.150.4405.4 | 190520    | 23-Oct-2024 | 09:22 | x86      |
| Rawsource.dll                                                 | 2019.150.4405.4 | 210984    | 23-Oct-2024 | 09:22 | x64      |
| Rawsource.dll                                                 | 2019.150.4405.4 | 178232    | 23-Oct-2024 | 09:22 | x86      |
| Recordsetdest.dll                                             | 2019.150.4405.4 | 202808    | 23-Oct-2024 | 09:22 | x64      |
| Recordsetdest.dll                                             | 2019.150.4405.4 | 174144    | 23-Oct-2024 | 09:22 | x86      |
| Sqlceip.exe                                                   | 15.0.4405.4     | 297000    | 23-Oct-2024 | 09:22 | x86      |
| Sqldest.dll                                                   | 2019.150.4405.4 | 239680    | 23-Oct-2024 | 09:22 | x86      |
| Sqldest.dll                                                   | 2019.150.4405.4 | 276520    | 23-Oct-2024 | 09:22 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4405.4 | 170040    | 23-Oct-2024 | 09:22 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4405.4 | 202792    | 23-Oct-2024 | 09:22 | x64      |
| Txagg.dll                                                     | 2019.150.4405.4 | 329784    | 23-Oct-2024 | 09:22 | x86      |
| Txagg.dll                                                     | 2019.150.4405.4 | 391208    | 23-Oct-2024 | 09:22 | x64      |
| Txbdd.dll                                                     | 2019.150.4405.4 | 153640    | 23-Oct-2024 | 09:22 | x86      |
| Txbdd.dll                                                     | 2019.150.4405.4 | 190504    | 23-Oct-2024 | 09:22 | x64      |
| Txbestmatch.dll                                               | 2019.150.4405.4 | 546872    | 23-Oct-2024 | 09:22 | x86      |
| Txbestmatch.dll                                               | 2019.150.4405.4 | 653368    | 23-Oct-2024 | 09:22 | x64      |
| Txcache.dll                                                   | 2019.150.4405.4 | 165952    | 23-Oct-2024 | 09:22 | x86      |
| Txcache.dll                                                   | 2019.150.4405.4 | 198712    | 23-Oct-2024 | 09:22 | x64      |
| Txcharmap.dll                                                 | 2019.150.4405.4 | 272456    | 23-Oct-2024 | 09:22 | x86      |
| Txcharmap.dll                                                 | 2019.150.4405.4 | 313400    | 23-Oct-2024 | 09:22 | x64      |
| Txcopymap.dll                                                 | 2019.150.4405.4 | 165952    | 23-Oct-2024 | 09:22 | x86      |
| Txcopymap.dll                                                 | 2019.150.4405.4 | 198712    | 23-Oct-2024 | 09:22 | x64      |
| Txdataconvert.dll                                             | 2019.150.4405.4 | 276544    | 23-Oct-2024 | 09:22 | x86      |
| Txdataconvert.dll                                             | 2019.150.4405.4 | 317496    | 23-Oct-2024 | 09:22 | x64      |
| Txderived.dll                                                 | 2019.150.4405.4 | 559168    | 23-Oct-2024 | 09:22 | x86      |
| Txderived.dll                                                 | 2019.150.4405.4 | 641064    | 23-Oct-2024 | 09:22 | x64      |
| Txfileextractor.dll                                           | 2019.150.4405.4 | 182312    | 23-Oct-2024 | 09:22 | x86      |
| Txfileextractor.dll                                           | 2019.150.4405.4 | 219192    | 23-Oct-2024 | 09:22 | x64      |
| Txfileinserter.dll                                            | 2019.150.4405.4 | 182328    | 23-Oct-2024 | 09:22 | x86      |
| Txfileinserter.dll                                            | 2019.150.4405.4 | 215096    | 23-Oct-2024 | 09:22 | x64      |
| Txgroupdups.dll                                               | 2019.150.4405.4 | 256040    | 23-Oct-2024 | 09:22 | x86      |
| Txgroupdups.dll                                               | 2019.150.4405.4 | 313400    | 23-Oct-2024 | 09:22 | x64      |
| Txlineage.dll                                                 | 2019.150.4405.4 | 129104    | 23-Oct-2024 | 09:22 | x86      |
| Txlineage.dll                                                 | 2019.150.4405.4 | 153656    | 23-Oct-2024 | 09:22 | x64      |
| Txlookup.dll                                                  | 2019.150.4405.4 | 469048    | 23-Oct-2024 | 09:22 | x86      |
| Txlookup.dll                                                  | 2019.150.4405.4 | 542776    | 23-Oct-2024 | 09:22 | x64      |
| Txmerge.dll                                                   | 2019.150.4405.4 | 202808    | 23-Oct-2024 | 09:22 | x86      |
| Txmerge.dll                                                   | 2019.150.4405.4 | 247864    | 23-Oct-2024 | 09:22 | x64      |
| Txmergejoin.dll                                               | 2019.150.4405.4 | 247864    | 23-Oct-2024 | 09:22 | x86      |
| Txmergejoin.dll                                               | 2019.150.4405.4 | 309288    | 23-Oct-2024 | 09:22 | x64      |
| Txmulticast.dll                                               | 2019.150.4405.4 | 116792    | 23-Oct-2024 | 09:22 | x86      |
| Txmulticast.dll                                               | 2019.150.4405.4 | 145448    | 23-Oct-2024 | 09:22 | x64      |
| Txpivot.dll                                                   | 2019.150.4405.4 | 206928    | 23-Oct-2024 | 09:22 | x86      |
| Txpivot.dll                                                   | 2019.150.4405.4 | 239656    | 23-Oct-2024 | 09:22 | x64      |
| Txrowcount.dll                                                | 2019.150.4405.4 | 112712    | 23-Oct-2024 | 09:22 | x86      |
| Txrowcount.dll                                                | 2019.150.4405.4 | 141368    | 23-Oct-2024 | 09:22 | x64      |
| Txsampling.dll                                                | 2019.150.4405.4 | 157736    | 23-Oct-2024 | 09:22 | x86      |
| Txsampling.dll                                                | 2019.150.4405.4 | 194616    | 23-Oct-2024 | 09:22 | x64      |
| Txscd.dll                                                     | 2019.150.4405.4 | 198736    | 23-Oct-2024 | 09:22 | x86      |
| Txscd.dll                                                     | 2019.150.4405.4 | 235576    | 23-Oct-2024 | 09:22 | x64      |
| Txsort.dll                                                    | 2019.150.4405.4 | 231480    | 23-Oct-2024 | 09:22 | x86      |
| Txsort.dll                                                    | 2019.150.4405.4 | 288808    | 23-Oct-2024 | 09:22 | x64      |
| Txsplit.dll                                                   | 2019.150.4405.4 | 550992    | 23-Oct-2024 | 09:22 | x86      |
| Txsplit.dll                                                   | 2019.150.4405.4 | 624696    | 23-Oct-2024 | 09:22 | x64      |
| Txtermextraction.dll                                          | 2019.150.4405.4 | 8644688   | 23-Oct-2024 | 09:22 | x86      |
| Txtermextraction.dll                                          | 2019.150.4405.4 | 8702008   | 23-Oct-2024 | 09:22 | x64      |
| Txtermlookup.dll                                              | 2019.150.4405.4 | 4139064   | 23-Oct-2024 | 09:22 | x86      |
| Txtermlookup.dll                                              | 2019.150.4405.4 | 4184104   | 23-Oct-2024 | 09:22 | x64      |
| Txunionall.dll                                                | 2019.150.4405.4 | 161832    | 23-Oct-2024 | 09:22 | x86      |
| Txunionall.dll                                                | 2019.150.4405.4 | 198696    | 23-Oct-2024 | 09:22 | x64      |
| Txunpivot.dll                                                 | 2019.150.4405.4 | 182328    | 23-Oct-2024 | 09:22 | x86      |
| Txunpivot.dll                                                 | 2019.150.4405.4 | 215080    | 23-Oct-2024 | 09:22 | x64      |
| Xe.dll                                                        | 2019.150.4405.4 | 632872    | 23-Oct-2024 | 09:22 | x86      |
| Xe.dll                                                        | 2019.150.4405.4 | 723000    | 23-Oct-2024 | 09:22 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1970.0     | 559688    | 23-Oct-2024 | 09:44 | x86      |
| Dmsnative.dll                                                        | 2018.150.1970.0 | 152632    | 23-Oct-2024 | 09:44 | x64      |
| Dwengineservice.dll                                                  | 15.0.1970.0     | 45016     | 23-Oct-2024 | 09:44 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 23-Oct-2024 | 09:44 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 23-Oct-2024 | 09:44 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 23-Oct-2024 | 09:44 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 23-Oct-2024 | 09:44 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 23-Oct-2024 | 09:44 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 23-Oct-2024 | 09:44 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 23-Oct-2024 | 09:44 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 23-Oct-2024 | 09:44 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 23-Oct-2024 | 09:44 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 23-Oct-2024 | 09:44 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 23-Oct-2024 | 09:44 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 23-Oct-2024 | 09:44 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 23-Oct-2024 | 09:44 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 23-Oct-2024 | 09:44 | x64      |
| Instapi150.dll                                                       | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:44 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 23-Oct-2024 | 09:44 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 23-Oct-2024 | 09:44 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 23-Oct-2024 | 09:44 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 23-Oct-2024 | 09:44 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 23-Oct-2024 | 09:44 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 23-Oct-2024 | 09:44 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 23-Oct-2024 | 09:44 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 23-Oct-2024 | 09:44 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 23-Oct-2024 | 09:44 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 23-Oct-2024 | 09:44 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1970.0     | 67656     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1970.0     | 293448    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1970.0     | 1957832   | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1970.0     | 169544    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1970.0     | 649800    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1970.0     | 246344    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1970.0     | 139336    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1970.0     | 79832     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1970.0     | 51272     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1970.0     | 88648     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1970.0     | 1129432   | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1970.0     | 80968     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1970.0     | 70616     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1970.0     | 35400     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1970.0     | 31176     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1970.0     | 46552     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1970.0     | 21464     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1970.0     | 26696     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1970.0     | 131656    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1970.0     | 86488     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1970.0     | 100936    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1970.0     | 293336    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 120280    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 138184    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 141272    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 137672    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 150488    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 139720    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 134712    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 176600    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 117704    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 136656    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1970.0     | 72776     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1970.0     | 21976     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1970.0     | 37448     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1970.0     | 129096    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1970.0     | 3064904   | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1970.0     | 3955784   | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 118344    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 133192    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 137800    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 133704    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 148440    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 134104    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 130632    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 171080    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 115272    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 132168    | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1970.0     | 67656     | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1970.0     | 2682952   | 23-Oct-2024 | 09:44 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1970.0     | 2436568   | 23-Oct-2024 | 09:44 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4405.4 | 452648    | 23-Oct-2024 | 09:44 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4405.4 | 7407672   | 23-Oct-2024 | 09:44 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 23-Oct-2024 | 09:44 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 23-Oct-2024 | 09:44 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 23-Oct-2024 | 09:44 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 23-Oct-2024 | 09:44 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 23-Oct-2024 | 09:44 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 23-Oct-2024 | 09:44 | x64      |
| Secforwarder.dll                                                     | 2019.150.4405.4 | 79928     | 23-Oct-2024 | 09:44 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1970.0 | 61392     | 23-Oct-2024 | 09:44 | x64      |
| Sqldk.dll                                                            | 2019.150.4405.4 | 3180584   | 23-Oct-2024 | 09:44 | x64      |
| Sqldumper.exe                                                        | 2019.150.4405.4 | 378920    | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 1599544   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 4171832   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 3422264   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 4167720   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 4073528   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 2226216   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 2177064   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 3831848   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 3827752   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 1542200   | 23-Oct-2024 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4405.4 | 4036664   | 23-Oct-2024 | 09:44 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 23-Oct-2024 | 09:44 | x64      |
| Sqlos.dll                                                            | 2019.150.4405.4 | 43048     | 23-Oct-2024 | 09:44 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1970.0 | 4841432   | 23-Oct-2024 | 09:44 | x64      |
| Sqltses.dll                                                          | 2019.150.4405.4 | 9119800   | 23-Oct-2024 | 09:44 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 23-Oct-2024 | 09:44 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 23-Oct-2024 | 09:44 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 23-Oct-2024 | 09:44 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 23-Oct-2024 | 09:44 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 23-Oct-2024 | 09:44 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 23-Oct-2024 | 09:44 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4405.4  | 30800     | 23-Oct-2024 | 09:20 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4405.4 | 1632312   | 23-Oct-2024 | 09:57 | x86      |
| Dtaengine.exe                                                | 2019.150.4405.4 | 219176    | 23-Oct-2024 | 09:57 | x86      |
| Dteparse.dll                                                 | 2019.150.4405.4 | 124968    | 23-Oct-2024 | 09:57 | x64      |
| Dteparse.dll                                                 | 2019.150.4405.4 | 112680    | 23-Oct-2024 | 09:57 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4405.4 | 133176    | 23-Oct-2024 | 09:57 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4405.4 | 116776    | 23-Oct-2024 | 09:57 | x86      |
| Dtepkg.dll                                                   | 2019.150.4405.4 | 149560    | 23-Oct-2024 | 09:57 | x64      |
| Dtepkg.dll                                                   | 2019.150.4405.4 | 133176    | 23-Oct-2024 | 09:57 | x86      |
| Dtexec.exe                                                   | 2019.150.4405.4 | 73768     | 23-Oct-2024 | 09:57 | x64      |
| Dtexec.exe                                                   | 2019.150.4405.4 | 65088     | 23-Oct-2024 | 09:57 | x86      |
| Dts.dll                                                      | 2019.150.4405.4 | 3143760   | 23-Oct-2024 | 09:57 | x64      |
| Dts.dll                                                      | 2019.150.4405.4 | 2762808   | 23-Oct-2024 | 09:57 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4405.4 | 501816    | 23-Oct-2024 | 09:57 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4405.4 | 444496    | 23-Oct-2024 | 09:57 | x86      |
| Dtsconn.dll                                                  | 2019.150.4405.4 | 522296    | 23-Oct-2024 | 09:57 | x64      |
| Dtsconn.dll                                                  | 2019.150.4405.4 | 432184    | 23-Oct-2024 | 09:57 | x86      |
| Dtshost.exe                                                  | 2019.150.4405.4 | 107576    | 23-Oct-2024 | 09:57 | x64      |
| Dtshost.exe                                                  | 2019.150.4405.4 | 89656     | 23-Oct-2024 | 09:57 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4405.4 | 567376    | 23-Oct-2024 | 09:57 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4405.4 | 555048    | 23-Oct-2024 | 09:57 | x86      |
| Dtspipeline.dll                                              | 2019.150.4405.4 | 1329232   | 23-Oct-2024 | 09:57 | x64      |
| Dtspipeline.dll                                              | 2019.150.4405.4 | 1120320   | 23-Oct-2024 | 09:57 | x86      |
| Dtswizard.exe                                                | 15.0.4405.4     | 886824    | 23-Oct-2024 | 09:57 | x64      |
| Dtswizard.exe                                                | 15.0.4405.4     | 890936    | 23-Oct-2024 | 09:57 | x86      |
| Dtuparse.dll                                                 | 2019.150.4405.4 | 100408    | 23-Oct-2024 | 09:57 | x64      |
| Dtuparse.dll                                                 | 2019.150.4405.4 | 88120     | 23-Oct-2024 | 09:57 | x86      |
| Dtutil.exe                                                   | 2019.150.4405.4 | 151096    | 23-Oct-2024 | 09:57 | x64      |
| Dtutil.exe                                                   | 2019.150.4405.4 | 130632    | 23-Oct-2024 | 09:57 | x86      |
| Exceldest.dll                                                | 2019.150.4405.4 | 280632    | 23-Oct-2024 | 09:57 | x64      |
| Exceldest.dll                                                | 2019.150.4405.4 | 235560    | 23-Oct-2024 | 09:57 | x86      |
| Excelsrc.dll                                                 | 2019.150.4405.4 | 309304    | 23-Oct-2024 | 09:57 | x64      |
| Excelsrc.dll                                                 | 2019.150.4405.4 | 260152    | 23-Oct-2024 | 09:57 | x86      |
| Flatfiledest.dll                                             | 2019.150.4405.4 | 358440    | 23-Oct-2024 | 09:57 | x86      |
| Flatfiledest.dll                                             | 2019.150.4405.4 | 411688    | 23-Oct-2024 | 09:57 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4405.4 | 370728    | 23-Oct-2024 | 09:57 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4405.4 | 428072    | 23-Oct-2024 | 09:57 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4405.4     | 116776    | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4405.4     | 403496    | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4405.4     | 403536    | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4405.4     | 3004488   | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4405.4     | 3004472   | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4405.4     | 43064     | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4405.4     | 43048     | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4405.4     | 59448     | 23-Oct-2024 | 09:57 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 23-Oct-2024 | 09:57 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4405.4 | 112696    | 23-Oct-2024 | 09:57 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4405.4 | 100392    | 23-Oct-2024 | 09:57 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.51  | 8280112   | 23-Oct-2024 | 09:57 | x86      |
| Oledbdest.dll                                                | 2019.150.4405.4 | 239656    | 23-Oct-2024 | 09:57 | x86      |
| Oledbdest.dll                                                | 2019.150.4405.4 | 280616    | 23-Oct-2024 | 09:57 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4405.4 | 264232    | 23-Oct-2024 | 09:57 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4405.4 | 313384    | 23-Oct-2024 | 09:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4405.4 | 51256     | 23-Oct-2024 | 09:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4405.4 | 38976     | 23-Oct-2024 | 09:57 | x86      |
| Sqlscm.dll                                                   | 2019.150.4405.4 | 88104     | 23-Oct-2024 | 09:57 | x64      |
| Sqlscm.dll                                                   | 2019.150.4405.4 | 79952     | 23-Oct-2024 | 09:57 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4405.4 | 182328    | 23-Oct-2024 | 09:57 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4405.4 | 149544    | 23-Oct-2024 | 09:57 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4405.4 | 202792    | 23-Oct-2024 | 09:57 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4405.4 | 170040    | 23-Oct-2024 | 09:57 | x86      |
| Txdataconvert.dll                                            | 2019.150.4405.4 | 276544    | 23-Oct-2024 | 09:57 | x86      |
| Txdataconvert.dll                                            | 2019.150.4405.4 | 317496    | 23-Oct-2024 | 09:57 | x64      |
| Xe.dll                                                       | 2019.150.4405.4 | 723000    | 23-Oct-2024 | 09:55 | x64      |
| Xe.dll                                                       | 2019.150.4405.4 | 632872    | 23-Oct-2024 | 09:57 | x86      |

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
