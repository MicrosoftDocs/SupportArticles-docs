---
title: Cumulative update 4 for SQL Server 2022 (KB5026717)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 4 (KB5026717).
ms.date: 06/02/2023
ms.custom: KB5026717
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5026717 - Cumulative Update 4 for SQL Server 2022

_Release Date:_ &nbsp; May 11, 2023  
_Version:_ &nbsp; 16.0.4035.4

## Summary

This article describes Cumulative Update package 4 (CU4) for Microsoft SQL Server 2022. This update contains 21 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 3, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4035.4**, file version: **2022.160.4035.4**
- Analysis Services - Product version: **16.0.43.211**, file version: **2022.160.43.211**

## Known issues in this update

### Issue one

After you install this cumulative update, external data sources using the generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the Driver keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

### Issue two

After you install this cumulative update, you may receive incorrect results from queries that meet all of the following conditions:

1. You have indexes that explicitly specify a descending sort order. Here's an example:

    ```sql
    CREATE NONCLUSTERED INDEX [nci_table_column1] ON [dbo].[table1] (column1 DESC)
    ```

2. You run queries against tables that contain these indexes. These queries specify a sort order that matches the sort order of the indexes.

3. The sort column is used in query predicates in the `WHERE IN` clause or multiple equality clauses. Here's an example:

    ```sql
    SELECT * FROM [dbo].[table1] WHERE column1 IN (1,2) ORDER BY column1 DESC
    SELECT * FROM [dbo].[table1] WHERE column1 = 1 or column1 = 2 ORDER BY column1 DESC
    ```

    > [!NOTE]
    > The `IN` clause that has a single value doesn't have this issue.

