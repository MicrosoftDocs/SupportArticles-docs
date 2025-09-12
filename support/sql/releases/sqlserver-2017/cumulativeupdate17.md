---
title: Cumulative update 17 for SQL Server 2017 (KB4515579)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 17 (KB4515579).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4515579, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4515579 - Cumulative Update 17 for SQL Server 2017

_Release Date:_ &nbsp; October 8, 2019  
_Version:_ &nbsp; 14.0.3238.1

## Summary

This article describes Cumulative Update package 17 (CU17) for Microsoft SQL Server 2017. This update contains 35 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 16, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3238.1**, file version: **2017.140.3238.1**
- Analysis Services - Product version: **14.0.249.17**, file version: **2017.140.249.17**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area | Component | Platform |
|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=13049501>[13049501](#13049501) </a>| [FIX: Synchronize command copies SSAS 2017 tabular model database role membership even when Skipmembership is used (KB4522911)](https://support.microsoft.com/help/4522911) | Analysis Services | Analysis Services | Windows |
| <a id=13076556>[13076556](#13076556) </a>| [FIX: Unexpected results occur when you query a SSAS 2017 tabular mode database in DQ mode (KB4517404)](https://support.microsoft.com/help/4517404) | Analysis Services | Analysis Services | Windows |
| <a id=13088831>[13088831](#13088831) </a>| [FIX: Error occurs when you refresh data on Power BI after Process FULL of SSAS 2017 Tabular database (KB4522909)](https://support.microsoft.com/help/4522909) | Analysis Services | Analysis Services | Windows |
| <a id=12865857>[12865857](#12865857) </a>| [FIX: SQL jobs fail due to blocking in SSISDB in SQL Server 2014, 2016 and 2017 (KB4338636)](https://support.microsoft.com/help/4338636)| Integration Services | Integration Services| Windows |
| <a id=13045830>[13045830](#13045830) </a>| [FIX: Hadoop File System Task fails to copy gigabyte-large file from HDFS in SQL Server 2017 (KB4515773)](https://support.microsoft.com/help/4515773) | Integration Services | Tasks_Components | Windows |
| <a id=13109883>[13109883](#13109883) </a>| [FIX: File content is sent twice when copied to HDFS using Hadoop File System Task in SQL Server 2017 (KB4516999)](https://support.microsoft.com/help/4516999) | Integration Services | Tasks_Components | Windows |
| <a id=13078232>[13078232](#13078232) </a>| [FIX: Accessibility bugs are fixed in MDS 2019 but not fixed in MDS 2017 (KB4520438)](https://support.microsoft.com/help/4520438) | Master Data Services | Client | Windows |
| <a id=13087325>[13087325](#13087325) </a>| [FIX: Restore or RESTORE VERIFYONLY of a TDE-compressed backup fails in SQL Server 2016 and 2017 (KB4513097)](https://support.microsoft.com/help/4513097) | SQL Server Engine | Backup Restore | Windows |
| <a id=13087329>[13087329](#13087329) </a>| [FIX: Azure storage I/O subsystem may not reset transfer details for a failed I/O resulting in backup errors (KB4513099)](https://support.microsoft.com/help/4513099) | SQL Server Engine | Backup Restore | All |
| <a id=13087330>[13087330](#13087330) </a>| [FIX: Error 9003 occurs when you back up a database on a secondary replica in Microsoft SQL Server 2016 and 2017 (KB4513238)](https://support.microsoft.com/help/4513238) | SQL Server Engine | Backup Restore | Windows |
| <a id=13163565>[13163565](#13163565) </a>| [FIX: SQL Writer Service fails to back up in non-component backup path in SQL Server 2016 and 2017 (KB4521659)](https://support.microsoft.com/help/4521659) | SQL Server Engine | Backup Restore | Windows |
| <a id=13037041>[13037041](#13037041) </a> </br><a id=13037044>[13037044](#13037044) </a> | [FIX: Query against table with both clustered columnstore index and nonclustered rowstore index may return incorrect results in SQL Server 2016 and 2017 (KB4497225)](https://support.microsoft.com/help/4497225) | SQL Server Engine| Column Stores | All|
| <a id=13037043>[13037043](#13037043) </a> </br><a id=13037045>[13037045](#13037045) </a> | [FIX: Columnstore filter pushdown may return wrong results when there is an overflow in filter expressions in SQL Server 2014, 2016 and 2017 (KB4497701)](https://support.microsoft.com/help/4497701) | SQL Server Engine| Column Stores | All|
| <a id=13087324>[13087324](#13087324) </a>| [FIX: Access violation error occurs when SQL Server 2016 and 2017 uses hash join, hash aggregate, sort or window function in batch-mode plan in the deadlock monitor (KB4511751)](https://support.microsoft.com/help/4511751) | SQL Server Engine | Column Stores | Windows|
| <a id=13087333>[13087333](#13087333) </a>| [FIX: Assertion error occurs when SQL Server 2016 and 2017 use hash join, hash aggregate, sort or window function in batch-mode plan (KB4512558)](https://support.microsoft.com/help/4512558) | SQL Server Engine | Column Stores | All |
| <a id=13136089>[13136089](#13136089) </a>| [FIX: Non-yielding scheduler error occurs when you run batch query with sort operation in SQL Server 2017 (KB4522405)](https://support.microsoft.com/help/4522405) | SQL Server Engine | Column Stores | All |
| <a id=13086241>[13086241](#13086241) </a>| [FIX: Unable to mount SQL Server FILESTREAM share from Linux with SMB 3.x protocol (KB4520124)](https://support.microsoft.com/help/4520124) | SQL Server Engine | FileStream and FileTable | Windows|
| <a id=12752114>[12752114](#12752114) </a>| [FIX: sys.fn_hadr_backup_is_preferred_replica causes error 41005 in SQL Server 2017 (KB4502442)](https://support.microsoft.com/help/4502442) | SQL Server Engine | High Availability and Disaster Recover | Windows |
| <a id=12947210>[12947210](#12947210) </a>| [FIX: AG is suspended when cross-database transaction is applied on AG databases in SQL Server 2016 and 2017 (KB4500770)](https://support.microsoft.com/help/4500770) | SQL Server Engine | High Availability and Disaster Recover | Windows |
| <a id=13017120>[13017120](#13017120) </a>| [FIX: Error 41162 occurs when the creation of distributed availability groups fails in SQL Server 2016 and 2017 (KB4495663)](https://support.microsoft.com/help/4495663) | SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=13043160>[13043160](#13043160) </a>| [FIX: Assertion occurs when you fail over Read-Scale AlwaysOn Availability Groups in SQL Server 2017 (KB4520149)](https://support.microsoft.com/help/4520149) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13059436>[13059436](#13059436) </a>| [FIX: Error 35262 with Severity 17 occurs when database is part of an Availability Group in SQL Server 2017 (KB4520148)](https://support.microsoft.com/help/4520148) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=13159467>[13159467](#13159467) </a>| [FIX: JDBC XA transaction fails with an error in SQL Server 2017 on Linux (KB4521758)](https://support.microsoft.com/help/4521758) | SQL Server Engine | Linux | Linux |
| <a id=13288306>[13288306](#13288306) </a>| [FIX: Core dump may be generated when you restart the SQL Server (KB4542725)](https://support.microsoft.com/help/4542725) | SQL Server Engine | Linux | Linux |
| <a id=13138944>[13138944](#13138944) </a>| [FIX: Stack dump occurs when table type has a user-defined constraint in SQL Server 2016 (KB4519796)](https://support.microsoft.com/help/4519796) | SQL Server Engine | Metadata | Windows |
| <a id=13161357>[13161357](#13161357) </a>| [FIX: Cardinality property for a table doesn't include rows in the delta store or deleted bitmap if the table has a clustered columnstore index (KB4521701)](https://support.microsoft.com/help/4521701) | SQL Server Engine | Metadata | Windows |
| <a id=13165551>[13165551](#13165551) </a>| [FIX: Access violation occurs when a clone database verification fails in SQL Server 2016 and 2017 (KB4521960)](https://support.microsoft.com/help/4521960) | SQL Server Engine|Metadata | Windows|
| <a id=13087320>[13087320](#13087320) </a>| [FIX: "Non-yielding Scheduler" occurs when you run queries with batch-mode hash join and/or sort in SQL Server 2016 and 2017 (KB4512567)](https://support.microsoft.com/help/4512567) | SQL Server Engine| Methods to access stored data | Windows |
| <a id=13122905>[13122905](#13122905) </a>| [FIX: Access violation occurs when you run queries that involve PIVOT or UNPIVOT in SQL Server 2016 and 2017 (KB4518364)](https://support.microsoft.com/help/4518364) | SQL Server Engine| Programmability | Windows |
| <a id=13130344>[13130344](#13130344) </a>| [FIX: Incorrect results occur with index intersection on partitioned table with a clustered columnstore index in SQL Server 2016 and 2017 (KB4519366)](https://support.microsoft.com/help/4519366) | SQL Server Engine | Query Optimizer | Windows |
| <a id=12519854>[12519854](#12519854) </a>| [FIX: Peer-to-peer replication fails in SQL Server 2016 and 2017 if the host name is not uppercase (KB4469600)](https://support.microsoft.com/help/4469600) | SQL Server Engine | Replication | Windows |
| <a id=12921465>[12921465](#12921465) </a>| [FIX: Error occurs when a non-dbo user alters procedure in SQL Server 2017 database that has Merge Publication enabled (KB4511884)](https://support.microsoft.com/help/4511884) | SQL Server Engine | Replication | Windows |
| <a id=13063787>[13063787](#13063787) </a>| [FIX: SQL Server 2017 on Linux fails with an Assertion error (KB4522002)](https://support.microsoft.com/help/4522002) | SQL Server Engine | SQL OS | Linux |
| <a id=13065294>[13065294](#13065294) </a>| [FIX: Error 8965 occurs when you run DBCC CHECKDB with PHYSICAL_ONLY option on CCI table in SQL Server 2017 (KB4522404)](https://support.microsoft.com/help/4522404) | SQL Server Engine | Storage Management | Windows |
| <a id=13061226>[13061226](#13061226) </a>| [FIX: Access violation occurs when you enable TF 3924 to clean orphaned DTC transactions in SQL Server 2016 and 2017 (KB4519668)](https://support.microsoft.com/help/4519668) | SQL Server Engine | Transaction Services | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2017 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

> [!NOTE]
>
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU17 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2019/10/sqlserver2017-kb4515579-x64_e6ab5e1c932edbff9ac99f1ba80998779745e6c6.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4515579-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4515579-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4515579-x64.exe| 172664A4B04CA0285CC13E37F3EA19281F85792A397A7813BF742A609B351E00 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date | Time | Platform |
|----------------------------------------------------|-----------------|-----------|------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.17 | 266344    | 14-9 | 03:00 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.17     | 741688    | 14-9 | 02:42 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.17     | 1380456   | 14-9 | 03:00 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.17     | 984160    | 14-9 | 03:00 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.17     | 521320    | 14-9 | 03:00 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 14-9 | 03:38 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 14-9 | 02:42 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 14-9 | 02:42 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 14-9 | 02:42 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 14-9 | 02:42 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 14-9 | 02:43 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 14-9 | 02:42 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 14-9 | 02:42 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 14-9 | 02:42 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 14-9 | 02:42 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 14-9 | 02:42 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 14-9 | 02:42 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 14-9 | 02:42 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 14-9 | 02:42 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 14-9 | 02:42 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 14-9 | 02:43 | x86      |
| Msmdctr.dll                                        | 2017.140.249.17 | 40040     | 14-9 | 03:11 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.17 | 40414312  | 14-9 | 03:00 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.17 | 60753744  | 14-9 | 03:12 | x64      |
| Msmdpump.dll                                       | 2017.140.249.17 | 9339496   | 14-9 | 03:11 | x64      |
| Msmdredir.dll                                      | 2017.140.249.17 | 7094888   | 14-9 | 03:12 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.17 | 60652136  | 14-9 | 03:12 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.17 | 7311456   | 14-9 | 03:00 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.17 | 9007424   | 14-9 | 03:12 | x64      |
| Msolap.dll                                         | 2017.140.249.17 | 10262632  | 14-9 | 03:12 | x64      |
| Msolap.dll                                         | 2017.140.249.17 | 7779432   | 14-9 | 03:12 | x86      |
| Msolui.dll                                         | 2017.140.249.17 | 310888    | 14-9 | 03:11 | x64      |
| Msolui.dll                                         | 2017.140.249.17 | 287336    | 14-9 | 03:12 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 14-9 | 02:43 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlboot.dll                                        | 2017.140.3238.1 | 196200    | 14-9 | 03:11 | x64      |
| Sqlceip.exe                                        | 14.0.3238.1     | 261736    | 14-9 | 03:38 | x86      |
| Sqldumper.exe                                      | 2017.140.3238.1 | 121960    | 14-9 | 03:22 | x86      |
| Sqldumper.exe                                      | 2017.140.3238.1 | 143976    | 14-9 | 03:31 | x64      |
| Tmapi.dll                                          | 2017.140.249.17 | 5821752   | 14-9 | 03:12 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.17 | 4164920   | 14-9 | 03:12 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.17 | 1132344   | 14-9 | 03:12 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.17 | 1641064   | 14-9 | 03:12 | x64      |
| Xe.dll                                             | 2017.140.3238.1 | 673384    | 14-9 | 03:12 | x64      |
| Xmlrw.dll                                          | 2017.140.3238.1 | 305256    | 14-9 | 03:12 | x64      |
| Xmlrw.dll                                          | 2017.140.3238.1 | 257640    | 14-9 | 03:12 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3238.1 | 224360    | 14-9 | 03:12 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3238.1 | 189544    | 14-9 | 03:12 | x86      |
| Xmsrv.dll                                          | 2017.140.249.17 | 25379432  | 14-9 | 03:12 | x64      |
| Xmsrv.dll                                          | 2017.140.249.17 | 33353552  | 14-9 | 03:12 | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date | Time | Platform |
|--------------------------------------------|------------------|-----------|------|------|----------|
| Batchparser.dll                            | 2017.140.3238.1  | 160360    | 14-9 | 02:54 | x86      |
| Batchparser.dll                            | 2017.140.3238.1  | 180840    | 14-9 | 03:00 | x64      |
| Instapi140.dll                             | 2017.140.3238.1  | 61032     | 14-9 | 03:00 | x86      |
| Instapi140.dll                             | 2017.140.3238.1  | 70760     | 14-9 | 03:11 | x64      |
| Isacctchange.dll                           | 2017.140.3238.1  | 29288     | 14-9 | 02:54 | x86      |
| Isacctchange.dll                           | 2017.140.3238.1  | 30824     | 14-9 | 03:00 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.17      | 1088616   | 14-9 | 02:54 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.17      | 1088616   | 14-9 | 03:00 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.17      | 1381480   | 14-9 | 02:54 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.17      | 741480    | 14-9 | 02:54 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.17      | 741472    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3238.1      | 36960     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3238.1  | 78440     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3238.1  | 82024     | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3238.1      | 571496    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3238.1      | 571496    | 14-9 | 03:00 | x86      |
| Msasxpress.dll                             | 2017.140.249.17  | 31848     | 14-9 | 03:00 | x86      |
| Msasxpress.dll                             | 2017.140.249.17  | 35944     | 14-9 | 03:11 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3238.1  | 82536     | 14-9 | 03:12 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3238.1  | 68200     | 14-9 | 03:12 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3238.1  | 100456    | 14-9 | 03:00 | x64      |
| Sqldumper.exe                              | 2017.140.3238.1  | 121960    | 14-9 | 03:22 | x86      |
| Sqldumper.exe                              | 2017.140.3238.1  | 143976    | 14-9 | 03:31 | x64      |
| Sqlftacct.dll                              | 2017.140.3238.1  | 62568     | 14-9 | 03:11 | x64      |
| Sqlftacct.dll                              | 2017.140.3238.1  | 55400     | 14-9 | 03:12 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 14-9 | 03:00 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 14-9 | 03:11 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3238.1  | 373864    | 14-9 | 03:00 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3238.1  | 418920    | 14-9 | 03:11 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3238.1  | 37480     | 14-9 | 03:11 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3238.1  | 34920     | 14-9 | 03:12 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3238.1  | 355944    | 14-9 | 03:11 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3238.1  | 273000    | 14-9 | 03:12 | x86      |
| Sqltdiagn.dll                              | 2017.140.3238.1  | 60520     | 14-9 | 03:00 | x86      |
| Sqltdiagn.dll                              | 2017.140.3238.1  | 67688     | 14-9 | 03:11 | x64      |
| Svrenumapi140.dll                          | 2017.140.3238.1  | 1173096   | 14-9 | 03:12 | x64      |
| Svrenumapi140.dll                          | 2017.140.3238.1  | 893544    | 14-9 | 03:12 | x86      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date | Time | Platform |
|---------------------|-----------------|-----------|------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 14-9 | 03:00 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 14-9 | 03:00 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 14-9 | 03:12 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 14-9 | 03:12 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date | Time | Platform |
|---------------------------------------------------|--------------|-----------|------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-9 | 02:54 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-9 | 03:00 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-9 | 02:54 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-9 | 03:00 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date | Time | Platform |
|--------------------------------|-----------------|-----------|------|------|----------|
| Dreplayclient.exe              | 2017.140.3238.1 | 120936    | 14-9 | 02:54 | x86      |
| Dreplaycommon.dll              | 2017.140.3238.1 | 698984    | 14-9 | 02:54 | x86      |
| Dreplayserverps.dll            | 2017.140.3238.1 | 32864     | 14-9 | 02:54 | x86      |
| Dreplayutil.dll                | 2017.140.3238.1 | 309864    | 14-9 | 02:54 | x86      |
| Instapi140.dll                 | 2017.140.3238.1 | 70760     | 14-9 | 03:11 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlresourceloader.dll          | 2017.140.3238.1 | 29288     | 14-9 | 03:00 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date | Time | Platform |
|------------------------------------|-----------------|-----------|------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3238.1 | 698984    | 14-9 | 02:54 | x86      |
| Dreplaycontroller.exe              | 2017.140.3238.1 | 350312    | 14-9 | 02:54 | x86      |
| Dreplayprocess.dll                 | 2017.140.3238.1 | 171624    | 14-9 | 02:54 | x86      |
| Dreplayserverps.dll                | 2017.140.3238.1 | 32864     | 14-9 | 02:54 | x86      |
| Instapi140.dll                     | 2017.140.3238.1 | 70760     | 14-9 | 03:11 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlresourceloader.dll              | 2017.140.3238.1 | 29288     | 14-9 | 03:00 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date | Time | Platform |
|----------------------------------------------|-----------------|-----------|------|------|----------|
| Backuptourl.exe                              | 14.0.3238.1     | 40552     | 14-9 | 03:00 | x64      |
| Batchparser.dll                              | 2017.140.3238.1 | 180840    | 14-9 | 03:00 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 14-9 | 03:37 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 14-9 | 03:38 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 14-9 | 03:37 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 14-9 | 02:41 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 14-9 | 03:00 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3238.1 | 226408    | 14-9 | 03:00 | x64      |
| Dcexec.exe                                   | 2017.140.3238.1 | 74336     | 14-9 | 03:00 | x64      |
| Fssres.dll                                   | 2017.140.3238.1 | 89704     | 14-9 | 03:11 | x64      |
| Hadrres.dll                                  | 2017.140.3238.1 | 188008    | 14-9 | 03:11 | x64      |
| Hkcompile.dll                                | 2017.140.3238.1 | 1422952   | 14-9 | 03:11 | x64      |
| Hkengine.dll                                 | 2017.140.3238.1 | 5858408   | 14-9 | 03:11 | x64      |
| Hkruntime.dll                                | 2017.140.3238.1 | 162920    | 14-9 | 03:11 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 14-9 | 03:37 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.17     | 740968    | 14-9 | 03:00 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 14-9 | 03:38 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3238.1     | 236136    | 14-9 | 03:00 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3238.1     | 79464     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3238.1 | 392808    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3238.1 | 72296     | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3238.1 | 65128     | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3238.1 | 152168    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3238.1 | 159336    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3238.1 | 303720    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3238.1 | 74856     | 14-9 | 03:00 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 14-9 | 03:37 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 14-9 | 03:37 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 14-9 | 03:37 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 14-9 | 03:37 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 14-9 | 03:38 | x64      |
| Odsole70.dll                                 | 2017.140.3238.1 | 92776     | 14-9 | 03:11 | x64      |
| Opends60.dll                                 | 2017.140.3238.1 | 32872     | 14-9 | 03:11 | x64      |
| Qds.dll                                      | 2017.140.3238.1 | 1179752   | 14-9 | 03:12 | x64      |
| Rsfxft.dll                                   | 2017.140.3238.1 | 34408     | 14-9 | 03:11 | x64      |
| Secforwarder.dll                             | 2017.140.3238.1 | 37480     | 14-9 | 03:11 | x64      |
| Sqagtres.dll                                 | 2017.140.3238.1 | 74344     | 14-9 | 03:11 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlaamss.dll                                 | 2017.140.3238.1 | 90216     | 14-9 | 03:11 | x64      |
| Sqlaccess.dll                                | 2017.140.3238.1 | 475752    | 14-9 | 03:11 | x64      |
| Sqlagent.exe                                 | 2017.140.3238.1 | 582248    | 14-9 | 03:11 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3238.1 | 52840     | 14-9 | 03:00 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3238.1 | 62056     | 14-9 | 03:11 | x64      |
| Sqlagentlog.dll                              | 2017.140.3238.1 | 32872     | 14-9 | 03:11 | x64      |
| Sqlagentmail.dll                             | 2017.140.3238.1 | 53864     | 14-9 | 03:11 | x64      |
| Sqlboot.dll                                  | 2017.140.3238.1 | 196200    | 14-9 | 03:11 | x64      |
| Sqlceip.exe                                  | 14.0.3238.1     | 261736    | 14-9 | 03:38 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3238.1 | 72808     | 14-9 | 03:11 | x64      |
| Sqlctr140.dll                                | 2017.140.3238.1 | 129128    | 14-9 | 03:11 | x64      |
| Sqlctr140.dll                                | 2017.140.3238.1 | 112232    | 14-9 | 03:12 | x86      |
| Sqldk.dll                                    | 2017.140.3238.1 | 2800744   | 14-9 | 03:11 | x64      |
| Sqldtsss.dll                                 | 2017.140.3238.1 | 107624    | 14-9 | 03:11 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3639912   | 14-9 | 02:41 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 1447016   | 14-9 | 02:41 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 1499752   | 14-9 | 02:42 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3406440   | 14-9 | 02:42 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3341928   | 14-9 | 02:48 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3217000   | 14-9 | 02:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3918952   | 14-9 | 02:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3789416   | 14-9 | 02:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3824744   | 14-9 | 03:07 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3680872   | 14-9 | 03:19 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3600488   | 14-9 | 03:20 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3371112   | 14-9 | 03:20 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 2038888   | 14-9 | 03:22 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3294824   | 14-9 | 03:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3300968   | 14-9 | 03:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3790952   | 14-9 | 03:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 2092136   | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3592296   | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 4031080   | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3783784   | 14-9 | 03:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3921512   | 14-9 | 03:36 | x64      |
| Sqlevn70.rll                                 | 2017.140.3238.1 | 3485288   | 14-9 | 03:38 | x64      |
| Sqliosim.com                                 | 2017.140.3238.1 | 313440    | 14-9 | 03:11 | x64      |
| Sqliosim.exe                                 | 2017.140.3238.1 | 3019880   | 14-9 | 03:11 | x64      |
| Sqllang.dll                                  | 2017.140.3238.1 | 41294952  | 14-9 | 03:12 | x64      |
| Sqlmin.dll                                   | 2017.140.3238.1 | 40511080  | 14-9 | 03:12 | x64      |
| Sqlolapss.dll                                | 2017.140.3238.1 | 107624    | 14-9 | 03:11 | x64      |
| Sqlos.dll                                    | 2017.140.3238.1 | 26216     | 14-9 | 03:11 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3238.1 | 68200     | 14-9 | 03:11 | x64      |
| Sqlrepss.dll                                 | 2017.140.3238.1 | 64616     | 14-9 | 03:11 | x64      |
| Sqlresld.dll                                 | 2017.140.3238.1 | 30824     | 14-9 | 03:11 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3238.1 | 32352     | 14-9 | 03:11 | x64      |
| Sqlscm.dll                                   | 2017.140.3238.1 | 71264     | 14-9 | 03:11 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3238.1 | 27752     | 14-9 | 03:11 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3238.1 | 5881960   | 14-9 | 03:12 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3238.1 | 732776    | 14-9 | 03:11 | x64      |
| Sqlservr.exe                                 | 2017.140.3238.1 | 487528    | 14-9 | 03:11 | x64      |
| Sqlsvc.dll                                   | 2017.140.3238.1 | 161896    | 14-9 | 03:11 | x64      |
| Sqltses.dll                                  | 2017.140.3238.1 | 9564776   | 14-9 | 03:12 | x64      |
| Sqsrvres.dll                                 | 2017.140.3238.1 | 261224    | 14-9 | 03:11 | x64      |
| Svl.dll                                      | 2017.140.3238.1 | 153704    | 14-9 | 03:11 | x64      |
| Xe.dll                                       | 2017.140.3238.1 | 673384    | 14-9 | 03:12 | x64      |
| Xmlrw.dll                                    | 2017.140.3238.1 | 305256    | 14-9 | 03:12 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3238.1 | 224360    | 14-9 | 03:12 | x64      |
| Xpadsi.exe                                   | 2017.140.3238.1 | 89704     | 14-9 | 03:11 | x64      |
| Xplog70.dll                                  | 2017.140.3238.1 | 75880     | 14-9 | 03:12 | x64      |
| Xpqueue.dll                                  | 2017.140.3238.1 | 74856     | 14-9 | 03:12 | x64      |
| Xprepl.dll                                   | 2017.140.3238.1 | 101992    | 14-9 | 03:12 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3238.1 | 32360     | 14-9 | 03:12 | x64      |
| Xpstar.dll                                   | 2017.140.3238.1 | 438376    | 14-9 | 03:11 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|------|------|----------|
| Batchparser.dll                                             | 2017.140.3238.1 | 160360    | 14-9 | 02:54 | x86      |
| Batchparser.dll                                             | 2017.140.3238.1 | 180840    | 14-9 | 03:00 | x64      |
| Bcp.exe                                                     | 2017.140.3238.1 | 119912    | 14-9 | 03:11 | x64      |
| Commanddest.dll                                             | 2017.140.3238.1 | 245864    | 14-9 | 03:00 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3238.1 | 116328    | 14-9 | 03:00 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3238.1 | 187496    | 14-9 | 03:00 | x64      |
| Distrib.exe                                                 | 2017.140.3238.1 | 203368    | 14-9 | 03:11 | x64      |
| Dteparse.dll                                                | 2017.140.3238.1 | 111208    | 14-9 | 03:00 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3238.1 | 89184     | 14-9 | 03:00 | x64      |
| Dtepkg.dll                                                  | 2017.140.3238.1 | 137832    | 14-9 | 03:00 | x64      |
| Dtexec.exe                                                  | 2017.140.3238.1 | 73832     | 14-9 | 03:00 | x64      |
| Dts.dll                                                     | 2017.140.3238.1 | 2998888   | 14-9 | 03:00 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3238.1 | 475240    | 14-9 | 03:00 | x64      |
| Dtsconn.dll                                                 | 2017.140.3238.1 | 497256    | 14-9 | 03:00 | x64      |
| Dtshost.exe                                                 | 2017.140.3238.1 | 104544    | 14-9 | 03:11 | x64      |
| Dtslog.dll                                                  | 2017.140.3238.1 | 120424    | 14-9 | 03:00 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3238.1 | 545384    | 14-9 | 03:11 | x64      |
| Dtspipeline.dll                                             | 2017.140.3238.1 | 1266280   | 14-9 | 03:00 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3238.1 | 48232     | 14-9 | 03:00 | x64      |
| Dtuparse.dll                                                | 2017.140.3238.1 | 89192     | 14-9 | 03:00 | x64      |
| Dtutil.exe                                                  | 2017.140.3238.1 | 147048    | 14-9 | 03:00 | x64      |
| Exceldest.dll                                               | 2017.140.3238.1 | 260712    | 14-9 | 03:00 | x64      |
| Excelsrc.dll                                                | 2017.140.3238.1 | 282728    | 14-9 | 03:00 | x64      |
| Execpackagetask.dll                                         | 2017.140.3238.1 | 168040    | 14-9 | 03:00 | x64      |
| Flatfiledest.dll                                            | 2017.140.3238.1 | 386664    | 14-9 | 03:00 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3238.1 | 398952    | 14-9 | 03:00 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3238.1 | 96360     | 14-9 | 03:00 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3238.1 | 59496     | 14-9 | 03:11 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 14-9 | 02:43 | x86      |
| Logread.exe                                                 | 2017.140.3238.1 | 634984    | 14-9 | 03:11 | x64      |
| Mergetxt.dll                                                | 2017.140.3238.1 | 63592     | 14-9 | 03:11 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.17     | 1381480   | 14-9 | 03:00 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 14-9 | 02:43 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3238.1     | 137832    | 14-9 | 02:54 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3238.1     | 54888     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3238.1     | 89704     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3238.1     | 73312     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3238.1     | 613992    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3238.1 | 1663592   | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3238.1     | 571496    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3238.1 | 152168    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3238.1 | 159336    | 14-9 | 03:00 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3238.1 | 103016    | 14-9 | 03:00 | x64      |
| Msgprox.dll                                                 | 2017.140.3238.1 | 270432    | 14-9 | 03:11 | x64      |
| Msxmlsql.dll                                                | 2017.140.3238.1 | 1448040   | 14-9 | 03:11 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 14-9 | 02:43 | x86      |
| Oledbdest.dll                                               | 2017.140.3238.1 | 261224    | 14-9 | 03:00 | x64      |
| Oledbsrc.dll                                                | 2017.140.3238.1 | 288872    | 14-9 | 03:00 | x64      |
| Osql.exe                                                    | 2017.140.3238.1 | 75360     | 14-9 | 03:00 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3238.1 | 474216    | 14-9 | 03:12 | x64      |
| Rawdest.dll                                                 | 2017.140.3238.1 | 206440    | 14-9 | 03:11 | x64      |
| Rawsource.dll                                               | 2017.140.3238.1 | 194152    | 14-9 | 03:11 | x64      |
| Rdistcom.dll                                                | 2017.140.3238.1 | 857704    | 14-9 | 03:12 | x64      |
| Recordsetdest.dll                                           | 2017.140.3238.1 | 184416    | 14-9 | 03:11 | x64      |
| Replagnt.dll                                                | 2017.140.3238.1 | 30824     | 14-9 | 03:12 | x64      |
| Repldp.dll                                                  | 2017.140.3238.1 | 290920    | 14-9 | 03:12 | x64      |
| Replerrx.dll                                                | 2017.140.3238.1 | 154216    | 14-9 | 03:12 | x64      |
| Replisapi.dll                                               | 2017.140.3238.1 | 362088    | 14-9 | 03:12 | x64      |
| Replmerg.exe                                                | 2017.140.3238.1 | 524904    | 14-9 | 03:12 | x64      |
| Replprov.dll                                                | 2017.140.3238.1 | 802408    | 14-9 | 03:12 | x64      |
| Replrec.dll                                                 | 2017.140.3238.1 | 975976    | 14-9 | 03:12 | x64      |
| Replsub.dll                                                 | 2017.140.3238.1 | 445544    | 14-9 | 03:12 | x64      |
| Replsync.dll                                                | 2017.140.3238.1 | 154216    | 14-9 | 03:12 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 14-9 | 03:11 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 14-9 | 03:11 | x64      |
| Spresolv.dll                                                | 2017.140.3238.1 | 252008    | 14-9 | 03:11 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3238.1 | 248936    | 14-9 | 03:11 | x64      |
| Sqldiag.exe                                                 | 2017.140.3238.1 | 1257576   | 14-9 | 03:11 | x64      |
| Sqldistx.dll                                                | 2017.140.3238.1 | 225384    | 14-9 | 03:11 | x64      |
| Sqllogship.exe                                              | 14.0.3238.1     | 105576    | 14-9 | 03:11 | x64      |
| Sqlmergx.dll                                                | 2017.140.3238.1 | 360552    | 14-9 | 03:12 | x64      |
| Sqlresld.dll                                                | 2017.140.3238.1 | 28776     | 14-9 | 03:00 | x86      |
| Sqlresld.dll                                                | 2017.140.3238.1 | 30824     | 14-9 | 03:11 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3238.1 | 29288     | 14-9 | 03:00 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3238.1 | 32352     | 14-9 | 03:11 | x64      |
| Sqlscm.dll                                                  | 2017.140.3238.1 | 61032     | 14-9 | 03:00 | x86      |
| Sqlscm.dll                                                  | 2017.140.3238.1 | 71264     | 14-9 | 03:11 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3238.1 | 134760    | 14-9 | 03:00 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3238.1 | 161896    | 14-9 | 03:11 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3238.1 | 183912    | 14-9 | 03:11 | x64      |
| Sqlwep140.dll                                               | 2017.140.3238.1 | 105576    | 14-9 | 03:11 | x64      |
| Ssdebugps.dll                                               | 2017.140.3238.1 | 33376     | 14-9 | 03:11 | x64      |
| Ssisoledb.dll                                               | 2017.140.3238.1 | 216168    | 14-9 | 03:11 | x64      |
| Ssradd.dll                                                  | 2017.140.3238.1 | 75368     | 14-9 | 03:11 | x64      |
| Ssravg.dll                                                  | 2017.140.3238.1 | 75880     | 14-9 | 03:11 | x64      |
| Ssrdown.dll                                                 | 2017.140.3238.1 | 61032     | 14-9 | 03:11 | x64      |
| Ssrmax.dll                                                  | 2017.140.3238.1 | 73832     | 14-9 | 03:11 | x64      |
| Ssrmin.dll                                                  | 2017.140.3238.1 | 74344     | 14-9 | 03:11 | x64      |
| Ssrpub.dll                                                  | 2017.140.3238.1 | 61544     | 14-9 | 03:11 | x64      |
| Ssrup.dll                                                   | 2017.140.3238.1 | 61032     | 14-9 | 03:11 | x64      |
| Tablediff.exe                                               | 14.0.3238.1     | 86632     | 14-9 | 03:12 | x64      |
| Txagg.dll                                                   | 2017.140.3238.1 | 362088    | 14-9 | 03:11 | x64      |
| Txbdd.dll                                                   | 2017.140.3238.1 | 170088    | 14-9 | 03:11 | x64      |
| Txdatacollector.dll                                         | 2017.140.3238.1 | 360552    | 14-9 | 03:11 | x64      |
| Txdataconvert.dll                                           | 2017.140.3238.1 | 292968    | 14-9 | 03:11 | x64      |
| Txderived.dll                                               | 2017.140.3238.1 | 604264    | 14-9 | 03:11 | x64      |
| Txlookup.dll                                                | 2017.140.3238.1 | 527976    | 14-9 | 03:11 | x64      |
| Txmerge.dll                                                 | 2017.140.3238.1 | 229992    | 14-9 | 03:11 | x64      |
| Txmergejoin.dll                                             | 2017.140.3238.1 | 275560    | 14-9 | 03:11 | x64      |
| Txmulticast.dll                                             | 2017.140.3238.1 | 127584    | 14-9 | 03:11 | x64      |
| Txrowcount.dll                                              | 2017.140.3238.1 | 125536    | 14-9 | 03:11 | x64      |
| Txsort.dll                                                  | 2017.140.3238.1 | 256608    | 14-9 | 03:11 | x64      |
| Txsplit.dll                                                 | 2017.140.3238.1 | 596584    | 14-9 | 03:11 | x64      |
| Txunionall.dll                                              | 2017.140.3238.1 | 181864    | 14-9 | 03:11 | x64      |
| Xe.dll                                                      | 2017.140.3238.1 | 673384    | 14-9 | 03:12 | x64      |
| Xmlrw.dll                                                   | 2017.140.3238.1 | 305256    | 14-9 | 03:12 | x64      |
| Xmlsub.dll                                                  | 2017.140.3238.1 | 261224    | 14-9 | 03:12 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date | Time | Platform |
|-------------------------------|-----------------|-----------|------|------|----------|
| Launchpad.exe                 | 2017.140.3238.1 | 1124968   | 14-9 | 03:11 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlsatellite.dll              | 2017.140.3238.1 | 922216    | 14-9 | 03:12 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date | Time | Platform |
|--------------------------|-----------------|-----------|------|------|----------|
| Fd.dll                   | 2017.140.3238.1 | 671336    | 14-9 | 03:11 | x64      |
| Fdhost.exe               | 2017.140.3238.1 | 114792    | 14-9 | 03:11 | x64      |
| Fdlauncher.exe           | 2017.140.3238.1 | 62568     | 14-9 | 03:11 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 14-9 | 03:11 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlft140ph.dll           | 2017.140.3238.1 | 68200     | 14-9 | 03:11 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date | Time | Platform |
|-------------------------|-----------------|-----------|------|------|----------|
| Imrdll.dll              | 14.0.3238.1     | 23656     | 14-9 | 03:00 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 14-9 | 02:54 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 14-9 | 03:00 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 14-9 | 02:54 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 14-9 | 03:00 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 14-9 | 02:54 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 14-9 | 03:00 | x86      |
| Commanddest.dll                                               | 2017.140.3238.1 | 200808    | 14-9 | 02:54 | x86      |
| Commanddest.dll                                               | 2017.140.3238.1 | 245864    | 14-9 | 03:00 | x64      |
| Dteparse.dll                                                  | 2017.140.3238.1 | 100456    | 14-9 | 02:54 | x86      |
| Dteparse.dll                                                  | 2017.140.3238.1 | 111208    | 14-9 | 03:00 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3238.1 | 83560     | 14-9 | 02:54 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3238.1 | 89184     | 14-9 | 03:00 | x64      |
| Dtepkg.dll                                                    | 2017.140.3238.1 | 116840    | 14-9 | 02:54 | x86      |
| Dtepkg.dll                                                    | 2017.140.3238.1 | 137832    | 14-9 | 03:00 | x64      |
| Dtexec.exe                                                    | 2017.140.3238.1 | 67688     | 14-9 | 02:54 | x86      |
| Dtexec.exe                                                    | 2017.140.3238.1 | 73832     | 14-9 | 03:00 | x64      |
| Dts.dll                                                       | 2017.140.3238.1 | 2549352   | 14-9 | 02:54 | x86      |
| Dts.dll                                                       | 2017.140.3238.1 | 2998888   | 14-9 | 03:00 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3238.1 | 417896    | 14-9 | 02:54 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3238.1 | 475240    | 14-9 | 03:00 | x64      |
| Dtsconn.dll                                                   | 2017.140.3238.1 | 399464    | 14-9 | 02:54 | x86      |
| Dtsconn.dll                                                   | 2017.140.3238.1 | 497256    | 14-9 | 03:00 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3238.1 | 95336     | 14-9 | 02:54 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3238.1 | 111208    | 14-9 | 03:00 | x64      |
| Dtshost.exe                                                   | 2017.140.3238.1 | 89704     | 14-9 | 03:00 | x86      |
| Dtshost.exe                                                   | 2017.140.3238.1 | 104544    | 14-9 | 03:11 | x64      |
| Dtslog.dll                                                    | 2017.140.3238.1 | 103016    | 14-9 | 02:54 | x86      |
| Dtslog.dll                                                    | 2017.140.3238.1 | 120424    | 14-9 | 03:00 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3238.1 | 541288    | 14-9 | 03:00 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3238.1 | 545384    | 14-9 | 03:11 | x64      |
| Dtspipeline.dll                                               | 2017.140.3238.1 | 1059432   | 14-9 | 02:54 | x86      |
| Dtspipeline.dll                                               | 2017.140.3238.1 | 1266280   | 14-9 | 03:00 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3238.1 | 42592     | 14-9 | 02:54 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3238.1 | 48232     | 14-9 | 03:00 | x64      |
| Dtuparse.dll                                                  | 2017.140.3238.1 | 79976     | 14-9 | 02:54 | x86      |
| Dtuparse.dll                                                  | 2017.140.3238.1 | 89192     | 14-9 | 03:00 | x64      |
| Dtutil.exe                                                    | 2017.140.3238.1 | 126056    | 14-9 | 02:54 | x86      |
| Dtutil.exe                                                    | 2017.140.3238.1 | 147048    | 14-9 | 03:00 | x64      |
| Exceldest.dll                                                 | 2017.140.3238.1 | 214632    | 14-9 | 02:54 | x86      |
| Exceldest.dll                                                 | 2017.140.3238.1 | 260712    | 14-9 | 03:00 | x64      |
| Excelsrc.dll                                                  | 2017.140.3238.1 | 230504    | 14-9 | 02:54 | x86      |
| Excelsrc.dll                                                  | 2017.140.3238.1 | 282728    | 14-9 | 03:00 | x64      |
| Execpackagetask.dll                                           | 2017.140.3238.1 | 135272    | 14-9 | 02:54 | x86      |
| Execpackagetask.dll                                           | 2017.140.3238.1 | 168040    | 14-9 | 03:00 | x64      |
| Flatfiledest.dll                                              | 2017.140.3238.1 | 332904    | 14-9 | 02:54 | x86      |
| Flatfiledest.dll                                              | 2017.140.3238.1 | 386664    | 14-9 | 03:00 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3238.1 | 344168    | 14-9 | 02:54 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3238.1 | 398952    | 14-9 | 03:00 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3238.1 | 80488     | 14-9 | 02:54 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3238.1 | 96360     | 14-9 | 03:00 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 14-9 | 02:43 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 14-9 | 03:27 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3238.1     | 467048    | 14-9 | 02:54 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3238.1     | 466536    | 14-9 | 03:00 | x64      |
| Isserverexec.exe                                              | 14.0.3238.1     | 149096    | 14-9 | 02:54 | x86      |
| Isserverexec.exe                                              | 14.0.3238.1     | 148584    | 14-9 | 03:00 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.17     | 1381688   | 14-9 | 02:54 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.17     | 1381480   | 14-9 | 03:00 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 14-9 | 03:38 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 14-9 | 02:43 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 14-9 | 03:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3238.1     | 72800     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3238.1 | 107112    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3238.1 | 112232    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3238.1     | 54888     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3238.1     | 54888     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3238.1     | 89704     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3238.1     | 89704     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3238.1     | 73320     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3238.1     | 73312     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3238.1     | 502376    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3238.1     | 502376    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3238.1     | 83560     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3238.1     | 83560     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3238.1     | 415848    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3238.1     | 415848    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3238.1     | 613992    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3238.1     | 613992    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3238.1     | 252520    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3238.1     | 252520    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3238.1 | 141928    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3238.1 | 152168    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3238.1 | 145512    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3238.1 | 159336    | 14-9 | 03:00 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3238.1     | 219752    | 14-9 | 03:00 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3238.1 | 90216     | 14-9 | 02:54 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3238.1 | 103016    | 14-9 | 03:00 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.17 | 9198904   | 14-9 | 03:12 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 14-9 | 02:43 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 14-9 | 02:53 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 14-9 | 03:27 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 14-9 | 03:34 | x86      |
| Oledbdest.dll                                                 | 2017.140.3238.1 | 214632    | 14-9 | 02:54 | x86      |
| Oledbdest.dll                                                 | 2017.140.3238.1 | 261224    | 14-9 | 03:00 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3238.1 | 233064    | 14-9 | 02:54 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3238.1 | 288872    | 14-9 | 03:00 | x64      |
| Rawdest.dll                                                   | 2017.140.3238.1 | 166504    | 14-9 | 03:00 | x86      |
| Rawdest.dll                                                   | 2017.140.3238.1 | 206440    | 14-9 | 03:11 | x64      |
| Rawsource.dll                                                 | 2017.140.3238.1 | 153192    | 14-9 | 03:00 | x86      |
| Rawsource.dll                                                 | 2017.140.3238.1 | 194152    | 14-9 | 03:11 | x64      |
| Recordsetdest.dll                                             | 2017.140.3238.1 | 149096    | 14-9 | 03:00 | x86      |
| Recordsetdest.dll                                             | 2017.140.3238.1 | 184416    | 14-9 | 03:11 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlceip.exe                                                   | 14.0.3238.1     | 261736    | 14-9 | 03:38 | x86      |
| Sqldest.dll                                                   | 2017.140.3238.1 | 213608    | 14-9 | 03:00 | x86      |
| Sqldest.dll                                                   | 2017.140.3238.1 | 260712    | 14-9 | 03:11 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3238.1 | 155240    | 14-9 | 03:00 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3238.1 | 183912    | 14-9 | 03:11 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3238.1 | 176744    | 14-9 | 03:00 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3238.1 | 216168    | 14-9 | 03:11 | x64      |
| Txagg.dll                                                     | 2017.140.3238.1 | 302184    | 14-9 | 03:00 | x86      |
| Txagg.dll                                                     | 2017.140.3238.1 | 362088    | 14-9 | 03:11 | x64      |
| Txbdd.dll                                                     | 2017.140.3238.1 | 136296    | 14-9 | 03:00 | x86      |
| Txbdd.dll                                                     | 2017.140.3238.1 | 170088    | 14-9 | 03:11 | x64      |
| Txbestmatch.dll                                               | 2017.140.3238.1 | 493160    | 14-9 | 03:00 | x86      |
| Txbestmatch.dll                                               | 2017.140.3238.1 | 605288    | 14-9 | 03:11 | x64      |
| Txcache.dll                                                   | 2017.140.3238.1 | 146024    | 14-9 | 03:00 | x86      |
| Txcache.dll                                                   | 2017.140.3238.1 | 180328    | 14-9 | 03:11 | x64      |
| Txcharmap.dll                                                 | 2017.140.3238.1 | 248936    | 14-9 | 03:00 | x86      |
| Txcharmap.dll                                                 | 2017.140.3238.1 | 286824    | 14-9 | 03:11 | x64      |
| Txcopymap.dll                                                 | 2017.140.3238.1 | 145512    | 14-9 | 03:00 | x86      |
| Txcopymap.dll                                                 | 2017.140.3238.1 | 180328    | 14-9 | 03:11 | x64      |
| Txdataconvert.dll                                             | 2017.140.3238.1 | 253032    | 14-9 | 03:00 | x86      |
| Txdataconvert.dll                                             | 2017.140.3238.1 | 292968    | 14-9 | 03:11 | x64      |
| Txderived.dll                                                 | 2017.140.3238.1 | 515688    | 14-9 | 03:00 | x86      |
| Txderived.dll                                                 | 2017.140.3238.1 | 604264    | 14-9 | 03:11 | x64      |
| Txfileextractor.dll                                           | 2017.140.3238.1 | 160872    | 14-9 | 03:00 | x86      |
| Txfileextractor.dll                                           | 2017.140.3238.1 | 198760    | 14-9 | 03:11 | x64      |
| Txfileinserter.dll                                            | 2017.140.3238.1 | 159336    | 14-9 | 03:00 | x86      |
| Txfileinserter.dll                                            | 2017.140.3238.1 | 196712    | 14-9 | 03:11 | x64      |
| Txgroupdups.dll                                               | 2017.140.3238.1 | 231016    | 14-9 | 03:00 | x86      |
| Txgroupdups.dll                                               | 2017.140.3238.1 | 290408    | 14-9 | 03:11 | x64      |
| Txlineage.dll                                                 | 2017.140.3238.1 | 110176    | 14-9 | 03:00 | x86      |
| Txlineage.dll                                                 | 2017.140.3238.1 | 136800    | 14-9 | 03:11 | x64      |
| Txlookup.dll                                                  | 2017.140.3238.1 | 446568    | 14-9 | 03:00 | x86      |
| Txlookup.dll                                                  | 2017.140.3238.1 | 527976    | 14-9 | 03:11 | x64      |
| Txmerge.dll                                                   | 2017.140.3238.1 | 176744    | 14-9 | 03:00 | x86      |
| Txmerge.dll                                                   | 2017.140.3238.1 | 229992    | 14-9 | 03:11 | x64      |
| Txmergejoin.dll                                               | 2017.140.3238.1 | 221800    | 14-9 | 03:00 | x86      |
| Txmergejoin.dll                                               | 2017.140.3238.1 | 275560    | 14-9 | 03:11 | x64      |
| Txmulticast.dll                                               | 2017.140.3238.1 | 102504    | 14-9 | 03:00 | x86      |
| Txmulticast.dll                                               | 2017.140.3238.1 | 127584    | 14-9 | 03:11 | x64      |
| Txpivot.dll                                                   | 2017.140.3238.1 | 180328    | 14-9 | 03:00 | x86      |
| Txpivot.dll                                                   | 2017.140.3238.1 | 224872    | 14-9 | 03:11 | x64      |
| Txrowcount.dll                                                | 2017.140.3238.1 | 101480    | 14-9 | 03:00 | x86      |
| Txrowcount.dll                                                | 2017.140.3238.1 | 125536    | 14-9 | 03:11 | x64      |
| Txsampling.dll                                                | 2017.140.3238.1 | 135784    | 14-9 | 03:00 | x86      |
| Txsampling.dll                                                | 2017.140.3238.1 | 172648    | 14-9 | 03:11 | x64      |
| Txscd.dll                                                     | 2017.140.3238.1 | 170088    | 14-9 | 03:00 | x86      |
| Txscd.dll                                                     | 2017.140.3238.1 | 220776    | 14-9 | 03:11 | x64      |
| Txsort.dll                                                    | 2017.140.3238.1 | 207976    | 14-9 | 03:00 | x86      |
| Txsort.dll                                                    | 2017.140.3238.1 | 256608    | 14-9 | 03:11 | x64      |
| Txsplit.dll                                                   | 2017.140.3238.1 | 510568    | 14-9 | 03:00 | x86      |
| Txsplit.dll                                                   | 2017.140.3238.1 | 596584    | 14-9 | 03:11 | x64      |
| Txtermextraction.dll                                          | 2017.140.3238.1 | 8615016   | 14-9 | 03:00 | x86      |
| Txtermextraction.dll                                          | 2017.140.3238.1 | 8676456   | 14-9 | 03:12 | x64      |
| Txtermlookup.dll                                              | 2017.140.3238.1 | 4106856   | 14-9 | 03:00 | x86      |
| Txtermlookup.dll                                              | 2017.140.3238.1 | 4157032   | 14-9 | 03:11 | x64      |
| Txunionall.dll                                                | 2017.140.3238.1 | 139368    | 14-9 | 03:00 | x86      |
| Txunionall.dll                                                | 2017.140.3238.1 | 181864    | 14-9 | 03:11 | x64      |
| Txunpivot.dll                                                 | 2017.140.3238.1 | 160360    | 14-9 | 03:00 | x86      |
| Txunpivot.dll                                                 | 2017.140.3238.1 | 199784    | 14-9 | 03:11 | x64      |
| Xe.dll                                                        | 2017.140.3238.1 | 673384    | 14-9 | 03:12 | x64      |
| Xe.dll                                                        | 2017.140.3238.1 | 595560    | 14-9 | 03:12 | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 14-9 | 03:25 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 14-9 | 03:25 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 14-9 | 03:25 | x86      |
| Instapi140.dll                                                       | 2017.140.3238.1  | 70760     | 14-9 | 03:25 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 14-9 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 14-9 | 03:19 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 14-9 | 03:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 14-9 | 03:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 14-9 | 02:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 14-9 | 02:42 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 14-9 | 02:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 14-9 | 02:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 14-9 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 14-9 | 03:19 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 14-9 | 03:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 14-9 | 03:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 14-9 | 02:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 14-9 | 02:42 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 14-9 | 02:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 14-9 | 02:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 14-9 | 03:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 14-9 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 14-9 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 14-9 | 03:25 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3238.1  | 407144    | 14-9 | 03:25 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3238.1  | 7326312   | 14-9 | 03:26 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3238.1  | 2263144   | 14-9 | 03:25 | x64      |
| Secforwarder.dll                                                     | 2017.140.3238.1  | 37480     | 14-9 | 03:25 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 14-9 | 03:25 | x64      |
| Sqldk.dll                                                            | 2017.140.3238.1  | 2734184   | 14-9 | 03:26 | x64      |
| Sqldumper.exe                                                        | 2017.140.3238.1  | 143976    | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 1499752   | 14-9 | 02:42 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3918952   | 14-9 | 02:52 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3217000   | 14-9 | 02:52 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3921512   | 14-9 | 03:36 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3824744   | 14-9 | 03:07 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 2092136   | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 2038888   | 14-9 | 03:22 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3592296   | 14-9 | 03:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3600488   | 14-9 | 03:20 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 1447016   | 14-9 | 02:41 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3238.1  | 3789416   | 14-9 | 02:52 | x64      |
| Sqlos.dll                                                            | 2017.140.3238.1  | 26216     | 14-9 | 03:25 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 14-9 | 03:26 | x64      |
| Sqltses.dll                                                          | 2017.140.3238.1  | 9734760   | 14-9 | 03:36 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date | Time | Platform |
|------------------------------------|-----------------|-----------|------|------|----------|
| Smrdll.dll                         | 14.0.3238.1     | 23656     | 14-9 | 03:11 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version    | File size | Date | Time | Platform |
|--------------------------------------------------------|-----------------|-----------|------|------|----------|
| Autoadmin.dll                                          | 2017.140.3238.1 | 1448552   | 14-9 | 03:00 | x86      |
| Dtaengine.exe                                          | 2017.140.3238.1 | 204392    | 14-9 | 02:54 | x86      |
| Dteparse.dll                                           | 2017.140.3238.1 | 100456    | 14-9 | 02:54 | x86      |
| Dteparse.dll                                           | 2017.140.3238.1 | 111208    | 14-9 | 03:00 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3238.1 | 83560     | 14-9 | 02:54 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3238.1 | 89184     | 14-9 | 03:00 | x64      |
| Dtepkg.dll                                             | 2017.140.3238.1 | 116840    | 14-9 | 02:54 | x86      |
| Dtepkg.dll                                             | 2017.140.3238.1 | 137832    | 14-9 | 03:00 | x64      |
| Dtexec.exe                                             | 2017.140.3238.1 | 67688     | 14-9 | 02:54 | x86      |
| Dtexec.exe                                             | 2017.140.3238.1 | 73832     | 14-9 | 03:00 | x64      |
| Dts.dll                                                | 2017.140.3238.1 | 2549352   | 14-9 | 02:54 | x86      |
| Dts.dll                                                | 2017.140.3238.1 | 2998888   | 14-9 | 03:00 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3238.1 | 417896    | 14-9 | 02:54 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3238.1 | 475240    | 14-9 | 03:00 | x64      |
| Dtsconn.dll                                            | 2017.140.3238.1 | 399464    | 14-9 | 02:54 | x86      |
| Dtsconn.dll                                            | 2017.140.3238.1 | 497256    | 14-9 | 03:00 | x64      |
| Dtshost.exe                                            | 2017.140.3238.1 | 89704     | 14-9 | 03:00 | x86      |
| Dtshost.exe                                            | 2017.140.3238.1 | 104544    | 14-9 | 03:11 | x64      |
| Dtslog.dll                                             | 2017.140.3238.1 | 103016    | 14-9 | 02:54 | x86      |
| Dtslog.dll                                             | 2017.140.3238.1 | 120424    | 14-9 | 03:00 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3238.1 | 541288    | 14-9 | 03:00 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3238.1 | 545384    | 14-9 | 03:11 | x64      |
| Dtspipeline.dll                                        | 2017.140.3238.1 | 1059432   | 14-9 | 02:54 | x86      |
| Dtspipeline.dll                                        | 2017.140.3238.1 | 1266280   | 14-9 | 03:00 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3238.1 | 42592     | 14-9 | 02:54 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3238.1 | 48232     | 14-9 | 03:00 | x64      |
| Dtuparse.dll                                           | 2017.140.3238.1 | 79976     | 14-9 | 02:54 | x86      |
| Dtuparse.dll                                           | 2017.140.3238.1 | 89192     | 14-9 | 03:00 | x64      |
| Dtutil.exe                                             | 2017.140.3238.1 | 126056    | 14-9 | 02:54 | x86      |
| Dtutil.exe                                             | 2017.140.3238.1 | 147048    | 14-9 | 03:00 | x64      |
| Exceldest.dll                                          | 2017.140.3238.1 | 214632    | 14-9 | 02:54 | x86      |
| Exceldest.dll                                          | 2017.140.3238.1 | 260712    | 14-9 | 03:00 | x64      |
| Excelsrc.dll                                           | 2017.140.3238.1 | 230504    | 14-9 | 02:54 | x86      |
| Excelsrc.dll                                           | 2017.140.3238.1 | 282728    | 14-9 | 03:00 | x64      |
| Flatfiledest.dll                                       | 2017.140.3238.1 | 332904    | 14-9 | 02:54 | x86      |
| Flatfiledest.dll                                       | 2017.140.3238.1 | 386664    | 14-9 | 03:00 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3238.1 | 344168    | 14-9 | 02:54 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3238.1 | 398952    | 14-9 | 03:00 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3238.1 | 80488     | 14-9 | 02:54 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3238.1 | 96360     | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3238.1     | 72808     | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3238.1     | 186472    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3238.1     | 409696    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3238.1     | 409704    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3238.1     | 2093160   | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3238.1     | 2093152   | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3238.1     | 613992    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3238.1     | 613992    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3238.1     | 252520    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3238.1 | 141928    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3238.1 | 152168    | 14-9 | 03:00 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3238.1 | 145512    | 14-9 | 03:00 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3238.1 | 159336    | 14-9 | 03:00 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3238.1 | 90216     | 14-9 | 02:54 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3238.1 | 103016    | 14-9 | 03:00 | x64      |
| Msmgdsrv.dll                                           | 2017.140.249.17 | 7311456   | 14-9 | 03:00 | x86      |
| Oledbdest.dll                                          | 2017.140.3238.1 | 214632    | 14-9 | 02:54 | x86      |
| Oledbdest.dll                                          | 2017.140.3238.1 | 261224    | 14-9 | 03:00 | x64      |
| Oledbsrc.dll                                           | 2017.140.3238.1 | 233064    | 14-9 | 02:54 | x86      |
| Oledbsrc.dll                                           | 2017.140.3238.1 | 288872    | 14-9 | 03:00 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3238.1 | 100456    | 14-9 | 03:00 | x64      |
| Sqlresld.dll                                           | 2017.140.3238.1 | 28776     | 14-9 | 03:00 | x86      |
| Sqlresld.dll                                           | 2017.140.3238.1 | 30824     | 14-9 | 03:11 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3238.1 | 29288     | 14-9 | 03:00 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3238.1 | 32352     | 14-9 | 03:11 | x64      |
| Sqlscm.dll                                             | 2017.140.3238.1 | 61032     | 14-9 | 03:00 | x86      |
| Sqlscm.dll                                             | 2017.140.3238.1 | 71264     | 14-9 | 03:11 | x64      |
| Sqlsvc.dll                                             | 2017.140.3238.1 | 134760    | 14-9 | 03:00 | x86      |
| Sqlsvc.dll                                             | 2017.140.3238.1 | 161896    | 14-9 | 03:11 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3238.1 | 155240    | 14-9 | 03:00 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3238.1 | 183912    | 14-9 | 03:11 | x64      |
| Txdataconvert.dll                                      | 2017.140.3238.1 | 253032    | 14-9 | 03:00 | x86      |
| Txdataconvert.dll                                      | 2017.140.3238.1 | 292968    | 14-9 | 03:11 | x64      |
| Xe.dll                                                 | 2017.140.3238.1 | 673384    | 14-9 | 03:12 | x64      |
| Xe.dll                                                 | 2017.140.3238.1 | 595560    | 14-9 | 03:12 | x86      |
| Xmlrw.dll                                              | 2017.140.3238.1 | 305256    | 14-9 | 03:12 | x64      |
| Xmlrw.dll                                              | 2017.140.3238.1 | 257640    | 14-9 | 03:12 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3238.1 | 224360    | 14-9 | 03:12 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3238.1 | 189544    | 14-9 | 03:12 | x86      |

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

CU packages for Linux are available at https://packages.microsoft.com/.

> [!NOTE]
> - Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
> - SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
>- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines: </br>- Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU. </br>- CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
> - We recommend that you test SQL Server CUs before you deploy them to production environments.

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

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

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

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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

### Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
