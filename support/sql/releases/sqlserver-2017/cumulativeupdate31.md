---
title: Cumulative update 31 for SQL Server 2017 (KB5016884)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 31 (KB5016884).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5016884, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5016884 - Cumulative Update 31 for SQL Server 2017

_Release Date:_ &nbsp; September 20, 2022  
_Version:_ &nbsp; 14.0.3456.2

> [!NOTE]
> Cumulative Update 31 is the last cumulative update for Microsoft SQL Server 2017. SQL Server 2017 is transitioned to [extended support](/lifecycle/products/sql-server-2017) after October 11, 2022.

## Summary

This article describes Cumulative Update package 31 (CU31) for Microsoft SQL Server 2017. This update contains 19 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 30, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3456.2**, file version: **2017.140.3456.2**
- Analysis Services - Product version: **14.0.249.94**, file version: **2017.140.249.94**

## Known issues in this update

Assume that a table used by replication uses a column that uses the `NEWSEQUENTIALID` function in the primary key. An error occurs when you attempt to apply the snapshot at the subscriber. Here are the commands attempted and error messages:

- Command attempted:

```sql
create procedure [sp_MSupd_PersonAddress]

@c1 int = NULL,

@c2 nvarchar(60) = NULL,

@c3 nvarchar(60) = NULL,

@c4 nvarchar(30) = NULL,

@c5 int = NULL,

@c6 nvarchar(15) = NULL,

@c7 [geography] = NULL,

@c8 uniqueidentifier = NULL,

@c9 datetime = NULL,

@pkc1 uniqueidentifier = NULL,

@bitmap binary(2)

as

begin 

declare @primarykey_text nvarchar(100) = ''

if (substring(@bitmap,1,1) & 128 = 128)

begin

if @pkc1 is null

     set @pkc1 = (newsequentialid())

update [Person].[

(Transaction sequence number: 0x0000002400000F30005500000000, Command ID: 7)
```
- Error messages:

> The newsequentialid() built-in function can only be used in a DEFAULT expression for a column of type 'uniqueidentifier' in a CREATE TABLE or ALTER TABLE statement. It cannot be combined with other operators to form a complex scalar expression. (Source: MSSQLServer, Error number: 302) </br></br>Get help: http://help/302

> [!NOTE]
> The only way to resolve this issue is to change the primary key column to the `NEWID` function while you take the snapshot and then set it back to the `NEWSEQUENTIALID` function after the snapshot is applied. You can run the following command:

