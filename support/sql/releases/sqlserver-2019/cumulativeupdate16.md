---
title: Cumulative update 16 for SQL Server 2019 (KB5011644)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 16 (KB5011644).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5011644
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5011644 - Cumulative Update 16 for SQL Server 2019

_Release Date:_ &nbsp; April 18, 2022  
_Version:_ &nbsp; 15.0.4223.1

## Summary

This article describes Cumulative Update package 16 (CU16) for Microsoft SQL Server 2019. This update contains 43 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 15, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4223.1**, file version: **2019.150.4223.1**
- Analysis Services - Product version: **15.0.35.23**, file version: **2018.150.35.23**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion-context-2019](../includes/av-sesssion_context-2019.md)]

## Improvements and fixes included in this update

> [!IMPORTANT]
> Transparent Data Encryption (TDE)-compressed backups that are created with previous CU versions of SQL Server 2019 can be restored on SQL Server 2019 CU 16 and later versions.
>
> However, because of the backup format improvement in SQL Server 2019 CU 16, TDE-compressed backups that are created with SQL Server 2019 CU 16 or later versions cannot be restored on SQL Server 2019 CU 15 or earlier versions.
>
> For more information, see [FIX: Error 3241 occurs during executing RESTORE DATABASE OR RESTORE LOG](https://support.microsoft.com/help/5014298).

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="14669019">[14669019](#14669019)</a> | Removes log4j2 used by SQL Server 2019 Integration Services (SSIS) to avoid any potential security issues. | Integration Services | DTS | All |
| <a id="14577537">[14577537](#14577537)</a> | In SQL Server 2019 Master Data Services, the child nodes don't open in the derived hierarchy when a child entity is joined with a recursive hierarchy. | Master Data Services | Master Data Services | Windows |
| <a id="13324042">[13324042](#13324042)</a> | [FIX: Error 18456 occurs when you run DMV queries on the SQL Server 2019 or 2017 instance after rebuilding system databases (KB4530955)](https://support.microsoft.com/help/4530955) | Servicing Experience | SQL Server | All |
| <a id="14621802">[14621802](#14621802)</a> | The **sqlcmd** utility crashes when the `batch_terminator` parameter "`-c`" is set to "`;`" in SQL Server 2019. | SQL Server Client Tools | Command Line Tools | Windows |
| <a id="14669436">[14669436](#14669436)</a> | The bulk insert is blocked when the lock of the target table is held by another session, and the session of the bulk insert will remain in SQL Server until its lock is released even if the client application disconnects or exits. This issue causes the session to leak and other requests to be blocked if the leaked sessions are accumulated too many. | SQL Server Connectivity | SQL Connectivity | Windows |
| <a id="14333094">[14333094](#14333094)</a> | [FIX: Error 3241 occurs during executing RESTORE LOG or RESTORE DATABASE (KB5014298)](https://support.microsoft.com/help/5014298) | SQL Server Engine | Backup Restore | Windows |
| <a id="14235719">[14235719](#14235719)</a> | Restoring transaction logs from a compressed backup of a TDE-enabled database may cause a "misaligned I/O" message to be logged in the SQL Server error log: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There have been \<IOCount> misaligned log IOs which required falling back to synchronous IO.&nbsp;&nbsp;The current IO is on file \<FilePath>. | SQL Server Engine | Backup Restore | Windows |
| <a id="14332258">[14332258](#14332258)</a> | A database freezes its I/O during a VSS backup but never thaws the I/O. This can lead to latch timeouts. | SQL Server Engine | Backup Restore | Windows |
| <a id="14573042">[14573042](#14573042)</a> | Restoring from a compressed backup that contains filestream objects randomly fails if the process is run through the Virtual Device Interface (VDI) client. Here's the error message: </br></br>Msg 3241, Level 16, State 18, Line \<LineNumber> </br>The media family on device '\<BackupFileName>' is incorrectly formed. SQL Server cannot process this media family. </br>Unexpected termination: x80770004 | SQL Server Engine | Backup Restore | Windows |
| <a id="14506574">[14506574](#14506574)</a> | An access violation dump occurs when the query runs for a long time in parallel and tries to determine the version of the rowgroup for the particular transactions to read. | SQL Server Engine | Column Stores | All |
| <a id="14689800">[14689800](#14689800)</a> | [Improvement: Make the EO-compliant ML service CAB packages available for SQL Server 2019 (KB5014136)](https://support.microsoft.com/help/5014136) | SQL Server Engine | Extensibility | All |
| <a id="14711983">[14711983](#14711983)</a> | [Improvement: Make the EO-compliant Microsoft Extensibility SDK available for Java for SQL Server 2019 (KB5014137)](https://support.microsoft.com/help/5014137) | SQL Server Engine | Extensibility | All |
| <a id="14396500">[14396500](#14396500)</a> | The `AlwaysOn_Health` extended event doesn't set `STARTUP_STATE` to `ON` after installing a SQL Server Cumulative Update. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14507656">[14507656](#14507656)</a> | The function `sys.fn_hadr_backup_is_preferred_replica` returns different results on primary or secondary replicas of read-scale availability groups (`CLUSTER_TYPE = NONE`) when running on standalone machines or cluster nodes. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14549500">[14549500](#14549500)</a> | The database recovery process is chosen as the deadlock victim on Availability Group (AG) failover under certain circumstances. The following error message is generated: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 1205, Severity: 13, State: 51. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Transaction (Process ID n) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14566765">[14566765](#14566765)</a> | An "Out of memory" error occurs when you take a log backup frequently and `Stolen Server Memory` grows at a synchronous secondary in Availability Groups. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14660934">[14660934](#14660934)</a> | Resolves stalled I/O completion port (IOCP) issues when a heavily used service broker is configured on an availability group database. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14332252">[14332252](#14332252)</a> | SQL Server 2019 using XTP UserDB for staging tables has a steady growing trend for "VARHEAP\Storage internal heap" in `dm_db_xtp_memory_consumers` that leads to OOM/41805 errors over time and requires proactive restart/failover to retain stability. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14508625">[14508625](#14508625)</a> | Improves the dynamic management view (DMV) to help debug the out-of-memory (OOM) issues. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14535149">[14535149](#14535149)</a> | Memory-Optimized TempDB Metadata keeps consuming memory under VARHEAP: LOB Page Allocator, which causes out-of-memory (OOM) exceptions like error 701 or `FAIL_PAGE_ALLOCATION`. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14617266">[14617266](#14617266)</a> | Supports more flexible cleanup and merge operations by changing In-Memory during restore operations. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14617331">[14617331](#14617331)</a> | Improves the response time of the *Sqldumper.exe* utility when in-memory objects are used in SQL Server or once existed. | SQL Server Engine | In-Memory OLTP | All |
| <a id="14662889">[14662889](#14662889)</a> | An assertion failure occurs in `tempdb` during the rollback of transactions, and triggers a server shutdown. The following dump file is generated: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\*\*Dump thread - spid = 0, EC = 0x000004849143B870 </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\*\*\*Stack Dump being sent to \<FilePath>\\\<FileName> </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* ******************************************************************************* </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* BEGIN STACK DUMP: </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\*&nbsp;&nbsp;&nbsp;\<DateTime> </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<FilePath>\\\<FileName> </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* Expression:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dependencies.CommitDepCountOut >= 1 </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID> </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* Process ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID> </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\* Input Buffer 26 bytes - </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;‰&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16 00 00 00 12 00 00 00 02 00 89 01 00 00 90 0f 00 00 </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;\*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;01 00 00 00 07 00 00 00 </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;SQL Server Assertion: File: \<FilePath\FileName>, line=\<LineNumber> Failed Assertion = 'Dependencies.CommitDepCountOut >= 1'. This error may be timing-related. If the error persists after rerunning the statement, use DBCC CHECKDB to check the database for structural integrity, or restart the server to ensure in-memory data structures are not corrupted. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Error: 3624, Severity: 20, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Error: 3314, Severity: 21, State: 3. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;During undoing of a logged operation in database '\<DatabaseName>' (page (1:139) if any), an error occurred at log record ID (3692:89591460:155). Typically, the specific failure is logged previously as an error in the operating system error log. Restore the database or file from a backup, or repair the database. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14694104">[14694104](#14694104)</a> | A memory dump and assertion failure "Dependencies.CommitDepCountOut >= 1" may occur after a transaction rolls back if in-memory `tempdb` is enabled. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="14662671">[14662671](#14662671)</a> | [FIX: Remove the adutil tool from SQL Server 2019 (KB5013391)](https://support.microsoft.com/help/5013391) | SQL Server Engine | Linux | Linux |
| <a id="14608912">[14608912](#14608912)</a> | Exposes the option '`ldaphostcanon`' by the **mssql-conf** tool so that you don't have to manually edit the *mssql.conf* file to enable or disable `ldaphostcanon`. | SQL Server Engine | Linux | Linux |
| <a id="14555263">[14555263](#14555263)</a> | An access violation occurs if a query on `sys.database_scoped_configurations` is waiting for a shared lock on the database while another thread holds the exclusive lock to drop the same database. | SQL Server Engine | Metadata | Windows |
| <a id="14576308">[14576308](#14576308)</a> | Calling `CMEDScan::EvaluateCmpResult` to evaluate filter predicates for the current metadata scan misses the "`NE`" predicate, which causes an "INVALID_SWITCH_VALUE" exception. | SQL Server Engine | Metadata | Windows |
| <a id="14618099">[14618099](#14618099)</a> | A "Non-yielding Scheduler" issue and dump occur during a backup operation because of concurrent Page Free Space (PFS) updates. | SQL Server Engine | Methods to access stored data | All |
| <a id="14520366">[14520366](#14520366)</a> | The logon trigger may fail unexpectedly for the pooled connections even when the criteria aren't met during the connection reset, and causes the following error: </br></br>Error: 17892, Severity: 20, State: 1. </br>Logon failed for login '\<LoginName>' due to trigger execution. | SQL Server Engine | Programmability | Windows |
| <a id="14522124">[14522124](#14522124)</a> | Dropping temp tables in some rare cases causes an unresolved deadlock and dump. | SQL Server Engine | Programmability | Windows |
| <a id="14654659">[14654659](#14654659)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Execution | All |
| <a id="14507658">[14507658](#14507658)</a> | SQL Server disconnects a session when it gets an attention and `INTERLEAVED_EXECUTION_TVF` is enabled. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14507662">[14507662](#14507662)</a> | The query processor can't produce a query plan if the `USE PLAN` hint specifies a query plan that has a left outer join and an inner join. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14670801">[14670801](#14670801)</a> | Executing a query where the plan contains an adaptive join may fail together with the following error: </br></br>Msg 8624, Level 16, State 21, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>Internal Query Processor Error: The query processor could not produce a query plan. For more information, contact Customer Support Services. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14541295">[14541295](#14541295)</a> | [Improvement: Add an XEvent for tracking manual user plan forcing and unforcing (KB5012964)](https://support.microsoft.com/help/5012964) | SQL Server Engine | Query Store | All |
| <a id="14576382">[14576382](#14576382)</a> | [Improvement: Make the change tracking table lock escalation policy be the same as the base table's (KB5014047)](https://support.microsoft.com/topic/4987b431-5d71-4030-84de-d514802151fb) | SQL Server Engine | Replication | Windows |
| <a id="14579161">[14579161](#14579161)</a> | Assume that you have tables with data on the peers and then you set a peer-to-peer publication by using a last-writer conflict detection policy. The distribution agent occurs the following conflict if you delete a row that was present before the publication was created: </br></br>A conflict of type 'Delete-Update' was detected at peer 1 between peer 100 (incoming), transaction id \<TransactionID> and peer (null) (on disk), transaction id (null) for Table \<TableName> with Primary Key(s): PK values, Current Version '(null)', Pre-Version '(null)' and Post-Version \<VersionNumber>. | SQL Server Engine | Replication | Windows |
| <a id="14487676">[14487676](#14487676)</a> | [FIX: Severe spinlock contention occurs in SQL Server 2019 (KB4538688)](https://support.microsoft.com/help/4538688) | SQL Server Engine | SQL OS | All |
| <a id="14558430">[14558430](#14558430)</a> | Running `DBCC CHECKDB` will report "corruption" errors when you use SQL Server graph databases that have edge constraints. | SQL Server Engine | SQL Server Engine | All |
| <a id="14623946">[14623946](#14623946)</a> | Adds two new Extended Events, `iam_page_range_cache_invalidation` and `iam_page_range_cache_population`, to respectively capture Index Allocation Map (IAM) page range cache invalidation and population. | SQL Server Engine | Storage Management | All |
| <a id="14569908">[14569908](#14569908)</a> | An assertion failure "lck_sufficient (lckMode, LCK_M_IX) \|\| lck_sufficient (lckMode, LCK_M_BU)" occurs when you use Accelerated Database Recovery (ADR). | SQL Server Engine | Transaction Services | All |
| <a id="14516287">[14516287](#14516287)</a> | A view, created in a table that has an XML index, can't return the correct result because of missing '`%`' in `LIKE` predicate on columns hidden for `xml_index_nodes` table. | SQL Server Engine | XML | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU16 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/04/sqlserver2019-kb5011644-x64_a38427fc9ed638fdbc0011be2c71a7b32f811b9e.exe)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202019) contains this SQL Server 2019 CU and previously released SQL Server 2019 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2019 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2019 Release Notes](/sql/linux/sql-server-linux-release-notes-2019).

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update for Big Data Clusters (BDC)</b></summary>

To upgrade Microsoft SQL Server 2019 Big Data Clusters (BDC) on Linux to the latest CU, see the [Big Data Clusters Deployment Guidance](/sql/big-data-cluster/deployment-guidance).

Starting in SQL Server 2019 CU1, you can perform in-place upgrades for Big Data Clusters from the production supported releases (SQL Server 2019 GDR1). For more information, see [How to upgrade SQL Server Big Data Clusters](/sql/big-data-cluster/deployment-upgrade).

For more information, see the [Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2019-KB5011644-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5011644-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5011644-x64.exe| E1CE2B473829D7E2C69CBFA15D75435FDB32017972EE1439BF3D50E3132F7FEF |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.23  | 292800    | 11-Apr-22 | 17:01 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 11-Apr-22 | 17:06 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.23      | 757144    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 175552    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 198552    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 201112    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 197528    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 213912    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 196504    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 192408    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 251288    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 172952    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.23      | 195992    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.23      | 1098144   | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.23      | 480672    | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 54688     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 59296     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 59808     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 58784     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 61856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 58272     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 58272     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 67488     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 53664     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.23      | 58272     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 16792     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 16792     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 16792     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17816     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 16784     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.23      | 17856     | 11-Apr-22 | 17:02 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 11-Apr-22 | 17:06 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 11-Apr-22 | 17:06 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 11-Apr-22 | 17:06 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 11-Apr-22 | 17:06 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 11-Apr-22 | 17:06 | x86      |
| Msmdctr.dll                                               | 2018.150.35.23  | 37272     | 11-Apr-22 | 17:02 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.23  | 66290584  | 11-Apr-22 | 17:02 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.23  | 47785408  | 11-Apr-22 | 17:02 | x86      |
| Msmdpump.dll                                              | 2018.150.35.23  | 10188704  | 11-Apr-22 | 17:02 | x64      |
| Msmdredir.dll                                             | 2018.150.35.23  | 7955864   | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 15768     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 16800     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 16280     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 15768     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 16280     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 17344     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 16280     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 18336     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 15768     | 11-Apr-22 | 17:02 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.23      | 16832     | 11-Apr-22 | 17:02 | x86      |
| Msmdsrv.errorcategories.xml                               | n/a             | 4882      | 11-Apr-22 | 17:02 | n/a      |
| Msmdsrv.exe                                               | 2018.150.35.23  | 65831872  | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 832400    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1628064   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1452952   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1642912   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1607576   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1000344   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 991640    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1535896   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1521568   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 810912    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.23  | 1595288   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 832416    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1623448   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1449880   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1636760   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1603480   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 997784    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 990104    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1532832   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1516944   | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 809888    | 11-Apr-22 | 17:02 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.23  | 1591712   | 11-Apr-22 | 17:02 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.23  | 10184600  | 11-Apr-22 | 17:02 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.23  | 8279456   | 11-Apr-22 | 17:02 | x86      |
| Msolap.dll                                                | 2018.150.35.23  | 11016096  | 11-Apr-22 | 17:02 | x64      |
| Msolap.dll                                                | 2018.150.35.23  | 8608160   | 11-Apr-22 | 17:02 | x86      |
| Msolui.dll                                                | 2018.150.35.23  | 306624    | 11-Apr-22 | 17:02 | x64      |
| Msolui.dll                                                | 2018.150.35.23  | 286144    | 11-Apr-22 | 17:02 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 11-Apr-22 | 17:06 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 11-Apr-22 | 17:06 | x64      |
| Sqlboot.dll                                               | 2019.150.4223.1 | 214968    | 11-Apr-22 | 17:06 | x64      |
| Sqlceip.exe                                               | 15.0.4223.1     | 292760    | 11-Apr-22 | 17:06 | x86      |
| Sqldumper.exe                                             | 2019.150.4223.1 | 153528    | 11-Apr-22 | 17:06 | x86      |
| Sqldumper.exe                                             | 2019.150.4223.1 | 186280    | 11-Apr-22 | 17:06 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 11-Apr-22 | 17:06 | x86      |
| Tmapi.dll                                                 | 2018.150.35.23  | 6178240   | 11-Apr-22 | 17:02 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.23  | 4917696   | 11-Apr-22 | 17:02 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.23  | 1183640   | 11-Apr-22 | 17:02 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.23  | 6806464   | 11-Apr-22 | 17:02 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.23  | 26025920  | 11-Apr-22 | 17:02 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.23  | 35460536  | 11-Apr-22 | 17:02 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4223.1 | 165792    | 11-Apr-22 | 17:37 | x86      |
| Batchparser.dll                      | 2019.150.4223.1 | 182200    | 11-Apr-22 | 17:37 | x64      |
| Instapi150.dll                       | 2019.150.4223.1 | 75704     | 11-Apr-22 | 17:37 | x86      |
| Instapi150.dll                       | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:37 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4223.1 | 100280    | 11-Apr-22 | 17:37 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:37 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4223.1     | 550824    | 11-Apr-22 | 17:37 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4223.1     | 550840    | 11-Apr-22 | 17:37 | x86      |
| Msasxpress.dll                       | 2018.150.35.23  | 32184     | 11-Apr-22 | 17:02 | x64      |
| Msasxpress.dll                       | 2018.150.35.23  | 27040     | 11-Apr-22 | 17:02 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4223.1 | 75688     | 11-Apr-22 | 17:37 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:37 | x64      |
| Sqldumper.exe                        | 2019.150.4223.1 | 153528    | 11-Apr-22 | 17:37 | x86      |
| Sqldumper.exe                        | 2019.150.4223.1 | 186280    | 11-Apr-22 | 17:37 | x64      |
| Sqlftacct.dll                        | 2019.150.4223.1 | 59304     | 11-Apr-22 | 17:37 | x86      |
| Sqlftacct.dll                        | 2019.150.4223.1 | 79784     | 11-Apr-22 | 17:37 | x64      |
| Sqlmanager.dll                       | 2019.150.4223.1 | 743328    | 11-Apr-22 | 17:37 | x86      |
| Sqlmanager.dll                       | 2019.150.4223.1 | 878496    | 11-Apr-22 | 17:37 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4223.1 | 378792    | 11-Apr-22 | 17:37 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4223.1 | 432040    | 11-Apr-22 | 17:37 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4223.1 | 276400    | 11-Apr-22 | 17:37 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4223.1 | 358328    | 11-Apr-22 | 17:37 | x64      |
| Svrenumapi150.dll                    | 2019.150.4223.1 | 1161128   | 11-Apr-22 | 17:37 | x64      |
| Svrenumapi150.dll                    | 2019.150.4223.1 | 911272    | 11-Apr-22 | 17:37 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4223.1 | 137120    | 11-Apr-22 | 17:06 | x86      |
| Dreplaycommon.dll     | 2019.150.4223.1 | 666536    | 11-Apr-22 | 17:06 | x86      |
| Dreplayutil.dll       | 2019.150.4223.1 | 305064    | 11-Apr-22 | 17:06 | x86      |
| Instapi150.dll        | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:06 | x64      |
| Sqlresourceloader.dll | 2019.150.4223.1 | 38840     | 11-Apr-22 | 17:06 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4223.1 | 666536    | 11-Apr-22 | 17:06 | x86      |
| Dreplaycontroller.exe | 2019.150.4223.1 | 366504    | 11-Apr-22 | 17:06 | x86      |
| Instapi150.dll        | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:06 | x64      |
| Sqlresourceloader.dll | 2019.150.4223.1 | 38840     | 11-Apr-22 | 17:06 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4223.1 | 4658088   | 11-Apr-22 | 17:59 | x64      |
| Aetm-enclave.dll                           | 2019.150.4223.1 | 4612504   | 11-Apr-22 | 17:59 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4223.1 | 4932408   | 11-Apr-22 | 17:59 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4223.1 | 4873536   | 11-Apr-22 | 17:59 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 11-Apr-22 | 17:01 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 11-Apr-22 | 17:01 | x64      |
| Batchparser.dll                            | 2019.150.4223.1 | 182200    | 11-Apr-22 | 17:59 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 11-Apr-22 | 17:59 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 11-Apr-22 | 17:59 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 11-Apr-22 | 17:59 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 11-Apr-22 | 17:59 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4223.1 | 280504    | 11-Apr-22 | 17:59 | x64      |
| Dcexec.exe                                 | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:59 | x64      |
| Exacorepredict.dll                         | n/a             | 58408368  | 11-Apr-22 | 17:59 | x64      |
| Exacorepredictsql.dll                      | n/a             | 40344     | 11-Apr-22 | 17:59 | x64      |
| Fssres.dll                                 | 2019.150.4223.1 | 96168     | 11-Apr-22 | 17:59 | x64      |
| Hadrres.dll                                | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:59 | x64      |
| Hkcompile.dll                              | 2019.150.4223.1 | 1292200   | 11-Apr-22 | 17:59 | x64      |
| Hkengdef.h                                 | n/a             | 2804      | 11-Apr-22 | 17:59 | n/a      |
| Hkenggen.h                                 | n/a             | 16783     | 11-Apr-22 | 17:59 | n/a      |
| Hkengine.dll                               | 2019.150.4223.1 | 5789624   | 11-Apr-22 | 17:59 | x64      |
| Hkengine.lib                               | n/a             | 98282     | 11-Apr-22 | 17:59 | n/a      |
| Hkgenlib.h                                 | n/a             | 57242     | 11-Apr-22 | 17:59 | n/a      |
| Hkgenlib.lib                               | n/a             | 3004568   | 11-Apr-22 | 17:59 | n/a      |
| Hkrtdef.h                                  | n/a             | 9434      | 11-Apr-22 | 17:59 | n/a      |
| Hkrtgen.h                                  | n/a             | 29067     | 11-Apr-22 | 17:59 | n/a      |
| Hkruntime.dll                              | 2019.150.4223.1 | 182184    | 11-Apr-22 | 17:59 | x64      |
| Hkruntime.lib                              | n/a             | 37422     | 11-Apr-22 | 17:59 | n/a      |
| Hktempdb.dll                               | 2019.150.4223.1 | 63400     | 11-Apr-22 | 17:59 | x64      |
| Libcmt.amd64.pdb                           | n/a             | 323584    | 11-Apr-22 | 17:59 | n/a      |
| Libcmt.lib                                 | n/a             | 2036034   | 11-Apr-22 | 17:59 | n/a      |
| Libvcruntime.amd64.pdb                     | n/a             | 274432    | 11-Apr-22 | 17:59 | n/a      |
| Libvcruntime.lib                           | n/a             | 1082768   | 11-Apr-22 | 17:59 | n/a      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 11-Apr-22 | 17:59 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4223.1     | 235424    | 11-Apr-22 | 17:59 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4223.1 | 325544    | 11-Apr-22 | 17:59 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4223.1 | 92064     | 11-Apr-22 | 17:59 | x64      |
| Model_msdbdata.mdf                         | n/a             | 14090240  | 11-Apr-22 | 17:59 | n/a      |
| Model_msdblog.ldf                          | n/a             | 524288    | 11-Apr-22 | 17:59 | n/a      |
| Model_replicatedmaster.ldf                 | n/a             | 524288    | 11-Apr-22 | 17:59 | n/a      |
| Model_replicatedmaster.mdf                 | n/a             | 4653056   | 11-Apr-22 | 17:59 | n/a      |
| Msdb110_upgrade.sql                        | n/a             | 2564756   | 11-Apr-22 | 17:59 | n/a      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 11-Apr-22 | 17:59 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 11-Apr-22 | 17:59 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 11-Apr-22 | 17:59 | x64      |
| Mssqlsystemresource.ldf                    | n/a             | 1310720   | 11-Apr-22 | 17:59 | n/a      |
| Mssqlsystemresource.mdf                    | n/a             | 41943040  | 11-Apr-22 | 17:59 | n/a      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 11-Apr-22 | 17:59 | x64      |
| Qds.dll                                    | 2019.150.4223.1 | 1185696   | 11-Apr-22 | 17:59 | x64      |
| Rsfxft.dll                                 | 2019.150.4223.1 | 51128     | 11-Apr-22 | 17:59 | x64      |
| Secforwarder.dll                           | 2019.150.4223.1 | 79800     | 11-Apr-22 | 17:59 | x64      |
| Sqagtres.dll                               | 2019.150.4223.1 | 87976     | 11-Apr-22 | 17:59 | x64      |
| Sqlaamss.dll                               | 2019.150.4223.1 | 108472    | 11-Apr-22 | 17:59 | x64      |
| Sqlaccess.dll                              | 2019.150.4223.1 | 493480    | 11-Apr-22 | 17:59 | x64      |
| Sqlagent.exe                               | 2019.150.4223.1 | 731064    | 11-Apr-22 | 17:59 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4223.1 | 67496     | 11-Apr-22 | 17:59 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4223.1 | 79784     | 11-Apr-22 | 17:59 | x64      |
| Sqlboot.dll                                | 2019.150.4223.1 | 214968    | 11-Apr-22 | 17:06 | x64      |
| Sqlceip.exe                                | 15.0.4223.1     | 292760    | 11-Apr-22 | 17:59 | x86      |
| Sqlcmdss.dll                               | 2019.150.4223.1 | 87976     | 11-Apr-22 | 17:59 | x64      |
| Sqlctr150.dll                              | 2019.150.4223.1 | 116664    | 11-Apr-22 | 17:59 | x86      |
| Sqlctr150.dll                              | 2019.150.4223.1 | 141224    | 11-Apr-22 | 17:59 | x64      |
| Sqldk.dll                                  | 2019.150.4223.1 | 3155872   | 11-Apr-22 | 17:59 | x64      |
| Sqldtsss.dll                               | 2019.150.4223.1 | 108456    | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 1595320   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3499960   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3696568   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4163512   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4282296   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3413944   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3581880   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4155320   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4011960   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4061112   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 2222008   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 2172856   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3868600   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3545016   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4016056   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3819448   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3819448   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3614648   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3499960   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 1537976   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 3905464   | 11-Apr-22 | 17:59 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4223.1 | 4028344   | 11-Apr-22 | 17:59 | x64      |
| Sqllang.dll                                | 2019.150.4223.1 | 39954344  | 11-Apr-22 | 17:59 | x64      |
| Sqlmin.dll                                 | 2019.150.4223.1 | 40530872  | 11-Apr-22 | 17:59 | x64      |
| Sqlolapss.dll                              | 2019.150.4223.1 | 104360    | 11-Apr-22 | 17:59 | x64      |
| Sqlos.dll                                  | 2019.150.4223.1 | 42936     | 11-Apr-22 | 17:59 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4223.1 | 83872     | 11-Apr-22 | 17:59 | x64      |
| Sqlrepss.dll                               | 2019.150.4223.1 | 83880     | 11-Apr-22 | 17:59 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4223.1 | 51128     | 11-Apr-22 | 17:59 | x64      |
| Sqlscm.dll                                 | 2019.150.4223.1 | 87976     | 11-Apr-22 | 17:59 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4223.1 | 38840     | 11-Apr-22 | 17:59 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4223.1 | 5805984   | 11-Apr-22 | 17:59 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4223.1 | 673720    | 11-Apr-22 | 17:59 | x64      |
| Sqlservr.exe                               | 2019.150.4223.1 | 628664    | 11-Apr-22 | 17:59 | x64      |
| Sqlsvc.dll                                 | 2019.150.4223.1 | 182176    | 11-Apr-22 | 17:59 | x64      |
| Sqltses.dll                                | 2019.150.4223.1 | 9115576   | 11-Apr-22 | 17:59 | x64      |
| Sqsrvres.dll                               | 2019.150.4223.1 | 280488    | 11-Apr-22 | 17:59 | x64      |
| Ssis_hotfix_install.sql                    | n/a             | 11872     | 11-Apr-22 | 17:59 | n/a      |
| Svl.dll                                    | 2019.150.4223.1 | 161696    | 11-Apr-22 | 17:59 | x64      |
| U_tables.sql                               | n/a             | 20021     | 11-Apr-22 | 17:59 | n/a      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 11-Apr-22 | 17:59 | x64      |
| Xe.dll                                     | 2019.150.4223.1 | 722872    | 11-Apr-22 | 17:59 | x64      |
| Xesospkg.mof                               | n/a             | 366466    | 11-Apr-22 | 17:59 | n/a      |
| Xesqlminpkg.mof                            | n/a             | 2018608   | 11-Apr-22 | 17:59 | n/a      |
| Xesqlpkg.mof                               | n/a             | 841931    | 11-Apr-22 | 17:59 | n/a      |
| Xpadsi.exe                                 | 2019.150.4223.1 | 116664    | 11-Apr-22 | 17:59 | x64      |
| Xplog70.dll                                | 2019.150.4223.1 | 92064     | 11-Apr-22 | 17:59 | x64      |
| Xpqueue.dll                                | 2019.150.4223.1 | 92056     | 11-Apr-22 | 17:59 | x64      |
| Xprepl.dll                                 | 2019.150.4223.1 | 120736    | 11-Apr-22 | 17:59 | x64      |
| Xpstar.dll                                 | 2019.150.4223.1 | 472992    | 11-Apr-22 | 17:59 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4223.1 | 182200    | 11-Apr-22 | 17:06 | x64      |
| Batchparser.dll                                              | 2019.150.4223.1 | 165792    | 11-Apr-22 | 17:06 | x86      |
| Commanddest.dll                                              | 2019.150.4223.1 | 264104    | 11-Apr-22 | 17:06 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4223.1 | 227240    | 11-Apr-22 | 17:06 | x64      |
| Distrib.exe                                                  | 2019.150.4223.1 | 235424    | 11-Apr-22 | 17:06 | x64      |
| Dteparse.dll                                                 | 2019.150.4223.1 | 124832    | 11-Apr-22 | 17:06 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4223.1 | 133032    | 11-Apr-22 | 17:06 | x64      |
| Dtepkg.dll                                                   | 2019.150.4223.1 | 149432    | 11-Apr-22 | 17:06 | x64      |
| Dtexec.exe                                                   | 2019.150.4223.1 | 72616     | 11-Apr-22 | 17:06 | x64      |
| Dts.dll                                                      | 2019.150.4223.1 | 3143592   | 11-Apr-22 | 17:06 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4223.1 | 501664    | 11-Apr-22 | 17:06 | x64      |
| Dtsconn.dll                                                  | 2019.150.4223.1 | 522152    | 11-Apr-22 | 17:06 | x64      |
| Dtshost.exe                                                  | 2019.150.4223.1 | 105384    | 11-Apr-22 | 17:06 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4223.1 | 567224    | 11-Apr-22 | 17:06 | x64      |
| Dtspipeline.dll                                              | 2019.150.4223.1 | 1329080   | 11-Apr-22 | 17:06 | x64      |
| Dtswizard.exe                                                | 15.0.4223.1     | 886712    | 11-Apr-22 | 17:06 | x64      |
| Dtuparse.dll                                                 | 2019.150.4223.1 | 100264    | 11-Apr-22 | 17:06 | x64      |
| Dtutil.exe                                                   | 2019.150.4223.1 | 148384    | 11-Apr-22 | 17:06 | x64      |
| Exceldest.dll                                                | 2019.150.4223.1 | 280488    | 11-Apr-22 | 17:06 | x64      |
| Excelsrc.dll                                                 | 2019.150.4223.1 | 309152    | 11-Apr-22 | 17:06 | x64      |
| Execpackagetask.dll                                          | 2019.150.4223.1 | 186272    | 11-Apr-22 | 17:06 | x64      |
| Flatfiledest.dll                                             | 2019.150.4223.1 | 411576    | 11-Apr-22 | 17:06 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4223.1 | 427944    | 11-Apr-22 | 17:06 | x64      |
| Log4j-1.2.17.jar                                             | n/a             | 489884    | 11-Apr-22 | 17:06 | n/a      |
| Logread.exe                                                  | 2019.150.4223.1 | 718776    | 11-Apr-22 | 17:06 | x64      |
| Mergetxt.dll                                                 | 2019.150.4223.1 | 75680     | 11-Apr-22 | 17:06 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4223.1     | 59320     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4223.1     | 42936     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4223.1     | 391096    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4223.1 | 1689512   | 11-Apr-22 | 17:06 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4223.1 | 1640352   | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4223.1     | 550824    | 11-Apr-22 | 17:06 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4223.1 | 112552    | 11-Apr-22 | 17:06 | x64      |
| Msgprox.dll                                                  | 2019.150.4223.1 | 300984    | 11-Apr-22 | 17:06 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 11-Apr-22 | 17:06 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4223.1 | 1497016   | 11-Apr-22 | 17:06 | x64      |
| Oledbdest.dll                                                | 2019.150.4223.1 | 280488    | 11-Apr-22 | 17:06 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4223.1 | 313256    | 11-Apr-22 | 17:06 | x64      |
| Osql.exe                                                     | 2019.150.4223.1 | 92088     | 11-Apr-22 | 17:06 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4223.1 | 497568    | 11-Apr-22 | 17:06 | x64      |
| Rawdest.dll                                                  | 2019.150.4223.1 | 227232    | 11-Apr-22 | 17:06 | x64      |
| Rawsource.dll                                                | 2019.150.4223.1 | 210856    | 11-Apr-22 | 17:06 | x64      |
| Rdistcom.dll                                                 | 2019.150.4223.1 | 915360    | 11-Apr-22 | 17:06 | x64      |
| Recordsetdest.dll                                            | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:06 | x64      |
| Repldp.dll                                                   | 2019.150.4223.1 | 313248    | 11-Apr-22 | 17:06 | x64      |
| Replerrx.dll                                                 | 2019.150.4223.1 | 182176    | 11-Apr-22 | 17:06 | x64      |
| Replisapi.dll                                                | 2019.150.4223.1 | 395192    | 11-Apr-22 | 17:06 | x64      |
| Replmerg.exe                                                 | 2019.150.4223.1 | 563104    | 11-Apr-22 | 17:06 | x64      |
| Replprov.dll                                                 | 2019.150.4223.1 | 858016    | 11-Apr-22 | 17:06 | x64      |
| Replrec.dll                                                  | 2019.150.4223.1 | 1034144   | 11-Apr-22 | 17:06 | x64      |
| Replsub.dll                                                  | 2019.150.4223.1 | 473016    | 11-Apr-22 | 17:06 | x64      |
| Replsync.dll                                                 | 2019.150.4223.1 | 165800    | 11-Apr-22 | 17:06 | x64      |
| Slf4j-log4j12-1.7.5.jar                                      | n/a             | 8869      | 11-Apr-22 | 17:06 | n/a      |
| Spresolv.dll                                                 | 2019.150.4223.1 | 276384    | 11-Apr-22 | 17:06 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4223.1 | 264120    | 11-Apr-22 | 17:06 | x64      |
| Sqldiag.exe                                                  | 2019.150.4223.1 | 1140664   | 11-Apr-22 | 17:06 | x64      |
| Sqldistx.dll                                                 | 2019.150.4223.1 | 247720    | 11-Apr-22 | 17:06 | x64      |
| Sqllogship.exe                                               | 15.0.4223.1     | 104376    | 11-Apr-22 | 17:06 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4223.1 | 399264    | 11-Apr-22 | 17:06 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4223.1 | 51128     | 11-Apr-22 | 17:06 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4223.1 | 38840     | 11-Apr-22 | 17:06 | x86      |
| Sqlscm.dll                                                   | 2019.150.4223.1 | 87976     | 11-Apr-22 | 17:06 | x64      |
| Sqlscm.dll                                                   | 2019.150.4223.1 | 79784     | 11-Apr-22 | 17:06 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4223.1 | 182176    | 11-Apr-22 | 17:06 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4223.1 | 149432    | 11-Apr-22 | 17:06 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:06 | x64      |
| Ssradd.dll                                                   | 2019.150.4223.1 | 83872     | 11-Apr-22 | 17:06 | x64      |
| Ssravg.dll                                                   | 2019.150.4223.1 | 83872     | 11-Apr-22 | 17:06 | x64      |
| Ssrdown.dll                                                  | 2019.150.4223.1 | 75688     | 11-Apr-22 | 17:06 | x64      |
| Ssrmax.dll                                                   | 2019.150.4223.1 | 83872     | 11-Apr-22 | 17:06 | x64      |
| Ssrmin.dll                                                   | 2019.150.4223.1 | 83872     | 11-Apr-22 | 17:06 | x64      |
| Ssrpub.dll                                                   | 2019.150.4223.1 | 75680     | 11-Apr-22 | 17:06 | x64      |
| Ssrup.dll                                                    | 2019.150.4223.1 | 75680     | 11-Apr-22 | 17:06 | x64      |
| Txagg.dll                                                    | 2019.150.4223.1 | 391080    | 11-Apr-22 | 17:06 | x64      |
| Txbdd.dll                                                    | 2019.150.4223.1 | 190376    | 11-Apr-22 | 17:06 | x64      |
| Txdatacollector.dll                                          | 2019.150.4223.1 | 473000    | 11-Apr-22 | 17:06 | x64      |
| Txdataconvert.dll                                            | 2019.150.4223.1 | 317368    | 11-Apr-22 | 17:06 | x64      |
| Txderived.dll                                                | 2019.150.4223.1 | 640928    | 11-Apr-22 | 17:06 | x64      |
| Txlookup.dll                                                 | 2019.150.4223.1 | 542632    | 11-Apr-22 | 17:06 | x64      |
| Txmerge.dll                                                  | 2019.150.4223.1 | 247720    | 11-Apr-22 | 17:06 | x64      |
| Txmergejoin.dll                                              | 2019.150.4223.1 | 309160    | 11-Apr-22 | 17:06 | x64      |
| Txmulticast.dll                                              | 2019.150.4223.1 | 145320    | 11-Apr-22 | 17:06 | x64      |
| Txrowcount.dll                                               | 2019.150.4223.1 | 141224    | 11-Apr-22 | 17:06 | x64      |
| Txsort.dll                                                   | 2019.150.4223.1 | 288680    | 11-Apr-22 | 17:06 | x64      |
| Txsplit.dll                                                  | 2019.150.4223.1 | 624544    | 11-Apr-22 | 17:06 | x64      |
| Txunionall.dll                                               | 2019.150.4223.1 | 198568    | 11-Apr-22 | 17:06 | x64      |
| Xe.dll                                                       | 2019.150.4223.1 | 722872    | 11-Apr-22 | 17:06 | x64      |
| Xmlsub.dll                                                   | 2019.150.4223.1 | 296888    | 11-Apr-22 | 17:06 | x64      |

SQL Server 2019 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Ccommonlauncher.dll           | 2019.150.4223.1 | 92088     | 11-Apr-22 | 17:06 | x64      |
| Exthost.exe                   | 2019.150.4223.1 | 239528    | 11-Apr-22 | 17:06 | x64      |
| Java-lang-extension.zip       | n/a             | 362852    | 11-Apr-22 | 17:06 | n/a      |
| Launchpad.exe                 | 2019.150.4223.1 | 1222560   | 11-Apr-22 | 17:06 | x64      |
| Mssql-java-lang-extension.jar | n/a             | 12630     | 11-Apr-22 | 17:06 | n/a      |
| Sqlsatellite.dll              | 2019.150.4223.1 | 1021880   | 11-Apr-22 | 17:06 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4223.1 | 685992    | 11-Apr-22 | 17:06 | x64      |
| Fdhost.exe     | 2019.150.4223.1 | 128928    | 11-Apr-22 | 17:06 | x64      |
| Fdlauncher.exe | 2019.150.4223.1 | 79784     | 11-Apr-22 | 17:06 | x64      |
| Sqlft150ph.dll | 2019.150.4223.1 | 92072     | 11-Apr-22 | 17:06 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4223.1  | 30624     | 11-Apr-22 | 17:06 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4223.1 | 264104    | 11-Apr-22 | 17:06 | x64      |
| Commanddest.dll                                               | 2019.150.4223.1 | 227240    | 11-Apr-22 | 17:06 | x86      |
| Dteparse.dll                                                  | 2019.150.4223.1 | 112552    | 11-Apr-22 | 17:06 | x86      |
| Dteparse.dll                                                  | 2019.150.4223.1 | 124832    | 11-Apr-22 | 17:06 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4223.1 | 116648    | 11-Apr-22 | 17:06 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4223.1 | 133032    | 11-Apr-22 | 17:06 | x64      |
| Dtepkg.dll                                                    | 2019.150.4223.1 | 133048    | 11-Apr-22 | 17:06 | x86      |
| Dtepkg.dll                                                    | 2019.150.4223.1 | 149432    | 11-Apr-22 | 17:06 | x64      |
| Dtexec.exe                                                    | 2019.150.4223.1 | 63904     | 11-Apr-22 | 17:06 | x86      |
| Dtexec.exe                                                    | 2019.150.4223.1 | 72616     | 11-Apr-22 | 17:06 | x64      |
| Dts.dll                                                       | 2019.150.4223.1 | 2762672   | 11-Apr-22 | 17:06 | x86      |
| Dts.dll                                                       | 2019.150.4223.1 | 3143592   | 11-Apr-22 | 17:06 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4223.1 | 501664    | 11-Apr-22 | 17:06 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4223.1 | 444328    | 11-Apr-22 | 17:06 | x86      |
| Dtsconn.dll                                                   | 2019.150.4223.1 | 432040    | 11-Apr-22 | 17:06 | x86      |
| Dtsconn.dll                                                   | 2019.150.4223.1 | 522152    | 11-Apr-22 | 17:06 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4223.1 | 112040    | 11-Apr-22 | 17:05 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4223.1 | 93608     | 11-Apr-22 | 17:05 | x86      |
| Dtshost.exe                                                   | 2019.150.4223.1 | 88488     | 11-Apr-22 | 17:06 | x86      |
| Dtshost.exe                                                   | 2019.150.4223.1 | 105384    | 11-Apr-22 | 17:06 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4223.1 | 554920    | 11-Apr-22 | 17:06 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4223.1 | 567224    | 11-Apr-22 | 17:06 | x64      |
| Dtspipeline.dll                                               | 2019.150.4223.1 | 1120184   | 11-Apr-22 | 17:06 | x86      |
| Dtspipeline.dll                                               | 2019.150.4223.1 | 1329080   | 11-Apr-22 | 17:06 | x64      |
| Dtswizard.exe                                                 | 15.0.4223.1     | 886712    | 11-Apr-22 | 17:05 | x64      |
| Dtswizard.exe                                                 | 15.0.4223.1     | 890808    | 11-Apr-22 | 17:05 | x86      |
| Dtuparse.dll                                                  | 2019.150.4223.1 | 100264    | 11-Apr-22 | 17:06 | x64      |
| Dtuparse.dll                                                  | 2019.150.4223.1 | 87976     | 11-Apr-22 | 17:06 | x86      |
| Dtutil.exe                                                    | 2019.150.4223.1 | 129960    | 11-Apr-22 | 17:06 | x86      |
| Dtutil.exe                                                    | 2019.150.4223.1 | 148384    | 11-Apr-22 | 17:06 | x64      |
| Exceldest.dll                                                 | 2019.150.4223.1 | 235432    | 11-Apr-22 | 17:06 | x86      |
| Exceldest.dll                                                 | 2019.150.4223.1 | 280488    | 11-Apr-22 | 17:06 | x64      |
| Excelsrc.dll                                                  | 2019.150.4223.1 | 309152    | 11-Apr-22 | 17:06 | x64      |
| Excelsrc.dll                                                  | 2019.150.4223.1 | 260008    | 11-Apr-22 | 17:06 | x86      |
| Execpackagetask.dll                                           | 2019.150.4223.1 | 149416    | 11-Apr-22 | 17:06 | x86      |
| Execpackagetask.dll                                           | 2019.150.4223.1 | 186272    | 11-Apr-22 | 17:06 | x64      |
| Flatfiledest.dll                                              | 2019.150.4223.1 | 358312    | 11-Apr-22 | 17:06 | x86      |
| Flatfiledest.dll                                              | 2019.150.4223.1 | 411576    | 11-Apr-22 | 17:06 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4223.1 | 427944    | 11-Apr-22 | 17:06 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4223.1 | 370600    | 11-Apr-22 | 17:06 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4223.1     | 120760    | 11-Apr-22 | 17:05 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4223.1     | 120736    | 11-Apr-22 | 17:06 | x86      |
| Isserverexec.exe                                              | 15.0.4223.1     | 145320    | 11-Apr-22 | 17:05 | x64      |
| Isserverexec.exe                                              | 15.0.4223.1     | 149408    | 11-Apr-22 | 17:05 | x86      |
| Log4j-1.2.17.jar                                              | n/a             | 489884    | 11-Apr-22 | 17:06 | n/a      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4223.1     | 116664    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4223.1     | 59320     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4223.1     | 59304     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4223.1     | 509880    | 11-Apr-22 | 17:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4223.1     | 42936     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4223.1     | 42920     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4223.1     | 391096    | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4223.1     | 59320     | 11-Apr-22 | 17:06 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4223.1     | 141240    | 11-Apr-22 | 17:05 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4223.1     | 219048    | 11-Apr-22 | 17:06 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4223.1 | 100264    | 11-Apr-22 | 17:06 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4223.1 | 112552    | 11-Apr-22 | 17:06 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.23  | 10062744  | 11-Apr-22 | 17:02 | x64      |
| Odbcdest.dll                                                  | 2019.150.4223.1 | 317352    | 11-Apr-22 | 17:06 | x86      |
| Odbcdest.dll                                                  | 2019.150.4223.1 | 370600    | 11-Apr-22 | 17:06 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4223.1 | 329640    | 11-Apr-22 | 17:06 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4223.1 | 382888    | 11-Apr-22 | 17:06 | x64      |
| Oledbdest.dll                                                 | 2019.150.4223.1 | 239528    | 11-Apr-22 | 17:06 | x86      |
| Oledbdest.dll                                                 | 2019.150.4223.1 | 280488    | 11-Apr-22 | 17:06 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4223.1 | 264104    | 11-Apr-22 | 17:06 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4223.1 | 313256    | 11-Apr-22 | 17:06 | x64      |
| Rawdest.dll                                                   | 2019.150.4223.1 | 190376    | 11-Apr-22 | 17:06 | x86      |
| Rawdest.dll                                                   | 2019.150.4223.1 | 227232    | 11-Apr-22 | 17:06 | x64      |
| Rawsource.dll                                                 | 2019.150.4223.1 | 210856    | 11-Apr-22 | 17:06 | x64      |
| Rawsource.dll                                                 | 2019.150.4223.1 | 178088    | 11-Apr-22 | 17:06 | x86      |
| Recordsetdest.dll                                             | 2019.150.4223.1 | 173992    | 11-Apr-22 | 17:06 | x86      |
| Recordsetdest.dll                                             | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:06 | x64      |
| Slf4j-log4j12-1.7.5.jar                                       | n/a             | 8869      | 11-Apr-22 | 17:06 | n/a      |
| Sqlceip.exe                                                   | 15.0.4223.1     | 292760    | 11-Apr-22 | 17:06 | x86      |
| Sqldest.dll                                                   | 2019.150.4223.1 | 276384    | 11-Apr-22 | 17:06 | x64      |
| Sqldest.dll                                                   | 2019.150.4223.1 | 239528    | 11-Apr-22 | 17:06 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4223.1 | 169896    | 11-Apr-22 | 17:06 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:06 | x64      |
| Txagg.dll                                                     | 2019.150.4223.1 | 329640    | 11-Apr-22 | 17:06 | x86      |
| Txagg.dll                                                     | 2019.150.4223.1 | 391080    | 11-Apr-22 | 17:06 | x64      |
| Txbdd.dll                                                     | 2019.150.4223.1 | 190376    | 11-Apr-22 | 17:06 | x64      |
| Txbdd.dll                                                     | 2019.150.4223.1 | 153512    | 11-Apr-22 | 17:06 | x86      |
| Ttxbestmatch.dll                                              | 2019.150.4223.1 | 546728    | 11-Apr-22 | 17:06 | x86      |
| Txbestmatch.dll                                               | 2019.150.4223.1 | 653240    | 11-Apr-22 | 17:06 | x64      |
| Txcache.dll                                                   | 2019.150.4223.1 | 165800    | 11-Apr-22 | 17:06 | x86      |
| Txcache.dll                                                   | 2019.150.4223.1 | 198568    | 11-Apr-22 | 17:06 | x64      |
| Txcharmap.dll                                                 | 2019.150.4223.1 | 313248    | 11-Apr-22 | 17:06 | x64      |
| Txcharmap.dll                                                 | 2019.150.4223.1 | 272296    | 11-Apr-22 | 17:06 | x86      |
| Txcopymap.dll                                                 | 2019.150.4223.1 | 165800    | 11-Apr-22 | 17:06 | x86      |
| Txcopymap.dll                                                 | 2019.150.4223.1 | 198568    | 11-Apr-22 | 17:06 | x64      |
| Txdataconvert.dll                                             | 2019.150.4223.1 | 317368    | 11-Apr-22 | 17:06 | x64      |
| Txdataconvert.dll                                             | 2019.150.4223.1 | 276392    | 11-Apr-22 | 17:06 | x86      |
| Txderived.dll                                                 | 2019.150.4223.1 | 559016    | 11-Apr-22 | 17:06 | x86      |
| Txderived.dll                                                 | 2019.150.4223.1 | 640928    | 11-Apr-22 | 17:06 | x64      |
| Txfileextractor.dll                                           | 2019.150.4223.1 | 182184    | 11-Apr-22 | 17:06 | x86      |
| Txfileextractor.dll                                           | 2019.150.4223.1 | 219032    | 11-Apr-22 | 17:06 | x64      |
| Txfileinserter.dll                                            | 2019.150.4223.1 | 182184    | 11-Apr-22 | 17:06 | x86      |
| Txfileinserter.dll                                            | 2019.150.4223.1 | 214952    | 11-Apr-22 | 17:06 | x64      |
| Txgroupdups.dll                                               | 2019.150.4223.1 | 313248    | 11-Apr-22 | 17:06 | x64      |
| Txgroupdups.dll                                               | 2019.150.4223.1 | 255912    | 11-Apr-22 | 17:06 | x86      |
| Txlineage.dll                                                 | 2019.150.4223.1 | 128936    | 11-Apr-22 | 17:06 | x86      |
| Txlineage.dll                                                 | 2019.150.4223.1 | 153512    | 11-Apr-22 | 17:06 | x64      |
| Txlookup.dll                                                  | 2019.150.4223.1 | 468904    | 11-Apr-22 | 17:06 | x86      |
| Txlookup.dll                                                  | 2019.150.4223.1 | 542632    | 11-Apr-22 | 17:06 | x64      |
| Txmerge.dll                                                   | 2019.150.4223.1 | 247720    | 11-Apr-22 | 17:06 | x64      |
| Txmerge.dll                                                   | 2019.150.4223.1 | 202664    | 11-Apr-22 | 17:06 | x86      |
| Txmergejoin.dll                                               | 2019.150.4223.1 | 247720    | 11-Apr-22 | 17:06 | x86      |
| Txmergejoin.dll                                               | 2019.150.4223.1 | 309160    | 11-Apr-22 | 17:06 | x64      |
| Txmulticast.dll                                               | 2019.150.4223.1 | 116648    | 11-Apr-22 | 17:06 | x86      |
| Txmulticast.dll                                               | 2019.150.4223.1 | 145320    | 11-Apr-22 | 17:06 | x64      |
| Txpivot.dll                                                   | 2019.150.4223.1 | 206760    | 11-Apr-22 | 17:06 | x86      |
| Txpivot.dll                                                   | 2019.150.4223.1 | 239528    | 11-Apr-22 | 17:06 | x64      |
| Txrowcount.dll                                                | 2019.150.4223.1 | 141224    | 11-Apr-22 | 17:06 | x64      |
| Txrowcount.dll                                                | 2019.150.4223.1 | 112552    | 11-Apr-22 | 17:06 | x86      |
| Txsampling.dll                                                | 2019.150.4223.1 | 157608    | 11-Apr-22 | 17:06 | x86      |
| Txsampling.dll                                                | 2019.150.4223.1 | 194472    | 11-Apr-22 | 17:06 | x64      |
| Txscd.dll                                                     | 2019.150.4223.1 | 198568    | 11-Apr-22 | 17:06 | x86      |
| Txscd.dll                                                     | 2019.150.4223.1 | 235432    | 11-Apr-22 | 17:06 | x64      |
| Txsort.dll                                                    | 2019.150.4223.1 | 231336    | 11-Apr-22 | 17:06 | x86      |
| Txsort.dll                                                    | 2019.150.4223.1 | 288680    | 11-Apr-22 | 17:06 | x64      |
| Txsplit.dll                                                   | 2019.150.4223.1 | 550824    | 11-Apr-22 | 17:06 | x86      |
| Txsplit.dll                                                   | 2019.150.4223.1 | 624544    | 11-Apr-22 | 17:06 | x64      |
| Txtermextraction.dll                                          | 2019.150.4223.1 | 8701856   | 11-Apr-22 | 17:06 | x64      |
| Txtermextraction.dll                                          | 2019.150.4223.1 | 8644512   | 11-Apr-22 | 17:06 | x86      |
| Txtermlookup.dll                                              | 2019.150.4223.1 | 4138920   | 11-Apr-22 | 17:06 | x86      |
| Txtermlookup.dll                                              | 2019.150.4223.1 | 4183976   | 11-Apr-22 | 17:06 | x64      |
| Txunionall.dll                                                | 2019.150.4223.1 | 161704    | 11-Apr-22 | 17:06 | x86      |
| Txunionall.dll                                                | 2019.150.4223.1 | 198568    | 11-Apr-22 | 17:06 | x64      |
| Txunpivot.dll                                                 | 2019.150.4223.1 | 182184    | 11-Apr-22 | 17:06 | x86      |
| Txunpivot.dll                                                 | 2019.150.4223.1 | 214952    | 11-Apr-22 | 17:06 | x64      |
| Xe.dll                                                        | 2019.150.4223.1 | 632744    | 11-Apr-22 | 17:06 | x86      |
| Xe.dll                                                        | 2019.150.4223.1 | 722872    | 11-Apr-22 | 17:06 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 11-Apr-22 | 17:47 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 11-Apr-22 | 17:47 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 11-Apr-22 | 17:47 | x86      |
| Dwengineservice.exe.config                                           | n/a             | 252094    | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_cacerts_pem.64                      | n/a             | 255048    | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_dsmessages_xml.64                   | n/a             | 10067     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_mdmessages_xml.64                   | n/a             | 9574      | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_did.64                  | n/a             | 272       | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdrivermongo_238_odbcmessages_xml.64                 | n/a             | 77846     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_openssl64_dlla_manifest.64          | n/a             | 282       | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdrivermongo_238_schemamapmessages_xml.64            | n/a             | 1884      | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_sqlenginemessages_xml.64            | n/a             | 39334     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongo_238_thirdpartynotices_txt.64            | n/a             | 52677     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongodb233_ini.64                             | n/a             | 229       | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdrivermongodb238_ini.64                             | n/a             | 241       | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msodbc_lic.64                      | n/a             | 2564      | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriveroracle_802_thirdpartynotices_txt.64           | n/a             | 64248     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1028 | n/a             | 156536    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1031 | n/a             | 226168    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1033 | n/a             | 205688    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1036 | n/a             | 230264    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1040 | n/a             | 226168    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1041 | n/a             | 172920    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1042 | n/a             | 172920    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1046 | n/a             | 222072    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_1049 | n/a             | 222072    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_2052 | n/a             | 156536    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriversqlserver_17411_lang_msodbcsqlr17_rll_64_3082 | n/a             | 226168    | 11-Apr-22 | 17:47 | x64      |
| Eng_polybase_odbcdriverteradata_162000_dsmessages_xml.64             | n/a             | 10247     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriverteradata_162000_odbcmessages_xml.64           | n/a             | 78296     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriverteradata_162000_sqlenginemessages_xml.64      | n/a             | 39647     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriverteradata_162000_tdmessages_xml.64             | n/a             | 20320     | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriverteradata_162000_teradataodbc_did.64           | n/a             | 272       | 11-Apr-22 | 17:47 | n/a      |
| Eng_polybase_odbcdriverteradata_162000_thirdpartynotices_txt.64      | n/a             | 28881     | 11-Apr-22 | 17:47 | n/a      |
| Enginediagnosticsconfig.xml                                          | n/a             | 155186    | 11-Apr-22 | 17:47 | n/a      |
| Externalaccessconfig.xml                                             | n/a             | 68870     | 11-Apr-22 | 17:47 | n/a      |
| Externalobjectsconfig.xml                                            | n/a             | 1834      | 11-Apr-22 | 17:47 | n/a      |
| Externaloptimizationconfig.xml                                       | n/a             | 18223     | 11-Apr-22 | 17:47 | n/a      |
| Externalworkersconfig.xml                                            | n/a             | 1416      | 11-Apr-22 | 17:47 | n/a      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 11-Apr-22 | 17:47 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 11-Apr-22 | 17:47 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 11-Apr-22 | 17:47 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 11-Apr-22 | 17:47 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 11-Apr-22 | 17:47 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 11-Apr-22 | 17:47 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 11-Apr-22 | 17:47 | x64      |
| Instapi150.dll                                                       | 2019.150.4223.1 | 87992     | 11-Apr-22 | 17:47 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 11-Apr-22 | 17:47 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 11-Apr-22 | 17:47 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 11-Apr-22 | 17:47 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 11-Apr-22 | 17:47 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 11-Apr-22 | 17:47 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 11-Apr-22 | 17:47 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 11-Apr-22 | 17:47 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4223.1 | 452520    | 11-Apr-22 | 17:47 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4223.1 | 7399352   | 11-Apr-22 | 17:47 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 11-Apr-22 | 17:47 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 11-Apr-22 | 17:47 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 11-Apr-22 | 17:47 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 11-Apr-22 | 17:47 | x64      |
| Polybase odbc driver for mongodb.ini                                 | n/a             | 229       | 11-Apr-22 | 17:47 | n/a      |
| Polybase odbc driver for oracle.ini                                  | n/a             | 207       | 11-Apr-22 | 17:47 | n/a      |
| Polybase odbc driver for sql server.ini                              | n/a             | 317       | 11-Apr-22 | 17:47 | n/a      |
| Polybase odbc driver for teradata.ini                                | n/a             | 235       | 11-Apr-22 | 17:47 | n/a      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 11-Apr-22 | 17:47 | x64      |
| Secforwarder.dll                                                     | 2019.150.4223.1 | 79800     | 11-Apr-22 | 17:47 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 11-Apr-22 | 17:47 | x64      |
| Sqldk.dll                                                            | 2019.150.4223.1 | 3155872   | 11-Apr-22 | 17:47 | x64      |
| Sqldumper.exe                                                        | 2019.150.4223.1 | 186280    | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 1595320   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 4163512   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 3413944   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 4155320   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 4061112   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 2222008   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 2172856   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 3819448   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 3819448   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 1537976   | 11-Apr-22 | 17:47 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4223.1 | 4028344   | 11-Apr-22 | 17:47 | x64      |
| Sqlos.dll                                                            | 2019.150.4223.1 | 42936     | 11-Apr-22 | 17:47 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 11-Apr-22 | 17:47 | x64      |
| Sqltses.dll                                                          | 2019.150.4223.1 | 9115576   | 11-Apr-22 | 17:47 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 11-Apr-22 | 17:47 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 11-Apr-22 | 17:47 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 11-Apr-22 | 17:47 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4223.1  | 30648     | 11-Apr-22 | 17:05 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4223.1 | 1632168   | 11-Apr-22 | 18:00 | x86      |
| Dtaengine.exe                                                | 2019.150.4223.1 | 219064    | 11-Apr-22 | 18:00 | x86      |
| Dteparse.dll                                                 | 2019.150.4223.1 | 112552    | 11-Apr-22 | 18:00 | x86      |
| Dteparse.dll                                                 | 2019.150.4223.1 | 124832    | 11-Apr-22 | 18:00 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4223.1 | 116648    | 11-Apr-22 | 18:00 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4223.1 | 133032    | 11-Apr-22 | 18:00 | x64      |
| Dtepkg.dll                                                   | 2019.150.4223.1 | 133048    | 11-Apr-22 | 18:00 | x86      |
| Dtepkg.dll                                                   | 2019.150.4223.1 | 149432    | 11-Apr-22 | 18:00 | x64      |
| Dtexec.exe                                                   | 2019.150.4223.1 | 72616     | 11-Apr-22 | 18:00 | x64      |
| Dtexec.exe                                                   | 2019.150.4223.1 | 63904     | 11-Apr-22 | 18:00 | x86      |
| Dts.dll                                                      | 2019.150.4223.1 | 2762672   | 11-Apr-22 | 18:00 | x86      |
| Dts.dll                                                      | 2019.150.4223.1 | 3143592   | 11-Apr-22 | 18:00 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4223.1 | 444328    | 11-Apr-22 | 18:00 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4223.1 | 501664    | 11-Apr-22 | 18:00 | x64      |
| Dtsconn.dll                                                  | 2019.150.4223.1 | 432040    | 11-Apr-22 | 18:00 | x86      |
| Dtsconn.dll                                                  | 2019.150.4223.1 | 522152    | 11-Apr-22 | 18:00 | x64      |
| Dtshost.exe                                                  | 2019.150.4223.1 | 105384    | 11-Apr-22 | 18:00 | x64      |
| Dtshost.exe                                                  | 2019.150.4223.1 | 88488     | 11-Apr-22 | 18:00 | x86      |
| Dtsmsg.h                                                     | n/a             | 779773    | 11-Apr-22 | 18:00 | n/a      |
| Dtsmsg150.dll                                                | 2019.150.4223.1 | 554920    | 11-Apr-22 | 18:00 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4223.1 | 567224    | 11-Apr-22 | 18:00 | x64      |
| Dtspipeline.dll                                              | 2019.150.4223.1 | 1120184   | 11-Apr-22 | 18:00 | x86      |
| Dtspipeline.dll                                              | 2019.150.4223.1 | 1329080   | 11-Apr-22 | 18:00 | x64      |
| Dtswizard.exe                                                | 15.0.4223.1     | 886712    | 11-Apr-22 | 18:00 | x64      |
| Dtswizard.exe                                                | 15.0.4223.1     | 890808    | 11-Apr-22 | 18:00 | x86      |
| Dtuparse.dll                                                 | 2019.150.4223.1 | 100264    | 11-Apr-22 | 18:00 | x64      |
| Dtuparse.dll                                                 | 2019.150.4223.1 | 87976     | 11-Apr-22 | 18:00 | x86      |
| Dtutil.exe                                                   | 2019.150.4223.1 | 129960    | 11-Apr-22 | 18:00 | x86      |
| Dtutil.exe                                                   | 2019.150.4223.1 | 148384    | 11-Apr-22 | 18:00 | x64      |
| Exceldest.dll                                                | 2019.150.4223.1 | 280488    | 11-Apr-22 | 18:00 | x64      |
| Exceldest.dll                                                | 2019.150.4223.1 | 235432    | 11-Apr-22 | 18:00 | x86      |
| Excelsrc.dll                                                 | 2019.150.4223.1 | 260008    | 11-Apr-22 | 18:00 | x86      |
| Excelsrc.dll                                                 | 2019.150.4223.1 | 309152    | 11-Apr-22 | 18:00 | x64      |
| Flatfiledest.dll                                             | 2019.150.4223.1 | 358312    | 11-Apr-22 | 18:00 | x86      |
| Flatfiledest.dll                                             | 2019.150.4223.1 | 411576    | 11-Apr-22 | 18:00 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4223.1 | 370600    | 11-Apr-22 | 18:00 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4223.1 | 427944    | 11-Apr-22 | 18:00 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4223.1     | 116664    | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4223.1     | 403360    | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4223.1     | 403360    | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4223.1     | 3000248   | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4223.1     | 3000232   | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4223.1     | 42920     | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4223.1     | 42936     | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4223.1     | 59320     | 11-Apr-22 | 18:00 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 11-Apr-22 | 18:00 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4223.1 | 100264    | 11-Apr-22 | 18:00 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4223.1 | 112552    | 11-Apr-22 | 18:00 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.23  | 8279456   | 11-Apr-22 | 17:02 | x86      |
| Oledbdest.dll                                                | 2019.150.4223.1 | 280488    | 11-Apr-22 | 18:00 | x64      |
| Oledbdest.dll                                                | 2019.150.4223.1 | 239528    | 11-Apr-22 | 18:00 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4223.1 | 264104    | 11-Apr-22 | 18:00 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4223.1 | 313256    | 11-Apr-22 | 18:00 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4223.1 | 51128     | 11-Apr-22 | 18:00 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4223.1 | 38840     | 11-Apr-22 | 18:00 | x86      |
| Sqlscm.dll                                                   | 2019.150.4223.1 | 79784     | 11-Apr-22 | 18:00 | x86      |
| Sqlscm.dll                                                   | 2019.150.4223.1 | 87976     | 11-Apr-22 | 18:00 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4223.1 | 182176    | 11-Apr-22 | 18:00 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4223.1 | 149432    | 11-Apr-22 | 18:00 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4223.1 | 202664    | 11-Apr-22 | 18:00 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4223.1 | 169896    | 11-Apr-22 | 18:00 | x86      |
| Txdataconvert.dll                                            | 2019.150.4223.1 | 276392    | 11-Apr-22 | 18:00 | x86      |
| Txdataconvert.dll                                            | 2019.150.4223.1 | 317368    | 11-Apr-22 | 18:00 | x64      |
| Xe.dll                                                       | 2019.150.4223.1 | 632744    | 11-Apr-22 | 18:00 | x86      |
| Xe.dll                                                       | 2019.150.4223.1 | 722872    | 11-Apr-22 | 18:00 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2019.

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

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

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

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2019**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
