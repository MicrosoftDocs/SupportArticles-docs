---
title: Cumulative update 8 for SQL Server 2017 (KB4338363)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 8 (KB4338363).
ms.date: 08/04/2023
ms.custom: KB4338363
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4338363 - Cumulative Update 8 for SQL Server 2017

_Release Date:_ &nbsp; June 21, 2018  
_Version:_ &nbsp; 14.0.3029.16

## Summary

This article describes Cumulative Update package 8 (CU8) for Microsoft SQL Server 2017. This update contains 36 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 7, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3029.16**, file version: **2017.140.3029.16**
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
| <a id="11829060">[11829060](#11829060)</a> | [Update adds improved support for SAP HANA data sources in SQL Server Analysis Services (KB4342111)](https://support.microsoft.com/help/4342111) | Analysis Services | Analysis Services | Windows |
| <a id="11566052">[11566052](#11566052)</a> | [FIX: Can't change the "isAvailableInMdx" column property to "False" in SSAS in Tabular mode (KB4295097)](https://support.microsoft.com/help/4295097) | Analysis Services | Analysis Services | Windows |
| <a id="11845000">[11845000](#11845000)</a> | [FIX: Query performance difference between SSAS 2014 and SSAS 2017 (KB4132042)](https://support.microsoft.com/help/4132042) | Analysis Services | Analysis Services | Windows |
| <a id="11863917">[11863917](#11863917)</a> | [FIX: SQL Server 2017 Analysis Services crashes after a random query is run against DirectQuery mode (KB4136679)](https://support.microsoft.com/help/4136679) | Analysis Services | Analysis Services | Windows |
| <a id="11953216">[11953216](#11953216)</a> | [FIX: DAX query performance decrease after you upgrade to SQL Server 2017 (KB4163528)](https://support.microsoft.com/help/4163528) | Analysis Services | Analysis Services | Windows |
| <a id="11976339">[11976339](#11976339)</a> | [FIX: Unexpected error when processing a table by using the "Process Full" option in SQL Server Analysis Services (KB4293761)](https://support.microsoft.com/help/4293761) | Analysis Services | Analysis Services | Windows |
| <a id="11983932">[11983932](#11983932)</a> | [FIX: "An unexpected error occurred" when you use DAX measures in Power BI table visualizations in SQL Server (KB4094858)](https://support.microsoft.com/help/4094858) | Analysis Services | Analysis Services | Windows |
| <a id="11983952">[11983952](#11983952)</a> | [FIX: A crash occurs when proactive caching is triggered for a dimension in SSAS (KB3028216)](https://support.microsoft.com/help/3028216) | Analysis Services | Analysis Services | Windows |
| <a id="11983945">[11983945](#11983945)</a> | FIX: Processing a cube with many partitions generates lots of concurrent data source connections in SSAS 2016 and 2017 (KB4134175) | Analysis Services | Analysis Services | Windows |
| <a id="11983946">[11983946](#11983946)</a> | FIX: An internal exception access violation occurs and the SSAS server stops responding (KB4162814) | Analysis Services | Analysis Services | Windows |
| <a id="11886245">[11886245](#11886245)</a> | [FIX: A DAX query that contains SWITCH and nested IF statements take more than an hour to finish in SQL Server (KB4163526)](https://support.microsoft.com/help/4163526) | Analysis Services | Server | Windows |
| <a id="11677210">[11677210](#11677210)</a> | [FIX: SSMS and SSDT don't escape double quotation marks when you export data as CSV (KB4135137)](https://support.microsoft.com/help/4135137) | Integration Services | Tasks_Components | Windows |
| <a id="11983933">[11983933](#11983933)</a> | [FIX: Wrong user name appears when two users log on to MDS at different times in SQL Server (KB4164562)](https://support.microsoft.com/help/4164562) | Master Data Services | Client | Windows |
| <a id="11057337">[11057337](#11057337)</a> | [FIX: RESTORE HEADERONLY statement for a TDE compressed backup slow to complete in SQL Server (KB4052135)](https://support.microsoft.com/help/4052135) | SQL Server Engine | Backup Restore | All |
| <a id="11983956">[11983956](#11983956)</a> | [FIX: Access violation when you run a nested select query against a columnstore index in SQL Server (KB4131960)](https://support.microsoft.com/help/4131960) | SQL Server Engine | Column Stores | Windows |
| <a id="11953689">[11953689](#11953689)</a> | [FIX: "PAGE_FAULT_IN_NONPAGED_AREA" Stop error when enumerating contents in a SQL Server FileTable directory (KB4338960)](https://support.microsoft.com/help/4338960) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12062786">[12062786](#12062786)</a> | [Improvements for Always On Availability Groups on a Pacemaker cluster in SQL Server (KB4339875)](https://support.microsoft.com/help/4339875) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12120313">[12120313](#12120313)</a> | [Improvement to reduce the fail-over duration for an availability group in SQL Server on Linux (KB4339090)](https://support.microsoft.com/help/4339090) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12000998">[12000998](#12000998)</a> | [FIX: Always On database is stuck in "Recovery Pending" state after the host name of an availability replica is renamed in SQL Server (KB4316789)](https://support.microsoft.com/help/4316789) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12035281">[12035281](#12035281)</a> | [FIX: Startup of a database that belongs to an availability group times out in SQL Server on Linux (KB4316790)](https://support.microsoft.com/help/4316790) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12038322">[12038322](#12038322)</a> | [FIX: Unnecessary failovers occur when a SQL Server 2017 Failover Cluster Instance or an Always On Availability Group is managed by Pacemaker (KB4316793)](https://support.microsoft.com/help/4316793) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12052001">[12052001](#12052001)</a> | [FIX: Two SQL Server instances are the primary replica of an availability group in SQL Server (KB4316791)](https://support.microsoft.com/help/4316791) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12059449">[12059449](#12059449)</a> | [FIX: Error 19432 when you use Always On Availability Groups in SQL Server (KB4338746)](https://support.microsoft.com/help/4338746) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11974804">[11974804](#11974804)</a> | [FIX: Database recovery could stop responding if it contains in-memory objects and a recovery failure is encountered during a race condition in SQL Server 2017 (KB4295233)](https://support.microsoft.com/help/4295233) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11990858">[11990858](#11990858)</a> | [FIX: Memory leak after dropping a LOB or off-row column from a memory-optimized table in SQL Server on Linux (KB4338296)](https://support.microsoft.com/help/4338296) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11983965">[11983965](#11983965)</a> | [FIX: An access violation occurs when incremental statistics are automatically updated on a table in SQL Server (KB4163478)](https://support.microsoft.com/help/4163478) | SQL Server Engine | Query Optimizer | Windows |
| <a id="11990171">[11990171](#11990171)</a> | [FIX: An assertion error may occur when you query dm_db_stats_histogram DMF in SQL Server 2017 (KB4316655)](https://support.microsoft.com/help/4316655) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12044555">[12044555](#12044555)</a> | [FIX: Access violation occurs when you compile a query and histogram amendment is enabled with default Cardinality Estimation in SQL Server 2017 (KB4316948)](https://support.microsoft.com/help/4316948) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12059522">[12059522](#12059522)</a> | [FIX: SQL Server crashes and then restarts when the "Adaptive join" option is enabled (KB4338337)](https://support.microsoft.com/help/4338337) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12100858">[12100858](#12100858)</a> | [FIX: CASE expressions containing identical sub-queries may return incorrect results in SQL Server 2017 (KB4338330)](https://support.microsoft.com/help/4338330) | SQL Server Engine | Query Optimizer | All |
| <a id="11983950">[11983950](#11983950)</a> | [FIX: Change tracking record is inconsistent during an update on a table that has a clustered or unique index in SQL Server (KB4135113)](https://support.microsoft.com/help/4135113) | SQL Server Engine | Replication | Windows |
| <a id="11983935">[11983935](#11983935)</a> | [FIX: Parallel query hangs when a worker thread is aborted in an instance of SQL Server (KB4094706)](https://support.microsoft.com/help/4094706) | SQL Server Engine | Search | Windows |
| <a id="11983959">[11983959](#11983959)</a> | [FIX: TDE-enabled backup and restore are slow if the encryption key is stored in an EKM provider in SQL Server (KB4058175)](https://support.microsoft.com/help/4058175) | SQL Server Engine | Security Infrastructure | All |
| <a id="10895916">[10895916](#10895916)</a> | Improvement: Adds Service Broker support for `DBCC CLONEDATABASE` in SQL Server (KB4092075) | SQL Server Engine | Service Broker | All |
| <a id="11983961">[11983961](#11983961)</a> | [FIX: Performance is slow for an Always On AG when you process a read query in SQL Server (KB4163087)](https://support.microsoft.com/help/4163087) | SQL Server Engine | Transaction Services | Windows |
| <a id="12038298">[12038298](#12038298)</a> | [FIX: Error 883 occurs when a database that belongs to an availability group is marked as SUSPECT in SQL Server 2017 on Linux (KB4337645)](https://support.microsoft.com/help/4337645) | SQL Server Engine | Transaction Services | Linux |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU8 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2018/06/sqlserver2017-kb4338363-x64_f32613586a621cacba6d08ea7af0b10e1b5938f6.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4338363-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4338363-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4338363-x64.exe| E81A8CED4FC4FCCBF182B72500D599E3C6C342CCE2111961E88192DDCEC247FD |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.223.1   | 266408    | 13-Jun-18 | 05:32 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.223.1       | 741544    | 13-Jun-18 | 05:32 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.223.1       | 1380520   | 13-Jun-18 | 05:32 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.223.1       | 984232    | 13-Jun-18 | 05:32 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.223.1       | 521384    | 13-Jun-18 | 05:32 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787       | 239328    | 02-May-18 | 01:40 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261    | 180424    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261    | 37584     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261    | 54472     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261    | 107728    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261    | 5223112   | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261    | 26312     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261    | 26824     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261    | 26824     | 13-Jun-18 | 05:36 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261    | 159440    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261    | 84176     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261    | 67280     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261    | 25808     | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151240    | 13-Jun-18 | 05:36 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261    | 13608144  | 13-Jun-18 | 05:36 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272       | 1106088   | 13-Jun-18 | 05:36 | x86      |
| Msmdctr.dll                                        | 2017.140.223.1   | 40104     | 13-Jun-18 | 05:32 | x64      |
| Msmdlocal.dll                                      | 2017.140.223.1   | 40384680  | 13-Jun-18 | 05:26 | x86      |
| Msmdlocal.dll                                      | 2017.140.223.1   | 60707488  | 13-Jun-18 | 05:32 | x64      |
| Msmdpump.dll                                       | 2017.140.223.1   | 9334952   | 13-Jun-18 | 05:32 | x64      |
| Msmdredir.dll                                      | 2017.140.223.1   | 7092384   | 13-Jun-18 | 05:26 | x86      |
| Msmdsrv.exe                                        | 2017.140.223.1   | 60608680  | 13-Jun-18 | 05:32 | x64      |
| Msmgdsrv.dll                                       | 2017.140.223.1   | 7310504   | 13-Jun-18 | 05:26 | x86      |
| Msmgdsrv.dll                                       | 2017.140.223.1   | 9004736   | 13-Jun-18 | 05:32 | x64      |
| Msolap.dll                                         | 2017.140.223.1   | 10258600  | 13-Jun-18 | 05:26 | x64      |
| Msolap.dll                                         | 2017.140.223.1   | 7777448   | 13-Jun-18 | 05:26 | x86      |
| Msolui.dll                                         | 2017.140.223.1   | 287400    | 13-Jun-18 | 05:26 | x86      |
| Msolui.dll                                         | 2017.140.223.1   | 310952    | 13-Jun-18 | 05:32 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261    | 6606536   | 13-Jun-18 | 05:36 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlboot.dll                                        | 2017.140.3029.16 | 196264    | 13-Jun-18 | 23:38 | x64      |
| Sqlceip.exe                                        | 14.0.3029.16     | 253096    | 13-Jun-18 | 20:47 | x86      |
| Sqldumper.exe                                      | 2017.140.3029.16 | 140960    | 13-Jun-18 | 19:58 | x64      |
| Sqldumper.exe                                      | 2017.140.3029.16 | 119464    | 13-Jun-18 | 23:46 | x86      |
| Tmapi.dll                                          | 2017.140.223.1   | 5821608   | 13-Jun-18 | 05:32 | x64      |
| Tmcachemgr.dll                                     | 2017.140.223.1   | 4164776   | 13-Jun-18 | 05:32 | x64      |
| Tmpersistence.dll                                  | 2017.140.223.1   | 1132192   | 13-Jun-18 | 05:32 | x64      |
| Tmtransactions.dll                                 | 2017.140.223.1   | 1641128   | 13-Jun-18 | 05:32 | x64      |
| Xe.dll                                             | 2017.140.3029.16 | 673448    | 13-Jun-18 | 23:46 | x64      |
| Xmlrw.dll                                          | 2017.140.3029.16 | 257704    | 13-Jun-18 | 20:04 | x86      |
| Xmlrw.dll                                          | 2017.140.3029.16 | 305312    | 13-Jun-18 | 23:46 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3029.16 | 224424    | 13-Jun-18 | 19:39 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3029.16 | 189600    | 13-Jun-18 | 19:47 | x86      |
| Xmsrv.dll                                          | 2017.140.223.1   | 33350816  | 13-Jun-18 | 05:26 | x86      |
| Xmsrv.dll                                          | 2017.140.223.1   | 25375400  | 13-Jun-18 | 05:32 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3029.16 | 180904    | 13-Jun-18 | 23:38 | x64      |
| Batchparser.dll                            | 2017.140.3029.16 | 160424    | 13-Jun-18 | 23:38 | x86      |
| Instapi140.dll                             | 2017.140.3029.16 | 70312     | 13-Jun-18 | 19:33 | x64      |
| Instapi140.dll                             | 2017.140.3029.16 | 61096     | 13-Jun-18 | 23:46 | x86      |
| Isacctchange.dll                           | 2017.140.3029.16 | 30888     | 13-Jun-18 | 23:46 | x64      |
| Isacctchange.dll                           | 2017.140.3029.16 | 29352     | 13-Jun-18 | 23:46 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.223.1       | 1088680   | 13-Jun-18 | 05:26 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.223.1       | 1088704   | 13-Jun-18 | 05:32 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.223.1       | 1381544   | 13-Jun-18 | 05:26 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.223.1       | 741544    | 13-Jun-18 | 05:26 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.223.1       | 741544    | 13-Jun-18 | 05:32 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3029.16     | 37032     | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3029.16 | 82080     | 13-Jun-18 | 19:31 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3029.16 | 78504     | 13-Jun-18 | 23:46 | x86      |
| Msasxpress.dll                             | 2017.140.223.1   | 31912     | 13-Jun-18 | 05:26 | x86      |
| Msasxpress.dll                             | 2017.140.223.1   | 36008     | 13-Jun-18 | 05:32 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3029.16 | 67744     | 13-Jun-18 | 19:48 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3029.16 | 82088     | 13-Jun-18 | 20:46 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqldumper.exe                              | 2017.140.3029.16 | 140960    | 13-Jun-18 | 19:58 | x64      |
| Sqldumper.exe                              | 2017.140.3029.16 | 119464    | 13-Jun-18 | 23:46 | x86      |
| Sqlftacct.dll                              | 2017.140.3029.16 | 62112     | 13-Jun-18 | 20:55 | x64      |
| Sqlftacct.dll                              | 2017.140.3029.16 | 54464     | 13-Jun-18 | 23:46 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 10-May-18 | 01:38 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 10-May-18 | 01:39 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3029.16 | 415912    | 13-Jun-18 | 23:46 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3029.16 | 372392    | 13-Jun-18 | 23:55 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3029.16 | 37536     | 13-Jun-18 | 20:55 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3029.16 | 34984     | 13-Jun-18 | 23:46 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3029.16 | 273056    | 13-Jun-18 | 19:47 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3029.16 | 356008    | 13-Jun-18 | 19:54 | x64      |
| Sqltdiagn.dll                              | 2017.140.3029.16 | 60576     | 13-Jun-18 | 19:30 | x86      |
| Sqltdiagn.dll                              | 2017.140.3029.16 | 67776     | 13-Jun-18 | 23:38 | x64      |
| Svrenumapi140.dll                          | 2017.140.3029.16 | 1173152   | 13-Jun-18 | 19:38 | x64      |
| Svrenumapi140.dll                          | 2017.140.3029.16 | 893600    | 13-Jun-18 | 19:47 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3029.16 | 121000    | 13-Jun-18 | 23:55 | x86      |
| Dreplaycommon.dll              | 2017.140.3029.16 | 698024    | 13-Jun-18 | 23:46 | x86      |
| Dreplayserverps.dll            | 2017.140.3029.16 | 32960     | 13-Jun-18 | 19:42 | x86      |
| Dreplayutil.dll                | 2017.140.3029.16 | 309928    | 13-Jun-18 | 23:46 | x86      |
| Instapi140.dll                 | 2017.140.3029.16 | 70312     | 13-Jun-18 | 19:33 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlresourceloader.dll          | 2017.140.3029.16 | 29352     | 13-Jun-18 | 23:38 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3029.16 | 698024    | 13-Jun-18 | 23:46 | x86      |
| Dreplaycontroller.exe              | 2017.140.3029.16 | 350400    | 13-Jun-18 | 23:55 | x86      |
| Dreplayprocess.dll                 | 2017.140.3029.16 | 171680    | 13-Jun-18 | 23:46 | x86      |
| Dreplayserverps.dll                | 2017.140.3029.16 | 32960     | 13-Jun-18 | 19:42 | x86      |
| Instapi140.dll                     | 2017.140.3029.16 | 70312     | 13-Jun-18 | 19:33 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlresourceloader.dll              | 2017.140.3029.16 | 29352     | 13-Jun-18 | 23:38 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3029.16 | 180904    | 13-Jun-18 | 23:38 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 09-May-18 | 22:59 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 09-May-18 | 22:59 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 09-May-18 | 22:59 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 10-May-18 | 01:46 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3029.16 | 225960    | 13-Jun-18 | 23:46 | x64      |
| Dcexec.exe                                   | 2017.140.3029.16 | 74432     | 13-Jun-18 | 23:55 | x64      |
| Fssres.dll                                   | 2017.140.3029.16 | 89248     | 13-Jun-18 | 20:46 | x64      |
| Hadrres.dll                                  | 2017.140.3029.16 | 187552    | 13-Jun-18 | 20:46 | x64      |
| Hkcompile.dll                                | 2017.140.3029.16 | 1423016   | 13-Jun-18 | 20:46 | x64      |
| Hkengine.dll                                 | 2017.140.3029.16 | 5858464   | 13-Jun-18 | 20:55 | x64      |
| Hkruntime.dll                                | 2017.140.3029.16 | 162984    | 13-Jun-18 | 20:55 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 09-May-18 | 22:59 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.223.1       | 741032    | 13-Jun-18 | 05:32 | x86      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787       | 239328    | 02-May-18 | 01:40 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3029.16     | 237224    | 13-Jun-18 | 21:00 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3029.16     | 79520     | 13-Jun-18 | 20:55 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3029.16 | 71328     | 13-Jun-18 | 19:41 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3029.16 | 65192     | 13-Jun-18 | 20:39 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3029.16 | 152232    | 13-Jun-18 | 20:55 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3029.16 | 159400    | 13-Jun-18 | 20:46 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3029.16 | 303776    | 13-Jun-18 | 20:39 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3029.16 | 74912     | 13-Jun-18 | 20:55 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 09-May-18 | 22:59 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 09-May-18 | 22:59 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 09-May-18 | 22:59 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 09-May-18 | 22:59 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 09-May-18 | 22:59 | x64      |
| Odsole70.dll                                 | 2017.140.3029.16 | 92840     | 13-Jun-18 | 23:46 | x64      |
| Opends60.dll                                 | 2017.140.3029.16 | 32928     | 13-Jun-18 | 23:38 | x64      |
| Qds.dll                                      | 2017.140.3029.16 | 1168040   | 14-Jun-18 | 03:25 | x64      |
| Rsfxft.dll                                   | 2017.140.3029.16 | 34472     | 13-Jun-18 | 19:31 | x64      |
| Secforwarder.dll                             | 2017.140.3029.16 | 37536     | 13-Jun-18 | 20:39 | x64      |
| Sqagtres.dll                                 | 2017.140.3029.16 | 74408     | 13-Jun-18 | 20:55 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlaamss.dll                                 | 2017.140.3029.16 | 90280     | 13-Jun-18 | 21:00 | x64      |
| Sqlaccess.dll                                | 2017.140.3029.16 | 474792    | 13-Jun-18 | 23:46 | x64      |
| Sqlagent.exe                                 | 2017.140.3029.16 | 581288    | 13-Jun-18 | 23:46 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3029.16 | 61088     | 13-Jun-18 | 19:59 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3029.16 | 52904     | 13-Jun-18 | 23:46 | x86      |
| Sqlagentlog.dll                              | 2017.140.3029.16 | 32928     | 13-Jun-18 | 23:38 | x64      |
| Sqlagentmail.dll                             | 2017.140.3029.16 | 53928     | 13-Jun-18 | 23:38 | x64      |
| Sqlboot.dll                                  | 2017.140.3029.16 | 196264    | 13-Jun-18 | 23:38 | x64      |
| Sqlceip.exe                                  | 14.0.3029.16     | 253096    | 13-Jun-18 | 20:47 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3029.16 | 72360     | 13-Jun-18 | 20:04 | x64      |
| Sqlctr140.dll                                | 2017.140.3029.16 | 129184    | 13-Jun-18 | 20:46 | x64      |
| Sqlctr140.dll                                | 2017.140.3029.16 | 111784    | 13-Jun-18 | 23:46 | x86      |
| Sqldk.dll                                    | 2017.140.3029.16 | 2793640   | 14-Jun-18 | 03:25 | x64      |
| Sqldtsss.dll                                 | 2017.140.3029.16 | 107168    | 14-Jun-18 | 00:30 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3289768   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 1444520   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3401384   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3479720   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3586720   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3595424   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3634344   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3778208   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3783848   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3785384   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3912872   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 2035880   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3675304   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3819176   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 4024992   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 2089128   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3915944   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 1497256   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3295400   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3336872   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3365544   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3029.16 | 3212456   | 13-Jun-18 | 20:39 | x64      |
| Sqliosim.com                                 | 2017.140.3029.16 | 313504    | 13-Jun-18 | 20:46 | x64      |
| Sqliosim.exe                                 | 2017.140.3029.16 | 3019944   | 13-Jun-18 | 20:46 | x64      |
| Sqllang.dll                                  | 2017.140.3029.16 | 41233576  | 14-Jun-18 | 03:49 | x64      |
| Sqlmin.dll                                   | 2017.140.3029.16 | 40337568  | 14-Jun-18 | 03:41 | x64      |
| Sqlolapss.dll                                | 2017.140.3029.16 | 107688    | 13-Jun-18 | 20:06 | x64      |
| Sqlos.dll                                    | 2017.140.3029.16 | 26272     | 13-Jun-18 | 20:39 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3029.16 | 67752     | 13-Jun-18 | 20:06 | x64      |
| Sqlrepss.dll                                 | 2017.140.3029.16 | 64168     | 13-Jun-18 | 20:06 | x64      |
| Sqlresld.dll                                 | 2017.140.3029.16 | 30912     | 13-Jun-18 | 20:39 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3029.16 | 32424     | 13-Jun-18 | 19:36 | x64      |
| Sqlscm.dll                                   | 2017.140.3029.16 | 70816     | 13-Jun-18 | 19:37 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3029.16 | 27816     | 13-Jun-18 | 19:41 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3029.16 | 5872808   | 13-Jun-18 | 19:31 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3029.16 | 732832    | 13-Jun-18 | 20:46 | x64      |
| Sqlservr.exe                                 | 2017.140.3029.16 | 487072    | 14-Jun-18 | 03:25 | x64      |
| Sqlsvc.dll                                   | 2017.140.3029.16 | 161440    | 13-Jun-18 | 19:43 | x64      |
| Sqltses.dll                                  | 2017.140.3029.16 | 9537192   | 14-Jun-18 | 03:25 | x64      |
| Sqsrvres.dll                                 | 2017.140.3029.16 | 260256    | 13-Jun-18 | 20:55 | x64      |
| Svl.dll                                      | 2017.140.3029.16 | 154272    | 13-Jun-18 | 20:55 | x64      |
| Xe.dll                                       | 2017.140.3029.16 | 673448    | 13-Jun-18 | 23:46 | x64      |
| Xmlrw.dll                                    | 2017.140.3029.16 | 305312    | 13-Jun-18 | 23:46 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3029.16 | 224424    | 13-Jun-18 | 19:39 | x64      |
| Xpadsi.exe                                   | 2017.140.3029.16 | 89768     | 13-Jun-18 | 20:00 | x64      |
| Xplog70.dll                                  | 2017.140.3029.16 | 75944     | 13-Jun-18 | 23:46 | x64      |
| Xpqueue.dll                                  | 2017.140.3029.16 | 74912     | 13-Jun-18 | 23:46 | x64      |
| Xprepl.dll                                   | 2017.140.3029.16 | 101544    | 13-Jun-18 | 23:46 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3029.16 | 32424     | 13-Jun-18 | 23:46 | x64      |
| Xpstar.dll                                   | 2017.140.3029.16 | 438440    | 13-Jun-18 | 23:46 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3029.16 | 180904    | 13-Jun-18 | 23:38 | x64      |
| Batchparser.dll                                             | 2017.140.3029.16 | 160424    | 13-Jun-18 | 23:38 | x86      |
| Bcp.exe                                                     | 2017.140.3029.16 | 119968    | 13-Jun-18 | 23:46 | x64      |
| Commanddest.dll                                             | 2017.140.3029.16 | 245928    | 13-Jun-18 | 23:46 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3029.16 | 116392    | 13-Jun-18 | 23:46 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3029.16 | 187552    | 13-Jun-18 | 23:46 | x64      |
| Distrib.exe                                                 | 2017.140.3029.16 | 202432    | 13-Jun-18 | 20:18 | x64      |
| Dteparse.dll                                                | 2017.140.3029.16 | 111272    | 13-Jun-18 | 23:46 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dtepkg.dll                                                  | 2017.140.3029.16 | 137896    | 13-Jun-18 | 23:46 | x64      |
| Dtexec.exe                                                  | 2017.140.3029.16 | 73888     | 13-Jun-18 | 23:55 | x64      |
| Dts.dll                                                     | 2017.140.3029.16 | 2998952   | 13-Jun-18 | 23:55 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3029.16 | 475296    | 13-Jun-18 | 23:46 | x64      |
| Dtsconn.dll                                                 | 2017.140.3029.16 | 497320    | 13-Jun-18 | 23:46 | x64      |
| Dtshost.exe                                                 | 2017.140.3029.16 | 103584    | 13-Jun-18 | 23:46 | x64      |
| Dtslog.dll                                                  | 2017.140.3029.16 | 120488    | 13-Jun-18 | 23:46 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3029.16 | 545448    | 13-Jun-18 | 23:46 | x64      |
| Dtspipeline.dll                                             | 2017.140.3029.16 | 1266344   | 13-Jun-18 | 23:55 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3029.16 | 48296     | 13-Jun-18 | 23:46 | x64      |
| Dtuparse.dll                                                | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dtutil.exe                                                  | 2017.140.3029.16 | 147104    | 13-Jun-18 | 23:55 | x64      |
| Exceldest.dll                                               | 2017.140.3029.16 | 260768    | 13-Jun-18 | 23:46 | x64      |
| Excelsrc.dll                                                | 2017.140.3029.16 | 282792    | 13-Jun-18 | 23:46 | x64      |
| Execpackagetask.dll                                         | 2017.140.3029.16 | 168104    | 13-Jun-18 | 23:46 | x64      |
| Flatfiledest.dll                                            | 2017.140.3029.16 | 386728    | 13-Jun-18 | 23:46 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3029.16 | 399016    | 13-Jun-18 | 23:46 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3029.16 | 96424     | 13-Jun-18 | 23:46 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3029.16 | 59552     | 13-Jun-18 | 20:46 | x64      |
| Logread.exe                                                 | 2017.140.3029.16 | 635048    | 13-Jun-18 | 20:00 | x64      |
| Mergetxt.dll                                                | 2017.140.3029.16 | 63144     | 13-Jun-18 | 19:49 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.223.1       | 1381544   | 13-Jun-18 | 05:32 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 02-May-18 | 00:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3029.16     | 89768     | 14-Jun-18 | 00:12 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3029.16 | 1662632   | 13-Jun-18 | 20:39 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3029.16 | 152232    | 13-Jun-18 | 20:55 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3029.16 | 159400    | 13-Jun-18 | 20:46 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3029.16 | 103080    | 13-Jun-18 | 23:46 | x64      |
| Msgprox.dll                                                 | 2017.140.3029.16 | 270504    | 13-Jun-18 | 20:18 | x64      |
| Msxmlsql.dll                                                | 2017.140.3029.16 | 1448104   | 13-Jun-18 | 20:39 | x64      |
| Oledbdest.dll                                               | 2017.140.3029.16 | 261288    | 13-Jun-18 | 23:46 | x64      |
| Oledbsrc.dll                                                | 2017.140.3029.16 | 288936    | 13-Jun-18 | 23:46 | x64      |
| Osql.exe                                                    | 2017.140.3029.16 | 75432     | 13-Jun-18 | 23:46 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3029.16 | 473792    | 13-Jun-18 | 20:39 | x64      |
| Rawdest.dll                                                 | 2017.140.3029.16 | 206504    | 13-Jun-18 | 23:55 | x64      |
| Rawsource.dll                                               | 2017.140.3029.16 | 194216    | 13-Jun-18 | 23:46 | x64      |
| Rdistcom.dll                                                | 2017.140.3029.16 | 856232    | 13-Jun-18 | 19:41 | x64      |
| Recordsetdest.dll                                           | 2017.140.3029.16 | 184488    | 13-Jun-18 | 23:46 | x64      |
| Replagnt.dll                                                | 2017.140.3029.16 | 30888     | 13-Jun-18 | 20:39 | x64      |
| Repldp.dll                                                  | 2017.140.3029.16 | 290472    | 13-Jun-18 | 20:04 | x64      |
| Replerrx.dll                                                | 2017.140.3029.16 | 154272    | 13-Jun-18 | 20:07 | x64      |
| Replisapi.dll                                               | 2017.140.3029.16 | 361640    | 13-Jun-18 | 19:53 | x64      |
| Replmerg.exe                                                | 2017.140.3029.16 | 524968    | 13-Jun-18 | 19:47 | x64      |
| Replprov.dll                                                | 2017.140.3029.16 | 801440    | 13-Jun-18 | 20:04 | x64      |
| Replrec.dll                                                 | 2017.140.3029.16 | 975016    | 13-Jun-18 | 23:46 | x64      |
| Replsub.dll                                                 | 2017.140.3029.16 | 445608    | 13-Jun-18 | 20:39 | x64      |
| Replsync.dll                                                | 2017.140.3029.16 | 153760    | 13-Jun-18 | 19:37 | x64      |
| Spresolv.dll                                                | 2017.140.3029.16 | 252072    | 13-Jun-18 | 20:12 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3029.16 | 248992    | 13-Jun-18 | 23:46 | x64      |
| Sqldiag.exe                                                 | 2017.140.3029.16 | 1257640   | 13-Jun-18 | 20:04 | x64      |
| Sqldistx.dll                                                | 2017.140.3029.16 | 224928    | 13-Jun-18 | 20:46 | x64      |
| Sqllogship.exe                                              | 14.0.3029.16     | 105640    | 13-Jun-18 | 23:46 | x64      |
| Sqlmergx.dll                                                | 2017.140.3029.16 | 360608    | 13-Jun-18 | 19:49 | x64      |
| Sqlresld.dll                                                | 2017.140.3029.16 | 28864     | 13-Jun-18 | 20:04 | x86      |
| Sqlresld.dll                                                | 2017.140.3029.16 | 30912     | 13-Jun-18 | 20:39 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3029.16 | 32424     | 13-Jun-18 | 19:36 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3029.16 | 29352     | 13-Jun-18 | 23:38 | x86      |
| Sqlscm.dll                                                  | 2017.140.3029.16 | 70816     | 13-Jun-18 | 19:37 | x64      |
| Sqlscm.dll                                                  | 2017.140.3029.16 | 60072     | 13-Jun-18 | 23:46 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3029.16 | 161440    | 13-Jun-18 | 19:43 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3029.16 | 134824    | 13-Jun-18 | 23:46 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3029.16 | 183976    | 13-Jun-18 | 23:46 | x64      |
| Sqlwep140.dll                                               | 2017.140.3029.16 | 105632    | 13-Jun-18 | 23:38 | x64      |
| Ssdebugps.dll                                               | 2017.140.3029.16 | 33440     | 13-Jun-18 | 20:46 | x64      |
| Ssisoledb.dll                                               | 2017.140.3029.16 | 216224    | 13-Jun-18 | 23:46 | x64      |
| Ssradd.dll                                                  | 2017.140.3029.16 | 74920     | 13-Jun-18 | 20:04 | x64      |
| Ssravg.dll                                                  | 2017.140.3029.16 | 74920     | 13-Jun-18 | 19:52 | x64      |
| Ssrdown.dll                                                 | 2017.140.3029.16 | 60064     | 13-Jun-18 | 19:47 | x64      |
| Ssrmax.dll                                                  | 2017.140.3029.16 | 72864     | 13-Jun-18 | 19:47 | x64      |
| Ssrmin.dll                                                  | 2017.140.3029.16 | 73384     | 13-Jun-18 | 19:47 | x64      |
| Ssrpub.dll                                                  | 2017.140.3029.16 | 60576     | 13-Jun-18 | 20:55 | x64      |
| Ssrup.dll                                                   | 2017.140.3029.16 | 60064     | 13-Jun-18 | 19:47 | x64      |
| Txagg.dll                                                   | 2017.140.3029.16 | 362152    | 13-Jun-18 | 23:46 | x64      |
| Txbdd.dll                                                   | 2017.140.3029.16 | 170152    | 13-Jun-18 | 23:46 | x64      |
| Txdatacollector.dll                                         | 2017.140.3029.16 | 360616    | 13-Jun-18 | 23:46 | x64      |
| Txdataconvert.dll                                           | 2017.140.3029.16 | 293032    | 13-Jun-18 | 23:46 | x64      |
| Txderived.dll                                               | 2017.140.3029.16 | 604328    | 13-Jun-18 | 23:46 | x64      |
| Txlookup.dll                                                | 2017.140.3029.16 | 528040    | 13-Jun-18 | 23:46 | x64      |
| Txmerge.dll                                                 | 2017.140.3029.16 | 231592    | 13-Jun-18 | 23:46 | x64      |
| Txmergejoin.dll                                             | 2017.140.3029.16 | 275624    | 13-Jun-18 | 23:46 | x64      |
| Txmulticast.dll                                             | 2017.140.3029.16 | 127656    | 13-Jun-18 | 23:46 | x64      |
| Txrowcount.dll                                              | 2017.140.3029.16 | 125608    | 13-Jun-18 | 23:46 | x64      |
| Txsort.dll                                                  | 2017.140.3029.16 | 256680    | 13-Jun-18 | 23:46 | x64      |
| Txsplit.dll                                                 | 2017.140.3029.16 | 596648    | 13-Jun-18 | 23:46 | x64      |
| Txunionall.dll                                              | 2017.140.3029.16 | 181928    | 13-Jun-18 | 23:46 | x64      |
| Xe.dll                                                      | 2017.140.3029.16 | 673448    | 13-Jun-18 | 23:46 | x64      |
| Xmlrw.dll                                                   | 2017.140.3029.16 | 305312    | 13-Jun-18 | 23:46 | x64      |
| Xmlsub.dll                                                  | 2017.140.3029.16 | 260768    | 13-Jun-18 | 19:48 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3029.16 | 1124000   | 13-Jun-18 | 21:11 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlsatellite.dll              | 2017.140.3029.16 | 922272    | 13-Jun-18 | 21:06 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3029.16 | 667304    | 13-Jun-18 | 23:55 | x64      |
| Fdhost.exe               | 2017.140.3029.16 | 114344    | 13-Jun-18 | 23:55 | x64      |
| Fdlauncher.exe           | 2017.140.3029.16 | 62112     | 13-Jun-18 | 23:46 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlft140ph.dll           | 2017.140.3029.16 | 67752     | 13-Jun-18 | 19:32 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3029.16     | 23720     | 13-Jun-18 | 19:36 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 02-May-18 | 00:56 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 02-May-18 | 00:56 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 02-May-18 | 00:56 | x86      |
| Commanddest.dll                                               | 2017.140.3029.16 | 245928    | 13-Jun-18 | 23:46 | x64      |
| Commanddest.dll                                               | 2017.140.3029.16 | 200872    | 13-Jun-18 | 23:55 | x86      |
| Dteparse.dll                                                  | 2017.140.3029.16 | 111272    | 13-Jun-18 | 23:46 | x64      |
| Dteparse.dll                                                  | 2017.140.3029.16 | 100520    | 13-Jun-18 | 23:46 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3029.16 | 83616     | 13-Jun-18 | 23:46 | x86      |
| Dtepkg.dll                                                    | 2017.140.3029.16 | 137896    | 13-Jun-18 | 23:46 | x64      |
| Dtepkg.dll                                                    | 2017.140.3029.16 | 116904    | 13-Jun-18 | 23:55 | x86      |
| Dtexec.exe                                                    | 2017.140.3029.16 | 73888     | 13-Jun-18 | 23:55 | x64      |
| Dtexec.exe                                                    | 2017.140.3029.16 | 67776     | 13-Jun-18 | 23:55 | x86      |
| Dts.dll                                                       | 2017.140.3029.16 | 2998952   | 13-Jun-18 | 23:55 | x64      |
| Dts.dll                                                       | 2017.140.3029.16 | 2549416   | 13-Jun-18 | 23:55 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3029.16 | 475296    | 13-Jun-18 | 23:46 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3029.16 | 417960    | 13-Jun-18 | 23:55 | x86      |
| Dtsconn.dll                                                   | 2017.140.3029.16 | 497320    | 13-Jun-18 | 23:46 | x64      |
| Dtsconn.dll                                                   | 2017.140.3029.16 | 399528    | 13-Jun-18 | 23:46 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3029.16 | 95424     | 13-Jun-18 | 23:46 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3029.16 | 111272    | 13-Jun-18 | 23:55 | x64      |
| Dtshost.exe                                                   | 2017.140.3029.16 | 103584    | 13-Jun-18 | 23:46 | x64      |
| Dtshost.exe                                                   | 2017.140.3029.16 | 89768     | 13-Jun-18 | 23:55 | x86      |
| Dtslog.dll                                                    | 2017.140.3029.16 | 120488    | 13-Jun-18 | 23:46 | x64      |
| Dtslog.dll                                                    | 2017.140.3029.16 | 103072    | 13-Jun-18 | 23:55 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3029.16 | 545448    | 13-Jun-18 | 23:46 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3029.16 | 541352    | 13-Jun-18 | 23:46 | x86      |
| Dtspipeline.dll                                               | 2017.140.3029.16 | 1266344   | 13-Jun-18 | 23:55 | x64      |
| Dtspipeline.dll                                               | 2017.140.3029.16 | 1059496   | 13-Jun-18 | 23:55 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3029.16 | 48296     | 13-Jun-18 | 23:46 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3029.16 | 42664     | 13-Jun-18 | 23:46 | x86      |
| Dtuparse.dll                                                  | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dtuparse.dll                                                  | 2017.140.3029.16 | 80040     | 13-Jun-18 | 23:46 | x86      |
| Dtutil.exe                                                    | 2017.140.3029.16 | 147104    | 13-Jun-18 | 23:55 | x64      |
| Dtutil.exe                                                    | 2017.140.3029.16 | 126120    | 13-Jun-18 | 23:55 | x86      |
| Exceldest.dll                                                 | 2017.140.3029.16 | 260768    | 13-Jun-18 | 23:46 | x64      |
| Exceldest.dll                                                 | 2017.140.3029.16 | 214696    | 13-Jun-18 | 23:46 | x86      |
| Excelsrc.dll                                                  | 2017.140.3029.16 | 282792    | 13-Jun-18 | 23:46 | x64      |
| Excelsrc.dll                                                  | 2017.140.3029.16 | 230568    | 13-Jun-18 | 23:46 | x86      |
| Execpackagetask.dll                                           | 2017.140.3029.16 | 168104    | 13-Jun-18 | 23:46 | x64      |
| Execpackagetask.dll                                           | 2017.140.3029.16 | 135336    | 13-Jun-18 | 23:46 | x86      |
| Flatfiledest.dll                                              | 2017.140.3029.16 | 386728    | 13-Jun-18 | 23:46 | x64      |
| Flatfiledest.dll                                              | 2017.140.3029.16 | 332968    | 13-Jun-18 | 23:55 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3029.16 | 399016    | 13-Jun-18 | 23:46 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3029.16 | 344224    | 13-Jun-18 | 23:55 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3029.16 | 96424     | 13-Jun-18 | 23:46 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3029.16 | 80552     | 13-Jun-18 | 23:46 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3029.16     | 466592    | 14-Jun-18 | 00:37 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3029.16     | 467112    | 14-Jun-18 | 00:47 | x86      |
| Isserverexec.exe                                              | 14.0.3029.16     | 149160    | 14-Jun-18 | 00:04 | x86      |
| Isserverexec.exe                                              | 14.0.3029.16     | 148648    | 14-Jun-18 | 00:12 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.223.1       | 1381544   | 13-Jun-18 | 05:26 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.223.1       | 1381544   | 13-Jun-18 | 05:32 | x86      |
| Microsoft.applicationinsights.dll                             | 2.6.0.6787       | 239328    | 02-May-18 | 01:40 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 02-May-18 | 00:56 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3029.16     | 71328     | 14-Jun-18 | 00:04 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3029.16 | 112288    | 13-Jun-18 | 23:46 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3029.16 | 107176    | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3029.16     | 89768     | 14-Jun-18 | 00:04 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3029.16     | 89768     | 14-Jun-18 | 00:12 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3029.16     | 494760    | 13-Jun-18 | 20:32 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3029.16     | 494760    | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3029.16     | 83624     | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3029.16     | 83616     | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3029.16     | 415912    | 14-Jun-18 | 00:37 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3029.16     | 415912    | 14-Jun-18 | 00:47 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3029.16     | 252584    | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3029.16     | 252584    | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3029.16 | 152232    | 13-Jun-18 | 20:55 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3029.16 | 141992    | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3029.16 | 159400    | 13-Jun-18 | 20:46 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3029.16 | 145600    | 13-Jun-18 | 23:46 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3029.16     | 219808    | 14-Jun-18 | 00:04 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3029.16 | 103080    | 13-Jun-18 | 23:46 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3029.16 | 90280     | 13-Jun-18 | 23:46 | x86      |
| Msmdpp.dll                                                    | 2017.140.223.1   | 9194152   | 13-Jun-18 | 05:32 | x64      |
| Oledbdest.dll                                                 | 2017.140.3029.16 | 261288    | 13-Jun-18 | 23:46 | x64      |
| Oledbdest.dll                                                 | 2017.140.3029.16 | 214696    | 13-Jun-18 | 23:46 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3029.16 | 288936    | 13-Jun-18 | 23:46 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3029.16 | 233128    | 13-Jun-18 | 23:55 | x86      |
| Rawdest.dll                                                   | 2017.140.3029.16 | 206504    | 13-Jun-18 | 23:55 | x64      |
| Rawdest.dll                                                   | 2017.140.3029.16 | 166560    | 13-Jun-18 | 23:55 | x86      |
| Rawsource.dll                                                 | 2017.140.3029.16 | 194216    | 13-Jun-18 | 23:46 | x64      |
| Rawsource.dll                                                 | 2017.140.3029.16 | 153248    | 13-Jun-18 | 23:46 | x86      |
| Recordsetdest.dll                                             | 2017.140.3029.16 | 184488    | 13-Jun-18 | 23:46 | x64      |
| Recordsetdest.dll                                             | 2017.140.3029.16 | 149160    | 13-Jun-18 | 23:46 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlceip.exe                                                   | 14.0.3029.16     | 253096    | 13-Jun-18 | 20:47 | x86      |
| Sqldest.dll                                                   | 2017.140.3029.16 | 260776    | 13-Jun-18 | 23:46 | x64      |
| Sqldest.dll                                                   | 2017.140.3029.16 | 213672    | 13-Jun-18 | 23:55 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3029.16 | 183976    | 13-Jun-18 | 23:46 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3029.16 | 155304    | 13-Jun-18 | 23:55 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3029.16 | 216224    | 13-Jun-18 | 23:46 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3029.16 | 176832    | 13-Jun-18 | 23:46 | x86      |
| Txagg.dll                                                     | 2017.140.3029.16 | 362152    | 13-Jun-18 | 23:46 | x64      |
| Txagg.dll                                                     | 2017.140.3029.16 | 302248    | 13-Jun-18 | 23:55 | x86      |
| Txbdd.dll                                                     | 2017.140.3029.16 | 170152    | 13-Jun-18 | 23:46 | x64      |
| Txbdd.dll                                                     | 2017.140.3029.16 | 136360    | 13-Jun-18 | 23:55 | x86      |
| Txbestmatch.dll                                               | 2017.140.3029.16 | 605352    | 13-Jun-18 | 23:55 | x64      |
| Txbestmatch.dll                                               | 2017.140.3029.16 | 493224    | 13-Jun-18 | 23:55 | x86      |
| Txcache.dll                                                   | 2017.140.3029.16 | 180392    | 13-Jun-18 | 23:46 | x64      |
| Txcache.dll                                                   | 2017.140.3029.16 | 146088    | 13-Jun-18 | 23:46 | x86      |
| Txcharmap.dll                                                 | 2017.140.3029.16 | 286888    | 13-Jun-18 | 23:46 | x64      |
| Txcharmap.dll                                                 | 2017.140.3029.16 | 249000    | 13-Jun-18 | 23:55 | x86      |
| Txcopymap.dll                                                 | 2017.140.3029.16 | 180392    | 13-Jun-18 | 23:46 | x64      |
| Txcopymap.dll                                                 | 2017.140.3029.16 | 145576    | 13-Jun-18 | 23:46 | x86      |
| Txdataconvert.dll                                             | 2017.140.3029.16 | 293032    | 13-Jun-18 | 23:46 | x64      |
| Txdataconvert.dll                                             | 2017.140.3029.16 | 253096    | 13-Jun-18 | 23:55 | x86      |
| Txderived.dll                                                 | 2017.140.3029.16 | 604328    | 13-Jun-18 | 23:46 | x64      |
| Txderived.dll                                                 | 2017.140.3029.16 | 515752    | 13-Jun-18 | 23:55 | x86      |
| Txfileextractor.dll                                           | 2017.140.3029.16 | 160936    | 13-Jun-18 | 23:46 | x86      |
| Txfileextractor.dll                                           | 2017.140.3029.16 | 198824    | 13-Jun-18 | 23:55 | x64      |
| Txfileinserter.dll                                            | 2017.140.3029.16 | 196776    | 13-Jun-18 | 23:46 | x64      |
| Txfileinserter.dll                                            | 2017.140.3029.16 | 159400    | 13-Jun-18 | 23:55 | x86      |
| Txgroupdups.dll                                               | 2017.140.3029.16 | 290496    | 13-Jun-18 | 23:46 | x64      |
| Txgroupdups.dll                                               | 2017.140.3029.16 | 231080    | 13-Jun-18 | 23:55 | x86      |
| Txlineage.dll                                                 | 2017.140.3029.16 | 136872    | 13-Jun-18 | 23:46 | x64      |
| Txlineage.dll                                                 | 2017.140.3029.16 | 110240    | 13-Jun-18 | 23:55 | x86      |
| Txlookup.dll                                                  | 2017.140.3029.16 | 528040    | 13-Jun-18 | 23:46 | x64      |
| Txlookup.dll                                                  | 2017.140.3029.16 | 446632    | 13-Jun-18 | 23:55 | x86      |
| Txmerge.dll                                                   | 2017.140.3029.16 | 231592    | 13-Jun-18 | 23:46 | x64      |
| Txmerge.dll                                                   | 2017.140.3029.16 | 176808    | 13-Jun-18 | 23:46 | x86      |
| Txmergejoin.dll                                               | 2017.140.3029.16 | 275624    | 13-Jun-18 | 23:46 | x64      |
| Txmergejoin.dll                                               | 2017.140.3029.16 | 221856    | 13-Jun-18 | 23:55 | x86      |
| Txmulticast.dll                                               | 2017.140.3029.16 | 127656    | 13-Jun-18 | 23:46 | x64      |
| Txmulticast.dll                                               | 2017.140.3029.16 | 103104    | 13-Jun-18 | 23:46 | x86      |
| Txpivot.dll                                                   | 2017.140.3029.16 | 224936    | 13-Jun-18 | 23:46 | x64      |
| Txpivot.dll                                                   | 2017.140.3029.16 | 180384    | 13-Jun-18 | 23:55 | x86      |
| Txrowcount.dll                                                | 2017.140.3029.16 | 125608    | 13-Jun-18 | 23:46 | x64      |
| Txrowcount.dll                                                | 2017.140.3029.16 | 101568    | 13-Jun-18 | 23:55 | x86      |
| Txsampling.dll                                                | 2017.140.3029.16 | 172704    | 13-Jun-18 | 23:46 | x64      |
| Txsampling.dll                                                | 2017.140.3029.16 | 135848    | 13-Jun-18 | 23:46 | x86      |
| Txscd.dll                                                     | 2017.140.3029.16 | 220840    | 13-Jun-18 | 23:46 | x64      |
| Txscd.dll                                                     | 2017.140.3029.16 | 170144    | 13-Jun-18 | 23:55 | x86      |
| Txsort.dll                                                    | 2017.140.3029.16 | 256680    | 13-Jun-18 | 23:46 | x64      |
| Txsort.dll                                                    | 2017.140.3029.16 | 208064    | 13-Jun-18 | 23:46 | x86      |
| Txsplit.dll                                                   | 2017.140.3029.16 | 596648    | 13-Jun-18 | 23:46 | x64      |
| Txsplit.dll                                                   | 2017.140.3029.16 | 510632    | 13-Jun-18 | 23:55 | x86      |
| Txtermextraction.dll                                          | 2017.140.3029.16 | 8676512   | 13-Jun-18 | 23:55 | x64      |
| Txtermextraction.dll                                          | 2017.140.3029.16 | 8615080   | 13-Jun-18 | 23:55 | x86      |
| Txtermlookup.dll                                              | 2017.140.3029.16 | 4157096   | 13-Jun-18 | 23:46 | x64      |
| Txtermlookup.dll                                              | 2017.140.3029.16 | 4106920   | 13-Jun-18 | 23:55 | x86      |
| Txunionall.dll                                                | 2017.140.3029.16 | 181928    | 13-Jun-18 | 23:46 | x64      |
| Txunionall.dll                                                | 2017.140.3029.16 | 139424    | 13-Jun-18 | 23:46 | x86      |
| Txunpivot.dll                                                 | 2017.140.3029.16 | 199848    | 13-Jun-18 | 23:46 | x64      |
| Txunpivot.dll                                                 | 2017.140.3029.16 | 160416    | 13-Jun-18 | 23:46 | x86      |
| Xe.dll                                                        | 2017.140.3029.16 | 595624    | 13-Jun-18 | 20:06 | x86      |
| Xe.dll                                                        | 2017.140.3029.16 | 673448    | 13-Jun-18 | 23:46 | x64      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 10-May-18 | 04:42 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 10-May-18 | 04:42 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 10-May-18 | 04:42 | x86      |
| Instapi140.dll                                                       | 2017.140.3029.16 | 70312     | 13-Jun-18 | 19:33 | x64      |
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
| Mpdwinterop.dll                                                      | 2017.140.3029.16 | 407208    | 13-Jun-18 | 20:46 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3029.16 | 7324328   | 14-Jun-18 | 00:12 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3029.16 | 2263208   | 13-Jun-18 | 23:46 | x64      |
| Secforwarder.dll                                                     | 2017.140.3029.16 | 37536     | 13-Jun-18 | 20:39 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 10-May-18 | 01:29 | x64      |
| Sqldk.dll                                                            | 2017.140.3029.16 | 2711040   | 13-Jun-18 | 20:47 | x64      |
| Sqldumper.exe                                                        | 2017.140.3029.16 | 140960    | 13-Jun-18 | 19:58 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 1497256   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3912872   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3212456   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3915944   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3819176   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 2089128   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 2035880   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3586720   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3595424   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 1444520   | 13-Jun-18 | 20:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3029.16 | 3783848   | 13-Jun-18 | 20:39 | x64      |
| Sqlos.dll                                                            | 2017.140.3029.16 | 26272     | 13-Jun-18 | 20:39 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 10-May-18 | 04:42 | x64      |
| Sqltses.dll                                                          | 2017.140.3029.16 | 9690624   | 13-Jun-18 | 20:55 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3029.16     | 23712     | 13-Jun-18 | 19:52 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3029.16 | 1448616   | 13-Jun-18 | 23:55 | x86      |
| Dtaengine.exe                                          | 2017.140.3029.16 | 204456    | 13-Jun-18 | 23:55 | x86      |
| Dteparse.dll                                           | 2017.140.3029.16 | 111272    | 13-Jun-18 | 23:46 | x64      |
| Dteparse.dll                                           | 2017.140.3029.16 | 100520    | 13-Jun-18 | 23:46 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3029.16 | 83616     | 13-Jun-18 | 23:46 | x86      |
| Dtepkg.dll                                             | 2017.140.3029.16 | 137896    | 13-Jun-18 | 23:46 | x64      |
| Dtepkg.dll                                             | 2017.140.3029.16 | 116904    | 13-Jun-18 | 23:55 | x86      |
| Dtexec.exe                                             | 2017.140.3029.16 | 73888     | 13-Jun-18 | 23:55 | x64      |
| Dtexec.exe                                             | 2017.140.3029.16 | 67776     | 13-Jun-18 | 23:55 | x86      |
| Dts.dll                                                | 2017.140.3029.16 | 2998952   | 13-Jun-18 | 23:55 | x64      |
| Dts.dll                                                | 2017.140.3029.16 | 2549416   | 13-Jun-18 | 23:55 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3029.16 | 475296    | 13-Jun-18 | 23:46 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3029.16 | 417960    | 13-Jun-18 | 23:55 | x86      |
| Dtsconn.dll                                            | 2017.140.3029.16 | 497320    | 13-Jun-18 | 23:46 | x64      |
| Dtsconn.dll                                            | 2017.140.3029.16 | 399528    | 13-Jun-18 | 23:46 | x86      |
| Dtshost.exe                                            | 2017.140.3029.16 | 103584    | 13-Jun-18 | 23:46 | x64      |
| Dtshost.exe                                            | 2017.140.3029.16 | 89768     | 13-Jun-18 | 23:55 | x86      |
| Dtslog.dll                                             | 2017.140.3029.16 | 120488    | 13-Jun-18 | 23:46 | x64      |
| Dtslog.dll                                             | 2017.140.3029.16 | 103072    | 13-Jun-18 | 23:55 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3029.16 | 545448    | 13-Jun-18 | 23:46 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3029.16 | 541352    | 13-Jun-18 | 23:46 | x86      |
| Dtspipeline.dll                                        | 2017.140.3029.16 | 1266344   | 13-Jun-18 | 23:55 | x64      |
| Dtspipeline.dll                                        | 2017.140.3029.16 | 1059496   | 13-Jun-18 | 23:55 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3029.16 | 48296     | 13-Jun-18 | 23:46 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3029.16 | 42664     | 13-Jun-18 | 23:46 | x86      |
| Dtuparse.dll                                           | 2017.140.3029.16 | 89256     | 13-Jun-18 | 23:46 | x64      |
| Dtuparse.dll                                           | 2017.140.3029.16 | 80040     | 13-Jun-18 | 23:46 | x86      |
| Dtutil.exe                                             | 2017.140.3029.16 | 147104    | 13-Jun-18 | 23:55 | x64      |
| Dtutil.exe                                             | 2017.140.3029.16 | 126120    | 13-Jun-18 | 23:55 | x86      |
| Exceldest.dll                                          | 2017.140.3029.16 | 260768    | 13-Jun-18 | 23:46 | x64      |
| Exceldest.dll                                          | 2017.140.3029.16 | 214696    | 13-Jun-18 | 23:46 | x86      |
| Excelsrc.dll                                           | 2017.140.3029.16 | 282792    | 13-Jun-18 | 23:46 | x64      |
| Excelsrc.dll                                           | 2017.140.3029.16 | 230568    | 13-Jun-18 | 23:46 | x86      |
| Flatfiledest.dll                                       | 2017.140.3029.16 | 386728    | 13-Jun-18 | 23:46 | x64      |
| Flatfiledest.dll                                       | 2017.140.3029.16 | 332968    | 13-Jun-18 | 23:55 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3029.16 | 399016    | 13-Jun-18 | 23:46 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3029.16 | 344224    | 13-Jun-18 | 23:55 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3029.16 | 96424     | 13-Jun-18 | 23:46 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3029.16 | 80552     | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3029.16     | 71336     | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3029.16     | 184488    | 14-Jun-18 | 02:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3029.16     | 406720    | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3029.16     | 406696    | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3029.16     | 2093216   | 13-Jun-18 | 23:46 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3029.16     | 2093224   | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3029.16     | 252584    | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3029.16 | 152232    | 13-Jun-18 | 20:55 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3029.16 | 141992    | 13-Jun-18 | 23:55 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3029.16 | 159400    | 13-Jun-18 | 20:46 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3029.16 | 145600    | 13-Jun-18 | 23:46 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3029.16 | 103080    | 13-Jun-18 | 23:46 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3029.16 | 90280     | 13-Jun-18 | 23:46 | x86      |
| Msmgdsrv.dll                                           | 2017.140.223.1   | 7310504   | 13-Jun-18 | 05:26 | x86      |
| Oledbdest.dll                                          | 2017.140.3029.16 | 261288    | 13-Jun-18 | 23:46 | x64      |
| Oledbdest.dll                                          | 2017.140.3029.16 | 214696    | 13-Jun-18 | 23:46 | x86      |
| Oledbsrc.dll                                           | 2017.140.3029.16 | 288936    | 13-Jun-18 | 23:46 | x64      |
| Oledbsrc.dll                                           | 2017.140.3029.16 | 233128    | 13-Jun-18 | 23:55 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3029.16 | 100512    | 13-Jun-18 | 20:39 | x64      |
| Sqlresld.dll                                           | 2017.140.3029.16 | 28864     | 13-Jun-18 | 20:04 | x86      |
| Sqlresld.dll                                           | 2017.140.3029.16 | 30912     | 13-Jun-18 | 20:39 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3029.16 | 32424     | 13-Jun-18 | 19:36 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3029.16 | 29352     | 13-Jun-18 | 23:38 | x86      |
| Sqlscm.dll                                             | 2017.140.3029.16 | 70816     | 13-Jun-18 | 19:37 | x64      |
| Sqlscm.dll                                             | 2017.140.3029.16 | 60072     | 13-Jun-18 | 23:46 | x86      |
| Sqlsvc.dll                                             | 2017.140.3029.16 | 161440    | 13-Jun-18 | 19:43 | x64      |
| Sqlsvc.dll                                             | 2017.140.3029.16 | 134824    | 13-Jun-18 | 23:46 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3029.16 | 183976    | 13-Jun-18 | 23:46 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3029.16 | 155304    | 13-Jun-18 | 23:55 | x86      |
| Txdataconvert.dll                                      | 2017.140.3029.16 | 293032    | 13-Jun-18 | 23:46 | x64      |
| Txdataconvert.dll                                      | 2017.140.3029.16 | 253096    | 13-Jun-18 | 23:55 | x86      |
| Xe.dll                                                 | 2017.140.3029.16 | 595624    | 13-Jun-18 | 20:06 | x86      |
| Xe.dll                                                 | 2017.140.3029.16 | 673448    | 13-Jun-18 | 23:46 | x64      |
| Xmlrw.dll                                              | 2017.140.3029.16 | 257704    | 13-Jun-18 | 20:04 | x86      |
| Xmlrw.dll                                              | 2017.140.3029.16 | 305312    | 13-Jun-18 | 23:46 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3029.16 | 224424    | 13-Jun-18 | 19:39 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3029.16 | 189600    | 13-Jun-18 | 19:47 | x86      |

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
