---
title: Cumulative update 7 for SQL Server 2019 (KB4570012)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 7 (KB4570012).
ms.date: 06/30/2023
ms.custom: KB4570012
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4570012 - Cumulative Update 7 for SQL Server 2019

_Release Date:_ &nbsp; September 02, 2020  
_Version:_ &nbsp; 15.0.4063.15

## Summary

This article describes Cumulative Update package 7 (CU7) for Microsoft SQL Server 2019. This update contains 50 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 6, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4063.15**, file version: **2019.150.4063.15**
- Analysis Services - Product version: **15.0.34.22**, file version: **2018.150.34.22**

## Known issues in this update

There's a known issue that affects using database snapshots in SQL Server 2019 CU7. Notice that using `DBCC CHECKDB` is also affected because this generates a database snapshot. This issue is fixed in SQL Server 2019 CU8. To get this fix, apply SQL Server 2019 CU8 or any later SQL Server 2019 CU release.

- If you downloaded the CU7 package file before September 23, 2020, we recommend that you don't install it. Please move to SQL Server CU8 or a later CU release.

- If you have already applied SQL Server 2019 CU7, please uninstall it and move to SQL Server CU8 or a later CU release.

- If you have already applied SQL Server 2019 CU7, and you created a database snapshot, plan to drop the database snapshot, and then apply SQL Server 2019 CU8 or a later CU release before you re-create your database snapshot.

