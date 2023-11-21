---
title: Cumulative update 15 for SQL Server 2017 (KB4498951)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 15 (KB4498951).
ms.date: 08/04/2023
ms.custom: KB4498951
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4498951 - Cumulative Update 15 for SQL Server 2017

_Release Date:_ &nbsp; May 23, 2019  
_Version:_ &nbsp; 14.0.3162.1

## Summary

This article describes Cumulative Update package 15 (CU15) for Microsoft SQL Server 2017. This update contains 44 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 14, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3162.1**, file version: **2017.140.3162.1**
- Analysis Services - Product version: **14.0.249.3**, file version: **2017.140.249.3**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12745584">[12745584](#12745584)</a> | [FIX: Exception occurs when you design a parameterized DAX query in Query Designer of Report Builder in SSRS (KB4503386)](https://support.microsoft.com/help/4503386) | Analysis Services | Analysis Services | Windows |
| <a id="12823369">[12823369](#12823369)</a> | [FIX: DAX query requires more than 200 times of memory than the size of the database in SQL Server 2017 multidimensional model database (KB4503385)](https://support.microsoft.com/help/4503385) | Analysis Services | Analysis Services | Windows |
| <a id="12710985">[12710985](#12710985)</a> | [FIX: CDC Source preview fails with "The given key was not present in the dictionary" error in SQL Server 2017 (KB4500595)](https://support.microsoft.com/help/4500595) | Integration Services | CDC | Windows |
| <a id="12804071">[12804071](#12804071)</a> | [FIX: Search Attribute doesn't work when display format is set to "Name {Code}" in SQL Server 2017 (KB4495683)](https://support.microsoft.com/help/4495683) | Master Data Services | Client | Windows |
| <a id="12844344">[12844344](#12844344)</a> | [FIX: Gray background for read-only attributes disappears after Refresh in Excel Add-in for MDS in SQL Server 2017 (KB4498924)](https://support.microsoft.com/help/4498924) | Master Data Services | Client | Windows |
| <a id="12750851">[12750851](#12750851)</a> | [FIX: SQL Writer Service can cause undetected deadlocks on system DMV when you do a VSS backup (KB4480652)](https://support.microsoft.com/help/4480652) | SQL Server Engine | Backup Restore | Windows |
| <a id="12931699">[12931699](#12931699)</a> | [FIX: Error occurs when you back up a virtual machine with non-component based backup in SQL Server 2016 and 2017 (KB4493364)](https://support.microsoft.com/help/4493364) | SQL Server Engine | Backup Restore | Windows |
| <a id="12723965">[12723965](#12723965)</a> | [FIX: Restoring backup to SQL Server 2016 and 2017 from SQL Server 2008 or 2008 R2 takes a long time (KB4490237)](https://support.microsoft.com/help/4490237) | SQL Server Engine | Column Stores | Windows |
| <a id="12816127">[12816127](#12816127)</a> | [FIX: Access violation occurs when you run sys.fn_dump_dblog function in SQL Server 2016 and 2017 (KB4502427)](https://support.microsoft.com/help/4502427) | SQL Server Engine | Column Stores | Windows |
| <a id="12819474">[12819474](#12819474)</a> | [FIX: Non-yielding scheduler issue occurs when you run queries in batch mode that spill in SQL Server 2016 and 2017 (KB4500327)](https://support.microsoft.com/help/4500327) | SQL Server Engine | Column Stores | Windows |
| <a id="12840763">[12840763](#12840763)</a> | [FIX: Query against table with both clustered columnstore index and nonclustered rowstore index may return incorrect results in SQL Server 2016 and 2017 (KB4497225)](https://support.microsoft.com/help/4497225) | SQL Server Engine | Column Stores | All |
| <a id="12840765">[12840765](#12840765)</a> | [FIX: Columnstore filter pushdown may return wrong results when there's an overflow in filter expressions in SQL Server 2014, 2016 and 2017 (KB4497701)](https://support.microsoft.com/help/4497701) | SQL Server Engine | Column Stores | All |
| <a id="12819479">[12819479](#12819479)</a> | [FIX: FileTable database level directory is inaccessible after database startup in SQL Server 2016 and 2017 (KB4492899)](https://support.microsoft.com/help/4492899) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12819460">[12819460](#12819460)</a> | [Improvement: DMV sys.dm_hadr_cluster reports cloud witness quorum type "4" and quorum_type_desc "UNKNOWN_QUORUM" in SQL Server 2016 and 2017 (KB4490141)](https://support.microsoft.com/help/4490141) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12640919">[12640919](#12640919)</a> | [FIX: Manual failover between forwarder and secondary replica fails with all replicas synchronized in SQL Server 2016 and 2017 (KB4492604)](https://support.microsoft.com/help/4492604) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12799964">[12799964](#12799964)</a> | [FIX: Access violation occurs in sqlmin!AGHealthCompStateActual::GetData in SQL Server 2017 (KB4502376)](https://support.microsoft.com/help/4502376) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="12819475">[12819475](#12819475)</a> | [FIX: Automatic seeding assertions occur when databases are removed from AG in SQL Server 2016 and 2017 (KB4492880)](https://support.microsoft.com/help/4492880) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12865861">[12865861](#12865861)</a> | [FIX: Fail to join the secondary replica if the database has a defunct filegroup in SQL Server 2014, 2016 and 2017 (KB4497230)](https://support.microsoft.com/help/4497230) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12877988">[12877988](#12877988)</a> | [FIX: Data movement to DAG Forwarder doesn't resume automatically after connection time-out in SQL Server 2016 and 2017 (KB4501797)](https://support.microsoft.com/help/4501797) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12789617">[12789617](#12789617)</a> | [FIX: Interleaved execution on MSTVFs by using memory-optimized tables causes floating point exception in SQL Server 2017 (KB4500783)](https://support.microsoft.com/help/4500783) | SQL Server Engine | In-Memory OLTP | All |
| <a id="12700741">[12700741](#12700741)</a> | [FIX: AD authentication fails to connect to SQL Server 2017 (KB4490478)](https://support.microsoft.com/help/4490478) | SQL Server Engine | Linux | Linux |
| <a id="12756913">[12756913](#12756913)</a> | [FIX: "No valid credentials provided" occurs after you restart PolyBase in SQL Server 2017 (KB4502658)](https://support.microsoft.com/help/4502658) | SQL Server Engine | PolyBase | Windows |
| <a id="12820675">[12820675](#12820675)</a> | [FIX: PolyBase queries that target Parquet or ORC files in HDP 3.0 or later will fail with pushdown computation enabled (KB4502659)](https://support.microsoft.com/help/4502659) | SQL Server Engine | PolyBase | Windows |
| <a id="12674647">[12674647](#12674647)</a> | [FIX: Assertion error occurs when you use sys.dm_exec_query_statistics_xml in SQL Server 2016 and 2017 (KB4490136)](https://support.microsoft.com/help/4490136) | SQL Server Engine | Query Execution | Windows |
| <a id="12794414">[12794414](#12794414)</a> | [FIX: Access violation occurs when you run a batch-mode query with UNION statement in SQL Server 2017 (KB4494650)](https://support.microsoft.com/help/4494650) | SQL Server Engine | Query Execution | Windows |
| <a id="12819466">[12819466](#12819466)</a> | [FIX: Referential integrity constraints aren't evaluated correctly when query execution plan uses Foreign Key Reference Check operator in SQL Server 2016 and 2017 (KB4503379)](https://support.microsoft.com/help/4503379) | SQL Server Engine | Query Execution | Windows |
| <a id="12821584">[12821584](#12821584)</a> | [FIX: Access Violation occurs due to corruption of compressed Showplan.xml file in SQL Server 2017 (KB4499614)](https://support.microsoft.com/help/4499614) | SQL Server Engine | Query Execution | Windows |
| <a id="12886436">[12886436](#12886436)</a> | [FIX: CPU and elapsed time reported by query_plan_profile and query_post_execuion_plan_profile xEvents aren't accurate in SQL Server 2017 (KB4501670)](https://support.microsoft.com/help/4501670) | SQL Server Engine | Query Execution | All |
| <a id="12892302">[12892302](#12892302)</a> | [FIX: SQLCLR function takes a longer time to run the query in CU 14 than RTM of SQL Server 2017 (KB4505820)](https://support.microsoft.com/help/4505820) | SQL Server Engine | Query Execution | Windows |
| <a id="12768690">[12768690](#12768690)</a> | [FIX: Query takes a long time if you enable Batch Mode Adaptive Join in SQL Server 2017 (KB4502532)](https://support.microsoft.com/help/4502532) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12805642">[12805642](#12805642)</a> | [FIX: SQL Server 2016 and 2017 don't perform the requested pre-row assignments when you use MERGE statement that performs assignments of local variables for each row (KB4502400)](https://support.microsoft.com/help/4502400) | SQL Server Engine | Query Optimizer | All |
| <a id="12921007">[12921007](#12921007)</a> | [FIX: Assertion dump occurs when you select a view on a linked server in SQL Server 2017 (KB4503417)](https://support.microsoft.com/help/4503417) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12686636">[12686636](#12686636)</a> | [Improvement: Improve CDC supportability and usability with In-Memory Databases (KB4500511)](https://support.microsoft.com/help/4500511) | SQL Server Engine | Replication | All |
| <a id="12644521">[12644521](#12644521)</a> | [FIX: Error occurs when sp_addarticle is used to add article for transactional replication to memory-optimized table on subscriber in SQL Server 2016 and 2017 (KB4493329)](https://support.microsoft.com/help/4493329) | SQL Server Engine | Replication | Windows |
| <a id="12819465">[12819465](#12819465)</a> | [FIX: 'MSrepl_agent_jobs' doesn't exist when you run sp_addpullsubscription_agent to create pull subscription in SQL Server 2016 and 2017 (KB4488853)](https://support.microsoft.com/help/4488853) | SQL Server Engine | Replication | Windows |
| <a id="12865874">[12865874](#12865874)</a> | [FIX: Log reader agent may fail after AG failover with TF 1448 enabled in SQL Server 2014, 2016 and 2017 (KB4499231)](https://support.microsoft.com/help/4499231) | SQL Server Engine | Replication | Windows |
| <a id="12812315">[12812315](#12812315)</a> | [FIX: Dynamic Data Masking doesn't function as expected in SQL Server 2017 (KB4505726)](https://support.microsoft.com/help/4505726) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12819478">[12819478](#12819478)</a> | [FIX: A specially crafted query run by a low-privileged user may expose the masked data in SQL Server 2016 and 2017 (KB4493363)](https://support.microsoft.com/help/4493363) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12870721">[12870721](#12870721)</a> | [FIX: Self-deadlock occurs when transaction auditing is enabled in SQL Server 2017 (KB4500574)](https://support.microsoft.com/help/4500574) | SQL Server Engine | Security Infrastructure | All |
| <a id="12670267">[12670267](#12670267)</a> | [FIX: SSIS and Power BI reports fail with connection time-out errors in SQL Server 2017 (KB4499423)](https://support.microsoft.com/help/4499423) | SQL Server Engine | SQL OS | Linux |
| <a id="12798181">[12798181](#12798181)</a> | [FIX: SQL Server generates core dump with "Failed to monitor external signals" in SQL Server 2017 (KB4502706)](https://support.microsoft.com/help/4502706) | SQL Server Engine | SQL OS | All |
| <a id="12819467">[12819467](#12819467)</a> | [FIX: Error 10314 occurs when you load .NET CLR assembly in SQL Server 2016 and 2017 database (KB4489202)](https://support.microsoft.com/help/4489202) | SQL Server Engine | SQL OS | Windows |
| <a id="12831695">[12831695](#12831695)</a> | [FIX: Core dump failed to generate on m_numLocks.load() == 0 error in SQL Server 2017 (KB4498720)](https://support.microsoft.com/help/4498720) | SQL Server Engine | SQL OS | Linux |
| <a id="12745415">[12745415](#12745415)</a> | [FIX: SQL Server 2017 crashes due to stack overflow when you try to back up database master to disk (KB4502380)](https://support.microsoft.com/help/4502380) | SQL Server Engine | Storage Management | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU15 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2019/05/sqlserver2017-kb4498951-x64_b143d28a48204eb6ebab62394ce45df53d73f286.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4498951-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4498951-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4498951-x64.exe| F10ABC85A6681E0FFCA40296159B97A6C1BEC81435D5F282337C8D755433C68E |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.249.3  | 266528    | 16-May-19 | 06:29 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.3      | 741440    | 16-May-19 | 06:42 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.3      | 1380656   | 16-May-19 | 06:29 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.3      | 984344    | 16-May-19 | 06:29 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.3      | 521288    | 16-May-19 | 06:29 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 16-May-19 | 06:38 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 16-May-19 | 06:42 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 16-May-19 | 06:42 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 16-May-19 | 06:42 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 16-May-19 | 06:42 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 16-May-19 | 06:42 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 16-May-19 | 06:42 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 16-May-19 | 06:42 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 16-May-19 | 06:42 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 16-May-19 | 06:42 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 16-May-19 | 06:42 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 16-May-19 | 06:42 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 16-May-19 | 06:42 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 16-May-19 | 06:42 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 16-May-19 | 06:42 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 16-May-19 | 06:42 | x86      |
| Msmdctr.dll                                        | 2017.140.249.3  | 40008     | 16-May-19 | 06:30 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.3  | 60704840  | 16-May-19 | 06:31 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.3  | 40388376  | 16-May-19 | 06:56 | x86      |
| Msmdpump.dll                                       | 2017.140.249.3  | 9335064   | 16-May-19 | 06:31 | x64      |
| Msmdredir.dll                                      | 2017.140.249.3  | 7092504   | 16-May-19 | 06:56 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.3  | 60605512  | 16-May-19 | 06:31 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.3  | 9004616   | 16-May-19 | 06:31 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.3  | 7310616   | 16-May-19 | 06:56 | x86      |
| Msolap.dll                                         | 2017.140.249.3  | 10258496  | 16-May-19 | 06:31 | x64      |
| Msolap.dll                                         | 2017.140.249.3  | 7777864   | 16-May-19 | 06:56 | x86      |
| Msolui.dll                                         | 2017.140.249.3  | 311064    | 16-May-19 | 06:30 | x64      |
| Msolui.dll                                         | 2017.140.249.3  | 287512    | 16-May-19 | 06:56 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 16-May-19 | 06:42 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlboot.dll                                        | 2017.140.3162.1 | 196176    | 16-May-19 | 06:30 | x64      |
| Sqlceip.exe                                        | 14.0.3162.1     | 261712    | 16-May-19 | 06:38 | x86      |
| Sqldumper.exe                                      | 2017.140.3162.1 | 144160    | 16-May-19 | 06:26 | x64      |
| Sqldumper.exe                                      | 2017.140.3162.1 | 121936    | 16-May-19 | 06:28 | x86      |
| Tmapi.dll                                          | 2017.140.249.3  | 5821512   | 16-May-19 | 06:31 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.3  | 4164680   | 16-May-19 | 06:31 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.3  | 1132104   | 16-May-19 | 06:30 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.3  | 1641032   | 16-May-19 | 06:31 | x64      |
| Xe.dll                                             | 2017.140.3162.1 | 673360    | 16-May-19 | 06:31 | x64      |
| Xmlrw.dll                                          | 2017.140.3162.1 | 305232    | 16-May-19 | 06:31 | x64      |
| Xmlrw.dll                                          | 2017.140.3162.1 | 257616    | 16-May-19 | 06:56 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3162.1 | 224552    | 16-May-19 | 06:31 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3162.1 | 189520    | 16-May-19 | 06:56 | x86      |
| Xmsrv.dll                                          | 2017.140.249.3  | 25375536  | 16-May-19 | 06:31 | x64      |
| Xmsrv.dll                                          | 2017.140.249.3  | 33350728  | 16-May-19 | 06:56 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3162.1  | 180816    | 16-May-19 | 06:29 | x64      |
| Batchparser.dll                            | 2017.140.3162.1  | 160328    | 16-May-19 | 06:56 | x86      |
| Instapi140.dll                             | 2017.140.3162.1  | 70952     | 16-May-19 | 06:30 | x64      |
| Instapi140.dll                             | 2017.140.3162.1  | 61008     | 16-May-19 | 06:56 | x86      |
| Isacctchange.dll                           | 2017.140.3162.1  | 31008     | 16-May-19 | 06:29 | x64      |
| Isacctchange.dll                           | 2017.140.3162.1  | 29264     | 16-May-19 | 06:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.3       | 1088800   | 16-May-19 | 06:29 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.3       | 1088800   | 16-May-19 | 06:56 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.3       | 1381656   | 16-May-19 | 06:56 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.3       | 741448    | 16-May-19 | 06:29 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.3       | 741680    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3162.1      | 36944     | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3162.1  | 82000     | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3162.1  | 78416     | 16-May-19 | 06:56 | x86      |
| Msasxpress.dll                             | 2017.140.249.3   | 35912     | 16-May-19 | 06:30 | x64      |
| Msasxpress.dll                             | 2017.140.249.3   | 32024     | 16-May-19 | 06:56 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3162.1  | 82720     | 16-May-19 | 06:30 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3162.1  | 68408     | 16-May-19 | 06:56 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3162.1  | 100432    | 16-May-19 | 06:29 | x64      |
| Sqldumper.exe                              | 2017.140.3162.1  | 144160    | 16-May-19 | 06:26 | x64      |
| Sqldumper.exe                              | 2017.140.3162.1  | 121936    | 16-May-19 | 06:28 | x86      |
| Sqlftacct.dll                              | 2017.140.3162.1  | 62544     | 16-May-19 | 06:30 | x64      |
| Sqlftacct.dll                              | 2017.140.3162.1  | 55376     | 16-May-19 | 06:56 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 16-May-19 | 06:30 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 16-May-19 | 06:56 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3162.1  | 418896    | 16-May-19 | 06:30 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3162.1  | 373840    | 16-May-19 | 06:56 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3162.1  | 37456     | 16-May-19 | 06:30 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3162.1  | 34896     | 16-May-19 | 06:56 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3162.1  | 355920    | 16-May-19 | 06:30 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3162.1  | 273192    | 16-May-19 | 06:56 | x86      |
| Sqltdiagn.dll                              | 2017.140.3162.1  | 67664     | 16-May-19 | 06:30 | x64      |
| Sqltdiagn.dll                              | 2017.140.3162.1  | 60496     | 16-May-19 | 06:56 | x86      |
| Svrenumapi140.dll                          | 2017.140.3162.1  | 1173584   | 16-May-19 | 06:30 | x64      |
| Svrenumapi140.dll                          | 2017.140.3162.1  | 894032    | 16-May-19 | 06:56 | x86      |

SQL Server 2017 Data Quality Client

|      File name      |   File version  | File size |    Date   |  Time | Platform |
|:-------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 16-May-19 | 06:56 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 16-May-19 | 06:56 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 16-May-19 | 06:56 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 16-May-19 | 06:56 | x86      |

SQL Server 2017 Data Quality

|                     File name                     | File version | File size |    Date   |  Time | Platform |
|:-------------------------------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-May-19 | 06:29 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-May-19 | 06:56 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-May-19 | 06:29 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-May-19 | 06:56 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3162.1 | 120912    | 16-May-19 | 06:56 | x86      |
| Dreplaycommon.dll              | 2017.140.3162.1 | 699168    | 16-May-19 | 06:56 | x86      |
| Dreplayserverps.dll            | 2017.140.3162.1 | 32848     | 16-May-19 | 06:56 | x86      |
| Dreplayutil.dll                | 2017.140.3162.1 | 309832    | 16-May-19 | 06:56 | x86      |
| Instapi140.dll                 | 2017.140.3162.1 | 70952     | 16-May-19 | 06:30 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlresourceloader.dll          | 2017.140.3162.1 | 29264     | 16-May-19 | 06:56 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3162.1 | 699168    | 16-May-19 | 06:56 | x86      |
| Dreplaycontroller.exe              | 2017.140.3162.1 | 350288    | 16-May-19 | 06:56 | x86      |
| Dreplayprocess.dll                 | 2017.140.3162.1 | 171808    | 16-May-19 | 06:56 | x86      |
| Dreplayserverps.dll                | 2017.140.3162.1 | 32848     | 16-May-19 | 06:56 | x86      |
| Instapi140.dll                     | 2017.140.3162.1 | 70952     | 16-May-19 | 06:30 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlresourceloader.dll              | 2017.140.3162.1 | 29264     | 16-May-19 | 06:56 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 14.0.3162.1     | 40528     | 16-May-19 | 06:29 | x64      |
| Batchparser.dll                              | 2017.140.3162.1 | 180816    | 16-May-19 | 06:29 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 16-May-19 | 06:36 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 16-May-19 | 06:36 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 16-May-19 | 06:36 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 16-May-19 | 06:51 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 16-May-19 | 06:29 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3162.1 | 226384    | 16-May-19 | 06:29 | x64      |
| Dcexec.exe                                   | 2017.140.3162.1 | 74320     | 16-May-19 | 06:29 | x64      |
| Fssres.dll                                   | 2017.140.3162.1 | 89680     | 16-May-19 | 06:30 | x64      |
| Hadrres.dll                                  | 2017.140.3162.1 | 187984    | 16-May-19 | 06:30 | x64      |
| Hkcompile.dll                                | 2017.140.3162.1 | 1422928   | 16-May-19 | 06:30 | x64      |
| Hkengine.dll                                 | 2017.140.3162.1 | 5858384   | 16-May-19 | 06:30 | x64      |
| Hkruntime.dll                                | 2017.140.3162.1 | 162896    | 16-May-19 | 06:30 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 16-May-19 | 06:36 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.3      | 740936    | 16-May-19 | 06:29 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 16-May-19 | 06:38 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3162.1     | 236112    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3162.1     | 79440     | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3162.1 | 72488     | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3162.1 | 65104     | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3162.1 | 152144    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3162.1 | 159520    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3162.1 | 303696    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3162.1 | 74832     | 16-May-19 | 06:30 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 16-May-19 | 06:36 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 16-May-19 | 06:36 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 16-May-19 | 06:36 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 16-May-19 | 06:36 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 16-May-19 | 06:36 | x64      |
| Odsole70.dll                                 | 2017.140.3162.1 | 92752     | 16-May-19 | 06:30 | x64      |
| Opends60.dll                                 | 2017.140.3162.1 | 32848     | 16-May-19 | 06:30 | x64      |
| Qds.dll                                      | 2017.140.3162.1 | 1174304   | 16-May-19 | 06:30 | x64      |
| Rsfxft.dll                                   | 2017.140.3162.1 | 34384     | 16-May-19 | 06:30 | x64      |
| Secforwarder.dll                             | 2017.140.3162.1 | 37456     | 16-May-19 | 06:30 | x64      |
| Sqagtres.dll                                 | 2017.140.3162.1 | 74320     | 16-May-19 | 06:30 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlaamss.dll                                 | 2017.140.3162.1 | 90192     | 16-May-19 | 06:30 | x64      |
| Sqlaccess.dll                                | 2017.140.3162.1 | 475936    | 16-May-19 | 06:30 | x64      |
| Sqlagent.exe                                 | 2017.140.3162.1 | 582224    | 16-May-19 | 06:30 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3162.1 | 62032     | 16-May-19 | 06:30 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3162.1 | 52816     | 16-May-19 | 06:56 | x86      |
| Sqlagentlog.dll                              | 2017.140.3162.1 | 33064     | 16-May-19 | 06:30 | x64      |
| Sqlagentmail.dll                             | 2017.140.3162.1 | 53840     | 16-May-19 | 06:30 | x64      |
| Sqlboot.dll                                  | 2017.140.3162.1 | 196176    | 16-May-19 | 06:30 | x64      |
| Sqlceip.exe                                  | 14.0.3162.1     | 261712    | 16-May-19 | 06:38 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3162.1 | 72784     | 16-May-19 | 06:30 | x64      |
| Sqlctr140.dll                                | 2017.140.3162.1 | 129096    | 16-May-19 | 06:30 | x64      |
| Sqlctr140.dll                                | 2017.140.3162.1 | 112208    | 16-May-19 | 06:56 | x86      |
| Sqldk.dll                                    | 2017.140.3162.1 | 2799904   | 16-May-19 | 06:30 | x64      |
| Sqldtsss.dll                                 | 2017.140.3162.1 | 107600    | 16-May-19 | 06:30 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3789392   | 16-May-19 | 06:23 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 1446184   | 16-May-19 | 06:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 2091296   | 16-May-19 | 06:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3293480   | 16-May-19 | 06:26 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3917096   | 16-May-19 | 06:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3787552   | 16-May-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3340584   | 16-May-19 | 06:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3483936   | 16-May-19 | 06:38 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3599136   | 16-May-19 | 06:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3679312   | 16-May-19 | 06:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 1498912   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3590952   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3215440   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3299112   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3781920   | 16-May-19 | 06:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3920160   | 16-May-19 | 06:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 2038056   | 16-May-19 | 06:47 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3369768   | 16-May-19 | 06:51 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3638056   | 16-May-19 | 06:51 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3404584   | 16-May-19 | 06:52 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 4029224   | 16-May-19 | 06:52 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3162.1 | 3823400   | 16-May-19 | 06:52 | x64      |
| Sqliosim.com                                 | 2017.140.3162.1 | 313424    | 16-May-19 | 06:30 | x64      |
| Sqliosim.exe                                 | 2017.140.3162.1 | 3019856   | 16-May-19 | 06:31 | x64      |
| Sqllang.dll                                  | 2017.140.3162.1 | 41279568  | 16-May-19 | 06:30 | x64      |
| Sqlmin.dll                                   | 2017.140.3162.1 | 40488224  | 16-May-19 | 06:31 | x64      |
| Sqlolapss.dll                                | 2017.140.3162.1 | 107600    | 16-May-19 | 06:30 | x64      |
| Sqlos.dll                                    | 2017.140.3162.1 | 26192     | 16-May-19 | 06:30 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3162.1 | 68176     | 16-May-19 | 06:30 | x64      |
| Sqlrepss.dll                                 | 2017.140.3162.1 | 64592     | 16-May-19 | 06:30 | x64      |
| Sqlresld.dll                                 | 2017.140.3162.1 | 30800     | 16-May-19 | 06:30 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3162.1 | 32336     | 16-May-19 | 06:30 | x64      |
| Sqlscm.dll                                   | 2017.140.3162.1 | 71248     | 16-May-19 | 06:30 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3162.1 | 27728     | 16-May-19 | 06:30 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3162.1 | 5874256   | 16-May-19 | 06:31 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3162.1 | 732752    | 16-May-19 | 06:30 | x64      |
| Sqlservr.exe                                 | 2017.140.3162.1 | 487712    | 16-May-19 | 06:30 | x64      |
| Sqlsvc.dll                                   | 2017.140.3162.1 | 162080    | 16-May-19 | 06:30 | x64      |
| Sqltses.dll                                  | 2017.140.3162.1 | 9564448   | 16-May-19 | 06:30 | x64      |
| Sqsrvres.dll                                 | 2017.140.3162.1 | 261200    | 16-May-19 | 06:30 | x64      |
| Svl.dll                                      | 2017.140.3162.1 | 153680    | 16-May-19 | 06:30 | x64      |
| Xe.dll                                       | 2017.140.3162.1 | 673360    | 16-May-19 | 06:31 | x64      |
| Xmlrw.dll                                    | 2017.140.3162.1 | 305232    | 16-May-19 | 06:31 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3162.1 | 224552    | 16-May-19 | 06:31 | x64      |
| Xpadsi.exe                                   | 2017.140.3162.1 | 89888     | 16-May-19 | 06:30 | x64      |
| Xplog70.dll                                  | 2017.140.3162.1 | 76072     | 16-May-19 | 06:31 | x64      |
| Xpqueue.dll                                  | 2017.140.3162.1 | 74832     | 16-May-19 | 06:31 | x64      |
| Xprepl.dll                                   | 2017.140.3162.1 | 101968    | 16-May-19 | 06:31 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3162.1 | 32552     | 16-May-19 | 06:31 | x64      |
| Xpstar.dll                                   | 2017.140.3162.1 | 438352    | 16-May-19 | 06:30 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3162.1 | 180816    | 16-May-19 | 06:29 | x64      |
| Batchparser.dll                                             | 2017.140.3162.1 | 160328    | 16-May-19 | 06:56 | x86      |
| Bcp.exe                                                     | 2017.140.3162.1 | 119888    | 16-May-19 | 06:30 | x64      |
| Commanddest.dll                                             | 2017.140.3162.1 | 245832    | 16-May-19 | 06:29 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3162.1 | 116512    | 16-May-19 | 06:29 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3162.1 | 187472    | 16-May-19 | 06:29 | x64      |
| Distrib.exe                                                 | 2017.140.3162.1 | 203344    | 16-May-19 | 06:30 | x64      |
| Dteparse.dll                                                | 2017.140.3162.1 | 111184    | 16-May-19 | 06:29 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3162.1 | 89376     | 16-May-19 | 06:29 | x64      |
| Dtepkg.dll                                                  | 2017.140.3162.1 | 137808    | 16-May-19 | 06:29 | x64      |
| Dtexec.exe                                                  | 2017.140.3162.1 | 73808     | 16-May-19 | 06:29 | x64      |
| Dts.dll                                                     | 2017.140.3162.1 | 2998864   | 16-May-19 | 06:29 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3162.1 | 475216    | 16-May-19 | 06:29 | x64      |
| Dtsconn.dll                                                 | 2017.140.3162.1 | 497224    | 16-May-19 | 06:29 | x64      |
| Dtshost.exe                                                 | 2017.140.3162.1 | 104528    | 16-May-19 | 06:30 | x64      |
| Dtslog.dll                                                  | 2017.140.3162.1 | 120400    | 16-May-19 | 06:29 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3162.1 | 545360    | 16-May-19 | 06:30 | x64      |
| Dtspipeline.dll                                             | 2017.140.3162.1 | 1266464   | 16-May-19 | 06:29 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3162.1 | 48416     | 16-May-19 | 06:29 | x64      |
| Dtuparse.dll                                                | 2017.140.3162.1 | 89160     | 16-May-19 | 06:29 | x64      |
| Dtutil.exe                                                  | 2017.140.3162.1 | 147024    | 16-May-19 | 06:29 | x64      |
| Exceldest.dll                                               | 2017.140.3162.1 | 260688    | 16-May-19 | 06:29 | x64      |
| Excelsrc.dll                                                | 2017.140.3162.1 | 282704    | 16-May-19 | 06:29 | x64      |
| Execpackagetask.dll                                         | 2017.140.3162.1 | 168016    | 16-May-19 | 06:29 | x64      |
| Flatfiledest.dll                                            | 2017.140.3162.1 | 386640    | 16-May-19 | 06:29 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3162.1 | 398928    | 16-May-19 | 06:29 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3162.1 | 96336     | 16-May-19 | 06:29 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3162.1 | 59472     | 16-May-19 | 06:30 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 16-May-19 | 06:52 | x86      |
| Logread.exe                                                 | 2017.140.3162.1 | 634960    | 16-May-19 | 06:30 | x64      |
| Mergetxt.dll                                                | 2017.140.3162.1 | 63568     | 16-May-19 | 06:30 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.3      | 1381656   | 16-May-19 | 06:29 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 16-May-19 | 06:52 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3162.1     | 137808    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3162.1     | 89888     | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3162.1     | 613968    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3162.1 | 1663568   | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3162.1 | 152144    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3162.1 | 159520    | 16-May-19 | 06:30 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3162.1 | 102992    | 16-May-19 | 06:29 | x64      |
| Msgprox.dll                                                 | 2017.140.3162.1 | 270624    | 16-May-19 | 06:30 | x64      |
| Msxmlsql.dll                                                | 2017.140.3162.1 | 1448008   | 16-May-19 | 06:30 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 16-May-19 | 06:52 | x86      |
| Oledbdest.dll                                               | 2017.140.3162.1 | 261200    | 16-May-19 | 06:29 | x64      |
| Oledbsrc.dll                                                | 2017.140.3162.1 | 288848    | 16-May-19 | 06:29 | x64      |
| Osql.exe                                                    | 2017.140.3162.1 | 75552     | 16-May-19 | 06:29 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3162.1 | 474400    | 16-May-19 | 06:30 | x64      |
| Rawdest.dll                                                 | 2017.140.3162.1 | 206408    | 16-May-19 | 06:30 | x64      |
| Rawsource.dll                                               | 2017.140.3162.1 | 194128    | 16-May-19 | 06:30 | x64      |
| Rdistcom.dll                                                | 2017.140.3162.1 | 857672    | 16-May-19 | 06:30 | x64      |
| Recordsetdest.dll                                           | 2017.140.3162.1 | 184400    | 16-May-19 | 06:30 | x64      |
| Replagnt.dll                                                | 2017.140.3162.1 | 31008     | 16-May-19 | 06:30 | x64      |
| Repldp.dll                                                  | 2017.140.3162.1 | 290896    | 16-May-19 | 06:30 | x64      |
| Replerrx.dll                                                | 2017.140.3162.1 | 154192    | 16-May-19 | 06:30 | x64      |
| Replisapi.dll                                               | 2017.140.3162.1 | 362272    | 16-May-19 | 06:30 | x64      |
| Replmerg.exe                                                | 2017.140.3162.1 | 524880    | 16-May-19 | 06:30 | x64      |
| Replprov.dll                                                | 2017.140.3162.1 | 802592    | 16-May-19 | 06:30 | x64      |
| Replrec.dll                                                 | 2017.140.3162.1 | 976160    | 16-May-19 | 06:30 | x64      |
| Replsub.dll                                                 | 2017.140.3162.1 | 445520    | 16-May-19 | 06:30 | x64      |
| Replsync.dll                                                | 2017.140.3162.1 | 154400    | 16-May-19 | 06:30 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 16-May-19 | 06:30 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 16-May-19 | 06:30 | x64      |
| Spresolv.dll                                                | 2017.140.3162.1 | 251984    | 16-May-19 | 06:30 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3162.1 | 248912    | 16-May-19 | 06:30 | x64      |
| Sqldiag.exe                                                 | 2017.140.3162.1 | 1257552   | 16-May-19 | 06:30 | x64      |
| Sqldistx.dll                                                | 2017.140.3162.1 | 225568    | 16-May-19 | 06:30 | x64      |
| Sqllogship.exe                                              | 14.0.3162.1     | 105544    | 16-May-19 | 06:30 | x64      |
| Sqlmergx.dll                                                | 2017.140.3162.1 | 360736    | 16-May-19 | 06:30 | x64      |
| Sqlresld.dll                                                | 2017.140.3162.1 | 30800     | 16-May-19 | 06:30 | x64      |
| Sqlresld.dll                                                | 2017.140.3162.1 | 28752     | 16-May-19 | 06:56 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3162.1 | 32336     | 16-May-19 | 06:30 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3162.1 | 29264     | 16-May-19 | 06:56 | x86      |
| Sqlscm.dll                                                  | 2017.140.3162.1 | 71248     | 16-May-19 | 06:30 | x64      |
| Sqlscm.dll                                                  | 2017.140.3162.1 | 61008     | 16-May-19 | 06:56 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3162.1 | 162080    | 16-May-19 | 06:30 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3162.1 | 134944    | 16-May-19 | 06:56 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3162.1 | 183888    | 16-May-19 | 06:30 | x64      |
| Sqlwep140.dll                                               | 2017.140.3162.1 | 105552    | 16-May-19 | 06:30 | x64      |
| Ssdebugps.dll                                               | 2017.140.3162.1 | 33360     | 16-May-19 | 06:30 | x64      |
| Ssisoledb.dll                                               | 2017.140.3162.1 | 216144    | 16-May-19 | 06:30 | x64      |
| Ssradd.dll                                                  | 2017.140.3162.1 | 75344     | 16-May-19 | 06:30 | x64      |
| Ssravg.dll                                                  | 2017.140.3162.1 | 76064     | 16-May-19 | 06:30 | x64      |
| Ssrdown.dll                                                 | 2017.140.3162.1 | 61008     | 16-May-19 | 06:30 | x64      |
| Ssrmax.dll                                                  | 2017.140.3162.1 | 73808     | 16-May-19 | 06:30 | x64      |
| Ssrmin.dll                                                  | 2017.140.3162.1 | 74320     | 16-May-19 | 06:30 | x64      |
| Ssrpub.dll                                                  | 2017.140.3162.1 | 61520     | 16-May-19 | 06:30 | x64      |
| Ssrup.dll                                                   | 2017.140.3162.1 | 61240     | 16-May-19 | 06:30 | x64      |
| Txagg.dll                                                   | 2017.140.3162.1 | 362064    | 16-May-19 | 06:30 | x64      |
| Txbdd.dll                                                   | 2017.140.3162.1 | 170064    | 16-May-19 | 06:30 | x64      |
| Txdatacollector.dll                                         | 2017.140.3162.1 | 360528    | 16-May-19 | 06:30 | x64      |
| Txdataconvert.dll                                           | 2017.140.3162.1 | 292936    | 16-May-19 | 06:30 | x64      |
| Txderived.dll                                               | 2017.140.3162.1 | 604240    | 16-May-19 | 06:30 | x64      |
| Txlookup.dll                                                | 2017.140.3162.1 | 527952    | 16-May-19 | 06:30 | x64      |
| Txmerge.dll                                                 | 2017.140.3162.1 | 229968    | 16-May-19 | 06:30 | x64      |
| Txmergejoin.dll                                             | 2017.140.3162.1 | 275536    | 16-May-19 | 06:30 | x64      |
| Txmulticast.dll                                             | 2017.140.3162.1 | 127568    | 16-May-19 | 06:30 | x64      |
| Txrowcount.dll                                              | 2017.140.3162.1 | 125520    | 16-May-19 | 06:30 | x64      |
| Txsort.dll                                                  | 2017.140.3162.1 | 256592    | 16-May-19 | 06:30 | x64      |
| Txsplit.dll                                                 | 2017.140.3162.1 | 596560    | 16-May-19 | 06:30 | x64      |
| Txunionall.dll                                              | 2017.140.3162.1 | 181840    | 16-May-19 | 06:30 | x64      |
| Xe.dll                                                      | 2017.140.3162.1 | 673360    | 16-May-19 | 06:31 | x64      |
| Xmlrw.dll                                                   | 2017.140.3162.1 | 305232    | 16-May-19 | 06:31 | x64      |
| Xmlsub.dll                                                  | 2017.140.3162.1 | 261200    | 16-May-19 | 06:31 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3162.1 | 1124944   | 16-May-19 | 06:30 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlsatellite.dll              | 2017.140.3162.1 | 922192    | 16-May-19 | 06:30 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3162.1 | 671520    | 16-May-19 | 06:30 | x64      |
| Fdhost.exe               | 2017.140.3162.1 | 114768    | 16-May-19 | 06:30 | x64      |
| Fdlauncher.exe           | 2017.140.3162.1 | 62544     | 16-May-19 | 06:30 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 16-May-19 | 06:30 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlft140ph.dll           | 2017.140.3162.1 | 68176     | 16-May-19 | 06:30 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3162.1     | 23632     | 16-May-19 | 06:29 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-May-19 | 06:29 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-May-19 | 06:56 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-May-19 | 06:29 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-May-19 | 06:56 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-May-19 | 06:29 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-May-19 | 06:56 | x86      |
| Commanddest.dll                                               | 2017.140.3162.1 | 245832    | 16-May-19 | 06:29 | x64      |
| Commanddest.dll                                               | 2017.140.3162.1 | 200992    | 16-May-19 | 06:56 | x86      |
| Dteparse.dll                                                  | 2017.140.3162.1 | 111184    | 16-May-19 | 06:29 | x64      |
| Dteparse.dll                                                  | 2017.140.3162.1 | 100640    | 16-May-19 | 06:56 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3162.1 | 89376     | 16-May-19 | 06:29 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3162.1 | 83536     | 16-May-19 | 06:56 | x86      |
| Dtepkg.dll                                                    | 2017.140.3162.1 | 137808    | 16-May-19 | 06:29 | x64      |
| Dtepkg.dll                                                    | 2017.140.3162.1 | 116808    | 16-May-19 | 06:56 | x86      |
| Dtexec.exe                                                    | 2017.140.3162.1 | 73808     | 16-May-19 | 06:29 | x64      |
| Dtexec.exe                                                    | 2017.140.3162.1 | 67664     | 16-May-19 | 06:56 | x86      |
| Dts.dll                                                       | 2017.140.3162.1 | 2998864   | 16-May-19 | 06:29 | x64      |
| Dts.dll                                                       | 2017.140.3162.1 | 2549328   | 16-May-19 | 06:56 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3162.1 | 475216    | 16-May-19 | 06:29 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3162.1 | 418080    | 16-May-19 | 06:56 | x86      |
| Dtsconn.dll                                                   | 2017.140.3162.1 | 497224    | 16-May-19 | 06:29 | x64      |
| Dtsconn.dll                                                   | 2017.140.3162.1 | 399440    | 16-May-19 | 06:56 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3162.1 | 111184    | 16-May-19 | 06:29 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3162.1 | 95520     | 16-May-19 | 06:56 | x86      |
| Dtshost.exe                                                   | 2017.140.3162.1 | 104528    | 16-May-19 | 06:30 | x64      |
| Dtshost.exe                                                   | 2017.140.3162.1 | 89888     | 16-May-19 | 06:56 | x86      |
| Dtslog.dll                                                    | 2017.140.3162.1 | 120400    | 16-May-19 | 06:29 | x64      |
| Dtslog.dll                                                    | 2017.140.3162.1 | 102992    | 16-May-19 | 06:56 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3162.1 | 545360    | 16-May-19 | 06:30 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3162.1 | 541264    | 16-May-19 | 06:56 | x86      |
| Dtspipeline.dll                                               | 2017.140.3162.1 | 1266464   | 16-May-19 | 06:29 | x64      |
| Dtspipeline.dll                                               | 2017.140.3162.1 | 1059408   | 16-May-19 | 06:56 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3162.1 | 48416     | 16-May-19 | 06:29 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3162.1 | 42576     | 16-May-19 | 06:56 | x86      |
| Dtuparse.dll                                                  | 2017.140.3162.1 | 89160     | 16-May-19 | 06:29 | x64      |
| Dtuparse.dll                                                  | 2017.140.3162.1 | 80184     | 16-May-19 | 06:56 | x86      |
| Dtutil.exe                                                    | 2017.140.3162.1 | 147024    | 16-May-19 | 06:29 | x64      |
| Dtutil.exe                                                    | 2017.140.3162.1 | 126032    | 16-May-19 | 06:56 | x86      |
| Exceldest.dll                                                 | 2017.140.3162.1 | 260688    | 16-May-19 | 06:29 | x64      |
| Exceldest.dll                                                 | 2017.140.3162.1 | 214816    | 16-May-19 | 06:56 | x86      |
| Excelsrc.dll                                                  | 2017.140.3162.1 | 282704    | 16-May-19 | 06:29 | x64      |
| Excelsrc.dll                                                  | 2017.140.3162.1 | 230688    | 16-May-19 | 06:56 | x86      |
| Execpackagetask.dll                                           | 2017.140.3162.1 | 168016    | 16-May-19 | 06:29 | x64      |
| Execpackagetask.dll                                           | 2017.140.3162.1 | 135456    | 16-May-19 | 06:56 | x86      |
| Flatfiledest.dll                                              | 2017.140.3162.1 | 386640    | 16-May-19 | 06:29 | x64      |
| Flatfiledest.dll                                              | 2017.140.3162.1 | 332880    | 16-May-19 | 06:56 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3162.1 | 398928    | 16-May-19 | 06:29 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3162.1 | 344144    | 16-May-19 | 06:56 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3162.1 | 96336     | 16-May-19 | 06:29 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3162.1 | 80672     | 16-May-19 | 06:56 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-May-19 | 06:32 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-May-19 | 06:52 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3162.1     | 466512    | 16-May-19 | 06:29 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3162.1     | 467024    | 16-May-19 | 06:56 | x86      |
| Isserverexec.exe                                              | 14.0.3162.1     | 148560    | 16-May-19 | 06:29 | x64      |
| Isserverexec.exe                                              | 14.0.3162.1     | 149072    | 16-May-19 | 06:56 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.3      | 1381656   | 16-May-19 | 06:29 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.3      | 1381664   | 16-May-19 | 06:56 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 16-May-19 | 06:38 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-May-19 | 06:32 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-May-19 | 06:52 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3162.1     | 72784     | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3162.1 | 112416    | 16-May-19 | 06:29 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3162.1 | 107296    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3162.1     | 89888     | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3162.1     | 89680     | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3162.1     | 494672    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3162.1     | 494672    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3162.1     | 83536     | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3162.1     | 83536     | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3162.1     | 416032    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3162.1     | 415824    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3162.1     | 613968    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3162.1     | 613968    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3162.1     | 252704    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3162.1     | 252496    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3162.1 | 152144    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3162.1 | 141904    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3162.1 | 159520    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3162.1 | 145488    | 16-May-19 | 06:56 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3162.1     | 219728    | 16-May-19 | 06:30 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3162.1 | 102992    | 16-May-19 | 06:29 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3162.1 | 90400     | 16-May-19 | 06:56 | x86      |
| Msmdpp.dll                                                    | 2017.140.249.3  | 9194056   | 16-May-19 | 06:30 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-May-19 | 06:32 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-May-19 | 06:41 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-May-19 | 06:46 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-May-19 | 06:52 | x86      |
| Oledbdest.dll                                                 | 2017.140.3162.1 | 261200    | 16-May-19 | 06:29 | x64      |
| Oledbdest.dll                                                 | 2017.140.3162.1 | 214608    | 16-May-19 | 06:56 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3162.1 | 288848    | 16-May-19 | 06:29 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3162.1 | 233248    | 16-May-19 | 06:56 | x86      |
| Rawdest.dll                                                   | 2017.140.3162.1 | 206408    | 16-May-19 | 06:30 | x64      |
| Rawdest.dll                                                   | 2017.140.3162.1 | 166688    | 16-May-19 | 06:56 | x86      |
| Rawsource.dll                                                 | 2017.140.3162.1 | 194128    | 16-May-19 | 06:30 | x64      |
| Rawsource.dll                                                 | 2017.140.3162.1 | 153376    | 16-May-19 | 06:56 | x86      |
| Recordsetdest.dll                                             | 2017.140.3162.1 | 184400    | 16-May-19 | 06:30 | x64      |
| Recordsetdest.dll                                             | 2017.140.3162.1 | 149280    | 16-May-19 | 06:56 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlceip.exe                                                   | 14.0.3162.1     | 261712    | 16-May-19 | 06:38 | x86      |
| Sqldest.dll                                                   | 2017.140.3162.1 | 260688    | 16-May-19 | 06:30 | x64      |
| Sqldest.dll                                                   | 2017.140.3162.1 | 213792    | 16-May-19 | 06:56 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3162.1 | 183888    | 16-May-19 | 06:30 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3162.1 | 155424    | 16-May-19 | 06:56 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3162.1 | 216144    | 16-May-19 | 06:30 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3162.1 | 176720    | 16-May-19 | 06:56 | x86      |
| Txagg.dll                                                     | 2017.140.3162.1 | 362064    | 16-May-19 | 06:30 | x64      |
| Txagg.dll                                                     | 2017.140.3162.1 | 302160    | 16-May-19 | 06:56 | x86      |
| Txbdd.dll                                                     | 2017.140.3162.1 | 170064    | 16-May-19 | 06:30 | x64      |
| Txbdd.dll                                                     | 2017.140.3162.1 | 136480    | 16-May-19 | 06:56 | x86      |
| Txbestmatch.dll                                               | 2017.140.3162.1 | 605264    | 16-May-19 | 06:30 | x64      |
| Txbestmatch.dll                                               | 2017.140.3162.1 | 493128    | 16-May-19 | 06:56 | x86      |
| Txcache.dll                                                   | 2017.140.3162.1 | 180304    | 16-May-19 | 06:30 | x64      |
| Txcache.dll                                                   | 2017.140.3162.1 | 146208    | 16-May-19 | 06:56 | x86      |
| Txcharmap.dll                                                 | 2017.140.3162.1 | 286800    | 16-May-19 | 06:30 | x64      |
| Txcharmap.dll                                                 | 2017.140.3162.1 | 249120    | 16-May-19 | 06:56 | x86      |
| Txcopymap.dll                                                 | 2017.140.3162.1 | 180304    | 16-May-19 | 06:30 | x64      |
| Txcopymap.dll                                                 | 2017.140.3162.1 | 145720    | 16-May-19 | 06:56 | x86      |
| Txdataconvert.dll                                             | 2017.140.3162.1 | 292936    | 16-May-19 | 06:30 | x64      |
| Txdataconvert.dll                                             | 2017.140.3162.1 | 253216    | 16-May-19 | 06:56 | x86      |
| Txderived.dll                                                 | 2017.140.3162.1 | 604240    | 16-May-19 | 06:30 | x64      |
| Txderived.dll                                                 | 2017.140.3162.1 | 515872    | 16-May-19 | 06:56 | x86      |
| Txfileextractor.dll                                           | 2017.140.3162.1 | 198736    | 16-May-19 | 06:30 | x64      |
| Txfileextractor.dll                                           | 2017.140.3162.1 | 160848    | 16-May-19 | 06:56 | x86      |
| Txfileinserter.dll                                            | 2017.140.3162.1 | 196688    | 16-May-19 | 06:30 | x64      |
| Txfileinserter.dll                                            | 2017.140.3162.1 | 159520    | 16-May-19 | 06:56 | x86      |
| Txgroupdups.dll                                               | 2017.140.3162.1 | 290384    | 16-May-19 | 06:30 | x64      |
| Txgroupdups.dll                                               | 2017.140.3162.1 | 230992    | 16-May-19 | 06:56 | x86      |
| Txlineage.dll                                                 | 2017.140.3162.1 | 136776    | 16-May-19 | 06:30 | x64      |
| Txlineage.dll                                                 | 2017.140.3162.1 | 110368    | 16-May-19 | 06:56 | x86      |
| Txlookup.dll                                                  | 2017.140.3162.1 | 527952    | 16-May-19 | 06:30 | x64      |
| Txlookup.dll                                                  | 2017.140.3162.1 | 455648    | 16-May-19 | 06:56 | x86      |
| Txmerge.dll                                                   | 2017.140.3162.1 | 229968    | 16-May-19 | 06:30 | x64      |
| Txmerge.dll                                                   | 2017.140.3162.1 | 176928    | 16-May-19 | 06:56 | x86      |
| Txmergejoin.dll                                               | 2017.140.3162.1 | 275536    | 16-May-19 | 06:30 | x64      |
| Txmergejoin.dll                                               | 2017.140.3162.1 | 221984    | 16-May-19 | 06:56 | x86      |
| Txmulticast.dll                                               | 2017.140.3162.1 | 127568    | 16-May-19 | 06:30 | x64      |
| Txmulticast.dll                                               | 2017.140.3162.1 | 102688    | 16-May-19 | 06:56 | x86      |
| Txpivot.dll                                                   | 2017.140.3162.1 | 224848    | 16-May-19 | 06:30 | x64      |
| Txpivot.dll                                                   | 2017.140.3162.1 | 180512    | 16-May-19 | 06:56 | x86      |
| Txrowcount.dll                                                | 2017.140.3162.1 | 125520    | 16-May-19 | 06:30 | x64      |
| Txrowcount.dll                                                | 2017.140.3162.1 | 101664    | 16-May-19 | 06:56 | x86      |
| Txsampling.dll                                                | 2017.140.3162.1 | 172616    | 16-May-19 | 06:30 | x64      |
| Txsampling.dll                                                | 2017.140.3162.1 | 135968    | 16-May-19 | 06:56 | x86      |
| Txscd.dll                                                     | 2017.140.3162.1 | 220752    | 16-May-19 | 06:30 | x64      |
| Txscd.dll                                                     | 2017.140.3162.1 | 170272    | 16-May-19 | 06:56 | x86      |
| Txsort.dll                                                    | 2017.140.3162.1 | 256592    | 16-May-19 | 06:30 | x64      |
| Txsort.dll                                                    | 2017.140.3162.1 | 208160    | 16-May-19 | 06:56 | x86      |
| Txsplit.dll                                                   | 2017.140.3162.1 | 596560    | 16-May-19 | 06:30 | x64      |
| Txsplit.dll                                                   | 2017.140.3162.1 | 510752    | 16-May-19 | 06:56 | x86      |
| Txtermextraction.dll                                          | 2017.140.3162.1 | 8676432   | 16-May-19 | 06:30 | x64      |
| Txtermextraction.dll                                          | 2017.140.3162.1 | 8614992   | 16-May-19 | 06:56 | x86      |
| Txtermlookup.dll                                              | 2017.140.3162.1 | 4157008   | 16-May-19 | 06:30 | x64      |
| Txtermlookup.dll                                              | 2017.140.3162.1 | 4106832   | 16-May-19 | 06:56 | x86      |
| Txunionall.dll                                                | 2017.140.3162.1 | 181840    | 16-May-19 | 06:30 | x64      |
| Txunionall.dll                                                | 2017.140.3162.1 | 139552    | 16-May-19 | 06:56 | x86      |
| Txunpivot.dll                                                 | 2017.140.3162.1 | 199760    | 16-May-19 | 06:30 | x64      |
| Txunpivot.dll                                                 | 2017.140.3162.1 | 160544    | 16-May-19 | 06:56 | x86      |
| Xe.dll                                                        | 2017.140.3162.1 | 673360    | 16-May-19 | 06:31 | x64      |
| Xe.dll                                                        | 2017.140.3162.1 | 595536    | 16-May-19 | 06:56 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 16-May-19 | 06:41 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 16-May-19 | 06:41 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 16-May-19 | 06:41 | x86      |
| Instapi140.dll                                                       | 2017.140.3162.1  | 70952     | 16-May-19 | 06:41 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 16-May-19 | 06:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 16-May-19 | 06:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 16-May-19 | 06:52 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 16-May-19 | 06:52 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 16-May-19 | 06:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 16-May-19 | 06:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 16-May-19 | 06:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 16-May-19 | 06:37 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 16-May-19 | 06:43 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 16-May-19 | 06:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 16-May-19 | 06:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 16-May-19 | 06:52 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 16-May-19 | 06:52 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 16-May-19 | 06:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 16-May-19 | 06:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 16-May-19 | 06:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 16-May-19 | 06:37 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 16-May-19 | 06:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 16-May-19 | 06:41 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 16-May-19 | 06:41 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3162.1  | 407120    | 16-May-19 | 06:41 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3162.1  | 7325992   | 16-May-19 | 06:41 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3162.1  | 2263120   | 16-May-19 | 06:41 | x64      |
| Secforwarder.dll                                                     | 2017.140.3162.1  | 37456     | 16-May-19 | 06:41 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 16-May-19 | 06:41 | x64      |
| Sqldk.dll                                                            | 2017.140.3162.1  | 2733136   | 16-May-19 | 06:41 | x64      |
| Sqldumper.exe                                                        | 2017.140.3162.1  | 144160    | 16-May-19 | 06:41 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 1498912   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3917096   | 16-May-19 | 06:27 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3215440   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3920160   | 16-May-19 | 06:41 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3823400   | 16-May-19 | 06:52 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 2091296   | 16-May-19 | 06:24 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 2038056   | 16-May-19 | 06:47 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3590952   | 16-May-19 | 06:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3599136   | 16-May-19 | 06:39 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 1446184   | 16-May-19 | 06:24 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3162.1  | 3787552   | 16-May-19 | 06:33 | x64      |
| Sqlos.dll                                                            | 2017.140.3162.1  | 26192     | 16-May-19 | 06:41 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 16-May-19 | 06:41 | x64      |
| Sqltses.dll                                                          | 2017.140.3162.1  | 9734736   | 16-May-19 | 06:41 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3162.1     | 23848     | 16-May-19 | 06:30 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3162.1 | 1448528   | 16-May-19 | 06:56 | x86      |
| Dtaengine.exe                                          | 2017.140.3162.1 | 204576    | 16-May-19 | 06:56 | x86      |
| Dteparse.dll                                           | 2017.140.3162.1 | 111184    | 16-May-19 | 06:29 | x64      |
| Dteparse.dll                                           | 2017.140.3162.1 | 100640    | 16-May-19 | 06:56 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3162.1 | 89376     | 16-May-19 | 06:29 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3162.1 | 83536     | 16-May-19 | 06:56 | x86      |
| Dtepkg.dll                                             | 2017.140.3162.1 | 137808    | 16-May-19 | 06:29 | x64      |
| Dtepkg.dll                                             | 2017.140.3162.1 | 116808    | 16-May-19 | 06:56 | x86      |
| Dtexec.exe                                             | 2017.140.3162.1 | 73808     | 16-May-19 | 06:29 | x64      |
| Dtexec.exe                                             | 2017.140.3162.1 | 67664     | 16-May-19 | 06:56 | x86      |
| Dts.dll                                                | 2017.140.3162.1 | 2998864   | 16-May-19 | 06:29 | x64      |
| Dts.dll                                                | 2017.140.3162.1 | 2549328   | 16-May-19 | 06:56 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3162.1 | 475216    | 16-May-19 | 06:29 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3162.1 | 418080    | 16-May-19 | 06:56 | x86      |
| Dtsconn.dll                                            | 2017.140.3162.1 | 497224    | 16-May-19 | 06:29 | x64      |
| Dtsconn.dll                                            | 2017.140.3162.1 | 399440    | 16-May-19 | 06:56 | x86      |
| Dtshost.exe                                            | 2017.140.3162.1 | 104528    | 16-May-19 | 06:30 | x64      |
| Dtshost.exe                                            | 2017.140.3162.1 | 89888     | 16-May-19 | 06:56 | x86      |
| Dtslog.dll                                             | 2017.140.3162.1 | 120400    | 16-May-19 | 06:29 | x64      |
| Dtslog.dll                                             | 2017.140.3162.1 | 102992    | 16-May-19 | 06:56 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3162.1 | 545360    | 16-May-19 | 06:30 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3162.1 | 541264    | 16-May-19 | 06:56 | x86      |
| Dtspipeline.dll                                        | 2017.140.3162.1 | 1266464   | 16-May-19 | 06:29 | x64      |
| Dtspipeline.dll                                        | 2017.140.3162.1 | 1059408   | 16-May-19 | 06:56 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3162.1 | 48416     | 16-May-19 | 06:29 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3162.1 | 42576     | 16-May-19 | 06:56 | x86      |
| Dtuparse.dll                                           | 2017.140.3162.1 | 89160     | 16-May-19 | 06:29 | x64      |
| Dtuparse.dll                                           | 2017.140.3162.1 | 80184     | 16-May-19 | 06:56 | x86      |
| Dtutil.exe                                             | 2017.140.3162.1 | 147024    | 16-May-19 | 06:29 | x64      |
| Dtutil.exe                                             | 2017.140.3162.1 | 126032    | 16-May-19 | 06:56 | x86      |
| Exceldest.dll                                          | 2017.140.3162.1 | 260688    | 16-May-19 | 06:29 | x64      |
| Exceldest.dll                                          | 2017.140.3162.1 | 214816    | 16-May-19 | 06:56 | x86      |
| Excelsrc.dll                                           | 2017.140.3162.1 | 282704    | 16-May-19 | 06:29 | x64      |
| Excelsrc.dll                                           | 2017.140.3162.1 | 230688    | 16-May-19 | 06:56 | x86      |
| Flatfiledest.dll                                       | 2017.140.3162.1 | 386640    | 16-May-19 | 06:29 | x64      |
| Flatfiledest.dll                                       | 2017.140.3162.1 | 332880    | 16-May-19 | 06:56 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3162.1 | 398928    | 16-May-19 | 06:29 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3162.1 | 344144    | 16-May-19 | 06:56 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3162.1 | 96336     | 16-May-19 | 06:29 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3162.1 | 80672     | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3162.1     | 72784     | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3162.1     | 186448    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3162.1     | 409680    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3162.1     | 409680    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3162.1     | 2093136   | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3162.1     | 2093136   | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3162.1     | 613968    | 16-May-19 | 06:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3162.1     | 613968    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3162.1     | 252496    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3162.1 | 152144    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3162.1 | 141904    | 16-May-19 | 06:56 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3162.1 | 159520    | 16-May-19 | 06:30 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3162.1 | 145488    | 16-May-19 | 06:56 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3162.1 | 102992    | 16-May-19 | 06:29 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3162.1 | 90400     | 16-May-19 | 06:56 | x86      |
| Msmgdsrv.dll                                           | 2017.140.249.3  | 7310616   | 16-May-19 | 06:56 | x86      |
| Oledbdest.dll                                          | 2017.140.3162.1 | 261200    | 16-May-19 | 06:29 | x64      |
| Oledbdest.dll                                          | 2017.140.3162.1 | 214608    | 16-May-19 | 06:56 | x86      |
| Oledbsrc.dll                                           | 2017.140.3162.1 | 288848    | 16-May-19 | 06:29 | x64      |
| Oledbsrc.dll                                           | 2017.140.3162.1 | 233248    | 16-May-19 | 06:56 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3162.1 | 100432    | 16-May-19 | 06:29 | x64      |
| Sqlresld.dll                                           | 2017.140.3162.1 | 30800     | 16-May-19 | 06:30 | x64      |
| Sqlresld.dll                                           | 2017.140.3162.1 | 28752     | 16-May-19 | 06:56 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3162.1 | 32336     | 16-May-19 | 06:30 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3162.1 | 29264     | 16-May-19 | 06:56 | x86      |
| Sqlscm.dll                                             | 2017.140.3162.1 | 71248     | 16-May-19 | 06:30 | x64      |
| Sqlscm.dll                                             | 2017.140.3162.1 | 61008     | 16-May-19 | 06:56 | x86      |
| Sqlsvc.dll                                             | 2017.140.3162.1 | 162080    | 16-May-19 | 06:30 | x64      |
| Sqlsvc.dll                                             | 2017.140.3162.1 | 134944    | 16-May-19 | 06:56 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3162.1 | 183888    | 16-May-19 | 06:30 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3162.1 | 155424    | 16-May-19 | 06:56 | x86      |
| Txdataconvert.dll                                      | 2017.140.3162.1 | 292936    | 16-May-19 | 06:30 | x64      |
| Txdataconvert.dll                                      | 2017.140.3162.1 | 253216    | 16-May-19 | 06:56 | x86      |
| Xe.dll                                                 | 2017.140.3162.1 | 673360    | 16-May-19 | 06:31 | x64      |
| Xe.dll                                                 | 2017.140.3162.1 | 595536    | 16-May-19 | 06:56 | x86      |
| Xmlrw.dll                                              | 2017.140.3162.1 | 305232    | 16-May-19 | 06:31 | x64      |
| Xmlrw.dll                                              | 2017.140.3162.1 | 257616    | 16-May-19 | 06:56 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3162.1 | 224552    | 16-May-19 | 06:31 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3162.1 | 189520    | 16-May-19 | 06:56 | x86      |

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
