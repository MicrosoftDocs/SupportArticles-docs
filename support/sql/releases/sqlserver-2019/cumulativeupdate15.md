---
title: Cumulative Update 15 for SQL Server 2019 (KB5008996)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 15 (KB5008996).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5008996
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5008996 - Cumulative Update 15 for SQL Server 2019

_Release Date:_ &nbsp; January 27, 2022  
_Version:_ &nbsp; 15.0.4198.2

## Summary

This article describes Cumulative Update package 15 (CU15) for Microsoft SQL Server 2019. This update contains 36 [fixes](#improvements-and-fixes-included-in-this-cumulative-update) that were issued after the release of SQL Server 2019 Cumulative Update 14, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4198.2**, file version: **2019.150.4198.2**
- Analysis Services - Product version: **15.0.35.22**, file version: **2018.150.35.22**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion-context-2019](../includes/av-sesssion-context-2019.md)]

## Improvements and fixes included in this cumulative update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|:--------------------------------------------:|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|----------|
| <a id="14448989">[14448989](#14448989)</a> | Fixes an issue where `AVERAGEX(CURRENTGROUP())` function returns the incorrect result that is close to 0 unless you add 0.0 to the measure in the DAX query. | Analysis Services | Analysis Services | Windows |
| <a id="14126931">[14126931](#14126931)</a> | Fixes an issue where the tooltip of column name doesn't display in SQL Server 2019 Master Data Services (MDS). | Master Data Services | Client | Windows |
| <a id="14393059">[14393059](#14393059)</a> | Fixes an issue about inconsistent data if you add a date that is between last day of 1899 and first day of March 1900 in the MDS add-in for Excel in SQL Server 2019. | Master Data Services | Master Data Services | Windows |
| <a id="14253634">[14253634](#14253634)</a> | Fixes an issue where Distributed Replay Client may fail with an unhandled exception. </br></br>This fix is for the Distributed Replay Client that is released with SQL Server 2019. </br></br>The following is the error you may observe in the output/log file: </br></br>\<DateTime> OPERATIONAL&nbsp;&nbsp;[Common] Unhandled exception is encountered. [Exception Code = 3221225477] </br>\<DateTime> OPERATIONAL&nbsp;&nbsp;[Common] Invoking dump. </br>\<DateTime> OPERATIONAL&nbsp;&nbsp;[Common] Service terminating. | SQL Server Client Tools | Database Performance Tools| Windows |
| <a id="14428866">[14428866](#14428866)</a> | Fixes an issue where the Shrink Database task in maintenance plans doesn't work in SQL Server 2019. | SQL Server Client Tools | SSMS | Windows |
| <a id="14043526">[14043526](#14043526)</a> | [FIX: Buffer overruns when data buffer spans multiple SNI packets (KB5010234)](https://support.microsoft.com/help/5010234) | SQL Server Connectivity | Protocols | Windows |
| <a id="14500584">[14500584](#14500584)</a> | [FIX: Database corruption after creating an external library in SQL Server 2019 (KB5010653)](https://support.microsoft.com/help/5010653) | SQL Server Engine | Extensibility | All |
| <a id="14401565">[14401565](#14401565)</a> | Fixes an access violation that occurs when you use FileTable in SQL Server 2019. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="14364622">[14364622](#14364622)</a> | Fixes an issue where assertion failure on secondary replica when you use Always On availability groups in high-latency networks in SQL Server 2019. </br></br>You may see this assert failure in the error log: </br></br>Assertion: File: <"e:\\\b\\\s3\\\sources\\\sql\\\ntdbms\\\storeng\\\dfs\\\trans\\\lsnlocmap.cpp">, line=358 Failed Assertion = 'pos - pndx < map->EntryCount' | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14396483">[14396483](#14396483)</a> | Adds improvement to capture `sp_server_diagnostics` XEvent in an `AlwaysOn_health` XEvent session when `STATE` is **3** (ERROR) to diagnose HADR Health Events.| SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14396775">[14396775](#14396775)</a> | Adds the Reverting progress to SQL Server error logs in SQL Server 2019 just like the Recovery progress. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14401590">[14401590](#14401590)</a> | Fixes an error that occurs after a failover of a Distributed Availability Group that attempts to connect to the secondary AG listener with application intent set to `READ ONLY`. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14300646">[14300646](#14300646)</a> | Fixes the following insufficient memory error that occurs during In-Memory Online Transactional Processing (OLTP) if application native procedures update tables that have Large Object (LOB) columns and don't specify the LOB column in the UPDATE list: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Disallowing page allocations for database 'Retail' due to insufficient memory in the resource pool 'IMOLTP'. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;XTP failed page allocation due to memory pressure: FAIL_PAGE_ALLOCATION 8 | SQL Server Engine | In-Memory OLTP| All |
| <a id="13313683">[13313683](#13313683)</a> | [Improvement: Add 1 (true) and 0 (false) as valid values to mssql-conf Boolean settings (KB5010246)](https://support.microsoft.com/help/5010246) | SQL Server Engine | Linux | Linux |
| <a id="14196082">[14196082](#14196082)</a> | [Improvement: Add mssql-conf and adutil utilities to SQL Server 2019 (KB5008647)](https://support.microsoft.com/help/5008647) | SQL Server Engine | Linux | Linux |
| <a id="14288034">[14288034](#14288034)</a> | Adds an improvement to enhance the security of machine keys by enabling you to change the default machine key location to a custom location by using SQL Platform Abstraction Layer (PAL) encryption settings. | SQL Server Engine | Linux | Linux|
| <a id="14401082">[14401082](#14401082)</a> | Fixes a committed memory accounting issue, which under some circumstances, `FAIL_PAGE_ALLOCATION` error could occur a few days after starting SQL Server services on Linux. | SQL Server Engine | Linux | Linux |
| <a id="14465885">[14465885](#14465885)</a> | Fixes the following error that occurs when you back up a database by using virtual device interface (VDI) on ubuntu docker container installed SQL Server 2019: </br></br>Host\_\<DeviceName>_SQLVDIMemoryName_0: ClientBufferAreaManager::SyncWithGlobalTable: Open(hBufferMemory): error 2Host\_\<DeviceName>_SQLVDIMemoryName_0: TriggerAbort: invoked: error 0Host\_\<DeviceName>_SQLVDIMemoryName_0: TriggerAbort: ChannelSem: error 2Features returned by SQL Server: 0x10000 </br></br>Opening the device. </br>VDS::OpenDevice fails: x80770004 </br>Msg 18210, Level 16, State 1, Server \<ServerName>, Line \<LineNumber> </br>BackupVirtualDeviceSet::AllocateBuffer:&nbsp;&nbsp;failure on backup device '\<DeviceName>'. Operating system error 995(The I/O operation has been aborted because of either a thread exit or an application request.). </br>Msg 3013, Level 16, State 1, Server \<ServerName>, Line \<LineNumber> </br>BACKUP DATABASE is terminating abnormally. | SQL Server Engine | Linux | Linux |
| <a id="14289674">[14289674](#14289674)</a> | Fixes an issue where a filtered index becomes corrupted after you drop a computed column on the same table, and the filtered index corruptions are reported as 8951 and 8955 errors when you run `DBCC CHECKTABLE WITH EXTENDED_LOGICAL_CHECKS`. | SQL Server Engine | Metadata | Windows |
| <a id="14320308">[14320308](#14320308)</a> | Fixes the memory release issue in execution of the `STDistance` spatial method while using spatial index. Before the fix, memory usage of `MEMORYCLERK_SOSNODE` gradually grew until all the memory available is taken. </br></br>**Note**: This fix requires that trace flag 8119 be in effect. You can enable the flag through `DBCC TRACEON`. However, we recommend that you apply it as a startup parameter so that it isn't removed when SQL Server restarts. | SQL Server Engine | Metadata | Windows |
| <a id="14382474">[14382474](#14382474)</a> | Fixes an issue where the output of `sp_pkeys KEY_SEQ` column doesn't conform to the ordering of columns defined in the Primary Key. | SQL Server Engine | Metadata| Windows |
| <a id="14382100">[14382100](#14382100)</a> | Fixes an issue where the `dm_db_page_info` function may record spurious corrupted pages entries in the `suspect_pages` table when calling the function against the transaction log file. | SQL Server Engine | Methods to access stored data| Windows |
| <a id="14312688">[14312688](#14312688)</a> | Fixes an issue where `java.nio.BufferOverflowException` error occurs when using PolyBase external tables to query data from Hadoop. </br></br>**Note**: This error occurs when querying from a file that has columns of type varchar or nvarchar with a width greater than 256 characters. | SQL Server Engine | PolyBase | All |
| <a id="14419546">[14419546](#14419546)</a> | [FIX: Physical reads are counted twice for read-ahead (KB5009753)](https://support.microsoft.com/help/5009753) | SQL Server Engine | Query Execution | All |
| <a id="14488550">[14488550](#14488550)</a> | Fixes a parallel query executing in batch mode that may cause an access violation and memory dump after installing CU14. | SQL Server Engine | Query Execution | Windows |
| <a id="14491100">[14491100](#14491100)</a> | Fixes an access violation that occurs in `CXPort::Close` after you use SQL Server 2019 Cumulative Update 14 (CU14). | SQL Server Engine | Query Execution | Windows |
| <a id="14394202">[14394202](#14394202)</a> | Fixes the following error 104 that occurs when you use scalar User-Defined Function (UDF) lnlining in the `ORDER BY` clause during the query compilation that has a `UNION` operator: </br></br>Msg 104, Level 16, State 1, Line \<LineNumber> </br>ORDER BY items must appear in the select list if the statement contains a UNION, INTERSECT or EXCEPT operator. | SQL Server Engine | Query Optimizer | All |
| <a id="14416748">[14416748](#14416748)</a> | Fixes an assertion in `CQPOnDemandTask::ExecuteQPJob` if auto async update statistics is enabled. </br></br>You may see this assert failure in the error log: </br></br>Assertion: File: <sosmemobj.cpp>, line=2774 Failed Assertion = 'pvb->FLargeAlloc () == FALSE' |SQL Server Engine | Query Optimizer | Windows |
| <a id="14434937">[14434937](#14434937)</a> | Fixes an issue where the specific statement for compilation in stored procedures seems "stuck" and shows `sqlsource_transform` until manual intervention. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14165626">[14165626](#14165626)</a> | Fixes an issue where different conversion results are displayed in publisher and subscriber database tables when using the ASCII function to convert a column. For more information, see [ASCII function returns different results in Publisher and Subscriber database tables](../../database-engine/replication/ascii-function-returns-different-results-publisher-subscriber.md). | SQL Server Engine | Replication | Windows |
| <a id="14227331">[14227331](#14227331)</a> | Fixes an issue where the default trace on Linux rolls over before the limit size of 20 MB. | SQL Server Engine | SQL OS | Linux |
| <a id="14412969">[14412969](#14412969)</a> | Fixes the access violation `sqldk!StringVPrintfWorkerW` that occurs during the compilation of the query for Dynamic Management Views (DMVs) `sys.dm_os_ring_buffers`. |SQL Server Engine | SQL OS | Windows |
| <a id="14421838">[14421838](#14421838)</a> | Fixes a system-wide low memory issue that occurs when SQL Server commits memory above the maximum server memory under the memory model with the Lock Pages In Memory. </br></br>**Note**: You should install startup trace flag 8121 to enable this fix. | SQL Server Engine | SQL OS | Windows |
| <a id="14497737">[14497737](#14497737)</a> | Adds improvement in capturing memory dumps on unexpected crashes in SQL Server 2019 on Linux. | SQL Server Engine | SQL OS | Linux |
| <a id="14459544">[14459544](#14459544)</a> | [Improvement: Add the usage of signed certificates with multiple DNS names (KB5010555)](https://support.microsoft.com/help/5010555) | SQL Server Engine | Surface Area | All |
| <a id="14332270">[14332270](#14332270)</a> | Fixes an issue where Cumulative Update (CU) patching fails with the following message when you set default data directory to Azure Blob Storage URL: </br></br>The given path's format is not supported. </br></br>Exception Type "System.NotSupportedException" </br><br>**Note**: To work around the issue, you can change the data default directory to a local directory and rerun the SQL patch. | SQL Setup | Patching | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU15 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/sqlserver2019-kb5008996-x64_f914e20d97650c2b2c09bd8f3d35d3f0feb1afd3.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5008996-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5008996-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5008996-x64.exe|503A17BDCACD1E02FF1E6EE673E6F1EEDB0DAF674CAF4FAFFE607FDC4D230190|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.22  | 292800    | 12-Jan-22 | 22:58 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 12-Jan-22 | 22:58 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.22      | 758200    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 175552    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 198536    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 202176    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 198592    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 214968    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 197568    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 192392    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 251272    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 174016    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.22      | 195976    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.22      | 1097096   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.22      | 479632    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 53640     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 58248     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 58760     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 57736     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 60808     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 58304     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 57224     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 66440     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 53696     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.22      | 57224     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16776     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 17800     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16792     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.22      | 16776     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 12-Jan-22 | 22:58 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 12-Jan-22 | 22:58 | x86      |
| Msmdctr.dll                                               | 2018.150.35.22  | 37256     | 12-Jan-22 | 22:58 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.22  | 66290568  | 12-Jan-22 | 22:58 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.22  | 47784344  | 12-Jan-22 | 22:58 | x86      |
| Msmdpump.dll                                              | 2018.150.35.22  | 10187672  | 12-Jan-22 | 22:58 | x64      |
| Msmdredir.dll                                             | 2018.150.35.22  | 7956920   | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 15752     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 15752     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 16264     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 15752     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 16264     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 16264     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 16264     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 17288     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 15752     | 12-Jan-22 | 22:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.22      | 15752     | 12-Jan-22 | 22:58 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.22  | 65830296  | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 833472    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1627032   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1454016   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1642944   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1608640   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1001408   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 991632    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1536952   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1520536   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 810944    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.22  | 1596352   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 832448    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1624512   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1450944   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1637824   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1604544   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 998840    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 991160    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1532864   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1518016   | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 809920    | 12-Jan-22 | 22:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.22  | 1591744   | 12-Jan-22 | 22:58 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.22  | 10184600  | 12-Jan-22 | 22:58 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.22  | 8278424   | 12-Jan-22 | 22:58 | x86      |
| Msolap.dll                                                | 2018.150.35.22  | 11015056  | 12-Jan-22 | 22:58 | x64      |
| Msolap.dll                                                | 2018.150.35.22  | 8607112   | 12-Jan-22 | 22:58 | x86      |
| Msolui.dll                                                | 2018.150.35.22  | 306624    | 12-Jan-22 | 22:58 | x64      |
| Msolui.dll                                                | 2018.150.35.22  | 286144    | 12-Jan-22 | 22:58 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 12-Jan-22 | 22:58 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 12-Jan-22 | 22:58 | x64      |
| Sqlboot.dll                                               | 2019.150.4198.2 | 214968    | 12-Jan-22 | 22:58 | x64      |
| Sqlceip.exe                                               | 15.0.4198.2     | 291712    | 12-Jan-22 | 22:58 | x86      |
| Sqldumper.exe                                             | 2019.150.4198.2 | 152464    | 12-Jan-22 | 22:58 | x86      |
| Sqldumper.exe                                             | 2019.150.4198.2 | 186296    | 12-Jan-22 | 22:58 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 12-Jan-22 | 22:58 | x86      |
| Tmapi.dll                                                 | 2018.150.35.22  | 6178232   | 12-Jan-22 | 22:58 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.22  | 4916616   | 12-Jan-22 | 22:58 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.22  | 1183632   | 12-Jan-22 | 22:58 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.22  | 6805400   | 12-Jan-22 | 22:58 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.22  | 26024840  | 12-Jan-22 | 22:58 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.22  | 35460544  | 12-Jan-22 | 22:58 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4198.2 | 75704     | 12-Jan-22 | 22:58 | x86      |
| Instapi150.dll                       | 2019.150.4198.2 | 86912     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4198.2 | 99200     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4198.2 | 86920     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4198.2     | 550840    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4198.2     | 550840    | 12-Jan-22 | 22:58 | x86      |
| Msasxpress.dll                       | 2018.150.35.22  | 25992     | 12-Jan-22 | 22:58 | x86      |
| Msasxpress.dll                       | 2018.150.35.22  | 32184     | 12-Jan-22 | 22:58 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4198.2 | 74640     | 12-Jan-22 | 22:58 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4198.2 | 86928     | 12-Jan-22 | 22:58 | x64      |
| Sqldumper.exe                        | 2019.150.4198.2 | 152464    | 12-Jan-22 | 22:58 | x86      |
| Sqldumper.exe                        | 2019.150.4198.2 | 186296    | 12-Jan-22 | 22:58 | x64      |
| Sqlftacct.dll                        | 2019.150.4198.2 | 59320     | 12-Jan-22 | 22:58 | x86      |
| Sqlftacct.dll                        | 2019.150.4198.2 | 78736     | 12-Jan-22 | 22:58 | x64      |
| Sqlmanager.dll                       | 2019.150.4198.2 | 742288    | 12-Jan-22 | 22:58 | x86      |
| Sqlmanager.dll                       | 2019.150.4198.2 | 877456    | 12-Jan-22 | 22:58 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4198.2 | 378808    | 12-Jan-22 | 22:58 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4198.2 | 430984    | 12-Jan-22 | 22:58 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4198.2 | 357264    | 12-Jan-22 | 22:58 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4198.2 | 276408    | 12-Jan-22 | 22:58 | x86      |
| Svrenumapi150.dll                    | 2019.150.4198.2 | 910224    | 12-Jan-22 | 22:58 | x86      |
| Svrenumapi150.dll                    | 2019.150.4198.2 | 1161144   | 12-Jan-22 | 22:58 | x64      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4198.2 | 136064    | 12-Jan-22 | 22:58 | x86      |
| Dreplaycommon.dll     | 2019.150.4198.2 | 665488    | 12-Jan-22 | 22:58 | x86      |
| Dreplayutil.dll       | 2019.150.4198.2 | 304008    | 12-Jan-22 | 22:58 | x86      |
| Instapi150.dll        | 2019.150.4198.2 | 86912     | 12-Jan-22 | 22:58 | x64      |
| Sqlresourceloader.dll | 2019.150.4198.2 | 37760     | 12-Jan-22 | 22:58 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4198.2 | 665488    | 12-Jan-22 | 22:58 | x86      |
| Dreplaycontroller.exe | 2019.150.4198.2 | 365448    | 12-Jan-22 | 22:58 | x86      |
| Instapi150.dll        | 2019.150.4198.2 | 86912     | 12-Jan-22 | 22:58 | x64      |
| Sqlresourceloader.dll | 2019.150.4198.2 | 37760     | 12-Jan-22 | 22:58 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4198.2 | 4657024   | 12-Jan-22 | 23:51 | x64      |
| Aetm-enclave.dll                           | 2019.150.4198.2 | 4611448   | 12-Jan-22 | 23:51 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4198.2 | 4931344   | 12-Jan-22 | 23:51 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4198.2 | 4871960   | 12-Jan-22 | 23:51 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 12-Jan-22 | 22:58 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 12-Jan-22 | 22:58 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 12-Jan-22 | 23:51 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 12-Jan-22 | 23:51 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 12-Jan-22 | 23:51 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 12-Jan-22 | 23:51 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4198.2 | 279440    | 12-Jan-22 | 23:51 | x64      |
| Dcexec.exe                                 | 2019.150.4198.2 | 86928     | 12-Jan-22 | 23:51 | x64      |
| Fssres.dll                                 | 2019.150.4198.2 | 96184     | 12-Jan-22 | 23:51 | x64      |
| Hadrres.dll                                | 2019.150.4198.2 | 202680    | 12-Jan-22 | 23:51 | x64      |
| Hkcompile.dll                              | 2019.150.4198.2 | 1291152   | 12-Jan-22 | 23:51 | x64      |
| Hkengine.dll                               | 2019.150.4198.2 | 5784456   | 12-Jan-22 | 23:51 | x64      |
| Hkruntime.dll                              | 2019.150.4198.2 | 181136    | 12-Jan-22 | 23:51 | x64      |
| Hktempdb.dll                               | 2019.150.4198.2 | 62336     | 12-Jan-22 | 23:51 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 12-Jan-22 | 23:51 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4198.2     | 234384    | 12-Jan-22 | 23:51 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4198.2 | 325560    | 12-Jan-22 | 23:51 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4198.2 | 91016     | 12-Jan-22 | 23:51 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 12-Jan-22 | 23:51 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 12-Jan-22 | 23:51 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 12-Jan-22 | 23:51 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 12-Jan-22 | 23:51 | x64      |
| Qds.dll                                    | 2019.150.4198.2 | 1184656   | 12-Jan-22 | 23:51 | x64      |
| Rsfxft.dll                                 | 2019.150.4198.2 | 50048     | 12-Jan-22 | 23:51 | x64      |
| Secforwarder.dll                           | 2019.150.4198.2 | 78728     | 12-Jan-22 | 23:51 | x64      |
| Sqagtres.dll                               | 2019.150.4198.2 | 87992     | 12-Jan-22 | 23:51 | x64      |
| Sqlaamss.dll                               | 2019.150.4198.2 | 108472    | 12-Jan-22 | 23:51 | x64      |
| Sqlaccess.dll                              | 2019.150.4198.2 | 493496    | 12-Jan-22 | 23:51 | x64      |
| Sqlagent.exe                               | 2019.150.4198.2 | 730000    | 12-Jan-22 | 23:51 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4198.2 | 79800     | 12-Jan-22 | 23:51 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4198.2 | 67512     | 12-Jan-22 | 23:51 | x86      |
| Sqlboot.dll                                | 2019.150.4198.2 | 214968    | 12-Jan-22 | 23:51 | x64      |
| Sqlceip.exe                                | 15.0.4198.2     | 291712    | 12-Jan-22 | 23:51 | x86      |
| Sqlcmdss.dll                               | 2019.150.4198.2 | 86928     | 12-Jan-22 | 23:51 | x64      |
| Sqlctr150.dll                              | 2019.150.4198.2 | 140176    | 12-Jan-22 | 23:51 | x64      |
| Sqlctr150.dll                              | 2019.150.4198.2 | 115600    | 12-Jan-22 | 23:51 | x86      |
| Sqldk.dll                                  | 2019.150.4198.2 | 3150736   | 12-Jan-22 | 23:51 | x64      |
| Sqldtsss.dll                               | 2019.150.4198.2 | 107408    | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 1594240   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3498888   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3696568   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4163512   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4281224   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3412864   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3580808   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4155320   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4011960   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4060032   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 2222008   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 2171784   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3867528   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3545016   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4016056   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3818376   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3814280   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3613576   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3499960   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 1536896   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 3904392   | 12-Jan-22 | 23:51 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4198.2 | 4028344   | 12-Jan-22 | 23:51 | x64      |
| Sqllang.dll                                | 2019.150.4198.2 | 39965584  | 12-Jan-22 | 23:51 | x64      |
| Sqlmin.dll                                 | 2019.150.4198.2 | 40523152  | 12-Jan-22 | 23:51 | x64      |
| Sqlolapss.dll                              | 2019.150.4198.2 | 103312    | 12-Jan-22 | 23:51 | x64      |
| Sqlos.dll                                  | 2019.150.4198.2 | 41864     | 12-Jan-22 | 23:51 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4198.2 | 82832     | 12-Jan-22 | 23:51 | x64      |
| Sqlrepss.dll                               | 2019.150.4198.2 | 82832     | 12-Jan-22 | 23:51 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4198.2 | 50056     | 12-Jan-22 | 23:51 | x64      |
| Sqlscm.dll                                 | 2019.150.4198.2 | 86928     | 12-Jan-22 | 23:51 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4198.2 | 37768     | 12-Jan-22 | 23:51 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4198.2 | 5804944   | 12-Jan-22 | 23:51 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4198.2 | 672656    | 12-Jan-22 | 23:51 | x64      |
| Sqlservr.exe                               | 2019.150.4198.2 | 627592    | 12-Jan-22 | 23:51 | x64      |
| Sqlsvc.dll                                 | 2019.150.4198.2 | 181128    | 12-Jan-22 | 23:51 | x64      |
| Sqltses.dll                                | 2019.150.4198.2 | 9114504   | 12-Jan-22 | 23:51 | x64      |
| Sqsrvres.dll                               | 2019.150.4198.2 | 280504    | 12-Jan-22 | 23:51 | x64      |
| Svl.dll                                    | 2019.150.4198.2 | 161720    | 12-Jan-22 | 23:51 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 12-Jan-22 | 23:51 | x64      |
| Xe.dll                                     | 2019.150.4198.2 | 721808    | 12-Jan-22 | 23:51 | x64      |
| Xpadsi.exe                                 | 2019.150.4198.2 | 115600    | 12-Jan-22 | 23:51 | x64      |
| Xplog70.dll                                | 2019.150.4198.2 | 91024     | 12-Jan-22 | 23:51 | x64      |
| Xpqueue.dll                                | 2019.150.4198.2 | 92088     | 12-Jan-22 | 23:51 | x64      |
| Xprepl.dll                                 | 2019.150.4198.2 | 119696    | 12-Jan-22 | 23:51 | x64      |
| Xpstar.dll                                 | 2019.150.4198.2 | 471952    | 12-Jan-22 | 23:51 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4198.2 | 263048    | 12-Jan-22 | 22:58 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4198.2 | 227256    | 12-Jan-22 | 22:58 | x64      |
| Distrib.exe                                                  | 2019.150.4198.2 | 234384    | 12-Jan-22 | 22:58 | x64      |
| Dteparse.dll                                                 | 2019.150.4198.2 | 123784    | 12-Jan-22 | 22:58 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4198.2 | 131984    | 12-Jan-22 | 22:58 | x64      |
| Dtepkg.dll                                                   | 2019.150.4198.2 | 148368    | 12-Jan-22 | 22:58 | x64      |
| Dtexec.exe                                                   | 2019.150.4198.2 | 71568     | 12-Jan-22 | 22:58 | x64      |
| Dts.dll                                                      | 2019.150.4198.2 | 3142536   | 12-Jan-22 | 22:58 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4198.2 | 500608    | 12-Jan-22 | 22:58 | x64      |
| Dtsconn.dll                                                  | 2019.150.4198.2 | 522168    | 12-Jan-22 | 22:58 | x64      |
| Dtshost.exe                                                  | 2019.150.4198.2 | 104328    | 12-Jan-22 | 22:58 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4198.2 | 567224    | 12-Jan-22 | 22:58 | x64      |
| Dtspipeline.dll                                              | 2019.150.4198.2 | 1328016   | 12-Jan-22 | 22:58 | x64      |
| Dtswizard.exe                                                | 15.0.4198.2     | 885648    | 12-Jan-22 | 22:58 | x64      |
| Dtuparse.dll                                                 | 2019.150.4198.2 | 99216     | 12-Jan-22 | 22:58 | x64      |
| Dtutil.exe                                                   | 2019.150.4198.2 | 147344    | 12-Jan-22 | 22:58 | x64      |
| Exceldest.dll                                                | 2019.150.4198.2 | 279432    | 12-Jan-22 | 22:58 | x64      |
| Excelsrc.dll                                                 | 2019.150.4198.2 | 308104    | 12-Jan-22 | 22:58 | x64      |
| Execpackagetask.dll                                          | 2019.150.4198.2 | 185224    | 12-Jan-22 | 22:58 | x64      |
| Flatfiledest.dll                                             | 2019.150.4198.2 | 410504    | 12-Jan-22 | 22:58 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4198.2 | 426888    | 12-Jan-22 | 22:58 | x64      |
| Logread.exe                                                  | 2019.150.4198.2 | 718776    | 12-Jan-22 | 22:58 | x64      |
| Mergetxt.dll                                                 | 2019.150.4198.2 | 74640     | 12-Jan-22 | 22:58 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4198.2     | 58240     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4198.2     | 41864     | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4198.2     | 390032    | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4198.2 | 1688456   | 12-Jan-22 | 22:58 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4198.2 | 1640376   | 12-Jan-22 | 22:58 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4198.2     | 550840    | 12-Jan-22 | 22:58 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4198.2 | 111488    | 12-Jan-22 | 22:58 | x64      |
| Msgprox.dll                                                  | 2019.150.4198.2 | 300984    | 12-Jan-22 | 22:58 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 12-Jan-22 | 22:58 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4198.2 | 1495944   | 12-Jan-22 | 22:58 | x64      |
| Oledbdest.dll                                                | 2019.150.4198.2 | 279424    | 12-Jan-22 | 22:58 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4198.2 | 313272    | 12-Jan-22 | 22:58 | x64      |
| Osql.exe                                                     | 2019.150.4198.2 | 91008     | 12-Jan-22 | 22:58 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4198.2 | 496528    | 12-Jan-22 | 22:58 | x64      |
| Rawdest.dll                                                  | 2019.150.4198.2 | 226192    | 12-Jan-22 | 22:58 | x64      |
| Rawsource.dll                                                | 2019.150.4198.2 | 209808    | 12-Jan-22 | 22:58 | x64      |
| Rdistcom.dll                                                 | 2019.150.4198.2 | 915384    | 12-Jan-22 | 22:58 | x64      |
| Recordsetdest.dll                                            | 2019.150.4198.2 | 201616    | 12-Jan-22 | 22:58 | x64      |
| Repldp.dll                                                   | 2019.150.4198.2 | 313272    | 12-Jan-22 | 22:58 | x64      |
| Replerrx.dll                                                 | 2019.150.4198.2 | 181136    | 12-Jan-22 | 22:58 | x64      |
| Replisapi.dll                                                | 2019.150.4198.2 | 394128    | 12-Jan-22 | 22:58 | x64      |
| Replmerg.exe                                                 | 2019.150.4198.2 | 562064    | 12-Jan-22 | 22:58 | x64      |
| Replprov.dll                                                 | 2019.150.4198.2 | 856976    | 12-Jan-22 | 22:58 | x64      |
| Replrec.dll                                                  | 2019.150.4198.2 | 1034168   | 12-Jan-22 | 22:58 | x64      |
| Replsub.dll                                                  | 2019.150.4198.2 | 471952    | 12-Jan-22 | 22:58 | x64      |
| Replsync.dll                                                 | 2019.150.4198.2 | 165816    | 12-Jan-22 | 22:58 | x64      |
| Spresolv.dll                                                 | 2019.150.4198.2 | 275344    | 12-Jan-22 | 22:58 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4198.2 | 264120    | 12-Jan-22 | 22:58 | x64      |
| Sqldiag.exe                                                  | 2019.150.4198.2 | 1139584   | 12-Jan-22 | 22:58 | x64      |
| Sqldistx.dll                                                 | 2019.150.4198.2 | 246672    | 12-Jan-22 | 22:58 | x64      |
| Sqllogship.exe                                               | 15.0.4198.2     | 104376    | 12-Jan-22 | 22:58 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4198.2 | 398224    | 12-Jan-22 | 22:58 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4198.2 | 37760     | 12-Jan-22 | 22:58 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4198.2 | 50056     | 12-Jan-22 | 22:58 | x64      |
| Sqlscm.dll                                                   | 2019.150.4198.2 | 86928     | 12-Jan-22 | 22:58 | x64      |
| Sqlscm.dll                                                   | 2019.150.4198.2 | 78736     | 12-Jan-22 | 22:58 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4198.2 | 181128    | 12-Jan-22 | 22:58 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4198.2 | 148368    | 12-Jan-22 | 22:58 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4198.2 | 201616    | 12-Jan-22 | 22:58 | x64      |
| Ssradd.dll                                                   | 2019.150.4198.2 | 82832     | 12-Jan-22 | 22:58 | x64      |
| Ssravg.dll                                                   | 2019.150.4198.2 | 82832     | 12-Jan-22 | 22:58 | x64      |
| Ssrdown.dll                                                  | 2019.150.4198.2 | 74640     | 12-Jan-22 | 22:58 | x64      |
| Ssrmax.dll                                                   | 2019.150.4198.2 | 82832     | 12-Jan-22 | 22:58 | x64      |
| Ssrmin.dll                                                   | 2019.150.4198.2 | 82832     | 12-Jan-22 | 22:58 | x64      |
| Ssrpub.dll                                                   | 2019.150.4198.2 | 75704     | 12-Jan-22 | 22:58 | x64      |
| Ssrup.dll                                                    | 2019.150.4198.2 | 75704     | 12-Jan-22 | 22:58 | x64      |
| Txagg.dll                                                    | 2019.150.4198.2 | 390016    | 12-Jan-22 | 22:58 | x64      |
| Txbdd.dll                                                    | 2019.150.4198.2 | 189320    | 12-Jan-22 | 22:58 | x64      |
| Txdatacollector.dll                                          | 2019.150.4198.2 | 484232    | 12-Jan-22 | 22:58 | x64      |
| Txdataconvert.dll                                            | 2019.150.4198.2 | 316304    | 12-Jan-22 | 22:58 | x64      |
| Txderived.dll                                                | 2019.150.4198.2 | 639888    | 12-Jan-22 | 22:58 | x64      |
| Txlookup.dll                                                 | 2019.150.4198.2 | 541576    | 12-Jan-22 | 22:58 | x64      |
| Txmerge.dll                                                  | 2019.150.4198.2 | 246664    | 12-Jan-22 | 22:58 | x64      |
| Txmergejoin.dll                                              | 2019.150.4198.2 | 308104    | 12-Jan-22 | 22:58 | x64      |
| Txmulticast.dll                                              | 2019.150.4198.2 | 148368    | 12-Jan-22 | 22:58 | x64      |
| Txrowcount.dll                                               | 2019.150.4198.2 | 140168    | 12-Jan-22 | 22:58 | x64      |
| Txsort.dll                                                   | 2019.150.4198.2 | 287624    | 12-Jan-22 | 22:58 | x64      |
| Txsplit.dll                                                  | 2019.150.4198.2 | 624568    | 12-Jan-22 | 22:58 | x64      |
| Txunionall.dll                                               | 2019.150.4198.2 | 205712    | 12-Jan-22 | 22:58 | x64      |
| Xe.dll                                                       | 2019.150.4198.2 | 721808    | 12-Jan-22 | 22:58 | x64      |
| Xmlsub.dll                                                   | 2019.150.4198.2 | 295824    | 12-Jan-22 | 22:58 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4198.2 | 95112     | 12-Jan-22 | 22:58 | x64      |
| Exthost.exe        | 2019.150.4198.2 | 238464    | 12-Jan-22 | 22:58 | x64      |
| Launchpad.exe      | 2019.150.4198.2 | 1221520   | 12-Jan-22 | 22:58 | x64      |
| Sqlsatellite.dll   | 2019.150.4198.2 | 1021880   | 12-Jan-22 | 22:58 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4198.2 | 686008    | 12-Jan-22 | 22:58 | x64      |
| Fdhost.exe     | 2019.150.4198.2 | 127872    | 12-Jan-22 | 22:58 | x64      |
| Fdlauncher.exe | 2019.150.4198.2 | 78736     | 12-Jan-22 | 22:58 | x64      |
| Sqlft150ph.dll | 2019.150.4198.2 | 92088     | 12-Jan-22 | 22:58 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4198.2  | 29568     | 12-Jan-22 | 22:58 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4198.2 | 263048    | 12-Jan-22 | 22:59 | x64      |
| Commanddest.dll                                               | 2019.150.4198.2 | 227256    | 12-Jan-22 | 22:59 | x86      |
| Dteparse.dll                                                  | 2019.150.4198.2 | 112568    | 12-Jan-22 | 22:59 | x86      |
| Dteparse.dll                                                  | 2019.150.4198.2 | 123784    | 12-Jan-22 | 22:59 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4198.2 | 115592    | 12-Jan-22 | 22:59 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4198.2 | 131984    | 12-Jan-22 | 22:59 | x64      |
| Dtepkg.dll                                                    | 2019.150.4198.2 | 131984    | 12-Jan-22 | 22:59 | x86      |
| Dtepkg.dll                                                    | 2019.150.4198.2 | 148368    | 12-Jan-22 | 22:59 | x64      |
| Dtexec.exe                                                    | 2019.150.4198.2 | 62864     | 12-Jan-22 | 22:59 | x86      |
| Dtexec.exe                                                    | 2019.150.4198.2 | 71568     | 12-Jan-22 | 22:59 | x64      |
| Dts.dll                                                       | 2019.150.4198.2 | 3142536   | 12-Jan-22 | 22:59 | x64      |
| Dts.dll                                                       | 2019.150.4198.2 | 2761616   | 12-Jan-22 | 22:59 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4198.2 | 500608    | 12-Jan-22 | 22:59 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4198.2 | 444344    | 12-Jan-22 | 22:59 | x86      |
| Dtsconn.dll                                                   | 2019.150.4198.2 | 522168    | 12-Jan-22 | 22:59 | x64      |
| Dtsconn.dll                                                   | 2019.150.4198.2 | 430992    | 12-Jan-22 | 22:59 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4198.2 | 110976    | 12-Jan-22 | 22:59 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4198.2 | 93624     | 12-Jan-22 | 22:59 | x86      |
| Dtshost.exe                                                   | 2019.150.4198.2 | 104328    | 12-Jan-22 | 22:59 | x64      |
| Dtshost.exe                                                   | 2019.150.4198.2 | 88504     | 12-Jan-22 | 22:59 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4198.2 | 553872    | 12-Jan-22 | 22:59 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4198.2 | 567224    | 12-Jan-22 | 22:59 | x64      |
| Dtspipeline.dll                                               | 2019.150.4198.2 | 1328016   | 12-Jan-22 | 22:59 | x64      |
| Dtspipeline.dll                                               | 2019.150.4198.2 | 1119104   | 12-Jan-22 | 22:59 | x86      |
| Dtswizard.exe                                                 | 15.0.4198.2     | 885648    | 12-Jan-22 | 22:59 | x64      |
| Dtswizard.exe                                                 | 15.0.4198.2     | 889744    | 12-Jan-22 | 22:59 | x86      |
| Dtuparse.dll                                                  | 2019.150.4198.2 | 86920     | 12-Jan-22 | 22:59 | x86      |
| Dtuparse.dll                                                  | 2019.150.4198.2 | 99216     | 12-Jan-22 | 22:59 | x64      |
| Dtutil.exe                                                    | 2019.150.4198.2 | 128912    | 12-Jan-22 | 22:59 | x86      |
| Dtutil.exe                                                    | 2019.150.4198.2 | 147344    | 12-Jan-22 | 22:59 | x64      |
| Exceldest.dll                                                 | 2019.150.4198.2 | 279432    | 12-Jan-22 | 22:59 | x64      |
| Exceldest.dll                                                 | 2019.150.4198.2 | 235448    | 12-Jan-22 | 22:59 | x86      |
| Excelsrc.dll                                                  | 2019.150.4198.2 | 308104    | 12-Jan-22 | 22:59 | x64      |
| Excelsrc.dll                                                  | 2019.150.4198.2 | 260024    | 12-Jan-22 | 22:59 | x86      |
| Execpackagetask.dll                                           | 2019.150.4198.2 | 148352    | 12-Jan-22 | 22:59 | x86      |
| Execpackagetask.dll                                           | 2019.150.4198.2 | 185224    | 12-Jan-22 | 22:59 | x64      |
| Flatfiledest.dll                                              | 2019.150.4198.2 | 410504    | 12-Jan-22 | 22:59 | x64      |
| Flatfiledest.dll                                              | 2019.150.4198.2 | 357248    | 12-Jan-22 | 22:59 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4198.2 | 426888    | 12-Jan-22 | 22:59 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4198.2 | 369536    | 12-Jan-22 | 22:59 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4198.2     | 119688    | 12-Jan-22 | 22:59 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4198.2     | 119688    | 12-Jan-22 | 22:59 | x86      |
| Isserverexec.exe                                              | 15.0.4198.2     | 145336    | 12-Jan-22 | 22:59 | x64      |
| Isserverexec.exe                                              | 15.0.4198.2     | 149432    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4198.2     | 115592    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4198.2     | 58240     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4198.2     | 58248     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4198.2     | 508800    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4198.2     | 508808    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4198.2     | 41864     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4198.2     | 41856     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4198.2     | 390032    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4198.2     | 58240     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4198.2     | 59320     | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4198.2     | 140176    | 12-Jan-22 | 22:59 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4198.2     | 140160    | 12-Jan-22 | 22:59 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4198.2     | 218000    | 12-Jan-22 | 22:59 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4198.2 | 111488    | 12-Jan-22 | 22:59 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4198.2 | 99208     | 12-Jan-22 | 22:59 | x86      |
| Msmdpp.dll                                                    | 2018.150.35.22  | 10062744  | 12-Jan-22 | 22:59 | x64      |
| Odbcdest.dll                                                  | 2019.150.4198.2 | 369544    | 12-Jan-22 | 22:59 | x64      |
| Odbcdest.dll                                                  | 2019.150.4198.2 | 316296    | 12-Jan-22 | 22:59 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4198.2 | 381832    | 12-Jan-22 | 22:59 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4198.2 | 329656    | 12-Jan-22 | 22:59 | x86      |
| Oledbdest.dll                                                 | 2019.150.4198.2 | 279424    | 12-Jan-22 | 22:59 | x64      |
| Oledbdest.dll                                                 | 2019.150.4198.2 | 239544    | 12-Jan-22 | 22:59 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4198.2 | 313272    | 12-Jan-22 | 22:59 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4198.2 | 264120    | 12-Jan-22 | 22:59 | x86      |
| Rawdest.dll                                                   | 2019.150.4198.2 | 226192    | 12-Jan-22 | 22:59 | x64      |
| Rawdest.dll                                                   | 2019.150.4198.2 | 189320    | 12-Jan-22 | 22:59 | x86      |
| Rawsource.dll                                                 | 2019.150.4198.2 | 209808    | 12-Jan-22 | 22:59 | x64      |
| Rawsource.dll                                                 | 2019.150.4198.2 | 177024    | 12-Jan-22 | 22:59 | x86      |
| Recordsetdest.dll                                             | 2019.150.4198.2 | 201616    | 12-Jan-22 | 22:59 | x64      |
| Recordsetdest.dll                                             | 2019.150.4198.2 | 172936    | 12-Jan-22 | 22:59 | x86      |
| Sqlceip.exe                                                   | 15.0.4198.2     | 291712    | 12-Jan-22 | 22:59 | x86      |
| Sqldest.dll                                                   | 2019.150.4198.2 | 275344    | 12-Jan-22 | 22:59 | x64      |
| Sqldest.dll                                                   | 2019.150.4198.2 | 238464    | 12-Jan-22 | 22:59 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4198.2 | 201616    | 12-Jan-22 | 22:59 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4198.2 | 169912    | 12-Jan-22 | 22:59 | x86      |
| Txagg.dll                                                     | 2019.150.4198.2 | 390016    | 12-Jan-22 | 22:59 | x64      |
| Txagg.dll                                                     | 2019.150.4198.2 | 329656    | 12-Jan-22 | 22:59 | x86      |
| Txbdd.dll                                                     | 2019.150.4198.2 | 189320    | 12-Jan-22 | 22:59 | x64      |
| Txbdd.dll                                                     | 2019.150.4198.2 | 152456    | 12-Jan-22 | 22:59 | x86      |
| Txbestmatch.dll                                               | 2019.150.4198.2 | 652160    | 12-Jan-22 | 22:59 | x64      |
| Txbestmatch.dll                                               | 2019.150.4198.2 | 545672    | 12-Jan-22 | 22:59 | x86      |
| Txcache.dll                                                   | 2019.150.4198.2 | 209808    | 12-Jan-22 | 22:59 | x64      |
| Txcache.dll                                                   | 2019.150.4198.2 | 164744    | 12-Jan-22 | 22:59 | x86      |
| Txcharmap.dll                                                 | 2019.150.4198.2 | 313272    | 12-Jan-22 | 22:59 | x64      |
| Txcharmap.dll                                                 | 2019.150.4198.2 | 271240    | 12-Jan-22 | 22:59 | x86      |
| Txcopymap.dll                                                 | 2019.150.4198.2 | 197520    | 12-Jan-22 | 22:59 | x64      |
| Txcopymap.dll                                                 | 2019.150.4198.2 | 164744    | 12-Jan-22 | 22:59 | x86      |
| Txdataconvert.dll                                             | 2019.150.4198.2 | 316304    | 12-Jan-22 | 22:59 | x64      |
| Txdataconvert.dll                                             | 2019.150.4198.2 | 275344    | 12-Jan-22 | 22:59 | x86      |
| Txderived.dll                                                 | 2019.150.4198.2 | 639888    | 12-Jan-22 | 22:59 | x64      |
| Txderived.dll                                                 | 2019.150.4198.2 | 559032    | 12-Jan-22 | 22:59 | x86      |
| Txfileextractor.dll                                           | 2019.150.4198.2 | 218000    | 12-Jan-22 | 22:59 | x64      |
| Txfileextractor.dll                                           | 2019.150.4198.2 | 181128    | 12-Jan-22 | 22:59 | x86      |
| Txfileinserter.dll                                            | 2019.150.4198.2 | 213888    | 12-Jan-22 | 22:59 | x64      |
| Txfileinserter.dll                                            | 2019.150.4198.2 | 181120    | 12-Jan-22 | 22:59 | x86      |
| Txgroupdups.dll                                               | 2019.150.4198.2 | 312200    | 12-Jan-22 | 22:59 | x64      |
| Txgroupdups.dll                                               | 2019.150.4198.2 | 254848    | 12-Jan-22 | 22:59 | x86      |
| Txlineage.dll                                                 | 2019.150.4198.2 | 152464    | 12-Jan-22 | 22:59 | x64      |
| Txlineage.dll                                                 | 2019.150.4198.2 | 127872    | 12-Jan-22 | 22:59 | x86      |
| Txlookup.dll                                                  | 2019.150.4198.2 | 541576    | 12-Jan-22 | 22:59 | x64      |
| Txlookup.dll                                                  | 2019.150.4198.2 | 468920    | 12-Jan-22 | 22:59 | x86      |
| Txmerge.dll                                                   | 2019.150.4198.2 | 246664    | 12-Jan-22 | 22:59 | x64      |
| Txmerge.dll                                                   | 2019.150.4198.2 | 201616    | 12-Jan-22 | 22:59 | x86      |
| Txmergejoin.dll                                               | 2019.150.4198.2 | 308104    | 12-Jan-22 | 22:59 | x64      |
| Txmergejoin.dll                                               | 2019.150.4198.2 | 247736    | 12-Jan-22 | 22:59 | x86      |
| Txmulticast.dll                                               | 2019.150.4198.2 | 148368    | 12-Jan-22 | 22:59 | x64      |
| Txmulticast.dll                                               | 2019.150.4198.2 | 116664    | 12-Jan-22 | 22:59 | x86      |
| Txpivot.dll                                                   | 2019.150.4198.2 | 239544    | 12-Jan-22 | 22:59 | x64      |
| Txpivot.dll                                                   | 2019.150.4198.2 | 205704    | 12-Jan-22 | 22:59 | x86      |
| Txrowcount.dll                                                | 2019.150.4198.2 | 140168    | 12-Jan-22 | 22:59 | x64      |
| Txrowcount.dll                                                | 2019.150.4198.2 | 111496    | 12-Jan-22 | 22:59 | x86      |
| Txsampling.dll                                                | 2019.150.4198.2 | 193408    | 12-Jan-22 | 22:59 | x64      |
| Txsampling.dll                                                | 2019.150.4198.2 | 156552    | 12-Jan-22 | 22:59 | x86      |
| Txscd.dll                                                     | 2019.150.4198.2 | 235448    | 12-Jan-22 | 22:59 | x64      |
| Txscd.dll                                                     | 2019.150.4198.2 | 197520    | 12-Jan-22 | 22:59 | x86      |
| Txsort.dll                                                    | 2019.150.4198.2 | 287624    | 12-Jan-22 | 22:59 | x64      |
| Txsort.dll                                                    | 2019.150.4198.2 | 230272    | 12-Jan-22 | 22:59 | x86      |
| Txsplit.dll                                                   | 2019.150.4198.2 | 624568    | 12-Jan-22 | 22:59 | x64      |
| Txsplit.dll                                                   | 2019.150.4198.2 | 549768    | 12-Jan-22 | 22:59 | x86      |
| Txtermextraction.dll                                          | 2019.150.4198.2 | 8700800   | 12-Jan-22 | 22:59 | x64      |
| Txtermextraction.dll                                          | 2019.150.4198.2 | 8643464   | 12-Jan-22 | 22:59 | x86      |
| Txtermlookup.dll                                              | 2019.150.4198.2 | 4182920   | 12-Jan-22 | 22:59 | x64      |
| Txtermlookup.dll                                              | 2019.150.4198.2 | 4137856   | 12-Jan-22 | 22:59 | x86      |
| Txunionall.dll                                                | 2019.150.4198.2 | 205712    | 12-Jan-22 | 22:59 | x64      |
| Txunionall.dll                                                | 2019.150.4198.2 | 161720    | 12-Jan-22 | 22:59 | x86      |
| Txunpivot.dll                                                 | 2019.150.4198.2 | 213904    | 12-Jan-22 | 22:59 | x64      |
| Txunpivot.dll                                                 | 2019.150.4198.2 | 181128    | 12-Jan-22 | 22:59 | x86      |
| Xe.dll                                                        | 2019.150.4198.2 | 631696    | 12-Jan-22 | 22:59 | x86      |
| Xe.dll                                                        | 2019.150.4198.2 | 721808    | 12-Jan-22 | 22:59 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 12-Jan-22 | 23:40 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 12-Jan-22 | 23:40 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 12-Jan-22 | 23:40 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 12-Jan-22 | 23:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 12-Jan-22 | 23:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 12-Jan-22 | 23:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 12-Jan-22 | 23:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 12-Jan-22 | 23:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 12-Jan-22 | 23:40 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 12-Jan-22 | 23:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 12-Jan-22 | 23:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 12-Jan-22 | 23:40 | x64      |
| Instapi150.dll                                                       | 2019.150.4198.2 | 86912     | 12-Jan-22 | 23:40 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 12-Jan-22 | 23:40 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 12-Jan-22 | 23:40 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 12-Jan-22 | 23:40 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 12-Jan-22 | 23:40 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 12-Jan-22 | 23:40 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 12-Jan-22 | 23:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 12-Jan-22 | 23:40 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4198.2 | 451464    | 12-Jan-22 | 23:40 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4198.2 | 7387064   | 12-Jan-22 | 23:40 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 12-Jan-22 | 23:40 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 12-Jan-22 | 23:40 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 12-Jan-22 | 23:40 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 12-Jan-22 | 23:40 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 12-Jan-22 | 23:40 | x64      |
| Secforwarder.dll                                                     | 2019.150.4198.2 | 78728     | 12-Jan-22 | 23:40 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 12-Jan-22 | 23:40 | x64      |
| Sqldk.dll                                                            | 2019.150.4198.2 | 3150736   | 12-Jan-22 | 23:40 | x64      |
| Sqldumper.exe                                                        | 2019.150.4198.2 | 186296    | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 1594240   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 4163512   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 3412864   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 4155320   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 4060032   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 2222008   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 2171784   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 3818376   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 3814280   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 1536896   | 12-Jan-22 | 23:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4198.2 | 4028344   | 12-Jan-22 | 23:40 | x64      |
| Sqlos.dll                                                            | 2019.150.4198.2 | 41864     | 12-Jan-22 | 23:40 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 12-Jan-22 | 23:40 | x64      |
| Sqltses.dll                                                          | 2019.150.4198.2 | 9114504   | 12-Jan-22 | 23:40 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 12-Jan-22 | 23:40 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 12-Jan-22 | 23:40 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 12-Jan-22 | 23:40 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4198.2  | 30648     | 12-Jan-22 | 22:58 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4198.2 | 1631104   | 12-Jan-22 | 23:15 | x86      |
| Dtaengine.exe                                                | 2019.150.4198.2 | 218000    | 12-Jan-22 | 23:15 | x86      |
| Dteparse.dll                                                 | 2019.150.4198.2 | 112568    | 12-Jan-22 | 23:15 | x86      |
| Dteparse.dll                                                 | 2019.150.4198.2 | 123784    | 12-Jan-22 | 23:15 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4198.2 | 115592    | 12-Jan-22 | 23:15 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4198.2 | 131984    | 12-Jan-22 | 23:15 | x64      |
| Dtepkg.dll                                                   | 2019.150.4198.2 | 131984    | 12-Jan-22 | 23:15 | x86      |
| Dtepkg.dll                                                   | 2019.150.4198.2 | 148368    | 12-Jan-22 | 23:15 | x64      |
| Dtexec.exe                                                   | 2019.150.4198.2 | 71568     | 12-Jan-22 | 23:15 | x64      |
| Dtexec.exe                                                   | 2019.150.4198.2 | 62864     | 12-Jan-22 | 23:15 | x86      |
| Dts.dll                                                      | 2019.150.4198.2 | 3142536   | 12-Jan-22 | 23:15 | x64      |
| Dts.dll                                                      | 2019.150.4198.2 | 2761616   | 12-Jan-22 | 23:15 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4198.2 | 444344    | 12-Jan-22 | 23:15 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4198.2 | 500608    | 12-Jan-22 | 23:15 | x64      |
| Dtsconn.dll                                                  | 2019.150.4198.2 | 522168    | 12-Jan-22 | 23:15 | x64      |
| Dtsconn.dll                                                  | 2019.150.4198.2 | 430992    | 12-Jan-22 | 23:15 | x86      |
| Dtshost.exe                                                  | 2019.150.4198.2 | 104328    | 12-Jan-22 | 23:15 | x64      |
| Dtshost.exe                                                  | 2019.150.4198.2 | 88504     | 12-Jan-22 | 23:15 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4198.2 | 553872    | 12-Jan-22 | 23:15 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4198.2 | 567224    | 12-Jan-22 | 23:15 | x64      |
| Dtspipeline.dll                                              | 2019.150.4198.2 | 1119104   | 12-Jan-22 | 23:15 | x86      |
| Dtspipeline.dll                                              | 2019.150.4198.2 | 1328016   | 12-Jan-22 | 23:15 | x64      |
| Dtswizard.exe                                                | 15.0.4198.2     | 885648    | 12-Jan-22 | 23:15 | x64      |
| Dtswizard.exe                                                | 15.0.4198.2     | 889744    | 12-Jan-22 | 23:15 | x86      |
| Dtuparse.dll                                                 | 2019.150.4198.2 | 86920     | 12-Jan-22 | 23:15 | x86      |
| Dtuparse.dll                                                 | 2019.150.4198.2 | 99216     | 12-Jan-22 | 23:15 | x64      |
| Dtutil.exe                                                   | 2019.150.4198.2 | 128912    | 12-Jan-22 | 23:15 | x86      |
| Dtutil.exe                                                   | 2019.150.4198.2 | 147344    | 12-Jan-22 | 23:15 | x64      |
| Exceldest.dll                                                | 2019.150.4198.2 | 279432    | 12-Jan-22 | 23:15 | x64      |
| Exceldest.dll                                                | 2019.150.4198.2 | 235448    | 12-Jan-22 | 23:15 | x86      |
| Excelsrc.dll                                                 | 2019.150.4198.2 | 260024    | 12-Jan-22 | 23:15 | x86      |
| Excelsrc.dll                                                 | 2019.150.4198.2 | 308104    | 12-Jan-22 | 23:15 | x64      |
| Flatfiledest.dll                                             | 2019.150.4198.2 | 410504    | 12-Jan-22 | 23:15 | x64      |
| Flatfiledest.dll                                             | 2019.150.4198.2 | 357248    | 12-Jan-22 | 23:15 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4198.2 | 369536    | 12-Jan-22 | 23:15 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4198.2 | 426888    | 12-Jan-22 | 23:15 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4198.2     | 115600    | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4198.2     | 403384    | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4198.2     | 2999184   | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4198.2     | 2999168   | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4198.2     | 41856     | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4198.2     | 41864     | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4198.2     | 59320     | 12-Jan-22 | 23:15 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 12-Jan-22 | 23:15 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4198.2 | 99208     | 12-Jan-22 | 23:15 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4198.2 | 111488    | 12-Jan-22 | 23:15 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.22  | 8278424   | 12-Jan-22 | 22:58 | x86      |
| Oledbdest.dll                                                | 2019.150.4198.2 | 239544    | 12-Jan-22 | 23:15 | x86      |
| Oledbdest.dll                                                | 2019.150.4198.2 | 279424    | 12-Jan-22 | 23:15 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4198.2 | 313272    | 12-Jan-22 | 23:15 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4198.2 | 264120    | 12-Jan-22 | 23:15 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4198.2 | 37760     | 12-Jan-22 | 23:15 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4198.2 | 50056     | 12-Jan-22 | 23:15 | x64      |
| Sqlscm.dll                                                   | 2019.150.4198.2 | 86928     | 12-Jan-22 | 23:15 | x64      |
| Sqlscm.dll                                                   | 2019.150.4198.2 | 78736     | 12-Jan-22 | 23:15 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4198.2 | 148368    | 12-Jan-22 | 23:15 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4198.2 | 181128    | 12-Jan-22 | 23:15 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4198.2 | 201616    | 12-Jan-22 | 23:15 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4198.2 | 169912    | 12-Jan-22 | 23:15 | x86      |
| Txdataconvert.dll                                            | 2019.150.4198.2 | 316304    | 12-Jan-22 | 23:15 | x64      |
| Txdataconvert.dll                                            | 2019.150.4198.2 | 275344    | 12-Jan-22 | 23:15 | x86      |
| Xe.dll                                                       | 2019.150.4198.2 | 631696    | 12-Jan-22 | 23:15 | x86      |
| Xe.dll                                                       | 2019.150.4198.2 | 721808    | 12-Jan-22 | 23:15 | x64      |

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
