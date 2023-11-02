---
title: Cumulative update 12 for SQL Server 2017 (KB4464082)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 12 (KB4464082).
ms.date: 08/04/2023
ms.custom: KB4464082
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4464082 - Cumulative Update 12 for SQL Server 2017

_Release Date:_ &nbsp; October 24, 2018  
_Version:_ &nbsp; 14.0.3045.24

## Summary

This article describes Cumulative Update package 12 (CU12) for Microsoft SQL Server 2017. This update contains 18 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 11, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3045.24**, file version: **2017.140.3045.24**
- Analysis Services - Product version: **14.0.230.1**, file version: **2017.140.230.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12392563">[12392563](#12392563)</a> | [FIX: "An unexpected exception occurred" in an MDX query for PC dimensions in SSAS 2017 (KB4465248)](https://support.microsoft.com/help/4465248) | Analysis Services | Analysis Services | Windows |
| <a id="12363625">[12363625](#12363625)</a> | FIX: Deadlock occurs in SSAS 2017 when you run a DAX query with time intelligence calculation in parallel (KB4465247) | Analysis Services | Analysis Services | Windows |
| <a id="12229849">[12229849](#12229849)</a> | [FIX: Create and update don’t work in an entity when you set Read and Create permission in MDS 2017 (KB4345524)](https://support.microsoft.com/help/4345524) | Master Data Services | Client | Windows |
| <a id="12352667">[12352667](#12352667)</a> | FIX: Error occurs when you change the "Display value" of "Name" attribute of an entity to any value other than "Name" in SQL Server 2017 MDS Add-in for Excel (KB4462426) | Master Data Services | Client | Windows |
| <a id="12342954">[12342954](#12342954)</a> | [FIX: "Encryption not supported on the client" error when a SQL Server 2017 linked server query fails (KB4463757)](https://support.microsoft.com/help/4463757) | SQL Server Connectivity | SQL Connectivity | Windows |
| <a id="12366825">[12366825](#12366825)</a> | [FIX: Backing up a SQL Server 2008 database by using a VSS backup application may fail after installing CU10 for SQL Server 2017 (KB4466108)](https://support.microsoft.com/help/4466108) | SQL Server Engine | Backup Restore | Windows |
| <a id="12428685">[12428685](#12428685)</a> | [FIX: SQL Server 2017 crashes unexpectedly when you use third-party Active Directory providers (KB4466962)](https://support.microsoft.com/help/4466962) | SQL Server Engine | Linux | Linux |
| <a id="11967433">[11967433](#11967433)</a> | [FIX: Assertion error occurs when you run a MERGE statement with an OUTPUT clause in SQL Server 2017 (KB4465745)](https://support.microsoft.com/help/4465745) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="12409366">[12409366](#12409366)</a> | [FIX: Rebuilding an Index with Resumable Online Index Rebuild can result in a fragmented index in SQL Server 2017 (KB4465832)](https://support.microsoft.com/help/4465832) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="12186149">[12186149](#12186149)</a> | [Improvement: Optional replacement for "String or binary data would be truncated" message with extended information in SQL Server 2017 (KB4468101)](https://support.microsoft.com/help/4468101) | SQL Server Engine | Programmability | All |
| <a id="12342904">[12342904](#12342904)</a> | [FIX: Excessive memory usage when you trace RPC events that involve Table-Valued Parameters in SQL Server 2017 (KB4468102)](https://support.microsoft.com/help/4468102) | SQL Server Engine | Programmability | All |
| <a id="12403785">[12403785](#12403785)</a> | [Update disables trace flag 2467 at session level to prevent a performance issue for parallel queries in SQL Server 2017 (KB4467074)](https://support.microsoft.com/help/4467074) | SQL Server Engine | Query Execution | All |
| <a id="12296279">[12296279](#12296279)</a> | [FIX: An intra-query deadlock occurs in a query containing UNION ALL in batch mode in SQL Server (KB4465204)](https://support.microsoft.com/help/4465204) | SQL Server Engine | Query Execution | Windows |
| <a id="12321033">[12321033](#12321033)</a> | [FIX: Query operation freezes when you insert data into a clustered columnstore index in parallel in SQL Server data warehousing (KB4462481)](https://support.microsoft.com/help/4462481) | SQL Server Engine | Query Execution | Windows |
| <a id="12359904">[12359904](#12359904)</a> | [FIX: Access violation occurs in compile code when you parse the forced plan in SQL Server 2017 (KB4465236)](https://support.microsoft.com/help/4465236) | SQL Server Engine | Query Store | Windows |
| <a id="12342475">[12342475](#12342475)</a> | [FIX: "Could not find server" when the publisher database name contains a period in SQL Server 2017 (KB4469140)](https://support.microsoft.com/help/4469140) | SQL Server Engine | Replication | All |
| <a id="12357735">[12357735](#12357735)</a> | [FIX: Access violation occurs in Distribution Agent in SQL Server 2017 (KB4468103)](https://support.microsoft.com/help/4468103) | SQL Server Engine | Replication | Windows |
| <a id="12362293">[12362293](#12362293)</a> | [FIX: Incorrect results occur when you convert "pollinginterval" parameter from seconds to hours in sys.sp_cdc_scan in SQL Server 2017 (KB4459220)](https://support.microsoft.com/help/4459220) | SQL Server Engine | Replication | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU12 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2018/10/sqlserver2017-kb4464082-x64_f02243869552c7a8e21fe64ee5f2a78a7d52d979.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4464082-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4464082-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4464082-x64.exe| 0A435B81D0C41041C2CD1BFA0B2AB4754B1B4609D6EA5BC672991F761B509B2F |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.230.1   | 266312    | 26-Sep-18 | 18:56 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.230.1       | 741448    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.230.1       | 1380424   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.230.1       | 984328    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.230.1       | 521480    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435      | 329872    | 27-Jul-18 | 23:51 | x86      |
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
| Msmdctr.dll                                        | 2017.140.230.1   | 40200     | 26-Sep-18 | 18:56 | x64      |
| Msmdlocal.dll                                      | 2017.140.230.1   | 60710168  | 26-Sep-18 | 18:56 | x64      |
| Msmdlocal.dll                                      | 2017.140.230.1   | 40384280  | 26-Sep-18 | 18:56 | x86      |
| Msmdpump.dll                                       | 2017.140.230.1   | 9335064   | 26-Sep-18 | 18:56 | x64      |
| Msmdredir.dll                                      | 2017.140.230.1   | 7092296   | 26-Sep-18 | 18:56 | x86      |
| Msmdsrv.exe                                        | 2017.140.230.1   | 60612680  | 26-Sep-18 | 18:56 | x64      |
| Msmgdsrv.dll                                       | 2017.140.230.1   | 9004616   | 26-Sep-18 | 18:56 | x64      |
| Msmgdsrv.dll                                       | 2017.140.230.1   | 7310600   | 26-Sep-18 | 18:56 | x86      |
| Msolap.dll                                         | 2017.140.230.1   | 10258504  | 26-Sep-18 | 18:56 | x64      |
| Msolap.dll                                         | 2017.140.230.1   | 7777552   | 26-Sep-18 | 18:56 | x86      |
| Msolui.dll                                         | 2017.140.230.1   | 311056    | 26-Sep-18 | 18:56 | x64      |
| Msolui.dll                                         | 2017.140.230.1   | 287512    | 26-Sep-18 | 18:56 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261    | 6606536   | 06-Jun-18 | 04:34 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlboot.dll                                        | 2017.140.3045.24 | 196360    | 19-Oct-18 | 06:02 | x64      |
| Sqlceip.exe                                        | 14.0.3045.24     | 255560    | 19-Oct-18 | 06:21 | x86      |
| Sqldumper.exe                                      | 2017.140.3045.24 | 141384    | 19-Oct-18 | 06:13 | x64      |
| Sqldumper.exe                                      | 2017.140.3045.24 | 119368    | 19-Oct-18 | 06:13 | x86      |
| Tmapi.dll                                          | 2017.140.230.1   | 5821512   | 26-Sep-18 | 18:56 | x64      |
| Tmcachemgr.dll                                     | 2017.140.230.1   | 4164880   | 26-Sep-18 | 18:56 | x64      |
| Tmpersistence.dll                                  | 2017.140.230.1   | 1132104   | 26-Sep-18 | 18:56 | x64      |
| Tmtransactions.dll                                 | 2017.140.230.1   | 1641032   | 26-Sep-18 | 18:56 | x64      |
| Xe.dll                                             | 2017.140.3045.24 | 673352    | 19-Oct-18 | 06:06 | x64      |
| Xmlrw.dll                                          | 2017.140.3045.24 | 305416    | 19-Oct-18 | 06:07 | x64      |
| Xmlrw.dll                                          | 2017.140.3045.24 | 257816    | 19-Oct-18 | 06:13 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3045.24 | 224536    | 19-Oct-18 | 06:02 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3045.24 | 189512    | 19-Oct-18 | 06:06 | x86      |
| Xmsrv.dll                                          | 2017.140.230.1   | 25375512  | 26-Sep-18 | 18:56 | x64      |
| Xmsrv.dll                                          | 2017.140.230.1   | 33350728  | 26-Sep-18 | 18:56 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3045.24 | 181016    | 19-Oct-18 | 05:57 | x64      |
| Batchparser.dll                            | 2017.140.3045.24 | 160536    | 19-Oct-18 | 06:02 | x86      |
| Instapi140.dll                             | 2017.140.3045.24 | 61232     | 19-Oct-18 | 06:06 | x86      |
| Instapi140.dll                             | 2017.140.3045.24 | 70936     | 19-Oct-18 | 06:07 | x64      |
| Isacctchange.dll                           | 2017.140.3045.24 | 29448     | 19-Oct-18 | 06:06 | x86      |
| Isacctchange.dll                           | 2017.140.3045.24 | 30792     | 19-Oct-18 | 06:15 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.230.1       | 1088792   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.230.1       | 1088792   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.230.1       | 1381640   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.230.1       | 741656    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.230.1       | 741648    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3045.24     | 37152     | 19-Oct-18 | 06:06 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3045.24 | 78600     | 19-Oct-18 | 06:06 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3045.24 | 81992     | 19-Oct-18 | 06:15 | x64      |
| Msasxpress.dll                             | 2017.140.230.1   | 35912     | 26-Sep-18 | 18:56 | x64      |
| Msasxpress.dll                             | 2017.140.230.1   | 32016     | 26-Sep-18 | 18:56 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3045.24 | 82712     | 19-Oct-18 | 06:07 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3045.24 | 68360     | 19-Oct-18 | 06:13 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqldumper.exe                              | 2017.140.3045.24 | 141384    | 19-Oct-18 | 06:13 | x64      |
| Sqldumper.exe                              | 2017.140.3045.24 | 119368    | 19-Oct-18 | 06:13 | x86      |
| Sqlftacct.dll                              | 2017.140.3045.24 | 55600     | 19-Oct-18 | 06:21 | x86      |
| Sqlftacct.dll                              | 2017.140.3045.24 | 62728     | 19-Oct-18 | 06:21 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 21-Apr-18 | 00:33 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 21-Apr-18 | 00:29 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3045.24 | 373008    | 19-Oct-18 | 06:13 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3045.24 | 416528    | 19-Oct-18 | 06:31 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3045.24 | 35096     | 19-Oct-18 | 06:21 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3045.24 | 37648     | 19-Oct-18 | 06:21 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3045.24 | 273480    | 19-Oct-18 | 06:06 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3045.24 | 356104    | 19-Oct-18 | 06:07 | x64      |
| Sqltdiagn.dll                              | 2017.140.3045.24 | 60488     | 19-Oct-18 | 05:57 | x86      |
| Sqltdiagn.dll                              | 2017.140.3045.24 | 67656     | 19-Oct-18 | 05:57 | x64      |
| Svrenumapi140.dll                          | 2017.140.3045.24 | 1173776   | 19-Oct-18 | 06:07 | x64      |
| Svrenumapi140.dll                          | 2017.140.3045.24 | 893704    | 19-Oct-18 | 06:13 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3045.24 | 121104    | 19-Oct-18 | 06:20 | x86      |
| Dreplaycommon.dll              | 2017.140.3045.24 | 699144    | 19-Oct-18 | 06:13 | x86      |
| Dreplayserverps.dll            | 2017.140.3045.24 | 32840     | 19-Oct-18 | 06:02 | x86      |
| Dreplayutil.dll                | 2017.140.3045.24 | 310040    | 19-Oct-18 | 06:20 | x86      |
| Instapi140.dll                 | 2017.140.3045.24 | 70936     | 19-Oct-18 | 06:07 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlresourceloader.dll          | 2017.140.3045.24 | 29256     | 19-Oct-18 | 05:56 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3045.24 | 699144    | 19-Oct-18 | 06:13 | x86      |
| Dreplaycontroller.exe              | 2017.140.3045.24 | 350472    | 19-Oct-18 | 06:20 | x86      |
| Dreplayprocess.dll                 | 2017.140.3045.24 | 171800    | 19-Oct-18 | 06:13 | x86      |
| Dreplayserverps.dll                | 2017.140.3045.24 | 32840     | 19-Oct-18 | 06:02 | x86      |
| Instapi140.dll                     | 2017.140.3045.24 | 70936     | 19-Oct-18 | 06:07 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlresourceloader.dll              | 2017.140.3045.24 | 29256     | 19-Oct-18 | 05:56 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3045.24 | 181016    | 19-Oct-18 | 05:57 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 20-Apr-18 | 23:43 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 20-Apr-18 | 23:43 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 20-Apr-18 | 23:43 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 21-Apr-18 | 00:28 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3045.24 | 226576    | 19-Oct-18 | 06:15 | x64      |
| Dcexec.exe                                   | 2017.140.3045.24 | 74512     | 19-Oct-18 | 06:15 | x64      |
| Fssres.dll                                   | 2017.140.3045.24 | 89864     | 19-Oct-18 | 06:21 | x64      |
| Hadrres.dll                                  | 2017.140.3045.24 | 188168    | 19-Oct-18 | 06:21 | x64      |
| Hkcompile.dll                                | 2017.140.3045.24 | 1423120   | 19-Oct-18 | 06:21 | x64      |
| Hkengine.dll                                 | 2017.140.3045.24 | 5858576   | 19-Oct-18 | 06:31 | x64      |
| Hkruntime.dll                                | 2017.140.3045.24 | 162888    | 19-Oct-18 | 06:38 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 20-Apr-18 | 23:43 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.230.1       | 741136    | 26-Sep-18 | 18:56 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 27-Jul-18 | 23:51 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3045.24     | 237320    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3045.24     | 79640     | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3045.24 | 71240     | 19-Oct-18 | 06:02 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3045.24 | 65096     | 19-Oct-18 | 06:01 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3045.24 | 152336    | 19-Oct-18 | 06:13 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3045.24 | 159496    | 19-Oct-18 | 06:06 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3045.24 | 304392    | 19-Oct-18 | 06:13 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3045.24 | 75024     | 19-Oct-18 | 06:20 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 20-Apr-18 | 23:43 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 20-Apr-18 | 23:43 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 20-Apr-18 | 23:43 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 20-Apr-18 | 23:43 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 20-Apr-18 | 23:43 | x64      |
| Odsole70.dll                                 | 2017.140.3045.24 | 92952     | 19-Oct-18 | 06:21 | x64      |
| Opends60.dll                                 | 2017.140.3045.24 | 33048     | 19-Oct-18 | 06:02 | x64      |
| Qds.dll                                      | 2017.140.3045.24 | 1173784   | 19-Oct-18 | 11:04 | x64      |
| Rsfxft.dll                                   | 2017.140.3045.24 | 34568     | 19-Oct-18 | 06:06 | x64      |
| Secforwarder.dll                             | 2017.140.3045.24 | 37656     | 19-Oct-18 | 06:20 | x64      |
| Sqagtres.dll                                 | 2017.140.3045.24 | 74520     | 19-Oct-18 | 06:15 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlaamss.dll                                 | 2017.140.3045.24 | 90392     | 19-Oct-18 | 06:21 | x64      |
| Sqlaccess.dll                                | 2017.140.3045.24 | 475928    | 19-Oct-18 | 06:07 | x64      |
| Sqlagent.exe                                 | 2017.140.3045.24 | 582216    | 19-Oct-18 | 06:21 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3045.24 | 62232     | 19-Oct-18 | 06:13 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3045.24 | 53016     | 19-Oct-18 | 06:13 | x86      |
| Sqlagentlog.dll                              | 2017.140.3045.24 | 32840     | 19-Oct-18 | 05:57 | x64      |
| Sqlagentmail.dll                             | 2017.140.3045.24 | 54024     | 19-Oct-18 | 05:56 | x64      |
| Sqlboot.dll                                  | 2017.140.3045.24 | 196360    | 19-Oct-18 | 06:02 | x64      |
| Sqlceip.exe                                  | 14.0.3045.24     | 255560    | 19-Oct-18 | 06:21 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3045.24 | 72776     | 19-Oct-18 | 06:15 | x64      |
| Sqlctr140.dll                                | 2017.140.3045.24 | 112400    | 19-Oct-18 | 06:21 | x86      |
| Sqlctr140.dll                                | 2017.140.3045.24 | 129304    | 19-Oct-18 | 06:21 | x64      |
| Sqldk.dll                                    | 2017.140.3045.24 | 2796312   | 19-Oct-18 | 11:08 | x64      |
| Sqldtsss.dll                                 | 2017.140.3045.24 | 107592    | 19-Oct-18 | 06:49 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3291720   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 2090264   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3297352   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 1498184   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3482392   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3636504   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3915536   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3677976   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3785992   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 1445640   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3339568   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3821848   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3597592   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3787544   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3918088   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3214608   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3403336   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3589400   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3780376   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 2037016   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 3368216   | 19-Oct-18 | 06:07 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3045.24 | 4027672   | 19-Oct-18 | 06:07 | x64      |
| Sqliosim.com                                 | 2017.140.3045.24 | 313416    | 19-Oct-18 | 06:20 | x64      |
| Sqliosim.exe                                 | 2017.140.3045.24 | 3019848   | 19-Oct-18 | 06:38 | x64      |
| Sqllang.dll                                  | 2017.140.3045.24 | 41245768  | 19-Oct-18 | 11:25 | x64      |
| Sqlmin.dll                                   | 2017.140.3045.24 | 40462600  | 19-Oct-18 | 11:22 | x64      |
| Sqlolapss.dll                                | 2017.140.3045.24 | 107800    | 19-Oct-18 | 06:15 | x64      |
| Sqlos.dll                                    | 2017.140.3045.24 | 26376     | 19-Oct-18 | 06:20 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3045.24 | 68168     | 19-Oct-18 | 06:15 | x64      |
| Sqlrepss.dll                                 | 2017.140.3045.24 | 64584     | 19-Oct-18 | 06:07 | x64      |
| Sqlresld.dll                                 | 2017.140.3045.24 | 30792     | 19-Oct-18 | 05:57 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3045.24 | 32328     | 19-Oct-18 | 06:02 | x64      |
| Sqlscm.dll                                   | 2017.140.3045.24 | 71240     | 19-Oct-18 | 06:07 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3045.24 | 27912     | 19-Oct-18 | 05:57 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3045.24 | 5872712   | 19-Oct-18 | 06:07 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3045.24 | 732936    | 19-Oct-18 | 06:21 | x64      |
| Sqlservr.exe                                 | 2017.140.3045.24 | 487688    | 19-Oct-18 | 11:04 | x64      |
| Sqlsvc.dll                                   | 2017.140.3045.24 | 161864    | 19-Oct-18 | 06:15 | x64      |
| Sqltses.dll                                  | 2017.140.3045.24 | 9564952   | 19-Oct-18 | 11:08 | x64      |
| Sqsrvres.dll                                 | 2017.140.3045.24 | 261392    | 19-Oct-18 | 06:31 | x64      |
| Svl.dll                                      | 2017.140.3045.24 | 153864    | 19-Oct-18 | 06:38 | x64      |
| Xe.dll                                       | 2017.140.3045.24 | 673352    | 19-Oct-18 | 06:06 | x64      |
| Xmlrw.dll                                    | 2017.140.3045.24 | 305416    | 19-Oct-18 | 06:07 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3045.24 | 224536    | 19-Oct-18 | 06:02 | x64      |
| Xpadsi.exe                                   | 2017.140.3045.24 | 89672     | 19-Oct-18 | 06:15 | x64      |
| Xplog70.dll                                  | 2017.140.3045.24 | 75848     | 19-Oct-18 | 06:38 | x64      |
| Xpqueue.dll                                  | 2017.140.3045.24 | 75016     | 19-Oct-18 | 06:07 | x64      |
| Xprepl.dll                                   | 2017.140.3045.24 | 102152    | 19-Oct-18 | 06:07 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3045.24 | 32328     | 19-Oct-18 | 06:07 | x64      |
| Xpstar.dll                                   | 2017.140.3045.24 | 438344    | 19-Oct-18 | 06:21 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3045.24 | 181016    | 19-Oct-18 | 05:57 | x64      |
| Batchparser.dll                                             | 2017.140.3045.24 | 160536    | 19-Oct-18 | 06:02 | x86      |
| Bcp.exe                                                     | 2017.140.3045.24 | 120088    | 19-Oct-18 | 06:07 | x64      |
| Commanddest.dll                                             | 2017.140.3045.24 | 246024    | 19-Oct-18 | 06:15 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3045.24 | 116296    | 19-Oct-18 | 06:15 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3045.24 | 187464    | 19-Oct-18 | 06:15 | x64      |
| Distrib.exe                                                 | 2017.140.3045.24 | 203528    | 19-Oct-18 | 06:15 | x64      |
| Dteparse.dll                                                | 2017.140.3045.24 | 111384    | 19-Oct-18 | 06:15 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3045.24 | 89352     | 19-Oct-18 | 06:07 | x64      |
| Dtepkg.dll                                                  | 2017.140.3045.24 | 138000    | 19-Oct-18 | 06:15 | x64      |
| Dtexec.exe                                                  | 2017.140.3045.24 | 73992     | 19-Oct-18 | 06:21 | x64      |
| Dts.dll                                                     | 2017.140.3045.24 | 2999064   | 19-Oct-18 | 06:21 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3045.24 | 475400    | 19-Oct-18 | 06:15 | x64      |
| Dtsconn.dll                                                 | 2017.140.3045.24 | 497416    | 19-Oct-18 | 06:15 | x64      |
| Dtshost.exe                                                 | 2017.140.3045.24 | 104712    | 19-Oct-18 | 06:15 | x64      |
| Dtslog.dll                                                  | 2017.140.3045.24 | 120600    | 19-Oct-18 | 06:15 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3045.24 | 545352    | 19-Oct-18 | 06:02 | x64      |
| Dtspipeline.dll                                             | 2017.140.3045.24 | 1266440   | 19-Oct-18 | 06:21 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3045.24 | 48408     | 19-Oct-18 | 06:15 | x64      |
| Dtuparse.dll                                                | 2017.140.3045.24 | 89368     | 19-Oct-18 | 06:15 | x64      |
| Dtutil.exe                                                  | 2017.140.3045.24 | 147224    | 19-Oct-18 | 06:15 | x64      |
| Exceldest.dll                                               | 2017.140.3045.24 | 260680    | 19-Oct-18 | 06:15 | x64      |
| Excelsrc.dll                                                | 2017.140.3045.24 | 282888    | 19-Oct-18 | 06:15 | x64      |
| Execpackagetask.dll                                         | 2017.140.3045.24 | 168008    | 19-Oct-18 | 06:15 | x64      |
| Flatfiledest.dll                                            | 2017.140.3045.24 | 386832    | 19-Oct-18 | 06:15 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3045.24 | 399112    | 19-Oct-18 | 06:15 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3045.24 | 96520     | 19-Oct-18 | 06:15 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3045.24 | 59656     | 19-Oct-18 | 06:21 | x64      |
| Logread.exe                                                 | 2017.140.3045.24 | 635160    | 19-Oct-18 | 06:21 | x64      |
| Mergetxt.dll                                                | 2017.140.3045.24 | 63752     | 19-Oct-18 | 06:15 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.230.1       | 1381440   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 21-Apr-18 | 00:24 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3045.24     | 137800    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3045.24     | 89672     | 19-Oct-18 | 06:38 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3045.24     | 613960    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3045.24 | 1663760   | 19-Oct-18 | 06:31 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3045.24 | 152336    | 19-Oct-18 | 06:13 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3045.24 | 159496    | 19-Oct-18 | 06:06 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3045.24 | 103496    | 19-Oct-18 | 06:15 | x64      |
| Msgprox.dll                                                 | 2017.140.3045.24 | 270408    | 19-Oct-18 | 06:15 | x64      |
| Msxmlsql.dll                                                | 2017.140.3045.24 | 1448216   | 19-Oct-18 | 06:15 | x64      |
| Oledbdest.dll                                               | 2017.140.3045.24 | 261192    | 19-Oct-18 | 06:15 | x64      |
| Oledbsrc.dll                                                | 2017.140.3045.24 | 289040    | 19-Oct-18 | 06:21 | x64      |
| Osql.exe                                                    | 2017.140.3045.24 | 75336     | 19-Oct-18 | 06:02 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3045.24 | 473672    | 19-Oct-18 | 06:15 | x64      |
| Rawdest.dll                                                 | 2017.140.3045.24 | 206600    | 19-Oct-18 | 06:15 | x64      |
| Rawsource.dll                                               | 2017.140.3045.24 | 194120    | 19-Oct-18 | 06:15 | x64      |
| Rdistcom.dll                                                | 2017.140.3045.24 | 857360    | 19-Oct-18 | 06:15 | x64      |
| Recordsetdest.dll                                           | 2017.140.3045.24 | 184392    | 19-Oct-18 | 06:15 | x64      |
| Replagnt.dll                                                | 2017.140.3045.24 | 30792     | 19-Oct-18 | 06:07 | x64      |
| Repldp.dll                                                  | 2017.140.3045.24 | 291080    | 19-Oct-18 | 06:15 | x64      |
| Replerrx.dll                                                | 2017.140.3045.24 | 154392    | 19-Oct-18 | 06:15 | x64      |
| Replisapi.dll                                               | 2017.140.3045.24 | 362256    | 19-Oct-18 | 06:21 | x64      |
| Replmerg.exe                                                | 2017.140.3045.24 | 525064    | 19-Oct-18 | 06:31 | x64      |
| Replprov.dll                                                | 2017.140.3045.24 | 802080    | 19-Oct-18 | 06:21 | x64      |
| Replrec.dll                                                 | 2017.140.3045.24 | 975432    | 19-Oct-18 | 06:15 | x64      |
| Replsub.dll                                                 | 2017.140.3045.24 | 445704    | 19-Oct-18 | 06:15 | x64      |
| Replsync.dll                                                | 2017.140.3045.24 | 154184    | 19-Oct-18 | 06:15 | x64      |
| Spresolv.dll                                                | 2017.140.3045.24 | 251976    | 19-Oct-18 | 06:15 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3045.24 | 248904    | 19-Oct-18 | 06:02 | x64      |
| Sqldiag.exe                                                 | 2017.140.3045.24 | 1257544   | 19-Oct-18 | 06:07 | x64      |
| Sqldistx.dll                                                | 2017.140.3045.24 | 225560    | 19-Oct-18 | 06:15 | x64      |
| Sqllogship.exe                                              | 14.0.3045.24     | 105544    | 19-Oct-18 | 06:07 | x64      |
| Sqlmergx.dll                                                | 2017.140.3045.24 | 360520    | 19-Oct-18 | 06:15 | x64      |
| Sqlresld.dll                                                | 2017.140.3045.24 | 30792     | 19-Oct-18 | 05:57 | x64      |
| Sqlresld.dll                                                | 2017.140.3045.24 | 28744     | 19-Oct-18 | 06:02 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3045.24 | 29256     | 19-Oct-18 | 05:56 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3045.24 | 32328     | 19-Oct-18 | 06:02 | x64      |
| Sqlscm.dll                                                  | 2017.140.3045.24 | 71240     | 19-Oct-18 | 06:07 | x64      |
| Sqlscm.dll                                                  | 2017.140.3045.24 | 61208     | 19-Oct-18 | 06:13 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3045.24 | 134728    | 19-Oct-18 | 06:13 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3045.24 | 161864    | 19-Oct-18 | 06:15 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3045.24 | 184088    | 19-Oct-18 | 06:15 | x64      |
| Sqlwep140.dll                                               | 2017.140.3045.24 | 105544    | 19-Oct-18 | 06:02 | x64      |
| Ssdebugps.dll                                               | 2017.140.3045.24 | 33544     | 19-Oct-18 | 06:21 | x64      |
| Ssisoledb.dll                                               | 2017.140.3045.24 | 216328    | 19-Oct-18 | 06:07 | x64      |
| Ssradd.dll                                                  | 2017.140.3045.24 | 75528     | 19-Oct-18 | 06:07 | x64      |
| Ssravg.dll                                                  | 2017.140.3045.24 | 75848     | 19-Oct-18 | 06:07 | x64      |
| Ssrdown.dll                                                 | 2017.140.3045.24 | 60696     | 19-Oct-18 | 06:15 | x64      |
| Ssrmax.dll                                                  | 2017.140.3045.24 | 73480     | 19-Oct-18 | 06:07 | x64      |
| Ssrmin.dll                                                  | 2017.140.3045.24 | 73992     | 19-Oct-18 | 06:15 | x64      |
| Ssrpub.dll                                                  | 2017.140.3045.24 | 61704     | 19-Oct-18 | 06:15 | x64      |
| Ssrup.dll                                                   | 2017.140.3045.24 | 60680     | 19-Oct-18 | 06:15 | x64      |
| Txagg.dll                                                   | 2017.140.3045.24 | 362248    | 19-Oct-18 | 06:15 | x64      |
| Txbdd.dll                                                   | 2017.140.3045.24 | 170248    | 19-Oct-18 | 06:15 | x64      |
| Txdatacollector.dll                                         | 2017.140.3045.24 | 360720    | 19-Oct-18 | 06:15 | x64      |
| Txdataconvert.dll                                           | 2017.140.3045.24 | 293144    | 19-Oct-18 | 06:15 | x64      |
| Txderived.dll                                               | 2017.140.3045.24 | 604432    | 19-Oct-18 | 06:15 | x64      |
| Txlookup.dll                                                | 2017.140.3045.24 | 528152    | 19-Oct-18 | 06:15 | x64      |
| Txmerge.dll                                                 | 2017.140.3045.24 | 230472    | 19-Oct-18 | 06:15 | x64      |
| Txmergejoin.dll                                             | 2017.140.3045.24 | 275528    | 19-Oct-18 | 06:15 | x64      |
| Txmulticast.dll                                             | 2017.140.3045.24 | 127560    | 19-Oct-18 | 06:15 | x64      |
| Txrowcount.dll                                              | 2017.140.3045.24 | 125512    | 19-Oct-18 | 06:15 | x64      |
| Txsort.dll                                                  | 2017.140.3045.24 | 257096    | 19-Oct-18 | 06:15 | x64      |
| Txsplit.dll                                                 | 2017.140.3045.24 | 596744    | 19-Oct-18 | 06:15 | x64      |
| Txunionall.dll                                              | 2017.140.3045.24 | 181832    | 19-Oct-18 | 06:15 | x64      |
| Xe.dll                                                      | 2017.140.3045.24 | 673352    | 19-Oct-18 | 06:06 | x64      |
| Xmlrw.dll                                                   | 2017.140.3045.24 | 305416    | 19-Oct-18 | 06:07 | x64      |
| Xmlsub.dll                                                  | 2017.140.3045.24 | 261384    | 19-Oct-18 | 06:15 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3045.24 | 1124616   | 19-Oct-18 | 06:49 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlsatellite.dll              | 2017.140.3045.24 | 922184    | 19-Oct-18 | 06:43 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3045.24 | 667400    | 19-Oct-18 | 06:07 | x64      |
| Fdhost.exe               | 2017.140.3045.24 | 114960    | 19-Oct-18 | 06:31 | x64      |
| Fdlauncher.exe           | 2017.140.3045.24 | 62736     | 19-Oct-18 | 06:15 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlft140ph.dll           | 2017.140.3045.24 | 68400     | 19-Oct-18 | 06:15 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3045.24     | 23624     | 19-Oct-18 | 06:07 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 21-Apr-18 | 00:28 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 21-Apr-18 | 00:28 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 21-Apr-18 | 00:28 | x86      |
| Commanddest.dll                                               | 2017.140.3045.24 | 201008    | 19-Oct-18 | 06:13 | x86      |
| Commanddest.dll                                               | 2017.140.3045.24 | 246024    | 19-Oct-18 | 06:15 | x64      |
| Dteparse.dll                                                  | 2017.140.3045.24 | 100624    | 19-Oct-18 | 06:13 | x86      |
| Dteparse.dll                                                  | 2017.140.3045.24 | 111384    | 19-Oct-18 | 06:15 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3045.24 | 89352     | 19-Oct-18 | 06:07 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3045.24 | 83736     | 19-Oct-18 | 06:13 | x86      |
| Dtepkg.dll                                                    | 2017.140.3045.24 | 138000    | 19-Oct-18 | 06:15 | x64      |
| Dtepkg.dll                                                    | 2017.140.3045.24 | 117008    | 19-Oct-18 | 06:20 | x86      |
| Dtexec.exe                                                    | 2017.140.3045.24 | 73992     | 19-Oct-18 | 06:21 | x64      |
| Dtexec.exe                                                    | 2017.140.3045.24 | 67848     | 19-Oct-18 | 06:31 | x86      |
| Dts.dll                                                       | 2017.140.3045.24 | 2549512   | 19-Oct-18 | 06:20 | x86      |
| Dts.dll                                                       | 2017.140.3045.24 | 2999064   | 19-Oct-18 | 06:21 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3045.24 | 418072    | 19-Oct-18 | 06:13 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3045.24 | 475400    | 19-Oct-18 | 06:15 | x64      |
| Dtsconn.dll                                                   | 2017.140.3045.24 | 399640    | 19-Oct-18 | 06:13 | x86      |
| Dtsconn.dll                                                   | 2017.140.3045.24 | 497416    | 19-Oct-18 | 06:15 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3045.24 | 111176    | 19-Oct-18 | 06:15 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3045.24 | 95512     | 19-Oct-18 | 06:20 | x86      |
| Dtshost.exe                                                   | 2017.140.3045.24 | 89880     | 19-Oct-18 | 06:13 | x86      |
| Dtshost.exe                                                   | 2017.140.3045.24 | 104712    | 19-Oct-18 | 06:15 | x64      |
| Dtslog.dll                                                    | 2017.140.3045.24 | 103192    | 19-Oct-18 | 06:13 | x86      |
| Dtslog.dll                                                    | 2017.140.3045.24 | 120600    | 19-Oct-18 | 06:15 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3045.24 | 545352    | 19-Oct-18 | 06:02 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3045.24 | 541488    | 19-Oct-18 | 06:06 | x86      |
| Dtspipeline.dll                                               | 2017.140.3045.24 | 1266440   | 19-Oct-18 | 06:21 | x64      |
| Dtspipeline.dll                                               | 2017.140.3045.24 | 1059400   | 19-Oct-18 | 06:31 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3045.24 | 42760     | 19-Oct-18 | 06:13 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3045.24 | 48408     | 19-Oct-18 | 06:15 | x64      |
| Dtuparse.dll                                                  | 2017.140.3045.24 | 80144     | 19-Oct-18 | 06:13 | x86      |
| Dtuparse.dll                                                  | 2017.140.3045.24 | 89368     | 19-Oct-18 | 06:15 | x64      |
| Dtutil.exe                                                    | 2017.140.3045.24 | 126232    | 19-Oct-18 | 06:13 | x86      |
| Dtutil.exe                                                    | 2017.140.3045.24 | 147224    | 19-Oct-18 | 06:15 | x64      |
| Exceldest.dll                                                 | 2017.140.3045.24 | 214808    | 19-Oct-18 | 06:13 | x86      |
| Exceldest.dll                                                 | 2017.140.3045.24 | 260680    | 19-Oct-18 | 06:15 | x64      |
| Excelsrc.dll                                                  | 2017.140.3045.24 | 230680    | 19-Oct-18 | 06:13 | x86      |
| Excelsrc.dll                                                  | 2017.140.3045.24 | 282888    | 19-Oct-18 | 06:15 | x64      |
| Execpackagetask.dll                                           | 2017.140.3045.24 | 135448    | 19-Oct-18 | 06:13 | x86      |
| Execpackagetask.dll                                           | 2017.140.3045.24 | 168008    | 19-Oct-18 | 06:15 | x64      |
| Flatfiledest.dll                                              | 2017.140.3045.24 | 333080    | 19-Oct-18 | 06:13 | x86      |
| Flatfiledest.dll                                              | 2017.140.3045.24 | 386832    | 19-Oct-18 | 06:15 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3045.24 | 344344    | 19-Oct-18 | 06:13 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3045.24 | 399112    | 19-Oct-18 | 06:15 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3045.24 | 80656     | 19-Oct-18 | 06:13 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3045.24 | 96520     | 19-Oct-18 | 06:15 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3045.24     | 467016    | 19-Oct-18 | 07:00 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3045.24     | 466696    | 19-Oct-18 | 07:00 | x64      |
| Isserverexec.exe                                              | 14.0.3045.24     | 149264    | 19-Oct-18 | 06:20 | x86      |
| Isserverexec.exe                                              | 14.0.3045.24     | 148552    | 19-Oct-18 | 06:38 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.230.1       | 1381440   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.230.1       | 1381448   | 26-Sep-18 | 18:56 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 27-Jul-18 | 23:51 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 21-Apr-18 | 00:24 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3045.24     | 72776     | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3045.24 | 112200    | 19-Oct-18 | 06:07 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3045.24 | 107080    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3045.24     | 89872     | 19-Oct-18 | 06:20 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3045.24     | 89672     | 19-Oct-18 | 06:38 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3045.24     | 494664    | 19-Oct-18 | 06:07 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3045.24     | 494872    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3045.24     | 83736     | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3045.24     | 83736     | 19-Oct-18 | 06:15 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3045.24     | 415816    | 19-Oct-18 | 06:49 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3045.24     | 415816    | 19-Oct-18 | 07:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3045.24     | 613960    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3045.24     | 613960    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3045.24     | 252696    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3045.24     | 252680    | 19-Oct-18 | 06:15 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3045.24 | 152336    | 19-Oct-18 | 06:13 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3045.24 | 141896    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3045.24 | 159496    | 19-Oct-18 | 06:06 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3045.24 | 145480    | 19-Oct-18 | 06:13 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3045.24     | 219928    | 19-Oct-18 | 06:21 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3045.24 | 90392     | 19-Oct-18 | 06:13 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3045.24 | 103496    | 19-Oct-18 | 06:15 | x64      |
| Msmdpp.dll                                                    | 2017.140.230.1   | 9194272   | 26-Sep-18 | 18:56 | x64      |
| Oledbdest.dll                                                 | 2017.140.3045.24 | 214808    | 19-Oct-18 | 06:13 | x86      |
| Oledbdest.dll                                                 | 2017.140.3045.24 | 261192    | 19-Oct-18 | 06:15 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3045.24 | 233240    | 19-Oct-18 | 06:13 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3045.24 | 289040    | 19-Oct-18 | 06:21 | x64      |
| Rawdest.dll                                                   | 2017.140.3045.24 | 166680    | 19-Oct-18 | 06:13 | x86      |
| Rawdest.dll                                                   | 2017.140.3045.24 | 206600    | 19-Oct-18 | 06:15 | x64      |
| Rawsource.dll                                                 | 2017.140.3045.24 | 153368    | 19-Oct-18 | 06:13 | x86      |
| Rawsource.dll                                                 | 2017.140.3045.24 | 194120    | 19-Oct-18 | 06:15 | x64      |
| Recordsetdest.dll                                             | 2017.140.3045.24 | 149272    | 19-Oct-18 | 06:13 | x86      |
| Recordsetdest.dll                                             | 2017.140.3045.24 | 184392    | 19-Oct-18 | 06:15 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlceip.exe                                                   | 14.0.3045.24     | 255560    | 19-Oct-18 | 06:21 | x86      |
| Sqldest.dll                                                   | 2017.140.3045.24 | 213784    | 19-Oct-18 | 06:13 | x86      |
| Sqldest.dll                                                   | 2017.140.3045.24 | 260888    | 19-Oct-18 | 06:15 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3045.24 | 155416    | 19-Oct-18 | 06:13 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3045.24 | 184088    | 19-Oct-18 | 06:15 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3045.24 | 216328    | 19-Oct-18 | 06:07 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3045.24 | 176920    | 19-Oct-18 | 06:13 | x86      |
| Txagg.dll                                                     | 2017.140.3045.24 | 302360    | 19-Oct-18 | 06:13 | x86      |
| Txagg.dll                                                     | 2017.140.3045.24 | 362248    | 19-Oct-18 | 06:15 | x64      |
| Txbdd.dll                                                     | 2017.140.3045.24 | 139552    | 19-Oct-18 | 06:13 | x86      |
| Txbdd.dll                                                     | 2017.140.3045.24 | 170248    | 19-Oct-18 | 06:15 | x64      |
| Txbestmatch.dll                                               | 2017.140.3045.24 | 493336    | 19-Oct-18 | 06:13 | x86      |
| Txbestmatch.dll                                               | 2017.140.3045.24 | 605472    | 19-Oct-18 | 06:15 | x64      |
| Txcache.dll                                                   | 2017.140.3045.24 | 146192    | 19-Oct-18 | 06:13 | x86      |
| Txcache.dll                                                   | 2017.140.3045.24 | 180488    | 19-Oct-18 | 06:15 | x64      |
| Txcharmap.dll                                                 | 2017.140.3045.24 | 249112    | 19-Oct-18 | 06:13 | x86      |
| Txcharmap.dll                                                 | 2017.140.3045.24 | 286984    | 19-Oct-18 | 06:15 | x64      |
| Txcopymap.dll                                                 | 2017.140.3045.24 | 145680    | 19-Oct-18 | 06:13 | x86      |
| Txcopymap.dll                                                 | 2017.140.3045.24 | 180296    | 19-Oct-18 | 06:15 | x64      |
| Txdataconvert.dll                                             | 2017.140.3045.24 | 253200    | 19-Oct-18 | 06:13 | x86      |
| Txdataconvert.dll                                             | 2017.140.3045.24 | 293144    | 19-Oct-18 | 06:15 | x64      |
| Txderived.dll                                                 | 2017.140.3045.24 | 515888    | 19-Oct-18 | 06:13 | x86      |
| Txderived.dll                                                 | 2017.140.3045.24 | 604432    | 19-Oct-18 | 06:15 | x64      |
| Txfileextractor.dll                                           | 2017.140.3045.24 | 161048    | 19-Oct-18 | 06:13 | x86      |
| Txfileextractor.dll                                           | 2017.140.3045.24 | 198928    | 19-Oct-18 | 06:15 | x64      |
| Txfileinserter.dll                                            | 2017.140.3045.24 | 159512    | 19-Oct-18 | 06:13 | x86      |
| Txfileinserter.dll                                            | 2017.140.3045.24 | 196680    | 19-Oct-18 | 06:15 | x64      |
| Txgroupdups.dll                                               | 2017.140.3045.24 | 231192    | 19-Oct-18 | 06:13 | x86      |
| Txgroupdups.dll                                               | 2017.140.3045.24 | 290568    | 19-Oct-18 | 06:15 | x64      |
| Txlineage.dll                                                 | 2017.140.3045.24 | 110384    | 19-Oct-18 | 06:13 | x86      |
| Txlineage.dll                                                 | 2017.140.3045.24 | 136776    | 19-Oct-18 | 06:15 | x64      |
| Txlookup.dll                                                  | 2017.140.3045.24 | 446752    | 19-Oct-18 | 06:13 | x86      |
| Txlookup.dll                                                  | 2017.140.3045.24 | 528152    | 19-Oct-18 | 06:15 | x64      |
| Txmerge.dll                                                   | 2017.140.3045.24 | 177456    | 19-Oct-18 | 06:13 | x86      |
| Txmerge.dll                                                   | 2017.140.3045.24 | 230472    | 19-Oct-18 | 06:15 | x64      |
| Txmergejoin.dll                                               | 2017.140.3045.24 | 221968    | 19-Oct-18 | 06:13 | x86      |
| Txmergejoin.dll                                               | 2017.140.3045.24 | 275528    | 19-Oct-18 | 06:15 | x64      |
| Txmulticast.dll                                               | 2017.140.3045.24 | 102672    | 19-Oct-18 | 06:13 | x86      |
| Txmulticast.dll                                               | 2017.140.3045.24 | 127560    | 19-Oct-18 | 06:15 | x64      |
| Txpivot.dll                                                   | 2017.140.3045.24 | 180512    | 19-Oct-18 | 06:13 | x86      |
| Txpivot.dll                                                   | 2017.140.3045.24 | 224840    | 19-Oct-18 | 06:15 | x64      |
| Txrowcount.dll                                                | 2017.140.3045.24 | 101656    | 19-Oct-18 | 06:13 | x86      |
| Txrowcount.dll                                                | 2017.140.3045.24 | 125512    | 19-Oct-18 | 06:15 | x64      |
| Txsampling.dll                                                | 2017.140.3045.24 | 135952    | 19-Oct-18 | 06:13 | x86      |
| Txsampling.dll                                                | 2017.140.3045.24 | 174152    | 19-Oct-18 | 06:15 | x64      |
| Txscd.dll                                                     | 2017.140.3045.24 | 170264    | 19-Oct-18 | 06:13 | x86      |
| Txscd.dll                                                     | 2017.140.3045.24 | 220936    | 19-Oct-18 | 06:15 | x64      |
| Txsort.dll                                                    | 2017.140.3045.24 | 208672    | 19-Oct-18 | 06:13 | x86      |
| Txsort.dll                                                    | 2017.140.3045.24 | 257096    | 19-Oct-18 | 06:15 | x64      |
| Txsplit.dll                                                   | 2017.140.3045.24 | 596744    | 19-Oct-18 | 06:15 | x64      |
| Txsplit.dll                                                   | 2017.140.3045.24 | 510768    | 19-Oct-18 | 06:21 | x86      |
| Txtermextraction.dll                                          | 2017.140.3045.24 | 8676424   | 19-Oct-18 | 06:15 | x64      |
| Txtermextraction.dll                                          | 2017.140.3045.24 | 8615192   | 19-Oct-18 | 06:21 | x86      |
| Txtermlookup.dll                                              | 2017.140.3045.24 | 4107024   | 19-Oct-18 | 06:13 | x86      |
| Txtermlookup.dll                                              | 2017.140.3045.24 | 4157232   | 19-Oct-18 | 06:15 | x64      |
| Txunionall.dll                                                | 2017.140.3045.24 | 140056    | 19-Oct-18 | 06:13 | x86      |
| Txunionall.dll                                                | 2017.140.3045.24 | 181832    | 19-Oct-18 | 06:15 | x64      |
| Txunpivot.dll                                                 | 2017.140.3045.24 | 160536    | 19-Oct-18 | 06:13 | x86      |
| Txunpivot.dll                                                 | 2017.140.3045.24 | 199752    | 19-Oct-18 | 06:15 | x64      |
| Xe.dll                                                        | 2017.140.3045.24 | 673352    | 19-Oct-18 | 06:06 | x64      |
| Xe.dll                                                        | 2017.140.3045.24 | 595736    | 19-Oct-18 | 06:06 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 21-Apr-18 | 00:47 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 21-Apr-18 | 00:47 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 21-Apr-18 | 00:47 | x86      |
| Instapi140.dll                                                       | 2017.140.3045.24 | 70936     | 19-Oct-18 | 06:07 | x64      |
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
| Mpdwinterop.dll                                                      | 2017.140.3045.24 | 407312    | 19-Oct-18 | 06:21 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3045.24 | 7325768   | 19-Oct-18 | 06:37 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3045.24 | 2263112   | 19-Oct-18 | 06:02 | x64      |
| Secforwarder.dll                                                     | 2017.140.3045.24 | 37656     | 19-Oct-18 | 06:20 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 21-Apr-18 | 00:19 | x64      |
| Sqldk.dll                                                            | 2017.140.3045.24 | 2730248   | 19-Oct-18 | 06:43 | x64      |
| Sqldumper.exe                                                        | 2017.140.3045.24 | 141384    | 19-Oct-18 | 06:13 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 1498184   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3915536   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3214608   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3918088   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3821848   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 2090264   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 2037016   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3589400   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3597592   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 1445640   | 19-Oct-18 | 06:06 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3045.24 | 3785992   | 19-Oct-18 | 06:06 | x64      |
| Sqlos.dll                                                            | 2017.140.3045.24 | 26376     | 19-Oct-18 | 06:20 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 21-Apr-18 | 00:47 | x64      |
| Sqltses.dll                                                          | 2017.140.3045.24 | 9734920   | 19-Oct-18 | 06:43 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3045.24     | 23824     | 19-Oct-18 | 06:07 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3045.24 | 1448520   | 19-Oct-18 | 06:30 | x86      |
| Dtaengine.exe                                          | 2017.140.3045.24 | 204560    | 19-Oct-18 | 06:30 | x86      |
| Dteparse.dll                                           | 2017.140.3045.24 | 100624    | 19-Oct-18 | 06:13 | x86      |
| Dteparse.dll                                           | 2017.140.3045.24 | 111384    | 19-Oct-18 | 06:15 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3045.24 | 89352     | 19-Oct-18 | 06:07 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3045.24 | 83736     | 19-Oct-18 | 06:13 | x86      |
| Dtepkg.dll                                             | 2017.140.3045.24 | 138000    | 19-Oct-18 | 06:15 | x64      |
| Dtepkg.dll                                             | 2017.140.3045.24 | 117008    | 19-Oct-18 | 06:20 | x86      |
| Dtexec.exe                                             | 2017.140.3045.24 | 73992     | 19-Oct-18 | 06:21 | x64      |
| Dtexec.exe                                             | 2017.140.3045.24 | 67848     | 19-Oct-18 | 06:31 | x86      |
| Dts.dll                                                | 2017.140.3045.24 | 2549512   | 19-Oct-18 | 06:20 | x86      |
| Dts.dll                                                | 2017.140.3045.24 | 2999064   | 19-Oct-18 | 06:21 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3045.24 | 418072    | 19-Oct-18 | 06:13 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3045.24 | 475400    | 19-Oct-18 | 06:15 | x64      |
| Dtsconn.dll                                            | 2017.140.3045.24 | 399640    | 19-Oct-18 | 06:13 | x86      |
| Dtsconn.dll                                            | 2017.140.3045.24 | 497416    | 19-Oct-18 | 06:15 | x64      |
| Dtshost.exe                                            | 2017.140.3045.24 | 89880     | 19-Oct-18 | 06:13 | x86      |
| Dtshost.exe                                            | 2017.140.3045.24 | 104712    | 19-Oct-18 | 06:15 | x64      |
| Dtslog.dll                                             | 2017.140.3045.24 | 103192    | 19-Oct-18 | 06:13 | x86      |
| Dtslog.dll                                             | 2017.140.3045.24 | 120600    | 19-Oct-18 | 06:15 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3045.24 | 545352    | 19-Oct-18 | 06:02 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3045.24 | 541488    | 19-Oct-18 | 06:06 | x86      |
| Dtspipeline.dll                                        | 2017.140.3045.24 | 1266440   | 19-Oct-18 | 06:21 | x64      |
| Dtspipeline.dll                                        | 2017.140.3045.24 | 1059400   | 19-Oct-18 | 06:31 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3045.24 | 42760     | 19-Oct-18 | 06:13 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3045.24 | 48408     | 19-Oct-18 | 06:15 | x64      |
| Dtuparse.dll                                           | 2017.140.3045.24 | 80144     | 19-Oct-18 | 06:13 | x86      |
| Dtuparse.dll                                           | 2017.140.3045.24 | 89368     | 19-Oct-18 | 06:15 | x64      |
| Dtutil.exe                                             | 2017.140.3045.24 | 126232    | 19-Oct-18 | 06:13 | x86      |
| Dtutil.exe                                             | 2017.140.3045.24 | 147224    | 19-Oct-18 | 06:15 | x64      |
| Exceldest.dll                                          | 2017.140.3045.24 | 214808    | 19-Oct-18 | 06:13 | x86      |
| Exceldest.dll                                          | 2017.140.3045.24 | 260680    | 19-Oct-18 | 06:15 | x64      |
| Excelsrc.dll                                           | 2017.140.3045.24 | 230680    | 19-Oct-18 | 06:13 | x86      |
| Excelsrc.dll                                           | 2017.140.3045.24 | 282888    | 19-Oct-18 | 06:15 | x64      |
| Flatfiledest.dll                                       | 2017.140.3045.24 | 333080    | 19-Oct-18 | 06:13 | x86      |
| Flatfiledest.dll                                       | 2017.140.3045.24 | 386832    | 19-Oct-18 | 06:15 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3045.24 | 344344    | 19-Oct-18 | 06:13 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3045.24 | 399112    | 19-Oct-18 | 06:15 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3045.24 | 80656     | 19-Oct-18 | 06:13 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3045.24 | 96520     | 19-Oct-18 | 06:15 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3045.24     | 72968     | 19-Oct-18 | 06:20 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3045.24     | 186632    | 19-Oct-18 | 07:05 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3045.24     | 406792    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3045.24     | 406808    | 19-Oct-18 | 06:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3045.24     | 2093336   | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3045.24     | 2093328   | 19-Oct-18 | 06:15 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3045.24     | 613960    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3045.24     | 613960    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3045.24     | 252696    | 19-Oct-18 | 06:13 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3045.24 | 152336    | 19-Oct-18 | 06:13 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3045.24 | 141896    | 19-Oct-18 | 06:21 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3045.24 | 159496    | 19-Oct-18 | 06:06 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3045.24 | 145480    | 19-Oct-18 | 06:13 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3045.24 | 90392     | 19-Oct-18 | 06:13 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3045.24 | 103496    | 19-Oct-18 | 06:15 | x64      |
| Msmgdsrv.dll                                           | 2017.140.230.1   | 7310600   | 26-Sep-18 | 18:56 | x86      |
| Oledbdest.dll                                          | 2017.140.3045.24 | 214808    | 19-Oct-18 | 06:13 | x86      |
| Oledbdest.dll                                          | 2017.140.3045.24 | 261192    | 19-Oct-18 | 06:15 | x64      |
| Oledbsrc.dll                                           | 2017.140.3045.24 | 233240    | 19-Oct-18 | 06:13 | x86      |
| Oledbsrc.dll                                           | 2017.140.3045.24 | 289040    | 19-Oct-18 | 06:21 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3045.24 | 100632    | 19-Oct-18 | 06:07 | x64      |
| Sqlresld.dll                                           | 2017.140.3045.24 | 30792     | 19-Oct-18 | 05:57 | x64      |
| Sqlresld.dll                                           | 2017.140.3045.24 | 28744     | 19-Oct-18 | 06:02 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3045.24 | 29256     | 19-Oct-18 | 05:56 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3045.24 | 32328     | 19-Oct-18 | 06:02 | x64      |
| Sqlscm.dll                                             | 2017.140.3045.24 | 71240     | 19-Oct-18 | 06:07 | x64      |
| Sqlscm.dll                                             | 2017.140.3045.24 | 61208     | 19-Oct-18 | 06:13 | x86      |
| Sqlsvc.dll                                             | 2017.140.3045.24 | 134728    | 19-Oct-18 | 06:13 | x86      |
| Sqlsvc.dll                                             | 2017.140.3045.24 | 161864    | 19-Oct-18 | 06:15 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3045.24 | 155416    | 19-Oct-18 | 06:13 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3045.24 | 184088    | 19-Oct-18 | 06:15 | x64      |
| Txdataconvert.dll                                      | 2017.140.3045.24 | 253200    | 19-Oct-18 | 06:13 | x86      |
| Txdataconvert.dll                                      | 2017.140.3045.24 | 293144    | 19-Oct-18 | 06:15 | x64      |
| Xe.dll                                                 | 2017.140.3045.24 | 673352    | 19-Oct-18 | 06:06 | x64      |
| Xe.dll                                                 | 2017.140.3045.24 | 595736    | 19-Oct-18 | 06:06 | x86      |
| Xmlrw.dll                                              | 2017.140.3045.24 | 305416    | 19-Oct-18 | 06:07 | x64      |
| Xmlrw.dll                                              | 2017.140.3045.24 | 257816    | 19-Oct-18 | 06:13 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3045.24 | 224536    | 19-Oct-18 | 06:02 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3045.24 | 189512    | 19-Oct-18 | 06:06 | x86      |

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
