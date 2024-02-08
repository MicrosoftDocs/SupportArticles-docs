---
title: Cumulative update 9 for SQL Server 2019 (KB5000642)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 9 (KB5000642).
ms.date: 06/30/2023
ms.custom: KB5000642
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5000642 - Cumulative Update 9 for SQL Server 2019

_Release Date:_ &nbsp; February 11, 2021  
_Version:_ &nbsp; 15.0.4102.2

## Summary

This article describes Cumulative Update package 9 (CU9) for Microsoft SQL Server 2019. This update contains 90 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 8, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4102.2**, file version: **2019.150.4102.2**
- Analysis Services - Product version: **15.0.34.29**, file version: **2018.150.34.29**

## Known issues in this update

After changes that are related to Scalar UDF Inlining were made in CU9, a defect was introduced in which an access violation can occur when an object invokes a scalar inlineable UDF (UDF1) together with a scalar inlineable UDF (UDF2) that's used as an input parameter:

```sql
OBJECT DEFINITION(view/UDF/TVF/procedure)
…
SELECT UDF1(UDF2());
…
```

A fix will be provided in a future cumulative update. To mitigate this problem, disable Scalar UDF inlining by using either of the following options:

- Change the definition of UDF2 by adding `WITH INLINE = OFF` to the definition.

- Disable inlining on the database by using `ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = OFF`.

