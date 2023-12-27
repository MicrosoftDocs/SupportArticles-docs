---
title: Cumulative update 12 for SQL Server 2019 (KB5004524)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 12 (KB5004524).
ms.date: 06/30/2023
ms.custom: KB5004524
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5004524 - Cumulative Update 12 for SQL Server 2019

_Release Date:_ &nbsp; August 04, 2021  
_Version:_ &nbsp; 15.0.4153.1

## Summary

This article describes Cumulative Update package 12 (CU12) for Microsoft SQL Server 2019. This update contains 30 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 11, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4153.1**, file version: **2019.150.4153.1**
- Analysis Services - Product version: **15.0.35.15**, file version: **2018.150.35.15**

## Known issues in this update

If a database in an Always On availability group has duplicate logical file names, either correct that situation or avoid using the automatic seeding functionality after you install SQL Server 2019 CU12.

> [!NOTE]
> This issue is resolved in [CU14](cumulativeupdate14.md).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="14143394">[14143394](#14143394)</a> | Fixes an issue where the DAX query with `UNION` generates an exception: </br></br>An unexpected error occurred (file '\<FileName>', line \<LineNumber>, function '\<FunctionName>') | Analysis Services | Analysis Services | Windows |
| <a id="13970856">[13970856](#13970856)</a> | Fixes the issue in SSIS 2019 when Dimension Processing returns the following error message: </br></br>clsid {ID}" could not be created and error code 0x80070005 "Access is denied.". Make sure that the component is registered correctly. </br>OnError: "Dimension Processing failed validation and returned error code 0x80040005" | Integration Services | Integration Services | Windows |
| <a id="14157632">[14157632](#14157632)</a> | Fixes an issue where the derived tree can't load correctly in **explore**/**design** page if the hierarchy contains more than two levels recursive. | Master Data Services | Client | Windows |
| <a id="14031511">[14031511](#14031511)</a> | Fixes the issue in MDS 2019 where Derived hierarchy for domain based attributes isn't working properly. | Master Data Services | Master Data Services | Windows |
| <a id="14152660">[14152660](#14152660)</a> | Fixes the access violation that occurs at `sqllang!srv_nameinfo::SkipOptionalTransportProvider` in SQL Server 2019. | SQL Server Connectivity | Protocols | Windows |
| <a id="13746933">[13746933](#13746933)</a> | Fixes an issue where running a Full Database Backup on a read-only database containing memory optimized objects fails with the error 3906. </br></br>"Failed to update database "\<DatabaseName>" because the database is read-only." | SQL Server Engine | Backup Restore | Windows |
| <a id="14099473">[14099473](#14099473)</a> | Fixes an issue where frozen I/O leads to latch timeout on database boot page (1:9) and leads to suspended availability group database REDO thread. | SQL Server Engine | Backup Restore | Windows |
| <a id="13979806">[13979806](#13979806)</a> | [FIX: Memory grant wait times out when you run many Columnstore bulk inserts concurrently in SQL Server 2017 and 2019 (KB5001045)](https://support.microsoft.com/help/5001045) | SQL Server Engine | Column Stores | All |
| <a id="14072670">[14072670](#14072670)</a> | [FIX: Wrong results during Clustered Columnstore Index alter "index reorganize" in versioned scans in SQL Server 2017 and 2019 (KB5004560)](https://support.microsoft.com/help/5004560) | SQL Server Engine | Column Stores | Windows |
| <a id="14132334">[14132334](#14132334)</a> | [FIX: Error when you use columnstore indexes and run versioned scans if all rows in a compressed rowgroup are deleted in SQL Server 2019 (KB5004936)](https://support.microsoft.com/help/5004936) | SQL Server Engine | Column Stores | All |
| <a id="14138749">[14138749](#14138749)</a> | [FIX: Persisted computed columns not being consistently blocked for Columnstore index (KB5004734)](https://support.microsoft.com/help/5004734) | SQL Server Engine | Column Stores | All |
| <a id="13633665">[13633665](#13633665)</a> | [FIX: Parallel redo failure on secondary replica in SQL Server 2019 (KB5004649)](https://support.microsoft.com/help/5004649) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13872115">[13872115](#13872115)</a> | Fixes a second exception that occurs when trying to generate a dump on a latch timeout issue and crashes the SQL service entirely. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14099845">[14099845](#14099845)</a> | Fixes an issue where creating an availability group with automatic seeding fails with the error: "Error: 4353 - Conflicting file relocations have been specified for file '\<Logical_FileName>'. Only a single WITH MOVE clause should be specified for any logical file name." due to a database where some files have been created, deleted several times with the same logical filename. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14125524">[14125524](#14125524)</a> | Adds improvement to report SQL Server native error 35217 in the `AlwaysOn_health` XEvent log: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 35217, Severity: 16, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The thread pool for Always On Availability Groups was unable to start a new worker thread because there are not enough available worker threads. This may degrade Always On Availability Groups performance. Use the "max worker threads" configuration option to increase number of allowable threads. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14135180">[14135180](#14135180)</a> | Adds improvement to replace High Availability Disaster Recovery (HADR) related logs output by Trace Flag (TF) 3605 to the error log to a new extended event `hadr_trace_message` which is written to the `alwayson_health` session. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14123177">[14123177](#14123177)</a> | [FIX: SQL Server often crashes when network.forceencryption property is set to '1' (KB5004750)](https://support.microsoft.com/help/5004750) | SQL Server Engine | Linux | Linux |
| <a id="14155805">[14155805](#14155805)</a> | Fixes an issue in SQL Server 2019, if IPv6 is disabled on Linux in the bootloader (GRUB), PolyBase will fail to start. | SQL Server Engine | PolyBase | Linux |
| <a id="14089504">[14089504](#14089504)</a> | Fixes an issue in SQL Server 2019 where you may encounter an Access Violation or Assertion when using the `sys.dm_exec_query_statistics_xml` Dynamic Management View. | SQL Server Engine | Query Execution | Windows |
| <a id="14124437">[14124437](#14124437)</a> | Fixes the access violation that occurs when you use graph shortest path expressions with `LIKE` predicates. | SQL Server Engine | Query Execution | Windows |
| <a id="13648398">[13648398](#13648398)</a> | [FIX: Dropping an index from the view on the primary may cause access violation on readable secondary (KB5005321)](https://support.microsoft.com/help/5005321) | SQL Server Engine | Query Optimizer | Windows |
| <a id="14085885">[14085885](#14085885)</a> | Fixes an issue where optimizer doesn't push down constant parameters to remote query via linked server. | SQL Server Engine | Query Optimizer | All |
| <a id="14129474">[14129474](#14129474)</a> | Fixes an issue where `NULL` values are populated for the `$from_id`, `$to_id` columns in a graph edge table when batch mode execution is chosen in SQL Server 2019. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14135092">[14135092](#14135092)</a> | Ensures that the correct error is returned, when an invalid table name is referenced inside a `SHORTEST_PATH` query on graph tables in SQL Server. | SQL Server Engine | Query Optimizer | All |
| <a id="14161380">[14161380](#14161380)</a> | Fixes an issue where you see `USERSTORE_SCHEMAMGR` grow uncontrollably and eventually leading to memory contention issues when you use graph queries in SQL Server 2019. | SQL Server Engine | Query Optimizer | All |
| <a id="14128989">[14128989](#14128989)</a> | Fixes missing data in the Change Data Capture (CDC) side table and adds additional error handling to prevent data loss. | SQL Server Engine | Replication | Windows |
| <a id="14085888">[14085888](#14085888)</a> | Fixed the memory release issue in execution of the `STDistance` spatial method while using spatial index. Before the fix, memory usage of `MEMORYCLERK_SOSNODE` gradually grew until all the memory available is taken. | SQL Server Engine | Spatial | Windows |
| <a id="14124394">[14124394](#14124394)</a> | [FIX: SQL Server affinity settings are reset after applying CU for SQL Server 2019 (KB5004573)](https://support.microsoft.com/help/5004573) | SQL Server Engine | SQL OS | Windows |
| <a id="14008525">[14008525](#14008525)</a> | Fixes an issue that causes the SQL Server to terminate. </br></br>ex_terminator - Last chance exception handling | SQL Server Engine | Storage Management | All |
| <a id="13713094">[13713094](#13713094)</a> | [FIX: Debug assert when a lock is acquired by the ParNested Transaction and attempts to get logged in sLog for the parent transaction (KB5004733)](https://support.microsoft.com/help/5004733) | SQL Server Engine | Transaction Services | All |

## File hash information

| File name | SHA1 hash | SHA256 hash |
|---|---|---|
| SQLServer2019-KB5004524-x64.exe | F145A82E48219E5BF80C7DCF57EA3C902C4D395F | C6D7BD9EBC82A68EA2D70638312120CEA66DB7BD633E82943D94035EC73A9934 |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU12 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/08/sqlserver2019-kb5004524-x64_f145a82e48219e5bf80c7dcf57ea3c902c4d395f.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5004524-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5004524-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5004524-x64.exe| C6D7BD9EBC82A68EA2D70638312120CEA66DB7BD633E82943D94035EC73A9934 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.15  | 291744    | 19-Jul-21 | 16:08 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 19-Jul-21 | 16:09 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.15      | 757128    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 174496    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 198560    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 201120    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 197536    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 213920    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 196512    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 192416    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 251296    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 172960    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 196000    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.15      | 1097112   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.15      | 479624    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 53656     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 58256     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 58776     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57752     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 60824     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57248     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57232     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 66456     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 52624     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57248     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16784     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 17816     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16792     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 19-Jul-21 | 16:09 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 19-Jul-21 | 16:09 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 19-Jul-21 | 16:09 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 19-Jul-21 | 16:09 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 19-Jul-21 | 16:09 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 19-Jul-21 | 16:09 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 19-Jul-21 | 16:09 | x86      |
| Msmdctr.dll                                               | 2018.150.35.15  | 37280     | 19-Jul-21 | 16:09 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.15  | 66288024  | 19-Jul-21 | 16:09 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.15  | 47783320  | 19-Jul-21 | 16:09 | x86      |
| Msmdpump.dll                                              | 2018.150.35.15  | 10187656  | 19-Jul-21 | 16:09 | x64      |
| Msmdredir.dll                                             | 2018.150.35.15  | 7955864   | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16272     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 17304     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15760     | 19-Jul-21 | 16:09 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15760     | 19-Jul-21 | 16:09 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.15  | 65825176  | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 832400    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1627016   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1452952   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1641880   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1607576   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1000344   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 991632    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1535896   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1520520   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 809880    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1595288   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 831384    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1623456   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1449888   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1636768   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1603472   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 997792    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 990104    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1531808   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1516960   | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 808856    | 19-Jul-21 | 16:09 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1590680   | 19-Jul-21 | 16:09 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.15  | 10185120  | 19-Jul-21 | 16:09 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.15  | 8277912   | 19-Jul-21 | 16:09 | x86      |
| Msolap.dll                                                | 2018.150.35.15  | 11014552  | 19-Jul-21 | 16:09 | x64      |
| Msolap.dll                                                | 2018.150.35.15  | 8607136   | 19-Jul-21 | 16:09 | x86      |
| Msolui.dll                                                | 2018.150.35.15  | 305560    | 19-Jul-21 | 16:09 | x64      |
| Msolui.dll                                                | 2018.150.35.15  | 285064    | 19-Jul-21 | 16:09 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 19-Jul-21 | 16:09 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 19-Jul-21 | 16:09 | x64      |
| Sqlboot.dll                                               | 2019.150.4153.1 | 213888    | 19-Jul-21 | 16:09 | x64      |
| Sqlceip.exe                                               | 15.0.4153.1     | 291720    | 19-Jul-21 | 16:09 | x86      |
| Sqldumper.exe                                             | 2019.150.4153.1 | 152480    | 19-Jul-21 | 16:09 | x86      |
| Sqldumper.exe                                             | 2019.150.4153.1 | 185248    | 19-Jul-21 | 16:09 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 19-Jul-21 | 16:09 | x86      |
| Tmapi.dll                                                 | 2018.150.35.15  | 6177184   | 19-Jul-21 | 16:09 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.15  | 4916632   | 19-Jul-21 | 16:09 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.15  | 1183648   | 19-Jul-21 | 16:09 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.15  | 6805384   | 19-Jul-21 | 16:09 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.15  | 26024864  | 19-Jul-21 | 16:09 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.15  | 35459464  | 19-Jul-21 | 16:10 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4153.1 | 74624     | 19-Jul-21 | 16:08 | x86      |
| Instapi150.dll                       | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:08 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4153.1 | 99232     | 19-Jul-21 | 16:08 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:08 | x86      |
| Msasxpress.dll                       | 2018.150.35.15  | 31112     | 19-Jul-21 | 16:09 | x64      |
| Msasxpress.dll                       | 2018.150.35.15  | 26016     | 19-Jul-21 | 16:09 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4153.1 | 74632     | 19-Jul-21 | 16:08 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4153.1 | 86928     | 19-Jul-21 | 16:08 | x64      |
| Sqldumper.exe                        | 2019.150.4153.1 | 152480    | 19-Jul-21 | 16:08 | x86      |
| Sqldumper.exe                        | 2019.150.4153.1 | 185248    | 19-Jul-21 | 16:09 | x64      |
| Sqlftacct.dll                        | 2019.150.4153.1 | 58256     | 19-Jul-21 | 16:09 | x86      |
| Sqlftacct.dll                        | 2019.150.4153.1 | 78736     | 19-Jul-21 | 16:09 | x64      |
| Sqlmanager.dll                       | 2019.150.4153.1 | 877456    | 19-Jul-21 | 16:09 | x64      |
| Sqlmanager.dll                       | 2019.150.4153.1 | 742288    | 19-Jul-21 | 16:09 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4153.1 | 377760    | 19-Jul-21 | 16:09 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4153.1 | 430976    | 19-Jul-21 | 16:09 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4153.1 | 275328    | 19-Jul-21 | 16:08 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4153.1 | 357248    | 19-Jul-21 | 16:08 | x64      |
| Svrenumapi150.dll                    | 2019.150.4153.1 | 910208    | 19-Jul-21 | 16:08 | x86      |
| Svrenumapi150.dll                    | 2019.150.4153.1 | 1160072   | 19-Jul-21 | 16:08 | x64      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4153.1 | 136064    | 19-Jul-21 | 16:09 | x86      |
| Dreplaycommon.dll     | 2019.150.4153.1 | 665488    | 19-Jul-21 | 16:09 | x86      |
| Dreplayutil.dll       | 2019.150.4153.1 | 304008    | 19-Jul-21 | 16:09 | x86      |
| Instapi150.dll        | 2019.150.4153.1 | 86912     | 19-Jul-21 | 15:47 | x64      |
| Sqlresourceloader.dll | 2019.150.4153.1 | 37792     | 19-Jul-21 | 16:09 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4153.1 | 665488    | 19-Jul-21 | 16:09 | x86      |
| Dreplaycontroller.exe | 2019.150.4153.1 | 365440    | 19-Jul-21 | 16:09 | x86      |
| Instapi150.dll        | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:09 | x64      |
| Sqlresourceloader.dll | 2019.150.4153.1 | 37792     | 19-Jul-21 | 16:09 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4153.1 | 4657056   | 19-Jul-21 | 17:10 | x64      |
| Aetm-enclave.dll                           | 2019.150.4153.1 | 4611480   | 19-Jul-21 | 17:10 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4153.1 | 4930848   | 19-Jul-21 | 17:10 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4153.1 | 4872464   | 19-Jul-21 | 17:10 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 19-Jul-21 | 16:07 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 19-Jul-21 | 16:07 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 19-Jul-21 | 17:10 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 19-Jul-21 | 17:10 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 19-Jul-21 | 17:10 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 19-Jul-21 | 17:10 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4153.1 | 279456    | 19-Jul-21 | 17:10 | x64      |
| Dcexec.exe                                 | 2019.150.4153.1 | 86928     | 19-Jul-21 | 17:10 | x64      |
| Fssres.dll                                 | 2019.150.4153.1 | 95112     | 19-Jul-21 | 17:10 | x64      |
| Hadrres.dll                                | 2019.150.4153.1 | 201608    | 19-Jul-21 | 17:10 | x64      |
| Hkcompile.dll                              | 2019.150.4153.1 | 1291144   | 19-Jul-21 | 17:10 | x64      |
| Hkengine.dll                               | 2019.150.4153.1 | 5784480   | 19-Jul-21 | 17:10 | x64      |
| Hkruntime.dll                              | 2019.150.4153.1 | 181152    | 19-Jul-21 | 17:10 | x64      |
| Hktempdb.dll                               | 2019.150.4153.1 | 62336     | 19-Jul-21 | 17:10 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 19-Jul-21 | 17:10 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4153.1     | 234400    | 19-Jul-21 | 17:10 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4153.1 | 324496    | 19-Jul-21 | 17:10 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4153.1 | 91016     | 19-Jul-21 | 17:10 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 19-Jul-21 | 17:10 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 19-Jul-21 | 17:10 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 19-Jul-21 | 17:10 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 19-Jul-21 | 17:10 | x64      |
| Qds.dll                                    | 2019.150.4153.1 | 1184656   | 19-Jul-21 | 17:10 | x64      |
| Rsfxft.dll                                 | 2019.150.4153.1 | 50048     | 19-Jul-21 | 17:10 | x64      |
| Secforwarder.dll                           | 2019.150.4153.1 | 78736     | 19-Jul-21 | 17:10 | x64      |
| Sqagtres.dll                               | 2019.150.4153.1 | 86920     | 19-Jul-21 | 17:10 | x64      |
| Sqlaamss.dll                               | 2019.150.4153.1 | 107392    | 19-Jul-21 | 17:10 | x64      |
| Sqlaccess.dll                              | 2019.150.4153.1 | 492448    | 19-Jul-21 | 17:10 | x64      |
| Sqlagent.exe                               | 2019.150.4153.1 | 730000    | 19-Jul-21 | 17:10 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4153.1 | 66464     | 19-Jul-21 | 17:10 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4153.1 | 78752     | 19-Jul-21 | 17:11 | x64      |
| Sqlboot.dll                                | 2019.150.4153.1 | 213888    | 19-Jul-21 | 17:10 | x64      |
| Sqlceip.exe                                | 15.0.4153.1     | 291720    | 19-Jul-21 | 17:10 | x86      |
| Sqlcmdss.dll                               | 2019.150.4153.1 | 86944     | 19-Jul-21 | 17:10 | x64      |
| Sqlctr150.dll                              | 2019.150.4153.1 | 140176    | 19-Jul-21 | 17:10 | x64      |
| Sqlctr150.dll                              | 2019.150.4153.1 | 115600    | 19-Jul-21 | 17:10 | x86      |
| Sqldk.dll                                  | 2019.150.4153.1 | 3150736   | 19-Jul-21 | 17:10 | x64      |
| Sqldtsss.dll                               | 2019.150.4153.1 | 107408    | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 1590160   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3494816   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3687328   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4154256   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4268944   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3404704   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3572640   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4146064   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4002704   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4051872   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 2216848   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 2167712   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3859360   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3535760   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4006816   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3810192   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3810192   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3605392   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3490720   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 1532816   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 3900320   | 19-Jul-21 | 17:10 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4153.1 | 4019088   | 19-Jul-21 | 17:10 | x64      |
| Sqllang.dll                                | 2019.150.4153.1 | 39932816  | 19-Jul-21 | 17:10 | x64      |
| Sqlmin.dll                                 | 2019.150.4153.1 | 40470432  | 19-Jul-21 | 17:10 | x64      |
| Sqlolapss.dll                              | 2019.150.4153.1 | 103328    | 19-Jul-21 | 17:10 | x64      |
| Sqlos.dll                                  | 2019.150.4153.1 | 41872     | 19-Jul-21 | 17:10 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4153.1 | 82848     | 19-Jul-21 | 17:10 | x64      |
| Sqlrepss.dll                               | 2019.150.4153.1 | 82848     | 19-Jul-21 | 17:10 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4153.1 | 50080     | 19-Jul-21 | 17:10 | x64      |
| Sqlscm.dll                                 | 2019.150.4153.1 | 86944     | 19-Jul-21 | 17:10 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4153.1 | 37768     | 19-Jul-21 | 17:10 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4153.1 | 5804928   | 19-Jul-21 | 17:10 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4153.1 | 672656    | 19-Jul-21 | 17:10 | x64      |
| Sqlservr.exe                               | 2019.150.4153.1 | 627600    | 19-Jul-21 | 17:10 | x64      |
| Sqlsvc.dll                                 | 2019.150.4153.1 | 181136    | 19-Jul-21 | 17:10 | x64      |
| Sqltses.dll                                | 2019.150.4153.1 | 9114496   | 19-Jul-21 | 17:10 | x64      |
| Sqsrvres.dll                               | 2019.150.4153.1 | 279432    | 19-Jul-21 | 17:10 | x64      |
| Svl.dll                                    | 2019.150.4153.1 | 160672    | 19-Jul-21 | 17:10 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 19-Jul-21 | 17:10 | x64      |
| Xe.dll                                     | 2019.150.4153.1 | 721824    | 19-Jul-21 | 17:11 | x64      |
| Xpadsi.exe                                 | 2019.150.4153.1 | 115616    | 19-Jul-21 | 17:10 | x64      |
| Xplog70.dll                                | 2019.150.4153.1 | 91040     | 19-Jul-21 | 17:10 | x64      |
| Xprepl.dll                                 | 2019.150.4153.1 | 119696    | 19-Jul-21 | 17:10 | x64      |
| Xpstar.dll                                 | 2019.150.4153.1 | 471944    | 19-Jul-21 | 17:10 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4153.1 | 263040    | 19-Jul-21 | 16:09 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4153.1 | 226176    | 19-Jul-21 | 16:09 | x64      |
| Distrib.exe                                                  | 2019.150.4153.1 | 234384    | 19-Jul-21 | 16:09 | x64      |
| Dteparse.dll                                                 | 2019.150.4153.1 | 123776    | 19-Jul-21 | 16:09 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4153.1 | 131976    | 19-Jul-21 | 16:09 | x64      |
| Dtepkg.dll                                                   | 2019.150.4153.1 | 148360    | 19-Jul-21 | 16:09 | x64      |
| Dtexec.exe                                                   | 2019.150.4153.1 | 71568     | 19-Jul-21 | 16:09 | x64      |
| Dts.dll                                                      | 2019.150.4153.1 | 3142560   | 19-Jul-21 | 16:09 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4153.1 | 500640    | 19-Jul-21 | 16:09 | x64      |
| Dtsconn.dll                                                  | 2019.150.4153.1 | 521088    | 19-Jul-21 | 16:09 | x64      |
| Dtshost.exe                                                  | 2019.150.4153.1 | 104320    | 19-Jul-21 | 16:09 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4153.1 | 566144    | 19-Jul-21 | 16:09 | x64      |
| Dtspipeline.dll                                              | 2019.150.4153.1 | 1328016   | 19-Jul-21 | 16:09 | x64      |
| Dtswizard.exe                                                | 15.0.4153.1     | 885640    | 19-Jul-21 | 16:09 | x64      |
| Dtuparse.dll                                                 | 2019.150.4153.1 | 99200     | 19-Jul-21 | 16:09 | x64      |
| Dtutil.exe                                                   | 2019.150.4153.1 | 147328    | 19-Jul-21 | 16:09 | x64      |
| Exceldest.dll                                                | 2019.150.4153.1 | 279432    | 19-Jul-21 | 16:09 | x64      |
| Excelsrc.dll                                                 | 2019.150.4153.1 | 308096    | 19-Jul-21 | 16:09 | x64      |
| Execpackagetask.dll                                          | 2019.150.4153.1 | 185216    | 19-Jul-21 | 16:09 | x64      |
| Flatfiledest.dll                                             | 2019.150.4153.1 | 410528    | 19-Jul-21 | 16:09 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4153.1 | 426880    | 19-Jul-21 | 16:09 | x64      |
| Logread.exe                                                  | 2019.150.4153.1 | 717712    | 19-Jul-21 | 16:09 | x64      |
| Mergetxt.dll                                                 | 2019.150.4153.1 | 74624     | 19-Jul-21 | 16:09 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4153.1     | 58272     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4153.1     | 41856     | 19-Jul-21 | 16:09 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4153.1     | 390032    | 19-Jul-21 | 16:09 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4153.1 | 111496    | 19-Jul-21 | 16:09 | x64      |
| Msgprox.dll                                                  | 2019.150.4153.1 | 299936    | 19-Jul-21 | 16:09 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 19-Jul-21 | 16:08 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4153.1 | 1495968   | 19-Jul-21 | 16:09 | x64      |
| Oledbdest.dll                                                | 2019.150.4153.1 | 279424    | 19-Jul-21 | 16:09 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4153.1 | 312192    | 19-Jul-21 | 16:09 | x64      |
| Osql.exe                                                     | 2019.150.4153.1 | 91040     | 19-Jul-21 | 16:09 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4153.1 | 496528    | 19-Jul-21 | 16:09 | x64      |
| Rawdest.dll                                                  | 2019.150.4153.1 | 226176    | 19-Jul-21 | 16:09 | x64      |
| Rawsource.dll                                                | 2019.150.4153.1 | 209792    | 19-Jul-21 | 16:09 | x64      |
| Rdistcom.dll                                                 | 2019.150.4153.1 | 914320    | 19-Jul-21 | 16:09 | x64      |
| Recordsetdest.dll                                            | 2019.150.4153.1 | 201600    | 19-Jul-21 | 16:09 | x64      |
| Repldp.dll                                                   | 2019.150.4153.1 | 312208    | 19-Jul-21 | 16:09 | x64      |
| Replerrx.dll                                                 | 2019.150.4153.1 | 181136    | 19-Jul-21 | 16:09 | x64      |
| Replisapi.dll                                                | 2019.150.4153.1 | 394128    | 19-Jul-21 | 16:09 | x64      |
| Replmerg.exe                                                 | 2019.150.4153.1 | 562080    | 19-Jul-21 | 16:09 | x64      |
| Replprov.dll                                                 | 2019.150.4153.1 | 852880    | 19-Jul-21 | 16:09 | x64      |
| Replrec.dll                                                  | 2019.150.4153.1 | 1033104   | 19-Jul-21 | 16:09 | x64      |
| Replsub.dll                                                  | 2019.150.4153.1 | 471968    | 19-Jul-21 | 16:09 | x64      |
| Replsync.dll                                                 | 2019.150.4153.1 | 164752    | 19-Jul-21 | 16:09 | x64      |
| Spresolv.dll                                                 | 2019.150.4153.1 | 275360    | 19-Jul-21 | 16:09 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4153.1 | 263064    | 19-Jul-21 | 16:08 | x64      |
| Sqldiag.exe                                                  | 2019.150.4153.1 | 1139584   | 19-Jul-21 | 16:09 | x64      |
| Sqldistx.dll                                                 | 2019.150.4153.1 | 246672    | 19-Jul-21 | 16:09 | x64      |
| Sqllogship.exe                                               | 15.0.4153.1     | 103296    | 19-Jul-21 | 16:09 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4153.1 | 398224    | 19-Jul-21 | 16:09 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4153.1 | 37792     | 19-Jul-21 | 16:09 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4153.1 | 50080     | 19-Jul-21 | 16:09 | x64      |
| Sqlscm.dll                                                   | 2019.150.4153.1 | 78752     | 19-Jul-21 | 16:09 | x86      |
| Sqlscm.dll                                                   | 2019.150.4153.1 | 86944     | 19-Jul-21 | 16:09 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4153.1 | 148368    | 19-Jul-21 | 16:09 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4153.1 | 181136    | 19-Jul-21 | 16:09 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4153.1 | 201608    | 19-Jul-21 | 16:09 | x64      |
| Ssradd.dll                                                   | 2019.150.4153.1 | 82816     | 19-Jul-21 | 16:09 | x64      |
| Ssravg.dll                                                   | 2019.150.4153.1 | 82848     | 19-Jul-21 | 16:09 | x64      |
| Ssrdown.dll                                                  | 2019.150.4153.1 | 74624     | 19-Jul-21 | 16:09 | x64      |
| Ssrmax.dll                                                   | 2019.150.4153.1 | 82832     | 19-Jul-21 | 16:09 | x64      |
| Ssrmin.dll                                                   | 2019.150.4153.1 | 82816     | 19-Jul-21 | 16:09 | x64      |
| Ssrpub.dll                                                   | 2019.150.4153.1 | 74624     | 19-Jul-21 | 16:09 | x64      |
| Ssrup.dll                                                    | 2019.150.4153.1 | 74624     | 19-Jul-21 | 16:09 | x64      |
| Txagg.dll                                                    | 2019.150.4153.1 | 390024    | 19-Jul-21 | 16:09 | x64      |
| Txbdd.dll                                                    | 2019.150.4153.1 | 189312    | 19-Jul-21 | 16:09 | x64      |
| Txdatacollector.dll                                          | 2019.150.4153.1 | 484224    | 19-Jul-21 | 16:09 | x64      |
| Txdataconvert.dll                                            | 2019.150.4153.1 | 316320    | 19-Jul-21 | 16:09 | x64      |
| Txderived.dll                                                | 2019.150.4153.1 | 639904    | 19-Jul-21 | 16:09 | x64      |
| Txlookup.dll                                                 | 2019.150.4153.1 | 541600    | 19-Jul-21 | 16:09 | x64      |
| Txmerge.dll                                                  | 2019.150.4153.1 | 246664    | 19-Jul-21 | 16:09 | x64      |
| Txmergejoin.dll                                              | 2019.150.4153.1 | 308096    | 19-Jul-21 | 16:09 | x64      |
| Txmulticast.dll                                              | 2019.150.4153.1 | 144256    | 19-Jul-21 | 16:09 | x64      |
| Txrowcount.dll                                               | 2019.150.4153.1 | 140160    | 19-Jul-21 | 16:09 | x64      |
| Txsort.dll                                                   | 2019.150.4153.1 | 287632    | 19-Jul-21 | 16:09 | x64      |
| Txsplit.dll                                                  | 2019.150.4153.1 | 623520    | 19-Jul-21 | 16:09 | x64      |
| Txunionall.dll                                               | 2019.150.4153.1 | 197512    | 19-Jul-21 | 16:09 | x64      |
| Xe.dll                                                       | 2019.150.4153.1 | 721824    | 19-Jul-21 | 16:09 | x64      |
| Xmlsub.dll                                                   | 2019.150.4153.1 | 295808    | 19-Jul-21 | 16:09 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4153.1 | 95120     | 19-Jul-21 | 16:09 | x64      |
| Exthost.exe        | 2019.150.4153.1 | 238496    | 19-Jul-21 | 16:09 | x64      |
| Launchpad.exe      | 2019.150.4153.1 | 1217424   | 19-Jul-21 | 16:09 | x64      |
| Sqlsatellite.dll   | 2019.150.4153.1 | 1016736   | 19-Jul-21 | 16:09 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4153.1 | 684960    | 19-Jul-21 | 16:09 | x64      |
| Fdhost.exe     | 2019.150.4153.1 | 127888    | 19-Jul-21 | 16:09 | x64      |
| Fdlauncher.exe | 2019.150.4153.1 | 78752     | 19-Jul-21 | 16:09 | x64      |
| Sqlft150ph.dll | 2019.150.4153.1 | 91008     | 19-Jul-21 | 16:09 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4153.1  | 29600     | 19-Jul-21 | 16:10 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4153.1 | 226176    | 19-Jul-21 | 16:15 | x86      |
| Commanddest.dll                                               | 2019.150.4153.1 | 263040    | 19-Jul-21 | 16:15 | x64      |
| Dteparse.dll                                                  | 2019.150.4153.1 | 111488    | 19-Jul-21 | 16:15 | x86      |
| Dteparse.dll                                                  | 2019.150.4153.1 | 123776    | 19-Jul-21 | 16:15 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4153.1 | 115592    | 19-Jul-21 | 16:15 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4153.1 | 131976    | 19-Jul-21 | 16:15 | x64      |
| Dtepkg.dll                                                    | 2019.150.4153.1 | 132000    | 19-Jul-21 | 16:15 | x86      |
| Dtepkg.dll                                                    | 2019.150.4153.1 | 148360    | 19-Jul-21 | 16:15 | x64      |
| Dtexec.exe                                                    | 2019.150.4153.1 | 62848     | 19-Jul-21 | 16:15 | x86      |
| Dtexec.exe                                                    | 2019.150.4153.1 | 71568     | 19-Jul-21 | 16:15 | x64      |
| Dts.dll                                                       | 2019.150.4153.1 | 2761632   | 19-Jul-21 | 16:16 | x86      |
| Dts.dll                                                       | 2019.150.4153.1 | 3142560   | 19-Jul-21 | 16:16 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4153.1 | 443264    | 19-Jul-21 | 16:15 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4153.1 | 500640    | 19-Jul-21 | 16:15 | x64      |
| Dtsconn.dll                                                   | 2019.150.4153.1 | 430976    | 19-Jul-21 | 16:15 | x86      |
| Dtsconn.dll                                                   | 2019.150.4153.1 | 521088    | 19-Jul-21 | 16:15 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4153.1 | 110976    | 19-Jul-21 | 16:15 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4153.1 | 92552     | 19-Jul-21 | 16:16 | x86      |
| Dtshost.exe                                                   | 2019.150.4153.1 | 104320    | 19-Jul-21 | 16:15 | x64      |
| Dtshost.exe                                                   | 2019.150.4153.1 | 87456     | 19-Jul-21 | 16:15 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4153.1 | 553888    | 19-Jul-21 | 16:15 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4153.1 | 566144    | 19-Jul-21 | 16:15 | x64      |
| Dtspipeline.dll                                               | 2019.150.4153.1 | 1119120   | 19-Jul-21 | 16:16 | x86      |
| Dtspipeline.dll                                               | 2019.150.4153.1 | 1328016   | 19-Jul-21 | 16:16 | x64      |
| Dtswizard.exe                                                 | 15.0.4153.1     | 885640    | 19-Jul-21 | 16:16 | x64      |
| Dtswizard.exe                                                 | 15.0.4153.1     | 889736    | 19-Jul-21 | 16:16 | x86      |
| Dtuparse.dll                                                  | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:15 | x86      |
| Dtuparse.dll                                                  | 2019.150.4153.1 | 99200     | 19-Jul-21 | 16:15 | x64      |
| Dtutil.exe                                                    | 2019.150.4153.1 | 128928    | 19-Jul-21 | 16:15 | x86      |
| Dtutil.exe                                                    | 2019.150.4153.1 | 147328    | 19-Jul-21 | 16:15 | x64      |
| Exceldest.dll                                                 | 2019.150.4153.1 | 234376    | 19-Jul-21 | 16:15 | x86      |
| Exceldest.dll                                                 | 2019.150.4153.1 | 279432    | 19-Jul-21 | 16:15 | x64      |
| Excelsrc.dll                                                  | 2019.150.4153.1 | 258944    | 19-Jul-21 | 16:15 | x86      |
| Excelsrc.dll                                                  | 2019.150.4153.1 | 308096    | 19-Jul-21 | 16:15 | x64      |
| Execpackagetask.dll                                           | 2019.150.4153.1 | 148360    | 19-Jul-21 | 16:15 | x86      |
| Execpackagetask.dll                                           | 2019.150.4153.1 | 185216    | 19-Jul-21 | 16:15 | x64      |
| Flatfiledest.dll                                              | 2019.150.4153.1 | 357248    | 19-Jul-21 | 16:15 | x86      |
| Flatfiledest.dll                                              | 2019.150.4153.1 | 410528    | 19-Jul-21 | 16:15 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4153.1 | 369536    | 19-Jul-21 | 16:15 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4153.1 | 426880    | 19-Jul-21 | 16:15 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4153.1     | 119680    | 19-Jul-21 | 16:15 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4153.1     | 119712    | 19-Jul-21 | 16:15 | x86      |
| Isserverexec.exe                                              | 15.0.4153.1     | 144288    | 19-Jul-21 | 16:15 | x64      |
| Isserverexec.exe                                              | 15.0.4153.1     | 148368    | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4153.1     | 115616    | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4153.1     | 58272     | 19-Jul-21 | 16:16 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4153.1     | 508800    | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4153.1     | 508832    | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4153.1     | 41856     | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4153.1     | 41856     | 19-Jul-21 | 16:16 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4153.1     | 390032    | 19-Jul-21 | 16:16 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4153.1     | 58240     | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4153.1     | 58256     | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4153.1     | 140176    | 19-Jul-21 | 16:15 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4153.1     | 140176    | 19-Jul-21 | 16:16 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4153.1     | 218000    | 19-Jul-21 | 16:15 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4153.1 | 111496    | 19-Jul-21 | 16:15 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4153.1 | 99200     | 19-Jul-21 | 16:15 | x86      |
| Msmdpp.dll                                                    | 2018.150.35.15  | 10062728  | 19-Jul-21 | 16:16 | x64      |
| Odbcdest.dll                                                  | 2019.150.4153.1 | 316296    | 19-Jul-21 | 16:15 | x86      |
| Odbcdest.dll                                                  | 2019.150.4153.1 | 369568    | 19-Jul-21 | 16:15 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4153.1 | 328584    | 19-Jul-21 | 16:15 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4153.1 | 381856    | 19-Jul-21 | 16:15 | x64      |
| Oledbdest.dll                                                 | 2019.150.4153.1 | 238464    | 19-Jul-21 | 16:15 | x86      |
| Oledbdest.dll                                                 | 2019.150.4153.1 | 279424    | 19-Jul-21 | 16:15 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4153.1 | 263040    | 19-Jul-21 | 16:15 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4153.1 | 312192    | 19-Jul-21 | 16:15 | x64      |
| Rawdest.dll                                                   | 2019.150.4153.1 | 189312    | 19-Jul-21 | 16:15 | x86      |
| Rawdest.dll                                                   | 2019.150.4153.1 | 226176    | 19-Jul-21 | 16:15 | x64      |
| Rawsource.dll                                                 | 2019.150.4153.1 | 177032    | 19-Jul-21 | 16:15 | x86      |
| Rawsource.dll                                                 | 2019.150.4153.1 | 209792    | 19-Jul-21 | 16:15 | x64      |
| Recordsetdest.dll                                             | 2019.150.4153.1 | 177024    | 19-Jul-21 | 16:15 | x86      |
| Recordsetdest.dll                                             | 2019.150.4153.1 | 201600    | 19-Jul-21 | 16:15 | x64      |
| Sqlceip.exe                                                   | 15.0.4153.1     | 291720    | 19-Jul-21 | 16:08 | x86      |
| Sqldest.dll                                                   | 2019.150.4153.1 | 238472    | 19-Jul-21 | 16:15 | x86      |
| Sqldest.dll                                                   | 2019.150.4153.1 | 275336    | 19-Jul-21 | 16:15 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4153.1 | 168840    | 19-Jul-21 | 16:16 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4153.1 | 201608    | 19-Jul-21 | 16:16 | x64      |
| Txagg.dll                                                     | 2019.150.4153.1 | 328576    | 19-Jul-21 | 16:16 | x86      |
| Txagg.dll                                                     | 2019.150.4153.1 | 390024    | 19-Jul-21 | 16:16 | x64      |
| Txbdd.dll                                                     | 2019.150.4153.1 | 152448    | 19-Jul-21 | 16:16 | x86      |
| Txbdd.dll                                                     | 2019.150.4153.1 | 189312    | 19-Jul-21 | 16:16 | x64      |
| Txbestmatch.dll                                               | 2019.150.4153.1 | 545664    | 19-Jul-21 | 16:16 | x86      |
| Txbestmatch.dll                                               | 2019.150.4153.1 | 652176    | 19-Jul-21 | 16:16 | x64      |
| Txcache.dll                                                   | 2019.150.4153.1 | 164736    | 19-Jul-21 | 16:16 | x86      |
| Txcache.dll                                                   | 2019.150.4153.1 | 197512    | 19-Jul-21 | 16:16 | x64      |
| Txcharmap.dll                                                 | 2019.150.4153.1 | 271240    | 19-Jul-21 | 16:16 | x86      |
| Txcharmap.dll                                                 | 2019.150.4153.1 | 312224    | 19-Jul-21 | 16:16 | x64      |
| Txcopymap.dll                                                 | 2019.150.4153.1 | 164752    | 19-Jul-21 | 16:16 | x86      |
| Txcopymap.dll                                                 | 2019.150.4153.1 | 197504    | 19-Jul-21 | 16:16 | x64      |
| Txdataconvert.dll                                             | 2019.150.4153.1 | 275328    | 19-Jul-21 | 16:16 | x86      |
| Txdataconvert.dll                                             | 2019.150.4153.1 | 316320    | 19-Jul-21 | 16:16 | x64      |
| Txderived.dll                                                 | 2019.150.4153.1 | 557960    | 19-Jul-21 | 16:16 | x86      |
| Txderived.dll                                                 | 2019.150.4153.1 | 639904    | 19-Jul-21 | 16:16 | x64      |
| Txfileextractor.dll                                           | 2019.150.4153.1 | 181128    | 19-Jul-21 | 16:16 | x86      |
| Txfileextractor.dll                                           | 2019.150.4153.1 | 217984    | 19-Jul-21 | 16:16 | x64      |
| Txfileinserter.dll                                            | 2019.150.4153.1 | 181128    | 19-Jul-21 | 16:16 | x86      |
| Txfileinserter.dll                                            | 2019.150.4153.1 | 213896    | 19-Jul-21 | 16:16 | x64      |
| Txgroupdups.dll                                               | 2019.150.4153.1 | 254848    | 19-Jul-21 | 16:16 | x86      |
| Txgroupdups.dll                                               | 2019.150.4153.1 | 312200    | 19-Jul-21 | 16:16 | x64      |
| Txlineage.dll                                                 | 2019.150.4153.1 | 127872    | 19-Jul-21 | 16:16 | x86      |
| Txlineage.dll                                                 | 2019.150.4153.1 | 152456    | 19-Jul-21 | 16:16 | x64      |
| Txlookup.dll                                                  | 2019.150.4153.1 | 467848    | 19-Jul-21 | 16:16 | x86      |
| Txlookup.dll                                                  | 2019.150.4153.1 | 541600    | 19-Jul-21 | 16:16 | x64      |
| Txmerge.dll                                                   | 2019.150.4153.1 | 201632    | 19-Jul-21 | 16:16 | x86      |
| Txmerge.dll                                                   | 2019.150.4153.1 | 246664    | 19-Jul-21 | 16:16 | x64      |
| Txmergejoin.dll                                               | 2019.150.4153.1 | 254848    | 19-Jul-21 | 16:16 | x86      |
| Txmergejoin.dll                                               | 2019.150.4153.1 | 308096    | 19-Jul-21 | 16:16 | x64      |
| Txmulticast.dll                                               | 2019.150.4153.1 | 115592    | 19-Jul-21 | 16:16 | x86      |
| Txmulticast.dll                                               | 2019.150.4153.1 | 144256    | 19-Jul-21 | 16:16 | x64      |
| Txpivot.dll                                                   | 2019.150.4153.1 | 209792    | 19-Jul-21 | 16:16 | x86      |
| Txpivot.dll                                                   | 2019.150.4153.1 | 238464    | 19-Jul-21 | 16:16 | x64      |
| Txrowcount.dll                                                | 2019.150.4153.1 | 111520    | 19-Jul-21 | 16:16 | x86      |
| Txrowcount.dll                                                | 2019.150.4153.1 | 140160    | 19-Jul-21 | 16:16 | x64      |
| Txsampling.dll                                                | 2019.150.4153.1 | 156544    | 19-Jul-21 | 16:16 | x86      |
| Txsampling.dll                                                | 2019.150.4153.1 | 193416    | 19-Jul-21 | 16:16 | x64      |
| Txscd.dll                                                     | 2019.150.4153.1 | 197504    | 19-Jul-21 | 16:16 | x86      |
| Txscd.dll                                                     | 2019.150.4153.1 | 234376    | 19-Jul-21 | 16:16 | x64      |
| Txsort.dll                                                    | 2019.150.4153.1 | 234368    | 19-Jul-21 | 16:16 | x86      |
| Txsort.dll                                                    | 2019.150.4153.1 | 287632    | 19-Jul-21 | 16:16 | x64      |
| Txsplit.dll                                                   | 2019.150.4153.1 | 549768    | 19-Jul-21 | 16:16 | x86      |
| Txsplit.dll                                                   | 2019.150.4153.1 | 623520    | 19-Jul-21 | 16:16 | x64      |
| Txtermextraction.dll                                          | 2019.150.4153.1 | 8643464   | 19-Jul-21 | 16:16 | x86      |
| Txtermextraction.dll                                          | 2019.150.4153.1 | 8700832   | 19-Jul-21 | 16:16 | x64      |
| Txtermlookup.dll                                              | 2019.150.4153.1 | 4137856   | 19-Jul-21 | 16:16 | x86      |
| Txtermlookup.dll                                              | 2019.150.4153.1 | 4182944   | 19-Jul-21 | 16:16 | x64      |
| Txunionall.dll                                                | 2019.150.4153.1 | 160640    | 19-Jul-21 | 16:16 | x86      |
| Txunionall.dll                                                | 2019.150.4153.1 | 197512    | 19-Jul-21 | 16:16 | x64      |
| Txunpivot.dll                                                 | 2019.150.4153.1 | 181128    | 19-Jul-21 | 16:16 | x86      |
| Txunpivot.dll                                                 | 2019.150.4153.1 | 213896    | 19-Jul-21 | 16:16 | x64      |
| Xe.dll                                                        | 2019.150.4153.1 | 631680    | 19-Jul-21 | 16:16 | x86      |
| Xe.dll                                                        | 2019.150.4153.1 | 721824    | 19-Jul-21 | 16:16 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1944.0     | 558480    | 19-Jul-21 | 16:59 | x86      |
| Dmsnative.dll                                                        | 2018.150.1944.0 | 151464    | 19-Jul-21 | 16:59 | x64      |
| Dwengineservice.dll                                                  | 15.0.1944.0     | 43920     | 19-Jul-21 | 16:59 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 19-Jul-21 | 16:59 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 19-Jul-21 | 16:59 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 19-Jul-21 | 16:59 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 19-Jul-21 | 16:59 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 19-Jul-21 | 16:59 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 19-Jul-21 | 16:59 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 19-Jul-21 | 16:59 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 19-Jul-21 | 16:59 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 19-Jul-21 | 16:59 | x64      |
| Instapi150.dll                                                       | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:59 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 19-Jul-21 | 16:59 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 19-Jul-21 | 16:59 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 19-Jul-21 | 16:59 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 19-Jul-21 | 16:59 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 19-Jul-21 | 16:59 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1944.0     | 66464     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1944.0     | 292240    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1944.0     | 1955752   | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1944.0     | 168360    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1944.0     | 647584    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1944.0     | 245152    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1944.0     | 138144    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1944.0     | 78744     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1944.0     | 50080     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1944.0     | 87440     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1944.0     | 1128344   | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1944.0     | 79760     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1944.0     | 69544     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1944.0     | 34216     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1944.0     | 30104     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1944.0     | 45480     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1944.0     | 20384     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1944.0     | 25504     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1944.0     | 130448    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1944.0     | 85416     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1944.0     | 99728     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1944.0     | 291744    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 119200    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 137120    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 140176    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 136608    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 149392    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 138640    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 133536    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 175520    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 116112    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1944.0     | 135584    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1944.0     | 71568     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1944.0     | 20904     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1944.0     | 36240     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1944.0     | 127888    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1944.0     | 3063712   | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1944.0     | 3954600   | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 117136    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 131984    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 136616    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 132496    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 147344    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 133024    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 129424    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 169872    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 114064    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1944.0     | 130960    | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1944.0     | 66464     | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1944.0     | 2681744   | 19-Jul-21 | 16:59 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1944.0     | 2435472   | 19-Jul-21 | 16:59 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4153.1 | 451464    | 19-Jul-21 | 16:59 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4153.1 | 7386016   | 19-Jul-21 | 16:59 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 19-Jul-21 | 16:59 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 19-Jul-21 | 16:59 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 19-Jul-21 | 16:59 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 19-Jul-21 | 16:59 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 19-Jul-21 | 16:59 | x64      |
| Secforwarder.dll                                                     | 2019.150.4153.1 | 78736     | 19-Jul-21 | 16:59 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1944.0 | 60320     | 19-Jul-21 | 16:59 | x64      |
| Sqldk.dll                                                            | 2019.150.4153.1 | 3150736   | 19-Jul-21 | 16:59 | x64      |
| Sqldumper.exe                                                        | 2019.150.4153.1 | 185248    | 19-Jul-21 | 16:59 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 1590160   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 4154256   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 3404704   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 4146064   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 4051872   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 2216848   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 2167712   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 3810192   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 3810192   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 1532816   | 19-Jul-21 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4153.1 | 4019088   | 19-Jul-21 | 16:53 | x64      |
| Sqlos.dll                                                            | 2019.150.4153.1 | 41872     | 19-Jul-21 | 16:59 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1944.0 | 4840352   | 19-Jul-21 | 16:59 | x64      |
| Sqltses.dll                                                          | 2019.150.4153.1 | 9114496   | 19-Jul-21 | 16:59 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 19-Jul-21 | 16:59 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 19-Jul-21 | 16:59 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 19-Jul-21 | 16:59 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4153.1  | 29568     | 19-Jul-21 | 16:09 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4153.1 | 1631136   | 19-Jul-21 | 16:30 | x86      |
| Dtaengine.exe                                                | 2019.150.4153.1 | 217984    | 19-Jul-21 | 16:30 | x86      |
| Dteparse.dll                                                 | 2019.150.4153.1 | 123776    | 19-Jul-21 | 16:30 | x64      |
| Dteparse.dll                                                 | 2019.150.4153.1 | 111488    | 19-Jul-21 | 16:30 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4153.1 | 115592    | 19-Jul-21 | 16:30 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4153.1 | 131976    | 19-Jul-21 | 16:30 | x64      |
| Dtepkg.dll                                                   | 2019.150.4153.1 | 132000    | 19-Jul-21 | 16:30 | x86      |
| Dtepkg.dll                                                   | 2019.150.4153.1 | 148360    | 19-Jul-21 | 16:30 | x64      |
| Dtexec.exe                                                   | 2019.150.4153.1 | 71568     | 19-Jul-21 | 16:30 | x64      |
| Dtexec.exe                                                   | 2019.150.4153.1 | 62848     | 19-Jul-21 | 16:30 | x86      |
| Dts.dll                                                      | 2019.150.4153.1 | 2761632   | 19-Jul-21 | 16:30 | x86      |
| Dts.dll                                                      | 2019.150.4153.1 | 3142560   | 19-Jul-21 | 16:30 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4153.1 | 443264    | 19-Jul-21 | 16:30 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4153.1 | 500640    | 19-Jul-21 | 16:30 | x64      |
| Dtsconn.dll                                                  | 2019.150.4153.1 | 521088    | 19-Jul-21 | 16:30 | x64      |
| Dtsconn.dll                                                  | 2019.150.4153.1 | 430976    | 19-Jul-21 | 16:30 | x86      |
| Dtshost.exe                                                  | 2019.150.4153.1 | 104320    | 19-Jul-21 | 16:30 | x64      |
| Dtshost.exe                                                  | 2019.150.4153.1 | 87456     | 19-Jul-21 | 16:30 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4153.1 | 566144    | 19-Jul-21 | 16:30 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4153.1 | 553888    | 19-Jul-21 | 16:30 | x86      |
| Dtspipeline.dll                                              | 2019.150.4153.1 | 1119120   | 19-Jul-21 | 16:30 | x86      |
| Dtspipeline.dll                                              | 2019.150.4153.1 | 1328016   | 19-Jul-21 | 16:30 | x64      |
| Dtswizard.exe                                                | 15.0.4153.1     | 885640    | 19-Jul-21 | 16:08 | x64      |
| Dtswizard.exe                                                | 15.0.4153.1     | 889736    | 19-Jul-21 | 16:08 | x86      |
| Dtuparse.dll                                                 | 2019.150.4153.1 | 99200     | 19-Jul-21 | 16:30 | x64      |
| Dtuparse.dll                                                 | 2019.150.4153.1 | 86912     | 19-Jul-21 | 16:30 | x86      |
| Dtutil.exe                                                   | 2019.150.4153.1 | 128928    | 19-Jul-21 | 16:30 | x86      |
| Dtutil.exe                                                   | 2019.150.4153.1 | 147328    | 19-Jul-21 | 16:30 | x64      |
| Exceldest.dll                                                | 2019.150.4153.1 | 279432    | 19-Jul-21 | 16:30 | x64      |
| Exceldest.dll                                                | 2019.150.4153.1 | 234376    | 19-Jul-21 | 16:30 | x86      |
| Excelsrc.dll                                                 | 2019.150.4153.1 | 308096    | 19-Jul-21 | 16:30 | x64      |
| Excelsrc.dll                                                 | 2019.150.4153.1 | 258944    | 19-Jul-21 | 16:30 | x86      |
| Flatfiledest.dll                                             | 2019.150.4153.1 | 410528    | 19-Jul-21 | 16:30 | x64      |
| Flatfiledest.dll                                             | 2019.150.4153.1 | 357248    | 19-Jul-21 | 16:30 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4153.1 | 426880    | 19-Jul-21 | 16:30 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4153.1 | 369536    | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4153.1     | 115584    | 19-Jul-21 | 16:08 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4153.1     | 402320    | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4153.1     | 402336    | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4153.1     | 2999168   | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4153.1     | 2999176   | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4153.1     | 41856     | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4153.1     | 41856     | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4153.1     | 58256     | 19-Jul-21 | 16:30 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 19-Jul-21 | 16:30 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4153.1 | 111496    | 19-Jul-21 | 16:30 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4153.1 | 99200     | 19-Jul-21 | 16:30 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.15  | 8277912   | 19-Jul-21 | 16:09 | x86      |
| Oledbdest.dll                                                | 2019.150.4153.1 | 238464    | 19-Jul-21 | 16:30 | x86      |
| Oledbdest.dll                                                | 2019.150.4153.1 | 279424    | 19-Jul-21 | 16:30 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4153.1 | 312192    | 19-Jul-21 | 16:30 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4153.1 | 263040    | 19-Jul-21 | 16:30 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4153.1 | 50080     | 19-Jul-21 | 16:30 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4153.1 | 37792     | 19-Jul-21 | 16:30 | x86      |
| Sqlscm.dll                                                   | 2019.150.4153.1 | 86944     | 19-Jul-21 | 16:30 | x64      |
| Sqlscm.dll                                                   | 2019.150.4153.1 | 78752     | 19-Jul-21 | 16:30 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4153.1 | 148368    | 19-Jul-21 | 16:30 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4153.1 | 181136    | 19-Jul-21 | 16:30 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4153.1 | 168840    | 19-Jul-21 | 16:30 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4153.1 | 201608    | 19-Jul-21 | 16:30 | x64      |
| Txdataconvert.dll                                            | 2019.150.4153.1 | 316320    | 19-Jul-21 | 16:30 | x64      |
| Txdataconvert.dll                                            | 2019.150.4153.1 | 275328    | 19-Jul-21 | 16:30 | x86      |
| Xe.dll                                                       | 2019.150.4153.1 | 631680    | 19-Jul-21 | 16:30 | x86      |
| Xe.dll                                                       | 2019.150.4153.1 | 721824    | 19-Jul-21 | 16:30 | x64      |

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
