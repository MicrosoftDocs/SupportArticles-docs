---
title: Cumulative update 2 for SQL Server 2017 (KB4052574)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 2 (KB4052574).
ms.date: 08/04/2023
ms.custom: KB4052574
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4052574 - Cumulative Update 2 for SQL Server 2017

_Release Date:_ &nbsp; November 28, 2017  
_Version:_ &nbsp; 14.0.3008.27

## Summary

This article describes Cumulative Update package 2 (CU2) for Microsoft SQL Server 2017. This update contains 34 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 1, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3008.27**, file version: **2017.140.3008.27**
- Analysis Services - Product version: **14.0.1.440**, file version: **2017.140.1.440**

## Known issues in this update

If you use the Query Store feature, don't install this Cumulative Update 2 (CU2) (14.0.3008.27). Instead, [install CU3](cumulativeupdate3.md) (14.0.3015.40).

If you have already installed CU2, after installing [CU3](cumulativeupdate3.md) or higher, you must immediately execute the following script to delete all plans collected by Query Store while CU2 was installed:

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

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="11078719">[11078719](#11078719)</a> | [FIX: Bookmarks functionality doesn't work completely when you open a report in MHTML format through Outlook in SSRS (KB4043947)](https://support.microsoft.com/help/4043947) | Analysis Services | Reporting Services | Windows |
| <a id="10970440">[10970440](#10970440)</a> | [FIX: "An unknown error" for "Show More Members" on Entity Dependencies explorer page in SQL Server 2017 Master Data Services (KB4042962)](https://support.microsoft.com/help/4042962) | Master Data Services | Client | Windows |
| <a id="11195748">[11195748](#11195748)</a> | [FIX: Incorrect warning message that asks to restart SQL Server when it isn't required in SQL Server 2017 on Linux (KB4053447)](https://support.microsoft.com/help/4053447) | SQL Server Client Tools | Command Line Tools | Linux |
| <a id="11133452">[11133452](#11133452)</a> | [FIX: Policy-Based Management policy not working after you install CU2 for SQL Server 2016 SP1 (KB4037454)](https://support.microsoft.com/help/4037454) | SQL Server Client Tools | Policy-Based Management | All |
| <a id="11078705">[11078705](#11078705)</a> | [FIX: Can't change the password for a SQL Server 2017 service account when additional LSA protection is enabled (KB4039592)](https://support.microsoft.com/help/4039592) | SQL Server Client Tools | SQL Server Manageability (SSM) | Windows |
| <a id="11057322">[11057322](#11057322)</a> | [FIX: Errors 33111 and 3013 when you back up a TDE encrypted database in SQL Server (KB4052134)](https://support.microsoft.com/help/4052134) | SQL Server Engine | Backup Restore | All |
| <a id="11078729">[11078729](#11078729)</a> | [FIX: "Message 611" error when you use BULK INSERT or INSERT SELECT to insert data into a clustered columnstore index (KB4045814)](https://support.microsoft.com/help/4045814) | SQL Server Engine | Column Stores | Windows |
| <a id="11187256">[11187256](#11187256)</a> | [FIX: Data retrieval queries using non-clustered index seek take much longer in SQL Server (KB4052625)](https://support.microsoft.com/help/4052625) | SQL Server Engine | Column Stores | Windows |
| <a id="11195379">[11195379](#11195379)</a> | [FIX: Assertion occurs on accessing memory-optimized table through MARS (KB4046056)](https://support.microsoft.com/help/4046056) | SQL Server Engine | Column Stores | Windows |
| <a id="11008401">[11008401](#11008401)</a> | [FIX: Memory use with many databases in SQL Server 2017 is greater than earlier versions (KB4035062)](https://support.microsoft.com/help/4035062) | SQL Server Engine | DB Management | All |
| <a id="11179674">[11179674](#11179674)</a> | [FIX: External R library is installed or uninstalled repeatedly in SQL Server (KB4053348)](https://support.microsoft.com/help/4053348) | SQL Server Engine | Extensibility | Windows |
| <a id="11179675">[11179675](#11179675)</a> | [FIX: "sys.external_libraries" catalog views are empty for non-dbo users in SQL Server (KB4053349)](https://support.microsoft.com/help/4053349) | SQL Server Engine | Extensibility | Windows |
| <a id="11186915">[11186915](#11186915)</a> | [FIX: Deadlock when multiple PREDICT T-SQL functions run concurrently (KB4053329)](https://support.microsoft.com/help/4053329) | SQL Server Engine | Extensibility | Windows |
| <a id="11128694">[11128694](#11128694)</a> | [FIX: Error when you backup database with memory-optimized tables in SQL Server 2017 (KB4052984)](https://support.microsoft.com/help/4052984) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11192144">[11192144](#11192144)</a> | [FIX: Using ALTER TABLE on an in-memory optimized table crashes SQL Server 2017 (KB4053386)](https://support.microsoft.com/help/4053386) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="11195380">[11195380](#11195380)</a> | [FIX: Fatal error when a natively compiled stored procedure is executed to access memory-optimized tables in SQL Server 2017 (KB4054037)](https://support.microsoft.com/help/4054037) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="11281561">[11281561](#11281561)</a> | [FIX: Inconsistent behavior for returning trailing blanks at the end of CHAR and BINARY data in SQL Server (KB4055758)](https://support.microsoft.com/help/4055758) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11128807">[11128807](#11128807)</a> | [FIX: TLS cipher suites with PFS don't work for secure connections in SQL Server 2017 on Linux (KB4052697)](https://support.microsoft.com/help/4052697) | SQL Server Engine | Linux | Linux |
| <a id="11129098">[11129098](#11129098)</a> | [FIX: Excessive PREMPTIVE_OS_CREATEDIRECTORY waits during a workload that compiles or recompiles memory-optimized tables or table types (KB4052338)](https://support.microsoft.com/help/4052338) | SQL Server Engine | Linux | Linux |
| <a id="11133453">[11133453](#11133453)</a> | [FIX: SQL Server 2017 can't decrypt data encrypted by earlier versions of SQL Server by using the same symmetric key (KB4053407)](https://support.microsoft.com/help/4053407) | SQL Server Engine | Linux | Linux |
| <a id="11188013">[11188013](#11188013)</a> | [FIX: Name resolution error occurs when IPv6 is disabled in SQL Server 2017 on Linux (KB4053392)](https://support.microsoft.com/help/4053392) | SQL Server Engine | Linux | Linux |
| <a id="11188014">[11188014](#11188014)</a> | [FIX: SQL Server 2017 on Linux doesn't listen to the nondefault IP address specified by the mssql-conf script (KB4053393)](https://support.microsoft.com/help/4053393) | SQL Server Engine | Linux | Linux |
| <a id="11076441">[11076441](#11076441)</a> | [FIX: A parallel query execution plan that contains a "merge join" operator takes longer to execute in Cumulative Update 3, 4 or 5 for SQL Server 2016 Service Pack 1 (KB4046858)](https://support.microsoft.com/help/4046858) | SQL Server Engine | Query Execution | All |
| <a id="11078715">[11078715](#11078715)</a> | [FIX: Access violation when you cancel a pending query if the missing indexes feature is enabled in SQL Server (KB4042232)](https://support.microsoft.com/help/4042232) | SQL Server Engine | Query Execution | All |
| <a id="11183519">[11183519](#11183519)</a> | [FIX: "sys.dm_exec_query_profiles" DMV returns wrong "estimate_row_count" in SQL Server 2017 on Linux and Windows (KB4053291)](https://support.microsoft.com/help/4053291) | SQL Server Engine | Query Execution | All |
| <a id="11195381">[11195381](#11195381)</a> | [FIX: Error 213 when you merge or split a partition of a partitioned graph table in SQL Server 2017 on Linux or Windows (KB4054035)](https://support.microsoft.com/help/4054035) | SQL Server Engine | Query Optimizer | All |
| <a id="11195382">[11195382](#11195382)</a> | [FIX: Error 8624 when you execute a query that contains a SELECT DISTINCT statement on a graph column in SQL Server 2017 on Linux or Windows (KB4054036)](https://support.microsoft.com/help/4054036) | SQL Server Engine | Query Optimizer | All |
| <a id="11003332">[11003332](#11003332)</a> | [FIX: ForceLastGoodPlan recommendation state is falsely reported as Expired if it's applied manually in SQL Server 2017 (KB4046102)](https://support.microsoft.com/help/4046102) | SQL Server Engine | Query Store | All |
| <a id="11076653">[11076653](#11076653)</a> | [Update for manual change tracking cleanup procedure in SQL Server 2017 (KB4052129)](https://support.microsoft.com/help/4052129) | SQL Server Engine | Replication | Windows |
| <a id="11229737">[11229737](#11229737)</a> | [Improvement: General improvements to the change tracking cleanup process in SQL Server 2017 (KB4054842)](https://support.microsoft.com/help/4054842) | SQL Server Engine | Replication | Windows |
| <a id="10966006">[10966006](#10966006)</a> | [FIX: Error 156 when SQL Server replication article contains either GEOGRAPHY_AUTO_GRID or GEOMETRY_AUTO_GRID (KB4037412)](https://support.microsoft.com/help/4037412) | SQL Server Engine | Replication | All |
| <a id="11123810">[11123810](#11123810)</a> | [Performance improvement for Spatial Intermediate Filter in SQL Server 2017 (KB4052122)](https://support.microsoft.com/help/4052122) | SQL Server Engine | Spatial | Windows |
| <a id="11182963">[11182963](#11182963)</a> | [FIX: Minimum memory limit set to 2 GB to install or start SQL Server 2017 (KB4052969)](https://support.microsoft.com/help/4052969) | SQL Server Engine | SQL OS | Linux |
| <a id="11076285">[11076285](#11076285)</a> | [Update adds a new extended event "marked_transaction_latch_trace" in SQL Server 2017 on Linux and Windows (KB4052126)](https://support.microsoft.com/help/4052126) | SQL Server Engine | Transaction Services | All |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU2 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2017/12/sqlserver2017-kb4052574-x64_ee995c195fafbdff4b30f424cab6fd64e2a5262d.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4052574-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4052574-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4052574-x64.exe| 1ABAD43EF6F320485A5A55008FCC5A2510F93252D8446369B8597A0F0F7E2E42 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.1.440   | 266400    | 08-Nov-17 | 12:55 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.1.440       | 741024    | 08-Nov-17 | 12:57 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.1.440       | 1380512   | 08-Nov-17 | 12:55 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.1.440       | 984224    | 08-Nov-17 | 12:55 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.1.440       | 521376    | 08-Nov-17 | 12:55 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201    | 174816    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201    | 36576     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201    | 48864     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201    | 105184    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201    | 5167328   | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201    | 26336     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201    | 26848     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201    | 26848     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201    | 159456    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201    | 82656     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201    | 67296     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201    | 25824     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151264    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201    | 13032160  | 25-Oct-17 | 03:11 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484       | 1044672   | 25-Oct-17 | 03:11 | x86      |
| Msmdctr.dll                                        | 2017.140.1.440   | 40088     | 08-Nov-17 | 12:57 | x64      |
| Msmdlocal.dll                                      | 2017.140.1.440   | 59898528  | 08-Nov-17 | 12:57 | x64      |
| Msmdlocal.dll                                      | 2017.140.1.440   | 40357024  | 08-Nov-17 | 12:57 | x86      |
| Msmdpump.dll                                       | 2017.140.1.440   | 8544416   | 08-Nov-17 | 12:57 | x64      |
| Msmdredir.dll                                      | 2017.140.1.440   | 7091872   | 08-Nov-17 | 12:57 | x86      |
| Msmdsrv.exe                                        | 2017.140.1.440   | 60590752  | 08-Nov-17 | 12:57 | x64      |
| Msmgdsrv.dll                                       | 2017.140.1.440   | 8208544   | 08-Nov-17 | 12:57 | x64      |
| Msmgdsrv.dll                                       | 2017.140.1.440   | 7310496   | 08-Nov-17 | 12:57 | x86      |
| Msolap.dll                                         | 2017.140.1.440   | 7776416   | 08-Nov-17 | 12:56 | x86      |
| Msolap.dll                                         | 2017.140.1.440   | 9468064   | 08-Nov-17 | 12:57 | x64      |
| Msolui.dll                                         | 2017.140.1.440   | 310944    | 08-Nov-17 | 12:57 | x64      |
| Msolui.dll                                         | 2017.140.1.440   | 287392    | 08-Nov-17 | 12:57 | x86      |
| Powerbiextensions.dll                              | 2.49.4831.201    | 5316832   | 25-Oct-17 | 03:11 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlboot.dll                                        | 2017.140.3008.27 | 195232    | 16-Nov-17 | 18:31 | x64      |
| Sqlceip.exe                                        | 14.0.3008.27     | 249504    | 16-Nov-17 | 19:19 | x86      |
| Sqldumper.exe                                      | 2017.140.3008.27 | 118944    | 16-Nov-17 | 18:28 | x86      |
| Sqldumper.exe                                      | 2017.140.3008.27 | 140448    | 16-Nov-17 | 19:04 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll                             | 2017.140.3008.27 | 61088     | 16-Nov-17 | 17:54 | x86      |
| Instapi140.dll                             | 2017.140.3008.27 | 70304     | 16-Nov-17 | 18:31 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.1.440       | 1088672   | 08-Nov-17 | 12:55 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.1.440       | 1088672   | 08-Nov-17 | 12:57 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.1.440       | 1381536   | 08-Nov-17 | 12:57 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.1.440       | 741536    | 08-Nov-17 | 12:55 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.1.440       | 741536    | 08-Nov-17 | 12:57 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3008.27     | 37024     | 16-Nov-17 | 19:18 | x86      |
| Msasxpress.dll                             | 2017.140.1.440   | 36000     | 08-Nov-17 | 12:57 | x64      |
| Msasxpress.dll                             | 2017.140.1.440   | 31904     | 08-Nov-17 | 12:57 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3008.27 | 82080     | 16-Nov-17 | 19:17 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3008.27 | 67744     | 16-Nov-17 | 19:19 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqldumper.exe                              | 2017.140.3008.27 | 118944    | 16-Nov-17 | 18:28 | x86      |
| Sqldumper.exe                              | 2017.140.3008.27 | 140448    | 16-Nov-17 | 19:04 | x64      |
| Sqlftacct.dll                              | 2017.140.3008.27 | 62112     | 16-Nov-17 | 19:17 | x64      |
| Sqlftacct.dll                              | 2017.140.3008.27 | 54432     | 16-Nov-17 | 19:19 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3008.27 | 415904    | 16-Nov-17 | 19:15 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3008.27 | 372384    | 16-Nov-17 | 19:18 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3008.27 | 356000    | 16-Nov-17 | 18:31 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3008.27 | 273056    | 16-Nov-17 | 18:32 | x86      |
| Svrenumapi140.dll                          | 2017.140.3008.27 | 1173152   | 16-Nov-17 | 18:31 | x64      |
| Svrenumapi140.dll                          | 2017.140.3008.27 | 893600    | 16-Nov-17 | 19:19 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3008.27 | 120992    | 16-Nov-17 | 19:18 | x86      |
| Dreplaycommon.dll              | 2017.140.3008.27 | 697504    | 16-Nov-17 | 19:18 | x86      |
| Dreplayutil.dll                | 2017.140.3008.27 | 309920    | 16-Nov-17 | 19:18 | x86      |
| Instapi140.dll                 | 2017.140.3008.27 | 70304     | 16-Nov-17 | 18:31 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3008.27 | 697504    | 16-Nov-17 | 19:18 | x86      |
| Dreplaycontroller.exe              | 2017.140.3008.27 | 350368    | 16-Nov-17 | 19:18 | x86      |
| Dreplayprocess.dll                 | 2017.140.3008.27 | 171168    | 16-Nov-17 | 19:18 | x86      |
| Instapi140.dll                     | 2017.140.3008.27 | 70304     | 16-Nov-17 | 18:31 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Datacollectorcontroller.dll                  | 2017.140.3008.27 | 225952    | 16-Nov-17 | 19:15 | x64      |
| Fssres.dll                                   | 2017.140.3008.27 | 89248     | 16-Nov-17 | 19:17 | x64      |
| Hadrres.dll                                  | 2017.140.3008.27 | 187552    | 16-Nov-17 | 19:17 | x64      |
| Hkcompile.dll                                | 2017.140.3008.27 | 1421984   | 16-Nov-17 | 19:17 | x64      |
| Hkengine.dll                                 | 2017.140.3008.27 | 5858472   | 16-Nov-17 | 19:17 | x64      |
| Hkruntime.dll                                | 2017.140.3008.27 | 161952    | 16-Nov-17 | 19:17 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.1.440       | 741024    | 08-Nov-17 | 12:55 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3008.27     | 237216    | 16-Nov-17 | 19:15 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3008.27     | 79520     | 16-Nov-17 | 19:15 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3008.27 | 392352    | 16-Nov-17 | 19:05 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3008.27 | 304288    | 16-Nov-17 | 19:05 | x64      |
| Qds.dll                                      | 2017.140.3008.27 | 1165472   | 16-Nov-17 | 21:28 | x64      |
| Sqagtres.dll                                 | 2017.140.3008.27 | 74400     | 16-Nov-17 | 19:17 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlaamss.dll                                 | 2017.140.3008.27 | 89760     | 16-Nov-17 | 19:15 | x64      |
| Sqlaccess.dll                                | 2017.140.3008.27 | 474784    | 16-Nov-17 | 18:31 | x64      |
| Sqlagent.exe                                 | 2017.140.3008.27 | 579744    | 16-Nov-17 | 19:15 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3008.27 | 61088     | 16-Nov-17 | 19:15 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3008.27 | 52896     | 16-Nov-17 | 19:18 | x86      |
| Sqlagentmail.dll                             | 2017.140.3008.27 | 53920     | 16-Nov-17 | 18:31 | x64      |
| Sqlboot.dll                                  | 2017.140.3008.27 | 195232    | 16-Nov-17 | 18:31 | x64      |
| Sqlceip.exe                                  | 14.0.3008.27     | 249504    | 16-Nov-17 | 19:19 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3008.27 | 72352     | 16-Nov-17 | 19:15 | x64      |
| Sqlctr140.dll                                | 2017.140.3008.27 | 129184    | 16-Nov-17 | 19:17 | x64      |
| Sqlctr140.dll                                | 2017.140.3008.27 | 111776    | 16-Nov-17 | 19:19 | x86      |
| Sqldk.dll                                    | 2017.140.3008.27 | 2789536   | 16-Nov-17 | 21:28 | x64      |
| Sqldtsss.dll                                 | 2017.140.3008.27 | 107168    | 16-Nov-17 | 19:54 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3207328   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3668128   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3813024   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3777184   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 4016800   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 2032800   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 1442464   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3359904   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3771040   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3474080   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3284640   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3909792   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 2085536   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3395232   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3290272   | 16-Nov-17 | 18:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3580576   | 16-Nov-17 | 18:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3778208   | 16-Nov-17 | 18:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3331744   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3906720   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 1495200   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3589792   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3008.27 | 3627168   | 16-Nov-17 | 18:33 | x64      |
| Sqllang.dll                                  | 2017.140.3008.27 | 41173152  | 16-Nov-17 | 21:28 | x64      |
| Sqlmin.dll                                   | 2017.140.3008.27 | 40238752  | 16-Nov-17 | 21:28 | x64      |
| Sqlolapss.dll                                | 2017.140.3008.27 | 107680    | 16-Nov-17 | 19:15 | x64      |
| Sqlos.dll                                    | 2017.140.3008.27 | 26272     | 16-Nov-17 | 19:05 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3008.27 | 67744     | 16-Nov-17 | 19:15 | x64      |
| Sqlrepss.dll                                 | 2017.140.3008.27 | 64160     | 16-Nov-17 | 19:15 | x64      |
| Sqlscm.dll                                   | 2017.140.3008.27 | 70816     | 16-Nov-17 | 19:15 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3008.27 | 27808     | 16-Nov-17 | 17:43 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3008.27 | 5871264   | 16-Nov-17 | 18:31 | x64      |
| Sqlservr.exe                                 | 2017.140.3008.27 | 487072    | 16-Nov-17 | 21:28 | x64      |
| Sqlsvc.dll                                   | 2017.140.3008.27 | 161440    | 16-Nov-17 | 19:15 | x64      |
| Sqltses.dll                                  | 2017.140.3008.27 | 9537696   | 16-Nov-17 | 21:28 | x64      |
| Sqsrvres.dll                                 | 2017.140.3008.27 | 260256    | 16-Nov-17 | 19:17 | x64      |
| Svl.dll                                      | 2017.140.3008.27 | 153760    | 16-Nov-17 | 19:17 | x64      |
| Xpadsi.exe                                   | 2017.140.3008.27 | 89760     | 16-Nov-17 | 19:17 | x64      |
| Xplog70.dll                                  | 2017.140.3008.27 | 75936     | 16-Nov-17 | 19:17 | x64      |
| Xpqueue.dll                                  | 2017.140.3008.27 | 74912     | 16-Nov-17 | 19:17 | x64      |
| Xprepl.dll                                   | 2017.140.3008.27 | 101536    | 16-Nov-17 | 19:17 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3008.27 | 32416     | 16-Nov-17 | 18:31 | x64      |
| Xpstar.dll                                   | 2017.140.3008.27 | 437408    | 16-Nov-17 | 19:17 | x64      |

SQL Server 2017 Database Services Core Shared

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Bcp.exe                                      | 2017.140.3008.27 | 119968    | 16-Nov-17 | 18:31 | x64      |
| Distrib.exe                                  | 2017.140.3008.27 | 202400    | 16-Nov-17 | 18:31 | x64      |
| Dts.dll                                      | 2017.140.3008.27 | 2997920   | 16-Nov-17 | 19:15 | x64      |
| Dtsconn.dll                                  | 2017.140.3008.27 | 496800    | 16-Nov-17 | 19:15 | x64      |
| Dtshost.exe                                  | 2017.140.3008.27 | 103584    | 16-Nov-17 | 19:17 | x64      |
| Dtspipeline.dll                              | 2017.140.3008.27 | 1265824   | 16-Nov-17 | 19:15 | x64      |
| Dtutil.exe                                   | 2017.140.3008.27 | 147104    | 16-Nov-17 | 19:15 | x64      |
| Logread.exe                                  | 2017.140.3008.27 | 623776    | 16-Nov-17 | 19:17 | x64      |
| Mergetxt.dll                                 | 2017.140.3008.27 | 63136     | 16-Nov-17 | 18:31 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 14.0.1.440       | 1381536   | 08-Nov-17 | 12:55 | x86      |
| Microsoft.data.datafeedclient.dll            | 13.1.1.0         | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.replication.dll          | 2017.140.3008.27 | 1650336   | 16-Nov-17 | 19:16 | x64      |
| Msgprox.dll                                  | 2017.140.3008.27 | 269984    | 16-Nov-17 | 18:31 | x64      |
| Msxmlsql.dll                                 | 2017.140.3008.27 | 1450656   | 16-Nov-17 | 19:17 | x64      |
| Qrdrsvc.exe                                  | 2017.140.3008.27 | 472224    | 16-Nov-17 | 19:17 | x64      |
| Rdistcom.dll                                 | 2017.140.3008.27 | 839840    | 16-Nov-17 | 19:17 | x64      |
| Repldp.dll                                   | 2017.140.3008.27 | 284320    | 16-Nov-17 | 18:31 | x64      |
| Replerrx.dll                                 | 2017.140.3008.27 | 153760    | 16-Nov-17 | 19:17 | x64      |
| Replisapi.dll                                | 2017.140.3008.27 | 361632    | 16-Nov-17 | 19:17 | x64      |
| Replmerg.exe                                 | 2017.140.3008.27 | 524448    | 16-Nov-17 | 19:17 | x64      |
| Replprov.dll                                 | 2017.140.3008.27 | 801440    | 16-Nov-17 | 18:31 | x64      |
| Replrec.dll                                  | 2017.140.3008.27 | 975008    | 16-Nov-17 | 18:31 | x64      |
| Replsub.dll                                  | 2017.140.3008.27 | 445600    | 16-Nov-17 | 19:17 | x64      |
| Replsync.dll                                 | 2017.140.3008.27 | 153760    | 16-Nov-17 | 19:17 | x64      |
| Spresolv.dll                                 | 2017.140.3008.27 | 252064    | 16-Nov-17 | 19:17 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqldistx.dll                                 | 2017.140.3008.27 | 224920    | 16-Nov-17 | 19:17 | x64      |
| Sqlmergx.dll                                 | 2017.140.3008.27 | 360608    | 16-Nov-17 | 18:31 | x64      |
| Sqlscm.dll                                   | 2017.140.3008.27 | 60064     | 16-Nov-17 | 18:32 | x86      |
| Sqlscm.dll                                   | 2017.140.3008.27 | 70816     | 16-Nov-17 | 19:15 | x64      |
| Sqlsvc.dll                                   | 2017.140.3008.27 | 161440    | 16-Nov-17 | 19:15 | x64      |
| Sqlsvc.dll                                   | 2017.140.3008.27 | 134304    | 16-Nov-17 | 19:18 | x86      |
| Ssradd.dll                                   | 2017.140.3008.27 | 74912     | 16-Nov-17 | 18:31 | x64      |
| Ssravg.dll                                   | 2017.140.3008.27 | 74912     | 16-Nov-17 | 18:31 | x64      |
| Ssrdown.dll                                  | 2017.140.3008.27 | 60064     | 16-Nov-17 | 19:17 | x64      |
| Ssrmax.dll                                   | 2017.140.3008.27 | 72864     | 16-Nov-17 | 19:17 | x64      |
| Ssrmin.dll                                   | 2017.140.3008.27 | 73376     | 16-Nov-17 | 19:17 | x64      |
| Ssrpub.dll                                   | 2017.140.3008.27 | 60576     | 16-Nov-17 | 19:17 | x64      |
| Ssrup.dll                                    | 2017.140.3008.27 | 60064     | 16-Nov-17 | 18:31 | x64      |
| Xmlsub.dll                                   | 2017.140.3008.27 | 260256    | 16-Nov-17 | 19:17 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3008.27 | 1122464   | 16-Nov-17 | 19:17 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlsatellite.dll              | 2017.140.3008.27 | 920736    | 16-Nov-17 | 19:17 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3008.27 | 667296    | 16-Nov-17 | 19:17 | x64      |
| Fdhost.exe               | 2017.140.3008.27 | 114336    | 16-Nov-17 | 19:17 | x64      |
| Fdlauncher.exe           | 2017.140.3008.27 | 62112     | 16-Nov-17 | 19:17 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlft140ph.dll           | 2017.140.3008.27 | 67744     | 16-Nov-17 | 19:17 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3008.27     | 23712     | 16-Nov-17 | 18:31 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 25-Oct-17 | 03:10 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 25-Oct-17 | 03:10 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 25-Oct-17 | 03:10 | x86      |
| Dts.dll                                                       | 2017.140.3008.27 | 2997920   | 16-Nov-17 | 19:15 | x64      |
| Dts.dll                                                       | 2017.140.3008.27 | 2548896   | 16-Nov-17 | 19:18 | x86      |
| Dtsconn.dll                                                   | 2017.140.3008.27 | 496800    | 16-Nov-17 | 19:15 | x64      |
| Dtsconn.dll                                                   | 2017.140.3008.27 | 398496    | 16-Nov-17 | 19:18 | x86      |
| Dtshost.exe                                                   | 2017.140.3008.27 | 103584    | 16-Nov-17 | 19:17 | x64      |
| Dtshost.exe                                                   | 2017.140.3008.27 | 89760     | 16-Nov-17 | 19:18 | x86      |
| Dtspipeline.dll                                               | 2017.140.3008.27 | 1265824   | 16-Nov-17 | 19:15 | x64      |
| Dtspipeline.dll                                               | 2017.140.3008.27 | 1058464   | 16-Nov-17 | 19:18 | x86      |
| Dtutil.exe                                                    | 2017.140.3008.27 | 147104    | 16-Nov-17 | 19:15 | x64      |
| Dtutil.exe                                                    | 2017.140.3008.27 | 126112    | 16-Nov-17 | 19:18 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3008.27     | 476832    | 16-Nov-17 | 19:53 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3008.27     | 477344    | 16-Nov-17 | 20:27 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.1.440       | 1381536   | 08-Nov-17 | 12:55 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.1.440       | 1381536   | 08-Nov-17 | 12:57 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3008.27     | 493728    | 16-Nov-17 | 18:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3008.27     | 493728    | 16-Nov-17 | 19:18 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3008.27     | 83616     | 16-Nov-17 | 19:15 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3008.27     | 83616     | 16-Nov-17 | 19:18 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3008.27     | 415392    | 16-Nov-17 | 19:54 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3008.27     | 415392    | 16-Nov-17 | 20:27 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3008.27     | 219808    | 16-Nov-17 | 19:15 | x64      |
| Msmdpp.dll                                                    | 2017.140.1.440   | 8400544   | 08-Nov-17 | 12:57 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlceip.exe                                                   | 14.0.3008.27     | 249504    | 16-Nov-17 | 19:19 | x86      |

SQL Server 2017 sql_polybase_core_inst

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2017.140.3008.27 | 70304     | 16-Nov-17 | 18:31 | x64      |
| Mpdwsvc.exe    | 2017.140.3008.27 | 7323296   | 16-Nov-17 | 19:04 | x64      |
| Sqldumper.exe  | 2017.140.3008.27 | 140448    | 16-Nov-17 | 19:04 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 1495200   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3906720   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3207328   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3909792   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3813024   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 2085536   | 16-Nov-17 | 18:28 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 2032800   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3580576   | 16-Nov-17 | 18:29 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3589792   | 16-Nov-17 | 18:31 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 1442464   | 16-Nov-17 | 18:27 | x64      |
| `Sqlevn70.rll`   | 2017.140.3008.27 | 3777184   | 16-Nov-17 | 18:27 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3008.27     | 23712     | 16-Nov-17 | 18:31 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |

SQL Server 2017 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                        | 2017.140.3008.27 | 2997920   | 16-Nov-17 | 19:15 | x64      |
| Dts.dll                                        | 2017.140.3008.27 | 2548896   | 16-Nov-17 | 19:18 | x86      |
| Dtsconn.dll                                    | 2017.140.3008.27 | 496800    | 16-Nov-17 | 19:15 | x64      |
| Dtsconn.dll                                    | 2017.140.3008.27 | 398496    | 16-Nov-17 | 19:18 | x86      |
| Dtshost.exe                                    | 2017.140.3008.27 | 103584    | 16-Nov-17 | 19:17 | x64      |
| Dtshost.exe                                    | 2017.140.3008.27 | 89760     | 16-Nov-17 | 19:18 | x86      |
| Dtspipeline.dll                                | 2017.140.3008.27 | 1265824   | 16-Nov-17 | 19:15 | x64      |
| Dtspipeline.dll                                | 2017.140.3008.27 | 1058464   | 16-Nov-17 | 19:18 | x86      |
| Dtutil.exe                                     | 2017.140.3008.27 | 147104    | 16-Nov-17 | 19:15 | x64      |
| Dtutil.exe                                     | 2017.140.3008.27 | 126112    | 16-Nov-17 | 19:18 | x86      |
| Microsoft.sqlserver.astasksui.dll              | 14.0.3008.27     | 184480    | 16-Nov-17 | 20:53 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3008.27     | 406688    | 16-Nov-17 | 19:15 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3008.27     | 406688    | 16-Nov-17 | 19:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3008.27     | 2093216   | 16-Nov-17 | 19:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3008.27     | 2093216   | 16-Nov-17 | 19:18 | x86      |
| Msmgdsrv.dll                                   | 2017.140.1.440   | 7310496   | 08-Nov-17 | 12:57 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2017.140.3008.27 | 100512    | 16-Nov-17 | 18:31 | x64      |
| Sqlscm.dll                                     | 2017.140.3008.27 | 60064     | 16-Nov-17 | 18:32 | x86      |
| Sqlscm.dll                                     | 2017.140.3008.27 | 70816     | 16-Nov-17 | 19:15 | x64      |
| Sqlsvc.dll                                     | 2017.140.3008.27 | 161440    | 16-Nov-17 | 19:15 | x64      |
| Sqlsvc.dll                                     | 2017.140.3008.27 | 134304    | 16-Nov-17 | 19:18 | x86      |

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
