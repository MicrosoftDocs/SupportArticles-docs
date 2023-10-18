---
title: Cumulative update 23 for SQL Server 2017 (KB5000685)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 23 (KB5000685).
ms.date: 08/04/2023
ms.custom: KB5000685
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5000685 - Cumulative Update 23 for SQL Server 2017

_Release Date:_ &nbsp; February 24, 2021  
_Version:_ &nbsp; 14.0.3381.3

## Summary

This article describes Cumulative Update package 23 (CU23) for Microsoft SQL Server 2017. This update contains 48 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 22, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3381.3**, file version: **2017.140.3381.3**
- Analysis Services - Product version: **14.0.249.70**, file version: **2017.140.249.70**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area| Component | Platform |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------------------------------------|----------|
| <a id=13745351>[13745351](#13745351) </a> | [FIX: Indefinite hang occurs during cube processing after applying SSAS 2016 SP2 CU7 (KB4589170)](https://support.microsoft.com/help/4589170) | Analysis Services | Analysis Services | Windows |
| <a id=13773701>[13773701](#13773701) </a> | [FIX: Data source with MultiSubnetFailover=True;ApplicationIntent=ReadOnly properties doesn't route requests to AG in SQL Server 2017 (KB4589362)](https://support.microsoft.com/help/4589362)| Analysis Service| Analysis Services | Windows |
| <a id=13773741>[13773741](#13773741) </a> | [FIX: SSAS 2017 stops responding when you run a DAX query (KB4589370)](https://support.microsoft.com/help/4589370)| Analysis Service| Analysis Services | Windows |
| <a id=13773746>[13773746](#13773746) </a> | [FIX: "Unexpected Exception" error occurs intermittently when SQL Dialect is used against SSAS Tabular model (KB4589372)](https://support.microsoft.com/help/4589372) | Analysis Service| Analysis Services | Windows |
| <a id=13763319>[13763319](#13763319) </a> | Power BI queries generally perform 2-5 times slower after upgrading from the SQL Server Analysis Services (SSAS) 2016 to 2017, due to different query plan generated and different Internal Vertipaq scan.| Analysis Services | Analysis Services | Windows |
| <a id=13948688>[13948688](#13948688) </a> | The [synchronizeSecurity](https://support.microsoft.com/contactus/?ws=support) setting of AMO method Microsoft.AnalysisServices.Tabular.Server.Synchronize is ignored. | Analysis Services | Analysis Services | Windows |
| <a id=13745343>[13745343](#13745343) </a> | Fixes deadlocks that occur in [catalog].[set_execution_property_override_value].| Integration Services| Engine| Windows|
| <a id=13490178>[13490178](#13490178) </a> | Fixes long duration taken for Integration Services Project deployment through PowerShell by improving search of operation messages in deployment process. | Integration Services| Server | Windows|
| <a id=13745355>[13745355](#13745355) </a> | [FIX: Intermittent connection error occurs when an expression is used for both connection string and password of a connection manager (KB4569837)](https://support.microsoft.com/help/4569837)| Integration Services| Tasks_Components | Windows |
| <a id=13916072>[13916072](#13916072) </a> | Fixes an error that HTTP connection manager can't connect to web services via TLS 1.1 & 1.2. | Integration Services| Tasks_Components| Windows|
| <a id=13745361>[13745361](#13745361) </a> | [FIX: ISDBUpgradeWizard.exe throws error when you try to upgrade SSISDB after restoring from earlier versions in SQL Server (KB4547890)](https://support.microsoft.com/help/4547890)| Integration Services| Tools | Windows |
| <a id=13773693>[13773693](#13773693) </a> | [FIX: SQL Server crashes when Afd!DbCreateSocketOperation process fails (KB4588977)](https://support.microsoft.com/help/4588977)| SQL Server Connectivity | Protocols | Linux|
| <a id=13746924>[13746924](#13746924) </a> | When you run a `RESTORE HEADERONLY` of SQL Server 2016 backup, you may notice [error 3285](/sql/relational-databases/errors-events/database-engine-events-and-errors#errors-3000---3999) even if the correct blocksize has been specified. If the error persists after applying this fix, you may specify the proper blocksize or contact Microsoft Support for assistance. | SQL Server Engine | Backup Restore | Windows |
| <a id=13746926>[13746926](#13746926) </a> | When you try to restore from a compressed or encrypted backup over an existing TDE enabled database, you may notice that the restore operation may take longer time than expected.| SQL Server Engine | Backup Restore| Windows|
| <a id=13818555>[13818555](#13818555) </a> | Fixes an issue where a database restore fails with an error 3257 (insufficient free space error) when the database is larger than 2 TB. The issue happens when the TotalAllocationUnits on the target volume is more than 4,294,967,295 units, for example when the target volume is larger than 16 TB and uses an allocation unit size = 512 bytes and a single sector per cluster.| SQL Server Engine | Backup Restore| Windows|
| <a id=13895274>[13895274](#13895274) </a> | [FIX: Memory grant wait times out when you run many Columnstore bulk inserts concurrently in SQL Server 2017 (KB5001045)](https://support.microsoft.com/help/5001045) | SQL Server Engine |Column Stores| All|
| <a id=13746937>[13746937](#13746937) </a> | `VERIFY_CLONEDB` prints message 'Clone database verification has failed' for the database if the database name starts with a number.| SQL Server Engine | DB Management | Windows|
| <a id=13724500>[13724500](#13724500) </a> | [FIX: Wrong results due to undetected concatenation parameters from scalar expression (KB5000649)](https://support.microsoft.com/help/5000649)| SQL Server Engine | Query Execution | All |
| <a id=13756398>[13756398](#13756398) </a> | [FIX: Wrong results when you run a query on In-Memory optimized tables in SQL Server 2017 (KB5001044)](https://support.microsoft.com/help/5001044)| SQL Server Engine | In-Memory OLTP | All|
| <a id=13708880>[13708880](#13708880) </a> | Fixes an issue where `ALTER AVAILABILITY GROUP SET (ROLE=SECONDARY)` raises an error 41104. However, it doesn't impact the Always On availability group health. | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=13737696>[13737696](#13737696) </a> | Fixes an issue where SQL process isn't killed properly resulting in subsequent start of SQL Server fails when the AG-Helper sends the `KILL 9` command to terminate the SQL Server process.| SQL Server Engine | High Availability and Disaster Recovery | Linux|
| <a id=13745331>[13745331](#13745331) </a> | [FIX: Automatic seeding failure occurs for a secondary replica in SQL Server (KB4568447)](https://support.microsoft.com/help/4568447) | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=13746920>[13746920](#13746920) </a> | Unable to connect to primary database replica after failing over the availability group in SQL Server.| SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=13760098>[13760098](#13760098) </a> | Forwarder is unable to reconnect to global primary following Global primary planned failover if the `LISTENER_URL` is modified. | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=13773689>[13773689](#13773689) </a> | [FIX: Incorrect results when you run INSERT INTO SELECT statement on memory-optimized table variables in SQL Server (KB4580397)](https://support.microsoft.com/help/4580397)| SQL Server Engine | In-Memory OLTP| Windows|
| <a id=13773671>[13773671](#13773671) </a> | [FIX: SQL Server service fails to start in Linux operating system (KB4582558)](https://support.microsoft.com/help/4582558)| SQL Server Engine | Linux | Linux|
| <a id=13924724>[13924724](#13924724) </a> | [FIX: "Login failed for user" error occurs when you run Maintenance plan with SQL login account in SQL Server 2017 (KB4486936)](https://support.microsoft.com/help/4486936)| SQL Server Engine | Management Services | Windows|
| <a id=13773660>[13773660](#13773660) </a> | [FIX: Error when you enable managed or automated backup in SQL Server 2016 and 2017 if "Allow Blob Public Access" is disabled on a storage account (KB4589360)](https://support.microsoft.com/help/4589360) | SQL Server Engine | Management Services | Windows|
| <a id=13773559>[13773559](#13773559) </a> | [FIX: Stored procedure (no SP:CacheInsert in trace) is not cached for database compatibility level 140 or 150 in SQL Server 2017 (KB4589352)](https://support.microsoft.com/help/4589352) | SQL Server Engine | Programmability | Windows|
| <a id=13773548>[13773548](#13773548) </a> | [FIX: MERGE statement fails with Access Violation at BTreeRow::DisableAccessReleaseOnWait in SQL Server (KB4589350)](https://support.microsoft.com/help/4589350)| SQL Server Engine | Query Execution | Windows|
| <a id=13745341>[13745341](#13745341) </a> | Fixes an access violation which occurs while querying row mod count property on spatial indexes in SQL Server 2017. | SQL Server Engine | Query Optimizer | Windows|
| <a id=13749460>[13749460](#13749460) </a> | Query Store scalability improvement for ad-hoc workloads. Query Store now imposes internal limits to the amount of memory, it can use and automatically changes the operation mode to READ-ONLY until enough memory has been returned to the Database Engine, preventing performance issues.| SQL Server Engine | Query Store | All|
| <a id=13745333>[13745333](#13745333) </a> | [Improvement: Option to forcefully turn QDS off by specifying the additional option in ALTER DB command (KB4571296)](https://support.microsoft.com/help/4571296)| SQL Server Engine | Query Store | Windows|
| <a id=13746943>[13746943](#13746943) </a> | Non-yielding Scheduler error may occur when query store tries to grow its memory structure during heavy workload. | SQL Server Engine |Query Store| Windows|
| <a id=13745335>[13745335](#13745335) </a> | [FIX: Log reader agent generates access violation exception for P2P or transactional replication with partitioning tables in SQL Server (KB4575939)](https://support.microsoft.com/help/4575939)| SQL Server Engine | Replication | Windows|
| <a id=13745357>[13745357](#13745357) </a> | [FIX: Newly added articles' snapshot doesn't get applied to subscriber in SQL Server (KB4575940)](https://support.microsoft.com/help/4575940) | SQL Server Engine | Replication | Windows|
| <a id=13905120>[13905120](#13905120) </a> | Fixes an error that occurs when a change tracking function is called in MSTVF.</br></br>Msg 443, Level 16, State 1, Procedure ProcedureName, Line LineNumber [Batch Start Line LineNumber]Invalid use of a side-effecting operator 'change_tracking_current_version' within a function. | SQL Server Engine |Replication| Windows|
| <a id=13746945>[13746945](#13746945) </a> | Intermittent error 6552 occurs when running Spatial query with `TOP <param> or OFFSET <param1> ROWS FETCH NEXT <param2> ROWS ONLY` clause and parallel plan. | SQL Server Engine | Spatial | All|
| <a id=13587857>[13587857](#13587857) </a> | [FIX: SQL Server on Linux does not start after trace flag 8809 is enabled (KB4336876)](https://support.microsoft.com/help/4336876)| SQL Server Engine | SQL OS| Linux|
| <a id=13880374>[13880374](#13880374) </a> | Fixes a high `HADR_SYNC_COMMIT` waits which may show on SQL Server with heavy workload after you apply CU22 for SQL Server 2017.| SQL Server Engine | SQL OS| Linux|
| <a id=13741858>[13741858](#13741858) </a> | New logging and XEvents to help troubleshoot long-running [Buffer Pool scans](../../database-engine/performance/buffer-pool-scan-runs-slowly-large-memory-machines.md).| SQL Server Engine | SQL OS| All |
| <a id=13739324>[13739324](#13739324) </a> | Fixes an issue with Performance counter Data File(s) Size (KB) that doesn't report the total size of database files correctly when the file size > 4 TB. | SQL Server Engine | Storage Management| Windows|
| <a id=13746918>[13746918](#13746918) </a> | Fixes an issue where the session gets killed when you run `DBCC CHECKTABLE` with `PHYSICAL_ONLY`due to disk full. The session remains in KILLED\ROLLBACK state and threads are waiting on `CHECK_TABLES_THREAD_BARRIER` wait type with increasing wait time.| SQL Server Engine | Storage Management| Windows|
| <a id=13746930>[13746930](#13746930) </a> | `CHECKDB` reports no errors but users may see [errors 602 and 608](/sql/relational-databases/errors-events/database-engine-events-and-errors#errors--2-to-999) due to inconsistent Full Text metadata.| SQL Server Engine | Storage Management| Windows|
| <a id=13784189>[13784189](#13784189) </a> | [FIX: User session is in rollback state indefinitely after it is killed in SQL Server (KB4585971)](https://support.microsoft.com/help/4585971)| SQL Server Engine | Transaction Services| Windows|
| <a id=13746941>[13746941](#13746941) </a> | Fixes an assertion error that occurs when the Availability Group is failed over manually to another replica. The failover succeeds however, the databases from the earlier primary (now the secondary) where the AG was failed from, doesn't come online and generates the assertion dumps with the signature: File: \<"FilePath/FileName">, line=\<LineNumber> Failed Assertion = 'inCorrectOrder'. | SQL Server Engine | Transaction Services| Windows|
| <a id=13911123>[13911123](#13911123) </a> | Adds a new option to free the LogPool cache only: `DBCC FREESYSTEMCACHE('LogPool')`.| SQL Server Engine | Transaction Services| Windows|
| <a id=13866788>[13866788](#13866788) </a> | Fixes an issue where an access violation exception may occur when you execute queries in read uncommitted mode with high concurrent read or write pattern over XML data types.| SQL Server Engine | XML | All|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU23 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/02/sqlserver2017-kb5000685-x64_c81205037e8cb594dc11faf538c66018383f8167.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5000685-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5000685-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5000685-x64.exe| DFA05D11624BADF91B2D4AD03B59CE24AD1851AD94BBA0A0C963D2275565007D |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                               | File version    | File size | Date     | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Asplatformhost.dll                                        | 2018.150.34.29  | 291736    | 5-Feb-21 | 21:22 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181   | 140664    | 5-Feb-21 | 21:26 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.29      | 757144    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 174472    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 198552    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 201112    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 197528    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 213912    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 196504    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 192408    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 251272    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 172936    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 195992    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.29      | 1097112   | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.29      | 479624    | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 53640     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 58264     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 58776     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57752     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 60824     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 66448     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 52624     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 17816     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16784     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 5-Feb-21 | 21:22 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660856    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181   | 180600    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181   | 30072     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181   | 74616     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181   | 102264    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 28536     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 45944     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 29048     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454456   | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920680    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 23928     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25464     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25976     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 28536     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37752     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181   | 5242744   | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181   | 19832     | 5-Feb-21 | 21:26 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181   | 19832     | 5-Feb-21 | 21:26 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181   | 19832     | 5-Feb-21 | 21:26 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181   | 149368    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181   | 82296     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15432     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15736     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181   | 190840    | 5-Feb-21 | 21:26 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181   | 59768     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181   | 26488     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140152    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181   | 14094200  | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 541560    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 652152    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 643960    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 627576    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 676728    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 635768    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 615288    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 848760    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 533368    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 623480    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 5-Feb-21 | 21:26 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778616    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15      | 1100152   | 5-Feb-21 | 21:26 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126328    | 5-Feb-21 | 21:26 | x86      |
| Msmdctr.dll                                               | 2018.150.34.29  | 37256     | 5-Feb-21 | 21:22 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.29  | 66288016  | 5-Feb-21 | 21:22 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.29  | 47781264  | 5-Feb-21 | 21:22 | x86      |
| Msmdpump.dll                                              | 2018.150.34.29  | 10187672  | 5-Feb-21 | 21:22 | x64      |
| Msmdredir.dll                                             | 2018.150.34.29  | 7955848   | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15760     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 17304     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15760     | 5-Feb-21 | 21:22 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 5-Feb-21 | 21:22 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.29  | 65824136  | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 832408    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1627032   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1452944   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1641880   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1607576   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1000344   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 991640    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1535888   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1520536   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 809880    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1595272   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 831384    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1623448   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1449864   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1636744   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1603480   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 997784    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 990088    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1531792   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1516952   | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 808856    | 5-Feb-21 | 21:22 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1590664   | 5-Feb-21 | 21:22 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.29  | 10185112  | 5-Feb-21 | 21:22 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.29  | 8277912   | 5-Feb-21 | 21:22 | x86      |
| Msolap.dll                                                | 2018.150.34.29  | 11014552  | 5-Feb-21 | 21:22 | x64      |
| Msolap.dll                                                | 2018.150.34.29  | 8607128   | 5-Feb-21 | 21:22 | x86      |
| Msolui.dll                                                | 2018.150.34.29  | 305560    | 5-Feb-21 | 21:22 | x64      |
| Msolui.dll                                                | 2018.150.34.29  | 285080    | 5-Feb-21 | 21:22 | x86      |
| Powerbiextensions.dll                                     | 2.72.5556.181   | 9252728   | 5-Feb-21 | 21:26 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728440    | 5-Feb-21 | 21:26 | x64      |
| Sqlboot.dll                                               | 2019.150.4105.2 | 213904    | 5-Feb-21 | 21:26 | x64      |
| Sqlceip.exe                                               | 15.0.4105.2     | 283536    | 5-Feb-21 | 21:26 | x86      |
| Sqldumper.exe                                             | 2019.150.4105.2 | 152464    | 5-Feb-21 | 21:26 | x86      |
| Sqldumper.exe                                             | 2019.150.4105.2 | 185232    | 5-Feb-21 | 21:26 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117624    | 5-Feb-21 | 21:26 | x86      |
| Tmapi.dll                                                 | 2018.150.34.29  | 6177168   | 5-Feb-21 | 21:22 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.29  | 4916632   | 5-Feb-21 | 21:22 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.29  | 1183640   | 5-Feb-21 | 21:22 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.29  | 6802328   | 5-Feb-21 | 21:22 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.29  | 26024344  | 5-Feb-21 | 21:22 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.29  | 35459480  | 5-Feb-21 | 21:22 | x86      |

SQL Server 2017 Database Services Common Core

| File   name                          | File version    | File size | Date     | Time  | Platform |
|--------------------------------------|-----------------|-----------|----------|-------|----------|
| Instapi150.dll                       | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x64      |
| Instapi150.dll                       | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:26 | x64      |
| Msasxpress.dll                       | 2018.150.34.29  | 31128     | 5-Feb-21 | 21:26 | x64      |
| Msasxpress.dll                       | 2018.150.34.29  | 26008     | 5-Feb-21 | 21:26 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x64      |
| Sqldumper.exe                        | 2019.150.4105.2 | 152464    | 5-Feb-21 | 21:26 | x86      |
| Sqldumper.exe                        | 2019.150.4105.2 | 185232    | 5-Feb-21 | 21:26 | x64      |
| Sqlftacct.dll                        | 2019.150.4105.2 | 58256     | 5-Feb-21 | 21:26 | x86      |
| Sqlftacct.dll                        | 2019.150.4105.2 | 78736     | 5-Feb-21 | 21:26 | x64      |
| Sqlmanager.dll                       | 2019.150.4105.2 | 742288    | 5-Feb-21 | 21:26 | x86      |
| Sqlmanager.dll                       | 2019.150.4105.2 | 877456    | 5-Feb-21 | 21:26 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4105.2 | 377744    | 5-Feb-21 | 21:26 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4105.2 | 430992    | 5-Feb-21 | 21:26 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4105.2 | 275344    | 5-Feb-21 | 21:26 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4105.2 | 357264    | 5-Feb-21 | 21:26 | x64      |
| Svrenumapi150.dll                    | 2019.150.4105.2 | 1160080   | 5-Feb-21 | 21:26 | x64      |
| Svrenumapi150.dll                    | 2019.150.4105.2 | 910224    | 5-Feb-21 | 21:26 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name           | File version    | File size | Date     | Time  | Platform |
|-----------------------|-----------------|-----------|----------|-------|----------|
| Dreplayclient.exe     | 2019.150.4105.2 | 136080    | 5-Feb-21 | 21:26 | x86      |
| Dreplaycommon.dll     | 2019.150.4105.2 | 665488    | 5-Feb-21 | 21:26 | x86      |
| Dreplayutil.dll       | 2019.150.4105.2 | 304016    | 5-Feb-21 | 21:26 | x86      |
| Instapi150.dll        | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x64      |
| Sqlresourceloader.dll | 2019.150.4105.2 | 37776     | 5-Feb-21 | 21:26 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name           | File version    | File size | Date     | Time  | Platform |
|-----------------------|-----------------|-----------|----------|-------|----------|
| Dreplaycommon.dll     | 2019.150.4105.2 | 665488    | 5-Feb-21 | 21:26 | x86      |
| Dreplaycontroller.exe | 2019.150.4105.2 | 365456    | 5-Feb-21 | 21:26 | x86      |
| Instapi150.dll        | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x64      |
| Sqlresourceloader.dll | 2019.150.4105.2 | 37776     | 5-Feb-21 | 21:26 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                | File version    | File size | Date     | Time  | Platform |
|--------------------------------------------|-----------------|-----------|----------|-------|----------|
| Aetm-enclave-simulator.dll                 | 2019.150.4105.2 | 4652944   | 5-Feb-21 | 22:37 | x64      |
| Aetm-enclave.dll                           | 2019.150.4105.2 | 4604264   | 5-Feb-21 | 22:38 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4105.2 | 4924656   | 5-Feb-21 | 22:38 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4105.2 | 4866256   | 5-Feb-21 | 22:38 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 5-Feb-21 | 21:21 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 5-Feb-21 | 21:22 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 5-Feb-21 | 22:37 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 5-Feb-21 | 22:37 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 5-Feb-21 | 22:37 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 5-Feb-21 | 22:38 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4105.2 | 279440    | 5-Feb-21 | 22:38 | x64      |
| Dcexec.exe                                 | 2019.150.4105.2 | 86928     | 5-Feb-21 | 22:38 | x64      |
| Fssres.dll                                 | 2019.150.4105.2 | 95120     | 5-Feb-21 | 22:38 | x64      |
| Hadrres.dll                                | 2019.150.4105.2 | 201616    | 5-Feb-21 | 22:38 | x64      |
| Hkcompile.dll                              | 2019.150.4105.2 | 1291152   | 5-Feb-21 | 22:38 | x64      |
| Hkengine.dll                               | 2019.150.4105.2 | 5784464   | 5-Feb-21 | 22:37 | x64      |
| Hkruntime.dll                              | 2019.150.4105.2 | 181136    | 5-Feb-21 | 22:37 | x64      |
| Hktempdb.dll                               | 2019.150.4105.2 | 62352     | 5-Feb-21 | 22:38 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 5-Feb-21 | 22:37 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4105.2     | 234384    | 5-Feb-21 | 22:38 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4105.2 | 324496    | 5-Feb-21 | 22:38 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4105.2 | 91024     | 5-Feb-21 | 22:38 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 5-Feb-21 | 22:37 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 5-Feb-21 | 22:37 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 5-Feb-21 | 22:37 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 5-Feb-21 | 22:37 | x64      |
| Qds.dll                                    | 2019.150.4105.2 | 1184656   | 5-Feb-21 | 22:38 | x64      |
| Rsfxft.dll                                 | 2019.150.4105.2 | 50064     | 5-Feb-21 | 22:38 | x64      |
| Secforwarder.dll                           | 2019.150.4105.2 | 78736     | 5-Feb-21 | 22:37 | x64      |
| Sqagtres.dll                               | 2019.150.4105.2 | 86928     | 5-Feb-21 | 22:38 | x64      |
| Sqlaamss.dll                               | 2019.150.4105.2 | 107408    | 5-Feb-21 | 22:38 | x64      |
| Sqlaccess.dll                              | 2019.150.4105.2 | 492432    | 5-Feb-21 | 22:37 | x64      |
| Sqlagent.exe                               | 2019.150.4105.2 | 730000    | 5-Feb-21 | 22:38 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4105.2 | 78736     | 5-Feb-21 | 22:38 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4105.2 | 66448     | 5-Feb-21 | 22:38 | x86      |
| Sqlboot.dll                                | 2019.150.4105.2 | 213904    | 5-Feb-21 | 22:38 | x64      |
| Sqlceip.exe                                | 15.0.4105.2     | 283536    | 5-Feb-21 | 22:37 | x86      |
| Sqlcmdss.dll                               | 2019.150.4105.2 | 86928     | 5-Feb-21 | 22:38 | x64      |
| Sqlctr150.dll                              | 2019.150.4105.2 | 115600    | 5-Feb-21 | 22:37 | x86      |
| Sqlctr150.dll                              | 2019.150.4105.2 | 140176    | 5-Feb-21 | 22:38 | x64      |
| Sqldk.dll                                  | 2019.150.4105.2 | 3146640   | 5-Feb-21 | 22:38 | x64      |
| Sqldtsss.dll                               | 2019.150.4105.2 | 107408    | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 1590160   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3490704   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3687312   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4150160   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4268944   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3404688   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3568528   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4146064   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3998608   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4051856   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 2216848   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 2163600   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3859344   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3535760   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4002704   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3810192   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3806096   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3601296   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3490704   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 1532816   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 3896208   | 5-Feb-21 | 22:38 | x64      |
| Sqlevn70.rll                               | 2019.150.4105.2 | 4014992   | 5-Feb-21 | 22:38 | x64      |
| Sqllang.dll                                | 2019.150.4105.2 | 39863184  | 5-Feb-21 | 22:38 | x64      |
| Sqlmin.dll                                 | 2019.150.4105.2 | 40392592  | 5-Feb-21 | 22:38 | x64      |
| Sqlolapss.dll                              | 2019.150.4105.2 | 103312    | 5-Feb-21 | 22:38 | x64      |
| Sqlos.dll                                  | 2019.150.4105.2 | 41872     | 5-Feb-21 | 22:37 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4105.2 | 82832     | 5-Feb-21 | 22:37 | x64      |
| Sqlrepss.dll                               | 2019.150.4105.2 | 82832     | 5-Feb-21 | 22:38 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4105.2 | 50064     | 5-Feb-21 | 22:37 | x64      |
| Sqlscm.dll                                 | 2019.150.4105.2 | 86928     | 5-Feb-21 | 22:37 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4105.2 | 37776     | 5-Feb-21 | 22:38 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4105.2 | 5804944   | 5-Feb-21 | 22:38 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4105.2 | 672656    | 5-Feb-21 | 22:37 | x64      |
| Sqlservr.exe                               | 2019.150.4105.2 | 627600    | 5-Feb-21 | 22:38 | x64      |
| Sqlsvc.dll                                 | 2019.150.4105.2 | 181136    | 5-Feb-21 | 22:37 | x64      |
| Sqltses.dll                                | 2019.150.4105.2 | 9077648   | 5-Feb-21 | 22:38 | x64      |
| Sqsrvres.dll                               | 2019.150.4105.2 | 279440    | 5-Feb-21 | 22:38 | x64      |
| Svl.dll                                    | 2019.150.4105.2 | 160656    | 5-Feb-21 | 22:37 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 5-Feb-21 | 22:37 | x64      |
| Xe.dll                                     | 2019.150.4105.2 | 721808    | 5-Feb-21 | 22:38 | x64      |
| Xpadsi.exe                                 | 2019.150.4105.2 | 115600    | 5-Feb-21 | 22:38 | x64      |
| Xplog70.dll                                | 2019.150.4105.2 | 91024     | 5-Feb-21 | 22:38 | x64      |
| Xprepl.dll                                 | 2019.150.4105.2 | 119696    | 5-Feb-21 | 22:37 | x64      |
| Xpstar.dll                                 | 2019.150.4105.2 | 471952    | 5-Feb-21 | 22:37 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                  | File version    | File size | Date     | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Commanddest.dll                                              | 2019.150.4105.2 | 263056    | 5-Feb-21 | 21:26 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4105.2 | 226192    | 5-Feb-21 | 21:26 | x64      |
| Distrib.exe                                                  | 2019.150.4105.2 | 234384    | 5-Feb-21 | 21:26 | x64      |
| Dteparse.dll                                                 | 2019.150.4105.2 | 123792    | 5-Feb-21 | 21:26 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4105.2 | 131984    | 5-Feb-21 | 21:26 | x64      |
| Dtepkg.dll                                                   | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:26 | x64      |
| Dtexec.exe                                                   | 2019.150.4105.2 | 71568     | 5-Feb-21 | 21:26 | x64      |
| Dts.dll                                                      | 2019.150.4105.2 | 3142544   | 5-Feb-21 | 21:26 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4105.2 | 500624    | 5-Feb-21 | 21:26 | x64      |
| Dtsconn.dll                                                  | 2019.150.4105.2 | 521104    | 5-Feb-21 | 21:26 | x64      |
| Dtshost.exe                                                  | 2019.150.4105.2 | 104336    | 5-Feb-21 | 21:26 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4105.2 | 566160    | 5-Feb-21 | 21:26 | x64      |
| Dtspipeline.dll                                              | 2019.150.4105.2 | 1328016   | 5-Feb-21 | 21:26 | x64      |
| Dtswizard.exe                                                | 15.0.4105.2     | 885648    | 5-Feb-21 | 21:26 | x64      |
| Dtuparse.dll                                                 | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:26 | x64      |
| Dtutil.exe                                                   | 2019.150.4105.2 | 147344    | 5-Feb-21 | 21:26 | x64      |
| Exceldest.dll                                                | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:26 | x64      |
| Excelsrc.dll                                                 | 2019.150.4105.2 | 308112    | 5-Feb-21 | 21:26 | x64      |
| Execpackagetask.dll                                          | 2019.150.4105.2 | 185232    | 5-Feb-21 | 21:26 | x64      |
| Flatfiledest.dll                                             | 2019.150.4105.2 | 410512    | 5-Feb-21 | 21:26 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4105.2 | 426896    | 5-Feb-21 | 21:26 | x64      |
| Logread.exe                                                  | 2019.150.4105.2 | 717712    | 5-Feb-21 | 21:26 | x64      |
| Mergetxt.dll                                                 | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4105.2     | 58256     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4105.2     | 41872     | 5-Feb-21 | 21:26 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4105.2     | 390032    | 5-Feb-21 | 21:26 | x86      |
| Microsoft.sqlserver.xmltask.dll                              | 15.0.4105.2     | 156560    | 5-Feb-21 | 21:26 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:26 | x64      |
| Msgprox.dll                                                  | 2019.150.4105.2 | 299920    | 5-Feb-21 | 21:26 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 5-Feb-21 | 21:26 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4105.2 | 1495952   | 5-Feb-21 | 21:26 | x64      |
| Oledbdest.dll                                                | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:26 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:26 | x64      |
| Osql.exe                                                     | 2019.150.4105.2 | 91024     | 5-Feb-21 | 21:26 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4105.2 | 496528    | 5-Feb-21 | 21:26 | x64      |
| Rawdest.dll                                                  | 2019.150.4105.2 | 226192    | 5-Feb-21 | 21:26 | x64      |
| Rawsource.dll                                                | 2019.150.4105.2 | 209808    | 5-Feb-21 | 21:26 | x64      |
| Rdistcom.dll                                                 | 2019.150.4105.2 | 914320    | 5-Feb-21 | 21:26 | x64      |
| Recordsetdest.dll                                            | 2019.150.4105.2 | 201616    | 5-Feb-21 | 21:26 | x64      |
| Repldp.dll                                                   | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:26 | x64      |
| Replerrx.dll                                                 | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:26 | x64      |
| Replisapi.dll                                                | 2019.150.4105.2 | 394128    | 5-Feb-21 | 21:26 | x64      |
| Replmerg.exe                                                 | 2019.150.4105.2 | 562064    | 5-Feb-21 | 21:26 | x64      |
| Replprov.dll                                                 | 2019.150.4105.2 | 852880    | 5-Feb-21 | 21:26 | x64      |
| Replrec.dll                                                  | 2019.150.4105.2 | 1029008   | 5-Feb-21 | 21:26 | x64      |
| Replsub.dll                                                  | 2019.150.4105.2 | 471952    | 5-Feb-21 | 21:26 | x64      |
| Replsync.dll                                                 | 2019.150.4105.2 | 164752    | 5-Feb-21 | 21:26 | x64      |
| Spresolv.dll                                                 | 2019.150.4105.2 | 275344    | 5-Feb-21 | 21:26 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4105.2 | 263056    | 5-Feb-21 | 21:26 | x64      |
| Sqldiag.exe                                                  | 2019.150.4105.2 | 1139600   | 5-Feb-21 | 21:26 | x64      |
| Sqldistx.dll                                                 | 2019.150.4105.2 | 246672    | 5-Feb-21 | 21:26 | x64      |
| Sqllogship.exe                                               | 15.0.4105.2     | 103312    | 5-Feb-21 | 21:26 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4105.2 | 398224    | 5-Feb-21 | 21:26 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4105.2 | 37776     | 5-Feb-21 | 21:26 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4105.2 | 50064     | 5-Feb-21 | 21:26 | x64      |
| Sqlscm.dll                                                   | 2019.150.4105.2 | 78736     | 5-Feb-21 | 21:26 | x86      |
| Sqlscm.dll                                                   | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:26 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:26 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:26 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4105.2 | 201608    | 5-Feb-21 | 21:26 | x64      |
| Ssradd.dll                                                   | 2019.150.4105.2 | 82832     | 5-Feb-21 | 21:26 | x64      |
| Ssravg.dll                                                   | 2019.150.4105.2 | 82832     | 5-Feb-21 | 21:26 | x64      |
| Ssrdown.dll                                                  | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x64      |
| Ssrmax.dll                                                   | 2019.150.4105.2 | 82832     | 5-Feb-21 | 21:26 | x64      |
| Ssrmin.dll                                                   | 2019.150.4105.2 | 82832     | 5-Feb-21 | 21:26 | x64      |
| Ssrpub.dll                                                   | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x64      |
| Ssrup.dll                                                    | 2019.150.4105.2 | 74640     | 5-Feb-21 | 21:26 | x64      |
| Txagg.dll                                                    | 2019.150.4105.2 | 390032    | 5-Feb-21 | 21:26 | x64      |
| Txbdd.dll                                                    | 2019.150.4105.2 | 189328    | 5-Feb-21 | 21:26 | x64      |
| Txdatacollector.dll                                          | 2019.150.4105.2 | 484240    | 5-Feb-21 | 21:26 | x64      |
| Txdataconvert.dll                                            | 2019.150.4105.2 | 316304    | 5-Feb-21 | 21:26 | x64      |
| Txderived.dll                                                | 2019.150.4105.2 | 639888    | 5-Feb-21 | 21:26 | x64      |
| Txlookup.dll                                                 | 2019.150.4105.2 | 541584    | 5-Feb-21 | 21:26 | x64      |
| Txmerge.dll                                                  | 2019.150.4105.2 | 246672    | 5-Feb-21 | 21:26 | x64      |
| Txmergejoin.dll                                              | 2019.150.4105.2 | 308112    | 5-Feb-21 | 21:26 | x64      |
| Txmulticast.dll                                              | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:26 | x64      |
| Txrowcount.dll                                               | 2019.150.4105.2 | 140176    | 5-Feb-21 | 21:26 | x64      |
| Txsort.dll                                                   | 2019.150.4105.2 | 287632    | 5-Feb-21 | 21:26 | x64      |
| Txsplit.dll                                                  | 2019.150.4105.2 | 623504    | 5-Feb-21 | 21:26 | x64      |
| Txunionall.dll                                               | 2019.150.4105.2 | 197520    | 5-Feb-21 | 21:26 | x64      |
| Xe.dll                                                       | 2019.150.4105.2 | 721808    | 5-Feb-21 | 21:26 | x64      |
| Xmlsub.dll                                                   | 2019.150.4105.2 | 295824    | 5-Feb-21 | 21:26 | x64      |

SQL Server 2017 sql_extensibility

| File   name        | File version    | File size | Date     | Time  | Platform |
|--------------------|-----------------|-----------|----------|-------|----------|
| Commonlauncher.dll | 2019.150.4105.2 | 91024     | 5-Feb-21 | 21:26 | x64      |
| Exthost.exe        | 2019.150.4105.2 | 238480    | 5-Feb-21 | 21:26 | x64      |
| Launchpad.exe      | 2019.150.4105.2 | 1217424   | 5-Feb-21 | 21:26 | x64      |
| Sqlsatellite.dll   | 2019.150.4105.2 | 1016720   | 5-Feb-21 | 21:26 | x64      |

SQL Server 2017 Full-Text Engine

| File   name    | File version    | File size | Date     | Time  | Platform |
|----------------|-----------------|-----------|----------|-------|----------|
| Fd.dll         | 2019.150.4105.2 | 684944    | 5-Feb-21 | 21:26 | x64      |
| Fdhost.exe     | 2019.150.4105.2 | 127888    | 5-Feb-21 | 21:26 | x64      |
| Fdlauncher.exe | 2019.150.4105.2 | 78736     | 5-Feb-21 | 21:26 | x64      |
| Sqlft150ph.dll | 2019.150.4105.2 | 91024     | 5-Feb-21 | 21:26 | x64      |

SQL Server 2017 sql_inst_mr

| File   name | File version | File size | Date     | Time  | Platform |
|-------------|--------------|-----------|----------|-------|----------|
| Imrdll.dll  | 15.0.4105.2  | 29584     | 5-Feb-21 | 21:26 | x86      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date     | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Commanddest.dll                                               | 2019.150.4105.2 | 226192    | 5-Feb-21 | 21:27 | x86      |
| Commanddest.dll                                               | 2019.150.4105.2 | 263056    | 5-Feb-21 | 21:27 | x64      |
| Dteparse.dll                                                  | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:27 | x86      |
| Dteparse.dll                                                  | 2019.150.4105.2 | 123792    | 5-Feb-21 | 21:27 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4105.2 | 115600    | 5-Feb-21 | 21:27 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4105.2 | 131984    | 5-Feb-21 | 21:27 | x64      |
| Dtepkg.dll                                                    | 2019.150.4105.2 | 131984    | 5-Feb-21 | 21:27 | x86      |
| Dtepkg.dll                                                    | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:27 | x64      |
| Dtexec.exe                                                    | 2019.150.4105.2 | 62864     | 5-Feb-21 | 21:27 | x86      |
| Dtexec.exe                                                    | 2019.150.4105.2 | 71568     | 5-Feb-21 | 21:27 | x64      |
| Dts.dll                                                       | 2019.150.4105.2 | 2761616   | 5-Feb-21 | 21:27 | x86      |
| Dts.dll                                                       | 2019.150.4105.2 | 3142544   | 5-Feb-21 | 21:27 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4105.2 | 443280    | 5-Feb-21 | 21:27 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4105.2 | 500624    | 5-Feb-21 | 21:27 | x64      |
| Dtsconn.dll                                                   | 2019.150.4105.2 | 521104    | 5-Feb-21 | 21:27 | x64      |
| Dtsconn.dll                                                   | 2019.150.4105.2 | 430992    | 5-Feb-21 | 21:27 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4105.2 | 111008    | 5-Feb-21 | 21:27 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4105.2 | 92560     | 5-Feb-21 | 21:27 | x86      |
| Dtshost.exe                                                   | 2019.150.4105.2 | 104336    | 5-Feb-21 | 21:27 | x64      |
| Dtshost.exe                                                   | 2019.150.4105.2 | 87440     | 5-Feb-21 | 21:27 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4105.2 | 553872    | 5-Feb-21 | 21:27 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4105.2 | 566160    | 5-Feb-21 | 21:27 | x64      |
| Dtspipeline.dll                                               | 2019.150.4105.2 | 1119120   | 5-Feb-21 | 21:27 | x86      |
| Dtspipeline.dll                                               | 2019.150.4105.2 | 1328016   | 5-Feb-21 | 21:27 | x64      |
| Dtswizard.exe                                                 | 15.0.4105.2     | 885648    | 5-Feb-21 | 21:27 | x64      |
| Dtswizard.exe                                                 | 15.0.4105.2     | 889744    | 5-Feb-21 | 21:27 | x86      |
| Dtuparse.dll                                                  | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:27 | x86      |
| Dtuparse.dll                                                  | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:27 | x64      |
| Dtutil.exe                                                    | 2019.150.4105.2 | 147344    | 5-Feb-21 | 21:27 | x64      |
| Dtutil.exe                                                    | 2019.150.4105.2 | 128912    | 5-Feb-21 | 21:27 | x86      |
| Exceldest.dll                                                 | 2019.150.4105.2 | 234384    | 5-Feb-21 | 21:27 | x86      |
| Exceldest.dll                                                 | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:27 | x64      |
| Excelsrc.dll                                                  | 2019.150.4105.2 | 258960    | 5-Feb-21 | 21:27 | x86      |
| Excelsrc.dll                                                  | 2019.150.4105.2 | 308112    | 5-Feb-21 | 21:27 | x64      |
| Execpackagetask.dll                                           | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:27 | x86      |
| Execpackagetask.dll                                           | 2019.150.4105.2 | 185232    | 5-Feb-21 | 21:27 | x64      |
| Flatfiledest.dll                                              | 2019.150.4105.2 | 357264    | 5-Feb-21 | 21:27 | x86      |
| Flatfiledest.dll                                              | 2019.150.4105.2 | 410512    | 5-Feb-21 | 21:27 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4105.2 | 369552    | 5-Feb-21 | 21:27 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4105.2 | 426896    | 5-Feb-21 | 21:27 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4105.2     | 119696    | 5-Feb-21 | 21:27 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4105.2     | 119696    | 5-Feb-21 | 21:27 | x86      |
| Isserverexec.exe                                              | 15.0.4105.2     | 144272    | 5-Feb-21 | 21:27 | x64      |
| Isserverexec.exe                                              | 15.0.4105.2     | 148368    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4105.2     | 78736     | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4105.2     | 58256     | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4105.2     | 58256     | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4105.2     | 508816    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4105.2     | 508816    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4105.2     | 41872     | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4105.2     | 390032    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4105.2     | 58256     | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4105.2     | 140176    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4105.2     | 140176    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4105.2     | 156560    | 5-Feb-21 | 21:27 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4105.2     | 156560    | 5-Feb-21 | 21:27 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4105.2     | 218000    | 5-Feb-21 | 21:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:27 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:27 | x86      |
| Msmdpp.dll                                                    | 2018.150.34.29  | 10062216  | 5-Feb-21 | 21:27 | x64      |
| Odbcdest.dll                                                  | 2019.150.4105.2 | 316304    | 5-Feb-21 | 21:27 | x86      |
| Odbcdest.dll                                                  | 2019.150.4105.2 | 369552    | 5-Feb-21 | 21:27 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4105.2 | 328592    | 5-Feb-21 | 21:27 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4105.2 | 381840    | 5-Feb-21 | 21:27 | x64      |
| Oledbdest.dll                                                 | 2019.150.4105.2 | 238480    | 5-Feb-21 | 21:27 | x86      |
| Oledbdest.dll                                                 | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:27 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4105.2 | 263056    | 5-Feb-21 | 21:27 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:27 | x64      |
| Rawdest.dll                                                   | 2019.150.4105.2 | 189328    | 5-Feb-21 | 21:27 | x86      |
| Rawdest.dll                                                   | 2019.150.4105.2 | 226192    | 5-Feb-21 | 21:27 | x64      |
| Rawsource.dll                                                 | 2019.150.4105.2 | 177040    | 5-Feb-21 | 21:27 | x86      |
| Rawsource.dll                                                 | 2019.150.4105.2 | 209808    | 5-Feb-21 | 21:27 | x64      |
| Recordsetdest.dll                                             | 2019.150.4105.2 | 172944    | 5-Feb-21 | 21:27 | x86      |
| Recordsetdest.dll                                             | 2019.150.4105.2 | 201616    | 5-Feb-21 | 21:27 | x64      |
| Sqlceip.exe                                                   | 15.0.4105.2     | 283536    | 5-Feb-21 | 21:27 | x86      |
| Sqldest.dll                                                   | 2019.150.4105.2 | 238480    | 5-Feb-21 | 21:27 | x86      |
| Sqldest.dll                                                   | 2019.150.4105.2 | 275344    | 5-Feb-21 | 21:27 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4105.2 | 201608    | 5-Feb-21 | 21:27 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4105.2 | 168848    | 5-Feb-21 | 21:27 | x86      |
| Txagg.dll                                                     | 2019.150.4105.2 | 328592    | 5-Feb-21 | 21:27 | x86      |
| Txagg.dll                                                     | 2019.150.4105.2 | 390032    | 5-Feb-21 | 21:27 | x64      |
| Txbdd.dll                                                     | 2019.150.4105.2 | 152464    | 5-Feb-21 | 21:27 | x86      |
| Txbdd.dll                                                     | 2019.150.4105.2 | 189328    | 5-Feb-21 | 21:27 | x64      |
| Txbestmatch.dll                                               | 2019.150.4105.2 | 652176    | 5-Feb-21 | 21:27 | x64      |
| Txbestmatch.dll                                               | 2019.150.4105.2 | 545680    | 5-Feb-21 | 21:27 | x86      |
| Txcache.dll                                                   | 2019.150.4105.2 | 164752    | 5-Feb-21 | 21:27 | x86      |
| Txcache.dll                                                   | 2019.150.4105.2 | 209808    | 5-Feb-21 | 21:27 | x64      |
| Txcharmap.dll                                                 | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:27 | x64      |
| Txcharmap.dll                                                 | 2019.150.4105.2 | 271248    | 5-Feb-21 | 21:27 | x86      |
| Txcopymap.dll                                                 | 2019.150.4105.2 | 197520    | 5-Feb-21 | 21:27 | x64      |
| Txcopymap.dll                                                 | 2019.150.4105.2 | 164752    | 5-Feb-21 | 21:27 | x86      |
| Txdataconvert.dll                                             | 2019.150.4105.2 | 275344    | 5-Feb-21 | 21:27 | x86      |
| Txdataconvert.dll                                             | 2019.150.4105.2 | 316304    | 5-Feb-21 | 21:27 | x64      |
| Txderived.dll                                                 | 2019.150.4105.2 | 557968    | 5-Feb-21 | 21:27 | x86      |
| Txderived.dll                                                 | 2019.150.4105.2 | 639888    | 5-Feb-21 | 21:27 | x64      |
| Txfileextractor.dll                                           | 2019.150.4105.2 | 218000    | 5-Feb-21 | 21:27 | x64      |
| Txfileextractor.dll                                           | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:27 | x86      |
| Txfileinserter.dll                                            | 2019.150.4105.2 | 213904    | 5-Feb-21 | 21:27 | x64      |
| Txfileinserter.dll                                            | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:27 | x86      |
| Txgroupdups.dll                                               | 2019.150.4105.2 | 254864    | 5-Feb-21 | 21:27 | x86      |
| Txgroupdups.dll                                               | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:27 | x64      |
| Txlineage.dll                                                 | 2019.150.4105.2 | 127888    | 5-Feb-21 | 21:27 | x86      |
| Txlineage.dll                                                 | 2019.150.4105.2 | 152464    | 5-Feb-21 | 21:27 | x64      |
| Txlookup.dll                                                  | 2019.150.4105.2 | 467856    | 5-Feb-21 | 21:27 | x86      |
| Txlookup.dll                                                  | 2019.150.4105.2 | 541584    | 5-Feb-21 | 21:27 | x64      |
| Txmerge.dll                                                   | 2019.150.4105.2 | 246672    | 5-Feb-21 | 21:27 | x64      |
| Txmerge.dll                                                   | 2019.150.4105.2 | 201616    | 5-Feb-21 | 21:27 | x86      |
| Txmergejoin.dll                                               | 2019.150.4105.2 | 246672    | 5-Feb-21 | 21:27 | x86      |
| Txmergejoin.dll                                               | 2019.150.4105.2 | 308112    | 5-Feb-21 | 21:27 | x64      |
| Txmulticast.dll                                               | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:27 | x64      |
| Txmulticast.dll                                               | 2019.150.4105.2 | 115600    | 5-Feb-21 | 21:27 | x86      |
| Txpivot.dll                                                   | 2019.150.4105.2 | 238480    | 5-Feb-21 | 21:27 | x64      |
| Txpivot.dll                                                   | 2019.150.4105.2 | 205712    | 5-Feb-21 | 21:27 | x86      |
| Txrowcount.dll                                                | 2019.150.4105.2 | 140176    | 5-Feb-21 | 21:27 | x64      |
| Txrowcount.dll                                                | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:27 | x86      |
| Txsampling.dll                                                | 2019.150.4105.2 | 193424    | 5-Feb-21 | 21:27 | x64      |
| Txsampling.dll                                                | 2019.150.4105.2 | 156560    | 5-Feb-21 | 21:27 | x86      |
| Txscd.dll                                                     | 2019.150.4105.2 | 234384    | 5-Feb-21 | 21:27 | x64      |
| Txscd.dll                                                     | 2019.150.4105.2 | 197520    | 5-Feb-21 | 21:27 | x86      |
| Txsort.dll                                                    | 2019.150.4105.2 | 230288    | 5-Feb-21 | 21:27 | x86      |
| Txsort.dll                                                    | 2019.150.4105.2 | 287632    | 5-Feb-21 | 21:27 | x64      |
| Txsplit.dll                                                   | 2019.150.4105.2 | 623504    | 5-Feb-21 | 21:27 | x64      |
| Txsplit.dll                                                   | 2019.150.4105.2 | 549776    | 5-Feb-21 | 21:27 | x86      |
| Txtermextraction.dll                                          | 2019.150.4105.2 | 8700816   | 5-Feb-21 | 21:27 | x64      |
| Txtermextraction.dll                                          | 2019.150.4105.2 | 8643472   | 5-Feb-21 | 21:27 | x86      |
| Txtermlookup.dll                                              | 2019.150.4105.2 | 4137872   | 5-Feb-21 | 21:27 | x86      |
| Txtermlookup.dll                                              | 2019.150.4105.2 | 4182928   | 5-Feb-21 | 21:27 | x64      |
| Txunionall.dll                                                | 2019.150.4105.2 | 160656    | 5-Feb-21 | 21:27 | x86      |
| Txunionall.dll                                                | 2019.150.4105.2 | 197520    | 5-Feb-21 | 21:27 | x64      |
| Txunpivot.dll                                                 | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:27 | x86      |
| Txunpivot.dll                                                 | 2019.150.4105.2 | 213904    | 5-Feb-21 | 21:27 | x64      |
| Xe.dll                                                        | 2019.150.4105.2 | 631696    | 5-Feb-21 | 21:27 | x86      |
| Xe.dll                                                        | 2019.150.4105.2 | 721808    | 5-Feb-21 | 21:27 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version    | File size | Date     | Time  | Platform |
|----------------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Dms.dll                                                              | 15.0.1901.0     | 551840    | 5-Feb-21 | 22:18 | x86      |
| Dmsnative.dll                                                        | 2018.150.1901.0 | 145824    | 5-Feb-21 | 22:18 | x64      |
| Dwengineservice.dll                                                  | 15.0.1901.0     | 43936     | 5-Feb-21 | 22:18 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 5-Feb-21 | 22:18 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 5-Feb-21 | 22:18 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 5-Feb-21 | 22:18 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 5-Feb-21 | 22:18 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 5-Feb-21 | 22:18 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 5-Feb-21 | 22:18 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 5-Feb-21 | 22:18 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 5-Feb-21 | 22:18 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 5-Feb-21 | 22:18 | x64      |
| Instapi150.dll                                                       | 2019.150.4105.2 | 86928     | 5-Feb-21 | 22:18 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 5-Feb-21 | 22:18 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 5-Feb-21 | 22:18 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 5-Feb-21 | 22:18 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 5-Feb-21 | 22:18 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 5-Feb-21 | 22:18 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1901.0     | 66456     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1901.0     | 292256    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1901.0     | 1954712   | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1901.0     | 169376    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1901.0     | 635808    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1901.0     | 244128    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1901.0     | 138136    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1901.0     | 78752     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1901.0     | 50080     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1901.0     | 87456     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1901.0     | 1128344   | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1901.0     | 79776     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1901.0     | 69536     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1901.0     | 34208     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1901.0     | 30104     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1901.0     | 45472     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1901.0     | 20384     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1901.0     | 25504     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1901.0     | 130456    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1901.0     | 85408     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1901.0     | 99744     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1901.0     | 291744    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 118688    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 137120    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 140192    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 136608    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 149408    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 138656    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 133024    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 175520    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 116128    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 135072    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1901.0     | 71576     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1901.0     | 20896     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1901.0     | 36256     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1901.0     | 127896    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1901.0     | 3050904   | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1901.0     | 3953056   | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 117152    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 132000    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 136608    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 132512    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 147360    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 133024    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 129440    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 169880    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 114080    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 130976    | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1901.0     | 66464     | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1901.0     | 2681248   | 5-Feb-21 | 22:18 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1901.0     | 2435480   | 5-Feb-21 | 22:18 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4105.2 | 451472    | 5-Feb-21 | 22:18 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4105.2 | 7386000   | 5-Feb-21 | 22:18 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 5-Feb-21 | 22:18 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 5-Feb-21 | 22:18 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 5-Feb-21 | 22:18 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 5-Feb-21 | 22:18 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 5-Feb-21 | 22:18 | x64      |
| Secforwarder.dll                                                     | 2019.150.4105.2 | 78736     | 5-Feb-21 | 22:18 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1901.0 | 60320     | 5-Feb-21 | 22:18 | x64      |
| Sqldk.dll                                                            | 2019.150.4105.2 | 3146640   | 5-Feb-21 | 22:18 | x64      |
| Sqldumper.exe                                                        | 2019.150.4105.2 | 185232    | 5-Feb-21 | 22:18 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 1590160   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 4150160   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 3404688   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 4146064   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 4051856   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 2216848   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 2163600   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 3810192   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 3806096   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 1532816   | 5-Feb-21 | 22:11 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4105.2 | 4014992   | 5-Feb-21 | 22:11 | x64      |
| Sqlos.dll                                                            | 2019.150.4105.2 | 41872     | 5-Feb-21 | 22:18 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1901.0 | 4840344   | 5-Feb-21 | 22:18 | x64      |
| Sqltses.dll                                                          | 2019.150.4105.2 | 9077648   | 5-Feb-21 | 22:18 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 5-Feb-21 | 22:18 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 5-Feb-21 | 22:18 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 5-Feb-21 | 22:18 | x64      |

SQL Server 2017 sql_shared_mr

| File   name | File version | File size | Date     | Time  | Platform |
|-------------|--------------|-----------|----------|-------|----------|
| Smrdll.dll  | 15.0.4105.2  | 29584     | 5-Feb-21 | 21:26 | x86      |

SQL Server 2017 sql_tools_extensions

| File   name                                                  | File version    | File size | Date     | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|----------|-------|----------|
| Autoadmin.dll                                                | 2019.150.4105.2 | 1631120   | 5-Feb-21 | 21:52 | x86      |
| Dtaengine.exe                                                | 2019.150.4105.2 | 218000    | 5-Feb-21 | 21:52 | x86      |
| Dteparse.dll                                                 | 2019.150.4105.2 | 123792    | 5-Feb-21 | 21:25 | x64      |
| Dteparse.dll                                                 | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:25 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4105.2 | 115600    | 5-Feb-21 | 21:18 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4105.2 | 131984    | 5-Feb-21 | 21:25 | x64      |
| Dtepkg.dll                                                   | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:25 | x64      |
| Dtepkg.dll                                                   | 2019.150.4105.2 | 131984    | 5-Feb-21 | 21:25 | x86      |
| Dtexec.exe                                                   | 2019.150.4105.2 | 71568     | 5-Feb-21 | 21:25 | x64      |
| Dtexec.exe                                                   | 2019.150.4105.2 | 62864     | 5-Feb-21 | 21:25 | x86      |
| Dts.dll                                                      | 2019.150.4105.2 | 2761616   | 5-Feb-21 | 21:25 | x86      |
| Dts.dll                                                      | 2019.150.4105.2 | 3142544   | 5-Feb-21 | 21:25 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4105.2 | 443280    | 5-Feb-21 | 21:24 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4105.2 | 500624    | 5-Feb-21 | 21:25 | x64      |
| Dtsconn.dll                                                  | 2019.150.4105.2 | 430992    | 5-Feb-21 | 21:24 | x86      |
| Dtsconn.dll                                                  | 2019.150.4105.2 | 521104    | 5-Feb-21 | 21:25 | x64      |
| Dtshost.exe                                                  | 2019.150.4105.2 | 87440     | 5-Feb-21 | 21:25 | x86      |
| Dtshost.exe                                                  | 2019.150.4105.2 | 104336    | 5-Feb-21 | 21:25 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4105.2 | 553872    | 5-Feb-21 | 21:24 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4105.2 | 566160    | 5-Feb-21 | 21:25 | x64      |
| Dtspipeline.dll                                              | 2019.150.4105.2 | 1119120   | 5-Feb-21 | 21:24 | x86      |
| Dtspipeline.dll                                              | 2019.150.4105.2 | 1328016   | 5-Feb-21 | 21:24 | x64      |
| Dtswizard.exe                                                | 15.0.4105.2     | 885648    | 5-Feb-21 | 21:24 | x64      |
| Dtswizard.exe                                                | 15.0.4105.2     | 889744    | 5-Feb-21 | 21:24 | x86      |
| Dtuparse.dll                                                 | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:25 | x86      |
| Dtuparse.dll                                                 | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:25 | x64      |
| Dtutil.exe                                                   | 2019.150.4105.2 | 147344    | 5-Feb-21 | 21:25 | x64      |
| Dtutil.exe                                                   | 2019.150.4105.2 | 128912    | 5-Feb-21 | 21:25 | x86      |
| Exceldest.dll                                                | 2019.150.4105.2 | 234384    | 5-Feb-21 | 21:24 | x86      |
| Exceldest.dll                                                | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:25 | x64      |
| Excelsrc.dll                                                 | 2019.150.4105.2 | 258960    | 5-Feb-21 | 21:24 | x86      |
| Excelsrc.dll                                                 | 2019.150.4105.2 | 308112    | 5-Feb-21 | 21:25 | x64      |
| Flatfiledest.dll                                             | 2019.150.4105.2 | 357264    | 5-Feb-21 | 21:24 | x86      |
| Flatfiledest.dll                                             | 2019.150.4105.2 | 410512    | 5-Feb-21 | 21:25 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4105.2 | 369552    | 5-Feb-21 | 21:24 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4105.2 | 426896    | 5-Feb-21 | 21:25 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4105.2     | 78736     | 5-Feb-21 | 21:24 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4105.2     | 402320    | 5-Feb-21 | 21:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4105.2     | 402320    | 5-Feb-21 | 21:52 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4105.2     | 2999184   | 5-Feb-21 | 21:52 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4105.2     | 41872     | 5-Feb-21 | 21:24 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4105.2     | 58256     | 5-Feb-21 | 21:18 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 5-Feb-21 | 21:09 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4105.2 | 99216     | 5-Feb-21 | 21:24 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4105.2 | 111504    | 5-Feb-21 | 21:25 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.34.29  | 8277912   | 5-Feb-21 | 21:25 | x86      |
| Oledbdest.dll                                                | 2019.150.4105.2 | 238480    | 5-Feb-21 | 21:24 | x86      |
| Oledbdest.dll                                                | 2019.150.4105.2 | 279440    | 5-Feb-21 | 21:25 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4105.2 | 263056    | 5-Feb-21 | 21:24 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4105.2 | 312208    | 5-Feb-21 | 21:25 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4105.2 | 50064     | 5-Feb-21 | 21:52 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4105.2 | 37776     | 5-Feb-21 | 21:52 | x86      |
| Sqlscm.dll                                                   | 2019.150.4105.2 | 86928     | 5-Feb-21 | 21:52 | x64      |
| Sqlscm.dll                                                   | 2019.150.4105.2 | 78736     | 5-Feb-21 | 21:52 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4105.2 | 148368    | 5-Feb-21 | 21:52 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4105.2 | 181136    | 5-Feb-21 | 21:52 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4105.2 | 168848    | 5-Feb-21 | 21:24 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4105.2 | 201608    | 5-Feb-21 | 21:25 | x64      |
| Txdataconvert.dll                                            | 2019.150.4105.2 | 275344    | 5-Feb-21 | 21:24 | x86      |
| Txdataconvert.dll                                            | 2019.150.4105.2 | 316304    | 5-Feb-21 | 21:25 | x64      |
| Xe.dll                                                       | 2019.150.4105.2 | 631696    | 5-Feb-21 | 21:24 | x86      |
| Xe.dll                                                       | 2019.150.4105.2 | 721808    | 5-Feb-21 | 21:25 | x64      |

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
