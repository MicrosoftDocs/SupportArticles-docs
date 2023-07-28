---
title: Cumulative update 31 for SQL Server 2017 (KB5016884)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 31 (KB5016884).
ms.date: 07/31/2023
ms.custom: KB5016884
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5016884 - Cumulative Update 31 for SQL Server 2017

_Release Date:_ &nbsp; September 20, 2022  
_Version:_ &nbsp; 14.0.3456.2

> [!NOTE]
> Cumulative Update 31 is the last cumulative update for Microsoft SQL Server 2017. SQL Server 2017 is transitioned to [extended support](https://learn.microsoft.com/lifecycle/products/sql-server-2017) after October 11, 2022.

## Summary

This article describes Cumulative Update package 31 (CU31) for Microsoft SQL Server 2017. This update contains 20 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 30, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3456.2**, file version: **2017.140.3456.2**
- Analysis Services - Product version: **14.0.249.94**, file version: **2017.140.249.94**

## Known issues in this update

Assume that a table used by replication uses a column that uses the `NEWSEQUENTIALID` function in the primary key. An error occurs when you attempt to apply the snapshot at the subscriber. Here are the commands attempted and error messages:

- Command attempted:

```
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

```SQL
ALTER TABLE [Person].[Address] DROP CONSTRAINT [PK_Address_rowguid]

GO

ALTER TABLE [Person].[Address] ADD  CONSTRAINT [PK_Address_rowguid]  DEFAULT (NEWID()) FOR [rowguid]

GO

ALTER TABLE [Person].[Address] DROP CONSTRAINT [PK_Address_rowguid]

GO

ALTER TABLE [Person].[Address] ADD  CONSTRAINT [PK_Address_rowguid]  DEFAULT (NEWSEQUENTIALID()) FOR [rowguid]

GO
```
## Improvements and fixes included in this cumulative update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|----------|
| <a id=14915051>[14915051](#14915051) </a> | Resolves the Denial of Service (DoS) vulnerability for the Newtonsoft library in SQL Server 2017.| Analysis Services | Analysis Services | Windows |
| <a id=14860451>[14860451](#14860451) </a> | The read-only request still goes to the read-write primary node in an Always On availability group when the read-only routing list node goes down. | High Availability | High Availability and Disaster Recovery | All |
| <a id=14904061>[14904061](#14904061) </a> | An assertion failure occurs on secondary replica when you use Always On availability groups in high-latency networks in SQL Server 2017. </br></br>You may see this assertion failure in the error log: </br></br>Assertion: File: <"e:\\\b\\\s3\\\sources\\\sql\\\ntdbms\\\storeng\\\dfs\\\trans\\\lsnlocmap.cpp">, line=358 Failed Assertion = 'pos - pndx < map->EntryCount'| High Availability | High Availability and Disaster Recovery | All |
| <a id=14676488>[14676488](#14676488) </a> | Error 9003 occurs with the incorrect log sequence number (LSN) when you do a subsequent restore after specifying the LSN at the virtual log file (VLF) boundary by using the `RESTORE WITH STANDBY` statement. Here's the error message: </br></br>Msg 3013, Level 16, State 1, Line \<LineNumber> </br></br>RESTORE DATABASE is terminating abnormally. </br></br>Msg 9003, Level 17, State 11, Line \<LineNumber> </br></br>The log scan number (\<LogScanNumber>) passed to log scan in database '\<DatabaseName>' isn't valid. This error may indicate data corruption or that the log file (.ldf) doesn't match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup. | SQL Server Engine | Backup Restore | Windows |
| <a id=14924205>[14924205](#14924205) </a> | Non-yielding dumps occur frequently on ColumnStoreAttributeCache::ColumnStoreColumnAttributeNode::GetSegmentById.| SQL Server Engine | Column Stores | Windows |
| <a id=14989388>[14989388](#14989388) </a> | The filegroup IDs of the files that belong to the clone database can be incorrect if the source database has gaps in the filegroup IDs due to the removal of files or filegroups. When you try to insert data into the table that belongs to the incorrectly generated clone database, you receive an error message that resembles the following message: </br></br>Msg 622, Level 16, State 3, Line \<LineNumber> </br></br>The filegroup "<FileGroupName>" has no files assigned to it. Tables, indexes, text columns, ntext columns, and image columns can't be populated on this filegroup until a file is added. | SQL Server Engine | DB Management | Windows |
| <a id=14964725>[14964725](#14964725) </a> | The FILESTREAM feature isn't enabled after you restart the operating system because of race conditions from multiple instances of SQL Server. In the error log, you can see the following error message: </br></br>Error: 5591, Severity: 16, State: 5. FILESTREAM feature is disabled. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=14209349>[14209349](#14209349) </a> | Memory-optimized tempdb metadata (HkTempDB) keeps consuming memory under VARHEAP: LOB Page Allocator.| SQL Server Engine | In-Memory OLTP | Windows |
| <a id=14923181>[14923181](#14923181) </a> | A memory leak occurs in the range index of in-memory tables after the parallel index scan. | SQL Server Engine | In-Memory OLTP| All |
| <a id=14923920>[14923920](#14923920) </a> | A memory leak occurs under "Range Index Heap" on the in-memory table that has non-clustered indexes, whenever there are concurrent inserts.| SQL Server Engine | In-Memory OLTP | All |
| <a id=13766490>[13766490](#13766490) </a> | Performance issues and deadlocks occur on SQL Server Agent in the msdb database that has automated backups. In addition, you see the following error messages in the SQL Server Agent log: </br></br>\<DateTime> SQLServer Error: 1205, Transaction (Process ID) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. </br></br>\<DateTime> Failed to retrieve job <JobID> from the server.| SQL Server Engine | Management Services | Windows |
| <a id=15009086>[15009086](#15009086) </a> | An access violation may occur after you apply SQL Server 2017 Cumulative Update 30 (CU30). This issue can occur when you perform a bulk insert operation followed by a `SELECT` statement in the same transaction, and the database's recovery model is either simple or bulk-logged.| SQL Server Engine |Methods to access stored data| All|
| <a id=14979530>[14979530](#14979530) </a> | [FIX: Installing SQL Server CUs may trigger IndexOutOfRangeException (KB5017551)](https://support.microsoft.com/help/5017551)| SQL Setup | Patching | Windows |
| <a id=14976696>[14976696](#14976696) </a> | [FIX: ParameterRuntimeValue is missing from the Showplan XML when you use the DMV sys.dm_exec_query_statistics_xml (KB5017788)](https://support.microsoft.com/help/5017788)| SQL Server Engine | Query Execution | All |
| <a id=14876278>[14876278](#14876278) </a> | A non-yielding scheduler dump occurs in `sqldk!SOS_MemoryWorkSpace::Lookup`. | SQL Server Engine | Query Execution | All |
| <a id=14918513>[14918513](#14918513) </a> | [FIX: ForceLastGoodPlan doesn't account for aborted and timed out queries in regression detection logic (KB5008184)](https://support.microsoft.com/help/5008184) | SQL Server Engine | Query Store | All |
| <a id=14810743>[14810743](#14810743) </a> | [FIX: Error 20598 after adding columns that have default constraints as part of the primary key for an existing table and configuring transactional replication (KB5018231)](https://support.microsoft.com/help/5018231) | SQL Server Engine | Replication | Windows |
| <a id=14914142>[14914142](#14914142) </a> | Error 208 occurs when you use the`sp_changereplicationserverpasswords` stored procedure to change stored passwords for the Microsoft SQL Server login used by replication agents. Here's the error message: </br></br>Msg 208, Level 16, State 1, Procedure master.sys.sp_MSchangerepltablepasswords, Line \<LineNumber> [Batch Start Line 0] </br></br>Invalid object name 'MSreplservers'. | SQL Server Engine | Replication | Windows |
| <a id=14962805>[14962805](#14962805) </a> | High CPU usage occurs when you enable change tracking on a large number of tables and do automatic or manual cleanup of the change tracking tables. | SQL Server Engine | Replication | Windows |
| <a id=14931590>[14931590](#14931590) </a> | [Improvement: Add new Azure SQL Database service tier options to the Stretch Database feature (KB5018050)](https://support.microsoft.com/help/5018050) | SQL Server Engine | Stretch DB | Windows|
