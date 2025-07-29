---
title: Cumulative update 10 for SQL Server 2017 (KB4342123)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 10 (KB4342123).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4342123, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4342123 - Cumulative Update 10 for SQL Server 2017

_Release Date:_ &nbsp; August 27, 2018  
_Version:_ &nbsp; 14.0.3037.1

## Summary

This article describes Cumulative Update package 10 (CU10) for Microsoft SQL Server 2017. This update contains 21 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 9, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3037.1**, file version: **2017.140.3037.1**
- Analysis Services - Product version: **14.0.226.1**, file version: **2017.140.226.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12201819">[12201819](#12201819)</a> | [FIX: Totals are wrong after you filter on a pivot table item and remove the filter in SSAS (KB2932559)](https://support.microsoft.com/help/2932559) | Analysis Services | Analysis Services | Windows |
| <a id="12227459">[12227459](#12227459)</a> | [FIX: Synchronization of a database takes a long time to finish in SQL Server 2017 (KB4345402)](https://support.microsoft.com/help/4345402) | Analysis Services | Analysis Services | Windows |
| <a id="12245666">[12245666](#12245666)</a> | [FIX: No records are returned when you run an MDX query after restarting SSAS 2016 and 2017 (KB4340746)](https://support.microsoft.com/help/4340746) | Analysis Services | Analysis Services | Windows |
| <a id="12229848">[12229848](#12229848)</a> | [FIX: Delete operation doesn’t work in an entity when you enable Approval Required permission in SQL Server 2017 Master Data Services (KB4346330)](https://support.microsoft.com/help/4346330) | Master Data Services | Client | Windows |
| <a id="12210593">[12210593](#12210593)</a> | [FIX: Incorrect prompt to restart SQL Server 2017 on Linux when not required (KB4053447)](https://support.microsoft.com/help/4053447) | SQL Server Client Tools | Command Line Tools | Linux |
| <a id="12213556">[12213556](#12213556)</a> | [FIX: A value set for the "Accepted NTLM SPNs" variable causes an access violation during startup of SQL Server 2017 (KB4345683)](https://support.microsoft.com/help/4345683) | SQL Server Connectivity | Protocols | Windows |
| <a id="12128370">[12128370](#12128370)</a> | [FIX: Errors 3212 and 3013 occur when you back up a database in AlwaysOn Availability Groups in SQL Server 2017 (KB4346643)](https://support.microsoft.com/help/4346643) | SQL Server Engine | Backup Restore | Windows |
| <a id="12248777">[12248777](#12248777)</a> | [FIX: VSS backup fails in secondary replica of Basic Availability Groups in SQL Server 2016 and 2017 (KB4341221)](https://support.microsoft.com/help/4341221) | SQL Server Engine | Backup Restore | Windows |
| <a id="12245662">[12245662](#12245662)</a> | [FIX: Transaction delays on the primary replica if database synchronization is reported incorrectly on a secondary replica in SQL Server (KB4338576)](https://support.microsoft.com/help/4338576) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12247780">[12247780](#12247780)</a> | [FIX: Out of memory error when you run SQL Server 2017 inside a Linux Docker container (KB4347055)](https://support.microsoft.com/help/4347055) | SQL Server Engine | Linux | Linux |
| <a id="12221447">[12221447](#12221447)</a> | [FIX: Slow performance in SQL Server 2017 when you run a query that contains HASHBYTES function when compared to SQL Server 2016 (KB4345228)](https://support.microsoft.com/help/4345228) | SQL Server Engine | Programmability | Windows |
| <a id="12242742">[12242742](#12242742)</a> | [FIX: Many xml_deadlock_report events are reported for one single intra-query deadlock occurrence in SQL Server 2016 and 2017 (KB4338715)](https://support.microsoft.com/help/4338715) | SQL Server Engine | Query Execution | All |
| <a id="12150907">[12150907](#12150907)</a> | [Improvement: Update to support QUERY_OPTIMIZER_COMPATIBILITY_LEVEL_n in USE HINT option in SQL Server 2017 (KB4342424)](https://support.microsoft.com/help/4342424) | SQL Server Engine | Query Optimizer | All |
| <a id="12171986">[12171986](#12171986)</a> | [Improvement enables CREATE AVAILABILITY GROUP and ALTER AVAILABILITY GROUP DDLs to set the SESSION_TIMEOUT for a configuration-only replica in SQL Server (KB4344904)](https://support.microsoft.com/help/4344904) | SQL Server Engine | Replication | All |
| <a id="12249912">[12249912](#12249912)</a> | [FIX: Change Tracking cleanup messages unexpectedly recorded in the error log for Always On Availability Groups in SQL Server (KB4456883)](https://support.microsoft.com/help/4456883) | SQL Server Engine | Replication | Windows |
| <a id="12203152">[12203152](#12203152)</a> | [FIX: Error occurs when you open a symmetric key that is encrypted by an asymmetric key in SQL Server 2017 (KB4346812)](https://support.microsoft.com/help/4346812) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12248752">[12248752](#12248752)</a> | [FIX: Leakage of sensitive data occurs when you enable DDM function in SQL Server 2016 and 2017 (KB4100582)](https://support.microsoft.com/help/4100582) | SQL Server Engine | Security Infrastructure | All |
| <a id="12164662">[12164662](#12164662)</a> | [FIX: Event notifications for AUDIT_LOGIN and AUDIT_LOGIN_FAILED events will cause an unusual growth of TempDB in SQL Server 2016 and 2017 (KB4341398)](https://support.microsoft.com/help/4341398) | SQL Server Engine | Service Broker | Windows |
| <a id="12177844">[12177844](#12177844)</a> | [FIX: A memory leak occurs in sqlwepxxx.dll causes the WmiPrvSe.exe process to crash (KB4133191)](https://support.microsoft.com/help/4133191) | SQL Server Engine | Service Broker | Windows |
| <a id="12201714">[12201714](#12201714)</a> | [FIX: MEMORYCLERK_SOSMEMMANAGER grows larger and FAIL_PAGE_ALLOCATION error is logged after you enable large page allocations (KB4344103)](https://support.microsoft.com/help/4344103) | SQL Server Engine | SQL OS | Windows |
| <a id="12251323">[12251323](#12251323)</a> | [FIX: Out of memory error occurs even when there are many free pages in SQL Server (KB4347088)](https://support.microsoft.com/help/4347088) | SQL Server Engine | SQL OS | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

> [!NOTE]
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU10 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2018/08/sqlserver2017-kb4342123-x64_7bfea85723fd0321d2555d4e5b8648115786757e.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4342123-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4342123-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4342123-x64.exe| 29FBBA3E7738028A49E3DD9BB0EC9176ADEB939F3E0E40795A63A5C6559D38E4 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.226.1  | 266408    | 27-Jul-18 | 16:58 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.226.1      | 741544    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.226.1      | 1380512   | 27-Jul-18 | 16:58 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.226.1      | 987112    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.226.1      | 522840    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 13-Jun-18 | 05:36 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 13-Jun-18 | 05:36 | x86      |
| Msmdctr.dll                                        | 2017.140.226.1  | 41520     | 27-Jul-18 | 16:58 | x64      |
| Msmdlocal.dll                                      | 2017.140.226.1  | 40386216  | 27-Jul-18 | 16:30 | x86      |
| Msmdlocal.dll                                      | 2017.140.226.1  | 60709544  | 27-Jul-18 | 16:58 | x64      |
| Msmdpump.dll                                       | 2017.140.226.1  | 9336408   | 27-Jul-18 | 16:58 | x64      |
| Msmdredir.dll                                      | 2017.140.226.1  | 7092392   | 27-Jul-18 | 16:30 | x86      |
| Msmdsrv.exe                                        | 2017.140.226.1  | 60609192  | 27-Jul-18 | 16:59 | x64      |
| Msmgdsrv.dll                                       | 2017.140.226.1  | 7310504   | 27-Jul-18 | 16:30 | x86      |
| Msmgdsrv.dll                                       | 2017.140.226.1  | 9006128   | 27-Jul-18 | 16:58 | x64      |
| Msolap.dll                                         | 2017.140.226.1  | 7777448   | 27-Jul-18 | 16:30 | x86      |
| Msolap.dll                                         | 2017.140.226.1  | 10258592  | 27-Jul-18 | 16:59 | x64      |
| Msolui.dll                                         | 2017.140.226.1  | 288816    | 27-Jul-18 | 16:30 | x86      |
| Msolui.dll                                         | 2017.140.226.1  | 312368    | 27-Jul-18 | 16:58 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 13-Jun-18 | 05:36 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlboot.dll                                        | 2017.140.3037.1 | 199120    | 27-Jul-18 | 16:36 | x64      |
| Sqlceip.exe                                        | 14.0.3037.1     | 255632    | 27-Jul-18 | 16:58 | x86      |
| Sqldumper.exe                                      | 2017.140.3037.1 | 142920    | 27-Jul-18 | 16:54 | x64      |
| Sqldumper.exe                                      | 2017.140.3037.1 | 120904    | 27-Jul-18 | 16:56 | x86      |
| Tmapi.dll                                          | 2017.140.226.1  | 5821608   | 27-Jul-18 | 16:58 | x64      |
| Tmcachemgr.dll                                     | 2017.140.226.1  | 4164776   | 27-Jul-18 | 16:58 | x64      |
| Tmpersistence.dll                                  | 2017.140.226.1  | 1132224   | 27-Jul-18 | 16:58 | x64      |
| Tmtransactions.dll                                 | 2017.140.226.1  | 1641128   | 27-Jul-18 | 16:58 | x64      |
| Xe.dll                                             | 2017.140.3037.1 | 674888    | 27-Jul-18 | 16:54 | x64      |
| Xmlrw.dll                                          | 2017.140.3037.1 | 305296    | 27-Jul-18 | 16:36 | x64      |
| Xmlrw.dll                                          | 2017.140.3037.1 | 259144    | 27-Jul-18 | 16:57 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3037.1 | 191072    | 27-Jul-18 | 16:36 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3037.1 | 225864    | 27-Jul-18 | 16:58 | x64      |
| Xmsrv.dll                                          | 2017.140.226.1  | 33350824  | 27-Jul-18 | 16:30 | x86      |
| Xmsrv.dll                                          | 2017.140.226.1  | 25375400  | 27-Jul-18 | 16:59 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3037.1  | 182304    | 27-Jul-18 | 16:30 | x64      |
| Batchparser.dll                            | 2017.140.3037.1  | 161824    | 27-Jul-18 | 16:36 | x86      |
| Instapi140.dll                             | 2017.140.3037.1  | 72224     | 27-Jul-18 | 16:36 | x64      |
| Instapi140.dll                             | 2017.140.3037.1  | 63952     | 27-Jul-18 | 16:57 | x86      |
| Isacctchange.dll                           | 2017.140.3037.1  | 30792     | 27-Jul-18 | 16:57 | x86      |
| Isacctchange.dll                           | 2017.140.3037.1  | 32288     | 27-Jul-18 | 16:58 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.226.1       | 1091560   | 27-Jul-18 | 16:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.226.1       | 1088672   | 27-Jul-18 | 16:58 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.226.1       | 1381544   | 27-Jul-18 | 16:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.226.1       | 742960    | 27-Jul-18 | 16:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.226.1       | 744424    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3037.1      | 38472     | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3037.1  | 79904     | 27-Jul-18 | 16:36 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3037.1  | 83488     | 27-Jul-18 | 16:36 | x64      |
| Msasxpress.dll                             | 2017.140.226.1   | 33328     | 27-Jul-18 | 16:30 | x86      |
| Msasxpress.dll                             | 2017.140.226.1   | 37424     | 27-Jul-18 | 16:58 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3037.1  | 69664     | 27-Jul-18 | 16:57 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3037.1  | 84040     | 27-Jul-18 | 16:58 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3037.1  | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqldumper.exe                              | 2017.140.3037.1  | 142920    | 27-Jul-18 | 16:54 | x64      |
| Sqldumper.exe                              | 2017.140.3037.1  | 120904    | 27-Jul-18 | 16:56 | x86      |
| Sqlftacct.dll                              | 2017.140.3037.1  | 56904     | 27-Jul-18 | 16:57 | x86      |
| Sqlftacct.dll                              | 2017.140.3037.1  | 64072     | 27-Jul-18 | 16:58 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 10-May-18 | 01:38 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 10-May-18 | 01:39 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3037.1  | 372880    | 27-Jul-18 | 16:57 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3037.1  | 417824    | 27-Jul-18 | 16:58 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3037.1  | 34960     | 27-Jul-18 | 16:57 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3037.1  | 38984     | 27-Jul-18 | 16:58 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3037.1  | 273576    | 27-Jul-18 | 16:36 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3037.1  | 357448    | 27-Jul-18 | 16:36 | x64      |
| Sqltdiagn.dll                              | 2017.140.3037.1  | 60560     | 27-Jul-18 | 16:30 | x86      |
| Sqltdiagn.dll                              | 2017.140.3037.1  | 67736     | 27-Jul-18 | 16:31 | x64      |
| Svrenumapi140.dll                          | 2017.140.3037.1  | 1175112   | 27-Jul-18 | 16:36 | x64      |
| Svrenumapi140.dll                          | 2017.140.3037.1  | 896976    | 27-Jul-18 | 16:57 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3037.1 | 120976    | 27-Jul-18 | 16:57 | x86      |
| Dreplaycommon.dll              | 2017.140.3037.1 | 701904    | 27-Jul-18 | 16:57 | x86      |
| Dreplayserverps.dll            | 2017.140.3037.1 | 34336     | 27-Jul-18 | 16:36 | x86      |
| Dreplayutil.dll                | 2017.140.3037.1 | 312784    | 27-Jul-18 | 16:57 | x86      |
| Instapi140.dll                 | 2017.140.3037.1 | 72224     | 27-Jul-18 | 16:36 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlresourceloader.dll          | 2017.140.3037.1 | 30752     | 27-Jul-18 | 16:36 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3037.1 | 701904    | 27-Jul-18 | 16:57 | x86      |
| Dreplaycontroller.exe              | 2017.140.3037.1 | 351776    | 27-Jul-18 | 16:57 | x86      |
| Dreplayprocess.dll                 | 2017.140.3037.1 | 173088    | 27-Jul-18 | 16:57 | x86      |
| Dreplayserverps.dll                | 2017.140.3037.1 | 34336     | 27-Jul-18 | 16:36 | x86      |
| Instapi140.dll                     | 2017.140.3037.1 | 72224     | 27-Jul-18 | 16:36 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlresourceloader.dll              | 2017.140.3037.1 | 30752     | 27-Jul-18 | 16:36 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3037.1 | 182304    | 27-Jul-18 | 16:30 | x64      |
| C1.dll                                       | 18.10.40116.18  | 909312    | 09-May-18 | 22:59 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5325312   | 09-May-18 | 22:59 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 176128    | 09-May-18 | 22:59 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 10-May-18 | 01:46 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3037.1 | 227872    | 27-Jul-18 | 16:58 | x64      |
| Dcexec.exe                                   | 2017.140.3037.1 | 75808     | 27-Jul-18 | 16:58 | x64      |
| Fssres.dll                                   | 2017.140.3037.1 | 92624     | 27-Jul-18 | 16:58 | x64      |
| Hadrres.dll                                  | 2017.140.3037.1 | 189512    | 27-Jul-18 | 16:58 | x64      |
| Hkcompile.dll                                | 2017.140.3037.1 | 1422992   | 27-Jul-18 | 16:58 | x64      |
| Hkengine.dll                                 | 2017.140.3037.1 | 5859912   | 27-Jul-18 | 16:58 | x64      |
| Hkruntime.dll                                | 2017.140.3037.1 | 162960    | 27-Jul-18 | 17:08 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1001472   | 09-May-18 | 22:59 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.226.1      | 742488    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3037.1     | 237208    | 27-Jul-18 | 17:08 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3037.1     | 80928     | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3037.1 | 71312     | 27-Jul-18 | 16:36 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3037.1 | 66632     | 27-Jul-18 | 16:35 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3037.1 | 153672    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3037.1 | 160840    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3037.1 | 306640    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3037.1 | 76360     | 27-Jul-18 | 16:54 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 113664    | 09-May-18 | 22:59 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 543232    | 09-May-18 | 22:59 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 543232    | 09-May-18 | 22:59 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 645120    | 09-May-18 | 22:59 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 948736    | 09-May-18 | 22:59 | x64      |
| Odsole70.dll                                 | 2017.140.3037.1 | 92816     | 27-Jul-18 | 16:58 | x64      |
| Opends60.dll                                 | 2017.140.3037.1 | 34336     | 27-Jul-18 | 16:36 | x64      |
| Qds.dll                                      | 2017.140.3037.1 | 1169984   | 27-Jul-18 | 19:50 | x64      |
| Rsfxft.dll                                   | 2017.140.3037.1 | 34448     | 27-Jul-18 | 16:36 | x64      |
| Secforwarder.dll                             | 2017.140.3037.1 | 40400     | 27-Jul-18 | 16:55 | x64      |
| Sqagtres.dll                                 | 2017.140.3037.1 | 75808     | 27-Jul-18 | 16:58 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlaamss.dll                                 | 2017.140.3037.1 | 91712     | 27-Jul-18 | 17:08 | x64      |
| Sqlaccess.dll                                | 2017.140.3037.1 | 476192    | 27-Jul-18 | 16:58 | x64      |
| Sqlagent.exe                                 | 2017.140.3037.1 | 583712    | 27-Jul-18 | 16:58 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3037.1 | 62096     | 27-Jul-18 | 16:56 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3037.1 | 52880     | 27-Jul-18 | 16:57 | x86      |
| Sqlagentlog.dll                              | 2017.140.3037.1 | 32920     | 27-Jul-18 | 16:31 | x64      |
| Sqlagentmail.dll                             | 2017.140.3037.1 | 55328     | 27-Jul-18 | 16:36 | x64      |
| Sqlboot.dll                                  | 2017.140.3037.1 | 199120    | 27-Jul-18 | 16:36 | x64      |
| Sqlceip.exe                                  | 14.0.3037.1     | 255632    | 27-Jul-18 | 16:58 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3037.1 | 74312     | 27-Jul-18 | 16:58 | x64      |
| Sqlctr140.dll                                | 2017.140.3037.1 | 113736    | 27-Jul-18 | 16:57 | x86      |
| Sqlctr140.dll                                | 2017.140.3037.1 | 130632    | 27-Jul-18 | 16:58 | x64      |
| Sqldk.dll                                    | 2017.140.3037.1 | 2796176   | 27-Jul-18 | 19:50 | x64      |
| Sqldtsss.dll                                 | 2017.140.3037.1 | 109088    | 27-Jul-18 | 17:15 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 2037832   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3678280   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3298376   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3403848   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3788360   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3589704   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3638736   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3341264   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3368520   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3786784   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3782096   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 1499208   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3823568   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 1446472   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 2092496   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3482656   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3918920   | 27-Jul-18 | 16:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3214880   | 27-Jul-18 | 16:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3597896   | 27-Jul-18 | 16:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3915848   | 27-Jul-18 | 16:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 4027976   | 27-Jul-18 | 16:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3037.1 | 3292704   | 27-Jul-18 | 16:58 | x64      |
| Sqliosim.com                                 | 2017.140.3037.1 | 314912    | 27-Jul-18 | 16:55 | x64      |
| Sqliosim.exe                                 | 2017.140.3037.1 | 3019920   | 27-Jul-18 | 16:58 | x64      |
| Sqllang.dll                                  | 2017.140.3037.1 | 41240720  | 27-Jul-18 | 19:59 | x64      |
| Sqlmin.dll                                   | 2017.140.3037.1 | 40454288  | 27-Jul-18 | 19:59 | x64      |
| Sqlolapss.dll                                | 2017.140.3037.1 | 109128    | 27-Jul-18 | 16:58 | x64      |
| Sqlos.dll                                    | 2017.140.3037.1 | 26256     | 27-Jul-18 | 16:57 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3037.1 | 69728     | 27-Jul-18 | 16:58 | x64      |
| Sqlrepss.dll                                 | 2017.140.3037.1 | 64664     | 27-Jul-18 | 16:58 | x64      |
| Sqlresld.dll                                 | 2017.140.3037.1 | 30864     | 27-Jul-18 | 16:36 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3037.1 | 33824     | 27-Jul-18 | 16:36 | x64      |
| Sqlscm.dll                                   | 2017.140.3037.1 | 72736     | 27-Jul-18 | 16:36 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3037.1 | 27792     | 27-Jul-18 | 16:36 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3037.1 | 5874208   | 27-Jul-18 | 16:36 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3037.1 | 732816    | 27-Jul-18 | 16:58 | x64      |
| Sqlservr.exe                                 | 2017.140.3037.1 | 487568    | 27-Jul-18 | 19:50 | x64      |
| Sqlsvc.dll                                   | 2017.140.3037.1 | 163400    | 27-Jul-18 | 16:58 | x64      |
| Sqltses.dll                                  | 2017.140.3037.1 | 9562768   | 27-Jul-18 | 19:50 | x64      |
| Sqsrvres.dll                                 | 2017.140.3037.1 | 262688    | 27-Jul-18 | 16:58 | x64      |
| Svl.dll                                      | 2017.140.3037.1 | 153744    | 27-Jul-18 | 17:08 | x64      |
| Xe.dll                                       | 2017.140.3037.1 | 674888    | 27-Jul-18 | 16:54 | x64      |
| Xmlrw.dll                                    | 2017.140.3037.1 | 305296    | 27-Jul-18 | 16:36 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3037.1 | 225864    | 27-Jul-18 | 16:58 | x64      |
| Xpadsi.exe                                   | 2017.140.3037.1 | 91232     | 27-Jul-18 | 16:58 | x64      |
| Xplog70.dll                                  | 2017.140.3037.1 | 77384     | 27-Jul-18 | 17:08 | x64      |
| Xpqueue.dll                                  | 2017.140.3037.1 | 76360     | 27-Jul-18 | 16:36 | x64      |
| Xprepl.dll                                   | 2017.140.3037.1 | 103496    | 27-Jul-18 | 16:36 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3037.1 | 32408     | 27-Jul-18 | 16:36 | x64      |
| Xpstar.dll                                   | 2017.140.3037.1 | 438416    | 27-Jul-18 | 16:58 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3037.1 | 182304    | 27-Jul-18 | 16:30 | x64      |
| Batchparser.dll                                             | 2017.140.3037.1 | 161824    | 27-Jul-18 | 16:36 | x86      |
| Bcp.exe                                                     | 2017.140.3037.1 | 121376    | 27-Jul-18 | 16:58 | x64      |
| Commanddest.dll                                             | 2017.140.3037.1 | 245904    | 27-Jul-18 | 16:58 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3037.1 | 117832    | 27-Jul-18 | 16:58 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3037.1 | 187544    | 27-Jul-18 | 16:58 | x64      |
| Distrib.exe                                                 | 2017.140.3037.1 | 204872    | 27-Jul-18 | 16:58 | x64      |
| Dteparse.dll                                                | 2017.140.3037.1 | 113184    | 27-Jul-18 | 16:58 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3037.1 | 90696     | 27-Jul-18 | 16:58 | x64      |
| Dtepkg.dll                                                  | 2017.140.3037.1 | 139296    | 27-Jul-18 | 16:58 | x64      |
| Dtexec.exe                                                  | 2017.140.3037.1 | 73872     | 27-Jul-18 | 16:58 | x64      |
| Dts.dll                                                     | 2017.140.3037.1 | 3000352   | 27-Jul-18 | 16:58 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3037.1 | 475280    | 27-Jul-18 | 16:58 | x64      |
| Dtsconn.dll                                                 | 2017.140.3037.1 | 497296    | 27-Jul-18 | 16:58 | x64      |
| Dtshost.exe                                                 | 2017.140.3037.1 | 106056    | 27-Jul-18 | 16:58 | x64      |
| Dtslog.dll                                                  | 2017.140.3037.1 | 123344    | 27-Jul-18 | 16:58 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3037.1 | 546888    | 27-Jul-18 | 16:36 | x64      |
| Dtspipeline.dll                                             | 2017.140.3037.1 | 1266320   | 27-Jul-18 | 17:08 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3037.1 | 49736     | 27-Jul-18 | 16:58 | x64      |
| Dtuparse.dll                                                | 2017.140.3037.1 | 89240     | 27-Jul-18 | 16:58 | x64      |
| Dtutil.exe                                                  | 2017.140.3037.1 | 149968    | 27-Jul-18 | 16:58 | x64      |
| Exceldest.dll                                               | 2017.140.3037.1 | 260752    | 27-Jul-18 | 16:58 | x64      |
| Excelsrc.dll                                                | 2017.140.3037.1 | 282768    | 27-Jul-18 | 16:58 | x64      |
| Execpackagetask.dll                                         | 2017.140.3037.1 | 169544    | 27-Jul-18 | 16:58 | x64      |
| Flatfiledest.dll                                            | 2017.140.3037.1 | 388168    | 27-Jul-18 | 16:58 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3037.1 | 400456    | 27-Jul-18 | 16:58 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3037.1 | 96408     | 27-Jul-18 | 16:58 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3037.1 | 59536     | 27-Jul-18 | 16:58 | x64      |
| Logread.exe                                                 | 2017.140.3037.1 | 635032    | 27-Jul-18 | 16:58 | x64      |
| Mergetxt.dll                                                | 2017.140.3037.1 | 65056     | 27-Jul-18 | 16:36 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.226.1      | 1381536   | 27-Jul-18 | 16:58 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 02-May-18 | 00:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3037.1     | 91168     | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3037.1     | 615496    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3037.1 | 1665056   | 27-Jul-18 | 16:58 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3037.1 | 153672    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3037.1 | 160840    | 27-Jul-18 | 16:54 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3037.1 | 103568    | 27-Jul-18 | 16:58 | x64      |
| Msgprox.dll                                                 | 2017.140.3037.1 | 271904    | 27-Jul-18 | 16:58 | x64      |
| Msxmlsql.dll                                                | 2017.140.3037.1 | 1448080   | 27-Jul-18 | 16:58 | x64      |
| Oledbdest.dll                                               | 2017.140.3037.1 | 262728    | 27-Jul-18 | 16:58 | x64      |
| Oledbsrc.dll                                                | 2017.140.3037.1 | 290376    | 27-Jul-18 | 16:58 | x64      |
| Osql.exe                                                    | 2017.140.3037.1 | 76832     | 27-Jul-18 | 16:36 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3037.1 | 473752    | 27-Jul-18 | 16:58 | x64      |
| Rawdest.dll                                                 | 2017.140.3037.1 | 207944    | 27-Jul-18 | 16:58 | x64      |
| Rawsource.dll                                               | 2017.140.3037.1 | 195656    | 27-Jul-18 | 16:58 | x64      |
| Rdistcom.dll                                                | 2017.140.3037.1 | 860112    | 27-Jul-18 | 16:58 | x64      |
| Recordsetdest.dll                                           | 2017.140.3037.1 | 187344    | 27-Jul-18 | 16:58 | x64      |
| Replagnt.dll                                                | 2017.140.3037.1 | 32288     | 27-Jul-18 | 16:58 | x64      |
| Repldp.dll                                                  | 2017.140.3037.1 | 292448    | 27-Jul-18 | 16:58 | x64      |
| Replerrx.dll                                                | 2017.140.3037.1 | 155720    | 27-Jul-18 | 16:58 | x64      |
| Replisapi.dll                                               | 2017.140.3037.1 | 363616    | 27-Jul-18 | 16:58 | x64      |
| Replmerg.exe                                                | 2017.140.3037.1 | 526432    | 27-Jul-18 | 16:58 | x64      |
| Replprov.dll                                                | 2017.140.3037.1 | 804816    | 27-Jul-18 | 16:58 | x64      |
| Replrec.dll                                                 | 2017.140.3037.1 | 976928    | 27-Jul-18 | 16:58 | x64      |
| Replsub.dll                                                 | 2017.140.3037.1 | 447008    | 27-Jul-18 | 16:58 | x64      |
| Replsync.dll                                                | 2017.140.3037.1 | 155720    | 27-Jul-18 | 16:58 | x64      |
| Spresolv.dll                                                | 2017.140.3037.1 | 253472    | 27-Jul-18 | 16:58 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3037.1 | 250440    | 27-Jul-18 | 16:58 | x64      |
| Sqldiag.exe                                                 | 2017.140.3037.1 | 1260496   | 27-Jul-18 | 16:58 | x64      |
| Sqldistx.dll                                                | 2017.140.3037.1 | 226888    | 27-Jul-18 | 16:36 | x64      |
| Sqllogship.exe                                              | 14.0.3037.1     | 105624    | 27-Jul-18 | 16:36 | x64      |
| Sqlmergx.dll                                                | 2017.140.3037.1 | 362056    | 27-Jul-18 | 16:58 | x64      |
| Sqlresld.dll                                                | 2017.140.3037.1 | 28824     | 27-Jul-18 | 16:36 | x86      |
| Sqlresld.dll                                                | 2017.140.3037.1 | 30864     | 27-Jul-18 | 16:36 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3037.1 | 30752     | 27-Jul-18 | 16:36 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3037.1 | 33824     | 27-Jul-18 | 16:36 | x64      |
| Sqlscm.dll                                                  | 2017.140.3037.1 | 72736     | 27-Jul-18 | 16:36 | x64      |
| Sqlscm.dll                                                  | 2017.140.3037.1 | 62496     | 27-Jul-18 | 16:57 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3037.1 | 136264    | 27-Jul-18 | 16:57 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3037.1 | 163400    | 27-Jul-18 | 16:58 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3037.1 | 184392    | 27-Jul-18 | 16:58 | x64      |
| Sqlwep140.dll                                               | 2017.140.3037.1 | 107040    | 27-Jul-18 | 16:36 | x64      |
| Ssdebugps.dll                                               | 2017.140.3037.1 | 36304     | 27-Jul-18 | 16:58 | x64      |
| Ssisoledb.dll                                               | 2017.140.3037.1 | 217672    | 27-Jul-18 | 16:58 | x64      |
| Ssradd.dll                                                  | 2017.140.3037.1 | 76872     | 27-Jul-18 | 16:58 | x64      |
| Ssravg.dll                                                  | 2017.140.3037.1 | 77384     | 27-Jul-18 | 16:58 | x64      |
| Ssrdown.dll                                                 | 2017.140.3037.1 | 62024     | 27-Jul-18 | 16:58 | x64      |
| Ssrmax.dll                                                  | 2017.140.3037.1 | 74824     | 27-Jul-18 | 16:58 | x64      |
| Ssrmin.dll                                                  | 2017.140.3037.1 | 75336     | 27-Jul-18 | 16:58 | x64      |
| Ssrpub.dll                                                  | 2017.140.3037.1 | 63048     | 27-Jul-18 | 16:58 | x64      |
| Ssrup.dll                                                   | 2017.140.3037.1 | 62024     | 27-Jul-18 | 16:58 | x64      |
| Txagg.dll                                                   | 2017.140.3037.1 | 365008    | 27-Jul-18 | 16:58 | x64      |
| Txbdd.dll                                                   | 2017.140.3037.1 | 170128    | 27-Jul-18 | 16:58 | x64      |
| Txdatacollector.dll                                         | 2017.140.3037.1 | 362056    | 27-Jul-18 | 16:58 | x64      |
| Txdataconvert.dll                                           | 2017.140.3037.1 | 295888    | 27-Jul-18 | 16:58 | x64      |
| Txderived.dll                                               | 2017.140.3037.1 | 607184    | 27-Jul-18 | 16:58 | x64      |
| Txlookup.dll                                                | 2017.140.3037.1 | 528016    | 27-Jul-18 | 16:58 | x64      |
| Txmerge.dll                                                 | 2017.140.3037.1 | 232912    | 27-Jul-18 | 16:58 | x64      |
| Txmergejoin.dll                                             | 2017.140.3037.1 | 277064    | 27-Jul-18 | 16:58 | x64      |
| Txmulticast.dll                                             | 2017.140.3037.1 | 127632    | 27-Jul-18 | 16:58 | x64      |
| Txrowcount.dll                                              | 2017.140.3037.1 | 127048    | 27-Jul-18 | 16:58 | x64      |
| Txsort.dll                                                  | 2017.140.3037.1 | 256656    | 27-Jul-18 | 16:58 | x64      |
| Txsplit.dll                                                 | 2017.140.3037.1 | 598112    | 27-Jul-18 | 16:58 | x64      |
| Txunionall.dll                                              | 2017.140.3037.1 | 183328    | 27-Jul-18 | 16:58 | x64      |
| Xe.dll                                                      | 2017.140.3037.1 | 674888    | 27-Jul-18 | 16:54 | x64      |
| Xmlrw.dll                                                   | 2017.140.3037.1 | 305296    | 27-Jul-18 | 16:36 | x64      |
| Xmlsub.dll                                                  | 2017.140.3037.1 | 262728    | 27-Jul-18 | 16:58 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3037.1 | 1125008   | 27-Jul-18 | 17:23 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlsatellite.dll              | 2017.140.3037.1 | 925136    | 27-Jul-18 | 17:15 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3037.1 | 668744    | 27-Jul-18 | 16:58 | x64      |
| Fdhost.exe               | 2017.140.3037.1 | 116296    | 27-Jul-18 | 17:08 | x64      |
| Fdlauncher.exe           | 2017.140.3037.1 | 62616     | 27-Jul-18 | 16:36 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlft140ph.dll           | 2017.140.3037.1 | 71120     | 27-Jul-18 | 16:36 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3037.1     | 25120     | 27-Jul-18 | 16:36 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 02-May-18 | 00:56 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 02-May-18 | 00:56 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 02-May-18 | 00:56 | x86      |
| Commanddest.dll                                               | 2017.140.3037.1 | 202272    | 27-Jul-18 | 16:57 | x86      |
| Commanddest.dll                                               | 2017.140.3037.1 | 245904    | 27-Jul-18 | 16:58 | x64      |
| Dteparse.dll                                                  | 2017.140.3037.1 | 101920    | 27-Jul-18 | 16:57 | x86      |
| Dteparse.dll                                                  | 2017.140.3037.1 | 113184    | 27-Jul-18 | 16:58 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3037.1 | 85088     | 27-Jul-18 | 16:57 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3037.1 | 90696     | 27-Jul-18 | 16:58 | x64      |
| Dtepkg.dll                                                    | 2017.140.3037.1 | 118304    | 27-Jul-18 | 16:57 | x86      |
| Dtepkg.dll                                                    | 2017.140.3037.1 | 139296    | 27-Jul-18 | 16:58 | x64      |
| Dtexec.exe                                                    | 2017.140.3037.1 | 67728     | 27-Jul-18 | 16:57 | x86      |
| Dtexec.exe                                                    | 2017.140.3037.1 | 73872     | 27-Jul-18 | 16:58 | x64      |
| Dts.dll                                                       | 2017.140.3037.1 | 2550880   | 27-Jul-18 | 16:57 | x86      |
| Dts.dll                                                       | 2017.140.3037.1 | 3000352   | 27-Jul-18 | 16:58 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3037.1 | 419400    | 27-Jul-18 | 16:57 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3037.1 | 475280    | 27-Jul-18 | 16:58 | x64      |
| Dtsconn.dll                                                   | 2017.140.3037.1 | 399504    | 27-Jul-18 | 16:57 | x86      |
| Dtsconn.dll                                                   | 2017.140.3037.1 | 497296    | 27-Jul-18 | 16:58 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3037.1 | 96800     | 27-Jul-18 | 16:57 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3037.1 | 114128    | 27-Jul-18 | 16:58 | x64      |
| Dtshost.exe                                                   | 2017.140.3037.1 | 91208     | 27-Jul-18 | 16:57 | x86      |
| Dtshost.exe                                                   | 2017.140.3037.1 | 106056    | 27-Jul-18 | 16:58 | x64      |
| Dtslog.dll                                                    | 2017.140.3037.1 | 104520    | 27-Jul-18 | 16:57 | x86      |
| Dtslog.dll                                                    | 2017.140.3037.1 | 123344    | 27-Jul-18 | 16:58 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3037.1 | 546888    | 27-Jul-18 | 16:36 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3037.1 | 542752    | 27-Jul-18 | 16:57 | x86      |
| Dtspipeline.dll                                               | 2017.140.3037.1 | 1060936   | 27-Jul-18 | 17:07 | x86      |
| Dtspipeline.dll                                               | 2017.140.3037.1 | 1266320   | 27-Jul-18 | 17:08 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3037.1 | 44104     | 27-Jul-18 | 16:57 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3037.1 | 49736     | 27-Jul-18 | 16:58 | x64      |
| Dtuparse.dll                                                  | 2017.140.3037.1 | 81480     | 27-Jul-18 | 16:57 | x86      |
| Dtuparse.dll                                                  | 2017.140.3037.1 | 89240     | 27-Jul-18 | 16:58 | x64      |
| Dtutil.exe                                                    | 2017.140.3037.1 | 126096    | 27-Jul-18 | 16:57 | x86      |
| Dtutil.exe                                                    | 2017.140.3037.1 | 149968    | 27-Jul-18 | 16:58 | x64      |
| Exceldest.dll                                                 | 2017.140.3037.1 | 216096    | 27-Jul-18 | 16:57 | x86      |
| Exceldest.dll                                                 | 2017.140.3037.1 | 260752    | 27-Jul-18 | 16:58 | x64      |
| Excelsrc.dll                                                  | 2017.140.3037.1 | 231968    | 27-Jul-18 | 16:57 | x86      |
| Excelsrc.dll                                                  | 2017.140.3037.1 | 282768    | 27-Jul-18 | 16:58 | x64      |
| Execpackagetask.dll                                           | 2017.140.3037.1 | 136736    | 27-Jul-18 | 16:57 | x86      |
| Execpackagetask.dll                                           | 2017.140.3037.1 | 169544    | 27-Jul-18 | 16:58 | x64      |
| Flatfiledest.dll                                              | 2017.140.3037.1 | 334368    | 27-Jul-18 | 16:57 | x86      |
| Flatfiledest.dll                                              | 2017.140.3037.1 | 388168    | 27-Jul-18 | 16:58 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3037.1 | 345672    | 27-Jul-18 | 16:57 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3037.1 | 400456    | 27-Jul-18 | 16:58 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3037.1 | 81992     | 27-Jul-18 | 16:57 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3037.1 | 96408     | 27-Jul-18 | 16:58 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3037.1     | 467088    | 27-Jul-18 | 17:23 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3037.1     | 466576    | 27-Jul-18 | 17:23 | x64      |
| Isserverexec.exe                                              | 14.0.3037.1     | 150624    | 27-Jul-18 | 16:57 | x86      |
| Isserverexec.exe                                              | 14.0.3037.1     | 148624    | 27-Jul-18 | 16:58 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.226.1      | 1382960   | 27-Jul-18 | 16:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.226.1      | 1381536   | 27-Jul-18 | 16:58 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 02-May-18 | 00:56 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3037.1     | 72776     | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3037.1 | 108616    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3037.1 | 113736    | 27-Jul-18 | 16:58 | x64      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3037.1     | 91168     | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3037.1     | 91168     | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3037.1     | 496200    | 27-Jul-18 | 16:36 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3037.1     | 496160    | 27-Jul-18 | 16:36 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3037.1     | 83600     | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3037.1     | 85064     | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3037.1     | 415888    | 27-Jul-18 | 17:14 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3037.1     | 415888    | 27-Jul-18 | 17:15 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3037.1     | 614032    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3037.1     | 615496    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3037.1     | 253984    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3037.1     | 254016    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3037.1 | 153672    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3037.1 | 143432    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3037.1 | 160840    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3037.1 | 147016    | 27-Jul-18 | 16:56 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3037.1     | 219792    | 27-Jul-18 | 16:58 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3037.1 | 91680     | 27-Jul-18 | 16:57 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3037.1 | 103568    | 27-Jul-18 | 16:58 | x64      |
| Msmdpp.dll                                                    | 2017.140.226.1  | 9194152   | 27-Jul-18 | 16:58 | x64      |
| Oledbdest.dll                                                 | 2017.140.3037.1 | 214672    | 27-Jul-18 | 16:57 | x86      |
| Oledbdest.dll                                                 | 2017.140.3037.1 | 262728    | 27-Jul-18 | 16:58 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3037.1 | 234528    | 27-Jul-18 | 16:57 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3037.1 | 290376    | 27-Jul-18 | 16:58 | x64      |
| Rawdest.dll                                                   | 2017.140.3037.1 | 167968    | 27-Jul-18 | 16:57 | x86      |
| Rawdest.dll                                                   | 2017.140.3037.1 | 207944    | 27-Jul-18 | 16:58 | x64      |
| Rawsource.dll                                                 | 2017.140.3037.1 | 154656    | 27-Jul-18 | 16:57 | x86      |
| Rawsource.dll                                                 | 2017.140.3037.1 | 195656    | 27-Jul-18 | 16:58 | x64      |
| Recordsetdest.dll                                             | 2017.140.3037.1 | 150600    | 27-Jul-18 | 16:57 | x86      |
| Recordsetdest.dll                                             | 2017.140.3037.1 | 187344    | 27-Jul-18 | 16:58 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlceip.exe                                                   | 14.0.3037.1     | 255632    | 27-Jul-18 | 16:58 | x86      |
| Sqldest.dll                                                   | 2017.140.3037.1 | 215072    | 27-Jul-18 | 16:57 | x86      |
| Sqldest.dll                                                   | 2017.140.3037.1 | 260752    | 27-Jul-18 | 16:58 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3037.1 | 156704    | 27-Jul-18 | 16:57 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3037.1 | 184392    | 27-Jul-18 | 16:58 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3037.1 | 176792    | 27-Jul-18 | 16:57 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3037.1 | 217672    | 27-Jul-18 | 16:58 | x64      |
| Txagg.dll                                                     | 2017.140.3037.1 | 303648    | 27-Jul-18 | 16:57 | x86      |
| Txagg.dll                                                     | 2017.140.3037.1 | 365008    | 27-Jul-18 | 16:58 | x64      |
| Txbdd.dll                                                     | 2017.140.3037.1 | 137760    | 27-Jul-18 | 16:57 | x86      |
| Txbdd.dll                                                     | 2017.140.3037.1 | 170128    | 27-Jul-18 | 16:58 | x64      |
| Txbestmatch.dll                                               | 2017.140.3037.1 | 494664    | 27-Jul-18 | 16:57 | x86      |
| Txbestmatch.dll                                               | 2017.140.3037.1 | 605328    | 27-Jul-18 | 16:58 | x64      |
| Txcache.dll                                                   | 2017.140.3037.1 | 147488    | 27-Jul-18 | 16:57 | x86      |
| Txcache.dll                                                   | 2017.140.3037.1 | 180368    | 27-Jul-18 | 16:58 | x64      |
| Txcharmap.dll                                                 | 2017.140.3037.1 | 250400    | 27-Jul-18 | 16:57 | x86      |
| Txcharmap.dll                                                 | 2017.140.3037.1 | 288328    | 27-Jul-18 | 16:58 | x64      |
| Txcopymap.dll                                                 | 2017.140.3037.1 | 146976    | 27-Jul-18 | 16:57 | x86      |
| Txcopymap.dll                                                 | 2017.140.3037.1 | 180368    | 27-Jul-18 | 16:58 | x64      |
| Txdataconvert.dll                                             | 2017.140.3037.1 | 254496    | 27-Jul-18 | 16:57 | x86      |
| Txdataconvert.dll                                             | 2017.140.3037.1 | 295888    | 27-Jul-18 | 16:58 | x64      |
| Txderived.dll                                                 | 2017.140.3037.1 | 517192    | 27-Jul-18 | 16:57 | x86      |
| Txderived.dll                                                 | 2017.140.3037.1 | 607184    | 27-Jul-18 | 16:58 | x64      |
| Txfileextractor.dll                                           | 2017.140.3037.1 | 162336    | 27-Jul-18 | 16:57 | x86      |
| Txfileextractor.dll                                           | 2017.140.3037.1 | 198800    | 27-Jul-18 | 16:58 | x64      |
| Txfileinserter.dll                                            | 2017.140.3037.1 | 160800    | 27-Jul-18 | 16:57 | x86      |
| Txfileinserter.dll                                            | 2017.140.3037.1 | 196752    | 27-Jul-18 | 16:58 | x64      |
| Txgroupdups.dll                                               | 2017.140.3037.1 | 232520    | 27-Jul-18 | 16:57 | x86      |
| Txgroupdups.dll                                               | 2017.140.3037.1 | 291912    | 27-Jul-18 | 16:58 | x64      |
| Txlineage.dll                                                 | 2017.140.3037.1 | 111688    | 27-Jul-18 | 16:57 | x86      |
| Txlineage.dll                                                 | 2017.140.3037.1 | 138312    | 27-Jul-18 | 16:58 | x64      |
| Txlookup.dll                                                  | 2017.140.3037.1 | 448032    | 27-Jul-18 | 16:57 | x86      |
| Txlookup.dll                                                  | 2017.140.3037.1 | 528016    | 27-Jul-18 | 16:58 | x64      |
| Txmerge.dll                                                   | 2017.140.3037.1 | 178248    | 27-Jul-18 | 16:57 | x86      |
| Txmerge.dll                                                   | 2017.140.3037.1 | 232912    | 27-Jul-18 | 16:58 | x64      |
| Txmergejoin.dll                                               | 2017.140.3037.1 | 223264    | 27-Jul-18 | 16:57 | x86      |
| Txmergejoin.dll                                               | 2017.140.3037.1 | 277064    | 27-Jul-18 | 16:58 | x64      |
| Txmulticast.dll                                               | 2017.140.3037.1 | 104008    | 27-Jul-18 | 16:57 | x86      |
| Txmulticast.dll                                               | 2017.140.3037.1 | 127632    | 27-Jul-18 | 16:58 | x64      |
| Txpivot.dll                                                   | 2017.140.3037.1 | 181832    | 27-Jul-18 | 16:57 | x86      |
| Txpivot.dll                                                   | 2017.140.3037.1 | 224936    | 27-Jul-18 | 16:58 | x64      |
| Txrowcount.dll                                                | 2017.140.3037.1 | 102984    | 27-Jul-18 | 16:57 | x86      |
| Txrowcount.dll                                                | 2017.140.3037.1 | 127048    | 27-Jul-18 | 16:58 | x64      |
| Txsampling.dll                                                | 2017.140.3037.1 | 137248    | 27-Jul-18 | 16:57 | x86      |
| Txsampling.dll                                                | 2017.140.3037.1 | 172688    | 27-Jul-18 | 16:58 | x64      |
| Txscd.dll                                                     | 2017.140.3037.1 | 170128    | 27-Jul-18 | 16:57 | x86      |
| Txscd.dll                                                     | 2017.140.3037.1 | 222304    | 27-Jul-18 | 16:58 | x64      |
| Txsort.dll                                                    | 2017.140.3037.1 | 209440    | 27-Jul-18 | 16:57 | x86      |
| Txsort.dll                                                    | 2017.140.3037.1 | 256656    | 27-Jul-18 | 16:58 | x64      |
| Txsplit.dll                                                   | 2017.140.3037.1 | 510608    | 27-Jul-18 | 16:57 | x86      |
| Txsplit.dll                                                   | 2017.140.3037.1 | 598112    | 27-Jul-18 | 16:58 | x64      |
| Txtermextraction.dll                                          | 2017.140.3037.1 | 8615056   | 27-Jul-18 | 16:57 | x86      |
| Txtermextraction.dll                                          | 2017.140.3037.1 | 8676496   | 27-Jul-18 | 16:58 | x64      |
| Txtermlookup.dll                                              | 2017.140.3037.1 | 4108360   | 27-Jul-18 | 16:57 | x86      |
| Txtermlookup.dll                                              | 2017.140.3037.1 | 4158560   | 27-Jul-18 | 16:58 | x64      |
| Txunionall.dll                                                | 2017.140.3037.1 | 140872    | 27-Jul-18 | 16:57 | x86      |
| Txunionall.dll                                                | 2017.140.3037.1 | 183328    | 27-Jul-18 | 16:58 | x64      |
| Txunpivot.dll                                                 | 2017.140.3037.1 | 161824    | 27-Jul-18 | 16:57 | x86      |
| Txunpivot.dll                                                 | 2017.140.3037.1 | 201288    | 27-Jul-18 | 16:58 | x64      |
| Xe.dll                                                        | 2017.140.3037.1 | 674888    | 27-Jul-18 | 16:54 | x64      |
| Xe.dll                                                        | 2017.140.3037.1 | 597064    | 27-Jul-18 | 16:55 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 10-May-18 | 04:42 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 10-May-18 | 04:42 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 10-May-18 | 04:42 | x86      |
| Instapi140.dll                                                       | 2017.140.3037.1  | 72224     | 27-Jul-18 | 16:36 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 10-May-18 | 04:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 10-May-18 | 04:41 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 10-May-18 | 04:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 10-May-18 | 04:41 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 10-May-18 | 04:41 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 10-May-18 | 04:42 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 10-May-18 | 04:42 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3037.1  | 408648    | 27-Jul-18 | 16:58 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3037.1  | 7325256   | 27-Jul-18 | 17:15 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3037.1  | 2263192   | 27-Jul-18 | 16:58 | x64      |
| Secforwarder.dll                                                     | 2017.140.3037.1  | 40400     | 27-Jul-18 | 16:55 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 10-May-18 | 01:29 | x64      |
| Sqldk.dll                                                            | 2017.140.3037.1  | 2714112   | 27-Jul-18 | 16:57 | x64      |
| Sqldumper.exe                                                        | 2017.140.3037.1  | 142920    | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 1499208   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3915848   | 27-Jul-18 | 16:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3214880   | 27-Jul-18 | 16:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3918920   | 27-Jul-18 | 16:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3823568   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 2092496   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 2037832   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3589704   | 27-Jul-18 | 16:54 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3597896   | 27-Jul-18 | 16:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 1446472   | 27-Jul-18 | 16:56 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3037.1  | 3786784   | 27-Jul-18 | 16:54 | x64      |
| Sqlos.dll                                                            | 2017.140.3037.1  | 26256     | 27-Jul-18 | 16:57 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 10-May-18 | 04:42 | x64      |
| Sqltses.dll                                                          | 2017.140.3037.1  | 9717248   | 27-Jul-18 | 17:07 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3037.1     | 25120     | 27-Jul-18 | 16:36 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3037.1 | 1450056   | 27-Jul-18 | 16:57 | x86      |
| Dtaengine.exe                                          | 2017.140.3037.1 | 205896    | 27-Jul-18 | 17:07 | x86      |
| Dteparse.dll                                           | 2017.140.3037.1 | 101920    | 27-Jul-18 | 16:57 | x86      |
| Dteparse.dll                                           | 2017.140.3037.1 | 113184    | 27-Jul-18 | 16:58 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3037.1 | 85088     | 27-Jul-18 | 16:57 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3037.1 | 90696     | 27-Jul-18 | 16:58 | x64      |
| Dtepkg.dll                                             | 2017.140.3037.1 | 118304    | 27-Jul-18 | 16:57 | x86      |
| Dtepkg.dll                                             | 2017.140.3037.1 | 139296    | 27-Jul-18 | 16:58 | x64      |
| Dtexec.exe                                             | 2017.140.3037.1 | 67728     | 27-Jul-18 | 16:57 | x86      |
| Dtexec.exe                                             | 2017.140.3037.1 | 73872     | 27-Jul-18 | 16:58 | x64      |
| Dts.dll                                                | 2017.140.3037.1 | 2550880   | 27-Jul-18 | 16:57 | x86      |
| Dts.dll                                                | 2017.140.3037.1 | 3000352   | 27-Jul-18 | 16:58 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3037.1 | 419400    | 27-Jul-18 | 16:57 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3037.1 | 475280    | 27-Jul-18 | 16:58 | x64      |
| Dtsconn.dll                                            | 2017.140.3037.1 | 399504    | 27-Jul-18 | 16:57 | x86      |
| Dtsconn.dll                                            | 2017.140.3037.1 | 497296    | 27-Jul-18 | 16:58 | x64      |
| Dtshost.exe                                            | 2017.140.3037.1 | 91208     | 27-Jul-18 | 16:57 | x86      |
| Dtshost.exe                                            | 2017.140.3037.1 | 106056    | 27-Jul-18 | 16:58 | x64      |
| Dtslog.dll                                             | 2017.140.3037.1 | 104520    | 27-Jul-18 | 16:57 | x86      |
| Dtslog.dll                                             | 2017.140.3037.1 | 123344    | 27-Jul-18 | 16:58 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3037.1 | 546888    | 27-Jul-18 | 16:36 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3037.1 | 542752    | 27-Jul-18 | 16:57 | x86      |
| Dtspipeline.dll                                        | 2017.140.3037.1 | 1060936   | 27-Jul-18 | 17:07 | x86      |
| Dtspipeline.dll                                        | 2017.140.3037.1 | 1266320   | 27-Jul-18 | 17:08 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3037.1 | 44104     | 27-Jul-18 | 16:57 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3037.1 | 49736     | 27-Jul-18 | 16:58 | x64      |
| Dtuparse.dll                                           | 2017.140.3037.1 | 81480     | 27-Jul-18 | 16:57 | x86      |
| Dtuparse.dll                                           | 2017.140.3037.1 | 89240     | 27-Jul-18 | 16:58 | x64      |
| Dtutil.exe                                             | 2017.140.3037.1 | 126096    | 27-Jul-18 | 16:57 | x86      |
| Dtutil.exe                                             | 2017.140.3037.1 | 149968    | 27-Jul-18 | 16:58 | x64      |
| Exceldest.dll                                          | 2017.140.3037.1 | 216096    | 27-Jul-18 | 16:57 | x86      |
| Exceldest.dll                                          | 2017.140.3037.1 | 260752    | 27-Jul-18 | 16:58 | x64      |
| Excelsrc.dll                                           | 2017.140.3037.1 | 231968    | 27-Jul-18 | 16:57 | x86      |
| Excelsrc.dll                                           | 2017.140.3037.1 | 282768    | 27-Jul-18 | 16:58 | x64      |
| Flatfiledest.dll                                       | 2017.140.3037.1 | 334368    | 27-Jul-18 | 16:57 | x86      |
| Flatfiledest.dll                                       | 2017.140.3037.1 | 388168    | 27-Jul-18 | 16:58 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3037.1 | 345672    | 27-Jul-18 | 16:57 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3037.1 | 400456    | 27-Jul-18 | 16:58 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3037.1 | 81992     | 27-Jul-18 | 16:57 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3037.1 | 96408     | 27-Jul-18 | 16:58 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3037.1     | 71312     | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3037.1     | 185920    | 27-Jul-18 | 17:23 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3037.1     | 408136    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3037.1     | 408136    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3037.1     | 2093200   | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3037.1     | 2093200   | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3037.1     | 614032    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3037.1     | 615496    | 27-Jul-18 | 16:58 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3037.1     | 253984    | 27-Jul-18 | 16:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3037.1 | 153672    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3037.1 | 143432    | 27-Jul-18 | 16:54 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3037.1 | 160840    | 27-Jul-18 | 16:54 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3037.1 | 147016    | 27-Jul-18 | 16:56 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3037.1 | 91680     | 27-Jul-18 | 16:57 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3037.1 | 103568    | 27-Jul-18 | 16:58 | x64      |
| Msmgdsrv.dll                                           | 2017.140.226.1  | 7310504   | 27-Jul-18 | 16:30 | x86      |
| Oledbdest.dll                                          | 2017.140.3037.1 | 214672    | 27-Jul-18 | 16:57 | x86      |
| Oledbdest.dll                                          | 2017.140.3037.1 | 262728    | 27-Jul-18 | 16:58 | x64      |
| Oledbsrc.dll                                           | 2017.140.3037.1 | 234528    | 27-Jul-18 | 16:57 | x86      |
| Oledbsrc.dll                                           | 2017.140.3037.1 | 290376    | 27-Jul-18 | 16:58 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3037.1 | 101960    | 27-Jul-18 | 16:58 | x64      |
| Sqlresld.dll                                           | 2017.140.3037.1 | 28824     | 27-Jul-18 | 16:36 | x86      |
| Sqlresld.dll                                           | 2017.140.3037.1 | 30864     | 27-Jul-18 | 16:36 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3037.1 | 30752     | 27-Jul-18 | 16:36 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3037.1 | 33824     | 27-Jul-18 | 16:36 | x64      |
| Sqlscm.dll                                             | 2017.140.3037.1 | 72736     | 27-Jul-18 | 16:36 | x64      |
| Sqlscm.dll                                             | 2017.140.3037.1 | 62496     | 27-Jul-18 | 16:57 | x86      |
| Sqlsvc.dll                                             | 2017.140.3037.1 | 136264    | 27-Jul-18 | 16:57 | x86      |
| Sqlsvc.dll                                             | 2017.140.3037.1 | 163400    | 27-Jul-18 | 16:58 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3037.1 | 156704    | 27-Jul-18 | 16:57 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3037.1 | 184392    | 27-Jul-18 | 16:58 | x64      |
| Txdataconvert.dll                                      | 2017.140.3037.1 | 254496    | 27-Jul-18 | 16:57 | x86      |
| Txdataconvert.dll                                      | 2017.140.3037.1 | 295888    | 27-Jul-18 | 16:58 | x64      |
| Xe.dll                                                 | 2017.140.3037.1 | 674888    | 27-Jul-18 | 16:54 | x64      |
| Xe.dll                                                 | 2017.140.3037.1 | 597064    | 27-Jul-18 | 16:55 | x86      |
| Xmlrw.dll                                              | 2017.140.3037.1 | 305296    | 27-Jul-18 | 16:36 | x64      |
| Xmlrw.dll                                              | 2017.140.3037.1 | 259144    | 27-Jul-18 | 16:57 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3037.1 | 191072    | 27-Jul-18 | 16:36 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3037.1 | 225864    | 27-Jul-18 | 16:58 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2017.

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

This article also provides important information about the following situations:

- [**Pacemaker**](#pacemaker): A behavioral change is made in distributions that use the latest available version of Pacemaker. Mitigation methods are provided.

- [**Query Store**](#query-store): You must run this script if you use the Query Store and you have previously installed Microsoft SQL Server 2017 Cumulative Update 2 (CU2).

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2017 is available at the Download Center.

CU packages for Linux are available at https://packages.microsoft.com.

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Pacemaker notice</b></summary><a id="pacemaker"></a>

**IMPORTANT**

All distributions (including RHEL 7.3 and 7.4) that use the latest available **Pacemaker package 1.1.18-11.el7** introduce a behavior change for the `start-failure-is-fatal` cluster setting if its value is `false`. This change affects the failover workflow. If a primary replica experiences an outage, the cluster is expected to fail over to one of the available secondary replicas. Instead, users will notice that the cluster keeps trying to start the failed primary replica. If that primary never comes online (because of a permanent outage), the cluster never fails over to another available secondary replica.

This issue affects all SQL Server versions, regardless of the cumulative update version that they are on.

To mitigate the issue, use either of the following methods.

### Method 1

Follow these steps:

1. Remove the `start-failure-is-fatal` override from the existing cluster.

    \# RHEL, Ubuntu pcs property unset start-failure-is-fatal # or pcs property set start-failure-is-fatal=true # SLES crm configure property start-failure-is-fatal=true

1. Decrease the `cluster-recheck-interval` value.

    \# RHEL, Ubuntu pcs property set cluster-recheck-interval=\<Xmin> # SLES crm configure property cluster-recheck-interval=\<Xmin>

1. Add the `failure-timeout` meta property to each AG resource.

    \# RHEL, Ubuntu pcs resource update ag1 meta failure-timeout=60s # SLES crm configure edit ag1 # In the text editor, add \`meta failure-timeout=60s\` after any \`param\`s and before any \`op\`s

    > [!NOTE]
    > In this code, substitute the value for \<Xmin> as appropriate. If a replica goes down, the cluster tries to restart the replica at an interval that is bound by the `failure-timeout` value and the `cluster-recheck-interval` value. For example, if `failure-timeout` is set to 60 seconds and `cluster-recheck-interval` is set to 120 seconds, the restart is tried at an interval that is greater than 60 seconds but less than 120 seconds. We recommend that you set `failure-timeout` to `60s` and `cluster-recheck-interval` to a value that is greater than 60 seconds. We recommend that you do not set `cluster-recheck-interval` to a small value. For more information, refer to the Pacemaker documentation or consult the system provider.

### Method 2

Revert to Pacemaker version 1.1.16.

</details>

<details>
<summary><b>Query Store notice</b></summary><a id="query-store"></a>

**IMPORTANT**

You must run this script if you use Query Store and you're updating from SQL Server 2017 Cumulative Update 2 (CU2) directly to SQL Server 2017 Cumulative Update 3 (CU3) or any later cumulative update. You don't have to run this script if you have previously installed SQL Server 2017 Cumulative Update 3 (CU3) or any later SQL Server 2017 cumulative update.

```sql
SET NOCOUNT ON;
DROP TABLE IF EXISTS #tmpUserDBs;

SELECT [database_id], 0 AS [IsDone]
INTO #tmpUserDBs
FROM master.sys.databases
WHERE [database_id] > 4
 AND [state] = 0 -- must be ONLINE
 AND is_read_only = 0 -- cannot be READ_ONLY
 AND [database_id] NOT IN (SELECT dr.database_id FROM sys.dm_hadr_database_replica_states dr -- Except all local Always On secondary replicas
  INNER JOIN sys.dm_hadr_availability_replica_states rs ON dr.group_id = rs.group_id
  INNER JOIN sys.databases d ON dr.database_id = d.database_id
  WHERE rs.role = 2 -- Is Secondary
   AND dr.is_local = 1
   AND rs.is_local = 1)

DECLARE @userDB sysname;

WHILE (SELECT COUNT([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0) > 0
BEGIN
 SELECT TOP 1 @userDB = DB_NAME([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0

 -- PRINT 'Working on database ' + @userDB

 EXEC ('USE [' + @userDB + '];
DECLARE @clearPlan bigint, @clearQry bigint;
IF EXISTS (SELECT [actual_state] FROM sys.database_query_store_options WHERE [actual_state] IN (1,2))
BEGIN
 IF EXISTS (SELECT plan_id FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27'')
 BEGIN
  DROP TABLE IF EXISTS #tmpclearPlans;

  SELECT plan_id, query_id, 0 AS [IsDone]
  INTO #tmpclearPlans
  FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27''

  WHILE (SELECT COUNT(plan_id) FROM #tmpclearPlans WHERE [IsDone] = 0) > 0
  BEGIN
   SELECT TOP 1 @clearPlan = plan_id, @clearQry = query_id FROM #tmpclearPlans WHERE [IsDone] = 0
   EXECUTE sys.sp_query_store_unforce_plan @clearQry, @clearPlan;
   EXECUTE sys.sp_query_store_remove_plan @clearPlan;

   UPDATE #tmpclearPlans
   SET [IsDone] = 1
   WHERE plan_id = @clearPlan AND query_id = @clearQry
  END;

  PRINT ''- Cleared possibly affected plans in database [' + @userDB + ']''
 END
 ELSE
 BEGIN
  PRINT ''- No affected plans in database [' + @userDB + ']''
 END
END
ELSE
BEGIN
 PRINT ''- Query Store not enabled in database [' + @userDB + ']''
END')
  UPDATE #tmpUserDBs
  SET [IsDone] = 1
  WHERE [database_id] = DB_ID(@userDB)
END
```

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

One CU package includes all available updates for all SQL Server 2017 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2017**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

**Third-party information disclaimer**

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