To work around this issue, you can either uninstall this cumulative update or enable trace flag (TF) 13166 and then run `DBCC FREEPROCCACHE`.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|----------------------|----------|
| <a id="2305079">[2305079](#2305079)</a> | Fixes a `DateTime` issue where the month and day are incorrectly recognized in Master Data Services (MDS) that you encounter when the input format doesn't match the preset format. | Master Data Services | Master Data Services | Windows |
| <a id="2300365">[2300365](#2300365)</a> | Fixes an access violation issue, most often seen on a database in an availability group, that you encounter during virtual device interface (VDI) backups.| SQL Server Engine| Backup Restore | All |
| <a id="2299195">[2299195](#2299195)</a> | Fixes an issue where SQL Server Agent job steps fail with the following error after the management data warehouse (MDW) is configured on a server: </br></br>Executed as user: NT Service\SQLSERVERAGENT. SSIS error. Component name: GenerateTSQLPackageTask, Code: -1073548540, Subcomponent: Generate T-SQL Package Task, Description: An error occurred with the following error message: "The given key was not present in the dictionary.".&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;SSIS error. Component name: GenerateTSQLPackageTask, Code: -1073548540, Subcomponent: Generate T-SQL Package Task, Description: An error occurred with the following error message: "The given key was not present in the dictionary.".&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;The master package exited with error, previous error messages should explain the cause.&nbsp;&nbsp;Process Exit Code 5.&nbsp;&nbsp;The step failed. | SQL Server Engine | Management Services | All |
| <a id="2280423">[2280423](#2280423)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Execution | All |
| <a id="2306513">[2306513](#2306513)</a> | Fixes access violations and `INVALID_POINTER_READ_c0000005_sqlmin.dll!CProfileList::FGetPartitionSummaryXML` exceptions that you may encounter during the execution of `sys.dm_exec_query_plan_stats`. | SQL Server Engine | Query Execution | Windows |
| <a id="2306669">[2306669](#2306669)</a> | Fixes an issue where parameter sensitive plan (PSP) optimization produces a dispatcher expression but fails to create a query variant when an application attempts to use the `SET FMTONLY ON` T-SQL statement to return only metadata. | SQL Server Engine | Query Execution | All |
| <a id="2310201">[2310201](#2310201)</a> | Fixes an issue where running the `ALTER ASSEMBLY` command for a complex common language runtime (CLR) assembly can cause some of the other commands that are executed in parallel to time out. | SQL Server Engine | Query Execution | All |
| <a id="2329208">[2329208](#2329208)</a> | Fixes an issue where parameter sensitive plan (PSP) optimization can't successfully remove a query from the in-memory portion of the Query Store when PSP optimization has Query Store integration enabled. | SQL Server Engine | Query Execution| All |
| <a id="2344871">[2344871](#2344871)</a> | Adds two new trace flags (TF) to the automatic plan correction (APC) feature of automatic tuning. TF 12618 introduces a new plan regression detection model that includes multiple consecutive checks. TF 12656 introduces the ability to use a time-based plan regression check that will occur five minutes after a plan change is discovered, which avoids biasing the regression checks by queries that execute quickly. | SQL Server Engine | Query Execution | All |
| <a id="2344940">[2344940](#2344940)</a> | Fixes an access violation when parameter sensitive plan (PSP) optimization has Query Store integration enabled under certain conditions when query variants and dispatcher plans are being flushed from the in-memory portion of the Query Store data to disk. | SQL Server Engine | Query Execution | All |
| <a id="2344943">[2344943](#2344943)</a> | Fixes an access violation when parameter sensitive plan (PSP) optimization has Query Store integration enabled when an inconsistent state exists within the PSP-related Query Store. An improvement has also been made to the `sp_query_store_consistency_check` stored procedure, which will fix query variant and dispatch plan consistency issues. | SQL Server Engine | Query Execution | All|
| <a id="2344945">[2344945](#2344945)</a> | Fixes an issue when parameter sensitive plan (PSP) optimization has Query Store integration enabled when a dispatcher plan is removed from the Query Store. | SQL Server Engine | Query Execution | All |
| <a id="2278800">[2278800](#2278800)</a> | Fixes an issue where incorrect results are returned when you use the `LAG` or `LEAD` window functions while using the `IGNORE NULLS` clause. | SQL Server Engine | Query Optimizer | All |
| <a id="2297428">[2297428](#2297428)</a> | Fixes an issue where the `KILL STATS JOB` process leaks reference counts on some items when multiple asynchronous statistics jobs are running, which causes those items to remain in the queue (visible via `sys.dm_exec_background_job_queue`) until the SQL Server instance is restarted. | SQL Server Engine | Query Optimizer | All |
| <a id="2307893">[2307893](#2307893)</a> | Fixes incorrect results for queries that filter on `ROW_NUMBER` and involve nullable columns. | SQL Server Engine | Query Optimizer | All |
| <a id="2313621">[2313621](#2313621)</a> | Fixes the following errors and access violations that are caused by an incorrect plan in the case of multiple occurrences of the same scalar subquery: </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command.&nbsp;&nbsp;The results, if any, should be discarded. | SQL Server Engine | Query Optimizer | All |
| <a id="2343788">[2343788](#2343788)</a> | Fixes a memory leak issue in the Cardinality Estimation (CE) feedback when an OOM (Out of Memory) error occurs in a constructor function. | SQL Server Engine | Query Optimizer | All |
| <a id="2303424">[2303424](#2303424)</a> | Fixes an issue that prevents you from dropping table groups on a database that has Azure Synapse Link enabled and the collation is set to `Latin1_General_BIN2`. | SQL Server Engine | Replication | All |
| <a id="2335976">[2335976](#2335976)</a> | Fixes an issue where error 22836 occurs when you add the change data capture (CDC) job again after deleting CDC capture and removing a job in SQL Server Agent. | SQL Server Engine | Replication | All |
| <a id="2312111">[2312111](#2312111)</a> | [FIX: Errors occur after you apply a cumulative update to an instance of SQL Server that has a contained availability group (KB5027331)](errors-apply-cu-contained-availability-group.md) | SQL Server Engine | SQL Agent | All |
| <a id="2329148">[2329148](#2329148)</a> | Fixes an issue where the SQL Server service on Linux exits with an unsuccessful code when you request to stop it. | SQL Server Engine | SQL Server Engine | Linux |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU4 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/05/sqlserver2022-kb5026717-x64_d6abee2fc65b806a2db2dc77590ddda77f6fa79d.exe)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5026717-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5026717-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5026717-x64.exe| 110B1B51DD804FD53315A4FEB58E90A3273AC08750CD3A3396C38B300D228B99 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |   Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.211 | 336848    | 1-May-23 | 11:06 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.211     | 2903504   | 1-May-23 | 11:06 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 1-May-23 | 11:06 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 1-May-23 | 11:06 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 1-May-23 | 11:06 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 1-May-23 | 11:06 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 1-May-23 | 11:06 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 1-May-23 | 11:06 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 1-May-23 | 11:06 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 1-May-23 | 11:06 | x86      |
| Msmdctr.dll                                         | 2022.160.43.211 | 38864     | 1-May-23 | 11:06 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 53921192  | 1-May-23 | 11:06 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 71759272  | 1-May-23 | 11:06 | x64      |
| Msmdpump.dll                                        | 2022.160.43.211 | 10335184  | 1-May-23 | 11:06 | x64      |
| Msmdredir.dll                                       | 2022.160.43.211 | 8132048   | 1-May-23 | 11:06 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.211 | 71316392  | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 954792    | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1882576   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1669536   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1878952   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1846176   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1145256   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1138088   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1767336   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1746856   | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 930728    | 1-May-23 | 11:06 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1835432   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 953256    | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1880488   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1666472   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1874344   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1842600   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1143208   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1136552   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1763752   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1743272   | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 931240    | 1-May-23 | 11:06 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1830824   | 1-May-23 | 11:06 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 10083792  | 1-May-23 | 11:06 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 8265640   | 1-May-23 | 11:06 | x86      |
| Msolap.dll                                          | 2022.160.43.211 | 10970064  | 1-May-23 | 11:06 | x64      |
| Msolap.dll                                          | 2022.160.43.211 | 8744912   | 1-May-23 | 11:06 | x86      |
| Msolui.dll                                          | 2022.160.43.211 | 308136    | 1-May-23 | 11:06 | x64      |
| Msolui.dll                                          | 2022.160.43.211 | 289744    | 1-May-23 | 11:06 | x86      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 1-May-23 | 11:06 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 1-May-23 | 11:06 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4035.4 | 137104    | 1-May-23 | 11:06 | x64      |
| Sqlceip.exe                                         | 16.0.4035.4     | 300960    | 1-May-23 | 11:07 | x86      |
| Sqldumper.exe                                       | 2022.160.4035.4 | 227216    | 1-May-23 | 11:07 | x86      |
| Sqldumper.exe                                       | 2022.160.4035.4 | 260032    | 1-May-23 | 11:07 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 1-May-23 | 11:06 | x86      |
| Tmapi.dll                                           | 2022.160.43.211 | 5884368   | 1-May-23 | 11:06 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.211 | 5575120   | 1-May-23 | 11:06 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.211 | 1481168   | 1-May-23 | 11:06 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.211 | 7197648   | 1-May-23 | 11:06 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 26594256  | 1-May-23 | 11:06 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 35895720  | 1-May-23 | 11:06 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4035.4 | 104336    | 1-May-23 | 11:07 | x64      |
| Instapi150.dll                             | 2022.160.4035.4 | 79760     | 1-May-23 | 11:07 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633680   | 1-May-23 | 11:07 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633640   | 1-May-23 | 11:07 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.211     | 2933152   | 1-May-23 | 11:07 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323408   | 1-May-23 | 11:07 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323368   | 1-May-23 | 11:07 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4035.4     | 554912    | 1-May-23 | 11:07 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4035.4     | 554944    | 1-May-23 | 11:07 | x86      |
| Msasxpress.dll                             | 2022.160.43.211 | 32720     | 1-May-23 | 11:07 | x64      |
| Msasxpress.dll                             | 2022.160.43.211 | 27600     | 1-May-23 | 11:07 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4035.4 | 137104    | 1-May-23 | 11:07 | x64      |
| Sqldumper.exe                              | 2022.160.4035.4 | 260032    | 1-May-23 | 11:07 | x64      |
| Sqldumper.exe                              | 2022.160.4035.4 | 227216    | 1-May-23 | 11:07 | x86      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |   Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4035.4     | 2066336   | 1-May-23 | 11:07 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4035.4 | 137104    | 1-May-23 | 11:07 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |   Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4035.4  | 599952    | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4035.4  | 599968    | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4035.4  | 173984    | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4035.4  | 174032    | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4035.4  | 1857440   | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4035.4  | 1857472   | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4035.4  | 370576    | 1-May-23 | 11:07 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4035.4  | 370640    | 1-May-23 | 11:07 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |   Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4035.4 | 4718992   | 1-May-23 | 12:22 | x64      |
| Aetm-enclave.dll                             | 2022.160.4035.4 | 4673464   | 1-May-23 | 12:22 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4035.4 | 4909136   | 1-May-23 | 12:22 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4035.4 | 4874496   | 1-May-23 | 12:22 | x64      |
| Hadrres.dll                                  | 2022.160.4035.4 | 227280    | 1-May-23 | 12:22 | x64      |
| Hkcompile.dll                                | 2022.160.4035.4 | 1411024   | 1-May-23 | 12:22 | x64      |
| Hkengine.dll                                 | 2022.160.4035.4 | 5760912   | 1-May-23 | 12:22 | x64      |
| Hkruntime.dll                                | 2022.160.4035.4 | 190400    | 1-May-23 | 12:22 | x64      |
| Hktempdb.dll                                 | 2022.160.4035.4 | 71584     | 1-May-23 | 12:22 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.211     | 2322384   | 1-May-23 | 12:22 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4035.4 | 333728    | 1-May-23 | 12:22 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4035.4 | 96208     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 30656     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 38864     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 34752     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 38864     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 38856     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 30672     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 30656     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 34720     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 38848     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 30656     | 1-May-23 | 12:22 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.4     | 38864     | 1-May-23 | 12:22 | x64      |
| Qds.dll                                      | 2022.160.4035.4 | 1791904   | 1-May-23 | 12:22 | x64      |
| Rsfxft.dll                                   | 2022.160.4035.4 | 55184     | 1-May-23 | 12:22 | x64      |
| Secforwarder.dll                             | 2022.160.4035.4 | 83904     | 1-May-23 | 12:22 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4035.4 | 137104    | 1-May-23 | 12:22 | x64      |
| Sqlaccess.dll                                | 2022.160.4035.4 | 444368    | 1-May-23 | 12:22 | x64      |
| Sqlagent.exe                                 | 2022.160.4035.4 | 726976    | 1-May-23 | 12:22 | x64      |
| Sqlceip.exe                                  | 16.0.4035.4     | 300960    | 1-May-23 | 12:22 | x86      |
| Sqlctr160.dll                                | 2022.160.4035.4 | 157584    | 1-May-23 | 12:22 | x64      |
| Sqlctr160.dll                                | 2022.160.4035.4 | 128928    | 1-May-23 | 12:22 | x86      |
| Sqldk.dll                                    | 2022.160.4035.4 | 4028304   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 1746848   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3844000   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4061072   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4568976   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4700064   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3745696   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3930016   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4568992   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4396960   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4470688   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 2443168   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 2385824   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4257696   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3893136   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4409248   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4200352   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4183952   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3970976   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 3848080   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 1685408   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4290448   | 1-May-23 | 12:22 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.4 | 4433824   | 1-May-23 | 12:22 | x64      |
| Sqllang.dll                                  | 2022.160.4035.4 | 48588736  | 1-May-23 | 12:22 | x64      |
| Sqlmin.dll                                   | 2022.160.4035.4 | 51333024  | 1-May-23 | 12:22 | x64      |
| Sqlos.dll                                    | 2022.160.4035.4 | 51088     | 1-May-23 | 12:22 | x64      |
| Sqlrepss.dll                                 | 2022.160.4035.4 | 137104    | 1-May-23 | 12:22 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4035.4 | 51104     | 1-May-23 | 12:22 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4035.4 | 5830544   | 1-May-23 | 12:22 | x64      |
| Sqlservr.exe                                 | 2022.160.4035.4 | 722880    | 1-May-23 | 12:22 | x64      |
| Sqltses.dll                                  | 2022.160.4035.4 | 9390032   | 1-May-23 | 12:22 | x64      |
| Sqsrvres.dll                                 | 2022.160.4035.4 | 305104    | 1-May-23 | 12:22 | x64      |
| Svl.dll                                      | 2022.160.4035.4 | 247696    | 1-May-23 | 12:22 | x64      |
| Xe.dll                                       | 2022.160.4035.4 | 718800    | 1-May-23 | 12:22 | x64      |
| Xpstar.dll                                   | 2022.160.4035.4 | 534480    | 1-May-23 | 12:22 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |   Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4035.4 | 268224    | 1-May-23 | 11:07 | x64      |
| Dts.dll                                              | 2022.160.4035.4 | 3266512   | 1-May-23 | 11:07 | x64      |
| Logread.exe                                          | 2022.160.4035.4 | 788384    | 1-May-23 | 11:07 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.211     | 2933672   | 1-May-23 | 11:06 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 1-May-23 | 11:07 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4035.4     | 30608     | 1-May-23 | 11:07 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 1-May-23 | 11:07 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 1-May-23 | 11:07 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 1-May-23 | 11:07 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 1-May-23 | 11:07 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 1-May-23 | 11:07 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 1-May-23 | 11:07 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4035.4 | 1714128   | 1-May-23 | 11:07 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4035.4     | 554944    | 1-May-23 | 11:07 | x86      |
| Msgprox.dll                                          | 2022.160.4035.4 | 313296    | 1-May-23 | 11:07 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 1-May-23 | 11:07 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 1-May-23 | 11:07 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 1-May-23 | 11:07 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4035.4 | 530336    | 1-May-23 | 11:07 | x64      |
| Rdistcom.dll                                         | 2022.160.4035.4 | 939984    | 1-May-23 | 11:07 | x64      |
| Repldp.dll                                           | 2022.160.4035.4 | 337872    | 1-May-23 | 11:07 | x64      |
| Replisapi.dll                                        | 2022.160.4035.4 | 419792    | 1-May-23 | 11:07 | x64      |
| Replmerg.exe                                         | 2022.160.4035.4 | 604096    | 1-May-23 | 11:07 | x64      |
| Replprov.dll                                         | 2022.160.4035.4 | 890768    | 1-May-23 | 11:07 | x64      |
| Replrec.dll                                          | 2022.160.4035.4 | 1058704   | 1-May-23 | 11:07 | x64      |
| Replsub.dll                                          | 2022.160.4035.4 | 501648    | 1-May-23 | 11:07 | x64      |
| Spresolv.dll                                         | 2022.160.4035.4 | 300960    | 1-May-23 | 11:07 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4035.4 | 137104    | 1-May-23 | 11:06 | x64      |
| Sqlcmd.exe                                           | 2022.160.4035.4 | 276432    | 1-May-23 | 11:07 | x64      |
| Sqldistx.dll                                         | 2022.160.4035.4 | 268240    | 1-May-23 | 11:07 | x64      |
| Sqlmergx.dll                                         | 2022.160.4035.4 | 423824    | 1-May-23 | 11:07 | x64      |
| Xe.dll                                               | 2022.160.4035.4 | 718800    | 1-May-23 | 11:07 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |   Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4035.4 | 100240    | 1-May-23 | 11:07 | x64      |
| Exthost.exe                   | 2022.160.4035.4 | 247760    | 1-May-23 | 11:07 | x64      |
| Launchpad.exe                 | 2022.160.4035.4 | 1357728   | 1-May-23 | 11:07 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4035.4 | 137104    | 1-May-23 | 11:07 | x64      |
| Sqlsatellite.dll              | 2022.160.4035.4 | 1165216   | 1-May-23 | 11:07 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |   Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4035.4 | 710544    | 1-May-23 | 11:07 | x64      |
| Fdhost.exe               | 2022.160.4035.4 | 153552    | 1-May-23 | 11:07 | x64      |
| Fdlauncher.exe           | 2022.160.4035.4 | 100304    | 1-May-23 | 11:07 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4035.4 | 137104    | 1-May-23 | 11:07 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |   Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 1-May-23 | 11:20 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 1-May-23 | 11:20 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 1-May-23 | 11:20 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 1-May-23 | 11:20 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 1-May-23 | 11:20 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 1-May-23 | 11:20 | x86      |
| Dts.dll                                                       | 2022.160.4035.4 | 2860960   | 1-May-23 | 11:20 | x86      |
| Dts.dll                                                       | 2022.160.4035.4 | 3266512   | 1-May-23 | 11:20 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4035.4     | 120768    | 1-May-23 | 11:20 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4035.4     | 120736    | 1-May-23 | 11:20 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.211     | 2933672   | 1-May-23 | 11:20 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4035.4     | 509840    | 1-May-23 | 11:20 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4035.4     | 509840    | 1-May-23 | 11:20 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4035.4     | 219040    | 1-May-23 | 11:20 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.211 | 10165712  | 1-May-23 | 11:20 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 1-May-23 | 11:20 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 1-May-23 | 11:20 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4035.4 | 137104    | 1-May-23 | 11:20 | x64      |
| Sqlceip.exe                                                   | 16.0.4035.4     | 300960    | 1-May-23 | 11:20 | x86      |
| Xe.dll                                                        | 2022.160.4035.4 | 640976    | 1-May-23 | 11:20 | x86      |
| Xe.dll                                                        | 2022.160.4035.4 | 718800    | 1-May-23 | 11:20 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |   Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1024.0     | 559064    | 1-May-23 | 12:04 | x86      |
| Dmsnative.dll                                                        | 2022.160.1024.0 | 152496    | 1-May-23 | 12:04 | x64      |
| Dwengineservice.dll                                                  | 16.0.1024.0     | 44976     | 1-May-23 | 12:04 | x86      |
| Instapi150.dll                                                       | 2022.160.4035.4 | 104336    | 1-May-23 | 12:04 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1024.0     | 67488     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1024.0     | 293336    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1024.0     | 1957848   | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1024.0     | 169392    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1024.0     | 647080    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1024.0     | 246232    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1024.0     | 139216    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1024.0     | 79832     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1024.0     | 51152     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1024.0     | 88528     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1024.0     | 1129432   | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1024.0     | 80856     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1024.0     | 70560     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1024.0     | 35232     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1024.0     | 30640     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1024.0     | 46544     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1024.0     | 21408     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1024.0     | 26544     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1024.0     | 131504    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1024.0     | 86480     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1024.0     | 100768    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1024.0     | 293280    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 120224    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 138144    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 141232    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 137648    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 150432    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 139696    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 134560    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 176560    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 117680    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 136624    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1024.0     | 72608     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1024.0     | 21968     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1024.0     | 37280     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1024.0     | 128928    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1024.0     | 3064784   | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1024.0     | 3955664   | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 118232    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133080    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 137688    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133592    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 148440    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 134104    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 130520    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 170960    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 115160    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 132056    | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1024.0     | 67504     | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1024.0     | 2682832   | 1-May-23 | 12:04 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1024.0     | 2436528   | 1-May-23 | 12:04 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4035.4 | 296864    | 1-May-23 | 12:04 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4035.4 | 7817104   | 1-May-23 | 12:04 | x64      |
| Secforwarder.dll                                                     | 2022.160.4035.4 | 83904     | 1-May-23 | 12:04 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1024.0 | 61392     | 1-May-23 | 12:04 | x64      |
| Sqldk.dll                                                            | 2022.160.4035.4 | 4028304   | 1-May-23 | 12:04 | x64      |
| Sqldumper.exe                                                        | 2022.160.4035.4 | 260032    | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 1746848   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4568976   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 3745696   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4568992   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4470688   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 2443168   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 2385824   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4200352   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4183952   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 1685408   | 1-May-23 | 12:04 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.4 | 4433824   | 1-May-23 | 12:04 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 1-May-23 | 12:04 | x64      |
| Sqlos.dll                                                            | 2022.160.4035.4 | 51088     | 1-May-23 | 12:04 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1024.0 | 4841424   | 1-May-23 | 12:04 | x64      |
| Sqltses.dll                                                          | 2022.160.4035.4 | 9390032   | 1-May-23 | 12:04 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
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
