---
title: Cumulative update 13 for SQL Server 2019 (KB5005679)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 13 (KB5005679).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5005679
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5005679 - Cumulative Update 13 for SQL Server 2019

_Release Date:_ &nbsp; October 05, 2021  
_Version:_ &nbsp; 15.0.4178.1

## Summary

This article describes Cumulative Update package 13 (CU13) for Microsoft SQL Server 2019. This update contains 19 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 12, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4178.1**, file version: **2019.150.4178.1**
- Analysis Services - Product version: **15.0.35.15**, file version: **2018.150.35.15**

## Known issues in this update

If a database in an Always On availability group has duplicate logical file names, either correct that situation or avoid using the automatic seeding functionality after you install SQL Server 2019 CU12.

This issue is fixed in [SQL Server 2019 CU14](cumulativeupdate14.md).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13981081">[13981081](#13981081)</a> | Fixes an issue where Integration Services packages start failing with the following error when you set `ExecuteOutOfProcess` property to `True`: </br></br>Data Flow Task: Error: The Oracle Source cannot run on the installed edition of Integration Services. It requires Enterprise Edition (64-bit) or higher | Integration Services | Integration Services | Windows |
| <a id="14194152">[14194152](#14194152)</a> | [FIX: Access violation occurs when you use FileTable feature with Windows Defender enabled (KB5005788)](https://support.microsoft.com/help/5005788) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="14182758">[14182758](#14182758)</a> | Fixes an issue where an incorrect name entry in `sys.servers` can result in Always On Availability Group (AG) replica being removed when the server name doesn't match Windows hostname. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14217780">[14217780](#14217780)</a> | Fixes an issue where the assertion results in system suspend of asynchronous secondary replica: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL Server Assertion: File: <"sql\\\ntdbms\\\storeng\\\dfs\\\trans\\\lsnlocmap.cpp">, line=\<LineNumber> Failed Assertion = 'curr->VlfSeqNo == prev->VlfSeqNo + 1'. This error may be timing-related. restart the server to ensure in-memory data structures are not corrupted | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14232813">[14232813](#14232813)</a> | Fixes an issue about extended event version in `Alwayson_health` session isn't changed automatically during Cumulative Update upgrade and downgrade. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14209346">[14209346](#14209346)</a> | Fixes an issue where Memory Optimized TempDB Metadata keeps consuming memory under `VARHEAP: LOB` Page Allocator. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14181146">[14181146](#14181146)</a> | Fixes an issue where you can't edit jobs by using SQL Server Management Studio (SSMS) if SQLAgent permissions are granted at AD group level. | SQL Server Engine | Linux | Linux |
| <a id="13952861">[13952861](#13952861)</a> | Fixes an intra-query deadlock that occurs with certain queries when verbose truncation feature is enabled. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="14190636">[14190636](#14190636)</a> | Fixes an issue where Polybase isn't generating the partition predicates for pushdown which generates the following error when you do cross-database joins in the backend where one or more of the tables is partitioned: </br></br>Msg 7320, Level \<LineNumber>, State 110, Line \<LineNumber> </br>Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". 105082;Generic ODBC error: [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]Invalid object name '$partition.PF_Polybase' | SQL Server Engine | PolyBase | All |
| <a id="14237645">[14237645](#14237645)</a> | [FIX: A dump occurs if you use the same synonym for a user-defined function in the view definition (KB5006359)](https://support.microsoft.com/help/5006359) | SQL Server Engine | Programmability | All |
| <a id="14239890">[14239890](#14239890)</a> | [Improvement: Last Writer Wins and support for P2P database in Availability Group (KB5006665)](https://support.microsoft.com/help/5006665) | SQL Server Engine | Replication | Windows |
| <a id="14243398">[14243398](#14243398)</a> | [FIX: An assertion dump occurs many times in SQL Server 2019 (KB5006632)](https://support.microsoft.com/help/5006632) | SQL Server Engine | Replication | Windows |
| <a id="14127274">[14127274](#14127274)</a> | Fixes an issue where 22836 error occurs when you add CDC job again after deleting CDC capture and removing jobs in SQL Server Agent. | SQL Server Engine | Replication | All |
| <a id="14178357">[14178357](#14178357)</a> | Adds `pOwnerSess` to the error message to find the owner session ID that runs the Log Reader Agent or log - related procedure in SQL Server 2017. | SQL Server Engine | Replication | Windows |
| <a id="14115230">[14115230](#14115230)</a> | Fixes an issue where AD Authentication in SQL Server BDC encounters an error "enctype aes256-cts found in keytab but cannot decrypt ticket" if support for 128-bit and 256-bit Kerberos AES encryption is enabled. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="14173307">[14173307](#14173307)</a> | [Improvement: Corrupted statistics can be detected by using extended_logical_checks in SQL Server 2016, 2017, and 2019 (KB4530907)](https://support.microsoft.com/help/4530907) | SQL Server Engine | Storage Management | Windows |
| <a id="14021172">[14021172](#14021172)</a> | Fixes an Access Violation that occurs in SQL Server 2019 when you attempt to add file to database that has backup in progress. | SQL Server Engine | Storage Management | Windows |
| <a id="14233210">[14233210](#14233210)</a> | Fixed an issue where resumable clustered index creation may sometimes fail if a table has lots of LOB columns. | SQL Server Engine | Table Index Partition | Windows |
| <a id="14218644">[14218644](#14218644)</a> | Fixes an issue where you can't complete image because the prepared instance is grayed out if you select [**Database Engine Services**] along with [**Machine Learning Services and Language Extensions**]- [**Java**] in Prepare Image. | SQL Setup | User Interface | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU13 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/10/sqlserver2019-kb5005679-x64_a6e4ec3e93be461565550973f8b8cdfdd5580967.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5005679-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5005679-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5005679-x64.exe| B5EC792CABFD905B8CFDF39F2F80F4CFC987D2BC87AEF1C7F682CF452ECF02EE |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.15  | 291744    | 23-Sep-21 | 17:22 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 23-Sep-21 | 17:28 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.15      | 757128    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 174496    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 198560    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 201120    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 197536    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 213920    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 196512    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 192416    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 251296    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 172960    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.15      | 196000    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.15      | 1097112   | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.15      | 479624    | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 53656     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 58256     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 58776     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57752     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 60824     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57248     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57232     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 66456     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 52624     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.15      | 57248     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16784     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 17816     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16800     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.15      | 16792     | 23-Sep-21 | 17:22 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 23-Sep-21 | 17:28 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 23-Sep-21 | 17:28 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 23-Sep-21 | 17:28 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 23-Sep-21 | 17:28 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 23-Sep-21 | 17:28 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 23-Sep-21 | 17:28 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 23-Sep-21 | 17:28 | x86      |
| Msmdctr.dll                                               | 2018.150.35.15  | 37280     | 23-Sep-21 | 17:22 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.15  | 66288024  | 23-Sep-21 | 17:22 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.15  | 47783320  | 23-Sep-21 | 17:22 | x86      |
| Msmdpump.dll                                              | 2018.150.35.15  | 10187656  | 23-Sep-21 | 17:22 | x64      |
| Msmdredir.dll                                             | 2018.150.35.15  | 7955864   | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15768     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16272     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 16280     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 17304     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15760     | 23-Sep-21 | 17:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.15      | 15760     | 23-Sep-21 | 17:22 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.15  | 65825176  | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 832400    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1627016   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1452952   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1641880   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1607576   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1000344   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 991632    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1535896   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1520520   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 809880    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.15  | 1595288   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 831384    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1623456   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1449888   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1636768   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1603472   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 997792    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 990104    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1531808   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1516960   | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 808856    | 23-Sep-21 | 17:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.15  | 1590680   | 23-Sep-21 | 17:22 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.15  | 10185120  | 23-Sep-21 | 17:22 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.15  | 8277912   | 23-Sep-21 | 17:22 | x86      |
| Msolap.dll                                                | 2018.150.35.15  | 11014552  | 23-Sep-21 | 17:22 | x64      |
| Msolap.dll                                                | 2018.150.35.15  | 8607136   | 23-Sep-21 | 17:22 | x86      |
| Msolui.dll                                                | 2018.150.35.15  | 305560    | 23-Sep-21 | 17:22 | x64      |
| Msolui.dll                                                | 2018.150.35.15  | 285064    | 23-Sep-21 | 17:22 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 23-Sep-21 | 17:28 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 23-Sep-21 | 17:28 | x64      |
| Sqlboot.dll                                               | 2019.150.4178.1 | 213904    | 23-Sep-21 | 17:27 | x64      |
| Sqlceip.exe                                               | 15.0.4178.1     | 291736    | 23-Sep-21 | 17:28 | x86      |
| Sqldumper.exe                                             | 2019.150.4178.1 | 152456    | 23-Sep-21 | 17:27 | x86      |
| Sqldumper.exe                                             | 2019.150.4178.1 | 185240    | 23-Sep-21 | 17:28 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 23-Sep-21 | 17:28 | x86      |
| Tmapi.dll                                                 | 2018.150.35.15  | 6177184   | 23-Sep-21 | 17:22 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.15  | 4916632   | 23-Sep-21 | 17:22 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.15  | 1183648   | 23-Sep-21 | 17:22 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.15  | 6805384   | 23-Sep-21 | 17:22 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.15  | 26024864  | 23-Sep-21 | 17:22 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.15  | 35459464  | 23-Sep-21 | 17:22 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4178.1 | 74640     | 23-Sep-21 | 17:32 | x86      |
| Instapi150.dll                       | 2019.150.4178.1 | 86912     | 23-Sep-21 | 17:32 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:32 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4178.1 | 99200     | 23-Sep-21 | 17:32 | x64      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4178.1     | 549760    | 23-Sep-21 | 17:32 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4178.1     | 549776    | 23-Sep-21 | 17:32 | x86      |
| Msasxpress.dll                       | 2018.150.35.15  | 31112     | 23-Sep-21 | 17:28 | x64      |
| Msasxpress.dll                       | 2018.150.35.15  | 26016     | 23-Sep-21 | 17:28 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4178.1 | 74624     | 23-Sep-21 | 17:32 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:32 | x64      |
| Sqldumper.exe                        | 2019.150.4178.1 | 152456    | 23-Sep-21 | 17:32 | x86      |
| Sqldumper.exe                        | 2019.150.4178.1 | 185240    | 23-Sep-21 | 17:32 | x64      |
| Sqlftacct.dll                        | 2019.150.4178.1 | 58240     | 23-Sep-21 | 17:32 | x86      |
| Sqlftacct.dll                        | 2019.150.4178.1 | 78728     | 23-Sep-21 | 17:32 | x64      |
| Sqlmanager.dll                       | 2019.150.4178.1 | 742272    | 23-Sep-21 | 17:32 | x86      |
| Sqlmanager.dll                       | 2019.150.4178.1 | 877448    | 23-Sep-21 | 17:32 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4178.1 | 377752    | 23-Sep-21 | 17:32 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4178.1 | 430992    | 23-Sep-21 | 17:32 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4178.1 | 275360    | 23-Sep-21 | 17:32 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4178.1 | 357264    | 23-Sep-21 | 17:32 | x64      |
| Svrenumapi150.dll                    | 2019.150.4178.1 | 1160096   | 23-Sep-21 | 17:32 | x64      |
| Svrenumapi150.dll                    | 2019.150.4178.1 | 910224    | 23-Sep-21 | 17:32 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4178.1 | 136072    | 23-Sep-21 | 17:28 | x86      |
| Dreplaycommon.dll     | 2019.150.4178.1 | 665488    | 23-Sep-21 | 17:28 | x86      |
| Dreplayutil.dll       | 2019.150.4178.1 | 304024    | 23-Sep-21 | 17:28 | x86      |
| Instapi150.dll        | 2019.150.4178.1 | 86912     | 23-Sep-21 | 17:27 | x64      |
| Sqlresourceloader.dll | 2019.150.4178.1 | 37760     | 23-Sep-21 | 17:27 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4178.1 | 665488    | 23-Sep-21 | 17:27 | x86      |
| Dreplaycontroller.exe | 2019.150.4178.1 | 365440    | 23-Sep-21 | 17:27 | x86      |
| Instapi150.dll        | 2019.150.4178.1 | 86912     | 23-Sep-21 | 17:22 | x64      |
| Sqlresourceloader.dll | 2019.150.4178.1 | 37760     | 23-Sep-21 | 17:27 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4178.1 | 4661656   | 23-Sep-21 | 18:19 | x64      |
| Aetm-enclave.dll                           | 2019.150.4178.1 | 4611480   | 23-Sep-21 | 18:19 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4178.1 | 4931336   | 23-Sep-21 | 18:19 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4178.1 | 4872472   | 23-Sep-21 | 18:19 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 23-Sep-21 | 18:19 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 23-Sep-21 | 18:19 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 23-Sep-21 | 18:19 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 23-Sep-21 | 18:19 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 23-Sep-21 | 18:19 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 23-Sep-21 | 18:19 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4178.1 | 279440    | 23-Sep-21 | 18:19 | x64      |
| Dcexec.exe                                 | 2019.150.4178.1 | 86944     | 23-Sep-21 | 18:19 | x64      |
| Fssres.dll                                 | 2019.150.4178.1 | 95120     | 23-Sep-21 | 18:19 | x64      |
| Hadrres.dll                                | 2019.150.4178.1 | 201616    | 23-Sep-21 | 18:19 | x64      |
| Hkcompile.dll                              | 2019.150.4178.1 | 1291152   | 23-Sep-21 | 18:19 | x64      |
| Hkengine.dll                               | 2019.150.4178.1 | 5784464   | 23-Sep-21 | 18:19 | x64      |
| Hkruntime.dll                              | 2019.150.4178.1 | 181144    | 23-Sep-21 | 18:19 | x64      |
| Hktempdb.dll                               | 2019.150.4178.1 | 62360     | 23-Sep-21 | 18:19 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 23-Sep-21 | 18:19 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4178.1     | 234400    | 23-Sep-21 | 18:19 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4178.1 | 324496    | 23-Sep-21 | 18:19 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4178.1 | 91040     | 23-Sep-21 | 18:19 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 23-Sep-21 | 18:19 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 23-Sep-21 | 18:19 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 23-Sep-21 | 18:19 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 23-Sep-21 | 18:19 | x64      |
| Qds.dll                                    | 2019.150.4178.1 | 1184656   | 23-Sep-21 | 18:19 | x64      |
| Rsfxft.dll                                 | 2019.150.4178.1 | 50064     | 23-Sep-21 | 18:19 | x64      |
| Secforwarder.dll                           | 2019.150.4178.1 | 78736     | 23-Sep-21 | 18:19 | x64      |
| Sqagtres.dll                               | 2019.150.4178.1 | 86912     | 23-Sep-21 | 18:19 | x64      |
| Sqlaamss.dll                               | 2019.150.4178.1 | 107408    | 23-Sep-21 | 18:19 | x64      |
| Sqlaccess.dll                              | 2019.150.4178.1 | 492416    | 23-Sep-21 | 18:19 | x64      |
| Sqlagent.exe                               | 2019.150.4178.1 | 730016    | 23-Sep-21 | 18:19 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4178.1 | 78736     | 23-Sep-21 | 18:19 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4178.1 | 66448     | 23-Sep-21 | 18:19 | x86      |
| Sqlboot.dll                                | 2019.150.4178.1 | 213904    | 23-Sep-21 | 18:19 | x64      |
| Sqlceip.exe                                | 15.0.4178.1     | 291736    | 23-Sep-21 | 18:19 | x86      |
| Sqlcmdss.dll                               | 2019.150.4178.1 | 86928     | 23-Sep-21 | 18:19 | x64      |
| Sqlctr150.dll                              | 2019.150.4178.1 | 115600    | 23-Sep-21 | 18:19 | x86      |
| Sqlctr150.dll                              | 2019.150.4178.1 | 140176    | 23-Sep-21 | 18:19 | x64      |
| Sqldk.dll                                  | 2019.150.4178.1 | 3150728   | 23-Sep-21 | 18:19 | x64      |
| Sqldtsss.dll                               | 2019.150.4178.1 | 107416    | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 1594256   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3498896   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3695504   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4162448   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4277136   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3412880   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3580816   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4154256   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4010880   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4060048   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 2220944   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 2171792   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3867536   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3543952   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4014992   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3818384   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3814288   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3609488   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3498896   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 1536912   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 3904400   | 23-Sep-21 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4178.1 | 4027280   | 23-Sep-21 | 18:19 | x64      |
| Sqllang.dll                                | 2019.150.4178.1 | 39965592  | 23-Sep-21 | 18:19 | x64      |
| Sqlmin.dll                                 | 2019.150.4178.1 | 40489352  | 23-Sep-21 | 18:19 | x64      |
| Sqlolapss.dll                              | 2019.150.4178.1 | 103312    | 23-Sep-21 | 18:19 | x64      |
| Sqlos.dll                                  | 2019.150.4178.1 | 41864     | 23-Sep-21 | 18:19 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4178.1 | 82832     | 23-Sep-21 | 18:19 | x64      |
| Sqlrepss.dll                               | 2019.150.4178.1 | 82832     | 23-Sep-21 | 18:19 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4178.1 | 50072     | 23-Sep-21 | 18:19 | x64      |
| Sqlscm.dll                                 | 2019.150.4178.1 | 86928     | 23-Sep-21 | 18:19 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4178.1 | 37776     | 23-Sep-21 | 18:19 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4178.1 | 5804944   | 23-Sep-21 | 18:19 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4178.1 | 672656    | 23-Sep-21 | 18:19 | x64      |
| Sqlservr.exe                               | 2019.150.4178.1 | 627600    | 23-Sep-21 | 18:19 | x64      |
| Sqlsvc.dll                                 | 2019.150.4178.1 | 181120    | 23-Sep-21 | 18:19 | x64      |
| Sqltses.dll                                | 2019.150.4178.1 | 9114512   | 23-Sep-21 | 18:19 | x64      |
| Sqsrvres.dll                               | 2019.150.4178.1 | 279440    | 23-Sep-21 | 18:19 | x64      |
| Svl.dll                                    | 2019.150.4178.1 | 160656    | 23-Sep-21 | 18:19 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 23-Sep-21 | 18:19 | x64      |
| Xe.dll                                     | 2019.150.4178.1 | 721816    | 23-Sep-21 | 18:19 | x64      |
| Xpadsi.exe                                 | 2019.150.4178.1 | 115600    | 23-Sep-21 | 18:19 | x64      |
| Xplog70.dll                                | 2019.150.4178.1 | 91024     | 23-Sep-21 | 18:19 | x64      |
| Xpqueue.dll                                | 2019.150.4178.1 | 91016     | 23-Sep-21 | 18:19 | x64      |
| Xprepl.dll                                 | 2019.150.4178.1 | 119696    | 23-Sep-21 | 18:19 | x64      |
| Xpstar.dll                                 | 2019.150.4178.1 | 471960    | 23-Sep-21 | 18:19 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4178.1 | 263064    | 23-Sep-21 | 17:28 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4178.1 | 230288    | 23-Sep-21 | 17:28 | x64      |
| Distrib.exe                                                  | 2019.150.4178.1 | 234384    | 23-Sep-21 | 17:28 | x64      |
| Dteparse.dll                                                 | 2019.150.4178.1 | 123808    | 23-Sep-21 | 17:27 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4178.1 | 132000    | 23-Sep-21 | 17:28 | x64      |
| Dtepkg.dll                                                   | 2019.150.4178.1 | 148368    | 23-Sep-21 | 17:28 | x64      |
| Dtexec.exe                                                   | 2019.150.4178.1 | 71568     | 23-Sep-21 | 17:27 | x64      |
| Dts.dll                                                      | 2019.150.4178.1 | 3142560   | 23-Sep-21 | 17:28 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4178.1 | 500624    | 23-Sep-21 | 17:28 | x64      |
| Dtsconn.dll                                                  | 2019.150.4178.1 | 521104    | 23-Sep-21 | 17:28 | x64      |
| Dtshost.exe                                                  | 2019.150.4178.1 | 104352    | 23-Sep-21 | 17:28 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4178.1 | 566160    | 23-Sep-21 | 17:27 | x64      |
| Dtspipeline.dll                                              | 2019.150.4178.1 | 1328016   | 23-Sep-21 | 17:28 | x64      |
| Dtswizard.exe                                                | 15.0.4178.1     | 885640    | 23-Sep-21 | 17:28 | x64      |
| Dtuparse.dll                                                 | 2019.150.4178.1 | 99200     | 23-Sep-21 | 17:28 | x64      |
| Dtutil.exe                                                   | 2019.150.4178.1 | 147344    | 23-Sep-21 | 17:28 | x64      |
| Exceldest.dll                                                | 2019.150.4178.1 | 279456    | 23-Sep-21 | 17:28 | x64      |
| Excelsrc.dll                                                 | 2019.150.4178.1 | 308120    | 23-Sep-21 | 17:28 | x64      |
| Execpackagetask.dll                                          | 2019.150.4178.1 | 185248    | 23-Sep-21 | 17:28 | x64      |
| Flatfiledest.dll                                             | 2019.150.4178.1 | 410512    | 23-Sep-21 | 17:28 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4178.1 | 426896    | 23-Sep-21 | 17:28 | x64      |
| Logread.exe                                                  | 2019.150.4178.1 | 717728    | 23-Sep-21 | 17:28 | x64      |
| Mergetxt.dll                                                 | 2019.150.4178.1 | 74656     | 23-Sep-21 | 17:27 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4178.1     | 58272     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4178.1     | 41872     | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4178.1     | 390016    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4178.1     | 549776    | 23-Sep-21 | 17:28 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4178.1 | 111488    | 23-Sep-21 | 17:28 | x64      |
| Msgprox.dll                                                  | 2019.150.4178.1 | 299904    | 23-Sep-21 | 17:28 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 23-Sep-21 | 17:27 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4178.1 | 1495952   | 23-Sep-21 | 17:27 | x64      |
| Oledbdest.dll                                                | 2019.150.4178.1 | 279448    | 23-Sep-21 | 17:28 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4178.1 | 312224    | 23-Sep-21 | 17:28 | x64      |
| Osql.exe                                                     | 2019.150.4178.1 | 91024     | 23-Sep-21 | 17:28 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4178.1 | 496512    | 23-Sep-21 | 17:28 | x64      |
| Rawdest.dll                                                  | 2019.150.4178.1 | 226192    | 23-Sep-21 | 17:28 | x64      |
| Rawsource.dll                                                | 2019.150.4178.1 | 209800    | 23-Sep-21 | 17:28 | x64      |
| Rdistcom.dll                                                 | 2019.150.4178.1 | 914328    | 23-Sep-21 | 17:28 | x64      |
| Recordsetdest.dll                                            | 2019.150.4178.1 | 201616    | 23-Sep-21 | 17:28 | x64      |
| Repldp.dll                                                   | 2019.150.4178.1 | 312192    | 23-Sep-21 | 17:28 | x64      |
| Replerrx.dll                                                 | 2019.150.4178.1 | 181136    | 23-Sep-21 | 17:27 | x64      |
| Replisapi.dll                                                | 2019.150.4178.1 | 394112    | 23-Sep-21 | 17:28 | x64      |
| Replmerg.exe                                                 | 2019.150.4178.1 | 562056    | 23-Sep-21 | 17:28 | x64      |
| Replprov.dll                                                 | 2019.150.4178.1 | 856960    | 23-Sep-21 | 17:28 | x64      |
| Replrec.dll                                                  | 2019.150.4178.1 | 1033120   | 23-Sep-21 | 17:27 | x64      |
| Replsub.dll                                                  | 2019.150.4178.1 | 471936    | 23-Sep-21 | 17:27 | x64      |
| Replsync.dll                                                 | 2019.150.4178.1 | 164752    | 23-Sep-21 | 17:27 | x64      |
| Spresolv.dll                                                 | 2019.150.4178.1 | 275344    | 23-Sep-21 | 17:27 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4178.1 | 263064    | 23-Sep-21 | 17:28 | x64      |
| Sqldiag.exe                                                  | 2019.150.4178.1 | 1139584   | 23-Sep-21 | 17:28 | x64      |
| Sqldistx.dll                                                 | 2019.150.4178.1 | 246672    | 23-Sep-21 | 17:27 | x64      |
| Sqllogship.exe                                               | 15.0.4178.1     | 103312    | 23-Sep-21 | 17:27 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4178.1 | 398240    | 23-Sep-21 | 17:28 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4178.1 | 37760     | 23-Sep-21 | 17:27 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4178.1 | 50072     | 23-Sep-21 | 17:27 | x64      |
| Sqlscm.dll                                                   | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:27 | x64      |
| Sqlscm.dll                                                   | 2019.150.4178.1 | 78728     | 23-Sep-21 | 17:28 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4178.1 | 181120    | 23-Sep-21 | 17:27 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4178.1 | 148376    | 23-Sep-21 | 17:28 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4178.1 | 201624    | 23-Sep-21 | 17:28 | x64      |
| Ssradd.dll                                                   | 2019.150.4178.1 | 82832     | 23-Sep-21 | 17:27 | x64      |
| Ssravg.dll                                                   | 2019.150.4178.1 | 82832     | 23-Sep-21 | 17:27 | x64      |
| Ssrdown.dll                                                  | 2019.150.4178.1 | 74640     | 23-Sep-21 | 17:27 | x64      |
| Ssrmax.dll                                                   | 2019.150.4178.1 | 82832     | 23-Sep-21 | 17:27 | x64      |
| Ssrmin.dll                                                   | 2019.150.4178.1 | 82832     | 23-Sep-21 | 17:27 | x64      |
| Ssrpub.dll                                                   | 2019.150.4178.1 | 74640     | 23-Sep-21 | 17:27 | x64      |
| Ssrup.dll                                                    | 2019.150.4178.1 | 74640     | 23-Sep-21 | 17:27 | x64      |
| Txagg.dll                                                    | 2019.150.4178.1 | 390040    | 23-Sep-21 | 17:28 | x64      |
| Txbdd.dll                                                    | 2019.150.4178.1 | 189344    | 23-Sep-21 | 17:28 | x64      |
| Txdatacollector.dll                                          | 2019.150.4178.1 | 471952    | 23-Sep-21 | 17:28 | x64      |
| Txdataconvert.dll                                            | 2019.150.4178.1 | 316304    | 23-Sep-21 | 17:28 | x64      |
| Txderived.dll                                                | 2019.150.4178.1 | 639888    | 23-Sep-21 | 17:28 | x64      |
| Txlookup.dll                                                 | 2019.150.4178.1 | 541600    | 23-Sep-21 | 17:28 | x64      |
| Txmerge.dll                                                  | 2019.150.4178.1 | 246672    | 23-Sep-21 | 17:28 | x64      |
| Txmergejoin.dll                                              | 2019.150.4178.1 | 308112    | 23-Sep-21 | 17:28 | x64      |
| Txmulticast.dll                                              | 2019.150.4178.1 | 144280    | 23-Sep-21 | 17:28 | x64      |
| Txrowcount.dll                                               | 2019.150.4178.1 | 140192    | 23-Sep-21 | 17:28 | x64      |
| Txsort.dll                                                   | 2019.150.4178.1 | 287648    | 23-Sep-21 | 17:28 | x64      |
| Txsplit.dll                                                  | 2019.150.4178.1 | 623504    | 23-Sep-21 | 17:28 | x64      |
| Txunionall.dll                                               | 2019.150.4178.1 | 197528    | 23-Sep-21 | 17:28 | x64      |
| Xe.dll                                                       | 2019.150.4178.1 | 721816    | 23-Sep-21 | 17:28 | x64      |
| Xmlsub.dll                                                   | 2019.150.4178.1 | 295824    | 23-Sep-21 | 17:27 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4178.1 | 91024     | 23-Sep-21 | 17:28 | x64      |
| Exthost.exe        | 2019.150.4178.1 | 238480    | 23-Sep-21 | 17:28 | x64      |
| Launchpad.exe      | 2019.150.4178.1 | 1217440   | 23-Sep-21 | 17:28 | x64      |
| Sqlsatellite.dll   | 2019.150.4178.1 | 1016720   | 23-Sep-21 | 17:28 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4178.1 | 684952    | 23-Sep-21 | 17:27 | x64      |
| Fdhost.exe     | 2019.150.4178.1 | 127904    | 23-Sep-21 | 17:27 | x64      |
| Fdlauncher.exe | 2019.150.4178.1 | 78736     | 23-Sep-21 | 17:27 | x64      |
| Sqlft150ph.dll | 2019.150.4178.1 | 91024     | 23-Sep-21 | 17:27 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4178.1  | 29584     | 23-Sep-21 | 17:27 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4178.1 | 263064    | 23-Sep-21 | 17:27 | x64      |
| Commanddest.dll                                               | 2019.150.4178.1 | 226192    | 23-Sep-21 | 17:28 | x86      |
| Dteparse.dll                                                  | 2019.150.4178.1 | 111504    | 23-Sep-21 | 17:28 | x86      |
| Dteparse.dll                                                  | 2019.150.4178.1 | 123808    | 23-Sep-21 | 17:28 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4178.1 | 132000    | 23-Sep-21 | 17:27 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4178.1 | 115600    | 23-Sep-21 | 17:28 | x86      |
| Dtepkg.dll                                                    | 2019.150.4178.1 | 131968    | 23-Sep-21 | 17:28 | x86      |
| Dtepkg.dll                                                    | 2019.150.4178.1 | 148368    | 23-Sep-21 | 17:28 | x64      |
| Dtexec.exe                                                    | 2019.150.4178.1 | 71568     | 23-Sep-21 | 17:28 | x64      |
| Dtexec.exe                                                    | 2019.150.4178.1 | 62848     | 23-Sep-21 | 17:28 | x86      |
| Dts.dll                                                       | 2019.150.4178.1 | 3142560   | 23-Sep-21 | 17:28 | x64      |
| Dts.dll                                                       | 2019.150.4178.1 | 2761616   | 23-Sep-21 | 17:28 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4178.1 | 500624    | 23-Sep-21 | 17:27 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4178.1 | 443280    | 23-Sep-21 | 17:28 | x86      |
| Dtsconn.dll                                                   | 2019.150.4178.1 | 521104    | 23-Sep-21 | 17:27 | x64      |
| Dtsconn.dll                                                   | 2019.150.4178.1 | 430992    | 23-Sep-21 | 17:28 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4178.1 | 111008    | 23-Sep-21 | 17:27 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4178.1 | 92560     | 23-Sep-21 | 17:28 | x86      |
| Dtshost.exe                                                   | 2019.150.4178.1 | 87440     | 23-Sep-21 | 17:28 | x86      |
| Dtshost.exe                                                   | 2019.150.4178.1 | 104352    | 23-Sep-21 | 17:28 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4178.1 | 566160    | 23-Sep-21 | 17:27 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4178.1 | 553872    | 23-Sep-21 | 17:28 | x86      |
| Dtspipeline.dll                                               | 2019.150.4178.1 | 1328016   | 23-Sep-21 | 17:28 | x64      |
| Dtspipeline.dll                                               | 2019.150.4178.1 | 1119104   | 23-Sep-21 | 17:28 | x86      |
| Dtswizard.exe                                                 | 15.0.4178.1     | 885640    | 23-Sep-21 | 17:28 | x64      |
| Dtswizard.exe                                                 | 15.0.4178.1     | 889744    | 23-Sep-21 | 17:28 | x86      |
| Dtuparse.dll                                                  | 2019.150.4178.1 | 99200     | 23-Sep-21 | 17:28 | x64      |
| Dtuparse.dll                                                  | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:28 | x86      |
| Dtutil.exe                                                    | 2019.150.4178.1 | 128912    | 23-Sep-21 | 17:28 | x86      |
| Dtutil.exe                                                    | 2019.150.4178.1 | 147344    | 23-Sep-21 | 17:28 | x64      |
| Exceldest.dll                                                 | 2019.150.4178.1 | 279456    | 23-Sep-21 | 17:27 | x64      |
| Exceldest.dll                                                 | 2019.150.4178.1 | 234384    | 23-Sep-21 | 17:28 | x86      |
| Excelsrc.dll                                                  | 2019.150.4178.1 | 308120    | 23-Sep-21 | 17:27 | x64      |
| Excelsrc.dll                                                  | 2019.150.4178.1 | 258960    | 23-Sep-21 | 17:28 | x86      |
| Execpackagetask.dll                                           | 2019.150.4178.1 | 185248    | 23-Sep-21 | 17:27 | x64      |
| Execpackagetask.dll                                           | 2019.150.4178.1 | 148368    | 23-Sep-21 | 17:27 | x86      |
| Flatfiledest.dll                                              | 2019.150.4178.1 | 410512    | 23-Sep-21 | 17:27 | x64      |
| Flatfiledest.dll                                              | 2019.150.4178.1 | 357264    | 23-Sep-21 | 17:28 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4178.1 | 426896    | 23-Sep-21 | 17:27 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4178.1 | 369552    | 23-Sep-21 | 17:28 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4178.1     | 119704    | 23-Sep-21 | 17:28 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4178.1     | 119688    | 23-Sep-21 | 17:28 | x86      |
| Isserverexec.exe                                              | 15.0.4178.1     | 144256    | 23-Sep-21 | 17:27 | x64      |
| Isserverexec.exe                                              | 15.0.4178.1     | 148352    | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4178.1     | 115592    | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4178.1     | 58272     | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4178.1     | 58264     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4178.1     | 508816    | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4178.1     | 508816    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4178.1     | 41872     | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4178.1     | 41856     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4178.1     | 390016    | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4178.1     | 58256     | 23-Sep-21 | 17:28 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4178.1     | 140160    | 23-Sep-21 | 17:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4178.1     | 140168    | 23-Sep-21 | 17:28 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4178.1     | 217984    | 23-Sep-21 | 17:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4178.1 | 111488    | 23-Sep-21 | 17:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4178.1 | 99216     | 23-Sep-21 | 17:28 | x86      |
| Msmdpp.dll                                                    | 2018.150.35.15  | 10062728  | 23-Sep-21 | 17:22 | x64      |
| Odbcdest.dll                                                  | 2019.150.4178.1 | 369552    | 23-Sep-21 | 17:27 | x64      |
| Odbcdest.dll                                                  | 2019.150.4178.1 | 316304    | 23-Sep-21 | 17:27 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4178.1 | 381840    | 23-Sep-21 | 17:27 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4178.1 | 328592    | 23-Sep-21 | 17:28 | x86      |
| Oledbdest.dll                                                 | 2019.150.4178.1 | 279448    | 23-Sep-21 | 17:27 | x64      |
| Oledbdest.dll                                                 | 2019.150.4178.1 | 238480    | 23-Sep-21 | 17:28 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4178.1 | 312224    | 23-Sep-21 | 17:27 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4178.1 | 263056    | 23-Sep-21 | 17:28 | x86      |
| Rawdest.dll                                                   | 2019.150.4178.1 | 226192    | 23-Sep-21 | 17:27 | x64      |
| Rawdest.dll                                                   | 2019.150.4178.1 | 189328    | 23-Sep-21 | 17:27 | x86      |
| Rawsource.dll                                                 | 2019.150.4178.1 | 209800    | 23-Sep-21 | 17:27 | x64      |
| Rawsource.dll                                                 | 2019.150.4178.1 | 177040    | 23-Sep-21 | 17:28 | x86      |
| Recordsetdest.dll                                             | 2019.150.4178.1 | 201616    | 23-Sep-21 | 17:27 | x64      |
| Recordsetdest.dll                                             | 2019.150.4178.1 | 172944    | 23-Sep-21 | 17:28 | x86      |
| Sqlceip.exe                                                   | 15.0.4178.1     | 291736    | 23-Sep-21 | 17:28 | x86      |
| Sqldest.dll                                                   | 2019.150.4178.1 | 275360    | 23-Sep-21 | 17:27 | x64      |
| Sqldest.dll                                                   | 2019.150.4178.1 | 238480    | 23-Sep-21 | 17:28 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4178.1 | 201624    | 23-Sep-21 | 17:27 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4178.1 | 168848    | 23-Sep-21 | 17:28 | x86      |
| Txagg.dll                                                     | 2019.150.4178.1 | 390040    | 23-Sep-21 | 17:27 | x64      |
| Txagg.dll                                                     | 2019.150.4178.1 | 328592    | 23-Sep-21 | 17:28 | x86      |
| Txbdd.dll                                                     | 2019.150.4178.1 | 189344    | 23-Sep-21 | 17:27 | x64      |
| Txbdd.dll                                                     | 2019.150.4178.1 | 156560    | 23-Sep-21 | 17:28 | x86      |
| Txbestmatch.dll                                               | 2019.150.4178.1 | 652176    | 23-Sep-21 | 17:27 | x64      |
| Txbestmatch.dll                                               | 2019.150.4178.1 | 545680    | 23-Sep-21 | 17:28 | x86      |
| Txcache.dll                                                   | 2019.150.4178.1 | 197520    | 23-Sep-21 | 17:27 | x64      |
| Txcache.dll                                                   | 2019.150.4178.1 | 172944    | 23-Sep-21 | 17:28 | x86      |
| Txcharmap.dll                                                 | 2019.150.4178.1 | 312208    | 23-Sep-21 | 17:27 | x64      |
| Txcharmap.dll                                                 | 2019.150.4178.1 | 271248    | 23-Sep-21 | 17:28 | x86      |
| Txcopymap.dll                                                 | 2019.150.4178.1 | 197520    | 23-Sep-21 | 17:27 | x64      |
| Txcopymap.dll                                                 | 2019.150.4178.1 | 172944    | 23-Sep-21 | 17:28 | x86      |
| Txdataconvert.dll                                             | 2019.150.4178.1 | 316304    | 23-Sep-21 | 17:27 | x64      |
| Txdataconvert.dll                                             | 2019.150.4178.1 | 275344    | 23-Sep-21 | 17:28 | x86      |
| Txderived.dll                                                 | 2019.150.4178.1 | 639888    | 23-Sep-21 | 17:27 | x64      |
| Txderived.dll                                                 | 2019.150.4178.1 | 557968    | 23-Sep-21 | 17:28 | x86      |
| Txfileextractor.dll                                           | 2019.150.4178.1 | 218008    | 23-Sep-21 | 17:27 | x64      |
| Txfileextractor.dll                                           | 2019.150.4178.1 | 181136    | 23-Sep-21 | 17:28 | x86      |
| Txfileinserter.dll                                            | 2019.150.4178.1 | 213904    | 23-Sep-21 | 17:27 | x64      |
| Txfileinserter.dll                                            | 2019.150.4178.1 | 181136    | 23-Sep-21 | 17:28 | x86      |
| Txgroupdups.dll                                               | 2019.150.4178.1 | 312224    | 23-Sep-21 | 17:27 | x64      |
| Txgroupdups.dll                                               | 2019.150.4178.1 | 254864    | 23-Sep-21 | 17:28 | x86      |
| Txlineage.dll                                                 | 2019.150.4178.1 | 152472    | 23-Sep-21 | 17:27 | x64      |
| Txlineage.dll                                                 | 2019.150.4178.1 | 127888    | 23-Sep-21 | 17:28 | x86      |
| Txlookup.dll                                                  | 2019.150.4178.1 | 541600    | 23-Sep-21 | 17:27 | x64      |
| Txlookup.dll                                                  | 2019.150.4178.1 | 467856    | 23-Sep-21 | 17:28 | x86      |
| Txmerge.dll                                                   | 2019.150.4178.1 | 246672    | 23-Sep-21 | 17:27 | x64      |
| Txmerge.dll                                                   | 2019.150.4178.1 | 205712    | 23-Sep-21 | 17:28 | x86      |
| Txmergejoin.dll                                               | 2019.150.4178.1 | 308112    | 23-Sep-21 | 17:27 | x64      |
| Txmergejoin.dll                                               | 2019.150.4178.1 | 246672    | 23-Sep-21 | 17:28 | x86      |
| Txmulticast.dll                                               | 2019.150.4178.1 | 144280    | 23-Sep-21 | 17:27 | x64      |
| Txmulticast.dll                                               | 2019.150.4178.1 | 119696    | 23-Sep-21 | 17:28 | x86      |
| Txpivot.dll                                                   | 2019.150.4178.1 | 238480    | 23-Sep-21 | 17:27 | x64      |
| Txpivot.dll                                                   | 2019.150.4178.1 | 205712    | 23-Sep-21 | 17:28 | x86      |
| Txrowcount.dll                                                | 2019.150.4178.1 | 140192    | 23-Sep-21 | 17:27 | x64      |
| Txrowcount.dll                                                | 2019.150.4178.1 | 115600    | 23-Sep-21 | 17:28 | x86      |
| Txsampling.dll                                                | 2019.150.4178.1 | 193432    | 23-Sep-21 | 17:27 | x64      |
| Txsampling.dll                                                | 2019.150.4178.1 | 160656    | 23-Sep-21 | 17:28 | x86      |
| Txscd.dll                                                     | 2019.150.4178.1 | 234400    | 23-Sep-21 | 17:27 | x64      |
| Txscd.dll                                                     | 2019.150.4178.1 | 197520    | 23-Sep-21 | 17:28 | x86      |
| Txsort.dll                                                    | 2019.150.4178.1 | 287648    | 23-Sep-21 | 17:27 | x64      |
| Txsort.dll                                                    | 2019.150.4178.1 | 230288    | 23-Sep-21 | 17:28 | x86      |
| Txsplit.dll                                                   | 2019.150.4178.1 | 623504    | 23-Sep-21 | 17:27 | x64      |
| Txsplit.dll                                                   | 2019.150.4178.1 | 549776    | 23-Sep-21 | 17:28 | x86      |
| Txtermextraction.dll                                          | 2019.150.4178.1 | 8700816   | 23-Sep-21 | 17:27 | x64      |
| Txtermextraction.dll                                          | 2019.150.4178.1 | 8643488   | 23-Sep-21 | 17:28 | x86      |
| Txtermlookup.dll                                              | 2019.150.4178.1 | 4182928   | 23-Sep-21 | 17:27 | x64      |
| Txtermlookup.dll                                              | 2019.150.4178.1 | 4137872   | 23-Sep-21 | 17:28 | x86      |
| Txunionall.dll                                                | 2019.150.4178.1 | 197528    | 23-Sep-21 | 17:27 | x64      |
| Txunionall.dll                                                | 2019.150.4178.1 | 160656    | 23-Sep-21 | 17:28 | x86      |
| Txunpivot.dll                                                 | 2019.150.4178.1 | 213920    | 23-Sep-21 | 17:27 | x64      |
| Txunpivot.dll                                                 | 2019.150.4178.1 | 181136    | 23-Sep-21 | 17:28 | x86      |
| Xe.dll                                                        | 2019.150.4178.1 | 631680    | 23-Sep-21 | 17:28 | x86      |
| Xe.dll                                                        | 2019.150.4178.1 | 721816    | 23-Sep-21 | 17:28 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 23-Sep-21 | 18:08 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 23-Sep-21 | 18:08 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 23-Sep-21 | 18:08 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 23-Sep-21 | 18:08 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 23-Sep-21 | 18:08 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 23-Sep-21 | 18:08 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 23-Sep-21 | 18:08 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 23-Sep-21 | 18:08 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 23-Sep-21 | 18:08 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 23-Sep-21 | 18:08 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 23-Sep-21 | 18:08 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 23-Sep-21 | 18:08 | x64      |
| Instapi150.dll                                                       | 2019.150.4178.1 | 86912     | 23-Sep-21 | 18:08 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 23-Sep-21 | 18:08 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 23-Sep-21 | 18:08 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 23-Sep-21 | 18:08 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 23-Sep-21 | 18:08 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 23-Sep-21 | 18:08 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 23-Sep-21 | 18:08 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 23-Sep-21 | 18:08 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4178.1 | 451472    | 23-Sep-21 | 18:08 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4178.1 | 7385984   | 23-Sep-21 | 18:08 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 23-Sep-21 | 18:08 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 23-Sep-21 | 18:08 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 23-Sep-21 | 18:08 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 23-Sep-21 | 18:08 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 23-Sep-21 | 18:08 | x64      |
| Secforwarder.dll                                                     | 2019.150.4178.1 | 78736     | 23-Sep-21 | 18:08 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 23-Sep-21 | 18:08 | x64      |
| Sqldk.dll                                                            | 2019.150.4178.1 | 3150728   | 23-Sep-21 | 18:08 | x64      |
| Sqldumper.exe                                                        | 2019.150.4178.1 | 185240    | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 1594256   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 4162448   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 3412880   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 4154256   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 4060048   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 2220944   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 2171792   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 3818384   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 3814288   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 1536912   | 23-Sep-21 | 18:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4178.1 | 4027280   | 23-Sep-21 | 18:08 | x64      |
| Sqlos.dll                                                            | 2019.150.4178.1 | 41864     | 23-Sep-21 | 18:08 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 23-Sep-21 | 18:08 | x64      |
| Sqltses.dll                                                          | 2019.150.4178.1 | 9114512   | 23-Sep-21 | 18:08 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 23-Sep-21 | 18:08 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 23-Sep-21 | 18:08 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 23-Sep-21 | 18:08 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4178.1  | 29584     | 23-Sep-21 | 17:28 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4178.1 | 1631112   | 23-Sep-21 | 17:55 | x86      |
| Dtaengine.exe                                                | 2019.150.4178.1 | 217984    | 23-Sep-21 | 17:55 | x86      |
| Dteparse.dll                                                 | 2019.150.4178.1 | 111504    | 23-Sep-21 | 17:55 | x86      |
| Dteparse.dll                                                 | 2019.150.4178.1 | 123808    | 23-Sep-21 | 17:55 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4178.1 | 115600    | 23-Sep-21 | 17:55 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4178.1 | 132000    | 23-Sep-21 | 17:55 | x64      |
| Dtepkg.dll                                                   | 2019.150.4178.1 | 131968    | 23-Sep-21 | 17:55 | x86      |
| Dtepkg.dll                                                   | 2019.150.4178.1 | 148368    | 23-Sep-21 | 17:55 | x64      |
| Dtexec.exe                                                   | 2019.150.4178.1 | 62848     | 23-Sep-21 | 17:55 | x86      |
| Dtexec.exe                                                   | 2019.150.4178.1 | 71568     | 23-Sep-21 | 17:55 | x64      |
| Dts.dll                                                      | 2019.150.4178.1 | 2761616   | 23-Sep-21 | 17:55 | x86      |
| Dts.dll                                                      | 2019.150.4178.1 | 3142560   | 23-Sep-21 | 17:55 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4178.1 | 443280    | 23-Sep-21 | 17:55 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4178.1 | 500624    | 23-Sep-21 | 17:55 | x64      |
| Dtsconn.dll                                                  | 2019.150.4178.1 | 430992    | 23-Sep-21 | 17:55 | x86      |
| Dtsconn.dll                                                  | 2019.150.4178.1 | 521104    | 23-Sep-21 | 17:55 | x64      |
| Dtshost.exe                                                  | 2019.150.4178.1 | 104352    | 23-Sep-21 | 17:55 | x64      |
| Dtshost.exe                                                  | 2019.150.4178.1 | 87440     | 23-Sep-21 | 17:55 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4178.1 | 553872    | 23-Sep-21 | 17:55 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4178.1 | 566160    | 23-Sep-21 | 17:55 | x64      |
| Dtspipeline.dll                                              | 2019.150.4178.1 | 1119104   | 23-Sep-21 | 17:55 | x86      |
| Dtspipeline.dll                                              | 2019.150.4178.1 | 1328016   | 23-Sep-21 | 17:55 | x64      |
| Dtswizard.exe                                                | 15.0.4178.1     | 885640    | 23-Sep-21 | 17:55 | x64      |
| Dtswizard.exe                                                | 15.0.4178.1     | 889744    | 23-Sep-21 | 17:55 | x86      |
| Dtuparse.dll                                                 | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:55 | x86      |
| Dtuparse.dll                                                 | 2019.150.4178.1 | 99200     | 23-Sep-21 | 17:55 | x64      |
| Dtutil.exe                                                   | 2019.150.4178.1 | 128912    | 23-Sep-21 | 17:55 | x86      |
| Dtutil.exe                                                   | 2019.150.4178.1 | 147344    | 23-Sep-21 | 17:55 | x64      |
| Exceldest.dll                                                | 2019.150.4178.1 | 234384    | 23-Sep-21 | 17:55 | x86      |
| Exceldest.dll                                                | 2019.150.4178.1 | 279456    | 23-Sep-21 | 17:55 | x64      |
| Excelsrc.dll                                                 | 2019.150.4178.1 | 258960    | 23-Sep-21 | 17:55 | x86      |
| Excelsrc.dll                                                 | 2019.150.4178.1 | 308120    | 23-Sep-21 | 17:55 | x64      |
| Flatfiledest.dll                                             | 2019.150.4178.1 | 357264    | 23-Sep-21 | 17:55 | x86      |
| Flatfiledest.dll                                             | 2019.150.4178.1 | 410512    | 23-Sep-21 | 17:55 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4178.1 | 369552    | 23-Sep-21 | 17:55 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4178.1 | 426896    | 23-Sep-21 | 17:55 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4178.1     | 115600    | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4178.1     | 402320    | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4178.1     | 402320    | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4178.1     | 2999184   | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4178.1     | 2999184   | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4178.1     | 41856     | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4178.1     | 41872     | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4178.1     | 58256     | 23-Sep-21 | 17:55 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 23-Sep-21 | 17:55 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4178.1 | 111488    | 23-Sep-21 | 17:55 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4178.1 | 99216     | 23-Sep-21 | 17:55 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.15  | 8277912   | 23-Sep-21 | 17:22 | x86      |
| Oledbdest.dll                                                | 2019.150.4178.1 | 238480    | 23-Sep-21 | 17:55 | x86      |
| Oledbdest.dll                                                | 2019.150.4178.1 | 279448    | 23-Sep-21 | 17:55 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4178.1 | 312224    | 23-Sep-21 | 17:55 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4178.1 | 263056    | 23-Sep-21 | 17:55 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4178.1 | 37760     | 23-Sep-21 | 17:55 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4178.1 | 50072     | 23-Sep-21 | 17:55 | x64      |
| Sqlscm.dll                                                   | 2019.150.4178.1 | 78728     | 23-Sep-21 | 17:55 | x86      |
| Sqlscm.dll                                                   | 2019.150.4178.1 | 86928     | 23-Sep-21 | 17:55 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4178.1 | 148376    | 23-Sep-21 | 17:55 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4178.1 | 181120    | 23-Sep-21 | 17:55 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4178.1 | 168848    | 23-Sep-21 | 17:55 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4178.1 | 201624    | 23-Sep-21 | 17:55 | x64      |
| Txdataconvert.dll                                            | 2019.150.4178.1 | 275344    | 23-Sep-21 | 17:55 | x86      |
| Txdataconvert.dll                                            | 2019.150.4178.1 | 316304    | 23-Sep-21 | 17:55 | x64      |
| Xe.dll                                                       | 2019.150.4178.1 | 631680    | 23-Sep-21 | 17:55 | x86      |
| Xe.dll                                                       | 2019.150.4178.1 | 721816    | 23-Sep-21 | 17:55 | x64      |

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
