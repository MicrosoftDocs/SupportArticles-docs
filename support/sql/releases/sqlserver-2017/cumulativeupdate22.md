---
title: Cumulative update 22 for SQL Server 2017 (KB4577467)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 22 (KB4577467).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4577467, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4577467 - Cumulative Update 22 for SQL Server 2017

_Release Date:_ &nbsp; September 10, 2020  
_Version:_ &nbsp; 14.0.3356.20

## Summary

This article describes Cumulative Update package 22 (CU22) for Microsoft SQL Server 2017. This update contains 41 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 21, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3356.20**, file version: **2017.140.3356.20**
- Analysis Services - Product version: **14.0.249.54**, file version: **2017.140.249.54**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area| Component | Platform |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|-----------------------------------------|----------|
| <a id=13594343>[13594343](#13594343) </a> | Fixes an unexpected error when you run a query against Multi Dimensional Instance using DirectQuery mode. </br></br>Unexpected error (file 'FileName', line LineNumber, FunctionName :: start function) | Analysis services | Analysis Services | Windows |
| <a id=13636106>[13636106](#13636106) </a> | Fixes an error that occurs when you run `DISCOVER_CSDL_METADATA` on a DirectQuery model perspective in SSAS 2017. </br></br>"OLE DB or ODBC error: We're sorry, an error occurred during evaluation.."| Analysis services | Analysis Services | Windows |
| <a id=13641471>[13641471](#13641471) </a> | Fixes an unexpected exception that occurs on function `XLVariable::WriteVarInfo` in SSAS 2017 when you enable trace or profiler to get DAX query plan.| Analysis services | Analysis Services | Windows|
| <a id=13598902>[13598902](#13598902) </a> | Fixes long package execution time involving SSIS task of type TransferSqlServerObjectsTask when database contains tens of thousands of tables and the db user isn't **db_owner**.| Integration services| Tasks_Components | Windows |
| <a id=13598930>[13598930](#13598930) </a> | [FIX: Concurrent inserts against tables with columnstore indexes may cause queries to stop responding in SQL Server (KB4561305)](https://support.microsoft.com/help/4561305)| SQL Server Engine | Column Stores | All |
| <a id=13586252>[13586252](#13586252) </a> | [FIX: Error 8992 occurs when you run DBCC CHECKDB on cloned database in SQL Server 2017 (KB4578110)](https://support.microsoft.com/help/4578110)| SQL Server Engine | DB Management | Windows |
| <a id=13573410>[13573410](#13573410) </a> | [FIX: Access violation occurs when you run INSERT EXEC with sp_execute_external_script on a table that has IDENTITY column in SQL Server 2017 (KB4578887)](https://support.microsoft.com/help/4578887)| SQL Server Engine | Extensibility | All |
| <a id=13575424>[13575424](#13575424) </a> | [FIX: INSERT EXEC doesn't work when you insert row containing explicit identity value into table with IDENTITY column and IDENTITY_INSERT is OFF by default in SQL Server (KB4568653)](https://support.microsoft.com/help/4568653)| SQL Server Engine | Extensibility | All |
| <a id=13637079>[13637079](#13637079) </a> | [FIX: Unable to use Filestream on Windows Server 2012 or Windows 8 after applying SQL Server 2017 CU21 (KB4578012)](https://support.microsoft.com/help/4578012) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=13598898>[13598898](#13598898) </a> | When you concurrently create sub directories in a FileTable directory, a deadlock may occur internally in the SQL Server Engine and all subsequent requests to FileTable directories and files may not respond. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=13477413>[13477413](#13477413) </a> | [FIX: Intermittent Availability Group failover occurs as AG helper connection times out while connecting to SQL Server 2017 (KB4569424)](https://support.microsoft.com/help/4569424)| SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id=13525230>[13525230](#13525230) </a> | [FIX: Access violation exception occurs in Availability Groups in SQL Server 2017 under certain conditions (KB4577932)](https://support.microsoft.com/help/4577932) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13477335>[13477335](#13477335) </a> | This update adds detailed error information to the pacemaker log when pacemaker agent fails to connect to SQL Server resource to obtain health status.| SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id=13598932>[13598932](#13598932) </a> | Assertion error occurs on the mirror server during redo process hitting. Assertion: File: \<FilePath\FileName>, line = \<LineNumber> Failed Assertion = 'result == LCK_OK' | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13587856>[13587856](#13587856) </a> | [FIX: A LOB allocator may be leaked when a LOB or off-row column is altered or dropped in SQL Server 2017 (KB4336873)](https://support.microsoft.com/help/4336873)| SQL Server Engine | In-Memory OLTP | All |
| <a id=13249811>[13249811](#13249811) </a> | [FIX: UTC time for DST time zone in Brazil/Sao Paulo is reported incorrectly in SQL Server 2017 (KB4579966)](https://support.microsoft.com/help/4579966)| SQL Server Engine | Linux | Linux |
| <a id=13530877>[13530877](#13530877) </a> | [FIX: VDI backup fails with error after applying SQL Server 2017 CU19/CU20/CU21 (KB4563007)](https://support.microsoft.com/help/4563007)| SQL Server Engine | Linux | Linux|
| <a id=13605758>[13605758](#13605758) </a> | [FIX: Error occurs when you run Distribution Agent on an instance of SQL Server 2017 on Linux (KB4573172)](https://support.microsoft.com/help/4573172)| SQL Server Engine | Linux | Linux |
| <a id=13585164>[13585164](#13585164) </a> | [FIX: Sharing violation when the “sp_cycle_agent_errorlog” stored procedure is run in SQL Server (KB4469942)](https://support.microsoft.com/help/4469942) | SQL Server Engine | Management Services | Windows |
| <a id=13622776>[13622776](#13622776) </a> | [FIX: Managed backup is not backing up the database when SQL Agent system jobs are changed to different name other than 'sa' in SQL Server 2017 (KB4578008)](https://support.microsoft.com/help/4578008)| SQL Server Engine | Management Services | Windows |
| <a id=13598906>[13598906](#13598906) </a> | When you run `ALTER` commands that include `ROLLBACK IMMEDIATE` option, the rollback may trigger before the command is processed even if the `ALTER` itself may fail due to lack of permissions. This fix ensures that the rollback is processed only after the `ALTER` command completes.| SQL Server Engine | Programmability | Windows|
| <a id=13636126>[13636126](#13636126) </a> | [FIX: SQL Server fails to start when remote admin connections are enabled and IPV6 is disabled on the host (KB4575453)](https://support.microsoft.com/help/4575453) | SQL Server Connectivity | Protocols | Linux |
| <a id=13598936>[13598936](#13598936) </a> | Fixes access violation exception that occurs when you run a query that references a non-existing partition function in SQL Server.| SQL Server Engine | Query Execution | Windows |
| <a id=13560722>[13560722](#13560722) </a> | [FIX: Incorrect results can occur when you run linked server query with aggregates or joins on table with filtered index on a remote server in SQL Server 2017 (KB4575689)](https://support.microsoft.com/help/4575689) | SQL Server Engine | Query Optimizer | Windows |
| <a id=13606604>[13606604](#13606604) </a> | [FIX: COMPILE blocking occurs when executing many concurrent stored procedures in SQL Server 2017 (KB4577976)](https://support.microsoft.com/help/4577976)| SQL Server Engine | Query Optimizer | Windows|
| <a id=13606668>[13606668](#13606668) </a> | [FIX: Cascade delete on key values outside of leading table histogram bounds causes Index scan in SQL Server 2017 (KB4577933)](https://support.microsoft.com/help/4577933) | SQL Server Engine | Query Optimizer | Windows |
| <a id=13598882>[13598882](#13598882) </a> | Non-yielding scheduler error occurs when a query with large number of expressions is run. | SQL Server Engine | Query Optimizer | Windows |
| <a id=13598912>[13598912](#13598912) </a> | Error occurs when `DELETE` from `CONSTITUENT` table is run, even when no matching rows exist in the referenced tables. </br>Msg 547, Level 16, State 0, Line LineNumber </br>The DELETE statement conflicted with the REFERENCE constraint "constraint name".</br>The conflict occurred in database "DatabaseName", table "TableName", column 'ColumnName'. </br>The statement has been terminated. | SQL Server Engine | Query Optimizer | Windows |
| <a id=13658971>[13658971](#13658971) </a> | Query Store scalability improvement for adhoc workloads. Query Store now imposes internal limits to the amount of memory it can use and automatically changes the operation mode to `READ-ONLY` until enough memory has been returned to the Database Engine, preventing performance issues. | SQL Server Engine | Query Store | All |
| <a id=13598910>[13598910](#13598910) </a> | [FIX: Upgrade script fails if you use anAlways On high availability group as a secondary replica in SQL Server (KB4563115)](https://support.microsoft.com/help/4563115) | SQL Server Engine | Replication | Windows|
| <a id=13598904>[13598904](#13598904) </a> | When a replication error such as deadlock occurs, random id is inserted in MSRepl_Errors table while it should be just incremented by 1 from the previous id value. This cumulative update (CU) fixes the issue and the MSRepl_Errors will insert entries with row id incremented by 1 instead of using some random value. | SQL Server Engine | Replication | Windows |
| <a id=13600268>[13600268](#13600268) </a> | "Monitor and Sync replication agent jobs" error occurs when a job runs on the new secondary replica after failover of the availability group that hosts the distribution database for transactional replication. Unable to post notification to SQLServerAgent (reason: The maximum number of pending SQLServerAgent notifications has been exceeded. The notification will be ignored.) [SQLSTATE 42000] (Error 22022). The step failed. | SQL Server Engine | Replication | Windows |
| <a id=13598908>[13598908](#13598908) </a> | [FIX: Full-Text search auto crawl stops when AG goes offline in SQL Server (KB4511771)](https://support.microsoft.com/help/4511771) | SQL Server Engine | Search | Windows|
| <a id=13663198>[13663198](#13663198) </a> | Intermittent error 6552 occurs when running Spatial query with `TOP <param> or OFFSET <param1> ROWS FETCH NEXT <param2> ROWS ONLY` clause and parallel plan. | SQL Server Engine | Spatial | All |
| <a id=13624029>[13624029](#13624029) </a> | SQL Server AG Helper/AG monitoring application waiting more than 30 seconds with epoll and `futex_wait_queue_me` wait type is unable to connect to SQL Server 2017 resulting in timeout and failover. | SQL Server Engine | SQL OS | Linux |
| <a id=12671877>[12671877](#12671877) </a> | [FIX: "Login failed for user" error occurs when you run Maintenance plan with SQL login account in SQL Server 2017 (KB4486936)](https://support.microsoft.com/help/4486936) | SQL Server Client Tools | SSMS| Windows |
| <a id=13509282>[13509282](#13509282) </a> | [FIX: Unable to restore SQL Server database from previous versions on NVMe device partitioned in 4K block size (KB4578011)](https://support.microsoft.com/help/4578011) | SQL Server Engine | Storage Management | Linux |
| <a id=13598884>[13598884](#13598884) </a> | `DBCC CHECKDB` may incorrectly report corruption on Spatial Index if base table has a column called ID. | SQL Server Engine | Storage Management | Windows |
| <a id=13598924>[13598924](#13598924) </a> | Assertion error occurs on the mirror server during redo process hitting. Assertion: File: \<FilePath\FileName>, line = \<LineNumber> Failed Assertion = 'result == LCK_OK'| SQL Server Engine | Storage Management | Windows |
| <a id=13619763>[13619763](#13619763) </a> | `DBCC SHRINKFLE` or `SHRINKDATABASE` can cause an assertion exception error when executed against database or files containing system-versioned temporal tables.| SQL Server Engine | Temporal| Windows |
| <a id=13598926>[13598926](#13598926) </a> | [FIX: Distributed transactions may experience long waits with DTC_STATE wait type in SQL Server (KB4560183)](https://support.microsoft.com/help/4560183) | SQL Server Engine | Transaction Services | Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU22 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/09/sqlserver2017-kb4577467-x64_8848761ca6ccec75d62aa0ea221bfa3ca54ad105.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4577467-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4577467-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4577467-x64.exe| C20313B4F39AFB8AAF14D6B100DA8BB04295029116A7CE76B8F7C30B0499B154 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.54  | 259472    | 21-Aug-20 | 05:27  | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.54      | 734608    | 11-Aug-20 | 07:18  | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.54      | 1373568   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.54      | 977296    | 11-Aug-20 | 07:18  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.54      | 514448    | 11-Aug-20 | 07:18  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435      | 329872    | 14-Aug-20 | 04:10  | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516      | 661072    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541    | 186232    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541    | 30080     | 29-May-20 | 13:22 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541    | 74832     | 29-May-20 | 13:22 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541    | 102264    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516      | 1454672   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516      | 181112    | 29-May-20 | 13:22 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25         | 920656    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541    | 5262728   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541    | 22392     | 29-May-20 | 13:22 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541    | 21880     | 29-May-20 | 13:22 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541    | 22096     | 21-Aug-20 | 05:27  | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541    | 149368    | 29-May-20 | 13:22 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541    | 78712     | 29-May-20 | 13:22 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541    | 192392    | 5-Aug-20  | 15:15 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541    | 59984     | 5-Aug-20  | 15:14 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541    | 27512     | 5-Aug-20  | 15:15 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 140368    | 29-May-20 | 13:22 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541    | 14271872  | 5-Aug-20  | 15:15 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0         | 1437568   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0         | 778632    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19       | 1104976   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0         | 126336    | 29-May-20 | 13:22 | x86      |
| Msmdctr.dll                                        | 2017.140.249.54  | 33168     | 11-Aug-20 | 07:18  | x64      |
| Msmdlocal.dll                                      | 2017.140.249.54  | 60756360  | 11-Aug-20 | 07:18  | x64      |
| Msmdlocal.dll                                      | 2017.140.249.54  | 40414616  | 11-Aug-20 | 07:18  | x86      |
| Msmdpump.dll                                       | 2017.140.249.54  | 9332616   | 11-Aug-20 | 07:18  | x64      |
| Msmdredir.dll                                      | 2017.140.249.54  | 7088520   | 11-Aug-20 | 07:18  | x86      |
| Msmdsrv.exe                                        | 2017.140.249.54  | 60655496  | 21-Aug-20 | 05:27  | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.54  | 9000856   | 11-Aug-20 | 07:18  | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.54  | 7304592   | 11-Aug-20 | 07:18  | x86      |
| Msolap.dll                                         | 2017.140.249.54  | 7772560   | 11-Aug-20 | 07:18  | x86      |
| Msolap.dll                                         | 2017.140.249.54  | 10256776  | 21-Aug-20 | 05:27  | x64      |
| Msolui.dll                                         | 2017.140.249.54  | 304024    | 11-Aug-20 | 07:18  | x64      |
| Msolui.dll                                         | 2017.140.249.54  | 280472    | 21-Aug-20 | 05:27  | x86      |
| Powerbiextensions.dll                              | 2.80.5803.541    | 9470032   | 29-May-20 | 13:22 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000  | 728456    | 21-Aug-20 | 05:27  | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Sqlboot.dll                                        | 2017.140.3356.20 | 190864    | 21-Aug-20 | 05:41  | x64      |
| Sqlceip.exe                                        | 14.0.3356.20     | 254856    | 21-Aug-20 | 06:00  | x86      |
| Sqldumper.exe                                      | 2017.140.3356.20 | 138640    | 21-Aug-20 | 05:39  | x64      |
| Sqldumper.exe                                      | 2017.140.3356.20 | 116096    | 21-Aug-20 | 05:40  | x86      |
| System.spatial.netfx35.dll                         | 5.7.0.62516      | 117640    | 21-Aug-20 | 05:27  | x86      |
| Tmapi.dll                                          | 2017.140.249.54  | 5814664   | 11-Aug-20 | 07:18  | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.54  | 4157840   | 21-Aug-20 | 05:27  | x64      |
| Tmpersistence.dll                                  | 2017.140.249.54  | 1125264   | 21-Aug-20 | 05:27  | x64      |
| Tmtransactions.dll                                 | 2017.140.249.54  | 1634184   | 21-Aug-20 | 05:27  | x64      |
| Xe.dll                                             | 2017.140.3356.20 | 666504    | 21-Aug-20 | 05:39  | x64      |
| Xmlrw.dll                                          | 2017.140.3356.20 | 298368    | 21-Aug-20 | 05:41  | x64      |
| Xmlrw.dll                                          | 2017.140.3356.20 | 250768    | 21-Aug-20 | 05:41  | x86      |
| Xmlrwbin.dll                                       | 2017.140.3356.20 | 217480    | 21-Aug-20 | 05:41  | x64      |
| Xmlrwbin.dll                                       | 2017.140.3356.20 | 182656    | 21-Aug-20 | 05:41  | x86      |
| Xmsrv.dll                                          | 2017.140.249.54  | 25375632  | 11-Aug-20 | 07:18  | x64      |
| Xmsrv.dll                                          | 2017.140.249.54  | 33349000  | 11-Aug-20 | 07:18  | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3356.20 | 173960    | 21-Aug-20 | 05:41  | x64      |
| Batchparser.dll                            | 2017.140.3356.20 | 153480    | 21-Aug-20 | 05:41  | x86      |
| Instapi140.dll                             | 2017.140.3356.20 | 65416     | 21-Aug-20 | 05:41  | x64      |
| Instapi140.dll                             | 2017.140.3356.20 | 55680     | 21-Aug-20 | 05:41  | x86      |
| Isacctchange.dll                           | 2017.140.3356.20 | 22400     | 21-Aug-20 | 06:00  | x86      |
| Isacctchange.dll                           | 2017.140.3356.20 | 23952     | 21-Aug-20 | 06:00  | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.54      | 1081744   | 11-Aug-20 | 07:18  | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.54      | 1081752   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.54      | 1374600   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.54      | 734608    | 11-Aug-20 | 07:18  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.54      | 734600    | 21-Aug-20 | 05:27  | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3356.20     | 30608     | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3356.20 | 75136     | 21-Aug-20 | 05:41  | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3356.20 | 71560     | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3356.20     | 564608    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3356.20     | 564616    | 21-Aug-20 | 06:00  | x86      |
| Msasxpress.dll                             | 2017.140.249.54  | 29064     | 11-Aug-20 | 07:18  | x64      |
| Msasxpress.dll                             | 2017.140.249.54  | 24968     | 11-Aug-20 | 07:18  | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3356.20 | 77192     | 21-Aug-20 | 05:41  | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3356.20 | 62344     | 21-Aug-20 | 05:41  | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Sqldumper.exe                              | 2017.140.3356.20 | 138640    | 21-Aug-20 | 05:39  | x64      |
| Sqldumper.exe                              | 2017.140.3356.20 | 116096    | 21-Aug-20 | 05:40  | x86      |
| Sqlftacct.dll                              | 2017.140.3356.20 | 49024     | 21-Aug-20 | 05:41  | x86      |
| Sqlftacct.dll                              | 2017.140.3356.20 | 57224     | 21-Aug-20 | 06:00  | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 15-Feb-20 | 17:38 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 15-Feb-20 | 18:04 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3356.20 | 413064    | 21-Aug-20 | 06:00  | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3356.20 | 368512    | 21-Aug-20 | 06:00  | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3356.20 | 30600     | 21-Aug-20 | 06:00  | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3356.20 | 28032     | 21-Aug-20 | 06:00  | x86      |
| Sqlsvcsync.dll                             | 2017.140.3356.20 | 351616    | 21-Aug-20 | 05:41  | x64      |
| Sqlsvcsync.dll                             | 2017.140.3356.20 | 267648    | 21-Aug-20 | 05:41  | x86      |
| Sqltdiagn.dll                              | 2017.140.3356.20 | 60800     | 21-Aug-20 | 05:41  | x64      |
| Sqltdiagn.dll                              | 2017.140.3356.20 | 53648     | 21-Aug-20 | 05:41  | x86      |
| Svrenumapi140.dll                          | 2017.140.3356.20 | 1168776   | 21-Aug-20 | 05:41  | x64      |
| Svrenumapi140.dll                          | 2017.140.3356.20 | 888720    | 21-Aug-20 | 05:41  | x86      |

SQL Server 2017 Data Quality Client

| File   name         | File version     | File size | Date      | Time  | Platform |
|---------------------|------------------|-----------|-----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2    | 24624     | 15-Feb-20 | 16:22 | x86      |
| Link.exe            | 12.10.30102.2    | 852528    | 15-Feb-20 | 16:22 | x86      |
| Mspdb120.dll        | 12.10.30102.2    | 259632    | 15-Feb-20 | 16:22 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Stdole.dll          | 7.0.9466.0       | 32296     | 21-Aug-20 | 05:41  | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 12-Feb-20 | 23:00 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 12-Feb-20 | 23:00 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version     | File size | Date      | Time | Platform |
|--------------------------------|------------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3356.20 | 114056    | 21-Aug-20 | 06:00 | x86      |
| Dreplaycommon.dll              | 2017.140.3356.20 | 693136    | 21-Aug-20 | 06:00 | x86      |
| Dreplayserverps.dll            | 2017.140.3356.20 | 26000     | 21-Aug-20 | 05:41 | x86      |
| Dreplayutil.dll                | 2017.140.3356.20 | 302992    | 21-Aug-20 | 06:00 | x86      |
| Instapi140.dll                 | 2017.140.3356.20 | 65416     | 21-Aug-20 | 05:41 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |
| Sqlresourceloader.dll          | 2017.140.3356.20 | 22400     | 21-Aug-20 | 05:41 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version     | File size | Date      | Time | Platform |
|------------------------------------|------------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3356.20 | 693136    | 21-Aug-20 | 06:00 | x86      |
| Dreplaycontroller.exe              | 2017.140.3356.20 | 343432    | 21-Aug-20 | 06:00 | x86      |
| Dreplayprocess.dll                 | 2017.140.3356.20 | 164752    | 21-Aug-20 | 06:00 | x86      |
| Dreplayserverps.dll                | 2017.140.3356.20 | 26000     | 21-Aug-20 | 05:41 | x86      |
| Instapi140.dll                     | 2017.140.3356.20 | 65416     | 21-Aug-20 | 05:41 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |
| Sqlresourceloader.dll              | 2017.140.3356.20 | 22400     | 21-Aug-20 | 05:41 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3356.20     | 33680     | 21-Aug-20 | 05:41  | x64      |
| Batchparser.dll                              | 2017.140.3356.20 | 173960    | 21-Aug-20 | 05:41  | x64      |
| C1.dll                                       | 18.10.40116.18   | 925232    | 15-Feb-20 | 16:24 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5341440   | 15-Feb-20 | 16:24 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 192048    | 15-Feb-20 | 16:24 | x64      |
| Clui.dll                                     | 18.10.40116.10   | 486144    | 21-Aug-20 | 05:19  | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 15-Feb-20 | 17:33 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3356.20 | 220552    | 21-Aug-20 | 06:00  | x64      |
| Dcexec.exe                                   | 2017.140.3356.20 | 67472     | 21-Aug-20 | 06:00  | x64      |
| Fssres.dll                                   | 2017.140.3356.20 | 83848     | 21-Aug-20 | 06:00  | x64      |
| Hadrres.dll                                  | 2017.140.3356.20 | 182664    | 21-Aug-20 | 06:00  | x64      |
| Hkcompile.dll                                | 2017.140.3356.20 | 1416072   | 21-Aug-20 | 06:00  | x64      |
| Hkengine.dll                                 | 2017.140.3356.20 | 5852040   | 21-Aug-20 | 06:00  | x64      |
| Hkruntime.dll                                | 2017.140.3356.20 | 156048    | 21-Aug-20 | 06:00  | x64      |
| Link.exe                                     | 12.10.40116.18   | 1017392   | 15-Feb-20 | 16:24 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.54      | 734096    | 11-Aug-20 | 07:18  | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 14-Aug-20 | 04:10  | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3356.20     | 229768    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3356.20     | 73088     | 21-Aug-20 | 05:57  | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3356.20 | 385936    | 21-Aug-20 | 05:56  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3356.20 | 65416     | 21-Aug-20 | 05:41  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3356.20 | 58256     | 21-Aug-20 | 05:39  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3356.20 | 145280    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3356.20 | 152464    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3356.20 | 296848    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3356.20 | 67976     | 21-Aug-20 | 05:56  | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 129576    | 21-Aug-20 | 05:19  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 559144    | 15-Feb-20 | 16:24 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 559144    | 15-Feb-20 | 16:24 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 661040    | 15-Feb-20 | 16:24 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 964656    | 15-Feb-20 | 16:24 | x64      |
| Odsole70.dll                                 | 2017.140.3356.20 | 85896     | 21-Aug-20 | 06:00  | x64      |
| Opends60.dll                                 | 2017.140.3356.20 | 25992     | 21-Aug-20 | 05:41  | x64      |
| Qds.dll                                      | 2017.140.3356.20 | 1177488   | 21-Aug-20 | 08:57  | x64      |
| Rsfxft.dll                                   | 2017.140.3356.20 | 27528     | 21-Aug-20 | 05:41  | x64      |
| Secforwarder.dll                             | 2017.140.3356.20 | 30600     | 21-Aug-20 | 05:56  | x64      |
| Sqagtres.dll                                 | 2017.140.3356.20 | 69000     | 21-Aug-20 | 05:41  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Sqlaamss.dll                                 | 2017.140.3356.20 | 84864     | 21-Aug-20 | 06:00  | x64      |
| Sqlaccess.dll                                | 2017.140.3356.20 | 468880    | 21-Aug-20 | 05:41  | x64      |
| Sqlagent.exe                                 | 2017.140.3356.20 | 598408    | 21-Aug-20 | 06:00  | x64      |
| Sqlagentctr140.dll                           | 2017.140.3356.20 | 47496     | 21-Aug-20 | 05:41  | x86      |
| Sqlagentctr140.dll                           | 2017.140.3356.20 | 56208     | 21-Aug-20 | 05:57  | x64      |
| Sqlagentlog.dll                              | 2017.140.3356.20 | 25992     | 21-Aug-20 | 05:41  | x64      |
| Sqlagentmail.dll                             | 2017.140.3356.20 | 46984     | 21-Aug-20 | 05:41  | x64      |
| Sqlboot.dll                                  | 2017.140.3356.20 | 190864    | 21-Aug-20 | 05:41  | x64      |
| Sqlceip.exe                                  | 14.0.3356.20     | 254856    | 21-Aug-20 | 06:00  | x86      |
| Sqlcmdss.dll                                 | 2017.140.3356.20 | 67472     | 21-Aug-20 | 06:00  | x64      |
| Sqlctr140.dll                                | 2017.140.3356.20 | 106376    | 21-Aug-20 | 05:41  | x86      |
| Sqlctr140.dll                                | 2017.140.3356.20 | 123784    | 21-Aug-20 | 06:00  | x64      |
| Sqldk.dll                                    | 2017.140.3356.20 | 2800016   | 21-Aug-20 | 08:57  | x64      |
| Sqldtsss.dll                                 | 2017.140.3356.20 | 102280    | 21-Aug-20 | 06:22  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 2086792   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3917192   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3784576   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 1493896   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 2033024   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3786632   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 4026760   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3212160   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3295616   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3676560   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3820424   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3587976   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3635584   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3366280   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3480456   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3401608   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3595656   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3779464   | 21-Aug-20 | 05:57  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 1441152   | 21-Aug-20 | 05:58  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3289984   | 21-Aug-20 | 05:58  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3914120   | 21-Aug-20 | 05:58  | x64      |
| Sqlevn70.rll                                 | 2017.140.3356.20 | 3337096   | 21-Aug-20 | 05:59  | x64      |
| Sqliosim.com                                 | 2017.140.3356.20 | 306568    | 21-Aug-20 | 05:56  | x64      |
| Sqliosim.exe                                 | 2017.140.3356.20 | 3013000   | 21-Aug-20 | 06:00  | x64      |
| Sqllang.dll                                  | 2017.140.3356.20 | 41388928  | 21-Aug-20 | 09:14  | x64      |
| Sqlmin.dll                                   | 2017.140.3356.20 | 40547728  | 21-Aug-20 | 09:10  | x64      |
| Sqlolapss.dll                                | 2017.140.3356.20 | 102288    | 21-Aug-20 | 06:00  | x64      |
| Sqlos.dll                                    | 2017.140.3356.20 | 19336     | 21-Aug-20 | 05:56  | x64      |
| Sqlpowershellss.dll                          | 2017.140.3356.20 | 62864     | 21-Aug-20 | 06:00  | x64      |
| Sqlrepss.dll                                 | 2017.140.3356.20 | 61840     | 21-Aug-20 | 06:00  | x64      |
| Sqlresld.dll                                 | 2017.140.3356.20 | 23944     | 21-Aug-20 | 05:41  | x64      |
| Sqlresourceloader.dll                        | 2017.140.3356.20 | 25480     | 21-Aug-20 | 05:41  | x64      |
| Sqlscm.dll                                   | 2017.140.3356.20 | 65936     | 21-Aug-20 | 05:41  | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3356.20 | 20864     | 21-Aug-20 | 05:41  | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3356.20 | 5890448   | 21-Aug-20 | 05:41  | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3356.20 | 725896    | 21-Aug-20 | 06:00  | x64      |
| Sqlservr.exe                                 | 2017.140.3356.20 | 481680    | 21-Aug-20 | 09:00  | x64      |
| Sqlsvc.dll                                   | 2017.140.3356.20 | 156048    | 21-Aug-20 | 06:00  | x64      |
| Sqltses.dll                                  | 2017.140.3356.20 | 9559440   | 21-Aug-20 | 09:00  | x64      |
| Sqsrvres.dll                                 | 2017.140.3356.20 | 255872    | 21-Aug-20 | 06:00  | x64      |
| Svl.dll                                      | 2017.140.3356.20 | 147336    | 21-Aug-20 | 06:00  | x64      |
| Xe.dll                                       | 2017.140.3356.20 | 666504    | 21-Aug-20 | 05:39  | x64      |
| Xmlrw.dll                                    | 2017.140.3356.20 | 298368    | 21-Aug-20 | 05:41  | x64      |
| Xmlrwbin.dll                                 | 2017.140.3356.20 | 217480    | 21-Aug-20 | 05:41  | x64      |
| Xpadsi.exe                                   | 2017.140.3356.20 | 84880     | 21-Aug-20 | 05:41  | x64      |
| Xplog70.dll                                  | 2017.140.3356.20 | 71048     | 21-Aug-20 | 06:00  | x64      |
| Xpqueue.dll                                  | 2017.140.3356.20 | 67976     | 21-Aug-20 | 05:41  | x64      |
| Xprepl.dll                                   | 2017.140.3356.20 | 96656     | 21-Aug-20 | 05:41  | x64      |
| Xpsqlbot.dll                                 | 2017.140.3356.20 | 25488     | 21-Aug-20 | 05:41  | x64      |
| Xpstar.dll                                   | 2017.140.3356.20 | 445320    | 21-Aug-20 | 06:00  | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version     | File size | Date      | Time  | Platform |
|-------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3356.20 | 173960    | 21-Aug-20 | 05:41  | x64      |
| Batchparser.dll                                             | 2017.140.3356.20 | 153480    | 21-Aug-20 | 05:41  | x86      |
| Bcp.exe                                                     | 2017.140.3356.20 | 113040    | 21-Aug-20 | 06:00  | x64      |
| Commanddest.dll                                             | 2017.140.3356.20 | 238984    | 21-Aug-20 | 06:00  | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3356.20 | 109448    | 21-Aug-20 | 06:00  | x64      |
| Datacollectortasks.dll                                      | 2017.140.3356.20 | 180616    | 21-Aug-20 | 06:00  | x64      |
| Distrib.exe                                                 | 2017.140.3356.20 | 198032    | 21-Aug-20 | 05:41  | x64      |
| Dteparse.dll                                                | 2017.140.3356.20 | 104336    | 21-Aug-20 | 06:00  | x64      |
| Dteparsemgd.dll                                             | 2017.140.3356.20 | 82320     | 21-Aug-20 | 06:00  | x64      |
| Dtepkg.dll                                                  | 2017.140.3356.20 | 130952    | 21-Aug-20 | 06:00  | x64      |
| Dtexec.exe                                                  | 2017.140.3356.20 | 66952     | 21-Aug-20 | 06:00  | x64      |
| Dts.dll                                                     | 2017.140.3356.20 | 2994056   | 21-Aug-20 | 06:00  | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3356.20 | 468352    | 21-Aug-20 | 06:00  | x64      |
| Dtsconn.dll                                                 | 2017.140.3356.20 | 493440    | 21-Aug-20 | 06:00  | x64      |
| Dtshost.exe                                                 | 2017.140.3356.20 | 99208     | 21-Aug-20 | 06:00  | x64      |
| Dtslog.dll                                                  | 2017.140.3356.20 | 113544    | 21-Aug-20 | 06:00  | x64      |
| Dtsmsg140.dll                                               | 2017.140.3356.20 | 538512    | 21-Aug-20 | 05:41  | x64      |
| Dtspipeline.dll                                             | 2017.140.3356.20 | 1261456   | 21-Aug-20 | 06:00  | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3356.20 | 41360     | 21-Aug-20 | 06:00  | x64      |
| Dtuparse.dll                                                | 2017.140.3356.20 | 82312     | 21-Aug-20 | 06:00  | x64      |
| Dtutil.exe                                                  | 2017.140.3356.20 | 141696    | 21-Aug-20 | 06:00  | x64      |
| Exceldest.dll                                               | 2017.140.3356.20 | 253832    | 21-Aug-20 | 06:00  | x64      |
| Excelsrc.dll                                                | 2017.140.3356.20 | 275848    | 21-Aug-20 | 06:00  | x64      |
| Execpackagetask.dll                                         | 2017.140.3356.20 | 161160    | 21-Aug-20 | 06:00  | x64      |
| Flatfiledest.dll                                            | 2017.140.3356.20 | 379784    | 21-Aug-20 | 06:00  | x64      |
| Flatfilesrc.dll                                             | 2017.140.3356.20 | 392584    | 21-Aug-20 | 06:00  | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3356.20 | 89480     | 21-Aug-20 | 06:00  | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3356.20 | 52608     | 21-Aug-20 | 06:00  | x64      |
| Ionic.zip.dll                                               | 1.9.1.8          | 471440    | 15-Feb-20 | 17:38 | x86      |
| Logread.exe                                                 | 2017.140.3356.20 | 629640    | 21-Aug-20 | 06:00  | x64      |
| Mergetxt.dll                                                | 2017.140.3356.20 | 58256     | 21-Aug-20 | 05:41  | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.54      | 1374600   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 12-Feb-20 | 23:00 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3356.20     | 130952    | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3356.20     | 48528     | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3356.20     | 82816     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3356.20     | 66440     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3356.20     | 385424    | 21-Aug-20 | 06:19  | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3356.20     | 607632    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3356.20 | 1657744   | 21-Aug-20 | 06:00  | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3356.20     | 564608    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3356.20 | 145280    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3356.20 | 152464    | 21-Aug-20 | 05:56  | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3356.20 | 96136     | 21-Aug-20 | 06:00  | x64      |
| Msgprox.dll                                                 | 2017.140.3356.20 | 265104    | 21-Aug-20 | 05:41  | x64      |
| Msxmlsql.dll                                                | 2017.140.3356.20 | 1441152   | 21-Aug-20 | 06:00  | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111      | 522856    | 8-Jul-20  | 01:35  | x86      |
| Oledbdest.dll                                               | 2017.140.3356.20 | 254344    | 21-Aug-20 | 06:00  | x64      |
| Oledbsrc.dll                                                | 2017.140.3356.20 | 281992    | 21-Aug-20 | 06:00  | x64      |
| Osql.exe                                                    | 2017.140.3356.20 | 68488     | 21-Aug-20 | 05:41  | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3356.20 | 468880    | 21-Aug-20 | 06:00  | x64      |
| Rawdest.dll                                                 | 2017.140.3356.20 | 199560    | 21-Aug-20 | 06:00  | x64      |
| Rawsource.dll                                               | 2017.140.3356.20 | 187272    | 21-Aug-20 | 06:00  | x64      |
| Rdistcom.dll                                                | 2017.140.3356.20 | 852368    | 21-Aug-20 | 06:00  | x64      |
| Recordsetdest.dll                                           | 2017.140.3356.20 | 177544    | 21-Aug-20 | 06:00  | x64      |
| Replagnt.dll                                                | 2017.140.3356.20 | 23952     | 21-Aug-20 | 05:41  | x64      |
| Repldp.dll                                                  | 2017.140.3356.20 | 285584    | 21-Aug-20 | 05:41  | x64      |
| Replerrx.dll                                                | 2017.140.3356.20 | 148880    | 21-Aug-20 | 05:41  | x64      |
| Replisapi.dll                                               | 2017.140.3356.20 | 357264    | 21-Aug-20 | 05:41  | x64      |
| Replmerg.exe                                                | 2017.140.3356.20 | 520080    | 21-Aug-20 | 06:00  | x64      |
| Replprov.dll                                                | 2017.140.3356.20 | 797072    | 21-Aug-20 | 06:00  | x64      |
| Replrec.dll                                                 | 2017.140.3356.20 | 970120    | 21-Aug-20 | 06:00  | x64      |
| Replsub.dll                                                 | 2017.140.3356.20 | 440208    | 21-Aug-20 | 06:00  | x64      |
| Replsync.dll                                                | 2017.140.3356.20 | 148368    | 21-Aug-20 | 05:41  | x64      |
| Sort00001000.dll                                            | 4.0.30319.576    | 871680    | 12-Feb-20 | 23:01 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576    | 75016     | 12-Feb-20 | 23:01 | x64      |
| Spresolv.dll                                                | 2017.140.3356.20 | 247184    | 21-Aug-20 | 06:00  | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Sqlcmd.exe                                                  | 2017.140.3356.20 | 242048    | 21-Aug-20 | 05:41  | x64      |
| Sqldiag.exe                                                 | 2017.140.3356.20 | 1254792   | 21-Aug-20 | 05:41  | x64      |
| Sqldistx.dll                                                | 2017.140.3356.20 | 219536    | 21-Aug-20 | 05:41  | x64      |
| Sqllogship.exe                                              | 14.0.3356.20     | 99208     | 21-Aug-20 | 05:41  | x64      |
| Sqlmergx.dll                                                | 2017.140.3356.20 | 355208    | 21-Aug-20 | 05:41  | x64      |
| Sqlresld.dll                                                | 2017.140.3356.20 | 23944     | 21-Aug-20 | 05:41  | x64      |
| Sqlresld.dll                                                | 2017.140.3356.20 | 21904     | 21-Aug-20 | 05:41  | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3356.20 | 25480     | 21-Aug-20 | 05:41  | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3356.20 | 22400     | 21-Aug-20 | 05:41  | x86      |
| Sqlscm.dll                                                  | 2017.140.3356.20 | 65936     | 21-Aug-20 | 05:41  | x64      |
| Sqlscm.dll                                                  | 2017.140.3356.20 | 55168     | 21-Aug-20 | 05:41  | x86      |
| Sqlsvc.dll                                                  | 2017.140.3356.20 | 128400    | 21-Aug-20 | 05:41  | x86      |
| Sqlsvc.dll                                                  | 2017.140.3356.20 | 156048    | 21-Aug-20 | 06:00  | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3356.20 | 177032    | 21-Aug-20 | 06:00  | x64      |
| Sqlwep140.dll                                               | 2017.140.3356.20 | 98704     | 21-Aug-20 | 05:41  | x64      |
| Ssdebugps.dll                                               | 2017.140.3356.20 | 26504     | 21-Aug-20 | 06:00  | x64      |
| Ssisoledb.dll                                               | 2017.140.3356.20 | 209288    | 21-Aug-20 | 06:00  | x64      |
| Ssradd.dll                                                  | 2017.140.3356.20 | 70032     | 21-Aug-20 | 05:41  | x64      |
| Ssravg.dll                                                  | 2017.140.3356.20 | 70544     | 21-Aug-20 | 05:41  | x64      |
| Ssrdown.dll                                                 | 2017.140.3356.20 | 55184     | 21-Aug-20 | 06:00  | x64      |
| Ssrmax.dll                                                  | 2017.140.3356.20 | 68496     | 21-Aug-20 | 05:41  | x64      |
| Ssrmin.dll                                                  | 2017.140.3356.20 | 68496     | 21-Aug-20 | 06:00  | x64      |
| Ssrpub.dll                                                  | 2017.140.3356.20 | 55696     | 21-Aug-20 | 06:00  | x64      |
| Ssrup.dll                                                   | 2017.140.3356.20 | 55184     | 21-Aug-20 | 05:41  | x64      |
| Tablediff.exe                                               | 14.0.3356.20     | 79752     | 21-Aug-20 | 05:41  | x64      |
| Txagg.dll                                                   | 2017.140.3356.20 | 355208    | 21-Aug-20 | 06:00  | x64      |
| Txbdd.dll                                                   | 2017.140.3356.20 | 163208    | 21-Aug-20 | 06:00  | x64      |
| Txdatacollector.dll                                         | 2017.140.3356.20 | 353672    | 21-Aug-20 | 06:00  | x64      |
| Txdataconvert.dll                                           | 2017.140.3356.20 | 286080    | 21-Aug-20 | 06:00  | x64      |
| Txderived.dll                                               | 2017.140.3356.20 | 597384    | 21-Aug-20 | 06:00  | x64      |
| Txlookup.dll                                                | 2017.140.3356.20 | 521096    | 21-Aug-20 | 06:00  | x64      |
| Txmerge.dll                                                 | 2017.140.3356.20 | 223112    | 21-Aug-20 | 06:00  | x64      |
| Txmergejoin.dll                                             | 2017.140.3356.20 | 268680    | 21-Aug-20 | 06:00  | x64      |
| Txmulticast.dll                                             | 2017.140.3356.20 | 120704    | 21-Aug-20 | 06:00  | x64      |
| Txrowcount.dll                                              | 2017.140.3356.20 | 118664    | 21-Aug-20 | 06:00  | x64      |
| Txsort.dll                                                  | 2017.140.3356.20 | 249728    | 21-Aug-20 | 06:00  | x64      |
| Txsplit.dll                                                 | 2017.140.3356.20 | 589704    | 21-Aug-20 | 06:00  | x64      |
| Txunionall.dll                                              | 2017.140.3356.20 | 174984    | 21-Aug-20 | 06:00  | x64      |
| Xe.dll                                                      | 2017.140.3356.20 | 666504    | 21-Aug-20 | 05:39  | x64      |
| Xmlrw.dll                                                   | 2017.140.3356.20 | 298368    | 21-Aug-20 | 05:41  | x64      |
| Xmlsub.dll                                                  | 2017.140.3356.20 | 255376    | 21-Aug-20 | 06:00  | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version     | File size | Date      | Time | Platform |
|-------------------------------|------------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3356.20 | 1119624   | 21-Aug-20 | 06:14 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |
| Sqlsatellite.dll              | 2017.140.3356.20 | 916864    | 21-Aug-20 | 06:14 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version     | File size | Date      | Time | Platform |
|--------------------------|------------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3356.20 | 665488    | 21-Aug-20 | 06:00 | x64      |
| Fdhost.exe               | 2017.140.3356.20 | 109448    | 21-Aug-20 | 06:00 | x64      |
| Fdlauncher.exe           | 2017.140.3356.20 | 57232     | 21-Aug-20 | 05:41 | x64      |
| Nlsdl.dll                | 6.0.6001.18000   | 46360     | 14-Aug-20 | 07:19 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |
| Sqlft140ph.dll           | 2017.140.3356.20 | 62864     | 21-Aug-20 | 05:41 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version     | File size | Date      | Time | Platform |
|-------------------------|------------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3356.20     | 17288     | 21-Aug-20 | 05:41 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112        | 75264     | 12-Feb-20 | 23:00 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112        | 36352     | 17-Apr-20 | 10:19 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112        | 76288     | 12-Feb-20 | 23:00 | x86      |
| Commanddest.dll                                               | 2017.140.3356.20 | 193936    | 21-Aug-20 | 05:59  | x86      |
| Commanddest.dll                                               | 2017.140.3356.20 | 238984    | 21-Aug-20 | 06:00  | x64      |
| Dteparse.dll                                                  | 2017.140.3356.20 | 93584     | 21-Aug-20 | 06:00  | x86      |
| Dteparse.dll                                                  | 2017.140.3356.20 | 104336    | 21-Aug-20 | 06:00  | x64      |
| Dteparsemgd.dll                                               | 2017.140.3356.20 | 76680     | 21-Aug-20 | 06:00  | x86      |
| Dteparsemgd.dll                                               | 2017.140.3356.20 | 82320     | 21-Aug-20 | 06:00  | x64      |
| Dtepkg.dll                                                    | 2017.140.3356.20 | 109960    | 21-Aug-20 | 06:00  | x86      |
| Dtepkg.dll                                                    | 2017.140.3356.20 | 130952    | 21-Aug-20 | 06:00  | x64      |
| Dtexec.exe                                                    | 2017.140.3356.20 | 60808     | 21-Aug-20 | 06:00  | x86      |
| Dtexec.exe                                                    | 2017.140.3356.20 | 66952     | 21-Aug-20 | 06:00  | x64      |
| Dts.dll                                                       | 2017.140.3356.20 | 2544008   | 21-Aug-20 | 06:00  | x86      |
| Dts.dll                                                       | 2017.140.3356.20 | 2994056   | 21-Aug-20 | 06:00  | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3356.20 | 411024    | 21-Aug-20 | 06:00  | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3356.20 | 468352    | 21-Aug-20 | 06:00  | x64      |
| Dtsconn.dll                                                   | 2017.140.3356.20 | 395664    | 21-Aug-20 | 06:00  | x86      |
| Dtsconn.dll                                                   | 2017.140.3356.20 | 493440    | 21-Aug-20 | 06:00  | x64      |
| Dtsdebughost.exe                                              | 2017.140.3356.20 | 88464     | 21-Aug-20 | 06:00  | x86      |
| Dtsdebughost.exe                                              | 2017.140.3356.20 | 104328    | 21-Aug-20 | 06:00  | x64      |
| Dtshost.exe                                                   | 2017.140.3356.20 | 84368     | 21-Aug-20 | 06:00  | x86      |
| Dtshost.exe                                                   | 2017.140.3356.20 | 99208     | 21-Aug-20 | 06:00  | x64      |
| Dtslog.dll                                                    | 2017.140.3356.20 | 96144     | 21-Aug-20 | 06:00  | x86      |
| Dtslog.dll                                                    | 2017.140.3356.20 | 113544    | 21-Aug-20 | 06:00  | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3356.20 | 538512    | 21-Aug-20 | 05:41  | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3356.20 | 534408    | 21-Aug-20 | 05:41  | x86      |
| Dtspipeline.dll                                               | 2017.140.3356.20 | 1053576   | 21-Aug-20 | 06:00  | x86      |
| Dtspipeline.dll                                               | 2017.140.3356.20 | 1261456   | 21-Aug-20 | 06:00  | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3356.20 | 35728     | 21-Aug-20 | 06:00  | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3356.20 | 41360     | 21-Aug-20 | 06:00  | x64      |
| Dtuparse.dll                                                  | 2017.140.3356.20 | 73104     | 21-Aug-20 | 06:00  | x86      |
| Dtuparse.dll                                                  | 2017.140.3356.20 | 82312     | 21-Aug-20 | 06:00  | x64      |
| Dtutil.exe                                                    | 2017.140.3356.20 | 120704    | 21-Aug-20 | 06:00  | x86      |
| Dtutil.exe                                                    | 2017.140.3356.20 | 141696    | 21-Aug-20 | 06:00  | x64      |
| Exceldest.dll                                                 | 2017.140.3356.20 | 207760    | 21-Aug-20 | 06:00  | x86      |
| Exceldest.dll                                                 | 2017.140.3356.20 | 253832    | 21-Aug-20 | 06:00  | x64      |
| Excelsrc.dll                                                  | 2017.140.3356.20 | 223632    | 21-Aug-20 | 06:00  | x86      |
| Excelsrc.dll                                                  | 2017.140.3356.20 | 275848    | 21-Aug-20 | 06:00  | x64      |
| Execpackagetask.dll                                           | 2017.140.3356.20 | 128400    | 21-Aug-20 | 06:00  | x86      |
| Execpackagetask.dll                                           | 2017.140.3356.20 | 161160    | 21-Aug-20 | 06:00  | x64      |
| Flatfiledest.dll                                              | 2017.140.3356.20 | 325520    | 21-Aug-20 | 06:00  | x86      |
| Flatfiledest.dll                                              | 2017.140.3356.20 | 379784    | 21-Aug-20 | 06:00  | x64      |
| Flatfilesrc.dll                                               | 2017.140.3356.20 | 337296    | 21-Aug-20 | 06:00  | x86      |
| Flatfilesrc.dll                                               | 2017.140.3356.20 | 392584    | 21-Aug-20 | 06:00  | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3356.20 | 73616     | 21-Aug-20 | 06:00  | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3356.20 | 89480     | 21-Aug-20 | 06:00  | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8          | 471440    | 15-Feb-20 | 17:38 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3356.20     | 460168    | 21-Aug-20 | 06:30  | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3356.20     | 459648    | 21-Aug-20 | 06:30  | x64      |
| Isserverexec.exe                                              | 14.0.3356.20     | 142216    | 21-Aug-20 | 06:00  | x86      |
| Isserverexec.exe                                              | 14.0.3356.20     | 141704    | 21-Aug-20 | 06:00  | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.54      | 1374608   | 11-Aug-20 | 07:18  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.54      | 1374600   | 21-Aug-20 | 05:27  | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 14-Aug-20 | 04:10  | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 12-Feb-20 | 23:00 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3356.20     | 67464     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3356.20 | 100224    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3356.20 | 105352    | 21-Aug-20 | 06:00  | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3356.20     | 48528     | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3356.20     | 48528     | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3356.20     | 82824     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3356.20     | 82816     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3356.20     | 66448     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3356.20     | 66440     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3356.20     | 507784    | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3356.20     | 507784    | 21-Aug-20 | 05:41  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3356.20     | 76688     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3356.20     | 76688     | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3356.20     | 408960    | 21-Aug-20 | 06:26  | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3356.20     | 408976    | 21-Aug-20 | 06:30  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3356.20     | 385424    | 21-Aug-20 | 06:19  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3356.20     | 607632    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3356.20     | 607632    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3356.20     | 246160    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3356.20     | 246152    | 21-Aug-20 | 06:00  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3356.20 | 145280    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3356.20 | 135056    | 21-Aug-20 | 05:57  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3356.20 | 152464    | 21-Aug-20 | 05:56  | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3356.20 | 138640    | 21-Aug-20 | 05:56  | x86      |
| Msdtssrvr.exe                                                 | 14.0.3356.20     | 212864    | 21-Aug-20 | 06:00  | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3356.20 | 83344     | 21-Aug-20 | 05:59  | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3356.20 | 96136     | 21-Aug-20 | 06:00  | x64      |
| Msmdpp.dll                                                    | 2017.140.249.54  | 9191832   | 11-Aug-20 | 07:18  | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 513424    | 2-Jul-20  | 05:22  | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 522856    | 8-Jul-20  | 01:35  | x86      |
| Oledbdest.dll                                                 | 2017.140.3356.20 | 207760    | 21-Aug-20 | 06:00  | x86      |
| Oledbdest.dll                                                 | 2017.140.3356.20 | 254344    | 21-Aug-20 | 06:00  | x64      |
| Oledbsrc.dll                                                  | 2017.140.3356.20 | 226192    | 21-Aug-20 | 06:00  | x86      |
| Oledbsrc.dll                                                  | 2017.140.3356.20 | 281992    | 21-Aug-20 | 06:00  | x64      |
| Rawdest.dll                                                   | 2017.140.3356.20 | 199560    | 21-Aug-20 | 06:00  | x64      |
| Rawdest.dll                                                   | 2017.140.3356.20 | 159632    | 21-Aug-20 | 06:00  | x86      |
| Rawsource.dll                                                 | 2017.140.3356.20 | 146320    | 21-Aug-20 | 06:00  | x86      |
| Rawsource.dll                                                 | 2017.140.3356.20 | 187272    | 21-Aug-20 | 06:00  | x64      |
| Recordsetdest.dll                                             | 2017.140.3356.20 | 142224    | 21-Aug-20 | 06:00  | x86      |
| Recordsetdest.dll                                             | 2017.140.3356.20 | 177544    | 21-Aug-20 | 06:00  | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41  | x64      |
| Sqlceip.exe                                                   | 14.0.3356.20     | 254856    | 21-Aug-20 | 06:00  | x86      |
| Sqldest.dll                                                   | 2017.140.3356.20 | 253824    | 21-Aug-20 | 06:00  | x64      |
| Sqldest.dll                                                   | 2017.140.3356.20 | 206736    | 21-Aug-20 | 06:00  | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3356.20 | 148368    | 21-Aug-20 | 06:00  | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3356.20 | 177032    | 21-Aug-20 | 06:00  | x64      |
| Ssisoledb.dll                                                 | 2017.140.3356.20 | 169856    | 21-Aug-20 | 06:00  | x86      |
| Ssisoledb.dll                                                 | 2017.140.3356.20 | 209288    | 21-Aug-20 | 06:00  | x64      |
| Txagg.dll                                                     | 2017.140.3356.20 | 355208    | 21-Aug-20 | 06:00  | x64      |
| Txagg.dll                                                     | 2017.140.3356.20 | 295312    | 21-Aug-20 | 06:00  | x86      |
| Txbdd.dll                                                     | 2017.140.3356.20 | 163208    | 21-Aug-20 | 06:00  | x64      |
| Txbdd.dll                                                     | 2017.140.3356.20 | 129424    | 21-Aug-20 | 06:00  | x86      |
| Txbestmatch.dll                                               | 2017.140.3356.20 | 486288    | 21-Aug-20 | 06:00  | x86      |
| Txbestmatch.dll                                               | 2017.140.3356.20 | 598400    | 21-Aug-20 | 06:00  | x64      |
| Txcache.dll                                                   | 2017.140.3356.20 | 173448    | 21-Aug-20 | 06:00  | x64      |
| Txcache.dll                                                   | 2017.140.3356.20 | 139152    | 21-Aug-20 | 06:00  | x86      |
| Txcharmap.dll                                                 | 2017.140.3356.20 | 279936    | 21-Aug-20 | 06:00  | x64      |
| Txcharmap.dll                                                 | 2017.140.3356.20 | 242064    | 21-Aug-20 | 06:00  | x86      |
| Txcopymap.dll                                                 | 2017.140.3356.20 | 173448    | 21-Aug-20 | 06:00  | x64      |
| Txcopymap.dll                                                 | 2017.140.3356.20 | 138640    | 21-Aug-20 | 06:00  | x86      |
| Txdataconvert.dll                                             | 2017.140.3356.20 | 286080    | 21-Aug-20 | 06:00  | x64      |
| Txdataconvert.dll                                             | 2017.140.3356.20 | 246160    | 21-Aug-20 | 06:00  | x86      |
| Txderived.dll                                                 | 2017.140.3356.20 | 597384    | 21-Aug-20 | 06:00  | x64      |
| Txderived.dll                                                 | 2017.140.3356.20 | 508816    | 21-Aug-20 | 06:00  | x86      |
| Txfileextractor.dll                                           | 2017.140.3356.20 | 191880    | 21-Aug-20 | 06:00  | x64      |
| Txfileextractor.dll                                           | 2017.140.3356.20 | 154000    | 21-Aug-20 | 06:00  | x86      |
| Txfileinserter.dll                                            | 2017.140.3356.20 | 152464    | 21-Aug-20 | 06:00  | x86      |
| Txfileinserter.dll                                            | 2017.140.3356.20 | 189832    | 21-Aug-20 | 06:00  | x64      |
| Txgroupdups.dll                                               | 2017.140.3356.20 | 224144    | 21-Aug-20 | 06:00  | x86      |
| Txgroupdups.dll                                               | 2017.140.3356.20 | 283528    | 21-Aug-20 | 06:00  | x64      |
| Txlineage.dll                                                 | 2017.140.3356.20 | 129928    | 21-Aug-20 | 06:00  | x64      |
| Txlineage.dll                                                 | 2017.140.3356.20 | 103312    | 21-Aug-20 | 06:00  | x86      |
| Txlookup.dll                                                  | 2017.140.3356.20 | 439696    | 21-Aug-20 | 06:00  | x86      |
| Txlookup.dll                                                  | 2017.140.3356.20 | 521096    | 21-Aug-20 | 06:00  | x64      |
| Txmerge.dll                                                   | 2017.140.3356.20 | 169872    | 21-Aug-20 | 06:00  | x86      |
| Txmerge.dll                                                   | 2017.140.3356.20 | 223112    | 21-Aug-20 | 06:00  | x64      |
| Txmergejoin.dll                                               | 2017.140.3356.20 | 214928    | 21-Aug-20 | 06:00  | x86      |
| Txmergejoin.dll                                               | 2017.140.3356.20 | 268680    | 21-Aug-20 | 06:00  | x64      |
| Txmulticast.dll                                               | 2017.140.3356.20 | 95632     | 21-Aug-20 | 06:00  | x86      |
| Txmulticast.dll                                               | 2017.140.3356.20 | 120704    | 21-Aug-20 | 06:00  | x64      |
| Txpivot.dll                                                   | 2017.140.3356.20 | 173456    | 21-Aug-20 | 06:00  | x86      |
| Txpivot.dll                                                   | 2017.140.3356.20 | 217992    | 21-Aug-20 | 06:00  | x64      |
| Txrowcount.dll                                                | 2017.140.3356.20 | 94608     | 21-Aug-20 | 06:00  | x86      |
| Txrowcount.dll                                                | 2017.140.3356.20 | 118664    | 21-Aug-20 | 06:00  | x64      |
| Txsampling.dll                                                | 2017.140.3356.20 | 128912    | 21-Aug-20 | 06:00  | x86      |
| Txsampling.dll                                                | 2017.140.3356.20 | 165768    | 21-Aug-20 | 06:00  | x64      |
| Txscd.dll                                                     | 2017.140.3356.20 | 163216    | 21-Aug-20 | 06:00  | x86      |
| Txscd.dll                                                     | 2017.140.3356.20 | 213888    | 21-Aug-20 | 06:00  | x64      |
| Txsort.dll                                                    | 2017.140.3356.20 | 201104    | 21-Aug-20 | 06:00  | x86      |
| Txsort.dll                                                    | 2017.140.3356.20 | 249728    | 21-Aug-20 | 06:00  | x64      |
| Txsplit.dll                                                   | 2017.140.3356.20 | 503696    | 21-Aug-20 | 06:00  | x86      |
| Txsplit.dll                                                   | 2017.140.3356.20 | 589704    | 21-Aug-20 | 06:00  | x64      |
| Txtermextraction.dll                                          | 2017.140.3356.20 | 8608144   | 21-Aug-20 | 06:00  | x86      |
| Txtermextraction.dll                                          | 2017.140.3356.20 | 8669568   | 21-Aug-20 | 06:00  | x64      |
| Txtermlookup.dll                                              | 2017.140.3356.20 | 4099984   | 21-Aug-20 | 06:00  | x86      |
| Txtermlookup.dll                                              | 2017.140.3356.20 | 4150152   | 21-Aug-20 | 06:00  | x64      |
| Txunionall.dll                                                | 2017.140.3356.20 | 174984    | 21-Aug-20 | 06:00  | x64      |
| Txunionall.dll                                                | 2017.140.3356.20 | 132496    | 21-Aug-20 | 06:00  | x86      |
| Txunpivot.dll                                                 | 2017.140.3356.20 | 153488    | 21-Aug-20 | 06:00  | x86      |
| Txunpivot.dll                                                 | 2017.140.3356.20 | 192904    | 21-Aug-20 | 06:00  | x64      |
| Xe.dll                                                        | 2017.140.3356.20 | 666504    | 21-Aug-20 | 05:39  | x64      |
| Xe.dll                                                        | 2017.140.3356.20 | 588688    | 21-Aug-20 | 05:40  | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 21-Aug-20 | 06:13  | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 21-Aug-20 | 06:13  | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 21-Aug-20 | 06:13  | x86      |
| Instapi140.dll                                                       | 2017.140.3356.20 | 65416     | 21-Aug-20 | 05:41  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 29-May-20 | 14:23 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 21-Aug-20 | 06:19  | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 15-Feb-20 | 18:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 21-Aug-20 | 06:14  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 29-May-20 | 14:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 15-Feb-20 | 18:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 21-Aug-20 | 06:14  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 15-Feb-20 | 18:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 21-Aug-20 | 06:30  | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 29-May-20 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 21-Aug-20 | 06:13  | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 21-Aug-20 | 06:13  | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3356.20 | 400264    | 21-Aug-20 | 06:00  | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3356.20 | 7320968   | 21-Aug-20 | 06:13  | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3356.20 | 2257808   | 21-Aug-20 | 05:41  | x64      |
| Secforwarder.dll                                                     | 2017.140.3356.20 | 30600     | 21-Aug-20 | 05:56  | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 21-Aug-20 | 05:27  | x64      |
| Sqldk.dll                                                            | 2017.140.3356.20 | 2732936   | 21-Aug-20 | 06:13  | x64      |
| Sqldumper.exe                                                        | 2017.140.3356.20 | 138640    | 21-Aug-20 | 05:39  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 1493896   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3914120   | 21-Aug-20 | 05:58  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3212160   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3917192   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3820424   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 2086792   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 2033024   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3587976   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3595656   | 21-Aug-20 | 05:56  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 1441152   | 21-Aug-20 | 05:58  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3356.20 | 3784576   | 21-Aug-20 | 05:56  | x64      |
| Sqlos.dll                                                            | 2017.140.3356.20 | 19336     | 21-Aug-20 | 05:56  | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 21-Aug-20 | 06:13  | x64      |
| Sqltses.dll                                                          | 2017.140.3356.20 | 9729416   | 21-Aug-20 | 06:13  | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version     | File size | Date      | Time | Platform |
|------------------------------------|------------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3356.20     | 17288     | 21-Aug-20 | 05:41 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version     | File size | Date      | Time | Platform |
|--------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Autoadmin.dll                                          | 2017.140.3356.20 | 1441680   | 21-Aug-20 | 05:57 | x86      |
| Dtaengine.exe                                          | 2017.140.3356.20 | 197512    | 21-Aug-20 | 05:57 | x86      |
| Dteparse.dll                                           | 2017.140.3356.20 | 93584     | 21-Aug-20 | 06:00 | x86      |
| Dteparse.dll                                           | 2017.140.3356.20 | 104336    | 21-Aug-20 | 06:00 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3356.20 | 76680     | 21-Aug-20 | 06:00 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3356.20 | 82320     | 21-Aug-20 | 06:00 | x64      |
| Dtepkg.dll                                             | 2017.140.3356.20 | 109960    | 21-Aug-20 | 06:00 | x86      |
| Dtepkg.dll                                             | 2017.140.3356.20 | 130952    | 21-Aug-20 | 06:00 | x64      |
| Dtexec.exe                                             | 2017.140.3356.20 | 60808     | 21-Aug-20 | 06:00 | x86      |
| Dtexec.exe                                             | 2017.140.3356.20 | 66952     | 21-Aug-20 | 06:00 | x64      |
| Dts.dll                                                | 2017.140.3356.20 | 2544008   | 21-Aug-20 | 06:00 | x86      |
| Dts.dll                                                | 2017.140.3356.20 | 2994056   | 21-Aug-20 | 06:00 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3356.20 | 411024    | 21-Aug-20 | 06:00 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3356.20 | 468352    | 21-Aug-20 | 06:00 | x64      |
| Dtsconn.dll                                            | 2017.140.3356.20 | 395664    | 21-Aug-20 | 06:00 | x86      |
| Dtsconn.dll                                            | 2017.140.3356.20 | 493440    | 21-Aug-20 | 06:00 | x64      |
| Dtshost.exe                                            | 2017.140.3356.20 | 84368     | 21-Aug-20 | 06:00 | x86      |
| Dtshost.exe                                            | 2017.140.3356.20 | 99208     | 21-Aug-20 | 06:00 | x64      |
| Dtslog.dll                                             | 2017.140.3356.20 | 96144     | 21-Aug-20 | 06:00 | x86      |
| Dtslog.dll                                             | 2017.140.3356.20 | 113544    | 21-Aug-20 | 06:00 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3356.20 | 538512    | 21-Aug-20 | 05:41 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3356.20 | 534408    | 21-Aug-20 | 05:41 | x86      |
| Dtspipeline.dll                                        | 2017.140.3356.20 | 1053576   | 21-Aug-20 | 06:00 | x86      |
| Dtspipeline.dll                                        | 2017.140.3356.20 | 1261456   | 21-Aug-20 | 06:00 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3356.20 | 35728     | 21-Aug-20 | 06:00 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3356.20 | 41360     | 21-Aug-20 | 06:00 | x64      |
| Dtuparse.dll                                           | 2017.140.3356.20 | 73104     | 21-Aug-20 | 06:00 | x86      |
| Dtuparse.dll                                           | 2017.140.3356.20 | 82312     | 21-Aug-20 | 06:00 | x64      |
| Dtutil.exe                                             | 2017.140.3356.20 | 120704    | 21-Aug-20 | 06:00 | x86      |
| Dtutil.exe                                             | 2017.140.3356.20 | 141696    | 21-Aug-20 | 06:00 | x64      |
| Exceldest.dll                                          | 2017.140.3356.20 | 207760    | 21-Aug-20 | 06:00 | x86      |
| Exceldest.dll                                          | 2017.140.3356.20 | 253832    | 21-Aug-20 | 06:00 | x64      |
| Excelsrc.dll                                           | 2017.140.3356.20 | 223632    | 21-Aug-20 | 06:00 | x86      |
| Excelsrc.dll                                           | 2017.140.3356.20 | 275848    | 21-Aug-20 | 06:00 | x64      |
| Flatfiledest.dll                                       | 2017.140.3356.20 | 325520    | 21-Aug-20 | 06:00 | x86      |
| Flatfiledest.dll                                       | 2017.140.3356.20 | 379784    | 21-Aug-20 | 06:00 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3356.20 | 337296    | 21-Aug-20 | 06:00 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3356.20 | 392584    | 21-Aug-20 | 06:00 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3356.20 | 73616     | 21-Aug-20 | 06:00 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3356.20 | 89480     | 21-Aug-20 | 06:00 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3356.20     | 67456     | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3356.20     | 179600    | 21-Aug-20 | 06:34 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3356.20     | 403344    | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3356.20     | 403336    | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3356.20     | 2086800   | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3356.20     | 2086792   | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3356.20     | 607632    | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3356.20     | 607632    | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3356.20     | 246160    | 21-Aug-20 | 06:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3356.20 | 145280    | 21-Aug-20 | 05:56 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3356.20 | 135056    | 21-Aug-20 | 05:57 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3356.20 | 152464    | 21-Aug-20 | 05:56 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3356.20 | 138640    | 21-Aug-20 | 05:56 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3356.20 | 83344     | 21-Aug-20 | 05:59 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3356.20 | 96136     | 21-Aug-20 | 06:00 | x64      |
| Msmgdsrv.dll                                           | 2017.140.249.54  | 7304592   | 11-Aug-20 | 07:18 | x86      |
| Oledbdest.dll                                          | 2017.140.3356.20 | 207760    | 21-Aug-20 | 06:00 | x86      |
| Oledbdest.dll                                          | 2017.140.3356.20 | 254344    | 21-Aug-20 | 06:00 | x64      |
| Oledbsrc.dll                                           | 2017.140.3356.20 | 226192    | 21-Aug-20 | 06:00 | x86      |
| Oledbsrc.dll                                           | 2017.140.3356.20 | 281992    | 21-Aug-20 | 06:00 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3356.20 | 93576     | 21-Aug-20 | 05:41 | x64      |
| Sqlresld.dll                                           | 2017.140.3356.20 | 23944     | 21-Aug-20 | 05:41 | x64      |
| Sqlresld.dll                                           | 2017.140.3356.20 | 21904     | 21-Aug-20 | 05:41 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3356.20 | 25480     | 21-Aug-20 | 05:41 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3356.20 | 22400     | 21-Aug-20 | 05:41 | x86      |
| Sqlscm.dll                                             | 2017.140.3356.20 | 65936     | 21-Aug-20 | 05:41 | x64      |
| Sqlscm.dll                                             | 2017.140.3356.20 | 55168     | 21-Aug-20 | 05:41 | x86      |
| Sqlsvc.dll                                             | 2017.140.3356.20 | 128400    | 21-Aug-20 | 05:41 | x86      |
| Sqlsvc.dll                                             | 2017.140.3356.20 | 156048    | 21-Aug-20 | 06:00 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3356.20 | 148368    | 21-Aug-20 | 06:00 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3356.20 | 177032    | 21-Aug-20 | 06:00 | x64      |
| Txdataconvert.dll                                      | 2017.140.3356.20 | 286080    | 21-Aug-20 | 06:00 | x64      |
| Txdataconvert.dll                                      | 2017.140.3356.20 | 246160    | 21-Aug-20 | 06:00 | x86      |
| Xe.dll                                                 | 2017.140.3356.20 | 666504    | 21-Aug-20 | 05:39 | x64      |
| Xe.dll                                                 | 2017.140.3356.20 | 588688    | 21-Aug-20 | 05:40 | x86      |
| Xmlrw.dll                                              | 2017.140.3356.20 | 298368    | 21-Aug-20 | 05:41 | x64      |
| Xmlrw.dll                                              | 2017.140.3356.20 | 250768    | 21-Aug-20 | 05:41 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3356.20 | 217480    | 21-Aug-20 | 05:41 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3356.20 | 182656    | 21-Aug-20 | 05:41 | x86      |

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
