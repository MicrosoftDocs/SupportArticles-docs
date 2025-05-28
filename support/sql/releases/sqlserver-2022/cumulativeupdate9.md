---
title: Cumulative update 9 for SQL Server 2022 (KB5030731)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 9 (KB5030731).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5030731
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5030731 - Cumulative Update 9 for SQL Server 2022

_Release Date:_ &nbsp; October 12, 2023  
_Version:_ &nbsp; 16.0.4085.2

## Summary

This article describes Cumulative Update package 9 (CU9) for Microsoft SQL Server 2022. This update contains 26 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 8, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4085.2**, file version: **2022.160.4085.2**
- Analysis Services - Product version: **16.0.43.222**, file version: **2022.160.43.222**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|--------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2641756>[2641756](#2641756) </a> | The `RemoveDiscontinuedFeatures` command that has the `EnsureProperEncryption` option is extended to support multidimensional model databases. For more information, see [Multidimensional mode](/analysis-services/instances/encryption-upgrade#multidimensional-mode). | Analysis Services| Analysis Services | Windows|
| <a id=2654343>[2654343](#2654343) </a> | Fixes an issue in which you search for a specific node and then fail to expand the node on the hierarchy page. | Master Data Services | Master Data Services| Windows|
| <a id=2659495>[2659495](#2659495) </a> | Updates the version of the Microsoft ODBC driver to 17.10.5.1. For more information, see [Release Notes for Microsoft ODBC Driver for SQL Server on Windows](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows). | SQL Connectivity | SQL Connectivity| Windows|
| <a id=2659497>[2659497](#2659497) </a> | Updates the version of the Microsoft OLE DB driver to 18.6.7. For more information, see [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server).| SQL Connectivity | SQL Connectivity| Windows|
| <a id=2450865>[2450865](#2450865) </a> | Fixes an issue in which the following assertion failure occurs while you try to restore a database to a disk with insufficient storage, which causes the SQL Server instance to stop responding: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 17066, Severity: 16, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL Server Assertion: File: <buffer.cpp>, line=12797 Failed Assertion = 'bufDiscarded'. This error may be timing-related. If the error persists after rerunning the statement, use DBCC CHECKDB to check the database for structural integrity, or restart the server to ensure in-memory data structures are not corrupted. | SQL Server Engine| Backup Restore| All|
| <a id=2630696>[2630696](#2630696) </a> | Fixes an issue in which restoring a transaction log backup to the specific point in time fails with the following error: </br></br>Msg 9003, Level 20, State 9, Line \<LineNumber> </br>The log scan number (xxx:xxx:xxx) passed to log scan in database 'DatabaseName' is not valid. | SQL Server Engine| Backup Restore| All|
| <a id=2518729>[2518729](#2518729) </a> | Fixes an issue in which an `INSERT` (or any Data Manipulation Language (DML)) statement is blocked if you run the statement before a clustered columnstore index (CCI) online rebuild or drop and then run the statement during the online rebuild or drop if the statement is still in the procedure cache. | SQL Server Engine| Column Stores | All|
| <a id=2557526>[2557526](#2557526) </a> | Fixes an access violation issue that occurs when removing the database snapshot files on the readable secondary replica of an Always On availability group that has the buffer pool extension enabled.| SQL Server Engine| DB Management | All|
| <a id=2670876>[2670876](#2670876) </a> | Updates the Pacemaker agent code to support Red Hat Enterprise Linux (RHEL) 9 and Ubuntu 22. | SQL Server Engine| High Availability and Disaster Recovery | Linux|
| <a id=2557571>[2557571](#2557571) </a> | This improvement adds Extended Events functionality to enhance the periodic primary replica to secondary replica notification investigation in availability groups for an in-memory database. New events are generated that provide the oldest active transaction and end of log values. </br></br>This new tracing will help diagnose errors such as the following: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Error: 41316, Severity: 23, State: 7. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Restore operation failed for database '\<DatabaseName>' with internal error code '0x84000004'.| SQL Server Engine| In-Memory OLTP| Windows|
| <a id=2644031>[2644031](#2644031) </a> | Improves Data Definition Language (DDL) performance to create a large number of tables and partitions when the number of databases on a SQL Server instance exceeds 100. | SQL Server Engine| Methods to access stored data | All|
| <a id=2627571>[2627571](#2627571) </a> | Enables the `JSON_ARRAY` and `JSON_OBJECT` functions by default in SQL Server 2022.| SQL Server Engine| Programmability | All|
| <a id=2681462>[2681462](#2681462) </a> | Fixes the incorrect results that you encounter when you use `JSON_ARRAY` or `JSON_OBJECT` as a default column during the table creation. | SQL Server Engine| Programmability | All|
| <a id=2636302>[2636302](#2636302) </a> | Fixes an access violation that may be encountered when querying the `sys.dm_os_memory_objects` dynamic management view (DMV).| SQL Server Engine| Query Execution | All|
| <a id=2499342>[2499342](#2499342) </a> | Fixes an issue in which the plan cache entry is evicted when the Cardinality Estimation (CE) feedback tries to get the associated profile, which causes a memory corruption. | SQL Server Engine| Query Optimizer | All|
| <a id=2499352>[2499352](#2499352) </a> | Updates the `SQDSFeedbackEEFunctors` constructor to prevent race conditions, which can cause double deletion during the construction.| SQL Server Engine| Query Optimizer | All|
| <a id=2636294>[2636294](#2636294) </a> | Fixes an issue in which the cardinality estimation (CE) uniformly increases after each `LEFT JOIN` or `RIGHT JOIN` combines, which causes overestimation. This fix adds a limitation to the CE when the join predicates are the primary keys of the tables that are involved. </br></br> **Note**: Trace flag 9440 will turn off the functionality provided by this fix for databases with a compatibility level of 160 and earlier. | SQL Server Engine| Query Optimizer | All |
| <a id=2690500>[2690500](#2690500) </a> | Fixes an issue in Cardinality Estimation (CE) feedback involving uninitialized variables in PStmtGetSafe.| SQL Server Engine| Query Optimizer | All|
| <a id=2602744>[2602744](#2602744) </a> | Fixes an issue that you encounter in the following scenario: </br></br>- Configure the "Replication: agent custom shutdown" alert to respond to error 20578. </br></br>- Run `sp_publication_validation` with `@shutdown_agent` as `1` to initiate an article validation. </br></br>In this scenario, you notice that the "Replication: agent custom shutdown" alert doesn't respond, which occurs as error 20578 isn't logged in the application log. | SQL Server Engine| Replication | All|
| <a id=2614104>[2614104](#2614104) </a> | Fixes an issue in which the Snapshot Agent incorrectly generates the script of the `XXX_msrepl_ccs` stored procedure if `@sync_method` is `concurrent`, and replication stored procedures are specified under a custom schema. | SQL Server Engine| Replication | All|
| <a id=2675548>[2675548](#2675548) </a> | Fixes an error that you encounter when reading some .XEL files by using `sys.fn_MSxe_read_event_stream`. | SQL Server Engine| Resource Governor | All|
| <a id=2659494>[2659494](#2659494) </a> | An attacker can send a malformed TDS (Tabular Data Stream) packet that causes a login failure, unavailability, or other undefined behavior. | SQL Server Engine| Security Infrastructure | All|
| <a id=2674316>[2674316](#2674316) </a> | Fixes error 207 (Invalid column name '\<ColumnName>') that you encounter when you run a user-defined function (UDF), which references a dropped column that uses data classification.| SQL Server Engine| Security Infrastructure | All|
| <a id=2668476>[2668476](#2668476) </a> </br><a id=2683132>[2683132](#2683132) </a> | Fixes an assertion failure (Location: setypes.cpp:1274; Expression: !IsInRowDiff()) that you might encounter at `FAILED_ASSERTION_42ac_sqlmin.dll!VersionRecPtr::IsNull` when you have multiple nested inserts. </br></br>**Note**: You can enable trace flag (TF) 7117 to mitigate the issue. Turn off TF 7117 after the mitigation is done, which means after the version cleaner cleans the problematic page. | SQL Server Engine| SQL Server Engine | All|
| <a id=2668765>[2668765](#2668765) </a> | Reduces the overall size of Ubuntu-based SQL Server container images.| SQL Setup| Linux | Linux|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU9 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5030731)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5030731-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5030731-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5030731-x64.exe|  FB55DACF5D956F05BFFB7CA583C30D68A412621C316D1A24C8A828F86A473884 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.222 | 336944    | 27-Sep-23 | 12:40 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.222     | 2903608   | 27-Sep-23 | 12:40 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 27-Sep-23 | 12:40 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 27-Sep-23 | 12:40 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 27-Sep-23 | 12:40 | x86      |
| Msmdctr.dll                                         | 2022.160.43.222 | 38960     | 27-Sep-23 | 12:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 53974984  | 27-Sep-23 | 12:40 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 71833648  | 27-Sep-23 | 12:40 | x64      |
| Msmdpump.dll                                        | 2022.160.43.222 | 10335296  | 27-Sep-23 | 12:40 | x64      |
| Msmdredir.dll                                       | 2022.160.43.222 | 8132032   | 27-Sep-23 | 12:40 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.222 | 71384624  | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 956976    | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1884736   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1671728   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1881136   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1848256   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1147440   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1140288   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1769408   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1748936   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 932800    | 27-Sep-23 | 12:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1837616   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 955440    | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1882560   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1668656   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1876528   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1844800   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1145288   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1138736   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1765424   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1745472   | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 933424    | 27-Sep-23 | 12:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1833008   | 27-Sep-23 | 12:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 10083888  | 27-Sep-23 | 12:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 8265680   | 27-Sep-23 | 12:40 | x86      |
| Msolap.dll                                          | 2022.160.43.222 | 10970568  | 27-Sep-23 | 12:40 | x64      |
| Msolap.dll                                          | 2022.160.43.222 | 8745008   | 27-Sep-23 | 12:40 | x86      |
| Msolui.dll                                          | 2022.160.43.222 | 289736    | 27-Sep-23 | 12:40 | x86      |
| Msolui.dll                                          | 2022.160.43.222 | 308272    | 27-Sep-23 | 12:40 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 27-Sep-23 | 12:40 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 27-Sep-23 | 12:40 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4085.2 | 137256    | 27-Sep-23 | 12:40 | x64      |
| Sqlceip.exe                                         | 16.0.4085.2     | 301096    | 27-Sep-23 | 12:41 | x86      |
| Sqldumper.exe                                       | 2022.160.4085.2 | 370624    | 27-Sep-23 | 12:41 | x86      |
| Sqldumper.exe                                       | 2022.160.4085.2 | 436264    | 27-Sep-23 | 12:41 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 27-Sep-23 | 12:40 | x86      |
| Tmapi.dll                                           | 2022.160.43.222 | 5884480   | 27-Sep-23 | 12:40 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.222 | 5575104   | 27-Sep-23 | 12:40 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.222 | 1481264   | 27-Sep-23 | 12:40 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.222 | 7198256   | 27-Sep-23 | 12:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.222 | 26593856  | 27-Sep-23 | 12:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.222 | 35896256  | 27-Sep-23 | 12:40 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4085.2 | 104488    | 27-Sep-23 | 12:41 | x64      |
| Instapi150.dll                             | 2022.160.4085.2 | 79912     | 27-Sep-23 | 12:41 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.222     | 2633776   | 27-Sep-23 | 12:41 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.222     | 2933296   | 27-Sep-23 | 12:41 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323512   | 27-Sep-23 | 12:41 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323504   | 27-Sep-23 | 12:41 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4085.2 | 104488    | 27-Sep-23 | 12:41 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4085.2 | 92200     | 27-Sep-23 | 12:41 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4085.2     | 555048    | 27-Sep-23 | 12:41 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4085.2     | 555064    | 27-Sep-23 | 12:41 | x86      |
| Msasxpress.dll                             | 2022.160.43.222 | 32720     | 27-Sep-23 | 12:41 | x64      |
| Msasxpress.dll                             | 2022.160.43.222 | 27696     | 27-Sep-23 | 12:41 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4085.2 | 137256    | 27-Sep-23 | 12:41 | x64      |
| Sqldumper.exe                              | 2022.160.4085.2 | 370624    | 27-Sep-23 | 12:41 | x86      |
| Sqldumper.exe                              | 2022.160.4085.2 | 436264    | 27-Sep-23 | 12:41 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4085.2 | 395304    | 27-Sep-23 | 12:41 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4085.2 | 456744    | 27-Sep-23 | 12:41 | x64      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4085.2     | 2070480   | 27-Sep-2023 | 12:41 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:41 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4085.2  | 600000    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4085.2  | 600120    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4085.2  | 174016    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4085.2  | 174032    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4085.2  | 1857472   | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4085.2  | 1857488   | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4085.2  | 370624    | 27-Sep-2023 | 12:41 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 27-Sep-2023 | 12:40 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 27-Sep-2023 | 12:40 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4085.2 | 4719056   | 27-Sep-2023 | 14:08 | x64      |
| Aetm-enclave.dll                             | 2022.160.4085.2 | 4673616   | 27-Sep-2023 | 14:08 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4085.2 | 4909248   | 27-Sep-2023 | 14:08 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4085.2 | 4874600   | 27-Sep-2023 | 14:08 | x64      |
| Dcexec.exe                                   | 2022.160.4085.2 | 96296     | 27-Sep-2023 | 14:08 | x64      |
| Fssres.dll                                   | 2022.160.4085.2 | 100392    | 27-Sep-2023 | 14:08 | x64      |
| Hadrres.dll                                  | 2022.160.4085.2 | 227368    | 27-Sep-2023 | 14:08 | x64      |
| Hkcompile.dll                                | 2022.160.4085.2 | 1411112   | 27-Sep-2023 | 14:08 | x64      |
| Hkengine.dll                                 | 2022.160.4085.2 | 5765176   | 27-Sep-2023 | 14:08 | x64      |
| Hkruntime.dll                                | 2022.160.4085.2 | 190504    | 27-Sep-2023 | 14:08 | x64      |
| Hktempdb.dll                                 | 2022.160.4085.2 | 71616     | 27-Sep-2023 | 14:08 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.222     | 2322368   | 27-Sep-2023 | 12:40 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4085.2 | 333864    | 27-Sep-2023 | 14:08 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4085.2 | 96312     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 30760     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 38968     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 34872     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 38848     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 38848     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 30776     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 30656     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 34752     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 38952     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 30656     | 27-Sep-2023 | 14:08 | x64      |
| `Odsole70.rll`                                 | 16.0.4085.2     | 38952     | 27-Sep-2023 | 14:08 | x64      |
| Qds.dll                                      | 2022.160.4085.2 | 1800232   | 27-Sep-2023 | 14:08 | x64      |
| Rsfxft.dll                                   | 2022.160.4085.2 | 55232     | 27-Sep-2023 | 14:08 | x64      |
| Secforwarder.dll                             | 2022.160.4085.2 | 83904     | 27-Sep-2023 | 14:08 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:40 | x64      |
| Sqlaccess.dll                                | 2022.160.4085.2 | 444456    | 27-Sep-2023 | 14:08 | x64      |
| Sqlagent.exe                                 | 2022.160.4085.2 | 714688    | 27-Sep-2023 | 14:08 | x64      |
| Sqlceip.exe                                  | 16.0.4085.2     | 301096    | 27-Sep-2023 | 14:08 | x86      |
| Sqlctr160.dll                                | 2022.160.4085.2 | 129064    | 27-Sep-2023 | 14:08 | x86      |
| Sqlctr160.dll                                | 2022.160.4085.2 | 157752    | 27-Sep-2023 | 14:08 | x64      |
| Sqldk.dll                                    | 2022.160.4085.2 | 4007872   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 1751080   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3848232   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4065336   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4577336   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4704296   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3749944   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3938360   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4577216   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4405288   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4479016   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 2443200   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 2385856   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4261928   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3897280   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4413384   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4208680   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4192208   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3975104   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 3852224   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 1685544   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4298688   | 27-Sep-2023 | 14:08 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4085.2 | 4442152   | 27-Sep-2023 | 14:08 | x64      |
| Sqliosim.com                                 | 2022.160.4085.2 | 387112    | 27-Sep-2023 | 14:08 | x64      |
| Sqliosim.exe                                 | 2022.160.4085.2 | 3057704   | 27-Sep-2023 | 14:08 | x64      |
| Sqllang.dll                                  | 2022.160.4085.2 | 48609216  | 27-Sep-2023 | 14:08 | x64      |
| Sqlmin.dll                                   | 2022.160.4085.2 | 51156928  | 27-Sep-2023 | 14:08 | x64      |
| Sqlos.dll                                    | 2022.160.4085.2 | 51240     | 27-Sep-2023 | 14:08 | x64      |
| Sqlrepss.dll                                 | 2022.160.4085.2 | 137152    | 27-Sep-2023 | 14:08 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4085.2 | 51240     | 27-Sep-2023 | 14:08 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4085.2 | 5830608   | 27-Sep-2023 | 14:08 | x64      |
| Sqlservr.exe                                 | 2022.160.4085.2 | 714792    | 27-Sep-2023 | 14:08 | x64      |
| Sqltses.dll                                  | 2022.160.4085.2 | 9386024   | 27-Sep-2023 | 14:08 | x64      |
| Sqsrvres.dll                                 | 2022.160.4085.2 | 305192    | 27-Sep-2023 | 14:08 | x64      |
| Svl.dll                                      | 2022.160.4085.2 | 247760    | 27-Sep-2023 | 14:08 | x64      |
| Xe.dll                                       | 2022.160.4085.2 | 718888    | 27-Sep-2023 | 14:08 | x64      |
| Xpqueue.dll                                  | 2022.160.4085.2 | 100392    | 27-Sep-2023 | 14:08 | x64      |
| Xpstar.dll                                   | 2022.160.4085.2 | 534584    | 27-Sep-2023 | 14:08 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version  | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commanddest.dll                                      | 2022.160.4085.2 | 272424    | 27-Sep-2023 | 12:41 | x64      |
| Datacollectortasks.dll                               | 2022.160.4085.2 | 227368    | 27-Sep-2023 | 12:41 | x64      |
| Distrib.exe                                          | 2022.160.4085.2 | 260136    | 27-Sep-2023 | 12:41 | x64      |
| Dteparse.dll                                         | 2022.160.4085.2 | 133160    | 27-Sep-2023 | 12:41 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4085.2 | 178232    | 27-Sep-2023 | 12:41 | x64      |
| Dtepkg.dll                                           | 2022.160.4085.2 | 153640    | 27-Sep-2023 | 12:41 | x64      |
| Dtexec.exe                                           | 2022.160.4085.2 | 76856     | 27-Sep-2023 | 12:41 | x64      |
| Dts.dll                                              | 2022.160.4085.2 | 3266600   | 27-Sep-2023 | 12:41 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4085.2 | 493608    | 27-Sep-2023 | 12:41 | x64      |
| Dtsconn.dll                                          | 2022.160.4085.2 | 550968    | 27-Sep-2023 | 12:41 | x64      |
| Dtshost.exe                                          | 2022.160.4085.2 | 120376    | 27-Sep-2023 | 12:41 | x64      |
| Dtspipeline.dll                                      | 2022.160.4085.2 | 1337384   | 27-Sep-2023 | 12:41 | x64      |
| Dtuparse.dll                                         | 2022.160.4085.2 | 104488    | 27-Sep-2023 | 12:41 | x64      |
| Dtutil.exe                                           | 2022.160.4085.2 | 166440    | 27-Sep-2023 | 12:41 | x64      |
| Exceldest.dll                                        | 2022.160.4085.2 | 284712    | 27-Sep-2023 | 12:41 | x64      |
| Excelsrc.dll                                         | 2022.160.4085.2 | 305192    | 27-Sep-2023 | 12:41 | x64      |
| Execpackagetask.dll                                  | 2022.160.4085.2 | 182312    | 27-Sep-2023 | 12:41 | x64      |
| Flatfiledest.dll                                     | 2022.160.4085.2 | 423888    | 27-Sep-2023 | 12:41 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4085.2 | 440360    | 27-Sep-2023 | 12:41 | x64      |
| Logread.exe                                          | 2022.160.4085.2 | 788520    | 27-Sep-2023 | 12:41 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.222     | 2933816   | 27-Sep-2023 | 12:40 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4085.2     | 30672     | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4085.2     | 391120    | 27-Sep-2023 | 12:41 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4085.2 | 1705920   | 27-Sep-2023 | 12:41 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4085.2     | 555048    | 27-Sep-2023 | 12:41 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4085.2 | 124984    | 27-Sep-2023 | 12:41 | x64      |
| Msgprox.dll                                          | 2022.160.4085.2 | 313384    | 27-Sep-2023 | 12:41 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 2729960   | 27-Sep-2023 | 12:41 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 153560    | 27-Sep-2023 | 12:41 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 27-Sep-2023 | 12:41 | x86      |
| Oledbdest.dll                                        | 2022.160.4085.2 | 288824    | 27-Sep-2023 | 12:41 | x64      |
| Oledbsrc.dll                                         | 2022.160.4085.2 | 313384    | 27-Sep-2023 | 12:41 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4085.2 | 522280    | 27-Sep-2023 | 12:41 | x64      |
| Rawdest.dll                                          | 2022.160.4085.2 | 227368    | 27-Sep-2023 | 12:41 | x64      |
| Rawsource.dll                                        | 2022.160.4085.2 | 215080    | 27-Sep-2023 | 12:41 | x64      |
| Rdistcom.dll                                         | 2022.160.4085.2 | 940072    | 27-Sep-2023 | 12:41 | x64      |
| Recordsetdest.dll                                    | 2022.160.4085.2 | 206888    | 27-Sep-2023 | 12:41 | x64      |
| Repldp.dll                                           | 2022.160.4085.2 | 337960    | 27-Sep-2023 | 12:41 | x64      |
| Replerrx.dll                                         | 2022.160.4085.2 | 198592    | 27-Sep-2023 | 12:41 | x64      |
| Replisapi.dll                                        | 2022.160.4085.2 | 419896    | 27-Sep-2023 | 12:41 | x64      |
| Replmerg.exe                                         | 2022.160.4085.2 | 595904    | 27-Sep-2023 | 12:41 | x64      |
| Replprov.dll                                         | 2022.160.4085.2 | 890936    | 27-Sep-2023 | 12:41 | x64      |
| Replrec.dll                                          | 2022.160.4085.2 | 1058856   | 27-Sep-2023 | 12:41 | x64      |
| Replsub.dll                                          | 2022.160.4085.2 | 501816    | 27-Sep-2023 | 12:41 | x64      |
| Spresolv.dll                                         | 2022.160.4085.2 | 300992    | 27-Sep-2023 | 12:41 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:40 | x64      |
| Sqlcmd.exe                                           | 2022.160.4085.2 | 276520    | 27-Sep-2023 | 12:41 | x64      |
| Sqldistx.dll                                         | 2022.160.4085.2 | 268224    | 27-Sep-2023 | 12:41 | x64      |
| Sqlmergx.dll                                         | 2022.160.4085.2 | 423976    | 27-Sep-2023 | 12:41 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4085.2 | 210984    | 27-Sep-2023 | 12:41 | x64      |
| Txagg.dll                                            | 2022.160.4085.2 | 395320    | 27-Sep-2023 | 12:41 | x64      |
| Txbdd.dll                                            | 2022.160.4085.2 | 190520    | 27-Sep-2023 | 12:41 | x64      |
| Txdatacollector.dll                                  | 2022.160.4085.2 | 469032    | 27-Sep-2023 | 12:41 | x64      |
| Txdataconvert.dll                                    | 2022.160.4085.2 | 333864    | 27-Sep-2023 | 12:41 | x64      |
| Txderived.dll                                        | 2022.160.4085.2 | 632872    | 27-Sep-2023 | 12:41 | x64      |
| Txlookup.dll                                         | 2022.160.4085.2 | 608312    | 27-Sep-2023 | 12:41 | x64      |
| Txmerge.dll                                          | 2022.160.4085.2 | 243752    | 27-Sep-2023 | 12:41 | x64      |
| Txmergejoin.dll                                      | 2022.160.4085.2 | 301096    | 27-Sep-2023 | 12:41 | x64      |
| Txmulticast.dll                                      | 2022.160.4085.2 | 145448    | 27-Sep-2023 | 12:41 | x64      |
| Txrowcount.dll                                       | 2022.160.4085.2 | 145448    | 27-Sep-2023 | 12:41 | x64      |
| Txsort.dll                                           | 2022.160.4085.2 | 276520    | 27-Sep-2023 | 12:41 | x64      |
| Txsplit.dll                                          | 2022.160.4085.2 | 620584    | 27-Sep-2023 | 12:41 | x64      |
| Txunionall.dll                                       | 2022.160.4085.2 | 194600    | 27-Sep-2023 | 12:41 | x64      |
| Xe.dll                                               | 2022.160.4085.2 | 718888    | 27-Sep-2023 | 12:41 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4085.2 | 100304    | 27-Sep-2023 | 12:41 | x64      |
| Exthost.exe                   | 2022.160.4085.2 | 247760    | 27-Sep-2023 | 12:41 | x64      |
| Launchpad.exe                 | 2022.160.4085.2 | 1447872   | 27-Sep-2023 | 12:41 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:41 | x64      |
| Sqlsatellite.dll              | 2022.160.4085.2 | 1255360   | 27-Sep-2023 | 12:41 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4085.2 | 710696    | 27-Sep-2023 | 12:41 | x64      |
| Fdhost.exe               | 2022.160.4085.2 | 153536    | 27-Sep-2023 | 12:41 | x64      |
| Fdlauncher.exe           | 2022.160.4085.2 | 100408    | 27-Sep-2023 | 12:41 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:41 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 27-Sep-2023 | 12:42 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 27-Sep-2023 | 12:42 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 27-Sep-2023 | 12:42 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 27-Sep-2023 | 12:42 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 27-Sep-2023 | 12:42 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 27-Sep-2023 | 12:42 | x86      |
| Commanddest.dll                                               | 2022.160.4085.2 | 272424    | 27-Sep-2023 | 12:42 | x64      |
| Commanddest.dll                                               | 2022.160.4085.2 | 231376    | 27-Sep-2023 | 12:42 | x86      |
| Dteparse.dll                                                  | 2022.160.4085.2 | 133160    | 27-Sep-2023 | 12:42 | x64      |
| Dteparse.dll                                                  | 2022.160.4085.2 | 116776    | 27-Sep-2023 | 12:42 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4085.2 | 178232    | 27-Sep-2023 | 12:42 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4085.2 | 165928    | 27-Sep-2023 | 12:42 | x86      |
| Dtepkg.dll                                                    | 2022.160.4085.2 | 153640    | 27-Sep-2023 | 12:42 | x64      |
| Dtepkg.dll                                                    | 2022.160.4085.2 | 129080    | 27-Sep-2023 | 12:42 | x86      |
| Dtexec.exe                                                    | 2022.160.4085.2 | 76856     | 27-Sep-2023 | 12:42 | x64      |
| Dtexec.exe                                                    | 2022.160.4085.2 | 65064     | 27-Sep-2023 | 12:42 | x86      |
| Dts.dll                                                       | 2022.160.4085.2 | 2860992   | 27-Sep-2023 | 12:42 | x86      |
| Dts.dll                                                       | 2022.160.4085.2 | 3266600   | 27-Sep-2023 | 12:42 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4085.2 | 444456    | 27-Sep-2023 | 12:42 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4085.2 | 493608    | 27-Sep-2023 | 12:42 | x64      |
| Dtsconn.dll                                                   | 2022.160.4085.2 | 464936    | 27-Sep-2023 | 12:42 | x86      |
| Dtsconn.dll                                                   | 2022.160.4085.2 | 550968    | 27-Sep-2023 | 12:42 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4085.2 | 114744    | 27-Sep-2023 | 12:42 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4085.2 | 94760     | 27-Sep-2023 | 12:42 | x86      |
| Dtshost.exe                                                   | 2022.160.4085.2 | 120376    | 27-Sep-2023 | 12:42 | x64      |
| Dtshost.exe                                                   | 2022.160.4085.2 | 98344     | 27-Sep-2023 | 12:42 | x86      |
| Dtspipeline.dll                                               | 2022.160.4085.2 | 1337384   | 27-Sep-2023 | 12:42 | x64      |
| Dtspipeline.dll                                               | 2022.160.4085.2 | 1144768   | 27-Sep-2023 | 12:42 | x86      |
| Dtuparse.dll                                                  | 2022.160.4085.2 | 104488    | 27-Sep-2023 | 12:42 | x64      |
| Dtuparse.dll                                                  | 2022.160.4085.2 | 88104     | 27-Sep-2023 | 12:42 | x86      |
| Dtutil.exe                                                    | 2022.160.4085.2 | 142376    | 27-Sep-2023 | 12:42 | x86      |
| Dtutil.exe                                                    | 2022.160.4085.2 | 166440    | 27-Sep-2023 | 12:42 | x64      |
| Exceldest.dll                                                 | 2022.160.4085.2 | 284712    | 27-Sep-2023 | 12:42 | x64      |
| Exceldest.dll                                                 | 2022.160.4085.2 | 247848    | 27-Sep-2023 | 12:42 | x86      |
| Excelsrc.dll                                                  | 2022.160.4085.2 | 305192    | 27-Sep-2023 | 12:42 | x64      |
| Excelsrc.dll                                                  | 2022.160.4085.2 | 264248    | 27-Sep-2023 | 12:42 | x86      |
| Execpackagetask.dll                                           | 2022.160.4085.2 | 182312    | 27-Sep-2023 | 12:42 | x64      |
| Execpackagetask.dll                                           | 2022.160.4085.2 | 149544    | 27-Sep-2023 | 12:42 | x86      |
| Flatfiledest.dll                                              | 2022.160.4085.2 | 423888    | 27-Sep-2023 | 12:42 | x64      |
| Flatfiledest.dll                                              | 2022.160.4085.2 | 374824    | 27-Sep-2023 | 12:42 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4085.2 | 440360    | 27-Sep-2023 | 12:42 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4085.2 | 391208    | 27-Sep-2023 | 12:42 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4085.2     | 120872    | 27-Sep-2023 | 12:42 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4085.2     | 120888    | 27-Sep-2023 | 12:42 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933816   | 27-Sep-2023 | 12:39 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933824   | 27-Sep-2023 | 12:39 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4085.2     | 509888    | 27-Sep-2023 | 12:42 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4085.2     | 509904    | 27-Sep-2023 | 12:42 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4085.2     | 391120    | 27-Sep-2023 | 12:42 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4085.2     | 219176    | 27-Sep-2023 | 12:42 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4085.2 | 100392    | 27-Sep-2023 | 12:42 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4085.2 | 124984    | 27-Sep-2023 | 12:42 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.222 | 10165808  | 27-Sep-2023 | 12:39 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Sep-2023 | 12:42 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Sep-2023 | 12:42 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Sep-2023 | 12:42 | x86      |
| Odbcdest.dll                                                  | 2022.160.4085.2 | 383016    | 27-Sep-2023 | 12:42 | x64      |
| Odbcdest.dll                                                  | 2022.160.4085.2 | 342056    | 27-Sep-2023 | 12:42 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4085.2 | 399416    | 27-Sep-2023 | 12:42 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4085.2 | 350248    | 27-Sep-2023 | 12:42 | x86      |
| Oledbdest.dll                                                 | 2022.160.4085.2 | 288824    | 27-Sep-2023 | 12:42 | x64      |
| Oledbdest.dll                                                 | 2022.160.4085.2 | 247760    | 27-Sep-2023 | 12:42 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4085.2 | 313384    | 27-Sep-2023 | 12:42 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4085.2 | 268240    | 27-Sep-2023 | 12:42 | x86      |
| Rawdest.dll                                                   | 2022.160.4085.2 | 227368    | 27-Sep-2023 | 12:42 | x64      |
| Rawdest.dll                                                   | 2022.160.4085.2 | 190520    | 27-Sep-2023 | 12:42 | x86      |
| Rawsource.dll                                                 | 2022.160.4085.2 | 215080    | 27-Sep-2023 | 12:42 | x64      |
| Rawsource.dll                                                 | 2022.160.4085.2 | 186424    | 27-Sep-2023 | 12:42 | x86      |
| Recordsetdest.dll                                             | 2022.160.4085.2 | 206888    | 27-Sep-2023 | 12:42 | x64      |
| Recordsetdest.dll                                             | 2022.160.4085.2 | 174136    | 27-Sep-2023 | 12:42 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4085.2 | 137256    | 27-Sep-2023 | 12:39 | x64      |
| Sqlceip.exe                                                   | 16.0.4085.2     | 301096    | 27-Sep-2023 | 12:42 | x86      |
| Sqldest.dll                                                   | 2022.160.4085.2 | 256056    | 27-Sep-2023 | 12:42 | x86      |
| Sqldest.dll                                                   | 2022.160.4085.2 | 288808    | 27-Sep-2023 | 12:42 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4085.2 | 174136    | 27-Sep-2023 | 12:42 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4085.2 | 210984    | 27-Sep-2023 | 12:42 | x64      |
| Txagg.dll                                                     | 2022.160.4085.2 | 395320    | 27-Sep-2023 | 12:42 | x64      |
| Txagg.dll                                                     | 2022.160.4085.2 | 346152    | 27-Sep-2023 | 12:42 | x86      |
| Txbdd.dll                                                     | 2022.160.4085.2 | 149440    | 27-Sep-2023 | 12:42 | x86      |
| Txbdd.dll                                                     | 2022.160.4085.2 | 190520    | 27-Sep-2023 | 12:42 | x64      |
| Txbestmatch.dll                                               | 2022.160.4085.2 | 661544    | 27-Sep-2023 | 12:42 | x64      |
| Txbestmatch.dll                                               | 2022.160.4085.2 | 567232    | 27-Sep-2023 | 12:42 | x86      |
| Txcache.dll                                                   | 2022.160.4085.2 | 202808    | 27-Sep-2023 | 12:42 | x64      |
| Txcache.dll                                                   | 2022.160.4085.2 | 170024    | 27-Sep-2023 | 12:42 | x86      |
| Txcharmap.dll                                                 | 2022.160.4085.2 | 325672    | 27-Sep-2023 | 12:42 | x64      |
| Txcharmap.dll                                                 | 2022.160.4085.2 | 280528    | 27-Sep-2023 | 12:42 | x86      |
| Txcopymap.dll                                                 | 2022.160.4085.2 | 202792    | 27-Sep-2023 | 12:42 | x64      |
| Txcopymap.dll                                                 | 2022.160.4085.2 | 165928    | 27-Sep-2023 | 12:42 | x86      |
| Txdataconvert.dll                                             | 2022.160.4085.2 | 333864    | 27-Sep-2023 | 12:42 | x64      |
| Txdataconvert.dll                                             | 2022.160.4085.2 | 288808    | 27-Sep-2023 | 12:42 | x86      |
| Txderived.dll                                                 | 2022.160.4085.2 | 632872    | 27-Sep-2023 | 12:42 | x64      |
| Txderived.dll                                                 | 2022.160.4085.2 | 559144    | 27-Sep-2023 | 12:42 | x86      |
| Txfileextractor.dll                                           | 2022.160.4085.2 | 219176    | 27-Sep-2023 | 12:42 | x64      |
| Txfileextractor.dll                                           | 2022.160.4085.2 | 186424    | 27-Sep-2023 | 12:42 | x86      |
| Txfileinserter.dll                                            | 2022.160.4085.2 | 219176    | 27-Sep-2023 | 12:42 | x64      |
| Txfileinserter.dll                                            | 2022.160.4085.2 | 186408    | 27-Sep-2023 | 12:42 | x86      |
| Txgroupdups.dll                                               | 2022.160.4085.2 | 403496    | 27-Sep-2023 | 12:42 | x64      |
| Txgroupdups.dll                                               | 2022.160.4085.2 | 354344    | 27-Sep-2023 | 12:42 | x86      |
| Txlineage.dll                                                 | 2022.160.4085.2 | 157752    | 27-Sep-2023 | 12:42 | x64      |
| Txlineage.dll                                                 | 2022.160.4085.2 | 129064    | 27-Sep-2023 | 12:42 | x86      |
| Txlookup.dll                                                  | 2022.160.4085.2 | 522280    | 27-Sep-2023 | 12:42 | x86      |
| Txlookup.dll                                                  | 2022.160.4085.2 | 608312    | 27-Sep-2023 | 12:42 | x64      |
| Txmerge.dll                                                   | 2022.160.4085.2 | 243752    | 27-Sep-2023 | 12:42 | x64      |
| Txmerge.dll                                                   | 2022.160.4085.2 | 194600    | 27-Sep-2023 | 12:42 | x86      |
| Txmergejoin.dll                                               | 2022.160.4085.2 | 256040    | 27-Sep-2023 | 12:42 | x86      |
| Txmergejoin.dll                                               | 2022.160.4085.2 | 301096    | 27-Sep-2023 | 12:42 | x64      |
| Txmulticast.dll                                               | 2022.160.4085.2 | 116776    | 27-Sep-2023 | 12:42 | x86      |
| Txmulticast.dll                                               | 2022.160.4085.2 | 145448    | 27-Sep-2023 | 12:42 | x64      |
| Txpivot.dll                                                   | 2022.160.4085.2 | 198696    | 27-Sep-2023 | 12:42 | x86      |
| Txpivot.dll                                                   | 2022.160.4085.2 | 239656    | 27-Sep-2023 | 12:42 | x64      |
| Txrowcount.dll                                                | 2022.160.4085.2 | 116776    | 27-Sep-2023 | 12:42 | x86      |
| Txrowcount.dll                                                | 2022.160.4085.2 | 145448    | 27-Sep-2023 | 12:42 | x64      |
| Txsampling.dll                                                | 2022.160.4085.2 | 153656    | 27-Sep-2023 | 12:42 | x86      |
| Txsampling.dll                                                | 2022.160.4085.2 | 186408    | 27-Sep-2023 | 12:42 | x64      |
| Txscd.dll                                                     | 2022.160.4085.2 | 198696    | 27-Sep-2023 | 12:42 | x86      |
| Txscd.dll                                                     | 2022.160.4085.2 | 235576    | 27-Sep-2023 | 12:42 | x64      |
| Txsort.dll                                                    | 2022.160.4085.2 | 231464    | 27-Sep-2023 | 12:42 | x86      |
| Txsort.dll                                                    | 2022.160.4085.2 | 276520    | 27-Sep-2023 | 12:42 | x64      |
| Txsplit.dll                                                   | 2022.160.4085.2 | 550952    | 27-Sep-2023 | 12:42 | x86      |
| Txsplit.dll                                                   | 2022.160.4085.2 | 620584    | 27-Sep-2023 | 12:42 | x64      |
| Txtermextraction.dll                                          | 2022.160.4085.2 | 8648744   | 27-Sep-2023 | 12:42 | x86      |
| Txtermextraction.dll                                          | 2022.160.4085.2 | 8702008   | 27-Sep-2023 | 12:42 | x64      |
| Txtermlookup.dll                                              | 2022.160.4085.2 | 4138944   | 27-Sep-2023 | 12:42 | x86      |
| Txtermlookup.dll                                              | 2022.160.4085.2 | 4184104   | 27-Sep-2023 | 12:42 | x64      |
| Txunionall.dll                                                | 2022.160.4085.2 | 153640    | 27-Sep-2023 | 12:42 | x86      |
| Txunionall.dll                                                | 2022.160.4085.2 | 194600    | 27-Sep-2023 | 12:42 | x64      |
| Txunpivot.dll                                                 | 2022.160.4085.2 | 178216    | 27-Sep-2023 | 12:42 | x86      |
| Txunpivot.dll                                                 | 2022.160.4085.2 | 215096    | 27-Sep-2023 | 12:42 | x64      |
| Xe.dll                                                        | 2022.160.4085.2 | 641064    | 27-Sep-2023 | 12:42 | x86      |
| Xe.dll                                                        | 2022.160.4085.2 | 718888    | 27-Sep-2023 | 12:42 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1029.0     | 559520    | 27-Sep-2023 | 13:50 | x86      |
| Dmsnative.dll                                                        | 2022.160.1029.0 | 152480    | 27-Sep-2023 | 13:50 | x64      |
| Dwengineservice.dll                                                  | 16.0.1029.0     | 44960     | 27-Sep-2023 | 13:50 | x86      |
| Instapi150.dll                                                       | 2022.160.4085.2 | 104488    | 27-Sep-2023 | 13:50 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1029.0     | 67536     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1029.0     | 293328    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1029.0     | 1958352   | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1029.0     | 169424    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1029.0     | 647120    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1029.0     | 246216    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1029.0     | 139216    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1029.0     | 79776     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1029.0     | 51104     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1029.0     | 88480     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1029.0     | 1129376   | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1029.0     | 80848     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1029.0     | 70560     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1029.0     | 35232     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1029.0     | 30624     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1029.0     | 46496     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1029.0     | 21456     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1029.0     | 26528     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1029.0     | 131536    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1029.0     | 86480     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1029.0     | 100768    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1029.0     | 293280    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 120272    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 138192    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 141216    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 137680    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 150480    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 139680    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 134608    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 176592    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 117704    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 136656    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1029.0     | 72656     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1029.0     | 21968     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1029.0     | 37280     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1029.0     | 128928    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1029.0     | 3064736   | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1029.0     | 3955616   | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 118176    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133024    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 137680    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133584    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 148432    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 134048    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 130464    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 170912    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 115152    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 132000    | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1029.0     | 67488     | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1029.0     | 2682832   | 27-Sep-2023 | 13:50 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1029.0     | 2436512   | 27-Sep-2023 | 13:50 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4085.2 | 296896    | 27-Sep-2023 | 13:50 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4085.2 | 7796776   | 27-Sep-2023 | 13:50 | x64      |
| Secforwarder.dll                                                     | 2022.160.4085.2 | 83904     | 27-Sep-2023 | 13:50 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1029.0 | 61392     | 27-Sep-2023 | 13:50 | x64      |
| Sqldk.dll                                                            | 2022.160.4085.2 | 4007872   | 27-Sep-2023 | 13:50 | x64      |
| Sqldumper.exe                                                        | 2022.160.4085.2 | 436264    | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 1751080   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4577336   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 3749944   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4577216   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4479016   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 2443200   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 2385856   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4208680   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4192208   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 1685544   | 27-Sep-2023 | 13:50 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4085.2 | 4442152   | 27-Sep-2023 | 13:50 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 27-Sep-2023 | 13:50 | x64      |
| Sqlos.dll                                                            | 2022.160.4085.2 | 51240     | 27-Sep-2023 | 13:50 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1029.0 | 4841424   | 27-Sep-2023 | 13:50 | x64      |
| Sqltses.dll                                                          | 2022.160.4085.2 | 9386024   | 27-Sep-2023 | 13:50 | x64      |

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
