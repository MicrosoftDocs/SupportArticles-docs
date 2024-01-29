---
title: Cumulative update 21 for SQL Server 2019 (KB5025808)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 21 (KB5025808).
ms.date: 09/19/2023
ms.custom: KB5025808
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5025808 - Cumulative Update 21 for SQL Server 2019

_Release Date:_ &nbsp; June 15, 2023  
_Version:_ &nbsp; 15.0.4316.3

## Summary

This article describes Cumulative Update package 21 (CU21) for Microsoft SQL Server 2019. This update contains 29 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 20, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4316.3**, file version: **2019.150.4316.3**
- Analysis Services - Product version: **15.0.35.39**, file version: **2018.150.35.39**

## Known issues in this update

### Issue one: Access violation when session is reset

SQL Server 2019 CU14 introduced a [fix to address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the SESSION is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.

Microsoft is working on a fix for this issue and it will be available in a future CU.

### Issue two

This issue is caused by a change introduced in SQL Server 2019 CU20 for the [Managed Instance link](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview) feature. Assume that the databases of an Always On availability group have one of the following conditions:

- The databases use memory-optimized tables, the FileStream class, or multiple log files.

- You upgrade a replica to this cumulative update. For example, the primary replica is upgraded to SQL Server 2019 CU21, and the secondary replica remains SQL Server 2019 CU19.

- The databases indicate the "Not Synchronizing" status.

- You review the `sys.dm_exec_requests` DMV and notice the `DB STARTUP` command is blocked on wait `HADR_RECOVERY_WAIT_FOR_UNDO`.

In this scenario, you restart the SQL Server instance hosting the primary replica of the availability group. Then the databases start to synchronize. Additionally, you might notice the following error messages logged in the SQL Server error log and Extended Event logs:

>  Error 9642, Severity 16, State 3: An error occurred in a Service Broker/Database Mirroring transport connection endpoint. Error: 8474, State: 11. (Near endpoint role: target, far endpoint address: '') 

If you have applied this cumulative update to one or more secondary replicas and are currently not synchronizing with the primary replica, you can use the following steps to mitigate this issue:

1. Add trace flag 12324 as a startup parameter on all replicas (including the primary replica). Restart the secondary replicas to activate this trace flag. Meanwhile, the primary replica should be synchronized with all secondary replicas restarted with trace flag 12324 as the startup parameter.

2. After all secondary replicas are updated and restarted, fail over the primary replica, now as a secondary role, and restart it to enable trace flag 12324.

3. Apply this cumulative update to the old primary replica and restart it in the secondary role.

4. Remove trace flag 12324 as the startup parameter from all replicas, and disable trace flag 12324 on all replicas by executing the `DBCC TRACEOFF(12324, -1)` statement.

> [!NOTE]
> Trace flag 12324 impacts only the Managed Instance Link feature and is only used to activate the changes in SQL Server 2019 CU20 and CU21.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

|Bug reference| Description| Fix area| Component | Platform |
|:-------------------------------------------------:|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|-------------------------------------------|----------|
| <a id="2354551">[2354551](#2354551)</a> | Adds an option for the Master Data Services (MDS) configuration tool to decide whether to enable the **PerformanceImprovementEnable** performance improvement setting. |Master Data Services | Master Data Services | Windows|
| <a id="2367741">[2367741](#2367741)</a> | Fixes an issue where a hierarchy created in Master Data Services (MDS) doesn't expand correctly (on both the **Edit Derived Hierarchy** page and the **Hierarchy** page in the Explorer area). | Master Data Services | Master Data Services | Windows |
| <a id="2375656">[2375656](#2375656)</a> | Fixes the following error that you may encounter when selecting any cell of a domain-based attribute column that has a different name and display name in a Master Data Services (MDS) entity and then selecting the drop-down arrow: </br></br>The current cell column title was not found. If the column title was changed, close the sheet and try again. | Master Data Services | Master Data Services | Windows |
| <a id="2385119">[2385119](#2385119)</a> | Updates the support for predicate pushdown when filtering on the `session_id` column of the `sys.dm_exec_connections` dynamic management view (DMV). | SQL Connectivity | SQL Connectivity | All |
| <a id="2405054">[2405054](#2405054)</a> | Updates the version of the Microsoft ODBC driver to 17.10.4.1. For more information, see [Release Notes for Microsoft ODBC Driver for SQL Server on Windows](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows). | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2405058">[2405058](#2405058)</a> | Updates the version of the Microsoft OLE DB driver to 18.6.6. For more information, see [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server). | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2405087">[2405087](#2405087)</a> | Fixes an issue where applying the option `ONLINE` in the `ALTER INDEX REBUILD` statement is invalid when running the index rebuild task created in an index maintenance plan. | SQL Server Client Tools | Management Services | All |
| <a id="2399354">[2399354](#2399354)</a> | Consider the following scenario: </br></br>- You have an instance of SQL Server that connects to Microsoft Entra ID. </br></br>- You enable Transport Layer Security (TLS) encryption on this instance of SQL Server. </br></br>In this scenario, you may receive the following error 39011 if you run the `sp_execute_external_script` query against the instance: </br></br>Msg 39011, Level 16, State 7, Line \<LineNumber> </br>SQL Server was unable to communicate with the LaunchPad service for request id: \<ID>. Please verify the configuration of the service. | SQL Server Engine | Extensibility | Linux |
| <a id="2375469">[2375469](#2375469)</a> | Fixes an issue where the following error occurs when you disable the FILESTREAM feature on a SQL Server failover cluster instance (FCI) by using SQL Server Configuration Manager (SSCM): </br></br>There was an unknown error applying FILESTREAM settings. </br>Check the parameters are valid. (0x800713d6) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="2195940">[2195940](#2195940)</a> | Fixes an issue where messages in the `sys.transmission_queue` of the initiator database in a SQL Server Service Broker conversation are missing or stuck after a failover of the target database.| SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="2101590">[2101590](#2101590)</a> | Fixes an issue where restoring an In-Memory OLTP database backup that has Transparent data encryption (TDE) enabled fails and returns the following error message: </br></br>Error: 33126, Severity: 16, State: 1. </br>Database encryption key is corrupted and cannot be read. </br></br>**Note**: To apply this fix, you need to enable a trace flag (TF) to relax TDE checks for In-Memory tables and disable the TF after the restoration is completed. For more information, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support). | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2184943">[2184943](#2184943)</a> | Fixes an assertion dump issue (Location: "sql\\\ntdbms\\\hekaton\\\engine\\\core\\\tx.cpp":4753; Expression: 0 == Dependencies.CommitDepCountOut) that causes an availability group failover. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2347043">[2347043](#2347043)</a> | Provides the details of the corrupt checkpoint file that's associated with the in-memory database when you try to restore a database but it fails with the following error: </br></br>[ERROR] Recovery failed with error 0x84000004 on database 10. This error will be mapped to 'HK_E_RESTORE_ABORTED' (0x82000018). (sql\ntdbms\hekaton\runtime\src\hkruntime.cpp : 5051 - 'HkRtRestoreDatabase') | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2401115">[2401115](#2401115)</a> | Fixes a dump issue where a huge number of concurrent In-Memory OLTP transactions cause a stack overflow. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2404944">[2404944](#2404944)</a> | Removes the need for running the `sys.sp_xtp_force_gc` stored procedure twice to free up allocated and used XTP memory, and running it once is enough. You need at least the `ALTER SERVER STATE` permission to run this procedure. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2312800">[2312800](#2312800)</a> | Fixes an issue where external data sources that use the generic ODBC connector may not work after you install SQL Server 2019 CU19 or later versions. You may encounter the following scenarios: </br></br>- When you try to query an external table that was created before you install this fix on a generic ODBC data source, and the `CONNECTION_OPTIONS` argument uses a `DSN` parameter without the `Driver` keyword, you receive the following error message: </br></br>Msg 7320, Level 16, State 110, Line \<LineNumber> </br>Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object. </br></br>- If you try to create a new external table, you receive the following error message: </br></br>Msg 110813, Level 16, State 1, Line \<LineNumber> </br>Object reference not set to an instance of an object. </br></br>**Note**: Before you apply this fix, you can uninstall SQL Server 2019 CU19 or later versions, or add the `Driver` keyword to the `CONNECTION_OPTIONS` argument as a workaround. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873). | SQL Server Engine | PolyBase | Windows |
| <a id="2117672">[2117672](#2117672)</a> | Fixes an issue that can cause the query execution to encounter an access violation error when the query has an aggregate function or a `GROUP BY` clause against a columnstore table that contains data in uncompressed row groups, and the cleanup may sometimes not complete correctly. </br></br>**Note**: Before you apply this cumulative update, you can rebuild the columnstore index to move all data into compressed row groups as a workaround. | SQL Server Engine | Query Execution | Windows |
| <a id="2346939">[2346939](#2346939)</a> | Fixes an assertion failure (Location: tmpilb.cpp:3540; Expression: RTL_ASSERTSZ(fFalse, "Attempt to access expired blob handle (1)")) and the following errors that you encounter when you run a common language runtime (CLR) stored procedure twice: </br></br>Msg 3624, Level 20, State 1, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command.&nbsp;&nbsp;The results, if any, should be discarded. | SQL Server Engine | Query Execution | All |
| <a id="2307898">[2307898](#2307898)</a> | Fixes incorrect results for queries that filter on `ROW_NUMBER` and involve nullable columns. | SQL Server Engine | Query Optimizer | All |
| <a id="2313620">[2313620](#2313620)</a> | Fixes the following errors and access violations that are caused by an incorrect plan in the case of multiple occurrences of the same scalar subquery: </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command.&nbsp;&nbsp;The results, if any, should be discarded. | SQL Server Engine | Query Optimizer | All |
| <a id="2363303">[2363303](#2363303)</a> | Improves the cardinality estimation (CE) for "`AND`" conjunctions that are composed of point predicates when the predicates have a multi-column statistic covering them, and the predicate values are outside the histogram bounds. | SQL Server Engine | Query Optimizer | All |
| <a id="2391556">[2391556](#2391556)</a> | Fixes inconsistent results that are caused by the parallel spool in the plan for the `INSERT`, `UPDATE`, or `DELETE` query. | SQL Server Engine | Query Optimizer | All |
| <a id="2266806">[2266806](#2266806)</a> | Adds a new error 673 that helps avoid the assertion failure (Location: IndexRowScanner.cpp:1449; Expression: m_versionStatus.IsVisible ()) that you might encounter when you enable change tracking on a database that has snapshot isolation turned on. </br></br>Error message: </br></br>Failure to access row object in snapshot isolation. </br></br>**Note**: You need to turn on trace flag 8285. | SQL Server Engine | Replication | All |
| <a id="2320889">[2320889](#2320889)</a> | Fixes an issue where applying an update on a secondary replica or performing an in-place upgrade fails when the distribution database is in an availability group. The following error is returned: </br></br>Error: There was an error executing the Replication upgrade scripts. See the SQL Server error log for details. </br></br>You can see the following error details in the SQL Server error log: </br></br>Executing sp_vupgrade_replication. </br>Could not open distribution database distribution because it is offline or being recovered. Replication settings and system objects could not be upgraded. Be sure this database is available and run sp_vupgrade_replication again. | SQL Server Engine | Replication | Windows |
| <a id="2421435">[2421435](#2421435)</a>| Fixes a manual cleanup issue where the repeated lock escalations on the tables cause contention and slowness in cleaning up the expired change tracking metadata. </br></br>**Note**: You need to turn on trace flag 8284. | SQL Server Engine | Replication | All |
| <a id="2397659">[2397659](#2397659)</a> | [FIX: SQL Server Audit Events fail to write to the Security log (KB4052136)](https://support.microsoft.com/help/4052136) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2409008">[2409008](#2409008)</a> | Fixes error 207 (Invalid column name '\<ColumnName>') that you encounter when you run a user-defined function (UDF), which references a dropped column that uses dynamic data masking (DDM). | SQL Server Engine | Security Infrastructure | All |
| <a id="2410400">[2410400](#2410400)</a> | `SOS_BLOCKALLOCPARTIALLIST` spinlock contention and elevated CPU utilization occur on large-memory machines. </br></br>`DBCC DROPCLEANBUFFERS` provides temporary mitigation for this issue when encountered. </br></br>This occurs when multiple threads concurrently attempt to gain access to a spinlock-protected list used by the SQL operating system for memory management purposes. </br></br>The following trace flags are required to enable the fix: </br></br>- TF 8142 partitions list by count of CPU, up to 64 partitions </br></br>- TF 8145 modifies the partitioning to be count of soft-NUMA nodes </br></br>These trace flags must be applied as startup parameters to take effect. </br></br>If `SOS_BLOCKALLOCPARTIALLIST` spinlock contention is encountered and `DBCC DROPCLEANBUFFERS` provides temporary mitigation, it's recommended to apply this fix first with both trace flags, and remove Trace Flag 8145 only if symptoms persist. | SQL Server Engine | SQL OS | All |
| <a id="2330957">[2330957](#2330957)</a> | Fixes the following error that you encounter on the target instance when configuring a Service Broker communication with transport security and the certificate serial number length is greater than 16 bytes: </br></br>The certificate serial number size is 19, however it must be no greater than 16 bytes in length. This occurred in the message with Conversation ID, Initiator: 1, and Message sequence number: 0. | SQL Server Engine | SQL Server Engine | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU21 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2023/06/sqlserver2019-kb5025808-x64_b4935d744a9f5abb67d43fac573ff059cb82f8c1.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5025808-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5025808-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5025808-x64.exe| CEB4C5C070E17EC83C4E4CA7B75109B40176673B614892C602D249DBE5FBA7D2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |   Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.39  | 292776    | 1-Jun-23 | 17:10 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 1-Jun-23 | 17:10 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.39      | 758224    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 175568    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 199632    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 202192    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 198608    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 214992    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 197584    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 193488    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 252368    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 174032    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 197072    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.39      | 1098664   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.39      | 567248    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 54696     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 59304     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 59816     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58832     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 61864     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58320     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58320     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 67496     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 53712     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58280     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 18896     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17832     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 1-Jun-23 | 17:10 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 1-Jun-23 | 17:10 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 1-Jun-23 | 17:10 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 1-Jun-23 | 17:10 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 1-Jun-23 | 17:10 | x86      |
| Msmdctr.dll                                               | 2018.150.35.39  | 38352     | 1-Jun-23 | 17:10 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.39  | 66299856  | 1-Jun-23 | 17:10 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.39  | 47787944  | 1-Jun-23 | 17:10 | x86      |
| Msmdpump.dll                                              | 2018.150.35.39  | 10189736  | 1-Jun-23 | 17:10 | x64      |
| Msmdredir.dll                                             | 2018.150.35.39  | 7957928   | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16848     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17360     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17320     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17320     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17360     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 18344     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 1-Jun-23 | 17:10 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 1-Jun-23 | 17:10 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.39  | 65835472  | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 833448    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1628072   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1454032   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1642960   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1608608   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1001376   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 992720    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1536976   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1521576   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 810920    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1596368   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 832464    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1624528   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1450960   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1637840   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1604560   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 998864    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 991184    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1532880   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1518032   | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 809936    | 1-Jun-23 | 17:10 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1591760   | 1-Jun-23 | 17:10 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.39  | 10187176  | 1-Jun-23 | 17:10 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.39  | 8281000   | 1-Jun-23 | 17:10 | x86      |
| Msolap.dll                                                | 2018.150.35.39  | 11017120  | 1-Jun-23 | 17:10 | x64      |
| Msolap.dll                                                | 2018.150.35.39  | 8609232   | 1-Jun-23 | 17:10 | x86      |
| Msolui.dll                                                | 2018.150.35.39  | 306640    | 1-Jun-23 | 17:10 | x64      |
| Msolui.dll                                                | 2018.150.35.39  | 286160    | 1-Jun-23 | 17:10 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 1-Jun-23 | 17:10 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 1-Jun-23 | 17:10 | x64      |
| Sqlboot.dll                                               | 2019.150.4316.3 | 214928    | 1-Jun-23 | 17:10 | x64      |
| Sqlceip.exe                                               | 15.0.4316.3     | 292760    | 1-Jun-23 | 17:10 | x86      |
| Sqldumper.exe                                             | 2019.150.4316.3 | 153536    | 1-Jun-23 | 17:10 | x86      |
| Sqldumper.exe                                             | 2019.150.4316.3 | 186320    | 1-Jun-23 | 17:10 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 1-Jun-23 | 17:10 | x86      |
| Tmapi.dll                                                 | 2018.150.35.39  | 6178216   | 1-Jun-23 | 17:10 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.39  | 4917664   | 1-Jun-23 | 17:10 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.39  | 1184680   | 1-Jun-23 | 17:10 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.39  | 6806952   | 1-Jun-23 | 17:10 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.39  | 26026448  | 1-Jun-23 | 17:10 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.39  | 35460560  | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4316.3 | 165792    | 1-Jun-23 | 17:10 | x86      |
| Batchparser.dll                      | 2019.150.4316.3 | 182176    | 1-Jun-23 | 17:10 | x64      |
| Instapi150.dll                       | 2019.150.4316.3 | 87952     | 1-Jun-23 | 17:10 | x64      |
| Instapi150.dll                       | 2019.150.4316.3 | 75680     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4316.3 | 100256    | 1-Jun-23 | 17:10 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4316.3 | 87952     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4316.3     | 550816    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4316.3     | 550848    | 1-Jun-23 | 17:10 | x86      |
| Msasxpress.dll                       | 2018.150.35.39  | 32208     | 1-Jun-23 | 17:10 | x64      |
| Msasxpress.dll                       | 2018.150.35.39  | 27088     | 1-Jun-23 | 17:11 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4316.3 | 92096     | 1-Jun-23 | 17:10 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4316.3 | 75664     | 1-Jun-23 | 17:10 | x86      |
| Sqldumper.exe                        | 2019.150.4316.3 | 153536    | 1-Jun-23 | 17:10 | x86      |
| Sqldumper.exe                        | 2019.150.4316.3 | 186320    | 1-Jun-23 | 17:10 | x64      |
| Sqlftacct.dll                        | 2019.150.4316.3 | 59328     | 1-Jun-23 | 17:10 | x86      |
| Sqlftacct.dll                        | 2019.150.4316.3 | 79760     | 1-Jun-23 | 17:10 | x64      |
| Sqlmanager.dll                       | 2019.150.4316.3 | 878544    | 1-Jun-23 | 17:10 | x64      |
| Sqlmanager.dll                       | 2019.150.4316.3 | 743328    | 1-Jun-23 | 17:10 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4316.3 | 378832    | 1-Jun-23 | 17:10 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4316.3 | 432016    | 1-Jun-23 | 17:10 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4316.3 | 358296    | 1-Jun-23 | 17:10 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4316.3 | 276416    | 1-Jun-23 | 17:10 | x86      |
| Svrenumapi150.dll                    | 2019.150.4316.3 | 1161152   | 1-Jun-23 | 17:10 | x64      |
| Svrenumapi150.dll                    | 2019.150.4316.3 | 911312    | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 Data Quality

|        File   name        | File version | File size |   Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4316.3  | 599968    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4316.3  | 599968    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4316.3  | 1857440   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4316.3  | 1857432   | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4316.3 | 137104    | 01-Jun-2023 | 17:10 | x86      |
| Dreplaycommon.dll     | 2019.150.4316.3 | 667552    | 01-Jun-2023 | 17:10 | x86      |
| Dreplayutil.dll       | 2019.150.4316.3 | 305088    | 01-Jun-2023 | 17:10 | x86      |
| Instapi150.dll        | 2019.150.4316.3 | 87952     | 01-Jun-2023 | 17:10 | x64      |
| Sqlresourceloader.dll | 2019.150.4316.3 | 38864     | 01-Jun-2023 | 17:10 | x86      |

SQL Server 2008 sql_dreplay_controller

|      File   name      |   File version  | File size |   Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4316.3 | 667552    | 1-Jun-23 | 17:10 | x86      |
| Dreplaycontroller.exe | 2019.150.4316.3 | 366496    | 1-Jun-23 | 17:10 | x86      |
| Instapi150.dll        | 2019.150.4316.3 | 87952     | 1-Jun-23 | 17:10 | x64      |
| Sqlresourceloader.dll | 2019.150.4316.3 | 38864     | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 Database Services Core Instance

|                 File   name                |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4316.3 | 4658080   | 1-Jun-23 | 18:18 | x64      |
| Aetm-enclave.dll                           | 2019.150.4316.3 | 4612504   | 1-Jun-23 | 18:19 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4316.3 | 4932384   | 1-Jun-23 | 18:19 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4316.3 | 4874568   | 1-Jun-23 | 18:19 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 1-Jun-23 | 17:10 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 1-Jun-23 | 17:10 | x64      |
| Batchparser.dll                            | 2019.150.4316.3 | 182176    | 1-Jun-23 | 18:18 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 1-Jun-23 | 18:18 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 1-Jun-23 | 18:18 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 1-Jun-23 | 18:18 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 1-Jun-23 | 18:18 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4316.3 | 280472    | 1-Jun-23 | 18:19 | x64      |
| Dcexec.exe                                 | 2019.150.4316.3 | 88016     | 1-Jun-23 | 18:19 | x64      |
| Fssres.dll                                 | 2019.150.4316.3 | 96144     | 1-Jun-23 | 18:18 | x64      |
| Hadrres.dll                                | 2019.150.4316.3 | 206752    | 1-Jun-23 | 18:18 | x64      |
| Hkcompile.dll                              | 2019.150.4316.3 | 1292184   | 1-Jun-23 | 18:18 | x64      |
| Hkengine.dll                               | 2019.150.4316.3 | 5793728   | 1-Jun-23 | 18:18 | x64      |
| Hkruntime.dll                              | 2019.150.4316.3 | 182160    | 1-Jun-23 | 18:18 | x64      |
| Hktempdb.dll                               | 2019.150.4316.3 | 63376     | 1-Jun-23 | 18:19 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 1-Jun-23 | 18:18 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4316.3     | 235408    | 1-Jun-23 | 18:19 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4316.3 | 391120    | 1-Jun-23 | 18:19 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4316.3 | 325520    | 1-Jun-23 | 18:18 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4316.3 | 92096     | 1-Jun-23 | 18:19 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 1-Jun-23 | 18:18 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 1-Jun-23 | 18:18 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 1-Jun-23 | 18:18 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 1-Jun-23 | 18:18 | x64      |
| Qds.dll                                    | 2019.150.4316.3 | 1189824   | 1-Jun-23 | 18:18 | x64      |
| Rsfxft.dll                                 | 2019.150.4316.3 | 51104     | 1-Jun-23 | 18:18 | x64      |
| Secforwarder.dll                           | 2019.150.4316.3 | 79808     | 1-Jun-23 | 18:18 | x64      |
| Sqagtres.dll                               | 2019.150.4316.3 | 87960     | 1-Jun-23 | 18:19 | x64      |
| Sqlaamss.dll                               | 2019.150.4316.3 | 108448    | 1-Jun-23 | 18:19 | x64      |
| Sqlaccess.dll                              | 2019.150.4316.3 | 493456    | 1-Jun-23 | 18:18 | x64      |
| Sqlagent.exe                               | 2019.150.4316.3 | 731024    | 1-Jun-23 | 18:19 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4316.3 | 71632     | 1-Jun-23 | 18:19 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4316.3 | 79760     | 1-Jun-23 | 18:19 | x64      |
| Sqlboot.dll                                | 2019.150.4316.3 | 214928    | 1-Jun-23 | 18:18 | x64      |
| Sqlceip.exe                                | 15.0.4316.3     | 292760    | 1-Jun-23 | 18:18 | x86      |
| Sqlcmdss.dll                               | 2019.150.4316.3 | 87960     | 1-Jun-23 | 18:19 | x64      |
| Sqlctr150.dll                              | 2019.150.4316.3 | 116640    | 1-Jun-23 | 18:18 | x86      |
| Sqlctr150.dll                              | 2019.150.4316.3 | 145296    | 1-Jun-23 | 18:18 | x64      |
| Sqldk.dll                                  | 2019.150.4316.3 | 3180432   | 1-Jun-23 | 18:18 | x64      |
| Sqldtsss.dll                               | 2019.150.4316.3 | 108480    | 1-Jun-23 | 18:19 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 1595296   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3504016   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3700672   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4167584   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4286368   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3418008   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3585952   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4163488   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4016016   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4069264   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 2226064   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 2172832   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3876752   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3549120   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4020160   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3827600   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3823512   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3618720   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3504032   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 1537952   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 3913632   | 1-Jun-23 | 18:18 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4316.3 | 4036512   | 1-Jun-23 | 18:18 | x64      |
| Sqllang.dll                                | 2019.150.4316.3 | 40007616  | 1-Jun-23 | 18:18 | x64      |
| Sqlmin.dll                                 | 2019.150.4316.3 | 40619456  | 1-Jun-23 | 18:19 | x64      |
| Sqlolapss.dll                              | 2019.150.4316.3 | 108448    | 1-Jun-23 | 18:19 | x64      |
| Sqlos.dll                                  | 2019.150.4316.3 | 42960     | 1-Jun-23 | 18:18 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4316.3 | 83856     | 1-Jun-23 | 18:18 | x64      |
| Sqlrepss.dll                               | 2019.150.4316.3 | 87968     | 1-Jun-23 | 18:19 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4316.3 | 51152     | 1-Jun-23 | 18:18 | x64      |
| Sqlscm.dll                                 | 2019.150.4316.3 | 87968     | 1-Jun-23 | 18:18 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4316.3 | 38808     | 1-Jun-23 | 18:18 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4316.3 | 5805968   | 1-Jun-23 | 18:18 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4316.3 | 673680    | 1-Jun-23 | 18:18 | x64      |
| Sqlservr.exe                               | 2019.150.4316.3 | 628640    | 1-Jun-23 | 18:18 | x64      |
| Sqlsvc.dll                                 | 2019.150.4316.3 | 182160    | 1-Jun-23 | 18:19 | x64      |
| Sqltses.dll                                | 2019.150.4316.3 | 9119640   | 1-Jun-23 | 18:18 | x64      |
| Sqsrvres.dll                               | 2019.150.4316.3 | 280480    | 1-Jun-23 | 18:18 | x64      |
| Stretchcodegen.exe                         | 15.0.4316.3     | 59344     | 1-Jun-23 | 18:18 | x86      |
| Svl.dll                                    | 2019.150.4316.3 | 161728    | 1-Jun-23 | 18:18 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 1-Jun-23 | 18:18 | x64      |
| Xe.dll                                     | 2019.150.4316.3 | 722848    | 1-Jun-23 | 18:19 | x64      |
| Xpadsi.exe                                 | 2019.150.4316.3 | 116672    | 1-Jun-23 | 18:18 | x64      |
| Xplog70.dll                                | 2019.150.4316.3 | 92064     | 1-Jun-23 | 18:18 | x64      |
| Xpqueue.dll                                | 2019.150.4316.3 | 92112     | 1-Jun-23 | 18:18 | x64      |
| Xprepl.dll                                 | 2019.150.4316.3 | 120720    | 1-Jun-23 | 18:18 | x64      |
| Xpstar.dll                                 | 2019.150.4316.3 | 473040    | 1-Jun-23 | 18:18 | x64      |

SQL Server 2019 Database Services Core Shared

|                          File   name                         |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4316.3 | 165792    | 1-Jun-23 | 17:10 | x86      |
| Batchparser.dll                                              | 2019.150.4316.3 | 182176    | 1-Jun-23 | 17:10 | x64      |
| Commanddest.dll                                              | 2019.150.4316.3 | 264144    | 1-Jun-23 | 17:10 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4316.3 | 227232    | 1-Jun-23 | 17:10 | x64      |
| Distrib.exe                                                  | 2019.150.4316.3 | 243616    | 1-Jun-23 | 17:10 | x64      |
| Dteparse.dll                                                 | 2019.150.4316.3 | 124832    | 1-Jun-23 | 17:10 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4316.3 | 133008    | 1-Jun-23 | 17:10 | x64      |
| Dtepkg.dll                                                   | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Dtexec.exe                                                   | 2019.150.4316.3 | 72592     | 1-Jun-23 | 17:10 | x64      |
| Dts.dll                                                      | 2019.150.4316.3 | 3143616   | 1-Jun-23 | 17:10 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4316.3 | 501696    | 1-Jun-23 | 17:10 | x64      |
| Dtsconn.dll                                                  | 2019.150.4316.3 | 522192    | 1-Jun-23 | 17:10 | x64      |
| Dtshost.exe                                                  | 2019.150.4316.3 | 106392    | 1-Jun-23 | 17:10 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4316.3 | 567232    | 1-Jun-23 | 17:10 | x64      |
| Dtspipeline.dll                                              | 2019.150.4316.3 | 1329056   | 1-Jun-23 | 17:10 | x64      |
| Dtswizard.exe                                                | 15.0.4316.3     | 886672    | 1-Jun-23 | 17:10 | x64      |
| Dtuparse.dll                                                 | 2019.150.4316.3 | 100256    | 1-Jun-23 | 17:10 | x64      |
| Dtutil.exe                                                   | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Exceldest.dll                                                | 2019.150.4316.3 | 280512    | 1-Jun-23 | 17:10 | x64      |
| Excelsrc.dll                                                 | 2019.150.4316.3 | 309136    | 1-Jun-23 | 17:10 | x64      |
| Execpackagetask.dll                                          | 2019.150.4316.3 | 186304    | 1-Jun-23 | 17:10 | x64      |
| Flatfiledest.dll                                             | 2019.150.4316.3 | 411552    | 1-Jun-23 | 17:10 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4316.3 | 427920    | 1-Jun-23 | 17:10 | x64      |
| Logread.exe                                                  | 2019.150.4316.3 | 722896    | 1-Jun-23 | 17:10 | x64      |
| Mergetxt.dll                                                 | 2019.150.4316.3 | 75712     | 1-Jun-23 | 17:10 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4316.3     | 59328     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4316.3     | 42896     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4316.3     | 391120    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4316.3 | 1697680   | 1-Jun-23 | 17:10 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4316.3 | 1640344   | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4316.3     | 550848    | 1-Jun-23 | 17:10 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4316.3 | 112576    | 1-Jun-23 | 17:10 | x64      |
| Msgprox.dll                                                  | 2019.150.4316.3 | 300944    | 1-Jun-23 | 17:10 | x64      |
| Msoledbsql.dll                                               | 2018.186.6.0    | 2729992   | 1-Jun-23 | 17:10 | x64      |
| Msoledbsql.dll                                               | 2018.186.6.0    | 153608    | 1-Jun-23 | 17:10 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4316.3 | 1497024   | 1-Jun-23 | 17:10 | x64      |
| Oledbdest.dll                                                | 2019.150.4316.3 | 280520    | 1-Jun-23 | 17:10 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4316.3 | 313232    | 1-Jun-23 | 17:10 | x64      |
| Osql.exe                                                     | 2019.150.4316.3 | 92048     | 1-Jun-23 | 17:10 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4316.3 | 497616    | 1-Jun-23 | 17:10 | x64      |
| Rawdest.dll                                                  | 2019.150.4316.3 | 227280    | 1-Jun-23 | 17:10 | x64      |
| Rawsource.dll                                                | 2019.150.4316.3 | 210832    | 1-Jun-23 | 17:10 | x64      |
| Rdistcom.dll                                                 | 2019.150.4316.3 | 915344    | 1-Jun-23 | 17:10 | x64      |
| Recordsetdest.dll                                            | 2019.150.4316.3 | 202704    | 1-Jun-23 | 17:10 | x64      |
| Repldp.dll                                                   | 2019.150.4316.3 | 313232    | 1-Jun-23 | 17:10 | x64      |
| Replerrx.dll                                                 | 2019.150.4316.3 | 182160    | 1-Jun-23 | 17:10 | x64      |
| Replisapi.dll                                                | 2019.150.4316.3 | 395168    | 1-Jun-23 | 17:10 | x64      |
| Replmerg.exe                                                 | 2019.150.4316.3 | 563104    | 1-Jun-23 | 17:10 | x64      |
| Replprov.dll                                                 | 2019.150.4316.3 | 862096    | 1-Jun-23 | 17:10 | x64      |
| Replrec.dll                                                  | 2019.150.4316.3 | 1034192   | 1-Jun-23 | 17:10 | x64      |
| Replsub.dll                                                  | 2019.150.4316.3 | 472992    | 1-Jun-23 | 17:10 | x64      |
| Replsync.dll                                                 | 2019.150.4316.3 | 165776    | 1-Jun-23 | 17:10 | x64      |
| Spresolv.dll                                                 | 2019.150.4316.3 | 276368    | 1-Jun-23 | 17:10 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4316.3 | 264144    | 1-Jun-23 | 17:10 | x64      |
| Sqldiag.exe                                                  | 2019.150.4316.3 | 1140624   | 1-Jun-23 | 17:10 | x64      |
| Sqldistx.dll                                                 | 2019.150.4316.3 | 251800    | 1-Jun-23 | 17:10 | x64      |
| Sqllogship.exe                                               | 15.0.4316.3     | 104336    | 1-Jun-23 | 17:10 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4316.3 | 399264    | 1-Jun-23 | 17:10 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4316.3 | 38864     | 1-Jun-23 | 17:10 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4316.3 | 51152     | 1-Jun-23 | 17:10 | x64      |
| Sqlscm.dll                                                   | 2019.150.4316.3 | 79808     | 1-Jun-23 | 17:10 | x86      |
| Sqlscm.dll                                                   | 2019.150.4316.3 | 87968     | 1-Jun-23 | 17:10 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4316.3 | 149440    | 1-Jun-23 | 17:10 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4316.3 | 182160    | 1-Jun-23 | 17:10 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4316.3 | 202704    | 1-Jun-23 | 17:10 | x64      |
| Ssradd.dll                                                   | 2019.150.4316.3 | 83872     | 1-Jun-23 | 17:10 | x64      |
| Ssravg.dll                                                   | 2019.150.4316.3 | 83904     | 1-Jun-23 | 17:10 | x64      |
| Ssrdown.dll                                                  | 2019.150.4316.3 | 75728     | 1-Jun-23 | 17:10 | x64      |
| Ssrmax.dll                                                   | 2019.150.4316.3 | 83920     | 1-Jun-23 | 17:10 | x64      |
| Ssrmin.dll                                                   | 2019.150.4316.3 | 83856     | 1-Jun-23 | 17:10 | x64      |
| Ssrpub.dll                                                   | 2019.150.4316.3 | 79808     | 1-Jun-23 | 17:10 | x64      |
| Ssrup.dll                                                    | 2019.150.4316.3 | 75712     | 1-Jun-23 | 17:10 | x64      |
| Txagg.dll                                                    | 2019.150.4316.3 | 391104    | 1-Jun-23 | 17:10 | x64      |
| Txbdd.dll                                                    | 2019.150.4316.3 | 190360    | 1-Jun-23 | 17:10 | x64      |
| Txdatacollector.dll                                          | 2019.150.4316.3 | 473040    | 1-Jun-23 | 17:10 | x64      |
| Txdataconvert.dll                                            | 2019.150.4316.3 | 317376    | 1-Jun-23 | 17:10 | x64      |
| Txderived.dll                                                | 2019.150.4316.3 | 640976    | 1-Jun-23 | 17:10 | x64      |
| Txlookup.dll                                                 | 2019.150.4316.3 | 542608    | 1-Jun-23 | 17:10 | x64      |
| Txmerge.dll                                                  | 2019.150.4316.3 | 247744    | 1-Jun-23 | 17:10 | x64      |
| Txmergejoin.dll                                              | 2019.150.4316.3 | 309184    | 1-Jun-23 | 17:10 | x64      |
| Txmulticast.dll                                              | 2019.150.4316.3 | 145296    | 1-Jun-23 | 17:10 | x64      |
| Txrowcount.dll                                               | 2019.150.4316.3 | 141200    | 1-Jun-23 | 17:10 | x64      |
| Txsort.dll                                                   | 2019.150.4316.3 | 288704    | 1-Jun-23 | 17:10 | x64      |
| Txsplit.dll                                                  | 2019.150.4316.3 | 624592    | 1-Jun-23 | 17:10 | x64      |
| Txunionall.dll                                               | 2019.150.4316.3 | 198592    | 1-Jun-23 | 17:10 | x64      |
| Xe.dll                                                       | 2019.150.4316.3 | 722848    | 1-Jun-23 | 17:10 | x64      |
| Xmlsub.dll                                                   | 2019.150.4316.3 | 296864    | 1-Jun-23 | 17:10 | x64      |

SQL Server 2019 sql_extensibility

|     File   name    |   File version  | File size |   Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4316.3 | 96192     | 1-Jun-23 | 17:10 | x64      |
| Exthost.exe        | 2019.150.4316.3 | 239568    | 1-Jun-23 | 17:10 | x64      |
| Launchpad.exe      | 2019.150.4316.3 | 1230784   | 1-Jun-23 | 17:10 | x64      |
| Sqlsatellite.dll   | 2019.150.4316.3 | 1025944   | 1-Jun-23 | 17:10 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |   Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4316.3 | 685976    | 1-Jun-23 | 17:10 | x64      |
| Fdhost.exe     | 2019.150.4316.3 | 128920    | 1-Jun-23 | 17:10 | x64      |
| Fdlauncher.exe | 2019.150.4316.3 | 79808     | 1-Jun-23 | 17:10 | x64      |
| Sqlft150ph.dll | 2019.150.4316.3 | 92112     | 1-Jun-23 | 17:10 | x64      |

SQL Server 2019 sql_inst_mr

| File   name | File version | File size |   Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Imrdll.dll  | 15.0.4316.3  | 30608     | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 Integration Services

|                          File   name                          |   File version  | File size |   Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4316.3 | 227264    | 1-Jun-23 | 17:10 | x86      |
| Commanddest.dll                                               | 2019.150.4316.3 | 264144    | 1-Jun-23 | 17:10 | x64      |
| Dteparse.dll                                                  | 2019.150.4316.3 | 112528    | 1-Jun-23 | 17:10 | x86      |
| Dteparse.dll                                                  | 2019.150.4316.3 | 124832    | 1-Jun-23 | 17:10 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4316.3 | 116672    | 1-Jun-23 | 17:10 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4316.3 | 133008    | 1-Jun-23 | 17:10 | x64      |
| Dtepkg.dll                                                    | 2019.150.4316.3 | 133008    | 1-Jun-23 | 17:10 | x86      |
| Dtepkg.dll                                                    | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Dtexec.exe                                                    | 2019.150.4316.3 | 63904     | 1-Jun-23 | 17:10 | x86      |
| Dtexec.exe                                                    | 2019.150.4316.3 | 72592     | 1-Jun-23 | 17:10 | x64      |
| Dts.dll                                                       | 2019.150.4316.3 | 2762688   | 1-Jun-23 | 17:10 | x86      |
| Dts.dll                                                       | 2019.150.4316.3 | 3143616   | 1-Jun-23 | 17:10 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4316.3 | 444352    | 1-Jun-23 | 17:10 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4316.3 | 501696    | 1-Jun-23 | 17:10 | x64      |
| Dtsconn.dll                                                   | 2019.150.4316.3 | 522192    | 1-Jun-23 | 17:10 | x64      |
| Dtsconn.dll                                                   | 2019.150.4316.3 | 432080    | 1-Jun-23 | 17:10 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4316.3 | 112064    | 1-Jun-23 | 17:10 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4316.3 | 93632     | 1-Jun-23 | 17:10 | x86      |
| Dtshost.exe                                                   | 2019.150.4316.3 | 106392    | 1-Jun-23 | 17:10 | x64      |
| Dtshost.exe                                                   | 2019.150.4316.3 | 89040     | 1-Jun-23 | 17:10 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4316.3 | 554944    | 1-Jun-23 | 17:10 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4316.3 | 567232    | 1-Jun-23 | 17:10 | x64      |
| Dtspipeline.dll                                               | 2019.150.4316.3 | 1120144   | 1-Jun-23 | 17:10 | x86      |
| Dtspipeline.dll                                               | 2019.150.4316.3 | 1329056   | 1-Jun-23 | 17:10 | x64      |
| Dtswizard.exe                                                 | 15.0.4316.3     | 886672    | 1-Jun-23 | 17:10 | x64      |
| Dtswizard.exe                                                 | 15.0.4316.3     | 890816    | 1-Jun-23 | 17:10 | x86      |
| Dtuparse.dll                                                  | 2019.150.4316.3 | 100256    | 1-Jun-23 | 17:10 | x64      |
| Dtuparse.dll                                                  | 2019.150.4316.3 | 88016     | 1-Jun-23 | 17:10 | x86      |
| Dtutil.exe                                                    | 2019.150.4316.3 | 130512    | 1-Jun-23 | 17:10 | x86      |
| Dtutil.exe                                                    | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Exceldest.dll                                                 | 2019.150.4316.3 | 235472    | 1-Jun-23 | 17:10 | x86      |
| Exceldest.dll                                                 | 2019.150.4316.3 | 280512    | 1-Jun-23 | 17:10 | x64      |
| Excelsrc.dll                                                  | 2019.150.4316.3 | 260032    | 1-Jun-23 | 17:10 | x86      |
| Excelsrc.dll                                                  | 2019.150.4316.3 | 309136    | 1-Jun-23 | 17:10 | x64      |
| Execpackagetask.dll                                           | 2019.150.4316.3 | 149456    | 1-Jun-23 | 17:10 | x86      |
| Execpackagetask.dll                                           | 2019.150.4316.3 | 186304    | 1-Jun-23 | 17:10 | x64      |
| Flatfiledest.dll                                              | 2019.150.4316.3 | 358352    | 1-Jun-23 | 17:10 | x86      |
| Flatfiledest.dll                                              | 2019.150.4316.3 | 411552    | 1-Jun-23 | 17:10 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4316.3 | 370624    | 1-Jun-23 | 17:10 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4316.3 | 427920    | 1-Jun-23 | 17:10 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4316.3     | 120736    | 1-Jun-23 | 17:10 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4316.3     | 120768    | 1-Jun-23 | 17:10 | x86      |
| Isserverexec.exe                                              | 15.0.4316.3     | 145360    | 1-Jun-23 | 17:10 | x64      |
| Isserverexec.exe                                              | 15.0.4316.3     | 149392    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4316.3     | 116672    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4316.3     | 59296     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4316.3     | 59328     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4316.3     | 509840    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4316.3     | 509856    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4316.3     | 42896     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4316.3     | 42912     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4316.3     | 391120    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4316.3     | 59280     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4316.3     | 141216    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4316.3     | 141216    | 1-Jun-23 | 17:10 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4316.3     | 219088    | 1-Jun-23 | 17:10 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4316.3 | 100288    | 1-Jun-23 | 17:10 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4316.3 | 112576    | 1-Jun-23 | 17:10 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.39  | 10065320  | 1-Jun-23 | 17:10 | x64      |
| Odbcdest.dll                                                  | 2019.150.4316.3 | 321480    | 1-Jun-23 | 17:10 | x86      |
| Odbcdest.dll                                                  | 2019.150.4316.3 | 370576    | 1-Jun-23 | 17:10 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4316.3 | 329664    | 1-Jun-23 | 17:10 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4316.3 | 382880    | 1-Jun-23 | 17:10 | x64      |
| Oledbdest.dll                                                 | 2019.150.4316.3 | 280520    | 1-Jun-23 | 17:10 | x64      |
| Oledbdest.dll                                                 | 2019.150.4316.3 | 239552    | 1-Jun-23 | 17:10 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4316.3 | 313232    | 1-Jun-23 | 17:10 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4316.3 | 264144    | 1-Jun-23 | 17:10 | x86      |
| Rawdest.dll                                                   | 2019.150.4316.3 | 190416    | 1-Jun-23 | 17:10 | x86      |
| Rawdest.dll                                                   | 2019.150.4316.3 | 227280    | 1-Jun-23 | 17:10 | x64      |
| Rawsource.dll                                                 | 2019.150.4316.3 | 178080    | 1-Jun-23 | 17:10 | x86      |
| Rawsource.dll                                                 | 2019.150.4316.3 | 210832    | 1-Jun-23 | 17:10 | x64      |
| Recordsetdest.dll                                             | 2019.150.4316.3 | 174032    | 1-Jun-23 | 17:10 | x86      |
| Recordsetdest.dll                                             | 2019.150.4316.3 | 202704    | 1-Jun-23 | 17:10 | x64      |
| Sqlceip.exe                                                   | 15.0.4316.3     | 292760    | 1-Jun-23 | 17:10 | x86      |
| Sqldest.dll                                                   | 2019.150.4316.3 | 239568    | 1-Jun-23 | 17:10 | x86      |
| Sqldest.dll                                                   | 2019.150.4316.3 | 276376    | 1-Jun-23 | 17:10 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4316.3 | 169936    | 1-Jun-23 | 17:10 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4316.3 | 202704    | 1-Jun-23 | 17:10 | x64      |
| Txagg.dll                                                     | 2019.150.4316.3 | 329664    | 1-Jun-23 | 17:10 | x86      |
| Txagg.dll                                                     | 2019.150.4316.3 | 391104    | 1-Jun-23 | 17:10 | x64      |
| Txbdd.dll                                                     | 2019.150.4316.3 | 153496    | 1-Jun-23 | 17:10 | x86      |
| Txbdd.dll                                                     | 2019.150.4316.3 | 190360    | 1-Jun-23 | 17:10 | x64      |
| Txbestmatch.dll                                               | 2019.150.4316.3 | 546704    | 1-Jun-23 | 17:10 | x86      |
| Txbestmatch.dll                                               | 2019.150.4316.3 | 653248    | 1-Jun-23 | 17:10 | x64      |
| Txcache.dll                                                   | 2019.150.4316.3 | 165832    | 1-Jun-23 | 17:10 | x86      |
| Txcache.dll                                                   | 2019.150.4316.3 | 198560    | 1-Jun-23 | 17:10 | x64      |
| Txcharmap.dll                                                 | 2019.150.4316.3 | 272320    | 1-Jun-23 | 17:10 | x86      |
| Txcharmap.dll                                                 | 2019.150.4316.3 | 313240    | 1-Jun-23 | 17:10 | x64      |
| Txcopymap.dll                                                 | 2019.150.4316.3 | 165776    | 1-Jun-23 | 17:10 | x86      |
| Txcopymap.dll                                                 | 2019.150.4316.3 | 198608    | 1-Jun-23 | 17:10 | x64      |
| Txdataconvert.dll                                             | 2019.150.4316.3 | 276432    | 1-Jun-23 | 17:10 | x86      |
| Txdataconvert.dll                                             | 2019.150.4316.3 | 317376    | 1-Jun-23 | 17:10 | x64      |
| Txderived.dll                                                 | 2019.150.4316.3 | 559040    | 1-Jun-23 | 17:10 | x86      |
| Txderived.dll                                                 | 2019.150.4316.3 | 640976    | 1-Jun-23 | 17:10 | x64      |
| Txfileextractor.dll                                           | 2019.150.4316.3 | 182208    | 1-Jun-23 | 17:10 | x86      |
| Txfileextractor.dll                                           | 2019.150.4316.3 | 219032    | 1-Jun-23 | 17:10 | x64      |
| Txfileinserter.dll                                            | 2019.150.4316.3 | 182224    | 1-Jun-23 | 17:10 | x86      |
| Txfileinserter.dll                                            | 2019.150.4316.3 | 214976    | 1-Jun-23 | 17:10 | x64      |
| Txgroupdups.dll                                               | 2019.150.4316.3 | 313296    | 1-Jun-23 | 17:10 | x64      |
| Txgroupdups.dll                                               | 2019.150.4316.3 | 255952    | 1-Jun-23 | 17:10 | x86      |
| Txlineage.dll                                                 | 2019.150.4316.3 | 128912    | 1-Jun-23 | 17:10 | x86      |
| Txlineage.dll                                                 | 2019.150.4316.3 | 153552    | 1-Jun-23 | 17:10 | x64      |
| Txlookup.dll                                                  | 2019.150.4316.3 | 468944    | 1-Jun-23 | 17:10 | x86      |
| Txlookup.dll                                                  | 2019.150.4316.3 | 542608    | 1-Jun-23 | 17:10 | x64      |
| Txmerge.dll                                                   | 2019.150.4316.3 | 202688    | 1-Jun-23 | 17:10 | x86      |
| Txmerge.dll                                                   | 2019.150.4316.3 | 247744    | 1-Jun-23 | 17:10 | x64      |
| Txmergejoin.dll                                               | 2019.150.4316.3 | 247744    | 1-Jun-23 | 17:10 | x86      |
| Txmergejoin.dll                                               | 2019.150.4316.3 | 309184    | 1-Jun-23 | 17:10 | x64      |
| Txmulticast.dll                                               | 2019.150.4316.3 | 116688    | 1-Jun-23 | 17:10 | x86      |
| Txmulticast.dll                                               | 2019.150.4316.3 | 145296    | 1-Jun-23 | 17:10 | x64      |
| Txpivot.dll                                                   | 2019.150.4316.3 | 206784    | 1-Jun-23 | 17:10 | x86      |
| Txpivot.dll                                                   | 2019.150.4316.3 | 239552    | 1-Jun-23 | 17:10 | x64      |
| Txrowcount.dll                                                | 2019.150.4316.3 | 112528    | 1-Jun-23 | 17:10 | x86      |
| Txrowcount.dll                                                | 2019.150.4316.3 | 141200    | 1-Jun-23 | 17:10 | x64      |
| Txsampling.dll                                                | 2019.150.4316.3 | 157648    | 1-Jun-23 | 17:10 | x86      |
| Txsampling.dll                                                | 2019.150.4316.3 | 194496    | 1-Jun-23 | 17:10 | x64      |
| Txscd.dll                                                     | 2019.150.4316.3 | 198592    | 1-Jun-23 | 17:10 | x86      |
| Txscd.dll                                                     | 2019.150.4316.3 | 235416    | 1-Jun-23 | 17:10 | x64      |
| Txsort.dll                                                    | 2019.150.4316.3 | 288704    | 1-Jun-23 | 17:10 | x64      |
| Txsort.dll                                                    | 2019.150.4316.3 | 231360    | 1-Jun-23 | 17:10 | x86      |
| Txsplit.dll                                                   | 2019.150.4316.3 | 624592    | 1-Jun-23 | 17:10 | x64      |
| Txsplit.dll                                                   | 2019.150.4316.3 | 550848    | 1-Jun-23 | 17:10 | x86      |
| Txtermextraction.dll                                          | 2019.150.4316.3 | 8644504   | 1-Jun-23 | 17:10 | x86      |
| Txtermextraction.dll                                          | 2019.150.4316.3 | 8701840   | 1-Jun-23 | 17:10 | x64      |
| Txtermlookup.dll                                              | 2019.150.4316.3 | 4138960   | 1-Jun-23 | 17:10 | x86      |
| Txtermlookup.dll                                              | 2019.150.4316.3 | 4183968   | 1-Jun-23 | 17:10 | x64      |
| Txunionall.dll                                                | 2019.150.4316.3 | 161728    | 1-Jun-23 | 17:10 | x86      |
| Txunionall.dll                                                | 2019.150.4316.3 | 198592    | 1-Jun-23 | 17:10 | x64      |
| Txunpivot.dll                                                 | 2019.150.4316.3 | 182160    | 1-Jun-23 | 17:10 | x86      |
| Txunpivot.dll                                                 | 2019.150.4316.3 | 214944    | 1-Jun-23 | 17:10 | x64      |
| Xe.dll                                                        | 2019.150.4316.3 | 632784    | 1-Jun-23 | 17:10 | x86      |
| Xe.dll                                                        | 2019.150.4316.3 | 722848    | 1-Jun-23 | 17:10 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |   Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1964.0     | 559536    | 1-Jun-23 | 17:55 | x86      |
| Dmsnative.dll                                                        | 2018.150.1964.0 | 152496    | 1-Jun-23 | 17:55 | x64      |
| Dwengineservice.dll                                                  | 15.0.1964.0     | 45016     | 1-Jun-23 | 17:55 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 1-Jun-23 | 17:55 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 1-Jun-23 | 17:55 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 1-Jun-23 | 17:55 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 1-Jun-23 | 17:55 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 1-Jun-23 | 17:55 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 1-Jun-23 | 17:55 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 1-Jun-23 | 17:55 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 1-Jun-23 | 17:55 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 1-Jun-23 | 17:55 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 1-Jun-23 | 17:55 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 1-Jun-23 | 17:55 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 1-Jun-23 | 17:55 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 1-Jun-23 | 17:55 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 1-Jun-23 | 17:55 | x64      |
| Instapi150.dll                                                       | 2019.150.4316.3 | 87952     | 1-Jun-23 | 17:55 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 1-Jun-23 | 17:55 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 1-Jun-23 | 17:55 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 1-Jun-23 | 17:55 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 1-Jun-23 | 17:55 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 1-Jun-23 | 17:55 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 1-Jun-23 | 17:55 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 1-Jun-23 | 17:55 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 1-Jun-23 | 17:55 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 1-Jun-23 | 17:55 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 1-Jun-23 | 17:55 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1964.0     | 67544     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1964.0     | 293328    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1964.0     | 1957848   | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1964.0     | 169392    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1964.0     | 649648    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1964.0     | 246192    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1964.0     | 139184    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1964.0     | 79776     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1964.0     | 51104     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1964.0     | 88496     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1964.0     | 1129392   | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1964.0     | 80816     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1964.0     | 70616     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1964.0     | 35248     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1964.0     | 31192     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1964.0     | 46552     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1964.0     | 21448     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1964.0     | 26528     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1964.0     | 131536    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1964.0     | 86488     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1964.0     | 100824    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1964.0     | 293328    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 120240    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 138160    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 141232    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 137680    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 150448    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 139696    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 134608    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 176600    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 117664    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 136656    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1964.0     | 72664     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1964.0     | 21936     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1964.0     | 37280     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1964.0     | 128928    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1964.0     | 3064752   | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1964.0     | 3955672   | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 118232    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133024    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 137688    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133584    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 148440    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 134088    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 130464    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 170912    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 115144    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 132056    | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1964.0     | 67544     | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1964.0     | 2682800   | 1-Jun-23 | 17:55 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1964.0     | 2436568   | 1-Jun-23 | 17:55 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4316.3 | 452504    | 1-Jun-23 | 17:55 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4316.3 | 7403408   | 1-Jun-23 | 17:55 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 1-Jun-23 | 17:55 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 1-Jun-23 | 17:55 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 1-Jun-23 | 17:55 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 1-Jun-23 | 17:55 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 1-Jun-23 | 17:55 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 1-Jun-23 | 17:55 | x64      |
| Secforwarder.dll                                                     | 2019.150.4316.3 | 79808     | 1-Jun-23 | 17:55 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1964.0 | 61400     | 1-Jun-23 | 17:55 | x64      |
| Sqldk.dll                                                            | 2019.150.4316.3 | 3180432   | 1-Jun-23 | 17:55 | x64      |
| Sqldumper.exe                                                        | 2019.150.4316.3 | 186320    | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 1595296   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 4167584   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 3418008   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 4163488   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 4069264   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 2226064   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 2172832   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 3827600   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 3823512   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 1537952   | 1-Jun-23 | 17:55 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4316.3 | 4036512   | 1-Jun-23 | 17:55 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 1-Jun-23 | 17:55 | x64      |
| Sqlos.dll                                                            | 2019.150.4316.3 | 42960     | 1-Jun-23 | 17:55 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1964.0 | 4841432   | 1-Jun-23 | 17:55 | x64      |
| Sqltses.dll                                                          | 2019.150.4316.3 | 9119640   | 1-Jun-23 | 17:55 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 1-Jun-23 | 17:55 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 1-Jun-23 | 17:55 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 1-Jun-23 | 17:55 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 1-Jun-23 | 17:55 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 1-Jun-23 | 17:55 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 1-Jun-23 | 17:55 | x64      |

SQL Server 2019 sql_shared_mr

| File   name | File version | File size |   Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:--------:|:-----:|:--------:|
| Smrdll.dll  | 15.0.4316.3  | 30608     | 1-Jun-23 | 17:10 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File   name                         |   File version  | File size |   Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:--------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4316.3 | 1632192   | 1-Jun-23 | 17:29 | x86      |
| Dtaengine.exe                                                | 2019.150.4316.3 | 219032    | 1-Jun-23 | 17:29 | x86      |
| Dteparse.dll                                                 | 2019.150.4316.3 | 112528    | 1-Jun-23 | 17:10 | x86      |
| Dteparse.dll                                                 | 2019.150.4316.3 | 124832    | 1-Jun-23 | 17:10 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4316.3 | 116672    | 1-Jun-23 | 17:10 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4316.3 | 133008    | 1-Jun-23 | 17:10 | x64      |
| Dtepkg.dll                                                   | 2019.150.4316.3 | 133008    | 1-Jun-23 | 17:10 | x86      |
| Dtepkg.dll                                                   | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Dtexec.exe                                                   | 2019.150.4316.3 | 63904     | 1-Jun-23 | 17:10 | x86      |
| Dtexec.exe                                                   | 2019.150.4316.3 | 72592     | 1-Jun-23 | 17:10 | x64      |
| Dts.dll                                                      | 2019.150.4316.3 | 2762688   | 1-Jun-23 | 17:10 | x86      |
| Dts.dll                                                      | 2019.150.4316.3 | 3143616   | 1-Jun-23 | 17:10 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4316.3 | 444352    | 1-Jun-23 | 17:10 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4316.3 | 501696    | 1-Jun-23 | 17:10 | x64      |
| Dtsconn.dll                                                  | 2019.150.4316.3 | 522192    | 1-Jun-23 | 17:10 | x64      |
| Dtsconn.dll                                                  | 2019.150.4316.3 | 432080    | 1-Jun-23 | 17:10 | x86      |
| Dtshost.exe                                                  | 2019.150.4316.3 | 106392    | 1-Jun-23 | 17:10 | x64      |
| Dtshost.exe                                                  | 2019.150.4316.3 | 89040     | 1-Jun-23 | 17:10 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4316.3 | 554944    | 1-Jun-23 | 17:10 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4316.3 | 567232    | 1-Jun-23 | 17:10 | x64      |
| Dtspipeline.dll                                              | 2019.150.4316.3 | 1120144   | 1-Jun-23 | 17:10 | x86      |
| Dtspipeline.dll                                              | 2019.150.4316.3 | 1329056   | 1-Jun-23 | 17:10 | x64      |
| Dtswizard.exe                                                | 15.0.4316.3     | 886672    | 1-Jun-23 | 17:10 | x64      |
| Dtswizard.exe                                                | 15.0.4316.3     | 890816    | 1-Jun-23 | 17:10 | x86      |
| Dtuparse.dll                                                 | 2019.150.4316.3 | 100256    | 1-Jun-23 | 17:10 | x64      |
| Dtuparse.dll                                                 | 2019.150.4316.3 | 88016     | 1-Jun-23 | 17:10 | x86      |
| Dtutil.exe                                                   | 2019.150.4316.3 | 130512    | 1-Jun-23 | 17:10 | x86      |
| Dtutil.exe                                                   | 2019.150.4316.3 | 149392    | 1-Jun-23 | 17:10 | x64      |
| Exceldest.dll                                                | 2019.150.4316.3 | 235472    | 1-Jun-23 | 17:10 | x86      |
| Exceldest.dll                                                | 2019.150.4316.3 | 280512    | 1-Jun-23 | 17:10 | x64      |
| Excelsrc.dll                                                 | 2019.150.4316.3 | 260032    | 1-Jun-23 | 17:10 | x86      |
| Excelsrc.dll                                                 | 2019.150.4316.3 | 309136    | 1-Jun-23 | 17:10 | x64      |
| Flatfiledest.dll                                             | 2019.150.4316.3 | 358352    | 1-Jun-23 | 17:10 | x86      |
| Flatfiledest.dll                                             | 2019.150.4316.3 | 411552    | 1-Jun-23 | 17:10 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4316.3 | 370624    | 1-Jun-23 | 17:10 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4316.3 | 427920    | 1-Jun-23 | 17:10 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4316.3     | 116632    | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4316.3     | 403344    | 1-Jun-23 | 17:29 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4316.3     | 403408    | 1-Jun-23 | 17:29 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4316.3     | 3004304   | 1-Jun-23 | 17:29 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4316.3     | 3004368   | 1-Jun-23 | 17:29 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4316.3     | 42896     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4316.3     | 42912     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4316.3     | 59280     | 1-Jun-23 | 17:10 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 1-Jun-23 | 17:29 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4316.3 | 100288    | 1-Jun-23 | 17:10 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4316.3 | 112576    | 1-Jun-23 | 17:10 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.39  | 8281000   | 1-Jun-23 | 17:10 | x86      |
| Oledbdest.dll                                                | 2019.150.4316.3 | 280520    | 1-Jun-23 | 17:10 | x64      |
| Oledbdest.dll                                                | 2019.150.4316.3 | 239552    | 1-Jun-23 | 17:10 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4316.3 | 313232    | 1-Jun-23 | 17:10 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4316.3 | 264144    | 1-Jun-23 | 17:10 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4316.3 | 38864     | 1-Jun-23 | 17:29 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4316.3 | 51152     | 1-Jun-23 | 17:29 | x64      |
| Sqlscm.dll                                                   | 2019.150.4316.3 | 79808     | 1-Jun-23 | 17:29 | x86      |
| Sqlscm.dll                                                   | 2019.150.4316.3 | 87968     | 1-Jun-23 | 17:29 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4316.3 | 149440    | 1-Jun-23 | 17:29 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4316.3 | 182160    | 1-Jun-23 | 17:29 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4316.3 | 169936    | 1-Jun-23 | 17:10 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4316.3 | 202704    | 1-Jun-23 | 17:10 | x64      |
| Txdataconvert.dll                                            | 2019.150.4316.3 | 276432    | 1-Jun-23 | 17:10 | x86      |
| Txdataconvert.dll                                            | 2019.150.4316.3 | 317376    | 1-Jun-23 | 17:10 | x64      |
| Xe.dll                                                       | 2019.150.4316.3 | 632784    | 1-Jun-23 | 17:10 | x86      |
| Xe.dll                                                       | 2019.150.4316.3 | 722848    | 1-Jun-23 | 17:10 | x64      |

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

To use one of the hotfixes in this package, you do not have to make any changes to the registry.

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

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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
