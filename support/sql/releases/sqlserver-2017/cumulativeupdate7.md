---
title: Cumulative update 7 for SQL Server 2017 (KB4229789)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 7 (KB4229789).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4229789, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4229789 - Cumulative Update 7 for SQL Server 2017

_Release Date:_ &nbsp; May 23, 2018  
_Version:_ &nbsp; 14.0.3026.27

## Summary

This article describes Cumulative Update package 7 (CU7) for Microsoft SQL Server 2017. This update contains 28 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 6, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3026.27**, file version: **2017.140.3026.27**
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
| <a id="11642085">[11642085](#11642085)</a> | [FIX: A calculation error occurs when a secured measure is queried in SSAS 2017 (KB4098732)](https://support.microsoft.com/help/4098732) | Analysis Services | Analysis Services | Windows |
| <a id="11701140">[11701140](#11701140)</a> | [FIX: Access violation occurs when executing a DAX query on a tabular model in SQL Server Analysis Services (KB4086173)](https://support.microsoft.com/help/4086173) | Analysis Services | Analysis Services | Windows |
| <a id="11701171">[11701171](#11701171)</a> | [FIX: Totals are wrong after you filter on a pivot table item and remove the filter in SSAS (KB2932559)](https://support.microsoft.com/help/2932559) | Analysis Services | Analysis Services | Windows |
| <a id="11701179">[11701179](#11701179)</a> | [FIX: "DirectQuery may not be used with this data source" error when you browse a Direct Query model in SQL Server (KB4093226)](https://support.microsoft.com/help/4093226) | Analysis Services | Analysis Services | Windows |
| <a id="11701193">[11701193](#11701193)</a> | [FIX: Unexpected error when you create a subcube in SQL Server 2016 and 2017 Analysis Services (Multidimensional model) (KB4074862)](https://support.microsoft.com/help/4074862) | Analysis Services | Analysis Services | Windows |
| <a id="11701194">[11701194](#11701194)</a> | [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2016 and 2017 Multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032) | Analysis Services | Analysis Services | Windows |
| <a id="11701196">[11701196](#11701196)</a> | [FIX: SSAS may crash when you run a DAX query by using a non-admin Windows user in SQL Server 2016 and 2017 (KB4083949)](https://support.microsoft.com/help/4083949) | Analysis Services | Analysis Services | Windows |
| <a id="11701201">[11701201](#11701201)</a> | [FIX: SSAS stops responding when you run an MDX query in SQL Server 2016 and 2017 Analysis Services (Multidimensional model) (KB4086136)](https://support.microsoft.com/help/4086136) | Analysis Services | Analysis Services | Windows |
| <a id="11701208">[11701208](#11701208)</a> | [FIX: Out of memory occurs and query fails when you run MDX query with NON EMPTY option in SSAS (KB4089623)](https://support.microsoft.com/help/4089623) | Analysis Services | Analysis Services | Windows |
| <a id="11751257">[11751257](#11751257)</a> | [FIX: An unexpected exception occurs and SSAS crashes when you run a particular DAX function in SQL Server 2017 (KB4096258)](https://support.microsoft.com/help/4096258) | Analysis Services | Analysis Services | Windows |
| <a id="11853504">[11853504](#11853504)</a> | [FIX: "Could not load file or assembly 'Microsoft.AnalysisServices.AdomdClientUI" error when a "Process Full" operation is run in SQL Server (KB4134601)](https://support.microsoft.com/help/4134601) | Analysis Services | Analysis Services | Windows |
| <a id="11578523">[11578523](#11578523)</a> | [Improvement: Performance issue when upgrading MDS from SQL Server 2012 to 2016 (KB4089718)](https://support.microsoft.com/help/4089718) | Master Data Services | Server | Windows |
| <a id="11870176">[11870176](#11870176)</a> | [Multiple device VDI backup can hang on Linux (KB4136912)](https://support.microsoft.com/help/4136912) | SQL Server Engine | Backup Restore | Linux |
| <a id="11923799">[11923799](#11923799)</a> | FIX: Restore of a TDE compressed backup is unsuccessful when using the VDI client (KB4230306) | SQL Server Engine | Backup Restore | All |
| <a id="11919582">[11919582](#11919582)</a> | [Improvement: Configure SESSION_TIMEOUT value for a Distributed Availability Group replica in SQL Server 2016 and 2017 (KB4090004)](https://support.microsoft.com/help/4090004) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11919583">[11919583](#11919583)</a> | [Transparent Data Encryption added for Log Shipping in SQL Server 2016 and 2017 (KB4099919)](https://support.microsoft.com/help/4099919) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11974640">[11974640](#11974640)</a> | [FIX: Pacemaker promotes local replica to primary may fail when you use AlwaysOn AG in SQL Server 2017 (KB4230542)](https://support.microsoft.com/help/4230542) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="11922305">[11922305](#11922305)</a> | [FIX: Floating point overflow error occurs when you execute a nested natively compiled module that uses EXP functions in SQL Server (KB4157948)](https://support.microsoft.com/help/4157948) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11974802">[11974802](#11974802)</a> | [FIX: "Non-yielding" error when you try to recover an In-Memory database in SQL Server (KB4293576)](https://support.microsoft.com/help/4293576) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11814297">[11814297](#11814297)</a> | [PFS page round robin algorithm improvement in SQL Server 2017 (KB4099472)](https://support.microsoft.com/help/4099472) | SQL Server Engine | Metadata | Windows |
| <a id="11971856">[11971856](#11971856)</a> | [FIX: A memory assertion failure occurs and the server is unable to make any new connections in SQL Server (KB4230516)](https://support.microsoft.com/help/4230516) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="11967438">[11967438](#11967438)</a> | FIX: A dead latch condition occurs when you perform an online index rebuild or execute a merge command in SQL Server (KB4230730) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="11951171">[11951171](#11951171)</a> | [FIX: An unexpected communication link error occurs when using datetime2 fields accessing a database in SQL Server 2017 (KB4230465)](https://support.microsoft.com/help/4230465) | SQL Server Engine | Programmability | All |
| <a id="11708399">[11708399](#11708399)</a> | FIX: `DROP_ASYMMETRIC_KEY` causes an instance of SQL Server to crash if it's rolled back from a trigger (KB4135045) | SQL Server Engine | Security Infrastructure | All |
| <a id="11953218">[11953218](#11953218)</a> | [FIX: SQL Server can't start when you run a SQL Server 2017 Linux container image on Docker for Windows (KB4212960)](https://support.microsoft.com/help/4212960) | SQL Server Engine | SQL OS | Linux |
| <a id="11823305">[11823305](#11823305)</a> | [FIX: TDE-enabled database backup with compression causes database corruption in SQL Server 2017 (KB4101502)](https://support.microsoft.com/help/4101502) | SQL Server Engine | Storage Management | All |
| <a id="11634330">[11634330](#11634330)</a> | [FIX: "Cannot use SAVE TRANSACTION within a distributed transaction" error when you execute a stored procedure in SQL Server (KB4092554)](https://support.microsoft.com/help/4092554) | SQL Server Engine | Transaction Services | Windows |
| <a id="11952929">[11952929](#11952929)</a> | [FIX: Performance is slow for an Always On AG when you process a read query in SQL Server (KB4163087)](https://support.microsoft.com/help/4163087) | SQL Server Engine | Transaction Services | All |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU7 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2018/05/sqlserver2017-kb4229789-x64_2851a9e2d5faadc45c7699f68a1382b8009608d8.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4229789-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4229789-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4229789-x64.exe| 8D533957A7B7167DB6A4B837556CCB8D1A3CE8DD290F05CA2D1D3C182B5AB12C |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.213.1   | 266400    | 24-Apr-18 | 21:54 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.213.1       | 741536    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.213.1       | 1380512   | 24-Apr-18 | 21:54 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.213.1       | 984224    | 24-Apr-18 | 21:54 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.213.1       | 521376    | 24-Apr-18 | 21:54 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787       | 239328    | 24-Apr-18 | 21:15 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201    | 174816    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201    | 36576     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201    | 48864     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201    | 105184    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201    | 5167328   | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201    | 26336     | 24-Apr-18 | 22:09 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201    | 26848     | 24-Apr-18 | 22:09 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201    | 26848     | 24-Apr-18 | 22:09 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201    | 159456    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201    | 82656     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201    | 67296     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201    | 25824     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151264    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201    | 13032160  | 24-Apr-18 | 22:09 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484       | 1044672   | 24-Apr-18 | 21:54 | x86      |
| Msmdctr.dll                                        | 2017.140.213.1   | 40096     | 24-Apr-18 | 21:54 | x64      |
| Msmdlocal.dll                                      | 2017.140.213.1   | 60711584  | 24-Apr-18 | 21:55 | x64      |
| Msmdlocal.dll                                      | 2017.140.213.1   | 40382624  | 24-Apr-18 | 22:08 | x86      |
| Msmdpump.dll                                       | 2017.140.213.1   | 9334432   | 24-Apr-18 | 21:55 | x64      |
| Msmdredir.dll                                      | 2017.140.213.1   | 7092384   | 24-Apr-18 | 22:07 | x86      |
| Msmdsrv.exe                                        | 2017.140.213.1   | 60613792  | 24-Apr-18 | 21:55 | x64      |
| Msmgdsrv.dll                                       | 2017.140.213.1   | 9004704   | 24-Apr-18 | 21:55 | x64      |
| Msmgdsrv.dll                                       | 2017.140.213.1   | 7310496   | 24-Apr-18 | 22:07 | x86      |
| Msolap.dll                                         | 2017.140.213.1   | 10258592  | 24-Apr-18 | 21:55 | x64      |
| Msolap.dll                                         | 2017.140.213.1   | 7777440   | 24-Apr-18 | 22:07 | x86      |
| Msolui.dll                                         | 2017.140.213.1   | 310944    | 24-Apr-18 | 21:54 | x64      |
| Msolui.dll                                         | 2017.140.213.1   | 287392    | 24-Apr-18 | 22:07 | x86      |
| Powerbiextensions.dll                              | 2.49.4831.201    | 5316832   | 24-Apr-18 | 22:09 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlboot.dll                                        | 2017.140.3026.27 | 196256    | 10-May-18 | 19:57 | x64      |
| Sqlceip.exe                                        | 14.0.3026.27     | 253096    | 11-May-18 | 00:06 | x86      |
| Sqldumper.exe                                      | 2017.140.3026.27 | 140968    | 10-May-18 | 19:57 | x64      |
| Sqldumper.exe                                      | 2017.140.3026.27 | 119464    | 10-May-18 | 19:58 | x86      |
| Tmapi.dll                                          | 2017.140.213.1   | 5822624   | 24-Apr-18 | 21:55 | x64      |
| Tmcachemgr.dll                                     | 2017.140.213.1   | 4164768   | 24-Apr-18 | 21:54 | x64      |
| Tmpersistence.dll                                  | 2017.140.213.1   | 1132192   | 24-Apr-18 | 21:54 | x64      |
| Tmtransactions.dll                                 | 2017.140.213.1   | 1640096   | 24-Apr-18 | 21:55 | x64      |
| Xe.dll                                             | 2017.140.3026.27 | 673440    | 10-May-18 | 19:57 | x64      |
| Xmlrw.dll                                          | 2017.140.3026.27 | 305320    | 10-May-18 | 19:57 | x64      |
| Xmlrw.dll                                          | 2017.140.3026.27 | 257704    | 10-May-18 | 22:27 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3026.27 | 224424    | 10-May-18 | 19:57 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3026.27 | 189608    | 10-May-18 | 22:20 | x86      |
| Xmsrv.dll                                          | 2017.140.213.1   | 25375392  | 24-Apr-18 | 21:55 | x64      |
| Xmsrv.dll                                          | 2017.140.213.1   | 33350304  | 24-Apr-18 | 22:07 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3026.27 | 180904    | 10-May-18 | 19:57 | x64      |
| Batchparser.dll                            | 2017.140.3026.27 | 160424    | 10-May-18 | 19:58 | x86      |
| Instapi140.dll                             | 2017.140.3026.27 | 70312     | 10-May-18 | 19:57 | x64      |
| Instapi140.dll                             | 2017.140.3026.27 | 61088     | 10-May-18 | 19:58 | x86      |
| Isacctchange.dll                           | 2017.140.3026.27 | 30888     | 10-May-18 | 20:50 | x64      |
| Isacctchange.dll                           | 2017.140.3026.27 | 29352     | 10-May-18 | 23:52 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.213.1       | 1088672   | 24-Apr-18 | 21:54 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.213.1       | 1088672   | 24-Apr-18 | 22:07 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.213.1       | 1381536   | 24-Apr-18 | 22:07 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.213.1       | 741536    | 24-Apr-18 | 21:54 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.213.1       | 741536    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3026.27     | 37024     | 10-May-18 | 19:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3026.27 | 82080     | 10-May-18 | 19:57 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3026.27 | 78504     | 10-May-18 | 19:58 | x86      |
| Msasxpress.dll                             | 2017.140.213.1   | 36000     | 24-Apr-18 | 21:54 | x64      |
| Msasxpress.dll                             | 2017.140.213.1   | 31904     | 24-Apr-18 | 22:07 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3026.27 | 82088     | 10-May-18 | 19:57 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3026.27 | 67752     | 10-May-18 | 23:52 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqldumper.exe                              | 2017.140.3026.27 | 140968    | 10-May-18 | 19:57 | x64      |
| Sqldumper.exe                              | 2017.140.3026.27 | 119464    | 10-May-18 | 19:58 | x86      |
| Sqlftacct.dll                              | 2017.140.3026.27 | 54440     | 10-May-18 | 20:10 | x86      |
| Sqlftacct.dll                              | 2017.140.3026.27 | 62112     | 10-May-18 | 20:28 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 24-Apr-18 | 22:07 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 24-Apr-18 | 22:12 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3026.27 | 372392    | 10-May-18 | 20:20 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3026.27 | 415912    | 10-May-18 | 20:28 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3026.27 | 37544     | 10-May-18 | 19:57 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3026.27 | 34976     | 10-May-18 | 20:20 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3026.27 | 356000    | 10-May-18 | 20:43 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3026.27 | 273064    | 10-May-18 | 23:43 | x86      |
| Sqltdiagn.dll                              | 2017.140.3026.27 | 67752     | 10-May-18 | 19:57 | x64      |
| Sqltdiagn.dll                              | 2017.140.3026.27 | 60584     | 10-May-18 | 19:58 | x86      |
| Svrenumapi140.dll                          | 2017.140.3026.27 | 1173152   | 10-May-18 | 19:57 | x64      |
| Svrenumapi140.dll                          | 2017.140.3026.27 | 893600    | 10-May-18 | 19:58 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3026.27 | 120992    | 10-May-18 | 20:43 | x86      |
| Dreplaycommon.dll              | 2017.140.3026.27 | 698024    | 10-May-18 | 19:58 | x86      |
| Dreplayserverps.dll            | 2017.140.3026.27 | 32936     | 10-May-18 | 19:58 | x86      |
| Dreplayutil.dll                | 2017.140.3026.27 | 309920    | 10-May-18 | 20:10 | x86      |
| Instapi140.dll                 | 2017.140.3026.27 | 70312     | 10-May-18 | 19:57 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlresourceloader.dll          | 2017.140.3026.27 | 29344     | 10-May-18 | 19:58 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3026.27 | 698024    | 10-May-18 | 19:58 | x86      |
| Dreplaycontroller.exe              | 2017.140.3026.27 | 350376    | 10-May-18 | 20:50 | x86      |
| Dreplayprocess.dll                 | 2017.140.3026.27 | 171680    | 10-May-18 | 20:10 | x86      |
| Dreplayserverps.dll                | 2017.140.3026.27 | 32936     | 10-May-18 | 19:58 | x86      |
| Instapi140.dll                     | 2017.140.3026.27 | 70312     | 10-May-18 | 19:57 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlresourceloader.dll              | 2017.140.3026.27 | 29344     | 10-May-18 | 19:58 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3026.27 | 180904    | 10-May-18 | 19:57 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 24-Apr-18 | 20:35 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 24-Apr-18 | 20:35 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 24-Apr-18 | 20:35 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 24-Apr-18 | 22:11 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3026.27 | 225952    | 10-May-18 | 20:19 | x64      |
| Dcexec.exe                                   | 2017.140.3026.27 | 74408     | 10-May-18 | 20:19 | x64      |
| Fssres.dll                                   | 2017.140.3026.27 | 89256     | 10-May-18 | 20:28 | x64      |
| Hadrres.dll                                  | 2017.140.3026.27 | 187560    | 10-May-18 | 20:43 | x64      |
| Hkcompile.dll                                | 2017.140.3026.27 | 1423008   | 10-May-18 | 19:57 | x64      |
| Hkengine.dll                                 | 2017.140.3026.27 | 5858984   | 10-May-18 | 20:04 | x64      |
| Hkruntime.dll                                | 2017.140.3026.27 | 161960    | 10-May-18 | 20:19 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 24-Apr-18 | 20:35 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.213.1       | 741024    | 24-Apr-18 | 21:54 | x86      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787       | 239328    | 24-Apr-18 | 21:15 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3026.27     | 237224    | 11-May-18 | 00:22 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3026.27     | 79520     | 11-May-18 | 00:15 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3026.27 | 71336     | 10-May-18 | 19:57 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3026.27 | 65192     | 10-May-18 | 23:43 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3026.27 | 152232    | 11-May-18 | 00:06 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3026.27 | 159400    | 10-May-18 | 23:51 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3026.27 | 304296    | 10-May-18 | 23:59 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3026.27 | 74920     | 11-May-18 | 00:15 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 24-Apr-18 | 20:35 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 24-Apr-18 | 20:35 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 24-Apr-18 | 20:35 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 24-Apr-18 | 20:35 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 24-Apr-18 | 20:35 | x64      |
| Odsole70.dll                                 | 2017.140.3026.27 | 92832     | 10-May-18 | 20:19 | x64      |
| Opends60.dll                                 | 2017.140.3026.27 | 32928     | 10-May-18 | 19:57 | x64      |
| Qds.dll                                      | 2017.140.3026.27 | 1168040   | 11-May-18 | 01:43 | x64      |
| Rsfxft.dll                                   | 2017.140.3026.27 | 34464     | 10-May-18 | 20:27 | x64      |
| Secforwarder.dll                             | 2017.140.3026.27 | 37536     | 10-May-18 | 19:57 | x64      |
| Sqagtres.dll                                 | 2017.140.3026.27 | 74408     | 10-May-18 | 20:04 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlaamss.dll                                 | 2017.140.3026.27 | 90280     | 11-May-18 | 00:22 | x64      |
| Sqlaccess.dll                                | 2017.140.3026.27 | 474784    | 10-May-18 | 19:57 | x64      |
| Sqlagent.exe                                 | 2017.140.3026.27 | 581288    | 10-May-18 | 23:51 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3026.27 | 61096     | 10-May-18 | 19:57 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3026.27 | 52904     | 10-May-18 | 20:10 | x86      |
| Sqlagentlog.dll                              | 2017.140.3026.27 | 32928     | 10-May-18 | 19:57 | x64      |
| Sqlagentmail.dll                             | 2017.140.3026.27 | 53928     | 10-May-18 | 19:57 | x64      |
| Sqlboot.dll                                  | 2017.140.3026.27 | 196256    | 10-May-18 | 19:57 | x64      |
| Sqlceip.exe                                  | 14.0.3026.27     | 253096    | 11-May-18 | 00:06 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3026.27 | 72360     | 10-May-18 | 20:43 | x64      |
| Sqlctr140.dll                                | 2017.140.3026.27 | 129192    | 10-May-18 | 19:57 | x64      |
| Sqlctr140.dll                                | 2017.140.3026.27 | 111776    | 10-May-18 | 20:20 | x86      |
| Sqldk.dll                                    | 2017.140.3026.27 | 2793128   | 11-May-18 | 01:17 | x64      |
| Sqldtsss.dll                                 | 2017.140.3026.27 | 107168    | 10-May-18 | 23:25 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3781792   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 2034856   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3817640   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 1496744   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3210920   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3288224   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3363488   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3911328   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3477664   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3293352   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3335328   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3398824   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3774632   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3914408   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 2088096   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 1444008   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3630760   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 4020384   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3593888   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3671712   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3781280   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3026.27 | 3585192   | 10-May-18 | 19:58 | x64      |
| Sqliosim.com                                 | 2017.140.3026.27 | 313504    | 10-May-18 | 20:10 | x64      |
| Sqliosim.exe                                 | 2017.140.3026.27 | 3019936   | 10-May-18 | 22:13 | x64      |
| Sqllang.dll                                  | 2017.140.3026.27 | 41226920  | 11-May-18 | 01:53 | x64      |
| Sqlmin.dll                                   | 2017.140.3026.27 | 40276136  | 11-May-18 | 01:44 | x64      |
| Sqlolapss.dll                                | 2017.140.3026.27 | 107688    | 10-May-18 | 19:57 | x64      |
| Sqlos.dll                                    | 2017.140.3026.27 | 26272     | 10-May-18 | 19:57 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3026.27 | 67744     | 10-May-18 | 20:19 | x64      |
| Sqlrepss.dll                                 | 2017.140.3026.27 | 64160     | 10-May-18 | 19:57 | x64      |
| Sqlresld.dll                                 | 2017.140.3026.27 | 30888     | 10-May-18 | 20:10 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3026.27 | 32416     | 10-May-18 | 19:57 | x64      |
| Sqlscm.dll                                   | 2017.140.3026.27 | 70816     | 10-May-18 | 23:43 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3026.27 | 27808     | 10-May-18 | 21:10 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3026.27 | 5872808   | 10-May-18 | 19:22 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3026.27 | 732832    | 10-May-18 | 19:57 | x64      |
| Sqlservr.exe                                 | 2017.140.3026.27 | 487080    | 11-May-18 | 01:24 | x64      |
| Sqlsvc.dll                                   | 2017.140.3026.27 | 161448    | 10-May-18 | 23:51 | x64      |
| Sqltses.dll                                  | 2017.140.3026.27 | 9537192   | 11-May-18 | 01:24 | x64      |
| Sqsrvres.dll                                 | 2017.140.3026.27 | 260264    | 10-May-18 | 20:56 | x64      |
| Svl.dll                                      | 2017.140.3026.27 | 154280    | 10-May-18 | 20:10 | x64      |
| Xe.dll                                       | 2017.140.3026.27 | 673440    | 10-May-18 | 19:57 | x64      |
| Xmlrw.dll                                    | 2017.140.3026.27 | 305320    | 10-May-18 | 19:57 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3026.27 | 224424    | 10-May-18 | 19:57 | x64      |
| Xpadsi.exe                                   | 2017.140.3026.27 | 89760     | 10-May-18 | 19:57 | x64      |
| Xplog70.dll                                  | 2017.140.3026.27 | 75944     | 10-May-18 | 20:19 | x64      |
| Xpqueue.dll                                  | 2017.140.3026.27 | 74912     | 10-May-18 | 19:57 | x64      |
| Xprepl.dll                                   | 2017.140.3026.27 | 101536    | 10-May-18 | 20:19 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3026.27 | 32416     | 10-May-18 | 19:57 | x64      |
| Xpstar.dll                                   | 2017.140.3026.27 | 438440    | 10-May-18 | 23:51 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3026.27 | 180904    | 10-May-18 | 19:57 | x64      |
| Batchparser.dll                                             | 2017.140.3026.27 | 160424    | 10-May-18 | 19:58 | x86      |
| Bcp.exe                                                     | 2017.140.3026.27 | 119968    | 10-May-18 | 19:57 | x64      |
| Commanddest.dll                                             | 2017.140.3026.27 | 245928    | 10-May-18 | 20:04 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3026.27 | 116384    | 10-May-18 | 19:57 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3026.27 | 187560    | 10-May-18 | 19:57 | x64      |
| Distrib.exe                                                 | 2017.140.3026.27 | 202408    | 10-May-18 | 19:57 | x64      |
| Dteparse.dll                                                | 2017.140.3026.27 | 111272    | 10-May-18 | 20:04 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3026.27 | 89256     | 10-May-18 | 19:57 | x64      |
| Dtepkg.dll                                                  | 2017.140.3026.27 | 137896    | 10-May-18 | 20:19 | x64      |
| Dtexec.exe                                                  | 2017.140.3026.27 | 73888     | 10-May-18 | 20:56 | x64      |
| Dts.dll                                                     | 2017.140.3026.27 | 2998952   | 10-May-18 | 20:04 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3026.27 | 475304    | 10-May-18 | 20:04 | x64      |
| Dtsconn.dll                                                 | 2017.140.3026.27 | 497312    | 10-May-18 | 20:04 | x64      |
| Dtshost.exe                                                 | 2017.140.3026.27 | 104104    | 10-May-18 | 20:04 | x64      |
| Dtslog.dll                                                  | 2017.140.3026.27 | 120480    | 10-May-18 | 20:04 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3026.27 | 545448    | 10-May-18 | 19:57 | x64      |
| Dtspipeline.dll                                             | 2017.140.3026.27 | 1266336   | 10-May-18 | 20:04 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3026.27 | 48288     | 10-May-18 | 20:27 | x64      |
| Dtuparse.dll                                                | 2017.140.3026.27 | 89248     | 10-May-18 | 19:57 | x64      |
| Dtutil.exe                                                  | 2017.140.3026.27 | 147104    | 10-May-18 | 20:04 | x64      |
| Exceldest.dll                                               | 2017.140.3026.27 | 260768    | 10-May-18 | 20:10 | x64      |
| Excelsrc.dll                                                | 2017.140.3026.27 | 282784    | 10-May-18 | 20:04 | x64      |
| Execpackagetask.dll                                         | 2017.140.3026.27 | 168104    | 10-May-18 | 19:57 | x64      |
| Flatfiledest.dll                                            | 2017.140.3026.27 | 384168    | 10-May-18 | 19:57 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3026.27 | 396448    | 10-May-18 | 20:04 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3026.27 | 96416     | 10-May-18 | 19:57 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3026.27 | 59560     | 10-May-18 | 20:10 | x64      |
| Logread.exe                                                 | 2017.140.3026.27 | 635048    | 10-May-18 | 20:10 | x64      |
| Mergetxt.dll                                                | 2017.140.3026.27 | 63136     | 10-May-18 | 19:57 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.213.1       | 1381536   | 24-Apr-18 | 21:54 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 24-Apr-18 | 22:08 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3026.27     | 89768     | 10-May-18 | 21:58 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3026.27 | 1662632   | 10-May-18 | 20:10 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3026.27 | 152232    | 11-May-18 | 00:06 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3026.27 | 159400    | 10-May-18 | 23:51 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3026.27 | 103080    | 10-May-18 | 20:04 | x64      |
| Msgprox.dll                                                 | 2017.140.3026.27 | 270504    | 10-May-18 | 20:28 | x64      |
| Msxmlsql.dll                                                | 2017.140.3026.27 | 1448096   | 10-May-18 | 19:57 | x64      |
| Oledbdest.dll                                               | 2017.140.3026.27 | 261288    | 10-May-18 | 20:10 | x64      |
| Oledbsrc.dll                                                | 2017.140.3026.27 | 288936    | 10-May-18 | 19:57 | x64      |
| Osql.exe                                                    | 2017.140.3026.27 | 75424     | 10-May-18 | 19:57 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3026.27 | 473768    | 10-May-18 | 19:57 | x64      |
| Rawdest.dll                                                 | 2017.140.3026.27 | 206504    | 10-May-18 | 20:19 | x64      |
| Rawsource.dll                                               | 2017.140.3026.27 | 194216    | 10-May-18 | 20:04 | x64      |
| Rdistcom.dll                                                | 2017.140.3026.27 | 856224    | 10-May-18 | 19:57 | x64      |
| Recordsetdest.dll                                           | 2017.140.3026.27 | 184480    | 10-May-18 | 20:04 | x64      |
| Replagnt.dll                                                | 2017.140.3026.27 | 30888     | 10-May-18 | 20:10 | x64      |
| Repldp.dll                                                  | 2017.140.3026.27 | 290464    | 10-May-18 | 19:57 | x64      |
| Replerrx.dll                                                | 2017.140.3026.27 | 154272    | 10-May-18 | 19:57 | x64      |
| Replisapi.dll                                               | 2017.140.3026.27 | 361632    | 10-May-18 | 20:10 | x64      |
| Replmerg.exe                                                | 2017.140.3026.27 | 524968    | 10-May-18 | 19:57 | x64      |
| Replprov.dll                                                | 2017.140.3026.27 | 801440    | 10-May-18 | 20:04 | x64      |
| Replrec.dll                                                 | 2017.140.3026.27 | 975008    | 10-May-18 | 19:57 | x64      |
| Replsub.dll                                                 | 2017.140.3026.27 | 445600    | 10-May-18 | 19:57 | x64      |
| Replsync.dll                                                | 2017.140.3026.27 | 153768    | 10-May-18 | 20:10 | x64      |
| Spresolv.dll                                                | 2017.140.3026.27 | 252072    | 10-May-18 | 19:57 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3026.27 | 249000    | 10-May-18 | 19:57 | x64      |
| Sqldiag.exe                                                 | 2017.140.3026.27 | 1257640   | 10-May-18 | 20:19 | x64      |
| Sqldistx.dll                                                | 2017.140.3026.27 | 224936    | 10-May-18 | 20:10 | x64      |
| Sqllogship.exe                                              | 14.0.3026.27     | 105640    | 10-May-18 | 19:57 | x64      |
| Sqlmergx.dll                                                | 2017.140.3026.27 | 360608    | 10-May-18 | 19:57 | x64      |
| Sqlresld.dll                                                | 2017.140.3026.27 | 28832     | 10-May-18 | 19:58 | x86      |
| Sqlresld.dll                                                | 2017.140.3026.27 | 30888     | 10-May-18 | 20:10 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3026.27 | 32416     | 10-May-18 | 19:57 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3026.27 | 29344     | 10-May-18 | 19:58 | x86      |
| Sqlscm.dll                                                  | 2017.140.3026.27 | 60072     | 10-May-18 | 19:58 | x86      |
| Sqlscm.dll                                                  | 2017.140.3026.27 | 70816     | 10-May-18 | 23:43 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3026.27 | 134816    | 10-May-18 | 20:05 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3026.27 | 161448    | 10-May-18 | 23:51 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3026.27 | 183976    | 10-May-18 | 19:57 | x64      |
| Sqlwep140.dll                                               | 2017.140.3026.27 | 105640    | 10-May-18 | 19:57 | x64      |
| Ssdebugps.dll                                               | 2017.140.3026.27 | 33448     | 10-May-18 | 20:19 | x64      |
| Ssisoledb.dll                                               | 2017.140.3026.27 | 216224    | 10-May-18 | 20:04 | x64      |
| Ssradd.dll                                                  | 2017.140.3026.27 | 74920     | 10-May-18 | 19:57 | x64      |
| Ssravg.dll                                                  | 2017.140.3026.27 | 74912     | 10-May-18 | 20:28 | x64      |
| Ssrdown.dll                                                 | 2017.140.3026.27 | 60064     | 10-May-18 | 20:19 | x64      |
| Ssrmax.dll                                                  | 2017.140.3026.27 | 72864     | 10-May-18 | 20:19 | x64      |
| Ssrmin.dll                                                  | 2017.140.3026.27 | 73384     | 10-May-18 | 19:57 | x64      |
| Ssrpub.dll                                                  | 2017.140.3026.27 | 60576     | 10-May-18 | 20:04 | x64      |
| Ssrup.dll                                                   | 2017.140.3026.27 | 60072     | 10-May-18 | 20:19 | x64      |
| Txagg.dll                                                   | 2017.140.3026.27 | 362144    | 10-May-18 | 20:04 | x64      |
| Txbdd.dll                                                   | 2017.140.3026.27 | 170152    | 10-May-18 | 20:04 | x64      |
| Txdatacollector.dll                                         | 2017.140.3026.27 | 360608    | 10-May-18 | 19:57 | x64      |
| Txdataconvert.dll                                           | 2017.140.3026.27 | 293032    | 10-May-18 | 20:10 | x64      |
| Txderived.dll                                               | 2017.140.3026.27 | 604328    | 10-May-18 | 20:04 | x64      |
| Txlookup.dll                                                | 2017.140.3026.27 | 528040    | 10-May-18 | 20:10 | x64      |
| Txmerge.dll                                                 | 2017.140.3026.27 | 230048    | 10-May-18 | 20:04 | x64      |
| Txmergejoin.dll                                             | 2017.140.3026.27 | 275616    | 10-May-18 | 19:57 | x64      |
| Txmulticast.dll                                             | 2017.140.3026.27 | 127656    | 10-May-18 | 19:57 | x64      |
| Txrowcount.dll                                              | 2017.140.3026.27 | 125600    | 10-May-18 | 20:04 | x64      |
| Txsort.dll                                                  | 2017.140.3026.27 | 256672    | 10-May-18 | 19:57 | x64      |
| Txsplit.dll                                                 | 2017.140.3026.27 | 596648    | 10-May-18 | 20:10 | x64      |
| Txunionall.dll                                              | 2017.140.3026.27 | 181928    | 10-May-18 | 19:57 | x64      |
| Xe.dll                                                      | 2017.140.3026.27 | 673440    | 10-May-18 | 19:57 | x64      |
| Xmlrw.dll                                                   | 2017.140.3026.27 | 305320    | 10-May-18 | 19:57 | x64      |
| Xmlsub.dll                                                  | 2017.140.3026.27 | 260776    | 10-May-18 | 20:36 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3026.27 | 1124008   | 10-May-18 | 20:50 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlsatellite.dll              | 2017.140.3026.27 | 922280    | 10-May-18 | 20:19 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3026.27 | 667296    | 10-May-18 | 19:57 | x64      |
| Fdhost.exe               | 2017.140.3026.27 | 114336    | 10-May-18 | 20:19 | x64      |
| Fdlauncher.exe           | 2017.140.3026.27 | 62112     | 10-May-18 | 19:57 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlft140ph.dll           | 2017.140.3026.27 | 67752     | 10-May-18 | 19:57 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3026.27     | 23720     | 10-May-18 | 19:57 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 24-Apr-18 | 22:07 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 24-Apr-18 | 22:07 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 24-Apr-18 | 22:07 | x86      |
| Commanddest.dll                                               | 2017.140.3026.27 | 245928    | 10-May-18 | 20:04 | x64      |
| Commanddest.dll                                               | 2017.140.3026.27 | 200872    | 10-May-18 | 23:59 | x86      |
| Dteparse.dll                                                  | 2017.140.3026.27 | 111272    | 10-May-18 | 20:04 | x64      |
| Dteparse.dll                                                  | 2017.140.3026.27 | 101032    | 10-May-18 | 23:52 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3026.27 | 89256     | 10-May-18 | 19:57 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3026.27 | 83616     | 10-May-18 | 23:52 | x86      |
| Dtepkg.dll                                                    | 2017.140.3026.27 | 137896    | 10-May-18 | 20:19 | x64      |
| Dtepkg.dll                                                    | 2017.140.3026.27 | 116904    | 10-May-18 | 23:59 | x86      |
| Dtexec.exe                                                    | 2017.140.3026.27 | 73888     | 10-May-18 | 20:56 | x64      |
| Dtexec.exe                                                    | 2017.140.3026.27 | 67744     | 11-May-18 | 00:06 | x86      |
| Dts.dll                                                       | 2017.140.3026.27 | 2998952   | 10-May-18 | 20:04 | x64      |
| Dts.dll                                                       | 2017.140.3026.27 | 2549416   | 10-May-18 | 23:59 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3026.27 | 475304    | 10-May-18 | 20:04 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3026.27 | 417960    | 10-May-18 | 23:52 | x86      |
| Dtsconn.dll                                                   | 2017.140.3026.27 | 497312    | 10-May-18 | 20:04 | x64      |
| Dtsconn.dll                                                   | 2017.140.3026.27 | 399520    | 10-May-18 | 23:43 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3026.27 | 111272    | 10-May-18 | 20:04 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3026.27 | 95392     | 10-May-18 | 23:52 | x86      |
| Dtshost.exe                                                   | 2017.140.3026.27 | 104104    | 10-May-18 | 20:04 | x64      |
| Dtshost.exe                                                   | 2017.140.3026.27 | 89768     | 10-May-18 | 23:59 | x86      |
| Dtslog.dll                                                    | 2017.140.3026.27 | 120480    | 10-May-18 | 20:04 | x64      |
| Dtslog.dll                                                    | 2017.140.3026.27 | 103072    | 10-May-18 | 23:43 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3026.27 | 545448    | 10-May-18 | 19:57 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3026.27 | 541352    | 10-May-18 | 23:43 | x86      |
| Dtspipeline.dll                                               | 2017.140.3026.27 | 1266336   | 10-May-18 | 20:04 | x64      |
| Dtspipeline.dll                                               | 2017.140.3026.27 | 1059488   | 10-May-18 | 23:59 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3026.27 | 48288     | 10-May-18 | 20:27 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3026.27 | 42664     | 10-May-18 | 23:52 | x86      |
| Dtuparse.dll                                                  | 2017.140.3026.27 | 89248     | 10-May-18 | 19:57 | x64      |
| Dtuparse.dll                                                  | 2017.140.3026.27 | 80040     | 10-May-18 | 23:43 | x86      |
| Dtutil.exe                                                    | 2017.140.3026.27 | 147104    | 10-May-18 | 20:04 | x64      |
| Dtutil.exe                                                    | 2017.140.3026.27 | 126120    | 10-May-18 | 23:52 | x86      |
| Exceldest.dll                                                 | 2017.140.3026.27 | 260768    | 10-May-18 | 20:10 | x64      |
| Exceldest.dll                                                 | 2017.140.3026.27 | 214688    | 10-May-18 | 23:59 | x86      |
| Excelsrc.dll                                                  | 2017.140.3026.27 | 282784    | 10-May-18 | 20:04 | x64      |
| Excelsrc.dll                                                  | 2017.140.3026.27 | 230568    | 10-May-18 | 23:59 | x86      |
| Execpackagetask.dll                                           | 2017.140.3026.27 | 168104    | 10-May-18 | 19:57 | x64      |
| Execpackagetask.dll                                           | 2017.140.3026.27 | 135328    | 10-May-18 | 23:52 | x86      |
| Flatfiledest.dll                                              | 2017.140.3026.27 | 384168    | 10-May-18 | 19:57 | x64      |
| Flatfiledest.dll                                              | 2017.140.3026.27 | 330920    | 10-May-18 | 23:59 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3026.27 | 396448    | 10-May-18 | 20:04 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3026.27 | 342184    | 10-May-18 | 23:59 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3026.27 | 96416     | 10-May-18 | 19:57 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3026.27 | 80552     | 10-May-18 | 23:52 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3026.27     | 467112    | 11-May-18 | 00:56 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3026.27     | 466600    | 11-May-18 | 00:06 | x64      |
| Isserverexec.exe                                              | 14.0.3026.27     | 148640    | 10-May-18 | 21:58 | x64      |
| Isserverexec.exe                                              | 14.0.3026.27     | 149152    | 11-May-18 | 00:22 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.213.1       | 1381536   | 24-Apr-18 | 21:54 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.213.1       | 1381536   | 24-Apr-18 | 22:07 | x86      |
| Microsoft.applicationinsights.dll                             | 2.6.0.6787       | 239328    | 24-Apr-18 | 21:15 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 24-Apr-18 | 22:08 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3026.27     | 71328     | 10-May-18 | 21:31 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3026.27 | 112296    | 10-May-18 | 20:10 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3026.27 | 107176    | 10-May-18 | 23:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3026.27     | 89768     | 10-May-18 | 21:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3026.27     | 89760     | 11-May-18 | 00:32 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3026.27     | 494752    | 10-May-18 | 19:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3026.27     | 494760    | 10-May-18 | 19:58 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3026.27     | 83624     | 10-May-18 | 20:50 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3026.27     | 83624     | 10-May-18 | 23:59 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3026.27     | 415912    | 10-May-18 | 23:59 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3026.27     | 415904    | 11-May-18 | 00:56 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3026.27     | 252584    | 10-May-18 | 20:05 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3026.27     | 252584    | 10-May-18 | 20:10 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3026.27 | 141992    | 10-May-18 | 20:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3026.27 | 152232    | 11-May-18 | 00:06 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3026.27 | 145568    | 10-May-18 | 20:04 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3026.27 | 159400    | 10-May-18 | 23:51 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3026.27     | 219808    | 10-May-18 | 21:31 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3026.27 | 103080    | 10-May-18 | 20:04 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3026.27 | 90272     | 10-May-18 | 23:52 | x86      |
| Msmdpp.dll                                                    | 2017.140.213.1   | 9194144   | 24-Apr-18 | 21:54 | x64      |
| Oledbdest.dll                                                 | 2017.140.3026.27 | 261288    | 10-May-18 | 20:10 | x64      |
| Oledbdest.dll                                                 | 2017.140.3026.27 | 214696    | 10-May-18 | 23:59 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3026.27 | 288936    | 10-May-18 | 19:57 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3026.27 | 233128    | 10-May-18 | 23:59 | x86      |
| Rawdest.dll                                                   | 2017.140.3026.27 | 206504    | 10-May-18 | 20:19 | x64      |
| Rawdest.dll                                                   | 2017.140.3026.27 | 166560    | 10-May-18 | 23:59 | x86      |
| Rawsource.dll                                                 | 2017.140.3026.27 | 194216    | 10-May-18 | 20:04 | x64      |
| Rawsource.dll                                                 | 2017.140.3026.27 | 153256    | 10-May-18 | 23:59 | x86      |
| Recordsetdest.dll                                             | 2017.140.3026.27 | 184480    | 10-May-18 | 20:04 | x64      |
| Recordsetdest.dll                                             | 2017.140.3026.27 | 149152    | 10-May-18 | 23:59 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlceip.exe                                                   | 14.0.3026.27     | 253096    | 11-May-18 | 00:06 | x86      |
| Sqldest.dll                                                   | 2017.140.3026.27 | 260776    | 10-May-18 | 20:10 | x64      |
| Sqldest.dll                                                   | 2017.140.3026.27 | 213664    | 10-May-18 | 23:59 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3026.27 | 183976    | 10-May-18 | 19:57 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3026.27 | 155304    | 10-May-18 | 23:52 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3026.27 | 216224    | 10-May-18 | 20:04 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3026.27 | 176800    | 10-May-18 | 23:52 | x86      |
| Txagg.dll                                                     | 2017.140.3026.27 | 362144    | 10-May-18 | 20:04 | x64      |
| Txagg.dll                                                     | 2017.140.3026.27 | 302240    | 10-May-18 | 23:59 | x86      |
| Txbdd.dll                                                     | 2017.140.3026.27 | 170152    | 10-May-18 | 20:04 | x64      |
| Txbdd.dll                                                     | 2017.140.3026.27 | 136360    | 10-May-18 | 23:59 | x86      |
| Txbestmatch.dll                                               | 2017.140.3026.27 | 605344    | 10-May-18 | 20:04 | x64      |
| Txbestmatch.dll                                               | 2017.140.3026.27 | 493216    | 10-May-18 | 23:59 | x86      |
| Txcache.dll                                                   | 2017.140.3026.27 | 180384    | 10-May-18 | 20:04 | x64      |
| Txcache.dll                                                   | 2017.140.3026.27 | 146088    | 10-May-18 | 23:59 | x86      |
| Txcharmap.dll                                                 | 2017.140.3026.27 | 286880    | 10-May-18 | 19:57 | x64      |
| Txcharmap.dll                                                 | 2017.140.3026.27 | 248992    | 10-May-18 | 23:59 | x86      |
| Txcopymap.dll                                                 | 2017.140.3026.27 | 180384    | 10-May-18 | 20:04 | x64      |
| Txcopymap.dll                                                 | 2017.140.3026.27 | 145576    | 10-May-18 | 23:59 | x86      |
| Txdataconvert.dll                                             | 2017.140.3026.27 | 293032    | 10-May-18 | 20:10 | x64      |
| Txdataconvert.dll                                             | 2017.140.3026.27 | 253096    | 10-May-18 | 23:59 | x86      |
| Txderived.dll                                                 | 2017.140.3026.27 | 604328    | 10-May-18 | 20:04 | x64      |
| Txderived.dll                                                 | 2017.140.3026.27 | 515744    | 10-May-18 | 23:59 | x86      |
| Txfileextractor.dll                                           | 2017.140.3026.27 | 198824    | 10-May-18 | 20:10 | x64      |
| Txfileextractor.dll                                           | 2017.140.3026.27 | 160936    | 10-May-18 | 23:59 | x86      |
| Txfileinserter.dll                                            | 2017.140.3026.27 | 196768    | 10-May-18 | 19:57 | x64      |
| Txfileinserter.dll                                            | 2017.140.3026.27 | 159400    | 10-May-18 | 23:59 | x86      |
| Txgroupdups.dll                                               | 2017.140.3026.27 | 290472    | 10-May-18 | 20:28 | x64      |
| Txgroupdups.dll                                               | 2017.140.3026.27 | 231080    | 10-May-18 | 23:59 | x86      |
| Txlineage.dll                                                 | 2017.140.3026.27 | 136872    | 10-May-18 | 20:10 | x64      |
| Txlineage.dll                                                 | 2017.140.3026.27 | 110248    | 10-May-18 | 23:59 | x86      |
| Txlookup.dll                                                  | 2017.140.3026.27 | 528040    | 10-May-18 | 20:10 | x64      |
| Txlookup.dll                                                  | 2017.140.3026.27 | 446632    | 10-May-18 | 23:59 | x86      |
| Txmerge.dll                                                   | 2017.140.3026.27 | 230048    | 10-May-18 | 20:04 | x64      |
| Txmerge.dll                                                   | 2017.140.3026.27 | 176800    | 10-May-18 | 23:43 | x86      |
| Txmergejoin.dll                                               | 2017.140.3026.27 | 275616    | 10-May-18 | 19:57 | x64      |
| Txmergejoin.dll                                               | 2017.140.3026.27 | 221856    | 10-May-18 | 23:59 | x86      |
| Txmulticast.dll                                               | 2017.140.3026.27 | 127656    | 10-May-18 | 19:57 | x64      |
| Txmulticast.dll                                               | 2017.140.3026.27 | 103080    | 10-May-18 | 23:59 | x86      |
| Txpivot.dll                                                   | 2017.140.3026.27 | 224936    | 10-May-18 | 19:57 | x64      |
| Txpivot.dll                                                   | 2017.140.3026.27 | 180392    | 10-May-18 | 23:59 | x86      |
| Txrowcount.dll                                                | 2017.140.3026.27 | 125600    | 10-May-18 | 20:04 | x64      |
| Txrowcount.dll                                                | 2017.140.3026.27 | 101544    | 10-May-18 | 23:59 | x86      |
| Txsampling.dll                                                | 2017.140.3026.27 | 172704    | 10-May-18 | 20:04 | x64      |
| Txsampling.dll                                                | 2017.140.3026.27 | 135848    | 10-May-18 | 23:52 | x86      |
| Txscd.dll                                                     | 2017.140.3026.27 | 220832    | 10-May-18 | 20:04 | x64      |
| Txscd.dll                                                     | 2017.140.3026.27 | 170152    | 10-May-18 | 23:43 | x86      |
| Txsort.dll                                                    | 2017.140.3026.27 | 256672    | 10-May-18 | 19:57 | x64      |
| Txsort.dll                                                    | 2017.140.3026.27 | 208032    | 10-May-18 | 23:59 | x86      |
| Txsplit.dll                                                   | 2017.140.3026.27 | 596648    | 10-May-18 | 20:10 | x64      |
| Txsplit.dll                                                   | 2017.140.3026.27 | 510632    | 10-May-18 | 23:59 | x86      |
| Txtermextraction.dll                                          | 2017.140.3026.27 | 8676520   | 10-May-18 | 20:19 | x64      |
| Txtermextraction.dll                                          | 2017.140.3026.27 | 8615072   | 10-May-18 | 23:52 | x86      |
| Txtermlookup.dll                                              | 2017.140.3026.27 | 4157096   | 10-May-18 | 20:04 | x64      |
| Txtermlookup.dll                                              | 2017.140.3026.27 | 4106912   | 10-May-18 | 23:59 | x86      |
| Txunionall.dll                                                | 2017.140.3026.27 | 181928    | 10-May-18 | 19:57 | x64      |
| Txunionall.dll                                                | 2017.140.3026.27 | 139432    | 10-May-18 | 23:59 | x86      |
| Txunpivot.dll                                                 | 2017.140.3026.27 | 199848    | 10-May-18 | 19:57 | x64      |
| Txunpivot.dll                                                 | 2017.140.3026.27 | 160424    | 10-May-18 | 23:59 | x86      |
| Xe.dll                                                        | 2017.140.3026.27 | 673440    | 10-May-18 | 19:57 | x64      |
| Xe.dll                                                        | 2017.140.3026.27 | 595624    | 10-May-18 | 19:57 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 24-Apr-18 | 21:53 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 24-Apr-18 | 21:53 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 24-Apr-18 | 21:53 | x86      |
| Instapi140.dll                                                       | 2017.140.3026.27 | 70312     | 10-May-18 | 19:57 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 24-Apr-18 | 22:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 24-Apr-18 | 22:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 24-Apr-18 | 22:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 24-Apr-18 | 22:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 24-Apr-18 | 22:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 24-Apr-18 | 22:14 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 24-Apr-18 | 22:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 24-Apr-18 | 22:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 24-Apr-18 | 22:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 24-Apr-18 | 22:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 24-Apr-18 | 22:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 24-Apr-18 | 22:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 24-Apr-18 | 22:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 24-Apr-18 | 21:53 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 24-Apr-18 | 21:53 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3026.27 | 407208    | 10-May-18 | 20:04 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3026.27 | 7324328   | 10-May-18 | 20:36 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3026.27 | 2263208   | 10-May-18 | 20:19 | x64      |
| Secforwarder.dll                                                     | 2017.140.3026.27 | 37536     | 10-May-18 | 19:57 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 24-Apr-18 | 21:51 | x64      |
| Sqldk.dll                                                            | 2017.140.3026.27 | 2710528   | 10-May-18 | 20:04 | x64      |
| Sqldumper.exe                                                        | 2017.140.3026.27 | 140968    | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 1496744   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3911328   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3210920   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3914408   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3817640   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 2088096   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 2034856   | 10-May-18 | 19:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3585192   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3593888   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 1444008   | 10-May-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3026.27 | 3781792   | 10-May-18 | 19:57 | x64      |
| Sqlos.dll                                                            | 2017.140.3026.27 | 26272     | 10-May-18 | 19:57 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 24-Apr-18 | 21:53 | x64      |
| Sqltses.dll                                                          | 2017.140.3026.27 | 9690624   | 10-May-18 | 20:04 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3026.27     | 23712     | 10-May-18 | 20:19 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3026.27 | 1448616   | 10-May-18 | 20:05 | x86      |
| Dtaengine.exe                                          | 2017.140.3026.27 | 204456    | 10-May-18 | 20:27 | x86      |
| Dteparse.dll                                           | 2017.140.3026.27 | 111272    | 10-May-18 | 20:04 | x64      |
| Dteparse.dll                                           | 2017.140.3026.27 | 101032    | 10-May-18 | 23:52 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3026.27 | 89256     | 10-May-18 | 19:57 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3026.27 | 83616     | 10-May-18 | 23:52 | x86      |
| Dtepkg.dll                                             | 2017.140.3026.27 | 137896    | 10-May-18 | 20:19 | x64      |
| Dtepkg.dll                                             | 2017.140.3026.27 | 116904    | 10-May-18 | 23:59 | x86      |
| Dtexec.exe                                             | 2017.140.3026.27 | 73888     | 10-May-18 | 20:56 | x64      |
| Dtexec.exe                                             | 2017.140.3026.27 | 67744     | 11-May-18 | 00:06 | x86      |
| Dts.dll                                                | 2017.140.3026.27 | 2998952   | 10-May-18 | 20:04 | x64      |
| Dts.dll                                                | 2017.140.3026.27 | 2549416   | 10-May-18 | 23:59 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3026.27 | 475304    | 10-May-18 | 20:04 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3026.27 | 417960    | 10-May-18 | 23:52 | x86      |
| Dtsconn.dll                                            | 2017.140.3026.27 | 497312    | 10-May-18 | 20:04 | x64      |
| Dtsconn.dll                                            | 2017.140.3026.27 | 399520    | 10-May-18 | 23:43 | x86      |
| Dtshost.exe                                            | 2017.140.3026.27 | 104104    | 10-May-18 | 20:04 | x64      |
| Dtshost.exe                                            | 2017.140.3026.27 | 89768     | 10-May-18 | 23:59 | x86      |
| Dtslog.dll                                             | 2017.140.3026.27 | 120480    | 10-May-18 | 20:04 | x64      |
| Dtslog.dll                                             | 2017.140.3026.27 | 103072    | 10-May-18 | 23:43 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3026.27 | 545448    | 10-May-18 | 19:57 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3026.27 | 541352    | 10-May-18 | 23:43 | x86      |
| Dtspipeline.dll                                        | 2017.140.3026.27 | 1266336   | 10-May-18 | 20:04 | x64      |
| Dtspipeline.dll                                        | 2017.140.3026.27 | 1059488   | 10-May-18 | 23:59 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3026.27 | 48288     | 10-May-18 | 20:27 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3026.27 | 42664     | 10-May-18 | 23:52 | x86      |
| Dtuparse.dll                                           | 2017.140.3026.27 | 89248     | 10-May-18 | 19:57 | x64      |
| Dtuparse.dll                                           | 2017.140.3026.27 | 80040     | 10-May-18 | 23:43 | x86      |
| Dtutil.exe                                             | 2017.140.3026.27 | 147104    | 10-May-18 | 20:04 | x64      |
| Dtutil.exe                                             | 2017.140.3026.27 | 126120    | 10-May-18 | 23:52 | x86      |
| Exceldest.dll                                          | 2017.140.3026.27 | 260768    | 10-May-18 | 20:10 | x64      |
| Exceldest.dll                                          | 2017.140.3026.27 | 214688    | 10-May-18 | 23:59 | x86      |
| Excelsrc.dll                                           | 2017.140.3026.27 | 282784    | 10-May-18 | 20:04 | x64      |
| Excelsrc.dll                                           | 2017.140.3026.27 | 230568    | 10-May-18 | 23:59 | x86      |
| Flatfiledest.dll                                       | 2017.140.3026.27 | 384168    | 10-May-18 | 19:57 | x64      |
| Flatfiledest.dll                                       | 2017.140.3026.27 | 330920    | 10-May-18 | 23:59 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3026.27 | 396448    | 10-May-18 | 20:04 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3026.27 | 342184    | 10-May-18 | 23:59 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3026.27 | 96416     | 10-May-18 | 19:57 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3026.27 | 80552     | 10-May-18 | 23:52 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3026.27     | 71336     | 11-May-18 | 00:22 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3026.27     | 184480    | 11-May-18 | 01:06 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3026.27     | 406696    | 10-May-18 | 19:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3026.27     | 406696    | 10-May-18 | 19:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3026.27     | 2093224   | 10-May-18 | 20:10 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3026.27     | 2093224   | 10-May-18 | 20:10 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3026.27     | 252584    | 10-May-18 | 20:05 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3026.27 | 141992    | 10-May-18 | 20:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3026.27 | 152232    | 11-May-18 | 00:06 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3026.27 | 145568    | 10-May-18 | 20:04 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3026.27 | 159400    | 10-May-18 | 23:51 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3026.27 | 103080    | 10-May-18 | 20:04 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3026.27 | 90272     | 10-May-18 | 23:52 | x86      |
| Msmgdsrv.dll                                           | 2017.140.213.1   | 7310496   | 24-Apr-18 | 22:07 | x86      |
| Oledbdest.dll                                          | 2017.140.3026.27 | 261288    | 10-May-18 | 20:10 | x64      |
| Oledbdest.dll                                          | 2017.140.3026.27 | 214696    | 10-May-18 | 23:59 | x86      |
| Oledbsrc.dll                                           | 2017.140.3026.27 | 288936    | 10-May-18 | 19:57 | x64      |
| Oledbsrc.dll                                           | 2017.140.3026.27 | 233128    | 10-May-18 | 23:59 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3026.27 | 100520    | 10-May-18 | 21:51 | x64      |
| Sqlresld.dll                                           | 2017.140.3026.27 | 28832     | 10-May-18 | 19:58 | x86      |
| Sqlresld.dll                                           | 2017.140.3026.27 | 30888     | 10-May-18 | 20:10 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3026.27 | 32416     | 10-May-18 | 19:57 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3026.27 | 29344     | 10-May-18 | 19:58 | x86      |
| Sqlscm.dll                                             | 2017.140.3026.27 | 60072     | 10-May-18 | 19:58 | x86      |
| Sqlscm.dll                                             | 2017.140.3026.27 | 70816     | 10-May-18 | 23:43 | x64      |
| Sqlsvc.dll                                             | 2017.140.3026.27 | 134816    | 10-May-18 | 20:05 | x86      |
| Sqlsvc.dll                                             | 2017.140.3026.27 | 161448    | 10-May-18 | 23:51 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3026.27 | 183976    | 10-May-18 | 19:57 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3026.27 | 155304    | 10-May-18 | 23:52 | x86      |
| Txdataconvert.dll                                      | 2017.140.3026.27 | 293032    | 10-May-18 | 20:10 | x64      |
| Txdataconvert.dll                                      | 2017.140.3026.27 | 253096    | 10-May-18 | 23:59 | x86      |
| Xe.dll                                                 | 2017.140.3026.27 | 673440    | 10-May-18 | 19:57 | x64      |
| Xe.dll                                                 | 2017.140.3026.27 | 595624    | 10-May-18 | 19:57 | x86      |
| Xmlrw.dll                                              | 2017.140.3026.27 | 305320    | 10-May-18 | 19:57 | x64      |
| Xmlrw.dll                                              | 2017.140.3026.27 | 257704    | 10-May-18 | 22:27 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3026.27 | 224424    | 10-May-18 | 19:57 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3026.27 | 189608    | 10-May-18 | 22:20 | x86      |

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