For examples of disabling Scalar UDF inlining, see [Disable Scalar UDF Inlining without changing the compatibility level](/sql/relational-databases/user-defined-functions/scalar-udf-inlining#disable-scalar-udf-inlining-without-changing-the-compatibility-level).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13770140">[13770140](#13770140)</a> | [FIX: Indefinite hang occurs during cube processing after applying SSAS 2016 SP2 CU7 (KB4589170)](https://support.microsoft.com/help/4589170) | Analysis Services | Analysis Services | Windows |
| <a id="13770147">[13770147](#13770147)</a> | [FIX: Unexpected error occurs when a query is run on an instance of SSAS (KB4589171)](https://support.microsoft.com/help/4589171) | Analysis Services | Analysis Services | Windows |
| <a id="13745344">[13745344](#13745344)</a> | Fixes deadlocks that occur in `[catalog].[set_execution_property_override_value]`. | Integration Services | Engine | Windows |
| <a id="13704071">[13704071](#13704071)</a> | FIX: SSIS ScaleOut Execution intermittently reports "Unexpected Termination" in the execution status but all tasks get completed successfully. | Integration Services | ScaleOut | Windows |
| <a id="13607161">[13607161](#13607161)</a> | Improves SSISDB performance by adding indexes to `event_message_context` and `execution_property_override_values` tables in SQL Server 2019. | Integration Services | Server | Windows |
| <a id="13745356">[13745356](#13745356)</a> | [FIX: Intermittent connection error occurs when an expression is used for both connection string and password of a connection manager (KB4569837)](https://support.microsoft.com/help/4569837) | Integration Services | Tasks_Components | Windows |
| <a id="13888649">[13888649](#13888649)</a> | FIX: When the master SSIS package calls multiple child packages and their connection managers are parameterized, the SSIS package execution fails with UNEXPECTED TERMINATION or INVALID CONNECTION STRING ATTRIBUTE error while updating connection strings. | Integration Services | Tasks_Components | Windows |
| <a id="13745362">[13745362](#13745362)</a> | [FIX: ISDBUpgradeWizard.exe throws error when you try to upgrade SSISDB after restoring from earlier versions in SQL Server (KB4547890)](https://support.microsoft.com/help/4547890) | Integration Services | Tools | Windows |
| <a id="13723579">[13723579](#13723579)</a> | Fixes Recursive hierarchy in **explore** page that's not working properly in MDS version 2019. | Master Data Services | Master Data Services | Windows |
| <a id="13770149">[13770149](#13770149)</a> | [FIX: SQL Server crashes when Afd!DbCreateSocketOperation process fails (KB4588977)](https://support.microsoft.com/topic/60ac7c2a-7904-4c3b-8bb7-5233cd5c9d85) | SQL Server Connectivity | Protocols | Linux |
| <a id="13757446">[13757446](#13757446)</a> | Fixes the issue of sending done token before sending the session kill state when session got killed. This fixes the issue of incorrect session state that occurs when a session is killed on SQL Server external data source instance. | SQL Server Connectivity | SQL Connectivity | Windows |
| <a id="13746925">[13746925](#13746925)</a> | When running a `RESTORE HEADERONLY` of a SQL Server 2016 backup you may notice [error 3285](/sql/relational-databases/errors-events/database-engine-events-and-errors-3000-to-3999) even if the correct block size has been specified. If the error persists after applying this fix, specify the proper block size or contact Microsoft Support for assistance. | SQL Server Engine | Backup Restore | Windows |
| <a id="13746927">[13746927](#13746927)</a> | FIX: When you try to restore from a compressed or encrypted backup over an existing TDE enabled database, you may notice that the restore operation may take longer time than expected. | SQL Server Engine | Backup Restore | Windows |
| <a id="13768244">[13768244](#13768244)</a> | Fixes an error where you may receive the following error when you restore a TDE enabled database from a backup with compression option and "`WITH FILE =`" option is greater than `1`: </br></br>Msg 3241, Level 16, State 40, Line \<LineNumber> </br>The media family on device '\<FilePath>\\\<FileName>' is incorrectly formed. SQL Server cannot process this media family. | SQL Server Engine | Backup Restore | Windows |
| <a id="13819319">[13819319](#13819319)</a> | Fixes an issue where a database restore fails with an error 3257 (insufficient free space error) when the database is larger than 2 TB. The issue happens when the `TotalAllocationUnits` on the target volume is more than 4,294,967,295 units, for example when the target volume is larger than 16 TB and uses an allocation unit size = 512 bytes and a single sector per cluster. | SQL Server Engine | Backup Restore | Windows |
| <a id="13807755">[13807755](#13807755)</a> | [Improvement: New trace Flags for better maintenance of deleted rows in Clustered Columnstore Index (KB5000895)](https://support.microsoft.com/help/5000895) | SQL Server Engine | Column Stores | Windows |
| <a id="13770156">[13770156](#13770156)</a> | [FIX: Higher than expected number of single row Columnstore rowgroups may be generated for Columnstore bulk insert when both large page allocator and scalable Columnstore bulk insert features are turned on (KB4588980)](https://support.microsoft.com/help/4588980) | SQL Server Engine | Column Stores | All |
| <a id="13746938">[13746938](#13746938)</a> | FIX: `VERIFY_CLONEDB` prints message 'Clone database verification has failed' for the database if the database name starts with a number. | SQL Server Engine | DB Management | Windows |
| <a id="13887793">[13887793](#13887793)</a> | Updates the Zulu JRE version to `mssql-zulu-jre-11.43.56-1` and `mssql-zulu-jre-8-8.50.0.52-1`. | SQL Server Engine | Extensibility | Linux |
| <a id="13887794">[13887794](#13887794)</a> | Updates the Zulu JRE version to `mssql-zulu-jre-11.43.56`. | SQL Server Engine | Extensibility | Windows |
| <a id="13607162">[13607162](#13607162)</a> | [Improvement: A manual method to set maximum group commit time in SQL Server 2017 and 2019 (KB4565944)](https://support.microsoft.com/help/4565944) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13717020">[13717020](#13717020)</a> | [FIX: Access Violation exception occurs in Availability Groups in SQL Server 2017 under certain conditions (KB4577932)](https://support.microsoft.com/help/4577932) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13745332">[13745332](#13745332)</a> | [FIX: Automatic seeding failure occurs for a secondary replica in SQL Server 2016 and 2019 (KB4568447)](https://support.microsoft.com/help/4568447) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13770154">[13770154](#13770154)</a> | [FIX: Fail to create AG on top of FCI in SQL Server 2019 (KB4588979)](https://support.microsoft.com/help/4588979) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="13770157">[13770157](#13770157)</a> | [FIX: "LogConsumer::StartScan failed to get the control lock" error occurs and the log writer activity stops completely in SQL Server 2019 (KB4588981)](https://support.microsoft.com/help/4588981) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13651126">[13651126](#13651126)</a> | Fixes an issue where selecting from `sys.databases` when there are a large number of databases in SQL Server 2019 take longer time to execute when compared to earlier versions of SQL Server. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13746921">[13746921](#13746921)</a> | Unable to connect to primary database replica after failing over the Availability Group in SQL Server. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13760269">[13760269](#13760269)</a> | Forwarder is unable to reconnect to global primary following Global primary planned failover if the `LISTENER_URL` is modified. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13878941">[13878941](#13878941)</a> | Fixes an issue where SQL process isn't killed properly resulting in subsequent start of SQL Server fails when the AG-Helper sends the `KILL 9` command to terminate the SQL Server process. | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="13916584">[13916584](#13916584)</a> | FIX: Assertion or `RaiseInconsistencyError` occurs when you use `VersionStoreTableAccess::PopulateRowData` on SQL 2019 Always On Availability Group Readable replica, but actually there's no corruption. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13717040">[13717040](#13717040)</a> | [FIX: Incorrect results occur when you run INSERT INTO SELECT statement on memory-optimized table variables in SQL Server (KB4580397)](https://support.microsoft.com/help/4580397) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13828883">[13828883](#13828883)</a> | Fixes an error that occurs when you execute a query by using `sp_send_dbmail` inside a SQL Agent Job to send mails with attachments. | SQL Server Engine | Linux | Linux |
| <a id="13865722">[13865722](#13865722)</a> | Fixes infinite loop in VDI due to improper initialization of `errno` variable. | SQL Server Engine | Linux | Linux |
| <a id="13651862">[13651862](#13651862)</a> | [FIX: Database mail doesn't send e-mail messages when IP address is specified in mssql-conf (KB5000663)](https://support.microsoft.com/help/5000663) | SQL Server Engine | Management Services | Linux |
| <a id="13813500">[13813500](#13813500)</a> | FIX: SQL Agent job fails with a sharing violation when writing to step output file in SQL 2019. | SQL Server Engine | Management Services | Windows |
| <a id="13770057">[13770057](#13770057)</a> | Fixes an issue where an online index operation using `WHEN_SUPPORTED` will fail on LOBs if in a transaction that has already done an update. | SQL Server Engine | Metadata | All |
| <a id="13773237">[13773237](#13773237)</a> | Fixes an issue where stack dumps may be generated frequently due to failed assertions and access violations when you enable Memory-Optimized tempdb Metadata (HkTempdb). | SQL Server Engine | Metadata | Windows |
| <a id="13949618">[13949618](#13949618)</a> | [FIX: Assertion failure error occurs on sqlmin.dll!XdesRMBase::StartStmtSnapshot in SQL Server 2019 (KB4594016)](https://support.microsoft.com/help/4594016) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13756064">[13756064](#13756064)</a> | [Improvement: Adds a new external generic query builder in SQL Server 2019 (KB5000669)](https://support.microsoft.com/help/5000669) | SQL Server Engine | PolyBase | Linux |
| <a id="13770152">[13770152](#13770152)</a> | [FIX: Statistics are ignored when a query is run on PolyBase external table in SQL Server 2019 (KB4588978)](https://support.microsoft.com/help/4588978) | SQL Server Engine | PolyBase | Windows |
| <a id="13770159">[13770159](#13770159)</a> | [FIX: CREATE STATISTICS WITH SAMPLE PERCENT command fails with error when Oracle data source has partitioned table (KB4588983)](https://support.microsoft.com/help/4588983) | SQL Server Engine | PolyBase | All |
| <a id="13909240">[13909240](#13909240)</a> | [FIX: Error occurs when you map an Oracle NUMBER type to a T-SQL DECIMAL/NUMERIC type (KB5000670)](https://support.microsoft.com/help/5000670) | SQL Server Engine | PolyBase | All |
| <a id="13909360">[13909360](#13909360)</a> | [FIX: Error occurs when casting non-Unicode string column using a Unicode-only UTF8 collation in SQL Server 2019 (KB5000671)](https://support.microsoft.com/help/5000671) | SQL Server Engine | PolyBase | All |
| <a id="13909404">[13909404](#13909404)</a> | [FIX: Fixes reading of NULL Time fields for non-sqlserver backends (KB5000672)](https://support.microsoft.com/help/5000672) | SQL Server Engine | PolyBase | All |
| <a id="13737330">[13737330](#13737330)</a> | Enables async path for PolyBase remote query and add cleanups for timeout/abort in SQL Server 2019. | SQL Server Engine | PolyBase | All |
| <a id="13737331">[13737331](#13737331)</a> | Fixes the query hang issue that occurs in SQL Server 2019 when querying an external table through PDW. | SQL Server Engine | PolyBase | All |
| <a id="13738992">[13738992](#13738992)</a> | Adds a randomization logic when mapping writers to pods in SQL Server 2019. | SQL Server Engine | PolyBase | All |
| <a id="13752408">[13752408](#13752408)</a> | This fix makes sure that when the "`EXECUTE ('sql query') AT DATA_SOURCE [mydatasource]`" query is executed, the [connection options](/sql/t-sql/statements/create-external-data-source-transact-sql#syntax) of `[mydatasource]` will be used when connecting to that data source. | SQL Server Engine | PolyBase | All |
| <a id="13752425">[13752425](#13752425)</a> | Fixes an issue with PolyBase SQL dump hash computation that uses MD5 which isn't FIPS compliant. | SQL Server Engine | PolyBase | All |
| <a id="13752426">[13752426](#13752426)</a> | Fixes an issue where PolyBase fails when it's deployed on a platform (Windows or Linux) and the control node hostname resolves to an IPv6. | SQL Server Engine | PolyBase | All |
| <a id="13878949">[13878949](#13878949)</a> | Fixes an issue where the PolyBase query against the backend may result in a dump of the PolyBase engine process when you try to resolve partitioning information and the connection to an external database backend is unreliable or interrupted. | SQL Server Engine | PolyBase | All |
| <a id="13880787">[13880787](#13880787)</a> | Fixes an issue where a message occurs in the error log and the Application event log: </br></br>Error: 46906, Severity: 16, State: 1. </br>Unable to retrieve registry value 'NodeRole' from Windows registry key 'Software\Microsoft\Microsoft SQL Server\MSSQL\Polybase\Configuration': (null) | SQL Server Engine | PolyBase | All |
| <a id="13880798">[13880798](#13880798)</a> | When you use `EXECUTE` with `AT DATA_SOURCE` in SQL Server 2019, the query gets truncated at 8000 byte length and may cause errors or wrong results. | SQL Server Engine | PolyBase | All |
| <a id="13770158">[13770158](#13770158)</a> | [FIX: sys.dm_exec_requests returns transaction_id as "0" in certain scenarios in SQL Server 2019 (KB4588982)](https://support.microsoft.com/help/4588982) | SQL Server Engine | Programmability | Windows |
| <a id="13904898">[13904898](#13904898)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="13668231">[13668231](#13668231)</a> | Fixes an Access violation error that occurs whenever '`sp_refreshsqlmodule`' function is executed quickly several times in a row causing a stack dump to be generated. | SQL Server Engine | Programmability | Windows |
| <a id="13771532">[13771532](#13771532)</a> | Fixes an access violation dump that occurs after you run a query by using `OUTER APPLY` on `sys.dm_db_index_operational_stats`. | SQL Server Engine | Programmability | Windows |
| <a id="13724507">[13724507](#13724507)</a> | [FIX: Wrong results due to undetected concatenation parameters from scalar expression (KB5000649)](https://support.microsoft.com/help/5000649) | SQL Server Engine | Query Execution | All |
| <a id="13777701">[13777701](#13777701)</a> | [FIX: Error 3625 occurs during query execution when batch mode on rowstore is enabled in SQL Server 2019 (KB4589345)](https://support.microsoft.com/help/4589345) | SQL Server Engine | Query Execution | Windows |
| <a id="13891302">[13891302](#13891302)</a> | [FIX: MERGE statement fails with Access Violation at BTreeRow::DisableAccessReleaseOnWait in SQL Server (KB4589350)](https://support.microsoft.com/help/4589350) | SQL Server Engine | Query Execution | Windows |
| <a id="13718092">[13718092](#13718092)</a> | Fixes Graph `LAST_NODE = LAST_NODE` predicate issue by including a second pass for `LAST_NODE` expressions and to include an appropriate predicate in the query tree. | SQL Server Engine | Query Execution | All |
| <a id="13718123">[13718123](#13718123)</a> | Fixes an access violation that occurs when Showplan XML Xevent is enabled, and an in-memory procedure containing a '`SELECT` without `FROM` clause' is executed. | SQL Server Engine | Query Execution | All |
| <a id="13717021">[13717021](#13717021)</a> | [FIX: Incorrect results can occur when you run linked server query with aggregates or joins on table with filtered index on a remote server in SQL Server (KB4575689)](https://support.microsoft.com/help/4575689) | SQL Server Engine | Query Optimizer | Windows |
| <a id="13717028">[13717028](#13717028)</a> | [FIX: COMPILE blocking occurs when executing many concurrent stored procedures in SQL Server 2017 and 2019 (KB4577976)](https://support.microsoft.com/help/4577976) | SQL Server Engine | Query Optimizer | Windows |
| <a id="13717029">[13717029](#13717029)</a> | [FIX: Cascade delete on key values outside of leading table histogram bounds causes index scan in SQL Server 2017 and 2019 (KB4577933)](https://support.microsoft.com/help/4577933) | SQL Server Engine | Query Optimizer | Windows |
| <a id="13647678">[13647678](#13647678)</a> | FIX: Query returns different result set when run on In-memory optimized tables and disk-based tables in SQL Server 2019. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13722862">[13722862](#13722862)</a> | Fixes the Assertion failure that occurs when group properties for `CLeafOp` children are derived. | SQL Server Engine | Query Optimizer | All |
| <a id="13745342">[13745342](#13745342)</a> | Fixes an access violation exception that occurs while querying `sys.dm_db_stats_properties` for a table with a spatial index in SQL Server 2019. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13746944">[13746944](#13746944)</a> | Fixes Non-yielding Scheduler error that may occur when Query Store tries to grow its memory structure during heavy workload. | SQL Server Engine | Query Store | Windows |
| <a id="13749461">[13749461](#13749461)</a> | Fixes Query Store scalability improvement for ad-hoc workloads. Query Store now imposes internal limits to the amount of memory it can use, and automatically changes the operation mode to read-only until enough memory has been returned to the Database Engine, preventing performance issues. | SQL Server Engine | Query Store | All |
| <a id="13745336">[13745336](#13745336)</a> | [FIX: Log reader agent generates access violation exception for P2P or transactional replication with partitioning tables in SQL Server 2016 and 2019 (KB4575939)](https://support.microsoft.com/help/4575939) | SQL Server Engine | Replication | Windows |
| <a id="13745358">[13745358](#13745358)</a> | [FIX: Newly added articles' snapshot doesn't get applied to subscriber in SQL Server 2016 and 2019 (KB4575940)](https://support.microsoft.com/help/4575940) | SQL Server Engine | Replication | Windows |
| <a id="13717026">[13717026](#13717026)</a> | Fixes Monitor and Sync replication agent job error that occurs when a job runs on the new secondary replica after failover of the Availability Group that hosts the distribution database for transactional replication. </br></br>Unable to post notification to SQLServerAgent </br>(reason: The maximum number of pending SQLServerAgent notifications has been exceeded. The notification will be ignored.) </br>[SQLSTATE 42000] (Error 22022). The step failed | SQL Server Engine | Replication | Windows |
| <a id="13759515">[13759515](#13759515)</a> | Fixes an error that occurs when a change tracking function is called in MSTVF. </br></br>Msg 443, Level 16, State 1, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>Invalid use of a side-effecting operator 'change_tracking_current_version' within a function. | SQL Server Engine | Replication | Windows |
| <a id="13769810">[13769810](#13769810)</a> | When the full-text service fdhost is attempting to index a column with the content of type *.eml* using the filter *c:\windows\system32\mimefilt.dll* version 2008.0.19041.1, the *fdhost.exe* process stops with 0xc0000409 `STATUS_STACK_BUFFER_OVERRUN`. | SQL Server Engine | Search | Windows |
| <a id="13909232">[13909232](#13909232)</a> | [FIX: Memory leak may occur when SQL Server auditing feature is used on an instance of SQL Server 2019 (KB5000655)](https://support.microsoft.com/help/5000655) | SQL Server Engine | Security Infrastructure | All |
| <a id="13909239">[13909239](#13909239)</a> | [FIX: Incorrect type of data mask is applied when DDM is used with queries that have UDFs in SQL Server 2019 (KB5000656)](https://support.microsoft.com/help/5000656) | SQL Server Engine | Security Infrastructure | All |
| <a id="13771348">[13771348](#13771348)</a> | Fixes an issue where deployment is stuck in '`WaitingForControlPlaneFilesDownload`' state with `ObjectDisposedException` in controller. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13770160">[13770160](#13770160)</a> | [FIX: Contention on XVB_List spinlock in highly concurrent workloads when using RCSI (KB4588984)](https://support.microsoft.com/help/4588984) | SQL Server Engine | SQL OS | Windows |
| <a id="13817504">[13817504](#13817504)</a> | [FIX: Severe spinlock contention occurs in SQL Server 2019 (KB4538688)](https://support.microsoft.com/help/4538688) | SQL Server Engine | SQL OS | Windows |
| <a id="13599202">[13599202](#13599202)</a> | Fixes the non-yielding scheduler condition that occurs when AG listener is created with invalid IP address in SQL Server 2019 on Linux. | SQL Server Engine | SQL OS | Linux |
| <a id="13744390">[13744390](#13744390)</a> | New logging and XEvents to help troubleshoot long-running [Buffer Pool scans](../../database-engine/performance/buffer-pool-scan-runs-slowly-large-memory-machines.md). | SQL Server Engine | SQL OS | All |
| <a id="13882987">[13882987](#13882987)</a> | Adds improvement to increase the default size and file retention on `AlwaysOn_health`. </br></br>**Note**: The current definition for the `AlwaysOn_health` XEvent session has a maximum file size of 5 megabytes (MB) and maximum number of files of 4, for a maximum of 20 MB of `AlwaysOn_health` XEvent data. On a busy system, you can roll over this limitation quickly and miss important information in the event of an issue that affects the system. In order to keep more troubleshooting data available on the system, the default file size is changed from 5 MB to 100 MB and the default number of files is changed from 4 to 10, for a maximum of 1 GB of `AlwaysOn_health` XEvent data, in this update. If the definition of the `AlwaysOn_health` session has already been modified from the default values, this improvement won't overwrite the existing settings. | SQL Server Engine | SQL OS | All |
| <a id="13746919">[13746919](#13746919)</a> | Fixes an issue where the session gets killed when you run `DBCC CHECKTABLE` with `PHYSICAL_ONLY` due to disk full. The session remains in `KILLED`\\`ROLLBACK` state and threads are waiting on `CHECK_TABLES_THREAD_BARRIER` wait type with increasing wait time. | SQL Server Engine | Storage Management | Windows |
| <a id="13717030">[13717030](#13717030)</a> | `DBCC SHRINKFLE` or `SHRINKDATABASE` can cause an assertion exception error when executed against database or files containing system-versioned temporal tables. | SQL Server Engine | Temporal | Windows |
| <a id="13784190">[13784190](#13784190)</a> | [FIX: User session is in rollback state indefinitely after it is killed in SQL Server 2016 (KB4585971)](https://support.microsoft.com/help/4585971) | SQL Server Engine | Transaction Services | Windows |
| <a id="13746942">[13746942](#13746942)</a> | Fixes SQL Server Assertion that occurs when the availability group is failed over manually to another replica. The failover succeeds however, the databases from the earlier primary (now the secondary) where the AG was failed from, doesn't come online and generates the assertion dumps. </br></br>File: \<FilePath\FileName>, line=\<LineNumber> Failed Assertion = 'inCorrectOrder' | SQL Server Engine | Transaction Services | Windows |
| <a id="13891577">[13891577](#13891577)</a> | Adds a new option to free the `LogPool` cache only: `DBCC FREESYSTEMCACHE('LogPool')`. | SQL Server Engine | Transaction Services | Windows |
| <a id="13955875">[13955875](#13955875)</a> | Fixes the assertion failure that occurs at `FAILED_ASSERTION_42ac_sqlmin.dll!LogLockCollectionVerify::Callback` in SQL Server 2019. | SQL Server Engine | Transaction Services | Windows |
| <a id="13866862">[13866862](#13866862)</a> | Fixes an issue where an access violation exception may occur when you execute queries in read uncommitted mode with high concurrent read or write pattern over XML data types. | SQL Server Engine | XML | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU9 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/02/sqlserver2019-kb5000642-x64_7146ecc67a3b7bc33f743ebb2c19cb6a18857f00.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5000642-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5000642-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5000642-x64.exe| EA4E1543FAFBAA811E4260EF506E62F966FEF1838031EF645A7FD1FD609620A2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.29  | 291736    | 25-Jan-21 | 20:59 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181   | 140664    | 25-Jan-21 | 20:59 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.29      | 757144    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 174472    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 198552    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 201112    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 197528    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 213912    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 196504    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 192408    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 251272    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 172936    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.29      | 195992    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.29      | 1097112   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.29      | 479624    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 53640     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 58264     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 58776     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57752     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 60824     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 66448     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 52624     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.29      | 57240     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16776     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 17816     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16784     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.29      | 16792     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660856    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181   | 180600    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181   | 30072     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181   | 74616     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181   | 102264    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 28536     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 45944     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 29048     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454456   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920680    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25464     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25976     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37752     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 23928     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25464     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 28536     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181   | 5242744   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181   | 19832     | 25-Jan-21 | 20:59 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181   | 19832     | 25-Jan-21 | 20:59 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181   | 19832     | 25-Jan-21 | 20:59 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181   | 149368    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181   | 82296     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15432     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15736     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181   | 190840    | 25-Jan-21 | 20:59 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181   | 59768     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181   | 26488     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140152    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181   | 14094200  | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 541560    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 652152    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 643960    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 627576    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 676728    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 635768    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 615288    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 848760    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 533368    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 623480    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778616    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15      | 1100152   | 25-Jan-21 | 20:59 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126328    | 25-Jan-21 | 20:59 | x86      |
| Msmdctr.dll                                               | 2018.150.34.29  | 37256     | 25-Jan-21 | 20:59 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.29  | 47781264  | 25-Jan-21 | 20:59 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.29  | 66288016  | 25-Jan-21 | 20:59 | x64      |
| Msmdpump.dll                                              | 2018.150.34.29  | 10187672  | 25-Jan-21 | 20:59 | x64      |
| Msmdredir.dll                                             | 2018.150.34.29  | 7955848   | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15760     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 16280     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 17304     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15760     | 25-Jan-21 | 20:59 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.29      | 15768     | 25-Jan-21 | 20:59 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.29  | 65824136  | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 832408    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1627032   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1452944   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1641880   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1607576   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1000344   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 991640    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1535888   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1520536   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 809880    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.29  | 1595272   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 831384    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1623448   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1449864   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1636744   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1603480   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 997784    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 990088    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1531792   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1516952   | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 808856    | 25-Jan-21 | 20:59 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.29  | 1590664   | 25-Jan-21 | 20:59 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.29  | 10185112  | 25-Jan-21 | 20:59 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.29  | 8277912   | 25-Jan-21 | 20:59 | x86      |
| Msolap.dll                                                | 2018.150.34.29  | 11014552  | 25-Jan-21 | 20:59 | x64      |
| Msolap.dll                                                | 2018.150.34.29  | 8607128   | 25-Jan-21 | 20:59 | x86      |
| Msolui.dll                                                | 2018.150.34.29  | 285080    | 25-Jan-21 | 20:59 | x86      |
| Msolui.dll                                                | 2018.150.34.29  | 305560    | 25-Jan-21 | 20:59 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181   | 9252728   | 25-Jan-21 | 20:59 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728440    | 25-Jan-21 | 20:59 | x64      |
| Sqlboot.dll                                               | 2019.150.4102.2 | 213904    | 25-Jan-21 | 20:59 | x64      |
| Sqlceip.exe                                               | 15.0.4102.2     | 283536    | 25-Jan-21 | 20:59 | x86      |
| Sqldumper.exe                                             | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:59 | x86      |
| Sqldumper.exe                                             | 2019.150.4102.2 | 185232    | 25-Jan-21 | 20:59 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117624    | 25-Jan-21 | 20:59 | x86      |
| Tmapi.dll                                                 | 2018.150.34.29  | 6177168   | 25-Jan-21 | 20:59 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.29  | 4916632   | 25-Jan-21 | 20:59 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.29  | 1183640   | 25-Jan-21 | 20:59 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.29  | 6802328   | 25-Jan-21 | 20:59 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.29  | 26024344  | 25-Jan-21 | 20:59 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.29  | 35459480  | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:25 | x64      |
| Instapi150.dll                       | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4102.2 | 99216     | 25-Jan-21 | 20:59 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x86      |
| Msasxpress.dll                       | 2018.150.34.29  | 31128     | 25-Jan-21 | 20:59 | x64      |
| Msasxpress.dll                       | 2018.150.34.29  | 26008     | 25-Jan-21 | 20:59 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x64      |
| Sqldumper.exe                        | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:59 | x86      |
| Sqldumper.exe                        | 2019.150.4102.2 | 185232    | 25-Jan-21 | 20:59 | x64      |
| Sqlftacct.dll                        | 2019.150.4102.2 | 58256     | 25-Jan-21 | 20:59 | x86      |
| Sqlftacct.dll                        | 2019.150.4102.2 | 78736     | 25-Jan-21 | 20:59 | x64      |
| Sqlmanager.dll                       | 2019.150.4102.2 | 742288    | 25-Jan-21 | 20:59 | x86      |
| Sqlmanager.dll                       | 2019.150.4102.2 | 877456    | 25-Jan-21 | 20:59 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4102.2 | 377744    | 25-Jan-21 | 20:59 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4102.2 | 430992    | 25-Jan-21 | 20:59 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4102.2 | 275344    | 25-Jan-21 | 20:59 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4102.2 | 357264    | 25-Jan-21 | 20:59 | x64      |
| Svrenumapi150.dll                    | 2019.150.4102.2 | 1160080   | 25-Jan-21 | 20:59 | x64      |
| Svrenumapi150.dll                    | 2019.150.4102.2 | 910224    | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4102.2 | 136080    | 25-Jan-21 | 20:59 | x86      |
| Dreplaycommon.dll     | 2019.150.4102.2 | 665488    | 25-Jan-21 | 20:59 | x86      |
| Dreplayutil.dll       | 2019.150.4102.2 | 304016    | 25-Jan-21 | 20:59 | x86      |
| Instapi150.dll        | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x64      |
| Sqlresourceloader.dll | 2019.150.4102.2 | 37776     | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4102.2 | 665488    | 25-Jan-21 | 20:59 | x86      |
| Dreplaycontroller.exe | 2019.150.4102.2 | 365456    | 25-Jan-21 | 20:59 | x86      |
| Instapi150.dll        | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x64      |
| Sqlresourceloader.dll | 2019.150.4102.2 | 37776     | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4102.2 | 4652944   | 25-Jan-21 | 21:55 | x64      |
| Aetm-enclave.dll                           | 2019.150.4102.2 | 4604264   | 25-Jan-21 | 21:55 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4102.2 | 4924656   | 25-Jan-21 | 21:55 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4102.2 | 4866256   | 25-Jan-21 | 21:55 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 25-Jan-21 | 21:53 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 25-Jan-21 | 21:53 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 25-Jan-21 | 21:55 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 25-Jan-21 | 21:55 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 25-Jan-21 | 21:55 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 25-Jan-21 | 21:55 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4102.2 | 279440    | 25-Jan-21 | 21:55 | x64      |
| Dcexec.exe                                 | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:55 | x64      |
| Fssres.dll                                 | 2019.150.4102.2 | 95120     | 25-Jan-21 | 21:55 | x64      |
| Hadrres.dll                                | 2019.150.4102.2 | 201616    | 25-Jan-21 | 21:55 | x64      |
| Hkcompile.dll                              | 2019.150.4102.2 | 1291152   | 25-Jan-21 | 21:55 | x64      |
| Hkengine.dll                               | 2019.150.4102.2 | 5784464   | 25-Jan-21 | 21:55 | x64      |
| Hkruntime.dll                              | 2019.150.4102.2 | 181136    | 25-Jan-21 | 21:55 | x64      |
| Hktempdb.dll                               | 2019.150.4102.2 | 62352     | 25-Jan-21 | 21:55 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 25-Jan-21 | 21:55 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4102.2     | 234384    | 25-Jan-21 | 21:55 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4102.2 | 324496    | 25-Jan-21 | 21:55 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4102.2 | 91024     | 25-Jan-21 | 21:55 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 25-Jan-21 | 21:55 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 25-Jan-21 | 21:55 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 25-Jan-21 | 21:55 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 25-Jan-21 | 21:55 | x64      |
| Qds.dll                                    | 2019.150.4102.2 | 1184656   | 25-Jan-21 | 21:55 | x64      |
| Rsfxft.dll                                 | 2019.150.4102.2 | 50064     | 25-Jan-21 | 21:55 | x64      |
| Secforwarder.dll                           | 2019.150.4102.2 | 78736     | 25-Jan-21 | 21:55 | x64      |
| Sqagtres.dll                               | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:55 | x64      |
| Sqlaamss.dll                               | 2019.150.4102.2 | 107408    | 25-Jan-21 | 21:55 | x64      |
| Sqlaccess.dll                              | 2019.150.4102.2 | 492432    | 25-Jan-21 | 21:55 | x64      |
| Sqlagent.exe                               | 2019.150.4102.2 | 730000    | 25-Jan-21 | 21:55 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4102.2 | 78736     | 25-Jan-21 | 21:55 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4102.2 | 66448     | 25-Jan-21 | 21:55 | x86      |
| Sqlboot.dll                                | 2019.150.4102.2 | 213904    | 25-Jan-21 | 21:53 | x64      |
| Sqlceip.exe                                | 15.0.4102.2     | 283536    | 25-Jan-21 | 21:55 | x86      |
| Sqlcmdss.dll                               | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:55 | x64      |
| Sqlctr150.dll                              | 2019.150.4102.2 | 140176    | 25-Jan-21 | 21:55 | x64      |
| Sqlctr150.dll                              | 2019.150.4102.2 | 115600    | 25-Jan-21 | 21:55 | x86      |
| Sqldk.dll                                  | 2019.150.4102.2 | 3146640   | 25-Jan-21 | 21:55 | x64      |
| Sqldtsss.dll                               | 2019.150.4102.2 | 107408    | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 1590160   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3490704   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3687312   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4150160   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4268944   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3404688   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3568528   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4146064   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3998608   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4051856   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 2216848   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 2163600   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3859344   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3535760   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4002704   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3810192   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3806096   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3601296   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3490704   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 1532816   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 3896208   | 25-Jan-21 | 21:55 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4102.2 | 4014992   | 25-Jan-21 | 21:55 | x64      |
| Sqllang.dll                                | 2019.150.4102.2 | 39719824  | 25-Jan-21 | 21:55 | x64      |
| Sqlmin.dll                                 | 2019.150.4102.2 | 40343440  | 25-Jan-21 | 21:55 | x64      |
| Sqlolapss.dll                              | 2019.150.4102.2 | 103312    | 25-Jan-21 | 21:55 | x64      |
| Sqlos.dll                                  | 2019.150.4102.2 | 41872     | 25-Jan-21 | 21:55 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4102.2 | 82832     | 25-Jan-21 | 21:55 | x64      |
| Sqlrepss.dll                               | 2019.150.4102.2 | 82832     | 25-Jan-21 | 21:55 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4102.2 | 50064     | 25-Jan-21 | 21:55 | x64      |
| Sqlscm.dll                                 | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:55 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4102.2 | 37776     | 25-Jan-21 | 21:55 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4102.2 | 5804944   | 25-Jan-21 | 21:55 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4102.2 | 672656    | 25-Jan-21 | 21:55 | x64      |
| Sqlservr.exe                               | 2019.150.4102.2 | 627600    | 25-Jan-21 | 21:55 | x64      |
| Sqlsvc.dll                                 | 2019.150.4102.2 | 181136    | 25-Jan-21 | 21:55 | x64      |
| Sqltses.dll                                | 2019.150.4102.2 | 9077648   | 25-Jan-21 | 21:55 | x64      |
| Sqsrvres.dll                               | 2019.150.4102.2 | 279440    | 25-Jan-21 | 21:55 | x64      |
| Svl.dll                                    | 2019.150.4102.2 | 160656    | 25-Jan-21 | 21:55 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 25-Jan-21 | 21:55 | x64      |
| Xe.dll                                     | 2019.150.4102.2 | 721808    | 25-Jan-21 | 21:55 | x64      |
| Xpadsi.exe                                 | 2019.150.4102.2 | 115600    | 25-Jan-21 | 21:55 | x64      |
| Xplog70.dll                                | 2019.150.4102.2 | 91024     | 25-Jan-21 | 21:55 | x64      |
| Xprepl.dll                                 | 2019.150.4102.2 | 119696    | 25-Jan-21 | 21:55 | x64      |
| Xpstar.dll                                 | 2019.150.4102.2 | 471952    | 25-Jan-21 | 21:55 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4102.2 | 263056    | 25-Jan-21 | 20:59 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4102.2 | 230288    | 25-Jan-21 | 20:59 | x64      |
| Distrib.exe                                                  | 2019.150.4102.2 | 234384    | 25-Jan-21 | 20:59 | x64      |
| Dteparse.dll                                                 | 2019.150.4102.2 | 123792    | 25-Jan-21 | 20:59 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4102.2 | 131984    | 25-Jan-21 | 20:59 | x64      |
| Dtepkg.dll                                                   | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:59 | x64      |
| Dtexec.exe                                                   | 2019.150.4102.2 | 71568     | 25-Jan-21 | 20:59 | x64      |
| Dts.dll                                                      | 2019.150.4102.2 | 3142544   | 25-Jan-21 | 20:59 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4102.2 | 500624    | 25-Jan-21 | 20:59 | x64      |
| Dtsconn.dll                                                  | 2019.150.4102.2 | 521104    | 25-Jan-21 | 20:59 | x64      |
| Dtshost.exe                                                  | 2019.150.4102.2 | 104336    | 25-Jan-21 | 20:59 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4102.2 | 566160    | 25-Jan-21 | 20:59 | x64      |
| Dtspipeline.dll                                              | 2019.150.4102.2 | 1328016   | 25-Jan-21 | 20:59 | x64      |
| Dtswizard.exe                                                | 15.0.4102.2     | 885648    | 25-Jan-21 | 20:59 | x64      |
| Dtuparse.dll                                                 | 2019.150.4102.2 | 99216     | 25-Jan-21 | 20:59 | x64      |
| Dtutil.exe                                                   | 2019.150.4102.2 | 147344    | 25-Jan-21 | 20:59 | x64      |
| Exceldest.dll                                                | 2019.150.4102.2 | 279440    | 25-Jan-21 | 20:59 | x64      |
| Excelsrc.dll                                                 | 2019.150.4102.2 | 308112    | 25-Jan-21 | 20:59 | x64      |
| Execpackagetask.dll                                          | 2019.150.4102.2 | 185232    | 25-Jan-21 | 20:59 | x64      |
| Flatfiledest.dll                                             | 2019.150.4102.2 | 410512    | 25-Jan-21 | 20:59 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4102.2 | 426896    | 25-Jan-21 | 20:59 | x64      |
| Logread.exe                                                  | 2019.150.4102.2 | 717712    | 25-Jan-21 | 20:59 | x64      |
| Mergetxt.dll                                                 | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4102.2     | 58256     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4102.2     | 41872     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4102.2     | 390032    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.xmltask.dll                              | 15.0.4102.2     | 156560    | 25-Jan-21 | 20:59 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4102.2 | 111504    | 25-Jan-21 | 20:59 | x64      |
| Msgprox.dll                                                  | 2019.150.4102.2 | 299920    | 25-Jan-21 | 20:59 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 25-Jan-21 | 20:59 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4102.2 | 1495952   | 25-Jan-21 | 20:59 | x64      |
| Oledbdest.dll                                                | 2019.150.4102.2 | 279440    | 25-Jan-21 | 20:59 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4102.2 | 312208    | 25-Jan-21 | 20:59 | x64      |
| Osql.exe                                                     | 2019.150.4102.2 | 91024     | 25-Jan-21 | 20:59 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4102.2 | 496528    | 25-Jan-21 | 20:59 | x64      |
| Rawdest.dll                                                  | 2019.150.4102.2 | 226192    | 25-Jan-21 | 20:59 | x64      |
| Rawsource.dll                                                | 2019.150.4102.2 | 209808    | 25-Jan-21 | 20:59 | x64      |
| Rdistcom.dll                                                 | 2019.150.4102.2 | 914320    | 25-Jan-21 | 20:59 | x64      |
| Recordsetdest.dll                                            | 2019.150.4102.2 | 201616    | 25-Jan-21 | 20:59 | x64      |
| Repldp.dll                                                   | 2019.150.4102.2 | 312208    | 25-Jan-21 | 20:59 | x64      |
| Replerrx.dll                                                 | 2019.150.4102.2 | 181136    | 25-Jan-21 | 20:59 | x64      |
| Replisapi.dll                                                | 2019.150.4102.2 | 394128    | 25-Jan-21 | 20:59 | x64      |
| Replmerg.exe                                                 | 2019.150.4102.2 | 562064    | 25-Jan-21 | 20:59 | x64      |
| Replprov.dll                                                 | 2019.150.4102.2 | 852880    | 25-Jan-21 | 20:59 | x64      |
| Replrec.dll                                                  | 2019.150.4102.2 | 1029008   | 25-Jan-21 | 20:59 | x64      |
| Replsub.dll                                                  | 2019.150.4102.2 | 471952    | 25-Jan-21 | 20:59 | x64      |
| Replsync.dll                                                 | 2019.150.4102.2 | 164752    | 25-Jan-21 | 20:59 | x64      |
| Spresolv.dll                                                 | 2019.150.4102.2 | 275344    | 25-Jan-21 | 20:59 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4102.2 | 263056    | 25-Jan-21 | 20:59 | x64      |
| Sqldiag.exe                                                  | 2019.150.4102.2 | 1139600   | 25-Jan-21 | 20:59 | x64      |
| Sqldistx.dll                                                 | 2019.150.4102.2 | 246672    | 25-Jan-21 | 20:59 | x64      |
| Sqllogship.exe                                               | 15.0.4102.2     | 103312    | 25-Jan-21 | 20:59 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4102.2 | 398224    | 25-Jan-21 | 20:59 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4102.2 | 50064     | 25-Jan-21 | 20:59 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4102.2 | 37776     | 25-Jan-21 | 20:59 | x86      |
| Sqlscm.dll                                                   | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x64      |
| Sqlscm.dll                                                   | 2019.150.4102.2 | 78736     | 25-Jan-21 | 20:59 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4102.2 | 181136    | 25-Jan-21 | 20:59 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4102.2 | 148368    | 25-Jan-21 | 20:59 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4102.2 | 205712    | 25-Jan-21 | 20:59 | x64      |
| Ssradd.dll                                                   | 2019.150.4102.2 | 82832     | 25-Jan-21 | 20:59 | x64      |
| Ssravg.dll                                                   | 2019.150.4102.2 | 82832     | 25-Jan-21 | 20:59 | x64      |
| Ssrdown.dll                                                  | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x64      |
| Ssrmax.dll                                                   | 2019.150.4102.2 | 82824     | 25-Jan-21 | 20:59 | x64      |
| Ssrmin.dll                                                   | 2019.150.4102.2 | 82832     | 25-Jan-21 | 20:59 | x64      |
| Ssrpub.dll                                                   | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x64      |
| Ssrup.dll                                                    | 2019.150.4102.2 | 74640     | 25-Jan-21 | 20:59 | x64      |
| Txagg.dll                                                    | 2019.150.4102.2 | 390032    | 25-Jan-21 | 20:59 | x64      |
| Txbdd.dll                                                    | 2019.150.4102.2 | 193424    | 25-Jan-21 | 20:59 | x64      |
| Txdatacollector.dll                                          | 2019.150.4102.2 | 471952    | 25-Jan-21 | 20:59 | x64      |
| Txdataconvert.dll                                            | 2019.150.4102.2 | 316304    | 25-Jan-21 | 20:59 | x64      |
| Txderived.dll                                                | 2019.150.4102.2 | 639888    | 25-Jan-21 | 20:59 | x64      |
| Txlookup.dll                                                 | 2019.150.4102.2 | 541584    | 25-Jan-21 | 20:59 | x64      |
| Txmerge.dll                                                  | 2019.150.4102.2 | 258960    | 25-Jan-21 | 20:59 | x64      |
| Txmergejoin.dll                                              | 2019.150.4102.2 | 308112    | 25-Jan-21 | 20:59 | x64      |
| Txmulticast.dll                                              | 2019.150.4102.2 | 144272    | 25-Jan-21 | 20:59 | x64      |
| Txrowcount.dll                                               | 2019.150.4102.2 | 140176    | 25-Jan-21 | 20:59 | x64      |
| Txsort.dll                                                   | 2019.150.4102.2 | 287632    | 25-Jan-21 | 20:59 | x64      |
| Txsplit.dll                                                  | 2019.150.4102.2 | 623504    | 25-Jan-21 | 20:59 | x64      |
| Txunionall.dll                                               | 2019.150.4102.2 | 205712    | 25-Jan-21 | 20:59 | x64      |
| Xe.dll                                                       | 2019.150.4102.2 | 721808    | 25-Jan-21 | 20:59 | x64      |
| Xmlsub.dll                                                   | 2019.150.4102.2 | 295824    | 25-Jan-21 | 20:59 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4102.2 | 91024     | 25-Jan-21 | 20:59 | x64      |
| Exthost.exe        | 2019.150.4102.2 | 238480    | 25-Jan-21 | 20:59 | x64      |
| Launchpad.exe      | 2019.150.4102.2 | 1217424   | 25-Jan-21 | 20:59 | x64      |
| Sqlsatellite.dll   | 2019.150.4102.2 | 1016720   | 25-Jan-21 | 20:59 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4102.2 | 684944    | 25-Jan-21 | 20:59 | x64      |
| Fdhost.exe     | 2019.150.4102.2 | 127888    | 25-Jan-21 | 20:59 | x64      |
| Fdlauncher.exe | 2019.150.4102.2 | 78736     | 25-Jan-21 | 20:59 | x64      |
| Sqlft150ph.dll | 2019.150.4102.2 | 91024     | 25-Jan-21 | 20:59 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4102.2  | 29584     | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4102.2 | 263056    | 25-Jan-21 | 20:56 | x64      |
| Commanddest.dll                                               | 2019.150.4102.2 | 226192    | 25-Jan-21 | 20:59 | x86      |
| Dteparse.dll                                                  | 2019.150.4102.2 | 123792    | 25-Jan-21 | 20:59 | x64      |
| Dteparse.dll                                                  | 2019.150.4102.2 | 111504    | 25-Jan-21 | 20:59 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4102.2 | 131984    | 25-Jan-21 | 20:59 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4102.2 | 115600    | 25-Jan-21 | 20:59 | x86      |
| Dtepkg.dll                                                    | 2019.150.4102.2 | 131984    | 25-Jan-21 | 20:59 | x86      |
| Dtepkg.dll                                                    | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:59 | x64      |
| Dtexec.exe                                                    | 2019.150.4102.2 | 62864     | 25-Jan-21 | 20:59 | x86      |
| Dtexec.exe                                                    | 2019.150.4102.2 | 71568     | 25-Jan-21 | 20:59 | x64      |
| Dts.dll                                                       | 2019.150.4102.2 | 3142544   | 25-Jan-21 | 20:56 | x64      |
| Dts.dll                                                       | 2019.150.4102.2 | 2761616   | 25-Jan-21 | 20:59 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4102.2 | 500624    | 25-Jan-21 | 20:56 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4102.2 | 443280    | 25-Jan-21 | 20:59 | x86      |
| Dtsconn.dll                                                   | 2019.150.4102.2 | 521104    | 25-Jan-21 | 20:56 | x64      |
| Dtsconn.dll                                                   | 2019.150.4102.2 | 430992    | 25-Jan-21 | 20:59 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4102.2 | 110992    | 25-Jan-21 | 20:56 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4102.2 | 92560     | 25-Jan-21 | 20:59 | x86      |
| Dtshost.exe                                                   | 2019.150.4102.2 | 87440     | 25-Jan-21 | 20:59 | x86      |
| Dtshost.exe                                                   | 2019.150.4102.2 | 104336    | 25-Jan-21 | 20:59 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4102.2 | 566160    | 25-Jan-21 | 20:59 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4102.2 | 553872    | 25-Jan-21 | 20:59 | x86      |
| Dtspipeline.dll                                               | 2019.150.4102.2 | 1328016   | 25-Jan-21 | 20:56 | x64      |
| Dtspipeline.dll                                               | 2019.150.4102.2 | 1119112   | 25-Jan-21 | 20:59 | x86      |
| Dtswizard.exe                                                 | 15.0.4102.2     | 885648    | 25-Jan-21 | 20:59 | x64      |
| Dtswizard.exe                                                 | 15.0.4102.2     | 889744    | 25-Jan-21 | 20:59 | x86      |
| Dtuparse.dll                                                  | 2019.150.4102.2 | 99216     | 25-Jan-21 | 20:59 | x64      |
| Dtuparse.dll                                                  | 2019.150.4102.2 | 86928     | 25-Jan-21 | 20:59 | x86      |
| Dtutil.exe                                                    | 2019.150.4102.2 | 147344    | 25-Jan-21 | 20:59 | x64      |
| Dtutil.exe                                                    | 2019.150.4102.2 | 128912    | 25-Jan-21 | 20:59 | x86      |
| Exceldest.dll                                                 | 2019.150.4102.2 | 279440    | 25-Jan-21 | 20:56 | x64      |
| Exceldest.dll                                                 | 2019.150.4102.2 | 234384    | 25-Jan-21 | 20:59 | x86      |
| Excelsrc.dll                                                  | 2019.150.4102.2 | 308112    | 25-Jan-21 | 20:56 | x64      |
| Excelsrc.dll                                                  | 2019.150.4102.2 | 258960    | 25-Jan-21 | 20:59 | x86      |
| Execpackagetask.dll                                           | 2019.150.4102.2 | 185232    | 25-Jan-21 | 20:56 | x64      |
| Execpackagetask.dll                                           | 2019.150.4102.2 | 148368    | 25-Jan-21 | 20:59 | x86      |
| Flatfiledest.dll                                              | 2019.150.4102.2 | 410512    | 25-Jan-21 | 20:56 | x64      |
| Flatfiledest.dll                                              | 2019.150.4102.2 | 357264    | 25-Jan-21 | 20:59 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4102.2 | 426896    | 25-Jan-21 | 20:56 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4102.2 | 369552    | 25-Jan-21 | 20:59 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4102.2     | 119696    | 25-Jan-21 | 20:59 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4102.2     | 119696    | 25-Jan-21 | 20:59 | x86      |
| Isserverexec.exe                                              | 15.0.4102.2     | 148368    | 25-Jan-21 | 20:59 | x86      |
| Isserverexec.exe                                              | 15.0.4102.2     | 144272    | 25-Jan-21 | 20:59 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4102.2     | 78736     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4102.2     | 58256     | 25-Jan-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4102.2     | 58256     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4102.2     | 508816    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4102.2     | 508816    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4102.2     | 41872     | 25-Jan-21 | 20:56 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4102.2     | 41872     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4102.2     | 390032    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4102.2     | 58256     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4102.2     | 58256     | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4102.2     | 140176    | 25-Jan-21 | 20:56 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4102.2     | 140176    | 25-Jan-21 | 20:59 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4102.2     | 156560    | 25-Jan-21 | 20:56 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4102.2     | 156560    | 25-Jan-21 | 20:59 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4102.2     | 218000    | 25-Jan-21 | 20:59 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4102.2 | 111504    | 25-Jan-21 | 20:56 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4102.2 | 99216     | 25-Jan-21 | 20:59 | x86      |
| Msmdpp.dll                                                    | 2018.150.34.29  | 10062216  | 25-Jan-21 | 20:59 | x64      |
| Odbcdest.dll                                                  | 2019.150.4102.2 | 369552    | 25-Jan-21 | 20:56 | x64      |
| Odbcdest.dll                                                  | 2019.150.4102.2 | 316304    | 25-Jan-21 | 20:59 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4102.2 | 381840    | 25-Jan-21 | 20:56 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4102.2 | 328592    | 25-Jan-21 | 20:59 | x86      |
| Oledbdest.dll                                                 | 2019.150.4102.2 | 279440    | 25-Jan-21 | 20:56 | x64      |
| Oledbdest.dll                                                 | 2019.150.4102.2 | 238480    | 25-Jan-21 | 20:59 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4102.2 | 312208    | 25-Jan-21 | 20:56 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4102.2 | 263056    | 25-Jan-21 | 20:59 | x86      |
| Rawdest.dll                                                   | 2019.150.4102.2 | 226192    | 25-Jan-21 | 20:56 | x64      |
| Rawdest.dll                                                   | 2019.150.4102.2 | 189328    | 25-Jan-21 | 20:59 | x86      |
| Rawsource.dll                                                 | 2019.150.4102.2 | 209808    | 25-Jan-21 | 20:56 | x64      |
| Rawsource.dll                                                 | 2019.150.4102.2 | 177040    | 25-Jan-21 | 20:59 | x86      |
| Recordsetdest.dll                                             | 2019.150.4102.2 | 201616    | 25-Jan-21 | 20:56 | x64      |
| Recordsetdest.dll                                             | 2019.150.4102.2 | 172944    | 25-Jan-21 | 20:59 | x86      |
| Sqlceip.exe                                                   | 15.0.4102.2     | 283536    | 25-Jan-21 | 20:59 | x86      |
| Sqldest.dll                                                   | 2019.150.4102.2 | 275344    | 25-Jan-21 | 20:56 | x64      |
| Sqldest.dll                                                   | 2019.150.4102.2 | 238480    | 25-Jan-21 | 20:59 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4102.2 | 205712    | 25-Jan-21 | 20:56 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4102.2 | 168848    | 25-Jan-21 | 20:59 | x86      |
| Txagg.dll                                                     | 2019.150.4102.2 | 390032    | 25-Jan-21 | 20:56 | x64      |
| Txagg.dll                                                     | 2019.150.4102.2 | 328592    | 25-Jan-21 | 20:59 | x86      |
| Txbdd.dll                                                     | 2019.150.4102.2 | 193424    | 25-Jan-21 | 20:56 | x64      |
| Txbdd.dll                                                     | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:59 | x86      |
| Txbestmatch.dll                                               | 2019.150.4102.2 | 652176    | 25-Jan-21 | 20:56 | x64      |
| Txbestmatch.dll                                               | 2019.150.4102.2 | 545680    | 25-Jan-21 | 20:59 | x86      |
| Txcache.dll                                                   | 2019.150.4102.2 | 209808    | 25-Jan-21 | 20:56 | x64      |
| Txcache.dll                                                   | 2019.150.4102.2 | 164752    | 25-Jan-21 | 20:59 | x86      |
| Txcharmap.dll                                                 | 2019.150.4102.2 | 312208    | 25-Jan-21 | 20:56 | x64      |
| Txcharmap.dll                                                 | 2019.150.4102.2 | 271248    | 25-Jan-21 | 20:59 | x86      |
| Txcopymap.dll                                                 | 2019.150.4102.2 | 197520    | 25-Jan-21 | 20:56 | x64      |
| Txcopymap.dll                                                 | 2019.150.4102.2 | 164752    | 25-Jan-21 | 20:59 | x86      |
| Txdataconvert.dll                                             | 2019.150.4102.2 | 316304    | 25-Jan-21 | 20:56 | x64      |
| Txdataconvert.dll                                             | 2019.150.4102.2 | 275344    | 25-Jan-21 | 20:59 | x86      |
| Txderived.dll                                                 | 2019.150.4102.2 | 639888    | 25-Jan-21 | 20:56 | x64      |
| Txderived.dll                                                 | 2019.150.4102.2 | 557968    | 25-Jan-21 | 20:59 | x86      |
| Txfileextractor.dll                                           | 2019.150.4102.2 | 218000    | 25-Jan-21 | 20:56 | x64      |
| Txfileextractor.dll                                           | 2019.150.4102.2 | 181136    | 25-Jan-21 | 20:59 | x86      |
| Txfileinserter.dll                                            | 2019.150.4102.2 | 213904    | 25-Jan-21 | 20:56 | x64      |
| Txfileinserter.dll                                            | 2019.150.4102.2 | 181136    | 25-Jan-21 | 20:59 | x86      |
| Txgroupdups.dll                                               | 2019.150.4102.2 | 312208    | 25-Jan-21 | 20:56 | x64      |
| Txgroupdups.dll                                               | 2019.150.4102.2 | 254864    | 25-Jan-21 | 20:59 | x86      |
| Txlineage.dll                                                 | 2019.150.4102.2 | 152464    | 25-Jan-21 | 20:56 | x64      |
| Txlineage.dll                                                 | 2019.150.4102.2 | 127888    | 25-Jan-21 | 20:59 | x86      |
| Txlookup.dll                                                  | 2019.150.4102.2 | 541584    | 25-Jan-21 | 20:56 | x64      |
| Txlookup.dll                                                  | 2019.150.4102.2 | 467856    | 25-Jan-21 | 20:59 | x86      |
| Txmerge.dll                                                   | 2019.150.4102.2 | 258960    | 25-Jan-21 | 20:56 | x64      |
| Txmerge.dll                                                   | 2019.150.4102.2 | 201616    | 25-Jan-21 | 20:59 | x86      |
| Txmergejoin.dll                                               | 2019.150.4102.2 | 308112    | 25-Jan-21 | 20:56 | x64      |
| Txmergejoin.dll                                               | 2019.150.4102.2 | 246672    | 25-Jan-21 | 20:59 | x86      |
| Txmulticast.dll                                               | 2019.150.4102.2 | 144272    | 25-Jan-21 | 20:56 | x64      |
| Txmulticast.dll                                               | 2019.150.4102.2 | 115600    | 25-Jan-21 | 20:59 | x86      |
| Txpivot.dll                                                   | 2019.150.4102.2 | 238480    | 25-Jan-21 | 20:56 | x64      |
| Txpivot.dll                                                   | 2019.150.4102.2 | 205712    | 25-Jan-21 | 20:59 | x86      |
| Txrowcount.dll                                                | 2019.150.4102.2 | 140176    | 25-Jan-21 | 20:56 | x64      |
| Txrowcount.dll                                                | 2019.150.4102.2 | 111504    | 25-Jan-21 | 20:59 | x86      |
| Txsampling.dll                                                | 2019.150.4102.2 | 193424    | 25-Jan-21 | 20:56 | x64      |
| Txsampling.dll                                                | 2019.150.4102.2 | 156560    | 25-Jan-21 | 20:59 | x86      |
| Txscd.dll                                                     | 2019.150.4102.2 | 234384    | 25-Jan-21 | 20:56 | x64      |
| Txscd.dll                                                     | 2019.150.4102.2 | 197520    | 25-Jan-21 | 20:59 | x86      |
| Txsort.dll                                                    | 2019.150.4102.2 | 287632    | 25-Jan-21 | 20:56 | x64      |
| Txsort.dll                                                    | 2019.150.4102.2 | 230288    | 25-Jan-21 | 20:59 | x86      |
| Txsplit.dll                                                   | 2019.150.4102.2 | 623504    | 25-Jan-21 | 20:56 | x64      |
| Txsplit.dll                                                   | 2019.150.4102.2 | 549776    | 25-Jan-21 | 20:59 | x86      |
| Txtermextraction.dll                                          | 2019.150.4102.2 | 8700816   | 25-Jan-21 | 20:56 | x64      |
| Txtermextraction.dll                                          | 2019.150.4102.2 | 8643472   | 25-Jan-21 | 20:59 | x86      |
| Txtermlookup.dll                                              | 2019.150.4102.2 | 4182928   | 25-Jan-21 | 20:56 | x64      |
| Txtermlookup.dll                                              | 2019.150.4102.2 | 4137872   | 25-Jan-21 | 20:59 | x86      |
| Txunionall.dll                                                | 2019.150.4102.2 | 205712    | 25-Jan-21 | 20:56 | x64      |
| Txunionall.dll                                                | 2019.150.4102.2 | 160656    | 25-Jan-21 | 20:59 | x86      |
| Txunpivot.dll                                                 | 2019.150.4102.2 | 213904    | 25-Jan-21 | 20:56 | x64      |
| Txunpivot.dll                                                 | 2019.150.4102.2 | 181136    | 25-Jan-21 | 20:59 | x86      |
| Xe.dll                                                        | 2019.150.4102.2 | 631696    | 25-Jan-21 | 20:59 | x86      |
| Xe.dll                                                        | 2019.150.4102.2 | 721808    | 25-Jan-21 | 20:59 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1901.0     | 551840    | 25-Jan-21 | 21:45 | x86      |
| Dmsnative.dll                                                        | 2018.150.1901.0 | 145824    | 25-Jan-21 | 21:45 | x64      |
| Dwengineservice.dll                                                  | 15.0.1901.0     | 43936     | 25-Jan-21 | 21:45 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 25-Jan-21 | 21:45 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 25-Jan-21 | 21:45 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 25-Jan-21 | 21:45 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 25-Jan-21 | 21:45 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 25-Jan-21 | 21:45 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 25-Jan-21 | 21:45 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 25-Jan-21 | 21:45 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 25-Jan-21 | 21:45 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 25-Jan-21 | 21:45 | x64      |
| Instapi150.dll                                                       | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:45 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 25-Jan-21 | 21:45 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 25-Jan-21 | 21:45 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 25-Jan-21 | 21:45 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 25-Jan-21 | 21:45 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 25-Jan-21 | 21:45 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1901.0     | 66456     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1901.0     | 292256    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1901.0     | 1954712   | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1901.0     | 169376    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1901.0     | 635808    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1901.0     | 244128    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1901.0     | 138136    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1901.0     | 78752     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1901.0     | 50080     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1901.0     | 87456     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1901.0     | 1128344   | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1901.0     | 79776     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1901.0     | 69536     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1901.0     | 34208     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1901.0     | 30104     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1901.0     | 45472     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1901.0     | 20384     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1901.0     | 25504     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1901.0     | 130456    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1901.0     | 85408     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1901.0     | 99744     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1901.0     | 291744    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 118688    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 137120    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 140192    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 136608    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 149408    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 138656    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 133024    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 175520    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 116128    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1901.0     | 135072    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1901.0     | 71576     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1901.0     | 20896     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1901.0     | 36256     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1901.0     | 127896    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1901.0     | 3050904   | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1901.0     | 3953056   | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 117152    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 132000    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 136608    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 132512    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 147360    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 133024    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 129440    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 169880    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 114080    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1901.0     | 130976    | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1901.0     | 66464     | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1901.0     | 2681248   | 25-Jan-21 | 21:45 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1901.0     | 2435480   | 25-Jan-21 | 21:45 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4102.2 | 451472    | 25-Jan-21 | 21:45 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4102.2 | 7386000   | 25-Jan-21 | 21:45 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 25-Jan-21 | 21:45 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 25-Jan-21 | 21:45 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 25-Jan-21 | 21:45 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 25-Jan-21 | 21:45 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 25-Jan-21 | 21:45 | x64      |
| Secforwarder.dll                                                     | 2019.150.4102.2 | 78736     | 25-Jan-21 | 21:45 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1901.0 | 60320     | 25-Jan-21 | 21:45 | x64      |
| Sqldk.dll                                                            | 2019.150.4102.2 | 3146640   | 25-Jan-21 | 21:45 | x64      |
| Sqldumper.exe                                                        | 2019.150.4102.2 | 185232    | 25-Jan-21 | 21:45 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 1590160   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 4150160   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 3404688   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 4146064   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 4051856   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 2216848   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 2163600   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 3810192   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 3806096   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 1532816   | 25-Jan-21 | 21:37 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4102.2 | 4014992   | 25-Jan-21 | 21:37 | x64      |
| Sqlos.dll                                                            | 2019.150.4102.2 | 41872     | 25-Jan-21 | 21:45 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1901.0 | 4840344   | 25-Jan-21 | 21:45 | x64      |
| Sqltses.dll                                                          | 2019.150.4102.2 | 9077648   | 25-Jan-21 | 21:45 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 25-Jan-21 | 21:45 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 25-Jan-21 | 21:45 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 25-Jan-21 | 21:45 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4102.2  | 29584     | 25-Jan-21 | 20:59 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4102.2 | 1631120   | 25-Jan-21 | 21:27 | x86      |
| Dtaengine.exe                                                | 2019.150.4102.2 | 218000    | 25-Jan-21 | 21:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4102.2 | 111504    | 25-Jan-21 | 21:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4102.2 | 123792    | 25-Jan-21 | 21:27 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4102.2 | 115600    | 25-Jan-21 | 21:27 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4102.2 | 131984    | 25-Jan-21 | 21:27 | x64      |
| Dtepkg.dll                                                   | 2019.150.4102.2 | 131984    | 25-Jan-21 | 21:27 | x86      |
| Dtepkg.dll                                                   | 2019.150.4102.2 | 152464    | 25-Jan-21 | 21:27 | x64      |
| Dtexec.exe                                                   | 2019.150.4102.2 | 71568     | 25-Jan-21 | 21:27 | x64      |
| Dtexec.exe                                                   | 2019.150.4102.2 | 62864     | 25-Jan-21 | 21:27 | x86      |
| Dts.dll                                                      | 2019.150.4102.2 | 2761616   | 25-Jan-21 | 21:27 | x86      |
| Dts.dll                                                      | 2019.150.4102.2 | 3142544   | 25-Jan-21 | 21:27 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4102.2 | 443280    | 25-Jan-21 | 21:27 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4102.2 | 500624    | 25-Jan-21 | 21:27 | x64      |
| Dtsconn.dll                                                  | 2019.150.4102.2 | 430992    | 25-Jan-21 | 21:27 | x86      |
| Dtsconn.dll                                                  | 2019.150.4102.2 | 521104    | 25-Jan-21 | 21:27 | x64      |
| Dtshost.exe                                                  | 2019.150.4102.2 | 104336    | 25-Jan-21 | 21:27 | x64      |
| Dtshost.exe                                                  | 2019.150.4102.2 | 87440     | 25-Jan-21 | 21:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4102.2 | 553872    | 25-Jan-21 | 21:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4102.2 | 566160    | 25-Jan-21 | 21:27 | x64      |
| Dtspipeline.dll                                              | 2019.150.4102.2 | 1119112   | 25-Jan-21 | 21:27 | x86      |
| Dtspipeline.dll                                              | 2019.150.4102.2 | 1328016   | 25-Jan-21 | 21:27 | x64      |
| Dtswizard.exe                                                | 15.0.4102.2     | 885648    | 25-Jan-21 | 21:27 | x64      |
| Dtswizard.exe                                                | 15.0.4102.2     | 889744    | 25-Jan-21 | 21:27 | x86      |
| Dtuparse.dll                                                 | 2019.150.4102.2 | 99216     | 25-Jan-21 | 21:27 | x64      |
| Dtuparse.dll                                                 | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4102.2 | 128912    | 25-Jan-21 | 21:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4102.2 | 147344    | 25-Jan-21 | 21:27 | x64      |
| Exceldest.dll                                                | 2019.150.4102.2 | 279440    | 25-Jan-21 | 21:27 | x64      |
| Exceldest.dll                                                | 2019.150.4102.2 | 234384    | 25-Jan-21 | 21:27 | x86      |
| Excelsrc.dll                                                 | 2019.150.4102.2 | 258960    | 25-Jan-21 | 21:27 | x86      |
| Excelsrc.dll                                                 | 2019.150.4102.2 | 308112    | 25-Jan-21 | 21:27 | x64      |
| Flatfiledest.dll                                             | 2019.150.4102.2 | 410512    | 25-Jan-21 | 21:27 | x64      |
| Flatfiledest.dll                                             | 2019.150.4102.2 | 357264    | 25-Jan-21 | 21:27 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4102.2 | 369552    | 25-Jan-21 | 21:27 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4102.2 | 426896    | 25-Jan-21 | 21:27 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4102.2     | 78736     | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4102.2     | 402320    | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4102.2     | 402320    | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4102.2     | 2999184   | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4102.2     | 41872     | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4102.2     | 41872     | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4102.2     | 58256     | 25-Jan-21 | 21:27 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 25-Jan-21 | 21:27 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4102.2 | 111504    | 25-Jan-21 | 21:27 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4102.2 | 99216     | 25-Jan-21 | 21:27 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.34.29  | 8277912   | 25-Jan-21 | 21:00 | x86      |
| Oledbdest.dll                                                | 2019.150.4102.2 | 238480    | 25-Jan-21 | 21:27 | x86      |
| Oledbdest.dll                                                | 2019.150.4102.2 | 279440    | 25-Jan-21 | 21:27 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4102.2 | 263056    | 25-Jan-21 | 21:27 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4102.2 | 312208    | 25-Jan-21 | 21:27 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4102.2 | 37776     | 25-Jan-21 | 21:27 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4102.2 | 50064     | 25-Jan-21 | 21:27 | x64      |
| Sqlscm.dll                                                   | 2019.150.4102.2 | 78736     | 25-Jan-21 | 21:27 | x86      |
| Sqlscm.dll                                                   | 2019.150.4102.2 | 86928     | 25-Jan-21 | 21:27 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4102.2 | 148368    | 25-Jan-21 | 21:27 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4102.2 | 181136    | 25-Jan-21 | 21:27 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4102.2 | 205712    | 25-Jan-21 | 21:27 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4102.2 | 168848    | 25-Jan-21 | 21:27 | x86      |
| Txdataconvert.dll                                            | 2019.150.4102.2 | 275344    | 25-Jan-21 | 21:27 | x86      |
| Txdataconvert.dll                                            | 2019.150.4102.2 | 316304    | 25-Jan-21 | 21:27 | x64      |
| Xe.dll                                                       | 2019.150.4102.2 | 631696    | 25-Jan-21 | 21:27 | x86      |
| Xe.dll                                                       | 2019.150.4102.2 | 721808    | 25-Jan-21 | 21:27 | x64      |

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
