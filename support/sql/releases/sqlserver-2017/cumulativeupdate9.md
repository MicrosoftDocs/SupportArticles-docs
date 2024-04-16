---
title: Cumulative update 9 for SQL Server 2017 (KB4341265)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 9 (KB4341265).
ms.date: 08/04/2023
ms.custom: KB4341265, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4341265 - Cumulative Update 9 for SQL Server 2017

_Release Date:_ &nbsp; July 18, 2018  
_Version:_ &nbsp; 14.0.3030.27

## Summary

This article describes Cumulative Update package 9 (CU9) for Microsoft SQL Server 2017. This update contains 18 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 8, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3030.27**, file version: **2017.140.3030.27**
- Analysis Services - Product version: **14.0.223.1**, file version: **2017.140.223.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12041154">[12041154](#12041154)</a> | [FIX: Error when a role that is defined with a restricted column is used to run a drillthrough query in SSAS (KB4340134)](https://support.microsoft.com/help/4340134) | Analysis Services | Analysis Services | Windows |
| <a id="12121216">[12121216](#12121216)</a> | [FIX: Exception error occurs when you try to refresh data for a pivot table in Excel in SSAS 2017 (KB4339664)](https://support.microsoft.com/help/4339664) | Analysis Services | Analysis Services | Windows |
| <a id="12123248">[12123248](#12123248)</a> | [FIX: Access to SSAS by using HTTP fails in SQL Server (KB4340742)](https://support.microsoft.com/help/4340742) | Analysis Services | Analysis Services | Windows |
| <a id="12129434">[12129434](#12129434)</a> | [FIX: "Could not load file or assembly 'Microsoft.AnalysisServices.AdomdClientUI" error when a "Process Full" operation is run in SQL Server (KB4134601)](https://support.microsoft.com/help/4134601) | Analysis Services | Server | Windows |
| <a id="12168709">[12168709](#12168709)</a> | [FIX: A .NET Framework error occurred when you update the reference table of a Fuzzy Lookup transformation in SSIS (KB4010460)](https://support.microsoft.com/help/4010460) | Integration Services | Tasks_Components | Windows |
| <a id="12138685">[12138685](#12138685)</a> | [FIX: "Unclosed quotation mark after the character string" error occurs on the MDS explorer when you try to add a new member to an entity in SQL Server (KB4339613)](https://support.microsoft.com/help/4339613) | Master Data Services | Master Data Services | Windows |
| <a id="11983925">[11983925](#11983925)</a> | FIX: Error when a SQL Server Agent job runs a PowerShell command to enumerate permissions of the database (KB4133164) | SQL Server Client Tools | SMO | Windows |
| <a id="12162425">[12162425](#12162425)</a> | [FIX: VSS backup fails in secondary replica of Basic Availability Groups in SQL Server 2016 and 2017 (KB4341221)](https://support.microsoft.com/help/4341221) | SQL Server Engine | Backup Restore | Windows |
| <a id="12186129">[12186129](#12186129)</a> | [FIX: TDE-enabled database backup with compression causes database corruption in SQL Server (KB4101502)](https://support.microsoft.com/help/4101502) | SQL Server Engine | Backup Restore | All |
| <a id="12108225">[12108225](#12108225)</a> | [FIX: Parallel redo doesn't work after you disable Trace Flag 3459 in an instance of SQL Server (KB4339858)](https://support.microsoft.com/help/4339858) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="12149855">[12149855](#12149855)</a> | [FIX: A split-brain scenario occurs after a failover when using AlwaysOn availability groups with external cluster technology in SQL Server 2017 (KB4341219)](https://support.microsoft.com/help/4341219) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="12144190">[12144190](#12144190)</a> | [FIX: SQL Server 2017 on Linux shuts down unexpectedly during the recovery of an In-Memory OLTP database (KB4340069)](https://support.microsoft.com/help/4340069) | SQL Server Engine | In-Memory OLTP | Linux |
| <a id="12162067">[12162067](#12162067)</a> | [Improvement: Allow SQL Server Agent jobs to start without waiting for all databases to get recovered in SQL Server 2017 on Linux (KB4341264)](https://support.microsoft.com/help/4341264) | SQL Server Engine | Linux | Linux |
| <a id="12128861">[12128861](#12128861)</a> | [FIX: SQLDUMPER.EXE initiated dumps may take a long time to complete dump generation process in SQL Server 2017 on Linux (KB4340747)](https://support.microsoft.com/help/4340747) | SQL Server Engine | Linux | Linux |
| <a id="11922902">[11922902](#11922902)</a> | [FIX: "Corrupted index" message and server disconnection when an update statistics query uses hash aggregate on SQL Server (KB4316858)](https://support.microsoft.com/help/4316858) | SQL Server Engine | Query Optimizer | All |
| <a id="12111717">[12111717](#12111717)</a> | [FIX: Error 3906 when a hotfix is applied on a SQL Server that has a database snapshot on a pull subscription database (KB4340837)](https://support.microsoft.com/help/4340837) | SQL Server Engine | Replication | Windows |
| <a id="12107546">[12107546](#12107546)</a> | [FIX: An instance of SQL Server may appear unresponsive then a "Non-yielding Scheduler" error may occur in SQL Server 2017 (KB4338890)](https://support.microsoft.com/help/4338890) | SQL Server Engine | SQL OS | Windows |
| <a id="12061383">[12061383](#12061383)</a> | FIX: DMVs `sys.dm_db_log_stats` and `sys.dm_db_log_info` may return incorrect values for the last database of the SQL Server 2017 instance (KB4341253) | SQL Server Engine | SQL OS | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU9 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2018/07/sqlserver2017-kb4341265-x64_8a5011f798115001695945f8dbad395f4ee9d9a6.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4341265-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4341265-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4341265-x64.exe| 6871130543A0DE2F9D1FA761E5B39101BC4CA667AE93E64C051323BEF1ABC6BA |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.223.1   | 266408    | 22-Jun-18 | 02:03 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.223.1       | 741544    | 22-Jun-18 | 02:03 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.223.1       | 1380520   | 22-Jun-18 | 02:03 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.223.1       | 984232    | 22-Jun-18 | 02:03 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.223.1       | 521384    | 22-Jun-18 | 02:03 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787       | 239328    | 20-Apr-18 | 23:59 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261    | 180424    | 06-Jun-18 | 04:34 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261    | 37584     | 06-Jun-18 | 04:34 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261    | 54472     | 06-Jun-18 | 04:34 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261    | 107728    | 06-Jun-18 | 04:34 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261    | 5223112   | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261    | 26312     | 06-Jun-18 | 04:34 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261    | 26824     | 06-Jun-18 | 04:34 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261    | 26824     | 06-Jun-18 | 04:34 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261    | 159440    | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261    | 84176     | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261    | 67280     | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261    | 25808     | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151240    | 06-Jun-18 | 04:34 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261    | 13608144  | 06-Jun-18 | 04:34 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272       | 1106088   | 06-Jun-18 | 04:34 | x86      |
| Msmdctr.dll                                        | 2017.140.223.1   | 40104     | 22-Jun-18 | 02:03 | x64      |
| Msmdlocal.dll                                      | 2017.140.223.1   | 40384680  | 22-Jun-18 | 01:40 | x86      |
| Msmdlocal.dll                                      | 2017.140.223.1   | 60707488  | 22-Jun-18 | 02:03 | x64      |
| Msmdpump.dll                                       | 2017.140.223.1   | 9334952   | 22-Jun-18 | 02:03 | x64      |
| Msmdredir.dll                                      | 2017.140.223.1   | 7092384   | 22-Jun-18 | 01:40 | x86      |
| Msmdsrv.exe                                        | 2017.140.223.1   | 60608680  | 22-Jun-18 | 02:03 | x64      |
| Msmgdsrv.dll                                       | 2017.140.223.1   | 7310504   | 22-Jun-18 | 01:40 | x86      |
| Msmgdsrv.dll                                       | 2017.140.223.1   | 9004736   | 22-Jun-18 | 02:03 | x64      |
| Msolap.dll                                         | 2017.140.223.1   | 7777448   | 22-Jun-18 | 01:40 | x86      |
| Msolap.dll                                         | 2017.140.223.1   | 10258600  | 22-Jun-18 | 02:03 | x64      |
| Msolui.dll                                         | 2017.140.223.1   | 287400    | 22-Jun-18 | 01:40 | x86      |
| Msolui.dll                                         | 2017.140.223.1   | 310952    | 22-Jun-18 | 02:03 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261    | 6606536   | 06-Jun-18 | 04:34 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlboot.dll                                        | 2017.140.3030.27 | 196288    | 30-Jun-18 | 01:15 | x64      |
| Sqlceip.exe                                        | 14.0.3030.27     | 255144    | 30-Jun-18 | 01:22 | x86      |
| Sqldumper.exe                                      | 2017.140.3030.27 | 141472    | 30-Jun-18 | 01:11 | x64      |
| Sqldumper.exe                                      | 2017.140.3030.27 | 119464    | 30-Jun-18 | 01:12 | x86      |
| Tmapi.dll                                          | 2017.140.223.1   | 5821608   | 22-Jun-18 | 02:03 | x64      |
| Tmcachemgr.dll                                     | 2017.140.223.1   | 4164776   | 22-Jun-18 | 02:03 | x64      |
| Tmpersistence.dll                                  | 2017.140.223.1   | 1132192   | 22-Jun-18 | 02:03 | x64      |
| Tmtransactions.dll                                 | 2017.140.223.1   | 1641128   | 22-Jun-18 | 02:03 | x64      |
| Xe.dll                                             | 2017.140.3030.27 | 673440    | 30-Jun-18 | 00:59 | x64      |
| Xmlrw.dll                                          | 2017.140.3030.27 | 257704    | 30-Jun-18 | 01:14 | x86      |
| Xmlrw.dll                                          | 2017.140.3030.27 | 305320    | 30-Jun-18 | 01:15 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3030.27 | 224424    | 30-Jun-18 | 01:00 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3030.27 | 189608    | 30-Jun-18 | 01:14 | x86      |
| Xmsrv.dll                                          | 2017.140.223.1   | 33350816  | 22-Jun-18 | 01:40 | x86      |
| Xmsrv.dll                                          | 2017.140.223.1   | 25375400  | 22-Jun-18 | 02:03 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3030.27 | 180904    | 30-Jun-18 | 00:48 | x64      |
| Batchparser.dll                            | 2017.140.3030.27 | 160416    | 30-Jun-18 | 01:00 | x86      |
| Instapi140.dll                             | 2017.140.3030.27 | 61096     | 30-Jun-18 | 01:00 | x86      |
| Instapi140.dll                             | 2017.140.3030.27 | 70848     | 30-Jun-18 | 01:00 | x64      |
| Isacctchange.dll                           | 2017.140.3030.27 | 29344     | 30-Jun-18 | 01:13 | x86      |
| Isacctchange.dll                           | 2017.140.3030.27 | 30912     | 30-Jun-18 | 01:15 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.223.1       | 1088680   | 22-Jun-18 | 01:40 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.223.1       | 1088704   | 22-Jun-18 | 02:03 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.223.1       | 1381544   | 22-Jun-18 | 01:40 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.223.1       | 741544    | 22-Jun-18 | 01:40 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.223.1       | 741544    | 22-Jun-18 | 02:03 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3030.27     | 37024     | 30-Jun-18 | 01:13 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3030.27 | 78504     | 30-Jun-18 | 01:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3030.27 | 82088     | 30-Jun-18 | 01:00 | x64      |
| Msasxpress.dll                             | 2017.140.223.1   | 31912     | 22-Jun-18 | 01:40 | x86      |
| Msasxpress.dll                             | 2017.140.223.1   | 36008     | 22-Jun-18 | 02:03 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3030.27 | 68264     | 30-Jun-18 | 01:14 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3030.27 | 82600     | 30-Jun-18 | 01:15 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqldumper.exe                              | 2017.140.3030.27 | 141472    | 30-Jun-18 | 01:11 | x64      |
| Sqldumper.exe                              | 2017.140.3030.27 | 119464    | 30-Jun-18 | 01:12 | x86      |
| Sqlftacct.dll                              | 2017.140.3030.27 | 55464     | 30-Jun-18 | 01:14 | x86      |
| Sqlftacct.dll                              | 2017.140.3030.27 | 62624     | 30-Jun-18 | 01:15 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 21-Apr-18 | 00:33 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 21-Apr-18 | 00:29 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3030.27 | 372896    | 30-Jun-18 | 01:13 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3030.27 | 416424    | 30-Jun-18 | 01:15 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3030.27 | 34984     | 30-Jun-18 | 01:14 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3030.27 | 37536     | 30-Jun-18 | 01:23 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3030.27 | 273576    | 30-Jun-18 | 01:14 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3030.27 | 356008    | 30-Jun-18 | 01:15 | x64      |
| Sqltdiagn.dll                              | 2017.140.3030.27 | 60584     | 30-Jun-18 | 00:48 | x86      |
| Sqltdiagn.dll                              | 2017.140.3030.27 | 67752     | 30-Jun-18 | 01:00 | x64      |
| Svrenumapi140.dll                          | 2017.140.3030.27 | 894120    | 30-Jun-18 | 01:00 | x86      |
| Svrenumapi140.dll                          | 2017.140.3030.27 | 1173160   | 30-Jun-18 | 01:00 | x64      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3030.27 | 121000    | 30-Jun-18 | 01:30 | x86      |
| Dreplaycommon.dll              | 2017.140.3030.27 | 699048    | 30-Jun-18 | 01:13 | x86      |
| Dreplayserverps.dll            | 2017.140.3030.27 | 32936     | 30-Jun-18 | 00:48 | x86      |
| Dreplayutil.dll                | 2017.140.3030.27 | 309928    | 30-Jun-18 | 01:22 | x86      |
| Instapi140.dll                 | 2017.140.3030.27 | 70848     | 30-Jun-18 | 01:00 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlresourceloader.dll          | 2017.140.3030.27 | 29352     | 30-Jun-18 | 00:48 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3030.27 | 699048    | 30-Jun-18 | 01:13 | x86      |
| Dreplaycontroller.exe              | 2017.140.3030.27 | 350368    | 30-Jun-18 | 01:22 | x86      |
| Dreplayprocess.dll                 | 2017.140.3030.27 | 171680    | 30-Jun-18 | 01:13 | x86      |
| Dreplayserverps.dll                | 2017.140.3030.27 | 32936     | 30-Jun-18 | 00:48 | x86      |
| Instapi140.dll                     | 2017.140.3030.27 | 70848     | 30-Jun-18 | 01:00 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlresourceloader.dll              | 2017.140.3030.27 | 29352     | 30-Jun-18 | 00:48 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3030.27 | 180904    | 30-Jun-18 | 00:48 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 20-Apr-18 | 23:43 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 20-Apr-18 | 23:43 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 20-Apr-18 | 23:43 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 21-Apr-18 | 00:28 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3030.27 | 226464    | 30-Jun-18 | 01:15 | x64      |
| Dcexec.exe                                   | 2017.140.3030.27 | 74408     | 30-Jun-18 | 01:23 | x64      |
| Fssres.dll                                   | 2017.140.3030.27 | 89760     | 30-Jun-18 | 01:23 | x64      |
| Hadrres.dll                                  | 2017.140.3030.27 | 188072    | 30-Jun-18 | 01:15 | x64      |
| Hkcompile.dll                                | 2017.140.3030.27 | 1423016   | 30-Jun-18 | 01:23 | x64      |
| Hkengine.dll                                 | 2017.140.3030.27 | 5858464   | 30-Jun-18 | 01:23 | x64      |
| Hkruntime.dll                                | 2017.140.3030.27 | 162984    | 30-Jun-18 | 01:23 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 20-Apr-18 | 23:43 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.223.1       | 741032    | 22-Jun-18 | 02:03 | x86      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787       | 239328    | 20-Apr-18 | 23:59 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3030.27     | 237224    | 30-Jun-18 | 01:31 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3030.27     | 79528     | 30-Jun-18 | 01:29 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3030.27 | 71336     | 30-Jun-18 | 01:00 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3030.27 | 65192     | 30-Jun-18 | 00:59 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3030.27 | 152232    | 30-Jun-18 | 01:22 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3030.27 | 159400    | 30-Jun-18 | 01:11 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3030.27 | 304296    | 30-Jun-18 | 01:11 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3030.27 | 74920     | 30-Jun-18 | 01:29 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 20-Apr-18 | 23:43 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 20-Apr-18 | 23:43 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 20-Apr-18 | 23:43 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 20-Apr-18 | 23:43 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 20-Apr-18 | 23:43 | x64      |
| Odsole70.dll                                 | 2017.140.3030.27 | 92840     | 30-Jun-18 | 01:15 | x64      |
| Opends60.dll                                 | 2017.140.3030.27 | 32928     | 30-Jun-18 | 00:48 | x64      |
| Qds.dll                                      | 2017.140.3030.27 | 1168552   | 30-Jun-18 | 09:52 | x64      |
| Rsfxft.dll                                   | 2017.140.3030.27 | 34472     | 30-Jun-18 | 00:48 | x64      |
| Secforwarder.dll                             | 2017.140.3030.27 | 37536     | 30-Jun-18 | 01:15 | x64      |
| Sqagtres.dll                                 | 2017.140.3030.27 | 74408     | 30-Jun-18 | 01:15 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlaamss.dll                                 | 2017.140.3030.27 | 90304     | 30-Jun-18 | 01:31 | x64      |
| Sqlaccess.dll                                | 2017.140.3030.27 | 474792    | 30-Jun-18 | 01:00 | x64      |
| Sqlagent.exe                                 | 2017.140.3030.27 | 582312    | 30-Jun-18 | 01:23 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3030.27 | 52904     | 30-Jun-18 | 01:13 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3030.27 | 62120     | 30-Jun-18 | 01:15 | x64      |
| Sqlagentlog.dll                              | 2017.140.3030.27 | 32960     | 30-Jun-18 | 00:45 | x64      |
| Sqlagentmail.dll                             | 2017.140.3030.27 | 53920     | 30-Jun-18 | 00:45 | x64      |
| Sqlboot.dll                                  | 2017.140.3030.27 | 196288    | 30-Jun-18 | 01:15 | x64      |
| Sqlceip.exe                                  | 14.0.3030.27     | 255144    | 30-Jun-18 | 01:22 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3030.27 | 72872     | 30-Jun-18 | 01:15 | x64      |
| Sqlctr140.dll                                | 2017.140.3030.27 | 112296    | 30-Jun-18 | 01:14 | x86      |
| Sqlctr140.dll                                | 2017.140.3030.27 | 129192    | 30-Jun-18 | 01:15 | x64      |
| Sqldk.dll                                    | 2017.140.3030.27 | 2794152   | 30-Jun-18 | 09:57 | x64      |
| Sqldtsss.dll                                 | 2017.140.3030.27 | 107688    | 30-Jun-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3367072   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3786920   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3821224   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 1445032   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3588256   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 1497768   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 2089640   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3676840   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 4027048   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3596968   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3296936   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3914408   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3402912   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3917480   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3338920   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 2036392   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3779752   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3785384   | 30-Jun-18 | 01:13 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3291304   | 30-Jun-18 | 01:13 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3481792   | 30-Jun-18 | 01:14 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3635904   | 30-Jun-18 | 01:14 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3030.27 | 3213992   | 30-Jun-18 | 01:14 | x64      |
| Sqliosim.com                                 | 2017.140.3030.27 | 313504    | 30-Jun-18 | 01:22 | x64      |
| Sqliosim.exe                                 | 2017.140.3030.27 | 3019944   | 30-Jun-18 | 01:23 | x64      |
| Sqllang.dll                                  | 2017.140.3030.27 | 41234088  | 30-Jun-18 | 10:19 | x64      |
| Sqlmin.dll                                   | 2017.140.3030.27 | 40450728  | 30-Jun-18 | 10:02 | x64      |
| Sqlolapss.dll                                | 2017.140.3030.27 | 107688    | 30-Jun-18 | 01:15 | x64      |
| Sqlos.dll                                    | 2017.140.3030.27 | 26280     | 30-Jun-18 | 01:12 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3030.27 | 68264     | 30-Jun-18 | 01:15 | x64      |
| Sqlrepss.dll                                 | 2017.140.3030.27 | 64680     | 30-Jun-18 | 01:15 | x64      |
| Sqlresld.dll                                 | 2017.140.3030.27 | 30888     | 30-Jun-18 | 00:48 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3030.27 | 32416     | 30-Jun-18 | 00:45 | x64      |
| Sqlscm.dll                                   | 2017.140.3030.27 | 71336     | 30-Jun-18 | 01:15 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3030.27 | 27808     | 30-Jun-18 | 00:48 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3030.27 | 5872800   | 30-Jun-18 | 00:48 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3030.27 | 732840    | 30-Jun-18 | 01:15 | x64      |
| Sqlservr.exe                                 | 2017.140.3030.27 | 487592    | 30-Jun-18 | 09:52 | x64      |
| Sqlsvc.dll                                   | 2017.140.3030.27 | 161952    | 30-Jun-18 | 01:15 | x64      |
| Sqltses.dll                                  | 2017.140.3030.27 | 9537192   | 30-Jun-18 | 09:57 | x64      |
| Sqsrvres.dll                                 | 2017.140.3030.27 | 261280    | 30-Jun-18 | 01:15 | x64      |
| Svl.dll                                      | 2017.140.3030.27 | 153768    | 30-Jun-18 | 01:31 | x64      |
| Xe.dll                                       | 2017.140.3030.27 | 673440    | 30-Jun-18 | 00:59 | x64      |
| Xmlrw.dll                                    | 2017.140.3030.27 | 305320    | 30-Jun-18 | 01:15 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3030.27 | 224424    | 30-Jun-18 | 01:00 | x64      |
| Xpadsi.exe                                   | 2017.140.3030.27 | 89768     | 30-Jun-18 | 01:15 | x64      |
| Xplog70.dll                                  | 2017.140.3030.27 | 75944     | 30-Jun-18 | 01:23 | x64      |
| Xpqueue.dll                                  | 2017.140.3030.27 | 74912     | 30-Jun-18 | 01:15 | x64      |
| Xprepl.dll                                   | 2017.140.3030.27 | 102080    | 30-Jun-18 | 01:15 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3030.27 | 32424     | 30-Jun-18 | 01:15 | x64      |
| Xpstar.dll                                   | 2017.140.3030.27 | 438440    | 30-Jun-18 | 01:23 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3030.27 | 180904    | 30-Jun-18 | 00:48 | x64      |
| Batchparser.dll                                             | 2017.140.3030.27 | 160416    | 30-Jun-18 | 01:00 | x86      |
| Bcp.exe                                                     | 2017.140.3030.27 | 119968    | 30-Jun-18 | 01:15 | x64      |
| Commanddest.dll                                             | 2017.140.3030.27 | 245920    | 30-Jun-18 | 01:14 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3030.27 | 116392    | 30-Jun-18 | 01:15 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3030.27 | 187560    | 30-Jun-18 | 01:23 | x64      |
| Distrib.exe                                                 | 2017.140.3030.27 | 203432    | 30-Jun-18 | 01:15 | x64      |
| Dteparse.dll                                                | 2017.140.3030.27 | 111784    | 30-Jun-18 | 01:15 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3030.27 | 89248     | 30-Jun-18 | 01:15 | x64      |
| Dtepkg.dll                                                  | 2017.140.3030.27 | 138912    | 30-Jun-18 | 01:23 | x64      |
| Dtexec.exe                                                  | 2017.140.3030.27 | 73896     | 30-Jun-18 | 01:23 | x64      |
| Dts.dll                                                     | 2017.140.3030.27 | 2998952   | 30-Jun-18 | 01:23 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3030.27 | 475304    | 30-Jun-18 | 01:15 | x64      |
| Dtsconn.dll                                                 | 2017.140.3030.27 | 497312    | 30-Jun-18 | 01:23 | x64      |
| Dtshost.exe                                                 | 2017.140.3030.27 | 104616    | 30-Jun-18 | 01:15 | x64      |
| Dtslog.dll                                                  | 2017.140.3030.27 | 120488    | 30-Jun-18 | 01:15 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3030.27 | 545448    | 30-Jun-18 | 01:15 | x64      |
| Dtspipeline.dll                                             | 2017.140.3030.27 | 1266336   | 30-Jun-18 | 01:23 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3030.27 | 48296     | 30-Jun-18 | 01:15 | x64      |
| Dtuparse.dll                                                | 2017.140.3030.27 | 89256     | 30-Jun-18 | 01:15 | x64      |
| Dtutil.exe                                                  | 2017.140.3030.27 | 147104    | 30-Jun-18 | 01:15 | x64      |
| Exceldest.dll                                               | 2017.140.3030.27 | 260776    | 30-Jun-18 | 01:15 | x64      |
| Excelsrc.dll                                                | 2017.140.3030.27 | 282792    | 30-Jun-18 | 01:15 | x64      |
| Execpackagetask.dll                                         | 2017.140.3030.27 | 168104    | 30-Jun-18 | 01:15 | x64      |
| Flatfiledest.dll                                            | 2017.140.3030.27 | 386728    | 30-Jun-18 | 01:15 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3030.27 | 399016    | 30-Jun-18 | 01:15 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3030.27 | 96424     | 30-Jun-18 | 01:23 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3030.27 | 59560     | 30-Jun-18 | 01:15 | x64      |
| Logread.exe                                                 | 2017.140.3030.27 | 635048    | 30-Jun-18 | 01:15 | x64      |
| Mergetxt.dll                                                | 2017.140.3030.27 | 63680     | 30-Jun-18 | 01:15 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.223.1       | 1381544   | 22-Jun-18 | 02:03 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 21-Apr-18 | 00:24 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3030.27     | 89760     | 30-Jun-18 | 01:39 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3030.27     | 614056    | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3030.27 | 1663656   | 30-Jun-18 | 01:15 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3030.27 | 152232    | 30-Jun-18 | 01:22 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3030.27 | 159400    | 30-Jun-18 | 01:11 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3030.27 | 103080    | 30-Jun-18 | 01:15 | x64      |
| Msgprox.dll                                                 | 2017.140.3030.27 | 270504    | 30-Jun-18 | 01:15 | x64      |
| Msxmlsql.dll                                                | 2017.140.3030.27 | 1448104   | 30-Jun-18 | 01:15 | x64      |
| Oledbdest.dll                                               | 2017.140.3030.27 | 261280    | 30-Jun-18 | 01:23 | x64      |
| Oledbsrc.dll                                                | 2017.140.3030.27 | 288928    | 30-Jun-18 | 01:23 | x64      |
| Osql.exe                                                    | 2017.140.3030.27 | 75432     | 30-Jun-18 | 00:48 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3030.27 | 473768    | 30-Jun-18 | 01:15 | x64      |
| Rawdest.dll                                                 | 2017.140.3030.27 | 206504    | 30-Jun-18 | 01:23 | x64      |
| Rawsource.dll                                               | 2017.140.3030.27 | 194216    | 30-Jun-18 | 01:15 | x64      |
| Rdistcom.dll                                                | 2017.140.3030.27 | 857256    | 30-Jun-18 | 01:15 | x64      |
| Recordsetdest.dll                                           | 2017.140.3030.27 | 184488    | 30-Jun-18 | 01:15 | x64      |
| Replagnt.dll                                                | 2017.140.3030.27 | 30888     | 30-Jun-18 | 01:15 | x64      |
| Repldp.dll                                                  | 2017.140.3030.27 | 290976    | 30-Jun-18 | 01:15 | x64      |
| Replerrx.dll                                                | 2017.140.3030.27 | 154280    | 30-Jun-18 | 01:15 | x64      |
| Replisapi.dll                                               | 2017.140.3030.27 | 362152    | 30-Jun-18 | 01:15 | x64      |
| Replmerg.exe                                                | 2017.140.3030.27 | 524968    | 30-Jun-18 | 01:15 | x64      |
| Replprov.dll                                                | 2017.140.3030.27 | 801960    | 30-Jun-18 | 01:15 | x64      |
| Replrec.dll                                                 | 2017.140.3030.27 | 975528    | 30-Jun-18 | 01:15 | x64      |
| Replsub.dll                                                 | 2017.140.3030.27 | 445608    | 30-Jun-18 | 01:15 | x64      |
| Replsync.dll                                                | 2017.140.3030.27 | 154280    | 30-Jun-18 | 01:15 | x64      |
| Spresolv.dll                                                | 2017.140.3030.27 | 252072    | 30-Jun-18 | 01:15 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3030.27 | 249000    | 30-Jun-18 | 01:15 | x64      |
| Sqldiag.exe                                                 | 2017.140.3030.27 | 1257640   | 30-Jun-18 | 01:15 | x64      |
| Sqldistx.dll                                                | 2017.140.3030.27 | 225448    | 30-Jun-18 | 01:15 | x64      |
| Sqllogship.exe                                              | 14.0.3030.27     | 105640    | 30-Jun-18 | 00:48 | x64      |
| Sqlmergx.dll                                                | 2017.140.3030.27 | 360616    | 30-Jun-18 | 01:15 | x64      |
| Sqlresld.dll                                                | 2017.140.3030.27 | 30888     | 30-Jun-18 | 00:48 | x64      |
| Sqlresld.dll                                                | 2017.140.3030.27 | 28832     | 30-Jun-18 | 01:13 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3030.27 | 32416     | 30-Jun-18 | 00:45 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3030.27 | 29352     | 30-Jun-18 | 00:48 | x86      |
| Sqlscm.dll                                                  | 2017.140.3030.27 | 61096     | 30-Jun-18 | 01:13 | x86      |
| Sqlscm.dll                                                  | 2017.140.3030.27 | 71336     | 30-Jun-18 | 01:15 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3030.27 | 134824    | 30-Jun-18 | 01:13 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3030.27 | 161952    | 30-Jun-18 | 01:15 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3030.27 | 182944    | 30-Jun-18 | 01:15 | x64      |
| Sqlwep140.dll                                               | 2017.140.3030.27 | 105640    | 30-Jun-18 | 00:48 | x64      |
| Ssdebugps.dll                                               | 2017.140.3030.27 | 33440     | 30-Jun-18 | 01:15 | x64      |
| Ssisoledb.dll                                               | 2017.140.3030.27 | 216256    | 30-Jun-18 | 01:15 | x64      |
| Ssradd.dll                                                  | 2017.140.3030.27 | 75424     | 30-Jun-18 | 01:15 | x64      |
| Ssravg.dll                                                  | 2017.140.3030.27 | 75944     | 30-Jun-18 | 01:15 | x64      |
| Ssrdown.dll                                                 | 2017.140.3030.27 | 60576     | 30-Jun-18 | 01:15 | x64      |
| Ssrmax.dll                                                  | 2017.140.3030.27 | 73384     | 30-Jun-18 | 01:15 | x64      |
| Ssrmin.dll                                                  | 2017.140.3030.27 | 73896     | 30-Jun-18 | 01:15 | x64      |
| Ssrpub.dll                                                  | 2017.140.3030.27 | 61600     | 30-Jun-18 | 01:15 | x64      |
| Ssrup.dll                                                   | 2017.140.3030.27 | 60584     | 30-Jun-18 | 01:15 | x64      |
| Txagg.dll                                                   | 2017.140.3030.27 | 362144    | 30-Jun-18 | 01:15 | x64      |
| Txbdd.dll                                                   | 2017.140.3030.27 | 170152    | 30-Jun-18 | 01:23 | x64      |
| Txdatacollector.dll                                         | 2017.140.3030.27 | 360608    | 30-Jun-18 | 01:15 | x64      |
| Txdataconvert.dll                                           | 2017.140.3030.27 | 293032    | 30-Jun-18 | 01:23 | x64      |
| Txderived.dll                                               | 2017.140.3030.27 | 604320    | 30-Jun-18 | 01:15 | x64      |
| Txlookup.dll                                                | 2017.140.3030.27 | 528040    | 30-Jun-18 | 01:15 | x64      |
| Txmerge.dll                                                 | 2017.140.3030.27 | 230048    | 30-Jun-18 | 01:15 | x64      |
| Txmergejoin.dll                                             | 2017.140.3030.27 | 275624    | 30-Jun-18 | 01:23 | x64      |
| Txmulticast.dll                                             | 2017.140.3030.27 | 127656    | 30-Jun-18 | 01:23 | x64      |
| Txrowcount.dll                                              | 2017.140.3030.27 | 125600    | 30-Jun-18 | 01:23 | x64      |
| Txsort.dll                                                  | 2017.140.3030.27 | 256672    | 30-Jun-18 | 01:15 | x64      |
| Txsplit.dll                                                 | 2017.140.3030.27 | 596648    | 30-Jun-18 | 01:23 | x64      |
| Txunionall.dll                                              | 2017.140.3030.27 | 181928    | 30-Jun-18 | 01:15 | x64      |
| Xe.dll                                                      | 2017.140.3030.27 | 673440    | 30-Jun-18 | 00:59 | x64      |
| Xmlrw.dll                                                   | 2017.140.3030.27 | 305320    | 30-Jun-18 | 01:15 | x64      |
| Xmlsub.dll                                                  | 2017.140.3030.27 | 261280    | 30-Jun-18 | 01:15 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3030.27 | 1125032   | 30-Jun-18 | 01:39 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlsatellite.dll              | 2017.140.3030.27 | 922280    | 30-Jun-18 | 01:39 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3030.27 | 667304    | 30-Jun-18 | 01:15 | x64      |
| Fdhost.exe               | 2017.140.3030.27 | 114848    | 30-Jun-18 | 01:23 | x64      |
| Fdlauncher.exe           | 2017.140.3030.27 | 62632     | 30-Jun-18 | 01:15 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlft140ph.dll           | 2017.140.3030.27 | 68264     | 30-Jun-18 | 01:00 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3030.27     | 23720     | 30-Jun-18 | 01:00 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 21-Apr-18 | 00:28 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 21-Apr-18 | 00:28 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 21-Apr-18 | 00:28 | x86      |
| Commanddest.dll                                               | 2017.140.3030.27 | 245920    | 30-Jun-18 | 01:14 | x64      |
| Commanddest.dll                                               | 2017.140.3030.27 | 200872    | 30-Jun-18 | 01:22 | x86      |
| Dteparse.dll                                                  | 2017.140.3030.27 | 100520    | 30-Jun-18 | 01:13 | x86      |
| Dteparse.dll                                                  | 2017.140.3030.27 | 111784    | 30-Jun-18 | 01:15 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3030.27 | 83624     | 30-Jun-18 | 01:13 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3030.27 | 89248     | 30-Jun-18 | 01:15 | x64      |
| Dtepkg.dll                                                    | 2017.140.3030.27 | 116928    | 30-Jun-18 | 01:13 | x86      |
| Dtepkg.dll                                                    | 2017.140.3030.27 | 138912    | 30-Jun-18 | 01:23 | x64      |
| Dtexec.exe                                                    | 2017.140.3030.27 | 67752     | 30-Jun-18 | 01:13 | x86      |
| Dtexec.exe                                                    | 2017.140.3030.27 | 73896     | 30-Jun-18 | 01:23 | x64      |
| Dts.dll                                                       | 2017.140.3030.27 | 2549416   | 30-Jun-18 | 01:13 | x86      |
| Dts.dll                                                       | 2017.140.3030.27 | 2998952   | 30-Jun-18 | 01:23 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3030.27 | 417960    | 30-Jun-18 | 01:13 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3030.27 | 475304    | 30-Jun-18 | 01:15 | x64      |
| Dtsconn.dll                                                   | 2017.140.3030.27 | 399520    | 30-Jun-18 | 01:22 | x86      |
| Dtsconn.dll                                                   | 2017.140.3030.27 | 497312    | 30-Jun-18 | 01:23 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3030.27 | 111272    | 30-Jun-18 | 01:15 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3030.27 | 95392     | 30-Jun-18 | 01:22 | x86      |
| Dtshost.exe                                                   | 2017.140.3030.27 | 89768     | 30-Jun-18 | 01:13 | x86      |
| Dtshost.exe                                                   | 2017.140.3030.27 | 104616    | 30-Jun-18 | 01:15 | x64      |
| Dtslog.dll                                                    | 2017.140.3030.27 | 103080    | 30-Jun-18 | 01:13 | x86      |
| Dtslog.dll                                                    | 2017.140.3030.27 | 120488    | 30-Jun-18 | 01:15 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3030.27 | 541352    | 30-Jun-18 | 01:14 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3030.27 | 545448    | 30-Jun-18 | 01:15 | x64      |
| Dtspipeline.dll                                               | 2017.140.3030.27 | 1059496   | 30-Jun-18 | 01:22 | x86      |
| Dtspipeline.dll                                               | 2017.140.3030.27 | 1266336   | 30-Jun-18 | 01:23 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3030.27 | 42664     | 30-Jun-18 | 01:13 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3030.27 | 48296     | 30-Jun-18 | 01:15 | x64      |
| Dtuparse.dll                                                  | 2017.140.3030.27 | 80040     | 30-Jun-18 | 01:13 | x86      |
| Dtuparse.dll                                                  | 2017.140.3030.27 | 89256     | 30-Jun-18 | 01:15 | x64      |
| Dtutil.exe                                                    | 2017.140.3030.27 | 126120    | 30-Jun-18 | 01:13 | x86      |
| Dtutil.exe                                                    | 2017.140.3030.27 | 147104    | 30-Jun-18 | 01:15 | x64      |
| Exceldest.dll                                                 | 2017.140.3030.27 | 214696    | 30-Jun-18 | 01:13 | x86      |
| Exceldest.dll                                                 | 2017.140.3030.27 | 260776    | 30-Jun-18 | 01:15 | x64      |
| Excelsrc.dll                                                  | 2017.140.3030.27 | 282792    | 30-Jun-18 | 01:15 | x64      |
| Excelsrc.dll                                                  | 2017.140.3030.27 | 230560    | 30-Jun-18 | 01:22 | x86      |
| Execpackagetask.dll                                           | 2017.140.3030.27 | 135336    | 30-Jun-18 | 01:13 | x86      |
| Execpackagetask.dll                                           | 2017.140.3030.27 | 168104    | 30-Jun-18 | 01:15 | x64      |
| Flatfiledest.dll                                              | 2017.140.3030.27 | 332968    | 30-Jun-18 | 01:13 | x86      |
| Flatfiledest.dll                                              | 2017.140.3030.27 | 386728    | 30-Jun-18 | 01:15 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3030.27 | 344232    | 30-Jun-18 | 01:13 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3030.27 | 399016    | 30-Jun-18 | 01:15 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3030.27 | 80544     | 30-Jun-18 | 01:22 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3030.27 | 96424     | 30-Jun-18 | 01:23 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3030.27     | 467104    | 30-Jun-18 | 06:00 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3030.27     | 466600    | 30-Jun-18 | 02:17 | x64      |
| Isserverexec.exe                                              | 14.0.3030.27     | 149160    | 30-Jun-18 | 01:39 | x86      |
| Isserverexec.exe                                              | 14.0.3030.27     | 148648    | 30-Jun-18 | 01:39 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.223.1       | 1381544   | 22-Jun-18 | 01:40 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.223.1       | 1381544   | 22-Jun-18 | 02:03 | x86      |
| Microsoft.applicationinsights.dll                             | 2.6.0.6787       | 239328    | 20-Apr-18 | 23:59 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 21-Apr-18 | 00:24 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3030.27     | 71336     | 30-Jun-18 | 01:31 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3030.27 | 107176    | 30-Jun-18 | 01:13 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3030.27 | 112296    | 30-Jun-18 | 01:15 | x64      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3030.27     | 89768     | 30-Jun-18 | 01:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3030.27     | 89760     | 30-Jun-18 | 01:39 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3030.27     | 494760    | 30-Jun-18 | 00:48 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3030.27     | 494760    | 30-Jun-18 | 01:00 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3030.27     | 83624     | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3030.27     | 83624     | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3030.27     | 415936    | 30-Jun-18 | 06:00 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3030.27     | 415912    | 30-Jun-18 | 02:12 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3030.27     | 614056    | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3030.27     | 614056    | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3030.27     | 252584    | 30-Jun-18 | 01:13 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3030.27     | 252576    | 30-Jun-18 | 01:15 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3030.27 | 141984    | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3030.27 | 152232    | 30-Jun-18 | 01:22 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3030.27 | 159400    | 30-Jun-18 | 01:11 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3030.27 | 145576    | 30-Jun-18 | 01:11 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3030.27     | 219816    | 30-Jun-18 | 01:31 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3030.27 | 90272     | 30-Jun-18 | 01:13 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3030.27 | 103080    | 30-Jun-18 | 01:15 | x64      |
| Msmdpp.dll                                                    | 2017.140.223.1   | 9194152   | 22-Jun-18 | 02:03 | x64      |
| Oledbdest.dll                                                 | 2017.140.3030.27 | 214696    | 30-Jun-18 | 01:13 | x86      |
| Oledbdest.dll                                                 | 2017.140.3030.27 | 261280    | 30-Jun-18 | 01:23 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3030.27 | 233128    | 30-Jun-18 | 01:13 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3030.27 | 288928    | 30-Jun-18 | 01:23 | x64      |
| Rawdest.dll                                                   | 2017.140.3030.27 | 166560    | 30-Jun-18 | 01:13 | x86      |
| Rawdest.dll                                                   | 2017.140.3030.27 | 206504    | 30-Jun-18 | 01:23 | x64      |
| Rawsource.dll                                                 | 2017.140.3030.27 | 194216    | 30-Jun-18 | 01:15 | x64      |
| Rawsource.dll                                                 | 2017.140.3030.27 | 153256    | 30-Jun-18 | 01:22 | x86      |
| Recordsetdest.dll                                             | 2017.140.3030.27 | 149160    | 30-Jun-18 | 01:13 | x86      |
| Recordsetdest.dll                                             | 2017.140.3030.27 | 184488    | 30-Jun-18 | 01:15 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlceip.exe                                                   | 14.0.3030.27     | 255144    | 30-Jun-18 | 01:22 | x86      |
| Sqldest.dll                                                   | 2017.140.3030.27 | 213672    | 30-Jun-18 | 01:13 | x86      |
| Sqldest.dll                                                   | 2017.140.3030.27 | 260776    | 30-Jun-18 | 01:15 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3030.27 | 155296    | 30-Jun-18 | 01:13 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3030.27 | 182944    | 30-Jun-18 | 01:15 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3030.27 | 176800    | 30-Jun-18 | 01:13 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3030.27 | 216256    | 30-Jun-18 | 01:15 | x64      |
| Txagg.dll                                                     | 2017.140.3030.27 | 302248    | 30-Jun-18 | 01:13 | x86      |
| Txagg.dll                                                     | 2017.140.3030.27 | 362144    | 30-Jun-18 | 01:15 | x64      |
| Txbdd.dll                                                     | 2017.140.3030.27 | 136360    | 30-Jun-18 | 01:13 | x86      |
| Txbdd.dll                                                     | 2017.140.3030.27 | 170152    | 30-Jun-18 | 01:23 | x64      |
| Txbestmatch.dll                                               | 2017.140.3030.27 | 493224    | 30-Jun-18 | 01:14 | x86      |
| Txbestmatch.dll                                               | 2017.140.3030.27 | 605344    | 30-Jun-18 | 01:15 | x64      |
| Txcache.dll                                                   | 2017.140.3030.27 | 146088    | 30-Jun-18 | 01:13 | x86      |
| Txcache.dll                                                   | 2017.140.3030.27 | 180392    | 30-Jun-18 | 01:15 | x64      |
| Txcharmap.dll                                                 | 2017.140.3030.27 | 248992    | 30-Jun-18 | 01:13 | x86      |
| Txcharmap.dll                                                 | 2017.140.3030.27 | 286880    | 30-Jun-18 | 01:15 | x64      |
| Txcopymap.dll                                                 | 2017.140.3030.27 | 145568    | 30-Jun-18 | 01:13 | x86      |
| Txcopymap.dll                                                 | 2017.140.3030.27 | 180392    | 30-Jun-18 | 01:23 | x64      |
| Txdataconvert.dll                                             | 2017.140.3030.27 | 253096    | 30-Jun-18 | 01:22 | x86      |
| Txdataconvert.dll                                             | 2017.140.3030.27 | 293032    | 30-Jun-18 | 01:23 | x64      |
| Txderived.dll                                                 | 2017.140.3030.27 | 515744    | 30-Jun-18 | 01:14 | x86      |
| Txderived.dll                                                 | 2017.140.3030.27 | 604320    | 30-Jun-18 | 01:15 | x64      |
| Txfileextractor.dll                                           | 2017.140.3030.27 | 160936    | 30-Jun-18 | 01:13 | x86      |
| Txfileextractor.dll                                           | 2017.140.3030.27 | 198816    | 30-Jun-18 | 01:23 | x64      |
| Txfileinserter.dll                                            | 2017.140.3030.27 | 159392    | 30-Jun-18 | 01:13 | x86      |
| Txfileinserter.dll                                            | 2017.140.3030.27 | 196776    | 30-Jun-18 | 01:15 | x64      |
| Txgroupdups.dll                                               | 2017.140.3030.27 | 231080    | 30-Jun-18 | 01:13 | x86      |
| Txgroupdups.dll                                               | 2017.140.3030.27 | 290472    | 30-Jun-18 | 01:15 | x64      |
| Txlineage.dll                                                 | 2017.140.3030.27 | 110248    | 30-Jun-18 | 01:13 | x86      |
| Txlineage.dll                                                 | 2017.140.3030.27 | 136864    | 30-Jun-18 | 01:15 | x64      |
| Txlookup.dll                                                  | 2017.140.3030.27 | 528040    | 30-Jun-18 | 01:15 | x64      |
| Txlookup.dll                                                  | 2017.140.3030.27 | 446624    | 30-Jun-18 | 01:22 | x86      |
| Txmerge.dll                                                   | 2017.140.3030.27 | 176808    | 30-Jun-18 | 01:13 | x86      |
| Txmerge.dll                                                   | 2017.140.3030.27 | 230048    | 30-Jun-18 | 01:15 | x64      |
| Txmergejoin.dll                                               | 2017.140.3030.27 | 221864    | 30-Jun-18 | 01:13 | x86      |
| Txmergejoin.dll                                               | 2017.140.3030.27 | 275624    | 30-Jun-18 | 01:23 | x64      |
| Txmulticast.dll                                               | 2017.140.3030.27 | 102560    | 30-Jun-18 | 01:14 | x86      |
| Txmulticast.dll                                               | 2017.140.3030.27 | 127656    | 30-Jun-18 | 01:23 | x64      |
| Txpivot.dll                                                   | 2017.140.3030.27 | 180392    | 30-Jun-18 | 01:13 | x86      |
| Txpivot.dll                                                   | 2017.140.3030.27 | 224936    | 30-Jun-18 | 01:23 | x64      |
| Txrowcount.dll                                                | 2017.140.3030.27 | 101544    | 30-Jun-18 | 01:13 | x86      |
| Txrowcount.dll                                                | 2017.140.3030.27 | 125600    | 30-Jun-18 | 01:23 | x64      |
| Txsampling.dll                                                | 2017.140.3030.27 | 135848    | 30-Jun-18 | 01:13 | x86      |
| Txsampling.dll                                                | 2017.140.3030.27 | 172712    | 30-Jun-18 | 01:15 | x64      |
| Txscd.dll                                                     | 2017.140.3030.27 | 220840    | 30-Jun-18 | 01:15 | x64      |
| Txscd.dll                                                     | 2017.140.3030.27 | 170152    | 30-Jun-18 | 01:22 | x86      |
| Txsort.dll                                                    | 2017.140.3030.27 | 208032    | 30-Jun-18 | 01:13 | x86      |
| Txsort.dll                                                    | 2017.140.3030.27 | 256672    | 30-Jun-18 | 01:15 | x64      |
| Txsplit.dll                                                   | 2017.140.3030.27 | 510632    | 30-Jun-18 | 01:13 | x86      |
| Txsplit.dll                                                   | 2017.140.3030.27 | 596648    | 30-Jun-18 | 01:23 | x64      |
| Txtermextraction.dll                                          | 2017.140.3030.27 | 8615080   | 30-Jun-18 | 01:14 | x86      |
| Txtermextraction.dll                                          | 2017.140.3030.27 | 8676520   | 30-Jun-18 | 01:23 | x64      |
| Txtermlookup.dll                                              | 2017.140.3030.27 | 4157096   | 30-Jun-18 | 01:15 | x64      |
| Txtermlookup.dll                                              | 2017.140.3030.27 | 4106912   | 30-Jun-18 | 01:22 | x86      |
| Txunionall.dll                                                | 2017.140.3030.27 | 139432    | 30-Jun-18 | 01:13 | x86      |
| Txunionall.dll                                                | 2017.140.3030.27 | 181928    | 30-Jun-18 | 01:15 | x64      |
| Txunpivot.dll                                                 | 2017.140.3030.27 | 160416    | 30-Jun-18 | 01:13 | x86      |
| Txunpivot.dll                                                 | 2017.140.3030.27 | 199848    | 30-Jun-18 | 01:15 | x64      |
| Xe.dll                                                        | 2017.140.3030.27 | 673440    | 30-Jun-18 | 00:59 | x64      |
| Xe.dll                                                        | 2017.140.3030.27 | 595616    | 30-Jun-18 | 01:11 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 21-Apr-18 | 00:47 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 21-Apr-18 | 00:47 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 21-Apr-18 | 00:47 | x86      |
| Instapi140.dll                                                       | 2017.140.3030.27 | 70848     | 30-Jun-18 | 01:00 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 21-Apr-18 | 00:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 21-Apr-18 | 00:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 21-Apr-18 | 00:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 21-Apr-18 | 00:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 21-Apr-18 | 00:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 21-Apr-18 | 00:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 21-Apr-18 | 00:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 21-Apr-18 | 00:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 21-Apr-18 | 00:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 21-Apr-18 | 00:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 21-Apr-18 | 00:47 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 21-Apr-18 | 00:47 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3030.27 | 407208    | 30-Jun-18 | 01:15 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3030.27 | 7324328   | 30-Jun-18 | 01:38 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3030.27 | 2263208   | 30-Jun-18 | 01:00 | x64      |
| Secforwarder.dll                                                     | 2017.140.3030.27 | 37536     | 30-Jun-18 | 01:15 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 21-Apr-18 | 00:19 | x64      |
| Sqldk.dll                                                            | 2017.140.3030.27 | 2711552   | 30-Jun-18 | 01:12 | x64      |
| Sqldumper.exe                                                        | 2017.140.3030.27 | 141472    | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 1497768   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3914408   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3213992   | 30-Jun-18 | 01:14 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3917480   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3821224   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 2089640   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 2036392   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3588256   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3596968   | 30-Jun-18 | 01:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 1445032   | 30-Jun-18 | 01:11 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3030.27 | 3785384   | 30-Jun-18 | 01:13 | x64      |
| Sqlos.dll                                                            | 2017.140.3030.27 | 26280     | 30-Jun-18 | 01:12 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 21-Apr-18 | 00:47 | x64      |
| Sqltses.dll                                                          | 2017.140.3030.27 | 9691136   | 30-Jun-18 | 01:22 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3030.27     | 23720     | 30-Jun-18 | 00:48 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3030.27 | 1448616   | 30-Jun-18 | 01:22 | x86      |
| Dtaengine.exe                                          | 2017.140.3030.27 | 204448    | 30-Jun-18 | 01:22 | x86      |
| Dteparse.dll                                           | 2017.140.3030.27 | 100520    | 30-Jun-18 | 01:13 | x86      |
| Dteparse.dll                                           | 2017.140.3030.27 | 111784    | 30-Jun-18 | 01:15 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3030.27 | 83624     | 30-Jun-18 | 01:13 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3030.27 | 89248     | 30-Jun-18 | 01:15 | x64      |
| Dtepkg.dll                                             | 2017.140.3030.27 | 116928    | 30-Jun-18 | 01:13 | x86      |
| Dtepkg.dll                                             | 2017.140.3030.27 | 138912    | 30-Jun-18 | 01:23 | x64      |
| Dtexec.exe                                             | 2017.140.3030.27 | 67752     | 30-Jun-18 | 01:13 | x86      |
| Dtexec.exe                                             | 2017.140.3030.27 | 73896     | 30-Jun-18 | 01:23 | x64      |
| Dts.dll                                                | 2017.140.3030.27 | 2549416   | 30-Jun-18 | 01:13 | x86      |
| Dts.dll                                                | 2017.140.3030.27 | 2998952   | 30-Jun-18 | 01:23 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3030.27 | 417960    | 30-Jun-18 | 01:13 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3030.27 | 475304    | 30-Jun-18 | 01:15 | x64      |
| Dtsconn.dll                                            | 2017.140.3030.27 | 399520    | 30-Jun-18 | 01:22 | x86      |
| Dtsconn.dll                                            | 2017.140.3030.27 | 497312    | 30-Jun-18 | 01:23 | x64      |
| Dtshost.exe                                            | 2017.140.3030.27 | 89768     | 30-Jun-18 | 01:13 | x86      |
| Dtshost.exe                                            | 2017.140.3030.27 | 104616    | 30-Jun-18 | 01:15 | x64      |
| Dtslog.dll                                             | 2017.140.3030.27 | 103080    | 30-Jun-18 | 01:13 | x86      |
| Dtslog.dll                                             | 2017.140.3030.27 | 120488    | 30-Jun-18 | 01:15 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3030.27 | 541352    | 30-Jun-18 | 01:14 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3030.27 | 545448    | 30-Jun-18 | 01:15 | x64      |
| Dtspipeline.dll                                        | 2017.140.3030.27 | 1059496   | 30-Jun-18 | 01:22 | x86      |
| Dtspipeline.dll                                        | 2017.140.3030.27 | 1266336   | 30-Jun-18 | 01:23 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3030.27 | 42664     | 30-Jun-18 | 01:13 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3030.27 | 48296     | 30-Jun-18 | 01:15 | x64      |
| Dtuparse.dll                                           | 2017.140.3030.27 | 80040     | 30-Jun-18 | 01:13 | x86      |
| Dtuparse.dll                                           | 2017.140.3030.27 | 89256     | 30-Jun-18 | 01:15 | x64      |
| Dtutil.exe                                             | 2017.140.3030.27 | 126120    | 30-Jun-18 | 01:13 | x86      |
| Dtutil.exe                                             | 2017.140.3030.27 | 147104    | 30-Jun-18 | 01:15 | x64      |
| Exceldest.dll                                          | 2017.140.3030.27 | 214696    | 30-Jun-18 | 01:13 | x86      |
| Exceldest.dll                                          | 2017.140.3030.27 | 260776    | 30-Jun-18 | 01:15 | x64      |
| Excelsrc.dll                                           | 2017.140.3030.27 | 282792    | 30-Jun-18 | 01:15 | x64      |
| Excelsrc.dll                                           | 2017.140.3030.27 | 230560    | 30-Jun-18 | 01:22 | x86      |
| Flatfiledest.dll                                       | 2017.140.3030.27 | 332968    | 30-Jun-18 | 01:13 | x86      |
| Flatfiledest.dll                                       | 2017.140.3030.27 | 386728    | 30-Jun-18 | 01:15 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3030.27 | 344232    | 30-Jun-18 | 01:13 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3030.27 | 399016    | 30-Jun-18 | 01:15 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3030.27 | 80544     | 30-Jun-18 | 01:22 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3030.27 | 96424     | 30-Jun-18 | 01:23 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3030.27     | 71336     | 30-Jun-18 | 01:30 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3030.27     | 184480    | 30-Jun-18 | 06:10 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3030.27     | 406688    | 30-Jun-18 | 01:13 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3030.27     | 406720    | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3030.27     | 2093224   | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3030.27     | 2093224   | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3030.27     | 614056    | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3030.27     | 614056    | 30-Jun-18 | 01:23 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3030.27     | 252584    | 30-Jun-18 | 01:13 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3030.27 | 141984    | 30-Jun-18 | 01:22 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3030.27 | 152232    | 30-Jun-18 | 01:22 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3030.27 | 159400    | 30-Jun-18 | 01:11 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3030.27 | 145576    | 30-Jun-18 | 01:11 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3030.27 | 90272     | 30-Jun-18 | 01:13 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3030.27 | 103080    | 30-Jun-18 | 01:15 | x64      |
| Msmgdsrv.dll                                           | 2017.140.223.1   | 7310504   | 22-Jun-18 | 01:40 | x86      |
| Oledbdest.dll                                          | 2017.140.3030.27 | 214696    | 30-Jun-18 | 01:13 | x86      |
| Oledbdest.dll                                          | 2017.140.3030.27 | 261280    | 30-Jun-18 | 01:23 | x64      |
| Oledbsrc.dll                                           | 2017.140.3030.27 | 233128    | 30-Jun-18 | 01:13 | x86      |
| Oledbsrc.dll                                           | 2017.140.3030.27 | 288928    | 30-Jun-18 | 01:23 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3030.27 | 100520    | 30-Jun-18 | 00:45 | x64      |
| Sqlresld.dll                                           | 2017.140.3030.27 | 30888     | 30-Jun-18 | 00:48 | x64      |
| Sqlresld.dll                                           | 2017.140.3030.27 | 28832     | 30-Jun-18 | 01:13 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3030.27 | 32416     | 30-Jun-18 | 00:45 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3030.27 | 29352     | 30-Jun-18 | 00:48 | x86      |
| Sqlscm.dll                                             | 2017.140.3030.27 | 61096     | 30-Jun-18 | 01:13 | x86      |
| Sqlscm.dll                                             | 2017.140.3030.27 | 71336     | 30-Jun-18 | 01:15 | x64      |
| Sqlsvc.dll                                             | 2017.140.3030.27 | 134824    | 30-Jun-18 | 01:13 | x86      |
| Sqlsvc.dll                                             | 2017.140.3030.27 | 161952    | 30-Jun-18 | 01:15 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3030.27 | 155296    | 30-Jun-18 | 01:13 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3030.27 | 182944    | 30-Jun-18 | 01:15 | x64      |
| Txdataconvert.dll                                      | 2017.140.3030.27 | 253096    | 30-Jun-18 | 01:22 | x86      |
| Txdataconvert.dll                                      | 2017.140.3030.27 | 293032    | 30-Jun-18 | 01:23 | x64      |
| Xe.dll                                                 | 2017.140.3030.27 | 673440    | 30-Jun-18 | 00:59 | x64      |
| Xe.dll                                                 | 2017.140.3030.27 | 595616    | 30-Jun-18 | 01:11 | x86      |
| Xmlrw.dll                                              | 2017.140.3030.27 | 257704    | 30-Jun-18 | 01:14 | x86      |
| Xmlrw.dll                                              | 2017.140.3030.27 | 305320    | 30-Jun-18 | 01:15 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3030.27 | 224424    | 30-Jun-18 | 01:00 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3030.27 | 189608    | 30-Jun-18 | 01:14 | x86      |

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
