---
title: Cumulative update 12 for SQL Server 2022 (KB5033663)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 12 (KB5033663).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5033663
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5033663 - Cumulative Update 12 for SQL Server 2022

_Release Date:_ &nbsp; March 14, 2024  
_Version:_ &nbsp; 16.0.4115.5

## Summary

This article describes Cumulative Update package 12 (CU12) for Microsoft SQL Server 2022. This update contains 51 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 11, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4115.5**, file version: **2022.160.4115.5**
- Analysis Services - Product version: **16.0.43.229**, file version: **2022.160.43.229**

> [!NOTE]
> [SQL Server 2022 CU6](cumulativeupdate6.md#2475171) enabled Microsoft Entra authentication for SQL Server replication. After you install SQL Server 2022 CU12, this feature will be generally available. For more information, see [Configure replication with Microsoft Entra authentication](/sql/relational-databases/replication/configure-replication-with-azure-ad-authentication). </br></br>Microsoft Entra authentication for replication can be disabled by using trace flag 11561.

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component| Platform |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|--------------------------------------------|----------|
| <a id=2860396>[2860396](#2860396) </a> | Fixes an access violation that you might encounter when adding or deleting an empty partition with row-level security (RLS) on a table.| Analysis Services | Analysis Services| Windows|
| <a id=2864688>[2864688](#2864688) </a> | Fixes an issue in which running Data Analysis Expressions (DAX) queries failed with error "Memory Allocation failure" even though the SQL Server Analysis Services instance still has a lot of available memory. | Analysis Services | Analysis Services| Windows|
| <a id=2888483>[2888483](#2888483) </a> | Fixes a performance degradation that might be encountered during the execution of the `ProcessAdd` command, which causes an increase in CPU usage and execution time.| Analysis Services | Analysis Services| Windows|
| <a id=2859818>[2859818](#2859818) </a> | Fixes an issue that might cause a recursive hierarchy to fail to load all levels.| Master Data Services| Master Data Services | Windows|
| <a id=2868247>[2868247](#2868247) </a> | Fixes an issue in which an upgrade process in Master Data Services models might fail if you set an inappropriate entity name such as "Entity". | Master Data Services| Master Data Services | Windows|
| <a id=2969541>[2969541](#2969541) </a> | Adds the support of the Extensible Key Management (EKM) feature for SQL Server on Linux. | SQL Connectivity| Linux| Linux|
| <a id=2920697>[2920697](#2920697) </a> | Fixes an issue in which the **SQLdiag** tool doesn't start when trying to read the default XML configuration file. Additionally, you receive the following error message: </br></br>\<DateTime> SQLDIAG Output path: \<FolderPath> </br>\<DateTime> SQLDIAG Failed to load XML configuration file: ErrCode:0xC00CE169,Reason:"'16' violates enumeration constraint of '7 8 9 10 10.5 10.50 11 12 13 14 15 *'.| SQL Server Client Tools | SQLDiag| Windows|
| <a id=2846022>[2846022](#2846022) </a> | Fixes an issue in which a Volume Shadow Copy Service (VSS) restore process with the **Restore with Move** feature might restore an incorrect file or fail if the file path for the `.mdf` file includes a trailing space. Additionally, you receive the following error message if the restore process fails: </br></br>NativeError: 1384 </br>The file '\<FilePath> ' cannot be overwritten. It is being used by database '\<DatabaseName>' | SQL Server Engine | Backup Restore | Windows|
| <a id=2804318>[2804318](#2804318) </a> | Fixes an issue that might cause the database file to be associated with an incorrect filegroup in the clone database created by using `DBCC CLONEDATABASE`.| SQL Server Engine | DB Management| All|
| <a id=2347023>[2347023](#2347023) </a> | Fixes an issue in which the automatic seeding operation for a database remains in `LIMIT_CONCURRENT_BACKUPS` after adding the database to a new availability group or an existing one created with automatic seeding, even though this SQL Server instance doesn't have any other active seeding, virtual device interface (VDI), or backup threads.| SQL Server Engine | High Availability and Disaster Recovery| All|
| <a id=2824982>[2824982](#2824982) </a> | Prevents the creation of read-scale availability groups that have a large number of databases to avoid the subsequent assertion failure (Location: ucsconnectionsend.cpp:103; Expression: 'm_pcscBoxcar->GetMessageCount () > 0'). | SQL Server Engine | High Availability and Disaster Recovery| Windows|
| <a id=2834436>[2834436](#2834436) </a> | Fixes an issue in which the database audit might not record the action when a database audit specification is initially created against the instance name (not the contained availability group listener), and future transactions are executed against the contained availability group listener. | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=2893030>[2893030](#2893030) </a> | Fixes an issue in which the global primary or forwarder in a distributed availability group can't connect to the listener of the other availability group for a while after the local availability group fails over between replicas in multi-subnet configurations. | SQL Server Engine | High Availability and Disaster Recovery| Windows|
| <a id=2923126>[2923126](#2923126) </a> | Fixes an issue that you encounter in `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups after you install SQL Server 2022 CU10 or later versions, which causes the **Availability Databases** folder in SQL Server Management Studio (SSMS) not to show the databases in the availability group (AG).| SQL Server Engine | High Availability and Disaster Recovery| Windows|
| <a id=2937584>[2937584](#2937584) </a> | Fixes an issue in which the `sp_server_diagnostics` stored procedure doesn't respond to the Always On availability group (AG) resource DLL within the `HealthCheckTimeout` when the I/O takes a long time, which causes unnecessary restart and failover. For example, when the `sp_server_diagnostics` stored procedure is waiting for the `PREEMPTIVE_OS_GETFINALFILEPATHBYHANDLE` wait type. </br></br>**Note**: To apply this fix, you need to turn on trace flag 16301, which is off by default. Tracing is added for this event regardless of the trace flag.| SQL Server Engine | High Availability and Disaster Recovery| All|
| <a id=2845380>[2845380](#2845380) </a> | Removes the following incorrect error that's related to `ca-certificates` when starting SQL Server on Linux: </br></br>Error searching first file in /var/opt/mssql/security/ca-certificates | SQL Server Engine | Linux| Linux|
| <a id=2920073>[2920073](#2920073) </a> | Fixes an issue in which an unreliable network connection causes an unsuccessful status during backup to a network share, which causes the SQL Server instance to stop responding.| SQL Server Engine | Linux| Linux|
| <a id=2958874>[2958874](#2958874) </a> | Fixes an issue in which the SQL Server instance fails to start on Linux kernels 6.7 and later versions.| SQL Server Engine | Linux| Linux|
| <a id=2768282>[2768282](#2768282) </a> | Fixes an assertion failure (Location: "sql\\\ntdbms\\\storeng\\\dfs\\\trans\\\PageFlush.cpp":1840; Expression: IS_OFF (BUF_LOG_BUFWRITE, buf->bstat) \|\| IS_ON (BUF_DIRTY, buf->bstat) \|\| m_ownerXdes->GetPru ()->IsSuspect ()) that you encounter when running the `BULK INSERT` statement.| SQL Server Engine | Methods to access stored data| All|
| <a id=2837848>[2837848](#2837848) </a> | Fixes a deadlock issue that you encounter when creating or updating statistics by turning off the blocking Auto Stats feature. The blocking Auto Stats feature is turned on when you use PolyBase. Turning off the blocking Auto Stats feature might cause a different query plan and execution time because query compilation isn't blocked by statistics collection. | SQL Server Engine | PolyBase | All|
| <a id=2870726>[2870726](#2870726) </a> | Fixes an issue in which the exported delimited text file created by using `CREATE EXTERNAL TABLE AS SELECT (CETAS)` is incorrect if the `FIELD_TERMINATOR` character is `'\t'`. | SQL Server Engine | PolyBase | All|
| <a id=2937200>[2937200](#2937200) </a> | Fixes an issue in which running Delta table queries requires the **sysadmin** server role. For more information, see [Delta table query may fail with errors 2571 and 16513](/sql/relational-databases/polybase/polybase-errors-and-possible-solutions#delta-table-query-may-fail-with-errors-2571-and-16513). | SQL Server Engine | PolyBase | All|
| <a id=2936186>[2936186](#2936186) </a> </br><a id=2936204>[2936204](#2936204) </a> </br><a id=2938811>[2938811](#2938811) </a> </br><a id=2941532>[2941532](#2941532) </a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581)| SQL Server Engine | Programmability| All|
| <a id=2961007>[2961007](#2961007) </a> | Fixes an out-of-memory (OOM) issue that's caused by spikes in `CACHESTORE_PHDR` usage. | SQL Server Engine | Programmability| Windows|
| <a id=2833605>[2833605](#2833605) </a> | Adds mitigation to avoid an assertion failure (Location: lobss.cpp:707; Expression: 'FALSE' Lob not found for read) that you might encounter when you run a complex query that uses large value data types such as **varchar(max)**. </br></br>**Note**: The mitigation doesn't apply in all situations. | SQL Server Engine | Query Execution| All|
| <a id=2850899>[2850899](#2850899) </a> | Fixes a potential process termination issue that you might encounter when an `adhoc` query that uses the binary large object (BLOB) encounters an error and tries to clean up during the query shutdown. | SQL Server Engine | Query Execution| All|
| <a id=2914479>[2914479](#2914479) </a> | Fixes a contention issue that you encounter when using `sys.dm_exec_query_statistics_xml` from multiple concurrent connections.| SQL Server Engine | Query Execution| All|
| <a id=2695507>[2695507](#2695507) </a> | Fixes inconsistent results that are caused by the parallel spool in the plan for the `INSERT`, `UPDATE`, or `DELETE` query.| SQL Server Engine | Query Optimizer| All|
| <a id=2850915>[2850915](#2850915) </a> | Fixes race conditions in which certain variables aren't initialized correctly when a batch mode sort query is aborted, which causes an access violation and <code>INVALID_POINTER_READ_c0000005_sqlmin.dll!CBpSortLessFunctor_127,0,1,0_<br>::OptLessFunction</code> exception.| SQL Server Engine | Query Optimizer| All|
| <a id=2850932>[2850932](#2850932) </a> | Fixes an access violation exception that you encounter at `sqlmin!CBpXteHashJoin::FSeparateHash` when you try to run a query that involves an `Adaptive Join (CONCAT)` operator in the query plan. | SQL Server Engine | Query Optimizer| All|
| <a id=2890724>[2890724](#2890724) </a> | Fixes an issue that you encounter when references to plan cache entries become dereferenced in memory without allowing the plans to be properly removed from memory. This issue might occur for queries that are analyzed by the Cardinality Estimation (CE) feedback feature. | SQL Server Engine | Query Optimizer| All|
| <a id=2916821>[2916821](#2916821) </a> | Fixes an access violation that you encounter when a Plan Cache object type differs from what Cardinality Estimation (CE) feedback expects. In this scenario, CE feedback casts the object type into the expected one and tries to access to a field that doesn't exist in the object type. | SQL Server Engine | Query Optimizer| All|
| <a id=2612953>[2612953](#2612953) </a> | Fixes the following error that you encounter in conflict detection and in the Replication Merge Agent when converting the generation to **int**: </br></br>Error converting data type bigint to int. | SQL Server Engine | Replication| All|
| <a id=2693175>[2693175](#2693175) </a> | Fixes the following errors that you encounter when using `sp_addsubscription` to create the Subscriber on secondary replicas if the distribution database is in an availability group: </br></br>Msg 20032, Level 16, State 1, Procedure distribution.dbo.sp_MSadd_subscription, Line \<LineNumber> [Batch Start Line 33] </br>\<SubscriberName> is not defined as a Subscriber for \<PublisherName>. </br>Msg 14070, Level 16, State 1, Procedure sys.sp_MSrepl_changesubstatus, Line \<LineNumber> [Batch Start Line 33] </br>Could not update the distribution database subscription table. The subscription status could not be changed. </br>Msg 14057, Level 16, State 1, Procedure sys.sp_MSrepl_addsubscription_article, Line \<LineNumber> [Batch Start Line 33] </br>The subscription could not be created. | SQL Server Engine | Replication| All|
| <a id=2864330>[2864330](#2864330) </a> | Fixes an issue in which overriding the `MakeGenerationInterval` parameter that uses a custom value doesn't work properly when you run *replmerg.exe*.| SQL Server Engine | Replication| Windows|
| <a id=2870454>[2870454](#2870454) </a> | Fixes an issue in which the `sp_helpsubscription` stored procedure doesn't return any results after an in-place upgrade of the Publisher instance to SQL Server 2022, which causes you to fail to reinitialize the subscription with the following error message: </br></br>The Subscription does not exist. | SQL Server Engine | Replication| All|
| <a id=2870518>[2870518](#2870518) </a> | Fixes an issue in which the size of the `_$update_bitmap` column of `dbo.conflict_<owner>_<table>` doesn't get updated with changes in the number of columns of the original conflicting table, which causes the Distributor agent in peer-to-peer replication to fail with the following error message: </br></br>String or binary data would be truncated in table '\<TableName>', column '\<ColumnName>'. Truncated value: "."| SQL Server Engine | Replication| All|
| <a id=2929215>[2929215](#2929215) </a> | Fixes an issue in which [error 18482](/sql/relational-databases/errors-events/mssqlserver-18482-database-engine-error) is caused when using `sp_adddistributor` to add a remote distributor if the Publisher server name contains lowercase characters and the Distributor server has the case-sensitive (_CS) collation. | SQL Server Engine | Replication| All|
| <a id=2877337>[2877337](#2877337) </a> | Adds the following fields to the `sqlserver.fulltext_filter_usage` Extended Event (XEvent) to improve the telemetry reporting for the XEvent: </br></br>- min_input_size </br>- max_input_size </br>- min_output_size </br>- max_output_size | SQL Server Engine | Search | Windows|
| <a id=2956576>[2956576](#2956576) </a> | Fixes an overflow issue of the word occurrence that you encounter during the full-text merging process. | SQL Server Engine | Search | All |
| <a id=2917001>[2917001](#2917001) </a> | Adds support for iterated and salted hash password verifiers. This is a more secure process than simply storing the SHA-512 hash of the password. This feature is available only in SQL Server 2022 CU12 and later versions. For more information, see [Support for Iterated and Salted Hash Password Verifiers in SQL Server 2022 CU12](https://techcommunity.microsoft.com/t5/azure-sql-blog/support-for-iterated-and-salted-hash-password-verifiers-in-sql/ba-p/4087155)| SQL Server Engine | Security Infrastructure | All|
| <a id=2907888>[2907888](#2907888) </a> | Fixes an issue that causes the SQL Server Agent to terminate with the following error message: </br></br>Exception 5 caught at line \<LineNumber> of file \<FileName>. SQLServerAgent initiating self-termination.| SQL Server Engine | SQL Agent| All|
| <a id=2830811>[2830811](#2830811) </a> | Adds trace flag 2616 to enable the stack signature feature when a dump occurs on a SQL Server instance, which avoids multiple dumps for the same exception.| SQL Server Engine | SQL OS | All|
| <a id=2899892>[2899892](#2899892) </a> | Makes the following improvements to the compressed memory dump feature: </br></br>- Adds the use of the `FILE_FLAG_NO_BUFFERING` flag to improve I/O performance and prevent excessive growth of the file cache. </br>- Adds the dynamic auto-tuning parallelism to the feature to take advantage of the available CPU cores.| SQL Server Engine | SQL OS | Windows|
| <a id=2956541>[2956541](#2956541) </a> | Before the improvement, a generic error message (configuration error during initialization) is reported when [creating](/azure/azure-sql/database/xevent-code-event-file) an `event_file` target for an Extended Events session if the Azure blob target is invalid. After applying the improvement, the error will be reported more specifically, such as "due to invalid or expired credentials."| SQL Server Engine | SQL OS | All|
| <a id=2153698>[2153698](#2153698) </a> | Adds a link to error 824 to improve the troubleshooting experience. For more information, see [MSSQLSERVER_824](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error). </br></br>Error Message: </br></br>SQL Server detected a logical consistency-based I/O error: \<Incorrect PageID>. It occurred during a \<Read/Write> of page \<PageID> in database ID \<DatabaseID> at offset \<Offset> in file '\<FileName>'. Additional messages in the SQL Server error log or operating system error log may provide more detail. This is a severe error condition that threatens database integrity and must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). This error can be caused by many factors; for more information, see https://go.microsoft.com/fwlink/?linkid=2252374. | SQL Server Engine | Storage Management | All|
| <a id=2766481>[2766481](#2766481) </a> | Fixes an access violation dump issue that you might encounter when resuming an index rebuild that includes partitions (for example, `ALTER INDEX [index_name] ON [schema].[TableName] RESUME WITH ( MAX_DURATION = 1, MAXDOP = 1 )`).| SQL Server Engine | Table Index Partition| All|
| <a id=2820084>[2820084](#2820084) </a> | Fixes a non-yielding scheduler issue due to spinlock contention on the Redo Manager on secondary replicas of an availability group.| SQL Server Engine | Transaction Services | All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU12 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5033663)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5033663-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5033663-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5033663-x64.exe| A9FC6D06BAA5EAEC40A8426F8562E060E4402E86713781AE2826EC2DBB0810B0 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.229 | 336832    | 04-Mar-2024 | 09:29 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.229     | 2903488   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 04-Mar-2024 | 09:29 | x86      |
| Msmdctr.dll                                         | 2022.160.43.229 | 38968     | 04-Mar-2024 | 09:29 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.229 | 53976624  | 04-Mar-2024 | 09:29 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.229 | 71818808  | 04-Mar-2024 | 09:29 | x64      |
| Msmdpump.dll                                        | 2022.160.43.229 | 10333744  | 04-Mar-2024 | 09:29 | x64      |
| Msmdredir.dll                                       | 2022.160.43.229 | 8132032   | 04-Mar-2024 | 09:29 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.229 | 71354816  | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 956976    | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1884728   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1671728   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1881144   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1848368   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1147440   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1140272   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1769520   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1749048   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 932920    | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.229 | 1837616   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 955440    | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1882672   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1668664   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1876416   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1844792   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1145392   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1138624   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1765424   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1745456   | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 933432    | 04-Mar-2024 | 09:29 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.229 | 1833008   | 04-Mar-2024 | 09:29 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.229 | 10083384  | 04-Mar-2024 | 09:29 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.229 | 8265152   | 04-Mar-2024 | 09:29 | x86      |
| Msolap.dll                                          | 2022.160.43.229 | 10969024  | 04-Mar-2024 | 09:29 | x64      |
| Msolap.dll                                          | 2022.160.43.229 | 8743976   | 04-Mar-2024 | 09:29 | x86      |
| Msolui.dll                                          | 2022.160.43.229 | 289736    | 04-Mar-2024 | 09:29 | x86      |
| Msolui.dll                                          | 2022.160.43.229 | 308272    | 04-Mar-2024 | 09:29 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 04-Mar-2024 | 09:29 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 04-Mar-2024 | 09:29 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |
| Sqlceip.exe                                         | 16.0.4115.5     | 300992    | 04-Mar-2024 | 09:29 | x86      |
| Sqldumper.exe                                       | 2022.160.4115.5 | 378920    | 04-Mar-2024 | 09:29 | x86      |
| Sqldumper.exe                                       | 2022.160.4115.5 | 448552    | 04-Mar-2024 | 09:29 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 04-Mar-2024 | 09:29 | x86      |
| Tmapi.dll                                           | 2022.160.43.229 | 5884352   | 04-Mar-2024 | 09:29 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.229 | 5575120   | 04-Mar-2024 | 09:29 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.229 | 1481152   | 04-Mar-2024 | 09:29 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.229 | 7198144   | 04-Mar-2024 | 09:29 | x64      |
| Xmsrv.dll                                           | 2022.160.43.229 | 26593328  | 04-Mar-2024 | 09:29 | x64      |
| Xmsrv.dll                                           | 2022.160.43.229 | 35895752  | 04-Mar-2024 | 09:29 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4115.5 | 104504    | 04-Mar-2024 | 09:29 | x64      |
| Instapi150.dll                             | 2022.160.4115.5 | 79808     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.229     | 2633672   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.229     | 2633776   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.229     | 2933200   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.229     | 2323504   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.229     | 2323512   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4115.5 | 104488    | 04-Mar-2024 | 09:29 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4115.5 | 92200     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4115.5     | 555048    | 04-Mar-2024 | 09:29 | x86      |
| Msasxpress.dll                             | 2022.160.43.229 | 27600     | 04-Mar-2024 | 09:29 | x86      |
| Msasxpress.dll                             | 2022.160.43.229 | 32704     | 04-Mar-2024 | 09:29 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |
| Sqldumper.exe                              | 2022.160.4115.5 | 378920    | 04-Mar-2024 | 09:29 | x86      |
| Sqldumper.exe                              | 2022.160.4115.5 | 448552    | 04-Mar-2024 | 09:29 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4115.5 | 395320    | 04-Mar-2024 | 09:29 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4115.5 | 456656    | 04-Mar-2024 | 09:29 | x64      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4115.5     | 309184    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4115.5     | 2070568   | 04-Mar-2024 | 09:29 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4115.5  | 600000    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4115.5  | 600104    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4115.5  | 174016    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4115.5  | 174120    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4115.5  | 1857488   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4115.5  | 1857592   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4115.5  | 370624    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4115.5  | 370728    | 04-Mar-2024 | 09:29 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 04-Mar-2024 | 10:33 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 04-Mar-2024 | 10:33 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4115.5 | 5994432   | 04-Mar-2024 | 10:11 | x64      |
| Aetm-enclave.dll                             | 2022.160.4115.5 | 5959568   | 04-Mar-2024 | 10:11 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4115.5 | 6194816   | 04-Mar-2024 | 10:11 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4115.5 | 6160680   | 04-Mar-2024 | 10:11 | x64      |
| Dcexec.exe                                   | 2022.160.4115.5 | 96312     | 04-Mar-2024 | 10:33 | x64      |
| Fssres.dll                                   | 2022.160.4115.5 | 100288    | 04-Mar-2024 | 10:33 | x64      |
| Hadrres.dll                                  | 2022.160.4115.5 | 227368    | 04-Mar-2024 | 10:33 | x64      |
| Hkcompile.dll                                | 2022.160.4115.5 | 1411112   | 04-Mar-2024 | 10:33 | x64      |
| Hkengine.dll                                 | 2022.160.4115.5 | 5769272   | 04-Mar-2024 | 10:11 | x64      |
| Hkruntime.dll                                | 2022.160.4115.5 | 190504    | 04-Mar-2024 | 10:11 | x64      |
| Hktempdb.dll                                 | 2022.160.4115.5 | 71720     | 04-Mar-2024 | 10:11 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.229     | 2322480   | 04-Mar-2024 | 10:33 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4115.5 | 333864    | 04-Mar-2024 | 10:33 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4115.5 | 96208     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 30656     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 38840     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 34768     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 38848     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 38848     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 30656     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 30656     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 34768     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 38848     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 30656     | 04-Mar-2024 | 10:33 | x64      |
| Odsole70.rll                                 | 16.0.4115.5     | 38848     | 04-Mar-2024 | 10:33 | x64      |
| Qds.dll                                      | 2022.160.4115.5 | 1804224   | 04-Mar-2024 | 10:33 | x64      |
| Rsfxft.dll                                   | 2022.160.4115.5 | 55336     | 04-Mar-2024 | 10:33 | x64      |
| Secforwarder.dll                             | 2022.160.4115.5 | 83904     | 04-Mar-2024 | 10:11 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 10:33 | x64      |
| Sqlaamss.dll                                 | 2022.160.4115.5 | 120888    | 04-Mar-2024 | 10:33 | x64      |
| Sqlaccess.dll                                | 2022.160.4115.5 | 444352    | 04-Mar-2024 | 10:33 | x64      |
| Sqlagent.exe                                 | 2022.160.4115.5 | 718904    | 04-Mar-2024 | 10:33 | x64      |
| Sqlceip.exe                                  | 16.0.4115.5     | 300992    | 04-Mar-2024 | 10:33 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4115.5 | 104488    | 04-Mar-2024 | 10:33 | x64      |
| Sqlctr160.dll                                | 2022.160.4115.5 | 157632    | 04-Mar-2024 | 10:33 | x64      |
| Sqlctr160.dll                                | 2022.160.4115.5 | 129064    | 04-Mar-2024 | 10:33 | x86      |
| Sqldk.dll                                    | 2022.160.4115.5 | 4012072   | 04-Mar-2024 | 10:33 | x64      |
| Sqldtsss.dll                                 | 2022.160.4115.5 | 120872    | 04-Mar-2024 | 10:33 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 1750976   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3856320   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4073408   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4585408   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4716480   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3758016   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3946432   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4585408   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4413392   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4487104   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 2447296   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 2389952   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4270032   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3905472   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4421568   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4216784   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4200384   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3983296   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 3860416   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 1689536   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4306896   | 04-Mar-2024 | 10:11 | x64      |
| Sqlevn70.rll                                 | 2022.160.4115.5 | 4450240   | 04-Mar-2024 | 10:11 | x64      |
| Sqliosim.com                                 | 2022.160.4115.5 | 387008    | 04-Mar-2024 | 10:33 | x64      |
| Sqliosim.exe                                 | 2022.160.4115.5 | 3057704   | 04-Mar-2024 | 10:33 | x64      |
| Sqllang.dll                                  | 2022.160.4115.5 | 48777152  | 04-Mar-2024 | 10:33 | x64      |
| Sqlmin.dll                                   | 2022.160.4115.5 | 51222568  | 04-Mar-2024 | 10:33 | x64      |
| Sqlolapss.dll                                | 2022.160.4115.5 | 116776    | 04-Mar-2024 | 10:33 | x64      |
| Sqlos.dll                                    | 2022.160.4115.5 | 51240     | 04-Mar-2024 | 10:11 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4115.5 | 100408    | 04-Mar-2024 | 10:33 | x64      |
| Sqlrepss.dll                                 | 2022.160.4115.5 | 141352    | 04-Mar-2024 | 10:33 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4115.5 | 51136     | 04-Mar-2024 | 10:33 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4115.5 | 5834688   | 04-Mar-2024 | 10:33 | x64      |
| Sqlservr.exe                                 | 2022.160.4115.5 | 722880    | 04-Mar-2024 | 10:33 | x64      |
| Sqlsvc.dll                                   | 2022.160.4115.5 | 194496    | 04-Mar-2024 | 10:33 | x64      |
| Sqltses.dll                                  | 2022.160.4115.5 | 10668072  | 04-Mar-2024 | 10:33 | x64      |
| Sqsrvres.dll                                 | 2022.160.4115.5 | 305088    | 04-Mar-2024 | 10:33 | x64      |
| Svl.dll                                      | 2022.160.4115.5 | 247864    | 04-Mar-2024 | 10:11 | x64      |
| Xe.dll                                       | 2022.160.4115.5 | 718888    | 04-Mar-2024 | 10:33 | x64      |
| Xpqueue.dll                                  | 2022.160.4115.5 | 100392    | 04-Mar-2024 | 10:33 | x64      |
| Xpstar.dll                                   | 2022.160.4115.5 | 534464    | 04-Mar-2024 | 10:33 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 04-Mar-2024 | 09:29 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 04-Mar-2024 | 09:29 | x86      |
| Bcp.exe                                              | 2022.160.4115.5  | 141368    | 04-Mar-2024 | 09:29 | x64      |
| Commanddest.dll                                      | 2022.160.4115.5  | 272440    | 04-Mar-2024 | 09:29 | x64      |
| Datacollectortasks.dll                               | 2022.160.4115.5  | 227368    | 04-Mar-2024 | 09:29 | x64      |
| Distrib.exe                                          | 2022.160.4115.5  | 260136    | 04-Mar-2024 | 09:29 | x64      |
| Dteparse.dll                                         | 2022.160.4115.5  | 133160    | 04-Mar-2024 | 09:29 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4115.5  | 178232    | 04-Mar-2024 | 09:29 | x64      |
| Dtepkg.dll                                           | 2022.160.4115.5  | 153656    | 04-Mar-2024 | 09:29 | x64      |
| Dtexec.exe                                           | 2022.160.4115.5  | 76752     | 04-Mar-2024 | 09:29 | x64      |
| Dts.dll                                              | 2022.160.4115.5  | 3266496   | 04-Mar-2024 | 09:29 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4115.5  | 493608    | 04-Mar-2024 | 09:29 | x64      |
| Dtsconn.dll                                          | 2022.160.4115.5  | 550952    | 04-Mar-2024 | 09:29 | x64      |
| Dtshost.exe                                          | 2022.160.4115.5  | 120376    | 04-Mar-2024 | 09:29 | x64      |
| Dtslog.dll                                           | 2022.160.4115.5  | 137256    | 04-Mar-2024 | 09:29 | x64      |
| Dtspipeline.dll                                      | 2022.160.4115.5  | 1337280   | 04-Mar-2024 | 09:29 | x64      |
| Dtuparse.dll                                         | 2022.160.4115.5  | 104384    | 04-Mar-2024 | 09:29 | x64      |
| Dtutil.exe                                           | 2022.160.4115.5  | 166456    | 04-Mar-2024 | 09:29 | x64      |
| Exceldest.dll                                        | 2022.160.4115.5  | 284728    | 04-Mar-2024 | 09:29 | x64      |
| Excelsrc.dll                                         | 2022.160.4115.5  | 305208    | 04-Mar-2024 | 09:29 | x64      |
| Execpackagetask.dll                                  | 2022.160.4115.5  | 182312    | 04-Mar-2024 | 09:28 | x64      |
| Flatfiledest.dll                                     | 2022.160.4115.5  | 423976    | 04-Mar-2024 | 09:29 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4115.5  | 440272    | 04-Mar-2024 | 09:29 | x64      |
| Logread.exe                                          | 2022.160.4115.5  | 792616    | 04-Mar-2024 | 09:29 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.229      | 2933808   | 04-Mar-2024 | 09:25 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 04-Mar-2024 | 09:29 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4115.5      | 30656     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4115.5      | 391104    | 04-Mar-2024 | 09:28 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4115.5  | 1710136   | 04-Mar-2024 | 09:29 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4115.5      | 555048    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 04-Mar-2024 | 09:29 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4115.5  | 124864    | 04-Mar-2024 | 09:29 | x64      |
| Msgprox.dll                                          | 2022.160.4115.5  | 313384    | 04-Mar-2024 | 09:29 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0     | 2729960   | 04-Mar-2024 | 09:29 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0     | 153560    | 04-Mar-2024 | 09:29 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 04-Mar-2024 | 09:29 | x86      |
| Oledbdest.dll                                        | 2022.160.4115.5  | 288808    | 04-Mar-2024 | 09:29 | x64      |
| Oledbsrc.dll                                         | 2022.160.4115.5  | 313384    | 04-Mar-2024 | 09:29 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4115.5  | 526376    | 04-Mar-2024 | 09:29 | x64      |
| Rawdest.dll                                          | 2022.160.4115.5  | 227368    | 04-Mar-2024 | 09:29 | x64      |
| Rawsource.dll                                        | 2022.160.4115.5  | 215096    | 04-Mar-2024 | 09:29 | x64      |
| Rdistcom.dll                                         | 2022.160.4115.5  | 940072    | 04-Mar-2024 | 09:29 | x64      |
| Recordsetdest.dll                                    | 2022.160.4115.5  | 206888    | 04-Mar-2024 | 09:29 | x64      |
| Repldp.dll                                           | 2022.160.4115.5  | 337976    | 04-Mar-2024 | 09:29 | x64      |
| Replerrx.dll                                         | 2022.160.4115.5  | 198696    | 04-Mar-2024 | 09:28 | x64      |
| Replisapi.dll                                        | 2022.160.4115.5  | 419880    | 04-Mar-2024 | 09:29 | x64      |
| Replmerg.exe                                         | 2022.160.4115.5  | 596008    | 04-Mar-2024 | 09:29 | x64      |
| Replprov.dll                                         | 2022.160.4115.5  | 890920    | 04-Mar-2024 | 09:29 | x64      |
| Replrec.dll                                          | 2022.160.4115.5  | 1058856   | 04-Mar-2024 | 09:29 | x64      |
| Replsub.dll                                          | 2022.160.4115.5  | 501800    | 04-Mar-2024 | 09:29 | x64      |
| Spresolv.dll                                         | 2022.160.4115.5  | 301096    | 04-Mar-2024 | 09:29 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4115.5  | 137256    | 04-Mar-2024 | 09:25 | x64      |
| Sqlcmd.exe                                           | 2022.160.4115.5  | 276408    | 04-Mar-2024 | 09:29 | x64      |
| Sqldiag.exe                                          | 2022.160.4115.5  | 1140672   | 04-Mar-2024 | 09:29 | x64      |
| Sqldistx.dll                                         | 2022.160.4115.5  | 268328    | 04-Mar-2024 | 09:29 | x64      |
| Sqlmergx.dll                                         | 2022.160.4115.5  | 423992    | 04-Mar-2024 | 09:29 | x64      |
| Sqlsvc.dll                                           | 2022.160.4115.5  | 153536    | 04-Mar-2024 | 09:29 | x86      |
| Sqlsvc.dll                                           | 2022.160.4115.5  | 194496    | 04-Mar-2024 | 09:29 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4115.5  | 211000    | 04-Mar-2024 | 09:29 | x64      |
| Ssradd.dll                                           | 2022.160.4115.5  | 100392    | 04-Mar-2024 | 09:28 | x64      |
| Ssravg.dll                                           | 2022.160.4115.5  | 100392    | 04-Mar-2024 | 09:29 | x64      |
| Ssrmax.dll                                           | 2022.160.4115.5  | 100392    | 04-Mar-2024 | 09:29 | x64      |
| Ssrmin.dll                                           | 2022.160.4115.5  | 100408    | 04-Mar-2024 | 09:28 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 04-Mar-2024 | 09:29 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 04-Mar-2024 | 09:29 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 04-Mar-2024 | 09:29 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 04-Mar-2024 | 09:29 | x86      |
| Txagg.dll                                            | 2022.160.4115.5  | 395320    | 04-Mar-2024 | 09:29 | x64      |
| Txbdd.dll                                            | 2022.160.4115.5  | 190504    | 04-Mar-2024 | 09:29 | x64      |
| Txdatacollector.dll                                  | 2022.160.4115.5  | 469032    | 04-Mar-2024 | 09:29 | x64      |
| Txdataconvert.dll                                    | 2022.160.4115.5  | 333864    | 04-Mar-2024 | 09:29 | x64      |
| Txderived.dll                                        | 2022.160.4115.5  | 632888    | 04-Mar-2024 | 09:29 | x64      |
| Txlookup.dll                                         | 2022.160.4115.5  | 608296    | 04-Mar-2024 | 09:29 | x64      |
| Txmerge.dll                                          | 2022.160.4115.5  | 243752    | 04-Mar-2024 | 09:29 | x64      |
| Txmergejoin.dll                                      | 2022.160.4115.5  | 301096    | 04-Mar-2024 | 09:29 | x64      |
| Txmulticast.dll                                      | 2022.160.4115.5  | 145448    | 04-Mar-2024 | 09:29 | x64      |
| Txrowcount.dll                                       | 2022.160.4115.5  | 145464    | 04-Mar-2024 | 09:29 | x64      |
| Txsort.dll                                           | 2022.160.4115.5  | 276520    | 04-Mar-2024 | 09:29 | x64      |
| Txsplit.dll                                          | 2022.160.4115.5  | 620584    | 04-Mar-2024 | 09:29 | x64      |
| Txunionall.dll                                       | 2022.160.4115.5  | 194600    | 04-Mar-2024 | 09:29 | x64      |
| Xe.dll                                               | 2022.160.4115.5  | 718888    | 04-Mar-2024 | 09:29 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4115.5 | 100288    | 04-Mar-2024 | 09:29 | x64      |
| Exthost.exe                   | 2022.160.4115.5 | 247848    | 04-Mar-2024 | 09:29 | x64      |
| Launchpad.exe                 | 2022.160.4115.5 | 1447976   | 04-Mar-2024 | 09:29 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |
| Sqlsatellite.dll              | 2022.160.4115.5 | 1255376   | 04-Mar-2024 | 09:29 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4115.5 | 710712    | 04-Mar-2024 | 09:29 | x64      |
| Fdhost.exe               | 2022.160.4115.5 | 153640    | 04-Mar-2024 | 09:29 | x64      |
| Fdlauncher.exe           | 2022.160.4115.5 | 100408    | 04-Mar-2024 | 09:29 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 04-Mar-2024 | 09:29 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 04-Mar-2024 | 09:29 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 04-Mar-2024 | 09:29 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 04-Mar-2024 | 09:29 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 04-Mar-2024 | 09:29 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 04-Mar-2024 | 09:29 | x86      |
| Commanddest.dll                                               | 2022.160.4115.5 | 272440    | 04-Mar-2024 | 09:29 | x64      |
| Commanddest.dll                                               | 2022.160.4115.5 | 231360    | 04-Mar-2024 | 09:29 | x86      |
| Dteparse.dll                                                  | 2022.160.4115.5 | 116672    | 04-Mar-2024 | 09:29 | x86      |
| Dteparse.dll                                                  | 2022.160.4115.5 | 133160    | 04-Mar-2024 | 09:29 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4115.5 | 178232    | 04-Mar-2024 | 09:29 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4115.5 | 165928    | 04-Mar-2024 | 09:29 | x86      |
| Dtepkg.dll                                                    | 2022.160.4115.5 | 129064    | 04-Mar-2024 | 09:29 | x86      |
| Dtepkg.dll                                                    | 2022.160.4115.5 | 153656    | 04-Mar-2024 | 09:29 | x64      |
| Dtexec.exe                                                    | 2022.160.4115.5 | 64960     | 04-Mar-2024 | 09:29 | x86      |
| Dtexec.exe                                                    | 2022.160.4115.5 | 76752     | 04-Mar-2024 | 09:29 | x64      |
| Dts.dll                                                       | 2022.160.4115.5 | 3266496   | 04-Mar-2024 | 09:29 | x64      |
| Dts.dll                                                       | 2022.160.4115.5 | 2860992   | 04-Mar-2024 | 09:29 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4115.5 | 493608    | 04-Mar-2024 | 09:29 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4115.5 | 444352    | 04-Mar-2024 | 09:29 | x86      |
| Dtsconn.dll                                                   | 2022.160.4115.5 | 550952    | 04-Mar-2024 | 09:29 | x64      |
| Dtsconn.dll                                                   | 2022.160.4115.5 | 464832    | 04-Mar-2024 | 09:29 | x86      |
| Dtsdebughost.exe                                              | 2022.160.4115.5 | 114728    | 04-Mar-2024 | 09:29 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4115.5 | 94656     | 04-Mar-2024 | 09:29 | x86      |
| Dtshost.exe                                                   | 2022.160.4115.5 | 120376    | 04-Mar-2024 | 09:29 | x64      |
| Dtshost.exe                                                   | 2022.160.4115.5 | 98256     | 04-Mar-2024 | 09:29 | x86      |
| Dtslog.dll                                                    | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:29 | x64      |
| Dtslog.dll                                                    | 2022.160.4115.5 | 120888    | 04-Mar-2024 | 09:29 | x86      |
| Dtspipeline.dll                                               | 2022.160.4115.5 | 1337280   | 04-Mar-2024 | 09:29 | x64      |
| Dtspipeline.dll                                               | 2022.160.4115.5 | 1144768   | 04-Mar-2024 | 09:29 | x86      |
| Dtuparse.dll                                                  | 2022.160.4115.5 | 88016     | 04-Mar-2024 | 09:29 | x86      |
| Dtuparse.dll                                                  | 2022.160.4115.5 | 104384    | 04-Mar-2024 | 09:29 | x64      |
| Dtutil.exe                                                    | 2022.160.4115.5 | 142376    | 04-Mar-2024 | 09:29 | x86      |
| Dtutil.exe                                                    | 2022.160.4115.5 | 166456    | 04-Mar-2024 | 09:29 | x64      |
| Exceldest.dll                                                 | 2022.160.4115.5 | 284728    | 04-Mar-2024 | 09:29 | x64      |
| Exceldest.dll                                                 | 2022.160.4115.5 | 247848    | 04-Mar-2024 | 09:29 | x86      |
| Excelsrc.dll                                                  | 2022.160.4115.5 | 305208    | 04-Mar-2024 | 09:29 | x64      |
| Excelsrc.dll                                                  | 2022.160.4115.5 | 264128    | 04-Mar-2024 | 09:29 | x86      |
| Execpackagetask.dll                                           | 2022.160.4115.5 | 182312    | 04-Mar-2024 | 09:29 | x64      |
| Execpackagetask.dll                                           | 2022.160.4115.5 | 149544    | 04-Mar-2024 | 09:29 | x86      |
| Flatfiledest.dll                                              | 2022.160.4115.5 | 423976    | 04-Mar-2024 | 09:29 | x64      |
| Flatfiledest.dll                                              | 2022.160.4115.5 | 374824    | 04-Mar-2024 | 09:29 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4115.5 | 440272    | 04-Mar-2024 | 09:29 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4115.5 | 391120    | 04-Mar-2024 | 09:29 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4115.5     | 120768    | 04-Mar-2024 | 09:29 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4115.5     | 120768    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.229     | 2933808   | 04-Mar-2024 | 09:25 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.229     | 2933696   | 04-Mar-2024 | 09:25 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4115.5     | 509888    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4115.5     | 509904    | 04-Mar-2024 | 09:29 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4115.5     | 391104    | 04-Mar-2024 | 09:29 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4115.5     | 219192    | 04-Mar-2024 | 09:29 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4115.5 | 124864    | 04-Mar-2024 | 09:29 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4115.5 | 100408    | 04-Mar-2024 | 09:29 | x86      |
| Msmdpp.dll                                                    | 2022.160.43.229 | 10164776  | 04-Mar-2024 | 09:25 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 04-Mar-2024 | 09:29 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 04-Mar-2024 | 09:29 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 04-Mar-2024 | 09:29 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 04-Mar-2024 | 09:29 | x86      |
| Odbcdest.dll                                                  | 2022.160.4115.5 | 382912    | 04-Mar-2024 | 09:29 | x64      |
| Odbcdest.dll                                                  | 2022.160.4115.5 | 342056    | 04-Mar-2024 | 09:29 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4115.5 | 399400    | 04-Mar-2024 | 09:29 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4115.5 | 350160    | 04-Mar-2024 | 09:29 | x86      |
| Oledbdest.dll                                                 | 2022.160.4115.5 | 288808    | 04-Mar-2024 | 09:29 | x64      |
| Oledbdest.dll                                                 | 2022.160.4115.5 | 247848    | 04-Mar-2024 | 09:29 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4115.5 | 313384    | 04-Mar-2024 | 09:29 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4115.5 | 268224    | 04-Mar-2024 | 09:29 | x86      |
| Rawdest.dll                                                   | 2022.160.4115.5 | 227368    | 04-Mar-2024 | 09:29 | x64      |
| Rawdest.dll                                                   | 2022.160.4115.5 | 190400    | 04-Mar-2024 | 09:29 | x86      |
| Rawsource.dll                                                 | 2022.160.4115.5 | 215096    | 04-Mar-2024 | 09:29 | x64      |
| Rawsource.dll                                                 | 2022.160.4115.5 | 186320    | 04-Mar-2024 | 09:29 | x86      |
| Recordsetdest.dll                                             | 2022.160.4115.5 | 206888    | 04-Mar-2024 | 09:29 | x64      |
| Recordsetdest.dll                                             | 2022.160.4115.5 | 174016    | 04-Mar-2024 | 09:29 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4115.5 | 137256    | 04-Mar-2024 | 09:25 | x64      |
| Sqlceip.exe                                                   | 16.0.4115.5     | 300992    | 04-Mar-2024 | 09:29 | x86      |
| Sqldest.dll                                                   | 2022.160.4115.5 | 288704    | 04-Mar-2024 | 09:29 | x64      |
| Sqldest.dll                                                   | 2022.160.4115.5 | 256056    | 04-Mar-2024 | 09:29 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4115.5 | 211000    | 04-Mar-2024 | 09:29 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4115.5 | 174136    | 04-Mar-2024 | 09:29 | x86      |
| Txagg.dll                                                     | 2022.160.4115.5 | 395320    | 04-Mar-2024 | 09:29 | x64      |
| Txagg.dll                                                     | 2022.160.4115.5 | 346064    | 04-Mar-2024 | 09:29 | x86      |
| Txbdd.dll                                                     | 2022.160.4115.5 | 190504    | 04-Mar-2024 | 09:29 | x64      |
| Txbdd.dll                                                     | 2022.160.4115.5 | 149544    | 04-Mar-2024 | 09:29 | x86      |
| Txbestmatch.dll                                               | 2022.160.4115.5 | 661544    | 04-Mar-2024 | 09:29 | x64      |
| Txbestmatch.dll                                               | 2022.160.4115.5 | 567336    | 04-Mar-2024 | 09:29 | x86      |
| Txcache.dll                                                   | 2022.160.4115.5 | 202808    | 04-Mar-2024 | 09:29 | x64      |
| Txcache.dll                                                   | 2022.160.4115.5 | 169936    | 04-Mar-2024 | 09:29 | x86      |
| Txcharmap.dll                                                 | 2022.160.4115.5 | 325584    | 04-Mar-2024 | 09:29 | x64      |
| Txcharmap.dll                                                 | 2022.160.4115.5 | 280512    | 04-Mar-2024 | 09:29 | x86      |
| Txcopymap.dll                                                 | 2022.160.4115.5 | 202792    | 04-Mar-2024 | 09:29 | x64      |
| Txcopymap.dll                                                 | 2022.160.4115.5 | 165824    | 04-Mar-2024 | 09:29 | x86      |
| Txdataconvert.dll                                             | 2022.160.4115.5 | 288808    | 04-Mar-2024 | 09:29 | x86      |
| Txdataconvert.dll                                             | 2022.160.4115.5 | 333864    | 04-Mar-2024 | 09:29 | x64      |
| Txderived.dll                                                 | 2022.160.4115.5 | 632888    | 04-Mar-2024 | 09:29 | x64      |
| Txderived.dll                                                 | 2022.160.4115.5 | 559144    | 04-Mar-2024 | 09:29 | x86      |
| Txfileextractor.dll                                           | 2022.160.4115.5 | 219176    | 04-Mar-2024 | 09:29 | x64      |
| Txfileextractor.dll                                           | 2022.160.4115.5 | 186304    | 04-Mar-2024 | 09:29 | x86      |
| Txfileinserter.dll                                            | 2022.160.4115.5 | 219176    | 04-Mar-2024 | 09:29 | x64      |
| Txfileinserter.dll                                            | 2022.160.4115.5 | 186320    | 04-Mar-2024 | 09:29 | x86      |
| Txgroupdups.dll                                               | 2022.160.4115.5 | 403496    | 04-Mar-2024 | 09:29 | x64      |
| Txgroupdups.dll                                               | 2022.160.4115.5 | 354256    | 04-Mar-2024 | 09:29 | x86      |
| Txlineage.dll                                                 | 2022.160.4115.5 | 157752    | 04-Mar-2024 | 09:29 | x64      |
| Txlineage.dll                                                 | 2022.160.4115.5 | 128960    | 04-Mar-2024 | 09:29 | x86      |
| Txlookup.dll                                                  | 2022.160.4115.5 | 608296    | 04-Mar-2024 | 09:29 | x64      |
| Txlookup.dll                                                  | 2022.160.4115.5 | 522176    | 04-Mar-2024 | 09:29 | x86      |
| Txmerge.dll                                                   | 2022.160.4115.5 | 194496    | 04-Mar-2024 | 09:29 | x86      |
| Txmerge.dll                                                   | 2022.160.4115.5 | 243752    | 04-Mar-2024 | 09:29 | x64      |
| Txmergejoin.dll                                               | 2022.160.4115.5 | 301096    | 04-Mar-2024 | 09:29 | x64      |
| Txmergejoin.dll                                               | 2022.160.4115.5 | 255936    | 04-Mar-2024 | 09:29 | x86      |
| Txmulticast.dll                                               | 2022.160.4115.5 | 145448    | 04-Mar-2024 | 09:29 | x64      |
| Txmulticast.dll                                               | 2022.160.4115.5 | 116672    | 04-Mar-2024 | 09:29 | x86      |
| Txpivot.dll                                                   | 2022.160.4115.5 | 239656    | 04-Mar-2024 | 09:29 | x64      |
| Txpivot.dll                                                   | 2022.160.4115.5 | 198592    | 04-Mar-2024 | 09:29 | x86      |
| Txrowcount.dll                                                | 2022.160.4115.5 | 145464    | 04-Mar-2024 | 09:29 | x64      |
| Txrowcount.dll                                                | 2022.160.4115.5 | 116792    | 04-Mar-2024 | 09:29 | x86      |
| Txsampling.dll                                                | 2022.160.4115.5 | 186408    | 04-Mar-2024 | 09:29 | x64      |
| Txsampling.dll                                                | 2022.160.4115.5 | 153536    | 04-Mar-2024 | 09:29 | x86      |
| Txscd.dll                                                     | 2022.160.4115.5 | 235576    | 04-Mar-2024 | 09:29 | x64      |
| Txscd.dll                                                     | 2022.160.4115.5 | 198696    | 04-Mar-2024 | 09:29 | x86      |
| Txsort.dll                                                    | 2022.160.4115.5 | 276520    | 04-Mar-2024 | 09:29 | x64      |
| Txsort.dll                                                    | 2022.160.4115.5 | 231464    | 04-Mar-2024 | 09:29 | x86      |
| Txsplit.dll                                                   | 2022.160.4115.5 | 620584    | 04-Mar-2024 | 09:29 | x64      |
| Txsplit.dll                                                   | 2022.160.4115.5 | 550952    | 04-Mar-2024 | 09:29 | x86      |
| Txtermextraction.dll                                          | 2022.160.4115.5 | 8702008   | 04-Mar-2024 | 09:29 | x64      |
| Txtermextraction.dll                                          | 2022.160.4115.5 | 8648744   | 04-Mar-2024 | 09:29 | x86      |
| Txtermlookup.dll                                              | 2022.160.4115.5 | 4184104   | 04-Mar-2024 | 09:29 | x64      |
| Txtermlookup.dll                                              | 2022.160.4115.5 | 4139048   | 04-Mar-2024 | 09:29 | x86      |
| Txunionall.dll                                                | 2022.160.4115.5 | 194600    | 04-Mar-2024 | 09:29 | x64      |
| Txunionall.dll                                                | 2022.160.4115.5 | 153640    | 04-Mar-2024 | 09:29 | x86      |
| Txunpivot.dll                                                 | 2022.160.4115.5 | 215080    | 04-Mar-2024 | 09:29 | x64      |
| Txunpivot.dll                                                 | 2022.160.4115.5 | 178112    | 04-Mar-2024 | 09:29 | x86      |
| Xe.dll                                                        | 2022.160.4115.5 | 718888    | 04-Mar-2024 | 09:29 | x64      |
| Xe.dll                                                        | 2022.160.4115.5 | 640968    | 04-Mar-2024 | 09:29 | x86      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1032.0     | 559672    | 04-Mar-2024 | 10:15 | x86      |
| Dmsnative.dll                                                        | 2022.160.1032.0 | 152632    | 04-Mar-2024 | 10:15 | x64      |
| Dwengineservice.dll                                                  | 16.0.1032.0     | 45120     | 04-Mar-2024 | 10:15 | x86      |
| Instapi150.dll                                                       | 2022.160.4115.5 | 104504    | 04-Mar-2024 | 10:15 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1032.0     | 67640     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1032.0     | 293432    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1032.0     | 1958464   | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1032.0     | 169528    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1032.0     | 647232    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1032.0     | 246328    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1032.0     | 139320    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1032.0     | 79928     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1032.0     | 51256     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1032.0     | 88624     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1032.0     | 1129528   | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1032.0     | 80952     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1032.0     | 70712     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1032.0     | 35384     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1032.0     | 30784     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1032.0     | 46648     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1032.0     | 21552     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1032.0     | 26680     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1032.0     | 131648    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1032.0     | 86584     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1032.0     | 100928    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1032.0     | 293432    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 120384    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 138304    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 141368    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 137792    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 150584    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 139840    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 134712    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 176696    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 117824    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 136760    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1032.0     | 72760     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1032.0     | 22072     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1032.0     | 37432     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1032.0     | 129088    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1032.0     | 3064896   | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1032.0     | 3955768   | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 118336    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 133176    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 137784    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 133688    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 148544    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 134200    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 130616    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 171064    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 115256    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 132160    | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1032.0     | 67640     | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1032.0     | 2682936   | 04-Mar-2024 | 10:15 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1032.0     | 2436664   | 04-Mar-2024 | 10:15 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4115.5 | 296912    | 04-Mar-2024 | 10:15 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4115.5 | 9074624   | 04-Mar-2024 | 10:15 | x64      |
| Secforwarder.dll                                                     | 2022.160.4115.5 | 83904     | 04-Mar-2024 | 10:15 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1032.0 | 61488     | 04-Mar-2024 | 10:15 | x64      |
| Sqldk.dll                                                            | 2022.160.4115.5 | 4012072   | 04-Mar-2024 | 10:15 | x64      |
| Sqldumper.exe                                                        | 2022.160.4115.5 | 448552    | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 1750976   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4585408   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 3758016   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4585408   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4487104   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 2447296   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 2389952   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4216784   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4200384   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 1689536   | 04-Mar-2024 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4115.5 | 4450240   | 04-Mar-2024 | 10:15 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 04-Mar-2024 | 10:15 | x64      |
| Sqlos.dll                                                            | 2022.160.4115.5 | 51240     | 04-Mar-2024 | 10:15 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1032.0 | 4841536   | 04-Mar-2024 | 10:15 | x64      |
| Sqltses.dll                                                          | 2022.160.4115.5 | 10668072  | 04-Mar-2024 | 10:15 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
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

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
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
