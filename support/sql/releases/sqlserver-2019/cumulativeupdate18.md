---
title: Cumulative update 18 for SQL Server 2019 (KB5017593)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 18 (KB5017593).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5017593
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5017593 - Cumulative Update 18 for SQL Server 2019

_Release Date:_ &nbsp; September 28, 2022  
_Version:_ &nbsp; 15.0.4261.1

## Summary

This article describes Cumulative Update package 18 (CU18) for Microsoft SQL Server 2019. This update contains 20 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 17, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4261.1**, file version: **2019.150.4261.1**
- Analysis Services - Product version: **15.0.35.33**, file version: **2018.150.35.33**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="14939335">[14939335](#14939335)</a> | The installation of Microsoft SQL Server 2019 that uses the configuration file ignores the value for the `ASCOLLATION` parameter and falls back to the system default locale. </br></br>**Note**: If you don't apply this SQL Server cumulative update, you can use `-ASCOLLATION` on the command line or UI as a workaround. | Servicing Experience | SQL Server | Windows |
| <a id="14913295">[14913295](#14913295)</a> | Managed Backup fails intermittently because of the missing completion signal from the SQL Server Agent that causes backups for databases to stop. | SQL Server Engine | Backup Restore | Windows |
| <a id="14654911">[14654911](#14654911)</a> | The `READ_COMMITTED_SNAPSHOT` isolation level still requests the IS Object lock. Thus, unexpected blocking occurs on the string-type column that has the columnstore index. | SQL Server Engine | Column Stores | Windows |
| <a id="14654914">[14654914](#14654914)</a> | The `NOLOCK` hint still requests the IS Object lock. Thus, unexpected blocking occurs on the string-type column that has the columnstore index. | SQL Server Engine | Column Stores | Windows |
| <a id="14989385">[14989385](#14989385)</a> | The filegroup IDs of the files that belong to the clone database can be incorrect if the source database has gaps in the filegroup IDs due to the removal of files or filegroups. When you try to insert data into the table that belongs to the incorrectly generated clone database, you receive an error message that resembles the following message: </br></br>Msg 622, Level 16, State 3, Line \<LineNumber> </br>The filegroup "\<FileGroupName>" has no files assigned to it. Tables, indexes, text columns, ntext columns, and image columns cannot be populated on this filegroup until a file is added. | SQL Server Engine | DB Management | Windows |
| <a id="14964738">[14964738](#14964738)</a> | The FILESTREAM feature isn't enabled after you restart the operating system because of race conditions from multiple instances of SQL Server. In the error log, you can see the following error message: </br></br>Error: 5591, Severity: 16, State: 5. FILESTREAM feature is disabled. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="15029590">[15029590](#15029590)</a> | The Filestream RsFx driver may cause an access violation for `IRP_MJ_NETWORK_QUERY_OPEN` requests (Windows API `GetFileAttributes`), which may be triggered by a third-party application like McAfee Application Control on Windows 10. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="14982785">[14982785](#14982785)</a> | The assertion "Status.Prepared" can occur when you perform a cross-database transaction that involves a memory-optimized table. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14916804">[14916804](#14916804)</a> | Executing multiple SQL Server Agent jobs that use proxy accounts at the same time fails due to `BCryptDecrypt` issues. Additionally, one of the following errors occurs: </br></br>- Unable to start execution of step 1 (reason: Error authenticating proxy \<ProxyName>, system error: ConnGetProxyPassword).&nbsp;&nbsp;The step failed. </br></br>- BCryptDecrypt failed (-1073741762) </br>Unable to start execution of step 1 (reason: Error authenticating proxy \<ProxyName>, system error: The user name or password is incorrect.).&nbsp;&nbsp;The step failed. </br></br>**Note**: You may see this issue when the number of logical processors is high (larger than 32), and the concurrency jobs are also very high. | SQL Server Engine | Management Services | Windows |
| <a id="14993959">[14993959](#14993959)</a> | An application that's running at Read Committed Snapshot Isolation (RCSI) may not see data committed by an XA transaction. | SQL Server Engine | Methods to access stored data | All |
| <a id="14931025">[14931025](#14931025)</a> | Access violation dumps are generated sometimes when stored procedures that use the Scalar UDF Inlining feature are used. | SQL Server Engine | Programmability | Windows |
| <a id="14978498">[14978498](#14978498)</a> | [FIX: Access violation when you use the query_post_execution_plan_profile XEvent and reuse the same execution plan (KB5017718)](https://support.microsoft.com/help/5017718) | SQL Server Engine | Query Execution | All |
| <a id="14930792">[14930792](#14930792)</a> | In Microsoft SQL Server 2019 and 2017, an index creation over a persisted computed column and partition function fails. Additionally, the following error 8624 occurs: </br></br>Internal Query Processor Error: The query processor could not produce a query plan. For more information, contact Customer Support Services. | SQL Server Engine | Query Optimizer | Windows |
| <a id="1945560">[1945560](#1945560)</a> | [FIX: Changes aren't applied to a newly added article in a peer-to-peer topology with a custom port (KB5019307)](https://support.microsoft.com/help/5019307) | SQL Server Engine | Replication | Windows |
| <a id="1890457">[1890457](#1890457)</a> | Fixes a high CPU usage condition that occurs when you enable change tracking on a large number of tables and do automatic or manual cleanup of the change tracking tables. | SQL Server Engine | Replication | Windows |
| <a id="1926384">[1926384](#1926384)</a> | Transactional replication fails with errors 12300 and 12301 when the replication is enabled on memory optimized tables with computed columns and index on nullable columns respectively. | SQL Server Engine | Replication | Windows |
| <a id="14914170">[14914170](#14914170)</a> | You use the `sp_changereplicationserverpasswords` stored procedure to change the password of the Microsoft SQL Server login used by replication agents. It fails and causes the following error: </br></br>Msg 208, Level 16, State 1, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>Invalid object name 'MSreplservers'. | SQL Server Engine | Replication | Windows |
| <a id="14942316">[14942316](#14942316)</a> | High CPU usage occurs when you enable change tracking on a large number of tables and do automatic or manual cleanup of the change tracking tables. | SQL Server Engine | Replication | Windows |
| <a id="14987604">[14987604](#14987604)</a> | Error 9833 "Invalid data for UTF8-encoded characters" can occur in one of the following scenarios: </br></br>- You create a merge publication or merge push subscription on a publication database that has UTF-8 collations. </br></br>- You create a pull subscription to a merge publication, and either the publication database or subscription database has UTF-8 collations. | SQL Server Engine | Replication | Windows |
| <a id="14979551">[14979551](#14979551)</a> | [FIX: Installing SQL Server CUs may trigger IndexOutOfRangeException (KB5017551)](https://support.microsoft.com/help/5017551) | SQL Setup | Patching | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU18 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/09/sqlserver2019-kb5017593-x64_bd8ea599f044e3834b779bd99e8732a92ae869a8.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5017593-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5017593-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5017593-x64.exe| ED5B8C473A8FDA2EC0FCB6B2F7A861985FBB506D5C704748063A192E1D3E4478 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.33  | 292768    | 12-Sep-22 | 15:45 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 12-Sep-22 | 15:45 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.33      | 758192    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 175536    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 199600    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 202152    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 198576    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 214960    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 197552    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 193440    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 252320    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 174000    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 197024    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.33      | 1098680   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.33      | 567200    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 54720     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 59296     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 59824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58800     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 61872     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58296     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58288     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 67504     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 53680     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58288     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 18848     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 12-Sep-22 | 15:45 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 12-Sep-22 | 15:45 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 12-Sep-22 | 15:45 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 12-Sep-22 | 15:45 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 12-Sep-22 | 15:45 | x86      |
| Msmdctr.dll                                               | 2018.150.35.33  | 38320     | 12-Sep-22 | 15:45 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.33  | 66291632  | 12-Sep-22 | 15:45 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.33  | 47785376  | 12-Sep-22 | 15:45 | x86      |
| Msmdpump.dll                                              | 2018.150.35.33  | 10188728  | 12-Sep-22 | 15:45 | x64      |
| Msmdredir.dll                                             | 2018.150.35.33  | 7956928   | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 18336     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 12-Sep-22 | 15:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 12-Sep-22 | 15:45 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.33  | 65831328  | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 833440    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1628064   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1453984   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1642912   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1608608   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1001376   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 992672    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1536928   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1521568   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 810912    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1596320   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 832416    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1624480   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1450912   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1637792   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1604512   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 998816    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 991136    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1532832   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1517984   | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 809888    | 12-Sep-22 | 15:45 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1591712   | 12-Sep-22 | 15:45 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.33  | 10185640  | 12-Sep-22 | 15:45 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.33  | 8279472   | 12-Sep-22 | 15:45 | x86      |
| Msolap.dll                                                | 2018.150.35.33  | 11016112  | 12-Sep-22 | 15:45 | x64      |
| Msolap.dll                                                | 2018.150.35.33  | 8608160   | 12-Sep-22 | 15:45 | x86      |
| Msolui.dll                                                | 2018.150.35.33  | 306592    | 12-Sep-22 | 15:45 | x64      |
| Msolui.dll                                                | 2018.150.35.33  | 286112    | 12-Sep-22 | 15:45 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 12-Sep-22 | 15:45 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 12-Sep-22 | 15:45 | x64      |
| Sqlboot.dll                                               | 2019.150.4261.1 | 214944    | 12-Sep-22 | 15:45 | x64      |
| Sqlceip.exe                                               | 15.0.4261.1     | 292800    | 12-Sep-22 | 15:45 | x86      |
| Sqldumper.exe                                             | 2019.150.4261.1 | 153504    | 12-Sep-22 | 15:45 | x86      |
| Sqldumper.exe                                             | 2019.150.4261.1 | 186304    | 12-Sep-22 | 15:45 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 12-Sep-22 | 15:45 | x86      |
| Tmapi.dll                                                 | 2018.150.35.33  | 6178208   | 12-Sep-22 | 15:45 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.33  | 4917688   | 12-Sep-22 | 15:45 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.33  | 1184672   | 12-Sep-22 | 15:45 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.33  | 6806432   | 12-Sep-22 | 15:45 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.33  | 26025904  | 12-Sep-22 | 15:45 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.33  | 35460528  | 12-Sep-22 | 15:45 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4261.1 | 165792    | 12-Sep-22 | 15:45 | x86      |
| Batchparser.dll                      | 2019.150.4261.1 | 182192    | 12-Sep-22 | 15:45 | x64      |
| Instapi150.dll                       | 2019.150.4261.1 | 75680     | 12-Sep-22 | 15:45 | x86      |
| Instapi150.dll                       | 2019.150.4261.1 | 87968     | 12-Sep-22 | 15:45 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4261.1 | 100256    | 12-Sep-22 | 15:45 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4261.1 | 87968     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4261.1     | 550832    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4261.1     | 550840    | 12-Sep-22 | 15:45 | x86      |
| Msasxpress.dll                       | 2018.150.35.33  | 32160     | 12-Sep-22 | 15:45 | x64      |
| Msasxpress.dll                       | 2018.150.35.33  | 27072     | 12-Sep-22 | 15:45 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4261.1 | 75680     | 12-Sep-22 | 15:45 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4261.1 | 87984     | 12-Sep-22 | 15:45 | x64      |
| Sqldumper.exe                        | 2019.150.4261.1 | 153504    | 12-Sep-22 | 15:45 | x86      |
| Sqldumper.exe                        | 2019.150.4261.1 | 186304    | 12-Sep-22 | 15:45 | x64      |
| Sqlftacct.dll                        | 2019.150.4261.1 | 59320     | 12-Sep-22 | 15:45 | x86      |
| Sqlftacct.dll                        | 2019.150.4261.1 | 79776     | 12-Sep-22 | 15:45 | x64      |
| Sqlmanager.dll                       | 2019.150.4261.1 | 743344    | 12-Sep-22 | 15:45 | x86      |
| Sqlmanager.dll                       | 2019.150.4261.1 | 878512    | 12-Sep-22 | 15:45 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4261.1 | 432040    | 12-Sep-22 | 15:45 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4261.1 | 378792    | 12-Sep-22 | 15:45 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4261.1 | 276384    | 12-Sep-22 | 15:45 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4261.1 | 358304    | 12-Sep-22 | 15:45 | x64      |
| Svrenumapi150.dll                    | 2019.150.4261.1 | 911288    | 12-Sep-22 | 15:45 | x86      |
| Svrenumapi150.dll                    | 2019.150.4261.1 | 1161152   | 12-Sep-22 | 15:45 | x64      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4261.1 | 137144    | 12-Sep-22 | 15:46 | x86      |
| Dreplaycommon.dll     | 2019.150.4261.1 | 666552    | 12-Sep-22 | 15:46 | x86      |
| Dreplayutil.dll       | 2019.150.4261.1 | 305072    | 12-Sep-22 | 15:46 | x86      |
| Instapi150.dll        | 2019.150.4261.1 | 87968     | 12-Sep-22 | 15:45 | x64      |
| Sqlresourceloader.dll | 2019.150.4261.1 | 38832     | 12-Sep-22 | 15:45 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4261.1 | 666552    | 12-Sep-22 | 15:46 | x86      |
| Dreplaycontroller.exe | 2019.150.4261.1 | 366504    | 12-Sep-22 | 15:46 | x86      |
| Instapi150.dll        | 2019.150.4261.1 | 87968     | 12-Sep-22 | 15:46 | x64      |
| Sqlresourceloader.dll | 2019.150.4261.1 | 38832     | 12-Sep-22 | 15:46 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4261.1 | 4658080   | 12-Sep-22 | 16:50 | x64      |
| Aetm-enclave.dll                           | 2019.150.4261.1 | 4612504   | 12-Sep-22 | 16:50 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4261.1 | 4931896   | 12-Sep-22 | 16:50 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4261.1 | 4873536   | 12-Sep-22 | 16:50 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 12-Sep-22 | 16:50 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 12-Sep-22 | 16:50 | x64      |
| Batchparser.dll                            | 2019.150.4261.1 | 182192    | 12-Sep-22 | 16:50 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 12-Sep-22 | 16:50 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 12-Sep-22 | 16:50 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 12-Sep-22 | 16:50 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 12-Sep-22 | 16:50 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4261.1 | 280488    | 12-Sep-22 | 16:50 | x64      |
| Dcexec.exe                                 | 2019.150.4261.1 | 87968     | 12-Sep-22 | 16:50 | x64      |
| Fssres.dll                                 | 2019.150.4261.1 | 96168     | 12-Sep-22 | 16:50 | x64      |
| Hadrres.dll                                | 2019.150.4261.1 | 202656    | 12-Sep-22 | 16:50 | x64      |
| Hkcompile.dll                              | 2019.150.4261.1 | 1292224   | 12-Sep-22 | 16:50 | x64      |
| Hkengine.dll                               | 2019.150.4261.1 | 5789600   | 12-Sep-22 | 16:50 | x64      |
| Hkruntime.dll                              | 2019.150.4261.1 | 182176    | 12-Sep-22 | 16:50 | x64      |
| Hktempdb.dll                               | 2019.150.4261.1 | 63408     | 12-Sep-22 | 16:50 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 12-Sep-22 | 16:50 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4261.1     | 235432    | 12-Sep-22 | 16:50 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4261.1 | 325536    | 12-Sep-22 | 16:50 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4261.1 | 92064     | 12-Sep-22 | 16:50 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 12-Sep-22 | 16:50 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 12-Sep-22 | 16:50 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 12-Sep-22 | 16:50 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 12-Sep-22 | 16:50 | x64      |
| Qds.dll                                    | 2019.150.4261.1 | 1185704   | 12-Sep-22 | 16:50 | x64      |
| Rsfxft.dll                                 | 2019.150.4261.1 | 51112     | 12-Sep-22 | 16:50 | x64      |
| Secforwarder.dll                           | 2019.150.4261.1 | 79776     | 12-Sep-22 | 16:41 | x64      |
| Sqagtres.dll                               | 2019.150.4261.1 | 87968     | 12-Sep-22 | 16:50 | x64      |
| Sqlaamss.dll                               | 2019.150.4261.1 | 108472    | 12-Sep-22 | 16:50 | x64      |
| Sqlaccess.dll                              | 2019.150.4261.1 | 493496    | 12-Sep-22 | 16:50 | x64      |
| Sqlagent.exe                               | 2019.150.4261.1 | 731040    | 12-Sep-22 | 16:50 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4261.1 | 67512     | 12-Sep-22 | 16:50 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4261.1 | 79776     | 12-Sep-22 | 16:50 | x64      |
| Sqlboot.dll                                | 2019.150.4261.1 | 214944    | 12-Sep-22 | 16:50 | x64      |
| Sqlceip.exe                                | 15.0.4261.1     | 292800    | 12-Sep-22 | 16:50 | x86      |
| Sqlcmdss.dll                               | 2019.150.4261.1 | 87968     | 12-Sep-22 | 16:50 | x64      |
| Sqlctr150.dll                              | 2019.150.4261.1 | 116648    | 12-Sep-22 | 16:50 | x86      |
| Sqlctr150.dll                              | 2019.150.4261.1 | 141240    | 12-Sep-22 | 16:50 | x64      |
| Sqldk.dll                                  | 2019.150.4261.1 | 3155872   | 12-Sep-22 | 16:41 | x64      |
| Sqldtsss.dll                               | 2019.150.4261.1 | 108456    | 12-Sep-22 | 16:50 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 1595312   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3499960   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3696568   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4163512   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4282288   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3413920   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3581856   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4159392   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4011936   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4065184   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 2221984   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 2172832   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3868576   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3544992   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4016032   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3819424   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3819424   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3614624   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3499960   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 1537976   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 3909536   | 12-Sep-22 | 16:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4261.1 | 4028320   | 12-Sep-22 | 16:37 | x64      |
| Sqllang.dll                                | 2019.150.4261.1 | 39946144  | 12-Sep-22 | 16:50 | x64      |
| Sqlmin.dll                                 | 2019.150.4261.1 | 40554400  | 12-Sep-22 | 16:50 | x64      |
| Sqlolapss.dll                              | 2019.150.4261.1 | 104352    | 12-Sep-22 | 16:50 | x64      |
| Sqlos.dll                                  | 2019.150.4261.1 | 42936     | 12-Sep-22 | 16:41 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4261.1 | 83872     | 12-Sep-22 | 16:50 | x64      |
| Sqlrepss.dll                               | 2019.150.4261.1 | 83872     | 12-Sep-22 | 16:50 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4261.1 | 51128     | 12-Sep-22 | 16:50 | x64      |
| Sqlscm.dll                                 | 2019.150.4261.1 | 87984     | 12-Sep-22 | 16:50 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4261.1 | 38840     | 12-Sep-22 | 16:50 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4261.1 | 5806008   | 12-Sep-22 | 16:50 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4261.1 | 673720    | 12-Sep-22 | 16:50 | x64      |
| Sqlservr.exe                               | 2019.150.4261.1 | 628664    | 12-Sep-22 | 16:50 | x64      |
| Sqlsvc.dll                                 | 2019.150.4261.1 | 182176    | 12-Sep-22 | 16:50 | x64      |
| Sqltses.dll                                | 2019.150.4261.1 | 9119672   | 12-Sep-22 | 16:41 | x64      |
| Sqsrvres.dll                               | 2019.150.4261.1 | 280480    | 12-Sep-22 | 16:50 | x64      |
| Stretchcodegen.exe                         | 15.0.4261.1     | 59320     | 12-Sep-22 | 16:50 | x86      |
| Svl.dll                                    | 2019.150.4261.1 | 161696    | 12-Sep-22 | 16:50 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 12-Sep-22 | 16:50 | x64      |
| Xe.dll                                     | 2019.150.4261.1 | 722856    | 12-Sep-22 | 16:50 | x64      |
| Xpadsi.exe                                 | 2019.150.4261.1 | 116640    | 12-Sep-22 | 16:50 | x64      |
| Xplog70.dll                                | 2019.150.4261.1 | 92072     | 12-Sep-22 | 16:50 | x64      |
| Xpqueue.dll                                | 2019.150.4261.1 | 92064     | 12-Sep-22 | 16:50 | x64      |
| Xprepl.dll                                 | 2019.150.4261.1 | 120752    | 12-Sep-22 | 16:50 | x64      |
| Xpstar.dll                                 | 2019.150.4261.1 | 472992    | 12-Sep-22 | 16:50 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4261.1 | 182192    | 12-Sep-22 | 15:45 | x64      |
| Batchparser.dll                                              | 2019.150.4261.1 | 165792    | 12-Sep-22 | 15:45 | x86      |
| Commanddest.dll                                              | 2019.150.4261.1 | 264128    | 12-Sep-22 | 15:45 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4261.1 | 227248    | 12-Sep-22 | 15:45 | x64      |
| Distrib.exe                                                  | 2019.150.4261.1 | 235424    | 12-Sep-22 | 15:45 | x64      |
| Dteparse.dll                                                 | 2019.150.4261.1 | 124848    | 12-Sep-22 | 15:45 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4261.1 | 133024    | 12-Sep-22 | 15:45 | x64      |
| Dtepkg.dll                                                   | 2019.150.4261.1 | 149432    | 12-Sep-22 | 15:45 | x64      |
| Dtexec.exe                                                   | 2019.150.4261.1 | 72616     | 12-Sep-22 | 15:45 | x64      |
| Dts.dll                                                      | 2019.150.4261.1 | 3143608   | 12-Sep-22 | 15:45 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4261.1 | 501664    | 12-Sep-22 | 15:45 | x64      |
| Dtsconn.dll                                                  | 2019.150.4261.1 | 522144    | 12-Sep-22 | 15:45 | x64      |
| Dtshost.exe                                                  | 2019.150.4261.1 | 105376    | 12-Sep-22 | 15:45 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4261.1 | 567200    | 12-Sep-22 | 15:45 | x64      |
| Dtspipeline.dll                                              | 2019.150.4261.1 | 1329072   | 12-Sep-22 | 15:45 | x64      |
| Dtswizard.exe                                                | 15.0.4261.1     | 886688    | 12-Sep-22 | 15:45 | x64      |
| Dtuparse.dll                                                 | 2019.150.4261.1 | 100280    | 12-Sep-22 | 15:45 | x64      |
| Dtutil.exe                                                   | 2019.150.4261.1 | 148400    | 12-Sep-22 | 15:45 | x64      |
| Exceldest.dll                                                | 2019.150.4261.1 | 280504    | 12-Sep-22 | 15:45 | x64      |
| Excelsrc.dll                                                 | 2019.150.4261.1 | 309152    | 12-Sep-22 | 15:45 | x64      |
| Execpackagetask.dll                                          | 2019.150.4261.1 | 186296    | 12-Sep-22 | 15:45 | x64      |
| Flatfiledest.dll                                             | 2019.150.4261.1 | 411552    | 12-Sep-22 | 15:45 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4261.1 | 427952    | 12-Sep-22 | 15:45 | x64      |
| Logread.exe                                                  | 2019.150.4261.1 | 718752    | 12-Sep-22 | 15:45 | x64      |
| Mergetxt.dll                                                 | 2019.150.4261.1 | 75704     | 12-Sep-22 | 15:45 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4261.1     | 59320     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4261.1     | 42912     | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4261.1     | 391104    | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4261.1 | 1689504   | 12-Sep-22 | 15:45 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4261.1 | 1640352   | 12-Sep-22 | 15:45 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4261.1     | 550840    | 12-Sep-22 | 15:45 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4261.1 | 112560    | 12-Sep-22 | 15:45 | x64      |
| Msgprox.dll                                                  | 2019.150.4261.1 | 300968    | 12-Sep-22 | 15:45 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 12-Sep-22 | 15:45 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4261.1 | 1496992   | 12-Sep-22 | 15:45 | x64      |
| Oledbdest.dll                                                | 2019.150.4261.1 | 280496    | 12-Sep-22 | 15:45 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4261.1 | 313264    | 12-Sep-22 | 15:45 | x64      |
| Osql.exe                                                     | 2019.150.4261.1 | 92088     | 12-Sep-22 | 15:45 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4261.1 | 497584    | 12-Sep-22 | 15:45 | x64      |
| Rawdest.dll                                                  | 2019.150.4261.1 | 227248    | 12-Sep-22 | 15:45 | x64      |
| Rawsource.dll                                                | 2019.150.4261.1 | 210856    | 12-Sep-22 | 15:45 | x64      |
| Rdistcom.dll                                                 | 2019.150.4261.1 | 915376    | 12-Sep-22 | 15:45 | x64      |
| Recordsetdest.dll                                            | 2019.150.4261.1 | 202656    | 12-Sep-22 | 15:45 | x64      |
| Repldp.dll                                                   | 2019.150.4261.1 | 313264    | 12-Sep-22 | 15:45 | x64      |
| Replerrx.dll                                                 | 2019.150.4261.1 | 182184    | 12-Sep-22 | 15:45 | x64      |
| Replisapi.dll                                                | 2019.150.4261.1 | 395168    | 12-Sep-22 | 15:45 | x64      |
| Replmerg.exe                                                 | 2019.150.4261.1 | 563104    | 12-Sep-22 | 15:45 | x64      |
| Replprov.dll                                                 | 2019.150.4261.1 | 858016    | 12-Sep-22 | 15:45 | x64      |
| Replrec.dll                                                  | 2019.150.4261.1 | 1034144   | 12-Sep-22 | 15:45 | x64      |
| Replsub.dll                                                  | 2019.150.4261.1 | 472992    | 12-Sep-22 | 15:45 | x64      |
| Replsync.dll                                                 | 2019.150.4261.1 | 165808    | 12-Sep-22 | 15:45 | x64      |
| Spresolv.dll                                                 | 2019.150.4261.1 | 276392    | 12-Sep-22 | 15:45 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4261.1 | 264096    | 12-Sep-22 | 15:45 | x64      |
| Sqldiag.exe                                                  | 2019.150.4261.1 | 1140640   | 12-Sep-22 | 15:45 | x64      |
| Sqldistx.dll                                                 | 2019.150.4261.1 | 247720    | 12-Sep-22 | 15:45 | x64      |
| Sqllogship.exe                                               | 15.0.4261.1     | 104384    | 12-Sep-22 | 15:45 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4261.1 | 399264    | 12-Sep-22 | 15:45 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4261.1 | 38832     | 12-Sep-22 | 15:45 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4261.1 | 51128     | 12-Sep-22 | 15:45 | x64      |
| Sqlscm.dll                                                   | 2019.150.4261.1 | 79776     | 12-Sep-22 | 15:45 | x86      |
| Sqlscm.dll                                                   | 2019.150.4261.1 | 87984     | 12-Sep-22 | 15:45 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4261.1 | 149408    | 12-Sep-22 | 15:45 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4261.1 | 182176    | 12-Sep-22 | 15:45 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4261.1 | 202656    | 12-Sep-22 | 15:45 | x64      |
| Ssradd.dll                                                   | 2019.150.4261.1 | 83888     | 12-Sep-22 | 15:45 | x64      |
| Ssravg.dll                                                   | 2019.150.4261.1 | 83896     | 12-Sep-22 | 15:45 | x64      |
| Ssrdown.dll                                                  | 2019.150.4261.1 | 75696     | 12-Sep-22 | 15:45 | x64      |
| Ssrmax.dll                                                   | 2019.150.4261.1 | 83896     | 12-Sep-22 | 15:45 | x64      |
| Ssrmin.dll                                                   | 2019.150.4261.1 | 83896     | 12-Sep-22 | 15:45 | x64      |
| Ssrpub.dll                                                   | 2019.150.4261.1 | 75696     | 12-Sep-22 | 15:45 | x64      |
| Ssrup.dll                                                    | 2019.150.4261.1 | 75704     | 12-Sep-22 | 15:45 | x64      |
| Txagg.dll                                                    | 2019.150.4261.1 | 391072    | 12-Sep-22 | 15:45 | x64      |
| Txbdd.dll                                                    | 2019.150.4261.1 | 190376    | 12-Sep-22 | 15:45 | x64      |
| Txdatacollector.dll                                          | 2019.150.4261.1 | 473008    | 12-Sep-22 | 15:45 | x64      |
| Txdataconvert.dll                                            | 2019.150.4261.1 | 317344    | 12-Sep-22 | 15:45 | x64      |
| Txderived.dll                                                | 2019.150.4261.1 | 640944    | 12-Sep-22 | 15:45 | x64      |
| Txlookup.dll                                                 | 2019.150.4261.1 | 542632    | 12-Sep-22 | 15:45 | x64      |
| Txmerge.dll                                                  | 2019.150.4261.1 | 247728    | 12-Sep-22 | 15:45 | x64      |
| Txmergejoin.dll                                              | 2019.150.4261.1 | 309168    | 12-Sep-22 | 15:45 | x64      |
| Txmulticast.dll                                              | 2019.150.4261.1 | 145312    | 12-Sep-22 | 15:45 | x64      |
| Txrowcount.dll                                               | 2019.150.4261.1 | 141224    | 12-Sep-22 | 15:45 | x64      |
| Txsort.dll                                                   | 2019.150.4261.1 | 288672    | 12-Sep-22 | 15:45 | x64      |
| Txsplit.dll                                                  | 2019.150.4261.1 | 624544    | 12-Sep-22 | 15:45 | x64      |
| Txunionall.dll                                               | 2019.150.4261.1 | 198560    | 12-Sep-22 | 15:45 | x64      |
| Xe.dll                                                       | 2019.150.4261.1 | 722856    | 12-Sep-22 | 15:45 | x64      |
| Xmlsub.dll                                                   | 2019.150.4261.1 | 296880    | 12-Sep-22 | 15:45 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4261.1 | 92064     | 12-Sep-22 | 15:46 | x64      |
| Exthost.exe        | 2019.150.4261.1 | 239536    | 12-Sep-22 | 15:46 | x64      |
| Launchpad.exe      | 2019.150.4261.1 | 1222584   | 12-Sep-22 | 15:46 | x64      |
| Sqlsatellite.dll   | 2019.150.4261.1 | 1021856   | 12-Sep-22 | 15:46 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4261.1 | 685992    | 12-Sep-22 | 15:45 | x64      |
| Fdhost.exe     | 2019.150.4261.1 | 128960    | 12-Sep-22 | 15:45 | x64      |
| Fdlauncher.exe | 2019.150.4261.1 | 79800     | 12-Sep-22 | 15:45 | x64      |
| Sqlft150ph.dll | 2019.150.4261.1 | 92088     | 12-Sep-22 | 15:45 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4261.1  | 30624     | 12-Sep-22 | 15:45 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4261.1 | 227232    | 12-Sep-22 | 15:52 | x86      |
| Commanddest.dll                                               | 2019.150.4261.1 | 264128    | 12-Sep-22 | 15:53 | x64      |
| Dteparse.dll                                                  | 2019.150.4261.1 | 112552    | 12-Sep-22 | 15:52 | x86      |
| Dteparse.dll                                                  | 2019.150.4261.1 | 124848    | 12-Sep-22 | 15:53 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4261.1 | 133024    | 12-Sep-22 | 15:52 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4261.1 | 116648    | 12-Sep-22 | 15:52 | x86      |
| Dtepkg.dll                                                    | 2019.150.4261.1 | 133048    | 12-Sep-22 | 15:52 | x86      |
| Dtepkg.dll                                                    | 2019.150.4261.1 | 149432    | 12-Sep-22 | 15:53 | x64      |
| Dtexec.exe                                                    | 2019.150.4261.1 | 63928     | 12-Sep-22 | 15:52 | x86      |
| Dtexec.exe                                                    | 2019.150.4261.1 | 72616     | 12-Sep-22 | 15:53 | x64      |
| Dts.dll                                                       | 2019.150.4261.1 | 3143608   | 12-Sep-22 | 15:52 | x64      |
| Dts.dll                                                       | 2019.150.4261.1 | 2762656   | 12-Sep-22 | 15:53 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4261.1 | 444320    | 12-Sep-22 | 15:52 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4261.1 | 501664    | 12-Sep-22 | 15:53 | x64      |
| Dtsconn.dll                                                   | 2019.150.4261.1 | 522144    | 12-Sep-22 | 15:52 | x64      |
| Dtsconn.dll                                                   | 2019.150.4261.1 | 432032    | 12-Sep-22 | 15:53 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4261.1 | 93600     | 12-Sep-22 | 15:52 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4261.1 | 112032    | 12-Sep-22 | 15:53 | x64      |
| Dtshost.exe                                                   | 2019.150.4261.1 | 88480     | 12-Sep-22 | 15:52 | x86      |
| Dtshost.exe                                                   | 2019.150.4261.1 | 105376    | 12-Sep-22 | 15:53 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4261.1 | 554936    | 12-Sep-22 | 15:52 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4261.1 | 567200    | 12-Sep-22 | 15:52 | x64      |
| Dtspipeline.dll                                               | 2019.150.4261.1 | 1120176   | 12-Sep-22 | 15:52 | x86      |
| Dtspipeline.dll                                               | 2019.150.4261.1 | 1329072   | 12-Sep-22 | 15:53 | x64      |
| Dtswizard.exe                                                 | 15.0.4261.1     | 886688    | 12-Sep-22 | 15:53 | x64      |
| Dtswizard.exe                                                 | 15.0.4261.1     | 890808    | 12-Sep-22 | 15:53 | x86      |
| Dtuparse.dll                                                  | 2019.150.4261.1 | 100280    | 12-Sep-22 | 15:52 | x64      |
| Dtuparse.dll                                                  | 2019.150.4261.1 | 87992     | 12-Sep-22 | 15:53 | x86      |
| Dtutil.exe                                                    | 2019.150.4261.1 | 129976    | 12-Sep-22 | 15:52 | x86      |
| Dtutil.exe                                                    | 2019.150.4261.1 | 148400    | 12-Sep-22 | 15:52 | x64      |
| Exceldest.dll                                                 | 2019.150.4261.1 | 235424    | 12-Sep-22 | 15:53 | x86      |
| Exceldest.dll                                                 | 2019.150.4261.1 | 280504    | 12-Sep-22 | 15:53 | x64      |
| Excelsrc.dll                                                  | 2019.150.4261.1 | 260000    | 12-Sep-22 | 15:53 | x86      |
| Excelsrc.dll                                                  | 2019.150.4261.1 | 309152    | 12-Sep-22 | 15:53 | x64      |
| Execpackagetask.dll                                           | 2019.150.4261.1 | 186296    | 12-Sep-22 | 15:52 | x64      |
| Execpackagetask.dll                                           | 2019.150.4261.1 | 149400    | 12-Sep-22 | 15:52 | x86      |
| Flatfiledest.dll                                              | 2019.150.4261.1 | 411552    | 12-Sep-22 | 15:52 | x64      |
| Flatfiledest.dll                                              | 2019.150.4261.1 | 358304    | 12-Sep-22 | 15:52 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4261.1 | 427952    | 12-Sep-22 | 15:52 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4261.1 | 370608    | 12-Sep-22 | 15:53 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4261.1     | 120744    | 12-Sep-22 | 15:52 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4261.1     | 120744    | 12-Sep-22 | 15:53 | x86      |
| Isserverexec.exe                                              | 15.0.4261.1     | 149408    | 12-Sep-22 | 15:52 | x86      |
| Isserverexec.exe                                              | 15.0.4261.1     | 145328    | 12-Sep-22 | 15:52 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4261.1     | 116664    | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4261.1     | 59320     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4261.1     | 59304     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4261.1     | 509872    | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4261.1     | 509864    | 12-Sep-22 | 15:53 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4261.1     | 42912     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4261.1     | 42912     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4261.1     | 391104    | 12-Sep-22 | 15:53 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4261.1     | 59312     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4261.1     | 59304     | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4261.1     | 141240    | 12-Sep-22 | 15:52 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4261.1     | 141224    | 12-Sep-22 | 15:53 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4261.1     | 219064    | 12-Sep-22 | 15:53 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4261.1 | 100256    | 12-Sep-22 | 15:53 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4261.1 | 112560    | 12-Sep-22 | 15:53 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.33  | 10063800  | 12-Sep-22 | 15:45 | x64      |
| Odbcdest.dll                                                  | 2019.150.4261.1 | 370592    | 12-Sep-22 | 15:52 | x64      |
| Odbcdest.dll                                                  | 2019.150.4261.1 | 321440    | 12-Sep-22 | 15:53 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4261.1 | 329640    | 12-Sep-22 | 15:53 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4261.1 | 382888    | 12-Sep-22 | 15:53 | x64      |
| Oledbdest.dll                                                 | 2019.150.4261.1 | 280496    | 12-Sep-22 | 15:52 | x64      |
| Oledbdest.dll                                                 | 2019.150.4261.1 | 239528    | 12-Sep-22 | 15:53 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4261.1 | 264112    | 12-Sep-22 | 15:53 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4261.1 | 313264    | 12-Sep-22 | 15:53 | x64      |
| Rawdest.dll                                                   | 2019.150.4261.1 | 227248    | 12-Sep-22 | 15:52 | x64      |
| Rawdest.dll                                                   | 2019.150.4261.1 | 190368    | 12-Sep-22 | 15:53 | x86      |
| Rawsource.dll                                                 | 2019.150.4261.1 | 210856    | 12-Sep-22 | 15:52 | x64      |
| Rawsource.dll                                                 | 2019.150.4261.1 | 178096    | 12-Sep-22 | 15:52 | x86      |
| Recordsetdest.dll                                             | 2019.150.4261.1 | 202656    | 12-Sep-22 | 15:52 | x64      |
| Recordsetdest.dll                                             | 2019.150.4261.1 | 173984    | 12-Sep-22 | 15:53 | x86      |
| Sqlceip.exe                                                   | 15.0.4261.1     | 292800    | 12-Sep-22 | 15:45 | x86      |
| Sqldest.dll                                                   | 2019.150.4261.1 | 239536    | 12-Sep-22 | 15:52 | x86      |
| Sqldest.dll                                                   | 2019.150.4261.1 | 276384    | 12-Sep-22 | 15:53 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4261.1 | 169912    | 12-Sep-22 | 15:52 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4261.1 | 202656    | 12-Sep-22 | 15:52 | x64      |
| Txagg.dll                                                     | 2019.150.4261.1 | 329632    | 12-Sep-22 | 15:52 | x86      |
| Txagg.dll                                                     | 2019.150.4261.1 | 391072    | 12-Sep-22 | 15:53 | x64      |
| Txbdd.dll                                                     | 2019.150.4261.1 | 153520    | 12-Sep-22 | 15:52 | x86      |
| Txbdd.dll                                                     | 2019.150.4261.1 | 190376    | 12-Sep-22 | 15:53 | x64      |
| Txbestmatch.dll                                               | 2019.150.4261.1 | 653216    | 12-Sep-22 | 15:52 | x64      |
| Txbestmatch.dll                                               | 2019.150.4261.1 | 546720    | 12-Sep-22 | 15:53 | x86      |
| Txcache.dll                                                   | 2019.150.4261.1 | 198576    | 12-Sep-22 | 15:52 | x64      |
| Txcache.dll                                                   | 2019.150.4261.1 | 165792    | 12-Sep-22 | 15:53 | x86      |
| Txcharmap.dll                                                 | 2019.150.4261.1 | 313248    | 12-Sep-22 | 15:52 | x64      |
| Txcharmap.dll                                                 | 2019.150.4261.1 | 272304    | 12-Sep-22 | 15:53 | x86      |
| Txcopymap.dll                                                 | 2019.150.4261.1 | 165792    | 12-Sep-22 | 15:53 | x86      |
| Txcopymap.dll                                                 | 2019.150.4261.1 | 198560    | 12-Sep-22 | 15:53 | x64      |
| Txdataconvert.dll                                             | 2019.150.4261.1 | 276400    | 12-Sep-22 | 15:53 | x86      |
| Txdataconvert.dll                                             | 2019.150.4261.1 | 317344    | 12-Sep-22 | 15:53 | x64      |
| Txderived.dll                                                 | 2019.150.4261.1 | 559016    | 12-Sep-22 | 15:53 | x86      |
| Txderived.dll                                                 | 2019.150.4261.1 | 640944    | 12-Sep-22 | 15:53 | x64      |
| Txfileextractor.dll                                           | 2019.150.4261.1 | 219040    | 12-Sep-22 | 15:52 | x64      |
| Txfileextractor.dll                                           | 2019.150.4261.1 | 182192    | 12-Sep-22 | 15:53 | x86      |
| Txfileinserter.dll                                            | 2019.150.4261.1 | 182192    | 12-Sep-22 | 15:53 | x86      |
| Txfileinserter.dll                                            | 2019.150.4261.1 | 214960    | 12-Sep-22 | 15:53 | x64      |
| Txgroupdups.dll                                               | 2019.150.4261.1 | 255920    | 12-Sep-22 | 15:53 | x86      |
| Txgroupdups.dll                                               | 2019.150.4261.1 | 313256    | 12-Sep-22 | 15:53 | x64      |
| Txlineage.dll                                                 | 2019.150.4261.1 | 128936    | 12-Sep-22 | 15:52 | x86      |
| Txlineage.dll                                                 | 2019.150.4261.1 | 153520    | 12-Sep-22 | 15:53 | x64      |
| Txlookup.dll                                                  | 2019.150.4261.1 | 468912    | 12-Sep-22 | 15:53 | x86      |
| Txlookup.dll                                                  | 2019.150.4261.1 | 542632    | 12-Sep-22 | 15:53 | x64      |
| Txmerge.dll                                                   | 2019.150.4261.1 | 247728    | 12-Sep-22 | 15:52 | x64      |
| Txmerge.dll                                                   | 2019.150.4261.1 | 202672    | 12-Sep-22 | 15:53 | x86      |
| Txmergejoin.dll                                               | 2019.150.4261.1 | 309168    | 12-Sep-22 | 15:52 | x64      |
| Txmergejoin.dll                                               | 2019.150.4261.1 | 247728    | 12-Sep-22 | 15:53 | x86      |
| Txmulticast.dll                                               | 2019.150.4261.1 | 145312    | 12-Sep-22 | 15:52 | x64      |
| Txmulticast.dll                                               | 2019.150.4261.1 | 116656    | 12-Sep-22 | 15:53 | x86      |
| Txpivot.dll                                                   | 2019.150.4261.1 | 206768    | 12-Sep-22 | 15:52 | x86      |
| Txpivot.dll                                                   | 2019.150.4261.1 | 239520    | 12-Sep-22 | 15:53 | x64      |
| Txrowcount.dll                                                | 2019.150.4261.1 | 112576    | 12-Sep-22 | 15:53 | x86      |
| Txrowcount.dll                                                | 2019.150.4261.1 | 141224    | 12-Sep-22 | 15:53 | x64      |
| Txsampling.dll                                                | 2019.150.4261.1 | 157600    | 12-Sep-22 | 15:52 | x86      |
| Txsampling.dll                                                | 2019.150.4261.1 | 194464    | 12-Sep-22 | 15:52 | x64      |
| Txscd.dll                                                     | 2019.150.4261.1 | 198576    | 12-Sep-22 | 15:53 | x86      |
| Txscd.dll                                                     | 2019.150.4261.1 | 235432    | 12-Sep-22 | 15:53 | x64      |
| Txsort.dll                                                    | 2019.150.4261.1 | 288672    | 12-Sep-22 | 15:52 | x64      |
| Txsort.dll                                                    | 2019.150.4261.1 | 231328    | 12-Sep-22 | 15:53 | x86      |
| Txsplit.dll                                                   | 2019.150.4261.1 | 624544    | 12-Sep-22 | 15:52 | x64      |
| Txsplit.dll                                                   | 2019.150.4261.1 | 550824    | 12-Sep-22 | 15:53 | x86      |
| Txtermextraction.dll                                          | 2019.150.4261.1 | 8644520   | 12-Sep-22 | 15:53 | x86      |
| Txtermextraction.dll                                          | 2019.150.4261.1 | 8701864   | 12-Sep-22 | 15:53 | x64      |
| Txtermlookup.dll                                              | 2019.150.4261.1 | 4138912   | 12-Sep-22 | 15:53 | x86      |
| Txtermlookup.dll                                              | 2019.150.4261.1 | 4183968   | 12-Sep-22 | 15:53 | x64      |
| Txunionall.dll                                                | 2019.150.4261.1 | 198560    | 12-Sep-22 | 15:52 | x64      |
| Txunionall.dll                                                | 2019.150.4261.1 | 161720    | 12-Sep-22 | 15:53 | x86      |
| Txunpivot.dll                                                 | 2019.150.4261.1 | 182176    | 12-Sep-22 | 15:53 | x86      |
| Txunpivot.dll                                                 | 2019.150.4261.1 | 214944    | 12-Sep-22 | 15:53 | x64      |
| Xe.dll                                                        | 2019.150.4261.1 | 722856    | 12-Sep-22 | 15:52 | x64      |
| Xe.dll                                                        | 2019.150.4261.1 | 632736    | 12-Sep-22 | 15:52 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 12-Sep-22 | 16:42 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 12-Sep-22 | 16:42 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 12-Sep-22 | 16:42 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 12-Sep-22 | 16:42 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 12-Sep-22 | 16:42 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 12-Sep-22 | 16:42 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 12-Sep-22 | 16:42 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 12-Sep-22 | 16:42 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 12-Sep-22 | 16:42 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 12-Sep-22 | 16:42 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 12-Sep-22 | 16:42 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 12-Sep-22 | 16:42 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 12-Sep-22 | 16:42 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 12-Sep-22 | 16:42 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 12-Sep-22 | 16:42 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 12-Sep-22 | 16:42 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 12-Sep-22 | 16:42 | x64      |
| Instapi150.dll                                                       | 2019.150.4261.1 | 87968     | 12-Sep-22 | 16:42 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 12-Sep-22 | 16:42 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 12-Sep-22 | 16:42 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 12-Sep-22 | 16:42 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 12-Sep-22 | 16:42 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 12-Sep-22 | 16:42 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 12-Sep-22 | 16:42 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 12-Sep-22 | 16:42 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 12-Sep-22 | 16:42 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 12-Sep-22 | 16:42 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 12-Sep-22 | 16:42 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 12-Sep-22 | 16:42 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 12-Sep-22 | 16:42 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4261.1 | 452528    | 12-Sep-22 | 16:42 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4261.1 | 7399328   | 12-Sep-22 | 16:42 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 12-Sep-22 | 16:42 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 12-Sep-22 | 16:42 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 12-Sep-22 | 16:42 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 12-Sep-22 | 16:42 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 12-Sep-22 | 16:42 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 12-Sep-22 | 16:42 | x64      |
| Secforwarder.dll                                                     | 2019.150.4261.1 | 79776     | 12-Sep-22 | 16:42 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 12-Sep-22 | 16:42 | x64      |
| Sqldk.dll                                                            | 2019.150.4261.1 | 3155872   | 12-Sep-22 | 16:42 | x64      |
| Sqldumper.exe                                                        | 2019.150.4261.1 | 186304    | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 1595312   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 4163512   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 3413920   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 4159392   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 4065184   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 2221984   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 2172832   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 3819424   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 3819424   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 1537976   | 12-Sep-22 | 16:42 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4261.1 | 4028320   | 12-Sep-22 | 16:42 | x64      |
| Sqlos.dll                                                            | 2019.150.4261.1 | 42936     | 12-Sep-22 | 16:42 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 12-Sep-22 | 16:42 | x64      |
| Sqltses.dll                                                          | 2019.150.4261.1 | 9119672   | 12-Sep-22 | 16:42 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 12-Sep-22 | 16:42 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 12-Sep-22 | 16:42 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 12-Sep-22 | 16:42 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 12-Sep-22 | 16:42 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 12-Sep-22 | 16:42 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 12-Sep-22 | 16:42 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4261.1  | 30624     | 12-Sep-22 | 15:45 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4261.1 | 1632168   | 12-Sep-22 | 16:27 | x86      |
| Dtaengine.exe                                                | 2019.150.4261.1 | 219064    | 12-Sep-22 | 16:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4261.1 | 112552    | 12-Sep-22 | 16:26 | x86      |
| Dteparse.dll                                                 | 2019.150.4261.1 | 124848    | 12-Sep-22 | 16:26 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4261.1 | 133024    | 12-Sep-22 | 16:26 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4261.1 | 116648    | 12-Sep-22 | 16:27 | x86      |
| Dtepkg.dll                                                   | 2019.150.4261.1 | 149432    | 12-Sep-22 | 16:26 | x64      |
| Dtepkg.dll                                                   | 2019.150.4261.1 | 133048    | 12-Sep-22 | 16:27 | x86      |
| Dtexec.exe                                                   | 2019.150.4261.1 | 72616     | 12-Sep-22 | 16:26 | x64      |
| Dtexec.exe                                                   | 2019.150.4261.1 | 63928     | 12-Sep-22 | 16:27 | x86      |
| Dts.dll                                                      | 2019.150.4261.1 | 2762656   | 12-Sep-22 | 16:27 | x86      |
| Dts.dll                                                      | 2019.150.4261.1 | 3143608   | 12-Sep-22 | 16:27 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4261.1 | 444320    | 12-Sep-22 | 16:26 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4261.1 | 501664    | 12-Sep-22 | 16:26 | x64      |
| Dtsconn.dll                                                  | 2019.150.4261.1 | 522144    | 12-Sep-22 | 16:26 | x64      |
| Dtsconn.dll                                                  | 2019.150.4261.1 | 432032    | 12-Sep-22 | 16:27 | x86      |
| Dtshost.exe                                                  | 2019.150.4261.1 | 105376    | 12-Sep-22 | 16:26 | x64      |
| Dtshost.exe                                                  | 2019.150.4261.1 | 88480     | 12-Sep-22 | 16:26 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4261.1 | 567200    | 12-Sep-22 | 16:26 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4261.1 | 554936    | 12-Sep-22 | 16:27 | x86      |
| Dtspipeline.dll                                              | 2019.150.4261.1 | 1120176   | 12-Sep-22 | 16:27 | x86      |
| Dtspipeline.dll                                              | 2019.150.4261.1 | 1329072   | 12-Sep-22 | 16:27 | x64      |
| Dtswizard.exe                                                | 15.0.4261.1     | 886688    | 12-Sep-22 | 16:27 | x64      |
| Dtswizard.exe                                                | 15.0.4261.1     | 890808    | 12-Sep-22 | 16:27 | x86      |
| Dtuparse.dll                                                 | 2019.150.4261.1 | 100280    | 12-Sep-22 | 16:26 | x64      |
| Dtuparse.dll                                                 | 2019.150.4261.1 | 87992     | 12-Sep-22 | 16:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4261.1 | 129976    | 12-Sep-22 | 16:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4261.1 | 148400    | 12-Sep-22 | 16:27 | x64      |
| Exceldest.dll                                                | 2019.150.4261.1 | 235424    | 12-Sep-22 | 16:26 | x86      |
| Exceldest.dll                                                | 2019.150.4261.1 | 280504    | 12-Sep-22 | 16:26 | x64      |
| Excelsrc.dll                                                 | 2019.150.4261.1 | 260000    | 12-Sep-22 | 16:26 | x86      |
| Excelsrc.dll                                                 | 2019.150.4261.1 | 309152    | 12-Sep-22 | 16:26 | x64      |
| Flatfiledest.dll                                             | 2019.150.4261.1 | 358304    | 12-Sep-22 | 16:26 | x86      |
| Flatfiledest.dll                                             | 2019.150.4261.1 | 411552    | 12-Sep-22 | 16:26 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4261.1 | 370608    | 12-Sep-22 | 16:26 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4261.1 | 427952    | 12-Sep-22 | 16:26 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4261.1     | 116648    | 12-Sep-22 | 16:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4261.1     | 403360    | 12-Sep-22 | 16:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4261.1     | 403360    | 12-Sep-22 | 16:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4261.1     | 3004328   | 12-Sep-22 | 16:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4261.1     | 42912     | 12-Sep-22 | 16:26 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4261.1     | 59304     | 12-Sep-22 | 16:26 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 12-Sep-22 | 16:27 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4261.1 | 100256    | 12-Sep-22 | 16:26 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4261.1 | 112560    | 12-Sep-22 | 16:26 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.33  | 8279472   | 12-Sep-22 | 16:27 | x86      |
| Oledbdest.dll                                                | 2019.150.4261.1 | 239528    | 12-Sep-22 | 16:26 | x86      |
| Oledbdest.dll                                                | 2019.150.4261.1 | 280496    | 12-Sep-22 | 16:26 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4261.1 | 264112    | 12-Sep-22 | 16:26 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4261.1 | 313264    | 12-Sep-22 | 16:26 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4261.1 | 38832     | 12-Sep-22 | 16:26 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4261.1 | 51128     | 12-Sep-22 | 16:26 | x64      |
| Sqlscm.dll                                                   | 2019.150.4261.1 | 87984     | 12-Sep-22 | 16:27 | x64      |
| Sqlscm.dll                                                   | 2019.150.4261.1 | 79776     | 12-Sep-22 | 16:27 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4261.1 | 182176    | 12-Sep-22 | 16:27 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4261.1 | 149408    | 12-Sep-22 | 16:27 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4261.1 | 169912    | 12-Sep-22 | 16:27 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4261.1 | 202656    | 12-Sep-22 | 16:27 | x64      |
| Txdataconvert.dll                                            | 2019.150.4261.1 | 276400    | 12-Sep-22 | 16:27 | x86      |
| Txdataconvert.dll                                            | 2019.150.4261.1 | 317344    | 12-Sep-22 | 16:27 | x64      |
| Xe.dll                                                       | 2019.150.4261.1 | 632736    | 12-Sep-22 | 16:27 | x86      |
| Xe.dll                                                       | 2019.150.4261.1 | 722856    | 12-Sep-22 | 16:27 | x64      |

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
