---
title: Cumulative update 3 for SQL Server 2022 (KB5024396)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 3 (KB5024396).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5024396
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5024396 - Cumulative Update 3 for SQL Server 2022

_Release Date:_ &nbsp; April 13, 2023  
_Version:_ &nbsp; 16.0.4025.1

## Summary

This article describes Cumulative Update package 3 (CU3) for Microsoft SQL Server 2022. This update contains 9 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 2, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4025.1**, file version: **2022.160.4025.1**
- Analysis Services - Product version: **16.0.43.211**, file version: **2022.160.43.211**

## Known issues in this update

After you install this cumulative update, external data sources using generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the Driver keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

This issue is fixed in [SQL Server 2022 CU5](cumulativeupdate5.md#2398344).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component| Platform |
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|----------------------|----------|
| <a id="2279666">[2279666](#2279666)</a> | Fixes a failure in SQL Server Analysis Services (SSAS) that you encounter after you rename partitions to the same name in a multidimensional model. | Analysis Services | Analysis Services | Windows |
| <a id="2255710">[2255710](#2255710)</a> | Fixes security vulnerabilities [CVE-2015-6420](https://nvd.nist.gov/vuln/detail/CVE-2015-6420) and [CVE-2017-15708](https://nvd.nist.gov/vuln/detail/CVE-2017-15708). | Integration Services | Integration Services | Windows |
| <a id="2168305">[2168305](#2168305)</a> | Fixes a memory leak issue that you encounter when configuring SQL Server log shipping that's in standby or read-only mode for an In-memory OLTP database. </br></br>**Note**: You need to turn on trace flag 9953 during startup to avoid the issue. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2251138">[2251138](#2251138)</a> | Updates the error message that's returned in the `SqlBackendNotSupported` exception when you run `CREATE EXTERNAL TABLE` by using a Synapse serverless external data source to the following one: </br></br>Azure Synapse Serverless SQL Pool is not a supported data source. | SQL Server Engine| PolyBase | All |
| <a id="2270253">[2270253](#2270253)</a> | Fixes a failure where the `DateTime` field can't be pushed down to some PolyBase generic ODBC external data sources such as Denodo when you query an external table by using a filter clause for a `DateTime` field. | SQL Server Engine | PolyBase | All |
| <a id="2290374">[2290374](#2290374)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Execution | All |
| <a id="2273502">[2273502](#2273502)</a> | Fixes an issue where the change tracking auto cleanup process generates dumps under rare conditions when the parent table name that the system tries to access isn't available during runtime, and then the process runs into an access violation. | SQL Server Engine | Replication | All |
| <a id="2214981">[2214981](#2214981)</a> | Fixes an issue where the `mssql-conf` commands give incorrect errors even if they succeed on Linux. | SQL Server Engine | SQL Agent | Linux |
| <a id="2283663">[2283663](#2283663)</a> | Adds a new feature that helps parallelize the version cleaner, which will help clean up the stale versions faster on databases that have the persistent version store. | SQL Server Engine | SQL Server Engine | All |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU3 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/04/sqlserver2022-kb5024396-x64_dcdb0dcb05dce5f9be87e6355f3077a488291b70.exe)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5024396-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5024396-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5024396-x64.exe|FD9412F77876358473E08C9866F1678DDDC66739A2A9E81C8EC6514D61577405|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.211 | 336848    | 13-Mar-23 | 19:40 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.211     | 2903504   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 13-Mar-23 | 19:44 | x86      |
| Msmdctr.dll                                         | 2022.160.43.211 | 38864     | 13-Mar-23 | 19:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 71759272  | 13-Mar-23 | 19:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.211 | 53921192  | 13-Mar-23 | 19:40 | x86      |
| Msmdpump.dll                                        | 2022.160.43.211 | 10335184  | 13-Mar-23 | 19:40 | x64      |
| Msmdredir.dll                                       | 2022.160.43.211 | 8132048   | 13-Mar-23 | 19:40 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.211 | 71316392  | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 954792    | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1882576   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1669536   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1878952   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1846176   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1145256   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1138088   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1767336   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1746856   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 930728    | 13-Mar-23 | 19:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.211 | 1835432   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 953256    | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1880488   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1666472   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1874344   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1842600   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1143208   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1136552   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1763752   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1743272   | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 931240    | 13-Mar-23 | 19:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.211 | 1830824   | 13-Mar-23 | 19:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 10083792  | 13-Mar-23 | 19:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.211 | 8265640   | 13-Mar-23 | 19:40 | x86      |
| Msolap.dll                                          | 2022.160.43.211 | 10970064  | 13-Mar-23 | 19:40 | x64      |
| Msolap.dll                                          | 2022.160.43.211 | 8744912   | 13-Mar-23 | 19:40 | x86      |
| Msolui.dll                                          | 2022.160.43.211 | 308136    | 13-Mar-23 | 19:40 | x64      |
| Msolui.dll                                          | 2022.160.43.211 | 289744    | 13-Mar-23 | 19:40 | x86      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 13-Mar-23 | 19:44 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 13-Mar-23 | 19:44 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:40 | x64      |
| Sqlceip.exe                                         | 16.0.4025.1     | 301008    | 13-Mar-23 | 19:44 | x86      |
| Sqldumper.exe                                       | 2022.160.4025.1 | 227272    | 13-Mar-23 | 19:44 | x86      |
| Sqldumper.exe                                       | 2022.160.4025.1 | 260048    | 13-Mar-23 | 19:44 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 13-Mar-23 | 19:44 | x86      |
| Tmapi.dll                                           | 2022.160.43.211 | 5884368   | 13-Mar-23 | 19:40 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.211 | 5575120   | 13-Mar-23 | 19:40 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.211 | 1481168   | 13-Mar-23 | 19:40 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.211 | 7197648   | 13-Mar-23 | 19:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 26594256  | 13-Mar-23 | 19:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.211 | 35895720  | 13-Mar-23 | 19:40 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4025.1 | 104400    | 13-Mar-23 | 19:44 | x64      |
| Instapi150.dll                             | 2022.160.4025.1 | 79808     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633640   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.211     | 2633680   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.211     | 2933152   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323368   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.211     | 2323408   | 13-Mar-23 | 19:40 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4025.1     | 554912    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4025.1     | 554904    | 13-Mar-23 | 19:44 | x86      |
| Msasxpress.dll                             | 2022.160.43.211 | 27600     | 13-Mar-23 | 19:40 | x86      |
| Msasxpress.dll                             | 2022.160.43.211 | 32720     | 13-Mar-23 | 19:40 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:40 | x64      |
| Sqldumper.exe                              | 2022.160.4025.1 | 227272    | 13-Mar-23 | 19:44 | x86      |
| Sqldumper.exe                              | 2022.160.4025.1 | 260048    | 13-Mar-23 | 19:44 | x64      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4025.1     | 2066384   | 13-Mar-23 | 19:44 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:40 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4025.1  | 600016    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4025.1  | 173984    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4025.1  | 1857472   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4025.1  | 1857480   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4025.1  | 370640    | 13-Mar-23 | 19:44 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4025.1 | 4719040   | 13-Mar-23 | 20:57 | x64      |
| Aetm-enclave.dll                             | 2022.160.4025.1 | 4673504   | 13-Mar-23 | 20:57 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4025.1 | 4909096   | 13-Mar-23 | 20:57 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4025.1 | 4874512   | 13-Mar-23 | 20:57 | x64      |
| Hadrres.dll                                  | 2022.160.4025.1 | 227224    | 13-Mar-23 | 20:57 | x64      |
| Hkcompile.dll                                | 2022.160.4025.1 | 1410976   | 13-Mar-23 | 20:57 | x64      |
| Hkengine.dll                                 | 2022.160.4025.1 | 5760960   | 13-Mar-23 | 20:57 | x64      |
| Hkruntime.dll                                | 2022.160.4025.1 | 190400    | 13-Mar-23 | 20:57 | x64      |
| Hktempdb.dll                                 | 2022.160.4025.1 | 71632     | 13-Mar-23 | 20:57 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.211     | 2322384   | 13-Mar-23 | 19:56 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4025.1 | 333728    | 13-Mar-23 | 20:57 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4025.1 | 96192     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                | 16.0.4025.1     | 30608     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 38816     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 34720     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 38816     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 38816     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 30608     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 30656     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 34712     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 38816     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 30624     | 13-Mar-23 | 20:57 | x64      |
| `Odsole70.rll`                                 | 16.0.4025.1     | 38800     | 13-Mar-23 | 20:57 | x64      |
| Qds.dll                                      | 2022.160.4025.1 | 1779664   | 13-Mar-23 | 20:57 | x64      |
| Rsfxft.dll                                   | 2022.160.4025.1 | 55248     | 13-Mar-23 | 20:57 | x64      |
| Secforwarder.dll                             | 2022.160.4025.1 | 83920     | 13-Mar-23 | 20:57 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4025.1 | 137104    | 13-Mar-23 | 20:57 | x64      |
| Sqlaccess.dll                                | 2022.160.4025.1 | 444368    | 13-Mar-23 | 20:57 | x64      |
| Sqlagent.exe                                 | 2022.160.4025.1 | 726928    | 13-Mar-23 | 20:57 | x64      |
| Sqlceip.exe                                  | 16.0.4025.1     | 301008    | 13-Mar-23 | 20:57 | x86      |
| Sqlctr160.dll                                | 2022.160.4025.1 | 157600    | 13-Mar-23 | 20:57 | x64      |
| Sqlctr160.dll                                | 2022.160.4025.1 | 128928    | 13-Mar-23 | 20:57 | x86      |
| Sqldk.dll                                    | 2022.160.4025.1 | 4028304   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 1746896   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3839952   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4057040   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4564944   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4695968   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3741632   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3930048   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4564944   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4396992   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4466640   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 2439120   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 2381776   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4253632   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3889104   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4405200   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4200400   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4184016   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3966928   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 3844040   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 1685440   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4290512   | 13-Mar-23 | 20:57 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4025.1 | 4429776   | 13-Mar-23 | 20:57 | x64      |
| `Sqllang.dll`                                  | 2022.160.4025.1 | 48572320  | 13-Mar-23 | 20:57 | x64      |
| `Sqlmin.dll`                                   | 2022.160.4025.1 | 51320784  | 13-Mar-23 | 20:57 | x64      |
| Sqlos.dll                                    | 2022.160.4025.1 | 51136     | 13-Mar-23 | 20:57 | x64      |
| Sqlrepss.dll                                 | 2022.160.4025.1 | 137168    | 13-Mar-23 | 20:57 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4025.1 | 51136     | 13-Mar-23 | 20:57 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4025.1 | 5830608   | 13-Mar-23 | 20:57 | x64      |
| Sqlservr.exe                                 | 2022.160.4025.1 | 722880    | 13-Mar-23 | 20:57 | x64      |
| Sqltses.dll                                  | 2022.160.4025.1 | 9390032   | 13-Mar-23 | 20:57 | x64      |
| Sqsrvres.dll                                 | 2022.160.4025.1 | 305040    | 13-Mar-23 | 20:57 | x64      |
| Svl.dll                                      | 2022.160.4025.1 | 247744    | 13-Mar-23 | 20:57 | x64      |
| Xe.dll                                       | 2022.160.4025.1 | 718752    | 13-Mar-23 | 20:57 | x64      |
| Xpstar.dll                                   | 2022.160.4025.1 | 534416    | 13-Mar-23 | 20:57 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4025.1 | 268192    | 13-Mar-23 | 19:44 | x64      |
| Logread.exe                                          | 2022.160.4025.1 | 788368    | 13-Mar-23 | 19:44 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.211     | 2933672   | 13-Mar-23 | 19:45 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4025.1     | 30616     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 13-Mar-23 | 19:44 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4025.1 | 1714128   | 13-Mar-23 | 19:44 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4025.1     | 554912    | 13-Mar-23 | 19:44 | x86      |
| Msgprox.dll                                          | 2022.160.4025.1 | 313248    | 13-Mar-23 | 19:44 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 13-Mar-23 | 19:44 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 13-Mar-23 | 19:44 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 13-Mar-23 | 19:45 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4025.1 | 530336    | 13-Mar-23 | 19:44 | x64      |
| Rdistcom.dll                                         | 2022.160.4025.1 | 939984    | 13-Mar-23 | 19:44 | x64      |
| Repldp.dll                                           | 2022.160.4025.1 | 337872    | 13-Mar-23 | 19:44 | x64      |
| Replisapi.dll                                        | 2022.160.4025.1 | 419744    | 13-Mar-23 | 19:44 | x64      |
| Replmerg.exe                                         | 2022.160.4025.1 | 604064    | 13-Mar-23 | 19:44 | x64      |
| Replprov.dll                                         | 2022.160.4025.1 | 890784    | 13-Mar-23 | 19:44 | x64      |
| Replrec.dll                                          | 2022.160.4025.1 | 1058712   | 13-Mar-23 | 19:44 | x64      |
| Replsub.dll                                          | 2022.160.4025.1 | 501648    | 13-Mar-23 | 19:44 | x64      |
| Spresolv.dll                                         | 2022.160.4025.1 | 300944    | 13-Mar-23 | 19:44 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:44 | x64      |
| Sqlcmd.exe                                           | 2022.160.4025.1 | 276416    | 13-Mar-23 | 19:44 | x64      |
| Sqldistx.dll                                         | 2022.160.4025.1 | 268224    | 13-Mar-23 | 19:44 | x64      |
| Sqlmergx.dll                                         | 2022.160.4025.1 | 423840    | 13-Mar-23 | 19:44 | x64      |
| Xe.dll                                               | 2022.160.4025.1 | 718752    | 13-Mar-23 | 19:45 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4025.1 | 100304    | 13-Mar-23 | 19:44 | x64      |
| Exthost.exe                   | 2022.160.4025.1 | 247712    | 13-Mar-23 | 19:44 | x64      |
| Launchpad.exe                 | 2022.160.4025.1 | 1361856   | 13-Mar-23 | 19:44 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:44 | x64      |
| Sqlsatellite.dll              | 2022.160.4025.1 | 1165264   | 13-Mar-23 | 19:44 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4025.1 | 710608    | 13-Mar-23 | 19:44 | x64      |
| Fdhost.exe               | 2022.160.4025.1 | 153504    | 13-Mar-23 | 19:44 | x64      |
| Fdlauncher.exe           | 2022.160.4025.1 | 100304    | 13-Mar-23 | 19:44 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:44 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 13-Mar-23 | 19:57 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 13-Mar-23 | 19:57 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 13-Mar-23 | 19:57 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 13-Mar-23 | 19:57 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 13-Mar-23 | 19:57 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 13-Mar-23 | 19:57 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4025.1     | 120784    | 13-Mar-23 | 19:57 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4025.1     | 120784    | 13-Mar-23 | 19:57 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.211     | 2933672   | 13-Mar-23 | 19:57 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.211     | 2933672   | 13-Mar-23 | 19:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4025.1     | 509904    | 13-Mar-23 | 19:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4025.1     | 509904    | 13-Mar-23 | 19:57 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4025.1     | 219040    | 13-Mar-23 | 19:57 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.211 | 10165712  | 13-Mar-23 | 19:57 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 13-Mar-23 | 19:57 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 13-Mar-23 | 19:57 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 13-Mar-23 | 19:57 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4025.1 | 137104    | 13-Mar-23 | 19:57 | x64      |
| Sqlceip.exe                                                   | 16.0.4025.1     | 301008    | 13-Mar-23 | 19:57 | x86      |
| Xe.dll                                                        | 2022.160.4025.1 | 640912    | 13-Mar-23 | 19:57 | x86      |
| Xe.dll                                                        | 2022.160.4025.1 | 718752    | 13-Mar-23 | 19:57 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1024.0     | 559064    | 13-Mar-23 | 20:40 | x86      |
| Dmsnative.dll                                                        | 2022.160.1024.0 | 152496    | 13-Mar-23 | 20:40 | x64      |
| Dwengineservice.dll                                                  | 16.0.1024.0     | 44976     | 13-Mar-23 | 20:40 | x86      |
| Instapi150.dll                                                       | 2022.160.4025.1 | 104400    | 13-Mar-23 | 20:40 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1024.0     | 67488     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1024.0     | 293336    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1024.0     | 1957848   | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1024.0     | 169392    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1024.0     | 647080    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1024.0     | 246232    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1024.0     | 139216    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1024.0     | 79832     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1024.0     | 51152     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1024.0     | 88528     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1024.0     | 1129432   | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1024.0     | 80856     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1024.0     | 70560     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1024.0     | 35232     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1024.0     | 30640     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1024.0     | 46544     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1024.0     | 21408     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1024.0     | 26544     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1024.0     | 131504    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1024.0     | 86480     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1024.0     | 100768    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1024.0     | 293280    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 120224    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 138144    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 141232    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 137648    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 150432    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 139696    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 134560    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 176560    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 117680    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1024.0     | 136624    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1024.0     | 72608     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1024.0     | 21968     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1024.0     | 37280     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1024.0     | 128928    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1024.0     | 3064784   | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1024.0     | 3955664   | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 118232    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133080    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 137688    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 133592    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 148440    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 134104    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 130520    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 170960    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 115160    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1024.0     | 132056    | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1024.0     | 67504     | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1024.0     | 2682832   | 13-Mar-23 | 20:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1024.0     | 2436528   | 13-Mar-23 | 20:40 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4025.1 | 296864    | 13-Mar-23 | 20:40 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4025.1 | 7817120   | 13-Mar-23 | 20:40 | x64      |
| Secforwarder.dll                                                     | 2022.160.4025.1 | 83920     | 13-Mar-23 | 20:40 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1024.0 | 61392     | 13-Mar-23 | 20:40 | x64      |
| Sqldk.dll                                                            | 2022.160.4025.1 | 4028304   | 13-Mar-23 | 20:40 | x64      |
| Sqldumper.exe                                                        | 2022.160.4025.1 | 260048    | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 1746896   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4564944   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 3741632   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4564944   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4466640   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 2439120   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 2381776   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4200400   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4184016   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 1685440   | 13-Mar-23 | 20:40 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4025.1 | 4429776   | 13-Mar-23 | 20:40 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 13-Mar-23 | 20:40 | x64      |
| Sqlos.dll                                                            | 2022.160.4025.1 | 51136     | 13-Mar-23 | 20:40 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1024.0 | 4841424   | 13-Mar-23 | 20:40 | x64      |
| Sqltses.dll                                                          | 2022.160.4025.1 | 9390032   | 13-Mar-23 | 20:40 | x64      |

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
