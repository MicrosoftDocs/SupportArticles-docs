---
title: Cumulative update 26 for SQL Server 2017 (KB5005226)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 26 (KB5005226).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5005226, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5005226 - Cumulative Update 26 for SQL Server 2017

_Release Date:_ &nbsp; September 14, 2021  
_Version:_ &nbsp; 14.0.3411.3

## Summary

This article describes Cumulative Update package 26 (CU26) for Microsoft SQL Server 2017. This update contains 22 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 25, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3411.3**, file version: **2017.140.3411.3**
- Analysis Services - Product version: **14.0.249.83**, file version: **2017.140.249.83**

## Known issues in this update

If you use the Change Tracking feature, you might encounter errors. For more information, see [KB5007039](https://support.microsoft.com/help/5007039) before you apply this update package.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area | Component| Platform |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|----------------------------------------------|----------|
| <a id=14143953>[14143953](#14143953) </a> | Fixes the issue in SSAS 2017, where msmdsrv.log doesn't work when you customize the values of the configuration settings **MaxFileSizeMB** and **MaxNumberOfLogFiles**. | Analysis Services | Analysis Services | Windows |
| <a id=14157183>[14157183](#14157183) </a> | Fixes an issue where the DAX query with union generates an exception: </br></br>An unexpected error occurred (file 'FileName', line LineNumber, function 'FunctionName'). | Analysis Services| Analysis Services | Windows |
| <a id=13905587>[13905587](#13905587) </a> | Fixes the issue in SSIS 2017 when Dimension Processing returns clsid {ID}" could not be created and error code 0x80070005 "Access is denied.". Make sure that the component is registered correctly. </br></br>OnError: "Dimension Processing failed validation and returned error code 0x80040005"| Integration Services | Integration Services | Windows |
| <a id=14175901>[14175901](#14175901) </a> | Fixes the issue in MDS 2017, where the derived hierarchy permissions are lost in the copied version. | Master Data Services | Master Data Services | Windows |
| <a id=14149041>[14149041](#14149041) </a> | Fixes an issue where Distributed Replay Client may fail with an unhandled exception. </br></br>This fix is for the Distributed Replay Client that is released with SQL Server 2017. </br></br>The following is the error you may observe in the output/log file: </br></br>\<DateTime> OPERATIONAL[Common]Unhandled exception is encountered. [Exception Code = 3221225477]</br>\<DateTime> OPERATIONAL[Common] Invoking dump. </br>\<DateTime> OPERATIONAL[Common] Service terminating | SQL Server Client Tools | Database Performance Tools | Windows |
| <a id=14175937>[14175937](#14175937) </a> | [FIX: Cannot change the password for a SQL Server service account when additional LSA protection is enabled (KB4039592)](https://support.microsoft.com/help/4039592) |SQL Server Client Tools | SQL Server Manageability (SSM) | Windows |
| <a id=14148246>[14148246](#14148246) </a> | [FIX: Persisted computed columns not being consistently blocked for Columnstore index (KB5004734)](https://support.microsoft.com/help/5004734) | SQL Server Engine| Column Stores| All|
| <a id=14155040>[14155040](#14155040) </a> | [FIX: Error when you use columnstore indexes and run versioned scans if all rows in a compressed rowgroup are deleted in SQL Server 2017 and 2019 (KB5004936)](https://support.microsoft.com/help/5004936) | SQL Server Engine | Column Stores | All|
| <a id=14193874>[14193874](#14193874) </a> | [FIX: Access violation occurs when you use FileTable feature with Windows Defender enabled (KB5005788)](https://support.microsoft.com/help/5005788)| SQL Server Engine| FileStream and FileTable | Windows |
| <a id=14031937>[14031937](#14031937) </a> | Fixes an issue where `Last_sent_time` and `Last_received_time` columns in DMV `dm_hadr_database_replica_states` don't get updated. | SQL Server Engine|High Availability and Disaster Recovery | Windows |
| <a id=14125523>[14125523](#14125523) </a> | Adds improvement to report SQL Server native error 35217 in the `AlwaysOn_health` XEvent log: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 35217, Severity: 16, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The thread pool for Always On Availability Groups was unable to start a new worker thread because there are not enough available worker threads. This may degrade Always On Availability Groups performance. Use the "max worker threads" configuration option to increase number of allowable threads. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14123174>[14123174](#14123174) </a> | [FIX: SQL Server often crashes when network.forceencryption property is set to '1' (KB5004750)](https://support.microsoft.com/help/5004750)| SQL Server Engine | Linux | Linux |
| <a id=13952862>[13952862](#13952862) </a> | Fixes an intra-query deadlock that occurs with certain queries when verbose truncation feature is enabled.| SQL Server Engine|Methods to access stored data | Windows |
| <a id=14134263>[14134263](#14134263) </a> | Fixes an issue in SQL Server 2017 and 2019 where you may encounter an Access Violation or Assertion when using the `sys.dm_exec_query_statistics_xml` Dynamic Management View.| SQL Server Engine|Query Execution | All |
| <a id=14135181>[14135181](#14135181) </a> | Fixes an issue in SQL Server 2017 where you may encounter an Access Violation or Assertion when using the `sys.dm_exec_query_statistics_xml` Dynamic Management View.| SQL Server Engine| Query Execution| Windows |
| <a id=14200277>[14200277](#14200277) </a> | Fix to keep the `PERSIST_SAMPLE_PERCENT` value for statistics on an indexed column after index rebuild. | SQL Server Engine| Query Optimizer| Windows|
| <a id=14224387>[14224387](#14224387) </a> | [FIX: Assertion failure may occur when sp_cleanup_history_table is executed in SQL Server 2017 (KB5006029)](https://support.microsoft.com/help/5006029) | SQL Server Engine | Replication | Windows |
| <a id=14130524>[14130524](#14130524) </a> | Fixes missing data in the Change Data Capture (CDC) side table and adds additional error handling to prevent data loss. | SQL Server Engine|Replication | Windows |
| <a id=14178360>[14178360](#14178360) </a> | Adds pOwnerSess to the error message to find the owner session Id that runs the Log Reader Agent or log-related procedure in SQL Server 2017. | SQL Server Engine| Replication | Windows |
| <a id=14193531>[14193531](#14193531) </a> | Fixes the issue where datatype isn't included in the warning message instead a 'null' value appears: </br></br>Warning: Article with '(null)' data type column is not supported with memory optimized tables on subscribers running SQL Server 2014 or earlier. | SQL Server Engine | Replication | Windows |
| <a id=14164877>[14164877](#14164877) </a> | [FIX: SQL Server affinity settings are reset after applying CU for SQL Server 2017 and 2019 (KB5004573)](https://support.microsoft.com/help/5004573) | SQL Server Engine | SQL OS | Windows |
| <a id=14117711>[14117711](#14117711) </a> | [Improvement: Corrupted statistics can be detected by using extended_logical_checks in SQL Server 2017 (KB4530907)](https://support.microsoft.com/help/4530907) | SQL Server Engine | Storage Management | Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU26 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2021/09/sqlserver2017-kb5005226-x64_e31b28ba9c4c0b63ddbb356f630e8ea631da97fe.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5005226-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5005226-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5005226-x64.exe| 7B48B534BC874ACD7D6B6E58646487EBFB6B354BCCBFF758BAFBA8807C477E8B |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.83 | 259464    | 24-Aug-21 | 20:59 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.83     | 735112    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.83     | 1374088   | 24-Aug-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.83     | 977304    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.83     | 514960    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 24-Aug-21 | 20:55 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 24-Aug-21 | 20:53 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 24-Aug-21 | 20:53 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 24-Aug-21 | 20:53 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 24-Aug-21 | 20:53 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 24-Aug-21 | 20:53 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 24-Aug-21 | 20:53 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 24-Aug-21 | 20:53 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 24-Aug-21 | 20:53 | x86      |
| Msmdctr.dll                                        | 2017.140.249.83 | 33168     | 24-Aug-21 | 21:00 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.83 | 40420256  | 24-Aug-21 | 20:58 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.83 | 60766096  | 24-Aug-21 | 21:00 | x64      |
| Msmdpump.dll                                       | 2017.140.249.83 | 9333136   | 24-Aug-21 | 21:00 | x64      |
| Msmdredir.dll                                      | 2017.140.249.83 | 7088544   | 24-Aug-21 | 20:58 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.83 | 60667776  | 24-Aug-21 | 21:00 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.83 | 7305096   | 24-Aug-21 | 20:58 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.83 | 9000856   | 24-Aug-21 | 21:00 | x64      |
| Msolap.dll                                         | 2017.140.249.83 | 7772568   | 24-Aug-21 | 20:58 | x86      |
| Msolap.dll                                         | 2017.140.249.83 | 10256784  | 24-Aug-21 | 21:00 | x64      |
| Msolui.dll                                         | 2017.140.249.83 | 280448    | 24-Aug-21 | 20:58 | x86      |
| Msolui.dll                                         | 2017.140.249.83 | 304016    | 24-Aug-21 | 21:00 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 24-Aug-21 | 20:53 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 24-Aug-21 | 20:53 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlboot.dll                                        | 2017.140.3411.3 | 190864    | 24-Aug-21 | 21:01 | x64      |
| Sqlceip.exe                                        | 14.0.3411.3     | 268176    | 24-Aug-21 | 20:55 | x86      |
| Sqldumper.exe                                      | 2017.140.3411.3 | 116096    | 24-Aug-21 | 20:55 | x86      |
| Sqldumper.exe                                      | 2017.140.3411.3 | 138624    | 24-Aug-21 | 21:08 | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 24-Aug-21 | 20:53 | x86      |
| Tmapi.dll                                          | 2017.140.249.83 | 5814656   | 24-Aug-21 | 21:01 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.83 | 4157832   | 24-Aug-21 | 21:01 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.83 | 1125256   | 24-Aug-21 | 21:01 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.83 | 1636240   | 24-Aug-21 | 21:01 | x64      |
| Xe.dll                                             | 2017.140.3411.3 | 666496    | 24-Aug-21 | 21:01 | x64      |
| Xmlrw.dll                                          | 2017.140.3411.3 | 250752    | 24-Aug-21 | 20:58 | x86      |
| Xmlrw.dll                                          | 2017.140.3411.3 | 298368    | 24-Aug-21 | 21:01 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3411.3 | 182656    | 24-Aug-21 | 20:58 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3411.3 | 217472    | 24-Aug-21 | 21:01 | x64      |
| Xmsrv.dll                                          | 2017.140.249.83 | 33349512  | 24-Aug-21 | 20:58 | x86      |
| Xmsrv.dll                                          | 2017.140.249.83 | 25376136  | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3411.3  | 153504    | 24-Aug-21 | 20:56 | x86      |
| Batchparser.dll                            | 2017.140.3411.3  | 173976    | 24-Aug-21 | 20:59 | x64      |
| Instapi140.dll                             | 2017.140.3411.3  | 55696     | 24-Aug-21 | 20:58 | x86      |
| Instapi140.dll                             | 2017.140.3411.3  | 65424     | 24-Aug-21 | 21:00 | x64      |
| Isacctchange.dll                           | 2017.140.3411.3  | 22416     | 24-Aug-21 | 20:56 | x86      |
| Isacctchange.dll                           | 2017.140.3411.3  | 23936     | 24-Aug-21 | 20:59 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.83      | 1081736   | 24-Aug-21 | 20:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.83      | 1081736   | 24-Aug-21 | 20:59 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.83      | 1374592   | 24-Aug-21 | 20:56 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.83      | 734608    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.83      | 734600    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3411.3      | 30592     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3411.3  | 71584     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3411.3  | 75152     | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3411.3      | 564624    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3411.3      | 564624    | 24-Aug-21 | 21:00 | x86      |
| Msasxpress.dll                             | 2017.140.249.83  | 24976     | 24-Aug-21 | 20:58 | x86      |
| Msasxpress.dll                             | 2017.140.249.83  | 29064     | 24-Aug-21 | 21:00 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3411.3  | 62352     | 24-Aug-21 | 20:58 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3411.3  | 77216     | 24-Aug-21 | 21:01 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3411.3  | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqldumper.exe                              | 2017.140.3411.3  | 116096    | 24-Aug-21 | 20:55 | x86      |
| Sqldumper.exe                              | 2017.140.3411.3  | 138624    | 24-Aug-21 | 21:08 | x64      |
| Sqlftacct.dll                              | 2017.140.3411.3  | 49040     | 24-Aug-21 | 20:58 | x86      |
| Sqlftacct.dll                              | 2017.140.3411.3  | 57232     | 24-Aug-21 | 21:01 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 24-Aug-21 | 20:58 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 24-Aug-21 | 21:00 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3411.3  | 368544    | 24-Aug-21 | 20:58 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3411.3  | 413072    | 24-Aug-21 | 21:00 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3411.3  | 28048     | 24-Aug-21 | 20:58 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3411.3  | 30608     | 24-Aug-21 | 21:01 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3411.3  | 267136    | 24-Aug-21 | 20:58 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3411.3  | 351104    | 24-Aug-21 | 21:01 | x64      |
| Sqltdiagn.dll                              | 2017.140.3411.3  | 53656     | 24-Aug-21 | 20:58 | x86      |
| Sqltdiagn.dll                              | 2017.140.3411.3  | 60832     | 24-Aug-21 | 21:00 | x64      |
| Svrenumapi140.dll                          | 2017.140.3411.3  | 888208    | 24-Aug-21 | 20:58 | x86      |
| Svrenumapi140.dll                          | 2017.140.3411.3  | 1167744   | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time  | Platform |
|---------------------|-----------------|-----------|-----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 24-Aug-21 | 20:58 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 24-Aug-21 | 20:58 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 24-Aug-21 | 20:58 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 24-Aug-21 | 20:58 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 24-Aug-21 | 20:59 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2017.140.3411.3 | 114064    | 24-Aug-21 | 20:56 | x86      |
| Dreplaycommon.dll              | 2017.140.3411.3 | 693136    | 24-Aug-21 | 20:56 | x86      |
| Dreplayserverps.dll            | 2017.140.3411.3 | 26016     | 24-Aug-21 | 20:56 | x86      |
| Dreplayutil.dll                | 2017.140.3411.3 | 303520    | 24-Aug-21 | 20:56 | x86      |
| Instapi140.dll                 | 2017.140.3411.3 | 65424     | 24-Aug-21 | 21:00 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlresourceloader.dll          | 2017.140.3411.3 | 22432     | 24-Aug-21 | 20:58 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3411.3 | 693136    | 24-Aug-21 | 20:56 | x86      |
| Dreplaycontroller.exe              | 2017.140.3411.3 | 343456    | 24-Aug-21 | 20:56 | x86      |
| Dreplayprocess.dll                 | 2017.140.3411.3 | 164752    | 24-Aug-21 | 20:56 | x86      |
| Dreplayserverps.dll                | 2017.140.3411.3 | 26016     | 24-Aug-21 | 20:56 | x86      |
| Instapi140.dll                     | 2017.140.3411.3 | 65424     | 24-Aug-21 | 21:00 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlresourceloader.dll              | 2017.140.3411.3 | 22432     | 24-Aug-21 | 20:58 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3411.3     | 33664     | 24-Aug-21 | 20:59 | x64      |
| Batchparser.dll                              | 2017.140.3411.3 | 173976    | 24-Aug-21 | 20:59 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 24-Aug-21 | 21:02 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 24-Aug-21 | 21:02 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 24-Aug-21 | 21:02 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 24-Aug-21 | 21:09 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 24-Aug-21 | 20:59 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3411.3 | 220560    | 24-Aug-21 | 20:59 | x64      |
| Dcexec.exe                                   | 2017.140.3411.3 | 67472     | 24-Aug-21 | 20:59 | x64      |
| Fssres.dll                                   | 2017.140.3411.3 | 83856     | 24-Aug-21 | 21:00 | x64      |
| Hadrres.dll                                  | 2017.140.3411.3 | 182672    | 24-Aug-21 | 21:00 | x64      |
| Hkcompile.dll                                | 2017.140.3411.3 | 1416064   | 24-Aug-21 | 21:00 | x64      |
| Hkengine.dll                                 | 2017.140.3411.3 | 5854624   | 24-Aug-21 | 21:00 | x64      |
| Hkruntime.dll                                | 2017.140.3411.3 | 156032    | 24-Aug-21 | 21:00 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 24-Aug-21 | 21:02 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.83     | 734080    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 24-Aug-21 | 20:55 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3411.3     | 231808    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3411.3     | 73088     | 24-Aug-21 | 20:59 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3411.3 | 385936    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3411.3 | 65440     | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3411.3 | 58256     | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3411.3 | 145296    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3411.3 | 152464    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3411.3 | 297360    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3411.3 | 67968     | 24-Aug-21 | 21:00 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 24-Aug-21 | 21:02 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 24-Aug-21 | 21:02 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 24-Aug-21 | 21:02 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 24-Aug-21 | 21:02 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 24-Aug-21 | 21:02 | x64      |
| Odsole70.dll                                 | 2017.140.3411.3 | 85904     | 24-Aug-21 | 21:00 | x64      |
| Opends60.dll                                 | 2017.140.3411.3 | 26000     | 24-Aug-21 | 21:00 | x64      |
| Qds.dll                                      | 2017.140.3411.3 | 1176448   | 24-Aug-21 | 21:01 | x64      |
| Rsfxft.dll                                   | 2017.140.3411.3 | 27536     | 24-Aug-21 | 21:00 | x64      |
| Secforwarder.dll                             | 2017.140.3411.3 | 30592     | 24-Aug-21 | 21:01 | x64      |
| Sqagtres.dll                                 | 2017.140.3411.3 | 69008     | 24-Aug-21 | 21:01 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlaamss.dll                                 | 2017.140.3411.3 | 84880     | 24-Aug-21 | 21:00 | x64      |
| Sqlaccess.dll                                | 2017.140.3411.3 | 468864    | 24-Aug-21 | 21:01 | x64      |
| Sqlagent.exe                                 | 2017.140.3411.3 | 598416    | 24-Aug-21 | 21:00 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3411.3 | 47504     | 24-Aug-21 | 20:58 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3411.3 | 56224     | 24-Aug-21 | 21:00 | x64      |
| Sqlagentlog.dll                              | 2017.140.3411.3 | 26008     | 24-Aug-21 | 21:00 | x64      |
| Sqlagentmail.dll                             | 2017.140.3411.3 | 47008     | 24-Aug-21 | 21:00 | x64      |
| Sqlboot.dll                                  | 2017.140.3411.3 | 190864    | 24-Aug-21 | 21:01 | x64      |
| Sqlceip.exe                                  | 14.0.3411.3     | 268176    | 24-Aug-21 | 20:55 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3411.3 | 67488     | 24-Aug-21 | 21:00 | x64      |
| Sqlctr140.dll                                | 2017.140.3411.3 | 106384    | 24-Aug-21 | 20:58 | x86      |
| Sqlctr140.dll                                | 2017.140.3411.3 | 123792    | 24-Aug-21 | 21:01 | x64      |
| Sqldk.dll                                    | 2017.140.3411.3 | 2802064   | 24-Aug-21 | 21:00 | x64      |
| Sqldtsss.dll                                 | 2017.140.3411.3 | 102304    | 24-Aug-21 | 21:00 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3681680   | 24-Aug-21 | 20:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 4031888   | 24-Aug-21 | 20:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3485584   | 24-Aug-21 | 20:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3295120   | 24-Aug-21 | 20:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 2092432   | 24-Aug-21 | 20:54 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3784080   | 24-Aug-21 | 20:54 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3217296   | 24-Aug-21 | 20:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3592592   | 24-Aug-21 | 20:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 1446800   | 24-Aug-21 | 21:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 2038672   | 24-Aug-21 | 21:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3300752   | 24-Aug-21 | 21:05 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3600784   | 24-Aug-21 | 21:05 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3371408   | 24-Aug-21 | 21:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3791248   | 24-Aug-21 | 21:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3825040   | 24-Aug-21 | 21:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 1499536   | 24-Aug-21 | 21:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3640208   | 24-Aug-21 | 21:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3406736   | 24-Aug-21 | 21:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3921792   | 24-Aug-21 | 21:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3789712   | 24-Aug-21 | 21:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3342736   | 24-Aug-21 | 21:11 | x64      |
| Sqlevn70.rll                                 | 2017.140.3411.3 | 3919248   | 24-Aug-21 | 21:12 | x64      |
| Sqliosim.com                                 | 2017.140.3411.3 | 306592    | 24-Aug-21 | 21:01 | x64      |
| Sqliosim.exe                                 | 2017.140.3411.3 | 3012992   | 24-Aug-21 | 21:01 | x64      |
| Sqllang.dll                                  | 2017.140.3411.3 | 41281928  | 24-Aug-21 | 21:01 | x64      |
| Sqlmin.dll                                   | 2017.140.3411.3 | 40468352  | 24-Aug-21 | 21:01 | x64      |
| Sqlolapss.dll                                | 2017.140.3411.3 | 102296    | 24-Aug-21 | 21:00 | x64      |
| Sqlos.dll                                    | 2017.140.3411.3 | 19328     | 24-Aug-21 | 21:00 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3411.3 | 62864     | 24-Aug-21 | 21:00 | x64      |
| Sqlrepss.dll                                 | 2017.140.3411.3 | 61856     | 24-Aug-21 | 21:00 | x64      |
| Sqlresld.dll                                 | 2017.140.3411.3 | 23968     | 24-Aug-21 | 21:00 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3411.3 | 25504     | 24-Aug-21 | 21:00 | x64      |
| Sqlscm.dll                                   | 2017.140.3411.3 | 65920     | 24-Aug-21 | 21:00 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3411.3 | 20896     | 24-Aug-21 | 21:01 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3411.3 | 5890448   | 24-Aug-21 | 21:01 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3411.3 | 725904    | 24-Aug-21 | 21:00 | x64      |
| Sqlservr.exe                                 | 2017.140.3411.3 | 482176    | 24-Aug-21 | 21:01 | x64      |
| Sqlsvc.dll                                   | 2017.140.3411.3 | 156064    | 24-Aug-21 | 21:00 | x64      |
| Sqltses.dll                                  | 2017.140.3411.3 | 9555872   | 24-Aug-21 | 21:00 | x64      |
| Sqsrvres.dll                                 | 2017.140.3411.3 | 255872    | 24-Aug-21 | 21:01 | x64      |
| Svl.dll                                      | 2017.140.3411.3 | 146840    | 24-Aug-21 | 21:01 | x64      |
| Xe.dll                                       | 2017.140.3411.3 | 666496    | 24-Aug-21 | 21:01 | x64      |
| Xmlrw.dll                                    | 2017.140.3411.3 | 298368    | 24-Aug-21 | 21:01 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3411.3 | 217472    | 24-Aug-21 | 21:01 | x64      |
| Xpadsi.exe                                   | 2017.140.3411.3 | 84896     | 24-Aug-21 | 21:00 | x64      |
| Xplog70.dll                                  | 2017.140.3411.3 | 71056     | 24-Aug-21 | 21:01 | x64      |
| Xpqueue.dll                                  | 2017.140.3411.3 | 67984     | 24-Aug-21 | 21:01 | x64      |
| Xprepl.dll                                   | 2017.140.3411.3 | 96656     | 24-Aug-21 | 21:01 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3411.3 | 25472     | 24-Aug-21 | 21:01 | x64      |
| Xpstar.dll                                   | 2017.140.3411.3 | 445312    | 24-Aug-21 | 21:00 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3411.3 | 153504    | 24-Aug-21 | 20:56 | x86      |
| Batchparser.dll                                             | 2017.140.3411.3 | 173976    | 24-Aug-21 | 20:59 | x64      |
| Bcp.exe                                                     | 2017.140.3411.3 | 113040    | 24-Aug-21 | 21:00 | x64      |
| Commanddest.dll                                             | 2017.140.3411.3 | 239008    | 24-Aug-21 | 20:59 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3411.3 | 109440    | 24-Aug-21 | 20:59 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3411.3 | 180624    | 24-Aug-21 | 20:59 | x64      |
| Distrib.exe                                                 | 2017.140.3411.3 | 198032    | 24-Aug-21 | 21:00 | x64      |
| Dteparse.dll                                                | 2017.140.3411.3 | 104336    | 24-Aug-21 | 20:59 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3411.3 | 82304     | 24-Aug-21 | 20:59 | x64      |
| Dtepkg.dll                                                  | 2017.140.3411.3 | 130960    | 24-Aug-21 | 20:59 | x64      |
| Dtexec.exe                                                  | 2017.140.3411.3 | 66960     | 24-Aug-21 | 20:59 | x64      |
| Dts.dll                                                     | 2017.140.3411.3 | 2994048   | 24-Aug-21 | 20:59 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3411.3 | 468368    | 24-Aug-21 | 20:59 | x64      |
| Dtsconn.dll                                                 | 2017.140.3411.3 | 493456    | 24-Aug-21 | 20:59 | x64      |
| Dtshost.exe                                                 | 2017.140.3411.3 | 99232     | 24-Aug-21 | 21:00 | x64      |
| Dtslog.dll                                                  | 2017.140.3411.3 | 113552    | 24-Aug-21 | 20:59 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3411.3 | 538528    | 24-Aug-21 | 21:00 | x64      |
| Dtspipeline.dll                                             | 2017.140.3411.3 | 1261456   | 24-Aug-21 | 20:59 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3411.3 | 41376     | 24-Aug-21 | 20:59 | x64      |
| Dtuparse.dll                                                | 2017.140.3411.3 | 82336     | 24-Aug-21 | 20:59 | x64      |
| Dtutil.exe                                                  | 2017.140.3411.3 | 141720    | 24-Aug-21 | 20:59 | x64      |
| Exceldest.dll                                               | 2017.140.3411.3 | 253856    | 24-Aug-21 | 20:59 | x64      |
| Excelsrc.dll                                                | 2017.140.3411.3 | 275872    | 24-Aug-21 | 20:59 | x64      |
| Execpackagetask.dll                                         | 2017.140.3411.3 | 161168    | 24-Aug-21 | 20:59 | x64      |
| Flatfiledest.dll                                            | 2017.140.3411.3 | 379808    | 24-Aug-21 | 20:59 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3411.3 | 392592    | 24-Aug-21 | 20:59 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3411.3 | 89488     | 24-Aug-21 | 20:59 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3411.3 | 52632     | 24-Aug-21 | 21:00 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 24-Aug-21 | 20:57 | x86      |
| Logread.exe                                                 | 2017.140.3411.3 | 629648    | 24-Aug-21 | 21:00 | x64      |
| Mergetxt.dll                                                | 2017.140.3411.3 | 58256     | 24-Aug-21 | 21:00 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.83     | 1375112   | 24-Aug-21 | 20:59 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 24-Aug-21 | 20:57 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3411.3     | 130960    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3411.3     | 48536     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3411.3     | 82832     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3411.3     | 66432     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3411.3     | 385424    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3411.3     | 607616    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3411.3 | 1657760   | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3411.3     | 564624    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3411.3 | 145296    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3411.3 | 152464    | 24-Aug-21 | 21:00 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3411.3 | 96160     | 24-Aug-21 | 20:59 | x64      |
| Msgprox.dll                                                 | 2017.140.3411.3 | 265104    | 24-Aug-21 | 21:00 | x64      |
| Msxmlsql.dll                                                | 2017.140.3411.3 | 1441184   | 24-Aug-21 | 21:00 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 24-Aug-21 | 20:57 | x86      |
| Oledbdest.dll                                               | 2017.140.3411.3 | 254352    | 24-Aug-21 | 20:59 | x64      |
| Oledbsrc.dll                                                | 2017.140.3411.3 | 282000    | 24-Aug-21 | 20:59 | x64      |
| Osql.exe                                                    | 2017.140.3411.3 | 68496     | 24-Aug-21 | 20:59 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3411.3 | 468880    | 24-Aug-21 | 21:01 | x64      |
| Rawdest.dll                                                 | 2017.140.3411.3 | 199576    | 24-Aug-21 | 21:00 | x64      |
| Rawsource.dll                                               | 2017.140.3411.3 | 187280    | 24-Aug-21 | 21:00 | x64      |
| Rdistcom.dll                                                | 2017.140.3411.3 | 852368    | 24-Aug-21 | 21:01 | x64      |
| Recordsetdest.dll                                           | 2017.140.3411.3 | 177568    | 24-Aug-21 | 21:00 | x64      |
| Replagnt.dll                                                | 2017.140.3411.3 | 23952     | 24-Aug-21 | 21:01 | x64      |
| Repldp.dll                                                  | 2017.140.3411.3 | 285584    | 24-Aug-21 | 21:01 | x64      |
| Replerrx.dll                                                | 2017.140.3411.3 | 148880    | 24-Aug-21 | 21:01 | x64      |
| Replisapi.dll                                               | 2017.140.3411.3 | 357264    | 24-Aug-21 | 21:01 | x64      |
| Replmerg.exe                                                | 2017.140.3411.3 | 520096    | 24-Aug-21 | 21:01 | x64      |
| Replprov.dll                                                | 2017.140.3411.3 | 797072    | 24-Aug-21 | 21:01 | x64      |
| Replrec.dll                                                 | 2017.140.3411.3 | 972696    | 24-Aug-21 | 21:01 | x64      |
| Replsub.dll                                                 | 2017.140.3411.3 | 440216    | 24-Aug-21 | 21:01 | x64      |
| Replsync.dll                                                | 2017.140.3411.3 | 148368    | 24-Aug-21 | 21:01 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 24-Aug-21 | 21:01 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 24-Aug-21 | 21:01 | x64      |
| Spresolv.dll                                                | 2017.140.3411.3 | 247184    | 24-Aug-21 | 21:01 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3411.3 | 242064    | 24-Aug-21 | 21:01 | x64      |
| Sqldiag.exe                                                 | 2017.140.3411.3 | 1254784   | 24-Aug-21 | 21:01 | x64      |
| Sqldistx.dll                                                | 2017.140.3411.3 | 219536    | 24-Aug-21 | 21:01 | x64      |
| Sqllogship.exe                                              | 14.0.3411.3     | 99232     | 24-Aug-21 | 21:00 | x64      |
| Sqlmergx.dll                                                | 2017.140.3411.3 | 355216    | 24-Aug-21 | 21:01 | x64      |
| Sqlresld.dll                                                | 2017.140.3411.3 | 21920     | 24-Aug-21 | 20:58 | x86      |
| Sqlresld.dll                                                | 2017.140.3411.3 | 23968     | 24-Aug-21 | 21:00 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3411.3 | 22432     | 24-Aug-21 | 20:58 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3411.3 | 25504     | 24-Aug-21 | 21:00 | x64      |
| Sqlscm.dll                                                  | 2017.140.3411.3 | 55168     | 24-Aug-21 | 20:58 | x86      |
| Sqlscm.dll                                                  | 2017.140.3411.3 | 65920     | 24-Aug-21 | 21:00 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3411.3 | 128912    | 24-Aug-21 | 20:58 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3411.3 | 156064    | 24-Aug-21 | 21:00 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3411.3 | 177048    | 24-Aug-21 | 21:00 | x64      |
| Sqlwep140.dll                                               | 2017.140.3411.3 | 98720     | 24-Aug-21 | 21:01 | x64      |
| Ssdebugps.dll                                               | 2017.140.3411.3 | 26512     | 24-Aug-21 | 21:01 | x64      |
| Ssisoledb.dll                                               | 2017.140.3411.3 | 209312    | 24-Aug-21 | 21:00 | x64      |
| Ssradd.dll                                                  | 2017.140.3411.3 | 70032     | 24-Aug-21 | 21:01 | x64      |
| Ssravg.dll                                                  | 2017.140.3411.3 | 70544     | 24-Aug-21 | 21:01 | x64      |
| Ssrdown.dll                                                 | 2017.140.3411.3 | 55184     | 24-Aug-21 | 21:01 | x64      |
| Ssrmax.dll                                                  | 2017.140.3411.3 | 68496     | 24-Aug-21 | 21:01 | x64      |
| Ssrmin.dll                                                  | 2017.140.3411.3 | 68496     | 24-Aug-21 | 21:01 | x64      |
| Ssrpub.dll                                                  | 2017.140.3411.3 | 55696     | 24-Aug-21 | 21:01 | x64      |
| Ssrup.dll                                                   | 2017.140.3411.3 | 55184     | 24-Aug-21 | 21:01 | x64      |
| Tablediff.exe                                               | 14.0.3411.3     | 79776     | 24-Aug-21 | 21:01 | x64      |
| Txagg.dll                                                   | 2017.140.3411.3 | 355216    | 24-Aug-21 | 21:00 | x64      |
| Txbdd.dll                                                   | 2017.140.3411.3 | 163232    | 24-Aug-21 | 21:00 | x64      |
| Txdatacollector.dll                                         | 2017.140.3411.3 | 353664    | 24-Aug-21 | 21:00 | x64      |
| Txdataconvert.dll                                           | 2017.140.3411.3 | 286112    | 24-Aug-21 | 21:00 | x64      |
| Txderived.dll                                               | 2017.140.3411.3 | 597392    | 24-Aug-21 | 21:00 | x64      |
| Txlookup.dll                                                | 2017.140.3411.3 | 521104    | 24-Aug-21 | 21:00 | x64      |
| Txmerge.dll                                                 | 2017.140.3411.3 | 223128    | 24-Aug-21 | 21:00 | x64      |
| Txmergejoin.dll                                             | 2017.140.3411.3 | 268704    | 24-Aug-21 | 21:00 | x64      |
| Txmulticast.dll                                             | 2017.140.3411.3 | 120736    | 24-Aug-21 | 21:00 | x64      |
| Txrowcount.dll                                              | 2017.140.3411.3 | 118672    | 24-Aug-21 | 21:00 | x64      |
| Txsort.dll                                                  | 2017.140.3411.3 | 249744    | 24-Aug-21 | 21:00 | x64      |
| Txsplit.dll                                                 | 2017.140.3411.3 | 589712    | 24-Aug-21 | 21:00 | x64      |
| Txunionall.dll                                              | 2017.140.3411.3 | 177040    | 24-Aug-21 | 21:00 | x64      |
| Xe.dll                                                      | 2017.140.3411.3 | 666496    | 24-Aug-21 | 21:01 | x64      |
| Xmlrw.dll                                                   | 2017.140.3411.3 | 298368    | 24-Aug-21 | 21:01 | x64      |
| Xmlsub.dll                                                  | 2017.140.3411.3 | 255376    | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2017.140.3411.3 | 1122704   | 24-Aug-21 | 21:00 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlsatellite.dll              | 2017.140.3411.3 | 916880    | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2017.140.3411.3 | 665496    | 24-Aug-21 | 21:00 | x64      |
| Fdhost.exe               | 2017.140.3411.3 | 109456    | 24-Aug-21 | 21:00 | x64      |
| Fdlauncher.exe           | 2017.140.3411.3 | 57216     | 24-Aug-21 | 21:00 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 24-Aug-21 | 21:00 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlft140ph.dll           | 2017.140.3411.3 | 62848     | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 14.0.3411.3     | 17312     | 24-Aug-21 | 20:59 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 24-Aug-21 | 20:56 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 24-Aug-21 | 20:59 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 24-Aug-21 | 20:56 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 24-Aug-21 | 20:59 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 24-Aug-21 | 20:56 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 24-Aug-21 | 20:59 | x86      |
| Commanddest.dll                                               | 2017.140.3411.3 | 193936    | 24-Aug-21 | 20:56 | x86      |
| Commanddest.dll                                               | 2017.140.3411.3 | 239008    | 24-Aug-21 | 20:59 | x64      |
| Dteparse.dll                                                  | 2017.140.3411.3 | 94096     | 24-Aug-21 | 20:56 | x86      |
| Dteparse.dll                                                  | 2017.140.3411.3 | 104336    | 24-Aug-21 | 20:59 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3411.3 | 76672     | 24-Aug-21 | 20:56 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3411.3 | 82304     | 24-Aug-21 | 20:59 | x64      |
| Dtepkg.dll                                                    | 2017.140.3411.3 | 109952    | 24-Aug-21 | 20:56 | x86      |
| Dtepkg.dll                                                    | 2017.140.3411.3 | 130960    | 24-Aug-21 | 20:59 | x64      |
| Dtexec.exe                                                    | 2017.140.3411.3 | 60816     | 24-Aug-21 | 20:56 | x86      |
| Dtexec.exe                                                    | 2017.140.3411.3 | 66960     | 24-Aug-21 | 20:59 | x64      |
| Dts.dll                                                       | 2017.140.3411.3 | 2544016   | 24-Aug-21 | 20:56 | x86      |
| Dts.dll                                                       | 2017.140.3411.3 | 2994048   | 24-Aug-21 | 20:59 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3411.3 | 411024    | 24-Aug-21 | 20:56 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3411.3 | 468368    | 24-Aug-21 | 20:59 | x64      |
| Dtsconn.dll                                                   | 2017.140.3411.3 | 395664    | 24-Aug-21 | 20:56 | x86      |
| Dtsconn.dll                                                   | 2017.140.3411.3 | 493456    | 24-Aug-21 | 20:59 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3411.3 | 88464     | 24-Aug-21 | 20:56 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3411.3 | 104336    | 24-Aug-21 | 20:59 | x64      |
| Dtshost.exe                                                   | 2017.140.3411.3 | 84368     | 24-Aug-21 | 20:58 | x86      |
| Dtshost.exe                                                   | 2017.140.3411.3 | 99232     | 24-Aug-21 | 21:00 | x64      |
| Dtslog.dll                                                    | 2017.140.3411.3 | 96160     | 24-Aug-21 | 20:56 | x86      |
| Dtslog.dll                                                    | 2017.140.3411.3 | 113552    | 24-Aug-21 | 20:59 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3411.3 | 534400    | 24-Aug-21 | 20:58 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3411.3 | 538528    | 24-Aug-21 | 21:00 | x64      |
| Dtspipeline.dll                                               | 2017.140.3411.3 | 1053568   | 24-Aug-21 | 20:56 | x86      |
| Dtspipeline.dll                                               | 2017.140.3411.3 | 1261456   | 24-Aug-21 | 20:59 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3411.3 | 35728     | 24-Aug-21 | 20:56 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3411.3 | 41376     | 24-Aug-21 | 20:59 | x64      |
| Dtuparse.dll                                                  | 2017.140.3411.3 | 73616     | 24-Aug-21 | 20:56 | x86      |
| Dtuparse.dll                                                  | 2017.140.3411.3 | 82336     | 24-Aug-21 | 20:59 | x64      |
| Dtutil.exe                                                    | 2017.140.3411.3 | 120720    | 24-Aug-21 | 20:56 | x86      |
| Dtutil.exe                                                    | 2017.140.3411.3 | 141720    | 24-Aug-21 | 20:59 | x64      |
| Exceldest.dll                                                 | 2017.140.3411.3 | 207760    | 24-Aug-21 | 20:56 | x86      |
| Exceldest.dll                                                 | 2017.140.3411.3 | 253856    | 24-Aug-21 | 20:59 | x64      |
| Excelsrc.dll                                                  | 2017.140.3411.3 | 223632    | 24-Aug-21 | 20:56 | x86      |
| Excelsrc.dll                                                  | 2017.140.3411.3 | 275872    | 24-Aug-21 | 20:59 | x64      |
| Execpackagetask.dll                                           | 2017.140.3411.3 | 128400    | 24-Aug-21 | 20:56 | x86      |
| Execpackagetask.dll                                           | 2017.140.3411.3 | 161168    | 24-Aug-21 | 20:59 | x64      |
| Flatfiledest.dll                                              | 2017.140.3411.3 | 325536    | 24-Aug-21 | 20:56 | x86      |
| Flatfiledest.dll                                              | 2017.140.3411.3 | 379808    | 24-Aug-21 | 20:59 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3411.3 | 337296    | 24-Aug-21 | 20:56 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3411.3 | 392592    | 24-Aug-21 | 20:59 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3411.3 | 73616     | 24-Aug-21 | 20:56 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3411.3 | 89488     | 24-Aug-21 | 20:59 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 24-Aug-21 | 20:57 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 24-Aug-21 | 21:10 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3411.3     | 460192    | 24-Aug-21 | 20:56 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3411.3     | 459648    | 24-Aug-21 | 20:59 | x64      |
| Isserverexec.exe                                              | 14.0.3411.3     | 142240    | 24-Aug-21 | 20:56 | x86      |
| Isserverexec.exe                                              | 14.0.3411.3     | 141712    | 24-Aug-21 | 20:59 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.83     | 1375112   | 24-Aug-21 | 20:56 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.83     | 1375112   | 24-Aug-21 | 20:59 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 24-Aug-21 | 20:55 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 24-Aug-21 | 20:57 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 24-Aug-21 | 21:10 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3411.3     | 105376    | 24-Aug-21 | 20:59 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3411.3 | 100240    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3411.3 | 105360    | 24-Aug-21 | 20:59 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3411.3     | 48544     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3411.3     | 48536     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3411.3     | 82816     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3411.3     | 82832     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3411.3     | 66448     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3411.3     | 66432     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3411.3     | 507800    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3411.3     | 507776    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3411.3     | 76688     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3411.3     | 76704     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3411.3     | 408992    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3411.3     | 408976    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3411.3     | 385424    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3411.3     | 607648    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3411.3     | 607616    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3411.3     | 246160    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3411.3     | 246160    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3411.3     | 48016     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3411.3     | 48016     | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3411.3 | 135056    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3411.3 | 145296    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3411.3 | 138640    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3411.3 | 152464    | 24-Aug-21 | 21:00 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3411.3     | 212880    | 24-Aug-21 | 21:00 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3411.3 | 83352     | 24-Aug-21 | 20:56 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3411.3 | 96160     | 24-Aug-21 | 20:59 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.83 | 9192856   | 24-Aug-21 | 21:00 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 24-Aug-21 | 20:57 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 24-Aug-21 | 21:05 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 24-Aug-21 | 21:10 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 24-Aug-21 | 21:12 | x86      |
| Oledbdest.dll                                                 | 2017.140.3411.3 | 207768    | 24-Aug-21 | 20:56 | x86      |
| Oledbdest.dll                                                 | 2017.140.3411.3 | 254352    | 24-Aug-21 | 20:59 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3411.3 | 226200    | 24-Aug-21 | 20:56 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3411.3 | 282000    | 24-Aug-21 | 20:59 | x64      |
| Rawdest.dll                                                   | 2017.140.3411.3 | 159632    | 24-Aug-21 | 20:58 | x86      |
| Rawdest.dll                                                   | 2017.140.3411.3 | 199576    | 24-Aug-21 | 21:00 | x64      |
| Rawsource.dll                                                 | 2017.140.3411.3 | 146320    | 24-Aug-21 | 20:58 | x86      |
| Rawsource.dll                                                 | 2017.140.3411.3 | 187280    | 24-Aug-21 | 21:00 | x64      |
| Recordsetdest.dll                                             | 2017.140.3411.3 | 142224    | 24-Aug-21 | 20:58 | x86      |
| Recordsetdest.dll                                             | 2017.140.3411.3 | 177568    | 24-Aug-21 | 21:00 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlceip.exe                                                   | 14.0.3411.3     | 268176    | 24-Aug-21 | 20:55 | x86      |
| Sqldest.dll                                                   | 2017.140.3411.3 | 206752    | 24-Aug-21 | 20:58 | x86      |
| Sqldest.dll                                                   | 2017.140.3411.3 | 253856    | 24-Aug-21 | 21:00 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3411.3 | 145296    | 24-Aug-21 | 20:58 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3411.3 | 177048    | 24-Aug-21 | 21:00 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3411.3 | 169872    | 24-Aug-21 | 20:58 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3411.3 | 209312    | 24-Aug-21 | 21:00 | x64      |
| Txagg.dll                                                     | 2017.140.3411.3 | 295312    | 24-Aug-21 | 20:58 | x86      |
| Txagg.dll                                                     | 2017.140.3411.3 | 355216    | 24-Aug-21 | 21:00 | x64      |
| Txbdd.dll                                                     | 2017.140.3411.3 | 129424    | 24-Aug-21 | 20:58 | x86      |
| Txbdd.dll                                                     | 2017.140.3411.3 | 163232    | 24-Aug-21 | 21:00 | x64      |
| Txbestmatch.dll                                               | 2017.140.3411.3 | 486304    | 24-Aug-21 | 20:58 | x86      |
| Txbestmatch.dll                                               | 2017.140.3411.3 | 598416    | 24-Aug-21 | 21:00 | x64      |
| Txcache.dll                                                   | 2017.140.3411.3 | 139152    | 24-Aug-21 | 20:58 | x86      |
| Txcache.dll                                                   | 2017.140.3411.3 | 173456    | 24-Aug-21 | 21:00 | x64      |
| Txcharmap.dll                                                 | 2017.140.3411.3 | 242080    | 24-Aug-21 | 20:58 | x86      |
| Txcharmap.dll                                                 | 2017.140.3411.3 | 279952    | 24-Aug-21 | 21:00 | x64      |
| Txcopymap.dll                                                 | 2017.140.3411.3 | 138656    | 24-Aug-21 | 20:58 | x86      |
| Txcopymap.dll                                                 | 2017.140.3411.3 | 173456    | 24-Aug-21 | 21:00 | x64      |
| Txdataconvert.dll                                             | 2017.140.3411.3 | 246168    | 24-Aug-21 | 20:58 | x86      |
| Txdataconvert.dll                                             | 2017.140.3411.3 | 286112    | 24-Aug-21 | 21:00 | x64      |
| Txderived.dll                                                 | 2017.140.3411.3 | 508816    | 24-Aug-21 | 20:58 | x86      |
| Txderived.dll                                                 | 2017.140.3411.3 | 597392    | 24-Aug-21 | 21:00 | x64      |
| Txfileextractor.dll                                           | 2017.140.3411.3 | 154016    | 24-Aug-21 | 20:58 | x86      |
| Txfileextractor.dll                                           | 2017.140.3411.3 | 191904    | 24-Aug-21 | 21:00 | x64      |
| Txfileinserter.dll                                            | 2017.140.3411.3 | 152480    | 24-Aug-21 | 20:58 | x86      |
| Txfileinserter.dll                                            | 2017.140.3411.3 | 189856    | 24-Aug-21 | 21:00 | x64      |
| Txgroupdups.dll                                               | 2017.140.3411.3 | 224160    | 24-Aug-21 | 20:58 | x86      |
| Txgroupdups.dll                                               | 2017.140.3411.3 | 283544    | 24-Aug-21 | 21:00 | x64      |
| Txlineage.dll                                                 | 2017.140.3411.3 | 103328    | 24-Aug-21 | 20:58 | x86      |
| Txlineage.dll                                                 | 2017.140.3411.3 | 129952    | 24-Aug-21 | 21:00 | x64      |
| Txlookup.dll                                                  | 2017.140.3411.3 | 439696    | 24-Aug-21 | 20:58 | x86      |
| Txlookup.dll                                                  | 2017.140.3411.3 | 521104    | 24-Aug-21 | 21:00 | x64      |
| Txmerge.dll                                                   | 2017.140.3411.3 | 169872    | 24-Aug-21 | 20:58 | x86      |
| Txmerge.dll                                                   | 2017.140.3411.3 | 223128    | 24-Aug-21 | 21:00 | x64      |
| Txmergejoin.dll                                               | 2017.140.3411.3 | 214928    | 24-Aug-21 | 20:58 | x86      |
| Txmergejoin.dll                                               | 2017.140.3411.3 | 268704    | 24-Aug-21 | 21:00 | x64      |
| Txmulticast.dll                                               | 2017.140.3411.3 | 95648     | 24-Aug-21 | 20:58 | x86      |
| Txmulticast.dll                                               | 2017.140.3411.3 | 120736    | 24-Aug-21 | 21:00 | x64      |
| Txpivot.dll                                                   | 2017.140.3411.3 | 173464    | 24-Aug-21 | 20:58 | x86      |
| Txpivot.dll                                                   | 2017.140.3411.3 | 218016    | 24-Aug-21 | 21:00 | x64      |
| Txrowcount.dll                                                | 2017.140.3411.3 | 94608     | 24-Aug-21 | 20:58 | x86      |
| Txrowcount.dll                                                | 2017.140.3411.3 | 118672    | 24-Aug-21 | 21:00 | x64      |
| Txsampling.dll                                                | 2017.140.3411.3 | 128912    | 24-Aug-21 | 20:58 | x86      |
| Txsampling.dll                                                | 2017.140.3411.3 | 165776    | 24-Aug-21 | 21:00 | x64      |
| Txscd.dll                                                     | 2017.140.3411.3 | 163232    | 24-Aug-21 | 20:58 | x86      |
| Txscd.dll                                                     | 2017.140.3411.3 | 213912    | 24-Aug-21 | 21:00 | x64      |
| Txsort.dll                                                    | 2017.140.3411.3 | 201104    | 24-Aug-21 | 20:58 | x86      |
| Txsort.dll                                                    | 2017.140.3411.3 | 249744    | 24-Aug-21 | 21:00 | x64      |
| Txsplit.dll                                                   | 2017.140.3411.3 | 503712    | 24-Aug-21 | 20:58 | x86      |
| Txsplit.dll                                                   | 2017.140.3411.3 | 589712    | 24-Aug-21 | 21:00 | x64      |
| Txtermextraction.dll                                          | 2017.140.3411.3 | 8608152   | 24-Aug-21 | 20:58 | x86      |
| Txtermextraction.dll                                          | 2017.140.3411.3 | 8669584   | 24-Aug-21 | 21:00 | x64      |
| Txtermlookup.dll                                              | 2017.140.3411.3 | 4099984   | 24-Aug-21 | 20:58 | x86      |
| Txtermlookup.dll                                              | 2017.140.3411.3 | 4150160   | 24-Aug-21 | 21:00 | x64      |
| Txunionall.dll                                                | 2017.140.3411.3 | 132512    | 24-Aug-21 | 20:58 | x86      |
| Txunionall.dll                                                | 2017.140.3411.3 | 177040    | 24-Aug-21 | 21:00 | x64      |
| Txunpivot.dll                                                 | 2017.140.3411.3 | 153488    | 24-Aug-21 | 20:58 | x86      |
| Txunpivot.dll                                                 | 2017.140.3411.3 | 192912    | 24-Aug-21 | 21:00 | x64      |
| Xe.dll                                                        | 2017.140.3411.3 | 588688    | 24-Aug-21 | 20:58 | x86      |
| Xe.dll                                                        | 2017.140.3411.3 | 666496    | 24-Aug-21 | 21:01 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 24-Aug-21 | 21:08 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 24-Aug-21 | 21:08 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 24-Aug-21 | 21:08 | x86      |
| Instapi140.dll                                                       | 2017.140.3411.3  | 65424     | 24-Aug-21 | 21:08 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 24-Aug-21 | 20:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 24-Aug-21 | 20:52 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 24-Aug-21 | 21:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 24-Aug-21 | 20:54 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 24-Aug-21 | 21:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 24-Aug-21 | 20:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 24-Aug-21 | 20:52 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 24-Aug-21 | 21:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 24-Aug-21 | 20:54 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 24-Aug-21 | 21:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 24-Aug-21 | 20:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 24-Aug-21 | 21:08 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 24-Aug-21 | 21:08 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3411.3  | 400280    | 24-Aug-21 | 21:08 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3411.3  | 7324048   | 24-Aug-21 | 21:08 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3411.3  | 2258304   | 24-Aug-21 | 21:08 | x64      |
| Secforwarder.dll                                                     | 2017.140.3411.3  | 30592     | 24-Aug-21 | 21:08 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 24-Aug-21 | 21:08 | x64      |
| Sqldk.dll                                                            | 2017.140.3411.3  | 2735520   | 24-Aug-21 | 21:08 | x64      |
| Sqldumper.exe                                                        | 2017.140.3411.3  | 138624    | 24-Aug-21 | 21:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 1499536   | 24-Aug-21 | 21:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3919248   | 24-Aug-21 | 21:12 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3217296   | 24-Aug-21 | 20:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3921792   | 24-Aug-21 | 21:09 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3825040   | 24-Aug-21 | 21:06 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 2092432   | 24-Aug-21 | 20:54 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 2038672   | 24-Aug-21 | 21:04 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3592592   | 24-Aug-21 | 20:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3600784   | 24-Aug-21 | 21:05 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 1446800   | 24-Aug-21 | 21:04 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3411.3  | 3789712   | 24-Aug-21 | 21:09 | x64      |
| Sqlos.dll                                                            | 2017.140.3411.3  | 19328     | 24-Aug-21 | 21:08 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 24-Aug-21 | 21:08 | x64      |
| Sqltses.dll                                                          | 2017.140.3411.3  | 9729440   | 24-Aug-21 | 21:08 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 14.0.3411.3     | 17280     | 24-Aug-21 | 21:00 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time  | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                              | 2017.140.3411.3 | 1441696   | 24-Aug-21 | 20:58 | x86      |
| Dtaengine.exe                                              | 2017.140.3411.3 | 197504    | 24-Aug-21 | 20:56 | x86      |
| Dteparse.dll                                               | 2017.140.3411.3 | 94096     | 24-Aug-21 | 20:56 | x86      |
| Dteparse.dll                                               | 2017.140.3411.3 | 104336    | 24-Aug-21 | 20:59 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3411.3 | 76672     | 24-Aug-21 | 20:56 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3411.3 | 82304     | 24-Aug-21 | 20:59 | x64      |
| Dtepkg.dll                                                 | 2017.140.3411.3 | 109952    | 24-Aug-21 | 20:56 | x86      |
| Dtepkg.dll                                                 | 2017.140.3411.3 | 130960    | 24-Aug-21 | 20:59 | x64      |
| Dtexec.exe                                                 | 2017.140.3411.3 | 60816     | 24-Aug-21 | 20:56 | x86      |
| Dtexec.exe                                                 | 2017.140.3411.3 | 66960     | 24-Aug-21 | 20:59 | x64      |
| Dts.dll                                                    | 2017.140.3411.3 | 2544016   | 24-Aug-21 | 20:56 | x86      |
| Dts.dll                                                    | 2017.140.3411.3 | 2994048   | 24-Aug-21 | 20:59 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3411.3 | 411024    | 24-Aug-21 | 20:56 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3411.3 | 468368    | 24-Aug-21 | 20:59 | x64      |
| Dtsconn.dll                                                | 2017.140.3411.3 | 395664    | 24-Aug-21 | 20:56 | x86      |
| Dtsconn.dll                                                | 2017.140.3411.3 | 493456    | 24-Aug-21 | 20:59 | x64      |
| Dtshost.exe                                                | 2017.140.3411.3 | 84368     | 24-Aug-21 | 20:58 | x86      |
| Dtshost.exe                                                | 2017.140.3411.3 | 99232     | 24-Aug-21 | 21:00 | x64      |
| Dtslog.dll                                                 | 2017.140.3411.3 | 96160     | 24-Aug-21 | 20:56 | x86      |
| Dtslog.dll                                                 | 2017.140.3411.3 | 113552    | 24-Aug-21 | 20:59 | x64      |
| Dtsmsg140.dll                                              | 2017.140.3411.3 | 534400    | 24-Aug-21 | 20:58 | x86      |
| Dtsmsg140.dll                                              | 2017.140.3411.3 | 538528    | 24-Aug-21 | 21:00 | x64      |
| Dtspipeline.dll                                            | 2017.140.3411.3 | 1053568   | 24-Aug-21 | 20:56 | x86      |
| Dtspipeline.dll                                            | 2017.140.3411.3 | 1261456   | 24-Aug-21 | 20:59 | x64      |
| Dtspipelineperf140.dll                                     | 2017.140.3411.3 | 35728     | 24-Aug-21 | 20:56 | x86      |
| Dtspipelineperf140.dll                                     | 2017.140.3411.3 | 41376     | 24-Aug-21 | 20:59 | x64      |
| Dtuparse.dll                                               | 2017.140.3411.3 | 73616     | 24-Aug-21 | 20:56 | x86      |
| Dtuparse.dll                                               | 2017.140.3411.3 | 82336     | 24-Aug-21 | 20:59 | x64      |
| Dtutil.exe                                                 | 2017.140.3411.3 | 120720    | 24-Aug-21 | 20:56 | x86      |
| Dtutil.exe                                                 | 2017.140.3411.3 | 141720    | 24-Aug-21 | 20:59 | x64      |
| Exceldest.dll                                              | 2017.140.3411.3 | 207760    | 24-Aug-21 | 20:56 | x86      |
| Exceldest.dll                                              | 2017.140.3411.3 | 253856    | 24-Aug-21 | 20:59 | x64      |
| Excelsrc.dll                                               | 2017.140.3411.3 | 223632    | 24-Aug-21 | 20:56 | x86      |
| Excelsrc.dll                                               | 2017.140.3411.3 | 275872    | 24-Aug-21 | 20:59 | x64      |
| Flatfiledest.dll                                           | 2017.140.3411.3 | 325536    | 24-Aug-21 | 20:56 | x86      |
| Flatfiledest.dll                                           | 2017.140.3411.3 | 379808    | 24-Aug-21 | 20:59 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3411.3 | 337296    | 24-Aug-21 | 20:56 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3411.3 | 392592    | 24-Aug-21 | 20:59 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3411.3 | 73616     | 24-Aug-21 | 20:56 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3411.3 | 89488     | 24-Aug-21 | 20:59 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3411.3     | 105344    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3411.3     | 179616    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3411.3     | 403344    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3411.3     | 403328    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3411.3     | 2086808   | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3411.3     | 2086800   | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3411.3     | 607648    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3411.3     | 607616    | 24-Aug-21 | 21:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3411.3     | 246160    | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3411.3     | 48016     | 24-Aug-21 | 20:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3411.3 | 135056    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3411.3 | 145296    | 24-Aug-21 | 21:00 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3411.3 | 138640    | 24-Aug-21 | 20:58 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3411.3 | 152464    | 24-Aug-21 | 21:00 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3411.3 | 83352     | 24-Aug-21 | 20:56 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3411.3 | 96160     | 24-Aug-21 | 20:59 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.83 | 7305096   | 24-Aug-21 | 20:58 | x86      |
| Oledbdest.dll                                              | 2017.140.3411.3 | 207768    | 24-Aug-21 | 20:56 | x86      |
| Oledbdest.dll                                              | 2017.140.3411.3 | 254352    | 24-Aug-21 | 20:59 | x64      |
| Oledbsrc.dll                                               | 2017.140.3411.3 | 226200    | 24-Aug-21 | 20:56 | x86      |
| Oledbsrc.dll                                               | 2017.140.3411.3 | 282000    | 24-Aug-21 | 20:59 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3411.3 | 93600     | 24-Aug-21 | 20:59 | x64      |
| Sqlresld.dll                                               | 2017.140.3411.3 | 21920     | 24-Aug-21 | 20:58 | x86      |
| Sqlresld.dll                                               | 2017.140.3411.3 | 23968     | 24-Aug-21 | 21:00 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3411.3 | 22432     | 24-Aug-21 | 20:58 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3411.3 | 25504     | 24-Aug-21 | 21:00 | x64      |
| Sqlscm.dll                                                 | 2017.140.3411.3 | 55168     | 24-Aug-21 | 20:58 | x86      |
| Sqlscm.dll                                                 | 2017.140.3411.3 | 65920     | 24-Aug-21 | 21:00 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3411.3 | 128912    | 24-Aug-21 | 20:58 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3411.3 | 156064    | 24-Aug-21 | 21:00 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3411.3 | 145296    | 24-Aug-21 | 20:58 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3411.3 | 177048    | 24-Aug-21 | 21:00 | x64      |
| Txdataconvert.dll                                          | 2017.140.3411.3 | 246168    | 24-Aug-21 | 20:58 | x86      |
| Txdataconvert.dll                                          | 2017.140.3411.3 | 286112    | 24-Aug-21 | 21:00 | x64      |
| Xe.dll                                                     | 2017.140.3411.3 | 588688    | 24-Aug-21 | 20:58 | x86      |
| Xe.dll                                                     | 2017.140.3411.3 | 666496    | 24-Aug-21 | 21:01 | x64      |
| Xmlrw.dll                                                  | 2017.140.3411.3 | 250752    | 24-Aug-21 | 20:58 | x86      |
| Xmlrw.dll                                                  | 2017.140.3411.3 | 298368    | 24-Aug-21 | 21:01 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3411.3 | 182656    | 24-Aug-21 | 20:58 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3411.3 | 217472    | 24-Aug-21 | 21:01 | x64      |

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
