---
title: Cumulative update 14 for SQL Server 2019 (KB5007182)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 14 (KB5007182).
ms.date: 06/30/2023
ms.custom: KB5007182
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5007182 - Cumulative Update 14 for SQL Server 2019

_Release Date:_ &nbsp; November 22, 2021  
_Version:_ &nbsp; 15.0.4188.2

## Summary

This article describes Cumulative Update package 14 (CU14) for Microsoft SQL Server 2019. This update contains 32 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 13, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4188.2**, file version: **2019.150.4188.2**
- Analysis Services - Product version: **15.0.35.19**, file version: **2018.150.35.19**

## Known issues in this update

### Issue one

After you install CU14, a parallel query that runs in batch mode might cause an access violation and create a memory dump file. To mitigate the issue, run the query to have a Degree of Parallelism of **1**, or disable batch mode processing by using [trace flag 9453](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf9453).

> [!NOTE]
> This issue is resolved in [CU15](cumulativeupdate15.md).

### Issue two: Access violation when session is reset

SQL Server 2019 CU14 introduced a [fix to address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the `SESSION` is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.

Microsoft is working on a fix for this issue and it will be available in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="14253632">[14253632](#14253632)</a> | Fixes the issue in SSAS 2017, where *msmdsrv.log* doesn't work when you customize the values of the configuration settings `MaxFileSizeMB` and `MaxNumberOfLogFiles`. | Analysis Services | Analysis Services | Windows |
| <a id="14302888">[14302888](#14302888)</a> | Fixes an issue where the DirectQuery query has no table join clause when you have a DirectQuery model with many-to-many relationship defined and run a DAX query. | Analysis Services | Analysis Services | Windows |
| <a id="14253624">[14253624](#14253624)</a> | Fixes the issue in SSIS 2017 when Dimension Processing returns the following error message: </br></br>clsid {ID}" could not be created and error code 0x80070005 "Access is denied.". Make sure that the component is registered correctly. </br>OnError: "Dimension Processing failed validation and returned error code 0x80040005" | Integration Services | Integration Services | Windows |
| <a id="14253642">[14253642](#14253642)</a> | Fixes the issue in MDS 2017, where the derived hierarchy permissions are lost in the copied version. | Master Data Services | Master Data Services | Windows |
| <a id="14253635">[14253635](#14253635)</a> | [FIX: Error when you use columnstore indexes and run versioned scans if all rows in a compressed rowgroup are deleted in SQL Server 2017 and 2019 (KB5004936)](https://support.microsoft.com/help/5004936) | SQL Server Engine | Column Stores | All |
| <a id="14080213">[14080213](#14080213)</a> | Fixes the failed assertion that occurs due to implicit conversion where predicate's precision is greater than the value. </br></br>Msg 3624, Level 20, State 1, Line \<LineNumber> </br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agree to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Server Engine | Column Stores | Windows |
| <a id="14276893">[14276893](#14276893)</a> | Fixes an Access Violation (AV) at `RbpEarlyFilter::TinyBitmapFilterSIMD` that occurs when you run queries on CLUSTERED COLUMNSTORE INDEX (CCI) tables. Here's the dump file: </br></br>Stack Dump being sent to \<FilePath> </br>SqlDumpExceptionHandler: Process 247 generated fatal exception c0000005 EXCEPTION_ACCESS_VIOLATION. SQL Server is terminating this process. </br>BEGIN STACK DUMP: </br>\<DateTime> </br>Exception Address = \<AddressNumber> Module(sqlmin+\<ID>) </br>Exception Code&nbsp;&nbsp;&nbsp;&nbsp;= c0000005 EXCEPTION_ACCESS_VIOLATION </br>Access Violation occurred reading address \<AddressNumber> | SQL Server Engine | Column Stores | All |
| <a id="14227887">[14227887](#14227887)</a> | Fixes an assert dump "pwchId && cwchId <= MAX_PATH && cwchId > 0" during Always On availability group (AG) Virtual Device Interface (VDI) seeding. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14253625">[14253625](#14253625)</a> | Fixes an issue where `Last_sent_time` and `Last_received_time` columns in DMV `dm_hadr_database_replica_states` doesn't get updated. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14295884">[14295884](#14295884)</a> | Fixes an issue where you encounter an "ex_terminator - Last chance exception handling" memory dump. The memory dump is associated with a lease timeout while the recovery of an Always On availability groups (AG) database is in progress. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14311616">[14311616](#14311616)</a> | Fixes the following error that occurs when you restore a database file (*.mdf*) that's larger than 15 GB on SQL Server 2019 Big Data Cluster (BDC) with high availability (HA) configuration: </br></br>Msg 42019, Level 16, State 4, Line \<LineNumber> </br>RESTORE MANAGED DATABASE operation failed. Internal service error. </br></br>Msg 3013, Level 16, State 1, Line \<LineNumber> </br>RESTORE DATABASE is terminating abnormally. | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="14328046">[14328046](#14328046)</a> | Fixes an access violation exception that may occur when `sp_server_diagnostics` is executed. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14162439">[14162439](#14162439)</a> | Fixes an issue where the following warning message occurs during the snapshot creation when you run the `DBCC CHECKDB` against a database that has a memory optimized filegroup: </br></br>[WARNING] Unable to create PerfCounter instance for DB xx (xxx): 0x800700b7. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14265296">[14265296](#14265296)</a> | [FIX: Non-yielding scheduler dumps during the recovery of a secondary availability database with a database snapshot (KB5007794)](https://support.microsoft.com/help/5007794) | SQL Server Engine | Methods to access stored data | All |
| <a id="13966323">[13966323](#13966323)</a> | Fixes the `EXCEPTION_INVALID_CRT_PARAMETER` dump that's generated on insert or update of wide replicated table. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="14134000">[14134000](#14134000)</a> | Fixes an issue where the `CollectPageLatchFields` can cause an access violation (AV) under certain timing conditions when the `latch_suspend_end` XEvent is turned on. The underlying reason is that this method assumes the Buffer is stable under the latch, which isn't true if the Buffer isn't in the Hashtable anymore. This hotfix avoids the AV by checking whether the Buffer is still in the Hashtable before accessing its underlying fields. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="14295855">[14295855](#14295855)</a> | Fixes an Access Violation (AV) that can occur when you run dynamic management views (DMVs) queries. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="14307204">[14307204](#14307204)</a> | [FIX: The built-in SESSION_CONTEXT returns wrong results in parallel plans (KB5008114)](https://support.microsoft.com/help/5008114) | SQL Server Engine | Programmability | All |
| <a id="14235259">[14235259](#14235259)</a> | [FIX: An assertion occurs when Compute Scalar operator operates on computed, temporary lobs with batch mode (KB5007842)](https://support.microsoft.com/help/5007842) | SQL Server Engine | Query Execution | Windows |
| <a id="14254562">[14254562](#14254562)</a> | Fixes a self-deadlock issue where thread always waits for `HASH_TABLE_DELETE` (`HTDELETE`) when you run parallel query in batch mode. | SQL Server Engine | Query Execution | Windows |
| <a id="14294740">[14294740](#14294740)</a> | Fixes a non-yielding scheduler dump in `sqldk!SOS_MemoryWorkSpace::Lookup`. | SQL Server Engine | Query Execution | All |
| <a id="14306964">[14306964](#14306964)</a> | Fixes an issue causing the assertion `fNoReaderWriterConflict`. | SQL Server Engine | Query Execution | Windows |
| <a id="14199142">[14199142](#14199142)</a> | Fixes an issue in which the query processor can't produce a query plan if the `USE PLAN` hint specifies a query plan that has a left outer join and an inner join. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14250829">[14250829](#14250829)</a> | Fixes an issue where executing a query with `BATCH_MODE_ON_ROWSTORE = ON` causes the following error and a dump occurs during compilation of the execution plan: </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Server Engine | Query Optimizer | All |
| <a id="14302678">[14302678](#14302678)</a> | [FIX: ForceLastGoodPlan doesn't account for aborted and timed out queries in regression detection logic (KB5008184)](https://support.microsoft.com/help/5008184) | SQL Server Engine | Query Store | All |
| <a id="14304467">[14304467](#14304467)</a> | [FIX: Missing change data capture cleanup execution isn't identified because of a deadlock without an error message (KB5008296)](https://support.microsoft.com/help/5008296) | SQL Server Engine | Replication | Windows |
| <a id="14255609">[14255609](#14255609)</a> | Fixes the following runtime error that occurs when you build a 32-bit application where *Microsoft.SqlServer.Rmo.dll* is referenced from *C:\Program Files (x86)\Microsoft SQL Server\150\SDK\Assemblies\\* but *Microsoft.SqlServer.Replication.dll* isn't cached in *GAC_32* folder (*C:\Windows\Microsoft.NET\assembly\GAC_32*) with SQL Server 2019: </br></br>System.IO.FileNotFoundException </br>HResult=0x80070002 </br>Message= Could not load file or assembly 'Microsoft.SqlServer.Replication, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' or one of its dependencies. The system cannot find the file specified. | SQL Server Engine | Replication | Windows |
| <a id="14288658">[14288658](#14288658)</a> | Fixes an issue where SQL Server 2019 stops responding and crashes due to "ex_terminator - Last chance exception handling" when you use SQL Server Service Broker. | SQL Server Engine | Service Broker | Windows |
| <a id="14309095">[14309095](#14309095)</a> | [Improvement: Cardinality estimation in Spatial TVF functions in SQL Server 2019 (KB5008107)](https://support.microsoft.com/help/5008107) | SQL Server Engine | Spatial | All |
| <a id="14298184">[14298184](#14298184)</a> | [FIX: Severe spinlock contention occurs in SQL Server 2019 (KB4538688)](https://support.microsoft.com/help/4538688) | SQL Server Engine | SQL OS | All |
| <a id="14307249">[14307249](#14307249)</a> | [FIX: Creating a resumable clustered index on a table with LOB causes corruption in SQL Server 2019 (KB5007719)](https://support.microsoft.com/help/5007719) | SQL Server Engine | Table Index Partition | All |
| <a id="14307250">[14307250](#14307250)</a> | [FIX: Add checkpoint handling for the first row in NonOptimizedGetAndInsertRows (KB5007744)](https://support.microsoft.com/help/5007744) | SQL Server Engine | Table Index Partition | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU14 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/11/sqlserver2019-kb5007182-x64_f8b5c3398e9f347701066deb388c2fcd2d94eb31.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5007182-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5007182-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5007182-x64.exe| 19D2ABA52942A16659C2C7702A22373082CF1129A3F1D45D47B9D4929D1082C9 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.19  | 291720    | 03-Nov-21 | 19:56 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 03-Nov-21 | 19:57 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.19      | 757152    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 174496    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 198560    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 201112    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 197520    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 213912    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 196512    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 192408    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 251288    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 172960    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.19      | 196000    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.19      | 1097112   | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.19      | 479632    | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 53656     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 58264     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 58776     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 57744     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 60832     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 57248     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 57248     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 66464     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 52640     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.19      | 57248     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16800     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16784     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16800     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16792     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16800     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16792     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16800     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 17824     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16784     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.19      | 16800     | 03-Nov-21 | 19:56 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 03-Nov-21 | 19:57 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 03-Nov-21 | 19:57 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 03-Nov-21 | 19:57 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 03-Nov-21 | 19:57 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 03-Nov-21 | 19:57 | x86      |
| Msmdctr.dll                                               | 2018.150.35.19  | 37256     | 03-Nov-21 | 19:56 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.19  | 66289056  | 03-Nov-21 | 19:56 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.19  | 47783816  | 03-Nov-21 | 19:56 | x86      |
| Msmdpump.dll                                              | 2018.150.35.19  | 10187672  | 03-Nov-21 | 19:56 | x64      |
| Msmdredir.dll                                             | 2018.150.35.19  | 7955864   | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 15768     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 15768     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 16280     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 15768     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 16280     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 16280     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 16280     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 17304     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 15760     | 03-Nov-21 | 19:56 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.19      | 15768     | 03-Nov-21 | 19:56 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.19  | 65826184  | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 832392    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1627032   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1452952   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1641880   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1607576   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1000344   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 991632    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1535896   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1520536   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 809880    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.19  | 1595280   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 831368    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1623432   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1449864   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1636744   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1603464   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 997768    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 990088    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1531784   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1516936   | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 808840    | 03-Nov-21 | 19:56 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.19  | 1590664   | 03-Nov-21 | 19:56 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.19  | 10184608  | 03-Nov-21 | 19:56 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.19  | 8278408   | 03-Nov-21 | 19:56 | x86      |
| Msolap.dll                                                | 2018.150.35.19  | 11015048  | 03-Nov-21 | 19:56 | x64      |
| Msolap.dll                                                | 2018.150.35.19  | 8607112   | 03-Nov-21 | 19:56 | x86      |
| Msolui.dll                                                | 2018.150.35.19  | 305560    | 03-Nov-21 | 19:56 | x64      |
| Msolui.dll                                                | 2018.150.35.19  | 285080    | 03-Nov-21 | 19:56 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 03-Nov-21 | 19:57 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 03-Nov-21 | 19:57 | x64      |
| Sqlboot.dll                                               | 2019.150.4188.2 | 213896    | 03-Nov-21 | 19:56 | x64      |
| Sqlceip.exe                                               | 15.0.4188.2     | 291728    | 03-Nov-21 | 19:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4188.2 | 152480    | 03-Nov-21 | 19:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4188.2 | 185216    | 03-Nov-21 | 19:57 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 03-Nov-21 | 19:57 | x86      |
| Tmapi.dll                                                 | 2018.150.35.19  | 6177160   | 03-Nov-21 | 19:56 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.19  | 4916632   | 03-Nov-21 | 19:56 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.19  | 1183624   | 03-Nov-21 | 19:56 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.19  | 6805384   | 03-Nov-21 | 19:56 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.19  | 26024864  | 03-Nov-21 | 19:56 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.19  | 35459488  | 03-Nov-21 | 19:56 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4188.2 | 74632     | 03-Nov-21 | 19:57 | x86      |
| Instapi150.dll                       | 2019.150.4188.2 | 86912     | 03-Nov-21 | 19:57 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4188.2 | 99208     | 03-Nov-21 | 19:58 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4188.2 | 86912     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4188.2     | 549776    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4188.2     | 549784    | 03-Nov-21 | 19:59 | x86      |
| Msasxpress.dll                       | 2018.150.35.19  | 31112     | 03-Nov-21 | 19:59 | x64      |
| Msasxpress.dll                       | 2018.150.35.19  | 25992     | 03-Nov-21 | 19:59 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4188.2 | 86928     | 03-Nov-21 | 19:57 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4188.2 | 74656     | 03-Nov-21 | 19:58 | x86      |
| Sqldumper.exe                        | 2019.150.4188.2 | 152480    | 03-Nov-21 | 19:57 | x86      |
| Sqldumper.exe                        | 2019.150.4188.2 | 185216    | 03-Nov-21 | 19:58 | x64      |
| Sqlftacct.dll                        | 2019.150.4188.2 | 78728     | 03-Nov-21 | 19:58 | x64      |
| Sqlftacct.dll                        | 2019.150.4188.2 | 58256     | 03-Nov-21 | 19:58 | x86      |
| Sqlmanager.dll                       | 2019.150.4188.2 | 877448    | 03-Nov-21 | 19:58 | x64      |
| Sqlmanager.dll                       | 2019.150.4188.2 | 742288    | 03-Nov-21 | 19:58 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4188.2 | 377744    | 03-Nov-21 | 19:58 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4188.2 | 430976    | 03-Nov-21 | 19:58 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4188.2 | 275336    | 03-Nov-21 | 19:58 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4188.2 | 357264    | 03-Nov-21 | 19:59 | x64      |
| Svrenumapi150.dll                    | 2019.150.4188.2 | 910240    | 03-Nov-21 | 19:58 | x86      |
| Svrenumapi150.dll                    | 2019.150.4188.2 | 1160080   | 03-Nov-21 | 19:58 | x64      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4188.2 | 136088    | 03-Nov-21 | 19:57 | x86      |
| Dreplaycommon.dll     | 2019.150.4188.2 | 665496    | 03-Nov-21 | 19:57 | x86      |
| Dreplayutil.dll       | 2019.150.4188.2 | 304024    | 03-Nov-21 | 19:57 | x86      |
| Instapi150.dll        | 2019.150.4188.2 | 86912     | 03-Nov-21 | 19:57 | x64      |
| Sqlresourceloader.dll | 2019.150.4188.2 | 37776     | 03-Nov-21 | 19:57 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4188.2 | 665496    | 03-Nov-21 | 19:58 | x86      |
| Dreplaycontroller.exe | 2019.150.4188.2 | 365464    | 03-Nov-21 | 19:58 | x86      |
| Instapi150.dll        | 2019.150.4188.2 | 86912     | 03-Nov-21 | 19:57 | x64      |
| Sqlresourceloader.dll | 2019.150.4188.2 | 37776     | 03-Nov-21 | 19:58 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4188.2 | 4657048   | 03-Nov-21 | 20:58 | x64      |
| Aetm-enclave.dll                           | 2019.150.4188.2 | 4611472   | 03-Nov-21 | 20:58 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4188.2 | 4931344   | 03-Nov-21 | 20:58 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4188.2 | 4871952   | 03-Nov-21 | 20:58 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 03-Nov-21 | 19:50 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 03-Nov-21 | 19:50 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 03-Nov-21 | 20:58 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 03-Nov-21 | 20:58 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 03-Nov-21 | 20:58 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 03-Nov-21 | 20:58 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4188.2 | 279424    | 03-Nov-21 | 20:58 | x64      |
| Dcexec.exe                                 | 2019.150.4188.2 | 86928     | 03-Nov-21 | 20:58 | x64      |
| Fssres.dll                                 | 2019.150.4188.2 | 95120     | 03-Nov-21 | 20:58 | x64      |
| Hadrres.dll                                | 2019.150.4188.2 | 201616    | 03-Nov-21 | 20:58 | x64      |
| Hkcompile.dll                              | 2019.150.4188.2 | 1291160   | 03-Nov-21 | 20:58 | x64      |
| Hkengine.dll                               | 2019.150.4188.2 | 5784472   | 03-Nov-21 | 20:58 | x64      |
| Hkruntime.dll                              | 2019.150.4188.2 | 181136    | 03-Nov-21 | 20:58 | x64      |
| Hktempdb.dll                               | 2019.150.4188.2 | 62360     | 03-Nov-21 | 20:58 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 03-Nov-21 | 20:58 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4188.2     | 234384    | 03-Nov-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4188.2 | 324496    | 03-Nov-21 | 20:58 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4188.2 | 91008     | 03-Nov-21 | 20:58 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 03-Nov-21 | 20:58 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 03-Nov-21 | 20:58 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 03-Nov-21 | 20:58 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 03-Nov-21 | 20:58 | x64      |
| Qds.dll                                    | 2019.150.4188.2 | 1184656   | 03-Nov-21 | 20:58 | x64      |
| Rsfxft.dll                                 | 2019.150.4188.2 | 50048     | 03-Nov-21 | 20:58 | x64      |
| Secforwarder.dll                           | 2019.150.4188.2 | 78736     | 03-Nov-21 | 20:58 | x64      |
| Sqagtres.dll                               | 2019.150.4188.2 | 86936     | 03-Nov-21 | 20:58 | x64      |
| Sqlaamss.dll                               | 2019.150.4188.2 | 107392    | 03-Nov-21 | 20:58 | x64      |
| Sqlaccess.dll                              | 2019.150.4188.2 | 492448    | 03-Nov-21 | 20:58 | x64      |
| Sqlagent.exe                               | 2019.150.4188.2 | 729984    | 03-Nov-21 | 20:58 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4188.2 | 66456     | 03-Nov-21 | 20:58 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4188.2 | 78736     | 03-Nov-21 | 20:58 | x64      |
| Sqlboot.dll                                | 2019.150.4188.2 | 213896    | 03-Nov-21 | 20:58 | x64      |
| Sqlceip.exe                                | 15.0.4188.2     | 291728    | 03-Nov-21 | 20:58 | x86      |
| Sqlcmdss.dll                               | 2019.150.4188.2 | 86928     | 03-Nov-21 | 20:58 | x64      |
| Sqlctr150.dll                              | 2019.150.4188.2 | 140176    | 03-Nov-21 | 20:58 | x64      |
| Sqlctr150.dll                              | 2019.150.4188.2 | 115600    | 03-Nov-21 | 20:58 | x86      |
| Sqldk.dll                                  | 2019.150.4188.2 | 3142536   | 03-Nov-21 | 20:58 | x64      |
| Sqldtsss.dll                               | 2019.150.4188.2 | 107408    | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 1594272   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3498904   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3695512   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4162456   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4281240   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3412896   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3580824   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4154264   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4010912   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4060056   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 2220952   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 2171808   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3867552   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3543960   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4015008   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3818400   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3814296   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3613592   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3498896   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 1536928   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 3904408   | 03-Nov-21 | 20:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4188.2 | 4027296   | 03-Nov-21 | 20:58 | x64      |
| Sqllang.dll                                | 2019.150.4188.2 | 39977880  | 03-Nov-21 | 20:58 | x64      |
| Sqlmin.dll                                 | 2019.150.4188.2 | 40519560  | 03-Nov-21 | 20:58 | x64      |
| Sqlolapss.dll                              | 2019.150.4188.2 | 103320    | 03-Nov-21 | 20:58 | x64      |
| Sqlos.dll                                  | 2019.150.4188.2 | 41856     | 03-Nov-21 | 20:58 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4188.2 | 82840     | 03-Nov-21 | 20:58 | x64      |
| Sqlrepss.dll                               | 2019.150.4188.2 | 82848     | 03-Nov-21 | 20:58 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4188.2 | 50064     | 03-Nov-21 | 19:57 | x64      |
| Sqlscm.dll                                 | 2019.150.4188.2 | 86936     | 03-Nov-21 | 19:57 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4188.2 | 37776     | 03-Nov-21 | 20:58 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4188.2 | 5804928   | 03-Nov-21 | 20:58 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4188.2 | 672648    | 03-Nov-21 | 20:58 | x64      |
| Sqlservr.exe                               | 2019.150.4188.2 | 627600    | 03-Nov-21 | 20:58 | x64      |
| Sqlsvc.dll                                 | 2019.150.4188.2 | 181120    | 03-Nov-21 | 19:57 | x64      |
| Sqltses.dll                                | 2019.150.4188.2 | 9114520   | 03-Nov-21 | 20:58 | x64      |
| Sqsrvres.dll                               | 2019.150.4188.2 | 279440    | 03-Nov-21 | 20:58 | x64      |
| Svl.dll                                    | 2019.150.4188.2 | 160640    | 03-Nov-21 | 20:58 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 03-Nov-21 | 20:58 | x64      |
| Xe.dll                                     | 2019.150.4188.2 | 721808    | 03-Nov-21 | 19:57 | x64      |
| Xpadsi.exe                                 | 2019.150.4188.2 | 115608    | 03-Nov-21 | 20:58 | x64      |
| Xplog70.dll                                | 2019.150.4188.2 | 91024     | 03-Nov-21 | 20:58 | x64      |
| Xpqueue.dll                                | 2019.150.4188.2 | 91024     | 03-Nov-21 | 20:58 | x64      |
| Xprepl.dll                                 | 2019.150.4188.2 | 119696    | 03-Nov-21 | 20:58 | x64      |
| Xpstar.dll                                 | 2019.150.4188.2 | 471968    | 03-Nov-21 | 20:58 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4188.2 | 263072    | 03-Nov-21 | 19:50 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4188.2 | 230280    | 03-Nov-21 | 19:57 | x64      |
| Distrib.exe                                                  | 2019.150.4188.2 | 234384    | 03-Nov-21 | 19:57 | x64      |
| Dteparse.dll                                                 | 2019.150.4188.2 | 123784    | 03-Nov-21 | 19:57 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4188.2 | 131976    | 03-Nov-21 | 19:57 | x64      |
| Dtepkg.dll                                                   | 2019.150.4188.2 | 148376    | 03-Nov-21 | 19:57 | x64      |
| Dtexec.exe                                                   | 2019.150.4188.2 | 71560     | 03-Nov-21 | 19:57 | x64      |
| Dts.dll                                                      | 2019.150.4188.2 | 3142552   | 03-Nov-21 | 19:50 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4188.2 | 500608    | 03-Nov-21 | 19:50 | x64      |
| Dtsconn.dll                                                  | 2019.150.4188.2 | 521096    | 03-Nov-21 | 19:50 | x64      |
| Dtshost.exe                                                  | 2019.150.4188.2 | 104328    | 03-Nov-21 | 19:57 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4188.2 | 566160    | 03-Nov-21 | 19:57 | x64      |
| Dtspipeline.dll                                              | 2019.150.4188.2 | 1328016   | 03-Nov-21 | 19:50 | x64      |
| Dtswizard.exe                                                | 15.0.4188.2     | 885648    | 03-Nov-21 | 19:57 | x64      |
| Dtuparse.dll                                                 | 2019.150.4188.2 | 99200     | 03-Nov-21 | 19:57 | x64      |
| Dtutil.exe                                                   | 2019.150.4188.2 | 147336    | 03-Nov-21 | 19:57 | x64      |
| Exceldest.dll                                                | 2019.150.4188.2 | 279432    | 03-Nov-21 | 19:50 | x64      |
| Excelsrc.dll                                                 | 2019.150.4188.2 | 308104    | 03-Nov-21 | 19:50 | x64      |
| Execpackagetask.dll                                          | 2019.150.4188.2 | 185248    | 03-Nov-21 | 19:50 | x64      |
| Flatfiledest.dll                                             | 2019.150.4188.2 | 410496    | 03-Nov-21 | 19:50 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4188.2 | 426880    | 03-Nov-21 | 19:50 | x64      |
| Logread.exe                                                  | 2019.150.4188.2 | 717696    | 03-Nov-21 | 19:57 | x64      |
| Mergetxt.dll                                                 | 2019.150.4188.2 | 74624     | 03-Nov-21 | 19:57 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4188.2     | 58256     | 03-Nov-21 | 19:50 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4188.2     | 41856     | 03-Nov-21 | 19:50 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4188.2     | 390016    | 03-Nov-21 | 19:57 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4188.2 | 1639320   | 03-Nov-21 | 19:57 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4188.2     | 549784    | 03-Nov-21 | 19:57 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4188.2 | 111504    | 03-Nov-21 | 19:50 | x64      |
| Msgprox.dll                                                  | 2019.150.4188.2 | 299912    | 03-Nov-21 | 19:57 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 03-Nov-21 | 19:57 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4188.2 | 1495952   | 03-Nov-21 | 19:57 | x64      |
| Oledbdest.dll                                                | 2019.150.4188.2 | 279432    | 03-Nov-21 | 19:50 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4188.2 | 312200    | 03-Nov-21 | 19:50 | x64      |
| Osql.exe                                                     | 2019.150.4188.2 | 91008     | 03-Nov-21 | 19:57 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4188.2 | 496528    | 03-Nov-21 | 19:57 | x64      |
| Rawdest.dll                                                  | 2019.150.4188.2 | 226200    | 03-Nov-21 | 19:50 | x64      |
| Rawsource.dll                                                | 2019.150.4188.2 | 209816    | 03-Nov-21 | 19:50 | x64      |
| Rdistcom.dll                                                 | 2019.150.4188.2 | 914320    | 03-Nov-21 | 19:57 | x64      |
| Recordsetdest.dll                                            | 2019.150.4188.2 | 209816    | 03-Nov-21 | 19:50 | x64      |
| Repldp.dll                                                   | 2019.150.4188.2 | 312208    | 03-Nov-21 | 19:57 | x64      |
| Replerrx.dll                                                 | 2019.150.4188.2 | 181120    | 03-Nov-21 | 19:57 | x64      |
| Replisapi.dll                                                | 2019.150.4188.2 | 394128    | 03-Nov-21 | 19:57 | x64      |
| Replmerg.exe                                                 | 2019.150.4188.2 | 562048    | 03-Nov-21 | 19:57 | x64      |
| Replprov.dll                                                 | 2019.150.4188.2 | 856960    | 03-Nov-21 | 19:57 | x64      |
| Replrec.dll                                                  | 2019.150.4188.2 | 1033088   | 03-Nov-21 | 19:57 | x64      |
| Replsub.dll                                                  | 2019.150.4188.2 | 471936    | 03-Nov-21 | 19:57 | x64      |
| Replsync.dll                                                 | 2019.150.4188.2 | 164752    | 03-Nov-21 | 19:57 | x64      |
| Spresolv.dll                                                 | 2019.150.4188.2 | 275344    | 03-Nov-21 | 19:57 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4188.2 | 263072    | 03-Nov-21 | 19:57 | x64      |
| Sqldiag.exe                                                  | 2019.150.4188.2 | 1139608   | 03-Nov-21 | 19:57 | x64      |
| Sqldistx.dll                                                 | 2019.150.4188.2 | 246672    | 03-Nov-21 | 19:57 | x64      |
| Sqllogship.exe                                               | 15.0.4188.2     | 103320    | 03-Nov-21 | 19:58 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4188.2 | 398216    | 03-Nov-21 | 19:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4188.2 | 37776     | 03-Nov-21 | 19:57 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4188.2 | 50064     | 03-Nov-21 | 19:57 | x64      |
| Sqlscm.dll                                                   | 2019.150.4188.2 | 86936     | 03-Nov-21 | 19:57 | x64      |
| Sqlscm.dll                                                   | 2019.150.4188.2 | 78752     | 03-Nov-21 | 19:57 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4188.2 | 148360    | 03-Nov-21 | 19:57 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4188.2 | 181120    | 03-Nov-21 | 19:57 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4188.2 | 205704    | 03-Nov-21 | 19:50 | x64      |
| Ssradd.dll                                                   | 2019.150.4188.2 | 82816     | 03-Nov-21 | 19:57 | x64      |
| Ssravg.dll                                                   | 2019.150.4188.2 | 82824     | 03-Nov-21 | 19:57 | x64      |
| Ssrdown.dll                                                  | 2019.150.4188.2 | 74624     | 03-Nov-21 | 19:57 | x64      |
| Ssrmax.dll                                                   | 2019.150.4188.2 | 82824     | 03-Nov-21 | 19:57 | x64      |
| Ssrmin.dll                                                   | 2019.150.4188.2 | 82816     | 03-Nov-21 | 19:57 | x64      |
| Ssrpub.dll                                                   | 2019.150.4188.2 | 74624     | 03-Nov-21 | 19:57 | x64      |
| Ssrup.dll                                                    | 2019.150.4188.2 | 74624     | 03-Nov-21 | 19:57 | x64      |
| Txagg.dll                                                    | 2019.150.4188.2 | 390016    | 03-Nov-21 | 19:50 | x64      |
| Txbdd.dll                                                    | 2019.150.4188.2 | 189312    | 03-Nov-21 | 19:50 | x64      |
| Txdatacollector.dll                                          | 2019.150.4188.2 | 484232    | 03-Nov-21 | 19:57 | x64      |
| Txdataconvert.dll                                            | 2019.150.4188.2 | 316312    | 03-Nov-21 | 19:50 | x64      |
| Txderived.dll                                                | 2019.150.4188.2 | 639896    | 03-Nov-21 | 19:50 | x64      |
| Txlookup.dll                                                 | 2019.150.4188.2 | 541576    | 03-Nov-21 | 19:50 | x64      |
| Txmerge.dll                                                  | 2019.150.4188.2 | 258952    | 03-Nov-21 | 19:50 | x64      |
| Txmergejoin.dll                                              | 2019.150.4188.2 | 312200    | 03-Nov-21 | 19:50 | x64      |
| Txmulticast.dll                                              | 2019.150.4188.2 | 148352    | 03-Nov-21 | 19:50 | x64      |
| Txrowcount.dll                                               | 2019.150.4188.2 | 144264    | 03-Nov-21 | 19:50 | x64      |
| Txsort.dll                                                   | 2019.150.4188.2 | 291744    | 03-Nov-21 | 19:50 | x64      |
| Txsplit.dll                                                  | 2019.150.4188.2 | 623520    | 03-Nov-21 | 19:50 | x64      |
| Txunionall.dll                                               | 2019.150.4188.2 | 205696    | 03-Nov-21 | 19:50 | x64      |
| Xe.dll                                                       | 2019.150.4188.2 | 721808    | 03-Nov-21 | 19:57 | x64      |
| Xmlsub.dll                                                   | 2019.150.4188.2 | 295816    | 03-Nov-21 | 19:57 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4188.2 | 95128     | 03-Nov-21 | 19:57 | x64      |
| Exthost.exe        | 2019.150.4188.2 | 238496    | 03-Nov-21 | 19:57 | x64      |
| Launchpad.exe      | 2019.150.4188.2 | 1221536   | 03-Nov-21 | 19:57 | x64      |
| Sqlsatellite.dll   | 2019.150.4188.2 | 1020816   | 03-Nov-21 | 19:57 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4188.2 | 684928    | 03-Nov-21 | 19:57 | x64      |
| Fdhost.exe     | 2019.150.4188.2 | 127896    | 03-Nov-21 | 19:57 | x64      |
| Fdlauncher.exe | 2019.150.4188.2 | 78744     | 03-Nov-21 | 19:57 | x64      |
| Sqlft150ph.dll | 2019.150.4188.2 | 91032     | 03-Nov-21 | 19:57 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4188.2  | 29584     | 03-Nov-21 | 19:57 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4188.2 | 263072    | 03-Nov-21 | 19:58 | x64      |
| Commanddest.dll                                               | 2019.150.4188.2 | 226176    | 03-Nov-21 | 19:58 | x86      |
| Dteparse.dll                                                  | 2019.150.4188.2 | 111488    | 03-Nov-21 | 19:58 | x86      |
| Dteparse.dll                                                  | 2019.150.4188.2 | 123784    | 03-Nov-21 | 19:58 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4188.2 | 115584    | 03-Nov-21 | 19:58 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4188.2 | 131976    | 03-Nov-21 | 19:58 | x64      |
| Dtepkg.dll                                                    | 2019.150.4188.2 | 131992    | 03-Nov-21 | 19:58 | x86      |
| Dtepkg.dll                                                    | 2019.150.4188.2 | 148376    | 03-Nov-21 | 19:58 | x64      |
| Dtexec.exe                                                    | 2019.150.4188.2 | 62880     | 03-Nov-21 | 19:58 | x86      |
| Dtexec.exe                                                    | 2019.150.4188.2 | 71560     | 03-Nov-21 | 19:58 | x64      |
| Dts.dll                                                       | 2019.150.4188.2 | 2761616   | 03-Nov-21 | 19:58 | x86      |
| Dts.dll                                                       | 2019.150.4188.2 | 3142552   | 03-Nov-21 | 19:58 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4188.2 | 443288    | 03-Nov-21 | 19:58 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4188.2 | 500608    | 03-Nov-21 | 19:58 | x64      |
| Dtsconn.dll                                                   | 2019.150.4188.2 | 430984    | 03-Nov-21 | 19:58 | x86      |
| Dtsconn.dll                                                   | 2019.150.4188.2 | 521096    | 03-Nov-21 | 19:58 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4188.2 | 111000    | 03-Nov-21 | 19:58 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4188.2 | 92552     | 03-Nov-21 | 19:58 | x86      |
| Dtshost.exe                                                   | 2019.150.4188.2 | 104328    | 03-Nov-21 | 19:58 | x64      |
| Dtshost.exe                                                   | 2019.150.4188.2 | 87424     | 03-Nov-21 | 19:58 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4188.2 | 553872    | 03-Nov-21 | 19:58 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4188.2 | 566160    | 03-Nov-21 | 19:58 | x64      |
| Dtspipeline.dll                                               | 2019.150.4188.2 | 1328016   | 03-Nov-21 | 19:58 | x64      |
| Dtspipeline.dll                                               | 2019.150.4188.2 | 1119120   | 03-Nov-21 | 19:58 | x86      |
| Dtswizard.exe                                                 | 15.0.4188.2     | 885648    | 03-Nov-21 | 19:58 | x64      |
| Dtswizard.exe                                                 | 15.0.4188.2     | 889744    | 03-Nov-21 | 19:58 | x86      |
| Dtuparse.dll                                                  | 2019.150.4188.2 | 86936     | 03-Nov-21 | 19:58 | x86      |
| Dtuparse.dll                                                  | 2019.150.4188.2 | 99200     | 03-Nov-21 | 19:58 | x64      |
| Dtutil.exe                                                    | 2019.150.4188.2 | 128912    | 03-Nov-21 | 19:58 | x86      |
| Dtutil.exe                                                    | 2019.150.4188.2 | 147336    | 03-Nov-21 | 19:58 | x64      |
| Exceldest.dll                                                 | 2019.150.4188.2 | 234384    | 03-Nov-21 | 19:58 | x86      |
| Exceldest.dll                                                 | 2019.150.4188.2 | 279432    | 03-Nov-21 | 19:58 | x64      |
| Excelsrc.dll                                                  | 2019.150.4188.2 | 258960    | 03-Nov-21 | 19:58 | x86      |
| Excelsrc.dll                                                  | 2019.150.4188.2 | 308104    | 03-Nov-21 | 19:58 | x64      |
| Execpackagetask.dll                                           | 2019.150.4188.2 | 185248    | 03-Nov-21 | 19:58 | x64      |
| Execpackagetask.dll                                           | 2019.150.4188.2 | 148360    | 03-Nov-21 | 19:58 | x86      |
| Flatfiledest.dll                                              | 2019.150.4188.2 | 357256    | 03-Nov-21 | 19:58 | x86      |
| Flatfiledest.dll                                              | 2019.150.4188.2 | 410496    | 03-Nov-21 | 19:58 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4188.2 | 369544    | 03-Nov-21 | 19:58 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4188.2 | 426880    | 03-Nov-21 | 19:58 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4188.2     | 119696    | 03-Nov-21 | 19:58 | x86      |
| Isserverexec.exe                                              | 15.0.4188.2     | 144272    | 03-Nov-21 | 19:58 | x64      |
| Isserverexec.exe                                              | 15.0.4188.2     | 148368    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4188.2     | 115584    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4188.2     | 58240     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4188.2     | 58256     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4188.2     | 508816    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4188.2     | 508824    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4188.2     | 41856     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4188.2     | 41864     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4188.2     | 390016    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4188.2     | 58240     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4188.2     | 58264     | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4188.2     | 140176    | 03-Nov-21 | 19:58 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4188.2     | 140176    | 03-Nov-21 | 19:58 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4188.2     | 217984    | 03-Nov-21 | 19:58 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4188.2 | 111504    | 03-Nov-21 | 19:58 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4188.2 | 99208     | 03-Nov-21 | 19:58 | x86      |
| Msmdpp.dll                                                    | 2018.150.35.19  | 10062744  | 03-Nov-21 | 19:58 | x64      |
| Odbcdest.dll                                                  | 2019.150.4188.2 | 316320    | 03-Nov-21 | 19:58 | x86      |
| Odbcdest.dll                                                  | 2019.150.4188.2 | 369536    | 03-Nov-21 | 19:58 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4188.2 | 328584    | 03-Nov-21 | 19:58 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4188.2 | 381840    | 03-Nov-21 | 19:58 | x64      |
| Oledbdest.dll                                                 | 2019.150.4188.2 | 238464    | 03-Nov-21 | 19:58 | x86      |
| Oledbdest.dll                                                 | 2019.150.4188.2 | 279432    | 03-Nov-21 | 19:58 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4188.2 | 263064    | 03-Nov-21 | 19:58 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4188.2 | 312200    | 03-Nov-21 | 19:58 | x64      |
| Rawdest.dll                                                   | 2019.150.4188.2 | 189320    | 03-Nov-21 | 19:58 | x86      |
| Rawdest.dll                                                   | 2019.150.4188.2 | 226200    | 03-Nov-21 | 19:58 | x64      |
| Rawsource.dll                                                 | 2019.150.4188.2 | 177032    | 03-Nov-21 | 19:58 | x86      |
| Rawsource.dll                                                 | 2019.150.4188.2 | 209816    | 03-Nov-21 | 19:58 | x64      |
| Recordsetdest.dll                                             | 2019.150.4188.2 | 177032    | 03-Nov-21 | 19:58 | x86      |
| Recordsetdest.dll                                             | 2019.150.4188.2 | 209816    | 03-Nov-21 | 19:58 | x64      |
| Sqlceip.exe                                                   | 15.0.4188.2     | 291728    | 03-Nov-21 | 19:58 | x86      |
| Sqldest.dll                                                   | 2019.150.4188.2 | 275328    | 03-Nov-21 | 19:58 | x64      |
| Sqldest.dll                                                   | 2019.150.4188.2 | 238464    | 03-Nov-21 | 19:58 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4188.2 | 205704    | 03-Nov-21 | 19:58 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4188.2 | 168832    | 03-Nov-21 | 19:58 | x86      |
| Txagg.dll                                                     | 2019.150.4188.2 | 390016    | 03-Nov-21 | 19:58 | x64      |
| Txagg.dll                                                     | 2019.150.4188.2 | 328600    | 03-Nov-21 | 19:58 | x86      |
| Txbdd.dll                                                     | 2019.150.4188.2 | 156544    | 03-Nov-21 | 19:58 | x86      |
| Txbdd.dll                                                     | 2019.150.4188.2 | 189312    | 03-Nov-21 | 19:58 | x64      |
| Txbestmatch.dll                                               | 2019.150.4188.2 | 545696    | 03-Nov-21 | 19:58 | x86      |
| Txbestmatch.dll                                               | 2019.150.4188.2 | 652184    | 03-Nov-21 | 19:58 | x64      |
| Txcache.dll                                                   | 2019.150.4188.2 | 172928    | 03-Nov-21 | 19:58 | x86      |
| Txcache.dll                                                   | 2019.150.4188.2 | 209800    | 03-Nov-21 | 19:58 | x64      |
| Txcharmap.dll                                                 | 2019.150.4188.2 | 275328    | 03-Nov-21 | 19:58 | x86      |
| Txcharmap.dll                                                 | 2019.150.4188.2 | 316312    | 03-Nov-21 | 19:58 | x64      |
| Txcopymap.dll                                                 | 2019.150.4188.2 | 172944    | 03-Nov-21 | 19:58 | x86      |
| Txcopymap.dll                                                 | 2019.150.4188.2 | 201600    | 03-Nov-21 | 19:58 | x64      |
| Txdataconvert.dll                                             | 2019.150.4188.2 | 275344    | 03-Nov-21 | 19:58 | x86      |
| Txdataconvert.dll                                             | 2019.150.4188.2 | 316312    | 03-Nov-21 | 19:58 | x64      |
| Txderived.dll                                                 | 2019.150.4188.2 | 557960    | 03-Nov-21 | 19:58 | x86      |
| Txderived.dll                                                 | 2019.150.4188.2 | 639896    | 03-Nov-21 | 19:58 | x64      |
| Txfileextractor.dll                                           | 2019.150.4188.2 | 222096    | 03-Nov-21 | 19:58 | x64      |
| Txfileextractor.dll                                           | 2019.150.4188.2 | 185216    | 03-Nov-21 | 19:58 | x86      |
| Txfileinserter.dll                                            | 2019.150.4188.2 | 185224    | 03-Nov-21 | 19:58 | x86      |
| Txfileinserter.dll                                            | 2019.150.4188.2 | 222088    | 03-Nov-21 | 19:58 | x64      |
| Txgroupdups.dll                                               | 2019.150.4188.2 | 320384    | 03-Nov-21 | 19:58 | x64      |
| Txgroupdups.dll                                               | 2019.150.4188.2 | 254872    | 03-Nov-21 | 19:58 | x86      |
| Txlineage.dll                                                 | 2019.150.4188.2 | 156568    | 03-Nov-21 | 19:58 | x64      |
| Txlineage.dll                                                 | 2019.150.4188.2 | 127880    | 03-Nov-21 | 19:58 | x86      |
| Txlookup.dll                                                  | 2019.150.4188.2 | 467864    | 03-Nov-21 | 19:58 | x86      |
| Txlookup.dll                                                  | 2019.150.4188.2 | 541576    | 03-Nov-21 | 19:58 | x64      |
| Txmerge.dll                                                   | 2019.150.4188.2 | 258952    | 03-Nov-21 | 19:58 | x64      |
| Txmerge.dll                                                   | 2019.150.4188.2 | 205704    | 03-Nov-21 | 19:58 | x86      |
| Txmergejoin.dll                                               | 2019.150.4188.2 | 254856    | 03-Nov-21 | 19:58 | x86      |
| Txmergejoin.dll                                               | 2019.150.4188.2 | 312200    | 03-Nov-21 | 19:58 | x64      |
| Txmulticast.dll                                               | 2019.150.4188.2 | 119704    | 03-Nov-21 | 19:58 | x86      |
| Txmulticast.dll                                               | 2019.150.4188.2 | 148352    | 03-Nov-21 | 19:58 | x64      |
| Txpivot.dll                                                   | 2019.150.4188.2 | 209792    | 03-Nov-21 | 19:58 | x86      |
| Txpivot.dll                                                   | 2019.150.4188.2 | 242568    | 03-Nov-21 | 19:58 | x64      |
| Txrowcount.dll                                                | 2019.150.4188.2 | 115584    | 03-Nov-21 | 19:58 | x86      |
| Txrowcount.dll                                                | 2019.150.4188.2 | 144264    | 03-Nov-21 | 19:58 | x64      |
| Txsampling.dll                                                | 2019.150.4188.2 | 193432    | 03-Nov-21 | 19:58 | x64      |
| Txsampling.dll                                                | 2019.150.4188.2 | 160648    | 03-Nov-21 | 19:58 | x86      |
| Txscd.dll                                                     | 2019.150.4188.2 | 197512    | 03-Nov-21 | 19:58 | x86      |
| Txscd.dll                                                     | 2019.150.4188.2 | 234368    | 03-Nov-21 | 19:58 | x64      |
| Txsort.dll                                                    | 2019.150.4188.2 | 291744    | 03-Nov-21 | 19:58 | x64      |
| Txsort.dll                                                    | 2019.150.4188.2 | 234368    | 03-Nov-21 | 19:58 | x86      |
| Txsplit.dll                                                   | 2019.150.4188.2 | 549760    | 03-Nov-21 | 19:58 | x86      |
| Txsplit.dll                                                   | 2019.150.4188.2 | 623520    | 03-Nov-21 | 19:58 | x64      |
| Txtermextraction.dll                                          | 2019.150.4188.2 | 8643464   | 03-Nov-21 | 19:58 | x86      |
| Txtermextraction.dll                                          | 2019.150.4188.2 | 8700816   | 03-Nov-21 | 19:58 | x64      |
| Txtermlookup.dll                                              | 2019.150.4188.2 | 4182912   | 03-Nov-21 | 19:58 | x64      |
| Txtermlookup.dll                                              | 2019.150.4188.2 | 4137880   | 03-Nov-21 | 19:58 | x86      |
| Txunionall.dll                                                | 2019.150.4188.2 | 205696    | 03-Nov-21 | 19:58 | x64      |
| Txunionall.dll                                                | 2019.150.4188.2 | 160672    | 03-Nov-21 | 19:58 | x86      |
| Txunpivot.dll                                                 | 2019.150.4188.2 | 222080    | 03-Nov-21 | 19:58 | x64      |
| Txunpivot.dll                                                 | 2019.150.4188.2 | 181144    | 03-Nov-21 | 19:58 | x86      |
| Xe.dll                                                        | 2019.150.4188.2 | 631704    | 03-Nov-21 | 19:58 | x86      |
| Xe.dll                                                        | 2019.150.4188.2 | 721808    | 03-Nov-21 | 19:58 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 03-Nov-21 | 20:47 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 03-Nov-21 | 20:47 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 03-Nov-21 | 20:47 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 03-Nov-21 | 20:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 03-Nov-21 | 20:47 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 03-Nov-21 | 20:47 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 03-Nov-21 | 20:47 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 03-Nov-21 | 20:47 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 03-Nov-21 | 20:47 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 03-Nov-21 | 20:47 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 03-Nov-21 | 20:47 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 03-Nov-21 | 20:47 | x64      |
| Instapi150.dll                                                       | 2019.150.4188.2 | 86912     | 03-Nov-21 | 20:47 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 03-Nov-21 | 20:47 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 03-Nov-21 | 20:47 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 03-Nov-21 | 20:47 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 03-Nov-21 | 20:47 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 03-Nov-21 | 20:47 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 03-Nov-21 | 20:47 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 03-Nov-21 | 20:47 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4188.2 | 451456    | 03-Nov-21 | 20:47 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4188.2 | 7386008   | 03-Nov-21 | 20:47 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 03-Nov-21 | 20:47 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 03-Nov-21 | 20:47 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 03-Nov-21 | 20:47 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 03-Nov-21 | 20:47 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 03-Nov-21 | 20:47 | x64      |
| Secforwarder.dll                                                     | 2019.150.4188.2 | 78736     | 03-Nov-21 | 20:47 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 03-Nov-21 | 20:47 | x64      |
| Sqldk.dll                                                            | 2019.150.4188.2 | 3142536   | 03-Nov-21 | 20:47 | x64      |
| Sqldumper.exe                                                        | 2019.150.4188.2 | 185216    | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 1594272   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 4162456   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 3412896   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 4154264   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 4060056   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 2220952   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 2171808   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 3818400   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 3814296   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 1536928   | 03-Nov-21 | 20:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4188.2 | 4027296   | 03-Nov-21 | 20:47 | x64      |
| Sqlos.dll                                                            | 2019.150.4188.2 | 41856     | 03-Nov-21 | 20:47 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 03-Nov-21 | 20:47 | x64      |
| Sqltses.dll                                                          | 2019.150.4188.2 | 9114520   | 03-Nov-21 | 20:47 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 03-Nov-21 | 20:47 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 03-Nov-21 | 20:47 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 03-Nov-21 | 20:47 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4188.2  | 29584     | 03-Nov-21 | 19:57 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4188.2 | 1631104   | 03-Nov-21 | 20:12 | x86      |
| Dtaengine.exe                                                | 2019.150.4188.2 | 217984    | 03-Nov-21 | 20:12 | x86      |
| Dteparse.dll                                                 | 2019.150.4188.2 | 111488    | 03-Nov-21 | 20:12 | x86      |
| Dteparse.dll                                                 | 2019.150.4188.2 | 123784    | 03-Nov-21 | 20:12 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4188.2 | 115584    | 03-Nov-21 | 20:12 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4188.2 | 131976    | 03-Nov-21 | 20:12 | x64      |
| Dtepkg.dll                                                   | 2019.150.4188.2 | 148376    | 03-Nov-21 | 20:12 | x64      |
| Dtepkg.dll                                                   | 2019.150.4188.2 | 131992    | 03-Nov-21 | 20:12 | x86      |
| Dtexec.exe                                                   | 2019.150.4188.2 | 62880     | 03-Nov-21 | 20:12 | x86      |
| Dtexec.exe                                                   | 2019.150.4188.2 | 71560     | 03-Nov-21 | 20:12 | x64      |
| Dts.dll                                                      | 2019.150.4188.2 | 2761616   | 03-Nov-21 | 20:12 | x86      |
| Dts.dll                                                      | 2019.150.4188.2 | 3142552   | 03-Nov-21 | 20:12 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4188.2 | 500608    | 03-Nov-21 | 20:12 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4188.2 | 443288    | 03-Nov-21 | 20:12 | x86      |
| Dtsconn.dll                                                  | 2019.150.4188.2 | 430984    | 03-Nov-21 | 20:12 | x86      |
| Dtsconn.dll                                                  | 2019.150.4188.2 | 521096    | 03-Nov-21 | 20:12 | x64      |
| Dtshost.exe                                                  | 2019.150.4188.2 | 104328    | 03-Nov-21 | 20:12 | x64      |
| Dtshost.exe                                                  | 2019.150.4188.2 | 87424     | 03-Nov-21 | 20:12 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4188.2 | 553872    | 03-Nov-21 | 19:57 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4188.2 | 566160    | 03-Nov-21 | 19:57 | x64      |
| Dtspipeline.dll                                              | 2019.150.4188.2 | 1119120   | 03-Nov-21 | 20:12 | x86      |
| Dtspipeline.dll                                              | 2019.150.4188.2 | 1328016   | 03-Nov-21 | 20:12 | x64      |
| Dtswizard.exe                                                | 15.0.4188.2     | 885648    | 03-Nov-21 | 20:12 | x64      |
| Dtswizard.exe                                                | 15.0.4188.2     | 889744    | 03-Nov-21 | 20:12 | x86      |
| Dtuparse.dll                                                 | 2019.150.4188.2 | 99200     | 03-Nov-21 | 20:12 | x64      |
| Dtuparse.dll                                                 | 2019.150.4188.2 | 86936     | 03-Nov-21 | 20:12 | x86      |
| Dtutil.exe                                                   | 2019.150.4188.2 | 147336    | 03-Nov-21 | 20:12 | x64      |
| Dtutil.exe                                                   | 2019.150.4188.2 | 128912    | 03-Nov-21 | 20:12 | x86      |
| Exceldest.dll                                                | 2019.150.4188.2 | 234384    | 03-Nov-21 | 20:12 | x86      |
| Exceldest.dll                                                | 2019.150.4188.2 | 279432    | 03-Nov-21 | 20:12 | x64      |
| Excelsrc.dll                                                 | 2019.150.4188.2 | 258960    | 03-Nov-21 | 20:12 | x86      |
| Excelsrc.dll                                                 | 2019.150.4188.2 | 308104    | 03-Nov-21 | 20:12 | x64      |
| Flatfiledest.dll                                             | 2019.150.4188.2 | 410496    | 03-Nov-21 | 20:12 | x64      |
| Flatfiledest.dll                                             | 2019.150.4188.2 | 357256    | 03-Nov-21 | 20:12 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4188.2 | 369544    | 03-Nov-21 | 20:12 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4188.2 | 426880    | 03-Nov-21 | 20:12 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4188.2     | 115600    | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4188.2     | 402328    | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4188.2     | 402328    | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4188.2     | 2999168   | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4188.2     | 2999176   | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4188.2     | 41856     | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4188.2     | 41864     | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4188.2     | 58264     | 03-Nov-21 | 20:12 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 03-Nov-21 | 19:58 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4188.2 | 111504    | 03-Nov-21 | 20:12 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4188.2 | 99208     | 03-Nov-21 | 20:12 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.19  | 8278408   | 03-Nov-21 | 19:59 | x86      |
| Oledbdest.dll                                                | 2019.150.4188.2 | 238464    | 03-Nov-21 | 20:12 | x86      |
| Oledbdest.dll                                                | 2019.150.4188.2 | 279432    | 03-Nov-21 | 20:12 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4188.2 | 263064    | 03-Nov-21 | 20:12 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4188.2 | 312200    | 03-Nov-21 | 20:12 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4188.2 | 50064     | 03-Nov-21 | 20:12 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4188.2 | 37776     | 03-Nov-21 | 20:12 | x86      |
| Sqlscm.dll                                                   | 2019.150.4188.2 | 78752     | 03-Nov-21 | 20:12 | x86      |
| Sqlscm.dll                                                   | 2019.150.4188.2 | 86936     | 03-Nov-21 | 20:12 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4188.2 | 148360    | 03-Nov-21 | 20:12 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4188.2 | 181120    | 03-Nov-21 | 20:12 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4188.2 | 205704    | 03-Nov-21 | 20:12 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4188.2 | 168832    | 03-Nov-21 | 20:12 | x86      |
| Txdataconvert.dll                                            | 2019.150.4188.2 | 316312    | 03-Nov-21 | 20:12 | x64      |
| Txdataconvert.dll                                            | 2019.150.4188.2 | 275344    | 03-Nov-21 | 20:12 | x86      |
| Xe.dll                                                       | 2019.150.4188.2 | 631704    | 03-Nov-21 | 20:12 | x86      |
| Xe.dll                                                       | 2019.150.4188.2 | 721808    | 03-Nov-21 | 20:12 | x64      |

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
