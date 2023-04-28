---
title: Cumulative update 4 for SQL Server 2022 (KB5026717)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 4 (KB5026717).
ms.date: 05/11/2023
ms.custom: KB5026717
author: Elena068
ms.author: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5026717 - Cumulative Update 4 for SQL Server 2022

_Release Date:_ &nbsp; May 11, 2023  
_Version:_ &nbsp; 16.0.4035.3

## Summary

This article describes Cumulative Update package 4 (CU4) for Microsoft SQL Server 2022. This update contains 15 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 3, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4035.3**, file version: **2022.160.4035.3**
- Analysis Services - Product version: **16.0.43.211**, file version: **2022.160.43.211**

## Known issues in this update

After you install SQL Server 2022 CU2, external data sources using generic ODBC connector may no longer work. When you try to query external tables that were created before installing CU2, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall SQL Server 2022 CU2 or add the Driver keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

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
| <a id="2306513">[2306513](#2306513)</a> | Fixes access violations and `INVALID_POINTER_READ_c0000005_sqlmin.dll!CProfileList::FGetPartitionSummaryXML` exceptions that you may encounter during the execution of `sys.dm_exec_query_plan_stats`. | SQL Server Engine | Query Execution | All |
| <a id="2310201">[2310201](#2310201)</a> | Fixes an issue where running the `ALTER ASSEMBLY` command for a complex common language runtime (CLR) assembly can cause some of the other commands that are executed in parallel to time out. | SQL Server Engine | Query Execution | All |
| <a id="2344871">[2344871](#2344871)</a> | Adds two new trace flags (TF) to the automatic plan correction (APC) feature of automatic tuning. TF 12618 introduces a new plan regression detection model that includes multiple consecutive checks. TF 12656 introduces the ability to use a time-based plan regression check that will occur five minutes after a plan change is discovered, which avoids biasing the regression checks by queries that execute quickly. | SQL Server Engine | Query Execution | All |
| <a id="2278800">[2278800](#2278800)</a> | Fixes an issue where incorrect results are returned when you use the `LAG` or `LEAD` window functions while using the `IGNORE NULLS` clause. | SQL Server Engine | Query Optimizer | All |
| <a id="2297428">[2297428](#2297428)</a> | Fixes an issue where the `KILL STATS JOB` process leaks reference count on some items when multiple asynchronous statistics jobs are running, which causes those items to remain in the queue (visible via `sys.dm_exec_background_job_queue`) until the SQL Server instance is restarted. | SQL Server Engine | Query Optimizer | All |
| <a id="2307893">[2307893](#2307893)</a> | Fixes incorrect results for queries that filter on `ROW_NUMBER` and involve nullable columns. | SQL Server Engine | Query Optimizer | All |
| <a id="2313621">[2313621](#2313621)</a> | Fixes the following errors and access violations that are caused by an incorrect plan in the case of multiple occurrences of the same scalar subquery: </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Server Engine | Query Optimizer | All |
| <a id="2343788">[2343788](#2343788)</a> | Fixes a memory leak issue in the Cardinality Estimation (CE) feedback when an OOM (Out of Memory) occurs in a constructor function. | SQL Server Engine | Query Optimizer | All |
| <a id="2303424">[2303424](#2303424)</a> | Fixes an issue that prevents you from dropping table groups on a database that has Azure Synapse Link enabled and the collation is set to `Latin1_General_BIN2`. | SQL Server Engine | Replication | All |
| <a id="2335976">[2335976](#2335976)</a> | Fixes an issue where 22836 error occurs when you add the change data capture (CDC) job again after deleting CDC capture and removing a job in SQL Server Agent. | SQL Server Engine | Replication | All |
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

This cumulative update package isn't yet available on [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022). This article will be updated after the package is made available on this channel.

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
|SQLServer2022-KB5026717-x64.exe| 0F244B80CF082117C6885AEE58D2ADF689FBA73EBEE420F5ECF6007358E00DF0 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.211 | 336848    | 26-Apr-23 | 17:14 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.211     | 2903504   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 26-Apr-23 | 17:15 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 26-Apr-23 | 17:15 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 26-Apr-23 | 17:15 | x86      |
| Msmdctr.dll                                         | 2022.160.43.211 | 38864     | 26-Apr-23 | 17:15 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 53921192  | 26-Apr-23 | 17:15 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 71759272  | 26-Apr-23 | 17:15 | x64      |
| Msmdpump.dll                                        | 2022.160.43.211 | 10335184  | 26-Apr-23 | 17:15 | x64      |
| Msmdredir.dll                                       | 2022.160.43.211 | 8132048   | 26-Apr-23 | 17:15 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.211 | 71316392  | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 954792    | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1882576   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1669536   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1878952   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1846176   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1145256   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1138088   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1767336   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1746856   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 930728    | 26-Apr-23 | 17:15 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1835432   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 953256    | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1880488   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1666472   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1874344   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1842600   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1143208   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1136552   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1763752   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1743272   | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 931240    | 26-Apr-23 | 17:15 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1830824   | 26-Apr-23 | 17:15 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 10083792  | 26-Apr-23 | 17:15 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 8265640   | 26-Apr-23 | 17:15 | x86      |
| Msolap.dll                                          | 2022.160.43.211 | 10970064  | 26-Apr-23 | 17:15 | x64      |
| Msolap.dll                                          | 2022.160.43.211 | 8744912   | 26-Apr-23 | 17:15 | x86      |
| Msolui.dll                                          | 2022.160.43.211 | 289744    | 26-Apr-23 | 17:15 | x86      |
| Msolui.dll                                          | 2022.160.43.211 | 308136    | 26-Apr-23 | 17:15 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 26-Apr-23 | 17:15 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 26-Apr-23 | 17:15 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |
| Sqlceip.exe                                         | 16.0.4035.3     | 300944    | 26-Apr-23 | 17:14 | x86      |
| Sqldumper.exe                                       | 2022.160.4035.3 | 227232    | 26-Apr-23 | 17:14 | x86      |
| Sqldumper.exe                                       | 2022.160.4035.3 | 260048    | 26-Apr-23 | 17:14 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 26-Apr-23 | 17:15 | x86      |
| Tmapi.dll                                           | 2022.160.43.211 | 5884368   | 26-Apr-23 | 17:15 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.211 | 5575120   | 26-Apr-23 | 17:15 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.211 | 1481168   | 26-Apr-23 | 17:15 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.211 | 7197648   | 26-Apr-23 | 17:15 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 26594256  | 26-Apr-23 | 17:15 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 35895720  | 26-Apr-23 | 17:15 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4035.3 | 104384    | 26-Apr-23 | 17:14 | x64      |
| Instapi150.dll                             | 2022.160.4035.3 | 79824     | 26-Apr-23 | 17:14 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633680   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633640   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.211     | 2933152   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323408   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323368   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4035.3     | 554960    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4035.3     | 554944    | 26-Apr-23 | 17:14 | x86      |
| Msasxpress.dll                             | 2022.160.43.211 | 32720     | 26-Apr-23 | 17:14 | x64      |
| Msasxpress.dll                             | 2022.160.43.211 | 27600     | 26-Apr-23 | 17:15 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |
| Sqldumper.exe                              | 2022.160.4035.3 | 227232    | 26-Apr-23 | 17:14 | x86      |
| Sqldumper.exe                              | 2022.160.4035.3 | 260048    | 26-Apr-23 | 17:14 | x64      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4035.3     | 2066320   | 26-Apr-23 | 17:14 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4035.3  | 600016    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4035.3  | 599968    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4035.3  | 174032    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4035.3  | 1857472   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4035.3  | 1857488   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4035.3  | 370592    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4035.3  | 370640    | 26-Apr-23 | 17:14 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4035.3 | 4719056   | 26-Apr-23 | 18:42 | x64      |
| Aetm-enclave.dll                             | 2022.160.4035.3 | 4673488   | 26-Apr-23 | 18:42 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4035.3 | 4909096   | 26-Apr-23 | 18:42 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4035.3 | 4874512   | 26-Apr-23 | 18:42 | x64      |
| Hadrres.dll                                  | 2022.160.4035.3 | 227264    | 26-Apr-23 | 18:42 | x64      |
| Hkcompile.dll                                | 2022.160.4035.3 | 1411024   | 26-Apr-23 | 18:42 | x64      |
| Hkengine.dll                                 | 2022.160.4035.3 | 5760912   | 26-Apr-23 | 18:42 | x64      |
| Hkruntime.dll                                | 2022.160.4035.3 | 190416    | 26-Apr-23 | 18:42 | x64      |
| Hktempdb.dll                                 | 2022.160.4035.3 | 71632     | 26-Apr-23 | 18:42 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.211     | 2322384   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4035.3 | 333776    | 26-Apr-23 | 18:42 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4035.3 | 96160     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                               | 16.0.4035.3     | 30624     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 38800     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 34752     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 38816     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 38816     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 30656     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 30672     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 34704     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 38816     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 30624     | 26-Apr-23 | 18:42 | x64      |
| `Odsole70.rll`                                 | 16.0.4035.3     | 38800     | 26-Apr-23 | 18:42 | x64      |
| Qds.dll                                      | 2022.160.4035.3 | 1791936   | 26-Apr-23 | 18:42 | x64      |
| Rsfxft.dll                                   | 2022.160.4035.3 | 55232     | 26-Apr-23 | 18:42 | x64      |
| Secforwarder.dll                             | 2022.160.4035.3 | 83872     | 26-Apr-23 | 18:42 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |
| Sqlaccess.dll                                | 2022.160.4035.3 | 444368    | 26-Apr-23 | 18:42 | x64      |
| Sqlagent.exe                                 | 2022.160.4035.3 | 726944    | 26-Apr-23 | 18:42 | x64      |
| Sqlceip.exe                                  | 16.0.4035.3     | 300944    | 26-Apr-23 | 18:42 | x86      |
| Sqlctr160.dll                                | 2022.160.4035.3 | 157584    | 26-Apr-23 | 18:42 | x64      |
| Sqlctr160.dll                                | 2022.160.4035.3 | 128928    | 26-Apr-23 | 18:42 | x86      |
| Sqldk.dll                                    | 2022.160.4035.3 | 4028368   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 1746896   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3844048   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4061120   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4569040   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4700096   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3745696   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3930064   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4569040   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4397008   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4470736   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 2443216   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 2385872   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4257744   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3893200   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4409296   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4200400   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4184000   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3971024   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 3848080   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 1685456   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4290512   | 26-Apr-23 | 18:42 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4035.3 | 4433872   | 26-Apr-23 | 18:42 | x64      |
| Sqllang.dll                                  | 2022.160.4035.3 | 48588752  | 26-Apr-23 | 18:42 | x64      |
| Sqlmin.dll                                   | 2022.160.4035.3 | 51328976  | 26-Apr-23 | 18:42 | x64      |
| Sqlos.dll                                    | 2022.160.4035.3 | 51136     | 26-Apr-23 | 18:42 | x64      |
| Sqlrepss.dll                                 | 2022.160.4035.3 | 137104    | 26-Apr-23 | 18:42 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4035.3 | 51152     | 26-Apr-23 | 18:42 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4035.3 | 5830608   | 26-Apr-23 | 18:42 | x64      |
| Sqlservr.exe                                 | 2022.160.4035.3 | 722848    | 26-Apr-23 | 18:42 | x64      |
| Sqltses.dll                                  | 2022.160.4035.3 | 9389968   | 26-Apr-23 | 18:42 | x64      |
| Sqsrvres.dll                                 | 2022.160.4035.3 | 305088    | 26-Apr-23 | 18:42 | x64      |
| Svl.dll                                      | 2022.160.4035.3 | 247744    | 26-Apr-23 | 18:42 | x64      |
| Xe.dll                                       | 2022.160.4035.3 | 718800    | 26-Apr-23 | 18:42 | x64      |
| Xpstar.dll                                   | 2022.160.4035.3 | 534432    | 26-Apr-23 | 18:42 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4035.3 | 268176    | 26-Apr-23 | 17:14 | x64      |
| Dts.dll                                              | 2022.160.4035.3 | 3266496   | 26-Apr-23 | 17:15 | x64      |
| Logread.exe                                          | 2022.160.4035.3 | 788416    | 26-Apr-23 | 17:14 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.211     | 2933672   | 26-Apr-23 | 17:15 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4035.3     | 30656     | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 26-Apr-23 | 17:14 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4035.3 | 1714128   | 26-Apr-23 | 17:15 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4035.3     | 554944    | 26-Apr-23 | 17:14 | x86      |
| Msgprox.dll                                          | 2022.160.4035.3 | 313280    | 26-Apr-23 | 17:15 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 26-Apr-23 | 17:14 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 26-Apr-23 | 17:14 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 26-Apr-23 | 17:15 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4035.3 | 530336    | 26-Apr-23 | 17:14 | x64      |
| Rdistcom.dll                                         | 2022.160.4035.3 | 939920    | 26-Apr-23 | 17:14 | x64      |
| Repldp.dll                                           | 2022.160.4035.3 | 337824    | 26-Apr-23 | 17:15 | x64      |
| Replisapi.dll                                        | 2022.160.4035.3 | 419792    | 26-Apr-23 | 17:15 | x64      |
| Replmerg.exe                                         | 2022.160.4035.3 | 604064    | 26-Apr-23 | 17:14 | x64      |
| Replprov.dll                                         | 2022.160.4035.3 | 890816    | 26-Apr-23 | 17:15 | x64      |
| Replrec.dll                                          | 2022.160.4035.3 | 1058720   | 26-Apr-23 | 17:14 | x64      |
| Replsub.dll                                          | 2022.160.4035.3 | 501664    | 26-Apr-23 | 17:14 | x64      |
| Spresolv.dll                                         | 2022.160.4035.3 | 300944    | 26-Apr-23 | 17:14 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |
| Sqlcmd.exe                                           | 2022.160.4035.3 | 276432    | 26-Apr-23 | 17:14 | x64      |
| Sqldistx.dll                                         | 2022.160.4035.3 | 268192    | 26-Apr-23 | 17:14 | x64      |
| Sqlmergx.dll                                         | 2022.160.4035.3 | 423840    | 26-Apr-23 | 17:15 | x64      |
| Xe.dll                                               | 2022.160.4035.3 | 718800    | 26-Apr-23 | 17:15 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4035.3 | 100288    | 26-Apr-23 | 17:14 | x64      |
| Exthost.exe                   | 2022.160.4035.3 | 247704    | 26-Apr-23 | 17:14 | x64      |
| Launchpad.exe                 | 2022.160.4035.3 | 1357760   | 26-Apr-23 | 17:14 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |
| Sqlsatellite.dll              | 2022.160.4035.3 | 1165216   | 26-Apr-23 | 17:14 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4035.3 | 710544    | 26-Apr-23 | 17:14 | x64      |
| Fdhost.exe               | 2022.160.4035.3 | 153504    | 26-Apr-23 | 17:14 | x64      |
| Fdlauncher.exe           | 2022.160.4035.3 | 100248    | 26-Apr-23 | 17:14 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:14 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 26-Apr-23 | 17:18 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 26-Apr-23 | 17:18 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 26-Apr-23 | 17:18 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 26-Apr-23 | 17:18 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 26-Apr-23 | 17:18 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 26-Apr-23 | 17:18 | x86      |
| Dts.dll                                                       | 2022.160.4035.3 | 2860992   | 26-Apr-23 | 17:18 | x86      |
| Dts.dll                                                       | 2022.160.4035.3 | 3266496   | 26-Apr-23 | 17:18 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4035.3     | 120768    | 26-Apr-23 | 17:18 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4035.3     | 120736    | 26-Apr-23 | 17:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.211     | 2933672   | 26-Apr-23 | 17:18 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4035.3     | 509904    | 26-Apr-23 | 17:18 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4035.3     | 509888    | 26-Apr-23 | 17:18 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4035.3     | 219088    | 26-Apr-23 | 17:18 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.211 | 10165712  | 26-Apr-23 | 17:18 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-Apr-23 | 17:18 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-Apr-23 | 17:18 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-Apr-23 | 17:18 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4035.3 | 137168    | 26-Apr-23 | 17:18 | x64      |
| Sqlceip.exe                                                   | 16.0.4035.3     | 300944    | 26-Apr-23 | 17:18 | x86      |
| Xe.dll                                                        | 2022.160.4035.3 | 640976    | 26-Apr-23 | 17:18 | x86      |
| Xe.dll                                                        | 2022.160.4035.3 | 718800    | 26-Apr-23 | 17:18 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1024.0     | 559064    | 26-Apr-23 | 18:23 | x86      |
| Dmsnative.dll                                                        | 2022.160.1024.0 | 152496    | 26-Apr-23 | 18:23 | x64      |
| Dwengineservice.dll                                                  | 16.0.1024.0     | 44976     | 26-Apr-23 | 18:23 | x86      |
| Instapi150.dll                                                       | 2022.160.4035.3 | 104384    | 26-Apr-23 | 18:23 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1024.0     | 67488     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1024.0     | 293336    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1024.0     | 1957848   | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1024.0     | 169392    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1024.0     | 647080    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1024.0     | 246232    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1024.0     | 139216    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1024.0     | 79832     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1024.0     | 51152     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1024.0     | 88528     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1024.0     | 1129432   | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1024.0     | 80856     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1024.0     | 70560     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1024.0     | 35232     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1024.0     | 30640     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1024.0     | 46544     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1024.0     | 21408     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1024.0     | 26544     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1024.0     | 131504    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1024.0     | 86480     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1024.0     | 100768    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1024.0     | 293280    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 120224    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 138144    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 141232    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 137648    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 150432    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 139696    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 134560    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 176560    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 117680    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 136624    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1024.0     | 72608     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1024.0     | 21968     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1024.0     | 37280     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1024.0     | 128928    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1024.0     | 3064784   | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1024.0     | 3955664   | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 118232    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133080    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 137688    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133592    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 148440    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 134104    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 130520    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 170960    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 115160    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 132056    | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1024.0     | 67504     | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1024.0     | 2682832   | 26-Apr-23 | 18:23 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1024.0     | 2436528   | 26-Apr-23 | 18:23 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4035.3 | 296912    | 26-Apr-23 | 18:23 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4035.3 | 7817152   | 26-Apr-23 | 18:23 | x64      |
| Secforwarder.dll                                                     | 2022.160.4035.3 | 83872     | 26-Apr-23 | 18:23 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1024.0 | 61392     | 26-Apr-23 | 18:23 | x64      |
| Sqldk.dll                                                            | 2022.160.4035.3 | 4028368   | 26-Apr-23 | 18:23 | x64      |
| Sqldumper.exe                                                        | 2022.160.4035.3 | 260048    | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 1746896   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4569040   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 3745696   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4569040   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4470736   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 2443216   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 2385872   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4200400   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4184000   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 1685456   | 26-Apr-23 | 18:23 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4035.3 | 4433872   | 26-Apr-23 | 18:23 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 26-Apr-23 | 18:23 | x64      |
| Sqlos.dll                                                            | 2022.160.4035.3 | 51136     | 26-Apr-23 | 18:23 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1024.0 | 4841424   | 26-Apr-23 | 18:23 | x64      |
| Sqltses.dll                                                          | 2022.160.4035.3 | 9389968   | 26-Apr-23 | 18:23 | x64      |

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

This article also provides the following important information:

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

If another issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](https://blogs.msdn.microsoft.com/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism/)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)