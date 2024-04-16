---
title: Cumulative update 5 for SQL Server 2017 (KB4092643)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 5 (KB4092643).
ms.date: 08/04/2023
ms.custom: KB4092643, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4092643 - Cumulative Update 5 for SQL Server 2017

_Release Date:_ &nbsp; March 20, 2018  
_Version:_ &nbsp; 14.0.3023.8

## Summary

This article describes Cumulative Update package 5 (CU5) for Microsoft SQL Server 2017. This update contains 18 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 4, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3023.8**, file version: **2017.140.3023.8**
- Analysis Services - Product version: **14.0.204.1**, file version: **2017.140.204.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="11447604">[11447604](#11447604)</a> | [FIX: Unexpected exception occurs when you process dimensions by using Process Update in SSAS 2016 or SSAS 2017 (KB4038881)](https://support.microsoft.com/help/4038881) | Analysis Services | Analysis Services | Windows |
| <a id="11505194">[11505194](#11505194)</a> | [FIX: Missing logs for Analysis Services Processing tasks in SQL Server 2016 and 2017 Integration Services (KB4055674)](https://support.microsoft.com/help/4055674) | Analysis Services | Analysis Services | Windows |
| <a id="11578523">[11578523](#11578523)</a> | [Improvement: Performance issue when upgrading MDS from SQL Server 2012 to 2016 (KB4089718)](https://support.microsoft.com/help/4089718) | Master Data Services | Server | All |
| <a id="11301460">[11301460](#11301460)</a> | [FIX: Intermittent 9004 error when a backup is restored via Standby Mode in SQL Server 2014, 2016, and 2017 (KB4058700)](https://support.microsoft.com/help/4058700) | SQL Server Engine | Backup Restore | All |
| <a id="11569472">[11569472](#11569472)</a> | [FIX: Intra-query deadlock when values are inserted into a partitioned clustered columnstore index in SQL Server 2016 or 2017 (KB4089948)](https://support.microsoft.com/help/4089948) | SQL Server Engine | Column Stores | All |
| <a id="11561331">[11561331](#11561331)</a> | [FIX: SQL Server stops responding when you remove the availability group listener or change their port number (KB4089946)](https://support.microsoft.com/help/4089946) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11677397">[11677397](#11677397)</a> | [FIX: Pacemaker promotes an unsynchronized replica to primary when you use AlwaysOn AG in SQL Server 2017 on Linux (KB4091722)](https://support.microsoft.com/help/4091722) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="11569058">[11569058](#11569058)</a> | [FIX: In-Memory OLTP database takes a long time to recover in SQL Server 2017 (KB4090789)](https://support.microsoft.com/help/4090789) | SQL Server Engine | Linux | Linux |
| <a id="11705681">[11705681](#11705681)</a> | [FIX: Can't stop the SQL Server Linux Docker container by using the "docker stop" command (KB4093805)](https://support.microsoft.com/help/4093805) | SQL Server Engine | Linux | Linux |
| <a id="11455785">[11455785](#11455785)</a> | [FIX: Heavy tempdb contention occurs in SQL Server 2016 or 2017 (KB4058174)](https://support.microsoft.com/help/4058174) | SQL Server Engine | Metadata | Windows |
| <a id="11469023">[11469023](#11469023)</a> | [FIX: Very large PAGELATCH_EX contentions occur when you drop temporary objects in SQL Server (KB4088270)](https://support.microsoft.com/help/4088270) | SQL Server Engine | Metadata | Windows |
| <a id="11542851">[11542851](#11542851)</a> | [Better intra-query parallelism deadlocks troubleshooting in SQL Server 2017 (KB4089473)](https://support.microsoft.com/help/4089473) | SQL Server Engine | Query Execution | All |
| <a id="11686345">[11686345](#11686345)</a> | [FIX: Errors 1921 and 1750 when you create a node or edge table in database that has binary collation in SQL Server 2017 (KB4092667)](https://support.microsoft.com/help/4092667) | SQL Server Engine | Query Execution | All |
| <a id="11789381">[11789381](#11789381)</a> | [Improves the query performance when an optimized bitmap filter is applied to a query plan in SQL Server 2016 and 2017 (KB4089276)](https://support.microsoft.com/help/4089276) | SQL Server Engine | Query Optimizer | All |
| <a id="11591383">[11591383](#11591383)</a> | [FIX: Access violation occurs when you query a table with an integer column in SQL Server 2017 (KB4091245)](https://support.microsoft.com/help/4091245) | SQL Server Engine | Query Optimizer | Windows |
| <a id="11632824">[11632824](#11632824)</a> | [FIX: Access violation occurs when Query Store collects runtime statistics in SQL Server 2017 (KB4091063)](https://support.microsoft.com/help/4091063) | SQL Server Engine | Query Store | All |
| <a id="11552950">[11552950](#11552950)</a> | FIX: Replication not enabled when database collation uses '`_SC`' collation extension in SQL Server 2017 (KB4092066) | SQL Server Engine | Replication | Windows |
| <a id="11516257">[11516257](#11516257)</a> | [FIX: Error 9002 when there's no sufficient disk space for critical log growth in SQL Server 2014, 2016, and 2017 (KB4087406)](https://support.microsoft.com/help/4087406) | SQL Server Engine | Transaction Services | All |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU5 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2018/03/sqlserver2017-kb4092643-x64_b462f2bc7e714b51e0ddd4511a3b3faf4b5d2c8e.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4092643-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4092643-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4092643-x64.exe| 1CAA572C91F933AD1B133456ABE2BA3EB66B007ECB2319C09F9301EAE69D92F8 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.204.1  | 266408    | 28-Jan-18 | 14:00 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.204.1      | 741536    | 28-Jan-18 | 14:01 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.204.1      | 1380520   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.204.1      | 984232    | 28-Jan-18 | 14:00 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.204.1      | 521384    | 28-Jan-18 | 14:00 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201   | 174816    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201   | 36576     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201   | 48864     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201   | 105184    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201   | 5167328   | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201   | 26336     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201   | 26848     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201   | 26848     | 11-Jan-18 | 14:32 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201   | 159456    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201   | 82656     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201   | 67296     | 11-Jan-18 | 14:32 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201   | 25824     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151264    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201   | 13032160  | 25-Oct-17 | 03:11 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484      | 1044672   | 25-Oct-17 | 03:11 | x86      |
| Msmdctr.dll                                        | 2017.140.204.1  | 40096     | 28-Jan-18 | 14:01 | x64      |
| Msmdlocal.dll                                      | 2017.140.204.1  | 40377504  | 28-Jan-18 | 13:30 | x86      |
| Msmdlocal.dll                                      | 2017.140.204.1  | 60709032  | 28-Jan-18 | 14:01 | x64      |
| Msmdpump.dll                                       | 2017.140.204.1  | 9334952   | 28-Jan-18 | 14:01 | x64      |
| Msmdredir.dll                                      | 2017.140.204.1  | 7092384   | 28-Jan-18 | 13:30 | x86      |
| Msmdsrv.exe                                        | 2017.140.204.1  | 60609704  | 28-Jan-18 | 14:01 | x64      |
| Msmgdsrv.dll                                       | 2017.140.204.1  | 7310496   | 28-Jan-18 | 13:30 | x86      |
| Msmgdsrv.dll                                       | 2017.140.204.1  | 9004712   | 28-Jan-18 | 14:01 | x64      |
| Msolap.dll                                         | 2017.140.204.1  | 7776928   | 28-Jan-18 | 13:01 | x86      |
| Msolap.dll                                         | 2017.140.204.1  | 10258592  | 28-Jan-18 | 13:31 | x64      |
| Msolui.dll                                         | 2017.140.204.1  | 287392    | 28-Jan-18 | 13:30 | x86      |
| Msolui.dll                                         | 2017.140.204.1  | 310952    | 28-Jan-18 | 14:01 | x64      |
| Powerbiextensions.dll                              | 2.49.4831.201   | 5316832   | 25-Oct-17 | 03:11 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlboot.dll                                        | 2017.140.3023.8 | 195232    | 03-Mar-18 | 02:26 | x64      |
| Sqlceip.exe                                        | 14.0.3023.8     | 251040    | 03-Mar-18 | 09:28 | x86      |
| Sqldumper.exe                                      | 2017.140.3023.8 | 140440    | 03-Mar-18 | 07:00 | x64      |
| Sqldumper.exe                                      | 2017.140.3023.8 | 118944    | 03-Mar-18 | 07:03 | x86      |
| Tmapi.dll                                          | 2017.140.204.1  | 5822624   | 28-Jan-18 | 14:01 | x64      |
| Tmcachemgr.dll                                     | 2017.140.204.1  | 4164768   | 28-Jan-18 | 14:01 | x64      |
| Tmpersistence.dll                                  | 2017.140.204.1  | 1132200   | 28-Jan-18 | 14:01 | x64      |
| Tmtransactions.dll                                 | 2017.140.204.1  | 1640096   | 28-Jan-18 | 14:01 | x64      |
| Xe.dll                                             | 2017.140.3023.8 | 673440    | 03-Mar-18 | 06:59 | x64      |
| Xmlrw.dll                                          | 2017.140.3023.8 | 257696    | 03-Mar-18 | 09:38 | x86      |
| Xmlrw.dll                                          | 2017.140.3023.8 | 305312    | 03-Mar-18 | 02:26 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3023.8 | 189600    | 03-Mar-18 | 09:38 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3023.8 | 224416    | 03-Mar-18 | 02:26 | x64      |
| Xmsrv.dll                                          | 2017.140.204.1  | 33350816  | 28-Jan-18 | 13:31 | x86      |
| Xmsrv.dll                                          | 2017.140.204.1  | 25375400  | 28-Jan-18 | 14:01 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3023.8  | 160416    | 03-Mar-18 | 02:05 | x86      |
| Batchparser.dll                            | 2017.140.3023.8  | 180896    | 03-Mar-18 | 02:06 | x64      |
| Instapi140.dll                             | 2017.140.3023.8  | 61088     | 03-Mar-18 | 02:24 | x86      |
| Instapi140.dll                             | 2017.140.3023.8  | 70304     | 03-Mar-18 | 02:26 | x64      |
| Isacctchange.dll                           | 2017.140.3023.8  | 29344     | 03-Mar-18 | 07:03 | x86      |
| Isacctchange.dll                           | 2017.140.3023.8  | 30872     | 03-Mar-18 | 07:26 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088672   | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088680   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.204.1       | 1381536   | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741544    | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741536    | 28-Jan-18 | 14:00 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3023.8      | 37024     | 03-Mar-18 | 07:04 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3023.8  | 78488     | 03-Mar-18 | 02:24 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3023.8  | 82080     | 03-Mar-18 | 02:26 | x64      |
| Msasxpress.dll                             | 2017.140.204.1   | 31904     | 28-Jan-18 | 13:30 | x86      |
| Msasxpress.dll                             | 2017.140.204.1   | 36008     | 28-Jan-18 | 14:01 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3023.8  | 67744     | 03-Mar-18 | 09:38 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3023.8  | 82080     | 03-Mar-18 | 11:00 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3023.8  | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqldumper.exe                              | 2017.140.3023.8  | 140440    | 03-Mar-18 | 07:00 | x64      |
| Sqldumper.exe                              | 2017.140.3023.8  | 118944    | 03-Mar-18 | 07:03 | x86      |
| Sqlftacct.dll                              | 2017.140.3023.8  | 54432     | 03-Mar-18 | 07:05 | x86      |
| Sqlftacct.dll                              | 2017.140.3023.8  | 62112     | 03-Mar-18 | 11:00 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 10-Jan-18 | 09:00 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 10-Jan-18 | 19:54 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3023.8  | 372384    | 03-Mar-18 | 09:37 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3023.8  | 415904    | 03-Mar-18 | 11:00 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3023.8  | 37536     | 03-Mar-18 | 07:30 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3023.8  | 34976     | 03-Mar-18 | 09:38 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3023.8  | 356000    | 03-Mar-18 | 11:00 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3023.8  | 273048    | 03-Mar-18 | 02:43 | x86      |
| Sqltdiagn.dll                              | 2017.140.3023.8  | 60576     | 03-Mar-18 | 02:05 | x86      |
| Sqltdiagn.dll                              | 2017.140.3023.8  | 67744     | 03-Mar-18 | 02:07 | x64      |
| Svrenumapi140.dll                          | 2017.140.3023.8  | 893600    | 03-Mar-18 | 09:38 | x86      |
| Svrenumapi140.dll                          | 2017.140.3023.8  | 1173152   | 03-Mar-18 | 11:00 | x64      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3023.8 | 120992    | 03-Mar-18 | 09:31 | x86      |
| Dreplaycommon.dll              | 2017.140.3023.8 | 698016    | 03-Mar-18 | 09:31 | x86      |
| Dreplayserverps.dll            | 2017.140.3023.8 | 32920     | 03-Mar-18 | 02:12 | x86      |
| Dreplayutil.dll                | 2017.140.3023.8 | 309920    | 03-Mar-18 | 09:31 | x86      |
| Instapi140.dll                 | 2017.140.3023.8 | 70304     | 03-Mar-18 | 02:26 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlresourceloader.dll          | 2017.140.3023.8 | 29344     | 03-Mar-18 | 02:12 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3023.8 | 698016    | 03-Mar-18 | 09:31 | x86      |
| Dreplaycontroller.exe              | 2017.140.3023.8 | 350368    | 03-Mar-18 | 09:31 | x86      |
| Dreplayprocess.dll                 | 2017.140.3023.8 | 171680    | 03-Mar-18 | 09:31 | x86      |
| Dreplayserverps.dll                | 2017.140.3023.8 | 32920     | 03-Mar-18 | 02:12 | x86      |
| Instapi140.dll                     | 2017.140.3023.8 | 70304     | 03-Mar-18 | 02:26 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlresourceloader.dll              | 2017.140.3023.8 | 29344     | 03-Mar-18 | 02:12 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3023.8 | 180896    | 03-Mar-18 | 02:06 | x64      |
| C1.dll                                       | 18.10.40116.18  | 909312    | 15-Dec-17 | 20:22 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5325312   | 11-Jan-18 | 12:42 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 176128    | 15-Dec-17 | 20:22 | x64      |
| Datacollectorcontroller.dll                  | 2017.140.3023.8 | 225952    | 03-Mar-18 | 07:26 | x64      |
| Dcexec.exe                                   | 2017.140.3023.8 | 74400     | 03-Mar-18 | 10:59 | x64      |
| Fssres.dll                                   | 2017.140.3023.8 | 89248     | 03-Mar-18 | 07:27 | x64      |
| Hadrres.dll                                  | 2017.140.3023.8 | 187544    | 03-Mar-18 | 07:27 | x64      |
| Hkcompile.dll                                | 2017.140.3023.8 | 1423008   | 03-Mar-18 | 07:27 | x64      |
| Hkengine.dll                                 | 2017.140.3023.8 | 5858976   | 03-Mar-18 | 07:27 | x64      |
| Hkruntime.dll                                | 2017.140.3023.8 | 161952    | 03-Mar-18 | 09:26 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1001472   | 11-Jan-18 | 12:42 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.204.1      | 741024    | 28-Jan-18 | 14:00 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3023.8     | 237216    | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3023.8     | 79520     | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3023.8 | 71328     | 03-Mar-18 | 02:26 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3023.8 | 65184     | 03-Mar-18 | 02:10 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3023.8 | 152224    | 03-Mar-18 | 09:26 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3023.8 | 159392    | 03-Mar-18 | 06:59 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3023.8 | 304288    | 03-Mar-18 | 07:00 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3023.8 | 74912     | 03-Mar-18 | 09:26 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 113664    | 15-Dec-17 | 20:22 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 543232    | 14-Jan-18 | 17:27 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 543232    | 14-Jan-18 | 17:27 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 645120    | 15-Dec-17 | 20:22 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 948736    | 15-Dec-17 | 20:22 | x64      |
| Odsole70.dll                                 | 2017.140.3023.8 | 92832     | 03-Mar-18 | 07:27 | x64      |
| Opends60.dll                                 | 2017.140.3023.8 | 32920     | 03-Mar-18 | 02:16 | x64      |
| Qds.dll                                      | 2017.140.3023.8 | 1168032   | 03-Mar-18 | 09:28 | x64      |
| Rsfxft.dll                                   | 2017.140.3023.8 | 34456     | 03-Mar-18 | 02:07 | x64      |
| Secforwarder.dll                             | 2017.140.3023.8 | 37536     | 03-Mar-18 | 07:04 | x64      |
| Sqagtres.dll                                 | 2017.140.3023.8 | 74400     | 03-Mar-18 | 07:30 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlaamss.dll                                 | 2017.140.3023.8 | 89760     | 03-Mar-18 | 09:37 | x64      |
| Sqlaccess.dll                                | 2017.140.3023.8 | 474784    | 03-Mar-18 | 03:01 | x64      |
| Sqlagent.exe                                 | 2017.140.3023.8 | 579736    | 03-Mar-18 | 09:37 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3023.8 | 61088     | 03-Mar-18 | 07:06 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3023.8 | 52896     | 03-Mar-18 | 09:37 | x86      |
| Sqlagentlog.dll                              | 2017.140.3023.8 | 32928     | 03-Mar-18 | 02:07 | x64      |
| Sqlagentmail.dll                             | 2017.140.3023.8 | 53912     | 03-Mar-18 | 02:16 | x64      |
| Sqlboot.dll                                  | 2017.140.3023.8 | 195232    | 03-Mar-18 | 02:26 | x64      |
| Sqlceip.exe                                  | 14.0.3023.8     | 251040    | 03-Mar-18 | 09:28 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3023.8 | 72352     | 03-Mar-18 | 03:01 | x64      |
| Sqlctr140.dll                                | 2017.140.3023.8 | 111776    | 03-Mar-18 | 07:05 | x86      |
| Sqlctr140.dll                                | 2017.140.3023.8 | 129184    | 03-Mar-18 | 07:30 | x64      |
| Sqldk.dll                                    | 2017.140.3023.8 | 2793632   | 03-Mar-18 | 09:26 | x64      |
| Sqldtsss.dll                                 | 2017.140.3023.8 | 107168    | 03-Mar-18 | 11:00 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 4018336   | 03-Mar-18 | 02:18 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3361440   | 03-Mar-18 | 02:18 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3779232   | 03-Mar-18 | 02:18 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3814560   | 03-Mar-18 | 02:18 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 1442976   | 03-Mar-18 | 02:19 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 1495712   | 03-Mar-18 | 02:19 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3772064   | 03-Mar-18 | 02:19 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 2086560   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3396256   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 2033312   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3475104   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3285664   | 03-Mar-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3778720   | 03-Mar-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3582624   | 03-Mar-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3669664   | 03-Mar-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3291296   | 03-Mar-18 | 02:22 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3332768   | 03-Mar-18 | 02:22 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3628704   | 03-Mar-18 | 02:23 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3908768   | 03-Mar-18 | 02:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3591328   | 03-Mar-18 | 02:25 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3911320   | 03-Mar-18 | 02:26 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3023.8 | 3208864   | 03-Mar-18 | 02:27 | x64      |
| Sqliosim.com                                 | 2017.140.3023.8 | 313504    | 03-Mar-18 | 07:15 | x64      |
| Sqliosim.exe                                 | 2017.140.3023.8 | 3019936   | 03-Mar-18 | 07:30 | x64      |
| Sqllang.dll                                  | 2017.140.3023.8 | 41218208  | 03-Mar-18 | 09:28 | x64      |
| Sqlmin.dll                                   | 2017.140.3023.8 | 40269472  | 03-Mar-18 | 09:28 | x64      |
| Sqlolapss.dll                                | 2017.140.3023.8 | 107680    | 03-Mar-18 | 07:26 | x64      |
| Sqlos.dll                                    | 2017.140.3023.8 | 26272     | 03-Mar-18 | 07:04 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3023.8 | 67744     | 03-Mar-18 | 07:26 | x64      |
| Sqlrepss.dll                                 | 2017.140.3023.8 | 64160     | 03-Mar-18 | 07:26 | x64      |
| Sqlresld.dll                                 | 2017.140.3023.8 | 30880     | 03-Mar-18 | 03:01 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3023.8 | 32416     | 03-Mar-18 | 02:07 | x64      |
| Sqlscm.dll                                   | 2017.140.3023.8 | 70816     | 03-Mar-18 | 03:01 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3023.8 | 27808     | 03-Mar-18 | 02:07 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3023.8 | 5871776   | 03-Mar-18 | 02:07 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3023.8 | 732832    | 03-Mar-18 | 07:26 | x64      |
| Sqlservr.exe                                 | 2017.140.3023.8 | 487072    | 03-Mar-18 | 09:28 | x64      |
| Sqlsvc.dll                                   | 2017.140.3023.8 | 161440    | 03-Mar-18 | 07:26 | x64      |
| Sqltses.dll                                  | 2017.140.3023.8 | 9536672   | 03-Mar-18 | 09:26 | x64      |
| Sqsrvres.dll                                 | 2017.140.3023.8 | 260256    | 03-Mar-18 | 07:30 | x64      |
| Svl.dll                                      | 2017.140.3023.8 | 153760    | 03-Mar-18 | 09:28 | x64      |
| Xe.dll                                       | 2017.140.3023.8 | 673440    | 03-Mar-18 | 06:59 | x64      |
| Xmlrw.dll                                    | 2017.140.3023.8 | 305312    | 03-Mar-18 | 02:26 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3023.8 | 224416    | 03-Mar-18 | 02:26 | x64      |
| Xpadsi.exe                                   | 2017.140.3023.8 | 89760     | 03-Mar-18 | 07:27 | x64      |
| Xplog70.dll                                  | 2017.140.3023.8 | 75936     | 03-Mar-18 | 09:28 | x64      |
| Xpqueue.dll                                  | 2017.140.3023.8 | 74912     | 03-Mar-18 | 07:30 | x64      |
| Xprepl.dll                                   | 2017.140.3023.8 | 101536    | 03-Mar-18 | 07:30 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3023.8 | 32416     | 03-Mar-18 | 03:01 | x64      |
| Xpstar.dll                                   | 2017.140.3023.8 | 437400    | 03-Mar-18 | 07:27 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3023.8 | 160416    | 03-Mar-18 | 02:05 | x86      |
| Batchparser.dll                                             | 2017.140.3023.8 | 180896    | 03-Mar-18 | 02:06 | x64      |
| Bcp.exe                                                     | 2017.140.3023.8 | 119968    | 03-Mar-18 | 07:27 | x64      |
| Commanddest.dll                                             | 2017.140.3023.8 | 245920    | 03-Mar-18 | 07:26 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3023.8 | 116384    | 03-Mar-18 | 07:26 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3023.8 | 187552    | 03-Mar-18 | 03:01 | x64      |
| Distrib.exe                                                 | 2017.140.3023.8 | 202400    | 03-Mar-18 | 07:27 | x64      |
| Dteparse.dll                                                | 2017.140.3023.8 | 111264    | 03-Mar-18 | 07:26 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3023.8 | 89240     | 03-Mar-18 | 07:26 | x64      |
| Dtepkg.dll                                                  | 2017.140.3023.8 | 137880    | 03-Mar-18 | 07:26 | x64      |
| Dtexec.exe                                                  | 2017.140.3023.8 | 73888     | 03-Mar-18 | 07:26 | x64      |
| Dts.dll                                                     | 2017.140.3023.8 | 2998944   | 03-Mar-18 | 07:26 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3023.8 | 475296    | 03-Mar-18 | 07:26 | x64      |
| Dtsconn.dll                                                 | 2017.140.3023.8 | 497304    | 03-Mar-18 | 07:26 | x64      |
| Dtshost.exe                                                 | 2017.140.3023.8 | 103584    | 03-Mar-18 | 07:27 | x64      |
| Dtslog.dll                                                  | 2017.140.3023.8 | 120480    | 03-Mar-18 | 07:26 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3023.8 | 545440    | 03-Mar-18 | 02:26 | x64      |
| Dtspipeline.dll                                             | 2017.140.3023.8 | 1266336   | 03-Mar-18 | 07:26 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3023.8 | 48288     | 03-Mar-18 | 10:59 | x64      |
| Dtuparse.dll                                                | 2017.140.3023.8 | 89248     | 03-Mar-18 | 07:26 | x64      |
| Dtutil.exe                                                  | 2017.140.3023.8 | 147104    | 03-Mar-18 | 07:26 | x64      |
| Exceldest.dll                                               | 2017.140.3023.8 | 260768    | 03-Mar-18 | 07:26 | x64      |
| Excelsrc.dll                                                | 2017.140.3023.8 | 282784    | 03-Mar-18 | 07:26 | x64      |
| Execpackagetask.dll                                         | 2017.140.3023.8 | 168096    | 03-Mar-18 | 07:26 | x64      |
| Flatfiledest.dll                                            | 2017.140.3023.8 | 384160    | 03-Mar-18 | 07:26 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3023.8 | 396448    | 03-Mar-18 | 03:01 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3023.8 | 96416     | 03-Mar-18 | 07:26 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3023.8 | 59544     | 03-Mar-18 | 07:27 | x64      |
| Logread.exe                                                 | 2017.140.3023.8 | 634016    | 03-Mar-18 | 07:29 | x64      |
| Mergetxt.dll                                                | 2017.140.3023.8 | 63136     | 03-Mar-18 | 07:29 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.204.1      | 1381536   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3023.8     | 89760     | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3023.8 | 1650336   | 03-Mar-18 | 07:26 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3023.8 | 152224    | 03-Mar-18 | 09:26 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3023.8 | 159392    | 03-Mar-18 | 06:59 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3023.8 | 103072    | 03-Mar-18 | 07:26 | x64      |
| Msgprox.dll                                                 | 2017.140.3023.8 | 269984    | 03-Mar-18 | 07:29 | x64      |
| Msxmlsql.dll                                                | 2017.140.3023.8 | 1448096   | 03-Mar-18 | 09:28 | x64      |
| Oledbdest.dll                                               | 2017.140.3023.8 | 261280    | 03-Mar-18 | 07:26 | x64      |
| Oledbsrc.dll                                                | 2017.140.3023.8 | 288928    | 03-Mar-18 | 07:26 | x64      |
| Osql.exe                                                    | 2017.140.3023.8 | 75424     | 03-Mar-18 | 02:26 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3023.8 | 472736    | 03-Mar-18 | 07:30 | x64      |
| Rawdest.dll                                                 | 2017.140.3023.8 | 206496    | 03-Mar-18 | 07:26 | x64      |
| Rawsource.dll                                               | 2017.140.3023.8 | 194208    | 03-Mar-18 | 07:26 | x64      |
| Rdistcom.dll                                                | 2017.140.3023.8 | 856224    | 03-Mar-18 | 03:01 | x64      |
| Recordsetdest.dll                                           | 2017.140.3023.8 | 184480    | 03-Mar-18 | 07:26 | x64      |
| Replagnt.dll                                                | 2017.140.3023.8 | 30872     | 03-Mar-18 | 11:00 | x64      |
| Repldp.dll                                                  | 2017.140.3023.8 | 290464    | 03-Mar-18 | 03:01 | x64      |
| Replerrx.dll                                                | 2017.140.3023.8 | 153760    | 03-Mar-18 | 03:01 | x64      |
| Replisapi.dll                                               | 2017.140.3023.8 | 361632    | 03-Mar-18 | 07:30 | x64      |
| Replmerg.exe                                                | 2017.140.3023.8 | 524960    | 03-Mar-18 | 11:00 | x64      |
| Replprov.dll                                                | 2017.140.3023.8 | 801440    | 03-Mar-18 | 07:30 | x64      |
| Replrec.dll                                                 | 2017.140.3023.8 | 975008    | 03-Mar-18 | 07:30 | x64      |
| Replsub.dll                                                 | 2017.140.3023.8 | 445600    | 03-Mar-18 | 11:00 | x64      |
| Replsync.dll                                                | 2017.140.3023.8 | 153760    | 03-Mar-18 | 07:30 | x64      |
| Spresolv.dll                                                | 2017.140.3023.8 | 252064    | 03-Mar-18 | 07:30 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3023.8 | 248984    | 03-Mar-18 | 02:26 | x64      |
| Sqldiag.exe                                                 | 2017.140.3023.8 | 1257632   | 03-Mar-18 | 07:30 | x64      |
| Sqldistx.dll                                                | 2017.140.3023.8 | 224928    | 03-Mar-18 | 07:30 | x64      |
| Sqllogship.exe                                              | 14.0.3023.8     | 105632    | 03-Mar-18 | 02:26 | x64      |
| Sqlmergx.dll                                                | 2017.140.3023.8 | 360608    | 03-Mar-18 | 03:01 | x64      |
| Sqlresld.dll                                                | 2017.140.3023.8 | 28832     | 03-Mar-18 | 07:04 | x86      |
| Sqlresld.dll                                                | 2017.140.3023.8 | 30880     | 03-Mar-18 | 03:01 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3023.8 | 32416     | 03-Mar-18 | 02:07 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3023.8 | 29344     | 03-Mar-18 | 02:12 | x86      |
| Sqlscm.dll                                                  | 2017.140.3023.8 | 60064     | 03-Mar-18 | 02:43 | x86      |
| Sqlscm.dll                                                  | 2017.140.3023.8 | 70816     | 03-Mar-18 | 03:01 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3023.8 | 161440    | 03-Mar-18 | 07:26 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3023.8 | 134304    | 03-Mar-18 | 09:37 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3023.8 | 183968    | 03-Mar-18 | 07:26 | x64      |
| Sqlwep140.dll                                               | 2017.140.3023.8 | 105632    | 03-Mar-18 | 07:30 | x64      |
| Ssdebugps.dll                                               | 2017.140.3023.8 | 33440     | 03-Mar-18 | 07:30 | x64      |
| Ssisoledb.dll                                               | 2017.140.3023.8 | 216216    | 03-Mar-18 | 07:26 | x64      |
| Ssradd.dll                                                  | 2017.140.3023.8 | 74912     | 03-Mar-18 | 07:30 | x64      |
| Ssravg.dll                                                  | 2017.140.3023.8 | 74912     | 03-Mar-18 | 07:30 | x64      |
| Ssrdown.dll                                                 | 2017.140.3023.8 | 60064     | 03-Mar-18 | 07:30 | x64      |
| Ssrmax.dll                                                  | 2017.140.3023.8 | 72864     | 03-Mar-18 | 07:30 | x64      |
| Ssrmin.dll                                                  | 2017.140.3023.8 | 73376     | 03-Mar-18 | 07:30 | x64      |
| Ssrpub.dll                                                  | 2017.140.3023.8 | 60576     | 03-Mar-18 | 07:30 | x64      |
| Ssrup.dll                                                   | 2017.140.3023.8 | 60064     | 03-Mar-18 | 07:30 | x64      |
| Txagg.dll                                                   | 2017.140.3023.8 | 362144    | 03-Mar-18 | 07:27 | x64      |
| Txbdd.dll                                                   | 2017.140.3023.8 | 170144    | 03-Mar-18 | 07:27 | x64      |
| Txdatacollector.dll                                         | 2017.140.3023.8 | 360600    | 03-Mar-18 | 03:01 | x64      |
| Txdataconvert.dll                                           | 2017.140.3023.8 | 293024    | 03-Mar-18 | 07:27 | x64      |
| Txderived.dll                                               | 2017.140.3023.8 | 604320    | 03-Mar-18 | 07:27 | x64      |
| Txlookup.dll                                                | 2017.140.3023.8 | 528032    | 03-Mar-18 | 07:27 | x64      |
| Txmerge.dll                                                 | 2017.140.3023.8 | 230048    | 03-Mar-18 | 07:27 | x64      |
| Txmergejoin.dll                                             | 2017.140.3023.8 | 275616    | 03-Mar-18 | 11:00 | x64      |
| Txmulticast.dll                                             | 2017.140.3023.8 | 129696    | 03-Mar-18 | 07:27 | x64      |
| Txrowcount.dll                                              | 2017.140.3023.8 | 125600    | 03-Mar-18 | 07:27 | x64      |
| Txsort.dll                                                  | 2017.140.3023.8 | 256672    | 03-Mar-18 | 07:27 | x64      |
| Txsplit.dll                                                 | 2017.140.3023.8 | 596640    | 03-Mar-18 | 11:00 | x64      |
| Txunionall.dll                                              | 2017.140.3023.8 | 181920    | 03-Mar-18 | 07:27 | x64      |
| Xe.dll                                                      | 2017.140.3023.8 | 673440    | 03-Mar-18 | 06:59 | x64      |
| Xmlrw.dll                                                   | 2017.140.3023.8 | 305312    | 03-Mar-18 | 02:26 | x64      |
| Xmlsub.dll                                                  | 2017.140.3023.8 | 260256    | 03-Mar-18 | 07:30 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3023.8 | 1123488   | 03-Mar-18 | 09:28 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlsatellite.dll              | 2017.140.3023.8 | 920736    | 03-Mar-18 | 07:30 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3023.8 | 667296    | 03-Mar-18 | 09:28 | x64      |
| Fdhost.exe               | 2017.140.3023.8 | 114336    | 03-Mar-18 | 09:28 | x64      |
| Fdlauncher.exe           | 2017.140.3023.8 | 62112     | 03-Mar-18 | 03:01 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlft140ph.dll           | 2017.140.3023.8 | 67744     | 03-Mar-18 | 02:26 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3023.8     | 23704     | 03-Mar-18 | 03:01 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 25-Oct-17 | 03:10 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 25-Oct-17 | 03:10 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 10-Jan-18 | 19:50 | x86      |
| Commanddest.dll                                               | 2017.140.3023.8 | 200856    | 03-Mar-18 | 07:03 | x86      |
| Commanddest.dll                                               | 2017.140.3023.8 | 245920    | 03-Mar-18 | 07:26 | x64      |
| Dteparse.dll                                                  | 2017.140.3023.8 | 100512    | 03-Mar-18 | 07:03 | x86      |
| Dteparse.dll                                                  | 2017.140.3023.8 | 111264    | 03-Mar-18 | 07:26 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3023.8 | 83616     | 03-Mar-18 | 07:03 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3023.8 | 89240     | 03-Mar-18 | 07:26 | x64      |
| Dtepkg.dll                                                    | 2017.140.3023.8 | 116888    | 03-Mar-18 | 07:03 | x86      |
| Dtepkg.dll                                                    | 2017.140.3023.8 | 137880    | 03-Mar-18 | 07:26 | x64      |
| Dtexec.exe                                                    | 2017.140.3023.8 | 67744     | 03-Mar-18 | 07:03 | x86      |
| Dtexec.exe                                                    | 2017.140.3023.8 | 73888     | 03-Mar-18 | 07:26 | x64      |
| Dts.dll                                                       | 2017.140.3023.8 | 2549408   | 03-Mar-18 | 07:03 | x86      |
| Dts.dll                                                       | 2017.140.3023.8 | 2998944   | 03-Mar-18 | 07:26 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3023.8 | 417952    | 03-Mar-18 | 07:03 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3023.8 | 475296    | 03-Mar-18 | 07:26 | x64      |
| Dtsconn.dll                                                   | 2017.140.3023.8 | 399008    | 03-Mar-18 | 07:03 | x86      |
| Dtsconn.dll                                                   | 2017.140.3023.8 | 497304    | 03-Mar-18 | 07:26 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3023.8 | 95392     | 03-Mar-18 | 07:03 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3023.8 | 111264    | 03-Mar-18 | 07:26 | x64      |
| Dtshost.exe                                                   | 2017.140.3023.8 | 89752     | 03-Mar-18 | 07:05 | x86      |
| Dtshost.exe                                                   | 2017.140.3023.8 | 103584    | 03-Mar-18 | 07:27 | x64      |
| Dtslog.dll                                                    | 2017.140.3023.8 | 103072    | 03-Mar-18 | 07:03 | x86      |
| Dtslog.dll                                                    | 2017.140.3023.8 | 120480    | 03-Mar-18 | 07:26 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3023.8 | 541344    | 03-Mar-18 | 02:24 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3023.8 | 545440    | 03-Mar-18 | 02:26 | x64      |
| Dtspipeline.dll                                               | 2017.140.3023.8 | 1058976   | 03-Mar-18 | 07:03 | x86      |
| Dtspipeline.dll                                               | 2017.140.3023.8 | 1266336   | 03-Mar-18 | 07:26 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3023.8 | 42656     | 03-Mar-18 | 07:03 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3023.8 | 48288     | 03-Mar-18 | 10:59 | x64      |
| Dtuparse.dll                                                  | 2017.140.3023.8 | 80032     | 03-Mar-18 | 07:03 | x86      |
| Dtuparse.dll                                                  | 2017.140.3023.8 | 89248     | 03-Mar-18 | 07:26 | x64      |
| Dtutil.exe                                                    | 2017.140.3023.8 | 147104    | 03-Mar-18 | 07:26 | x64      |
| Dtutil.exe                                                    | 2017.140.3023.8 | 126112    | 03-Mar-18 | 09:31 | x86      |
| Exceldest.dll                                                 | 2017.140.3023.8 | 214680    | 03-Mar-18 | 07:03 | x86      |
| Exceldest.dll                                                 | 2017.140.3023.8 | 260768    | 03-Mar-18 | 07:26 | x64      |
| Excelsrc.dll                                                  | 2017.140.3023.8 | 230560    | 03-Mar-18 | 07:03 | x86      |
| Excelsrc.dll                                                  | 2017.140.3023.8 | 282784    | 03-Mar-18 | 07:26 | x64      |
| Execpackagetask.dll                                           | 2017.140.3023.8 | 135328    | 03-Mar-18 | 07:03 | x86      |
| Execpackagetask.dll                                           | 2017.140.3023.8 | 168096    | 03-Mar-18 | 07:26 | x64      |
| Flatfiledest.dll                                              | 2017.140.3023.8 | 384160    | 03-Mar-18 | 07:26 | x64      |
| Flatfiledest.dll                                              | 2017.140.3023.8 | 330912    | 03-Mar-18 | 09:31 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3023.8 | 342176    | 03-Mar-18 | 07:03 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3023.8 | 396448    | 03-Mar-18 | 03:01 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3023.8 | 80544     | 03-Mar-18 | 07:03 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3023.8 | 96416     | 03-Mar-18 | 07:26 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3023.8     | 467104    | 03-Mar-18 | 09:31 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3023.8     | 466592    | 03-Mar-18 | 10:59 | x64      |
| Isserverexec.exe                                              | 14.0.3023.8     | 149152    | 03-Mar-18 | 09:31 | x86      |
| Isserverexec.exe                                              | 14.0.3023.8     | 148640    | 03-Mar-18 | 10:59 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1      | 1381536   | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1      | 1381536   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3023.8     | 71328     | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3023.8 | 107160    | 03-Mar-18 | 07:04 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3023.8 | 112288    | 03-Mar-18 | 07:26 | x64      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3023.8     | 89760     | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3023.8     | 89760     | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3023.8     | 494752    | 03-Mar-18 | 02:06 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3023.8     | 494752    | 03-Mar-18 | 02:24 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3023.8     | 83616     | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3023.8     | 83616     | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3023.8     | 415904    | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3023.8     | 415904    | 03-Mar-18 | 10:59 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3023.8 | 152224    | 03-Mar-18 | 09:26 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3023.8 | 141984    | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3023.8 | 159392    | 03-Mar-18 | 06:59 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3023.8 | 145568    | 03-Mar-18 | 09:37 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3023.8     | 219800    | 03-Mar-18 | 11:00 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3023.8 | 90264     | 03-Mar-18 | 07:03 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3023.8 | 103072    | 03-Mar-18 | 07:26 | x64      |
| Msmdpp.dll                                                    | 2017.140.204.1  | 9194144   | 28-Jan-18 | 14:01 | x64      |
| Oledbdest.dll                                                 | 2017.140.3023.8 | 214688    | 03-Mar-18 | 07:03 | x86      |
| Oledbdest.dll                                                 | 2017.140.3023.8 | 261280    | 03-Mar-18 | 07:26 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3023.8 | 233112    | 03-Mar-18 | 07:03 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3023.8 | 288928    | 03-Mar-18 | 07:26 | x64      |
| Rawdest.dll                                                   | 2017.140.3023.8 | 166560    | 03-Mar-18 | 07:05 | x86      |
| Rawdest.dll                                                   | 2017.140.3023.8 | 206496    | 03-Mar-18 | 07:26 | x64      |
| Rawsource.dll                                                 | 2017.140.3023.8 | 153248    | 03-Mar-18 | 07:05 | x86      |
| Rawsource.dll                                                 | 2017.140.3023.8 | 194208    | 03-Mar-18 | 07:26 | x64      |
| Recordsetdest.dll                                             | 2017.140.3023.8 | 149152    | 03-Mar-18 | 07:05 | x86      |
| Recordsetdest.dll                                             | 2017.140.3023.8 | 184480    | 03-Mar-18 | 07:26 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlceip.exe                                                   | 14.0.3023.8     | 251040    | 03-Mar-18 | 09:28 | x86      |
| Sqldest.dll                                                   | 2017.140.3023.8 | 213656    | 03-Mar-18 | 07:04 | x86      |
| Sqldest.dll                                                   | 2017.140.3023.8 | 260768    | 03-Mar-18 | 03:01 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3023.8 | 155296    | 03-Mar-18 | 07:04 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3023.8 | 183968    | 03-Mar-18 | 07:26 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3023.8 | 176792    | 03-Mar-18 | 07:04 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3023.8 | 216216    | 03-Mar-18 | 07:26 | x64      |
| Txagg.dll                                                     | 2017.140.3023.8 | 302240    | 03-Mar-18 | 07:05 | x86      |
| Txagg.dll                                                     | 2017.140.3023.8 | 362144    | 03-Mar-18 | 07:27 | x64      |
| Txbdd.dll                                                     | 2017.140.3023.8 | 136352    | 03-Mar-18 | 07:05 | x86      |
| Txbdd.dll                                                     | 2017.140.3023.8 | 170144    | 03-Mar-18 | 07:27 | x64      |
| Txbestmatch.dll                                               | 2017.140.3023.8 | 493216    | 03-Mar-18 | 07:05 | x86      |
| Txbestmatch.dll                                               | 2017.140.3023.8 | 605344    | 03-Mar-18 | 07:27 | x64      |
| Txcache.dll                                                   | 2017.140.3023.8 | 146072    | 03-Mar-18 | 07:05 | x86      |
| Txcache.dll                                                   | 2017.140.3023.8 | 180384    | 03-Mar-18 | 11:00 | x64      |
| Txcharmap.dll                                                 | 2017.140.3023.8 | 248992    | 03-Mar-18 | 07:05 | x86      |
| Txcharmap.dll                                                 | 2017.140.3023.8 | 286880    | 03-Mar-18 | 07:27 | x64      |
| Txcopymap.dll                                                 | 2017.140.3023.8 | 145568    | 03-Mar-18 | 07:05 | x86      |
| Txcopymap.dll                                                 | 2017.140.3023.8 | 184992    | 03-Mar-18 | 07:27 | x64      |
| Txdataconvert.dll                                             | 2017.140.3023.8 | 253088    | 03-Mar-18 | 07:05 | x86      |
| Txdataconvert.dll                                             | 2017.140.3023.8 | 293024    | 03-Mar-18 | 07:27 | x64      |
| Txderived.dll                                                 | 2017.140.3023.8 | 515744    | 03-Mar-18 | 07:05 | x86      |
| Txderived.dll                                                 | 2017.140.3023.8 | 604320    | 03-Mar-18 | 07:27 | x64      |
| Txfileextractor.dll                                           | 2017.140.3023.8 | 160928    | 03-Mar-18 | 07:05 | x86      |
| Txfileextractor.dll                                           | 2017.140.3023.8 | 198816    | 03-Mar-18 | 07:27 | x64      |
| Txfileinserter.dll                                            | 2017.140.3023.8 | 159392    | 03-Mar-18 | 07:05 | x86      |
| Txfileinserter.dll                                            | 2017.140.3023.8 | 196768    | 03-Mar-18 | 11:00 | x64      |
| Txgroupdups.dll                                               | 2017.140.3023.8 | 231072    | 03-Mar-18 | 07:05 | x86      |
| Txgroupdups.dll                                               | 2017.140.3023.8 | 290464    | 03-Mar-18 | 03:01 | x64      |
| Txlineage.dll                                                 | 2017.140.3023.8 | 110240    | 03-Mar-18 | 07:05 | x86      |
| Txlineage.dll                                                 | 2017.140.3023.8 | 136864    | 03-Mar-18 | 07:27 | x64      |
| Txlookup.dll                                                  | 2017.140.3023.8 | 446624    | 03-Mar-18 | 07:05 | x86      |
| Txlookup.dll                                                  | 2017.140.3023.8 | 528032    | 03-Mar-18 | 07:27 | x64      |
| Txmerge.dll                                                   | 2017.140.3023.8 | 176792    | 03-Mar-18 | 07:05 | x86      |
| Txmerge.dll                                                   | 2017.140.3023.8 | 230048    | 03-Mar-18 | 07:27 | x64      |
| Txmergejoin.dll                                               | 2017.140.3023.8 | 221856    | 03-Mar-18 | 07:05 | x86      |
| Txmergejoin.dll                                               | 2017.140.3023.8 | 275616    | 03-Mar-18 | 11:00 | x64      |
| Txmulticast.dll                                               | 2017.140.3023.8 | 102560    | 03-Mar-18 | 07:05 | x86      |
| Txmulticast.dll                                               | 2017.140.3023.8 | 129696    | 03-Mar-18 | 07:27 | x64      |
| Txpivot.dll                                                   | 2017.140.3023.8 | 180384    | 03-Mar-18 | 07:05 | x86      |
| Txpivot.dll                                                   | 2017.140.3023.8 | 224928    | 03-Mar-18 | 07:27 | x64      |
| Txrowcount.dll                                                | 2017.140.3023.8 | 101536    | 03-Mar-18 | 07:05 | x86      |
| Txrowcount.dll                                                | 2017.140.3023.8 | 125600    | 03-Mar-18 | 07:27 | x64      |
| Txsampling.dll                                                | 2017.140.3023.8 | 135840    | 03-Mar-18 | 07:05 | x86      |
| Txsampling.dll                                                | 2017.140.3023.8 | 172704    | 03-Mar-18 | 07:27 | x64      |
| Txscd.dll                                                     | 2017.140.3023.8 | 170144    | 03-Mar-18 | 07:05 | x86      |
| Txscd.dll                                                     | 2017.140.3023.8 | 220832    | 03-Mar-18 | 07:27 | x64      |
| Txsort.dll                                                    | 2017.140.3023.8 | 208032    | 03-Mar-18 | 07:05 | x86      |
| Txsort.dll                                                    | 2017.140.3023.8 | 256672    | 03-Mar-18 | 07:27 | x64      |
| Txsplit.dll                                                   | 2017.140.3023.8 | 510624    | 03-Mar-18 | 07:05 | x86      |
| Txsplit.dll                                                   | 2017.140.3023.8 | 596640    | 03-Mar-18 | 11:00 | x64      |
| Txtermextraction.dll                                          | 2017.140.3023.8 | 8615072   | 03-Mar-18 | 07:05 | x86      |
| Txtermextraction.dll                                          | 2017.140.3023.8 | 8676512   | 03-Mar-18 | 07:27 | x64      |
| Txtermlookup.dll                                              | 2017.140.3023.8 | 4106912   | 03-Mar-18 | 07:05 | x86      |
| Txtermlookup.dll                                              | 2017.140.3023.8 | 4157088   | 03-Mar-18 | 07:27 | x64      |
| Txunionall.dll                                                | 2017.140.3023.8 | 181920    | 03-Mar-18 | 07:27 | x64      |
| Txunionall.dll                                                | 2017.140.3023.8 | 139424    | 03-Mar-18 | 09:37 | x86      |
| Txunpivot.dll                                                 | 2017.140.3023.8 | 160408    | 03-Mar-18 | 07:05 | x86      |
| Txunpivot.dll                                                 | 2017.140.3023.8 | 199840    | 03-Mar-18 | 07:27 | x64      |
| Xe.dll                                                        | 2017.140.3023.8 | 673440    | 03-Mar-18 | 06:59 | x64      |
| Xe.dll                                                        | 2017.140.3023.8 | 595616    | 03-Mar-18 | 09:30 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 28-Jan-18 | 14:02 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 28-Jan-18 | 14:02 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 28-Jan-18 | 14:02 | x86      |
| Instapi140.dll                                                       | 2017.140.3023.8  | 70304     | 03-Mar-18 | 02:26 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 28-Jan-18 | 14:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 28-Jan-18 | 14:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 28-Jan-18 | 14:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 28-Jan-18 | 14:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 28-Jan-18 | 14:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 28-Jan-18 | 14:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 28-Jan-18 | 14:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 28-Jan-18 | 14:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 28-Jan-18 | 14:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 28-Jan-18 | 14:02 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3023.8  | 407200    | 03-Mar-18 | 09:28 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3023.8  | 7323808   | 03-Mar-18 | 09:28 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3023.8  | 2263200   | 03-Mar-18 | 07:30 | x64      |
| Secforwarder.dll                                                     | 2017.140.3023.8  | 37536     | 03-Mar-18 | 07:04 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 28-Jan-18 | 14:02 | x64      |
| Sqldk.dll                                                            | 2017.140.3023.8  | 2709504   | 03-Mar-18 | 07:04 | x64      |
| Sqldumper.exe                                                        | 2017.140.3023.8  | 140440    | 03-Mar-18 | 07:00 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 1495712   | 03-Mar-18 | 02:19 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3908768   | 03-Mar-18 | 02:24 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3208864   | 03-Mar-18 | 02:27 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3911320   | 03-Mar-18 | 02:26 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3814560   | 03-Mar-18 | 02:18 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 2086560   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 2033312   | 03-Mar-18 | 02:20 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3582624   | 03-Mar-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3591328   | 03-Mar-18 | 02:25 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 1442976   | 03-Mar-18 | 02:19 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3023.8  | 3778720   | 03-Mar-18 | 02:21 | x64      |
| Sqlos.dll                                                            | 2017.140.3023.8  | 26272     | 03-Mar-18 | 07:04 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 28-Jan-18 | 14:02 | x64      |
| Sqltses.dll                                                          | 2017.140.3023.8  | 9690624   | 03-Mar-18 | 07:04 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3023.8     | 23712     | 03-Mar-18 | 02:26 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |


SQL Server 2017 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2017.140.3023.8 | 1448608   | 03-Mar-18 | 09:37 | x86      |
| Dtaengine.exe                                  | 2017.140.3023.8 | 204448    | 03-Mar-18 | 09:31 | x86      |
| Dteparse.dll                                   | 2017.140.3023.8 | 100512    | 03-Mar-18 | 07:03 | x86      |
| Dteparse.dll                                   | 2017.140.3023.8 | 111264    | 03-Mar-18 | 07:26 | x64      |
| Dteparsemgd.dll                                | 2017.140.3023.8 | 83616     | 03-Mar-18 | 07:03 | x86      |
| Dteparsemgd.dll                                | 2017.140.3023.8 | 89240     | 03-Mar-18 | 07:26 | x64      |
| Dtepkg.dll                                     | 2017.140.3023.8 | 116888    | 03-Mar-18 | 07:03 | x86      |
| Dtepkg.dll                                     | 2017.140.3023.8 | 137880    | 03-Mar-18 | 07:26 | x64      |
| Dtexec.exe                                     | 2017.140.3023.8 | 67744     | 03-Mar-18 | 07:03 | x86      |
| Dtexec.exe                                     | 2017.140.3023.8 | 73888     | 03-Mar-18 | 07:26 | x64      |
| Dts.dll                                        | 2017.140.3023.8 | 2549408   | 03-Mar-18 | 07:03 | x86      |
| Dts.dll                                        | 2017.140.3023.8 | 2998944   | 03-Mar-18 | 07:26 | x64      |
| Dtscomexpreval.dll                             | 2017.140.3023.8 | 417952    | 03-Mar-18 | 07:03 | x86      |
| Dtscomexpreval.dll                             | 2017.140.3023.8 | 475296    | 03-Mar-18 | 07:26 | x64      |
| Dtsconn.dll                                    | 2017.140.3023.8 | 399008    | 03-Mar-18 | 07:03 | x86      |
| Dtsconn.dll                                    | 2017.140.3023.8 | 497304    | 03-Mar-18 | 07:26 | x64      |
| Dtshost.exe                                    | 2017.140.3023.8 | 89752     | 03-Mar-18 | 07:05 | x86      |
| Dtshost.exe                                    | 2017.140.3023.8 | 103584    | 03-Mar-18 | 07:27 | x64      |
| Dtslog.dll                                     | 2017.140.3023.8 | 103072    | 03-Mar-18 | 07:03 | x86      |
| Dtslog.dll                                     | 2017.140.3023.8 | 120480    | 03-Mar-18 | 07:26 | x64      |
| Dtsmsg140.dll                                  | 2017.140.3023.8 | 541344    | 03-Mar-18 | 02:24 | x86      |
| Dtsmsg140.dll                                  | 2017.140.3023.8 | 545440    | 03-Mar-18 | 02:26 | x64      |
| Dtspipeline.dll                                | 2017.140.3023.8 | 1058976   | 03-Mar-18 | 07:03 | x86      |
| Dtspipeline.dll                                | 2017.140.3023.8 | 1266336   | 03-Mar-18 | 07:26 | x64      |
| Dtspipelineperf140.dll                         | 2017.140.3023.8 | 42656     | 03-Mar-18 | 07:03 | x86      |
| Dtspipelineperf140.dll                         | 2017.140.3023.8 | 48288     | 03-Mar-18 | 10:59 | x64      |
| Dtuparse.dll                                   | 2017.140.3023.8 | 80032     | 03-Mar-18 | 07:03 | x86      |
| Dtuparse.dll                                   | 2017.140.3023.8 | 89248     | 03-Mar-18 | 07:26 | x64      |
| Dtutil.exe                                     | 2017.140.3023.8 | 147104    | 03-Mar-18 | 07:26 | x64      |
| Dtutil.exe                                     | 2017.140.3023.8 | 126112    | 03-Mar-18 | 09:31 | x86      |
| Exceldest.dll                                  | 2017.140.3023.8 | 214680    | 03-Mar-18 | 07:03 | x86      |
| Exceldest.dll                                  | 2017.140.3023.8 | 260768    | 03-Mar-18 | 07:26 | x64      |
| Excelsrc.dll                                   | 2017.140.3023.8 | 230560    | 03-Mar-18 | 07:03 | x86      |
| Excelsrc.dll                                   | 2017.140.3023.8 | 282784    | 03-Mar-18 | 07:26 | x64      |
| Flatfiledest.dll                               | 2017.140.3023.8 | 384160    | 03-Mar-18 | 07:26 | x64      |
| Flatfiledest.dll                               | 2017.140.3023.8 | 330912    | 03-Mar-18 | 09:31 | x86      |
| Flatfilesrc.dll                                | 2017.140.3023.8 | 342176    | 03-Mar-18 | 07:03 | x86      |
| Flatfilesrc.dll                                | 2017.140.3023.8 | 396448    | 03-Mar-18 | 03:01 | x64      |
| Foreachfileenumerator.dll                      | 2017.140.3023.8 | 80544     | 03-Mar-18 | 07:03 | x86      |
| Foreachfileenumerator.dll                      | 2017.140.3023.8 | 96416     | 03-Mar-18 | 07:26 | x64      |
| Microsoft.sqlserver.astasks.dll                | 14.0.3023.8     | 71328     | 03-Mar-18 | 09:36 | x86      |
| Microsoft.sqlserver.astasksui.dll              | 14.0.3023.8     | 184480    | 03-Mar-18 | 09:36 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3023.8     | 406688    | 03-Mar-18 | 07:26 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3023.8     | 406688    | 03-Mar-18 | 09:36 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3023.8     | 2093216   | 03-Mar-18 | 07:26 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3023.8     | 2093216   | 03-Mar-18 | 09:36 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3023.8 | 152224    | 03-Mar-18 | 09:26 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3023.8 | 141984    | 03-Mar-18 | 09:37 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3023.8 | 159392    | 03-Mar-18 | 06:59 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3023.8 | 145568    | 03-Mar-18 | 09:37 | x86      |
| Msdtssrvrutil.dll                              | 2017.140.3023.8 | 90264     | 03-Mar-18 | 07:03 | x86      |
| Msdtssrvrutil.dll                              | 2017.140.3023.8 | 103072    | 03-Mar-18 | 07:26 | x64      |
| Msmgdsrv.dll                                   | 2017.140.204.1  | 7310496   | 28-Jan-18 | 13:30 | x86      |
| Oledbdest.dll                                  | 2017.140.3023.8 | 214688    | 03-Mar-18 | 07:03 | x86      |
| Oledbdest.dll                                  | 2017.140.3023.8 | 261280    | 03-Mar-18 | 07:26 | x64      |
| Oledbsrc.dll                                   | 2017.140.3023.8 | 233112    | 03-Mar-18 | 07:03 | x86      |
| Oledbsrc.dll                                   | 2017.140.3023.8 | 288928    | 03-Mar-18 | 07:26 | x64      |
| Sql_tools_extensions_keyfile.dll               | 2017.140.3023.8 | 100512    | 03-Mar-18 | 02:16 | x64      |
| Sqlresld.dll                                   | 2017.140.3023.8 | 28832     | 03-Mar-18 | 07:04 | x86      |
| Sqlresld.dll                                   | 2017.140.3023.8 | 30880     | 03-Mar-18 | 03:01 | x64      |
| Sqlresourceloader.dll                          | 2017.140.3023.8 | 32416     | 03-Mar-18 | 02:07 | x64      |
| Sqlresourceloader.dll                          | 2017.140.3023.8 | 29344     | 03-Mar-18 | 02:12 | x86      |
| Sqlscm.dll                                     | 2017.140.3023.8 | 60064     | 03-Mar-18 | 02:43 | x86      |
| Sqlscm.dll                                     | 2017.140.3023.8 | 70816     | 03-Mar-18 | 03:01 | x64      |
| Sqlsvc.dll                                     | 2017.140.3023.8 | 161440    | 03-Mar-18 | 07:26 | x64      |
| Sqlsvc.dll                                     | 2017.140.3023.8 | 134304    | 03-Mar-18 | 09:37 | x86      |
| Sqltaskconnections.dll                         | 2017.140.3023.8 | 155296    | 03-Mar-18 | 07:04 | x86      |
| Sqltaskconnections.dll                         | 2017.140.3023.8 | 183968    | 03-Mar-18 | 07:26 | x64      |
| Txdataconvert.dll                              | 2017.140.3023.8 | 253088    | 03-Mar-18 | 07:05 | x86      |
| Txdataconvert.dll                              | 2017.140.3023.8 | 293024    | 03-Mar-18 | 07:27 | x64      |
| Xe.dll                                         | 2017.140.3023.8 | 673440    | 03-Mar-18 | 06:59 | x64      |
| Xe.dll                                         | 2017.140.3023.8 | 595616    | 03-Mar-18 | 09:30 | x86      |
| Xmlrw.dll                                      | 2017.140.3023.8 | 257696    | 03-Mar-18 | 09:38 | x86      |
| Xmlrw.dll                                      | 2017.140.3023.8 | 305312    | 03-Mar-18 | 02:26 | x64      |
| Xmlrwbin.dll                                   | 2017.140.3023.8 | 189600    | 03-Mar-18 | 09:38 | x86      |
| Xmlrwbin.dll                                   | 2017.140.3023.8 | 224416    | 03-Mar-18 | 02:26 | x64      |

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
