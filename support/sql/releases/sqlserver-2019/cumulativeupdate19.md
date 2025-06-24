---
title: Cumulative update 19 for SQL Server 2019 (KB5023049)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 19 (KB5023049).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5023049
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5023049 - Cumulative Update 19 for SQL Server 2019

_Release Date:_ &nbsp; February 16, 2023  
_Version:_ &nbsp; 15.0.4298.1

## Summary

This article describes Cumulative Update package 19 (CU19) for Microsoft SQL Server 2019. This update contains 47 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 18, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4298.1**, file version: **2019.150.4298.1**
- Analysis Services - Product version: **15.0.35.35**, file version: **2018.150.35.35**

> [!NOTE]
> This cumulative update includes Security Update 5021125. For more information, see [KB5021125 - Description of the security update for SQL Server 2019 GDR: February 14, 2023](https://support.microsoft.com/help/5021125).

## Known issues in this update

### Issue one

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

### Issue two

After you install this cumulative update, external data sources using the generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the `Driver` keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

This issue is fixed in [SQL Server 2019 CU21](cumulativeupdate21.md#2312800).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="2086067">[2086067](#2086067)</a> | Fixes an issue where any member who has the DQS KB Operator (`dqs_kb_operator`) role or a higher privilege level role can create or overwrite arbitrary files on the machine hosting SQL Server as the account that runs the SQL Server service (the default account is `NT SERVICE\MSSQLSERVER`). | Data Quality Services | Data Quality Services | Windows |
| <a id="2120779">[2120779](#2120779)</a> | Fixes a rare issue where memory corruption in the ODBC driver can occur in communications between two SQL Server instances. This issue occurs when the target SQL Server instance uses a down-level version of the Tabular Data Stream (TDS) protocol. An improper version check causes image data types to be decoded improperly on the client-side of the connection. | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2192500">[2192500](#2192500)</a> | Updates the version of *msoledbsql.msi* from 18.2.3 to 18.6.5 in SQL Server 2019, which resolves signature issues for custom actions. For more information, see [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server). | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2030140">[2030140](#2030140)</a> | Fixes an issue where the **sqlcmd** utility doesn't honor the **sqlcmd** command "`:!!`" when you run operating system (OS) commands. For more information, see [sqlcmd commands](/sql/tools/sqlcmd/sqlcmd-utility#sqlcmd-commands). | SQL Server Client Tools | Command Line Tools | Windows |
| <a id="2012343">[2012343](#2012343)</a> | Performance issues and deadlocks occur on SQL Server Agent in the `msdb` database that has automated backups. In addition, you see the following error messages in the SQL Server Agent log: </br></br>\<DateTime> SQLServer Error: 1205, Transaction (Process ID) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. </br>\<DateTime> Failed to retrieve job \<JobID> from the server. | SQL Server Client Tools | SQL Agent | All |
| <a id="2114705">[2114705](#2114705)</a> | Fixes an issue with differential backup skipping new Page Free Space (PFS) pages after a data file grows around a PFS boundary (a multiple of 8,088 pages; 64,704 KB), resulting in database corruption and a possible crash dump when this differential backup is restored. | SQL Server Engine | Backup Restore | All |
| <a id="2134470">[2134470](#2134470)</a> | Fixes a non-yielding scheduler condition (Msg 17883) that occurs when backup operations can't properly handle abort signals in some cases while waiting for pending I/O writes. | SQL Server Engine | Backup Restore | All |
| <a id="2032954">[2032954](#2032954)</a> | Fixes an Access Violation issue that occurs when removing the database snapshot files on the readable secondary replica of an Always On availability group that has the buffer pool extension enabled. | SQL Server Engine | DB Management | All |
| <a id="1943179">[1943179](#1943179)</a> | Fixes an assertion failure (Location: schemamgr.cpp:1253; Expression:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!regularPVSHobt->m_NeedsRefresh && !longtermPVSHobt->m_NeedsRefresh) that may occur when you run `sys.dm_tran_persistent_version_store_stats` on the secondary replica of an Always On availability group. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="1990621">[1990621](#1990621)</a> | After you apply this fix, the `cluster_nodename` returns valid results when you query `sys.dm_server_services` in SQL Server 2019. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="1992694">[1992694](#1992694)</a> | Fixes a failure of the SQL Server resource DLL (*hadrres.dll*) to report `SQLSTATE` when you retrieve the health information from SQL Server and **SQLGetData** returns `SQL_ERROR`. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="2025412">[2025412](#2025412)</a> | After you apply this fix, the SQL Server performance counter '`Log File(s) Size (KB)`' for the `SQLServer:Databases` object is correctly updated for secondary replicas in an Always On availability group (AG) when there's a log growth. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="2044132">[2044132](#2044132)</a> | Fixes an access violation issue that occurs on the secondary replica of an Always On availability group while accessing the empty conversation list. This issue occurs due to a concurrency condition when the system processes the messages like `HadrExtendedRecoveryForksMsg` or `HadrEstablishDB`. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="2023266">[2023266](#2023266)</a> | Fixes an assertion failure that occurs in natively compiled modules when the `Inner FOR JSON` operator is followed by an operator that buffers the corresponding objects, such as another `FOR JSON` or `ORDER BY` operator. Additionally, you may see the following assert expression: </br></br>Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memilb.cpp:\<LineNumber> </br>Expression: (*ppilb)->m_cRef == 0 </br>SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID> </br>Process ID:&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID> | SQL Server Engine | In-Memory OLTP | All |
| <a id="2069963">[2069963](#2069963)</a> | Fixes error 41842 that's incorrectly shown even when natively compiled stored procedures or in-memory transactions don't insert many records in a single transaction. Here's the error message: </br></br> Error 41842: Too many rows inserted or updated in this transaction. You can insert or update at most 4,294,967,294 rows in memory-optimized tables in a single transaction. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2087572">[2087572](#2087572)</a> | After you apply this update, you need at least the `CONTROL SERVER` permission to run the procedure `sys.sp_xtp_force_gc`. This update changes the implementation of the procedure to a single call for allocated and used bytes to be freed. Before you apply this update, you need to call it twice. For more information, see [Gradual increase in XTP memory consumption](../../database-engine/performance/memory-optimized-tempdb-out-of-memory.md#gradual-increase-in-xtp-memory-consumption). | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2147190">[2147190](#2147190)</a> | This improvement adds Extended Events functionality to enhance the periodic primary replica to secondary replica notification investigation in availability groups for an in-memory database. New events are generated that provide the oldest active transaction and end of log values. </br></br>This new tracing will help diagnose errors such as the following:</br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Error: 41316, Severity: 23, State: 7. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;Restore operation failed for database '\<DatabaseName>' with internal error code '0x84000004'. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2153945">[2153945](#2153945)</a> | Fixes an assertion failure (Location: execcoll.cpp:1305; Expression: 'savepointId > HkTxSavePointDefault') that occurs during the savepoint cleanup in a Hekaton transaction. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2129325">[2129325](#2129325)</a> | Fixes error 8992 [Check Catalog Msg 3853, State 1: Attribute (owning_principal_id=\<ID>) of row (principal_id=\<ID>) in sys.database_principals does not have a matching row (principal_id=\<ID>) in sys.database_principals.] generated by `DBCC CHECKDB` when executed against a database clone of a change data capture (CDC) enabled source database that has system-defined roles owned by CDC users. | SQL Server Engine | Metadata | All |
| <a id="308163385">[308163385](#308163385)</a> | Starting in SQL Server 2019 CU19, `CREATE EXTERNAL DATA SOURCE` supports the use of TNS files when connecting to Oracle, by using the `CONNECTION_OPTIONS` parameter. | SQL Server Engine | PolyBase | All |
| <a id="1021159">[1021159](#1021159)</a> | Adds the `NullOnInvalid` method for **geometry** and **geography** spatial data types to properly handle invalid spatial data. This enables you to have consistent behavior regardless of whether spatial indexes are used in your query plan. | SQL Server Engine | Programmability | All |
| <a id="2024688">[2024688](#2024688)</a> | [FIX: ParameterRuntimeValue is missing from the Showplan XML when you use the DMV sys.dm_exec_query_statistics_xml (KB5017788)](https://support.microsoft.com/help/5017788) | SQL Server Engine | Query Execution | All |
| <a id="2042998">[2042998](#2042998)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Execution | All |
| <a id="2034115">[2034115](#2034115)</a> | Fixes a failure to automatically resolve an inter-query deadlock that involves parallel resources. Deadlocks are usually resolved automatically by SQL Server but not for specific conditions before you apply this fix. So if you're collecting `xml_deadlock_report` Extended Events, you'll get continuous outputs for it until you manually kill the problem session. | SQL Server Engine | Query Execution | All |
| <a id="2061830">[2061830](#2061830)</a> | Fixes the following stack overflow error that occurs when deeply nesting `APPLY` operations: </br></br>Msg 8621, Level 17, State 1, Line \<LineNumber> </br>The query processor ran out of stack space during query optimization. Please simplify the query. </br></br>**Note**: This fix allows the nesting depth of the `APPLY` operator to be equal to or better than the functionality in SQL Server 2017. | SQL Server Engine | Query Execution | All |
| <a id="2116382">[2116382](#2116382)</a> | Fixes a failure to raise the proper data type overflow error when a comma-separated values (CSV) file has an integer (int) value larger than the maximum value of **int** and you run `SELECT <integer_column_name> FROM OPENROWSET` on this CSV file. | SQL Server Engine | Query Execution | All |
| <a id="2122673">[2122673](#2122673)</a> | The fix stops reporting transient error conditions that `@@ERROR` previously occurred when running queries by using a plan stored in Query Store (QDS). | SQL Server Engine | Query Execution | All |
| <a id="2139793">[2139793](#2139793)</a> | Improvement: Automatically enables the binary large object (BLOB) trace ring buffer feature when a BLOB assertion failure is detected. This improvement helps to better investigate such issues. | SQL Server Engine | Query Execution | All |
| <a id="2162840">[2162840](#2162840)</a> | Fixes a self-deadlock issue where internal update statistic transactions persist locks, which can cause unresolved deadlocks with user queries. The issue occurs because the lock isn't released when the system runs the update query statistics. After you apply this fix, the lock can be released as intended. | SQL Server Engine | Query Execution | All |
| <a id="2046472">[2046472](#2046472)</a> | [FIX: Table-valued function that uses a parameter and the OPTION (OPTIMIZE FOR) clause gives incorrect results on the first run (KB5022920)](https://support.microsoft.com/help/5022920) | SQL Server Engine | Query Optimizer | All |
| <a id="2086069">[2086069](#2086069)</a> | Fixes an issue where an authenticated attacker could affect SQL Server memory when executing a specially crafted `CREATE STATISTICS` or `UPDATE STATISTICS` statement. | SQL Server Engine | Query Optimizer | All |
| <a id="2016962">[2016962](#2016962)</a> | [FIX: Error 20598 after adding columns that have default constraints as part of the primary key for an existing table and configuring transactional replication (KB5018231)](https://support.microsoft.com/help/5018231) | SQL Server Engine | Replication | Windows |
| <a id="2013429">[2013429](#2013429)</a> | Fixes an issue where the Distribution Agent returns a general message code 20046 instead of the connection failure message code 20084 when it fails to connect to the Subscriber by using the non-cached connection. These errors are specific to the Replication Distribution Agent. </br></br>Error message: </br></br>20046: The process encountered a general external error. </br>20084: The process could not connect to server. | SQL Server Engine | Replication | All |
| <a id="2047657">[2047657](#2047657)</a> | Consider the following scenario: </br></br> - You have a transactional replication setup. </br>- You execute the `sp_changearticle` stored procedure to change the property of an article on the publisher, and data manipulation language (DML) changes occur on the published table. </br></br>In this scenario, the Log Reader Agent reader thread may generate the following assertion dump when processing the log records: </br></br>\* Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;replrowset.cpp:\<LineNumber> </br>\* Expression:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(LSN)m_curLSN < (LSN)(pSchemas->schema_lsn_begin)</br>\* SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID> </br>\* Process ID:&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID> | SQL Server Engine | Replication | All |
| <a id="2068768">[2068768](#2068768)</a> | Fixes a gradual memory leak in the SQL Server process (the high usage under `MEMORYCLERK_SOSNODE`) caused by the Log Reader Agent in transactional replication. | SQL Server Engine | Replication | All |
| <a id="2086544">[2086544](#2086544)</a> | Fixes an issue with Change Tracking manual cleanup that caused internal tables to have orphaned records. Previously if the stored procedure experienced a lock timeout on a given table, cleanup wouldn't mark the table for retry and continue cleaning up the next table in the list. After you apply this fix, the table will be marked for retry. | SQL Server Engine | Replication | All |
| <a id="2104413">[2104413](#2104413)</a> | Fixes an issue where the temporary linked server created by the Log Reader Agent isn't always properly dropped when the publisher is in an Always On availability group (AG) and there's a failover at the distributor. After you apply this fix, the linked server is properly removed. | SQL Server Engine | Replication | Windows |
| <a id="2133575">[2133575](#2133575)</a> | Resolves a query performance issue that affects change tracking autocleanup and manual cleanup queries. </br></br>**Note**: You need to turn on trace flags 8286 and 8287, as this forces the cleanup query to use the `FORCE ORDER` and `FORCESEEK` hints to speed up the performance. | SQL Server Engine | Replication | All |
| <a id="2145226">[2145226](#2145226)</a> | Fixes a primary key violation error that's caused by a timing issue in change data capture (CDC) in SQL Server 2019. The CDC capture process may try to insert a duplicate `start_lsn` value in the `cdc.lsn_time_mapping` table, and you may see an error message that resembles the following one: </br></br>Violation of PRIMARY KEY constraint 'lsn_time_mapping_clustered_idx'. Cannot insert duplicate key in object 'cdc.lsn_time_mapping'. The duplicate key value is (*Value*). </br></br>**Note**: This fix covers all the causes of this error. For the same issue that occurs in SQL Server 2019 that has a previous cumulative update installed, SQL Server 2017, and SQL Server 2016, see the previous fix [KB 4521739](https://support.microsoft.com/help/4521739). However, the previous fix didn't cover all the cases. | SQL Server Engine | Replication | All |
| <a id="2151106">[2151106](#2151106)</a> | Fixes error 241 that occurs while running the Snapshot Agent, and the system date format was changed to a different format than the one used by SQL Server. </br></br>Error message: </br></br>Conversion failed when converting date and/or time from character string. | SQL Server Engine | Replication | All |
| <a id="2118514">[2118514](#2118514)</a> | [FIX: Database accessibility issues with high-volume customer workloads that use EKM for encryption and key generation (KB5023236)](../sqlserver-2022/database-accessibility-issues-high-volume-customer-workloads.md) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2021484">[2021484](#2021484)</a> | Fixes spelling issues in Database Engine error messages in SQL Server 2019. | SQL Server Engine | SQL Engine | All |
| <a id="2086005">[2086005](#2086005)</a> | Fixes an access violation exception that occurs in `sqlmin.dll!sort_persistresumableprogress` when you try to run the `CREATE INDEX` command that uses the `RESUMABLE = ON` option. | SQL Server Engine | Table Index Partition | All |
| <a id="2116348">[2116348](#2116348)</a> | Fixes error 692 that occurs when you create a non-clustered index under the following scenario: </br></br>- A clustered index already exists in the table. </br>- You create a non-clustered index that has the `RESUMABLE` option. </br>- The non-clustered index has an `INCLUDE` clause that has the key columns from the clustered index but in a different order. </br></br>Error message: </br></br>Msg 692, Level 22, State 1, line \<LineNumber> </br>Internal error. Buffer provided to write a fixed column value is too large. Run DBCC CHECKDB to check for any corruption. </br></br>**Note**: Specifying the included columns in the same order as in the clustered index or removing them from the `INCLUDE` clause can prevent the error. | SQL Server Engine | Table Index Partition | Windows |
| <a id="2122726">[2122726](#2122726)</a> | Lock escalation policy propagation from a user table that has spatial columns to the internal table of related spatial indexes is enabled, which minimizes the chance of deadlocks in the case of highly concurrent data manipulation language (DML) workloads. | SQL Server Engine | Table Index Partition | All |
| <a id="2123502">[2123502](#2123502)</a> | Fixes an assertion issue (Location: tabcreat.cpp:16938; Expression: idIS/8 < sizeof(bmIndexId)) that occurs when you run `ALTER TABLE ALTER COLUMN` on a table that has many indexes and statistics. | SQL Server Engine | Table Index Partition | Windows |
| <a id="2137926">[2137926](#2137926)</a> | Fixes an issue where schema modification (Sch-M) locks are acquired on foreign key tables when altering columns on the primary tables even if the transaction isn't related to the foreign key column. After you apply this fix, SQL Server only acquires schema stability (Sch-S) locks on foreign key tables. For more information, see [Schema locks](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#schema). | SQL Server Engine | Table Index Partition | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU19 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5023049)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5023049-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5023049-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5023049-x64.exe| E1E2C36AA7A3D713597BC12E2EEC2FCEBD126DD10BB45AAC2E5474903CD2C61E |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.35  | 292784    | 27-Jan-23 | 17:31 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 27-Jan-23 | 17:31 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.35      | 758224    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 175520    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 199600    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 202144    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 198560    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 214944    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 197552    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 193440    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 252320    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 173984    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.35      | 197040    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.35      | 1098696   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.35      | 567216    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 54736     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 59344     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 59856     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 58832     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 61896     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 58288     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 58320     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 67536     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 53672     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.35      | 58320     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17840     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17824     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17840     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17840     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17840     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17824     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17872     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 18896     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17832     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.35      | 17824     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 27-Jan-23 | 17:31 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 27-Jan-23 | 17:31 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 27-Jan-23 | 17:31 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 27-Jan-23 | 17:31 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 27-Jan-23 | 17:31 | x86      |
| Msmdctr.dll                                               | 2018.150.35.35  | 38352     | 27-Jan-23 | 17:31 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.35  | 47785424  | 27-Jan-23 | 17:31 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.35  | 66291664  | 27-Jan-23 | 17:31 | x64      |
| Msmdpump.dll                                              | 2018.150.35.35  | 10188704  | 27-Jan-23 | 17:31 | x64      |
| Msmdredir.dll                                             | 2018.150.35.35  | 7956936   | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 16800     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 16800     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 17360     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 16848     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 17360     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 17312     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 17360     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 18336     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 16848     | 27-Jan-23 | 17:31 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.35      | 16800     | 27-Jan-23 | 17:31 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.35  | 65831328  | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 833448    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1628112   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1454000   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1642960   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1608624   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1001392   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 992688    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1536976   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1521584   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 810960    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.35  | 1596336   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 832432    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1624496   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1450928   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1637808   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1604528   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 998832    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 991152    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1532848   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1518000   | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 809904    | 27-Jan-23 | 17:31 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.35  | 1591728   | 27-Jan-23 | 17:31 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.35  | 10185648  | 27-Jan-23 | 17:31 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.35  | 8279504   | 27-Jan-23 | 17:31 | x86      |
| Msolap.dll                                                | 2018.150.35.35  | 11016112  | 27-Jan-23 | 17:31 | x64      |
| Msolap.dll                                                | 2018.150.35.35  | 8608200   | 27-Jan-23 | 17:31 | x86      |
| Msolui.dll                                                | 2018.150.35.35  | 286128    | 27-Jan-23 | 17:31 | x86      |
| Msolui.dll                                                | 2018.150.35.35  | 306608    | 27-Jan-23 | 17:31 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 27-Jan-23 | 17:31 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 27-Jan-23 | 17:31 | x64      |
| Sqlboot.dll                                               | 2019.150.4298.1 | 214952    | 27-Jan-23 | 17:31 | x64      |
| Sqlceip.exe                                               | 15.0.4298.1     | 292808    | 27-Jan-23 | 17:34 | x86      |
| Sqldumper.exe                                             | 2019.150.4298.1 | 153504    | 27-Jan-23 | 17:31 | x86      |
| Sqldumper.exe                                             | 2019.150.4298.1 | 186312    | 27-Jan-23 | 17:34 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 27-Jan-23 | 17:31 | x86      |
| Tmapi.dll                                                 | 2018.150.35.35  | 6178224   | 27-Jan-23 | 17:31 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.35  | 4917680   | 27-Jan-23 | 17:31 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.35  | 1184688   | 27-Jan-23 | 17:31 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.35  | 6806440   | 27-Jan-23 | 17:31 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.35  | 26025904  | 27-Jan-23 | 17:31 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.35  | 35460528  | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4298.1 | 182216    | 27-Jan-23 | 17:31 | x64      |
| Batchparser.dll                      | 2019.150.4298.1 | 165800    | 27-Jan-23 | 17:31 | x86      |
| Instapi150.dll                       | 2019.150.4298.1 | 75680     | 27-Jan-23 | 17:31 | x86      |
| Instapi150.dll                       | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:31 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4298.1 | 100264    | 27-Jan-23 | 17:31 | x64      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4298.1     | 550824    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4298.1     | 550856    | 27-Jan-23 | 17:31 | x86      |
| Msasxpress.dll                       | 2018.150.35.35  | 27040     | 27-Jan-23 | 17:31 | x86      |
| Msasxpress.dll                       | 2018.150.35.35  | 32176     | 27-Jan-23 | 17:31 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4298.1 | 92072     | 27-Jan-23 | 17:31 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4298.1 | 75688     | 27-Jan-23 | 17:31 | x86      |
| Sqldumper.exe                        | 2019.150.4298.1 | 153504    | 27-Jan-23 | 17:31 | x86      |
| Sqldumper.exe                        | 2019.150.4298.1 | 186312    | 27-Jan-23 | 17:31 | x64      |
| Sqlftacct.dll                        | 2019.150.4298.1 | 59336     | 27-Jan-23 | 17:31 | x86      |
| Sqlftacct.dll                        | 2019.150.4298.1 | 79784     | 27-Jan-23 | 17:31 | x64      |
| Sqlmanager.dll                       | 2019.150.4298.1 | 743328    | 27-Jan-23 | 17:31 | x86      |
| Sqlmanager.dll                       | 2019.150.4298.1 | 878504    | 27-Jan-23 | 17:31 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4298.1 | 378824    | 27-Jan-23 | 17:31 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4298.1 | 432032    | 27-Jan-23 | 17:31 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4298.1 | 358296    | 27-Jan-23 | 17:31 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4298.1 | 276376    | 27-Jan-23 | 17:31 | x86      |
| Svrenumapi150.dll                    | 2019.150.4298.1 | 1161128   | 27-Jan-23 | 17:31 | x64      |
| Svrenumapi150.dll                    | 2019.150.4298.1 | 911272    | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4298.1  | 599976    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4298.1  | 599976    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4298.1  | 1857448   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4298.1  | 1857440   | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4298.1 | 137128    | 27-Jan-23 | 17:31 | x86      |
| Dreplaycommon.dll     | 2019.150.4298.1 | 667544    | 27-Jan-23 | 17:31 | x86      |
| Dreplayutil.dll       | 2019.150.4298.1 | 305096    | 27-Jan-23 | 17:31 | x86      |
| Instapi150.dll        | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:31 | x64      |
| Sqlresourceloader.dll | 2019.150.4298.1 | 38824     | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4298.1 | 667544    | 27-Jan-23 | 17:32 | x86      |
| Dreplaycontroller.exe | 2019.150.4298.1 | 366504    | 27-Jan-23 | 17:32 | x86      |
| Instapi150.dll        | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:31 | x64      |
| Sqlresourceloader.dll | 2019.150.4298.1 | 38824     | 27-Jan-23 | 17:32 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4298.1 | 4658088   | 27-Jan-23 | 17:58 | x64      |
| Aetm-enclave.dll                           | 2019.150.4298.1 | 4612504   | 27-Jan-23 | 17:58 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4298.1 | 4932384   | 27-Jan-23 | 17:58 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4298.1 | 4874576   | 27-Jan-23 | 17:58 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 27-Jan-23 | 18:16 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 27-Jan-23 | 18:17 | x64      |
| Batchparser.dll                            | 2019.150.4298.1 | 182216    | 27-Jan-23 | 17:58 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 27-Jan-23 | 18:16 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 27-Jan-23 | 18:16 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 27-Jan-23 | 18:16 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 27-Jan-23 | 18:16 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4298.1 | 280520    | 27-Jan-23 | 18:16 | x64      |
| Dcexec.exe                                 | 2019.150.4298.1 | 88008     | 27-Jan-23 | 18:16 | x64      |
| Fssres.dll                                 | 2019.150.4298.1 | 96160     | 27-Jan-23 | 18:16 | x64      |
| Hadrres.dll                                | 2019.150.4298.1 | 206760    | 27-Jan-23 | 18:16 | x64      |
| Hkcompile.dll                              | 2019.150.4298.1 | 1292192   | 27-Jan-23 | 18:16 | x64      |
| Hkengine.dll                               | 2019.150.4298.1 | 5793696   | 27-Jan-23 | 18:16 | x64      |
| Hkruntime.dll                              | 2019.150.4298.1 | 182176    | 27-Jan-23 | 18:16 | x64      |
| Hktempdb.dll                               | 2019.150.4298.1 | 63400     | 27-Jan-23 | 18:16 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 27-Jan-23 | 18:16 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4298.1     | 235424    | 27-Jan-23 | 18:16 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4298.1 | 391080    | 27-Jan-23 | 18:16 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4298.1 | 325536    | 27-Jan-23 | 18:16 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4298.1 | 92104     | 27-Jan-23 | 18:16 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 27-Jan-23 | 18:16 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 27-Jan-23 | 18:16 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 27-Jan-23 | 18:16 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 27-Jan-23 | 18:16 | x64      |
| Qds.dll                                    | 2019.150.4298.1 | 1185704   | 27-Jan-23 | 18:16 | x64      |
| Rsfxft.dll                                 | 2019.150.4298.1 | 51112     | 27-Jan-23 | 18:16 | x64      |
| Secforwarder.dll                           | 2019.150.4298.1 | 79768     | 27-Jan-23 | 18:16 | x64      |
| Sqagtres.dll                               | 2019.150.4298.1 | 87968     | 27-Jan-23 | 18:16 | x64      |
| Sqlaamss.dll                               | 2019.150.4298.1 | 108456    | 27-Jan-23 | 18:16 | x64      |
| Sqlaccess.dll                              | 2019.150.4298.1 | 493480    | 27-Jan-23 | 18:16 | x64      |
| Sqlagent.exe                               | 2019.150.4298.1 | 731040    | 27-Jan-23 | 18:16 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4298.1 | 79776     | 27-Jan-23 | 18:16 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4298.1 | 71584     | 27-Jan-23 | 18:16 | x86      |
| Sqlboot.dll                                | 2019.150.4298.1 | 214952    | 27-Jan-23 | 18:16 | x64      |
| Sqlceip.exe                                | 15.0.4298.1     | 292808    | 27-Jan-23 | 18:16 | x86      |
| Sqlcmdss.dll                               | 2019.150.4298.1 | 87968     | 27-Jan-23 | 18:16 | x64      |
| Sqlctr150.dll                              | 2019.150.4298.1 | 145312    | 27-Jan-23 | 18:16 | x64      |
| Sqlctr150.dll                              | 2019.150.4298.1 | 116640    | 27-Jan-23 | 18:16 | x86      |
| Sqldk.dll                                  | 2019.150.4298.1 | 3159968   | 27-Jan-23 | 18:16 | x64      |
| Sqldtsss.dll                               | 2019.150.4298.1 | 108488    | 27-Jan-23 | 18:16 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 1595304   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3504040   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3696544   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4163488   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4282272   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3413920   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3581856   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4159400   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4011936   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4065192   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 2221984   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 2172840   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3868576   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3544992   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4016024   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3823520   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3819424   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3614632   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3499944   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 1537952   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 3909544   | 27-Jan-23 | 17:58 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4298.1 | 4028320   | 27-Jan-23 | 17:58 | x64      |
| Sqllang.dll                                | 2019.150.4298.1 | 39991200  | 27-Jan-23 | 18:16 | x64      |
| Sqlmin.dll                                 | 2019.150.4298.1 | 40595912  | 27-Jan-23 | 18:16 | x64      |
| Sqlolapss.dll                              | 2019.150.4298.1 | 108448    | 27-Jan-23 | 18:16 | x64      |
| Sqlos.dll                                  | 2019.150.4298.1 | 42912     | 27-Jan-23 | 17:58 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4298.1 | 83880     | 27-Jan-23 | 18:16 | x64      |
| Sqlrepss.dll                               | 2019.150.4298.1 | 87968     | 27-Jan-23 | 18:16 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4298.1 | 51112     | 27-Jan-23 | 18:16 | x64      |
| Sqlscm.dll                                 | 2019.150.4298.1 | 87976     | 27-Jan-23 | 18:16 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4298.1 | 38856     | 27-Jan-23 | 18:16 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4298.1 | 5805984   | 27-Jan-23 | 18:16 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4298.1 | 673696    | 27-Jan-23 | 18:16 | x64      |
| Sqlservr.exe                               | 2019.150.4298.1 | 628648    | 27-Jan-23 | 18:16 | x64      |
| Sqlsvc.dll                                 | 2019.150.4298.1 | 182184    | 27-Jan-23 | 18:16 | x64      |
| Sqltses.dll                                | 2019.150.4298.1 | 9119688   | 27-Jan-23 | 18:16 | x64      |
| Sqsrvres.dll                               | 2019.150.4298.1 | 280480    | 27-Jan-23 | 18:16 | x64      |
| Stretchcodegen.exe                         | 15.0.4298.1     | 59296     | 27-Jan-23 | 17:58 | x86      |
| Svl.dll                                    | 2019.150.4298.1 | 161736    | 27-Jan-23 | 17:58 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 27-Jan-23 | 18:16 | x64      |
| Xe.dll                                     | 2019.150.4298.1 | 722848    | 27-Jan-23 | 18:16 | x64      |
| Xpadsi.exe                                 | 2019.150.4298.1 | 116680    | 27-Jan-23 | 18:16 | x64      |
| Xplog70.dll                                | 2019.150.4298.1 | 92072     | 27-Jan-23 | 18:16 | x64      |
| Xpqueue.dll                                | 2019.150.4298.1 | 92064     | 27-Jan-23 | 18:16 | x64      |
| Xprepl.dll                                 | 2019.150.4298.1 | 120736    | 27-Jan-23 | 18:16 | x64      |
| Xpstar.dll                                 | 2019.150.4298.1 | 472992    | 27-Jan-23 | 18:16 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4298.1 | 182216    | 27-Jan-23 | 17:33 | x64      |
| Batchparser.dll                                              | 2019.150.4298.1 | 165800    | 27-Jan-23 | 17:33 | x86      |
| Commanddest.dll                                              | 2019.150.4298.1 | 264096    | 27-Jan-23 | 17:31 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4298.1 | 231328    | 27-Jan-23 | 17:34 | x64      |
| Distrib.exe                                                  | 2019.150.4298.1 | 243608    | 27-Jan-23 | 17:31 | x64      |
| Dteparse.dll                                                 | 2019.150.4298.1 | 124832    | 27-Jan-23 | 17:32 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4298.1 | 133032    | 27-Jan-23 | 17:32 | x64      |
| Dtepkg.dll                                                   | 2019.150.4298.1 | 149416    | 27-Jan-23 | 17:32 | x64      |
| Dtexec.exe                                                   | 2019.150.4298.1 | 72616     | 27-Jan-23 | 17:32 | x64      |
| Dts.dll                                                      | 2019.150.4298.1 | 3143592   | 27-Jan-23 | 17:32 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4298.1 | 501672    | 27-Jan-23 | 17:32 | x64      |
| Dtsconn.dll                                                  | 2019.150.4298.1 | 522144    | 27-Jan-23 | 17:32 | x64      |
| Dtshost.exe                                                  | 2019.150.4298.1 | 106400    | 27-Jan-23 | 17:32 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4298.1 | 567208    | 27-Jan-23 | 17:32 | x64      |
| Dtspipeline.dll                                              | 2019.150.4298.1 | 1329064   | 27-Jan-23 | 17:31 | x64      |
| Dtswizard.exe                                                | 15.0.4298.1     | 886728    | 27-Jan-23 | 17:31 | x64      |
| Dtuparse.dll                                                 | 2019.150.4298.1 | 100264    | 27-Jan-23 | 17:32 | x64      |
| Dtutil.exe                                                   | 2019.150.4298.1 | 149448    | 27-Jan-23 | 17:32 | x64      |
| Exceldest.dll                                                | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:32 | x64      |
| Excelsrc.dll                                                 | 2019.150.4298.1 | 309144    | 27-Jan-23 | 17:32 | x64      |
| Execpackagetask.dll                                          | 2019.150.4298.1 | 186272    | 27-Jan-23 | 17:31 | x64      |
| Flatfiledest.dll                                             | 2019.150.4298.1 | 411560    | 27-Jan-23 | 17:31 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4298.1 | 427936    | 27-Jan-23 | 17:31 | x64      |
| Logread.exe                                                  | 2019.150.4298.1 | 722848    | 27-Jan-23 | 17:31 | x64      |
| Mergetxt.dll                                                 | 2019.150.4298.1 | 75680     | 27-Jan-23 | 17:31 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4298.1     | 59304     | 27-Jan-23 | 17:13 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4298.1     | 42920     | 27-Jan-23 | 17:33 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4298.1     | 391072    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4298.1 | 1697704   | 27-Jan-23 | 17:31 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4298.1 | 1640352   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4298.1     | 550856    | 27-Jan-23 | 17:31 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4298.1 | 112544    | 27-Jan-23 | 17:32 | x64      |
| Msgprox.dll                                                  | 2019.150.4298.1 | 300960    | 27-Jan-23 | 17:31 | x64      |
| Msoledbsql.dll                                               | 2018.186.5.0    | 2734064   | 27-Jan-23 | 17:31 | x64      |
| Msoledbsql.dll                                               | 2018.186.5.0    | 153616    | 27-Jan-23 | 17:34 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4298.1 | 1497032   | 27-Jan-23 | 17:34 | x64      |
| Oledbdest.dll                                                | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:31 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4298.1 | 313256    | 27-Jan-23 | 17:31 | x64      |
| Osql.exe                                                     | 2019.150.4298.1 | 92072     | 27-Jan-23 | 17:34 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4298.1 | 497568    | 27-Jan-23 | 17:31 | x64      |
| Rawdest.dll                                                  | 2019.150.4298.1 | 227232    | 27-Jan-23 | 17:31 | x64      |
| Rawsource.dll                                                | 2019.150.4298.1 | 210848    | 27-Jan-23 | 17:32 | x64      |
| Rdistcom.dll                                                 | 2019.150.4298.1 | 915360    | 27-Jan-23 | 17:31 | x64      |
| Recordsetdest.dll                                            | 2019.150.4298.1 | 202656    | 27-Jan-23 | 17:32 | x64      |
| Repldp.dll                                                   | 2019.150.4298.1 | 313288    | 27-Jan-23 | 17:31 | x64      |
| Replerrx.dll                                                 | 2019.150.4298.1 | 182216    | 27-Jan-23 | 17:31 | x64      |
| Replisapi.dll                                                | 2019.150.4298.1 | 395168    | 27-Jan-23 | 17:31 | x64      |
| Replmerg.exe                                                 | 2019.150.4298.1 | 563104    | 27-Jan-23 | 17:31 | x64      |
| Replprov.dll                                                 | 2019.150.4298.1 | 862112    | 27-Jan-23 | 17:31 | x64      |
| Replrec.dll                                                  | 2019.150.4298.1 | 1034184   | 27-Jan-23 | 17:31 | x64      |
| Replsub.dll                                                  | 2019.150.4298.1 | 473000    | 27-Jan-23 | 17:31 | x64      |
| Replsync.dll                                                 | 2019.150.4298.1 | 165800    | 27-Jan-23 | 17:31 | x64      |
| Spresolv.dll                                                 | 2019.150.4298.1 | 276384    | 27-Jan-23 | 17:31 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4298.1 | 264104    | 27-Jan-23 | 17:34 | x64      |
| Sqldiag.exe                                                  | 2019.150.4298.1 | 1140648   | 27-Jan-23 | 17:34 | x64      |
| Sqldistx.dll                                                 | 2019.150.4298.1 | 251848    | 27-Jan-23 | 17:31 | x64      |
| Sqllogship.exe                                               | 15.0.4298.1     | 104360    | 27-Jan-23 | 17:34 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4298.1 | 399304    | 27-Jan-23 | 17:31 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4298.1 | 38824     | 27-Jan-23 | 17:34 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4298.1 | 51112     | 27-Jan-23 | 17:34 | x64      |
| Sqlscm.dll                                                   | 2019.150.4298.1 | 79816     | 27-Jan-23 | 17:34 | x86      |
| Sqlscm.dll                                                   | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:34 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4298.1 | 149408    | 27-Jan-23 | 17:31 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4298.1 | 182184    | 27-Jan-23 | 17:34 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4298.1 | 202656    | 27-Jan-23 | 17:32 | x64      |
| Ssradd.dll                                                   | 2019.150.4298.1 | 83872     | 27-Jan-23 | 17:31 | x64      |
| Ssravg.dll                                                   | 2019.150.4298.1 | 83872     | 27-Jan-23 | 17:31 | x64      |
| Ssrdown.dll                                                  | 2019.150.4298.1 | 75680     | 27-Jan-23 | 17:31 | x64      |
| Ssrmax.dll                                                   | 2019.150.4298.1 | 83872     | 27-Jan-23 | 17:31 | x64      |
| Ssrmin.dll                                                   | 2019.150.4298.1 | 83880     | 27-Jan-23 | 17:31 | x64      |
| Ssrpub.dll                                                   | 2019.150.4298.1 | 79776     | 27-Jan-23 | 17:31 | x64      |
| Ssrup.dll                                                    | 2019.150.4298.1 | 75680     | 27-Jan-23 | 17:31 | x64      |
| Txagg.dll                                                    | 2019.150.4298.1 | 391080    | 27-Jan-23 | 17:32 | x64      |
| Txbdd.dll                                                    | 2019.150.4298.1 | 190360    | 27-Jan-23 | 17:33 | x64      |
| Txdatacollector.dll                                          | 2019.150.4298.1 | 473000    | 27-Jan-23 | 17:34 | x64      |
| Txdataconvert.dll                                            | 2019.150.4298.1 | 317344    | 27-Jan-23 | 17:32 | x64      |
| Txderived.dll                                                | 2019.150.4298.1 | 640928    | 27-Jan-23 | 17:32 | x64      |
| Txlookup.dll                                                 | 2019.150.4298.1 | 542624    | 27-Jan-23 | 17:32 | x64      |
| Txmerge.dll                                                  | 2019.150.4298.1 | 247712    | 27-Jan-23 | 17:33 | x64      |
| Txmergejoin.dll                                              | 2019.150.4298.1 | 309160    | 27-Jan-23 | 17:33 | x64      |
| Txmulticast.dll                                              | 2019.150.4298.1 | 145312    | 27-Jan-23 | 17:33 | x64      |
| Txrowcount.dll                                               | 2019.150.4298.1 | 141216    | 27-Jan-23 | 17:32 | x64      |
| Txsort.dll                                                   | 2019.150.4298.1 | 288672    | 27-Jan-23 | 17:32 | x64      |
| Txsplit.dll                                                  | 2019.150.4298.1 | 624552    | 27-Jan-23 | 17:32 | x64      |
| Txunionall.dll                                               | 2019.150.4298.1 | 198552    | 27-Jan-23 | 17:33 | x64      |
| Xe.dll                                                       | 2019.150.4298.1 | 722848    | 27-Jan-23 | 17:31 | x64      |
| Xmlsub.dll                                                   | 2019.150.4298.1 | 296864    | 27-Jan-23 | 17:31 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4298.1 | 96200     | 27-Jan-23 | 17:34 | x64      |
| Exthost.exe        | 2019.150.4298.1 | 239520    | 27-Jan-23 | 17:34 | x64      |
| Launchpad.exe      | 2019.150.4298.1 | 1226696   | 27-Jan-23 | 17:34 | x64      |
| Sqlsatellite.dll   | 2019.150.4298.1 | 1025960   | 27-Jan-23 | 17:34 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4298.1 | 686024    | 27-Jan-23 | 17:31 | x64      |
| Fdhost.exe     | 2019.150.4298.1 | 128936    | 27-Jan-23 | 17:31 | x64      |
| Fdlauncher.exe | 2019.150.4298.1 | 79784     | 27-Jan-23 | 17:31 | x64      |
| Sqlft150ph.dll | 2019.150.4298.1 | 92104     | 27-Jan-23 | 17:31 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4298.1  | 30664     | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4298.1 | 227240    | 27-Jan-23 | 17:31 | x86      |
| Commanddest.dll                                               | 2019.150.4298.1 | 264096    | 27-Jan-23 | 17:31 | x64      |
| Dteparse.dll                                                  | 2019.150.4298.1 | 112584    | 27-Jan-23 | 17:31 | x86      |
| Dteparse.dll                                                  | 2019.150.4298.1 | 124832    | 27-Jan-23 | 17:32 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4298.1 | 133032    | 27-Jan-23 | 17:31 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4298.1 | 116680    | 27-Jan-23 | 17:31 | x86      |
| Dtepkg.dll                                                    | 2019.150.4298.1 | 133064    | 27-Jan-23 | 17:31 | x86      |
| Dtepkg.dll                                                    | 2019.150.4298.1 | 149416    | 27-Jan-23 | 17:31 | x64      |
| Dtexec.exe                                                    | 2019.150.4298.1 | 63896     | 27-Jan-23 | 17:31 | x86      |
| Dtexec.exe                                                    | 2019.150.4298.1 | 72616     | 27-Jan-23 | 17:32 | x64      |
| Dts.dll                                                       | 2019.150.4298.1 | 2762696   | 27-Jan-23 | 17:31 | x86      |
| Dts.dll                                                       | 2019.150.4298.1 | 3143592   | 27-Jan-23 | 17:31 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4298.1 | 444328    | 27-Jan-23 | 17:31 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4298.1 | 501672    | 27-Jan-23 | 17:32 | x64      |
| Dtsconn.dll                                                   | 2019.150.4298.1 | 432072    | 27-Jan-23 | 17:31 | x86      |
| Dtsconn.dll                                                   | 2019.150.4298.1 | 522144    | 27-Jan-23 | 17:31 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4298.1 | 93608     | 27-Jan-23 | 17:31 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4298.1 | 112040    | 27-Jan-23 | 17:31 | x64      |
| Dtshost.exe                                                   | 2019.150.4298.1 | 106400    | 27-Jan-23 | 17:31 | x64      |
| Dtshost.exe                                                   | 2019.150.4298.1 | 88992     | 27-Jan-23 | 17:31 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4298.1 | 554920    | 27-Jan-23 | 17:31 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4298.1 | 567208    | 27-Jan-23 | 17:31 | x64      |
| Dtspipeline.dll                                               | 2019.150.4298.1 | 1120168   | 27-Jan-23 | 17:31 | x86      |
| Dtspipeline.dll                                               | 2019.150.4298.1 | 1329064   | 27-Jan-23 | 17:31 | x64      |
| Dtswizard.exe                                                 | 15.0.4298.1     | 886728    | 27-Jan-23 | 17:31 | x64      |
| Dtswizard.exe                                                 | 15.0.4298.1     | 890824    | 27-Jan-23 | 17:31 | x86      |
| Dtuparse.dll                                                  | 2019.150.4298.1 | 100264    | 27-Jan-23 | 17:31 | x64      |
| Dtuparse.dll                                                  | 2019.150.4298.1 | 88008     | 27-Jan-23 | 17:31 | x86      |
| Dtutil.exe                                                    | 2019.150.4298.1 | 149448    | 27-Jan-23 | 17:31 | x64      |
| Dtutil.exe                                                    | 2019.150.4298.1 | 130456    | 27-Jan-23 | 17:32 | x86      |
| Exceldest.dll                                                 | 2019.150.4298.1 | 235432    | 27-Jan-23 | 17:31 | x86      |
| Exceldest.dll                                                 | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:31 | x64      |
| Excelsrc.dll                                                  | 2019.150.4298.1 | 260008    | 27-Jan-23 | 17:31 | x86      |
| Excelsrc.dll                                                  | 2019.150.4298.1 | 309144    | 27-Jan-23 | 17:31 | x64      |
| Execpackagetask.dll                                           | 2019.150.4298.1 | 149448    | 27-Jan-23 | 17:31 | x86      |
| Execpackagetask.dll                                           | 2019.150.4298.1 | 186272    | 27-Jan-23 | 17:31 | x64      |
| Flatfiledest.dll                                              | 2019.150.4298.1 | 358344    | 27-Jan-23 | 17:31 | x86      |
| Flatfiledest.dll                                              | 2019.150.4298.1 | 411560    | 27-Jan-23 | 17:31 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4298.1 | 370600    | 27-Jan-23 | 17:31 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4298.1 | 427936    | 27-Jan-23 | 17:31 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4298.1     | 120744    | 27-Jan-23 | 17:31 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4298.1     | 120736    | 27-Jan-23 | 17:31 | x86      |
| Isserverexec.exe                                              | 15.0.4298.1     | 149408    | 27-Jan-23 | 17:31 | x86      |
| Isserverexec.exe                                              | 15.0.4298.1     | 145312    | 27-Jan-23 | 17:31 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4298.1     | 116680    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4298.1     | 59296     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4298.1     | 59304     | 27-Jan-23 | 17:32 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4298.1     | 509864    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4298.1     | 509896    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4298.1     | 42912     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4298.1     | 42920     | 27-Jan-23 | 17:32 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4298.1     | 391072    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4298.1     | 59296     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4298.1     | 59336     | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4298.1     | 141216    | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4298.1     | 141216    | 27-Jan-23 | 17:31 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4298.1     | 219048    | 27-Jan-23 | 17:31 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4298.1 | 100256    | 27-Jan-23 | 17:31 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4298.1 | 112544    | 27-Jan-23 | 17:31 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.35  | 10063792  | 27-Jan-23 | 17:31 | x64      |
| Odbcdest.dll                                                  | 2019.150.4298.1 | 321448    | 27-Jan-23 | 17:31 | x86      |
| Odbcdest.dll                                                  | 2019.150.4298.1 | 370600    | 27-Jan-23 | 17:31 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4298.1 | 329640    | 27-Jan-23 | 17:31 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4298.1 | 382888    | 27-Jan-23 | 17:31 | x64      |
| Oledbdest.dll                                                 | 2019.150.4298.1 | 239560    | 27-Jan-23 | 17:31 | x86      |
| Oledbdest.dll                                                 | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:31 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4298.1 | 264096    | 27-Jan-23 | 17:31 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4298.1 | 313256    | 27-Jan-23 | 17:31 | x64      |
| Rawdest.dll                                                   | 2019.150.4298.1 | 190376    | 27-Jan-23 | 17:31 | x86      |
| Rawdest.dll                                                   | 2019.150.4298.1 | 227232    | 27-Jan-23 | 17:31 | x64      |
| Rawsource.dll                                                 | 2019.150.4298.1 | 178088    | 27-Jan-23 | 17:31 | x86      |
| Rawsource.dll                                                 | 2019.150.4298.1 | 210848    | 27-Jan-23 | 17:31 | x64      |
| Recordsetdest.dll                                             | 2019.150.4298.1 | 174024    | 27-Jan-23 | 17:31 | x86      |
| Recordsetdest.dll                                             | 2019.150.4298.1 | 202656    | 27-Jan-23 | 17:31 | x64      |
| Sqlceip.exe                                                   | 15.0.4298.1     | 292808    | 27-Jan-23 | 17:32 | x86      |
| Sqldest.dll                                                   | 2019.150.4298.1 | 239560    | 27-Jan-23 | 17:31 | x86      |
| Sqldest.dll                                                   | 2019.150.4298.1 | 276392    | 27-Jan-23 | 17:31 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4298.1 | 169928    | 27-Jan-23 | 17:31 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4298.1 | 202656    | 27-Jan-23 | 17:32 | x64      |
| Txagg.dll                                                     | 2019.150.4298.1 | 329640    | 27-Jan-23 | 17:31 | x86      |
| Txagg.dll                                                     | 2019.150.4298.1 | 391080    | 27-Jan-23 | 17:32 | x64      |
| Txbdd.dll                                                     | 2019.150.4298.1 | 153512    | 27-Jan-23 | 17:31 | x86      |
| Txbdd.dll                                                     | 2019.150.4298.1 | 190360    | 27-Jan-23 | 17:32 | x64      |
| Txbestmatch.dll                                               | 2019.150.4298.1 | 546760    | 27-Jan-23 | 17:31 | x86      |
| Txbestmatch.dll                                               | 2019.150.4298.1 | 653256    | 27-Jan-23 | 17:32 | x64      |
| Txcache.dll                                                   | 2019.150.4298.1 | 165832    | 27-Jan-23 | 17:31 | x86      |
| Txcache.dll                                                   | 2019.150.4298.1 | 198568    | 27-Jan-23 | 17:31 | x64      |
| Txcharmap.dll                                                 | 2019.150.4298.1 | 272328    | 27-Jan-23 | 17:31 | x86      |
| Txcharmap.dll                                                 | 2019.150.4298.1 | 313248    | 27-Jan-23 | 17:32 | x64      |
| Txcopymap.dll                                                 | 2019.150.4298.1 | 165832    | 27-Jan-23 | 17:31 | x86      |
| Txcopymap.dll                                                 | 2019.150.4298.1 | 198568    | 27-Jan-23 | 17:31 | x64      |
| Txdataconvert.dll                                             | 2019.150.4298.1 | 276424    | 27-Jan-23 | 17:31 | x86      |
| Txdataconvert.dll                                             | 2019.150.4298.1 | 317344    | 27-Jan-23 | 17:32 | x64      |
| Txderived.dll                                                 | 2019.150.4298.1 | 559048    | 27-Jan-23 | 17:31 | x86      |
| Txderived.dll                                                 | 2019.150.4298.1 | 640928    | 27-Jan-23 | 17:31 | x64      |
| Txfileextractor.dll                                           | 2019.150.4298.1 | 182216    | 27-Jan-23 | 17:31 | x86      |
| Txfileextractor.dll                                           | 2019.150.4298.1 | 219040    | 27-Jan-23 | 17:31 | x64      |
| Txfileinserter.dll                                            | 2019.150.4298.1 | 182184    | 27-Jan-23 | 17:31 | x86      |
| Txfileinserter.dll                                            | 2019.150.4298.1 | 214936    | 27-Jan-23 | 17:32 | x64      |
| Txgroupdups.dll                                               | 2019.150.4298.1 | 255944    | 27-Jan-23 | 17:31 | x86      |
| Txgroupdups.dll                                               | 2019.150.4298.1 | 313256    | 27-Jan-23 | 17:32 | x64      |
| Txlineage.dll                                                 | 2019.150.4298.1 | 128968    | 27-Jan-23 | 17:31 | x86      |
| Txlineage.dll                                                 | 2019.150.4298.1 | 153504    | 27-Jan-23 | 17:32 | x64      |
| Txlookup.dll                                                  | 2019.150.4298.1 | 468936    | 27-Jan-23 | 17:31 | x86      |
| Txlookup.dll                                                  | 2019.150.4298.1 | 542624    | 27-Jan-23 | 17:32 | x64      |
| Txmerge.dll                                                   | 2019.150.4298.1 | 202664    | 27-Jan-23 | 17:31 | x86      |
| Txmerge.dll                                                   | 2019.150.4298.1 | 247712    | 27-Jan-23 | 17:31 | x64      |
| Txmergejoin.dll                                               | 2019.150.4298.1 | 247752    | 27-Jan-23 | 17:31 | x86      |
| Txmergejoin.dll                                               | 2019.150.4298.1 | 309160    | 27-Jan-23 | 17:32 | x64      |
| Txmulticast.dll                                               | 2019.150.4298.1 | 116680    | 27-Jan-23 | 17:31 | x86      |
| Txmulticast.dll                                               | 2019.150.4298.1 | 145312    | 27-Jan-23 | 17:32 | x64      |
| Txpivot.dll                                                   | 2019.150.4298.1 | 206792    | 27-Jan-23 | 17:31 | x86      |
| Txpivot.dll                                                   | 2019.150.4298.1 | 239520    | 27-Jan-23 | 17:31 | x64      |
| Txrowcount.dll                                                | 2019.150.4298.1 | 112584    | 27-Jan-23 | 17:31 | x86      |
| Txrowcount.dll                                                | 2019.150.4298.1 | 141216    | 27-Jan-23 | 17:32 | x64      |
| Txsampling.dll                                                | 2019.150.4298.1 | 157640    | 27-Jan-23 | 17:31 | x86      |
| Txsampling.dll                                                | 2019.150.4298.1 | 194464    | 27-Jan-23 | 17:32 | x64      |
| Txscd.dll                                                     | 2019.150.4298.1 | 198568    | 27-Jan-23 | 17:31 | x86      |
| Txscd.dll                                                     | 2019.150.4298.1 | 235424    | 27-Jan-23 | 17:31 | x64      |
| Txsort.dll                                                    | 2019.150.4298.1 | 231368    | 27-Jan-23 | 17:31 | x86      |
| Txsort.dll                                                    | 2019.150.4298.1 | 288672    | 27-Jan-23 | 17:31 | x64      |
| Txsplit.dll                                                   | 2019.150.4298.1 | 550824    | 27-Jan-23 | 17:31 | x86      |
| Txsplit.dll                                                   | 2019.150.4298.1 | 624552    | 27-Jan-23 | 17:31 | x64      |
| Txtermextraction.dll                                          | 2019.150.4298.1 | 8644520   | 27-Jan-23 | 17:31 | x86      |
| Txtermextraction.dll                                          | 2019.150.4298.1 | 8701896   | 27-Jan-23 | 17:32 | x64      |
| Txtermlookup.dll                                              | 2019.150.4298.1 | 4138952   | 27-Jan-23 | 17:31 | x86      |
| Txtermlookup.dll                                              | 2019.150.4298.1 | 4183968   | 27-Jan-23 | 17:31 | x64      |
| Txunionall.dll                                                | 2019.150.4298.1 | 161736    | 27-Jan-23 | 17:31 | x86      |
| Txunionall.dll                                                | 2019.150.4298.1 | 198552    | 27-Jan-23 | 17:32 | x64      |
| Txunpivot.dll                                                 | 2019.150.4298.1 | 182184    | 27-Jan-23 | 17:31 | x86      |
| Txunpivot.dll                                                 | 2019.150.4298.1 | 214952    | 27-Jan-23 | 17:31 | x64      |
| Xe.dll                                                        | 2019.150.4298.1 | 722848    | 27-Jan-23 | 17:31 | x64      |
| Xe.dll                                                        | 2019.150.4298.1 | 632736    | 27-Jan-23 | 17:32 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1959.0     | 559544    | 27-Jan-23 | 18:03 | x86      |
| Dmsnative.dll                                                        | 2018.150.1959.0 | 152536    | 27-Jan-23 | 18:03 | x64      |
| Dwengineservice.dll                                                  | 15.0.1959.0     | 44968     | 27-Jan-23 | 18:03 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 27-Jan-23 | 18:03 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 27-Jan-23 | 18:03 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 27-Jan-23 | 18:03 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 27-Jan-23 | 18:03 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 27-Jan-23 | 18:03 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 27-Jan-23 | 18:03 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 27-Jan-23 | 18:03 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 27-Jan-23 | 18:03 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 27-Jan-23 | 18:03 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 27-Jan-23 | 18:03 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 27-Jan-23 | 18:03 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 27-Jan-23 | 18:03 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 27-Jan-23 | 18:03 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 27-Jan-23 | 18:03 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 27-Jan-23 | 18:03 | x64      |
| Instapi150.dll                                                       | 2019.150.4298.1 | 87976     | 27-Jan-23 | 18:03 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 27-Jan-23 | 18:03 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 27-Jan-23 | 18:03 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 27-Jan-23 | 18:03 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 27-Jan-23 | 18:03 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 27-Jan-23 | 18:03 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 27-Jan-23 | 18:03 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 27-Jan-23 | 18:03 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 27-Jan-23 | 18:03 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 27-Jan-23 | 18:03 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 27-Jan-23 | 18:03 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1959.0     | 67512     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1959.0     | 293336    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1959.0     | 1956792   | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1959.0     | 169400    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1959.0     | 649144    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1959.0     | 246232    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1959.0     | 139176    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1959.0     | 79800     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1959.0     | 51112     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1959.0     | 88488     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1959.0     | 1129432   | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1959.0     | 80808     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1959.0     | 70616     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1959.0     | 35280     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1959.0     | 31192     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1959.0     | 46552     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1959.0     | 21464     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1959.0     | 26584     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1959.0     | 131496    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1959.0     | 86488     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1959.0     | 100824    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1959.0     | 292824    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 120280    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 138200    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 141240    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 137688    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 150456    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 139704    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 134616    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 176568    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 117176    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1959.0     | 136664    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1959.0     | 72616     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1959.0     | 21928     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1959.0     | 37336     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1959.0     | 128936    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1959.0     | 3064760   | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1959.0     | 3955624   | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 118232    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 133032    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 137640    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 133592    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 148392    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 134096    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 130472    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 170920    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 115112    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1959.0     | 132008    | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1959.0     | 67544     | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1959.0     | 2682792   | 27-Jan-23 | 18:03 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1959.0     | 2436568   | 27-Jan-23 | 18:03 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4298.1 | 452552    | 27-Jan-23 | 18:03 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4298.1 | 7403432   | 27-Jan-23 | 18:03 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 27-Jan-23 | 18:03 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 27-Jan-23 | 18:03 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 27-Jan-23 | 18:03 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 27-Jan-23 | 18:03 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 27-Jan-23 | 18:03 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 27-Jan-23 | 18:03 | x64      |
| Secforwarder.dll                                                     | 2019.150.4298.1 | 79768     | 27-Jan-23 | 18:03 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1959.0 | 61400     | 27-Jan-23 | 18:03 | x64      |
| Sqldk.dll                                                            | 2019.150.4298.1 | 3159968   | 27-Jan-23 | 18:03 | x64      |
| Sqldumper.exe                                                        | 2019.150.4298.1 | 186312    | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 1595304   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 4163488   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 3413920   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 4159400   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 4065192   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 2221984   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 2172840   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 3823520   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 3819424   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 1537952   | 27-Jan-23 | 18:03 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4298.1 | 4028320   | 27-Jan-23 | 18:03 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 27-Jan-23 | 18:03 | x64      |
| Sqlos.dll                                                            | 2019.150.4298.1 | 42912     | 27-Jan-23 | 18:03 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1959.0 | 4841432   | 27-Jan-23 | 18:03 | x64      |
| Sqltses.dll                                                          | 2019.150.4298.1 | 9119688   | 27-Jan-23 | 18:03 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 27-Jan-23 | 18:03 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 27-Jan-23 | 18:03 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 27-Jan-23 | 18:03 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 27-Jan-23 | 18:03 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 27-Jan-23 | 18:03 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 27-Jan-23 | 18:03 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4298.1  | 30664     | 27-Jan-23 | 17:31 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4298.1 | 1632200   | 27-Jan-23 | 17:48 | x86      |
| Dtaengine.exe                                                | 2019.150.4298.1 | 219080    | 27-Jan-23 | 17:48 | x86      |
| Dteparse.dll                                                 | 2019.150.4298.1 | 112584    | 27-Jan-23 | 17:47 | x86      |
| Dteparse.dll                                                 | 2019.150.4298.1 | 124832    | 27-Jan-23 | 17:47 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4298.1 | 116680    | 27-Jan-23 | 17:47 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4298.1 | 133032    | 27-Jan-23 | 17:47 | x64      |
| Dtepkg.dll                                                   | 2019.150.4298.1 | 133064    | 27-Jan-23 | 17:47 | x86      |
| Dtepkg.dll                                                   | 2019.150.4298.1 | 149416    | 27-Jan-23 | 17:47 | x64      |
| Dtexec.exe                                                   | 2019.150.4298.1 | 63896     | 27-Jan-23 | 17:47 | x86      |
| Dtexec.exe                                                   | 2019.150.4298.1 | 72616     | 27-Jan-23 | 17:47 | x64      |
| Dts.dll                                                      | 2019.150.4298.1 | 2762696   | 27-Jan-23 | 17:47 | x86      |
| Dts.dll                                                      | 2019.150.4298.1 | 3143592   | 27-Jan-23 | 17:47 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4298.1 | 444328    | 27-Jan-23 | 17:47 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4298.1 | 501672    | 27-Jan-23 | 17:47 | x64      |
| Dtsconn.dll                                                  | 2019.150.4298.1 | 432072    | 27-Jan-23 | 17:47 | x86      |
| Dtsconn.dll                                                  | 2019.150.4298.1 | 522144    | 27-Jan-23 | 17:47 | x64      |
| Dtshost.exe                                                  | 2019.150.4298.1 | 106400    | 27-Jan-23 | 17:47 | x64      |
| Dtshost.exe                                                  | 2019.150.4298.1 | 88992     | 27-Jan-23 | 17:47 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4298.1 | 554920    | 27-Jan-23 | 17:47 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4298.1 | 567208    | 27-Jan-23 | 17:47 | x64      |
| Dtspipeline.dll                                              | 2019.150.4298.1 | 1120168   | 27-Jan-23 | 17:47 | x86      |
| Dtspipeline.dll                                              | 2019.150.4298.1 | 1329064   | 27-Jan-23 | 17:47 | x64      |
| Dtswizard.exe                                                | 15.0.4298.1     | 886728    | 27-Jan-23 | 17:47 | x64      |
| Dtswizard.exe                                                | 15.0.4298.1     | 890824    | 27-Jan-23 | 17:47 | x86      |
| Dtuparse.dll                                                 | 2019.150.4298.1 | 100264    | 27-Jan-23 | 17:47 | x64      |
| Dtuparse.dll                                                 | 2019.150.4298.1 | 88008     | 27-Jan-23 | 17:47 | x86      |
| Dtutil.exe                                                   | 2019.150.4298.1 | 130456    | 27-Jan-23 | 17:47 | x86      |
| Dtutil.exe                                                   | 2019.150.4298.1 | 149448    | 27-Jan-23 | 17:47 | x64      |
| Exceldest.dll                                                | 2019.150.4298.1 | 235432    | 27-Jan-23 | 17:47 | x86      |
| Exceldest.dll                                                | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:47 | x64      |
| Excelsrc.dll                                                 | 2019.150.4298.1 | 260008    | 27-Jan-23 | 17:47 | x86      |
| Excelsrc.dll                                                 | 2019.150.4298.1 | 309144    | 27-Jan-23 | 17:47 | x64      |
| Flatfiledest.dll                                             | 2019.150.4298.1 | 358344    | 27-Jan-23 | 17:47 | x86      |
| Flatfiledest.dll                                             | 2019.150.4298.1 | 411560    | 27-Jan-23 | 17:47 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4298.1 | 370600    | 27-Jan-23 | 17:47 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4298.1 | 427936    | 27-Jan-23 | 17:47 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4298.1     | 116640    | 27-Jan-23 | 17:47 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4298.1     | 403368    | 27-Jan-23 | 17:35 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4298.1     | 403352    | 27-Jan-23 | 17:35 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4298.1     | 3004320   | 27-Jan-23 | 17:35 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4298.1     | 3004320   | 27-Jan-23 | 17:35 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4298.1     | 42912     | 27-Jan-23 | 17:47 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4298.1     | 42920     | 27-Jan-23 | 17:47 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4298.1     | 59336     | 27-Jan-23 | 17:47 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 27-Jan-23 | 17:47 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4298.1 | 100256    | 27-Jan-23 | 17:47 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4298.1 | 112544    | 27-Jan-23 | 17:47 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.35  | 8279504   | 27-Jan-23 | 17:35 | x86      |
| Oledbdest.dll                                                | 2019.150.4298.1 | 239560    | 27-Jan-23 | 17:47 | x86      |
| Oledbdest.dll                                                | 2019.150.4298.1 | 280488    | 27-Jan-23 | 17:47 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4298.1 | 264096    | 27-Jan-23 | 17:47 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4298.1 | 313256    | 27-Jan-23 | 17:47 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4298.1 | 38824     | 27-Jan-23 | 17:47 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4298.1 | 51112     | 27-Jan-23 | 17:47 | x64      |
| Sqlscm.dll                                                   | 2019.150.4298.1 | 79816     | 27-Jan-23 | 17:48 | x86      |
| Sqlscm.dll                                                   | 2019.150.4298.1 | 87976     | 27-Jan-23 | 17:48 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4298.1 | 182184    | 27-Jan-23 | 17:48 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4298.1 | 149408    | 27-Jan-23 | 17:48 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4298.1 | 169928    | 27-Jan-23 | 17:47 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4298.1 | 202656    | 27-Jan-23 | 17:47 | x64      |
| Txdataconvert.dll                                            | 2019.150.4298.1 | 276424    | 27-Jan-23 | 17:47 | x86      |
| Txdataconvert.dll                                            | 2019.150.4298.1 | 317344    | 27-Jan-23 | 17:47 | x64      |
| Xe.dll                                                       | 2019.150.4298.1 | 632736    | 27-Jan-23 | 17:47 | x86      |
| Xe.dll                                                       | 2019.150.4298.1 | 722848    | 27-Jan-23 | 17:47 | x64      |

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