More details will be made available in the [SQL Release Blog](https://techcommunity.microsoft.com/t5/sql-server-blog/cumulative-update-7-for-sql-server-2019-rtm-removed/ba-p/1629317).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13607136">[13607136](#13607136)</a> | Error occurs when mashup is used to import from Active Directory (AD) using the default M query generated from the connection wizard. </br></br>Key Expression Error: The key didn't match any rows in the table | Analysis Services | Analysis Services | Windows |
| <a id="13607145">[13607145](#13607145)</a> | Fixes an error that occurs when a session cube is created on a database and you try to query from that session cube. The following error is received when you query the session cube: </br></br>Server: The operation has been cancelled because there is not enough memory available for the application. If using a 32-bit version of the product, consider upgrading to the 64-bit version or increasing the amount of memory available on the machine. | Analysis Services | Analysis Services | Windows |
| <a id="13607144">[13607144](#13607144)</a> | Fixes long duration for Integration Services Project deployment through powershell by improving search of operation messages in deployment process. | Integration Services | Server | Windows |
| <a id="13585628">[13585628](#13585628)</a> | Fixes intermittent connection issue with SSIS package executions when expression is used for both connection string and password of a connection manager. | Integration Services | Tasks_Components | Windows |
| <a id="13626378">[13626378](#13626378)</a> | Fixes an issue in MDS Filtered results where the user isn't returned to page 1 and the page count isn't updated until returning to page 1. | Master Data Services | Client | Windows |
| <a id="13583547">[13583547](#13583547)</a> | [FIX: Error occurs when you try to filter the members of an entity for numeric values less than or greater than '0' in MDS 2019 (KB4577561)](https://support.microsoft.com/help/4577561) | Master Data Services | Master Data Services | Windows |
| <a id="13606017">[13606017](#13606017)</a> | Unable to change the `DateTime`/`Number` attributes to `NULL` in Master Data Services (MDS). | Master Data Services | Master Data Services | Windows |
| <a id="13607160">[13607160](#13607160)</a> | Column description disappears after exporting/importing models through `MDSModelDeploy` for an approval required entity in SQL Server 2019. | Master Data Services | Master Data Services | Windows |
| <a id="13632226">[13632226](#13632226)</a> | Fixes an issue in Master Data Services 2019 where you can't input multiline content in text attributes. | Master Data Services | Master Data Services | Windows |
| <a id="13512207">[13512207](#13512207)</a> | [FIX: SQL Server fails to start when remote admin connections are enabled and IPV6 is disabled on the host (KB4575453)](https://support.microsoft.com/help/4575453) | SQL Server Connectivity | Protocols | Linux |
| <a id="13598931">[13598931](#13598931)</a> | [FIX: Concurrent inserts against tables with columnstore indexes may cause queries to hang in SQL Server 2016 and 2019 (KB4561305)](https://support.microsoft.com/help/4561305) | SQL Server Engine | Column Stores | All |
| <a id="13669080">[13669080](#13669080)</a> | [FIX: Inconsistency occurs when ghost rows are inserted into mapping index rowset (KB4577836)](https://support.microsoft.com/help/4577836) | SQL Server Engine | Column Stores | All |
| <a id="13606684">[13606684](#13606684)</a> | When you run a `SELECT` query in Read Committed Snapshot Isolation (RCSI) on Clustered Columnstore Index (CCI) on a table in SQL Server 2019, the query may return incorrect number of rows under rare conditions. | SQL Server Engine | Column Stores | All |
| <a id="13586253">[13586253](#13586253)</a> | [FIX: Error 8992 occurs when you run DBCC CHECKDB on cloned database in SQL Server 2019 (KB4578110)](https://support.microsoft.com/help/4578110) | SQL Server Engine | DB Management | Windows |
| <a id="13643805">[13643805](#13643805)</a> | [FIX: Add language and extension directories to the PATH environment variable in SQL Server 2019 (KB4577594)](https://support.microsoft.com/help/4577594) | SQL Server Engine | Extensibility | All |
| <a id="13619478">[13619478](#13619478)</a> | Updates RSetup with the updated FWLINK version 3.5.2.777. | SQL Server Engine | Extensibility | Windows |
| <a id="13643390">[13643390](#13643390)</a> | Fixes failure of SQL Server Extensibility Runtimes Setup on FIPS compliant servers. | SQL Server Engine | Extensibility | All |
| <a id="13647889">[13647889](#13647889)</a> | Python and R CAB files for SQL Server Machine Learning Services on Windows and `mssql-mlservices` packages on Linux are updated to version 9.4.7.958. On Windows, "Cannot resume session with terminated pooled process" error is fixed while launching Python/R runtimes. On Linux, this update enables successful installation of `mssql-mlservices-mlm-r` package on RHEL8. | SQL Server Engine | Extensibility | All |
| <a id="13598899">[13598899](#13598899)</a> | When you concurrently create sub directories in a FileTable directory, a deadlock may occur internally in the SQL Server Engine and all subsequent requests to FileTable directories and files may not respond. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="13607142">[13607142](#13607142)</a> | [FIX: Intermittent Availability Group failover occurs as AG helper connection times out while connecting to SQL Server (KB4569424)](https://support.microsoft.com/help/4569424) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="13567739">[13567739](#13567739)</a> | Fixes an issue to reduce parallel redo thread shutdown and startup thread messages in error log on servers with fewer cores and more idle databases. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13598933">[13598933](#13598933)</a> | FIX: Assertion error occurs on the mirror server during redo process hitting. </br></br>Assertion: File: \<FilePath\FileName>, line = \<LineNumber> Failed Assertion = 'result == LCK_OK' | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13607140">[13607140](#13607140)</a> | This update adds detailed error information to the pacemaker log when pacemaker agent fails to connect to SQL Server resource to obtain health status. | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="13607141">[13607141](#13607141)</a> | Fixes an assertion exception that occurs when you query the DMV `sys.dm_hadr_automatic_seeding`. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13627086">[13627086](#13627086)</a> | Updates the Zulu JRE version to `zulu11.37.18-sa-jre11.0.6.101`. | SQL Server Engine | Linux | Linux |
| <a id="13607135">[13607135](#13607135)</a> | [FIX: Assertion failure occurs when you try to insert record into a page in fully logged mode in SQL Server 2017 and 2019 (KB4567166)](https://support.microsoft.com/help/4567166) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13621665">[13621665](#13621665)</a> | [FIX: Incorrect results occur when you run PolyBase query to read text files from Hadoop in SQL Server 2019 (KB4574801)](https://support.microsoft.com/help/4574801) | SQL Server Engine | PolyBase | All |
| <a id="13628489">[13628489](#13628489)</a> | [FIX: Widerow insert to an external table is not supported when the row width is more than 32K in SQL Server 2019 (KB4577591)](https://support.microsoft.com/help/4577591) | SQL Server Engine | PolyBase | Linux |
| <a id="13634075">[13634075](#13634075)</a> | [FIX: Error occurs when row width is less than DMS buffer size of 32K and an incorrect return path is chosen in SQL Server 2019 (KB4577590)](https://support.microsoft.com/help/4577590) | SQL Server Engine | PolyBase | Linux |
| <a id="13578549">[13578549](#13578549)</a> | Improvement: Enables RLS feature for PolyBase by default in SQL Server 2019. | SQL Server Engine | PolyBase | Linux |
| <a id="13643332">[13643332](#13643332)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="13647491">[13647491](#13647491)</a> | [FIX: Table Variable Deferred Compilation feature on SQL Server 2019 database remains enabled when database compatibility level is 140 or lower (KB4576778)](https://support.microsoft.com/help/4576778) | SQL Server Engine | Programmability | All |
| <a id="13598907">[13598907](#13598907)</a> | When you run an `ALTER` command `WITH ROLLBACK IMMEDIATE`, the rollback can trigger before the command is processed, thus rolling back transactions even if the `ALTER` itself fails due to lack of permissions. This fix makes sure that the rollback is processed only after the `ALTER` command completes. | SQL Server Engine | Programmability | Windows |
| <a id="13598937">[13598937](#13598937)</a> | Access violation exception occurs when a query that references a non-exsting partition function is executed. | SQL Server Engine | Query Execution | Windows |
| <a id="13616383">[13616383](#13616383)</a> | Fixes a performance issue when a query outputs `NULL` values following a semi join in SQL Server 2019 for a database with UTF8. | SQL Server Engine | Query Execution | Windows |
| <a id="13667907">[13667907](#13667907)</a> | Under (rare) certain circumstances, memory grant recalculation can cause an access violation. | SQL Server Engine | Query Execution | Windows |
| <a id="13607143">[13607143](#13607143)</a> | `DELETE` statement returns Foreign Key check constraint error even when `REFERENCE` table has no matching rows. </br></br>Msg 547, Level 16, State 0, Line \<LineNumber> </br>The DELETE statement conflicted with the REFERENCE constraint "\<ConstraintName>". </br>The conflict occurred in database "\<DatabaseName>", table "\<TableName>", column '\<ColumnName>'. </br>The statement has been terminated. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13607158">[13607158](#13607158)</a> | This update fixes an issue with `sys.dm_db_stats_histogram` not showing `NULL` value histogram step. | SQL Server Engine | Query Optimizer | All |
| <a id="13598911">[13598911](#13598911)</a> | [FIX: Upgrade script may fail if you use an Always On high availability group as a secondary replica in SQL Server 2016 and 2019 (KB4563115)](https://support.microsoft.com/help/4563115) | SQL Server Engine | Replication | Windows |
| <a id="13607134">[13607134](#13607134)</a> | [FIX: Transactional replication publications can support URL type device to initialize subscriptions from backups in Azure Blob Storage in SQL Server 2017 (KB4569425)](https://support.microsoft.com/help/4569425) | SQL Server Engine | Replication | Windows |
| <a id="13636909">[13636909](#13636909)</a> | [FIX: Couldn't disable "change data capture" if any column is encrypted by "Always Encrypted" feature of SQL Server (KB4034376)](https://support.microsoft.com/help/4034376) | SQL Server Engine | Replication | All |
| <a id="13598905">[13598905](#13598905)</a> | When a replication error such as deadlock occurs, random ID is inserted in `MSRepl_Errors` table while it should be just incremented by 1 from the previous ID value. This cumulative update (CU) fixes the issue and the `MSRepl_Errors` will insert entries with row ID incremented by 1 instead of using some random value. | SQL Server Engine | Replication | Windows |
| <a id="13598909">[13598909](#13598909)</a> | [FIX: Full-Text search auto crawl stops when AG goes offline in SQL Server (KB4511771)](https://support.microsoft.com/help/4511771) | SQL Server Engine | Search | Windows |
| <a id="13635355">[13635355](#13635355)</a> | [FIX: Error occurs when using DBCC operations while TDE key change happens in SQL Server 2019 (KB4578395)](https://support.microsoft.com/help/4578395) | SQL Server Engine | Security Infrastructure | All |
| <a id="13491695">[13491695](#13491695)</a> | [FIX: Unable to restore SQL Server database from previous versions on NVMe device partitioned in 4K block size (KB4578011)](https://support.microsoft.com/help/4578011) | SQL Server Engine | Storage Management | Linux |
| <a id="13598885">[13598885](#13598885)</a> | `DBCC CHECKDB` reports corruption on spatial index incorrectly if base table has a column called ID. | SQL Server Engine | Storage Management | Windows |
| <a id="13598925">[13598925](#13598925)</a> | When `DBCC CHECKTABLE`, `CHECKFILEGROUP` and `CHECKDB` commands are issued against a database with table that contains columnstore index located on read-only non-primary filegroup, you may receive the following error: </br></br>Msg 8921, Level 16, State 1, Line \<LineNumber> </br>Check terminated. A failure was detected while collecting facts. Possibly tempdb out of space or a system table is inconsistent. Check previous errors. | SQL Server Engine | Storage Management | Windows |
| <a id="13598927">[13598927](#13598927)</a> | [FIX: Distributed transactions may experience long waits with DTC_STATE wait type in SQL Server 2016 and 2019 (KB4560183)](https://support.microsoft.com/help/4560183) | SQL Server Engine | Transaction Services | Windows |
| <a id="13598896">[13598896](#13598896)</a> | SSRS 2016 URLs are case-sensitive after applying Security update GDRs: [KB4532097](https://support.microsoft.com/help/4532097) and [KB4535706](https://support.microsoft.com/help/4535706). | SQL Server Engine | XML | Windows |
| <a id="13602806">[13602806](#13602806)</a> | Fixes the Japanese translation for "**State**" in SQL Configuration Manager. | SQL Setup | Patching | Windows |

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

You can verify the download by computing the hash of the *SQLServer2019-KB4570012-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4570012-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4570012-x64.exe| 8E2745560B973F98E6FB6A902DD99103D58DDDBD6CDB4AE5B912B02531B89C3F |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.22   | 291736    | 15-Aug-20 | 11:18 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 15-Aug-20 | 11:18 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.22       | 757144    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 174488    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 198552    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 201112    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 197528    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 213912    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 196504    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 192408    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 251280    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 172952    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.22       | 195992    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.22       | 1097112   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.22       | 479632    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 53656     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 58264     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 58768     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 57744     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 60808     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 57240     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 57232     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 66448     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 52624     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.22       | 57232     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16784     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16784     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16792     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16784     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16784     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16792     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16784     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 17808     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16792     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.22       | 16792     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 15-Aug-20 | 11:18 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 15-Aug-20 | 11:18 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 15-Aug-20 | 11:18 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 15-Aug-20 | 11:18 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 15-Aug-20 | 11:18 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 15-Aug-20 | 11:18 | x86      |
| Msmdctr.dll                                               | 2018.150.34.22   | 37264     | 15-Aug-20 | 11:18 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.22   | 47777672  | 15-Aug-20 | 11:18 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.22   | 66282896  | 15-Aug-20 | 11:18 | x64      |
| Msmdpump.dll                                              | 2018.150.34.22   | 10187672  | 15-Aug-20 | 11:18 | x64      |
| Msmdredir.dll                                             | 2018.150.34.22   | 7955856   | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 15760     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 15760     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 16272     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 15768     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 16280     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 16280     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 16272     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 17288     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 15760     | 15-Aug-20 | 11:18 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.22       | 15760     | 15-Aug-20 | 11:18 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.22   | 65819544  | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 832400    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1627016   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1452944   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1641872   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1607576   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1000328   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 991632    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1535888   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1520536   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 809880    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.22   | 1595280   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 831384    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1623448   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1449880   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1636760   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1603480   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 997784    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 990104    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1531800   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1516952   | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 808856    | 15-Aug-20 | 11:18 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.22   | 1590680   | 15-Aug-20 | 11:18 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.22   | 10185112  | 15-Aug-20 | 11:18 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.22   | 8277912   | 15-Aug-20 | 11:18 | x86      |
| Msolap.dll                                                | 2018.150.34.22   | 11014552  | 15-Aug-20 | 11:18 | x64      |
| Msolap.dll                                                | 2018.150.34.22   | 8607128   | 15-Aug-20 | 11:18 | x86      |
| Msolui.dll                                                | 2018.150.34.22   | 285080    | 15-Aug-20 | 11:18 | x86      |
| Msolui.dll                                                | 2018.150.34.22   | 305560    | 15-Aug-20 | 11:18 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 15-Aug-20 | 11:18 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 15-Aug-20 | 11:18 | x64      |
| Sqlboot.dll                                               | 2019.150.4063.15 | 213904    | 15-Aug-20 | 11:18 | x64      |
| Sqlceip.exe                                               | 15.0.4063.15     | 283536    | 15-Aug-20 | 11:18 | x86      |
| Sqldumper.exe                                             | 2019.150.4063.15 | 152464    | 15-Aug-20 | 11:18 | x86      |
| Sqldumper.exe                                             | 2019.150.4063.15 | 185232    | 15-Aug-20 | 11:18 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 15-Aug-20 | 11:18 | x86      |
| Tmapi.dll                                                 | 2018.150.34.22   | 6177168   | 15-Aug-20 | 11:18 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.22   | 4916632   | 15-Aug-20 | 11:18 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.22   | 1183640   | 15-Aug-20 | 11:18 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.22   | 6802320   | 15-Aug-20 | 11:18 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.22   | 26024840  | 15-Aug-20 | 11:18 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.22   | 35459472  | 15-Aug-20 | 11:18 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4063.15 | 74640     | 15-Aug-20 | 11:19 | x86      |
| Instapi150.dll                       | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:19 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4063.15 | 86920     | 15-Aug-20 | 11:19 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:19 | x64      |
| Msasxpress.dll                       | 2018.150.34.22   | 26000     | 15-Aug-20 | 11:19 | x86      |
| Msasxpress.dll                       | 2018.150.34.22   | 31128     | 15-Aug-20 | 11:19 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:19 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4063.15 | 74640     | 15-Aug-20 | 11:19 | x86      |
| Sqldumper.exe                        | 2019.150.4063.15 | 152464    | 15-Aug-20 | 11:19 | x86      |
| Sqldumper.exe                        | 2019.150.4063.15 | 185232    | 15-Aug-20 | 11:19 | x64      |
| Sqlftacct.dll                        | 2019.150.4063.15 | 78728     | 15-Aug-20 | 11:19 | x64      |
| Sqlftacct.dll                        | 2019.150.4063.15 | 58256     | 15-Aug-20 | 11:19 | x86      |
| Sqlmanager.dll                       | 2019.150.4063.15 | 742288    | 15-Aug-20 | 11:19 | x86      |
| Sqlmanager.dll                       | 2019.150.4063.15 | 877456    | 15-Aug-20 | 11:19 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4063.15 | 430992    | 15-Aug-20 | 11:19 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4063.15 | 377744    | 15-Aug-20 | 11:19 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4063.15 | 275344    | 15-Aug-20 | 11:19 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4063.15 | 357264    | 15-Aug-20 | 11:19 | x64      |
| Svrenumapi150.dll                    | 2019.150.4063.15 | 1160080   | 15-Aug-20 | 11:19 | x64      |
| Svrenumapi150.dll                    | 2019.150.4063.15 | 910224    | 15-Aug-20 | 11:19 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4063.15 | 136080    | 15-Aug-20 | 11:18 | x86      |
| Dreplaycommon.dll     | 2019.150.4063.15 | 665488    | 15-Aug-20 | 11:18 | x86      |
| Dreplayutil.dll       | 2019.150.4063.15 | 304016    | 15-Aug-20 | 11:18 | x86      |
| Instapi150.dll        | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:18 | x64      |
| Sqlresourceloader.dll | 2019.150.4063.15 | 37776     | 15-Aug-20 | 11:18 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4063.15 | 665488    | 15-Aug-20 | 11:19 | x86      |
| Dreplaycontroller.exe | 2019.150.4063.15 | 365456    | 15-Aug-20 | 11:19 | x86      |
| Instapi150.dll        | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:19 | x64      |
| Sqlresourceloader.dll | 2019.150.4063.15 | 37776     | 15-Aug-20 | 11:19 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4063.15 | 4652944   | 15-Aug-20 | 12:39 | x64      |
| Aetm-enclave.dll                           | 2019.150.4063.15 | 4604264   | 15-Aug-20 | 12:39 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4063.15 | 4924640   | 15-Aug-20 | 12:39 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4063.15 | 4866256   | 15-Aug-20 | 12:39 | x64      |
| Azureattest.dll                            | 10.0.18965.1000  | 255056    | 15-Aug-20 | 12:39 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000  | 97528     | 15-Aug-20 | 12:39 | x64      |
| C1.dll                                     | 19.16.27034.0    | 2438520   | 15-Aug-20 | 12:39 | x64      |
| C2.dll                                     | 19.16.27034.0    | 7239032   | 15-Aug-20 | 12:39 | x64      |
| Cl.exe                                     | 19.16.27034.0    | 424360    | 15-Aug-20 | 12:39 | x64      |
| Clui.dll                                   | 19.16.27034.0    | 541048    | 15-Aug-20 | 12:39 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4063.15 | 279440    | 15-Aug-20 | 12:39 | x64      |
| Dcexec.exe                                 | 2019.150.4063.15 | 86928     | 15-Aug-20 | 12:39 | x64      |
| Fssres.dll                                 | 2019.150.4063.15 | 95112     | 15-Aug-20 | 12:39 | x64      |
| Hadrres.dll                                | 2019.150.4063.15 | 201608    | 15-Aug-20 | 12:39 | x64      |
| Hkcompile.dll                              | 2019.150.4063.15 | 1291152   | 15-Aug-20 | 12:39 | x64      |
| Hkengine.dll                               | 2019.150.4063.15 | 5784464   | 15-Aug-20 | 12:39 | x64      |
| Hkruntime.dll                              | 2019.150.4063.15 | 181136    | 15-Aug-20 | 12:39 | x64      |
| Hktempdb.dll                               | 2019.150.4063.15 | 62352     | 15-Aug-20 | 12:39 | x64      |
| Link.exe                                   | 14.16.27034.0    | 1707936   | 15-Aug-20 | 12:39 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4063.15     | 234384    | 15-Aug-20 | 12:39 | x86      |
| Msobj140.dll                               | 14.16.27034.0    | 134008    | 15-Aug-20 | 12:39 | x64      |
| Mspdb140.dll                               | 14.16.27034.0    | 632184    | 15-Aug-20 | 12:39 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0    | 632184    | 15-Aug-20 | 12:39 | x64      |
| Msvcp140.dll                               | 14.16.27034.0    | 628200    | 15-Aug-20 | 12:39 | x64      |
| Qds.dll                                    | 2019.150.4063.15 | 1184656   | 15-Aug-20 | 12:39 | x64      |
| Rsfxft.dll                                 | 2019.150.4063.15 | 50064     | 15-Aug-20 | 12:39 | x64      |
| Secforwarder.dll                           | 2019.150.4063.15 | 78736     | 15-Aug-20 | 12:39 | x64      |
| Sqagtres.dll                               | 2019.150.4063.15 | 86920     | 15-Aug-20 | 12:39 | x64      |
| Sqlaamss.dll                               | 2019.150.4063.15 | 107400    | 15-Aug-20 | 12:39 | x64      |
| Sqlaccess.dll                              | 2019.150.4063.15 | 492432    | 15-Aug-20 | 12:39 | x64      |
| Sqlagent.exe                               | 2019.150.4063.15 | 730000    | 15-Aug-20 | 12:39 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4063.15 | 66440     | 15-Aug-20 | 12:39 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4063.15 | 78736     | 15-Aug-20 | 12:39 | x64      |
| Sqlboot.dll                                | 2019.150.4063.15 | 213904    | 15-Aug-20 | 12:39 | x64      |
| Sqlceip.exe                                | 15.0.4063.15     | 283536    | 15-Aug-20 | 12:39 | x86      |
| Sqlcmdss.dll                               | 2019.150.4063.15 | 86928     | 15-Aug-20 | 12:39 | x64      |
| Sqlctr150.dll                              | 2019.150.4063.15 | 115592    | 15-Aug-20 | 12:39 | x86      |
| Sqlctr150.dll                              | 2019.150.4063.15 | 140176    | 15-Aug-20 | 12:39 | x64      |
| Sqldk.dll                                  | 2019.150.4063.15 | 3146640   | 15-Aug-20 | 12:39 | x64      |
| Sqldtsss.dll                               | 2019.150.4063.15 | 107408    | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 1586048   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3486608   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3679120   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 4141960   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 4260736   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3396480   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3564432   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 4137864   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3994512   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 4043664   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 2212752   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 2159496   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3851152   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3527560   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3994512   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3802000   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3797904   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3597200   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3482512   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 1528712   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 3888016   | 15-Aug-20 | 12:39 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4063.15 | 4010896   | 15-Aug-20 | 12:39 | x64      |
| Sqllang.dll                                | 2019.150.4063.15 | 39789456  | 15-Aug-20 | 12:39 | x64      |
| Sqlmin.dll                                 | 2019.150.4063.15 | 40254352  | 15-Aug-20 | 12:39 | x64      |
| Sqlolapss.dll                              | 2019.150.4063.15 | 103304    | 15-Aug-20 | 12:39 | x64      |
| Sqlos.dll                                  | 2019.150.4063.15 | 41872     | 15-Aug-20 | 12:39 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4063.15 | 82824     | 15-Aug-20 | 12:39 | x64      |
| Sqlrepss.dll                               | 2019.150.4063.15 | 82832     | 15-Aug-20 | 12:39 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4063.15 | 50064     | 15-Aug-20 | 12:39 | x64      |
| Sqlscm.dll                                 | 2019.150.4063.15 | 86928     | 15-Aug-20 | 12:39 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4063.15 | 37760     | 15-Aug-20 | 12:39 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4063.15 | 5792656   | 15-Aug-20 | 12:39 | x64      |
| Sqlservr.exe                               | 2019.150.4063.15 | 623504    | 15-Aug-20 | 12:39 | x64      |
| Sqlsvc.dll                                 | 2019.150.4063.15 | 181136    | 15-Aug-20 | 12:39 | x64      |
| Sqltses.dll                                | 2019.150.4063.15 | 9073552   | 15-Aug-20 | 12:39 | x64      |
| Sqsrvres.dll                               | 2019.150.4063.15 | 279440    | 15-Aug-20 | 12:39 | x64      |
| Svl.dll                                    | 2019.150.4063.15 | 160656    | 15-Aug-20 | 12:39 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0    | 85992     | 15-Aug-20 | 12:39 | x64      |
| Xe.dll                                     | 2019.150.4063.15 | 721808    | 15-Aug-20 | 12:39 | x64      |
| Xpadsi.exe                                 | 2019.150.4063.15 | 115600    | 15-Aug-20 | 12:39 | x64      |
| Xplog70.dll                                | 2019.150.4063.15 | 91024     | 15-Aug-20 | 12:39 | x64      |
| Xprepl.dll                                 | 2019.150.4063.15 | 119696    | 15-Aug-20 | 12:39 | x64      |
| Xpstar.dll                                 | 2019.150.4063.15 | 471952    | 15-Aug-20 | 12:39 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                          | 2019.150.4063.15 | 263056    | 15-Aug-20 | 11:18 | x64      |
| Datacollectortasks.dll                                   | 2019.150.4063.15 | 226184    | 15-Aug-20 | 11:19 | x64      |
| Distrib.exe                                              | 2019.150.4063.15 | 234384    | 15-Aug-20 | 11:18 | x64      |
| Dteparse.dll                                             | 2019.150.4063.15 | 123784    | 15-Aug-20 | 11:18 | x64      |
| Dteparsemgd.dll                                          | 2019.150.4063.15 | 131984    | 15-Aug-20 | 11:18 | x64      |
| Dtepkg.dll                                               | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:18 | x64      |
| Dtexec.exe                                               | 2019.150.4063.15 | 71560     | 15-Aug-20 | 11:18 | x64      |
| Dts.dll                                                  | 2019.150.4063.15 | 3142544   | 15-Aug-20 | 11:20 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4063.15 | 500616    | 15-Aug-20 | 11:19 | x64      |
| Dtsconn.dll                                              | 2019.150.4063.15 | 525200    | 15-Aug-20 | 11:19 | x64      |
| Dtshost.exe                                              | 2019.150.4063.15 | 104328    | 15-Aug-20 | 11:18 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4063.15 | 566160    | 15-Aug-20 | 11:18 | x64      |
| Dtspipeline.dll                                          | 2019.150.4063.15 | 1328016   | 15-Aug-20 | 11:18 | x64      |
| Dtswizard.exe                                            | 15.0.4063.15     | 885648    | 15-Aug-20 | 11:18 | x64      |
| Dtuparse.dll                                             | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:18 | x64      |
| Dtutil.exe                                               | 2019.150.4063.15 | 147344    | 15-Aug-20 | 11:18 | x64      |
| Exceldest.dll                                            | 2019.150.4063.15 | 279440    | 15-Aug-20 | 11:18 | x64      |
| Excelsrc.dll                                             | 2019.150.4063.15 | 308112    | 15-Aug-20 | 11:18 | x64      |
| Execpackagetask.dll                                      | 2019.150.4063.15 | 185232    | 15-Aug-20 | 11:18 | x64      |
| Flatfiledest.dll                                         | 2019.150.4063.15 | 410512    | 15-Aug-20 | 11:18 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4063.15 | 426896    | 15-Aug-20 | 11:18 | x64      |
| Logread.exe                                              | 2019.150.4063.15 | 717712    | 15-Aug-20 | 11:18 | x64      |
| Mergetxt.dll                                             | 2019.150.4063.15 | 74624     | 15-Aug-20 | 11:18 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:18 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4063.15     | 390016    | 15-Aug-20 | 11:18 | x86      |
| Microsoft.sqlserver.xmltask.dll                          | 15.0.4063.15     | 156560    | 15-Aug-20 | 11:18 | x86      |
| Msdtssrvrutil.dll                                        | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:18 | x64      |
| Msgprox.dll                                              | 2019.150.4063.15 | 299920    | 15-Aug-20 | 11:18 | x64      |
| Msoledbsql.dll                                           | 2018.182.3.0     | 148432    | 15-Aug-20 | 11:18 | x64      |
| Msxmlsql.dll                                             | 2019.150.4063.15 | 1495944   | 15-Aug-20 | 11:18 | x64      |
| Oledbdest.dll                                            | 2019.150.4063.15 | 279424    | 15-Aug-20 | 11:18 | x64      |
| Oledbsrc.dll                                             | 2019.150.4063.15 | 312192    | 15-Aug-20 | 11:18 | x64      |
| Osql.exe                                                 | 2019.150.4063.15 | 91024     | 15-Aug-20 | 11:18 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4063.15 | 496520    | 15-Aug-20 | 11:19 | x64      |
| Rawdest.dll                                              | 2019.150.4063.15 | 226192    | 15-Aug-20 | 11:18 | x64      |
| Rawsource.dll                                            | 2019.150.4063.15 | 209800    | 15-Aug-20 | 11:18 | x64      |
| Rdistcom.dll                                             | 2019.150.4063.15 | 914320    | 15-Aug-20 | 11:19 | x64      |
| Recordsetdest.dll                                        | 2019.150.4063.15 | 201608    | 15-Aug-20 | 11:18 | x64      |
| Repldp.dll                                               | 2019.150.4063.15 | 312192    | 15-Aug-20 | 11:18 | x64      |
| Replerrx.dll                                             | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:19 | x64      |
| Replisapi.dll                                            | 2019.150.4063.15 | 394120    | 15-Aug-20 | 11:19 | x64      |
| Replmerg.exe                                             | 2019.150.4063.15 | 562064    | 15-Aug-20 | 11:19 | x64      |
| Replprov.dll                                             | 2019.150.4063.15 | 852880    | 15-Aug-20 | 11:19 | x64      |
| Replrec.dll                                              | 2019.150.4063.15 | 1029008   | 15-Aug-20 | 11:18 | x64      |
| Replsub.dll                                              | 2019.150.4063.15 | 471952    | 15-Aug-20 | 11:18 | x64      |
| Replsync.dll                                             | 2019.150.4063.15 | 164744    | 15-Aug-20 | 11:18 | x64      |
| Spresolv.dll                                             | 2019.150.4063.15 | 275344    | 15-Aug-20 | 11:18 | x64      |
| Sqlcmd.exe                                               | 2019.150.4063.15 | 263056    | 15-Aug-20 | 11:18 | x64      |
| Sqldiag.exe                                              | 2019.150.4063.15 | 1139600   | 15-Aug-20 | 11:18 | x64      |
| Sqldistx.dll                                             | 2019.150.4063.15 | 246672    | 15-Aug-20 | 11:18 | x64      |
| Sqllogship.exe                                           | 15.0.4063.15     | 103312    | 15-Aug-20 | 11:18 | x64      |
| Sqlmergx.dll                                             | 2019.150.4063.15 | 398224    | 15-Aug-20 | 11:18 | x64      |
| Sqlresourceloader.dll                                    | 2019.150.4063.15 | 50064     | 15-Aug-20 | 11:19 | x64      |
| Sqlresourceloader.dll                                    | 2019.150.4063.15 | 37776     | 15-Aug-20 | 11:19 | x86      |
| Sqlscm.dll                                               | 2019.150.4063.15 | 78736     | 15-Aug-20 | 11:18 | x86      |
| Sqlscm.dll                                               | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:18 | x64      |
| Sqlsvc.dll                                               | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:18 | x64      |
| Sqlsvc.dll                                               | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:19 | x86      |
| Sqltaskconnections.dll                                   | 2019.150.4063.15 | 201616    | 15-Aug-20 | 11:18 | x64      |
| Ssradd.dll                                               | 2019.150.4063.15 | 82832     | 15-Aug-20 | 11:18 | x64      |
| Ssravg.dll                                               | 2019.150.4063.15 | 82832     | 15-Aug-20 | 11:20 | x64      |
| Ssrdown.dll                                              | 2019.150.4063.15 | 74640     | 15-Aug-20 | 11:19 | x64      |
| Ssrmax.dll                                               | 2019.150.4063.15 | 82832     | 15-Aug-20 | 11:18 | x64      |
| Ssrmin.dll                                               | 2019.150.4063.15 | 82824     | 15-Aug-20 | 11:18 | x64      |
| Ssrpub.dll                                               | 2019.150.4063.15 | 74640     | 15-Aug-20 | 11:19 | x64      |
| Ssrup.dll                                                | 2019.150.4063.15 | 74632     | 15-Aug-20 | 11:19 | x64      |
| Txagg.dll                                                | 2019.150.4063.15 | 390032    | 15-Aug-20 | 11:19 | x64      |
| Txbdd.dll                                                | 2019.150.4063.15 | 189328    | 15-Aug-20 | 11:19 | x64      |
| Txdatacollector.dll                                      | 2019.150.4063.15 | 471944    | 15-Aug-20 | 11:19 | x64      |
| Txdataconvert.dll                                        | 2019.150.4063.15 | 316304    | 15-Aug-20 | 11:18 | x64      |
| Txderived.dll                                            | 2019.150.4063.15 | 639888    | 15-Aug-20 | 11:18 | x64      |
| Txlookup.dll                                             | 2019.150.4063.15 | 541584    | 15-Aug-20 | 11:18 | x64      |
| Txmerge.dll                                              | 2019.150.4063.15 | 246672    | 15-Aug-20 | 11:18 | x64      |
| Txmergejoin.dll                                          | 2019.150.4063.15 | 308112    | 15-Aug-20 | 11:19 | x64      |
| Txmulticast.dll                                          | 2019.150.4063.15 | 144272    | 15-Aug-20 | 11:18 | x64      |
| Txrowcount.dll                                           | 2019.150.4063.15 | 140176    | 15-Aug-20 | 11:18 | x64      |
| Txsort.dll                                               | 2019.150.4063.15 | 287632    | 15-Aug-20 | 11:18 | x64      |
| Txsplit.dll                                              | 2019.150.4063.15 | 623504    | 15-Aug-20 | 11:18 | x64      |
| Txunionall.dll                                           | 2019.150.4063.15 | 197520    | 15-Aug-20 | 11:18 | x64      |
| Xe.dll                                                   | 2019.150.4063.15 | 721808    | 15-Aug-20 | 11:19 | x64      |
| Xmlsub.dll                                               | 2019.150.4063.15 | 295824    | 15-Aug-20 | 11:19 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4063.15 | 91024     | 15-Aug-20 | 11:18 | x64      |
| Exthost.exe        | 2019.150.4063.15 | 238480    | 15-Aug-20 | 11:19 | x64      |
| Launchpad.exe      | 2019.150.4063.15 | 1229712   | 15-Aug-20 | 11:18 | x64      |
| Sqlsatellite.dll   | 2019.150.4063.15 | 1024912   | 15-Aug-20 | 11:19 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4063.15 | 684944    | 15-Aug-20 | 11:18 | x64      |
| Fdhost.exe     | 2019.150.4063.15 | 127888    | 15-Aug-20 | 11:18 | x64      |
| Fdlauncher.exe | 2019.150.4063.15 | 78736     | 15-Aug-20 | 11:18 | x64      |
| Sqlft150ph.dll | 2019.150.4063.15 | 91024     | 15-Aug-20 | 11:18 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4063.15 | 29584     | 15-Aug-20 | 11:19 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4063.15 | 263056    | 15-Aug-20 | 11:27 | x64      |
| Commanddest.dll                                               | 2019.150.4063.15 | 226176    | 15-Aug-20 | 11:27 | x86      |
| Dteparse.dll                                                  | 2019.150.4063.15 | 123784    | 15-Aug-20 | 11:27 | x64      |
| Dteparse.dll                                                  | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:27 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4063.15 | 131984    | 15-Aug-20 | 11:27 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4063.15 | 115600    | 15-Aug-20 | 11:27 | x86      |
| Dtepkg.dll                                                    | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:27 | x64      |
| Dtepkg.dll                                                    | 2019.150.4063.15 | 131984    | 15-Aug-20 | 11:27 | x86      |
| Dtexec.exe                                                    | 2019.150.4063.15 | 71560     | 15-Aug-20 | 11:27 | x64      |
| Dtexec.exe                                                    | 2019.150.4063.15 | 62864     | 15-Aug-20 | 11:27 | x86      |
| Dts.dll                                                       | 2019.150.4063.15 | 3142544   | 15-Aug-20 | 11:27 | x64      |
| Dts.dll                                                       | 2019.150.4063.15 | 2761616   | 15-Aug-20 | 11:27 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4063.15 | 500616    | 15-Aug-20 | 11:27 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4063.15 | 443264    | 15-Aug-20 | 11:28 | x86      |
| Dtsconn.dll                                                   | 2019.150.4063.15 | 525200    | 15-Aug-20 | 11:27 | x64      |
| Dtsconn.dll                                                   | 2019.150.4063.15 | 435088    | 15-Aug-20 | 11:27 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4063.15 | 110992    | 15-Aug-20 | 11:27 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4063.15 | 92560     | 15-Aug-20 | 11:27 | x86      |
| Dtshost.exe                                                   | 2019.150.4063.15 | 104328    | 15-Aug-20 | 11:27 | x64      |
| Dtshost.exe                                                   | 2019.150.4063.15 | 87440     | 15-Aug-20 | 11:28 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4063.15 | 553872    | 15-Aug-20 | 11:27 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4063.15 | 566160    | 15-Aug-20 | 11:27 | x64      |
| Dtspipeline.dll                                               | 2019.150.4063.15 | 1328016   | 15-Aug-20 | 11:27 | x64      |
| Dtspipeline.dll                                               | 2019.150.4063.15 | 1119120   | 15-Aug-20 | 11:27 | x86      |
| Dtswizard.exe                                                 | 15.0.4063.15     | 885648    | 15-Aug-20 | 11:27 | x64      |
| Dtswizard.exe                                                 | 15.0.4063.15     | 889744    | 15-Aug-20 | 11:27 | x86      |
| Dtuparse.dll                                                  | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:28 | x86      |
| Dtuparse.dll                                                  | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:28 | x64      |
| Dtutil.exe                                                    | 2019.150.4063.15 | 147344    | 15-Aug-20 | 11:27 | x64      |
| Dtutil.exe                                                    | 2019.150.4063.15 | 128912    | 15-Aug-20 | 11:28 | x86      |
| Exceldest.dll                                                 | 2019.150.4063.15 | 279440    | 15-Aug-20 | 11:27 | x64      |
| Exceldest.dll                                                 | 2019.150.4063.15 | 234384    | 15-Aug-20 | 11:27 | x86      |
| Excelsrc.dll                                                  | 2019.150.4063.15 | 308112    | 15-Aug-20 | 11:27 | x64      |
| Excelsrc.dll                                                  | 2019.150.4063.15 | 258960    | 15-Aug-20 | 11:28 | x86      |
| Execpackagetask.dll                                           | 2019.150.4063.15 | 185232    | 15-Aug-20 | 11:27 | x64      |
| Execpackagetask.dll                                           | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:27 | x86      |
| Flatfiledest.dll                                              | 2019.150.4063.15 | 410512    | 15-Aug-20 | 11:27 | x64      |
| Flatfiledest.dll                                              | 2019.150.4063.15 | 357264    | 15-Aug-20 | 11:27 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4063.15 | 426896    | 15-Aug-20 | 11:27 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4063.15 | 369544    | 15-Aug-20 | 11:27 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4063.15     | 119696    | 15-Aug-20 | 11:27 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4063.15     | 119696    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4063.15     | 78736     | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:28 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4063.15     | 500624    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4063.15     | 500624    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4063.15     | 390016    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:28 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4063.15     | 140168    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4063.15     | 140176    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4063.15     | 156560    | 15-Aug-20 | 11:27 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4063.15     | 156560    | 15-Aug-20 | 11:27 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4063.15     | 217992    | 15-Aug-20 | 11:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:28 | x86      |
| Msmdpp.dll                                                    | 2018.150.34.22   | 10062232  | 15-Aug-20 | 11:27 | x64      |
| Odbcdest.dll                                                  | 2019.150.4063.15 | 369552    | 15-Aug-20 | 11:27 | x64      |
| Odbcdest.dll                                                  | 2019.150.4063.15 | 316304    | 15-Aug-20 | 11:28 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4063.15 | 381840    | 15-Aug-20 | 11:27 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4063.15 | 328592    | 15-Aug-20 | 11:27 | x86      |
| Oledbdest.dll                                                 | 2019.150.4063.15 | 279424    | 15-Aug-20 | 11:27 | x64      |
| Oledbdest.dll                                                 | 2019.150.4063.15 | 238480    | 15-Aug-20 | 11:27 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4063.15 | 312192    | 15-Aug-20 | 11:27 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4063.15 | 263048    | 15-Aug-20 | 11:27 | x86      |
| Rawdest.dll                                                   | 2019.150.4063.15 | 226192    | 15-Aug-20 | 11:27 | x64      |
| Rawdest.dll                                                   | 2019.150.4063.15 | 189328    | 15-Aug-20 | 11:27 | x86      |
| Rawsource.dll                                                 | 2019.150.4063.15 | 209800    | 15-Aug-20 | 11:27 | x64      |
| Rawsource.dll                                                 | 2019.150.4063.15 | 177040    | 15-Aug-20 | 11:27 | x86      |
| Recordsetdest.dll                                             | 2019.150.4063.15 | 201608    | 15-Aug-20 | 11:27 | x64      |
| Recordsetdest.dll                                             | 2019.150.4063.15 | 172944    | 15-Aug-20 | 11:27 | x86      |
| Sqlceip.exe                                                   | 15.0.4063.15     | 283536    | 15-Aug-20 | 11:27 | x86      |
| Sqldest.dll                                                   | 2019.150.4063.15 | 275344    | 15-Aug-20 | 11:27 | x64      |
| Sqldest.dll                                                   | 2019.150.4063.15 | 238480    | 15-Aug-20 | 11:27 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4063.15 | 201616    | 15-Aug-20 | 11:27 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4063.15 | 168848    | 15-Aug-20 | 11:27 | x86      |
| Txagg.dll                                                     | 2019.150.4063.15 | 390032    | 15-Aug-20 | 11:27 | x64      |
| Txagg.dll                                                     | 2019.150.4063.15 | 328592    | 15-Aug-20 | 11:28 | x86      |
| Txbdd.dll                                                     | 2019.150.4063.15 | 189328    | 15-Aug-20 | 11:27 | x64      |
| Txbdd.dll                                                     | 2019.150.4063.15 | 152464    | 15-Aug-20 | 11:28 | x86      |
| Txbestmatch.dll                                               | 2019.150.4063.15 | 652176    | 15-Aug-20 | 11:27 | x64      |
| Txbestmatch.dll                                               | 2019.150.4063.15 | 545680    | 15-Aug-20 | 11:28 | x86      |
| Txcache.dll                                                   | 2019.150.4063.15 | 197520    | 15-Aug-20 | 11:27 | x64      |
| Txcache.dll                                                   | 2019.150.4063.15 | 164736    | 15-Aug-20 | 11:28 | x86      |
| Txcharmap.dll                                                 | 2019.150.4063.15 | 312208    | 15-Aug-20 | 11:27 | x64      |
| Txcharmap.dll                                                 | 2019.150.4063.15 | 271248    | 15-Aug-20 | 11:28 | x86      |
| Txcopymap.dll                                                 | 2019.150.4063.15 | 197520    | 15-Aug-20 | 11:27 | x64      |
| Txcopymap.dll                                                 | 2019.150.4063.15 | 164736    | 15-Aug-20 | 11:28 | x86      |
| Txdataconvert.dll                                             | 2019.150.4063.15 | 316304    | 15-Aug-20 | 11:27 | x64      |
| Txdataconvert.dll                                             | 2019.150.4063.15 | 275344    | 15-Aug-20 | 11:27 | x86      |
| Txderived.dll                                                 | 2019.150.4063.15 | 639888    | 15-Aug-20 | 11:27 | x64      |
| Txderived.dll                                                 | 2019.150.4063.15 | 557968    | 15-Aug-20 | 11:28 | x86      |
| Txfileextractor.dll                                           | 2019.150.4063.15 | 218000    | 15-Aug-20 | 11:27 | x64      |
| Txfileextractor.dll                                           | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:28 | x86      |
| Txfileinserter.dll                                            | 2019.150.4063.15 | 213904    | 15-Aug-20 | 11:27 | x64      |
| Txfileinserter.dll                                            | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:27 | x86      |
| Txgroupdups.dll                                               | 2019.150.4063.15 | 312200    | 15-Aug-20 | 11:27 | x64      |
| Txgroupdups.dll                                               | 2019.150.4063.15 | 254864    | 15-Aug-20 | 11:28 | x86      |
| Txlineage.dll                                                 | 2019.150.4063.15 | 152464    | 15-Aug-20 | 11:27 | x64      |
| Txlineage.dll                                                 | 2019.150.4063.15 | 127888    | 15-Aug-20 | 11:27 | x86      |
| Txlookup.dll                                                  | 2019.150.4063.15 | 541584    | 15-Aug-20 | 11:27 | x64      |
| Txlookup.dll                                                  | 2019.150.4063.15 | 467856    | 15-Aug-20 | 11:28 | x86      |
| Txmerge.dll                                                   | 2019.150.4063.15 | 246672    | 15-Aug-20 | 11:27 | x64      |
| Txmerge.dll                                                   | 2019.150.4063.15 | 201616    | 15-Aug-20 | 11:28 | x86      |
| Txmergejoin.dll                                               | 2019.150.4063.15 | 308112    | 15-Aug-20 | 11:27 | x64      |
| Txmergejoin.dll                                               | 2019.150.4063.15 | 246664    | 15-Aug-20 | 11:28 | x86      |
| Txmulticast.dll                                               | 2019.150.4063.15 | 144272    | 15-Aug-20 | 11:27 | x64      |
| Txmulticast.dll                                               | 2019.150.4063.15 | 119696    | 15-Aug-20 | 11:28 | x86      |
| Txpivot.dll                                                   | 2019.150.4063.15 | 238480    | 15-Aug-20 | 11:27 | x64      |
| Txpivot.dll                                                   | 2019.150.4063.15 | 205712    | 15-Aug-20 | 11:28 | x86      |
| Txrowcount.dll                                                | 2019.150.4063.15 | 140176    | 15-Aug-20 | 11:27 | x64      |
| Txrowcount.dll                                                | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:28 | x86      |
| Txsampling.dll                                                | 2019.150.4063.15 | 193416    | 15-Aug-20 | 11:27 | x64      |
| Txsampling.dll                                                | 2019.150.4063.15 | 156552    | 15-Aug-20 | 11:28 | x86      |
| Txscd.dll                                                     | 2019.150.4063.15 | 234384    | 15-Aug-20 | 11:27 | x64      |
| Txscd.dll                                                     | 2019.150.4063.15 | 197504    | 15-Aug-20 | 11:28 | x86      |
| Txsort.dll                                                    | 2019.150.4063.15 | 287632    | 15-Aug-20 | 11:27 | x64      |
| Txsort.dll                                                    | 2019.150.4063.15 | 230288    | 15-Aug-20 | 11:28 | x86      |
| Txsplit.dll                                                   | 2019.150.4063.15 | 623504    | 15-Aug-20 | 11:27 | x64      |
| Txsplit.dll                                                   | 2019.150.4063.15 | 549768    | 15-Aug-20 | 11:27 | x86      |
| Txtermextraction.dll                                          | 2019.150.4063.15 | 8700816   | 15-Aug-20 | 11:27 | x64      |
| Txtermextraction.dll                                          | 2019.150.4063.15 | 8643472   | 15-Aug-20 | 11:28 | x86      |
| Txtermlookup.dll                                              | 2019.150.4063.15 | 4182928   | 15-Aug-20 | 11:27 | x64      |
| Txtermlookup.dll                                              | 2019.150.4063.15 | 4137872   | 15-Aug-20 | 11:27 | x86      |
| Txunionall.dll                                                | 2019.150.4063.15 | 197520    | 15-Aug-20 | 11:27 | x64      |
| Txunionall.dll                                                | 2019.150.4063.15 | 160656    | 15-Aug-20 | 11:27 | x86      |
| Txunpivot.dll                                                 | 2019.150.4063.15 | 213896    | 15-Aug-20 | 11:27 | x64      |
| Txunpivot.dll                                                 | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:27 | x86      |
| Xe.dll                                                        | 2019.150.4063.15 | 721808    | 15-Aug-20 | 10:55 | x64      |
| Xe.dll                                                        | 2019.150.4063.15 | 631696    | 15-Aug-20 | 11:28 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1877.0      | 551840    | 15-Aug-20 | 12:09 | x86      |
| Dmsnative.dll                                                        | 2018.150.1877.0  | 139168    | 15-Aug-20 | 12:09 | x64      |
| Dwengineservice.dll                                                  | 15.0.1877.0      | 43936     | 15-Aug-20 | 12:09 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008       | 17142672  | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003       | 146304    | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108        | 2365520   | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272       | 2199120   | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272       | 144976    | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217        | 2408016   | 15-Aug-20 | 12:09 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39         | 2928720   | 15-Aug-20 | 12:09 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109768  | 15-Aug-20 | 12:09 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109832  | 15-Aug-20 | 12:09 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2425288   | 15-Aug-20 | 12:09 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2431880   | 15-Aug-20 | 12:09 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124        | 15488080  | 15-Aug-20 | 12:09 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1775048   | 15-Aug-20 | 12:09 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1783688   | 15-Aug-20 | 12:09 | x64      |
| Instapi150.dll                                                       | 2019.150.4063.15 | 86928     | 15-Aug-20 | 12:09 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10         | 2620304   | 15-Aug-20 | 12:09 | x64      |
| Libcrypto                                                            | 1.1.1.4          | 2953680   | 15-Aug-20 | 12:09 | x64      |
| Libsasl.dll                                                          | 2.1.26.0         | 292224    | 15-Aug-20 | 12:09 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10         | 648080    | 15-Aug-20 | 12:09 | x64      |
| Libssl                                                               | 1.1.1.4          | 798160    | 15-Aug-20 | 12:09 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1877.0      | 66456     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1877.0      | 292248    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1877.0      | 1951128   | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1877.0      | 169376    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1877.0      | 634272    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1877.0      | 243608    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1877.0      | 137624    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1877.0      | 78752     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1877.0      | 50080     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1877.0      | 87448     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1877.0      | 1127840   | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1877.0      | 79776     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1877.0      | 69536     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1877.0      | 34200     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1877.0      | 30112     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1877.0      | 45464     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1877.0      | 20368     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1877.0      | 25496     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1877.0      | 130456    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1877.0      | 85400     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1877.0      | 99728     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1877.0      | 291744    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 118688    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 137112    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 140192    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 136608    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 149408    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 138656    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 133024    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 175520    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 116128    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1877.0      | 135064    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1877.0      | 71568     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1877.0      | 20880     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1877.0      | 36256     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1877.0      | 127904    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1877.0      | 3041696   | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1877.0      | 3952544   | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 117152    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 131992    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 136608    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 132512    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 147360    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 133024    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 129440    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 169880    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 114072    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1877.0      | 130960    | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1877.0      | 66464     | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1877.0      | 2681240   | 15-Aug-20 | 12:09 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1877.0      | 2435488   | 15-Aug-20 | 12:09 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4063.15 | 451472    | 15-Aug-20 | 12:09 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4063.15 | 7394192   | 15-Aug-20 | 12:09 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1     | 2016120   | 15-Aug-20 | 12:09 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1     | 720792    | 15-Aug-20 | 12:09 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1     | 138136    | 15-Aug-20 | 12:09 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1     | 175000    | 15-Aug-20 | 12:09 | x64      |
| Saslplain.dll                                                        | 2.1.26.0         | 170880    | 15-Aug-20 | 12:09 | x64      |
| Secforwarder.dll                                                     | 2019.150.4063.15 | 78736     | 15-Aug-20 | 12:09 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1877.0  | 60320     | 15-Aug-20 | 12:09 | x64      |
| Sqldk.dll                                                            | 2019.150.4063.15 | 3146640   | 15-Aug-20 | 12:09 | x64      |
| Sqldumper.exe                                                        | 2019.150.4063.15 | 185232    | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 1586048   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 4141960   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 3396480   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 4137864   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 4043664   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 2212752   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 2159496   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 3802000   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 3797904   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 1528712   | 15-Aug-20 | 12:09 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4063.15 | 4010896   | 15-Aug-20 | 12:09 | x64      |
| Sqlos.dll                                                            | 2019.150.4063.15 | 41872     | 15-Aug-20 | 12:09 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1877.0  | 4840352   | 15-Aug-20 | 12:09 | x64      |
| Sqltses.dll                                                          | 2019.150.4063.15 | 9073552   | 15-Aug-20 | 12:09 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078     | 14995920  | 15-Aug-20 | 12:09 | x64      |
| Terasso.dll                                                          | 16.20.0.13       | 2158896   | 15-Aug-20 | 12:09 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0         | 281472    | 15-Aug-20 | 12:09 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4063.15 | 29584     | 15-Aug-20 | 11:19 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File name                         |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                              | 2019.150.4063.15 | 1631120   | 15-Aug-20 | 11:32 | x86      |
| Dtaengine.exe                                              | 2019.150.4063.15 | 218000    | 15-Aug-20 | 11:32 | x86      |
| Dteparse.dll                                               | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:32 | x86      |
| Dteparse.dll                                               | 2019.150.4063.15 | 123784    | 15-Aug-20 | 11:32 | x64      |
| Dteparsemgd.dll                                            | 2019.150.4063.15 | 115600    | 15-Aug-20 | 11:32 | x86      |
| Dteparsemgd.dll                                            | 2019.150.4063.15 | 131984    | 15-Aug-20 | 11:32 | x64      |
| Dtepkg.dll                                                 | 2019.150.4063.15 | 131984    | 15-Aug-20 | 11:32 | x86      |
| Dtepkg.dll                                                 | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:32 | x64      |
| Dtexec.exe                                                 | 2019.150.4063.15 | 62864     | 15-Aug-20 | 11:32 | x86      |
| Dtexec.exe                                                 | 2019.150.4063.15 | 71560     | 15-Aug-20 | 11:32 | x64      |
| Dts.dll                                                    | 2019.150.4063.15 | 2761616   | 15-Aug-20 | 11:32 | x86      |
| Dts.dll                                                    | 2019.150.4063.15 | 3142544   | 15-Aug-20 | 11:32 | x64      |
| Dtscomexpreval.dll                                         | 2019.150.4063.15 | 443264    | 15-Aug-20 | 11:32 | x86      |
| Dtscomexpreval.dll                                         | 2019.150.4063.15 | 500616    | 15-Aug-20 | 11:32 | x64      |
| Dtsconn.dll                                                | 2019.150.4063.15 | 435088    | 15-Aug-20 | 11:32 | x86      |
| Dtsconn.dll                                                | 2019.150.4063.15 | 525200    | 15-Aug-20 | 11:32 | x64      |
| Dtshost.exe                                                | 2019.150.4063.15 | 104328    | 15-Aug-20 | 11:32 | x64      |
| Dtshost.exe                                                | 2019.150.4063.15 | 87440     | 15-Aug-20 | 11:32 | x86      |
| Dtsmsg150.dll                                              | 2019.150.4063.15 | 553872    | 15-Aug-20 | 11:32 | x86      |
| Dtsmsg150.dll                                              | 2019.150.4063.15 | 566160    | 15-Aug-20 | 11:32 | x64      |
| Dtspipeline.dll                                            | 2019.150.4063.15 | 1119120   | 15-Aug-20 | 11:32 | x86      |
| Dtspipeline.dll                                            | 2019.150.4063.15 | 1328016   | 15-Aug-20 | 11:32 | x64      |
| Dtswizard.exe                                              | 15.0.4063.15     | 885648    | 15-Aug-20 | 11:32 | x64      |
| Dtswizard.exe                                              | 15.0.4063.15     | 889744    | 15-Aug-20 | 11:32 | x86      |
| Dtuparse.dll                                               | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:32 | x86      |
| Dtuparse.dll                                               | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:32 | x64      |
| Dtutil.exe                                                 | 2019.150.4063.15 | 128912    | 15-Aug-20 | 11:32 | x86      |
| Dtutil.exe                                                 | 2019.150.4063.15 | 147344    | 15-Aug-20 | 11:32 | x64      |
| Exceldest.dll                                              | 2019.150.4063.15 | 234384    | 15-Aug-20 | 11:32 | x86      |
| Exceldest.dll                                              | 2019.150.4063.15 | 279440    | 15-Aug-20 | 11:32 | x64      |
| Excelsrc.dll                                               | 2019.150.4063.15 | 258960    | 15-Aug-20 | 11:32 | x86      |
| Excelsrc.dll                                               | 2019.150.4063.15 | 308112    | 15-Aug-20 | 11:32 | x64      |
| Flatfiledest.dll                                           | 2019.150.4063.15 | 357264    | 15-Aug-20 | 11:32 | x86      |
| Flatfiledest.dll                                           | 2019.150.4063.15 | 410512    | 15-Aug-20 | 11:32 | x64      |
| Flatfilesrc.dll                                            | 2019.150.4063.15 | 369544    | 15-Aug-20 | 11:32 | x86      |
| Flatfilesrc.dll                                            | 2019.150.4063.15 | 426896    | 15-Aug-20 | 11:32 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 15.0.4063.15     | 78736     | 15-Aug-20 | 11:32 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 15.0.4063.15     | 402312    | 15-Aug-20 | 11:32 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 15.0.4063.15     | 2999184   | 15-Aug-20 | 11:32 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4063.15     | 58256     | 15-Aug-20 | 11:32 | x86      |
| Msdtssrvrutil.dll                                          | 2019.150.4063.15 | 111504    | 15-Aug-20 | 11:32 | x64      |
| Msdtssrvrutil.dll                                          | 2019.150.4063.15 | 99216     | 15-Aug-20 | 11:32 | x86      |
| Msmgdsrv.dll                                               | 2018.150.34.22   | 8277912   | 15-Aug-20 | 11:32 | x86      |
| Oledbdest.dll                                              | 2019.150.4063.15 | 238480    | 15-Aug-20 | 11:32 | x86      |
| Oledbdest.dll                                              | 2019.150.4063.15 | 279424    | 15-Aug-20 | 11:32 | x64      |
| Oledbsrc.dll                                               | 2019.150.4063.15 | 263048    | 15-Aug-20 | 11:32 | x86      |
| Oledbsrc.dll                                               | 2019.150.4063.15 | 312192    | 15-Aug-20 | 11:32 | x64      |
| Sqlresourceloader.dll                                      | 2019.150.4063.15 | 37776     | 15-Aug-20 | 11:32 | x86      |
| Sqlresourceloader.dll                                      | 2019.150.4063.15 | 50064     | 15-Aug-20 | 11:32 | x64      |
| Sqlscm.dll                                                 | 2019.150.4063.15 | 78736     | 15-Aug-20 | 11:32 | x86      |
| Sqlscm.dll                                                 | 2019.150.4063.15 | 86928     | 15-Aug-20 | 11:32 | x64      |
| Sqlsvc.dll                                                 | 2019.150.4063.15 | 148368    | 15-Aug-20 | 11:32 | x86      |
| Sqlsvc.dll                                                 | 2019.150.4063.15 | 181136    | 15-Aug-20 | 11:32 | x64      |
| Sqltaskconnections.dll                                     | 2019.150.4063.15 | 168848    | 15-Aug-20 | 11:32 | x86      |
| Sqltaskconnections.dll                                     | 2019.150.4063.15 | 201616    | 15-Aug-20 | 11:32 | x64      |
| Txdataconvert.dll                                          | 2019.150.4063.15 | 275344    | 15-Aug-20 | 11:32 | x86      |
| Txdataconvert.dll                                          | 2019.150.4063.15 | 316304    | 15-Aug-20 | 11:32 | x64      |
| Xe.dll                                                     | 2019.150.4063.15 | 631696    | 15-Aug-20 | 11:32 | x86      |
| Xe.dll                                                     | 2019.150.4063.15 | 721808    | 15-Aug-20 | 11:32 | x64      |

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
  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
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

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

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

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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
