---
title: Cumulative update 1 for SQL Server 2022 (KB5022375)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 1 (KB5022375).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5022375
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5022375 - Cumulative Update 1 for SQL Server 2022

_Release Date:_ &nbsp; February 16, 2023  
_Version:_ &nbsp; 16.0.4003.1

## Summary

This article describes Cumulative Update package 1 (CU1) for Microsoft SQL Server 2022. This update contains 64 [fixes](#improvements-and-fixes-included-in-this-update) and updates components in the following builds:

- SQL Server - Product version: **16.0.4003.1**, file version: **2022.160.4003.1**
- Analysis Services - Product version: **16.0.43.208**, file version: **2022.160.43.208**

> [!NOTE]
> This Cumulative Update includes the recently released GDR for SQL Server 2022 ([KB5021522 - Description of the security update for SQL Server 2022 GDR: February 14, 2023](https://support.microsoft.com/help/5021522)). For more information about SQL Servicing releases, see [Servicing models for SQL Server](../../general/servicing-models-sql-server.md).

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|-|-|-|-|-|
| <a id="2078803">[2078803](#2078803)</a> | Fixes potential memory access violations and incorrect results when executing specific Data Analysis Expressions (DAX) queries that trigger the internal Horizontal Fusion query optimization. </br></br>**Note** Before you apply the cumulative update, you can disable the feature by setting the `DAX\HorizontalFusion` configuration option to **0** as a workaround. | Analysis Services | Analysis Services | Windows |
| <a id="2113832">[2113832](#2113832)</a> | Updates Microsoft.Data.SqlClient assemblies used by the mashup engine to address security vulnerability discussed in [CVE-2022-41064](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-41064). | Analysis Services | Analysis Services | Windows |
| <a id="2115275">[2115275](#2115275)</a> | Enhances the encryption algorithm that's used to encrypt data sources and connection strings in SQL Server Analysis Services (SSAS) models. For more information, see [Upgrade encryption](https://go.microsoft.com/fwlink/?linkid=2224274). | Analysis Services | Analysis Services | Windows |
| <a id="2082644">[2082644](#2082644)</a></br><a id="2089261">[2089261](#2089261)</a> | Fixes an issue where any member who has the DQS KB Operator (dqs_kb_operator) role or a higher privilege level role can create or overwrite arbitrary files on the machine hosting SQL Server as the account that runs the SQL Server service (the default account is `NT SERVICE\MSSQLSERVER`). | Data Quality Services | Data Quality Services | Windows |
| <a id="2008855">[2008855](#2008855)</a> | Fixes the following error that occurs when you try to start the SQL Server Import and Export Wizard after you install the SQL Server Database Engine: </br></br>An error occurred which the SQL Server Integration Services Wizard was not prepared to handle. (SQL Server Import and Export Wizard) </br></br>\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\= </br></br>Could not load file or assembly 'Microsoft.DataTransformationServices.ScaleHelper, Version=16.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' or one of its dependencies. The system cannot find the file specified. (DTSWizard) | Integration Services | Integration Services | Windows |
| <a id="2076990">[2076990](#2076990)</a> | Fixes the following error that occurs when running the change data capture (CDC) Control task fails: </br></br>Could not load file or assembly 'Microsoft.SqlServer.DtsMsg, Version=16.100.0.0,Culture=neutral, PublicKeyToken=89845dcd8080cc91' or one of its dependencies. The located assembly's manifest definition does not match the assembly reference. (Exception from HRESULT: 0x80131040) | Integration Services | Integration Services | Windows |
| <a id="2159526">[2159526](#2159526)</a> | Reverts the length of the `ROUTINE_DEFINITION` column to 4000 in the `INFORMATION_SCHEMA.ROUTINES` view as the previous change in the length may cause unexpected inconsistencies. | Integration Services | Integration Services | All |
| <a id="2042238">[2042238](#2042238)</a> | Fixes "The incoming tabular data stream (TDS) remote procedure call (RPC) protocol stream is incorrect. Parameter 1 (""): Data type 0x00 is unknown" error that occurs when using the [strict encryption option](/sql/relational-databases/security/networking/connect-with-strict-encryption) in your connection settings. For an example about this scenario, see [Invalid TDS Stream errors with Encrypt=Strict when executing Stored Procedures](https://github.com/dotnet/SqlClient/issues/1807). | SQL Connectivity | SQL Connectivity | All |
| <a id="2120777">[2120777](#2120777)</a> | Fixes a rare issue where memory corruption in the ODBC driver can occur in communications between two SQL Server instances. This issue occurs when the target SQL Server instance uses a down-level version of the Tabular Data Stream (TDS) protocol. An improper version check causes image data types to be decoded improperly on the client-side of the connection. | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2157874">[2157874](#2157874)</a> | Fixes an access violation and `INVALID_POINTER_READ_CPP_EXCEPTION_c0000005_sqldk.dll!ex_oomCheck` exceptions triggered by an out-of-memory (OOM) exception when the SQL Server instance is under memory pressure. | SQL performance | Query Optimizer | All |
| <a id="2069101">[2069101](#2069101)</a> | Fixes an issue where Database Mail fails to send email messages and logs the following error message in the SQL Server error log, when used in a contained availability group (AG): </br></br>The activated proc '[dbo].[sp_sysmail_activate]' running on queue '\<DatabaseName>_msdb.dbo.ExternalMailQueue' output the following: 'Cannot find the object 'ExternalMailQueue' because it does not exist or you do not have permissions.' | SQL Server Client Tools | Database Mail | All |
| <a id="2114695">[2114695](#2114695)</a> | Fixes an issue with differential backup skipping new Page Free Space (PFS) pages after a data file grows around a PFS boundary (a multiple of 8,088 pages; 64,704 KB), resulting in database corruption and a possible crash dump when this differential backup is restored. | SQL Server Engine | Backup Restore | All |
| <a id="2154919">[2154919](#2154919)</a> | Fixes an issue where the Transact-SQL snapshot backup fails with the following errors when a database is suspended in single-user mode: </br></br>Msg 3081, Level 16, State 9, Line \<LineNumber> </br>Database '\<DatabaseName>' was previously suspended for snapshot backup. </br>Msg 5069, Level 16, State 1, Line \<LineNumber> </br>ALTER DATABASE statement failed. | SQL Server Engine | Backup Restore | All |
| <a id="2138926">[2138926](#2138926)</a> | Improvement: The [sp_invoke_external_rest_endpoint](/sql/relational-databases/system-stored-procedures/sp-invoke-external-rest-endpoint-transact-sql) stored procedure is only supported in Azure SQL Database environments. If you try to use this procedure in on-premises environments, you'll receive a spurious error like the following one: </br></br>Msg 2812, Level 16, State 99, Procedure sys.sp_invoke_external_rest_endpoint_internal, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>Could not find stored procedure 'sp_invoke_external_rest_endpoint_internal'. </br></br>The fix improves the message to read as follows: </br></br>"sp_invoke_external_rest_endpoint" is not supported on this edition of SQL Server. | SQL Server Engine | Extensibility | All |
| <a id="2075503">[2075503](#2075503)</a> | Fixes an issue where the read query on a readable secondary replica may be aborted or return unexpected results if the query uses a heap and forwarding records are present in the heap. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="1948145">[1948145](#1948145)</a> | Fixes error 41842 that's incorrectly shown even when natively compiled stored procedures or in-memory transactions don't insert many records in a single transaction. Here's the error message: </br></br>Error 41842: Too many rows inserted or updated in this transaction. You can insert or update at most 4,294,967,294 rows in memory-optimized tables in a single transaction. | SQL Server Engine | In-Memory OLTP | All |
| <a id="1993393">[1993393](#1993393)</a> | Fixes error 35221 that occurs in the following scenarios: </br></br>- You attempt to add a file to a FILESTREAM filegroup or a memory-optimized filegroup. </br>- You attempt to add additional transaction log files to a database. </br></br>Error message: </br></br> Msg 35221, Level 16, State 1, Line \<LineNumber> </br>Could not process the operation. Always On Availability Groups replica manager is disabled on this instance of SQL Server. Enable Always On Availability Groups, by using the SQL Server Configuration Manager. Then, restart the SQL Server service, and retry the currently operation. For information about how to enable and disable Always On Availability Groups, see SQL Server Books Online. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2087479">[2087479](#2087479)</a> | After you apply this update, you need at least the control server permission to run the procedure `sys.sp_xtp_force_gc`. This update changes the implementation of the procedure to a single call for allocated and used bytes to be freed. Before you apply this update, you need to call it twice. For more information, see [Gradual increase in XTP memory consumption](../../database-engine/performance/memory-optimized-tempdb-out-of-memory.md#gradual-increase-in-xtp-memory-consumption). | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2153494">[2153494](#2153494)</a> | Fixes an assertion failure (Location: execcoll.cpp:1317; Expression: 'savepointId > HkTxSavePointDefault') that occurs during the savepoint cleanup in a Hekaton transaction. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2160880">[2160880](#2160880)</a> | Fixes an issue where In-Memory OLTP stored procedures that have streaming table-valued functions (STVFs), expressions, or constraint checks may generate inconsistent query plan hashes. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2098401">[2098401](#2098401)</a> | Fixes an issue where a memory dump may occur in `CMIterStatsDisk::GetNextStatForLeadingColumn` caused by some metadata inconsistencies. | SQL Server Engine | Metadata | All |
| <a id="2135970">[2135970](#2135970)</a> | Fixes a `DBCC CLONEDATABASE` failure when upgrading the source database from an earlier version of SQL Server. | SQL Server Engine | Metadata | All |
| <a id="2084307">[2084307](#2084307)</a> | Fixes index inconsistency or incorrect results that may occur in the following scenario: </br></br>- You enable accelerated database recovery (ADR) and snapshot isolation. </br>- You roll back to a savepoint. </br>- You update on top of aborted rows and the version cleanup lags behind this update. | SQL Server Engine | Methods to access stored data | All |
| <a id="2081891">[2081891](#2081891)</a> | Fixes an exception that occurs when `JSON_ARRAY`/`JSON_OBJECT` return values are used in a parameter in functions that take strings. After you apply this fix, return values of `JSON_ARRAY` and `JSON_OBJECT` are made coercible and can be used as string parameters. | SQL Server Engine | Programmability | All |
| <a id="2115768">[2115768](#2115768)</a> | Fixes an assertion failure that occurs in natively compiled modules when the `Inner FOR JSON` operator is followed by an operator that buffers the corresponding objects, such as another `FOR JSON` or `ORDER BY` operator. Additionally, you may see the following assert expression: </br></br>Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memilb.cpp:\<LineNumber> </br>Expression: (*ppilb)->m_cRef == 0 </br>SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID> </br>Process ID:&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID> | SQL Server Engine | Programmability | All |
| <a id="2118401">[2118401](#2118401)</a> | Before you apply this update, the key name in the [JSON_OBJECT](/sql/t-sql/functions/json-object-transact-sql) function output isn't quoted when the data type is a **numeric**, **Boolean**, or internal JSON data type. After you apply this update, keys in `JSON_OBJECT` are quoted. | SQL Server Engine | Programmability | All |
| <a id="2043012">[2043012](#2043012)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Execution | All |
| <a id="1860413">[1860413](#1860413)</a> | This fix resolves the following issues that can occur when you rename databases: </br></br>**Issue 1**: SQL Server crashes when a user who has a non-default schema (for example: `CREATE USER <user_name> FOR LOGIN <login_name> WITH DEFAULT_SCHEMA = <schema_name>`) executes queries in the following sequence: </br></br>1. Executes a query like the following with an implicit name (a schema name that isn't explicitly specified requires SQL Server to determine the same name): </br>`SELECT * FROM <database_name>..<table_name>` </br>2. Renames the database. </br>3. Reruns the implicit query from step 1. </br></br>**Issue 2**: Fixes SQL Server error 942 that occurs when you perform the following steps in the same sequence on your SQL Server instance: </br></br>1. You query a table in a database (for example: `SELECT * FROM DatabaseA.sys.columns`). </br>2. You rename an existing database (for example: `ALTER DATABASE DatabaseA MODIFY NAME = DatabaseA_old`). </br>3. You take this renamed database offline (for example: `ALTER DATABASE DatabaseA_old SET OFFLINE`). </br>4. You rename another database on the server to have the same name as the database that you renamed in step 2 (for example: `ALTER DATABASE DatabaseA_new MODIFY NAME = DatabaseA`). </br>5. Now if you query a table in this database (for example: `SELECT * FROM DatabaseA.sys.columns`), you'll receive the following 942 error: </br></br>Msg 942, Level 14, State 4, Line \<LineNumber> </br>Database '*DatabaseA_old*' cannot be opened because it is offline. | SQL Server Engine | Query Execution | All |
| <a id="2009090">[2009090](#2009090)</a> | Fixes error 8657 when running queries that use percentile mode for memory grant feedback. | SQL Server Engine | Query Execution | All |
| <a id="2116378">[2116378](#2116378)</a> | Fixes a failure to raise the proper data type overflow error when a comma-separated values (CSV) file has an integer (int) value larger than the maximum value of **int** and you run `SELECT <integer_column_name> FROM OPENROWSET` on this CSV file. | SQL Server Engine | Query Execution | All |
| <a id="2120696">[2120696](#2120696)</a> | Improvement: Automatically enables the binary large object (BLOB) trace ring buffer feature when a BLOB assertion failure is detected. This improvement helps to better investigate such issues. | SQL Server Engine | Query Execution | All |
| <a id="2086044">[2086044](#2086044)</a> | Fixes an issue where an authenticated attacker could affect SQL Server memory when executing a specially crafted `CREATE STATISTICS` or `UPDATE STATISTICS` statement. | SQL Server Engine | Query Optimizer | All |
| <a id="2113374">[2113374](#2113374)</a> | Fixes an access violation exception that occurs on the primary replica when the secondary replica sends cursor plans to the primary replica for storage in Query Store (QDS). | SQL Server Engine | Query Store | All |
| <a id="1959261">[1959261](#1959261)</a> | Fixes a high CPU usage condition that occurs when you enable change tracking on a large number of tables and do automatic or manual cleanup of the change tracking tables. | SQL Server Engine | Replication | Windows |
| <a id="1967560">[1967560](#1967560)</a> | Fixes errors 12300 (Computed columns are not supported) and 12301 (Nullable columns in the index key are not supported) when transactional replication is enabled on memory optimized tables with computed columns and the index on nullable columns respectively. After applying this fix, you can enable transactional replication on memory optimized tables with computed columns and the index on nullable columns. | SQL Server Engine | Replication | Windows |
| <a id="2049442">[2049442](#2049442)</a> | Consider the following scenario: </br></br> - You have a transactional replication setup. </br>- You execute the `sp_changearticle` stored procedure to change the property of an article on the publisher, and data manipulation language (DML) changes occur on the published table. </br></br>In this scenario, the Log Reader Agent reader thread may generate the following assertion dump when processing the log records: </br></br>\* Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;replrowset.cpp:\<LineNumber> </br>\* Expression:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(LSN)m_curLSN <(LSN)(pSchemas->schema_lsn_begin)</br>\* SPID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<SPID> </br>\* Process ID:&nbsp;&nbsp;&nbsp;&nbsp;\<ProcessID> | SQL Server Engine | Replication | All |
| <a id="2068781">[2068781](#2068781)</a> | Fixes a gradual memory leak in the SQL Server process (the high usage under `MEMORYCLERK_SOSNODE`) caused by the Log Reader Agent in transactional replication. | SQL Server Engine | Replication | All |
| <a id="2104416">[2104416](#2104416)</a> | Fixes an issue where the temporary linked server created by the Log Reader Agent isn't always properly dropped when the publisher is in an Always On availability group (AG) and there's a failover at the distributor. After you apply this fix, the linked server is properly removed. | SQL Server Engine | Replication | Windows |
| <a id="2129326">[2129326](#2129326)</a> | Fixes error 8992 [Check Catalog Msg 3853, State 1: Attribute (owning_principal_id=\<ID>) of row (principal_id=\<ID>) in sys.database_principals does not have a matching row (principal_id=\<ID>) in sys.database_principals.] generated by `DBCC CHECKDB` when executed against a database clone of a change data capture (CDC) enabled source database that has system-defined roles owned by CDC users. | SQL Server Engine | Replication | All |
| <a id="2130492">[2130492](#2130492)</a> | Resolves a query performance issue that affects change tracking autocleanup and manual cleanup queries. </br></br>**Note** You need to turn on trace flags 8286 and 8287, as this forces the cleanup query to use the `FORCE ORDER` and `FORCESEEK` hints to speed up the performance. | SQL Server Engine | Replication | All |
| <a id="2138330">[2138330](#2138330)</a> | Fixes a primary key violation error that's caused by a timing issue in change data capture (CDC) in SQL Server 2022. The CDC capture process may try to insert a duplicate `start_lsn` value in the `cdc.lsn_time_mapping` table, and you may see an error message that resembles the following one: </br></br>Violation of PRIMARY KEY constraint 'lsn_time_mapping_clustered_idx'. Cannot insert duplicate key in object 'cdc.lsn_time_mapping'. The duplicate key value is (*Value*). </br></br>**Note** This fix covers all the causes of this error. For the same issue that occurs in SQL Server 2019 that has a previous cumulative update installed, SQL Server 2017, and SQL Server 2016, see the previous fix [KB 4521739](https://support.microsoft.com/help/4521739). However, the previous fix didn't cover all the cases. | SQL Server Engine | Replication | All |
| <a id="2138691">[2138691](#2138691)</a> | Fixes error 302 in SQL Server replication. When the Distribution Agent attempts to apply a snapshot generated on a table that has a primary key with the `NEWSEQUENTIALID` function as a default value, the following error occurs: </br></br>Msg 302, Severity 16 </br>The newsequentialid() built-in function can only be used in a DEFAULT expression for a column of type 'uniqueidentifier' in a CREATE TABLE or ALTER TABLE statement. It cannot be combined with other operators to form a complex scalar expression. | SQL Server Engine | Replication | Windows |
| <a id="2151109">[2151109](#2151109)</a> | Fixes error 241 that occurs while running the Snapshot Agent, and the system date format was changed to a different format than the one used by SQL Server. </br></br>Error message: </br></br>Conversion failed when converting date and/or time from character string. | SQL Server Engine | Replication | All |
| <a id="2160907">[2160907](#2160907)</a> | Fixes an issue where the Distribution Agent returns a general message code 20046 instead of the connection failure message code 20084 when it fails to connect to the Subscriber by using the non-cached connection. These errors are specific to the Replication Distribution Agent. </br></br>Error message: </br></br>20046: The process encountered a general external error. </br>20084: The process could not connect to server. | SQL Server Engine | Replication | All |
| <a id="2114313">[2114313](#2114313)</a></br><a id="2158583">[2158583](#2158583)</a> | This fix is a safeguard for issues that can cause unavailability due to memory capacity in some rare queries (nested queries performing table scans). Before issuing these queries, it tries to make sure sufficient space is available and avoids causing any further capacity issues. | SQL Server Engine | Resource Governor | All |
| <a id="2105584">[2105584](#2105584)</a> | Fixes an issue where Full-text Search generates memory leaks and high waits in full-text queries. | SQL Server Engine | Search | All |
| <a id="2123504">[2123504](#2123504)</a> | Enhancement: Split the `FT_IFTS_RWLOCK` wait type into more granular wait types for more accurate diagnostics of the problem. For more information about these wait types, see [sys.dm_os_wait_stats (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql). | SQL Server Engine | Search | All |
| <a id="2118499">[2118499](#2118499)</a> | [FIX: Database accessibility issues with high-volume customer workloads that use EKM for encryption and key generation (KB5023236)](database-accessibility-issues-high-volume-customer-workloads.md) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2058060">[2058060](#2058060)</a> | After you apply this update, you can audit events (`EXTERNAL GOVERNANCE TURNED ON` and `EXTERNAL GOVERNANCE TURNED OFF`) that correspond to external governance enable/disable actions (Microsoft Purview access policies). The correctness of audit records is ensured when evaluating data reader and writer permissions. This update introduces trace flag (TF) 12481 to disable logging auditing information for external permissions in the `external_policy_permission_checked` field of audit records. | SQL Server Engine | Security Infrastructure | All |
| <a id="2088539">[2088539](#2088539)</a> | Adds the queries and category of the Microsoft Customer Experience Improvement Program (CEIP) telemetry to SQL Server 2022. | SQL Server Engine | Security Infrastructure | All |
| <a id="2100518">[2100518](#2100518)</a> | Fixes an issue where the Microsoft Entra administrator isn't added to the sysadmin group after you configure Microsoft Entra ID for SQL Server 2022. | SQL Server Engine | Security Infrastructure | All |
| <a id="2101033">[2101033](#2101033)</a> | Updates the error message 37517 used for the Microsoft Purview access policies in SQL Server to the following one: </br></br>Internal error occurred while obtaining ARC resource information from IMDS endpoint. Substate: '\%ls', status: 0x\%08x. | SQL Server Engine | Security Infrastructure | All |
| <a id="2101035">[2101035](#2101035)</a> | Fixes an exception that generates a dump file when using Microsoft Purview access policies for SQL Server 2022 and running the `sp_external_policy_refresh` stored procedure as a non-admin Microsoft Entra user. | SQL Server Engine | Security Infrastructure | All |
| <a id="2117119">[2117119](#2117119)</a> | Removes a case of multiple inheritance in the RSA encryption code in SQL Server 2022. | SQL Server Engine | Security Infrastructure | All |
| <a id="2117122">[2117122](#2117122)</a> | Fixes a spelling issue in error 33025 (Invalid cryptographic provider property: %S_MSG) when you use the Extensible Key Management (EKM) feature. | SQL Server Engine | Security Infrastructure | All |
| <a id="2117214">[2117214](#2117214)</a> | Fixes the following error that can occur when you load audit logs from SQL Server Management Studio (SSMS): </br></br>Item has already been added. Key in dictionary: 'MNDO' Key being added: 'MNDO' | SQL Server Engine | Security Infrastructure | All |
| <a id="2125981">[2125981](#2125981)</a> | Adds a new `sys.dm_external_provider_certificate_info` dynamic management view (DMV), which returns information about the Azure cloud certificates used in SQL Server to set up and maintain a Microsoft Entra administrator for Microsoft Entra authentication. For more information, see [sys.dm_external_provider_certificate_info (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-external-provider-certificate-info-transact-sql). | SQL Server Engine | Security Infrastructure | All |
| <a id="2131225">[2131225](#2131225)</a> | Fixes the following issues with attribute-based policies of Purview - Azure Attribute-based access control (Azure ABAC): </br></br>- Attributes don't synchronize correctly. </br>- The synchronization process can't move past the table that didn't have attribute synchronization. </br>- On retry, the synchronization process encounters exceptions because it expected the database state to be planning not synchronization. | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2021487">[2021487](#2021487)</a> | Fixes spelling issues in Database Engine error messages in SQL Server 2022. | SQL Server Engine | SQL Server Engine | All |
| <a id="1862944">[1862944](#1862944)</a> | This update removes the requirement for the trace flag (TF) 809 for the hybrid buffer pool with direct write feature. After you apply this update, this feature is enabled by default in SQL Server 2022. This update introduces TF 898 to disable the `Direct Write` behavior of the [hybrid buffer pool](/sql/database-engine/configure-windows/hybrid-buffer-pool) for troubleshooting or debugging purposes. | SQL Server Engine | SQL OS | All |
| <a id="2137927">[2137927](#2137927)</a> | Fixes an issue where schema modification (Sch-M) locks are acquired on foreign key tables when altering columns on the primary tables even if the transaction isn't related to the foreign key column. After you apply this fix, SQL Server only acquires schema stability (Sch-S) locks on foreign key tables. For more information, see [Schema locks](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#schema). | SQL Server Engine | Table Index Partition | All |
| <a id="2162849">[2162849](#2162849)</a> | Fixes a self-deadlock issue where internal update statistic transactions persist locks, which can cause unresolved deadlocks with user queries. The issue occurs because the lock isn't released when the system runs the update query statistics. After you apply this fix, the lock can be released as intended. | SQL Server Engine | Transaction Services | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU1 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2023/03/sqlserver2022-kb5022375-x64_ab34fe7633beef56c7bce1e212a6cf56c91f4e57.exe)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5022375-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5022375-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5022375-x64.exe|589F5609A99EDC07AAAD2C73FFE53E1259B6BC1BCDE3ED950468C8219D2C9594|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.208 | 336808    | 27-Jan-23 | 17:34 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.208     | 2903472   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 27-Jan-23 | 17:34 | x86      |
| Msmdctr.dll                                         | 2022.160.43.208 | 38864     | 27-Jan-23 | 17:34 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.208 | 53920160  | 27-Jan-23 | 17:34 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.208 | 71755216  | 27-Jan-23 | 17:34 | x64      |
| Msmdpump.dll                                        | 2022.160.43.208 | 10335152  | 27-Jan-23 | 17:34 | x64      |
| Msmdredir.dll                                       | 2022.160.43.208 | 8132016   | 27-Jan-23 | 17:34 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.208 | 71308720  | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 954832    | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1882576   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1669584   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1878992   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1846224   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1145296   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1138128   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1767376   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1746896   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 930768    | 27-Jan-23 | 17:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1835472   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 953296    | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1880528   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1666512   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1874384   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1842640   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1143248   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1136584   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1763792   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1743312   | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 931280    | 27-Jan-23 | 17:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1830864   | 27-Jan-23 | 17:34 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.208 | 8265648   | 27-Jan-23 | 17:34 | x86      |
| Msmgdsrv.dll                                        | 2022.160.43.208 | 10083760  | 27-Jan-23 | 17:34 | x64      |
| Msolap.dll                                          | 2022.160.43.208 | 8744864   | 27-Jan-23 | 17:34 | x86      |
| Msolap.dll                                          | 2022.160.43.208 | 10970016  | 27-Jan-23 | 17:34 | x64      |
| Msolui.dll                                          | 2022.160.43.208 | 289696    | 27-Jan-23 | 17:34 | x86      |
| Msolui.dll                                          | 2022.160.43.208 | 308144    | 27-Jan-23 | 17:34 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 27-Jan-23 | 17:34 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 27-Jan-23 | 17:34 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:34 | x64      |
| Sqlceip.exe                                         | 16.0.4003.1     | 300968    | 27-Jan-23 | 17:34 | x86      |
| Sqldumper.exe                                       | 2022.160.4003.1 | 227240    | 27-Jan-23 | 17:34 | x86      |
| Sqldumper.exe                                       | 2022.160.4003.1 | 260008    | 27-Jan-23 | 17:34 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 27-Jan-23 | 17:34 | x86      |
| Tmapi.dll                                           | 2022.160.43.208 | 5884336   | 27-Jan-23 | 17:34 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.208 | 5575120   | 27-Jan-23 | 17:34 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.208 | 1481136   | 27-Jan-23 | 17:34 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.208 | 7197648   | 27-Jan-23 | 17:34 | x64      |
| Xmsrv.dll                                           | 2022.160.43.208 | 35895712  | 27-Jan-23 | 17:34 | x86      |
| Xmsrv.dll                                           | 2022.160.43.208 | 26594224  | 27-Jan-23 | 17:34 | x64      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4003.1 | 104392    | 27-Jan-23 | 17:34 | x64      |
| Instapi150.dll                             | 2022.160.4003.1 | 79776     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.208     | 2633672   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.208     | 2633680   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.208     | 2933152   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.208     | 2323408   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.208     | 2323360   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4003.1     | 554912    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4003.1     | 554920    | 27-Jan-23 | 17:34 | x86      |
| Msasxpress.dll                             | 2022.160.43.208 | 32672     | 27-Jan-23 | 17:34 | x64      |
| Msasxpress.dll                             | 2022.160.43.208 | 27600     | 27-Jan-23 | 17:34 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:34 | x64      |
| Sqldumper.exe                              | 2022.160.4003.1 | 227240    | 27-Jan-23 | 17:34 | x86      |
| Sqldumper.exe                              | 2022.160.4003.1 | 260008    | 27-Jan-23 | 17:34 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4003.1  | 599976    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4003.1  | 173992    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4003.1  | 173984    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4003.1  | 1857440   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4003.1  | 1857448   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4003.1  | 370592    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4003.1  | 370632    | 27-Jan-23 | 17:34 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4003.1 | 4719016   | 27-Jan-23 | 19:21 | x64      |
| Aetm-enclave.dll                             | 2022.160.4003.1 | 4673456   | 27-Jan-23 | 19:21 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4003.1 | 4909088   | 27-Jan-23 | 19:21 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4003.1 | 4874464   | 27-Jan-23 | 19:21 | x64      |
| Hadrres.dll                                  | 2022.160.4003.1 | 227232    | 27-Jan-23 | 19:21 | x64      |
| Hkcompile.dll                                | 2022.160.4003.1 | 1410976   | 27-Jan-23 | 19:20 | x64      |
| Hkengine.dll                                 | 2022.160.4003.1 | 5760936   | 27-Jan-23 | 19:20 | x64      |
| Hkruntime.dll                                | 2022.160.4003.1 | 190376    | 27-Jan-23 | 19:20 | x64      |
| Hktempdb.dll                                 | 2022.160.4003.1 | 71624     | 27-Jan-23 | 19:21 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.208     | 2322336   | 27-Jan-23 | 19:21 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4003.1 | 333720    | 27-Jan-23 | 19:21 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4003.1 | 96200     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 30664     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 38856     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 34760     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 38816     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 38856     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 30664     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 30624     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 34720     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 38856     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 30664     | 27-Jan-23 | 19:21 | x64      |
| `Odsole70.rll`                                 | 16.0.4003.1     | 38856     | 27-Jan-23 | 19:21 | x64      |
| Qds.dll                                      | 2022.160.4003.1 | 1779616   | 27-Jan-23 | 19:20 | x64      |
| Rsfxft.dll                                   | 2022.160.4003.1 | 55200     | 27-Jan-23 | 19:21 | x64      |
| Secforwarder.dll                             | 2022.160.4003.1 | 83872     | 27-Jan-23 | 19:20 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4003.1 | 137128    | 27-Jan-23 | 19:20 | x64      |
| Sqlaccess.dll                                | 2022.160.4003.1 | 444360    | 27-Jan-23 | 19:21 | x64      |
| Sqlagent.exe                                 | 2022.160.4003.1 | 726944    | 27-Jan-23 | 19:21 | x64      |
| Sqlceip.exe                                  | 16.0.4003.1     | 300968    | 27-Jan-23 | 19:21 | x86      |
| Sqlctr160.dll                                | 2022.160.4003.1 | 157600    | 27-Jan-23 | 19:21 | x64      |
| Sqlctr160.dll                                | 2022.160.4003.1 | 128968    | 27-Jan-23 | 19:21 | x86      |
| Sqldk.dll                                    | 2022.160.4003.1 | 4028360   | 27-Jan-23 | 19:20 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 1742792   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3835816   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4052904   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4556712   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4687816   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3737544   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3921832   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4556744   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4388776   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4458408   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 2434984   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 2377640   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4245448   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3885000   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4397000   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4192168   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4175816   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3958696   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 3835816   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 1681320   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4282280   | 27-Jan-23 | 19:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4003.1 | 4425672   | 27-Jan-23 | 19:21 | x64      |
| Sqllang.dll                                  | 2022.160.4003.1 | 48535464  | 27-Jan-23 | 19:20 | x64      |
| Sqlmin.dll                                   | 2022.160.4003.1 | 51300256  | 27-Jan-23 | 19:20 | x64      |
| Sqlos.dll                                    | 2022.160.4003.1 | 51112     | 27-Jan-23 | 19:20 | x64      |
| Sqlrepss.dll                                 | 2022.160.4003.1 | 137120    | 27-Jan-23 | 19:21 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4003.1 | 51104     | 27-Jan-23 | 19:21 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4003.1 | 5830560   | 27-Jan-23 | 19:21 | x64      |
| Sqlservr.exe                                 | 2022.160.4003.1 | 722848    | 27-Jan-23 | 19:20 | x64      |
| Sqltses.dll                                  | 2022.160.4003.1 | 9389984   | 27-Jan-23 | 19:20 | x64      |
| Sqsrvres.dll                                 | 2022.160.4003.1 | 305056    | 27-Jan-23 | 19:21 | x64      |
| Svl.dll                                      | 2022.160.4003.1 | 247752    | 27-Jan-23 | 19:20 | x64      |
| Xe.dll                                       | 2022.160.4003.1 | 718752    | 27-Jan-23 | 19:21 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4003.1 | 268200    | 27-Jan-23 | 17:34 | x64      |
| Logread.exe                                          | 2022.160.4003.1 | 788376    | 27-Jan-23 | 17:34 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.208     | 2933680   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4003.1     | 30624     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 27-Jan-23 | 17:34 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4003.1 | 1714088   | 27-Jan-23 | 17:34 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4003.1     | 554912    | 27-Jan-23 | 17:34 | x86      |
| Msgprox.dll                                          | 2022.160.4003.1 | 313248    | 27-Jan-23 | 17:34 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 27-Jan-23 | 17:34 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 27-Jan-23 | 17:34 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 27-Jan-23 | 17:34 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4003.1 | 530336    | 27-Jan-23 | 17:34 | x64      |
| Rdistcom.dll                                         | 2022.160.4003.1 | 939936    | 27-Jan-23 | 17:34 | x64      |
| Repldp.dll                                           | 2022.160.4003.1 | 337824    | 27-Jan-23 | 17:34 | x64      |
| Replisapi.dll                                        | 2022.160.4003.1 | 419752    | 27-Jan-23 | 17:34 | x64      |
| Replmerg.exe                                         | 2022.160.4003.1 | 604056    | 27-Jan-23 | 17:34 | x64      |
| Replprov.dll                                         | 2022.160.4003.1 | 890824    | 27-Jan-23 | 17:34 | x64      |
| Replrec.dll                                          | 2022.160.4003.1 | 1058760   | 27-Jan-23 | 17:34 | x64      |
| Replsub.dll                                          | 2022.160.4003.1 | 501664    | 27-Jan-23 | 17:34 | x64      |
| Spresolv.dll                                         | 2022.160.4003.1 | 300960    | 27-Jan-23 | 17:34 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:31 | x64      |
| Sqldistx.dll                                         | 2022.160.4003.1 | 268200    | 27-Jan-23 | 17:34 | x64      |
| Sqlmergx.dll                                         | 2022.160.4003.1 | 423848    | 27-Jan-23 | 17:34 | x64      |
| Xe.dll                                               | 2022.160.4003.1 | 718752    | 27-Jan-23 | 17:35 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4003.1 | 100256    | 27-Jan-23 | 17:34 | x64      |
| Exthost.exe                   | 2022.160.4003.1 | 247752    | 27-Jan-23 | 17:34 | x64      |
| Launchpad.exe                 | 2022.160.4003.1 | 1361824   | 27-Jan-23 | 17:34 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:34 | x64      |
| Sqlsatellite.dll              | 2022.160.4003.1 | 1165256   | 27-Jan-23 | 17:34 | x64      |

SQL Server 2022 Full-Text Engine

|          File   name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4003.1 | 710568    | 27-Jan-23 | 17:34 | x64      |
| Fdhost.exe               | 2022.160.4003.1 | 153544    | 27-Jan-23 | 17:34 | x64      |
| Fdlauncher.exe           | 2022.160.4003.1 | 100264    | 27-Jan-23 | 17:34 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:34 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 27-Jan-23 | 17:40 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 27-Jan-23 | 17:40 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 27-Jan-23 | 17:40 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 27-Jan-23 | 17:40 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 80728     | 27-Jan-23 | 17:40 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4003.1     | 120744    | 27-Jan-23 | 17:40 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4003.1     | 120776    | 27-Jan-23 | 17:40 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.208     | 2933664   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.208     | 2933680   | 27-Jan-23 | 17:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4003.1     | 509856    | 27-Jan-23 | 17:40 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4003.1     | 219080    | 27-Jan-23 | 17:40 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.208 | 10165664  | 27-Jan-23 | 17:31 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Jan-23 | 17:40 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Jan-23 | 17:40 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4003.1 | 137128    | 27-Jan-23 | 17:31 | x64      |
| Sqlceip.exe                                                   | 16.0.4003.1     | 300968    | 27-Jan-23 | 17:40 | x86      |
| Xe.dll                                                        | 2022.160.4003.1 | 640936    | 27-Jan-23 | 17:40 | x86      |
| Xe.dll                                                        | 2022.160.4003.1 | 718752    | 27-Jan-23 | 17:40 | x64      |

SQL Server 2022 sql_polybase_core_inst

|     File name    |   File version  | File size |    Date   |  Time | Platform |
|:----------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll   | 2022.160.4003.1 | 104392    | 27-Jan-23 | 19:19 | x64      |
| Mpdwinterop.dll  | 2022.160.4003.1 | 296904    | 27-Jan-23 | 19:19 | x64      |
| Mpdwsvc.exe      | 2022.160.4003.1 | 7817120   | 27-Jan-23 | 19:19 | x64      |
| Secforwarder.dll | 2022.160.4003.1 | 83872     | 27-Jan-23 | 19:19 | x64      |
| Sqldk.dll        | 2022.160.4003.1 | 4028360   | 27-Jan-23 | 19:19 | x64      |
| Sqldumper.exe    | 2022.160.4003.1 | 260008    | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 1742792   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4556712   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 3737544   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4556744   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4458408   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 2434984   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 2377640   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4192168   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4175816   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 1681320   | 27-Jan-23 | 19:19 | x64      |
| `Sqlevn70.rll`     | 2022.160.4003.1 | 4425672   | 27-Jan-23 | 19:19 | x64      |
| Sqlncli17e.dll   | 2017.1710.3.1   | 1898432   | 27-Jan-23 | 19:19 | x64      |
| Sqlos.dll        | 2022.160.4003.1 | 51112     | 27-Jan-23 | 19:19 | x64      |
| Sqltses.dll      | 2022.160.4003.1 | 9389984   | 27-Jan-23 | 19:19 | x64      |

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
