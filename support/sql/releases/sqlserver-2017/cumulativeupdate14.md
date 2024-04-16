---
title: Cumulative update 14 for SQL Server 2017 (KB4484710)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 14 (KB4484710).
ms.date: 08/04/2023
ms.custom: KB4484710, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4484710 - Cumulative Update 14 for SQL Server 2017

_Release Date:_ &nbsp; March 25, 2019  
_Version:_ &nbsp; 14.0.3076.1

## Summary

This article describes Cumulative Update package 14 (CU14) for Microsoft SQL Server 2017. This update contains 34 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 13, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3076.1**, file version: **2017.140.3076.1**
- Analysis Services - Product version: **14.0.245.1**, file version: **2017.140.245.1**

## Known issues in this update

After installing this Cumulative Update for Linux, you may notice the following message in SQL Server error log file:

> DateTime Server Failed to verify the Authenticode signature of 'C:\binn\secforwarder.dll'. Signature verification of SQL Server DLLs will be skipped. Genuine copies of SQL Server are signed.  
> Failure to verify the Authenticode signature might indicate that this is not an authentic release of SQL Server. Install a genuine copy of SQL Server or contact customer support.

This message results from a change in how *sedforwarder.dll* is being built and packaged for Linux. The signature checking logic wasn't updated appropriately. The message can safely be ignored and the signature checking logic will be updated in future cumulative updates to address this issue.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12631714">[12631714](#12631714)</a> | [FIX: An unexpected exception error occurs when you run a TREATAS function DAX query from Power BI desktop in SSAS 2017 (KB4487751)](https://support.microsoft.com/help/4487751) | Analysis Services | Analysis Services | Windows |
| <a id="12635600">[12635600](#12635600)</a> | [FIX: Reporting Action feature doesn't appear in the menu when you view the related measure in Excel or use MDSCHEMA_ACTIONS in SSAS 2017 (KB4487975)](https://support.microsoft.com/help/4487975) | Analysis Services | Analysis Services | Windows |
| <a id="12671899">[12671899](#12671899)</a> | [FIX: Query results aren't as expected when you run a particular query from Excel in SQL 2014 SP2 CU14 or later versions (2016, 2017 or 2019) (KB4486935)](https://support.microsoft.com/help/4486935) | Analysis Services | Analysis Services | Windows |
| <a id="12564137">[12564137](#12564137)</a> | [Update adds improvements and fixes issues when you use an Oracle RAC environment in SQL Server (KB4480647)](https://support.microsoft.com/help/4480647) | Integration Services | CDC | Windows |
| <a id="12571730">[12571730](#12571730)</a> | [FIX: Publishing MDS data from Excel fails when you save the changes to workbook, close and reopen it in SQL Server 2016 and 2017 (KB4486937)](https://support.microsoft.com/help/4486937) | Master Data Services | Client | Windows |
| <a id="12654305">[12654305](#12654305)</a> | [FIX: MDS database upgrade fails with error in SQL Server 2016 and 2017 (KB4488971)](https://support.microsoft.com/help/4488971) | Master Data Services | Server | Windows |
| <a id="12588637">[12588637](#12588637)</a> | [FIX: Assertion failure occurs when you try to back up database in limited disk space in SQL Server 2016 and 2017 (KB4486940)](https://support.microsoft.com/help/4486940) | SQL Server Engine | Backup Restore | Windows |
| <a id="12656908">[12656908](#12656908)</a> | [FIX: Assertion occurs when a parallel query deletes from a Filestream table in SQL Server 2014, 2016 and 2017 (KB4488809)](https://support.microsoft.com/help/4488809) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12657080">[12657080](#12657080)</a> | [FIX: FILESTREAM for file I/O access feature can't be enabled when you use Cluster Shared Volumes (CSV) in SQL Server 2016 and 2017 Failover Cluster Instances (KB4488817)](https://support.microsoft.com/help/4488817) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12562317">[12562317](#12562317)</a> | [FIX: Access violation occurs and data movement is suspended for databases in Availability Group in SQL Server 2017 (KB4488400)](https://support.microsoft.com/help/4488400) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12671876">[12671876](#12671876)</a> | [FIX: sys.fn_hadr_backup_is_preferred_replica returns TRUE for more than one secondary replica even if the priority values are identical in SQL Server 2016 and 2017 (KB4480650)](https://support.microsoft.com/help/4480650) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12578034">[12578034](#12578034)</a> | [FIX: "Non-yielding" error occurs when there's a heavy use of prepared statements in SQL Server 2014, 2016 and 2017 (KB4475322)](https://support.microsoft.com/help/4475322) | SQL Server Engine | Programmability | Windows |
| <a id="12672571">[12672571](#12672571)</a> | [FIX: Truncation error when TF 460 is enabled and you use INSERT INTO table variable in ELSE block in SQL Server 2017 (KB4490142)](https://support.microsoft.com/help/4490142) | SQL Server Engine | Programmability | All |
| <a id="12629554">[12629554](#12629554)</a> | [Improvement: Add a new extended event query_post_execution_plan_profile in SQL Server 2017 (KB4490134)](https://support.microsoft.com/help/4490134) | SQL Server Engine | Query Execution | All |
| <a id="12671869">[12671869](#12671869)</a> | [FIX: Columnstore Index build request may time out after 25 seconds though the memory grant time-out is configured in SQL Server 2016 or 2017 (KB4480641)](https://support.microsoft.com/help/4480641) | SQL Server Engine | Query Execution | All |
| <a id="12580378">[12580378](#12580378)</a> | [FIX: Access violation occurs when automatic statistics update happens on tables with incremental statistics in SQL Server 2017 (KB4488026)](https://support.microsoft.com/help/4488026) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12671863">[12671863](#12671863)</a> | [FIX: Users are incorrectly permitted to create incremental statistics on nonclustered indexes which aren't aligned to the base table in SQL Server 2016 and 2017 (KB4486932)](https://support.microsoft.com/help/4486932) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12677802">[12677802](#12677802)</a> | [FIX: Filtered NCI over a CCI may not be maintained when the table is updated in a way that none of the key or included columns of the NCI are changed in SQL Server 2016 and 2017 (KB4490138)](https://support.microsoft.com/help/4490138) | SQL Server Engine | Query Optimizer | All |
| <a id="12594078">[12594078](#12594078)</a> | [FIX: Upgrade to SQL Server 2016 SP2 CU3 or CU4 fails with an error when sysadmin account "sa" is renamed in SQL Server 2016 and 2017 (KB4486931)](https://support.microsoft.com/help/4486931) | SQL Server Engine | Replication | Windows |
| <a id="12639890">[12639890](#12639890)</a> | [FIX: Error 2812 and 20028 occur when you drop publisher or enable database for publication after you upgrade your SQL Server 2016 and 2017 (KB4488856)](https://support.microsoft.com/help/4488856) | SQL Server Engine | Replication | Windows |
| <a id="12656687">[12656687](#12656687)</a> | [FIX: Repl_Schema_Access wait issues when there are multiple publisher databases on the same instance of SQL Server 2017 (KB4488036)](https://support.microsoft.com/help/4488036) | SQL Server Engine | Replication | All |
| <a id="12673173">[12673173](#12673173)</a> | [FIX: Stack Dump occurs in the change tracking cleanup process in SQL Server 2016 and 2017 (KB4490140)](https://support.microsoft.com/help/4490140) | SQL Server Engine | Replication | Windows |
| <a id="12700549">[12700549](#12700549)</a> | [Improvement: New XEvent sqlserver.security_authentication_perf_interrogate_login is added in SQL Server 2017 (KB4490144)](https://support.microsoft.com/help/4490144) | SQL Server Engine | Security Infrastructure | Linux |
| <a id="12700550">[12700550](#12700550)</a> | [Improvement: New mssql-conf option network.enablekdcfromkrb5 is added in SQL Server 2017 (KB4490145)](https://support.microsoft.com/help/4490145) | SQL Server Engine | Security Infrastructure | Linux |
| <a id="12695517">[12695517](#12695517)</a> | [FIX: TCP Timeout or login time-out error occurs when you connect to SQL Server 2017 by using Integrated Authentication (KB4490379)](https://support.microsoft.com/help/4490379) | SQL Server Engine | Security Infrastructure | Linux |
| <a id="12546124">[12546124](#12546124)</a> | [FIX: I/O error on a BPE file causes buffer time-out in SQL Server (KB4469268)](https://support.microsoft.com/help/4469268) | SQL Server Engine | SQL OS | Windows |
| <a id="12576806">[12576806](#12576806)</a> | [FIX: SQL Server 2017 may crash when local process uses global key event handle (KB4490135)](https://support.microsoft.com/help/4490135) | SQL Server Engine | SQL OS | Linux |
| <a id="12651915">[12651915](#12651915)</a> | [FIX: DBCC STACKDUMP doesn't generate dump file for SQL Server 2017 on Linux starting from SQL Server 2017 CU9 to CU13 (KB4490799)](https://support.microsoft.com/help/4490799) | SQL Server Engine | SQL OS | Linux |
| <a id="12671897">[12671897](#12671897)</a> | [FIX: Access violation occurs and server stops unexpectedly when you use XEvent session with sqlos.wait_info event in SQL Server 2016 and 2017 (KB4483427)](https://support.microsoft.com/help/4483427) | SQL Server Engine | SQL OS | Windows |
| <a id="12674843">[12674843](#12674843)</a> | [FIX: TCP Timeout or login time-out error occurs when you connect to SQL Server 2017 using Integrated Authentication (KB4490137)](https://support.microsoft.com/help/4490137) | SQL Server Engine | SQL OS | All |
| <a id="12245672">[12245672](#12245672)</a> | [FIX: SQL Server may generate EXCEPTION_ACCESS_VIOLATION dump file when you merge two partitions of system-versioned temporal tables in SQL Server 2016 or 2017 (KB4338761)](https://support.microsoft.com/help/4338761) | SQL Server Engine | Temporal | Windows |
| <a id="12552012">[12552012](#12552012)</a> | [Snapshot Isolation and Savepoint support added for Availability Group databases on the same instance with DTC enabled in SQL Server (KB4483593)](https://support.microsoft.com/help/4483593) | SQL Server Engine | Transaction Services | Windows |
| <a id="12450172">[12450172](#12450172)</a> | [FIX: Possible assertion failure when a cross-database transaction involving an Availability Group database is committed from a SQL Server trigger (KB4483571)](https://support.microsoft.com/help/4483571) | SQL Server Engine | Transaction Services | Windows |
| <a id="12654421">[12654421](#12654421)</a> | [FIX: Assertion occurs when linked server which points to itself is used in a cross-database transaction in SQL Server 2016 and 2017 (KB4488949)](https://support.microsoft.com/help/4488949) | SQL Server Engine | Transaction Services | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU14 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2019/03/sqlserver2017-kb4484710-x64_59015db5853814c7f2ac24cd4722c0eae771829f.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4484710-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4484710-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4484710-x64.exe| 31AE7282F02AA2290E97C006FB3B63D683D21D1A995E0644DC61292EE4B6BD57 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.245.1  | 266528    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.245.1      | 741656    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.245.1      | 1380640   | 13-Mar-19 | 06:19 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.245.1      | 984136    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.245.1      | 521288    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 13-Mar-19 | 06:47 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 13-Mar-19 | 06:15 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 13-Mar-19 | 06:15 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 13-Mar-19 | 06:15 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 13-Mar-19 | 06:15 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 13-Mar-19 | 06:15 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 13-Mar-19 | 06:15 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 13-Mar-19 | 06:15 | x86      |
| Msmdctr.dll                                        | 2017.140.245.1  | 40008     | 13-Mar-19 | 06:20 | x64      |
| Msmdlocal.dll                                      | 2017.140.245.1  | 60710472  | 13-Mar-19 | 06:20 | x64      |
| Msmdlocal.dll                                      | 2017.140.245.1  | 40387864  | 13-Mar-19 | 06:51 | x86      |
| Msmdpump.dll                                       | 2017.140.245.1  | 9334856   | 13-Mar-19 | 06:20 | x64      |
| Msmdredir.dll                                      | 2017.140.245.1  | 7092504   | 13-Mar-19 | 06:51 | x86      |
| Msmdsrv.exe                                        | 2017.140.245.1  | 60613400  | 13-Mar-19 | 06:20 | x64      |
| Msmgdsrv.dll                                       | 2017.140.245.1  | 9004824   | 13-Mar-19 | 06:20 | x64      |
| Msmgdsrv.dll                                       | 2017.140.245.1  | 7310640   | 13-Mar-19 | 06:51 | x86      |
| Msolap.dll                                         | 2017.140.245.1  | 10258504  | 13-Mar-19 | 06:20 | x64      |
| Msolap.dll                                         | 2017.140.245.1  | 7777352   | 13-Mar-19 | 06:51 | x86      |
| Msolui.dll                                         | 2017.140.245.1  | 311064    | 13-Mar-19 | 06:20 | x64      |
| Msolui.dll                                         | 2017.140.245.1  | 287512    | 13-Mar-19 | 06:51 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 13-Mar-19 | 06:15 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlboot.dll                                        | 2017.140.3076.1 | 196168    | 13-Mar-19 | 06:22 | x64      |
| Sqlceip.exe                                        | 14.0.3076.1     | 258120    | 13-Mar-19 | 06:47 | x86      |
| Sqldumper.exe                                      | 2017.140.3076.1 | 122136    | 13-Mar-19 | 06:29 | x86      |
| Sqldumper.exe                                      | 2017.140.3076.1 | 144152    | 13-Mar-19 | 06:29 | x64      |
| Tmapi.dll                                          | 2017.140.245.1  | 5821512   | 13-Mar-19 | 06:22 | x64      |
| Tmcachemgr.dll                                     | 2017.140.245.1  | 4164680   | 13-Mar-19 | 06:22 | x64      |
| Tmpersistence.dll                                  | 2017.140.245.1  | 1132312   | 13-Mar-19 | 06:22 | x64      |
| Tmtransactions.dll                                 | 2017.140.245.1  | 1641032   | 13-Mar-19 | 06:22 | x64      |
| Xe.dll                                             | 2017.140.3076.1 | 673352    | 13-Mar-19 | 06:22 | x64      |
| Xmlrw.dll                                          | 2017.140.3076.1 | 305224    | 13-Mar-19 | 06:22 | x64      |
| Xmlrw.dll                                          | 2017.140.3076.1 | 257608    | 13-Mar-19 | 06:51 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3076.1 | 224328    | 13-Mar-19 | 06:22 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3076.1 | 189512    | 13-Mar-19 | 06:51 | x86      |
| Xmsrv.dll                                          | 2017.140.245.1  | 25375304  | 13-Mar-19 | 06:22 | x64      |
| Xmsrv.dll                                          | 2017.140.245.1  | 33350728  | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3076.1  | 180808    | 13-Mar-19 | 06:19 | x64      |
| Batchparser.dll                            | 2017.140.3076.1  | 160328    | 13-Mar-19 | 06:50 | x86      |
| Instapi140.dll                             | 2017.140.3076.1  | 70728     | 13-Mar-19 | 06:20 | x64      |
| Instapi140.dll                             | 2017.140.3076.1  | 61000     | 13-Mar-19 | 06:51 | x86      |
| Isacctchange.dll                           | 2017.140.3076.1  | 31000     | 13-Mar-19 | 06:19 | x64      |
| Isacctchange.dll                           | 2017.140.3076.1  | 29464     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.245.1       | 1088792   | 13-Mar-19 | 06:19 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.245.1       | 1088584   | 13-Mar-19 | 06:50 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.245.1       | 1381656   | 13-Mar-19 | 06:50 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.245.1       | 741664    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.245.1       | 741656    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3076.1      | 36936     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3076.1  | 82200     | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3076.1  | 78408     | 13-Mar-19 | 06:50 | x86      |
| Msasxpress.dll                             | 2017.140.245.1   | 36120     | 13-Mar-19 | 06:20 | x64      |
| Msasxpress.dll                             | 2017.140.245.1   | 32024     | 13-Mar-19 | 06:51 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3076.1  | 82712     | 13-Mar-19 | 06:22 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3076.1  | 68168     | 13-Mar-19 | 06:51 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3076.1  | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqldumper.exe                              | 2017.140.3076.1  | 122136    | 13-Mar-19 | 06:29 | x86      |
| Sqldumper.exe                              | 2017.140.3076.1  | 144152    | 13-Mar-19 | 06:29 | x64      |
| Sqlftacct.dll                              | 2017.140.3076.1  | 62744     | 13-Mar-19 | 06:22 | x64      |
| Sqlftacct.dll                              | 2017.140.3076.1  | 55368     | 13-Mar-19 | 06:51 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 13-Mar-19 | 06:20 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 13-Mar-19 | 06:51 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3076.1  | 418888    | 13-Mar-19 | 06:20 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3076.1  | 373832    | 13-Mar-19 | 06:51 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3076.1  | 37656     | 13-Mar-19 | 06:22 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3076.1  | 34888     | 13-Mar-19 | 06:51 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3076.1  | 355912    | 13-Mar-19 | 06:22 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3076.1  | 272968    | 13-Mar-19 | 06:51 | x86      |
| Sqltdiagn.dll                              | 2017.140.3076.1  | 67656     | 13-Mar-19 | 06:20 | x64      |
| Sqltdiagn.dll                              | 2017.140.3076.1  | 60696     | 13-Mar-19 | 06:51 | x86      |
| Svrenumapi140.dll                          | 2017.140.3076.1  | 1173576   | 13-Mar-19 | 06:22 | x64      |
| Svrenumapi140.dll                          | 2017.140.3076.1  | 893512    | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 Data Quality Client

|      File name      |   File version  | File size |    Date   |  Time | Platform |
|:-------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 13-Mar-19 | 06:51 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 13-Mar-19 | 06:51 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 13-Mar-19 | 06:51 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 Data Quality

|                     File name                     | File version | File size |    Date   |  Time | Platform |
|:-------------------------------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 13-Mar-19 | 06:50 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3076.1 | 120904    | 13-Mar-19 | 06:50 | x86      |
| Dreplaycommon.dll              | 2017.140.3076.1 | 699160    | 13-Mar-19 | 06:50 | x86      |
| Dreplayserverps.dll            | 2017.140.3076.1 | 32840     | 13-Mar-19 | 06:50 | x86      |
| Dreplayutil.dll                | 2017.140.3076.1 | 309832    | 13-Mar-19 | 06:50 | x86      |
| Instapi140.dll                 | 2017.140.3076.1 | 70728     | 13-Mar-19 | 06:20 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlresourceloader.dll          | 2017.140.3076.1 | 29256     | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3076.1 | 699160    | 13-Mar-19 | 06:50 | x86      |
| Dreplaycontroller.exe              | 2017.140.3076.1 | 350280    | 13-Mar-19 | 06:50 | x86      |
| Dreplayprocess.dll                 | 2017.140.3076.1 | 171592    | 13-Mar-19 | 06:50 | x86      |
| Dreplayserverps.dll                | 2017.140.3076.1 | 32840     | 13-Mar-19 | 06:50 | x86      |
| Instapi140.dll                     | 2017.140.3076.1 | 70728     | 13-Mar-19 | 06:20 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlresourceloader.dll              | 2017.140.3076.1 | 29256     | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 14.0.3076.1     | 40520     | 13-Mar-19 | 06:19 | x64      |
| Batchparser.dll                              | 2017.140.3076.1 | 180808    | 13-Mar-19 | 06:19 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 13-Mar-19 | 06:16 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 13-Mar-19 | 06:16 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 13-Mar-19 | 06:16 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 13-Mar-19 | 06:45 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 13-Mar-19 | 06:19 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3076.1 | 226376    | 13-Mar-19 | 06:19 | x64      |
| Dcexec.exe                                   | 2017.140.3076.1 | 74520     | 13-Mar-19 | 06:19 | x64      |
| Fssres.dll                                   | 2017.140.3076.1 | 89672     | 13-Mar-19 | 06:20 | x64      |
| Hadrres.dll                                  | 2017.140.3076.1 | 187976    | 13-Mar-19 | 06:20 | x64      |
| Hkcompile.dll                                | 2017.140.3076.1 | 1422920   | 13-Mar-19 | 06:20 | x64      |
| Hkengine.dll                                 | 2017.140.3076.1 | 5858376   | 13-Mar-19 | 06:20 | x64      |
| Hkruntime.dll                                | 2017.140.3076.1 | 162888    | 13-Mar-19 | 06:20 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 13-Mar-19 | 06:16 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.245.1      | 741144    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 13-Mar-19 | 06:47 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3076.1     | 236104    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3076.1     | 79432     | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3076.1 | 72264     | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3076.1 | 65096     | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3076.1 | 152136    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3076.1 | 159512    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3076.1 | 303688    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3076.1 | 74824     | 13-Mar-19 | 06:19 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 13-Mar-19 | 06:16 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 13-Mar-19 | 06:16 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 13-Mar-19 | 06:16 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 13-Mar-19 | 06:16 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 13-Mar-19 | 06:16 | x64      |
| Odsole70.dll                                 | 2017.140.3076.1 | 92952     | 13-Mar-19 | 06:20 | x64      |
| Opends60.dll                                 | 2017.140.3076.1 | 32840     | 13-Mar-19 | 06:20 | x64      |
| Qds.dll                                      | 2017.140.3076.1 | 1174296   | 13-Mar-19 | 06:22 | x64      |
| Rsfxft.dll                                   | 2017.140.3076.1 | 34376     | 13-Mar-19 | 06:20 | x64      |
| Secforwarder.dll                             | 2017.140.3076.1 | 37448     | 13-Mar-19 | 06:22 | x64      |
| Sqagtres.dll                                 | 2017.140.3076.1 | 74520     | 13-Mar-19 | 06:22 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlaamss.dll                                 | 2017.140.3076.1 | 90184     | 13-Mar-19 | 06:20 | x64      |
| Sqlaccess.dll                                | 2017.140.3076.1 | 475720    | 13-Mar-19 | 06:22 | x64      |
| Sqlagent.exe                                 | 2017.140.3076.1 | 582448    | 13-Mar-19 | 06:20 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3076.1 | 62024     | 13-Mar-19 | 06:20 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3076.1 | 52808     | 13-Mar-19 | 06:51 | x86      |
| Sqlagentlog.dll                              | 2017.140.3076.1 | 32840     | 13-Mar-19 | 06:20 | x64      |
| Sqlagentmail.dll                             | 2017.140.3076.1 | 53832     | 13-Mar-19 | 06:20 | x64      |
| Sqlboot.dll                                  | 2017.140.3076.1 | 196168    | 13-Mar-19 | 06:22 | x64      |
| Sqlceip.exe                                  | 14.0.3076.1     | 258120    | 13-Mar-19 | 06:47 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3076.1 | 72776     | 13-Mar-19 | 06:20 | x64      |
| Sqlctr140.dll                                | 2017.140.3076.1 | 129096    | 13-Mar-19 | 06:22 | x64      |
| Sqlctr140.dll                                | 2017.140.3076.1 | 112200    | 13-Mar-19 | 06:51 | x86      |
| Sqldk.dll                                    | 2017.140.3076.1 | 2799688   | 13-Mar-19 | 06:20 | x64      |
| Sqldtsss.dll                                 | 2017.140.3076.1 | 107592    | 13-Mar-19 | 06:20 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3915336   | 13-Mar-19 | 06:15 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3339336   | 13-Mar-19 | 06:16 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 2090568   | 13-Mar-19 | 06:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 2037016   | 13-Mar-19 | 06:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 1445656   | 13-Mar-19 | 06:26 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3780168   | 13-Mar-19 | 06:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3403336   | 13-Mar-19 | 06:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3482392   | 13-Mar-19 | 06:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3214616   | 13-Mar-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3785800   | 13-Mar-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3918616   | 13-Mar-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3636808   | 13-Mar-19 | 06:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3677768   | 13-Mar-19 | 06:38 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3787848   | 13-Mar-19 | 06:39 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 1498184   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3368240   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3589400   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 4027464   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3291720   | 13-Mar-19 | 06:44 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3297864   | 13-Mar-19 | 06:46 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3821848   | 13-Mar-19 | 06:46 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3076.1 | 3597384   | 13-Mar-19 | 06:48 | x64      |
| Sqliosim.com                                 | 2017.140.3076.1 | 313624    | 13-Mar-19 | 06:22 | x64      |
| Sqliosim.exe                                 | 2017.140.3076.1 | 3020056   | 13-Mar-19 | 06:22 | x64      |
| Sqllang.dll                                  | 2017.140.3076.1 | 41264944  | 13-Mar-19 | 06:22 | x64      |
| Sqlmin.dll                                   | 2017.140.3076.1 | 40487704  | 13-Mar-19 | 06:22 | x64      |
| Sqlolapss.dll                                | 2017.140.3076.1 | 107800    | 13-Mar-19 | 06:20 | x64      |
| Sqlos.dll                                    | 2017.140.3076.1 | 26184     | 13-Mar-19 | 06:20 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3076.1 | 68168     | 13-Mar-19 | 06:20 | x64      |
| Sqlrepss.dll                                 | 2017.140.3076.1 | 64816     | 13-Mar-19 | 06:20 | x64      |
| Sqlresld.dll                                 | 2017.140.3076.1 | 31000     | 13-Mar-19 | 06:20 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3076.1 | 32536     | 13-Mar-19 | 06:20 | x64      |
| Sqlscm.dll                                   | 2017.140.3076.1 | 71448     | 13-Mar-19 | 06:20 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3076.1 | 27712     | 13-Mar-19 | 06:22 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3076.1 | 5874456   | 13-Mar-19 | 06:22 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3076.1 | 732952    | 13-Mar-19 | 06:20 | x64      |
| Sqlservr.exe                                 | 2017.140.3076.1 | 487704    | 13-Mar-19 | 06:22 | x64      |
| Sqlsvc.dll                                   | 2017.140.3076.1 | 162096    | 13-Mar-19 | 06:20 | x64      |
| Sqltses.dll                                  | 2017.140.3076.1 | 9564744   | 13-Mar-19 | 06:20 | x64      |
| Sqsrvres.dll                                 | 2017.140.3076.1 | 261192    | 13-Mar-19 | 06:22 | x64      |
| Svl.dll                                      | 2017.140.3076.1 | 153672    | 13-Mar-19 | 06:22 | x64      |
| Xe.dll                                       | 2017.140.3076.1 | 673352    | 13-Mar-19 | 06:22 | x64      |
| Xmlrw.dll                                    | 2017.140.3076.1 | 305224    | 13-Mar-19 | 06:22 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3076.1 | 224328    | 13-Mar-19 | 06:22 | x64      |
| Xpadsi.exe                                   | 2017.140.3076.1 | 89880     | 13-Mar-19 | 06:20 | x64      |
| Xplog70.dll                                  | 2017.140.3076.1 | 75840     | 13-Mar-19 | 06:22 | x64      |
| Xpqueue.dll                                  | 2017.140.3076.1 | 74824     | 13-Mar-19 | 06:22 | x64      |
| Xprepl.dll                                   | 2017.140.3076.1 | 101960    | 13-Mar-19 | 06:22 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3076.1 | 32328     | 13-Mar-19 | 06:22 | x64      |
| Xpstar.dll                                   | 2017.140.3076.1 | 438344    | 13-Mar-19 | 06:20 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3076.1 | 180808    | 13-Mar-19 | 06:19 | x64      |
| Batchparser.dll                                             | 2017.140.3076.1 | 160328    | 13-Mar-19 | 06:50 | x86      |
| Bcp.exe                                                     | 2017.140.3076.1 | 120088    | 13-Mar-19 | 06:20 | x64      |
| Commanddest.dll                                             | 2017.140.3076.1 | 245832    | 13-Mar-19 | 06:19 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3076.1 | 116296    | 13-Mar-19 | 06:19 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3076.1 | 187464    | 13-Mar-19 | 06:19 | x64      |
| Distrib.exe                                                 | 2017.140.3076.1 | 203544    | 13-Mar-19 | 06:20 | x64      |
| Dteparse.dll                                                | 2017.140.3076.1 | 111176    | 13-Mar-19 | 06:19 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dtepkg.dll                                                  | 2017.140.3076.1 | 137800    | 13-Mar-19 | 06:19 | x64      |
| Dtexec.exe                                                  | 2017.140.3076.1 | 73800     | 13-Mar-19 | 06:19 | x64      |
| Dts.dll                                                     | 2017.140.3076.1 | 2998856   | 13-Mar-19 | 06:19 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3076.1 | 475208    | 13-Mar-19 | 06:19 | x64      |
| Dtsconn.dll                                                 | 2017.140.3076.1 | 497224    | 13-Mar-19 | 06:19 | x64      |
| Dtshost.exe                                                 | 2017.140.3076.1 | 104520    | 13-Mar-19 | 06:20 | x64      |
| Dtslog.dll                                                  | 2017.140.3076.1 | 120392    | 13-Mar-19 | 06:19 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3076.1 | 545352    | 13-Mar-19 | 06:20 | x64      |
| Dtspipeline.dll                                             | 2017.140.3076.1 | 1266248   | 13-Mar-19 | 06:19 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3076.1 | 48408     | 13-Mar-19 | 06:19 | x64      |
| Dtuparse.dll                                                | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dtutil.exe                                                  | 2017.140.3076.1 | 147016    | 13-Mar-19 | 06:19 | x64      |
| Exceldest.dll                                               | 2017.140.3076.1 | 260680    | 13-Mar-19 | 06:19 | x64      |
| Excelsrc.dll                                                | 2017.140.3076.1 | 282696    | 13-Mar-19 | 06:19 | x64      |
| Execpackagetask.dll                                         | 2017.140.3076.1 | 168008    | 13-Mar-19 | 06:19 | x64      |
| Flatfiledest.dll                                            | 2017.140.3076.1 | 386632    | 13-Mar-19 | 06:19 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3076.1 | 398920    | 13-Mar-19 | 06:19 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3076.1 | 96328     | 13-Mar-19 | 06:19 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3076.1 | 59672     | 13-Mar-19 | 06:20 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 13-Mar-19 | 06:16 | x86      |
| Logread.exe                                                 | 2017.140.3076.1 | 634952    | 13-Mar-19 | 06:20 | x64      |
| Mergetxt.dll                                                | 2017.140.3076.1 | 63768     | 13-Mar-19 | 06:20 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.245.1      | 1381448   | 13-Mar-19 | 06:19 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 13-Mar-19 | 06:16 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3076.1     | 137800    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3076.1     | 89672     | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3076.1     | 613960    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3076.1 | 1663560   | 13-Mar-19 | 06:20 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3076.1 | 152136    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3076.1 | 159512    | 13-Mar-19 | 06:19 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3076.1 | 102984    | 13-Mar-19 | 06:19 | x64      |
| Msgprox.dll                                                 | 2017.140.3076.1 | 270408    | 13-Mar-19 | 06:20 | x64      |
| Msxmlsql.dll                                                | 2017.140.3076.1 | 1448008   | 13-Mar-19 | 06:20 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 13-Mar-19 | 06:16 | x86      |
| Oledbdest.dll                                               | 2017.140.3076.1 | 261192    | 13-Mar-19 | 06:19 | x64      |
| Oledbsrc.dll                                                | 2017.140.3076.1 | 288840    | 13-Mar-19 | 06:19 | x64      |
| Osql.exe                                                    | 2017.140.3076.1 | 75336     | 13-Mar-19 | 06:19 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3076.1 | 474184    | 13-Mar-19 | 06:22 | x64      |
| Rawdest.dll                                                 | 2017.140.3076.1 | 206408    | 13-Mar-19 | 06:20 | x64      |
| Rawsource.dll                                               | 2017.140.3076.1 | 194120    | 13-Mar-19 | 06:20 | x64      |
| Rdistcom.dll                                                | 2017.140.3076.1 | 857880    | 13-Mar-19 | 06:22 | x64      |
| Recordsetdest.dll                                           | 2017.140.3076.1 | 184392    | 13-Mar-19 | 06:20 | x64      |
| Replagnt.dll                                                | 2017.140.3076.1 | 30792     | 13-Mar-19 | 06:22 | x64      |
| Repldp.dll                                                  | 2017.140.3076.1 | 291096    | 13-Mar-19 | 06:22 | x64      |
| Replerrx.dll                                                | 2017.140.3076.1 | 154392    | 13-Mar-19 | 06:22 | x64      |
| Replisapi.dll                                               | 2017.140.3076.1 | 362264    | 13-Mar-19 | 06:22 | x64      |
| Replmerg.exe                                                | 2017.140.3076.1 | 525104    | 13-Mar-19 | 06:22 | x64      |
| Replprov.dll                                                | 2017.140.3076.1 | 802584    | 13-Mar-19 | 06:22 | x64      |
| Replrec.dll                                                 | 2017.140.3076.1 | 976152    | 13-Mar-19 | 06:22 | x64      |
| Replsub.dll                                                 | 2017.140.3076.1 | 445512    | 13-Mar-19 | 06:22 | x64      |
| Replsync.dll                                                | 2017.140.3076.1 | 154392    | 13-Mar-19 | 06:22 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 13-Mar-19 | 06:22 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 13-Mar-19 | 06:22 | x64      |
| Spresolv.dll                                                | 2017.140.3076.1 | 252184    | 13-Mar-19 | 06:22 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3076.1 | 248904    | 13-Mar-19 | 06:22 | x64      |
| Sqldiag.exe                                                 | 2017.140.3076.1 | 1257752   | 13-Mar-19 | 06:22 | x64      |
| Sqldistx.dll                                                | 2017.140.3076.1 | 225560    | 13-Mar-19 | 06:22 | x64      |
| Sqllogship.exe                                              | 14.0.3076.1     | 105776    | 13-Mar-19 | 06:20 | x64      |
| Sqlmergx.dll                                                | 2017.140.3076.1 | 360520    | 13-Mar-19 | 06:22 | x64      |
| Sqlresld.dll                                                | 2017.140.3076.1 | 31000     | 13-Mar-19 | 06:20 | x64      |
| Sqlresld.dll                                                | 2017.140.3076.1 | 28744     | 13-Mar-19 | 06:51 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3076.1 | 32536     | 13-Mar-19 | 06:20 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3076.1 | 29256     | 13-Mar-19 | 06:51 | x86      |
| Sqlscm.dll                                                  | 2017.140.3076.1 | 71448     | 13-Mar-19 | 06:20 | x64      |
| Sqlscm.dll                                                  | 2017.140.3076.1 | 61000     | 13-Mar-19 | 06:51 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3076.1 | 162096    | 13-Mar-19 | 06:20 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3076.1 | 134936    | 13-Mar-19 | 06:51 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3076.1 | 183880    | 13-Mar-19 | 06:20 | x64      |
| Sqlwep140.dll                                               | 2017.140.3076.1 | 105752    | 13-Mar-19 | 06:22 | x64      |
| Ssdebugps.dll                                               | 2017.140.3076.1 | 33560     | 13-Mar-19 | 06:22 | x64      |
| Ssisoledb.dll                                               | 2017.140.3076.1 | 216136    | 13-Mar-19 | 06:20 | x64      |
| Ssradd.dll                                                  | 2017.140.3076.1 | 75544     | 13-Mar-19 | 06:22 | x64      |
| Ssravg.dll                                                  | 2017.140.3076.1 | 76056     | 13-Mar-19 | 06:22 | x64      |
| Ssrdown.dll                                                 | 2017.140.3076.1 | 61208     | 13-Mar-19 | 06:22 | x64      |
| Ssrmax.dll                                                  | 2017.140.3076.1 | 74008     | 13-Mar-19 | 06:22 | x64      |
| Ssrmin.dll                                                  | 2017.140.3076.1 | 74520     | 13-Mar-19 | 06:22 | x64      |
| Ssrpub.dll                                                  | 2017.140.3076.1 | 61720     | 13-Mar-19 | 06:22 | x64      |
| Ssrup.dll                                                   | 2017.140.3076.1 | 61216     | 13-Mar-19 | 06:22 | x64      |
| Txagg.dll                                                   | 2017.140.3076.1 | 362056    | 13-Mar-19 | 06:20 | x64      |
| Txbdd.dll                                                   | 2017.140.3076.1 | 170056    | 13-Mar-19 | 06:20 | x64      |
| Txdatacollector.dll                                         | 2017.140.3076.1 | 360736    | 13-Mar-19 | 06:20 | x64      |
| Txdataconvert.dll                                           | 2017.140.3076.1 | 293144    | 13-Mar-19 | 06:20 | x64      |
| Txderived.dll                                               | 2017.140.3076.1 | 604232    | 13-Mar-19 | 06:20 | x64      |
| Txlookup.dll                                                | 2017.140.3076.1 | 527936    | 13-Mar-19 | 06:20 | x64      |
| Txmerge.dll                                                 | 2017.140.3076.1 | 229960    | 13-Mar-19 | 06:20 | x64      |
| Txmergejoin.dll                                             | 2017.140.3076.1 | 275528    | 13-Mar-19 | 06:20 | x64      |
| Txmulticast.dll                                             | 2017.140.3076.1 | 127560    | 13-Mar-19 | 06:20 | x64      |
| Txrowcount.dll                                              | 2017.140.3076.1 | 125512    | 13-Mar-19 | 06:20 | x64      |
| Txsort.dll                                                  | 2017.140.3076.1 | 256584    | 13-Mar-19 | 06:20 | x64      |
| Txsplit.dll                                                 | 2017.140.3076.1 | 596760    | 13-Mar-19 | 06:20 | x64      |
| Txunionall.dll                                              | 2017.140.3076.1 | 181832    | 13-Mar-19 | 06:20 | x64      |
| Xe.dll                                                      | 2017.140.3076.1 | 673352    | 13-Mar-19 | 06:22 | x64      |
| Xmlrw.dll                                                   | 2017.140.3076.1 | 305224    | 13-Mar-19 | 06:22 | x64      |
| Xmlsub.dll                                                  | 2017.140.3076.1 | 261400    | 13-Mar-19 | 06:22 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3076.1 | 1125168   | 13-Mar-19 | 06:20 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlsatellite.dll              | 2017.140.3076.1 | 922184    | 13-Mar-19 | 06:22 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3076.1 | 667416    | 13-Mar-19 | 06:20 | x64      |
| Fdhost.exe               | 2017.140.3076.1 | 114760    | 13-Mar-19 | 06:20 | x64      |
| Fdlauncher.exe           | 2017.140.3076.1 | 62744     | 13-Mar-19 | 06:20 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 13-Mar-19 | 06:20 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlft140ph.dll           | 2017.140.3076.1 | 68168     | 13-Mar-19 | 06:22 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3076.1     | 23856     | 13-Mar-19 | 06:19 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 13-Mar-19 | 06:19 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70        | 75248     | 13-Mar-19 | 06:50 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 13-Mar-19 | 06:19 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70        | 36336     | 13-Mar-19 | 06:50 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 13-Mar-19 | 06:19 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70        | 76272     | 13-Mar-19 | 06:50 | x86      |
| Commanddest.dll                                               | 2017.140.3076.1 | 245832    | 13-Mar-19 | 06:19 | x64      |
| Commanddest.dll                                               | 2017.140.3076.1 | 200984    | 13-Mar-19 | 06:50 | x86      |
| Dteparse.dll                                                  | 2017.140.3076.1 | 111176    | 13-Mar-19 | 06:19 | x64      |
| Dteparse.dll                                                  | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:50 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3076.1 | 83736     | 13-Mar-19 | 06:50 | x86      |
| Dtepkg.dll                                                    | 2017.140.3076.1 | 137800    | 13-Mar-19 | 06:19 | x64      |
| Dtepkg.dll                                                    | 2017.140.3076.1 | 117016    | 13-Mar-19 | 06:50 | x86      |
| Dtexec.exe                                                    | 2017.140.3076.1 | 73800     | 13-Mar-19 | 06:19 | x64      |
| Dtexec.exe                                                    | 2017.140.3076.1 | 67656     | 13-Mar-19 | 06:50 | x86      |
| Dts.dll                                                       | 2017.140.3076.1 | 2998856   | 13-Mar-19 | 06:19 | x64      |
| Dts.dll                                                       | 2017.140.3076.1 | 2549320   | 13-Mar-19 | 06:50 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3076.1 | 475208    | 13-Mar-19 | 06:19 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3076.1 | 417864    | 13-Mar-19 | 06:50 | x86      |
| Dtsconn.dll                                                   | 2017.140.3076.1 | 497224    | 13-Mar-19 | 06:19 | x64      |
| Dtsconn.dll                                                   | 2017.140.3076.1 | 399432    | 13-Mar-19 | 06:50 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3076.1 | 111176    | 13-Mar-19 | 06:19 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3076.1 | 95304     | 13-Mar-19 | 06:50 | x86      |
| Dtshost.exe                                                   | 2017.140.3076.1 | 104520    | 13-Mar-19 | 06:20 | x64      |
| Dtshost.exe                                                   | 2017.140.3076.1 | 89672     | 13-Mar-19 | 06:51 | x86      |
| Dtslog.dll                                                    | 2017.140.3076.1 | 120392    | 13-Mar-19 | 06:19 | x64      |
| Dtslog.dll                                                    | 2017.140.3076.1 | 102984    | 13-Mar-19 | 06:50 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3076.1 | 545352    | 13-Mar-19 | 06:20 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3076.1 | 541256    | 13-Mar-19 | 06:51 | x86      |
| Dtspipeline.dll                                               | 2017.140.3076.1 | 1266248   | 13-Mar-19 | 06:19 | x64      |
| Dtspipeline.dll                                               | 2017.140.3076.1 | 1059400   | 13-Mar-19 | 06:50 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3076.1 | 48408     | 13-Mar-19 | 06:19 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3076.1 | 42800     | 13-Mar-19 | 06:50 | x86      |
| Dtuparse.dll                                                  | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dtuparse.dll                                                  | 2017.140.3076.1 | 79944     | 13-Mar-19 | 06:50 | x86      |
| Dtutil.exe                                                    | 2017.140.3076.1 | 147016    | 13-Mar-19 | 06:19 | x64      |
| Dtutil.exe                                                    | 2017.140.3076.1 | 126024    | 13-Mar-19 | 06:50 | x86      |
| Exceldest.dll                                                 | 2017.140.3076.1 | 260680    | 13-Mar-19 | 06:19 | x64      |
| Exceldest.dll                                                 | 2017.140.3076.1 | 214600    | 13-Mar-19 | 06:50 | x86      |
| Excelsrc.dll                                                  | 2017.140.3076.1 | 282696    | 13-Mar-19 | 06:19 | x64      |
| Excelsrc.dll                                                  | 2017.140.3076.1 | 230472    | 13-Mar-19 | 06:50 | x86      |
| Execpackagetask.dll                                           | 2017.140.3076.1 | 168008    | 13-Mar-19 | 06:19 | x64      |
| Execpackagetask.dll                                           | 2017.140.3076.1 | 135240    | 13-Mar-19 | 06:50 | x86      |
| Flatfiledest.dll                                              | 2017.140.3076.1 | 386632    | 13-Mar-19 | 06:19 | x64      |
| Flatfiledest.dll                                              | 2017.140.3076.1 | 332872    | 13-Mar-19 | 06:50 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3076.1 | 398920    | 13-Mar-19 | 06:19 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3076.1 | 344136    | 13-Mar-19 | 06:50 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3076.1 | 96328     | 13-Mar-19 | 06:19 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3076.1 | 80456     | 13-Mar-19 | 06:50 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 13-Mar-19 | 06:16 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 13-Mar-19 | 06:49 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3076.1     | 466504    | 13-Mar-19 | 06:19 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3076.1     | 467224    | 13-Mar-19 | 06:50 | x86      |
| Isserverexec.exe                                              | 14.0.3076.1     | 148760    | 13-Mar-19 | 06:19 | x64      |
| Isserverexec.exe                                              | 14.0.3076.1     | 149064    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.245.1      | 1381448   | 13-Mar-19 | 06:19 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.245.1      | 1381664   | 13-Mar-19 | 06:50 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 13-Mar-19 | 06:47 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 13-Mar-19 | 06:16 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 13-Mar-19 | 06:49 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3076.1     | 72776     | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3076.1 | 112408    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3076.1 | 107080    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3076.1     | 89672     | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3076.1     | 89672     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3076.1     | 494872    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3076.1     | 494872    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3076.1     | 83528     | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3076.1     | 83528     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3076.1     | 416024    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3076.1     | 416024    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3076.1     | 613960    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3076.1     | 613960    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3076.1     | 252696    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3076.1     | 252720    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3076.1 | 152136    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3076.1 | 142104    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3076.1 | 159512    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3076.1 | 145688    | 13-Mar-19 | 06:50 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3076.1     | 219720    | 13-Mar-19 | 06:19 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3076.1 | 102984    | 13-Mar-19 | 06:19 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3076.1 | 90184     | 13-Mar-19 | 06:50 | x86      |
| Msmdpp.dll                                                    | 2017.140.245.1  | 9194264   | 13-Mar-19 | 06:20 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 13-Mar-19 | 06:16 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 13-Mar-19 | 06:16 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 13-Mar-19 | 06:19 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 13-Mar-19 | 06:49 | x86      |
| Oledbdest.dll                                                 | 2017.140.3076.1 | 261192    | 13-Mar-19 | 06:19 | x64      |
| Oledbdest.dll                                                 | 2017.140.3076.1 | 214600    | 13-Mar-19 | 06:50 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3076.1 | 288840    | 13-Mar-19 | 06:19 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3076.1 | 233032    | 13-Mar-19 | 06:50 | x86      |
| Rawdest.dll                                                   | 2017.140.3076.1 | 206408    | 13-Mar-19 | 06:20 | x64      |
| Rawdest.dll                                                   | 2017.140.3076.1 | 166472    | 13-Mar-19 | 06:51 | x86      |
| Rawsource.dll                                                 | 2017.140.3076.1 | 194120    | 13-Mar-19 | 06:20 | x64      |
| Rawsource.dll                                                 | 2017.140.3076.1 | 153160    | 13-Mar-19 | 06:51 | x86      |
| Recordsetdest.dll                                             | 2017.140.3076.1 | 184392    | 13-Mar-19 | 06:20 | x64      |
| Recordsetdest.dll                                             | 2017.140.3076.1 | 149064    | 13-Mar-19 | 06:51 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlceip.exe                                                   | 14.0.3076.1     | 258120    | 13-Mar-19 | 06:47 | x86      |
| Sqldest.dll                                                   | 2017.140.3076.1 | 260680    | 13-Mar-19 | 06:20 | x64      |
| Sqldest.dll                                                   | 2017.140.3076.1 | 213576    | 13-Mar-19 | 06:51 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3076.1 | 183880    | 13-Mar-19 | 06:20 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3076.1 | 155208    | 13-Mar-19 | 06:51 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3076.1 | 216136    | 13-Mar-19 | 06:20 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3076.1 | 176920    | 13-Mar-19 | 06:51 | x86      |
| Txagg.dll                                                     | 2017.140.3076.1 | 362056    | 13-Mar-19 | 06:20 | x64      |
| Txagg.dll                                                     | 2017.140.3076.1 | 302152    | 13-Mar-19 | 06:51 | x86      |
| Txbdd.dll                                                     | 2017.140.3076.1 | 170056    | 13-Mar-19 | 06:20 | x64      |
| Txbdd.dll                                                     | 2017.140.3076.1 | 136264    | 13-Mar-19 | 06:51 | x86      |
| Txbestmatch.dll                                               | 2017.140.3076.1 | 605464    | 13-Mar-19 | 06:20 | x64      |
| Txbestmatch.dll                                               | 2017.140.3076.1 | 493128    | 13-Mar-19 | 06:51 | x86      |
| Txcache.dll                                                   | 2017.140.3076.1 | 180296    | 13-Mar-19 | 06:20 | x64      |
| Txcache.dll                                                   | 2017.140.3076.1 | 145992    | 13-Mar-19 | 06:51 | x86      |
| Txcharmap.dll                                                 | 2017.140.3076.1 | 286792    | 13-Mar-19 | 06:20 | x64      |
| Txcharmap.dll                                                 | 2017.140.3076.1 | 248904    | 13-Mar-19 | 06:51 | x86      |
| Txcopymap.dll                                                 | 2017.140.3076.1 | 180296    | 13-Mar-19 | 06:20 | x64      |
| Txcopymap.dll                                                 | 2017.140.3076.1 | 145712    | 13-Mar-19 | 06:51 | x86      |
| Txdataconvert.dll                                             | 2017.140.3076.1 | 293144    | 13-Mar-19 | 06:20 | x64      |
| Txdataconvert.dll                                             | 2017.140.3076.1 | 253208    | 13-Mar-19 | 06:51 | x86      |
| Txderived.dll                                                 | 2017.140.3076.1 | 604232    | 13-Mar-19 | 06:20 | x64      |
| Txderived.dll                                                 | 2017.140.3076.1 | 515872    | 13-Mar-19 | 06:51 | x86      |
| Txfileextractor.dll                                           | 2017.140.3076.1 | 198728    | 13-Mar-19 | 06:20 | x64      |
| Txfileextractor.dll                                           | 2017.140.3076.1 | 160840    | 13-Mar-19 | 06:51 | x86      |
| Txfileinserter.dll                                            | 2017.140.3076.1 | 196680    | 13-Mar-19 | 06:20 | x64      |
| Txfileinserter.dll                                            | 2017.140.3076.1 | 159304    | 13-Mar-19 | 06:51 | x86      |
| Txgroupdups.dll                                               | 2017.140.3076.1 | 290584    | 13-Mar-19 | 06:20 | x64      |
| Txgroupdups.dll                                               | 2017.140.3076.1 | 230984    | 13-Mar-19 | 06:51 | x86      |
| Txlineage.dll                                                 | 2017.140.3076.1 | 136776    | 13-Mar-19 | 06:20 | x64      |
| Txlineage.dll                                                 | 2017.140.3076.1 | 110152    | 13-Mar-19 | 06:51 | x86      |
| Txlookup.dll                                                  | 2017.140.3076.1 | 527936    | 13-Mar-19 | 06:20 | x64      |
| Txlookup.dll                                                  | 2017.140.3076.1 | 446536    | 13-Mar-19 | 06:51 | x86      |
| Txmerge.dll                                                   | 2017.140.3076.1 | 229960    | 13-Mar-19 | 06:20 | x64      |
| Txmerge.dll                                                   | 2017.140.3076.1 | 176712    | 13-Mar-19 | 06:51 | x86      |
| Txmergejoin.dll                                               | 2017.140.3076.1 | 275528    | 13-Mar-19 | 06:20 | x64      |
| Txmergejoin.dll                                               | 2017.140.3076.1 | 221768    | 13-Mar-19 | 06:51 | x86      |
| Txmulticast.dll                                               | 2017.140.3076.1 | 127560    | 13-Mar-19 | 06:20 | x64      |
| Txmulticast.dll                                               | 2017.140.3076.1 | 102472    | 13-Mar-19 | 06:51 | x86      |
| Txpivot.dll                                                   | 2017.140.3076.1 | 224840    | 13-Mar-19 | 06:20 | x64      |
| Txpivot.dll                                                   | 2017.140.3076.1 | 180296    | 13-Mar-19 | 06:51 | x86      |
| Txrowcount.dll                                                | 2017.140.3076.1 | 125512    | 13-Mar-19 | 06:20 | x64      |
| Txrowcount.dll                                                | 2017.140.3076.1 | 101656    | 13-Mar-19 | 06:51 | x86      |
| Txsampling.dll                                                | 2017.140.3076.1 | 172616    | 13-Mar-19 | 06:20 | x64      |
| Txsampling.dll                                                | 2017.140.3076.1 | 135752    | 13-Mar-19 | 06:51 | x86      |
| Txscd.dll                                                     | 2017.140.3076.1 | 220744    | 13-Mar-19 | 06:20 | x64      |
| Txscd.dll                                                     | 2017.140.3076.1 | 170056    | 13-Mar-19 | 06:51 | x86      |
| Txsort.dll                                                    | 2017.140.3076.1 | 256584    | 13-Mar-19 | 06:20 | x64      |
| Txsort.dll                                                    | 2017.140.3076.1 | 207944    | 13-Mar-19 | 06:51 | x86      |
| Txsplit.dll                                                   | 2017.140.3076.1 | 596760    | 13-Mar-19 | 06:20 | x64      |
| Txsplit.dll                                                   | 2017.140.3076.1 | 510744    | 13-Mar-19 | 06:51 | x86      |
| Txtermextraction.dll                                          | 2017.140.3076.1 | 8676424   | 13-Mar-19 | 06:20 | x64      |
| Txtermextraction.dll                                          | 2017.140.3076.1 | 8614984   | 13-Mar-19 | 06:51 | x86      |
| Txtermlookup.dll                                              | 2017.140.3076.1 | 4157208   | 13-Mar-19 | 06:20 | x64      |
| Txtermlookup.dll                                              | 2017.140.3076.1 | 4107032   | 13-Mar-19 | 06:51 | x86      |
| Txunionall.dll                                                | 2017.140.3076.1 | 181832    | 13-Mar-19 | 06:20 | x64      |
| Txunionall.dll                                                | 2017.140.3076.1 | 139336    | 13-Mar-19 | 06:51 | x86      |
| Txunpivot.dll                                                 | 2017.140.3076.1 | 199752    | 13-Mar-19 | 06:20 | x64      |
| Txunpivot.dll                                                 | 2017.140.3076.1 | 160328    | 13-Mar-19 | 06:51 | x86      |
| Xe.dll                                                        | 2017.140.3076.1 | 673352    | 13-Mar-19 | 06:22 | x64      |
| Xe.dll                                                        | 2017.140.3076.1 | 595528    | 13-Mar-19 | 06:51 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.20     | 523856    | 13-Mar-19 | 06:22 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.20 | 78624     | 13-Mar-19 | 06:22 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.20     | 45648     | 13-Mar-19 | 06:22 | x86      |
| Instapi140.dll                                                       | 2017.140.3076.1  | 70728     | 13-Mar-19 | 06:22 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.20     | 74832     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.20     | 213584    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.20     | 1799248   | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.20     | 116816    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.20     | 390224    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.20     | 196176    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.20     | 131152    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.20     | 63056     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.20     | 55376     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.20     | 93776     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.20     | 792656    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.20     | 87632     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.20     | 77904     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.20     | 42064     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.20     | 36944     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.20     | 47696     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.20     | 27216     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.20     | 32336     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.20     | 129616    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.20     | 95312     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.20     | 109136    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.20     | 264272    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 105040    | 13-Mar-19 | 06:16 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 119376    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 122448    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 118864    | 13-Mar-19 | 06:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 129104    | 13-Mar-19 | 06:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 121424    | 13-Mar-19 | 06:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 116304    | 13-Mar-19 | 06:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 149584    | 13-Mar-19 | 06:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 102992    | 13-Mar-19 | 06:35 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.20     | 118352    | 13-Mar-19 | 06:27 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.20     | 70224     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.20     | 28752     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.20     | 43600     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.20     | 83536     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.20     | 136784    | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.20     | 2340944   | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.20     | 3860048   | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 110672    | 13-Mar-19 | 06:16 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 123472    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 128080    | 13-Mar-19 | 06:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 123984    | 13-Mar-19 | 06:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 136784    | 13-Mar-19 | 06:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 124496    | 13-Mar-19 | 06:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 121424    | 13-Mar-19 | 06:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 156240    | 13-Mar-19 | 06:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 108624    | 13-Mar-19 | 06:35 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.20     | 122960    | 13-Mar-19 | 06:27 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.20     | 70224     | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.20     | 2756176   | 13-Mar-19 | 06:22 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.20     | 751696    | 13-Mar-19 | 06:22 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3076.1  | 407112    | 13-Mar-19 | 06:22 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3076.1  | 7325768   | 13-Mar-19 | 06:22 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3076.1  | 2263344   | 13-Mar-19 | 06:22 | x64      |
| Secforwarder.dll                                                     | 2017.140.3076.1  | 37448     | 13-Mar-19 | 06:22 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.20 | 64824     | 13-Mar-19 | 06:22 | x64      |
| Sqldk.dll                                                            | 2017.140.3076.1  | 2733336   | 13-Mar-19 | 06:22 | x64      |
| Sqldumper.exe                                                        | 2017.140.3076.1  | 144152    | 13-Mar-19 | 06:22 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 1498184   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3915336   | 13-Mar-19 | 06:15 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3214616   | 13-Mar-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3918616   | 13-Mar-19 | 06:33 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3821848   | 13-Mar-19 | 06:46 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 2090568   | 13-Mar-19 | 06:17 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 2037016   | 13-Mar-19 | 06:17 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3589400   | 13-Mar-19 | 06:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3597384   | 13-Mar-19 | 06:48 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 1445656   | 13-Mar-19 | 06:26 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3076.1  | 3785800   | 13-Mar-19 | 06:33 | x64      |
| Sqlos.dll                                                            | 2017.140.3076.1  | 26184     | 13-Mar-19 | 06:22 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.20 | 4348192   | 13-Mar-19 | 06:22 | x64      |
| Sqltses.dll                                                          | 2017.140.3076.1  | 9734936   | 13-Mar-19 | 06:22 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3076.1     | 23624     | 13-Mar-19 | 06:20 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3076.1 | 1448728   | 13-Mar-19 | 06:51 | x86      |
| Dtaengine.exe                                          | 2017.140.3076.1 | 204568    | 13-Mar-19 | 06:50 | x86      |
| Dteparse.dll                                           | 2017.140.3076.1 | 111176    | 13-Mar-19 | 06:19 | x64      |
| Dteparse.dll                                           | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:50 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3076.1 | 83736     | 13-Mar-19 | 06:50 | x86      |
| Dtepkg.dll                                             | 2017.140.3076.1 | 137800    | 13-Mar-19 | 06:19 | x64      |
| Dtepkg.dll                                             | 2017.140.3076.1 | 117016    | 13-Mar-19 | 06:50 | x86      |
| Dtexec.exe                                             | 2017.140.3076.1 | 73800     | 13-Mar-19 | 06:19 | x64      |
| Dtexec.exe                                             | 2017.140.3076.1 | 67656     | 13-Mar-19 | 06:50 | x86      |
| Dts.dll                                                | 2017.140.3076.1 | 2998856   | 13-Mar-19 | 06:19 | x64      |
| Dts.dll                                                | 2017.140.3076.1 | 2549320   | 13-Mar-19 | 06:50 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3076.1 | 475208    | 13-Mar-19 | 06:19 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3076.1 | 417864    | 13-Mar-19 | 06:50 | x86      |
| Dtsconn.dll                                            | 2017.140.3076.1 | 497224    | 13-Mar-19 | 06:19 | x64      |
| Dtsconn.dll                                            | 2017.140.3076.1 | 399432    | 13-Mar-19 | 06:50 | x86      |
| Dtshost.exe                                            | 2017.140.3076.1 | 104520    | 13-Mar-19 | 06:20 | x64      |
| Dtshost.exe                                            | 2017.140.3076.1 | 89672     | 13-Mar-19 | 06:51 | x86      |
| Dtslog.dll                                             | 2017.140.3076.1 | 120392    | 13-Mar-19 | 06:19 | x64      |
| Dtslog.dll                                             | 2017.140.3076.1 | 102984    | 13-Mar-19 | 06:50 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3076.1 | 545352    | 13-Mar-19 | 06:20 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3076.1 | 541256    | 13-Mar-19 | 06:51 | x86      |
| Dtspipeline.dll                                        | 2017.140.3076.1 | 1266248   | 13-Mar-19 | 06:19 | x64      |
| Dtspipeline.dll                                        | 2017.140.3076.1 | 1059400   | 13-Mar-19 | 06:50 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3076.1 | 48408     | 13-Mar-19 | 06:19 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3076.1 | 42800     | 13-Mar-19 | 06:50 | x86      |
| Dtuparse.dll                                           | 2017.140.3076.1 | 89160     | 13-Mar-19 | 06:19 | x64      |
| Dtuparse.dll                                           | 2017.140.3076.1 | 79944     | 13-Mar-19 | 06:50 | x86      |
| Dtutil.exe                                             | 2017.140.3076.1 | 147016    | 13-Mar-19 | 06:19 | x64      |
| Dtutil.exe                                             | 2017.140.3076.1 | 126024    | 13-Mar-19 | 06:50 | x86      |
| Exceldest.dll                                          | 2017.140.3076.1 | 260680    | 13-Mar-19 | 06:19 | x64      |
| Exceldest.dll                                          | 2017.140.3076.1 | 214600    | 13-Mar-19 | 06:50 | x86      |
| Excelsrc.dll                                           | 2017.140.3076.1 | 282696    | 13-Mar-19 | 06:19 | x64      |
| Excelsrc.dll                                           | 2017.140.3076.1 | 230472    | 13-Mar-19 | 06:50 | x86      |
| Flatfiledest.dll                                       | 2017.140.3076.1 | 386632    | 13-Mar-19 | 06:19 | x64      |
| Flatfiledest.dll                                       | 2017.140.3076.1 | 332872    | 13-Mar-19 | 06:50 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3076.1 | 398920    | 13-Mar-19 | 06:19 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3076.1 | 344136    | 13-Mar-19 | 06:50 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3076.1 | 96328     | 13-Mar-19 | 06:19 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3076.1 | 80456     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3076.1     | 72776     | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3076.1     | 186440    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3076.1     | 409672    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3076.1     | 409672    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3076.1     | 2093336   | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3076.1     | 2093336   | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3076.1     | 613960    | 13-Mar-19 | 06:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3076.1     | 613960    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3076.1     | 252720    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3076.1 | 152136    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3076.1 | 142104    | 13-Mar-19 | 06:50 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3076.1 | 159512    | 13-Mar-19 | 06:19 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3076.1 | 145688    | 13-Mar-19 | 06:50 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3076.1 | 102984    | 13-Mar-19 | 06:19 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3076.1 | 90184     | 13-Mar-19 | 06:50 | x86      |
| Msmgdsrv.dll                                           | 2017.140.245.1  | 7310640   | 13-Mar-19 | 06:51 | x86      |
| Oledbdest.dll                                          | 2017.140.3076.1 | 261192    | 13-Mar-19 | 06:19 | x64      |
| Oledbdest.dll                                          | 2017.140.3076.1 | 214600    | 13-Mar-19 | 06:50 | x86      |
| Oledbsrc.dll                                           | 2017.140.3076.1 | 288840    | 13-Mar-19 | 06:19 | x64      |
| Oledbsrc.dll                                           | 2017.140.3076.1 | 233032    | 13-Mar-19 | 06:50 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3076.1 | 100424    | 13-Mar-19 | 06:19 | x64      |
| Sqlresld.dll                                           | 2017.140.3076.1 | 31000     | 13-Mar-19 | 06:20 | x64      |
| Sqlresld.dll                                           | 2017.140.3076.1 | 28744     | 13-Mar-19 | 06:51 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3076.1 | 32536     | 13-Mar-19 | 06:20 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3076.1 | 29256     | 13-Mar-19 | 06:51 | x86      |
| Sqlscm.dll                                             | 2017.140.3076.1 | 71448     | 13-Mar-19 | 06:20 | x64      |
| Sqlscm.dll                                             | 2017.140.3076.1 | 61000     | 13-Mar-19 | 06:51 | x86      |
| Sqlsvc.dll                                             | 2017.140.3076.1 | 162096    | 13-Mar-19 | 06:20 | x64      |
| Sqlsvc.dll                                             | 2017.140.3076.1 | 134936    | 13-Mar-19 | 06:51 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3076.1 | 183880    | 13-Mar-19 | 06:20 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3076.1 | 155208    | 13-Mar-19 | 06:51 | x86      |
| Txdataconvert.dll                                      | 2017.140.3076.1 | 293144    | 13-Mar-19 | 06:20 | x64      |
| Txdataconvert.dll                                      | 2017.140.3076.1 | 253208    | 13-Mar-19 | 06:51 | x86      |
| Xe.dll                                                 | 2017.140.3076.1 | 673352    | 13-Mar-19 | 06:22 | x64      |
| Xe.dll                                                 | 2017.140.3076.1 | 595528    | 13-Mar-19 | 06:51 | x86      |
| Xmlrw.dll                                              | 2017.140.3076.1 | 305224    | 13-Mar-19 | 06:22 | x64      |
| Xmlrw.dll                                              | 2017.140.3076.1 | 257608    | 13-Mar-19 | 06:51 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3076.1 | 224328    | 13-Mar-19 | 06:22 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3076.1 | 189512    | 13-Mar-19 | 06:51 | x86      |

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