```sql
ALTER TABLE [Person].[Address] DROP CONSTRAINT [PK_Address_rowguid]

GO

ALTER TABLE [Person].[Address] ADD  CONSTRAINT [PK_Address_rowguid]  DEFAULT (NEWID()) FOR [rowguid]

GO

ALTER TABLE [Person].[Address] DROP CONSTRAINT [PK_Address_rowguid]

GO

ALTER TABLE [Person].[Address] ADD  CONSTRAINT [PK_Address_rowguid]  DEFAULT (NEWSEQUENTIALID()) FOR [rowguid]

GO
```
## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|----------|
| <a id=14915051>[14915051](#14915051) </a> | Resolves the Denial of Service (DoS) vulnerability for the Newtonsoft library in SQL Server 2017.| Analysis Services | Analysis Services | Windows |
| <a id=14676488>[14676488](#14676488) </a> | Error 9003 occurs with the incorrect log sequence number (LSN) when you do a subsequent restore after specifying the LSN at the virtual log file (VLF) boundary by using the `RESTORE WITH STANDBY` statement. Here's the error message: </br></br>Msg 3013, Level 16, State 1, Line \<LineNumber> </br></br>RESTORE DATABASE is terminating abnormally. </br></br>Msg 9003, Level 17, State 11, Line \<LineNumber> </br></br>The log scan number (\<LogScanNumber>) passed to log scan in database '\<DatabaseName>' isn't valid. This error may indicate data corruption or that the log file (.ldf) doesn't match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup. | SQL Server Engine | Backup Restore | Windows |
| <a id=14924205>[14924205](#14924205) </a> | Non-yielding dumps occur frequently on ColumnStoreAttributeCache::ColumnStoreColumnAttributeNode::GetSegmentById.| SQL Server Engine | Column Stores | Windows |
| <a id=14989388>[14989388](#14989388) </a> | The filegroup IDs of the files that belong to the clone database can be incorrect if the source database has gaps in the filegroup IDs due to the removal of files or filegroups. When you try to insert data into the table that belongs to the incorrectly generated clone database, you receive an error message that resembles the following message: </br></br>Msg 622, Level 16, State 3, Line \<LineNumber> </br></br>The filegroup "\<FileGroupName>" has no files assigned to it. Tables, indexes, text columns, ntext columns, and image columns can't be populated on this filegroup until a file is added. | SQL Server Engine | DB Management | Windows |
| <a id=14964725>[14964725](#14964725) </a> | The FILESTREAM feature isn't enabled after you restart the operating system because of race conditions from multiple instances of SQL Server. In the error log, you can see the following error message: </br></br>Error: 5591, Severity: 16, State: 5. FILESTREAM feature is disabled. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=14860451>[14860451](#14860451) </a> | The read-only request still goes to the read-write primary node in an Always On availability group when the read-only routing list node goes down. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=14904061>[14904061](#14904061) </a> | An assertion failure occurs on secondary replica when you use Always On availability groups in high-latency networks in SQL Server 2017. </br></br>You may see this assertion failure in the error log: </br></br>Assertion: File: <"e:\\\b\\\s3\\\sources\\\sql\\\ntdbms\\\storeng\\\dfs\\\trans\\\lsnlocmap.cpp">, line=358 Failed Assertion = 'pos - pndx < map->EntryCount'| SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=14209349>[14209349](#14209349) </a> | Memory-optimized tempdb metadata (HkTempDB) keeps consuming memory under VARHEAP: LOB Page Allocator.| SQL Server Engine | In-Memory OLTP | Windows |
| <a id=14923181>[14923181](#14923181) </a> | A memory leak occurs in the range index of in-memory tables after the parallel index scan. | SQL Server Engine | In-Memory OLTP| All |
| <a id=14923920>[14923920](#14923920) </a> | A memory leak occurs under "Range Index Heap" on the in-memory table that has non-clustered indexes, whenever there are concurrent inserts.| SQL Server Engine | In-Memory OLTP | All |
| <a id=13766490>[13766490](#13766490) </a> | Performance issues and deadlocks occur on SQL Server Agent in the msdb database that has automated backups. In addition, you see the following error messages in the SQL Server Agent log: </br></br>\<DateTime> SQLServer Error: 1205, Transaction (Process ID) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. </br></br>\<DateTime> Failed to retrieve job \<JobID> from the server.| SQL Server Engine | Management Services | Windows |
| <a id=15009086>[15009086](#15009086) </a> | An access violation may occur after you apply SQL Server 2017 Cumulative Update 30 (CU30). This issue can occur when you perform a bulk insert operation followed by a `SELECT` statement in the same transaction, and the database's recovery model is either simple or bulk-logged.| SQL Server Engine |Methods to access stored data| All|
| <a id=14979530>[14979530](#14979530) </a> | [FIX: Installing SQL Server CUs may trigger IndexOutOfRangeException (KB5017551)](https://support.microsoft.com/help/5017551)| SQL Setup | Patching | Windows |
| <a id=14976696>[14976696](#14976696) </a> | [FIX: ParameterRuntimeValue is missing from the Showplan XML when you use the DMV sys.dm_exec_query_statistics_xml (KB5017788)](https://support.microsoft.com/help/5017788)| SQL Server Engine | Query Execution | All |
| <a id=14876278>[14876278](#14876278) </a> | A non-yielding scheduler dump occurs in `sqldk!SOS_MemoryWorkSpace::Lookup`. | SQL Server Engine | Query Execution | All |
| <a id=14918513>[14918513](#14918513) </a> | [FIX: ForceLastGoodPlan doesn't account for aborted and timed out queries in regression detection logic (KB5008184)](https://support.microsoft.com/help/5008184) | SQL Server Engine | Query Store | All |
| <a id=14810743>[14810743](#14810743) </a> | [FIX: Error 20598 after adding columns that have default constraints as part of the primary key for an existing table and configuring transactional replication (KB5018231)](https://support.microsoft.com/help/5018231) | SQL Server Engine | Replication | Windows |
| <a id=14914142>[14914142](#14914142) </a> | Error 208 occurs when you use the`sp_changereplicationserverpasswords` stored procedure to change stored passwords for the Microsoft SQL Server login used by replication agents. Here's the error message: </br></br>Msg 208, Level 16, State 1, Procedure master.sys.sp_MSchangerepltablepasswords, Line \<LineNumber> [Batch Start Line 0] </br></br>Invalid object name 'MSreplservers'. | SQL Server Engine | Replication | Windows |
| <a id=14962805>[14962805](#14962805) </a> | High CPU usage occurs when you enable change tracking on a large number of tables and do automatic or manual cleanup of the change tracking tables. | SQL Server Engine | Replication | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

> [!NOTE]
>
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU31 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/09/sqlserver2017-kb5016884-x64_ff02621395c103b1381924f4c4b137901a870261.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5016884-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5016884-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5016884-x64.exe|AE3554BA0A474B4D1A6B2D3BB7F00A4F6308DBE50178FFF67BAA8B21CC74DBC2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date     | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.94 | 260520    | 2-Sep-22 | 21:50 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.94     | 736672    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.94     | 1375136   | 2-Sep-22 | 21:50 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.94     | 978856    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.94     | 582056    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 2-Sep-22 | 21:30 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 2-Sep-22 | 21:28 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 2-Sep-22 | 21:28 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 2-Sep-22 | 21:28 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 2-Sep-22 | 21:28 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 2-Sep-22 | 21:28 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 2-Sep-22 | 21:28 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 2-Sep-22 | 21:28 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 2-Sep-22 | 21:28 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 2-Sep-22 | 21:28 | x86      |
| Msmdctr.dll                                        | 2017.140.249.94 | 34216     | 2-Sep-22 | 21:51 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.94 | 40421288  | 2-Sep-22 | 21:48 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.94 | 60767160  | 2-Sep-22 | 21:51 | x64      |
| Msmdpump.dll                                       | 2017.140.249.94 | 9334184   | 2-Sep-22 | 21:51 | x64      |
| Msmdredir.dll                                      | 2017.140.249.94 | 7089568   | 2-Sep-22 | 21:48 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.94 | 60669352  | 2-Sep-22 | 21:51 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.94 | 7306144   | 2-Sep-22 | 21:48 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.94 | 9001888   | 2-Sep-22 | 21:51 | x64      |
| Msolap.dll                                         | 2017.140.249.94 | 7773624   | 2-Sep-22 | 21:48 | x86      |
| Msolap.dll                                         | 2017.140.249.94 | 10257832  | 2-Sep-22 | 21:51 | x64      |
| Msolui.dll                                         | 2017.140.249.94 | 281504    | 2-Sep-22 | 21:48 | x86      |
| Msolui.dll                                         | 2017.140.249.94 | 305056    | 2-Sep-22 | 21:51 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 2-Sep-22 | 21:28 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 2-Sep-22 | 21:28 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlboot.dll                                        | 2017.140.3456.2 | 191912    | 2-Sep-22 | 21:51 | x64      |
| Sqlceip.exe                                        | 14.0.3456.2     | 269216    | 2-Sep-22 | 21:30 | x86      |
| Sqldumper.exe                                      | 2017.140.3456.2 | 139688    | 2-Sep-22 | 21:29 | x64      |
| Sqldumper.exe                                      | 2017.140.3456.2 | 117176    | 2-Sep-22 | 21:47 | x86      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 2-Sep-22 | 21:28 | x86      |
| Tmapi.dll                                          | 2017.140.249.94 | 5815712   | 2-Sep-22 | 21:53 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.94 | 4158888   | 2-Sep-22 | 21:53 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.94 | 1126312   | 2-Sep-22 | 21:53 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.94 | 1637288   | 2-Sep-22 | 21:53 | x64      |
| Xe.dll                                             | 2017.140.3456.2 | 667576    | 2-Sep-22 | 21:53 | x64      |
| Xmlrw.dll                                          | 2017.140.3456.2 | 251816    | 2-Sep-22 | 21:48 | x86      |
| Xmlrw.dll                                          | 2017.140.3456.2 | 299424    | 2-Sep-22 | 21:53 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3456.2 | 183712    | 2-Sep-22 | 21:48 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3456.2 | 218552    | 2-Sep-22 | 21:53 | x64      |
| Xmsrv.dll                                          | 2017.140.249.94 | 33350560  | 2-Sep-22 | 21:48 | x86      |
| Xmsrv.dll                                          | 2017.140.249.94 | 25377192  | 2-Sep-22 | 21:53 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date     | Time  | Platform |
|--------------------------------------------|------------------|-----------|----------|-------|----------|
| Batchparser.dll                            | 2017.140.3456.2  | 154552    | 2-Sep-22 | 21:43 | x86      |
| Batchparser.dll                            | 2017.140.3456.2  | 175016    | 2-Sep-22 | 21:50 | x64      |
| Instapi150.dll                             | 2017.140.3456.2  | 56744     | 2-Sep-22 | 21:48 | x86      |
| Instapi150.dll                             | 2017.140.3456.2  | 66472     | 2-Sep-22 | 21:51 | x64      |
| Isacctchange.dll                           | 2017.140.3456.2  | 23480     | 2-Sep-22 | 21:46 | x86      |
| Isacctchange.dll                           | 2017.140.3456.2  | 25016     | 2-Sep-22 | 21:50 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.94      | 1082784   | 2-Sep-22 | 21:47 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.94      | 1082784   | 2-Sep-22 | 21:50 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.94      | 1375648   | 2-Sep-22 | 21:46 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.94      | 735648    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.94      | 735656    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3456.2      | 31672     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3456.2  | 72632     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3456.2  | 76216     | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3456.2      | 565664    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3456.2      | 565664    | 2-Sep-22 | 21:51 | x86      |
| Msasxpress.dll                             | 2017.140.249.94  | 26016     | 2-Sep-22 | 21:48 | x86      |
| Msasxpress.dll                             | 2017.140.249.94  | 30112     | 2-Sep-22 | 21:51 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3456.2  | 63416     | 2-Sep-22 | 21:48 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3456.2  | 78264     | 2-Sep-22 | 21:51 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3456.2  | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqldumper.exe                              | 2017.140.3456.2  | 139688    | 2-Sep-22 | 21:29 | x64      |
| Sqldumper.exe                              | 2017.140.3456.2  | 117176    | 2-Sep-22 | 21:47 | x86      |
| Sqlftacct.dll                              | 2017.140.3456.2  | 50080     | 2-Sep-22 | 21:48 | x86      |
| Sqlftacct.dll                              | 2017.140.3456.2  | 58272     | 2-Sep-22 | 21:51 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 2-Sep-22 | 21:47 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 2-Sep-22 | 21:51 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3456.2  | 369576    | 2-Sep-22 | 21:47 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3456.2  | 414120    | 2-Sep-22 | 21:51 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3456.2  | 29088     | 2-Sep-22 | 21:48 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3456.2  | 31672     | 2-Sep-22 | 21:51 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3456.2  | 268200    | 2-Sep-22 | 21:48 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3456.2  | 352160    | 2-Sep-22 | 21:51 | x64      |
| Sqltdiagn.dll                              | 2017.140.3456.2  | 54696     | 2-Sep-22 | 21:47 | x86      |
| Sqltdiagn.dll                              | 2017.140.3456.2  | 61864     | 2-Sep-22 | 21:51 | x64      |
| Svrenumapi150.dll                          | 2017.140.3456.2  | 889256    | 2-Sep-22 | 21:48 | x86      |
| Svrenumapi150.dll                          | 2017.140.3456.2  | 1168808   | 2-Sep-22 | 21:51 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date     | Time  | Platform |
|---------------------|-----------------|-----------|----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 2-Sep-22 | 21:48 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 2-Sep-22 | 21:48 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 2-Sep-22 | 21:48 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 2-Sep-22 | 21:48 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date     | Time  | Platform |
|---------------------------------------------------|--------------|-----------|----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 2-Sep-22 | 21:50 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date     | Time  | Platform |
|--------------------------------|-----------------|-----------|----------|-------|----------|
| Dreplayclient.exe              | 2017.140.3456.2 | 115104    | 2-Sep-22 | 21:43 | x86      |
| Dreplaycommon.dll              | 2017.140.3456.2 | 694176    | 2-Sep-22 | 21:43 | x86      |
| Dreplayserverps.dll            | 2017.140.3456.2 | 27064     | 2-Sep-22 | 21:43 | x86      |
| Dreplayutil.dll                | 2017.140.3456.2 | 304552    | 2-Sep-22 | 21:43 | x86      |
| Instapi150.dll                 | 2017.140.3456.2 | 66472     | 2-Sep-22 | 21:51 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlresourceloader.dll          | 2017.140.3456.2 | 23480     | 2-Sep-22 | 21:47 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date     | Time  | Platform |
|------------------------------------|-----------------|-----------|----------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3456.2 | 694176    | 2-Sep-22 | 21:43 | x86      |
| Dreplaycontroller.exe              | 2017.140.3456.2 | 344488    | 2-Sep-22 | 21:43 | x86      |
| Dreplayprocess.dll                 | 2017.140.3456.2 | 165800    | 2-Sep-22 | 21:43 | x86      |
| Dreplayserverps.dll                | 2017.140.3456.2 | 27064     | 2-Sep-22 | 21:43 | x86      |
| Instapi150.dll                     | 2017.140.3456.2 | 66472     | 2-Sep-22 | 21:51 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlresourceloader.dll              | 2017.140.3456.2 | 23480     | 2-Sep-22 | 21:47 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date     | Time  | Platform |
|----------------------------------------------|-----------------|-----------|----------|-------|----------|
| Backuptourl.exe                              | 14.0.3456.2     | 34720     | 2-Sep-22 | 21:50 | x64      |
| Batchparser.dll                              | 2017.140.3456.2 | 175016    | 2-Sep-22 | 21:50 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 2-Sep-22 | 21:29 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 2-Sep-22 | 21:29 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 2-Sep-22 | 21:29 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 2-Sep-22 | 21:45 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 2-Sep-22 | 21:50 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3456.2 | 221600    | 2-Sep-22 | 21:50 | x64      |
| Dcexec.exe                                   | 2017.140.3456.2 | 68512     | 2-Sep-22 | 21:50 | x64      |
| Fssres.dll                                   | 2017.140.3456.2 | 84896     | 2-Sep-22 | 21:51 | x64      |
| Hadrres.dll                                  | 2017.140.3456.2 | 183720    | 2-Sep-22 | 21:51 | x64      |
| Hkcompile.dll                                | 2017.140.3456.2 | 1417112   | 2-Sep-22 | 21:51 | x64      |
| Hkengine.dll                                 | 2017.140.3456.2 | 5857208   | 2-Sep-22 | 21:51 | x64      |
| Hkruntime.dll                                | 2017.140.3456.2 | 157088    | 2-Sep-22 | 21:51 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 2-Sep-22 | 21:29 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.94     | 735144    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 2-Sep-22 | 21:30 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3456.2     | 232864    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3456.2     | 74144     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3456.2 | 386984    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3456.2 | 66472     | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3456.2 | 59304     | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3456.2 | 146344    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3456.2 | 153504    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3456.2 | 297888    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3456.2 | 69024     | 2-Sep-22 | 21:51 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 2-Sep-22 | 21:29 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 2-Sep-22 | 21:29 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 2-Sep-22 | 21:29 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 2-Sep-22 | 21:29 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 2-Sep-22 | 21:29 | x64      |
| Odsole70.dll                                 | 2017.140.3456.2 | 86944     | 2-Sep-22 | 21:51 | x64      |
| Opends60.dll                                 | 2017.140.3456.2 | 27048     | 2-Sep-22 | 21:51 | x64      |
| Qds.dll                                      | 2017.140.3456.2 | 1179040   | 2-Sep-22 | 21:51 | x64      |
| Rsfxft.dll                                   | 2017.140.3456.2 | 29112     | 2-Sep-22 | 21:51 | x64      |
| Secforwarder.dll                             | 2017.140.3456.2 | 31648     | 2-Sep-22 | 21:51 | x64      |
| Sqagtres.dll                                 | 2017.140.3456.2 | 70072     | 2-Sep-22 | 21:51 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlaamss.dll                                 | 2017.140.3456.2 | 85944     | 2-Sep-22 | 21:51 | x64      |
| Sqlaccess.dll                                | 2017.140.3456.2 | 469944    | 2-Sep-22 | 21:51 | x64      |
| Sqlagent.exe                                 | 2017.140.3456.2 | 599464    | 2-Sep-22 | 21:51 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3456.2 | 48568     | 2-Sep-22 | 21:47 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3456.2 | 57272     | 2-Sep-22 | 21:51 | x64      |
| Sqlagentlog.dll                              | 2017.140.3456.2 | 27048     | 2-Sep-22 | 21:51 | x64      |
| Sqlagentmail.dll                             | 2017.140.3456.2 | 48056     | 2-Sep-22 | 21:51 | x64      |
| Sqlboot.dll                                  | 2017.140.3456.2 | 191912    | 2-Sep-22 | 21:51 | x64      |
| Sqlceip.exe                                  | 14.0.3456.2     | 269216    | 2-Sep-22 | 21:30 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3456.2 | 68536     | 2-Sep-22 | 21:51 | x64      |
| Sqlctr140.dll                                | 2017.140.3456.2 | 107448    | 2-Sep-22 | 21:48 | x86      |
| Sqlctr140.dll                                | 2017.140.3456.2 | 124848    | 2-Sep-22 | 21:51 | x64      |
| Sqldk.dll                                    | 2017.140.3456.2 | 2806184   | 2-Sep-22 | 21:51 | x64      |
| Sqldtsss.dll                                 | 2017.140.3456.2 | 103336    | 2-Sep-22 | 21:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 1500584   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3301792   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3486624   | 2-Sep-22 | 21:28 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3920288   | 2-Sep-22 | 21:42 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 4032920   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3218328   | 2-Sep-22 | 21:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3372456   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3922848   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3792296   | 2-Sep-22 | 21:40 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3826080   | 2-Sep-22 | 21:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 2093480   | 2-Sep-22 | 21:46 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 2039712   | 2-Sep-22 | 21:45 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3641256   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3343776   | 2-Sep-22 | 21:28 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3785128   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3593624   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3601816   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3407784   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3296160   | 2-Sep-22 | 21:41 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 1447840   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3682712   | 2-Sep-22 | 21:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3456.2 | 3790752   | 2-Sep-22 | 21:29 | x64      |
| Sqliosim.com                                 | 2017.140.3456.2 | 307624    | 2-Sep-22 | 21:51 | x64      |
| Sqliosim.exe                                 | 2017.140.3456.2 | 3014056   | 2-Sep-22 | 21:51 | x64      |
| Sqllang.dll                                  | 2017.140.3456.2 | 41384344  | 2-Sep-22 | 21:51 | x64      |
| Sqlmin.dll                                   | 2017.140.3456.2 | 40599968  | 2-Sep-22 | 21:51 | x64      |
| Sqlolapss.dll                                | 2017.140.3456.2 | 103336    | 2-Sep-22 | 21:51 | x64      |
| Sqlos.dll                                    | 2017.140.3456.2 | 20376     | 2-Sep-22 | 21:51 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3456.2 | 63912     | 2-Sep-22 | 21:51 | x64      |
| Sqlrepss.dll                                 | 2017.140.3456.2 | 62888     | 2-Sep-22 | 21:51 | x64      |
| Sqlresld.dll                                 | 2017.140.3456.2 | 25016     | 2-Sep-22 | 21:51 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3456.2 | 26552     | 2-Sep-22 | 21:51 | x64      |
| Sqlscm.dll                                   | 2017.140.3456.2 | 66976     | 2-Sep-22 | 21:51 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3456.2 | 21944     | 2-Sep-22 | 21:51 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3456.2 | 5893560   | 2-Sep-22 | 21:51 | x64      |
| Sqlserverspatial150.dll                      | 2017.140.3456.2 | 726944    | 2-Sep-22 | 21:51 | x64      |
| Sqlservr.exe                                 | 2017.140.3456.2 | 482712    | 2-Sep-22 | 21:51 | x64      |
| Sqlsvc.dll                                   | 2017.140.3456.2 | 157112    | 2-Sep-22 | 21:51 | x64      |
| Sqltses.dll                                  | 2017.140.3456.2 | 9560480   | 2-Sep-22 | 21:51 | x64      |
| Sqsrvres.dll                                 | 2017.140.3456.2 | 256936    | 2-Sep-22 | 21:51 | x64      |
| Stretchcodegen.exe                           | 14.0.3456.2     | 50600     | 2-Sep-22 | 21:51 | x86      |
| Svl.dll                                      | 2017.140.3456.2 | 147872    | 2-Sep-22 | 21:51 | x64      |
| Xe.dll                                       | 2017.140.3456.2 | 667576    | 2-Sep-22 | 21:53 | x64      |
| Xmlrw.dll                                    | 2017.140.3456.2 | 299424    | 2-Sep-22 | 21:53 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3456.2 | 218552    | 2-Sep-22 | 21:53 | x64      |
| Xpadsi.exe                                   | 2017.140.3456.2 | 85928     | 2-Sep-22 | 21:51 | x64      |
| Xplog70.dll                                  | 2017.140.3456.2 | 72088     | 2-Sep-22 | 21:53 | x64      |
| Xpqueue.dll                                  | 2017.140.3456.2 | 69024     | 2-Sep-22 | 21:53 | x64      |
| Xprepl.dll                                   | 2017.140.3456.2 | 97704     | 2-Sep-22 | 21:53 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3456.2 | 26536     | 2-Sep-22 | 21:53 | x64      |
| Xpstar.dll                                   | 2017.140.3456.2 | 446368    | 2-Sep-22 | 21:51 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date     | Time  | Platform |
|-------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3456.2 | 154552    | 2-Sep-22 | 21:43 | x86      |
| Batchparser.dll                                             | 2017.140.3456.2 | 175016    | 2-Sep-22 | 21:50 | x64      |
| Bcp.exe                                                     | 2017.140.3456.2 | 114088    | 2-Sep-22 | 21:51 | x64      |
| Commanddest.dll                                             | 2017.140.3456.2 | 240040    | 2-Sep-22 | 21:50 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3456.2 | 110520    | 2-Sep-22 | 21:50 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3456.2 | 182184    | 2-Sep-22 | 21:50 | x64      |
| Distrib.exe                                                 | 2017.140.3456.2 | 199072    | 2-Sep-22 | 21:51 | x64      |
| Dteparse.dll                                                | 2017.140.3456.2 | 105896    | 2-Sep-22 | 21:50 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3456.2 | 83384     | 2-Sep-22 | 21:50 | x64      |
| Dtepkg.dll                                                  | 2017.140.3456.2 | 132008    | 2-Sep-22 | 21:50 | x64      |
| Dtexec.exe                                                  | 2017.140.3456.2 | 69024     | 2-Sep-22 | 21:50 | x64      |
| Dts.dll                                                     | 2017.140.3456.2 | 2995112   | 2-Sep-22 | 21:50 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3456.2 | 469416    | 2-Sep-22 | 21:50 | x64      |
| Dtsconn.dll                                                 | 2017.140.3456.2 | 494504    | 2-Sep-22 | 21:50 | x64      |
| Dtshost.exe                                                 | 2017.140.3456.2 | 100280    | 2-Sep-22 | 21:51 | x64      |
| Dtslog.dll                                                  | 2017.140.3456.2 | 114600    | 2-Sep-22 | 21:50 | x64      |
| Dtsmsg150.dll                                               | 2017.140.3456.2 | 539560    | 2-Sep-22 | 21:51 | x64      |
| Dtspipeline.dll                                             | 2017.140.3456.2 | 1262504   | 2-Sep-22 | 21:50 | x64      |
| Dtspipelineperf150.dll                                      | 2017.140.3456.2 | 42424     | 2-Sep-22 | 21:50 | x64      |
| Dtuparse.dll                                                | 2017.140.3456.2 | 83368     | 2-Sep-22 | 21:50 | x64      |
| Dtutil.exe                                                  | 2017.140.3456.2 | 142760    | 2-Sep-22 | 21:50 | x64      |
| Exceldest.dll                                               | 2017.140.3456.2 | 254888    | 2-Sep-22 | 21:50 | x64      |
| Excelsrc.dll                                                | 2017.140.3456.2 | 276904    | 2-Sep-22 | 21:50 | x64      |
| Execpackagetask.dll                                         | 2017.140.3456.2 | 162216    | 2-Sep-22 | 21:50 | x64      |
| Flatfiledest.dll                                            | 2017.140.3456.2 | 380840    | 2-Sep-22 | 21:50 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3456.2 | 393640    | 2-Sep-22 | 21:50 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3456.2 | 90536     | 2-Sep-22 | 21:50 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3456.2 | 53664     | 2-Sep-22 | 21:51 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 2-Sep-22 | 21:44 | x86      |
| Logread.exe                                                 | 2017.140.3456.2 | 630696    | 2-Sep-22 | 21:51 | x64      |
| Mergetxt.dll                                                | 2017.140.3456.2 | 59304     | 2-Sep-22 | 21:51 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.94     | 1376160   | 2-Sep-22 | 21:50 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 2-Sep-22 | 21:44 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3456.2     | 132008    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3456.2     | 49592     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3456.2     | 83872     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3456.2     | 67512     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3456.2     | 386488    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3456.2     | 608680    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3456.2 | 1659304   | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3456.2     | 565664    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3456.2 | 146344    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3456.2 | 153504    | 2-Sep-22 | 21:51 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3456.2 | 97208     | 2-Sep-22 | 21:50 | x64      |
| Msgprox.dll                                                 | 2017.140.3456.2 | 266168    | 2-Sep-22 | 21:51 | x64      |
| Msxmlsql.dll                                                | 2017.140.3456.2 | 1442208   | 2-Sep-22 | 21:51 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 2-Sep-22 | 21:44 | x86      |
| Oledbdest.dll                                               | 2017.140.3456.2 | 255400    | 2-Sep-22 | 21:50 | x64      |
| Oledbsrc.dll                                                | 2017.140.3456.2 | 283048    | 2-Sep-22 | 21:50 | x64      |
| Osql.exe                                                    | 2017.140.3456.2 | 69544     | 2-Sep-22 | 21:50 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3456.2 | 469944    | 2-Sep-22 | 21:51 | x64      |
| Rawdest.dll                                                 | 2017.140.3456.2 | 200632    | 2-Sep-22 | 21:51 | x64      |
| Rawsource.dll                                               | 2017.140.3456.2 | 188344    | 2-Sep-22 | 21:51 | x64      |
| Rdistcom.dll                                                | 2017.140.3456.2 | 853432    | 2-Sep-22 | 21:51 | x64      |
| Recordsetdest.dll                                           | 2017.140.3456.2 | 178616    | 2-Sep-22 | 21:51 | x64      |
| Replagnt.dll                                                | 2017.140.3456.2 | 25000     | 2-Sep-22 | 21:51 | x64      |
| Repldp.dll                                                  | 2017.140.3456.2 | 286648    | 2-Sep-22 | 21:51 | x64      |
| Replerrx.dll                                                | 2017.140.3456.2 | 149936    | 2-Sep-22 | 21:53 | x64      |
| Replisapi.dll                                               | 2017.140.3456.2 | 358304    | 2-Sep-22 | 21:53 | x64      |
| Replmerg.exe                                                | 2017.140.3456.2 | 521120    | 2-Sep-22 | 21:51 | x64      |
| Replprov.dll                                                | 2017.140.3456.2 | 798136    | 2-Sep-22 | 21:53 | x64      |
| Replrec.dll                                                 | 2017.140.3456.2 | 973744    | 2-Sep-22 | 21:53 | x64      |
| Replsub.dll                                                 | 2017.140.3456.2 | 441272    | 2-Sep-22 | 21:53 | x64      |
| Replsync.dll                                                | 2017.140.3456.2 | 149432    | 2-Sep-22 | 21:53 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 2-Sep-22 | 21:51 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 2-Sep-22 | 21:51 | x64      |
| Spresolv.dll                                                | 2017.140.3456.2 | 248248    | 2-Sep-22 | 21:51 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3456.2 | 243128    | 2-Sep-22 | 21:51 | x64      |
| Sqldiag.exe                                                 | 2017.140.3456.2 | 1255848   | 2-Sep-22 | 21:51 | x64      |
| Sqldistx.dll                                                | 2017.140.3456.2 | 220576    | 2-Sep-22 | 21:51 | x64      |
| Sqllogship.exe                                              | 14.0.3456.2     | 100256    | 2-Sep-22 | 21:51 | x64      |
| Sqlmergx.dll                                                | 2017.140.3456.2 | 356256    | 2-Sep-22 | 21:51 | x64      |
| Sqlresld.dll                                                | 2017.140.3456.2 | 22968     | 2-Sep-22 | 21:47 | x86      |
| Sqlresld.dll                                                | 2017.140.3456.2 | 25016     | 2-Sep-22 | 21:51 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3456.2 | 23480     | 2-Sep-22 | 21:47 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3456.2 | 26552     | 2-Sep-22 | 21:51 | x64      |
| Sqlscm.dll                                                  | 2017.140.3456.2 | 56248     | 2-Sep-22 | 21:47 | x86      |
| Sqlscm.dll                                                  | 2017.140.3456.2 | 66976     | 2-Sep-22 | 21:51 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3456.2 | 129448    | 2-Sep-22 | 21:47 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3456.2 | 157112    | 2-Sep-22 | 21:51 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3456.2 | 177064    | 2-Sep-22 | 21:51 | x64      |
| Sqlwep140.dll                                               | 2017.140.3456.2 | 99768     | 2-Sep-22 | 21:51 | x64      |
| Ssdebugps.dll                                               | 2017.140.3456.2 | 27552     | 2-Sep-22 | 21:51 | x64      |
| Ssisoledb.dll                                               | 2017.140.3456.2 | 210328    | 2-Sep-22 | 21:51 | x64      |
| Ssradd.dll                                                  | 2017.140.3456.2 | 71080     | 2-Sep-22 | 21:51 | x64      |
| Ssravg.dll                                                  | 2017.140.3456.2 | 71584     | 2-Sep-22 | 21:51 | x64      |
| Ssrdown.dll                                                 | 2017.140.3456.2 | 56232     | 2-Sep-22 | 21:51 | x64      |
| Ssrmax.dll                                                  | 2017.140.3456.2 | 69544     | 2-Sep-22 | 21:51 | x64      |
| Ssrmin.dll                                                  | 2017.140.3456.2 | 69536     | 2-Sep-22 | 21:51 | x64      |
| Ssrpub.dll                                                  | 2017.140.3456.2 | 56744     | 2-Sep-22 | 21:51 | x64      |
| Ssrup.dll                                                   | 2017.140.3456.2 | 56224     | 2-Sep-22 | 21:51 | x64      |
| Tablediff.exe                                               | 14.0.3456.2     | 80808     | 2-Sep-22 | 21:53 | x64      |
| Txagg.dll                                                   | 2017.140.3456.2 | 356264    | 2-Sep-22 | 21:51 | x64      |
| Txbdd.dll                                                   | 2017.140.3456.2 | 169384    | 2-Sep-22 | 21:51 | x64      |
| Txdatacollector.dll                                         | 2017.140.3456.2 | 361384    | 2-Sep-22 | 21:51 | x64      |
| Txdataconvert.dll                                           | 2017.140.3456.2 | 287144    | 2-Sep-22 | 21:51 | x64      |
| Txderived.dll                                               | 2017.140.3456.2 | 598440    | 2-Sep-22 | 21:51 | x64      |
| Txlookup.dll                                                | 2017.140.3456.2 | 522152    | 2-Sep-22 | 21:51 | x64      |
| Txmerge.dll                                                 | 2017.140.3456.2 | 225720    | 2-Sep-22 | 21:51 | x64      |
| Txmergejoin.dll                                             | 2017.140.3456.2 | 274344    | 2-Sep-22 | 21:51 | x64      |
| Txmulticast.dll                                             | 2017.140.3456.2 | 121784    | 2-Sep-22 | 21:51 | x64      |
| Txrowcount.dll                                              | 2017.140.3456.2 | 122792    | 2-Sep-22 | 21:51 | x64      |
| Txsort.dll                                                  | 2017.140.3456.2 | 250808    | 2-Sep-22 | 21:51 | x64      |
| Txsplit.dll                                                 | 2017.140.3456.2 | 590760    | 2-Sep-22 | 21:51 | x64      |
| Txunionall.dll                                              | 2017.140.3456.2 | 178104    | 2-Sep-22 | 21:51 | x64      |
| Xe.dll                                                      | 2017.140.3456.2 | 667576    | 2-Sep-22 | 21:53 | x64      |
| Xmlrw.dll                                                   | 2017.140.3456.2 | 299424    | 2-Sep-22 | 21:53 | x64      |
| Xmlsub.dll                                                  | 2017.140.3456.2 | 256440    | 2-Sep-22 | 21:53 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date     | Time  | Platform |
|-------------------------------|-----------------|-----------|----------|-------|----------|
| Launchpad.exe                 | 2017.140.3456.2 | 1127864   | 2-Sep-22 | 21:51 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlsatellite.dll              | 2017.140.3456.2 | 918440    | 2-Sep-22 | 21:51 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date     | Time  | Platform |
|--------------------------|-----------------|-----------|----------|-------|----------|
| Fd.dll                   | 2017.140.3456.2 | 666552    | 2-Sep-22 | 21:51 | x64      |
| Fdhost.exe               | 2017.140.3456.2 | 110496    | 2-Sep-22 | 21:51 | x64      |
| Fdlauncher.exe           | 2017.140.3456.2 | 58272     | 2-Sep-22 | 21:51 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 2-Sep-22 | 21:51 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlft140ph.dll           | 2017.140.3456.2 | 63912     | 2-Sep-22 | 21:51 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date     | Time  | Platform |
|-------------------------|-----------------|-----------|----------|-------|----------|
| Imrdll.dll              | 14.0.3456.2     | 18360     | 2-Sep-22 | 21:50 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date     | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 2-Sep-22 | 21:43 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 2-Sep-22 | 21:50 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 2-Sep-22 | 21:43 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 2-Sep-22 | 21:50 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 2-Sep-22 | 21:43 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 2-Sep-22 | 21:50 | x86      |
| Commanddest.dll                                               | 2017.140.3456.2 | 194976    | 2-Sep-22 | 21:43 | x86      |
| Commanddest.dll                                               | 2017.140.3456.2 | 240040    | 2-Sep-22 | 21:50 | x64      |
| Dteparse.dll                                                  | 2017.140.3456.2 | 95136     | 2-Sep-22 | 21:43 | x86      |
| Dteparse.dll                                                  | 2017.140.3456.2 | 105896    | 2-Sep-22 | 21:50 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3456.2 | 77752     | 2-Sep-22 | 21:43 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3456.2 | 83384     | 2-Sep-22 | 21:50 | x64      |
| Dtepkg.dll                                                    | 2017.140.3456.2 | 111016    | 2-Sep-22 | 21:43 | x86      |
| Dtepkg.dll                                                    | 2017.140.3456.2 | 132008    | 2-Sep-22 | 21:50 | x64      |
| Dtexec.exe                                                    | 2017.140.3456.2 | 61856     | 2-Sep-22 | 21:43 | x86      |
| Dtexec.exe                                                    | 2017.140.3456.2 | 69024     | 2-Sep-22 | 21:50 | x64      |
| Dts.dll                                                       | 2017.140.3456.2 | 2545048   | 2-Sep-22 | 21:43 | x86      |
| Dts.dll                                                       | 2017.140.3456.2 | 2995112   | 2-Sep-22 | 21:50 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3456.2 | 412064    | 2-Sep-22 | 21:43 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3456.2 | 469416    | 2-Sep-22 | 21:50 | x64      |
| Dtsconn.dll                                                   | 2017.140.3456.2 | 396704    | 2-Sep-22 | 21:43 | x86      |
| Dtsconn.dll                                                   | 2017.140.3456.2 | 494504    | 2-Sep-22 | 21:50 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3456.2 | 89504     | 2-Sep-22 | 21:43 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3456.2 | 105896    | 2-Sep-22 | 21:50 | x64      |
| Dtshost.exe                                                   | 2017.140.3456.2 | 85408     | 2-Sep-22 | 21:48 | x86      |
| Dtshost.exe                                                   | 2017.140.3456.2 | 100280    | 2-Sep-22 | 21:51 | x64      |
| Dtslog.dll                                                    | 2017.140.3456.2 | 97176     | 2-Sep-22 | 21:43 | x86      |
| Dtslog.dll                                                    | 2017.140.3456.2 | 114600    | 2-Sep-22 | 21:50 | x64      |
| Dtsmsg150.dll                                                 | 2017.140.3456.2 | 535456    | 2-Sep-22 | 21:48 | x86      |
| Dtsmsg150.dll                                                 | 2017.140.3456.2 | 539560    | 2-Sep-22 | 21:51 | x64      |
| Dtspipeline.dll                                               | 2017.140.3456.2 | 1054624   | 2-Sep-22 | 21:43 | x86      |
| Dtspipeline.dll                                               | 2017.140.3456.2 | 1262504   | 2-Sep-22 | 21:50 | x64      |
| Dtspipelineperf150.dll                                        | 2017.140.3456.2 | 36792     | 2-Sep-22 | 21:43 | x86      |
| Dtspipelineperf150.dll                                        | 2017.140.3456.2 | 42424     | 2-Sep-22 | 21:50 | x64      |
| Dtuparse.dll                                                  | 2017.140.3456.2 | 74656     | 2-Sep-22 | 21:43 | x86      |
| Dtuparse.dll                                                  | 2017.140.3456.2 | 83368     | 2-Sep-22 | 21:50 | x64      |
| Dtutil.exe                                                    | 2017.140.3456.2 | 121768    | 2-Sep-22 | 21:43 | x86      |
| Dtutil.exe                                                    | 2017.140.3456.2 | 142760    | 2-Sep-22 | 21:50 | x64      |
| Exceldest.dll                                                 | 2017.140.3456.2 | 208792    | 2-Sep-22 | 21:43 | x86      |
| Exceldest.dll                                                 | 2017.140.3456.2 | 254888    | 2-Sep-22 | 21:50 | x64      |
| Excelsrc.dll                                                  | 2017.140.3456.2 | 224672    | 2-Sep-22 | 21:43 | x86      |
| Excelsrc.dll                                                  | 2017.140.3456.2 | 276904    | 2-Sep-22 | 21:50 | x64      |
| Execpackagetask.dll                                           | 2017.140.3456.2 | 129440    | 2-Sep-22 | 21:43 | x86      |
| Execpackagetask.dll                                           | 2017.140.3456.2 | 162216    | 2-Sep-22 | 21:50 | x64      |
| Flatfiledest.dll                                              | 2017.140.3456.2 | 326552    | 2-Sep-22 | 21:43 | x86      |
| Flatfiledest.dll                                              | 2017.140.3456.2 | 380840    | 2-Sep-22 | 21:50 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3456.2 | 338328    | 2-Sep-22 | 21:43 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3456.2 | 393640    | 2-Sep-22 | 21:50 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3456.2 | 74648     | 2-Sep-22 | 21:43 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3456.2 | 90536     | 2-Sep-22 | 21:50 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 2-Sep-22 | 21:30 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 2-Sep-22 | 21:44 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3456.2     | 461208    | 2-Sep-22 | 21:46 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3456.2     | 460704    | 2-Sep-22 | 21:50 | x64      |
| Isserverexec.exe                                              | 14.0.3456.2     | 143288    | 2-Sep-22 | 21:46 | x86      |
| Isserverexec.exe                                              | 14.0.3456.2     | 142760    | 2-Sep-22 | 21:50 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.94     | 1376184   | 2-Sep-22 | 21:47 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.94     | 1376160   | 2-Sep-22 | 21:50 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 2-Sep-22 | 21:30 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 2-Sep-22 | 21:30 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 2-Sep-22 | 21:44 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3456.2     | 106400    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3456.2 | 101304    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3456.2 | 106400    | 2-Sep-22 | 21:50 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3456.2     | 49592     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3456.2     | 49592     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3456.2     | 83872     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3456.2     | 83872     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3456.2     | 67512     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3456.2     | 67512     | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3456.2     | 508856    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3456.2     | 508856    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3456.2     | 77720     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3456.2     | 77736     | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3456.2     | 410024    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3456.2     | 410040    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3456.2     | 386488    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3456.2     | 608680    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3456.2     | 608680    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3456.2     | 247200    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3456.2     | 247224    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3456.2     | 49080     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3456.2     | 49080     | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3456.2 | 136088    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3456.2 | 146344    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3456.2 | 139680    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3456.2 | 153504    | 2-Sep-22 | 21:51 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3456.2     | 213920    | 2-Sep-22 | 21:51 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3456.2 | 84384     | 2-Sep-22 | 21:46 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3456.2 | 97208     | 2-Sep-22 | 21:50 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.94 | 9193912   | 2-Sep-22 | 21:51 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 2-Sep-22 | 21:29 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 2-Sep-22 | 21:42 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 2-Sep-22 | 21:30 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 2-Sep-22 | 21:44 | x86      |
| Oledbdest.dll                                                 | 2017.140.3456.2 | 208800    | 2-Sep-22 | 21:46 | x86      |
| Oledbdest.dll                                                 | 2017.140.3456.2 | 255400    | 2-Sep-22 | 21:50 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3456.2 | 227232    | 2-Sep-22 | 21:46 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3456.2 | 283048    | 2-Sep-22 | 21:50 | x64      |
| Rawdest.dll                                                   | 2017.140.3456.2 | 160696    | 2-Sep-22 | 21:48 | x86      |
| Rawdest.dll                                                   | 2017.140.3456.2 | 200632    | 2-Sep-22 | 21:51 | x64      |
| Rawsource.dll                                                 | 2017.140.3456.2 | 147360    | 2-Sep-22 | 21:48 | x86      |
| Rawsource.dll                                                 | 2017.140.3456.2 | 188344    | 2-Sep-22 | 21:51 | x64      |
| Recordsetdest.dll                                             | 2017.140.3456.2 | 143264    | 2-Sep-22 | 21:48 | x86      |
| Recordsetdest.dll                                             | 2017.140.3456.2 | 178616    | 2-Sep-22 | 21:51 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlceip.exe                                                   | 14.0.3456.2     | 269216    | 2-Sep-22 | 21:30 | x86      |
| Sqldest.dll                                                   | 2017.140.3456.2 | 207800    | 2-Sep-22 | 21:47 | x86      |
| Sqldest.dll                                                   | 2017.140.3456.2 | 254904    | 2-Sep-22 | 21:51 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3456.2 | 146336    | 2-Sep-22 | 21:47 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3456.2 | 177064    | 2-Sep-22 | 21:51 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3456.2 | 170936    | 2-Sep-22 | 21:47 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3456.2 | 210328    | 2-Sep-22 | 21:51 | x64      |
| Txagg.dll                                                     | 2017.140.3456.2 | 296352    | 2-Sep-22 | 21:48 | x86      |
| Txagg.dll                                                     | 2017.140.3456.2 | 356264    | 2-Sep-22 | 21:51 | x64      |
| Txbdd.dll                                                     | 2017.140.3456.2 | 133536    | 2-Sep-22 | 21:48 | x86      |
| Txbdd.dll                                                     | 2017.140.3456.2 | 169384    | 2-Sep-22 | 21:51 | x64      |
| Txbestmatch.dll                                               | 2017.140.3456.2 | 487352    | 2-Sep-22 | 21:48 | x86      |
| Txbestmatch.dll                                               | 2017.140.3456.2 | 599464    | 2-Sep-22 | 21:51 | x64      |
| Txcache.dll                                                   | 2017.140.3456.2 | 140192    | 2-Sep-22 | 21:48 | x86      |
| Txcache.dll                                                   | 2017.140.3456.2 | 179128    | 2-Sep-22 | 21:51 | x64      |
| Txcharmap.dll                                                 | 2017.140.3456.2 | 243096    | 2-Sep-22 | 21:48 | x86      |
| Txcharmap.dll                                                 | 2017.140.3456.2 | 285608    | 2-Sep-22 | 21:51 | x64      |
| Txcopymap.dll                                                 | 2017.140.3456.2 | 139680    | 2-Sep-22 | 21:48 | x86      |
| Txcopymap.dll                                                 | 2017.140.3456.2 | 179128    | 2-Sep-22 | 21:51 | x64      |
| Txdataconvert.dll                                             | 2017.140.3456.2 | 247200    | 2-Sep-22 | 21:48 | x86      |
| Txdataconvert.dll                                             | 2017.140.3456.2 | 287144    | 2-Sep-22 | 21:51 | x64      |
| Txderived.dll                                                 | 2017.140.3456.2 | 509856    | 2-Sep-22 | 21:48 | x86      |
| Txderived.dll                                                 | 2017.140.3456.2 | 598440    | 2-Sep-22 | 21:51 | x64      |
| Txfileextractor.dll                                           | 2017.140.3456.2 | 155040    | 2-Sep-22 | 21:48 | x86      |
| Txfileextractor.dll                                           | 2017.140.3456.2 | 197544    | 2-Sep-22 | 21:51 | x64      |
| Txfileinserter.dll                                            | 2017.140.3456.2 | 153504    | 2-Sep-22 | 21:48 | x86      |
| Txfileinserter.dll                                            | 2017.140.3456.2 | 190904    | 2-Sep-22 | 21:51 | x64      |
| Txgroupdups.dll                                               | 2017.140.3456.2 | 225184    | 2-Sep-22 | 21:48 | x86      |
| Txgroupdups.dll                                               | 2017.140.3456.2 | 287144    | 2-Sep-22 | 21:51 | x64      |
| Txlineage.dll                                                 | 2017.140.3456.2 | 104352    | 2-Sep-22 | 21:48 | x86      |
| Txlineage.dll                                                 | 2017.140.3456.2 | 131000    | 2-Sep-22 | 21:51 | x64      |
| Txlookup.dll                                                  | 2017.140.3456.2 | 440760    | 2-Sep-22 | 21:48 | x86      |
| Txlookup.dll                                                  | 2017.140.3456.2 | 522152    | 2-Sep-22 | 21:51 | x64      |
| Txmerge.dll                                                   | 2017.140.3456.2 | 170912    | 2-Sep-22 | 21:48 | x86      |
| Txmerge.dll                                                   | 2017.140.3456.2 | 225720    | 2-Sep-22 | 21:51 | x64      |
| Txmergejoin.dll                                               | 2017.140.3456.2 | 215968    | 2-Sep-22 | 21:48 | x86      |
| Txmergejoin.dll                                               | 2017.140.3456.2 | 274344    | 2-Sep-22 | 21:51 | x64      |
| Txmulticast.dll                                               | 2017.140.3456.2 | 97184     | 2-Sep-22 | 21:48 | x86      |
| Txmulticast.dll                                               | 2017.140.3456.2 | 121784    | 2-Sep-22 | 21:51 | x64      |
| Txpivot.dll                                                   | 2017.140.3456.2 | 174496    | 2-Sep-22 | 21:48 | x86      |
| Txpivot.dll                                                   | 2017.140.3456.2 | 219064    | 2-Sep-22 | 21:51 | x64      |
| Txrowcount.dll                                                | 2017.140.3456.2 | 96160     | 2-Sep-22 | 21:48 | x86      |
| Txrowcount.dll                                                | 2017.140.3456.2 | 122792    | 2-Sep-22 | 21:51 | x64      |
| Txsampling.dll                                                | 2017.140.3456.2 | 129952    | 2-Sep-22 | 21:48 | x86      |
| Txsampling.dll                                                | 2017.140.3456.2 | 168360    | 2-Sep-22 | 21:51 | x64      |
| Txscd.dll                                                     | 2017.140.3456.2 | 164256    | 2-Sep-22 | 21:48 | x86      |
| Txscd.dll                                                     | 2017.140.3456.2 | 214952    | 2-Sep-22 | 21:51 | x64      |
| Txsort.dll                                                    | 2017.140.3456.2 | 202144    | 2-Sep-22 | 21:48 | x86      |
| Txsort.dll                                                    | 2017.140.3456.2 | 250808    | 2-Sep-22 | 21:51 | x64      |
| Txsplit.dll                                                   | 2017.140.3456.2 | 504760    | 2-Sep-22 | 21:48 | x86      |
| Txsplit.dll                                                   | 2017.140.3456.2 | 590760    | 2-Sep-22 | 21:51 | x64      |
| Txtermextraction.dll                                          | 2017.140.3456.2 | 8609192   | 2-Sep-22 | 21:48 | x86      |
| Txtermextraction.dll                                          | 2017.140.3456.2 | 8670616   | 2-Sep-22 | 21:51 | x64      |
| Txtermlookup.dll                                              | 2017.140.3456.2 | 4101048   | 2-Sep-22 | 21:48 | x86      |
| Txtermlookup.dll                                              | 2017.140.3456.2 | 4151208   | 2-Sep-22 | 21:51 | x64      |
| Txunionall.dll                                                | 2017.140.3456.2 | 134040    | 2-Sep-22 | 21:48 | x86      |
| Txunionall.dll                                                | 2017.140.3456.2 | 178104    | 2-Sep-22 | 21:51 | x64      |
| Txunpivot.dll                                                 | 2017.140.3456.2 | 154528    | 2-Sep-22 | 21:48 | x86      |
| Txunpivot.dll                                                 | 2017.140.3456.2 | 193976    | 2-Sep-22 | 21:51 | x64      |
| Xe.dll                                                        | 2017.140.3456.2 | 589752    | 2-Sep-22 | 21:48 | x86      |
| Xe.dll                                                        | 2017.140.3456.2 | 667576    | 2-Sep-22 | 21:53 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date     | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 2-Sep-22 | 21:40 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 2-Sep-22 | 21:40 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 2-Sep-22 | 21:40 | x86      |
| Instapi150.dll                                                       | 2017.140.3456.2  | 66472     | 2-Sep-22 | 21:40 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 2-Sep-22 | 21:31 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 2-Sep-22 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 2-Sep-22 | 21:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 2-Sep-22 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 2-Sep-22 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 2-Sep-22 | 21:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 2-Sep-22 | 21:39 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 2-Sep-22 | 21:31 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 2-Sep-22 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 2-Sep-22 | 21:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 2-Sep-22 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 2-Sep-22 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 2-Sep-22 | 21:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 2-Sep-22 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 2-Sep-22 | 21:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 2-Sep-22 | 21:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 2-Sep-22 | 21:40 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3456.2  | 401312    | 2-Sep-22 | 21:40 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3456.2  | 7325088   | 2-Sep-22 | 21:40 | x64      |
| Secforwarder.dll                                                     | 2017.140.3456.2  | 31648     | 2-Sep-22 | 21:40 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 2-Sep-22 | 21:40 | x64      |
| Sqldk.dll                                                            | 2017.140.3456.2  | 2737056   | 2-Sep-22 | 21:40 | x64      |
| Sqldumper.exe                                                        | 2017.140.3456.2  | 139688    | 2-Sep-22 | 21:40 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 1500584   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3920288   | 2-Sep-22 | 21:42 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3218328   | 2-Sep-22 | 21:32 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3922848   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3826080   | 2-Sep-22 | 21:32 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 2093480   | 2-Sep-22 | 21:46 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 2039712   | 2-Sep-22 | 21:45 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3593624   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3601816   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 1447840   | 2-Sep-22 | 21:29 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3456.2  | 3790752   | 2-Sep-22 | 21:29 | x64      |
| Sqlncli13e.dll                                                       | 2017.140.3456.2  | 2259360   | 2-Sep-22 | 21:40 | x64      |
| Sqlos.dll                                                            | 2017.140.3456.2  | 20376     | 2-Sep-22 | 21:40 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 2-Sep-22 | 21:40 | x64      |
| Sqltses.dll                                                          | 2017.140.3456.2  | 9730464   | 2-Sep-22 | 21:40 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date     | Time  | Platform |
|------------------------------------|-----------------|-----------|----------|-------|----------|
| Smrdll.dll                         | 14.0.3456.2     | 18360     | 2-Sep-22 | 21:51 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date     | Time  | Platform |
|------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Autoadmin.dll                                              | 2017.140.3456.2 | 1442728   | 2-Sep-22 | 21:48 | x86      |
| Dtaengine.exe                                              | 2017.140.3456.2 | 198560    | 2-Sep-22 | 21:43 | x86      |
| Dteparse.dll                                               | 2017.140.3456.2 | 95136     | 2-Sep-22 | 21:43 | x86      |
| Dteparse.dll                                               | 2017.140.3456.2 | 105896    | 2-Sep-22 | 21:50 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3456.2 | 77752     | 2-Sep-22 | 21:43 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3456.2 | 83384     | 2-Sep-22 | 21:50 | x64      |
| Dtepkg.dll                                                 | 2017.140.3456.2 | 111016    | 2-Sep-22 | 21:43 | x86      |
| Dtepkg.dll                                                 | 2017.140.3456.2 | 132008    | 2-Sep-22 | 21:50 | x64      |
| Dtexec.exe                                                 | 2017.140.3456.2 | 61856     | 2-Sep-22 | 21:43 | x86      |
| Dtexec.exe                                                 | 2017.140.3456.2 | 69024     | 2-Sep-22 | 21:50 | x64      |
| Dts.dll                                                    | 2017.140.3456.2 | 2545048   | 2-Sep-22 | 21:43 | x86      |
| Dts.dll                                                    | 2017.140.3456.2 | 2995112   | 2-Sep-22 | 21:50 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3456.2 | 412064    | 2-Sep-22 | 21:43 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3456.2 | 469416    | 2-Sep-22 | 21:50 | x64      |
| Dtsconn.dll                                                | 2017.140.3456.2 | 396704    | 2-Sep-22 | 21:43 | x86      |
| Dtsconn.dll                                                | 2017.140.3456.2 | 494504    | 2-Sep-22 | 21:50 | x64      |
| Dtshost.exe                                                | 2017.140.3456.2 | 85408     | 2-Sep-22 | 21:48 | x86      |
| Dtshost.exe                                                | 2017.140.3456.2 | 100280    | 2-Sep-22 | 21:51 | x64      |
| Dtslog.dll                                                 | 2017.140.3456.2 | 97176     | 2-Sep-22 | 21:43 | x86      |
| Dtslog.dll                                                 | 2017.140.3456.2 | 114600    | 2-Sep-22 | 21:50 | x64      |
| Dtsmsg150.dll                                              | 2017.140.3456.2 | 535456    | 2-Sep-22 | 21:48 | x86      |
| Dtsmsg150.dll                                              | 2017.140.3456.2 | 539560    | 2-Sep-22 | 21:51 | x64      |
| Dtspipeline.dll                                            | 2017.140.3456.2 | 1054624   | 2-Sep-22 | 21:43 | x86      |
| Dtspipeline.dll                                            | 2017.140.3456.2 | 1262504   | 2-Sep-22 | 21:50 | x64      |
| Dtspipelineperf150.dll                                     | 2017.140.3456.2 | 36792     | 2-Sep-22 | 21:43 | x86      |
| Dtspipelineperf150.dll                                     | 2017.140.3456.2 | 42424     | 2-Sep-22 | 21:50 | x64      |
| Dtuparse.dll                                               | 2017.140.3456.2 | 74656     | 2-Sep-22 | 21:43 | x86      |
| Dtuparse.dll                                               | 2017.140.3456.2 | 83368     | 2-Sep-22 | 21:50 | x64      |
| Dtutil.exe                                                 | 2017.140.3456.2 | 121768    | 2-Sep-22 | 21:43 | x86      |
| Dtutil.exe                                                 | 2017.140.3456.2 | 142760    | 2-Sep-22 | 21:50 | x64      |
| Exceldest.dll                                              | 2017.140.3456.2 | 208792    | 2-Sep-22 | 21:43 | x86      |
| Exceldest.dll                                              | 2017.140.3456.2 | 254888    | 2-Sep-22 | 21:50 | x64      |
| Excelsrc.dll                                               | 2017.140.3456.2 | 224672    | 2-Sep-22 | 21:43 | x86      |
| Excelsrc.dll                                               | 2017.140.3456.2 | 276904    | 2-Sep-22 | 21:50 | x64      |
| Flatfiledest.dll                                           | 2017.140.3456.2 | 326552    | 2-Sep-22 | 21:43 | x86      |
| Flatfiledest.dll                                           | 2017.140.3456.2 | 380840    | 2-Sep-22 | 21:50 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3456.2 | 338328    | 2-Sep-22 | 21:43 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3456.2 | 393640    | 2-Sep-22 | 21:50 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3456.2 | 74648     | 2-Sep-22 | 21:43 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3456.2 | 90536     | 2-Sep-22 | 21:50 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3456.2     | 106400    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3456.2     | 180632    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3456.2     | 404392    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3456.2     | 404384    | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3456.2     | 2087856   | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3456.2     | 2087848   | 2-Sep-22 | 21:50 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3456.2     | 608680    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3456.2     | 608680    | 2-Sep-22 | 21:51 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3456.2     | 247200    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3456.2     | 49080     | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3456.2 | 136088    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3456.2 | 146344    | 2-Sep-22 | 21:51 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3456.2 | 139680    | 2-Sep-22 | 21:47 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3456.2 | 153504    | 2-Sep-22 | 21:51 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3456.2 | 84384     | 2-Sep-22 | 21:46 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3456.2 | 97208     | 2-Sep-22 | 21:50 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.94 | 7306144   | 2-Sep-22 | 21:48 | x86      |
| Oledbdest.dll                                              | 2017.140.3456.2 | 208800    | 2-Sep-22 | 21:46 | x86      |
| Oledbdest.dll                                              | 2017.140.3456.2 | 255400    | 2-Sep-22 | 21:50 | x64      |
| Oledbsrc.dll                                               | 2017.140.3456.2 | 227232    | 2-Sep-22 | 21:46 | x86      |
| Oledbsrc.dll                                               | 2017.140.3456.2 | 283048    | 2-Sep-22 | 21:50 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3456.2 | 94648     | 2-Sep-22 | 21:50 | x64      |
| Sqlresld.dll                                               | 2017.140.3456.2 | 22968     | 2-Sep-22 | 21:47 | x86      |
| Sqlresld.dll                                               | 2017.140.3456.2 | 25016     | 2-Sep-22 | 21:51 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3456.2 | 23480     | 2-Sep-22 | 21:47 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3456.2 | 26552     | 2-Sep-22 | 21:51 | x64      |
| Sqlscm.dll                                                 | 2017.140.3456.2 | 56248     | 2-Sep-22 | 21:47 | x86      |
| Sqlscm.dll                                                 | 2017.140.3456.2 | 66976     | 2-Sep-22 | 21:51 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3456.2 | 129448    | 2-Sep-22 | 21:47 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3456.2 | 157112    | 2-Sep-22 | 21:51 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3456.2 | 146336    | 2-Sep-22 | 21:47 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3456.2 | 177064    | 2-Sep-22 | 21:51 | x64      |
| Txdataconvert.dll                                          | 2017.140.3456.2 | 247200    | 2-Sep-22 | 21:48 | x86      |
| Txdataconvert.dll                                          | 2017.140.3456.2 | 287144    | 2-Sep-22 | 21:51 | x64      |
| Xe.dll                                                     | 2017.140.3456.2 | 589752    | 2-Sep-22 | 21:48 | x86      |
| Xe.dll                                                     | 2017.140.3456.2 | 667576    | 2-Sep-22 | 21:53 | x64      |
| Xmlrw.dll                                                  | 2017.140.3456.2 | 251816    | 2-Sep-22 | 21:48 | x86      |
| Xmlrw.dll                                                  | 2017.140.3456.2 | 299424    | 2-Sep-22 | 21:53 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3456.2 | 183712    | 2-Sep-22 | 21:48 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3456.2 | 218552    | 2-Sep-22 | 21:53 | x64      |

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
