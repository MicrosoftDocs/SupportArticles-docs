---
title: Cumulative update 7 for SQL Server 2022 (KB5028743)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 7 (KB5028743).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5028743
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5028743 - Cumulative Update 7 for SQL Server 2022

_Release Date:_ &nbsp; August 10, 2023  
_Version:_ &nbsp; 16.0.4065.3

## Summary

This article describes Cumulative Update package 7 (CU7) for Microsoft SQL Server 2022. This update contains 20 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 6, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4065.3**, file version: **2022.160.4065.3**
- Analysis Services - Product version: **16.0.43.221**, file version: **2022.160.43.221**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|--------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2469661>[2469661](#2469661) </a>| Fixes an issue in which the validation of a custom input mask fails. After applying this fix, you can use a custom input mask with the time part. | Master Data Services | Master Data Services | Windows |
| <a id=2516796>[2516796](#2516796) </a>| Fixes an issue in which you can't see the **Created By** and **Updated By** fields in the **View History** window when you use the Master Data Services (MDS) Add-in for Excel. | Master Data Services | Master Data Services | Windows |
| <a id=2518605>[2518605](#2518605) </a>| Fixes an issue in which an error may occur when you download an attachment uploaded previously in a Master Data Services model.| Master Data Services | Master Data Services | Windows |
| <a id=2500053>[2500053](#2500053) </a>| Fixes an access violation in `sqllang!FReadDataDirect` that you encounter during network exchanges between an instance of SQL Server and a client. | SQL Connectivity | SQL Connectivity | All |
| <a id=1550865>[1550865](#1550865) </a>| Fixes an issue in which the `BACKUP` or `RESTORE` statement doesn't time out even after a long time when the S3 server is unreachable or the hostname/IP address/port number that's given in the URL is incorrect. After applying this fix, backing up or restoring a database to the S3 server fails quickly.| SQL Server Engine| Backup Restore| All|
| <a id=2491363>[2491363](#2491363) </a>| Fixes an issue in which a checkpoint process on an In-Memory OLTP database may get stuck, and the log size keeps increasing. | SQL Server Engine | In-Memory OLTP | All |
| <a id=2369109>[2369109](#2369109) </a>| [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id=2423760>[2423760](#2423760) </a>| Fixes the following SQL Server assertion failure: </br></br>Error: 17065, Severity: 16, State: 1. </br>Server Assertion: File: \<typinfo.cpp>, line = 1153 Failed Assertion = 'false' Invalid comparison due to NO COLLATION. | SQL Server Engine | Programmability | All |
| <a id=2528280>[2528280](#2528280) </a>| Fixes a dump issue that you encounter when you run the `APPROX_COUNT_DISTINCT` query, which affects the query that has at least two approximate count aggregates where at least one aggregate is on a **char** column and the **char** column isn't the first aggregate in the query.| SQL Server Engine| Programmability | All|
| <a id=2512016>[2512016](#2512016) </a>| Fixes an access violation that you encounter during the initialization of Query Store if a parameter sensitive plan (PSP) optimization query variant has inconsistent data within the Query Store. | SQL Server Engine | Query Execution | All |
| <a id=2458680>[2458680](#2458680) </a>| Fixes a manual cleanup issue in which the repeated lock escalations on the tables cause contention and slowness in cleaning up the expired change tracking metadata. </br></br>**Note**: You need to turn on trace flag 8284.| SQL Server Engine | Replication | All |
| <a id=2506726>[2506726](#2506726) </a>| Improves `sp_addpublication_snapshot` by exposing additional parameters (`@distributor_security_mode`, `@distributor_login`, and `@distributor_password`). With these parameters, you can configure the Snapshot Agent to connect to the Distributor using SQL Server Authentication. Before this fix, the Snapshot Agent connects to the Distributor with Windows Authentication, and you can't configure it to connect to the Distributor using SQL Server Authentication. | SQL Server Engine| Replication | All|
| <a id=2491020>[2491020](#2491020) </a>| Fixes an issue in which running `sp_change_users_login` reports the following error if the database collation is `Chinese_PRC_CI_AS`: </br></br>Msg 9833, Level 16, State 3, Line \<LineNumber> </br>Invalid data for DBCS-encoded characters.| SQL Server Engine | Security Infrastructure | All |
| <a id=2522765>[2522765](#2522765) </a>| Fixes the incorrect masking behavior that you encounter when you use an `INSTEAD OF` trigger that's defined on a table, which contains columns that use dynamic data masking (DDM).| SQL Server Engine | Security Infrastructure | All |
| <a id=2526528>[2526528](#2526528) </a>| Fixes error 207 (Invalid column name '\<ColumnName>') that you encounter when you run a user-defined function (UDF), which references a dropped column that uses dynamic data masking (DDM). | SQL Server Engine | Security Infrastructure | All |
| <a id=2494984>[2494984](#2494984) </a>| Fixes a memory leak issue that you encounter on `MEMOBJ_STORAGEMANAGEMENT` when you try to use Backup TO URL for AWS S3-compatible object storage. | SQL Server Engine | SQL OS | All |
| <a id=2475019>[2475019](#2475019) </a> </br><a id=2568409>[2568409](#2568409) </a> | [Improvement: Make several enhancements to the SQLIOSim utility (KB5028786)](make-enhancements-sqliosim-utility.md) | SQL Server Engine | Storage Management | All |
| <a id=2337613>[2337613](#2337613) </a>| Fixes an issue in which running `DBCC CHECKTABLE` may create snapshot files, even if a user fails the table-level permission check. | SQL Server Engine | Storage Management | All |
| <a id=2491770>[2491770](#2491770) </a>| Fixes an issue in which the number of the Log Writer threads is inconsistent when the SQL Server instance is affinitized to a subset of NUMA nodes. | SQL Server Engine | Transaction Services | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU7 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/08/sqlserver2022-kb5028743-x64_18dab43fdb947ffa86ef4ec669666bef2f4221c2.exe)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5028743-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5028743-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5028743-x64.exe| 26D68D5EE50EDB740AB35E37638435FE5DF51E38EC5D089F22F3FEBB0E8EA766 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.221 | 336792    | 25-Jul-23 | 18:39 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.221     | 2903464   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 25-Jul-23 | 18:39 | x86      |
| Msmdctr.dll                                         | 2022.160.43.221 | 38864     | 25-Jul-23 | 18:39 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.221 | 71768016  | 25-Jul-23 | 18:39 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.221 | 53929928  | 25-Jul-23 | 18:39 | x86      |
| Msmdpump.dll                                        | 2022.160.43.221 | 10335184  | 25-Jul-23 | 18:39 | x64      |
| Msmdredir.dll                                       | 2022.160.43.221 | 8131992   | 25-Jul-23 | 18:39 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.221 | 71309264  | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 956328    | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1884096   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1671080   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1880520   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1847720   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1146824   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1139624   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1768896   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1748392   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 932288    | 25-Jul-23 | 18:39 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1837000   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 954816    | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1882024   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1668040   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1875912   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1844168   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1144744   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1138088   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1764808   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1744840   | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 932264    | 25-Jul-23 | 18:39 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1832360   | 25-Jul-23 | 18:39 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.221 | 10083792  | 25-Jul-23 | 18:39 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.221 | 8265640   | 25-Jul-23 | 18:39 | x86      |
| Msolap.dll                                          | 2022.160.43.221 | 10970064  | 25-Jul-23 | 18:39 | x64      |
| Msolap.dll                                          | 2022.160.43.221 | 8744912   | 25-Jul-23 | 18:39 | x86      |
| Msolui.dll                                          | 2022.160.43.221 | 308176    | 25-Jul-23 | 18:39 | x64      |
| Msolui.dll                                          | 2022.160.43.221 | 289744    | 25-Jul-23 | 18:39 | x86      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 25-Jul-23 | 18:39 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 25-Jul-23 | 18:39 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:39 | x64      |
| Sqlceip.exe                                         | 16.0.4065.3     | 300944    | 25-Jul-23 | 18:39 | x86      |
| Sqldumper.exe                                       | 2022.160.4065.3 | 227264    | 25-Jul-23 | 18:39 | x86      |
| Sqldumper.exe                                       | 2022.160.4065.3 | 260032    | 25-Jul-23 | 18:39 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 25-Jul-23 | 18:39 | x86      |
| Tmapi.dll                                           | 2022.160.43.221 | 5884312   | 25-Jul-23 | 18:39 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.221 | 5575064   | 25-Jul-23 | 18:39 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.221 | 1481112   | 25-Jul-23 | 18:39 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.221 | 7198120   | 25-Jul-23 | 18:39 | x64      |
| Xmsrv.dll                                           | 2022.160.43.221 | 26594256  | 25-Jul-23 | 18:39 | x64      |
| Xmsrv.dll                                           | 2022.160.43.221 | 35896272  | 25-Jul-23 | 18:39 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4065.3 | 104336    | 25-Jul-23 | 18:39 | x64      |
| Instapi150.dll                             | 2022.160.4065.3 | 79808     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.221     | 2633664   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.221     | 2633680   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.221     | 2933200   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.221     | 2323352   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.221     | 2323408   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4065.3     | 554896    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4065.3     | 554904    | 25-Jul-23 | 18:39 | x86      |
| Msasxpress.dll                             | 2022.160.43.221 | 32680     | 25-Jul-23 | 18:39 | x64      |
| Msasxpress.dll                             | 2022.160.43.221 | 27600     | 25-Jul-23 | 18:39 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:39 | x64      |
| Sqldumper.exe                              | 2022.160.4065.3 | 227264    | 25-Jul-23 | 18:39 | x86      |
| Sqldumper.exe                              | 2022.160.4065.3 | 260032    | 25-Jul-23 | 18:39 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4065.3 | 395216    | 25-Jul-23 | 18:39 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4065.3 | 456640    | 25-Jul-23 | 18:39 | x64      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4065.3     | 2070480   | 25-Jul-23 | 18:39 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:39 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4065.3  | 600000    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4065.3  | 600016    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4065.3  | 173984    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4065.3  | 174032    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4065.3  | 1857432   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4065.3  | 370576    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4065.3  | 370640    | 25-Jul-23 | 18:39 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 25-Jul-23 | 19:46 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 25-Jul-23 | 19:46 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4065.3 | 4719008   | 25-Jul-23 | 20:04 | x64      |
| Aetm-enclave.dll                             | 2022.160.4065.3 | 4673488   | 25-Jul-23 | 20:04 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4065.3 | 4909080   | 25-Jul-23 | 20:04 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4065.3 | 4874456   | 25-Jul-23 | 20:04 | x64      |
| Fssres.dll                                   | 2022.160.4065.3 | 100248    | 25-Jul-23 | 20:04 | x64      |
| Hadrres.dll                                  | 2022.160.4065.3 | 227224    | 25-Jul-23 | 20:04 | x64      |
| Hkcompile.dll                                | 2022.160.4065.3 | 1411008   | 25-Jul-23 | 20:04 | x64      |
| Hkengine.dll                                 | 2022.160.4065.3 | 5765056   | 25-Jul-23 | 20:04 | x64      |
| Hkruntime.dll                                | 2022.160.4065.3 | 190352    | 25-Jul-23 | 20:04 | x64      |
| Hktempdb.dll                                 | 2022.160.4065.3 | 71616     | 25-Jul-23 | 20:04 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.221     | 2322384   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4065.3 | 333720    | 25-Jul-23 | 20:04 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4065.3 | 96152     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 30656     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 38848     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 34768     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 38848     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 38848     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 30656     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 30656     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 34752     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 38848     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 30672     | 25-Jul-23 | 20:04 | x64      |
| `Odsole70.rll`                                 | 16.0.4065.3     | 38848     | 25-Jul-23 | 20:04 | x64      |
| Qds.dll                                      | 2022.160.4065.3 | 1808320   | 25-Jul-23 | 20:04 | x64      |
| Rsfxft.dll                                   | 2022.160.4065.3 | 55240     | 25-Jul-23 | 20:04 | x64      |
| Secforwarder.dll                             | 2022.160.4065.3 | 83864     | 25-Jul-23 | 19:46 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4065.3 | 137152    | 25-Jul-23 | 19:46 | x64      |
| Sqlaccess.dll                                | 2022.160.4065.3 | 444312    | 25-Jul-23 | 20:04 | x64      |
| Sqlagent.exe                                 | 2022.160.4065.3 | 726936    | 25-Jul-23 | 20:04 | x64      |
| Sqlceip.exe                                  | 16.0.4065.3     | 300944    | 25-Jul-23 | 20:04 | x86      |
| Sqlctr160.dll                                | 2022.160.4065.3 | 128968    | 25-Jul-23 | 20:04 | x86      |
| Sqlctr160.dll                                | 2022.160.4065.3 | 157632    | 25-Jul-23 | 20:04 | x64      |
| Sqldk.dll                                    | 2022.160.4065.3 | 4024208   | 25-Jul-23 | 20:04 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 1746880   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3848128   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4065232   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4573136   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4704192   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3749824   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3934144   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4573120   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4401088   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4474816   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 2443216   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 2385856   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4261824   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3897280   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4413392   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4204480   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4188096   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3975104   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 3848128   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 1685440   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4298704   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4065.3 | 4437952   | 25-Jul-23 | 19:46 | x64      |
| Sqliosim.com                                 | 2022.160.4065.3 | 386968    | 25-Jul-23 | 20:04 | x64      |
| Sqliosim.exe                                 | 2022.160.4065.3 | 3057600   | 25-Jul-23 | 20:04 | x64      |
| Sqllang.dll                                  | 2022.160.4065.3 | 48625568  | 25-Jul-23 | 20:04 | x64      |
| Sqlmin.dll                                   | 2022.160.4065.3 | 51333024  | 25-Jul-23 | 20:04 | x64      |
| Sqlos.dll                                    | 2022.160.4065.3 | 51136     | 25-Jul-23 | 20:04 | x64      |
| Sqlrepss.dll                                 | 2022.160.4065.3 | 137160    | 25-Jul-23 | 20:04 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4065.3 | 51152     | 25-Jul-23 | 20:04 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4065.3 | 5830592   | 25-Jul-23 | 20:04 | x64      |
| Sqlservr.exe                                 | 2022.160.4065.3 | 722880    | 25-Jul-23 | 20:04 | x64      |
| Sqltses.dll                                  | 2022.160.4065.3 | 9389968   | 25-Jul-23 | 20:04 | x64      |
| Sqsrvres.dll                                 | 2022.160.4065.3 | 305104    | 25-Jul-23 | 20:04 | x64      |
| Svl.dll                                      | 2022.160.4065.3 | 247744    | 25-Jul-23 | 20:04 | x64      |
| Xe.dll                                       | 2022.160.4065.3 | 718800    | 25-Jul-23 | 20:04 | x64      |
| Xpstar.dll                                   | 2022.160.4065.3 | 534480    | 25-Jul-23 | 20:04 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4065.3 | 268224    | 25-Jul-23 | 18:39 | x64      |
| Dts.dll                                              | 2022.160.4065.3 | 3266512   | 25-Jul-23 | 18:32 | x64      |
| Logread.exe                                          | 2022.160.4065.3 | 788432    | 25-Jul-23 | 18:39 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.221     | 2933696   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4065.3     | 30656     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4065.3     | 391120    | 25-Jul-23 | 18:39 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4065.3 | 1714112   | 25-Jul-23 | 18:39 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4065.3     | 554904    | 25-Jul-23 | 18:39 | x86      |
| Msgprox.dll                                          | 2022.160.4065.3 | 313296    | 25-Jul-23 | 18:39 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 2729992   | 25-Jul-23 | 18:39 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 153608    | 25-Jul-23 | 18:39 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 25-Jul-23 | 18:32 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4065.3 | 530368    | 25-Jul-23 | 18:39 | x64      |
| Rdistcom.dll                                         | 2022.160.4065.3 | 939936    | 25-Jul-23 | 18:39 | x64      |
| Repldp.dll                                           | 2022.160.4065.3 | 337872    | 25-Jul-23 | 18:39 | x64      |
| Replisapi.dll                                        | 2022.160.4065.3 | 419776    | 25-Jul-23 | 18:39 | x64      |
| Replmerg.exe                                         | 2022.160.4065.3 | 604112    | 25-Jul-23 | 18:39 | x64      |
| Replprov.dll                                         | 2022.160.4065.3 | 890816    | 25-Jul-23 | 18:39 | x64      |
| Replrec.dll                                          | 2022.160.4065.3 | 1058704   | 25-Jul-23 | 18:39 | x64      |
| Replsub.dll                                          | 2022.160.4065.3 | 501696    | 25-Jul-23 | 18:39 | x64      |
| Spresolv.dll                                         | 2022.160.4065.3 | 301008    | 25-Jul-23 | 18:39 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:32 | x64      |
| Sqlcmd.exe                                           | 2022.160.4065.3 | 276432    | 25-Jul-23 | 18:39 | x64      |
| Sqldistx.dll                                         | 2022.160.4065.3 | 268224    | 25-Jul-23 | 18:39 | x64      |
| Sqlmergx.dll                                         | 2022.160.4065.3 | 423872    | 25-Jul-23 | 18:39 | x64      |
| Xe.dll                                               | 2022.160.4065.3 | 718800    | 25-Jul-23 | 18:39 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4065.3 | 100288    | 25-Jul-23 | 18:39 | x64      |
| Exthost.exe                   | 2022.160.4065.3 | 247744    | 25-Jul-23 | 18:39 | x64      |
| Launchpad.exe                 | 2022.160.4065.3 | 1460120   | 25-Jul-23 | 18:39 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:39 | x64      |
| Sqlsatellite.dll              | 2022.160.4065.3 | 1267616   | 25-Jul-23 | 18:39 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4065.3 | 710560    | 25-Jul-2023 | 18:39 | x64      |
| Fdhost.exe               | 2022.160.4065.3 | 153496    | 25-Jul-2023 | 18:39 | x64      |
| Fdlauncher.exe           | 2022.160.4065.3 | 100288    | 25-Jul-2023 | 18:39 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4065.3 | 137152    | 25-Jul-2023 | 18:39 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 25-Jul-23 | 18:41 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 25-Jul-23 | 18:41 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 25-Jul-23 | 18:41 | x86      |
| Dts.dll                                                       | 2022.160.4065.3 | 3266512   | 25-Jul-23 | 18:41 | x64      |
| Dts.dll                                                       | 2022.160.4065.3 | 2860992   | 25-Jul-23 | 18:41 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4065.3     | 120728    | 25-Jul-23 | 18:41 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4065.3     | 120768    | 25-Jul-23 | 18:41 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.221     | 2933696   | 25-Jul-23 | 18:41 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.221     | 2933712   | 25-Jul-23 | 18:41 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4065.3     | 509856    | 25-Jul-23 | 18:41 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4065.3     | 509848    | 25-Jul-23 | 18:41 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4065.3     | 391120    | 25-Jul-23 | 18:41 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4065.3     | 219040    | 25-Jul-23 | 18:41 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.221 | 10165696  | 25-Jul-23 | 18:41 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 25-Jul-23 | 18:41 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 25-Jul-23 | 18:41 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4065.3 | 137152    | 25-Jul-23 | 18:41 | x64      |
| Sqlceip.exe                                                   | 16.0.4065.3     | 300944    | 25-Jul-23 | 18:41 | x86      |
| Xe.dll                                                        | 2022.160.4065.3 | 718800    | 25-Jul-23 | 18:41 | x64      |
| Xe.dll                                                        | 2022.160.4065.3 | 640928    | 25-Jul-23 | 18:41 | x86      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1029.0     | 559520    | 25-Jul-23 | 19:46 | x86      |
| Dmsnative.dll                                                        | 2022.160.1029.0 | 152480    | 25-Jul-23 | 19:46 | x64      |
| Dwengineservice.dll                                                  | 16.0.1029.0     | 44960     | 25-Jul-23 | 19:46 | x86      |
| Instapi150.dll                                                       | 2022.160.4065.3 | 104336    | 25-Jul-23 | 19:46 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1029.0     | 67536     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1029.0     | 293328    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1029.0     | 1958352   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1029.0     | 169424    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1029.0     | 647120    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1029.0     | 246216    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1029.0     | 139216    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1029.0     | 79776     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1029.0     | 51104     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1029.0     | 88480     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1029.0     | 1129376   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1029.0     | 80848     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1029.0     | 70560     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1029.0     | 35232     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1029.0     | 30624     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1029.0     | 46496     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1029.0     | 21456     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1029.0     | 26528     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1029.0     | 131536    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1029.0     | 86480     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1029.0     | 100768    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1029.0     | 293280    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 120272    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 138192    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 141216    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 137680    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 150480    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 139680    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 134608    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 176592    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 117704    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 136656    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1029.0     | 72656     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1029.0     | 21968     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1029.0     | 37280     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1029.0     | 128928    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1029.0     | 3064736   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1029.0     | 3955616   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 118176    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133024    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 137680    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133584    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 148432    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 134048    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 130464    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 170912    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 115152    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 132000    | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1029.0     | 67488     | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1029.0     | 2682832   | 25-Jul-23 | 19:46 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1029.0     | 2436512   | 25-Jul-23 | 19:46 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4065.3 | 296896    | 25-Jul-23 | 19:46 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4065.3 | 7817168   | 25-Jul-23 | 19:46 | x64      |
| Secforwarder.dll                                                     | 2022.160.4065.3 | 83864     | 25-Jul-23 | 19:46 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1029.0 | 61392     | 25-Jul-23 | 19:46 | x64      |
| Sqldk.dll                                                            | 2022.160.4065.3 | 4024208   | 25-Jul-23 | 19:46 | x64      |
| Sqldumper.exe                                                        | 2022.160.4065.3 | 260032    | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 1746880   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4573136   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 3749824   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4573120   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4474816   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 2443216   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 2385856   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4204480   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4188096   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 1685440   | 25-Jul-23 | 19:46 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4065.3 | 4437952   | 25-Jul-23 | 19:46 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 25-Jul-23 | 19:46 | x64      |
| Sqlos.dll                                                            | 2022.160.4065.3 | 51136     | 25-Jul-23 | 19:46 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1029.0 | 4841424   | 25-Jul-23 | 19:46 | x64      |
| Sqltses.dll                                                          | 2022.160.4065.3 | 9389968   | 25-Jul-23 | 19:46 | x64      |

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
