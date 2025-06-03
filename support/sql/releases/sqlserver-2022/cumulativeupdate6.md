---
title: Cumulative update 6 for SQL Server 2022 (KB5027505)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 6 (KB5027505).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5027505
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5027505 - Cumulative Update 6 for SQL Server 2022

_Release Date:_ &nbsp; July 13, 2023  
_Version:_ &nbsp; 16.0.4055.4

## Summary

This article describes Cumulative Update package 6 (CU6) for Microsoft SQL Server 2022. This update contains 15 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 5, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4055.4**, file version: **2022.160.4055.4**
- Analysis Services - Product version: **16.0.43.219**, file version: **2022.160.43.219**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component | Platform |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|---------------------------|----------|
| <a id="2439381">[2439381](#2439381)</a> | Fixes potential memory access violations and incorrect results when executing specific Data Analysis Expressions (DAX) queries that trigger the internal Horizontal Fusion query optimization. </br></br>**Note**: Before you apply the cumulative update, you can disable the feature by setting the `DAX\HorizontalFusion` configuration option to **0** as a workaround.| Analysis Services | Analysis Services | Windows |
| <a id="2442140">[2442140](#2442140)</a> | Fixes an issue in which an alias error occurs during a database upgrade if you apply the name "en" to an attribute. | Master Data Services| Master Data Services| Windows|
| <a id="2424714">[2424714](#2424714)</a> | Fixes a non-yielding scheduler condition (Msg 17883) that you encounter when backup operations can't handle abort signals correctly in some cases while waiting for pending I/O writes. |SQL Server Engine | Backup Restore | All |
| <a id="2449506">[2449506](#2449506)</a> | Fixes an issue in which the SQL Server instance stops responding when it calls a memory-optimized stored procedure from another memory-optimized stored procedure in which the called procedure isn't yet in the plan cache, and a statistics update is triggered during query compilation. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2382857">[2382857](#2382857)</a> | Fixes an issue in which the node profile information from parallel threads for Cardinality Estimation (CE) feedback is missing. After you apply this fix, CE feedback can suggest hints for parallel queries. | SQL Server Engine | Query Execution | All |
| <a id="2470755">[2470755](#2470755)</a> | Fixes an access violation that you encounter under a race condition if the parameter sensitive plan (PSP) optimization feature has Query Store integration enabled, and a query variant's reference to its associated dispatcher or original parent statement is dereferenced prematurely within the in-memory representation of the Query Store. | SQL Server Engine | Query Execution | All |
| <a id="2434843">[2434843](#2434843)</a> | Fixes an issue in which a thread deadlock between Query Store (QDS) background tasks blocks the database shutdown. | SQL Server Engine | Query Store | All |
| <a id="2266818">[2266818](#2266818)</a> | Adds a new error 673 that helps avoid the assertion failure (Location: IndexRowScanner.cpp:1449; Expression: m_versionStatus.IsVisible ()) that you might encounter when you enable change tracking on a database that has snapshot isolation turned on. </br></br>Error message: </br></br>Failure to access row object in snapshot isolation. </br></br>**Note**: You need to turn on trace flag 8285. | SQL Server Engine | Replication | All |
| <a id="2442348">[2442348](#2442348)</a> | Fixes an issue in which applying a patch on the secondary replica or performing an in-place upgrade fails if a database has change data capture (CDC) enabled and is in an availability group. The following error is returned: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 912, Severity: 21, State: 2. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script level upgrade for database 'master' failed because upgrade step 'repl_upgrade.sql' encountered error 35262, state 4, severity 10. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion. | SQL Server Engine | Replication | Windows |
| <a id="2397656">[2397656](#2397656)</a> | [FIX: SQL Server Audit Events fail to write to the Security log (KB4052136)](https://support.microsoft.com/help/4052136) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2472403">[2472403](#2472403)</a> | Fixes the following error 41313 that you encounter when you create a natively compiled stored procedure that contains a `CASE` statement and a column that uses dynamic data masking (DDM): </br></br>Msg 41313, Level 16, State 1, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>The C compiler encountered a failure. The exit code was 2. | SQL Server Engine | Security Infrastructure | All |
| <a id="2475171">[2475171](#2475171)</a> | Enables Microsoft Entra authentication for SQL Server replication. Microsoft Entra authentication for replication can be disabled by using trace flag 11561. Using Microsoft Entra authentication for replication is currently in public preview. For more information, see [Configure replication with Microsoft Entra authentication](/sql/relational-databases/replication/configure-replication-with-azure-ad-authentication).| SQL Server Engine | Security Infrastructure | All |
| <a id="2405773">[2405773](#2405773)</a> | Fixes an issue in which upgrading SQL Server 2017 to SQL Server 2022 on Linux fails and returns an error such as "'model_replicatedmaster.ldf' file does not exist." | SQL Server Engine | SQL Agent | Linux |
| <a id="2425643">[2425643](#2425643)</a> | Fixes an issue in which running `DBCC CHECKDB` reports `RBPEX::NotifyFileShutdown` in the SQL Server error log. | SQL Server Engine | SQL Server Engine | All |
| <a id="2431805">[2431805](#2431805)</a> | Fixes a non-yielding dump issue that you encounter when the `IORequestDispenser` is waiting for the I/O to finish. | SQL Server Engine | Storage Management | All |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU6 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/07/sqlserver2022-kb5027505-x64_7e188a61f59eaf1011bc1625900202d7fbca6b0d.exe)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5027505-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5027505-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5027505-x64.exe| 65591B7E4CE4FB5AFC424CEE903ED90B0A9997569F9263A1183581A48DE5AFF2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.219 | 336808    | 29-Jun-23 | 16:20 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.219     | 2903504   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 29-Jun-23 | 16:20 | x86      |
| Msmdctr.dll                                         | 2022.160.43.219 | 38864     | 29-Jun-23 | 16:20 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.219 | 71767448  | 29-Jun-23 | 16:20 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.219 | 53929880  | 29-Jun-23 | 16:20 | x86      |
| Msmdpump.dll                                        | 2022.160.43.219 | 10335168  | 29-Jun-23 | 16:20 | x64      |
| Msmdredir.dll                                       | 2022.160.43.219 | 8132008   | 29-Jun-23 | 16:20 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.219 | 71304136  | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 956368    | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1884096   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1671104   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1880528   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1847752   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1146776   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1139608   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1768864   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1748376   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 932248    | 29-Jun-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.219 | 1837008   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 954792    | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1882024   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1668008   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1875920   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1844120   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1144744   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1138080   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1764816   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1744808   | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 932288    | 29-Jun-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.219 | 1832352   | 29-Jun-23 | 16:20 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.219 | 10083752  | 29-Jun-23 | 16:20 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.219 | 8265624   | 29-Jun-23 | 16:20 | x86      |
| Msolap.dll                                          | 2022.160.43.219 | 10970008  | 29-Jun-23 | 16:20 | x64      |
| Msolap.dll                                          | 2022.160.43.219 | 8744856   | 29-Jun-23 | 16:20 | x86      |
| Msolui.dll                                          | 2022.160.43.219 | 308136    | 29-Jun-23 | 16:20 | x64      |
| Msolui.dll                                          | 2022.160.43.219 | 289688    | 29-Jun-23 | 16:20 | x86      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 29-Jun-23 | 16:20 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 29-Jun-23 | 16:20 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |
| Sqlceip.exe                                         | 16.0.4055.4     | 300952    | 29-Jun-23 | 16:20 | x86      |
| Sqldumper.exe                                       | 2022.160.4055.4 | 227264    | 29-Jun-23 | 16:20 | x86      |
| Sqldumper.exe                                       | 2022.160.4055.4 | 260032    | 29-Jun-23 | 16:20 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 29-Jun-23 | 16:20 | x86      |
| Tmapi.dll                                           | 2022.160.43.219 | 5884352   | 29-Jun-23 | 16:20 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.219 | 5575080   | 29-Jun-23 | 16:20 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.219 | 1481112   | 29-Jun-23 | 16:20 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.219 | 7198120   | 29-Jun-23 | 16:20 | x64      |
| Xmsrv.dll                                           | 2022.160.43.219 | 26594200  | 29-Jun-23 | 16:20 | x64      |
| Xmsrv.dll                                           | 2022.160.43.219 | 35896264  | 29-Jun-23 | 16:20 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4055.4 | 104400    | 29-Jun-23 | 16:20 | x64      |
| Instapi150.dll                             | 2022.160.4055.4 | 79824     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.219     | 2633640   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.219     | 2633624   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.219     | 2933192   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.219     | 2323352   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.219     | 2323368   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4055.4     | 554912    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4055.4     | 554960    | 29-Jun-23 | 16:20 | x86      |
| Msasxpress.dll                             | 2022.160.43.219 | 32704     | 29-Jun-23 | 16:20 | x64      |
| Msasxpress.dll                             | 2022.160.43.219 | 27544     | 29-Jun-23 | 16:20 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |
| Sqldumper.exe                              | 2022.160.4055.4 | 227264    | 29-Jun-23 | 16:20 | x86      |
| Sqldumper.exe                              | 2022.160.4055.4 | 260032    | 29-Jun-23 | 16:20 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4055.4 | 395168    | 29-Jun-23 | 16:20 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4055.4 | 456656    | 29-Jun-23 | 16:20 | x64      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4055.4     | 2070464   | 29-Jun-23 | 16:20 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4055.4  | 600000    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4055.4  | 600016    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4055.4  | 173984    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4055.4  | 174016    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4055.4  | 1857472   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4055.4  | 1857488   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4055.4  | 370584    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4055.4  | 370624    | 29-Jun-23 | 16:20 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 29-Jun-23 | 17:43 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 29-Jun-23 | 17:43 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4055.4 | 4719056   | 29-Jun-23 | 17:43 | x64      |
| Aetm-enclave.dll                             | 2022.160.4055.4 | 4673512   | 29-Jun-23 | 17:43 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4055.4 | 4909096   | 29-Jun-23 | 17:43 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4055.4 | 4874456   | 29-Jun-23 | 17:43 | x64      |
| Hadrres.dll                                  | 2022.160.4055.4 | 227224    | 29-Jun-23 | 17:43 | x64      |
| Hkcompile.dll                                | 2022.160.4055.4 | 1411024   | 29-Jun-23 | 17:43 | x64      |
| Hkengine.dll                                 | 2022.160.4055.4 | 5765016   | 29-Jun-23 | 17:43 | x64      |
| Hkruntime.dll                                | 2022.160.4055.4 | 190360    | 29-Jun-23 | 17:43 | x64      |
| Hktempdb.dll                                 | 2022.160.4055.4 | 71632     | 29-Jun-23 | 17:43 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.219     | 2322328   | 29-Jun-23 | 17:43 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4055.4 | 333728    | 29-Jun-23 | 17:43 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4055.4 | 96160     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 30656     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 38816     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 34752     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 38800     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 38864     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 30656     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 30624     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 34752     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 38856     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 30672     | 29-Jun-23 | 17:43 | x64      |
| `Odsole70.rll`                                 | 16.0.4055.4     | 38848     | 29-Jun-23 | 17:43 | x64      |
| Qds.dll                                      | 2022.160.4055.4 | 1800088   | 29-Jun-23 | 17:43 | x64      |
| Rsfxft.dll                                   | 2022.160.4055.4 | 55192     | 29-Jun-23 | 17:43 | x64      |
| Secforwarder.dll                             | 2022.160.4055.4 | 83864     | 29-Jun-23 | 17:43 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4055.4 | 137120    | 29-Jun-23 | 17:43 | x64      |
| Sqlaccess.dll                                | 2022.160.4055.4 | 444320    | 29-Jun-23 | 17:43 | x64      |
| Sqlagent.exe                                 | 2022.160.4055.4 | 726944    | 29-Jun-23 | 17:43 | x64      |
| Sqlceip.exe                                  | 16.0.4055.4     | 300952    | 29-Jun-23 | 17:43 | x86      |
| Sqlctr160.dll                                | 2022.160.4055.4 | 128976    | 29-Jun-23 | 17:43 | x86      |
| Sqlctr160.dll                                | 2022.160.4055.4 | 157600    | 29-Jun-23 | 17:43 | x64      |
| Sqldk.dll                                    | 2022.160.4055.4 | 4032464   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 1746848   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3844000   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4061088   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4568992   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4700064   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3745680   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3934104   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4568984   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4401040   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4470688   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 2443168   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 2385824   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4257696   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3893144   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4409240   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4204448   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4188048   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3970960   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 3848080   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 1685408   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4294560   | 29-Jun-23 | 17:43 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4055.4 | 4437920   | 29-Jun-23 | 17:43 | x64      |
| Sqllang.dll                                  | 2022.160.4055.4 | 48617376  | 29-Jun-23 | 17:43 | x64      |
| Sqlmin.dll                                   | 2022.160.4055.4 | 51341248  | 29-Jun-23 | 17:43 | x64      |
| Sqlos.dll                                    | 2022.160.4055.4 | 51096     | 29-Jun-23 | 17:43 | x64      |
| Sqlrepss.dll                                 | 2022.160.4055.4 | 137152    | 29-Jun-23 | 17:43 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4055.4 | 51096     | 29-Jun-23 | 17:43 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4055.4 | 5830608   | 29-Jun-23 | 17:43 | x64      |
| Sqlservr.exe                                 | 2022.160.4055.4 | 722840    | 29-Jun-23 | 17:43 | x64      |
| Sqltses.dll                                  | 2022.160.4055.4 | 9390016   | 29-Jun-23 | 17:43 | x64      |
| Sqsrvres.dll                                 | 2022.160.4055.4 | 305104    | 29-Jun-23 | 17:43 | x64      |
| Svl.dll                                      | 2022.160.4055.4 | 247760    | 29-Jun-23 | 17:43 | x64      |
| Xe.dll                                       | 2022.160.4055.4 | 718752    | 29-Jun-23 | 17:43 | x64      |
| Xpstar.dll                                   | 2022.160.4055.4 | 534480    | 29-Jun-23 | 17:43 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4055.4 | 268240    | 29-Jun-23 | 16:20 | x64      |
| Dts.dll                                              | 2022.160.4055.4 | 3266496   | 29-Jun-23 | 16:20 | x64      |
| Logread.exe                                          | 2022.160.4055.4 | 788416    | 29-Jun-23 | 16:20 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.219     | 2933696   | 29-Jun-23 | 16:18 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4055.4     | 30624     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4055.4     | 391072    | 29-Jun-23 | 16:20 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4055.4 | 1714064   | 29-Jun-23 | 16:20 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4055.4     | 554960    | 29-Jun-23 | 16:20 | x86      |
| Msgprox.dll                                          | 2022.160.4055.4 | 313296    | 29-Jun-23 | 16:20 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 2729992   | 29-Jun-23 | 16:20 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 153608    | 29-Jun-23 | 16:20 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 29-Jun-23 | 16:20 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4055.4 | 530384    | 29-Jun-23 | 16:20 | x64      |
| Rdistcom.dll                                         | 2022.160.4055.4 | 939968    | 29-Jun-23 | 16:20 | x64      |
| Repldp.dll                                           | 2022.160.4055.4 | 337872    | 29-Jun-23 | 16:20 | x64      |
| Replisapi.dll                                        | 2022.160.4055.4 | 419776    | 29-Jun-23 | 16:20 | x64      |
| Replmerg.exe                                         | 2022.160.4055.4 | 604112    | 29-Jun-23 | 16:20 | x64      |
| Replprov.dll                                         | 2022.160.4055.4 | 890816    | 29-Jun-23 | 16:20 | x64      |
| Replrec.dll                                          | 2022.160.4055.4 | 1058768   | 29-Jun-23 | 16:20 | x64      |
| Replsub.dll                                          | 2022.160.4055.4 | 501696    | 29-Jun-23 | 16:20 | x64      |
| Spresolv.dll                                         | 2022.160.4055.4 | 300992    | 29-Jun-23 | 16:20 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |
| Sqlcmd.exe                                           | 2022.160.4055.4 | 276416    | 29-Jun-23 | 16:20 | x64      |
| Sqldistx.dll                                         | 2022.160.4055.4 | 268240    | 29-Jun-23 | 16:20 | x64      |
| Sqlmergx.dll                                         | 2022.160.4055.4 | 423888    | 29-Jun-23 | 16:20 | x64      |
| Xe.dll                                               | 2022.160.4055.4 | 718752    | 29-Jun-23 | 16:20 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4055.4 | 100240    | 29-Jun-23 | 16:20 | x64      |
| Exthost.exe                   | 2022.160.4055.4 | 247712    | 29-Jun-23 | 16:20 | x64      |
| Launchpad.exe                 | 2022.160.4055.4 | 1460128   | 29-Jun-23 | 16:20 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |
| Sqlsatellite.dll              | 2022.160.4055.4 | 1267616   | 29-Jun-23 | 16:20 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4055.4 | 710608    | 29-Jun-23 | 16:20 | x64      |
| Fdhost.exe               | 2022.160.4055.4 | 153496    | 29-Jun-23 | 16:20 | x64      |
| Fdlauncher.exe           | 2022.160.4055.4 | 100288    | 29-Jun-23 | 16:20 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:20 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 29-Jun-23 | 16:37 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 29-Jun-23 | 16:37 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 29-Jun-23 | 16:37 | x86      |
| Dts.dll                                                       | 2022.160.4055.4 | 2860992   | 29-Jun-23 | 16:37 | x86      |
| Dts.dll                                                       | 2022.160.4055.4 | 3266496   | 29-Jun-23 | 16:37 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4055.4     | 120784    | 29-Jun-23 | 16:37 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.219     | 2933664   | 29-Jun-23 | 16:37 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.219     | 2933696   | 29-Jun-23 | 16:37 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4055.4     | 509904    | 29-Jun-23 | 16:37 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4055.4     | 391072    | 29-Jun-23 | 16:37 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4055.4     | 219040    | 29-Jun-23 | 16:37 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.219 | 10165664  | 29-Jun-23 | 16:37 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 29-Jun-23 | 16:37 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 29-Jun-23 | 16:37 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 29-Jun-23 | 16:37 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4055.4 | 137120    | 29-Jun-23 | 16:37 | x64      |
| Sqlceip.exe                                                   | 16.0.4055.4     | 300952    | 29-Jun-23 | 16:37 | x86      |
| Xe.dll                                                        | 2022.160.4055.4 | 640960    | 29-Jun-23 | 16:37 | x86      |
| Xe.dll                                                        | 2022.160.4055.4 | 718752    | 29-Jun-23 | 16:37 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1026.0     | 559520    | 29-Jun-23 | 17:20 | x86      |
| Dmsnative.dll                                                        | 2022.160.1026.0 | 152480    | 29-Jun-23 | 17:20 | x64      |
| Dwengineservice.dll                                                  | 16.0.1026.0     | 45008     | 29-Jun-23 | 17:20 | x86      |
| Instapi150.dll                                                       | 2022.160.4055.4 | 104400    | 29-Jun-23 | 17:20 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1026.0     | 67536     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1026.0     | 293280    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1026.0     | 1957792   | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1026.0     | 169432    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1026.0     | 647112    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1026.0     | 246216    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1026.0     | 139184    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1026.0     | 79776     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1026.0     | 51152     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1026.0     | 88496     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1026.0     | 1129432   | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1026.0     | 80800     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1026.0     | 70560     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1026.0     | 35288     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1026.0     | 30680     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1026.0     | 46536     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1026.0     | 21424     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1026.0     | 26584     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1026.0     | 131488    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1026.0     | 86448     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1026.0     | 100816    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1026.0     | 293296    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 120240    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 138160    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 141256    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 137648    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 150488    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 139696    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 134616    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 176592    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 117720    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 136624    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1026.0     | 72624     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1026.0     | 21936     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1026.0     | 37320     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1026.0     | 128984    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1026.0     | 3064776   | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1026.0     | 3955616   | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 118192    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 133040    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 137632    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 133536    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 148400    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 134064    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 130480    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 170928    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 115120    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 132000    | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1026.0     | 67544     | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1026.0     | 2682784   | 29-Jun-23 | 17:20 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1026.0     | 2436568   | 29-Jun-23 | 17:20 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4055.4 | 296896    | 29-Jun-23 | 17:20 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4055.4 | 7817152   | 29-Jun-23 | 17:20 | x64      |
| Secforwarder.dll                                                     | 2022.160.4055.4 | 83864     | 29-Jun-23 | 17:20 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1026.0 | 61384     | 29-Jun-23 | 17:20 | x64      |
| Sqldk.dll                                                            | 2022.160.4055.4 | 4032464   | 29-Jun-23 | 17:20 | x64      |
| Sqldumper.exe                                                        | 2022.160.4055.4 | 260032    | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 1746848   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4568992   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 3745680   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4568984   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4470688   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 2443168   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 2385824   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4204448   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4188048   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 1685408   | 29-Jun-23 | 17:20 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4055.4 | 4437920   | 29-Jun-23 | 17:20 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 29-Jun-23 | 17:20 | x64      |
| Sqlos.dll                                                            | 2022.160.4055.4 | 51096     | 29-Jun-23 | 17:20 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1026.0 | 4841432   | 29-Jun-23 | 17:20 | x64      |
| Sqltses.dll                                                          | 2022.160.4055.4 | 9390016   | 29-Jun-23 | 17:20 | x64      |

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
