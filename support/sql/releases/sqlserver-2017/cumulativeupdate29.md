---
title: Cumulative update 29 for SQL Server 2017 (KB5010786)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 29 (KB5010786).
ms.date: 08/04/2023
ms.custom: KB5010786, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5010786 - Cumulative Update 29 for SQL Server 2017

_Release Date:_ &nbsp; March 30, 2022  
_Version:_ &nbsp; 14.0.3436.1

## Summary

This article describes Cumulative Update package 29 (CU29) for Microsoft SQL Server 2017. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 28, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3436.1**, file version: **2017.140.3436.1**
- Analysis Services - Product version: **14.0.249.90**, file version: **2017.140.249.90**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area| Component| Platform |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|----------|
| <a id=14553128>[14553128](#14553128) </a> | Restoring from a compressed backup that contains filestream content occasionally fails when the restore is run by using the Virtual Device Interface (VDI) client. The following error message is generated: </br></br>Msg 3241 </br>The media family on device '\<backup file name>' is incorrectly formed. SQL Server cannot process this media family. | SQL Server Engine | Backup Restore | Windows |
| <a id=14506575>[14506575](#14506575) </a> | An access violation dump occurs when the query runs for a long time in parallel and tries to determine the version of the rowgroup for the particular transactions to read. | SQL Server Engine | Column Stores | All |
| <a id=14641666>[14641666](#14641666) </a> | [FIX: Python is broken after the runtime upgrades to Python 3.7 (KB5013207)](https://support.microsoft.com/help/5013207) | SQL Server Engine | Extensibility | Windows|
| <a id=14401562>[14401562](#14401562) </a> | An access violation occurs when you use FileTables in SQL Server 2017.| SQL Server Engine | FileStream and FileTable| Windows|
| <a id=14401587>[14401587](#14401587) </a> | An error occurs after the failover of a Distributed Availability Group (AG) that attempts to connect to the secondary AG listener with application intent set to READ ONLY. Here are the possible error messages: </br></br>- Sqlcmd: Error: Microsoft ODBC Driver 11 for SQL Server: Protocol error in TDS stream </br></br> - Invalid routing information received. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14451454>[14451454](#14451454) </a> | The `AlwaysOn_Health` extended event doesn't set `STARTUP_STATE` to `ON` after installing a SQL Server Cumulative Update. | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=14577899>[14577899](#14577899) </a> | The database recovery process is chosen as the deadlock victim on Availability Group (AG) failover under certain circumstances. The following error message is generated: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Error: 1205, Severity: 13, State: 51. </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Transaction (Process ID n) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14287010>[14287010](#14287010) </a> | Improves the response time of the Sqldumpr.exe utility when in-memory objects are used in SQL Server or once existed. | SQL Server Engine | In-Memory OLTP | All |
| <a id=14607995>[14607995](#14607995) </a> | Supports more flexible cleanup and merge operations enable by changing In-Memory during restore operations. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id=14144674>[14144674](#14144674) </a> | A filtered index becomes corrupted after you drop a computed column on the same table, and the filtered index corruptions are reported as 8951 and 8955 errors when you run `DBCC CHECKTABLE WITH EXTENDED_LOGICAL_CHECKS`. | SQL Server Engine | Metadata | Windows |
| <a id=14609626>[14609626](#14609626) </a> | Traversing long IAM chains may cause a non-yielding scheduler and associated dump.| SQL Server Engine | Methods to access stored data | Windows|
| <a id=14587111>[14587111](#14587111) </a> | The Table Valued Function (TVF) misses calling the execution plan if the same TVF is referenced more than once in the same SQL query. | SQL Server Engine |Query Optimizer| Windows |
| <a id=14422835>[14422835](#14422835) </a> | [FIX: Missing change data capture cleanup execution isn't identified because of a deadlock without an error message (KB5008296)](https://support.microsoft.com/help/5008296)| SQL Server Engine | Replication | Windows |
| <a id=14561271>[14561271](#14561271) </a> | [FIX: A subscription is still active after the distribution retention period expires (KB5013181)](https://support.microsoft.com/help/5013181) | SQL Server Engine | Replication | Windows |
| <a id=14412963>[14412963](#14412963) </a> | The query against the dynamic management view (DMV) `sys.dm_os_ring_buffers` may cause an access violation (AV). | SQL Server Engine | SQL OS | All|
| <a id=14516280>[14516280](#14516280) </a> | A view, created in a table that has an XML index, can't return the correct result because of missing '%' in `LIKE` predicate on columns hidden for `xml_index_nodes` table. | SQL Server Engine | XML | All |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU29 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/03/sqlserver2017-kb5010786-x64_e6afc1d37ed985fd786c1a71457274c508a6c99c.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5010786-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5010786-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5010786-x64.exe| B610787064A85C1C25B014D7D8DE9EB20DC7AFB272CFB2D3002BA6653E31D662 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.90 | 259472    | 18-Mar-22 | 23:48 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.90     | 735120    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.90     | 1374096   | 18-Mar-22 | 23:48 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.90     | 977296    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.90     | 516024    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 18-Mar-22 | 23:47 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 18-Mar-22 | 23:58 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 18-Mar-22 | 23:58 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 18-Mar-22 | 23:58 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 18-Mar-22 | 23:58 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 18-Mar-22 | 23:58 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 18-Mar-22 | 23:58 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 18-Mar-22 | 23:58 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 18-Mar-22 | 23:58 | x86      |
| Msmdctr.dll                                        | 2017.140.249.90 | 33168     | 18-Mar-22 | 23:50 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.90 | 40420240  | 18-Mar-22 | 23:49 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.90 | 60767160  | 18-Mar-22 | 23:50 | x64      |
| Msmdpump.dll                                       | 2017.140.249.90 | 9333136   | 18-Mar-22 | 23:50 | x64      |
| Msmdredir.dll                                      | 2017.140.249.90 | 7088528   | 18-Mar-22 | 23:49 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.90 | 60669856  | 18-Mar-22 | 23:50 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.90 | 7305104   | 18-Mar-22 | 23:49 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.90 | 9001912   | 18-Mar-22 | 23:50 | x64      |
| Msolap.dll                                         | 2017.140.249.90 | 7772560   | 18-Mar-22 | 23:49 | x86      |
| Msolap.dll                                         | 2017.140.249.90 | 10256784  | 18-Mar-22 | 23:50 | x64      |
| Msolui.dll                                         | 2017.140.249.90 | 281528    | 18-Mar-22 | 23:49 | x86      |
| Msolui.dll                                         | 2017.140.249.90 | 304016    | 18-Mar-22 | 23:50 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 18-Mar-22 | 23:58 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 18-Mar-22 | 23:58 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlboot.dll                                        | 2017.140.3436.1 | 191928    | 18-Mar-22 | 23:50 | x64      |
| Sqlceip.exe                                        | 14.0.3436.1     | 269240    | 18-Mar-22 | 23:47 | x86      |
| Sqldumper.exe                                      | 2017.140.3436.1 | 117152    | 19-Mar-22 | 00:04  | x86      |
| Sqldumper.exe                                      | 2017.140.3436.1 | 139704    | 19-Mar-22 | 00:01  | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 18-Mar-22 | 23:58 | x86      |
| Tmapi.dll                                          | 2017.140.249.90 | 5814672   | 18-Mar-22 | 23:50 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.90 | 4158904   | 18-Mar-22 | 23:50 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.90 | 1125264   | 18-Mar-22 | 23:50 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.90 | 1637280   | 18-Mar-22 | 23:50 | x64      |
| Xe.dll                                             | 2017.140.3436.1 | 667576    | 18-Mar-22 | 23:50 | x64      |
| Xmlrw.dll                                          | 2017.140.3436.1 | 251832    | 18-Mar-22 | 23:49 | x86      |
| Xmlrw.dll                                          | 2017.140.3436.1 | 299448    | 18-Mar-22 | 23:50 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3436.1 | 183736    | 18-Mar-22 | 23:49 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3436.1 | 218552    | 18-Mar-22 | 23:50 | x64      |
| Xmsrv.dll                                          | 2017.140.249.90 | 33350584  | 18-Mar-22 | 23:49 | x86      |
| Xmsrv.dll                                          | 2017.140.249.90 | 25376144  | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3436.1  | 154528    | 18-Mar-22 | 23:46 | x86      |
| Batchparser.dll                            | 2017.140.3436.1  | 175032    | 18-Mar-22 | 23:48 | x64      |
| Instapi150.dll                             | 2017.140.3436.1  | 56760     | 18-Mar-22 | 23:49 | x86      |
| Instapi150.dll                             | 2017.140.3436.1  | 66488     | 18-Mar-22 | 23:49 | x64      |
| Isacctchange.dll                           | 2017.140.3436.1  | 23456     | 18-Mar-22 | 23:46 | x86      |
| Isacctchange.dll                           | 2017.140.3436.1  | 24992     | 18-Mar-22 | 23:48 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.90      | 1081744   | 18-Mar-22 | 23:46 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.90      | 1082784   | 18-Mar-22 | 23:48 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.90      | 1374608   | 18-Mar-22 | 23:47 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.90      | 734608    | 18-Mar-22 | 23:46 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.90      | 734608    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3436.1      | 31672     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3436.1  | 72608     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3436.1  | 76216     | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3436.1      | 565664    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3436.1      | 565688    | 18-Mar-22 | 23:49 | x86      |
| Msasxpress.dll                             | 2017.140.249.90  | 24976     | 18-Mar-22 | 23:49 | x86      |
| Msasxpress.dll                             | 2017.140.249.90  | 30112     | 18-Mar-22 | 23:50 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3436.1  | 63392     | 18-Mar-22 | 23:49 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3436.1  | 78264     | 18-Mar-22 | 23:50 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3436.1  | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqldumper.exe                              | 2017.140.3436.1  | 117152    | 19-Mar-22 | 00:04  | x86      |
| Sqldumper.exe                              | 2017.140.3436.1  | 139704    | 19-Mar-22 | 00:01  | x64      |
| Sqlftacct.dll                              | 2017.140.3436.1  | 50104     | 18-Mar-22 | 23:49 | x86      |
| Sqlftacct.dll                              | 2017.140.3436.1  | 58296     | 18-Mar-22 | 23:50 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 18-Mar-22 | 23:48 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 18-Mar-22 | 23:49 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3436.1  | 369592    | 18-Mar-22 | 23:48 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3436.1  | 414136    | 18-Mar-22 | 23:49 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3436.1  | 29112     | 18-Mar-22 | 23:49 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3436.1  | 31648     | 18-Mar-22 | 23:50 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3436.1  | 268216    | 18-Mar-22 | 23:49 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3436.1  | 352184    | 18-Mar-22 | 23:50 | x64      |
| Sqltdiagn.dll                              | 2017.140.3436.1  | 54688     | 18-Mar-22 | 23:48 | x86      |
| Sqltdiagn.dll                              | 2017.140.3436.1  | 61856     | 18-Mar-22 | 23:49 | x64      |
| Svrenumapi150.dll                          | 2017.140.3436.1  | 889272    | 18-Mar-22 | 23:49 | x86      |
| Svrenumapi150.dll                          | 2017.140.3436.1  | 1168824   | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time  | Platform |
|---------------------|-----------------|-----------|-----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 18-Mar-22 | 23:48 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 18-Mar-22 | 23:49 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 18-Mar-22 | 23:49 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 18-Mar-22 | 23:49 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 18-Mar-22 | 23:48 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2017.140.3436.1 | 115128    | 18-Mar-22 | 23:46 | x86      |
| Dreplaycommon.dll              | 2017.140.3436.1 | 694200    | 18-Mar-22 | 23:46 | x86      |
| Dreplayserver.tlb              | n/a             | 20592     | 18-Mar-22 | 23:46 | n/a      |
| Dreplayserverps.dll            | 2017.140.3436.1 | 27064     | 18-Mar-22 | 23:46 | x86      |
| Dreplayutil.dll                | 2017.140.3436.1 | 304544    | 18-Mar-22 | 23:46 | x86      |
| Instapi150.dll                 | 2017.140.3436.1 | 66488     | 18-Mar-22 | 23:49 | x64      |
| Irdefinition.xml               | n/a             | 63906     | 18-Mar-22 | 23:46 | n/a      |
| Irtemplate.tdf                 | n/a             | 1322      | 18-Mar-22 | 23:46 | n/a      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlresourceloader.dll          | 2017.140.3436.1 | 23480     | 18-Mar-22 | 23:48 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3436.1 | 694200    | 18-Mar-22 | 23:46 | x86      |
| Dreplaycontroller.exe              | 2017.140.3436.1 | 344504    | 18-Mar-22 | 23:46 | x86      |
| Dreplayprocess.dll                 | 2017.140.3436.1 | 165792    | 18-Mar-22 | 23:46 | x86      |
| Dreplayserver.tlb                  | n/a             | 20592     | 18-Mar-22 | 23:46 | n/a      |
| Dreplayserverps.dll                | 2017.140.3436.1 | 27064     | 18-Mar-22 | 23:46 | x86      |
| Instapi150.dll                     | 2017.140.3436.1 | 66488     | 18-Mar-22 | 23:49 | x64      |
| Irdefinition.xml                   | n/a             | 63906     | 18-Mar-22 | 23:46 | n/a      |
| Irtemplate.tdf                     | n/a             | 1322      | 18-Mar-22 | 23:46 | n/a      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlresourceloader.dll              | 2017.140.3436.1 | 23480     | 18-Mar-22 | 23:48 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3436.1     | 34744     | 18-Mar-22 | 23:48 | x64      |
| Batchparser.dll                              | 2017.140.3436.1 | 175032    | 18-Mar-22 | 23:48 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 19-Mar-22 | 00:03  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 19-Mar-22 | 00:03  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 19-Mar-22 | 00:03  | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 18-Mar-22 | 23:45 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 18-Mar-22 | 23:48 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3436.1 | 221624    | 18-Mar-22 | 23:48 | x64      |
| Dcexec.exe                                   | 2017.140.3436.1 | 68512     | 18-Mar-22 | 23:48 | x64      |
| Eng_xtp_vc_hkcrt.64                          | n/a             | 169936    | 18-Mar-22 | 23:55 | n/a      |
| Exacorepredict.dll                           | n/a             | 58386000  | 18-Mar-22 | 23:48 | x64      |
| Exacorepredictsql.dll                        | n/a             | 38272     | 18-Mar-22 | 23:48 | x64      |
| Fssres.dll                                   | 2017.140.3436.1 | 84920     | 18-Mar-22 | 23:49 | x64      |
| Hadrres.dll                                  | 2017.140.3436.1 | 183736    | 18-Mar-22 | 23:49 | x64      |
| Hkcompile.dll                                | 2017.140.3436.1 | 1417144   | 18-Mar-22 | 23:49 | x64      |
| Hkengine.dll                                 | 2017.140.3436.1 | 5855648   | 18-Mar-22 | 23:49 | x64      |
| Hkengine.lib                                 | n/a             | 92818     | 18-Mar-22 | 23:49 | n/a      |
| Hkgenexp.exp                                 | n/a             | 880       | 18-Mar-22 | 23:49 | n/a      |
| Hkgenlib.lib                                 | n/a             | 2834114   | 18-Mar-22 | 23:49 | n/a      |
| Hkk32.lib                                    | n/a             | 2838      | 18-Mar-22 | 23:49 | n/a      |
| Hkruntime.dll                                | 2017.140.3436.1 | 157088    | 18-Mar-22 | 23:49 | x64      |
| Hkruntime.lib                                | n/a             | 36872     | 18-Mar-22 | 23:49 | n/a      |
| Hkversion.obj                                | n/a             | 1184      | 18-Mar-22 | 23:49 | n/a      |
| Libcmt.lib                                   | n/a             | 1216512   | 18-Mar-22 | 23:55 | n/a      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 19-Mar-22 | 00:03  | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.90     | 734096    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 18-Mar-22 | 23:47 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3436.1     | 232864    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3436.1     | 74168     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3436.1 | 386976    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3436.1 | 66488     | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3436.1 | 59320     | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3436.1 | 146336    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3436.1 | 153504    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3436.1 | 297888    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3436.1 | 69048     | 18-Mar-22 | 23:49 | x64      |
| Msdb110_upgrade.sql                          | n/a             | 2663236   | 18-Mar-22 | 23:50 | n/a      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 19-Mar-22 | 00:03  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 19-Mar-22 | 00:03  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 19-Mar-22 | 00:03  | x64      |
| Mssqlsystemresource.ldf                      | n/a             | 1310720   | 18-Mar-22 | 23:50 | n/a      |
| Mssqlsystemresource.mdf                      | n/a             | 41943040  | 18-Mar-22 | 23:50 | n/a      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 19-Mar-22 | 00:03  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 19-Mar-22 | 00:03  | x64      |
| Odsole70.dll                                 | 2017.140.3436.1 | 86968     | 18-Mar-22 | 23:49 | x64      |
| Opends60.dll                                 | 2017.140.3436.1 | 27040     | 18-Mar-22 | 23:49 | x64      |
| Perfcounterscollect.dtsx                     | n/a             | 88754     | 18-Mar-22 | 23:49 | n/a      |
| Perfcountersupload.dtsx                      | n/a             | 218630    | 18-Mar-22 | 23:49 | n/a      |
| Qds.dll                                      | 2017.140.3436.1 | 1177528   | 18-Mar-22 | 23:50 | x64      |
| Queryactivitycollect.dtsx                    | n/a             | 369430    | 18-Mar-22 | 23:49 | n/a      |
| Queryactivityupload.dtsx                     | n/a             | 1983698   | 18-Mar-22 | 23:49 | n/a      |
| Rsfxft.dll                                   | 2017.140.3436.1 | 28600     | 18-Mar-22 | 23:49 | x64      |
| Secforwarder.dll                             | 2017.140.3436.1 | 31672     | 18-Mar-22 | 23:50 | x64      |
| Sqagtres.dll                                 | 2017.140.3436.1 | 70048     | 18-Mar-22 | 23:50 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlaamss.dll                                 | 2017.140.3436.1 | 85944     | 18-Mar-22 | 23:49 | x64      |
| Sqlaccess.dll                                | 2017.140.3436.1 | 469944    | 18-Mar-22 | 23:50 | x64      |
| Sqlagent.exe                                 | 2017.140.3436.1 | 599480    | 18-Mar-22 | 23:49 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3436.1 | 48544     | 18-Mar-22 | 23:48 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3436.1 | 57248     | 18-Mar-22 | 23:49 | x64      |
| Sqlagentlog.dll                              | 2017.140.3436.1 | 27064     | 18-Mar-22 | 23:49 | x64      |
| Sqlagentmail.dll                             | 2017.140.3436.1 | 48056     | 18-Mar-22 | 23:49 | x64      |
| Sqlboot.dll                                  | 2017.140.3436.1 | 191928    | 18-Mar-22 | 23:50 | x64      |
| Sqlceip.exe                                  | 14.0.3436.1     | 269240    | 18-Mar-22 | 23:47 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3436.1 | 68512     | 18-Mar-22 | 23:49 | x64      |
| Sqlctr140.dll                                | 2017.140.3436.1 | 107448    | 18-Mar-22 | 23:49 | x86      |
| Sqlctr140.dll                                | 2017.140.3436.1 | 124856    | 18-Mar-22 | 23:50 | x64      |
| Sqldk.dll                                    | 2017.140.3436.1 | 2804152   | 18-Mar-22 | 23:49 | x64      |
| Sqldtsss.dll                                 | 2017.140.3436.1 | 103328    | 18-Mar-22 | 23:49 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 1500576   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3301816   | 18-Mar-22 | 23:46 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3486648   | 18-Mar-22 | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3920312   | 18-Mar-22 | 23:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 4032952   | 19-Mar-22 | 00:00  | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3218360   | 18-Mar-22 | 23:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3372472   | 18-Mar-22 | 23:44 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3922872   | 18-Mar-22 | 23:47 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3792312   | 18-Mar-22 | 23:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3826080   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 2093472   | 18-Mar-22 | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 2039736   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3641272   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3343800   | 18-Mar-22 | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3785144   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3593656   | 18-Mar-22 | 23:44 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3601848   | 18-Mar-22 | 23:46 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3407800   | 18-Mar-22 | 23:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3296184   | 19-Mar-22 | 00:02  | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 1447864   | 18-Mar-22 | 23:47 | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3682720   | 19-Mar-22 | 00:03  | x64      |
| Sqlevn70.rll                                 | 2017.140.3436.1 | 3790776   | 18-Mar-22 | 23:44 | x64      |
| Sqliosim.com                                 | 2017.140.3436.1 | 307640    | 18-Mar-22 | 23:50 | x64      |
| Sqliosim.exe                                 | 2017.140.3436.1 | 3014048   | 18-Mar-22 | 23:50 | x64      |
| Sqllang.dll                                  | 2017.140.3436.1 | 41376696  | 18-Mar-22 | 23:50 | x64      |
| Sqlmin.dll                                   | 2017.140.3436.1 | 40597920  | 18-Mar-22 | 23:50 | x64      |
| Sqlolapss.dll                                | 2017.140.3436.1 | 103328    | 18-Mar-22 | 23:49 | x64      |
| Sqlos.dll                                    | 2017.140.3436.1 | 20384     | 18-Mar-22 | 23:49 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3436.1 | 63904     | 18-Mar-22 | 23:49 | x64      |
| Sqlrepss.dll                                 | 2017.140.3436.1 | 62880     | 18-Mar-22 | 23:49 | x64      |
| Sqlresld.dll                                 | 2017.140.3436.1 | 25016     | 18-Mar-22 | 23:49 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3436.1 | 26552     | 18-Mar-22 | 23:49 | x64      |
| Sqlscm.dll                                   | 2017.140.3436.1 | 67000     | 18-Mar-22 | 23:49 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3436.1 | 21944     | 18-Mar-22 | 23:50 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3436.1 | 5893536   | 18-Mar-22 | 23:50 | x64      |
| Sqlserverspatial150.dll                      | 2017.140.3436.1 | 726944    | 18-Mar-22 | 23:49 | x64      |
| Sqlservr.exe                                 | 2017.140.3436.1 | 482744    | 18-Mar-22 | 23:50 | x64      |
| Sqlsvc.dll                                   | 2017.140.3436.1 | 157088    | 18-Mar-22 | 23:49 | x64      |
| Sqltracecollect.dtsx                         | n/a             | 64814     | 18-Mar-22 | 23:49 | n/a      |
| Sqltraceupload.dtsx                          | n/a             | 898834    | 18-Mar-22 | 23:49 | n/a      |
| Sqltses.dll                                  | 2017.140.3436.1 | 9560504   | 18-Mar-22 | 23:49 | x64      |
| Sqsrvres.dll                                 | 2017.140.3436.1 | 256952    | 18-Mar-22 | 23:50 | x64      |
| Ssis_hotfix_install.sql                      | n/a             | 23096     | 18-Mar-22 | 23:50 | n/a      |
| Ssis_hotfix_uninstall.sql                    | n/a             | 3512      | 18-Mar-22 | 23:50 | n/a      |
| Svl.dll                                      | 2017.140.3436.1 | 147872    | 18-Mar-22 | 23:50 | x64      |
| Tsqlquerycollect.dtsx                        | n/a             | 44858     | 18-Mar-22 | 23:49 | n/a      |
| Tsqlqueryupload.dtsx                         | n/a             | 34930     | 18-Mar-22 | 23:49 | n/a      |
| U_tables.sql                                 | n/a             | 19769     | 18-Mar-22 | 23:50 | n/a      |
| Xe.dll                                       | 2017.140.3436.1 | 667576    | 18-Mar-22 | 23:50 | x64      |
| Xesospkg.mof                                 | n/a             | 362552    | 18-Mar-22 | 23:50 | n/a      |
| Xesqlminpkg.mof                              | n/a             | 1607788   | 18-Mar-22 | 23:50 | n/a      |
| Xesqlminpkg_loc_rll_64_1028                  | n/a             | 197536    | 18-Mar-22 | 23:45 | x64      |
| Xesqlminpkg_loc_rll_64_1031                  | n/a             | 463800    | 18-Mar-22 | 23:58 | x64      |
| Xesqlminpkg_loc_rll_64_1033                  | n/a             | 386976    | 18-Mar-22 | 23:57 | x64      |
| Xesqlminpkg_loc_rll_64_1036                  | n/a             | 463264    | 18-Mar-22 | 23:47 | x64      |
| Xesqlminpkg_loc_rll_64_1040                  | n/a             | 448928    | 18-Mar-22 | 23:45 | x64      |
| Xesqlminpkg_loc_rll_64_1041                  | n/a             | 251832    | 18-Mar-22 | 23:59 | x64      |
| Xesqlminpkg_loc_rll_64_1042                  | n/a             | 249272    | 18-Mar-22 | 23:45 | x64      |
| Xesqlminpkg_loc_rll_64_1046                  | n/a             | 438200    | 18-Mar-22 | 23:44 | x64      |
| Xesqlminpkg_loc_rll_64_1049                  | n/a             | 440248    | 18-Mar-22 | 23:46 | x64      |
| Xesqlminpkg_loc_rll_64_2052                  | n/a             | 191392    | 18-Mar-22 | 23:47 | x64      |
| Xesqlminpkg_loc_rll_64_3082                  | n/a             | 474528    | 18-Mar-22 | 23:44 | x64      |
| Xesqlpkg.mof                                 | n/a             | 741722    | 18-Mar-22 | 23:50 | n/a      |
| Xesqlpkg_loc_rll_64_1028                     | n/a             | 149408    | 18-Mar-22 | 23:45 | x64      |
| Xesqlpkg_loc_rll_64_1031                     | n/a             | 319416    | 18-Mar-22 | 23:58 | x64      |
| Xesqlpkg_loc_rll_64_1033                     | n/a             | 279480    | 18-Mar-22 | 23:57 | x64      |
| Xesqlpkg_loc_rll_64_1036                     | n/a             | 317368    | 18-Mar-22 | 23:47 | x64      |
| Xesqlpkg_loc_rll_64_1040                     | n/a             | 312248    | 18-Mar-22 | 23:45 | x64      |
| Xesqlpkg_loc_rll_64_1041                     | n/a             | 185784    | 18-Mar-22 | 23:59 | x64      |
| Xesqlpkg_loc_rll_64_1042                     | n/a             | 182688    | 18-Mar-22 | 23:45 | x64      |
| Xesqlpkg_loc_rll_64_1046                     | n/a             | 299960    | 18-Mar-22 | 23:44 | x64      |
| Xesqlpkg_loc_rll_64_1049                     | n/a             | 299448    | 18-Mar-22 | 23:46 | x64      |
| Xesqlpkg_loc_rll_64_2052                     | n/a             | 146360    | 18-Mar-22 | 23:47 | x64      |
| Xesqlpkg_loc_rll_64_3082                     | n/a             | 317880    | 18-Mar-22 | 23:44 | x64      |
| Xmlrw.dll                                    | 2017.140.3436.1 | 299448    | 18-Mar-22 | 23:50 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3436.1 | 218552    | 18-Mar-22 | 23:50 | x64      |
| Xpadsi.exe                                   | 2017.140.3436.1 | 85944     | 18-Mar-22 | 23:49 | x64      |
| Xplog70.dll                                  | 2017.140.3436.1 | 72096     | 18-Mar-22 | 23:50 | x64      |
| Xpqueue.dll                                  | 2017.140.3436.1 | 69048     | 18-Mar-22 | 23:50 | x64      |
| Xprepl.dll                                   | 2017.140.3436.1 | 97720     | 18-Mar-22 | 23:50 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3436.1 | 26552     | 18-Mar-22 | 23:50 | x64      |
| Xpstar.dll                                   | 2017.140.3436.1 | 446392    | 18-Mar-22 | 23:49 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3436.1 | 154528    | 18-Mar-22 | 23:46 | x86      |
| Batchparser.dll                                             | 2017.140.3436.1 | 175032    | 18-Mar-22 | 23:48 | x64      |
| Bcp.exe                                                     | 2017.140.3436.1 | 114080    | 18-Mar-22 | 23:49 | x64      |
| Commanddest.dll                                             | 2017.140.3436.1 | 240056    | 18-Mar-22 | 23:48 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3436.1 | 110496    | 18-Mar-22 | 23:48 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3436.1 | 182200    | 18-Mar-22 | 23:48 | x64      |
| Distrib.exe                                                 | 2017.140.3436.1 | 199072    | 18-Mar-22 | 23:49 | x64      |
| Dteparse.dll                                                | 2017.140.3436.1 | 105912    | 18-Mar-22 | 23:48 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3436.1 | 83360     | 18-Mar-22 | 23:48 | x64      |
| Dtepkg.dll                                                  | 2017.140.3436.1 | 132000    | 18-Mar-22 | 23:48 | x64      |
| Dtexec.exe                                                  | 2017.140.3436.1 | 68024     | 18-Mar-22 | 23:48 | x64      |
| Dts.dll                                                     | 2017.140.3436.1 | 2995104   | 18-Mar-22 | 23:48 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3436.1 | 469408    | 18-Mar-22 | 23:48 | x64      |
| Dtsconn.dll                                                 | 2017.140.3436.1 | 494520    | 18-Mar-22 | 23:48 | x64      |
| Dtshost.exe                                                 | 2017.140.3436.1 | 100280    | 18-Mar-22 | 23:49 | x64      |
| Dtslog.dll                                                  | 2017.140.3436.1 | 114616    | 18-Mar-22 | 23:48 | x64      |
| Dtsmsg150.dll                                               | 2017.140.3436.1 | 539576    | 18-Mar-22 | 23:49 | x64      |
| Dtspipeline.dll                                             | 2017.140.3436.1 | 1262520   | 18-Mar-22 | 23:48 | x64      |
| Dtspipelineperf150.dll                                      | 2017.140.3436.1 | 42400     | 18-Mar-22 | 23:48 | x64      |
| Dtuparse.dll                                                | 2017.140.3436.1 | 83384     | 18-Mar-22 | 23:48 | x64      |
| Dtutil.exe                                                  | 2017.140.3436.1 | 142752    | 18-Mar-22 | 23:48 | x64      |
| Exceldest.dll                                               | 2017.140.3436.1 | 254904    | 18-Mar-22 | 23:48 | x64      |
| Excelsrc.dll                                                | 2017.140.3436.1 | 276920    | 18-Mar-22 | 23:48 | x64      |
| Execpackagetask.dll                                         | 2017.140.3436.1 | 162208    | 18-Mar-22 | 23:48 | x64      |
| Flatfiledest.dll                                            | 2017.140.3436.1 | 380832    | 18-Mar-22 | 23:48 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3436.1 | 393632    | 18-Mar-22 | 23:48 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3436.1 | 90528     | 18-Mar-22 | 23:48 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3436.1 | 53688     | 18-Mar-22 | 23:49 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 18-Mar-22 | 23:58 | x86      |
| logread.exe                                                 | 2017.140.3436.1 | 630688    | 18-Mar-22 | 23:49 | x64      |
| Mergetxt.dll                                                | 2017.140.3436.1 | 59320     | 18-Mar-22 | 23:49 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.90     | 1375120   | 18-Mar-22 | 23:48 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3436.1     | 132024    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3436.1     | 49592     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3436.1     | 83872     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3436.1     | 67488     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3436.1     | 386488    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3436.1     | 608672    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3436.1 | 1658784   | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3436.1     | 565664    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3436.1 | 146336    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3436.1 | 153504    | 18-Mar-22 | 23:49 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3436.1 | 97208     | 18-Mar-22 | 23:48 | x64      |
| Msgprox.dll                                                 | 2017.140.3436.1 | 266168    | 18-Mar-22 | 23:50 | x64      |
| Msxmlsql.dll                                                | 2017.140.3436.1 | 1442232   | 18-Mar-22 | 23:50 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 18-Mar-22 | 23:58 | x86      |
| Oledbdest.dll                                               | 2017.140.3436.1 | 255392    | 18-Mar-22 | 23:48 | x64      |
| Oledbsrc.dll                                                | 2017.140.3436.1 | 283040    | 18-Mar-22 | 23:48 | x64      |
| Osql.exe                                                    | 2017.140.3436.1 | 69560     | 18-Mar-22 | 23:48 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3436.1 | 469944    | 18-Mar-22 | 23:50 | x64      |
| Rawdest.dll                                                 | 2017.140.3436.1 | 200608    | 18-Mar-22 | 23:49 | x64      |
| Rawsource.dll                                               | 2017.140.3436.1 | 188320    | 18-Mar-22 | 23:49 | x64      |
| Rdistcom.dll                                                | 2017.140.3436.1 | 853432    | 18-Mar-22 | 23:50 | x64      |
| Recordsetdest.dll                                           | 2017.140.3436.1 | 178616    | 18-Mar-22 | 23:49 | x64      |
| Replagnt.dll                                                | 2017.140.3436.1 | 24992     | 18-Mar-22 | 23:50 | x64      |
| Repldp.dll                                                  | 2017.140.3436.1 | 286648    | 18-Mar-22 | 23:50 | x64      |
| Replerrx.dll                                                | 2017.140.3436.1 | 149944    | 18-Mar-22 | 23:50 | x64      |
| Replisapi.dll                                               | 2017.140.3436.1 | 358304    | 18-Mar-22 | 23:50 | x64      |
| Replmerg.exe                                                | 2017.140.3436.1 | 521120    | 18-Mar-22 | 23:50 | x64      |
| Replprov.dll                                                | 2017.140.3436.1 | 798112    | 18-Mar-22 | 23:50 | x64      |
| Replrec.dll                                                 | 2017.140.3436.1 | 973728    | 18-Mar-22 | 23:50 | x64      |
| Replsub.dll                                                 | 2017.140.3436.1 | 441248    | 18-Mar-22 | 23:50 | x64      |
| Replsync.dll                                                | 2017.140.3436.1 | 149408    | 18-Mar-22 | 23:50 | x64      |
| Showplanxml.xsd                                             | n/a             | 98229     | 18-Mar-22 | 23:50 | n/a      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 18-Mar-22 | 23:50 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 18-Mar-22 | 23:50 | x64      |
| Spresolv.dll                                                | 2017.140.3436.1 | 248224    | 18-Mar-22 | 23:50 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3436.1 | 243128    | 18-Mar-22 | 23:50 | x64      |
| Sqldiag.exe                                                 | 2017.140.3436.1 | 1255864   | 18-Mar-22 | 23:50 | x64      |
| Sqldistx.dll                                                | 2017.140.3436.1 | 220600    | 18-Mar-22 | 23:50 | x64      |
| Sqllogship.exe                                              | 14.0.3436.1     | 100280    | 18-Mar-22 | 23:49 | x64      |
| Sqlmergx.dll                                                | 2017.140.3436.1 | 356256    | 18-Mar-22 | 23:50 | x64      |
| Sqlresld.dll                                                | 2017.140.3436.1 | 22944     | 18-Mar-22 | 23:48 | x86      |
| Sqlresld.dll                                                | 2017.140.3436.1 | 25016     | 18-Mar-22 | 23:49 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3436.1 | 23480     | 18-Mar-22 | 23:48 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3436.1 | 26552     | 18-Mar-22 | 23:49 | x64      |
| Sqlscm.dll                                                  | 2017.140.3436.1 | 56248     | 18-Mar-22 | 23:48 | x86      |
| Sqlscm.dll                                                  | 2017.140.3436.1 | 67000     | 18-Mar-22 | 23:49 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3436.1 | 129440    | 18-Mar-22 | 23:48 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3436.1 | 157088    | 18-Mar-22 | 23:49 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3436.1 | 177080    | 18-Mar-22 | 23:49 | x64      |
| Sqlwep140.dll                                               | 2017.140.3436.1 | 99744     | 18-Mar-22 | 23:50 | x64      |
| Ssdebugps.dll                                               | 2017.140.3436.1 | 27552     | 18-Mar-22 | 23:50 | x64      |
| Ssisoledb.dll                                               | 2017.140.3436.1 | 210360    | 18-Mar-22 | 23:49 | x64      |
| Ssradd.dll                                                  | 2017.140.3436.1 | 71072     | 18-Mar-22 | 23:50 | x64      |
| Ssravg.dll                                                  | 2017.140.3436.1 | 71584     | 18-Mar-22 | 23:50 | x64      |
| Ssrdown.dll                                                 | 2017.140.3436.1 | 56224     | 18-Mar-22 | 23:50 | x64      |
| Ssrmax.dll                                                  | 2017.140.3436.1 | 69560     | 18-Mar-22 | 23:50 | x64      |
| Ssrmin.dll                                                  | 2017.140.3436.1 | 69560     | 18-Mar-22 | 23:50 | x64      |
| Ssrpub.dll                                                  | 2017.140.3436.1 | 56736     | 18-Mar-22 | 23:50 | x64      |
| Ssrup.dll                                                   | 2017.140.3436.1 | 56224     | 18-Mar-22 | 23:50 | x64      |
| Tablediff.exe                                               | 14.0.3436.1     | 80824     | 18-Mar-22 | 23:50 | x64      |
| Txagg.dll                                                   | 2017.140.3436.1 | 356256    | 18-Mar-22 | 23:49 | x64      |
| Txbdd.dll                                                   | 2017.140.3436.1 | 169376    | 18-Mar-22 | 23:49 | x64      |
| Txdatacollector.dll                                         | 2017.140.3436.1 | 361376    | 18-Mar-22 | 23:49 | x64      |
| Txdataconvert.dll                                           | 2017.140.3436.1 | 287136    | 18-Mar-22 | 23:49 | x64      |
| Txderived.dll                                               | 2017.140.3436.1 | 598432    | 18-Mar-22 | 23:49 | x64      |
| Txlookup.dll                                                | 2017.140.3436.1 | 522144    | 18-Mar-22 | 23:49 | x64      |
| Txmerge.dll                                                 | 2017.140.3436.1 | 224184    | 18-Mar-22 | 23:49 | x64      |
| Txmergejoin.dll                                             | 2017.140.3436.1 | 269752    | 18-Mar-22 | 23:49 | x64      |
| Txmulticast.dll                                             | 2017.140.3436.1 | 121784    | 18-Mar-22 | 23:49 | x64      |
| Txrowcount.dll                                              | 2017.140.3436.1 | 122808    | 18-Mar-22 | 23:49 | x64      |
| Txsort.dll                                                  | 2017.140.3436.1 | 250808    | 18-Mar-22 | 23:49 | x64      |
| Txsplit.dll                                                 | 2017.140.3436.1 | 590752    | 18-Mar-22 | 23:49 | x64      |
| Txunionall.dll                                              | 2017.140.3436.1 | 176056    | 18-Mar-22 | 23:49 | x64      |
| Xe.dll                                                      | 2017.140.3436.1 | 667576    | 18-Mar-22 | 23:50 | x64      |
| Xmlrw.dll                                                   | 2017.140.3436.1 | 299448    | 18-Mar-22 | 23:50 | x64      |
| Xmlsub.dll                                                  | 2017.140.3436.1 | 256416    | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2017.140.3436.1 | 1127840   | 18-Mar-22 | 23:49 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlsatellite.dll              | 2017.140.3436.1 | 917920    | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2017.140.3436.1 | 666552    | 18-Mar-22 | 23:49 | x64      |
| Fdhost.exe               | 2017.140.3436.1 | 110520    | 18-Mar-22 | 23:49 | x64      |
| Fdlauncher.exe           | 2017.140.3436.1 | 58272     | 18-Mar-22 | 23:49 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 18-Mar-22 | 23:49 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlft140ph.dll           | 2017.140.3436.1 | 63928     | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 14.0.3436.1     | 18360     | 18-Mar-22 | 23:48 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 18-Mar-22 | 23:46 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 18-Mar-22 | 23:48 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 18-Mar-22 | 23:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 18-Mar-22 | 23:48 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 18-Mar-22 | 23:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 18-Mar-22 | 23:48 | x86      |
| Commanddest.dll                                               | 2017.140.3436.1 | 195000    | 18-Mar-22 | 23:46 | x86      |
| Commanddest.dll                                               | 2017.140.3436.1 | 240056    | 18-Mar-22 | 23:48 | x64      |
| Dteparse.dll                                                  | 2017.140.3436.1 | 95160     | 18-Mar-22 | 23:46 | x86      |
| Dteparse.dll                                                  | 2017.140.3436.1 | 105912    | 18-Mar-22 | 23:48 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3436.1 | 77728     | 18-Mar-22 | 23:46 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3436.1 | 83360     | 18-Mar-22 | 23:48 | x64      |
| Dtepkg.dll                                                    | 2017.140.3436.1 | 111008    | 18-Mar-22 | 23:46 | x86      |
| Dtepkg.dll                                                    | 2017.140.3436.1 | 132000    | 18-Mar-22 | 23:48 | x64      |
| Dtexec.exe                                                    | 2017.140.3436.1 | 61856     | 18-Mar-22 | 23:46 | x86      |
| Dtexec.exe                                                    | 2017.140.3436.1 | 68024     | 18-Mar-22 | 23:48 | x64      |
| Dts.dll                                                       | 2017.140.3436.1 | 2545056   | 18-Mar-22 | 23:46 | x86      |
| Dts.dll                                                       | 2017.140.3436.1 | 2995104   | 18-Mar-22 | 23:48 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3436.1 | 412088    | 18-Mar-22 | 23:46 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3436.1 | 469408    | 18-Mar-22 | 23:48 | x64      |
| Dtsconn.dll                                                   | 2017.140.3436.1 | 396728    | 18-Mar-22 | 23:46 | x86      |
| Dtsconn.dll                                                   | 2017.140.3436.1 | 494520    | 18-Mar-22 | 23:48 | x64      |
| Dtsdebughost.exe.config                                       | n/a             | 1812      | 5-Aug-17  | 2:15  | n/a      |
| Dtsdebughost.exe                                              | 2017.140.3436.1 | 89520     | 18-Mar-22 | 23:46 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3436.1 | 105912    | 18-Mar-22 | 23:48 | x64      |
| Dtshost.exe                                                   | 2017.140.3436.1 | 85432     | 18-Mar-22 | 23:48 | x86      |
| Dtshost.exe                                                   | 2017.140.3436.1 | 100280    | 18-Mar-22 | 23:49 | x64      |
| Dtslog.dll                                                    | 2017.140.3436.1 | 97208     | 18-Mar-22 | 23:46 | x86      |
| Dtslog.dll                                                    | 2017.140.3436.1 | 114616    | 18-Mar-22 | 23:48 | x64      |
| Dtsmsg150.dll                                                 | 2017.140.3436.1 | 535480    | 18-Mar-22 | 23:48 | x86      |
| Dtsmsg150.dll                                                 | 2017.140.3436.1 | 539576    | 18-Mar-22 | 23:49 | x64      |
| Dtspipeline.dll                                               | 2017.140.3436.1 | 1054648   | 18-Mar-22 | 23:46 | x86      |
| Dtspipeline.dll                                               | 2017.140.3436.1 | 1262520   | 18-Mar-22 | 23:48 | x64      |
| Dtspipelineperf150.dll                                        | 2017.140.3436.1 | 36768     | 18-Mar-22 | 23:46 | x86      |
| Dtspipelineperf150.dll                                        | 2017.140.3436.1 | 42400     | 18-Mar-22 | 23:48 | x64      |
| Dtuparse.dll                                                  | 2017.140.3436.1 | 74656     | 18-Mar-22 | 23:46 | x86      |
| Dtuparse.dll                                                  | 2017.140.3436.1 | 83384     | 18-Mar-22 | 23:48 | x64      |
| Dtutil.exe                                                    | 2017.140.3436.1 | 121760    | 18-Mar-22 | 23:46 | x86      |
| Dtutil.exe                                                    | 2017.140.3436.1 | 142752    | 18-Mar-22 | 23:48 | x64      |
| Exceldest.dll                                                 | 2017.140.3436.1 | 208824    | 18-Mar-22 | 23:46 | x86      |
| Exceldest.dll                                                 | 2017.140.3436.1 | 254904    | 18-Mar-22 | 23:48 | x64      |
| Excelsrc.dll                                                  | 2017.140.3436.1 | 224696    | 18-Mar-22 | 23:46 | x86      |
| Excelsrc.dll                                                  | 2017.140.3436.1 | 276920    | 18-Mar-22 | 23:48 | x64      |
| Execpackagetask.dll                                           | 2017.140.3436.1 | 129440    | 18-Mar-22 | 23:46 | x86      |
| Execpackagetask.dll                                           | 2017.140.3436.1 | 162208    | 18-Mar-22 | 23:48 | x64      |
| Flatfiledest.dll                                              | 2017.140.3436.1 | 326560    | 18-Mar-22 | 23:46 | x86      |
| Flatfiledest.dll                                              | 2017.140.3436.1 | 380832    | 18-Mar-22 | 23:48 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3436.1 | 338360    | 18-Mar-22 | 23:46 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3436.1 | 393632    | 18-Mar-22 | 23:48 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3436.1 | 74680     | 18-Mar-22 | 23:46 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3436.1 | 90528     | 18-Mar-22 | 23:48 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 18-Mar-22 | 23:50 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 18-Mar-22 | 23:58 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3436.1     | 461240    | 18-Mar-22 | 23:46 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3436.1     | 460704    | 18-Mar-22 | 23:48 | x64      |
| Isserverexec.exe                                              | 14.0.3436.1     | 143264    | 18-Mar-22 | 23:46 | x86      |
| Isserverexec.exe                                              | 14.0.3436.1     | 142752    | 18-Mar-22 | 23:48 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.90     | 1375120   | 18-Mar-22 | 23:46 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.90     | 1375120   | 18-Mar-22 | 23:48 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 18-Mar-22 | 23:47 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 18-Mar-22 | 23:50 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 18-Mar-22 | 23:58 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3436.1     | 106400    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3436.1 | 101280    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3436.1 | 106400    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3436.1     | 49584     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3436.1     | 49592     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3436.1     | 83872     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3436.1     | 83872     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3436.1     | 67488     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3436.1     | 67488     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3436.1     | 508856    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3436.1     | 508856    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3436.1     | 77728     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3436.1     | 77728     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3436.1     | 410040    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3436.1     | 410016    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3436.1     | 386488    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3436.1     | 608672    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3436.1     | 608672    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3436.1     | 247224    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3436.1     | 247200    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3436.1     | 49056     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3436.1     | 49056     | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3436.1 | 136096    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3436.1 | 146336    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3436.1 | 139696    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3436.1 | 153504    | 18-Mar-22 | 23:49 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3436.1     | 213920    | 18-Mar-22 | 23:49 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3436.1 | 84408     | 18-Mar-22 | 23:46 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3436.1 | 97208     | 18-Mar-22 | 23:48 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.90 | 9192848   | 18-Mar-22 | 23:50 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 18-Mar-22 | 23:52 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 19-Mar-22 | 00:04  | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 18-Mar-22 | 23:50 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 18-Mar-22 | 23:58 | x86      |
| Oledbdest.dll                                                 | 2017.140.3436.1 | 208824    | 18-Mar-22 | 23:46 | x86      |
| Oledbdest.dll                                                 | 2017.140.3436.1 | 255392    | 18-Mar-22 | 23:48 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3436.1 | 227256    | 18-Mar-22 | 23:46 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3436.1 | 283040    | 18-Mar-22 | 23:48 | x64      |
| Rawdest.dll                                                   | 2017.140.3436.1 | 160696    | 18-Mar-22 | 23:48 | x86      |
| Rawdest.dll                                                   | 2017.140.3436.1 | 200608    | 18-Mar-22 | 23:49 | x64      |
| Rawsource.dll                                                 | 2017.140.3436.1 | 147384    | 18-Mar-22 | 23:48 | x86      |
| Rawsource.dll                                                 | 2017.140.3436.1 | 188320    | 18-Mar-22 | 23:49 | x64      |
| Recordsetdest.dll                                             | 2017.140.3436.1 | 143288    | 18-Mar-22 | 23:48 | x86      |
| Recordsetdest.dll                                             | 2017.140.3436.1 | 178616    | 18-Mar-22 | 23:49 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlceip.exe                                                   | 14.0.3436.1     | 269240    | 18-Mar-22 | 23:47 | x86      |
| Sqldest.dll                                                   | 2017.140.3436.1 | 207776    | 18-Mar-22 | 23:48 | x86      |
| Sqldest.dll                                                   | 2017.140.3436.1 | 254880    | 18-Mar-22 | 23:49 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3436.1 | 146360    | 18-Mar-22 | 23:48 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3436.1 | 177080    | 18-Mar-22 | 23:49 | x64      |
| Ssisdbbackup.bak                                              | n/a             | 5343744   | 18-Mar-22 | 23:50 | n/a      |
| Ssisoledb.dll                                                 | 2017.140.3436.1 | 170936    | 18-Mar-22 | 23:48 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3436.1 | 210360    | 18-Mar-22 | 23:49 | x64      |
| Txagg.dll                                                     | 2017.140.3436.1 | 296376    | 18-Mar-22 | 23:48 | x86      |
| Txagg.dll                                                     | 2017.140.3436.1 | 356256    | 18-Mar-22 | 23:49 | x64      |
| Txbdd.dll                                                     | 2017.140.3436.1 | 133536    | 18-Mar-22 | 23:48 | x86      |
| Txbdd.dll                                                     | 2017.140.3436.1 | 169376    | 18-Mar-22 | 23:49 | x64      |
| Txbestmatch.dll                                               | 2017.140.3436.1 | 487328    | 18-Mar-22 | 23:48 | x86      |
| Txbestmatch.dll                                               | 2017.140.3436.1 | 599480    | 18-Mar-22 | 23:49 | x64      |
| txcache.dll                                                   | 2017.140.3436.1 | 140216    | 18-Mar-22 | 23:48 | x86      |
| Txcache.dll                                                   | 2017.140.3436.1 | 174520    | 18-Mar-22 | 23:49 | x64      |
| Txcharmap.dll                                                 | 2017.140.3436.1 | 243128    | 18-Mar-22 | 23:48 | x86      |
| Txcharmap.dll                                                 | 2017.140.3436.1 | 280992    | 18-Mar-22 | 23:49 | x64      |
| Txcopymap.dll                                                 | 2017.140.3436.1 | 139704    | 18-Mar-22 | 23:48 | x86      |
| Txcopymap.dll                                                 | 2017.140.3436.1 | 179104    | 18-Mar-22 | 23:49 | x64      |
| Txdataconvert.dll                                             | 2017.140.3436.1 | 247224    | 18-Mar-22 | 23:48 | x86      |
| Txdataconvert.dll                                             | 2017.140.3436.1 | 287136    | 18-Mar-22 | 23:49 | x64      |
| Txderived.dll                                                 | 2017.140.3436.1 | 509856    | 18-Mar-22 | 23:48 | x86      |
| Txderived.dll                                                 | 2017.140.3436.1 | 598432    | 18-Mar-22 | 23:49 | x64      |
| Txfileextractor.dll                                           | 2017.140.3436.1 | 155040    | 18-Mar-22 | 23:48 | x86      |
| Txfileextractor.dll                                           | 2017.140.3436.1 | 192952    | 18-Mar-22 | 23:49 | x64      |
| Txfileinserter.dll                                            | 2017.140.3436.1 | 153528    | 18-Mar-22 | 23:48 | x86      |
| Txfileinserter.dll                                            | 2017.140.3436.1 | 190904    | 18-Mar-22 | 23:49 | x64      |
| Txgroupdups.dll                                               | 2017.140.3436.1 | 225184    | 18-Mar-22 | 23:48 | x86      |
| Txgroupdups.dll                                               | 2017.140.3436.1 | 284576    | 18-Mar-22 | 23:49 | x64      |
| Txlineage.dll                                                 | 2017.140.3436.1 | 104376    | 18-Mar-22 | 23:48 | x86      |
| Txlineage.dll                                                 | 2017.140.3436.1 | 131000    | 18-Mar-22 | 23:49 | x64      |
| Txlookup.dll                                                  | 2017.140.3436.1 | 440760    | 18-Mar-22 | 23:48 | x86      |
| Txlookup.dll                                                  | 2017.140.3436.1 | 522144    | 18-Mar-22 | 23:49 | x64      |
| Txmerge.dll                                                   | 2017.140.3436.1 | 170912    | 18-Mar-22 | 23:48 | x86      |
| Txmerge.dll                                                   | 2017.140.3436.1 | 224184    | 18-Mar-22 | 23:49 | x64      |
| Txmergejoin.dll                                               | 2017.140.3436.1 | 215992    | 18-Mar-22 | 23:48 | x86      |
| Txmergejoin.dll                                               | 2017.140.3436.1 | 269752    | 18-Mar-22 | 23:49 | x64      |
| Txmulticast.dll                                               | 2017.140.3436.1 | 96696     | 18-Mar-22 | 23:48 | x86      |
| Txmulticast.dll                                               | 2017.140.3436.1 | 121784    | 18-Mar-22 | 23:49 | x64      |
| Txpivot.dll                                                   | 2017.140.3436.1 | 174520    | 18-Mar-22 | 23:48 | x86      |
| Txpivot.dll                                                   | 2017.140.3436.1 | 219064    | 18-Mar-22 | 23:49 | x64      |
| Txrowcount.dll                                                | 2017.140.3436.1 | 96160     | 18-Mar-22 | 23:48 | x86      |
| Txrowcount.dll                                                | 2017.140.3436.1 | 122808    | 18-Mar-22 | 23:49 | x64      |
| Txsampling.dll                                                | 2017.140.3436.1 | 129976    | 18-Mar-22 | 23:48 | x86      |
| Txsampling.dll                                                | 2017.140.3436.1 | 166840    | 18-Mar-22 | 23:49 | x64      |
| Txscd.dll                                                     | 2017.140.3436.1 | 164280    | 18-Mar-22 | 23:48 | x86      |
| Txscd.dll                                                     | 2017.140.3436.1 | 214968    | 18-Mar-22 | 23:49 | x64      |
| Txsort.dll                                                    | 2017.140.3436.1 | 202168    | 18-Mar-22 | 23:48 | x86      |
| Txsort.dll                                                    | 2017.140.3436.1 | 250808    | 18-Mar-22 | 23:49 | x64      |
| Txsplit.dll                                                   | 2017.140.3436.1 | 504752    | 18-Mar-22 | 23:48 | x86      |
| Txsplit.dll                                                   | 2017.140.3436.1 | 590752    | 18-Mar-22 | 23:49 | x64      |
| Txtermextraction.dll                                          | 2017.140.3436.1 | 8609208   | 18-Mar-22 | 23:48 | x86      |
| Ttxtermextraction.dll                                         | 2017.140.3436.1 | 8670648   | 18-Mar-22 | 23:49 | x64      |
| Txtermlookup.dll                                              | 2017.140.3436.1 | 4101024   | 18-Mar-22 | 23:48 | x86      |
| Txtermlookup.dll                                              | 2017.140.3436.1 | 4151200   | 18-Mar-22 | 23:49 | x64      |
| Txunionall.dll                                                | 2017.140.3436.1 | 133560    | 18-Mar-22 | 23:48 | x86      |
| Txunionall.dll                                                | 2017.140.3436.1 | 176056    | 18-Mar-22 | 23:49 | x64      |
| Txunpivot.dll                                                 | 2017.140.3436.1 | 154528    | 18-Mar-22 | 23:48 | x86      |
| Txunpivot.dll                                                 | 2017.140.3436.1 | 193976    | 18-Mar-22 | 23:49 | x64      |
| Xe.dll                                                        | 2017.140.3436.1 | 589752    | 18-Mar-22 | 23:49 | x86      |
| Xe.dll                                                        | 2017.140.3436.1 | 667576    | 18-Mar-22 | 23:50 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                              | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                                  | 13.0.9124.22     | 523848    | 19-Mar-22 | 00:02  | x86      |
| Dmsnative.dll                                                            | 2016.130.9124.22 | 78408     | 19-Mar-22 | 00:02  | x64      |
| Dwengineservice.dll                                                      | 13.0.9124.22     | 45640     | 19-Mar-22 | 00:02  | x86      |
| Hadoop_chd5_avro_1_7_6_cdh5_14_4_jar.64                                  | n/a              | 477010    | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_auth_2_6_0_cdh5_14_4_jar.64                           | n/a              | 79200     | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_common_2_6_0_cdh5_14_4_jar.64                         | n/a              | 3568587   | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_hdfs_2_6_0_cdh5_14_4_jar.64                           | n/a              | 11711219  | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_mapreduce_client_common_2_6_0_cdh5_14_4_jar.64        | n/a              | 756671    | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_mapreduce_client_core_2_6_0_cdh5_14_4_jar.64          | n/a              | 1553184   | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_mapreduce_client_jobclient_2_6_0_cdh5_14_4_jar.64     | n/a              | 46074     | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_yarn_api_2_6_0_cdh5_14_4_jar.64                       | n/a              | 1931810   | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_yarn_client_2_6_0_cdh5_14_4_jar.64                    | n/a              | 160217    | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_hadoop_yarn_common_2_6_0_cdh5_14_4_jar.64                    | n/a              | 1562174   | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_httpclient_4_2_5_jar.64                                      | n/a              | 433368    | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_chd5_httpcore_4_2_5_jar.64                                        | n/a              | 227708    | 19-Mar-22 | 00:02  | n/a      |
| Hadoop_cloudera5_polybase_jar.64                                         | n/a              | 25624924  | 19-Mar-22 | 00:01  | n/a      |
| Hadoop_cloudera_polybase_jar.64                                          | n/a              | 25622197  | 19-Mar-22 | 00:01  | n/a      |
| Hadoop_conf_core_site_xml.64                                             | n/a              | 1353      | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_conf_hdfs_site_xml.64                                             | n/a              | 1602      | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdfsbridge_jar.64                                                 | n/a              | 21285     | 19-Mar-22 | 00:01  | n/a      |
| Hadoop_hdp2_2_azure_storage_5_3_0_jar.64                                 | n/a              | 734049    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_bin_hadoop_dll.64                                          | n/a              | 114944    | 18-Mar-22 | 23:44 | x64      |
| Hadoop_hdp2_2_bin_snappy_dll.64                                          | n/a              | 33032     | 18-Mar-22 | 23:44 | x64      |
| Hadoop_hdp2_2_hadoop_auth_2_7_3_2_6_4_104_1_jar.64                       | n/a              | 79251     | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_azure_2_7_1_2_3_2_0_2950_with_hadoop_13354_jar.64   | n/a              | 130552    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_azure_2_7_3_2_6_4_104_1_jar.64                      | n/a              | 261217    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_azure_datalake_2_7_3_2_6_4_104_1_jar.64             | n/a              | 23752     | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_common_2_7_3_2_6_4_104_1_jar.64                     | n/a              | 3668463   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_hdfs_2_7_3_2_6_4_104_1_jar.64                       | n/a              | 8770830   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_mapreduce_client_common_2_7_3_2_6_4_104_1_jar.64    | n/a              | 754243    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_mapreduce_client_core_2_7_3_2_6_4_104_1_jar.64      | n/a              | 1535624   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_mapreduce_client_jobclient_2_7_3_2_6_4_104_1_jar.64 | n/a              | 40354     | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_yarn_api_2_7_3_2_6_4_104_1_jar.64                   | n/a              | 2124933   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_yarn_client_2_7_3_2_6_4_104_1_jar.64                | n/a              | 202035    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_yarn_common_2_7_1_2_3_2_0_2950_jar.64               | n/a              | 1605366   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_hadoop_yarn_common_2_7_3_2_6_4_104_1_jar.64                | n/a              | 1816597   | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_httpclient_4_5_2_jar.64                                    | n/a              | 736658    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_httpcore_4_4_4_jar.64                                      | n/a              | 326724    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_jackson_core_2_2_3_jar.64                                  | n/a              | 192699    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_jersey_client_1_9_jar.64                                   | n/a              | 130458    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_jersey_core_1_9_jar.64                                     | n/a              | 458739    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_okhttp_2_4_0_jar.64                                        | n/a              | 319099    | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hdp2_2_okio_1_4_0_jar.64                                          | n/a              | 64661     | 18-Mar-22 | 23:44 | n/a      |
| Hadoop_hortonworks2_2_polybase_jar.64                                    | n/a              | 28099236  | 19-Mar-22 | 00:01  | n/a      |
| Hadoop_hortonworks2_polybase_jar.64                                      | n/a              | 28096509  | 19-Mar-22 | 00:01  | n/a      |
| Hadoop_polybase_jar.64                                                   | n/a              | 28539318  | 19-Mar-22 | 00:01  | n/a      |
| Instapi150.dll                                                           | 2017.140.3436.1  | 66488     | 19-Mar-22 | 00:02  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll              | 13.0.9124.22     | 74824     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                            | 13.0.9124.22     | 213576    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                             | 13.0.9124.22     | 1799240   | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                      | 13.0.9124.22     | 116808    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll                | 13.0.9124.22     | 390216    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll               | 13.0.9124.22     | 196168    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll          | 13.0.9124.22     | 131144    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll     | 13.0.9124.22     | 63048     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                        | 13.0.9124.22     | 55368     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                        | 13.0.9124.22     | 93768     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                             | 13.0.9124.22     | 792648    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll                 | 13.0.9124.22     | 87624     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                           | 13.0.9124.22     | 77896     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll                   | 13.0.9124.22     | 42056     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll                   | 13.0.9124.22     | 36936     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                    | 13.0.9124.22     | 47688     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll                | 13.0.9124.22     | 27208     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                           | 13.0.9124.22     | 32328     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll                | 13.0.9124.22     | 129608    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                       | 13.0.9124.22     | 95304     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                        | 13.0.9124.22     | 109128    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                       | 13.0.9124.22     | 264264    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 105032    | 19-Mar-22 | 00:00  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 119368    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 122440    | 19-Mar-22 | 00:01  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 118856    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 129096    | 19-Mar-22 | 00:06  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 121416    | 18-Mar-22 | 23:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 116296    | 18-Mar-22 | 23:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 149576    | 18-Mar-22 | 23:44 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 102984    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll             | 13.0.9124.22     | 118344    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                              | 13.0.9124.22     | 70216     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                    | 13.0.9124.22     | 28744     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                       | 13.0.9124.22     | 43592     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll                 | 13.0.9124.22     | 83528     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll      | 13.0.9124.22     | 136776    | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                                | 13.0.9124.22     | 2340936   | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                         | 13.0.9124.22     | 3860040   | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 110664    | 19-Mar-22 | 00:00  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 123464    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 128072    | 19-Mar-22 | 00:01  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 123976    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 136776    | 19-Mar-22 | 00:06  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 124488    | 18-Mar-22 | 23:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 121416    | 18-Mar-22 | 23:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 156232    | 18-Mar-22 | 23:44 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 108616    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll               | 13.0.9124.22     | 122952    | 18-Mar-22 | 23:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                     | 13.0.9124.22     | 70216     | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll              | 13.0.9124.22     | 2756168   | 19-Mar-22 | 00:02  | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                          | 13.0.9124.22     | 751688    | 19-Mar-22 | 00:02  | x86      |
| Mpdwinterop.dll                                                          | 2017.140.3436.1  | 401336    | 19-Mar-22 | 00:02  | x64      |
| Mpdwsvc.exe                                                              | 2017.140.3436.1  | 7325112   | 19-Mar-22 | 00:02  | x64      |
| Secforwarder.dll                                                         | 2017.140.3436.1  | 31672     | 19-Mar-22 | 00:02  | x64      |
| Sharedmemory.dll                                                         | 2016.130.9124.22 | 64584     | 19-Mar-22 | 00:02  | x64      |
| Sqldk.dll                                                                | 2017.140.3436.1  | 2737056   | 19-Mar-22 | 00:02  | x64      |
| Sqldumper.exe                                                            | 2017.140.3436.1  | 139704    | 19-Mar-22 | 00:02  | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 1500576   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3920312   | 18-Mar-22 | 23:58 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3218360   | 18-Mar-22 | 23:57 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3922872   | 18-Mar-22 | 23:47 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3826080   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 2093472   | 18-Mar-22 | 23:59 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 2039736   | 18-Mar-22 | 23:45 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3593656   | 18-Mar-22 | 23:44 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3601848   | 18-Mar-22 | 23:46 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 1447864   | 18-Mar-22 | 23:47 | x64      |
| Sqlevn70.rll                                                             | 2017.140.3436.1  | 3790776   | 18-Mar-22 | 23:44 | x64      |
| Sqlncli13e.dll                                                           | 2017.140.3436.1  | 2259384   | 19-Mar-22 | 00:02  | x64      |
| Sqlos.dll                                                                | 2017.140.3436.1  | 20384     | 19-Mar-22 | 00:02  | x64      |
| Sqlsortpdw.dll                                                           | 2016.130.9124.22 | 4347976   | 19-Mar-22 | 00:02  | x64      |
| Sqltses.dll                                                              | 2017.140.3436.1  | 9730464   | 19-Mar-22 | 00:02  | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 14.0.3436.1     | 18336     | 18-Mar-22 | 23:49 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time  | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                              | 2017.140.3436.1 | 1442720   | 18-Mar-22 | 23:48 | x86      |
| Dtaengine.exe                                              | 2017.140.3436.1 | 198584    | 18-Mar-22 | 23:46 | x86      |
| Dteparse.dll                                               | 2017.140.3436.1 | 95160     | 18-Mar-22 | 23:46 | x86      |
| Dteparse.dll                                               | 2017.140.3436.1 | 105912    | 18-Mar-22 | 23:48 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3436.1 | 77728     | 18-Mar-22 | 23:46 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3436.1 | 83360     | 18-Mar-22 | 23:48 | x64      |
| Dtepkg.dll                                                 | 2017.140.3436.1 | 111008    | 18-Mar-22 | 23:46 | x86      |
| Dtepkg.dll                                                 | 2017.140.3436.1 | 132000    | 18-Mar-22 | 23:48 | x64      |
| Dtexec.exe                                                 | 2017.140.3436.1 | 61856     | 18-Mar-22 | 23:46 | x86      |
| Dtexec.exe                                                 | 2017.140.3436.1 | 68024     | 18-Mar-22 | 23:48 | x64      |
| Dts.dll                                                    | 2017.140.3436.1 | 2545056   | 18-Mar-22 | 23:46 | x86      |
| Dts.dll                                                    | 2017.140.3436.1 | 2995104   | 18-Mar-22 | 23:48 | x64      |
| Dts.tlb                                                    | n/a             | 191356    | 18-Mar-22 | 23:50 | n/a      |
| Dtscomexpreval.dll                                         | 2017.140.3436.1 | 412088    | 18-Mar-22 | 23:46 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3436.1 | 469408    | 18-Mar-22 | 23:48 | x64      |
| Dtsconn.dll                                                | 2017.140.3436.1 | 396728    | 18-Mar-22 | 23:46 | x86      |
| Dtsconn.dll                                                | 2017.140.3436.1 | 494520    | 18-Mar-22 | 23:48 | x64      |
| Dtshost.exe                                                | 2017.140.3436.1 | 85432     | 18-Mar-22 | 23:48 | x86      |
| Dtshost.exe                                                | 2017.140.3436.1 | 100280    | 18-Mar-22 | 23:49 | x64      |
| Dtslog.dll                                                 | 2017.140.3436.1 | 97208     | 18-Mar-22 | 23:46 | x86      |
| Dtslog.dll                                                 | 2017.140.3436.1 | 114616    | 18-Mar-22 | 23:48 | x64      |
| Dtsmsg.h                                                   | n/a             | 774777    | 18-Mar-22 | 23:50 | n/a      |
| Dtsmsg150.dll                                              | 2017.140.3436.1 | 535480    | 18-Mar-22 | 23:48 | x86      |
| Dtsmsg150.dll                                              | 2017.140.3436.1 | 539576    | 18-Mar-22 | 23:49 | x64      |
| Dtspipeline.dll                                            | 2017.140.3436.1 | 1054648   | 18-Mar-22 | 23:46 | x86      |
| Dtspipeline.dll                                            | 2017.140.3436.1 | 1262520   | 18-Mar-22 | 23:48 | x64      |
| Dtspipeline.tlb                                            | n/a             | 86280     | 18-Mar-22 | 23:50 | n/a      |
| Dtspipelineperf150.dll                                     | 2017.140.3436.1 | 36768     | 18-Mar-22 | 23:46 | x86      |
| Dtspipelineperf150.dll                                     | 2017.140.3436.1 | 42400     | 18-Mar-22 | 23:48 | x64      |
| Dtuparse.dll                                               | 2017.140.3436.1 | 74656     | 18-Mar-22 | 23:46 | x86      |
| Dtuparse.dll                                               | 2017.140.3436.1 | 83384     | 18-Mar-22 | 23:48 | x64      |
| Dtutil.exe                                                 | 2017.140.3436.1 | 121760    | 18-Mar-22 | 23:46 | x86      |
| Dtutil.exe                                                 | 2017.140.3436.1 | 142752    | 18-Mar-22 | 23:48 | x64      |
| Exceldest.dll                                              | 2017.140.3436.1 | 208824    | 18-Mar-22 | 23:46 | x86      |
| Exceldest.dll                                              | 2017.140.3436.1 | 254904    | 18-Mar-22 | 23:48 | x64      |
| Excelsrc.dll                                               | 2017.140.3436.1 | 224696    | 18-Mar-22 | 23:46 | x86      |
| Excelsrc.dll                                               | 2017.140.3436.1 | 276920    | 18-Mar-22 | 23:48 | x64      |
| Flatfiledest.dll                                           | 2017.140.3436.1 | 326560    | 18-Mar-22 | 23:46 | x86      |
| Flatfiledest.dll                                           | 2017.140.3436.1 | 380832    | 18-Mar-22 | 23:48 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3436.1 | 338360    | 18-Mar-22 | 23:46 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3436.1 | 393632    | 18-Mar-22 | 23:48 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3436.1 | 74680     | 18-Mar-22 | 23:46 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3436.1 | 90528     | 18-Mar-22 | 23:48 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3436.1     | 106424    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3436.1     | 180664    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3436.1     | 404408    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3436.1     | 404384    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3436.1     | 2087840   | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3436.1     | 2087840   | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3436.1     | 608672    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3436.1     | 608672    | 18-Mar-22 | 23:49 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3436.1     | 247224    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3436.1     | 49056     | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3436.1 | 136096    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3436.1 | 146336    | 18-Mar-22 | 23:49 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3436.1 | 139696    | 18-Mar-22 | 23:48 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3436.1 | 153504    | 18-Mar-22 | 23:49 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3436.1 | 84408     | 18-Mar-22 | 23:46 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3436.1 | 97208     | 18-Mar-22 | 23:48 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.90 | 7305104   | 18-Mar-22 | 23:49 | x86      |
| Oledbdest.dll                                              | 2017.140.3436.1 | 208824    | 18-Mar-22 | 23:46 | x86      |
| Oledbdest.dll                                              | 2017.140.3436.1 | 255392    | 18-Mar-22 | 23:48 | x64      |
| Oledbsrc.dll                                               | 2017.140.3436.1 | 227256    | 18-Mar-22 | 23:46 | x86      |
| Oledbsrc.dll                                               | 2017.140.3436.1 | 283040    | 18-Mar-22 | 23:48 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3436.1 | 94624     | 18-Mar-22 | 23:48 | x64      |
| Sqlresld.dll                                               | 2017.140.3436.1 | 22944     | 18-Mar-22 | 23:48 | x86      |
| Sqlresld.dll                                               | 2017.140.3436.1 | 25016     | 18-Mar-22 | 23:49 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3436.1 | 23480     | 18-Mar-22 | 23:48 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3436.1 | 26552     | 18-Mar-22 | 23:49 | x64      |
| Sqlscm.dll                                                 | 2017.140.3436.1 | 56248     | 18-Mar-22 | 23:48 | x86      |
| Sqlscm.dll                                                 | 2017.140.3436.1 | 67000     | 18-Mar-22 | 23:49 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3436.1 | 129440    | 18-Mar-22 | 23:48 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3436.1 | 157088    | 18-Mar-22 | 23:49 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3436.1 | 146360    | 18-Mar-22 | 23:48 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3436.1 | 177080    | 18-Mar-22 | 23:49 | x64      |
| Txdataconvert.dll                                          | 2017.140.3436.1 | 247224    | 18-Mar-22 | 23:48 | x86      |
| Txdataconvert.dll                                          | 2017.140.3436.1 | 287136    | 18-Mar-22 | 23:49 | x64      |
| Xe.dll                                                     | 2017.140.3436.1 | 589752    | 18-Mar-22 | 23:49 | x86      |
| Xe.dll                                                     | 2017.140.3436.1 | 667576    | 18-Mar-22 | 23:50 | x64      |
| Xmlrw.dll                                                  | 2017.140.3436.1 | 251832    | 18-Mar-22 | 23:49 | x86      |
| Xmlrw.dll                                                  | 2017.140.3436.1 | 299448    | 18-Mar-22 | 23:50 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3436.1 | 183736    | 18-Mar-22 | 23:49 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3436.1 | 218552    | 18-Mar-22 | 23:50 | x64      |

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
