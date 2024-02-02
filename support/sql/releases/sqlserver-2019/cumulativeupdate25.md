---
title: Cumulative update 25 for SQL Server 2019 (KB5033688)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 25 (KB5033688).
ms.date: 02/15/2024
ms.custom: KB5033688
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5033688 - Cumulative Update 25 for SQL Server 2019

_Release Date:_ &nbsp; February 15, 2024  
_Version:_ &nbsp; 15.0.4355.3

## Summary

This article describes Cumulative Update package 25 (CU25) for Microsoft SQL Server 2019. This update contains 14 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 24, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4355.3**, file version: **2019.150.4355.3**
- Analysis Services - Product version: **15.0.35.45**, file version: **2018.150.35.45**

## Known issues in this update

### Issue one: Access violation when session is reset

SQL Server 2019 CU14 introduced a [fix to address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the SESSION is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.

Microsoft is working on a fix for this issue and it will be available in a future CU.

### Issue two: Read-scale availability group not displayed in dm_hadr_database_replica_cluster_states

SQL Server 2019 CU24 introduced [fix 2714260](#2714260), which causes an issue with `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups that results in the **Availability Databases** folder in SQL Server Management Studio (SSMS) not showing the databases in the availability group (AG). To mitigate this issue, roll back the patch to CU23.

Microsoft is working on a fix for this issue and it will be available in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|-------------------------------------------|----------|
| <a id=2888485>[2888485](#2888485) </a> | Fixes a performance degradation that might be encountered during the execution of the `ProcessAdd` command, which causes an increase in CPU usage and execution time.| Analysis Services| Analysis Services | Windows|
| <a id=2842754>[2842754](#2842754) </a> | Fixes an issue that might cause a recursive hierarchy to fail to load all levels.| Master Data Services| Master Data Services | Windows|
| <a id=2842801>[2842801](#2842801) </a> | Fixes an issue in which an upgrade process in Master Data Services models might fail if you set an inappropriate entity name such as "Entity". | Master Data Services| Master Data Services | Windows|
| <a id=2820559>[2820559](#2820559) </a> | Fixes an issue in which a Volume Shadow Copy Service (VSS) restore process with the **Restore with Move** feature might restore an incorrect file or fail if the file path for the `.mdf` file includes a trailing space. Additionally, you receive the following error message if the restore process fails: </br></br>NativeError: 1384 </br>The file '\<FilePath> ' cannot be overwritten. It is being used by database '\<DatabaseName>'| SQL Server Engine| Backup Restore| Windows|
| <a id=2932327>[2932327](#2932327) </a> | Fixes an issue that might cause the database file to be associated with an incorrect filegroup in the clone database created by using `DBCC CLONEDATABASE`.| SQL Server Engine| DB Management | All|
| <a id=2343632>[2343632](#2343632) </a> | Fixes an assertion failure (Location: ucsconnectionsend.cpp:103; Expression: 'm_pcscBoxcar->GetMessageCount () > 0') that you might encounter when a clusterless Always On availability group (AG) has a large number of databases.| SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=2926845>[2926845](#2926845) </a> | Fixes an issue that you encounter in `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups after you install SQL Server 2019 CU24 or later versions, which causes the **Availability Databases** folder in SQL Server Management Studio (SSMS) not to show the databases in the availability group (AG).| SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=2843374>[2843374](#2843374) </a> | Fixes a deadlock issue that you encounter when creating or updating statistics by turning off the blocking Auto Stats feature. The blocking Auto Stats feature is turned on when you use PolyBase. Turning off the blocking Auto Stats feature might cause a different query plan and execution time because query compilation isn't blocked by statistics collection. | SQL Server Engine| PolyBase| All|
| <a id=2833604>[2833604](#2833604) </a> | Adds mitigation to avoid an assertion failure (Location: lobss.cpp:707; Expression: 'FALSE' Lob not found for read) that you might encounter when you run a complex query that uses large value data types such as **varchar(max)**. </br></br>**Note**: The mitigation doesn't apply in all situations. | SQL Server Engine| Query Execution | All|
| <a id=2165090>[2165090](#2165090) </a> | Fixes an issue in which the size of the `_$update_bitmap` column of `dbo.conflict_<owner>_<table>` doesn't get updated with changes in the number of columns of the original conflicting table, which causes the Distributor agent in peer-to-peer replication fails with the following error message: </br></br>String or binary data would be truncated in table '\<TableName>', column '\<ColumnName>'. Truncated value: "." | SQL Server Engine| Replication | All|
| <a id=2612943>[2612943](#2612943) </a> | Fixes the following error that you encounter in conflict detection and in the Replication Merge Agent when converting the generation to **int**: </br></br>Error converting data type bigint to int. | SQL Server Engine| Replication | All|
| <a id=2686243>[2686243](#2686243) </a> | Fixes an issue in which the `sp_helpsubscription` stored procedure doesn't return any results after an in-place upgrade of the Publisher instance to SQL Server 2019, which causes you to fail to reinitialize the subscription with the following error message: </br></br>The Subscription does not exist. | SQL Server Engine| Replication | All|
| <a id=2922937>[2922937](#2922937) </a> | Makes the following improvements to the compressed memory dump feature: </br></br>- Adds the use of the `FILE_FLAG_NO_BUFFERING` flag to improve I/O performance and prevent excessive growth of the file cache. </br>- Adds the dynamic auto-tuning parallelism to the feature to take advantage of the available CPU cores.| SQL Server Engine| SQL OS| Windows|
| <a id=2153707>[2153707](#2153707) </a> | Adds a link to error 824 to improve the troubleshooting experience. For more information, see [MSSQLSERVER_824](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error). </br></br>Error Message: </br></br>SQL Server detected a logical consistency-based I/O error: \<Incorrect PageID>. It occurred during a \<Read/Write> of page \<PageID> in database ID \<DatabaseID> at offset \<Offset> in file '\<FileName>'. Additional messages in the SQL Server error log or operating system error log may provide more detail. This is a severe error condition that threatens database integrity and must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). This error can be caused by many factors; for more information, see https://go.microsoft.com/fwlink/?linkid=2252374. | SQL Server Engine| Storage Management| All|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU25 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5033688)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5033688-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5033688-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5033688-x64.exe| 13104EA1F986CED164CD8B00E376E982904CD147131E00729B478075CC74379E |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.45  | 292928    | 30-Jan-2024 | 17:34 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.45      | 758328    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 175552    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 199616    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 202176    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 198608    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 214976    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197568    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 193472    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 252464    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 174016    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.45      | 197072    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.45      | 1098688   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.45      | 567344    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 54736     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59328     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 59840     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58816     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 61888     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58320     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 67632     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 53696     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.45      | 58304     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17976     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17984     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 18992     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.45      | 17968     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 30-Jan-2024 | 17:34 | x86      |
| Msmdctr.dll                                               | 2018.150.35.45  | 38448     | 30-Jan-2024 | 17:35 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.45  | 66260928  | 30-Jan-2024 | 17:34 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.45  | 47785008  | 30-Jan-2024 | 17:35 | x86      |
| Msmdpump.dll                                              | 2018.150.35.45  | 10187200  | 30-Jan-2024 | 17:34 | x64      |
| Msmdredir.dll                                             | 2018.150.35.45  | 7957440   | 30-Jan-2024 | 17:35 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16848     | 30-Jan-2024 | 17:35 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 30-Jan-2024 | 17:34 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 30-Jan-2024 | 17:34 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 30-Jan-2024 | 17:34 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17456     | 30-Jan-2024 | 17:34 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 30-Jan-2024 | 17:34 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 17344     | 30-Jan-2024 | 17:35 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 18480     | 30-Jan-2024 | 17:35 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16832     | 30-Jan-2024 | 17:35 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.45      | 16944     | 30-Jan-2024 | 17:34 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.45  | 65798080  | 30-Jan-2024 | 17:34 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 833600    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1628224   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1454128   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1643064   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1608768   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1001536   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 992816    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1537080   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1521728   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 811056    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.45  | 1596480   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 832560    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1624640   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1451064   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1637944   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1604672   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 998960    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 991280    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1532992   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1518144   | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 810032    | 30-Jan-2024 | 17:35 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.45  | 1591856   | 30-Jan-2024 | 17:35 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.45  | 10186176  | 30-Jan-2024 | 17:34 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.45  | 8280120   | 30-Jan-2024 | 17:35 | x86      |
| Msolap.dll                                                | 2018.150.35.45  | 11013072  | 30-Jan-2024 | 17:34 | x64      |
| Msolap.dll                                                | 2018.150.35.45  | 8607168   | 30-Jan-2024 | 17:35 | x86      |
| Msolui.dll                                                | 2018.150.35.45  | 306752    | 30-Jan-2024 | 17:34 | x64      |
| Msolui.dll                                                | 2018.150.35.45  | 286256    | 30-Jan-2024 | 17:35 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 30-Jan-2024 | 17:34 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 30-Jan-2024 | 17:34 | x64      |
| Sqlboot.dll                                               | 2019.150.4355.3 | 214976    | 30-Jan-2024 | 17:35 | x64      |
| Sqlceip.exe                                               | 15.0.4355.3     | 296912    | 30-Jan-2024 | 17:35 | x86      |
| Sqldumper.exe                                             | 2019.150.4355.3 | 321576    | 30-Jan-2024 | 17:35 | x86      |
| Sqldumper.exe                                             | 2019.150.4355.3 | 378832    | 30-Jan-2024 | 17:35 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 30-Jan-2024 | 17:34 | x86      |
| Tmapi.dll                                                 | 2018.150.35.45  | 6178352   | 30-Jan-2024 | 17:35 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.45  | 4917712   | 30-Jan-2024 | 17:35 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.45  | 1184816   | 30-Jan-2024 | 17:35 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.45  | 6807104   | 30-Jan-2024 | 17:35 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.45  | 26025520  | 30-Jan-2024 | 17:35 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.45  | 35460032  | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4355.3 | 182312    | 30-Jan-2024 | 17:40 | x64      |
| Batchparser.dll                      | 2019.150.4355.3 | 165928    | 30-Jan-2024 | 17:40 | x86      |
| Instapi150.dll                       | 2019.150.4355.3 | 75712     | 30-Jan-2024 | 17:40 | x86      |
| Instapi150.dll                       | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 17:40 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4355.3 | 104384    | 30-Jan-2024 | 17:40 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4355.3 | 88016     | 30-Jan-2024 | 17:40 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4355.3     | 550848    | 30-Jan-2024 | 17:40 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4355.3     | 550864    | 30-Jan-2024 | 17:40 | x86      |
| Msasxpress.dll                       | 2018.150.35.45  | 27184     | 30-Jan-2024 | 17:40 | x86      |
| Msasxpress.dll                       | 2018.150.35.45  | 32304     | 30-Jan-2024 | 17:40 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4355.3 | 75816     | 30-Jan-2024 | 17:40 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4355.3 | 92200     | 30-Jan-2024 | 17:40 | x64      |
| Sqldumper.exe                        | 2019.150.4355.3 | 321576    | 30-Jan-2024 | 17:40 | x86      |
| Sqldumper.exe                        | 2019.150.4355.3 | 378832    | 30-Jan-2024 | 17:40 | x64      |
| Sqlftacct.dll                        | 2019.150.4355.3 | 59432     | 30-Jan-2024 | 17:40 | x86      |
| Sqlftacct.dll                        | 2019.150.4355.3 | 79824     | 30-Jan-2024 | 17:40 | x64      |
| Sqlmanager.dll                       | 2019.150.4355.3 | 743464    | 30-Jan-2024 | 17:40 | x86      |
| Sqlmanager.dll                       | 2019.150.4355.3 | 878648    | 30-Jan-2024 | 17:40 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4355.3 | 432080    | 30-Jan-2024 | 17:40 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4355.3 | 378816    | 30-Jan-2024 | 17:40 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4355.3 | 276416    | 30-Jan-2024 | 17:40 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4355.3 | 358336    | 30-Jan-2024 | 17:40 | x64      |
| Svrenumapi150.dll                    | 2019.150.4355.3 | 1161152   | 30-Jan-2024 | 17:40 | x64      |
| Svrenumapi150.dll                    | 2019.150.4355.3 | 911296    | 30-Jan-2024 | 17:40 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4355.3  | 600104    | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4355.3  | 1857472   | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4355.3 | 137256    | 30-Jan-2024 | 17:35 | x86      |
| Dreplaycommon.dll     | 2019.150.4355.3 | 667688    | 30-Jan-2024 | 17:35 | x86      |
| Dreplayutil.dll       | 2019.150.4355.3 | 305192    | 30-Jan-2024 | 17:35 | x86      |
| Instapi150.dll        | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 17:35 | x64      |
| Sqlresourceloader.dll | 2019.150.4355.3 | 38848     | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4355.3 | 667688    | 30-Jan-2024 | 17:35 | x86      |
| Dreplaycontroller.exe | 2019.150.4355.3 | 366536    | 30-Jan-2024 | 17:35 | x86      |
| Instapi150.dll        | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 17:35 | x64      |
| Sqlresourceloader.dll | 2019.150.4355.3 | 38848     | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4355.3 | 4658112   | 30-Jan-2024 | 18:38 | x64      |
| Aetm-enclave.dll                           | 2019.150.4355.3 | 4612648   | 30-Jan-2024 | 18:38 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4355.3 | 4932416   | 30-Jan-2024 | 18:38 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4355.3 | 4874568   | 30-Jan-2024 | 18:38 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 30-Jan-2024 | 18:38 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 30-Jan-2024 | 18:38 | x64      |
| Batchparser.dll                            | 2019.150.4355.3 | 182312    | 30-Jan-2024 | 18:38 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 30-Jan-2024 | 18:38 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 30-Jan-2024 | 18:38 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 30-Jan-2024 | 18:38 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 30-Jan-2024 | 18:38 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4355.3 | 280528    | 30-Jan-2024 | 18:38 | x64      |
| Dcexec.exe                                 | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 18:38 | x64      |
| Fssres.dll                                 | 2019.150.4355.3 | 96208     | 30-Jan-2024 | 18:38 | x64      |
| Hadrres.dll                                | 2019.150.4355.3 | 206784    | 30-Jan-2024 | 18:38 | x64      |
| Hkcompile.dll                              | 2019.150.4355.3 | 1292224   | 30-Jan-2024 | 18:38 | x64      |
| Hkengine.dll                               | 2019.150.4355.3 | 5793832   | 30-Jan-2024 | 18:38 | x64      |
| Hkruntime.dll                              | 2019.150.4355.3 | 182312    | 30-Jan-2024 | 18:38 | x64      |
| Hktempdb.dll                               | 2019.150.4355.3 | 63528     | 30-Jan-2024 | 18:38 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 30-Jan-2024 | 18:38 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4355.3     | 235576    | 30-Jan-2024 | 18:38 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4355.3 | 391104    | 30-Jan-2024 | 18:38 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4355.3 | 325672    | 30-Jan-2024 | 18:38 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4355.3 | 92096     | 30-Jan-2024 | 18:38 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 30-Jan-2024 | 18:38 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 30-Jan-2024 | 18:38 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 30-Jan-2024 | 18:38 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 30-Jan-2024 | 18:38 | x64      |
| Qds.dll                                    | 2019.150.4355.3 | 1189944   | 30-Jan-2024 | 18:38 | x64      |
| Rsfxft.dll                                 | 2019.150.4355.3 | 51152     | 30-Jan-2024 | 18:38 | x64      |
| Secforwarder.dll                           | 2019.150.4355.3 | 79808     | 30-Jan-2024 | 18:38 | x64      |
| Sqagtres.dll                               | 2019.150.4355.3 | 88104     | 30-Jan-2024 | 18:38 | x64      |
| Sqlaamss.dll                               | 2019.150.4355.3 | 108480    | 30-Jan-2024 | 18:38 | x64      |
| Sqlaccess.dll                              | 2019.150.4355.3 | 493504    | 30-Jan-2024 | 18:38 | x64      |
| Sqlagent.exe                               | 2019.150.4355.3 | 731072    | 30-Jan-2024 | 18:38 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4355.3 | 79928     | 30-Jan-2024 | 18:38 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4355.3 | 71736     | 30-Jan-2024 | 18:38 | x86      |
| Sqlboot.dll                                | 2019.150.4355.3 | 214976    | 30-Jan-2024 | 18:38 | x64      |
| Sqlceip.exe                                | 15.0.4355.3     | 296912    | 30-Jan-2024 | 18:38 | x86      |
| Sqlcmdss.dll                               | 2019.150.4355.3 | 88104     | 30-Jan-2024 | 18:38 | x64      |
| Sqlctr150.dll                              | 2019.150.4355.3 | 145344    | 30-Jan-2024 | 18:38 | x64      |
| Sqlctr150.dll                              | 2019.150.4355.3 | 116776    | 30-Jan-2024 | 18:38 | x86      |
| Sqldk.dll                                  | 2019.150.4355.3 | 3180480   | 30-Jan-2024 | 18:38 | x64      |
| Sqldtsss.dll                               | 2019.150.4355.3 | 108584    | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 1595432   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3508160   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3704768   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4171712   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4286400   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3418152   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3586000   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4163520   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4020160   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4069304   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 2226112   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 2176960   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3876816   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3549120   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4024256   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3827648   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3823568   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3618768   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3508160   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 1542096   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 3913664   | 30-Jan-2024 | 18:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4355.3 | 4036560   | 30-Jan-2024 | 18:38 | x64      |
| Sqllang.dll                                | 2019.150.4355.3 | 40048680  | 30-Jan-2024 | 18:38 | x64      |
| Sqlmin.dll                                 | 2019.150.4355.3 | 40636352  | 30-Jan-2024 | 18:38 | x64      |
| Sqlolapss.dll                              | 2019.150.4355.3 | 108584    | 30-Jan-2024 | 18:38 | x64      |
| Sqlos.dll                                  | 2019.150.4355.3 | 42944     | 30-Jan-2024 | 18:38 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4355.3 | 84008     | 30-Jan-2024 | 18:38 | x64      |
| Sqlrepss.dll                               | 2019.150.4355.3 | 88120     | 30-Jan-2024 | 18:38 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4355.3 | 51136     | 30-Jan-2024 | 18:38 | x64      |
| Sqlscm.dll                                 | 2019.150.4355.3 | 88104     | 30-Jan-2024 | 18:38 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4355.3 | 38864     | 30-Jan-2024 | 18:38 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4355.3 | 5806032   | 30-Jan-2024 | 18:38 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4355.3 | 673728    | 30-Jan-2024 | 18:38 | x64      |
| Sqlservr.exe                               | 2019.150.4355.3 | 628776    | 30-Jan-2024 | 18:38 | x64      |
| Sqlsvc.dll                                 | 2019.150.4355.3 | 182208    | 30-Jan-2024 | 18:38 | x64      |
| Sqltses.dll                                | 2019.150.4355.3 | 9119784   | 30-Jan-2024 | 18:38 | x64      |
| Sqsrvres.dll                               | 2019.150.4355.3 | 280616    | 30-Jan-2024 | 18:38 | x64      |
| Stretchcodegen.exe                         | 15.0.4355.3     | 59432     | 30-Jan-2024 | 18:38 | x86      |
| Svl.dll                                    | 2019.150.4355.3 | 161728    | 30-Jan-2024 | 18:38 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 30-Jan-2024 | 18:38 | x64      |
| Xe.dll                                     | 2019.150.4355.3 | 722984    | 30-Jan-2024 | 18:38 | x64      |
| Xpadsi.exe                                 | 2019.150.4355.3 | 116792    | 30-Jan-2024 | 18:38 | x64      |
| Xplog70.dll                                | 2019.150.4355.3 | 92112     | 30-Jan-2024 | 18:38 | x64      |
| Xpqueue.dll                                | 2019.150.4355.3 | 92096     | 30-Jan-2024 | 18:38 | x64      |
| Xprepl.dll                                 | 2019.150.4355.3 | 120768    | 30-Jan-2024 | 18:38 | x64      |
| Xpstar.dll                                 | 2019.150.4355.3 | 473128    | 30-Jan-2024 | 18:38 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4355.3 | 182312    | 30-Jan-2024 | 17:34 | x64      |
| Batchparser.dll                                              | 2019.150.4355.3 | 165928    | 30-Jan-2024 | 17:34 | x86      |
| Commanddest.dll                                              | 2019.150.4355.3 | 264128    | 30-Jan-2024 | 17:35 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4355.3 | 227384    | 30-Jan-2024 | 17:35 | x64      |
| Distrib.exe                                                  | 2019.150.4355.3 | 243752    | 30-Jan-2024 | 17:34 | x64      |
| Dteparse.dll                                                 | 2019.150.4355.3 | 124968    | 30-Jan-2024 | 17:35 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4355.3 | 133064    | 30-Jan-2024 | 17:34 | x64      |
| Dtepkg.dll                                                   | 2019.150.4355.3 | 149544    | 30-Jan-2024 | 17:35 | x64      |
| Dtexec.exe                                                   | 2019.150.4355.3 | 73664     | 30-Jan-2024 | 17:35 | x64      |
| Dts.dll                                                      | 2019.150.4355.3 | 3143720   | 30-Jan-2024 | 17:35 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4355.3 | 501696    | 30-Jan-2024 | 17:35 | x64      |
| Dtsconn.dll                                                  | 2019.150.4355.3 | 522280    | 30-Jan-2024 | 17:35 | x64      |
| Dtshost.exe                                                  | 2019.150.4355.3 | 107560    | 30-Jan-2024 | 17:35 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4355.3 | 567232    | 30-Jan-2024 | 17:34 | x64      |
| Dtspipeline.dll                                              | 2019.150.4355.3 | 1329088   | 30-Jan-2024 | 17:35 | x64      |
| Dtswizard.exe                                                | 15.0.4355.3     | 886736    | 30-Jan-2024 | 17:35 | x64      |
| Dtuparse.dll                                                 | 2019.150.4355.3 | 100304    | 30-Jan-2024 | 17:34 | x64      |
| Dtutil.exe                                                   | 2019.150.4355.3 | 151096    | 30-Jan-2024 | 17:34 | x64      |
| Exceldest.dll                                                | 2019.150.4355.3 | 280528    | 30-Jan-2024 | 17:35 | x64      |
| Excelsrc.dll                                                 | 2019.150.4355.3 | 309200    | 30-Jan-2024 | 17:35 | x64      |
| Execpackagetask.dll                                          | 2019.150.4355.3 | 186304    | 30-Jan-2024 | 17:34 | x64      |
| Flatfiledest.dll                                             | 2019.150.4355.3 | 411600    | 30-Jan-2024 | 17:35 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4355.3 | 428072    | 30-Jan-2024 | 17:35 | x64      |
| Logread.exe                                                  | 2019.150.4355.3 | 722880    | 30-Jan-2024 | 17:34 | x64      |
| Mergetxt.dll                                                 | 2019.150.4355.3 | 75832     | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4355.3     | 59448     | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4355.3     | 42960     | 30-Jan-2024 | 17:35 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4355.3     | 391104    | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4355.3 | 1697728   | 30-Jan-2024 | 17:34 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4355.3 | 1640488   | 30-Jan-2024 | 17:34 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4355.3     | 550864    | 30-Jan-2024 | 17:34 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4355.3 | 112592    | 30-Jan-2024 | 17:34 | x64      |
| Msgprox.dll                                                  | 2019.150.4355.3 | 300992    | 30-Jan-2024 | 17:34 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 2729960   | 30-Jan-2024 | 17:34 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 153560    | 30-Jan-2024 | 17:35 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4355.3 | 1497144   | 30-Jan-2024 | 17:35 | x64      |
| Oledbdest.dll                                                | 2019.150.4355.3 | 280616    | 30-Jan-2024 | 17:35 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4355.3 | 313280    | 30-Jan-2024 | 17:35 | x64      |
| Osql.exe                                                     | 2019.150.4355.3 | 92112     | 30-Jan-2024 | 17:35 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4355.3 | 501800    | 30-Jan-2024 | 17:34 | x64      |
| Rawdest.dll                                                  | 2019.150.4355.3 | 227368    | 30-Jan-2024 | 17:34 | x64      |
| Rawsource.dll                                                | 2019.150.4355.3 | 210896    | 30-Jan-2024 | 17:34 | x64      |
| Rdistcom.dll                                                 | 2019.150.4355.3 | 915512    | 30-Jan-2024 | 17:34 | x64      |
| Recordsetdest.dll                                            | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 17:34 | x64      |
| Repldp.dll                                                   | 2019.150.4355.3 | 313280    | 30-Jan-2024 | 17:34 | x64      |
| Replerrx.dll                                                 | 2019.150.4355.3 | 182328    | 30-Jan-2024 | 17:34 | x64      |
| Replisapi.dll                                                | 2019.150.4355.3 | 395200    | 30-Jan-2024 | 17:34 | x64      |
| Replmerg.exe                                                 | 2019.150.4355.3 | 563256    | 30-Jan-2024 | 17:34 | x64      |
| Replprov.dll                                                 | 2019.150.4355.3 | 862144    | 30-Jan-2024 | 17:34 | x64      |
| Replrec.dll                                                  | 2019.150.4355.3 | 1034280   | 30-Jan-2024 | 17:34 | x64      |
| Replsub.dll                                                  | 2019.150.4355.3 | 473144    | 30-Jan-2024 | 17:34 | x64      |
| Replsync.dll                                                 | 2019.150.4355.3 | 165928    | 30-Jan-2024 | 17:34 | x64      |
| Spresolv.dll                                                 | 2019.150.4355.3 | 276416    | 30-Jan-2024 | 17:34 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4355.3 | 264232    | 30-Jan-2024 | 17:34 | x64      |
| Sqldiag.exe                                                  | 2019.150.4355.3 | 1140688   | 30-Jan-2024 | 17:34 | x64      |
| Sqldistx.dll                                                 | 2019.150.4355.3 | 251840    | 30-Jan-2024 | 17:34 | x64      |
| Sqllogship.exe                                               | 15.0.4355.3     | 104384    | 30-Jan-2024 | 17:35 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4355.3 | 399296    | 30-Jan-2024 | 17:34 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4355.3 | 51136     | 30-Jan-2024 | 17:34 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4355.3 | 38848     | 30-Jan-2024 | 17:35 | x86      |
| Sqlscm.dll                                                   | 2019.150.4355.3 | 79808     | 30-Jan-2024 | 17:35 | x86      |
| Sqlscm.dll                                                   | 2019.150.4355.3 | 88104     | 30-Jan-2024 | 17:35 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4355.3 | 182208    | 30-Jan-2024 | 17:34 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4355.3 | 149560    | 30-Jan-2024 | 17:35 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 17:35 | x64      |
| Ssradd.dll                                                   | 2019.150.4355.3 | 84008     | 30-Jan-2024 | 17:34 | x64      |
| Ssravg.dll                                                   | 2019.150.4355.3 | 84008     | 30-Jan-2024 | 17:34 | x64      |
| Ssrdown.dll                                                  | 2019.150.4355.3 | 75816     | 30-Jan-2024 | 17:34 | x64      |
| Ssrmax.dll                                                   | 2019.150.4355.3 | 84024     | 30-Jan-2024 | 17:34 | x64      |
| Ssrmin.dll                                                   | 2019.150.4355.3 | 84008     | 30-Jan-2024 | 17:34 | x64      |
| Ssrpub.dll                                                   | 2019.150.4355.3 | 79808     | 30-Jan-2024 | 17:34 | x64      |
| Ssrup.dll                                                    | 2019.150.4355.3 | 75832     | 30-Jan-2024 | 17:34 | x64      |
| Txagg.dll                                                    | 2019.150.4355.3 | 391208    | 30-Jan-2024 | 17:35 | x64      |
| Txbdd.dll                                                    | 2019.150.4355.3 | 194600    | 30-Jan-2024 | 17:35 | x64      |
| Txdatacollector.dll                                          | 2019.150.4355.3 | 473144    | 30-Jan-2024 | 17:35 | x64      |
| Txdataconvert.dll                                            | 2019.150.4355.3 | 317376    | 30-Jan-2024 | 17:35 | x64      |
| Txderived.dll                                                | 2019.150.4355.3 | 640960    | 30-Jan-2024 | 17:34 | x64      |
| Txlookup.dll                                                 | 2019.150.4355.3 | 542760    | 30-Jan-2024 | 17:35 | x64      |
| Txmerge.dll                                                  | 2019.150.4355.3 | 247760    | 30-Jan-2024 | 17:35 | x64      |
| Txmergejoin.dll                                              | 2019.150.4355.3 | 309288    | 30-Jan-2024 | 17:34 | x64      |
| Txmulticast.dll                                              | 2019.150.4355.3 | 145360    | 30-Jan-2024 | 17:35 | x64      |
| Txrowcount.dll                                               | 2019.150.4355.3 | 141352    | 30-Jan-2024 | 17:35 | x64      |
| Txsort.dll                                                   | 2019.150.4355.3 | 288824    | 30-Jan-2024 | 17:34 | x64      |
| Txsplit.dll                                                  | 2019.150.4355.3 | 624680    | 30-Jan-2024 | 17:34 | x64      |
| Txunionall.dll                                               | 2019.150.4355.3 | 198592    | 30-Jan-2024 | 17:34 | x64      |
| Xe.dll                                                       | 2019.150.4355.3 | 722984    | 30-Jan-2024 | 17:34 | x64      |
| Xmlsub.dll                                                   | 2019.150.4355.3 | 297000    | 30-Jan-2024 | 17:34 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |     Date    |  Time | Platform |
|:------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4355.3 | 96192     | 30-Jan-2024 | 17:35 | x64      |
| Exthost.exe        | 2019.150.4355.3 | 239568    | 30-Jan-2024 | 17:35 | x64      |
| Launchpad.exe      | 2019.150.4355.3 | 1230784   | 30-Jan-2024 | 17:35 | x64      |
| Sqlsatellite.dll   | 2019.150.4355.3 | 1025984   | 30-Jan-2024 | 17:35 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4355.3 | 686120    | 30-Jan-2024 | 17:35 | x64      |
| Fdhost.exe     | 2019.150.4355.3 | 129080    | 30-Jan-2024 | 17:35 | x64      |
| Fdlauncher.exe | 2019.150.4355.3 | 79912     | 30-Jan-2024 | 17:35 | x64      |
| Sqlft150ph.dll | 2019.150.4355.3 | 92112     | 30-Jan-2024 | 17:35 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4355.3  | 30672     | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4355.3 | 227368    | 30-Jan-2024 | 17:46 | x86      |
| Commanddest.dll                                               | 2019.150.4355.3 | 264128    | 30-Jan-2024 | 17:46 | x64      |
| Dteparse.dll                                                  | 2019.150.4355.3 | 112576    | 30-Jan-2024 | 17:46 | x86      |
| Dteparse.dll                                                  | 2019.150.4355.3 | 124968    | 30-Jan-2024 | 17:46 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4355.3 | 116672    | 30-Jan-2024 | 17:46 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4355.3 | 133064    | 30-Jan-2024 | 17:46 | x64      |
| Dtepkg.dll                                                    | 2019.150.4355.3 | 133176    | 30-Jan-2024 | 17:46 | x86      |
| Dtepkg.dll                                                    | 2019.150.4355.3 | 149544    | 30-Jan-2024 | 17:46 | x64      |
| Dtexec.exe                                                    | 2019.150.4355.3 | 64960     | 30-Jan-2024 | 17:46 | x86      |
| Dtexec.exe                                                    | 2019.150.4355.3 | 73664     | 30-Jan-2024 | 17:46 | x64      |
| Dts.dll                                                       | 2019.150.4355.3 | 2762688   | 30-Jan-2024 | 17:46 | x86      |
| Dts.dll                                                       | 2019.150.4355.3 | 3143720   | 30-Jan-2024 | 17:46 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4355.3 | 444456    | 30-Jan-2024 | 17:46 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4355.3 | 501696    | 30-Jan-2024 | 17:46 | x64      |
| Dtsconn.dll                                                   | 2019.150.4355.3 | 432168    | 30-Jan-2024 | 17:46 | x86      |
| Dtsconn.dll                                                   | 2019.150.4355.3 | 522280    | 30-Jan-2024 | 17:46 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4355.3 | 113192    | 30-Jan-2024 | 17:46 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4355.3 | 94760     | 30-Jan-2024 | 17:46 | x86      |
| Dtshost.exe                                                   | 2019.150.4355.3 | 107560    | 30-Jan-2024 | 17:46 | x64      |
| Dtshost.exe                                                   | 2019.150.4355.3 | 89536     | 30-Jan-2024 | 17:46 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4355.3 | 555048    | 30-Jan-2024 | 17:46 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4355.3 | 567232    | 30-Jan-2024 | 17:46 | x64      |
| Dtspipeline.dll                                               | 2019.150.4355.3 | 1120296   | 30-Jan-2024 | 17:46 | x86      |
| Dtspipeline.dll                                               | 2019.150.4355.3 | 1329088   | 30-Jan-2024 | 17:46 | x64      |
| Dtswizard.exe                                                 | 15.0.4355.3     | 886736    | 30-Jan-2024 | 17:46 | x64      |
| Dtswizard.exe                                                 | 15.0.4355.3     | 890936    | 30-Jan-2024 | 17:46 | x86      |
| Dtuparse.dll                                                  | 2019.150.4355.3 | 100304    | 30-Jan-2024 | 17:46 | x64      |
| Dtuparse.dll                                                  | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 17:46 | x86      |
| Dtutil.exe                                                    | 2019.150.4355.3 | 130616    | 30-Jan-2024 | 17:46 | x86      |
| Dtutil.exe                                                    | 2019.150.4355.3 | 151096    | 30-Jan-2024 | 17:46 | x64      |
| Exceldest.dll                                                 | 2019.150.4355.3 | 235576    | 30-Jan-2024 | 17:46 | x86      |
| Exceldest.dll                                                 | 2019.150.4355.3 | 280528    | 30-Jan-2024 | 17:46 | x64      |
| Excelsrc.dll                                                  | 2019.150.4355.3 | 260152    | 30-Jan-2024 | 17:46 | x86      |
| Excelsrc.dll                                                  | 2019.150.4355.3 | 309200    | 30-Jan-2024 | 17:46 | x64      |
| Execpackagetask.dll                                           | 2019.150.4355.3 | 149544    | 30-Jan-2024 | 17:46 | x86      |
| Execpackagetask.dll                                           | 2019.150.4355.3 | 186304    | 30-Jan-2024 | 17:46 | x64      |
| Flatfiledest.dll                                              | 2019.150.4355.3 | 358440    | 30-Jan-2024 | 17:46 | x86      |
| Flatfiledest.dll                                              | 2019.150.4355.3 | 411600    | 30-Jan-2024 | 17:46 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4355.3 | 370624    | 30-Jan-2024 | 17:46 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4355.3 | 428072    | 30-Jan-2024 | 17:46 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4355.3     | 120768    | 30-Jan-2024 | 17:46 | x86      |
| Isserverexec.exe                                              | 15.0.4355.3     | 145344    | 30-Jan-2024 | 17:46 | x64      |
| Isserverexec.exe                                              | 15.0.4355.3     | 149440    | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4355.3     | 116792    | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4355.3     | 59448     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4355.3     | 59328     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4355.3     | 509904    | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4355.3     | 42960     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4355.3     | 43048     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4355.3     | 391104    | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4355.3     | 59328     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4355.3     | 59336     | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4355.3     | 141352    | 30-Jan-2024 | 17:46 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4355.3     | 141248    | 30-Jan-2024 | 17:46 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4355.3     | 219184    | 30-Jan-2024 | 17:46 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4355.3 | 100392    | 30-Jan-2024 | 17:46 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4355.3 | 112592    | 30-Jan-2024 | 17:46 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.45  | 10062904  | 30-Jan-2024 | 17:46 | x64      |
| Odbcdest.dll                                                  | 2019.150.4355.3 | 321488    | 30-Jan-2024 | 17:46 | x86      |
| Odbcdest.dll                                                  | 2019.150.4355.3 | 370624    | 30-Jan-2024 | 17:46 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4355.3 | 329664    | 30-Jan-2024 | 17:46 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4355.3 | 383016    | 30-Jan-2024 | 17:46 | x64      |
| Oledbdest.dll                                                 | 2019.150.4355.3 | 239552    | 30-Jan-2024 | 17:46 | x86      |
| Oledbdest.dll                                                 | 2019.150.4355.3 | 280616    | 30-Jan-2024 | 17:46 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4355.3 | 264248    | 30-Jan-2024 | 17:46 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4355.3 | 313280    | 30-Jan-2024 | 17:46 | x64      |
| Rawdest.dll                                                   | 2019.150.4355.3 | 227368    | 30-Jan-2024 | 17:46 | x64      |
| Rawdest.dll                                                   | 2019.150.4355.3 | 190520    | 30-Jan-2024 | 17:46 | x86      |
| Rawsource.dll                                                 | 2019.150.4355.3 | 178128    | 30-Jan-2024 | 17:46 | x86      |
| Rawsource.dll                                                 | 2019.150.4355.3 | 210896    | 30-Jan-2024 | 17:46 | x64      |
| Recordsetdest.dll                                             | 2019.150.4355.3 | 174016    | 30-Jan-2024 | 17:46 | x86      |
| Recordsetdest.dll                                             | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 17:46 | x64      |
| Sqlceip.exe                                                   | 15.0.4355.3     | 296912    | 30-Jan-2024 | 17:46 | x86      |
| Sqldest.dll                                                   | 2019.150.4355.3 | 239552    | 30-Jan-2024 | 17:46 | x86      |
| Sqldest.dll                                                   | 2019.150.4355.3 | 276520    | 30-Jan-2024 | 17:46 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4355.3 | 170040    | 30-Jan-2024 | 17:46 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 17:46 | x64      |
| Txagg.dll                                                     | 2019.150.4355.3 | 391208    | 30-Jan-2024 | 17:46 | x64      |
| Txagg.dll                                                     | 2019.150.4355.3 | 329768    | 30-Jan-2024 | 17:46 | x86      |
| Txbdd.dll                                                     | 2019.150.4355.3 | 157632    | 30-Jan-2024 | 17:46 | x86      |
| Txbdd.dll                                                     | 2019.150.4355.3 | 194600    | 30-Jan-2024 | 17:46 | x64      |
| Txbestmatch.dll                                               | 2019.150.4355.3 | 546768    | 30-Jan-2024 | 17:46 | x86      |
| Txbestmatch.dll                                               | 2019.150.4355.3 | 653352    | 30-Jan-2024 | 17:46 | x64      |
| Txcache.dll                                                   | 2019.150.4355.3 | 174032    | 30-Jan-2024 | 17:46 | x86      |
| Txcache.dll                                                   | 2019.150.4355.3 | 198592    | 30-Jan-2024 | 17:46 | x64      |
| Txcharmap.dll                                                 | 2019.150.4355.3 | 272320    | 30-Jan-2024 | 17:46 | x86      |
| Txcharmap.dll                                                 | 2019.150.4355.3 | 313280    | 30-Jan-2024 | 17:46 | x64      |
| Txcopymap.dll                                                 | 2019.150.4355.3 | 202792    | 30-Jan-2024 | 17:46 | x64      |
| Txcopymap.dll                                                 | 2019.150.4355.3 | 174120    | 30-Jan-2024 | 17:46 | x86      |
| Txdataconvert.dll                                             | 2019.150.4355.3 | 317376    | 30-Jan-2024 | 17:46 | x64      |
| Txdataconvert.dll                                             | 2019.150.4355.3 | 276520    | 30-Jan-2024 | 17:46 | x86      |
| Txderived.dll                                                 | 2019.150.4355.3 | 640960    | 30-Jan-2024 | 17:46 | x64      |
| Txderived.dll                                                 | 2019.150.4355.3 | 559040    | 30-Jan-2024 | 17:46 | x86      |
| Txfileextractor.dll                                           | 2019.150.4355.3 | 182208    | 30-Jan-2024 | 17:46 | x86      |
| Txfileextractor.dll                                           | 2019.150.4355.3 | 219176    | 30-Jan-2024 | 17:46 | x64      |
| Txfileinserter.dll                                            | 2019.150.4355.3 | 182208    | 30-Jan-2024 | 17:46 | x86      |
| Txfileinserter.dll                                            | 2019.150.4355.3 | 215080    | 30-Jan-2024 | 17:46 | x64      |
| Txgroupdups.dll                                               | 2019.150.4355.3 | 255936    | 30-Jan-2024 | 17:46 | x86      |
| Txgroupdups.dll                                               | 2019.150.4355.3 | 313384    | 30-Jan-2024 | 17:46 | x64      |
| Txlineage.dll                                                 | 2019.150.4355.3 | 128976    | 30-Jan-2024 | 17:46 | x86      |
| Txlineage.dll                                                 | 2019.150.4355.3 | 153656    | 30-Jan-2024 | 17:46 | x64      |
| Txlookup.dll                                                  | 2019.150.4355.3 | 469032    | 30-Jan-2024 | 17:46 | x86      |
| Txlookup.dll                                                  | 2019.150.4355.3 | 542760    | 30-Jan-2024 | 17:46 | x64      |
| Txmerge.dll                                                   | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 17:46 | x86      |
| Txmerge.dll                                                   | 2019.150.4355.3 | 247760    | 30-Jan-2024 | 17:46 | x64      |
| Txmergejoin.dll                                               | 2019.150.4355.3 | 247864    | 30-Jan-2024 | 17:46 | x86      |
| Txmergejoin.dll                                               | 2019.150.4355.3 | 309288    | 30-Jan-2024 | 17:46 | x64      |
| Txmulticast.dll                                               | 2019.150.4355.3 | 120784    | 30-Jan-2024 | 17:46 | x86      |
| Txmulticast.dll                                               | 2019.150.4355.3 | 145360    | 30-Jan-2024 | 17:46 | x64      |
| Txpivot.dll                                                   | 2019.150.4355.3 | 206904    | 30-Jan-2024 | 17:46 | x86      |
| Txpivot.dll                                                   | 2019.150.4355.3 | 239568    | 30-Jan-2024 | 17:46 | x64      |
| Txrowcount.dll                                                | 2019.150.4355.3 | 112576    | 30-Jan-2024 | 17:46 | x86      |
| Txrowcount.dll                                                | 2019.150.4355.3 | 141352    | 30-Jan-2024 | 17:46 | x64      |
| Txsampling.dll                                                | 2019.150.4355.3 | 157632    | 30-Jan-2024 | 17:46 | x86      |
| Txsampling.dll                                                | 2019.150.4355.3 | 194600    | 30-Jan-2024 | 17:46 | x64      |
| Txscd.dll                                                     | 2019.150.4355.3 | 198712    | 30-Jan-2024 | 17:46 | x86      |
| Txscd.dll                                                     | 2019.150.4355.3 | 235576    | 30-Jan-2024 | 17:46 | x64      |
| Txsort.dll                                                    | 2019.150.4355.3 | 231376    | 30-Jan-2024 | 17:46 | x86      |
| Txsort.dll                                                    | 2019.150.4355.3 | 288824    | 30-Jan-2024 | 17:46 | x64      |
| Txsplit.dll                                                   | 2019.150.4355.3 | 550848    | 30-Jan-2024 | 17:46 | x86      |
| Txsplit.dll                                                   | 2019.150.4355.3 | 624680    | 30-Jan-2024 | 17:46 | x64      |
| Txtermextraction.dll                                          | 2019.150.4355.3 | 8701904   | 30-Jan-2024 | 17:46 | x64      |
| Txtermextraction.dll                                          | 2019.150.4355.3 | 8644544   | 30-Jan-2024 | 17:46 | x86      |
| Txtermlookup.dll                                              | 2019.150.4355.3 | 4139048   | 30-Jan-2024 | 17:46 | x86      |
| Txtermlookup.dll                                              | 2019.150.4355.3 | 4184000   | 30-Jan-2024 | 17:46 | x64      |
| Txunionall.dll                                                | 2019.150.4355.3 | 161744    | 30-Jan-2024 | 17:46 | x86      |
| Txunionall.dll                                                | 2019.150.4355.3 | 198592    | 30-Jan-2024 | 17:46 | x64      |
| Txunpivot.dll                                                 | 2019.150.4355.3 | 182312    | 30-Jan-2024 | 17:46 | x86      |
| Txunpivot.dll                                                 | 2019.150.4355.3 | 215080    | 30-Jan-2024 | 17:46 | x64      |
| Xe.dll                                                        | 2019.150.4355.3 | 632768    | 30-Jan-2024 | 17:46 | x86      |
| Xe.dll                                                        | 2019.150.4355.3 | 722984    | 30-Jan-2024 | 17:46 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1964.0     | 559536    | 30-Jan-2024 | 18:26 | x86      |
| Dmsnative.dll                                                        | 2018.150.1964.0 | 152496    | 30-Jan-2024 | 18:26 | x64      |
| Dwengineservice.dll                                                  | 15.0.1964.0     | 45016     | 30-Jan-2024 | 18:26 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 30-Jan-2024 | 18:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 30-Jan-2024 | 18:26 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 30-Jan-2024 | 18:26 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 30-Jan-2024 | 18:26 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 30-Jan-2024 | 18:26 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 30-Jan-2024 | 18:26 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 30-Jan-2024 | 18:26 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 30-Jan-2024 | 18:26 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 30-Jan-2024 | 18:26 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 30-Jan-2024 | 18:26 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 30-Jan-2024 | 18:26 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 30-Jan-2024 | 18:26 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 30-Jan-2024 | 18:26 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 30-Jan-2024 | 18:26 | x64      |
| Instapi150.dll                                                       | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 18:26 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 30-Jan-2024 | 18:26 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 30-Jan-2024 | 18:26 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 30-Jan-2024 | 18:26 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 30-Jan-2024 | 18:26 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 30-Jan-2024 | 18:26 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 30-Jan-2024 | 18:26 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 30-Jan-2024 | 18:26 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 30-Jan-2024 | 18:26 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 30-Jan-2024 | 18:26 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 30-Jan-2024 | 18:26 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1964.0     | 67544     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1964.0     | 293328    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1964.0     | 1957848   | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1964.0     | 169392    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1964.0     | 649648    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1964.0     | 246192    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1964.0     | 139184    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1964.0     | 79776     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1964.0     | 51104     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1964.0     | 88496     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1964.0     | 1129392   | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1964.0     | 80816     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1964.0     | 70616     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1964.0     | 35248     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1964.0     | 31192     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1964.0     | 46552     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1964.0     | 21448     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1964.0     | 26528     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1964.0     | 131536    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1964.0     | 86488     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1964.0     | 100824    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1964.0     | 293328    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 120240    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 138160    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 141232    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 137680    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 150448    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 139696    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 134608    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 176600    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 117664    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 136656    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1964.0     | 72664     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1964.0     | 21936     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1964.0     | 37280     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1964.0     | 128928    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1964.0     | 3064752   | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1964.0     | 3955672   | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 118232    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133024    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 137688    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133584    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 148440    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 134088    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 130464    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 170912    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 115144    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 132056    | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1964.0     | 67544     | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1964.0     | 2682800   | 30-Jan-2024 | 18:26 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1964.0     | 2436568   | 30-Jan-2024 | 18:26 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4355.3 | 452664    | 30-Jan-2024 | 18:26 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4355.3 | 7407552   | 30-Jan-2024 | 18:26 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 30-Jan-2024 | 18:26 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 30-Jan-2024 | 18:26 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 30-Jan-2024 | 18:26 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 30-Jan-2024 | 18:26 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 30-Jan-2024 | 18:26 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 30-Jan-2024 | 18:26 | x64      |
| Secforwarder.dll                                                     | 2019.150.4355.3 | 79808     | 30-Jan-2024 | 18:26 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1964.0 | 61400     | 30-Jan-2024 | 18:26 | x64      |
| Sqldk.dll                                                            | 2019.150.4355.3 | 3180480   | 30-Jan-2024 | 18:26 | x64      |
| Sqldumper.exe                                                        | 2019.150.4355.3 | 378832    | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 1595432   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 4171712   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 3418152   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 4163520   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 4069304   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 2226112   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 2176960   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 3827648   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 3823568   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 1542096   | 30-Jan-2024 | 18:26 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4355.3 | 4036560   | 30-Jan-2024 | 18:26 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 30-Jan-2024 | 18:26 | x64      |
| Sqlos.dll                                                            | 2019.150.4355.3 | 42944     | 30-Jan-2024 | 18:26 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1964.0 | 4841432   | 30-Jan-2024 | 18:26 | x64      |
| Sqltses.dll                                                          | 2019.150.4355.3 | 9119784   | 30-Jan-2024 | 18:26 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 30-Jan-2024 | 18:26 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 30-Jan-2024 | 18:26 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 30-Jan-2024 | 18:26 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 30-Jan-2024 | 18:26 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 30-Jan-2024 | 18:26 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 30-Jan-2024 | 18:26 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4355.3  | 30656     | 30-Jan-2024 | 17:35 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4355.3 | 1632312   | 30-Jan-2024 | 18:09 | x86      |
| Dtaengine.exe                                                | 2019.150.4355.3 | 219072    | 30-Jan-2024 | 18:09 | x86      |
| Dteparse.dll                                                 | 2019.150.4355.3 | 112576    | 30-Jan-2024 | 18:09 | x86      |
| Dteparse.dll                                                 | 2019.150.4355.3 | 124968    | 30-Jan-2024 | 18:09 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4355.3 | 116672    | 30-Jan-2024 | 18:09 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4355.3 | 133064    | 30-Jan-2024 | 18:09 | x64      |
| Dtepkg.dll                                                   | 2019.150.4355.3 | 133176    | 30-Jan-2024 | 18:09 | x86      |
| Dtepkg.dll                                                   | 2019.150.4355.3 | 149544    | 30-Jan-2024 | 18:09 | x64      |
| Dtexec.exe                                                   | 2019.150.4355.3 | 64960     | 30-Jan-2024 | 18:09 | x86      |
| Dtexec.exe                                                   | 2019.150.4355.3 | 73664     | 30-Jan-2024 | 18:09 | x64      |
| Dts.dll                                                      | 2019.150.4355.3 | 2762688   | 30-Jan-2024 | 18:09 | x86      |
| Dts.dll                                                      | 2019.150.4355.3 | 3143720   | 30-Jan-2024 | 18:09 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4355.3 | 444456    | 30-Jan-2024 | 18:09 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4355.3 | 501696    | 30-Jan-2024 | 18:09 | x64      |
| Dtsconn.dll                                                  | 2019.150.4355.3 | 432168    | 30-Jan-2024 | 18:09 | x86      |
| Dtsconn.dll                                                  | 2019.150.4355.3 | 522280    | 30-Jan-2024 | 18:09 | x64      |
| Dtshost.exe                                                  | 2019.150.4355.3 | 107560    | 30-Jan-2024 | 18:09 | x64      |
| Dtshost.exe                                                  | 2019.150.4355.3 | 89536     | 30-Jan-2024 | 18:09 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4355.3 | 555048    | 30-Jan-2024 | 18:09 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4355.3 | 567232    | 30-Jan-2024 | 18:09 | x64      |
| Dtspipeline.dll                                              | 2019.150.4355.3 | 1329088   | 30-Jan-2024 | 18:09 | x64      |
| Dtspipeline.dll                                              | 2019.150.4355.3 | 1120296   | 30-Jan-2024 | 18:09 | x86      |
| Dtswizard.exe                                                | 15.0.4355.3     | 886736    | 30-Jan-2024 | 18:09 | x64      |
| Dtswizard.exe                                                | 15.0.4355.3     | 890936    | 30-Jan-2024 | 18:09 | x86      |
| Dtuparse.dll                                                 | 2019.150.4355.3 | 100304    | 30-Jan-2024 | 18:09 | x64      |
| Dtuparse.dll                                                 | 2019.150.4355.3 | 88000     | 30-Jan-2024 | 18:09 | x86      |
| Dtutil.exe                                                   | 2019.150.4355.3 | 130616    | 30-Jan-2024 | 18:09 | x86      |
| Dtutil.exe                                                   | 2019.150.4355.3 | 151096    | 30-Jan-2024 | 18:09 | x64      |
| Exceldest.dll                                                | 2019.150.4355.3 | 280528    | 30-Jan-2024 | 18:09 | x64      |
| Exceldest.dll                                                | 2019.150.4355.3 | 235576    | 30-Jan-2024 | 18:09 | x86      |
| Excelsrc.dll                                                 | 2019.150.4355.3 | 260152    | 30-Jan-2024 | 18:09 | x86      |
| Excelsrc.dll                                                 | 2019.150.4355.3 | 309200    | 30-Jan-2024 | 18:09 | x64      |
| Flatfiledest.dll                                             | 2019.150.4355.3 | 358440    | 30-Jan-2024 | 18:09 | x86      |
| Flatfiledest.dll                                             | 2019.150.4355.3 | 411600    | 30-Jan-2024 | 18:09 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4355.3 | 370624    | 30-Jan-2024 | 18:09 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4355.3 | 428072    | 30-Jan-2024 | 18:09 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4355.3     | 116672    | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4355.3     | 403512    | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4355.3     | 3004352   | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4355.3     | 3004456   | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4355.3     | 42960     | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4355.3     | 43048     | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4355.3     | 59336     | 30-Jan-2024 | 18:09 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 30-Jan-2024 | 18:09 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4355.3 | 112592    | 30-Jan-2024 | 18:09 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4355.3 | 100392    | 30-Jan-2024 | 18:09 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.45  | 8280120   | 30-Jan-2024 | 18:09 | x86      |
| Oledbdest.dll                                                | 2019.150.4355.3 | 239552    | 30-Jan-2024 | 18:09 | x86      |
| Oledbdest.dll                                                | 2019.150.4355.3 | 280616    | 30-Jan-2024 | 18:09 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4355.3 | 264248    | 30-Jan-2024 | 18:09 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4355.3 | 313280    | 30-Jan-2024 | 18:09 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4355.3 | 51136     | 30-Jan-2024 | 18:09 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4355.3 | 38848     | 30-Jan-2024 | 18:09 | x86      |
| Sqlscm.dll                                                   | 2019.150.4355.3 | 79808     | 30-Jan-2024 | 18:09 | x86      |
| Sqlscm.dll                                                   | 2019.150.4355.3 | 88104     | 30-Jan-2024 | 18:09 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4355.3 | 149560    | 30-Jan-2024 | 18:09 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4355.3 | 182208    | 30-Jan-2024 | 18:09 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4355.3 | 170040    | 30-Jan-2024 | 18:09 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4355.3 | 202688    | 30-Jan-2024 | 18:09 | x64      |
| Txdataconvert.dll                                            | 2019.150.4355.3 | 276520    | 30-Jan-2024 | 18:09 | x86      |
| Txdataconvert.dll                                            | 2019.150.4355.3 | 317376    | 30-Jan-2024 | 18:09 | x64      |
| Xe.dll                                                       | 2019.150.4355.3 | 632768    | 30-Jan-2024 | 18:09 | x86      |
| Xe.dll                                                       | 2019.150.4355.3 | 722984    | 30-Jan-2024 | 18:09 | x64      |

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
