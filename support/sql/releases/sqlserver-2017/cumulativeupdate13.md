---
title: Cumulative update 13 for SQL Server 2017 (KB4466404)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 13 (KB4466404).
ms.date: 08/04/2023
ms.custom: KB4466404, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4466404 - Cumulative Update 13 for SQL Server 2017

_Release Date:_ &nbsp; December 18, 2018  
_Version:_ &nbsp; 14.0.3048.4

## Summary

This article describes Cumulative Update package 13 (CU13) for Microsoft SQL Server 2017. This update contains 49 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 12, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3048.4**, file version: **2017.140.3048.4**
- Analysis Services - Product version: **14.0.239.1**, file version: **2017.140.239.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12535167">[12535167](#12535167)</a> | [Improvement: IsAvailableInMDX feature can disable processing for specific columns in TREATAS function DAX query in SQL Server 2017 (KB4480634)](https://support.microsoft.com/help/4480634) | Analysis Services | Analysis Services | Windows |
| <a id="12416026">[12416026](#12416026)</a> | [FIX: Designing a parameterized DAX query in Report Builder Query Designer generates an exception in SSAS (KB4470411)](https://support.microsoft.com/help/4470411) | Analysis Services | Analysis Services | Windows |
| <a id="12458033">[12458033](#12458033)</a> | [FIX: Access violation occurs and SSAS crashes when you process an SSAS database in SQL Server 2014, 2016 and 2017 (KB4459981)](https://support.microsoft.com/help/4459981) | Analysis services | Analysis services | Windows |
| <a id="12488513">[12488513](#12488513)</a> | [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2014, 2016 and 2017 Multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032) | Analysis Services | Analysis Services | Windows |
| <a id="12488542">[12488542](#12488542)</a> | [FIX: Can't retrieve ConnectionID and SPID when running an SSAS Profiler trace in SQL Server (KB4456775)](https://support.microsoft.com/help/4456775) | Analysis Services | Analysis Services | Windows |
| <a id="12491221">[12491221](#12491221)</a> | [FIX: Missing logs for Analysis Services Processing tasks in SQL Server 2016 and 2017 Integration Services (KB4055674)](https://support.microsoft.com/help/4055674) | Analysis Services | Analysis Services | Windows |
| <a id="12510015">[12510015](#12510015)</a> | [FIX: "A connection cannot be made" error when SSIS package uses a parameterized connection manager in SQL Server 2016 and 2017 (KB4466831)](https://support.microsoft.com/help/4466831) | Analysis Services | Analysis Services | Windows |
| <a id="12488525">[12488525](#12488525)</a> | FIX: "An unexpected exception occurred" when you run an MDX query after an XMLA query to process a dimension in SSAS (KB4463328) | Analysis Services | Analysis Services | Windows |
| <a id="12422580">[12422580](#12422580)</a> | [Improvement: You can set the minimum interval value to less than 10 seconds for running SSIS packages in parallel in SQL Server 2017 (KB4466491)](https://support.microsoft.com/help/4466491) | Integration Services | ScaleOut | Windows |
| <a id="12456181">[12456181](#12456181)</a> | [FIX: Can't connect to the MDS database by using the MDS Add-in for Microsoft Excel (KB4469292)](https://support.microsoft.com/help/4469292) | Master Data Services | Client | Windows |
| <a id="12536280">[12536280](#12536280)</a> | Improvement: Performance issue when you create or modify entities, attributes, users, or groups when page load permissions are used in SQL Server (KB4480643) | Master Data Services | Server | Windows |
| <a id="12516851">[12516851](#12516851)</a> | [FIX: DCExec crashes when you collect data in SQL Server 2017 (KB4480631)](https://support.microsoft.com/help/4480631) | SQL Server Client Tools | Database Performance Tools | Windows |
| <a id="12431333">[12431333](#12431333)</a> | [FIX: Assertion error occurs during restore of compressed backups in SQL Server 2014, 2016 and 2017 (KB4469554)](https://support.microsoft.com/help/4469554) | SQL Server Engine | Backup Restore | Windows |
| <a id="12466221">[12466221](#12466221)</a> | [FIX: "9003 error, sev 20, state 1" error when a backup operation fails on a secondary replica that is running under asynchronous-commit mode (KB4458880)](https://support.microsoft.com/help/4458880) | SQL Server Engine | Backup Restore | Windows |
| <a id="12487676">[12487676](#12487676)</a> | [FIX: Restore or Restore Verifyonly of a TDE-compressed backup fails with errors 33111 and 3013 in SQL Server 2017 (KB4481148)](https://support.microsoft.com/help/4481148) | SQL Server Engine | Backup Restore | Windows |
| <a id="12491210">[12491210](#12491210)</a> | [FIX: Intermittent failures when you back up to Azure storage from SQL Server (KB4463320)](https://support.microsoft.com/help/4463320) | SQL Server Engine | Backup Restore | Windows |
| <a id="12542123">[12542123](#12542123)</a> | [Improvement: Merge operation will consider the number of deleted rows in the rowgroup in SQL Server 2017 (KB4480651)](https://support.microsoft.com/help/4480651) | SQL Server Engine | Column Stores | All |
| <a id="12429556">[12429556](#12429556)</a> | FIX: Access violation occurs when you query data from a view created on a table with columnstore index in SQL Server 2016 and 2017 (KB4467119) | SQL Server Engine | Column Stores | Windows |
| <a id="12339101">[12339101](#12339101)</a> | [FIX: Query plans are different on clone database created by DBCC CLONEDATABASE and its original database in SQL Server 2016 and 2017 (KB4467058)](https://support.microsoft.com/help/4467058) | SQL Server Engine | DB Management | Windows |
| <a id="12428473">[12428473](#12428473)</a> | [FIX: Internal error messages when you update a FILESTREAM tombstone system table in SQL Server (KB4469722)](https://support.microsoft.com/help/4469722) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12376480">[12376480](#12376480)</a> | [FIX: Primary replica databases display "NOT SYNCHRONIZING" status when all replicas in AG use synchronous commit availability mode in SQL Server 2017 (KB4471213)](https://support.microsoft.com/help/4471213) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12409393">[12409393](#12409393)</a> | [FIX: Pacemaker can't manage cluster resources in an Always On Availability Group in SQL Server (KB4467449)](https://support.microsoft.com/help/4467449) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12478828">[12478828](#12478828)</a> | [FIX: Access violations and unhandled exceptions when you set automatic seeding for secondary replica or Distributed Availability Group replica in SQL Server (KB4457953)](https://support.microsoft.com/help/4457953) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12491228">[12491228](#12491228)</a> | [FIX: "3414" and "9003" errors and a .pmm log file grows large in SQL Server 2016 and 2017 (KB4466994)](https://support.microsoft.com/help/4466994) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="12385495">[12385495](#12385495)</a> | [FIX: Error 18204 during automatic backup in virtual machines when the backup file is split into multiple files (KB4480709)](https://support.microsoft.com/help/4480709) | SQL Server Engine | Management Services | Windows |
| <a id="12488520">[12488520](#12488520)</a> | [FIX: Error occurs when you run sp_send_dbmail stored procedure that contains comma in sender email address and name in SQL Server 2014 and 2017 (KB4346803)](https://support.microsoft.com/help/4346803) | SQL Server Engine | Management Services | Windows |
| <a id="12475370">[12475370](#12475370)</a> | [FIX: DBCC CHECKDB on master database fails with error 2570 when Common Criteria Compliance is enabled in SQL Server 2017 (KB4470821)](https://support.microsoft.com/help/4470821) | SQL Server Engine | Metadata | Windows |
| <a id="12549350">[12549350](#12549350)</a> | [FIX: ObjectPropertyEx returns incorrect row count when there are partitions in a database object (KB4480648)](https://support.microsoft.com/help/4480648) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="12481579">[12481579](#12481579)</a> | FIX: The "`modification_counter`" in DMV `sys.dm_db_stats_properties` shows incorrect value when partitions are merged through `ALTER PARTITION` in SQL Server 2016 and 2017 (KB4465443) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="12373379">[12373379](#12373379)</a> | [FIX: Error occurs when you run a query that includes a Boolean field against PolyBase external tables in SQL Server 2017 (KB4480653)](https://support.microsoft.com/help/4480653) | SQL Server Engine | PolyBase | Windows |
| <a id="12342904">[12342904](#12342904)</a> | [FIX: Excessive memory usage when you trace RPC events that involve Table-Valued Parameters in SQL Server 2016 and 2017 (KB4468102)](https://support.microsoft.com/help/4468102) | SQL Server Engine | Programmability | All |
| <a id="12521739">[12521739](#12521739)</a> | [FIX: QRY_PROFILE_LIST_MUTEX is blocked when TF 7412 is enabled in SQL Server 2016 and 2017 (KB4089239)](https://support.microsoft.com/help/4089239) | SQL Server Engine | Query Execution | All |
| <a id="12495967">[12495967](#12495967)</a> | FIX: Assertion error occurs when you use `sys.dm_exec_query_statistics_xml` in SQL Server 2016 and 2017 (KB4458157) | SQL Server Engine | Query Execution | Windows |
| <a id="12347608">[12347608](#12347608)</a> | [Improvement: Enhancement adds sql_statement_post_compile extended event in SQL Server 2017 (KB4480630)](https://support.microsoft.com/help/4480630) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12458029">[12458029](#12458029)</a> | [FIX: Overestimations when using default Cardinality Estimator to query table with many null values (KB4460116)](https://support.microsoft.com/help/4460116) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12488561">[12488561](#12488561)</a> | FIX: Slow query performance occurs when you use `NULL` filters on Partition Key with default CE in SQL Server 2016 and 2017 (KB4459522) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12545511">[12545511](#12545511)</a> | [FIX: A dump file may be generated when you run the DML internal plan on Query Store enabled database in SQL Server 2017 (KB4480644)](https://support.microsoft.com/help/4480644) | SQL Server Engine | Query Store | All |
| <a id="12546696">[12546696](#12546696)</a> | [FIX: Access violation when you query by using "sys.dm_db_tuning_recommendations" in SQL Server (KB4480645)](https://support.microsoft.com/help/4480645) | SQL Server Engine | Query Store | All |
| <a id="12458045">[12458045](#12458045)</a> | [FIX: "ran out of memory" error when executing a query on a table that has a large full-text index in SQL Server 2014, 2016 and 2017 (KB4465867)](https://support.microsoft.com/help/4465867) | SQL Server Engine | Search | Windows |
| <a id="12488529">[12488529](#12488529)</a> | [FIX: Error occurs when the Database Encryption Key is longer than 3,456 bits in SQL Server 2016 and 2017 (KB4463125)](https://support.microsoft.com/help/4463125) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12488539">[12488539](#12488539)</a> | [FIX: Error 41317 when you enable server audit and you use in-memory transactions in SQL Server (KB4459327)](https://support.microsoft.com/help/4459327) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12488533">[12488533](#12488533)</a> | FIX: Masked data is exposed when a query that uses `sp_cursorfetch` is run in SQL Server if Dynamic Data Masking is enabled (KB4459535) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12527112">[12527112](#12527112)</a> | FIX: Access violation when you run a granular audit policy for DML in SQL Server (KB4470991) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12478582">[12478582](#12478582)</a> | [FIX: Log message displays "N/A" when using ring buffer target to hold extended event data in memory in SQL Server (KB4470811)](https://support.microsoft.com/help/4470811) | SQL Server Engine | SQL OS | All |
| <a id="12521845">[12521845](#12521845)</a> | [FIX: SQL Server service crashes when DBCC CHECKDB runs against a database that has a corrupted partition (KB4480639)](https://support.microsoft.com/help/4480639) | SQL Server Engine | Storage Management | Windows |
| <a id="12486146">[12486146](#12486146)</a> | FIX: Restore of TDE-compressed backup is unsuccessful when backing up database to a 512-byte Emulation disk in SQL Server 2017 (KB4479280) | SQL Server Engine | Storage Management | Windows |
| <a id="12482229">[12482229](#12482229)</a> | [FIX: Access violation when you run a query that uses the XML data type in SQL Server 2014 and 2017 (KB4460112)](https://support.microsoft.com/help/4460112) | SQL Server Engine | XML | Windows |
| <a id="12489781">[12489781](#12489781)</a> | [FIX: VC++ 2015 Redistributable installation returns error 1638 when a newer version is already installed (KB4092997)](https://support.microsoft.com/help/4092997) | SQL Setup | Deployment Platform | Windows |
| <a id="12517645">[12517645](#12517645)</a> | [FIX: SQL Server installation fails if one of the remote nodes is unreachable in a cluster (KB4479283)](https://support.microsoft.com/help/4479283) | SQL Setup | Deployment Platform | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU13 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2018/12/sqlserver2017-kb4466404-x64_5cf494b2be8d679ee407f03d77bcb574875f1f5b.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4466404-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4466404-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4466404-x64.exe| 7BA817CF8C5DCE3F267F6E720A2D3A19C34280464EB126AF638C8CB833AF0406 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.239.1  | 266312    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.239.1      | 741448    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.239.1      | 1380424   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.239.1      | 984136    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.239.1      | 521488    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 01-Dec-18 | 02:10 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 01-Dec-18 | 02:05 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 01-Dec-18 | 02:05 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 01-Dec-18 | 02:05 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 01-Dec-18 | 02:05 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 01-Dec-18 | 02:05 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 01-Dec-18 | 02:05 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 01-Dec-18 | 02:05 | x86      |
| Msmdctr.dll                                        | 2017.140.239.1  | 40008     | 01-Dec-18 | 02:30 | x64      |
| Msmdlocal.dll                                      | 2017.140.239.1  | 60709960  | 01-Dec-18 | 02:31 | x64      |
| Msmdlocal.dll                                      | 2017.140.239.1  | 40387896  | 01-Dec-18 | 02:31 | x86      |
| Msmdpump.dll                                       | 2017.140.239.1  | 9334856   | 01-Dec-18 | 02:31 | x64      |
| Msmdredir.dll                                      | 2017.140.239.1  | 7092504   | 01-Dec-18 | 02:31 | x86      |
| Msmdsrv.exe                                        | 2017.140.239.1  | 60611864  | 01-Dec-18 | 02:31 | x64      |
| Msmgdsrv.dll                                       | 2017.140.239.1  | 9004616   | 01-Dec-18 | 02:31 | x64      |
| Msmgdsrv.dll                                       | 2017.140.239.1  | 7310648   | 01-Dec-18 | 02:31 | x86      |
| Msolap.dll                                         | 2017.140.239.1  | 10258712  | 01-Dec-18 | 02:30 | x64      |
| Msolap.dll                                         | 2017.140.239.1  | 7778072   | 01-Dec-18 | 02:31 | x86      |
| Msolui.dll                                         | 2017.140.239.1  | 310856    | 01-Dec-18 | 02:30 | x64      |
| Msolui.dll                                         | 2017.140.239.1  | 287304    | 01-Dec-18 | 02:31 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 01-Dec-18 | 02:05 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlboot.dll                                        | 2017.140.3048.4 | 196168    | 01-Dec-18 | 02:30 | x64      |
| Sqlceip.exe                                        | 14.0.3048.4     | 257608    | 01-Dec-18 | 02:10 | x86      |
| Sqldumper.exe                                      | 2017.140.3048.4 | 119368    | 01-Dec-18 | 02:06 | x86      |
| Sqldumper.exe                                      | 2017.140.3048.4 | 141384    | 01-Dec-18 | 02:19 | x64      |
| Tmapi.dll                                          | 2017.140.239.1  | 5821512   | 01-Dec-18 | 02:31 | x64      |
| Tmcachemgr.dll                                     | 2017.140.239.1  | 4164680   | 01-Dec-18 | 02:31 | x64      |
| Tmpersistence.dll                                  | 2017.140.239.1  | 1132104   | 01-Dec-18 | 02:31 | x64      |
| Tmtransactions.dll                                 | 2017.140.239.1  | 1641032   | 01-Dec-18 | 02:31 | x64      |
| Xe.dll                                             | 2017.140.3048.4 | 673352    | 01-Dec-18 | 02:31 | x64      |
| Xmlrw.dll                                          | 2017.140.3048.4 | 305224    | 01-Dec-18 | 02:31 | x64      |
| Xmlrw.dll                                          | 2017.140.3048.4 | 257800    | 01-Dec-18 | 02:31 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3048.4 | 224520    | 01-Dec-18 | 02:31 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3048.4 | 189512    | 01-Dec-18 | 02:31 | x86      |
| Xmsrv.dll                                          | 2017.140.239.1  | 25375496  | 01-Dec-18 | 02:31 | x64      |
| Xmsrv.dll                                          | 2017.140.239.1  | 33350936  | 01-Dec-18 | 02:31 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3048.4  | 181000    | 01-Dec-18 | 02:30 | x64      |
| Batchparser.dll                            | 2017.140.3048.4  | 160520    | 01-Dec-18 | 02:30 | x86      |
| Instapi140.dll                             | 2017.140.3048.4  | 70728     | 01-Dec-18 | 02:30 | x64      |
| Instapi140.dll                             | 2017.140.3048.4  | 61200     | 01-Dec-18 | 02:31 | x86      |
| Isacctchange.dll                           | 2017.140.3048.4  | 30792     | 01-Dec-18 | 02:30 | x64      |
| Isacctchange.dll                           | 2017.140.3048.4  | 29472     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.239.1       | 1088584   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.239.1       | 1088792   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.239.1       | 1381448   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.239.1       | 741448    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.239.1       | 741448    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3048.4      | 36936     | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3048.4  | 82184     | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3048.4  | 78600     | 01-Dec-18 | 02:31 | x86      |
| Msasxpress.dll                             | 2017.140.239.1   | 35912     | 01-Dec-18 | 02:30 | x64      |
| Msasxpress.dll                             | 2017.140.239.1   | 31816     | 01-Dec-18 | 02:31 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3048.4  | 82696     | 01-Dec-18 | 02:30 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3048.4  | 68376     | 01-Dec-18 | 02:31 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3048.4  | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqldumper.exe                              | 2017.140.3048.4  | 119368    | 01-Dec-18 | 02:06 | x86      |
| Sqldumper.exe                              | 2017.140.3048.4  | 141384    | 01-Dec-18 | 02:19 | x64      |
| Sqlftacct.dll                              | 2017.140.3048.4  | 62744     | 01-Dec-18 | 02:30 | x64      |
| Sqlftacct.dll                              | 2017.140.3048.4  | 55560     | 01-Dec-18 | 02:31 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 01-Dec-18 | 02:30 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 01-Dec-18 | 02:31 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3048.4  | 416536    | 01-Dec-18 | 02:30 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3048.4  | 372808    | 01-Dec-18 | 02:31 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3048.4  | 37448     | 01-Dec-18 | 02:30 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3048.4  | 35080     | 01-Dec-18 | 02:31 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3048.4  | 355912    | 01-Dec-18 | 02:30 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3048.4  | 273160    | 01-Dec-18 | 02:31 | x86      |
| Sqltdiagn.dll                              | 2017.140.3048.4  | 67656     | 01-Dec-18 | 02:30 | x64      |
| Sqltdiagn.dll                              | 2017.140.3048.4  | 60488     | 01-Dec-18 | 02:31 | x86      |
| Svrenumapi140.dll                          | 2017.140.3048.4  | 1173064   | 01-Dec-18 | 02:31 | x64      |
| Svrenumapi140.dll                          | 2017.140.3048.4  | 893512    | 01-Dec-18 | 02:31 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3048.4 | 121112    | 01-Dec-18 | 02:30 | x86      |
| Dreplaycommon.dll              | 2017.140.3048.4 | 698952    | 01-Dec-18 | 02:30 | x86      |
| Dreplayserverps.dll            | 2017.140.3048.4 | 33032     | 01-Dec-18 | 02:30 | x86      |
| Dreplayutil.dll                | 2017.140.3048.4 | 310048    | 01-Dec-18 | 02:30 | x86      |
| Instapi140.dll                 | 2017.140.3048.4 | 70728     | 01-Dec-18 | 02:30 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlresourceloader.dll          | 2017.140.3048.4 | 29456     | 01-Dec-18 | 02:31 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3048.4 | 698952    | 01-Dec-18 | 02:30 | x86      |
| Dreplaycontroller.exe              | 2017.140.3048.4 | 350480    | 01-Dec-18 | 02:30 | x86      |
| Dreplayprocess.dll                 | 2017.140.3048.4 | 171800    | 01-Dec-18 | 02:30 | x86      |
| Dreplayserverps.dll                | 2017.140.3048.4 | 33032     | 01-Dec-18 | 02:30 | x86      |
| Instapi140.dll                     | 2017.140.3048.4 | 70728     | 01-Dec-18 | 02:30 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlresourceloader.dll              | 2017.140.3048.4 | 29456     | 01-Dec-18 | 02:31 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 14.0.3048.4     | 40712     | 01-Dec-18 | 02:30 | x64      |
| Batchparser.dll                              | 2017.140.3048.4 | 181000    | 01-Dec-18 | 02:30 | x64      |
| C1.dll                                       | 18.10.40116.18  | 909312    | 01-Dec-18 | 02:17 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5325312   | 01-Dec-18 | 02:17 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 176128    | 01-Dec-18 | 02:17 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 01-Dec-18 | 02:30 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3048.4 | 226376    | 01-Dec-18 | 02:30 | x64      |
| Dcexec.exe                                   | 2017.140.3048.4 | 74520     | 01-Dec-18 | 02:30 | x64      |
| Fssres.dll                                   | 2017.140.3048.4 | 89880     | 01-Dec-18 | 02:30 | x64      |
| Hadrres.dll                                  | 2017.140.3048.4 | 188184    | 01-Dec-18 | 02:30 | x64      |
| Hkcompile.dll                                | 2017.140.3048.4 | 1423112   | 01-Dec-18 | 02:30 | x64      |
| Hkengine.dll                                 | 2017.140.3048.4 | 5858584   | 01-Dec-18 | 02:31 | x64      |
| Hkruntime.dll                                | 2017.140.3048.4 | 163088    | 01-Dec-18 | 02:30 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1001472   | 01-Dec-18 | 02:17 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.239.1      | 740936    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 01-Dec-18 | 02:10 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3048.4     | 236320    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3048.4     | 79648     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3048.4 | 72264     | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3048.4 | 65096     | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3048.4 | 152136    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3048.4 | 159520    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3048.4 | 303688    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3048.4 | 75040     | 01-Dec-18 | 02:30 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 113664    | 01-Dec-18 | 02:17 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 543232    | 01-Dec-18 | 02:17 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 543232    | 01-Dec-18 | 02:17 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 645120    | 01-Dec-18 | 02:17 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 948736    | 01-Dec-18 | 02:17 | x64      |
| Odsole70.dll                                 | 2017.140.3048.4 | 92952     | 01-Dec-18 | 02:30 | x64      |
| Opends60.dll                                 | 2017.140.3048.4 | 33032     | 01-Dec-18 | 02:30 | x64      |
| Qds.dll                                      | 2017.140.3048.4 | 1174280   | 01-Dec-18 | 02:31 | x64      |
| Rsfxft.dll                                   | 2017.140.3048.4 | 34576     | 01-Dec-18 | 02:30 | x64      |
| Secforwarder.dll                             | 2017.140.3048.4 | 37640     | 01-Dec-18 | 02:30 | x64      |
| Sqagtres.dll                                 | 2017.140.3048.4 | 74528     | 01-Dec-18 | 02:30 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlaamss.dll                                 | 2017.140.3048.4 | 90416     | 01-Dec-18 | 02:30 | x64      |
| Sqlaccess.dll                                | 2017.140.3048.4 | 475912    | 01-Dec-18 | 02:30 | x64      |
| Sqlagent.exe                                 | 2017.140.3048.4 | 582432    | 01-Dec-18 | 02:30 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3048.4 | 62024     | 01-Dec-18 | 02:30 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3048.4 | 53000     | 01-Dec-18 | 02:31 | x86      |
| Sqlagentlog.dll                              | 2017.140.3048.4 | 33032     | 01-Dec-18 | 02:30 | x64      |
| Sqlagentmail.dll                             | 2017.140.3048.4 | 54024     | 01-Dec-18 | 02:30 | x64      |
| Sqlboot.dll                                  | 2017.140.3048.4 | 196168    | 01-Dec-18 | 02:30 | x64      |
| Sqlceip.exe                                  | 14.0.3048.4     | 257608    | 01-Dec-18 | 02:10 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3048.4 | 72984     | 01-Dec-18 | 02:30 | x64      |
| Sqlctr140.dll                                | 2017.140.3048.4 | 129288    | 01-Dec-18 | 02:30 | x64      |
| Sqlctr140.dll                                | 2017.140.3048.4 | 112400    | 01-Dec-18 | 02:31 | x86      |
| Sqldk.dll                                    | 2017.140.3048.4 | 2796616   | 01-Dec-18 | 02:30 | x64      |
| Sqldtsss.dll                                 | 2017.140.3048.4 | 107592    | 01-Dec-18 | 02:30 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3403528   | 01-Dec-18 | 02:03 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 1498376   | 01-Dec-18 | 02:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 1445640   | 01-Dec-18 | 02:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 2037000   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3291912   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3636296   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3915528   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3787528   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3214600   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3918088   | 01-Dec-18 | 02:10 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3297544   | 01-Dec-18 | 02:11 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3589384   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3785992   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 2090248   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3339528   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3482376   | 01-Dec-18 | 02:16 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3597576   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3780360   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3821832   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3368200   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 4027656   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3048.4 | 3677960   | 01-Dec-18 | 02:26 | x64      |
| Sqliosim.com                                 | 2017.140.3048.4 | 313632    | 01-Dec-18 | 02:30 | x64      |
| Sqliosim.exe                                 | 2017.140.3048.4 | 3020048   | 01-Dec-18 | 02:31 | x64      |
| Sqllang.dll                                  | 2017.140.3048.4 | 41260808  | 01-Dec-18 | 02:31 | x64      |
| Sqlmin.dll                                   | 2017.140.3048.4 | 40465672  | 01-Dec-18 | 02:31 | x64      |
| Sqlolapss.dll                                | 2017.140.3048.4 | 107808    | 01-Dec-18 | 02:30 | x64      |
| Sqlos.dll                                    | 2017.140.3048.4 | 26184     | 01-Dec-18 | 02:30 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3048.4 | 68384     | 01-Dec-18 | 02:30 | x64      |
| Sqlrepss.dll                                 | 2017.140.3048.4 | 64800     | 01-Dec-18 | 02:30 | x64      |
| Sqlresld.dll                                 | 2017.140.3048.4 | 30792     | 01-Dec-18 | 02:30 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3048.4 | 32528     | 01-Dec-18 | 02:30 | x64      |
| Sqlscm.dll                                   | 2017.140.3048.4 | 71240     | 01-Dec-18 | 02:30 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3048.4 | 27912     | 01-Dec-18 | 02:30 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3048.4 | 5874440   | 01-Dec-18 | 02:31 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3048.4 | 732744    | 01-Dec-18 | 02:30 | x64      |
| Sqlservr.exe                                 | 2017.140.3048.4 | 487688    | 01-Dec-18 | 02:30 | x64      |
| Sqlsvc.dll                                   | 2017.140.3048.4 | 162072    | 01-Dec-18 | 02:30 | x64      |
| Sqltses.dll                                  | 2017.140.3048.4 | 9564952   | 01-Dec-18 | 02:30 | x64      |
| Sqsrvres.dll                                 | 2017.140.3048.4 | 261400    | 01-Dec-18 | 02:30 | x64      |
| Svl.dll                                      | 2017.140.3048.4 | 153672    | 01-Dec-18 | 02:30 | x64      |
| Xe.dll                                       | 2017.140.3048.4 | 673352    | 01-Dec-18 | 02:31 | x64      |
| Xmlrw.dll                                    | 2017.140.3048.4 | 305224    | 01-Dec-18 | 02:31 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3048.4 | 224520    | 01-Dec-18 | 02:31 | x64      |
| Xpadsi.exe                                   | 2017.140.3048.4 | 89672     | 01-Dec-18 | 02:30 | x64      |
| Xplog70.dll                                  | 2017.140.3048.4 | 76056     | 01-Dec-18 | 02:31 | x64      |
| Xpqueue.dll                                  | 2017.140.3048.4 | 75016     | 01-Dec-18 | 02:31 | x64      |
| Xprepl.dll                                   | 2017.140.3048.4 | 101960    | 01-Dec-18 | 02:31 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3048.4 | 32328     | 01-Dec-18 | 02:31 | x64      |
| Xpstar.dll                                   | 2017.140.3048.4 | 438536    | 01-Dec-18 | 02:30 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3048.4 | 181000    | 01-Dec-18 | 02:30 | x64      |
| Batchparser.dll                                             | 2017.140.3048.4 | 160520    | 01-Dec-18 | 02:30 | x86      |
| Bcp.exe                                                     | 2017.140.3048.4 | 120096    | 01-Dec-18 | 02:30 | x64      |
| Commanddest.dll                                             | 2017.140.3048.4 | 246048    | 01-Dec-18 | 02:30 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3048.4 | 116296    | 01-Dec-18 | 02:30 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3048.4 | 187680    | 01-Dec-18 | 02:30 | x64      |
| Distrib.exe                                                 | 2017.140.3048.4 | 203552    | 01-Dec-18 | 02:30 | x64      |
| Dteparse.dll                                                | 2017.140.3048.4 | 111176    | 01-Dec-18 | 02:30 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3048.4 | 89160     | 01-Dec-18 | 02:30 | x64      |
| Dtepkg.dll                                                  | 2017.140.3048.4 | 137800    | 01-Dec-18 | 02:30 | x64      |
| Dtexec.exe                                                  | 2017.140.3048.4 | 73992     | 01-Dec-18 | 02:30 | x64      |
| Dts.dll                                                     | 2017.140.3048.4 | 2998856   | 01-Dec-18 | 02:30 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3048.4 | 475208    | 01-Dec-18 | 02:30 | x64      |
| Dtsconn.dll                                                 | 2017.140.3048.4 | 497432    | 01-Dec-18 | 02:30 | x64      |
| Dtshost.exe                                                 | 2017.140.3048.4 | 104728    | 01-Dec-18 | 02:30 | x64      |
| Dtslog.dll                                                  | 2017.140.3048.4 | 120608    | 01-Dec-18 | 02:30 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3048.4 | 545352    | 01-Dec-18 | 02:30 | x64      |
| Dtspipeline.dll                                             | 2017.140.3048.4 | 1266456   | 01-Dec-18 | 02:30 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3048.4 | 48200     | 01-Dec-18 | 02:30 | x64      |
| Dtuparse.dll                                                | 2017.140.3048.4 | 89376     | 01-Dec-18 | 02:30 | x64      |
| Dtutil.exe                                                  | 2017.140.3048.4 | 147208    | 01-Dec-18 | 02:30 | x64      |
| Exceldest.dll                                               | 2017.140.3048.4 | 260680    | 01-Dec-18 | 02:30 | x64      |
| Excelsrc.dll                                                | 2017.140.3048.4 | 282904    | 01-Dec-18 | 02:30 | x64      |
| Execpackagetask.dll                                         | 2017.140.3048.4 | 168224    | 01-Dec-18 | 02:30 | x64      |
| Flatfiledest.dll                                            | 2017.140.3048.4 | 386632    | 01-Dec-18 | 02:30 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3048.4 | 398920    | 01-Dec-18 | 02:30 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3048.4 | 96544     | 01-Dec-18 | 02:30 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3048.4 | 59656     | 01-Dec-18 | 02:30 | x64      |
| Logread.exe                                                 | 2017.140.3048.4 | 635152    | 01-Dec-18 | 02:30 | x64      |
| Mergetxt.dll                                                | 2017.140.3048.4 | 63752     | 01-Dec-18 | 02:30 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.239.1      | 1381656   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3048.4     | 137800    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3048.4     | 89872     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3048.4     | 614176    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3048.4 | 1663760   | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3048.4 | 152136    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3048.4 | 159520    | 01-Dec-18 | 02:30 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3048.4 | 103200    | 01-Dec-18 | 02:30 | x64      |
| Msgprox.dll                                                 | 2017.140.3048.4 | 270624    | 01-Dec-18 | 02:30 | x64      |
| Msxmlsql.dll                                                | 2017.140.3048.4 | 1448008   | 01-Dec-18 | 02:30 | x64      |
| Oledbdest.dll                                               | 2017.140.3048.4 | 261408    | 01-Dec-18 | 02:30 | x64      |
| Oledbsrc.dll                                                | 2017.140.3048.4 | 289072    | 01-Dec-18 | 02:30 | x64      |
| Osql.exe                                                    | 2017.140.3048.4 | 75528     | 01-Dec-18 | 02:30 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3048.4 | 473888    | 01-Dec-18 | 02:31 | x64      |
| Rawdest.dll                                                 | 2017.140.3048.4 | 206624    | 01-Dec-18 | 02:30 | x64      |
| Rawsource.dll                                               | 2017.140.3048.4 | 194120    | 01-Dec-18 | 02:30 | x64      |
| Rdistcom.dll                                                | 2017.140.3048.4 | 857160    | 01-Dec-18 | 02:31 | x64      |
| Recordsetdest.dll                                           | 2017.140.3048.4 | 184608    | 01-Dec-18 | 02:30 | x64      |
| Replagnt.dll                                                | 2017.140.3048.4 | 30792     | 01-Dec-18 | 02:31 | x64      |
| Repldp.dll                                                  | 2017.140.3048.4 | 291104    | 01-Dec-18 | 02:31 | x64      |
| Replerrx.dll                                                | 2017.140.3048.4 | 154376    | 01-Dec-18 | 02:31 | x64      |
| Replisapi.dll                                               | 2017.140.3048.4 | 362272    | 01-Dec-18 | 02:31 | x64      |
| Replmerg.exe                                                | 2017.140.3048.4 | 524872    | 01-Dec-18 | 02:31 | x64      |
| Replprov.dll                                                | 2017.140.3048.4 | 801864    | 01-Dec-18 | 02:31 | x64      |
| Replrec.dll                                                 | 2017.140.3048.4 | 975640    | 01-Dec-18 | 02:31 | x64      |
| Replsub.dll                                                 | 2017.140.3048.4 | 445728    | 01-Dec-18 | 02:31 | x64      |
| Replsync.dll                                                | 2017.140.3048.4 | 154376    | 01-Dec-18 | 02:31 | x64      |
| Spresolv.dll                                                | 2017.140.3048.4 | 252192    | 01-Dec-18 | 02:30 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3048.4 | 249096    | 01-Dec-18 | 02:30 | x64      |
| Sqldiag.exe                                                 | 2017.140.3048.4 | 1257736   | 01-Dec-18 | 02:30 | x64      |
| Sqldistx.dll                                                | 2017.140.3048.4 | 225544    | 01-Dec-18 | 02:30 | x64      |
| Sqllogship.exe                                              | 14.0.3048.4     | 105544    | 01-Dec-18 | 02:30 | x64      |
| Sqlmergx.dll                                                | 2017.140.3048.4 | 360736    | 01-Dec-18 | 02:30 | x64      |
| Sqlresld.dll                                                | 2017.140.3048.4 | 30792     | 01-Dec-18 | 02:30 | x64      |
| Sqlresld.dll                                                | 2017.140.3048.4 | 28936     | 01-Dec-18 | 02:31 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3048.4 | 32528     | 01-Dec-18 | 02:30 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3048.4 | 29456     | 01-Dec-18 | 02:31 | x86      |
| Sqlscm.dll                                                  | 2017.140.3048.4 | 71240     | 01-Dec-18 | 02:30 | x64      |
| Sqlscm.dll                                                  | 2017.140.3048.4 | 61000     | 01-Dec-18 | 02:31 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3048.4 | 162072    | 01-Dec-18 | 02:30 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3048.4 | 134936    | 01-Dec-18 | 02:31 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3048.4 | 184096    | 01-Dec-18 | 02:30 | x64      |
| Sqlwep140.dll                                               | 2017.140.3048.4 | 105736    | 01-Dec-18 | 02:30 | x64      |
| Ssdebugps.dll                                               | 2017.140.3048.4 | 33352     | 01-Dec-18 | 02:30 | x64      |
| Ssisoledb.dll                                               | 2017.140.3048.4 | 216352    | 01-Dec-18 | 02:30 | x64      |
| Ssradd.dll                                                  | 2017.140.3048.4 | 75336     | 01-Dec-18 | 02:30 | x64      |
| Ssravg.dll                                                  | 2017.140.3048.4 | 76040     | 01-Dec-18 | 02:30 | x64      |
| Ssrdown.dll                                                 | 2017.140.3048.4 | 60488     | 01-Dec-18 | 02:30 | x64      |
| Ssrmax.dll                                                  | 2017.140.3048.4 | 73480     | 01-Dec-18 | 02:30 | x64      |
| Ssrmin.dll                                                  | 2017.140.3048.4 | 73992     | 01-Dec-18 | 02:30 | x64      |
| Ssrpub.dll                                                  | 2017.140.3048.4 | 61512     | 01-Dec-18 | 02:30 | x64      |
| Ssrup.dll                                                   | 2017.140.3048.4 | 60680     | 01-Dec-18 | 02:30 | x64      |
| Txagg.dll                                                   | 2017.140.3048.4 | 362056    | 01-Dec-18 | 02:30 | x64      |
| Txbdd.dll                                                   | 2017.140.3048.4 | 170056    | 01-Dec-18 | 02:30 | x64      |
| Txdatacollector.dll                                         | 2017.140.3048.4 | 360736    | 01-Dec-18 | 02:30 | x64      |
| Txdataconvert.dll                                           | 2017.140.3048.4 | 292936    | 01-Dec-18 | 02:30 | x64      |
| Txderived.dll                                               | 2017.140.3048.4 | 604232    | 01-Dec-18 | 02:30 | x64      |
| Txlookup.dll                                                | 2017.140.3048.4 | 527944    | 01-Dec-18 | 02:30 | x64      |
| Txmerge.dll                                                 | 2017.140.3048.4 | 230176    | 01-Dec-18 | 02:30 | x64      |
| Txmergejoin.dll                                             | 2017.140.3048.4 | 275744    | 01-Dec-18 | 02:30 | x64      |
| Txmulticast.dll                                             | 2017.140.3048.4 | 127776    | 01-Dec-18 | 02:30 | x64      |
| Txrowcount.dll                                              | 2017.140.3048.4 | 125720    | 01-Dec-18 | 02:30 | x64      |
| Txsort.dll                                                  | 2017.140.3048.4 | 256800    | 01-Dec-18 | 02:30 | x64      |
| Txsplit.dll                                                 | 2017.140.3048.4 | 596552    | 01-Dec-18 | 02:30 | x64      |
| Txunionall.dll                                              | 2017.140.3048.4 | 182048    | 01-Dec-18 | 02:30 | x64      |
| Xe.dll                                                      | 2017.140.3048.4 | 673352    | 01-Dec-18 | 02:31 | x64      |
| Xmlrw.dll                                                   | 2017.140.3048.4 | 305224    | 01-Dec-18 | 02:31 | x64      |
| Xmlsub.dll                                                  | 2017.140.3048.4 | 261384    | 01-Dec-18 | 02:31 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3048.4 | 1124632   | 01-Dec-18 | 02:30 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlsatellite.dll              | 2017.140.3048.4 | 922392    | 01-Dec-18 | 02:30 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3048.4 | 667400    | 01-Dec-18 | 02:30 | x64      |
| Fdhost.exe               | 2017.140.3048.4 | 114976    | 01-Dec-18 | 02:30 | x64      |
| Fdlauncher.exe           | 2017.140.3048.4 | 62536     | 01-Dec-18 | 02:30 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlft140ph.dll           | 2017.140.3048.4 | 68168     | 01-Dec-18 | 02:30 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3048.4     | 23624     | 01-Dec-18 | 02:30 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 01-Dec-18 | 02:30 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 01-Dec-18 | 02:30 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 01-Dec-18 | 02:30 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 01-Dec-18 | 02:30 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 01-Dec-18 | 02:30 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 01-Dec-18 | 02:30 | x86      |
| Commanddest.dll                                               | 2017.140.3048.4 | 246048    | 01-Dec-18 | 02:30 | x64      |
| Commanddest.dll                                               | 2017.140.3048.4 | 200992    | 01-Dec-18 | 02:30 | x86      |
| Dteparse.dll                                                  | 2017.140.3048.4 | 111176    | 01-Dec-18 | 02:30 | x64      |
| Dteparse.dll                                                  | 2017.140.3048.4 | 100632    | 01-Dec-18 | 02:30 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3048.4 | 89160     | 01-Dec-18 | 02:30 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3048.4 | 83528     | 01-Dec-18 | 02:30 | x86      |
| Dtepkg.dll                                                    | 2017.140.3048.4 | 137800    | 01-Dec-18 | 02:30 | x64      |
| Dtepkg.dll                                                    | 2017.140.3048.4 | 117000    | 01-Dec-18 | 02:30 | x86      |
| Dtexec.exe                                                    | 2017.140.3048.4 | 73992     | 01-Dec-18 | 02:30 | x64      |
| Dtexec.exe                                                    | 2017.140.3048.4 | 67656     | 01-Dec-18 | 02:30 | x86      |
| Dts.dll                                                       | 2017.140.3048.4 | 2998856   | 01-Dec-18 | 02:30 | x64      |
| Dts.dll                                                       | 2017.140.3048.4 | 2549528   | 01-Dec-18 | 02:30 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3048.4 | 475208    | 01-Dec-18 | 02:30 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3048.4 | 417864    | 01-Dec-18 | 02:30 | x86      |
| Dtsconn.dll                                                   | 2017.140.3048.4 | 497432    | 01-Dec-18 | 02:30 | x64      |
| Dtsconn.dll                                                   | 2017.140.3048.4 | 399432    | 01-Dec-18 | 02:30 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3048.4 | 111392    | 01-Dec-18 | 02:30 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3048.4 | 95512     | 01-Dec-18 | 02:30 | x86      |
| Dtshost.exe                                                   | 2017.140.3048.4 | 104728    | 01-Dec-18 | 02:30 | x64      |
| Dtshost.exe                                                   | 2017.140.3048.4 | 89864     | 01-Dec-18 | 02:31 | x86      |
| Dtslog.dll                                                    | 2017.140.3048.4 | 120608    | 01-Dec-18 | 02:30 | x64      |
| Dtslog.dll                                                    | 2017.140.3048.4 | 103192    | 01-Dec-18 | 02:30 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3048.4 | 545352    | 01-Dec-18 | 02:30 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3048.4 | 541256    | 01-Dec-18 | 02:31 | x86      |
| Dtspipeline.dll                                               | 2017.140.3048.4 | 1266456   | 01-Dec-18 | 02:30 | x64      |
| Dtspipeline.dll                                               | 2017.140.3048.4 | 1059592   | 01-Dec-18 | 02:30 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3048.4 | 48200     | 01-Dec-18 | 02:30 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3048.4 | 42568     | 01-Dec-18 | 02:30 | x86      |
| Dtuparse.dll                                                  | 2017.140.3048.4 | 89376     | 01-Dec-18 | 02:30 | x64      |
| Dtuparse.dll                                                  | 2017.140.3048.4 | 80152     | 01-Dec-18 | 02:30 | x86      |
| Dtutil.exe                                                    | 2017.140.3048.4 | 147208    | 01-Dec-18 | 02:30 | x64      |
| Dtutil.exe                                                    | 2017.140.3048.4 | 126216    | 01-Dec-18 | 02:30 | x86      |
| Exceldest.dll                                                 | 2017.140.3048.4 | 260680    | 01-Dec-18 | 02:30 | x64      |
| Exceldest.dll                                                 | 2017.140.3048.4 | 214792    | 01-Dec-18 | 02:30 | x86      |
| Excelsrc.dll                                                  | 2017.140.3048.4 | 282904    | 01-Dec-18 | 02:30 | x64      |
| Excelsrc.dll                                                  | 2017.140.3048.4 | 230664    | 01-Dec-18 | 02:30 | x86      |
| Execpackagetask.dll                                           | 2017.140.3048.4 | 168224    | 01-Dec-18 | 02:30 | x64      |
| Execpackagetask.dll                                           | 2017.140.3048.4 | 135448    | 01-Dec-18 | 02:30 | x86      |
| Flatfiledest.dll                                              | 2017.140.3048.4 | 386632    | 01-Dec-18 | 02:30 | x64      |
| Flatfiledest.dll                                              | 2017.140.3048.4 | 333088    | 01-Dec-18 | 02:30 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3048.4 | 398920    | 01-Dec-18 | 02:30 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3048.4 | 344344    | 01-Dec-18 | 02:30 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3048.4 | 96544     | 01-Dec-18 | 02:30 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3048.4 | 80664     | 01-Dec-18 | 02:30 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3048.4     | 466504    | 01-Dec-18 | 02:30 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3048.4     | 467224    | 01-Dec-18 | 02:30 | x86      |
| Isserverexec.exe                                              | 14.0.3048.4     | 148552    | 01-Dec-18 | 02:30 | x64      |
| Isserverexec.exe                                              | 14.0.3048.4     | 149272    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.239.1      | 1381656   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.239.1      | 1381664   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 01-Dec-18 | 02:10 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 01-Dec-18 | 02:17 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3048.4     | 72776     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3048.4 | 112432    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3048.4 | 107080    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3048.4     | 89872     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3048.4     | 89880     | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3048.4     | 494856    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3048.4     | 494856    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3048.4     | 83728     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3048.4     | 83728     | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3048.4     | 416008    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3048.4     | 416008    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3048.4     | 614176    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3048.4     | 613960    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3048.4     | 252488    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3048.4     | 252488    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3048.4 | 152136    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3048.4 | 141896    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3048.4 | 159520    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3048.4 | 145480    | 01-Dec-18 | 02:31 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3048.4     | 219912    | 01-Dec-18 | 02:30 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3048.4 | 103200    | 01-Dec-18 | 02:30 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3048.4 | 90376     | 01-Dec-18 | 02:30 | x86      |
| Msmdpp.dll                                                    | 2017.140.239.1  | 9194248   | 01-Dec-18 | 02:31 | x64      |
| Oledbdest.dll                                                 | 2017.140.3048.4 | 261408    | 01-Dec-18 | 02:30 | x64      |
| Oledbdest.dll                                                 | 2017.140.3048.4 | 214792    | 01-Dec-18 | 02:30 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3048.4 | 289072    | 01-Dec-18 | 02:30 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3048.4 | 233240    | 01-Dec-18 | 02:30 | x86      |
| Rawdest.dll                                                   | 2017.140.3048.4 | 206624    | 01-Dec-18 | 02:30 | x64      |
| Rawdest.dll                                                   | 2017.140.3048.4 | 166680    | 01-Dec-18 | 02:31 | x86      |
| Rawsource.dll                                                 | 2017.140.3048.4 | 194120    | 01-Dec-18 | 02:30 | x64      |
| Rawsource.dll                                                 | 2017.140.3048.4 | 153368    | 01-Dec-18 | 02:31 | x86      |
| Recordsetdest.dll                                             | 2017.140.3048.4 | 184608    | 01-Dec-18 | 02:30 | x64      |
| Recordsetdest.dll                                             | 2017.140.3048.4 | 149280    | 01-Dec-18 | 02:31 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlceip.exe                                                   | 14.0.3048.4     | 257608    | 01-Dec-18 | 02:10 | x86      |
| Sqldest.dll                                                   | 2017.140.3048.4 | 260888    | 01-Dec-18 | 02:30 | x64      |
| Sqldest.dll                                                   | 2017.140.3048.4 | 213792    | 01-Dec-18 | 02:31 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3048.4 | 184096    | 01-Dec-18 | 02:30 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3048.4 | 155416    | 01-Dec-18 | 02:31 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3048.4 | 216352    | 01-Dec-18 | 02:30 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3048.4 | 176712    | 01-Dec-18 | 02:31 | x86      |
| Txagg.dll                                                     | 2017.140.3048.4 | 362056    | 01-Dec-18 | 02:30 | x64      |
| Txagg.dll                                                     | 2017.140.3048.4 | 302360    | 01-Dec-18 | 02:31 | x86      |
| Txbdd.dll                                                     | 2017.140.3048.4 | 170056    | 01-Dec-18 | 02:30 | x64      |
| Txbdd.dll                                                     | 2017.140.3048.4 | 136472    | 01-Dec-18 | 02:31 | x86      |
| Txbestmatch.dll                                               | 2017.140.3048.4 | 605464    | 01-Dec-18 | 02:30 | x64      |
| Txbestmatch.dll                                               | 2017.140.3048.4 | 493128    | 01-Dec-18 | 02:31 | x86      |
| Txcache.dll                                                   | 2017.140.3048.4 | 180512    | 01-Dec-18 | 02:30 | x64      |
| Txcache.dll                                                   | 2017.140.3048.4 | 146200    | 01-Dec-18 | 02:31 | x86      |
| Txcharmap.dll                                                 | 2017.140.3048.4 | 286792    | 01-Dec-18 | 02:30 | x64      |
| Txcharmap.dll                                                 | 2017.140.3048.4 | 249112    | 01-Dec-18 | 02:31 | x86      |
| Txcopymap.dll                                                 | 2017.140.3048.4 | 180512    | 01-Dec-18 | 02:30 | x64      |
| Txcopymap.dll                                                 | 2017.140.3048.4 | 145696    | 01-Dec-18 | 02:31 | x86      |
| Txdataconvert.dll                                             | 2017.140.3048.4 | 292936    | 01-Dec-18 | 02:30 | x64      |
| Txdataconvert.dll                                             | 2017.140.3048.4 | 253208    | 01-Dec-18 | 02:31 | x86      |
| Txderived.dll                                                 | 2017.140.3048.4 | 604232    | 01-Dec-18 | 02:30 | x64      |
| Txderived.dll                                                 | 2017.140.3048.4 | 515872    | 01-Dec-18 | 02:31 | x86      |
| Txfileextractor.dll                                           | 2017.140.3048.4 | 198944    | 01-Dec-18 | 02:30 | x64      |
| Txfileextractor.dll                                           | 2017.140.3048.4 | 161056    | 01-Dec-18 | 02:31 | x86      |
| Txfileinserter.dll                                            | 2017.140.3048.4 | 196680    | 01-Dec-18 | 02:30 | x64      |
| Txfileinserter.dll                                            | 2017.140.3048.4 | 159304    | 01-Dec-18 | 02:31 | x86      |
| Txgroupdups.dll                                               | 2017.140.3048.4 | 290608    | 01-Dec-18 | 02:30 | x64      |
| Txgroupdups.dll                                               | 2017.140.3048.4 | 231192    | 01-Dec-18 | 02:31 | x86      |
| Txlineage.dll                                                 | 2017.140.3048.4 | 136992    | 01-Dec-18 | 02:30 | x64      |
| Txlineage.dll                                                 | 2017.140.3048.4 | 110360    | 01-Dec-18 | 02:31 | x86      |
| Txlookup.dll                                                  | 2017.140.3048.4 | 527944    | 01-Dec-18 | 02:30 | x64      |
| Txlookup.dll                                                  | 2017.140.3048.4 | 446744    | 01-Dec-18 | 02:31 | x86      |
| Txmerge.dll                                                   | 2017.140.3048.4 | 230176    | 01-Dec-18 | 02:30 | x64      |
| Txmerge.dll                                                   | 2017.140.3048.4 | 176920    | 01-Dec-18 | 02:31 | x86      |
| Txmergejoin.dll                                               | 2017.140.3048.4 | 275744    | 01-Dec-18 | 02:30 | x64      |
| Txmergejoin.dll                                               | 2017.140.3048.4 | 221976    | 01-Dec-18 | 02:31 | x86      |
| Txmulticast.dll                                               | 2017.140.3048.4 | 127776    | 01-Dec-18 | 02:30 | x64      |
| Txmulticast.dll                                               | 2017.140.3048.4 | 103176    | 01-Dec-18 | 02:31 | x86      |
| Txpivot.dll                                                   | 2017.140.3048.4 | 225056    | 01-Dec-18 | 02:30 | x64      |
| Txpivot.dll                                                   | 2017.140.3048.4 | 180488    | 01-Dec-18 | 02:31 | x86      |
| Txrowcount.dll                                                | 2017.140.3048.4 | 125720    | 01-Dec-18 | 02:30 | x64      |
| Txrowcount.dll                                                | 2017.140.3048.4 | 101664    | 01-Dec-18 | 02:31 | x86      |
| Txsampling.dll                                                | 2017.140.3048.4 | 172832    | 01-Dec-18 | 02:30 | x64      |
| Txsampling.dll                                                | 2017.140.3048.4 | 135960    | 01-Dec-18 | 02:31 | x86      |
| Txscd.dll                                                     | 2017.140.3048.4 | 220952    | 01-Dec-18 | 02:30 | x64      |
| Txscd.dll                                                     | 2017.140.3048.4 | 170288    | 01-Dec-18 | 02:31 | x86      |
| Txsort.dll                                                    | 2017.140.3048.4 | 256800    | 01-Dec-18 | 02:30 | x64      |
| Txsort.dll                                                    | 2017.140.3048.4 | 208176    | 01-Dec-18 | 02:31 | x86      |
| Txsplit.dll                                                   | 2017.140.3048.4 | 596552    | 01-Dec-18 | 02:30 | x64      |
| Txsplit.dll                                                   | 2017.140.3048.4 | 510744    | 01-Dec-18 | 02:31 | x86      |
| Txtermextraction.dll                                          | 2017.140.3048.4 | 8676616   | 01-Dec-18 | 02:30 | x64      |
| Txtermextraction.dll                                          | 2017.140.3048.4 | 8614984   | 01-Dec-18 | 02:31 | x86      |
| Txtermlookup.dll                                              | 2017.140.3048.4 | 4157208   | 01-Dec-18 | 02:30 | x64      |
| Txtermlookup.dll                                              | 2017.140.3048.4 | 4106824   | 01-Dec-18 | 02:31 | x86      |
| Txunionall.dll                                                | 2017.140.3048.4 | 182048    | 01-Dec-18 | 02:30 | x64      |
| Txunionall.dll                                                | 2017.140.3048.4 | 139544    | 01-Dec-18 | 02:31 | x86      |
| Txunpivot.dll                                                 | 2017.140.3048.4 | 199752    | 01-Dec-18 | 02:30 | x64      |
| Txunpivot.dll                                                 | 2017.140.3048.4 | 160328    | 01-Dec-18 | 02:31 | x86      |
| Xe.dll                                                        | 2017.140.3048.4 | 673352    | 01-Dec-18 | 02:31 | x64      |
| Xe.dll                                                        | 2017.140.3048.4 | 595720    | 01-Dec-18 | 02:31 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 01-Dec-18 | 02:04 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 01-Dec-18 | 02:04 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 01-Dec-18 | 02:04 | x86      |
| Instapi140.dll                                                       | 2017.140.3048.4  | 70728     | 01-Dec-18 | 02:04 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 01-Dec-18 | 02:19 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 01-Dec-18 | 02:20 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 01-Dec-18 | 02:27 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 01-Dec-18 | 02:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 01-Dec-18 | 02:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 01-Dec-18 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 01-Dec-18 | 02:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 01-Dec-18 | 02:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 01-Dec-18 | 02:19 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 01-Dec-18 | 02:20 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 01-Dec-18 | 02:27 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 01-Dec-18 | 02:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 01-Dec-18 | 02:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 01-Dec-18 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 01-Dec-18 | 02:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 01-Dec-18 | 02:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 01-Dec-18 | 02:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 01-Dec-18 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 01-Dec-18 | 02:04 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3048.4  | 407112    | 01-Dec-18 | 02:04 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3048.4  | 7325976   | 01-Dec-18 | 02:04 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3048.4  | 2263112   | 01-Dec-18 | 02:04 | x64      |
| Secforwarder.dll                                                     | 2017.140.3048.4  | 37640     | 01-Dec-18 | 02:04 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 01-Dec-18 | 02:04 | x64      |
| Sqldk.dll                                                            | 2017.140.3048.4  | 2730056   | 01-Dec-18 | 02:04 | x64      |
| Sqldumper.exe                                                        | 2017.140.3048.4  | 141384    | 01-Dec-18 | 02:04 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 1498376   | 01-Dec-18 | 02:04 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3915528   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3214600   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3918088   | 01-Dec-18 | 02:10 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3821832   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 2090248   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 2037000   | 01-Dec-18 | 02:05 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3589384   | 01-Dec-18 | 02:12 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3597576   | 01-Dec-18 | 02:21 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 1445640   | 01-Dec-18 | 02:04 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3048.4  | 3785992   | 01-Dec-18 | 02:12 | x64      |
| Sqlos.dll                                                            | 2017.140.3048.4  | 26184     | 01-Dec-18 | 02:04 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 01-Dec-18 | 02:04 | x64      |
| Sqltses.dll                                                          | 2017.140.3048.4  | 9734920   | 01-Dec-18 | 02:04 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3048.4     | 23816     | 01-Dec-18 | 02:30 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3048.4 | 1448712   | 01-Dec-18 | 02:31 | x86      |
| Dtaengine.exe                                          | 2017.140.3048.4 | 204552    | 01-Dec-18 | 02:30 | x86      |
| Dteparse.dll                                           | 2017.140.3048.4 | 111176    | 01-Dec-18 | 02:30 | x64      |
| Dteparse.dll                                           | 2017.140.3048.4 | 100632    | 01-Dec-18 | 02:30 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3048.4 | 89160     | 01-Dec-18 | 02:30 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3048.4 | 83528     | 01-Dec-18 | 02:30 | x86      |
| Dtepkg.dll                                             | 2017.140.3048.4 | 137800    | 01-Dec-18 | 02:30 | x64      |
| Dtepkg.dll                                             | 2017.140.3048.4 | 117000    | 01-Dec-18 | 02:30 | x86      |
| Dtexec.exe                                             | 2017.140.3048.4 | 73992     | 01-Dec-18 | 02:30 | x64      |
| Dtexec.exe                                             | 2017.140.3048.4 | 67656     | 01-Dec-18 | 02:30 | x86      |
| Dts.dll                                                | 2017.140.3048.4 | 2998856   | 01-Dec-18 | 02:30 | x64      |
| Dts.dll                                                | 2017.140.3048.4 | 2549528   | 01-Dec-18 | 02:30 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3048.4 | 475208    | 01-Dec-18 | 02:30 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3048.4 | 417864    | 01-Dec-18 | 02:30 | x86      |
| Dtsconn.dll                                            | 2017.140.3048.4 | 497432    | 01-Dec-18 | 02:30 | x64      |
| Dtsconn.dll                                            | 2017.140.3048.4 | 399432    | 01-Dec-18 | 02:30 | x86      |
| Dtshost.exe                                            | 2017.140.3048.4 | 104728    | 01-Dec-18 | 02:30 | x64      |
| Dtshost.exe                                            | 2017.140.3048.4 | 89864     | 01-Dec-18 | 02:31 | x86      |
| Dtslog.dll                                             | 2017.140.3048.4 | 120608    | 01-Dec-18 | 02:30 | x64      |
| Dtslog.dll                                             | 2017.140.3048.4 | 103192    | 01-Dec-18 | 02:30 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3048.4 | 545352    | 01-Dec-18 | 02:30 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3048.4 | 541256    | 01-Dec-18 | 02:31 | x86      |
| Dtspipeline.dll                                        | 2017.140.3048.4 | 1266456   | 01-Dec-18 | 02:30 | x64      |
| Dtspipeline.dll                                        | 2017.140.3048.4 | 1059592   | 01-Dec-18 | 02:30 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3048.4 | 48200     | 01-Dec-18 | 02:30 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3048.4 | 42568     | 01-Dec-18 | 02:30 | x86      |
| Dtuparse.dll                                           | 2017.140.3048.4 | 89376     | 01-Dec-18 | 02:30 | x64      |
| Dtuparse.dll                                           | 2017.140.3048.4 | 80152     | 01-Dec-18 | 02:30 | x86      |
| Dtutil.exe                                             | 2017.140.3048.4 | 147208    | 01-Dec-18 | 02:30 | x64      |
| Dtutil.exe                                             | 2017.140.3048.4 | 126216    | 01-Dec-18 | 02:30 | x86      |
| Exceldest.dll                                          | 2017.140.3048.4 | 260680    | 01-Dec-18 | 02:30 | x64      |
| Exceldest.dll                                          | 2017.140.3048.4 | 214792    | 01-Dec-18 | 02:30 | x86      |
| Excelsrc.dll                                           | 2017.140.3048.4 | 282904    | 01-Dec-18 | 02:30 | x64      |
| Excelsrc.dll                                           | 2017.140.3048.4 | 230664    | 01-Dec-18 | 02:30 | x86      |
| Flatfiledest.dll                                       | 2017.140.3048.4 | 386632    | 01-Dec-18 | 02:30 | x64      |
| Flatfiledest.dll                                       | 2017.140.3048.4 | 333088    | 01-Dec-18 | 02:30 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3048.4 | 398920    | 01-Dec-18 | 02:30 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3048.4 | 344344    | 01-Dec-18 | 02:30 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3048.4 | 96544     | 01-Dec-18 | 02:30 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3048.4 | 80664     | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3048.4     | 72968     | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3048.4     | 186632    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3048.4     | 409904    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3048.4     | 409888    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3048.4     | 2093344   | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3048.4     | 2093336   | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3048.4     | 614176    | 01-Dec-18 | 02:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3048.4     | 613960    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3048.4     | 252488    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3048.4 | 152136    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3048.4 | 141896    | 01-Dec-18 | 02:31 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3048.4 | 159520    | 01-Dec-18 | 02:30 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3048.4 | 145480    | 01-Dec-18 | 02:31 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3048.4 | 103200    | 01-Dec-18 | 02:30 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3048.4 | 90376     | 01-Dec-18 | 02:30 | x86      |
| Msmgdsrv.dll                                           | 2017.140.239.1  | 7310648   | 01-Dec-18 | 02:31 | x86      |
| Oledbdest.dll                                          | 2017.140.3048.4 | 261408    | 01-Dec-18 | 02:30 | x64      |
| Oledbdest.dll                                          | 2017.140.3048.4 | 214792    | 01-Dec-18 | 02:30 | x86      |
| Oledbsrc.dll                                           | 2017.140.3048.4 | 289072    | 01-Dec-18 | 02:30 | x64      |
| Oledbsrc.dll                                           | 2017.140.3048.4 | 233240    | 01-Dec-18 | 02:30 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3048.4 | 100616    | 01-Dec-18 | 02:30 | x64      |
| Sqlresld.dll                                           | 2017.140.3048.4 | 30792     | 01-Dec-18 | 02:30 | x64      |
| Sqlresld.dll                                           | 2017.140.3048.4 | 28936     | 01-Dec-18 | 02:31 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3048.4 | 32528     | 01-Dec-18 | 02:30 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3048.4 | 29456     | 01-Dec-18 | 02:31 | x86      |
| Sqlscm.dll                                             | 2017.140.3048.4 | 71240     | 01-Dec-18 | 02:30 | x64      |
| Sqlscm.dll                                             | 2017.140.3048.4 | 61000     | 01-Dec-18 | 02:31 | x86      |
| Sqlsvc.dll                                             | 2017.140.3048.4 | 162072    | 01-Dec-18 | 02:30 | x64      |
| Sqlsvc.dll                                             | 2017.140.3048.4 | 134936    | 01-Dec-18 | 02:31 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3048.4 | 184096    | 01-Dec-18 | 02:30 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3048.4 | 155416    | 01-Dec-18 | 02:31 | x86      |
| Txdataconvert.dll                                      | 2017.140.3048.4 | 292936    | 01-Dec-18 | 02:30 | x64      |
| Txdataconvert.dll                                      | 2017.140.3048.4 | 253208    | 01-Dec-18 | 02:31 | x86      |
| Xe.dll                                                 | 2017.140.3048.4 | 673352    | 01-Dec-18 | 02:31 | x64      |
| Xe.dll                                                 | 2017.140.3048.4 | 595720    | 01-Dec-18 | 02:31 | x86      |
| Xmlrw.dll                                              | 2017.140.3048.4 | 305224    | 01-Dec-18 | 02:31 | x64      |
| Xmlrw.dll                                              | 2017.140.3048.4 | 257800    | 01-Dec-18 | 02:31 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3048.4 | 224520    | 01-Dec-18 | 02:31 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3048.4 | 189512    | 01-Dec-18 | 02:31 | x86      |

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
