---
title: Cumulative update 5 for SQL Server 2019 (KB4552255)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 5 (KB4552255).
ms.date: 06/30/2023
ms.custom: KB4552255
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4552255 - Cumulative Update 5 for SQL Server 2019

_Release Date:_ &nbsp; June 22, 2020  
_Version:_ &nbsp; 15.0.4043.16

## Summary

This article describes Cumulative Update package 5 (CU5) for Microsoft SQL Server 2019. This update contains 58 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 4, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4043.16**, file version: **2019.150.4043.16**
- Analysis Services - Product version: **15.0.34.19**, file version: **2018.150.34.19**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13491009">[13491009](#13491009)</a> | [FIX: Analysis Services Execute DDL task may fail to impersonate the user context to the remote Analysis services instance in SQL Server 2017 and 2019 (KB4539023)](https://support.microsoft.com/help/4539023) | Analysis Services | Analysis Services | Windows |
| <a id="13458540">[13458540](#13458540)</a> | When you try to build relationship on a model that contains many measures with `USERELATIONSHIP` function, this fix can improve the processing performance and also reduce the time of "sequence point algorithm" step. | Analysis Services | Analysis Services | Windows |
| <a id="13469410">[13469410](#13469410)</a> | This improves MDX query execution performance against a dimension user hierarchy which is a ragged hierarchy (`HideMemberIf` property set) and has deep hierarchy level in SSAS Multidimensional instance. | Analysis Services | Analysis Services | Windows |
| <a id="13516286">[13516286](#13516286)</a> | This will fix a functional results issue with the usage of `NOT IN` operator in DAX when `OPTIMIZEDNOTINOPERATOR` optimization is enabled. | Analysis Services | Analysis Services | Windows |
| <a id="13516290">[13516290](#13516290)</a> | This will fix the functional issues with initial performance fix for dense measures evaluation in `SuperDAXMD` mode. | Analysis Services | Analysis Services | Windows |
| <a id="13516292">[13516292](#13516292)</a> | This will fix performance problems in PBI and Multidimensional models user scenario. | Analysis Services | Analysis Services | Windows |
| <a id="13498052">[13498052](#13498052)</a> | Fix the issue that when using ODBC components in Foreach Loop component, the ODBC component will meet "Function sequence error" in the second loop during package execution. | Integration Services | DTS | Windows |
| <a id="13491696">[13491696](#13491696)</a> | "**Show More Members**" functionality for Explicit Hierarchies don't show more than 50 members in Master Data Services (MDS) 2019. | Master Data Services | Client | Windows |
| <a id="13455824">[13455824](#13455824)</a> | In **explore** page, you may not be able to revert the changes in changeset. | Master Data Services | Master Data Services | Windows |
| <a id="13468903">[13468903](#13468903)</a> | When FIPS is enabled on the server (using MSKB article [811833](/windows/security/threat-protection/fips-140-validation)), you may not be able to use Managed Backup on a SQL Server 2019 instance and you may encounter the following error: </br></br>Msg 45207, Level 17, State 17, Line \<LineNumber> </br>The operation failed because of an internal error. Exception has been thrown by the target of an invocation. Please retry later. | SQL Server Engine | Backup Restore | Windows |
| <a id="13491012">[13491012](#13491012)</a> | Msg 3628 (The Database Engine may receive a floating point exception from the operating system while processing a user request) may occur during a clustered columnstore index rebuild. | SQL Server Engine | Column Stores | Windows |
| <a id="13522185">[13522185](#13522185)</a> | [FIX: sp_execute_external_script may fail to run R scripts that use the RxLocalParallel compute context or the doParallel R package in SQL Server 2019 (KB4563195)](https://support.microsoft.com/help/4563195) | SQL Server Engine | Extensibility | Windows |
| <a id="13532909">[13532909](#13532909)</a> | [FIX: Allow external resource pool to use more than one processor group in SQL Server 2019 on Windows (KB4563044)](https://support.microsoft.com/help/4563044) | SQL Server Engine | Extensibility | Windows |
| <a id="13526506">[13526506](#13526506)</a> | When a Windows principal that's not mapped to a specific database user accesses a database by using membership in a Windows group or Microsoft Entra group, a user ID of 0 may be assigned to the user. When the user tries to use libraries that are installed by other `dbo`/`sysadmin` user, the user may not see any external libraries. After applying this update, a user ID of 0 would have access to external libraries installed by the `dbo` (libraries in public scope). Since there's no database user that's mapped to the Windows principal, the user with user ID 0 can't create or install external libraries. | SQL Server Engine | Extensibility | Windows |
| <a id="13421891">[13421891](#13421891)</a> | [FIX: Access violation may occur when enumerating files in a FileTable in SQL Server (KB4540896)](https://support.microsoft.com/help/4540896) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="13508776">[13508776](#13508776)</a> | [FIX: Availability Group failover generates lot of dumps as DTC support is toggled between PER_DB and NONE multiple times (KB4562173)](https://support.microsoft.com/help/4562173) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13522235">[13522235](#13522235)</a> | [FIX: SQL Server may still read data from secondary replica when ALLOW_CONNECTIONS is set to NO (KB4560051)](https://support.microsoft.com/help/4560051) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13477441">[13477441](#13477441)</a> | [FIX: Credential update frequency option is added to mssql-conf option in SQL Server 2019 on Linux (KB4556244)](https://support.microsoft.com/topic/c6f090f7-2126-d5d1-3f02-6152faeedb82) | SQL Server Engine | Linux | Linux |
| <a id="13530877">[13530877](#13530877)</a> | [FIX: VDI backup fails with error after applying SQL Server 2019 CU2/CU3/CU4 (KB4563007)](https://support.microsoft.com/help/4563007) | SQL Server Engine | Linux | Linux |
| <a id="13452649">[13452649](#13452649)</a> | Enable SQL Server Big Data Clusters Active Directory (AD) deployments when domain controllers aren't acting as DNS servers. | SQL Server Engine | Linux | Linux |
| <a id="13456880">[13456880](#13456880)</a> | Access violation exception occurs when querying `sys.dm_cluster_endpoints` in SQL Server 2019 on Big Data Cluster. | SQL Server Engine | Linux | Linux |
| <a id="13490049">[13490049](#13490049)</a> | For SQL Server 2019 on Linux or Big Data Cluster configured to use AD auth, you may notice a reduction in size of core dumps generated after installing the update. | SQL Server Engine | Linux | Linux |
| <a id="13491688">[13491688](#13491688)</a> | When you attempt to enable Log Shipping feature in SQL Server on Linux, you may receive an error message that resembles the following: </br></br>Msg 32018, Level 16, State 3, Server mssql02, Procedure master.dbo.sp_add_log_shipping_secondary_primary, Line \<LineNumber> </br>Log shipping is not installed on this instance. </br>RegQueryValueEx() returned error 2, 'The system cannot find the file specified.' | SQL Server Engine | Linux | Linux |
| <a id="13555838">[13555838](#13555838)</a> | Memory may be increased and not be released when a SQL Server outbound connect like Linked Servers fails. This may happen because a socket structure isn't deallocated properly. | SQL Server Engine | Linux | Linux |
| <a id="13502023">[13502023](#13502023)</a> | `sys.key_constraints` reports two rows for an index if the XML component ID is the same as the "`object_id`" of a primary key. | SQL Server Engine | Metadata | Windows |
| <a id="13518379">[13518379](#13518379)</a> | [FIX: Assertion exception occurs when you query the DMV sys.dm_db_file_space_usage in SQL Server 2019 (KB4564868)](https://support.microsoft.com/help/4564868) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13509341">[13509341](#13509341)</a> | When shrinking a database, you may receive a database consistency error if the shrinking process encounters an IAM page that's the first and only IAM page. The symptoms may include assertions errors involving `heapdataset`. Confirm that you don't have any inconsistencies by executing `DBCC CHECKDB` after shrink operations. Applying this update will prevent future occurrence of this issue and not clean up past inconsistencies. | SQL Server Engine | Methods to access stored data | All |
| <a id="13476078">[13476078](#13476078)</a> | [Improvement: Enables custom event configuration for XEVENT Session EngineService in SQL Server 2019 (KB4561725)](https://support.microsoft.com/help/4561725) | SQL Server Engine | PolyBase | Linux |
| <a id="13526208">[13526208](#13526208)</a> | [FIX: Changes to firewall rules created when you install PolyBase in scale-out group configuration in SQL Server 2019 (KB4562618)](https://support.microsoft.com/help/4562618) | SQL Server Engine | PolyBase | Windows |
| <a id="13491460">[13491460](#13491460)</a> | When PolyBase queries are cancelled shortly after being scheduled, the cancellation may timeout after one hour (and fail to cancel the execution) and generate a dump of Data Movement service. | SQL Server Engine | PolyBase | All |
| <a id="13491461">[13491461](#13491461)</a> | When 32 or more PolyBase queries are scheduled concurrently, deadlock may occur and current and subsequent PolyBase queries may stall and may not be cancellable. | SQL Server Engine | PolyBase | All |
| <a id="13491472">[13491472](#13491472)</a> | When inserting into PolyBase external tables from SQL Server head data or tables, query may fail (instead of waiting for resources) if 32 PolyBase queries are currently running. | SQL Server Engine | PolyBase | All |
| <a id="13522367">[13522367](#13522367)</a> | If trace flag 6424 is enabled, this fix will dump PolyBase processes if SQL Server dumps. | SQL Server Engine | PolyBase | Linux |
| <a id="13525965">[13525965](#13525965)</a> | You can access configurations that ship with PolyBase when specifying a `DSN` in the `CONNECTION_OPTIONS` of a Generic ODBC External Data Source definition. The options are picked up by matching the driver name used in the DSN definition. This currently applies to the following drivers: </br></br>- IBM DB2 ODBC DRIVER </br>- HDBODBC </br>- Microsoft Spark ODBC Driver | SQL Server Engine | PolyBase | Windows |
| <a id="13525968">[13525968](#13525968)</a> | Disables PolyBase Generic ODBC External Data Sources' default behavior of pushing down the `TOP` operator and calling the `SQLRowCount` function. | SQL Server Engine | PolyBase | Windows |
| <a id="13525977">[13525977](#13525977)</a> | Enables the following keys to be specified in the `CONNECTION_OPTIONS` of a PolyBase Generic ODBC External Data Source: </br></br>PolyBaseOdbcSupportsRowCount, PolyBaseOdbcSupportsMetadataIdAttributes, PolyBaseOdbcSupportsBindOffset, PolyBaseQoTopPushdownSyntax | SQL Server Engine | PolyBase | Windows |
| <a id="13465623">[13465623](#13465623)</a> | [FIX: Blocking may occur when Reduce Recompilations feature is enabled by default in SQL Server 2019 (KB4555232)](https://support.microsoft.com/help/4555232) | SQL Server Engine | Programmability | All |
| <a id="13526183">[13526183](#13526183)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="13458643">[13458643](#13458643)</a> | Spatial data types (**Geometry** and **Geography**) are implemented as CLR data types in SQL Server. When the application domain hosting the spatial data type structures is unloaded, the engine treats this as a schema change to the underlying objects referenced in the cursor. As a result, spatial query may fail with related error message when the schema change is detected. | SQL Server Engine | Programmability | Windows |
| <a id="13464812">[13464812](#13464812)</a> | Access violation may occur when a cursor is used to retrieve data from scalar UDF and the underlying table contains primary key. | SQL Server Engine | Programmability | Windows |
| <a id="13488605">[13488605](#13488605)</a> | When you use `DELETE` statement on a table in SQL Server, you may receive the following error message as no matching rows exists in the referenced tables. </br></br>Msg 547, Level 16, State 0, Line \<LineNumber> </br>The DELETE statement conflicted with the REFERENCE constraint "\<ConstraintName>". </br>The conflict occurred in database "\<DatabaseName>", table "\<TableName>", column '\<ColumnName>'. </br>The statement has been terminated. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13491011">[13491011](#13491011)</a> | Access violation occurs when a query is executed against a filtered index in SQL Server 2019. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13472695">[13472695](#13472695)</a> | [After upgrading SQL Server 2017 Distributor to SQL Server 2019, transactional push replication fails when subscriber is using non-default port (KB4563348)](https://support.microsoft.com/help/4563348) | SQL Server Engine | Replication | Windows |
| <a id="13491016">[13491016](#13491016)</a> | [FIX: Distribution Agent "Parameterized values for above command" log message is missing (KB4552478)](https://support.microsoft.com/help/4552478) | SQL Server Engine | Replication | Windows |
| <a id="13443318">[13443318](#13443318)</a> | When you have external tables on a database in SQL Server 2019 and try to publish different tables from the same database, you may receive the following error message in SSMS: </br></br>New Publication Wizard encountered one or more errors while retrieving the list of articles on '\<DatabaseName>'. The list of articles may not be complete. </br>Additional Information: Data is Null. This method or property cannot be called on Null values. | SQL Server Engine | Replication | Windows |
| <a id="13440400">[13440400](#13440400)</a> | When using `INSERT INTO … VALUES (…)` or `INSERT INTO SELECT…` statement to populate Data Pool external table and if user specifies the target table columns, the list of target table column names must have the same order as the source table columns and must be the full list. Starting this cumulative update, you'll get detailed new errors outlining these conditions: </br></br>"Source column count must match the # of columns in the destination table" </br>"Order of source columns must match the order of columns in the destination table" | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13485259">[13485259](#13485259)</a> | `Encrypt` keyword is missing from `externalaccessconfig` in SQL Server 2019. | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13530274">[13530274](#13530274)</a> | When you deploy SQL Server Big Data Clusters in Active Directory mode, SQL Server uses domain DNS name to create user in SQL Server. When the DNS name and realm name are different, failures may occur. After installing this update, SQL Server will use realm name to create user in SQL Server. | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13328542">[13328542](#13328542)</a> | SQL Agent jobs that require access to credentials stored in `master` database may not be executed when you use Always On availability group in SQL Big Data Cluster. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13464184">[13464184](#13464184)</a> | SQL Server may block renaming a database when the database consists of one or more external data pool tables. If you attempt to rename the database in the scenario, you may get the following error: </br></br>Alter database name is not supported in Big Data Cluster if the database contains external data pool tables. Drop the external data pool tables to perform the operation. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13530704">[13530704](#13530704)</a> | You can retrieve the SQL Server Big Data Cluster controller endpoint by querying the new property `SELECT SERVERPROPERTY ('ControllerEndpoint')`. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13531811">[13531811](#13531811)</a> | Deployment gets blocked when domain DNS name and realm name are different in SQL Server 2019 BDC. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13531816">[13531816](#13531816)</a> | AD access to SQL Server 2019 BDC endpoints fails when domain DNS name and endpoint DNS names don't match. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13495908">[13495908](#13495908)</a> | [Improvement: MAXTRANSFERSIZE no longer required to enable backup compression on TDE encrypted databases (KB4561915)](https://support.microsoft.com/help/4561915) | SQL Server Engine | Storage Management | All |
| <a id="13544367">[13544367](#13544367)</a> | [FIX: Unable to reconfigure Database mirroring when ADR is enabled and disabled in SQL Server 2019 (KB4564876)](https://support.microsoft.com/help/4564876) | SQL Server Engine | Transaction Services | Windows |
| <a id="13464137">[13464137](#13464137)</a> | When you use Accelerated Database Recovery feature on a database in SQL Server 2019, which is part of an Availability Group or Transactional Replication, an assertion error occurs. </br></br>(Location: recovery.cpp:\<LineNumber>, </br>Expression: (!!lp->IsFlagOn (LogRec::LOG_TO_SLOG)) == recXdes->DoesXactSupportCTR () \|\| lp->GetOpCode () == LOP_CTR_NEST_ABORT) | SQL Server Engine | Transaction Services | All |
| <a id="13477086">[13477086](#13477086)</a> | [FIX: Setup is unable to extract product update when it is executed as LOCAL SYSTEM with UPDATE SOURCE option specified in SQL Server 2019 (KB4556233)](https://support.microsoft.com/help/4556233) | SQL Setup | Deployment Platform | Windows |
| <a id="13543133">[13543133](#13543133)</a> | Script "*system_xevents_modification.sql*" downgraded failed with error 935 which causes `master` database not able to recover with error 3417 and then SQL Server is unable to start. | SQL Setup | Patching | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU5 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/06/sqlserver2019-kb4552255-x64_c6a0778132b00ced30f06ee61875d58d7a7a70b2.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4552255-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4552255-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4552255-x64.exe| 4EC032408AA99C6F17DC935D8F62C62081B07B5A1A08921D312A7521AEDB18E4 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.19   | 291736    | 10-Jun-20 | 18:55 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 10-Jun-20 | 18:55 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.19       | 757128    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 174488    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 198544    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 201096    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 197528    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 213896    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 196488    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 192400    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 251280    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 172952    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.19       | 195992    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.19       | 1097104   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.19       | 479624    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 53640     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 58248     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 58768     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 57736     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 60824     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 57224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 57224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 66440     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 52624     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.19       | 57240     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16776     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16784     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16792     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16776     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16792     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16776     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16776     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 17816     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16784     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.19       | 16792     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 10-Jun-20 | 18:55 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 10-Jun-20 | 18:55 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 10-Jun-20 | 18:55 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 10-Jun-20 | 18:55 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 10-Jun-20 | 18:55 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 10-Jun-20 | 18:55 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 10-Jun-20 | 18:55 | x86      |
| Msmdctr.dll                                               | 2018.150.34.19   | 37256     | 10-Jun-20 | 18:55 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.19   | 47777672  | 10-Jun-20 | 18:55 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.19   | 66283416  | 10-Jun-20 | 18:55 | x64      |
| Msmdpump.dll                                              | 2018.150.34.19   | 10187144  | 10-Jun-20 | 18:55 | x64      |
| Msmdredir.dll                                             | 2018.150.34.19   | 7955864   | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 15752     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 15768     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 16280     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 15768     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 16280     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 16280     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 16264     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 17304     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 15768     | 10-Jun-20 | 18:55 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.19       | 15768     | 10-Jun-20 | 18:55 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.19   | 65819528  | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 832400    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1627024   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1452944   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1641872   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1607568   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1000328   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 991624    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1535880   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1520520   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 809864    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.19   | 1595280   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 831376    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1623432   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1449864   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1636752   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1603464   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 997776    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 990096    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1531784   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1516936   | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 808840    | 10-Jun-20 | 18:55 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.19   | 1590672   | 10-Jun-20 | 18:55 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.19   | 10185096  | 10-Jun-20 | 18:55 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.19   | 8277912   | 10-Jun-20 | 18:55 | x86      |
| Msolap.dll                                                | 2018.150.34.19   | 11015048  | 10-Jun-20 | 18:55 | x64      |
| Msolap.dll                                                | 2018.150.34.19   | 8607112   | 10-Jun-20 | 18:55 | x86      |
| Msolui.dll                                                | 2018.150.34.19   | 285080    | 10-Jun-20 | 18:55 | x86      |
| Msolui.dll                                                | 2018.150.34.19   | 305552    | 10-Jun-20 | 18:55 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 10-Jun-20 | 18:55 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 10-Jun-20 | 18:55 | x64      |
| Sqlboot.dll                                               | 2019.150.4043.16 | 213904    | 10-Jun-20 | 18:55 | x64      |
| Sqlceip.exe                                               | 15.0.4043.16     | 283536    | 10-Jun-20 | 18:55 | x86      |
| Sqldumper.exe                                             | 2019.150.4043.16 | 152464    | 10-Jun-20 | 18:55 | x86      |
| Sqldumper.exe                                             | 2019.150.4043.16 | 181128    | 10-Jun-20 | 18:55 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 10-Jun-20 | 18:55 | x86      |
| Tmapi.dll                                                 | 2018.150.34.19   | 6177160   | 10-Jun-20 | 18:55 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.19   | 4916616   | 10-Jun-20 | 18:55 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.19   | 1183632   | 10-Jun-20 | 18:55 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.19   | 6802328   | 10-Jun-20 | 18:55 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.19   | 26021256  | 10-Jun-20 | 18:55 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.19   | 35457936  | 10-Jun-20 | 18:55 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4043.16 | 74640     | 10-Jun-20 | 18:55 | x86      |
| Instapi150.dll                       | 2019.150.4043.16 | 82832     | 10-Jun-20 | 18:55 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4043.16 | 86920     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4043.16 | 99208     | 10-Jun-20 | 18:55 | x64      |
| Msasxpress.dll                       | 2018.150.34.19   | 25992     | 10-Jun-20 | 18:55 | x86      |
| Msasxpress.dll                       | 2018.150.34.19   | 31112     | 10-Jun-20 | 18:55 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4043.16 | 78736     | 10-Jun-20 | 18:55 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4043.16 | 86920     | 10-Jun-20 | 18:55 | x64      |
| Sqldumper.exe                        | 2019.150.4043.16 | 152464    | 10-Jun-20 | 18:55 | x86      |
| Sqldumper.exe                        | 2019.150.4043.16 | 181128    | 10-Jun-20 | 18:55 | x64      |
| Sqlftacct.dll                        | 2019.150.4043.16 | 58256     | 10-Jun-20 | 18:55 | x86      |
| Sqlftacct.dll                        | 2019.150.4043.16 | 74640     | 10-Jun-20 | 18:55 | x64      |
| Sqlmanager.dll                       | 2019.150.4043.16 | 742288    | 10-Jun-20 | 18:55 | x86      |
| Sqlmanager.dll                       | 2019.150.4043.16 | 873352    | 10-Jun-20 | 18:55 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4043.16 | 377736    | 10-Jun-20 | 18:55 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4043.16 | 431000    | 10-Jun-20 | 18:55 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4043.16 | 275336    | 10-Jun-20 | 18:55 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4043.16 | 357256    | 10-Jun-20 | 18:55 | x64      |
| Svrenumapi150.dll                    | 2019.150.4043.16 | 910232    | 10-Jun-20 | 18:55 | x86      |
| Svrenumapi150.dll                    | 2019.150.4043.16 | 1160072   | 10-Jun-20 | 18:55 | x64      |

SQL Server 2019 sql_dreplay_client

|     File name     |   File version   | File size |    Date   |  Time | Platform |
|:-----------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe | 2019.150.4043.16 | 136080    | 10-Jun-20 | 18:56 | x86      |
| Dreplaycommon.dll | 2019.150.4043.16 | 664976    | 10-Jun-20 | 18:56 | x86      |
| Dreplayutil.dll   | 2019.150.4043.16 | 304016    | 10-Jun-20 | 18:56 | x86      |
| Instapi150.dll    | 2019.150.4043.16 | 82832     | 10-Jun-20 | 18:56 | x64      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4043.16 | 664976    | 10-Jun-20 | 18:55 | x86      |
| Dreplaycontroller.exe | 2019.150.4043.16 | 365456    | 10-Jun-20 | 18:55 | x86      |
| Instapi150.dll        | 2019.150.4043.16 | 82832     | 10-Jun-20 | 18:55 | x64      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4043.16 | 4652936   | 10-Jun-20 | 20:08 | x64      |
| Aetm-enclave.dll                           | 2019.150.4043.16 | 4604264   | 10-Jun-20 | 20:08 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4043.16 | 4924640   | 10-Jun-20 | 20:08 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4043.16 | 4866256   | 10-Jun-20 | 20:08 | x64      |
| Azureattest.dll                            | 10.0.18965.1000  | 255056    | 10-Jun-20 | 18:55 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000  | 97528     | 10-Jun-20 | 18:55 | x64      |
| C1.dll                                     | 19.16.27034.0    | 2438520   | 10-Jun-20 | 20:08 | x64      |
| C2.dll                                     | 19.16.27034.0    | 7239032   | 10-Jun-20 | 20:08 | x64      |
| Cl.exe                                     | 19.16.27034.0    | 424360    | 10-Jun-20 | 20:08 | x64      |
| Clui.dll                                   | 19.16.27034.0    | 541048    | 10-Jun-20 | 20:08 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4043.16 | 279448    | 10-Jun-20 | 20:08 | x64      |
| Dcexec.exe                                 | 2019.150.4043.16 | 86920     | 10-Jun-20 | 20:08 | x64      |
| Fssres.dll                                 | 2019.150.4043.16 | 95120     | 10-Jun-20 | 20:08 | x64      |
| Hadrres.dll                                | 2019.150.4043.16 | 201616    | 10-Jun-20 | 20:08 | x64      |
| Hkcompile.dll                              | 2019.150.4043.16 | 1291144   | 10-Jun-20 | 20:08 | x64      |
| Hkengine.dll                               | 2019.150.4043.16 | 5784456   | 10-Jun-20 | 20:08 | x64      |
| Hkruntime.dll                              | 2019.150.4043.16 | 181136    | 10-Jun-20 | 20:08 | x64      |
| Hktempdb.dll                               | 2019.150.4043.16 | 62352     | 10-Jun-20 | 20:08 | x64      |
| Link.exe                                   | 14.16.27034.0    | 1707936   | 10-Jun-20 | 20:08 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4043.16     | 234384    | 10-Jun-20 | 20:08 | x86      |
| Msobj140.dll                               | 14.16.27034.0    | 134008    | 10-Jun-20 | 20:08 | x64      |
| Mspdb140.dll                               | 14.16.27034.0    | 632184    | 10-Jun-20 | 20:08 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0    | 632184    | 10-Jun-20 | 20:08 | x64      |
| Msvcp140.dll                               | 14.16.27034.0    | 628200    | 10-Jun-20 | 20:08 | x64      |
| Qds.dll                                    | 2019.150.4043.16 | 1176456   | 10-Jun-20 | 20:08 | x64      |
| Rsfxft.dll                                 | 2019.150.4043.16 | 50072     | 10-Jun-20 | 20:08 | x64      |
| Secforwarder.dll                           | 2019.150.4043.16 | 78736     | 10-Jun-20 | 20:08 | x64      |
| Sqagtres.dll                               | 2019.150.4043.16 | 86928     | 10-Jun-20 | 20:08 | x64      |
| Sqlaamss.dll                               | 2019.150.4043.16 | 107400    | 10-Jun-20 | 20:08 | x64      |
| Sqlaccess.dll                              | 2019.150.4043.16 | 492424    | 10-Jun-20 | 19:38 | x64      |
| Sqlagent.exe                               | 2019.150.4043.16 | 729992    | 10-Jun-20 | 20:08 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4043.16 | 66456     | 10-Jun-20 | 20:08 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4043.16 | 78736     | 10-Jun-20 | 20:08 | x64      |
| Sqlboot.dll                                | 2019.150.4043.16 | 213904    | 10-Jun-20 | 19:37 | x64      |
| Sqlceip.exe                                | 15.0.4043.16     | 283536    | 10-Jun-20 | 20:08 | x86      |
| Sqlcmdss.dll                               | 2019.150.4043.16 | 86928     | 10-Jun-20 | 20:08 | x64      |
| Sqlctr150.dll                              | 2019.150.4043.16 | 115592    | 10-Jun-20 | 20:08 | x86      |
| Sqlctr150.dll                              | 2019.150.4043.16 | 140168    | 10-Jun-20 | 20:08 | x64      |
| Sqldk.dll                                  | 2019.150.4043.16 | 3146640   | 10-Jun-20 | 20:08 | x64      |
| Sqldtsss.dll                               | 2019.150.4043.16 | 107400    | 10-Jun-20 | 20:08 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 1586064   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3482520   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3679112   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 4141960   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 4260736   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3396496   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3560328   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 4137872   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3990416   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 4043656   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 2212752   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 2159496   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3851152   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3527568   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3994504   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3802000   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3797904   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3593104   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3482504   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 1528712   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 3888008   | 10-Jun-20 | 19:37 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4043.16 | 4006800   | 10-Jun-20 | 19:37 | x64      |
| Sqllang.dll                                | 2019.150.4043.16 | 39646088  | 10-Jun-20 | 20:08 | x64      |
| Sqlmin.dll                                 | 2019.150.4043.16 | 40175512  | 10-Jun-20 | 20:08 | x64      |
| Sqlolapss.dll                              | 2019.150.4043.16 | 103312    | 10-Jun-20 | 20:08 | x64      |
| Sqlos.dll                                  | 2019.150.4043.16 | 41864     | 10-Jun-20 | 19:37 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4043.16 | 82824     | 10-Jun-20 | 20:08 | x64      |
| Sqlrepss.dll                               | 2019.150.4043.16 | 82824     | 10-Jun-20 | 20:08 | x64      |
| Sqlscm.dll                                 | 2019.150.4043.16 | 86912     | 10-Jun-20 | 19:37 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4043.16 | 37768     | 10-Jun-20 | 19:38 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4043.16 | 5792648   | 10-Jun-20 | 19:38 | x64      |
| Sqlservr.exe                               | 2019.150.4043.16 | 623504    | 10-Jun-20 | 19:38 | x64      |
| Sqlsvc.dll                                 | 2019.150.4043.16 | 181128    | 10-Jun-20 | 20:08 | x64      |
| Sqltses.dll                                | 2019.150.4043.16 | 9073536   | 10-Jun-20 | 20:08 | x64      |
| Sqsrvres.dll                               | 2019.150.4043.16 | 279432    | 10-Jun-20 | 20:08 | x64      |
| Svl.dll                                    | 2019.150.4043.16 | 160656    | 10-Jun-20 | 20:08 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0    | 85992     | 10-Jun-20 | 20:08 | x64      |
| Xe.dll                                     | 2019.150.4043.16 | 721800    | 10-Jun-20 | 20:08 | x64      |
| Xpadsi.exe                                 | 2019.150.4043.16 | 115592    | 10-Jun-20 | 20:08 | x64      |
| Xplog70.dll                                | 2019.150.4043.16 | 91032     | 10-Jun-20 | 19:38 | x64      |
| Xprepl.dll                                 | 2019.150.4043.16 | 119696    | 10-Jun-20 | 20:08 | x64      |
| Xpstar.dll                                 | 2019.150.4043.16 | 471944    | 10-Jun-20 | 19:37 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                          | 2019.150.4043.16 | 263056    | 10-Jun-20 | 18:55 | x64      |
| Datacollectortasks.dll                                   | 2019.150.4043.16 | 226184    | 10-Jun-20 | 18:55 | x64      |
| Distrib.exe                                              | 2019.150.4043.16 | 234376    | 10-Jun-20 | 18:55 | x64      |
| Dteparse.dll                                             | 2019.150.4043.16 | 123792    | 10-Jun-20 | 18:55 | x64      |
| Dteparsemgd.dll                                          | 2019.150.4043.16 | 131976    | 10-Jun-20 | 18:55 | x64      |
| Dtepkg.dll                                               | 2019.150.4043.16 | 148368    | 10-Jun-20 | 18:55 | x64      |
| Dtexec.exe                                               | 2019.150.4043.16 | 71568     | 10-Jun-20 | 18:55 | x64      |
| Dts.dll                                                  | 2019.150.4043.16 | 3142544   | 10-Jun-20 | 18:55 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4043.16 | 500616    | 10-Jun-20 | 18:55 | x64      |
| Dtsconn.dll                                              | 2019.150.4043.16 | 525192    | 10-Jun-20 | 18:55 | x64      |
| Dtshost.exe                                              | 2019.150.4043.16 | 104328    | 10-Jun-20 | 18:55 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4043.16 | 566152    | 10-Jun-20 | 18:55 | x64      |
| Dtspipeline.dll                                          | 2019.150.4043.16 | 1328024   | 10-Jun-20 | 18:55 | x64      |
| Dtswizard.exe                                            | 15.0.4043.16     | 885640    | 10-Jun-20 | 18:55 | x64      |
| Dtuparse.dll                                             | 2019.150.4043.16 | 99216     | 10-Jun-20 | 18:55 | x64      |
| Dtutil.exe                                               | 2019.150.4043.16 | 147344    | 10-Jun-20 | 18:55 | x64      |
| Exceldest.dll                                            | 2019.150.4043.16 | 279432    | 10-Jun-20 | 18:55 | x64      |
| Excelsrc.dll                                             | 2019.150.4043.16 | 308112    | 10-Jun-20 | 18:55 | x64      |
| Execpackagetask.dll                                      | 2019.150.4043.16 | 185224    | 10-Jun-20 | 18:55 | x64      |
| Flatfiledest.dll                                         | 2019.150.4043.16 | 410512    | 10-Jun-20 | 18:55 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4043.16 | 426888    | 10-Jun-20 | 18:55 | x64      |
| Logread.exe                                              | 2019.150.4043.16 | 717712    | 10-Jun-20 | 18:55 | x64      |
| Mergetxt.dll                                             | 2019.150.4043.16 | 74640     | 10-Jun-20 | 18:55 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4043.16     | 58248     | 10-Jun-20 | 18:55 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4043.16     | 390032    | 10-Jun-20 | 18:55 | x86      |
| Msdtssrvrutil.dll                                        | 2019.150.4043.16 | 111496    | 10-Jun-20 | 18:55 | x64      |
| Msgprox.dll                                              | 2019.150.4043.16 | 299912    | 10-Jun-20 | 18:55 | x64      |
| Msoledbsql.dll                                           | 2018.182.3.0     | 148432    | 10-Jun-20 | 18:55 | x64      |
| Msxmlsql.dll                                             | 2019.150.4043.16 | 1495952   | 10-Jun-20 | 18:55 | x64      |
| Oledbdest.dll                                            | 2019.150.4043.16 | 279432    | 10-Jun-20 | 18:55 | x64      |
| Oledbsrc.dll                                             | 2019.150.4043.16 | 312208    | 10-Jun-20 | 18:55 | x64      |
| Osql.exe                                                 | 2019.150.4043.16 | 91024     | 10-Jun-20 | 18:55 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4043.16 | 496520    | 10-Jun-20 | 18:55 | x64      |
| Rawdest.dll                                              | 2019.150.4043.16 | 226184    | 10-Jun-20 | 18:55 | x64      |
| Rawsource.dll                                            | 2019.150.4043.16 | 209800    | 10-Jun-20 | 18:55 | x64      |
| Rdistcom.dll                                             | 2019.150.4043.16 | 914312    | 10-Jun-20 | 18:55 | x64      |
| Recordsetdest.dll                                        | 2019.150.4043.16 | 201616    | 10-Jun-20 | 18:55 | x64      |
| Repldp.dll                                               | 2019.150.4043.16 | 312208    | 10-Jun-20 | 18:55 | x64      |
| Replerrx.dll                                             | 2019.150.4043.16 | 181136    | 10-Jun-20 | 18:55 | x64      |
| Replisapi.dll                                            | 2019.150.4043.16 | 394120    | 10-Jun-20 | 18:55 | x64      |
| Replmerg.exe                                             | 2019.150.4043.16 | 562056    | 10-Jun-20 | 18:55 | x64      |
| Replprov.dll                                             | 2019.150.4043.16 | 852872    | 10-Jun-20 | 18:55 | x64      |
| Replrec.dll                                              | 2019.150.4043.16 | 1029008   | 10-Jun-20 | 18:55 | x64      |
| Replsub.dll                                              | 2019.150.4043.16 | 471944    | 10-Jun-20 | 18:55 | x64      |
| Replsync.dll                                             | 2019.150.4043.16 | 164744    | 10-Jun-20 | 18:55 | x64      |
| Spresolv.dll                                             | 2019.150.4043.16 | 275336    | 10-Jun-20 | 18:55 | x64      |
| Sqldiag.exe                                              | 2019.150.4043.16 | 1139592   | 10-Jun-20 | 18:55 | x64      |
| Sqldistx.dll                                             | 2019.150.4043.16 | 246664    | 10-Jun-20 | 18:55 | x64      |
| Sqllogship.exe                                           | 15.0.4043.16     | 103304    | 10-Jun-20 | 18:55 | x64      |
| Sqlmergx.dll                                             | 2019.150.4043.16 | 398216    | 10-Jun-20 | 18:55 | x64      |
| Sqlscm.dll                                               | 2019.150.4043.16 | 78728     | 10-Jun-20 | 18:55 | x86      |
| Sqlscm.dll                                               | 2019.150.4043.16 | 86912     | 10-Jun-20 | 18:55 | x64      |
| Sqlsvc.dll                                               | 2019.150.4043.16 | 181128    | 10-Jun-20 | 18:55 | x64      |
| Sqlsvc.dll                                               | 2019.150.4043.16 | 148360    | 10-Jun-20 | 18:55 | x86      |
| Sqltaskconnections.dll                                   | 2019.150.4043.16 | 201608    | 10-Jun-20 | 18:55 | x64      |
| Ssradd.dll                                               | 2019.150.4043.16 | 82824     | 10-Jun-20 | 18:55 | x64      |
| Ssravg.dll                                               | 2019.150.4043.16 | 82840     | 10-Jun-20 | 18:55 | x64      |
| Ssrdown.dll                                              | 2019.150.4043.16 | 74632     | 10-Jun-20 | 18:55 | x64      |
| Ssrmax.dll                                               | 2019.150.4043.16 | 82832     | 10-Jun-20 | 18:55 | x64      |
| Ssrmin.dll                                               | 2019.150.4043.16 | 82840     | 10-Jun-20 | 18:55 | x64      |
| Ssrpub.dll                                               | 2019.150.4043.16 | 74640     | 10-Jun-20 | 18:55 | x64      |
| Ssrup.dll                                                | 2019.150.4043.16 | 74648     | 10-Jun-20 | 18:55 | x64      |
| Txagg.dll                                                | 2019.150.4043.16 | 390032    | 10-Jun-20 | 18:55 | x64      |
| Txbdd.dll                                                | 2019.150.4043.16 | 189328    | 10-Jun-20 | 18:55 | x64      |
| Txdatacollector.dll                                      | 2019.150.4043.16 | 471952    | 10-Jun-20 | 18:55 | x64      |
| Txdataconvert.dll                                        | 2019.150.4043.16 | 316304    | 10-Jun-20 | 18:55 | x64      |
| Txderived.dll                                            | 2019.150.4043.16 | 639888    | 10-Jun-20 | 18:55 | x64      |
| Txlookup.dll                                             | 2019.150.4043.16 | 541584    | 10-Jun-20 | 18:55 | x64      |
| Txmerge.dll                                              | 2019.150.4043.16 | 246672    | 10-Jun-20 | 18:55 | x64      |
| Txmergejoin.dll                                          | 2019.150.4043.16 | 308112    | 10-Jun-20 | 18:55 | x64      |
| Txmulticast.dll                                          | 2019.150.4043.16 | 144272    | 10-Jun-20 | 18:55 | x64      |
| Txrowcount.dll                                           | 2019.150.4043.16 | 140168    | 10-Jun-20 | 18:55 | x64      |
| Txsort.dll                                               | 2019.150.4043.16 | 287632    | 10-Jun-20 | 18:55 | x64      |
| Txsplit.dll                                              | 2019.150.4043.16 | 623504    | 10-Jun-20 | 18:55 | x64      |
| Txunionall.dll                                           | 2019.150.4043.16 | 197520    | 10-Jun-20 | 18:55 | x64      |
| Xe.dll                                                   | 2019.150.4043.16 | 721800    | 10-Jun-20 | 18:55 | x64      |
| Xmlsub.dll                                               | 2019.150.4043.16 | 295824    | 10-Jun-20 | 18:55 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4043.16 | 91032     | 10-Jun-20 | 18:56 | x64      |
| Exthost.exe        | 2019.150.4043.16 | 230288    | 10-Jun-20 | 18:56 | x64      |
| Launchpad.exe      | 2019.150.4043.16 | 1225616   | 10-Jun-20 | 18:56 | x64      |
| Sqlsatellite.dll   | 2019.150.4043.16 | 1024912   | 10-Jun-20 | 18:56 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4043.16 | 684944    | 10-Jun-20 | 18:55 | x64      |
| Fdhost.exe     | 2019.150.4043.16 | 127888    | 10-Jun-20 | 18:55 | x64      |
| Fdlauncher.exe | 2019.150.4043.16 | 78736     | 10-Jun-20 | 18:55 | x64      |
| Sqlft150ph.dll | 2019.150.4043.16 | 91024     | 10-Jun-20 | 18:55 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4043.16 | 29592     | 10-Jun-20 | 18:55 | x86      |

SQL Server 2019 Integration Services

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                          | 2019.150.4043.16 | 226192    | 10-Jun-20 | 19:05 | x86      |
| Commanddest.dll                                          | 2019.150.4043.16 | 263056    | 10-Jun-20 | 19:05 | x64      |
| Dteparse.dll                                             | 2019.150.4043.16 | 111496    | 10-Jun-20 | 19:05 | x86      |
| Dteparse.dll                                             | 2019.150.4043.16 | 123792    | 10-Jun-20 | 19:05 | x64      |
| Dteparsemgd.dll                                          | 2019.150.4043.16 | 115592    | 10-Jun-20 | 19:05 | x86      |
| Dteparsemgd.dll                                          | 2019.150.4043.16 | 131976    | 10-Jun-20 | 19:05 | x64      |
| Dtepkg.dll                                               | 2019.150.4043.16 | 131976    | 10-Jun-20 | 19:05 | x86      |
| Dtepkg.dll                                               | 2019.150.4043.16 | 148368    | 10-Jun-20 | 19:05 | x64      |
| Dtexec.exe                                               | 2019.150.4043.16 | 71568     | 10-Jun-20 | 19:05 | x64      |
| Dtexec.exe                                               | 2019.150.4043.16 | 62864     | 10-Jun-20 | 19:05 | x86      |
| Dts.dll                                                  | 2019.150.4043.16 | 2761608   | 10-Jun-20 | 19:05 | x86      |
| Dts.dll                                                  | 2019.150.4043.16 | 3142544   | 10-Jun-20 | 19:05 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4043.16 | 500616    | 10-Jun-20 | 19:05 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4043.16 | 443280    | 10-Jun-20 | 19:05 | x86      |
| Dtsconn.dll                                              | 2019.150.4043.16 | 435080    | 10-Jun-20 | 19:05 | x86      |
| Dtsconn.dll                                              | 2019.150.4043.16 | 525192    | 10-Jun-20 | 19:05 | x64      |
| Dtsdebughost.exe                                         | 2019.150.4043.16 | 110992    | 10-Jun-20 | 19:05 | x64      |
| Dtsdebughost.exe                                         | 2019.150.4043.16 | 92552     | 10-Jun-20 | 19:05 | x86      |
| Dtshost.exe                                              | 2019.150.4043.16 | 104328    | 10-Jun-20 | 19:05 | x64      |
| Dtshost.exe                                              | 2019.150.4043.16 | 87440     | 10-Jun-20 | 19:05 | x86      |
| Dtsmsg150.dll                                            | 2019.150.4043.16 | 553872    | 10-Jun-20 | 19:05 | x86      |
| Dtsmsg150.dll                                            | 2019.150.4043.16 | 566152    | 10-Jun-20 | 19:05 | x64      |
| Dtspipeline.dll                                          | 2019.150.4043.16 | 1119128   | 10-Jun-20 | 19:05 | x86      |
| Dtspipeline.dll                                          | 2019.150.4043.16 | 1328024   | 10-Jun-20 | 19:05 | x64      |
| Dtswizard.exe                                            | 15.0.4043.16     | 885640    | 10-Jun-20 | 19:05 | x64      |
| Dtswizard.exe                                            | 15.0.4043.16     | 889744    | 10-Jun-20 | 19:05 | x86      |
| Dtuparse.dll                                             | 2019.150.4043.16 | 86920     | 10-Jun-20 | 19:05 | x86      |
| Dtuparse.dll                                             | 2019.150.4043.16 | 99216     | 10-Jun-20 | 19:05 | x64      |
| Dtutil.exe                                               | 2019.150.4043.16 | 128904    | 10-Jun-20 | 19:05 | x86      |
| Dtutil.exe                                               | 2019.150.4043.16 | 147344    | 10-Jun-20 | 19:05 | x64      |
| Exceldest.dll                                            | 2019.150.4043.16 | 234384    | 10-Jun-20 | 19:05 | x86      |
| Exceldest.dll                                            | 2019.150.4043.16 | 279432    | 10-Jun-20 | 19:05 | x64      |
| Excelsrc.dll                                             | 2019.150.4043.16 | 258952    | 10-Jun-20 | 19:05 | x86      |
| Excelsrc.dll                                             | 2019.150.4043.16 | 308112    | 10-Jun-20 | 19:05 | x64      |
| Execpackagetask.dll                                      | 2019.150.4043.16 | 148368    | 10-Jun-20 | 19:05 | x86      |
| Execpackagetask.dll                                      | 2019.150.4043.16 | 185224    | 10-Jun-20 | 19:05 | x64      |
| Flatfiledest.dll                                         | 2019.150.4043.16 | 357264    | 10-Jun-20 | 19:05 | x86      |
| Flatfiledest.dll                                         | 2019.150.4043.16 | 410512    | 10-Jun-20 | 19:05 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4043.16 | 369552    | 10-Jun-20 | 19:05 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4043.16 | 426888    | 10-Jun-20 | 19:05 | x64      |
| Isdbupgradewizard.exe                                    | 15.0.4043.16     | 119696    | 10-Jun-20 | 19:05 | x86      |
| Microsoft.sqlserver.astasks.dll                          | 15.0.4043.16     | 78736     | 10-Jun-20 | 19:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4043.16     | 58248     | 10-Jun-20 | 19:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4043.16     | 58256     | 10-Jun-20 | 19:05 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4043.16     | 390032    | 10-Jun-20 | 19:05 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4043.16     | 140168    | 10-Jun-20 | 19:05 | x86      |
| Msdtssrvr.exe                                            | 15.0.4043.16     | 218000    | 10-Jun-20 | 19:05 | x64      |
| Msdtssrvrutil.dll                                        | 2019.150.4043.16 | 111496    | 10-Jun-20 | 19:05 | x64      |
| Msdtssrvrutil.dll                                        | 2019.150.4043.16 | 99216     | 10-Jun-20 | 19:05 | x86      |
| Msmdpp.dll                                               | 2018.150.34.19   | 10062216  | 10-Jun-20 | 18:56 | x64      |
| Odbcdest.dll                                             | 2019.150.4043.16 | 316296    | 10-Jun-20 | 19:05 | x86      |
| Odbcdest.dll                                             | 2019.150.4043.16 | 369544    | 10-Jun-20 | 19:05 | x64      |
| Odbcsrc.dll                                              | 2019.150.4043.16 | 328592    | 10-Jun-20 | 19:05 | x86      |
| Odbcsrc.dll                                              | 2019.150.4043.16 | 381832    | 10-Jun-20 | 19:05 | x64      |
| Oledbdest.dll                                            | 2019.150.4043.16 | 238472    | 10-Jun-20 | 19:05 | x86      |
| Oledbdest.dll                                            | 2019.150.4043.16 | 279432    | 10-Jun-20 | 19:05 | x64      |
| Oledbsrc.dll                                             | 2019.150.4043.16 | 263048    | 10-Jun-20 | 19:05 | x86      |
| Oledbsrc.dll                                             | 2019.150.4043.16 | 312208    | 10-Jun-20 | 19:05 | x64      |
| Rawdest.dll                                              | 2019.150.4043.16 | 189320    | 10-Jun-20 | 19:05 | x86      |
| Rawdest.dll                                              | 2019.150.4043.16 | 226184    | 10-Jun-20 | 19:05 | x64      |
| Rawsource.dll                                            | 2019.150.4043.16 | 177032    | 10-Jun-20 | 19:05 | x86      |
| Rawsource.dll                                            | 2019.150.4043.16 | 209800    | 10-Jun-20 | 19:05 | x64      |
| Recordsetdest.dll                                        | 2019.150.4043.16 | 172944    | 10-Jun-20 | 19:05 | x86      |
| Recordsetdest.dll                                        | 2019.150.4043.16 | 201616    | 10-Jun-20 | 19:05 | x64      |
| Sqlceip.exe                                              | 15.0.4043.16     | 283536    | 10-Jun-20 | 19:05 | x86      |
| Sqldest.dll                                              | 2019.150.4043.16 | 238480    | 10-Jun-20 | 19:05 | x86      |
| Sqldest.dll                                              | 2019.150.4043.16 | 275336    | 10-Jun-20 | 19:05 | x64      |
| Sqltaskconnections.dll                                   | 2019.150.4043.16 | 168840    | 10-Jun-20 | 19:05 | x86      |
| Sqltaskconnections.dll                                   | 2019.150.4043.16 | 201608    | 10-Jun-20 | 19:05 | x64      |
| Txagg.dll                                                | 2019.150.4043.16 | 328600    | 10-Jun-20 | 19:05 | x86      |
| Txagg.dll                                                | 2019.150.4043.16 | 390032    | 10-Jun-20 | 19:05 | x64      |
| Txbdd.dll                                                | 2019.150.4043.16 | 152456    | 10-Jun-20 | 19:05 | x86      |
| Txbdd.dll                                                | 2019.150.4043.16 | 189328    | 10-Jun-20 | 19:05 | x64      |
| Txbestmatch.dll                                          | 2019.150.4043.16 | 545680    | 10-Jun-20 | 19:05 | x86      |
| Txbestmatch.dll                                          | 2019.150.4043.16 | 652184    | 10-Jun-20 | 19:05 | x64      |
| Txcache.dll                                              | 2019.150.4043.16 | 164752    | 10-Jun-20 | 19:05 | x86      |
| Txcache.dll                                              | 2019.150.4043.16 | 197512    | 10-Jun-20 | 19:05 | x64      |
| Txcharmap.dll                                            | 2019.150.4043.16 | 271248    | 10-Jun-20 | 19:05 | x86      |
| Txcharmap.dll                                            | 2019.150.4043.16 | 312208    | 10-Jun-20 | 19:05 | x64      |
| Txcopymap.dll                                            | 2019.150.4043.16 | 164752    | 10-Jun-20 | 19:05 | x86      |
| Txcopymap.dll                                            | 2019.150.4043.16 | 197512    | 10-Jun-20 | 19:05 | x64      |
| Txdataconvert.dll                                        | 2019.150.4043.16 | 275336    | 10-Jun-20 | 19:05 | x86      |
| Txdataconvert.dll                                        | 2019.150.4043.16 | 316304    | 10-Jun-20 | 19:05 | x64      |
| Txderived.dll                                            | 2019.150.4043.16 | 557968    | 10-Jun-20 | 19:05 | x86      |
| Txderived.dll                                            | 2019.150.4043.16 | 639888    | 10-Jun-20 | 19:05 | x64      |
| Txfileextractor.dll                                      | 2019.150.4043.16 | 181136    | 10-Jun-20 | 19:05 | x86      |
| Txfileextractor.dll                                      | 2019.150.4043.16 | 217992    | 10-Jun-20 | 19:05 | x64      |
| Txfileinserter.dll                                       | 2019.150.4043.16 | 181128    | 10-Jun-20 | 19:05 | x86      |
| Txfileinserter.dll                                       | 2019.150.4043.16 | 213896    | 10-Jun-20 | 19:05 | x64      |
| Txgroupdups.dll                                          | 2019.150.4043.16 | 254856    | 10-Jun-20 | 19:05 | x86      |
| Txgroupdups.dll                                          | 2019.150.4043.16 | 312200    | 10-Jun-20 | 19:05 | x64      |
| Txlineage.dll                                            | 2019.150.4043.16 | 127888    | 10-Jun-20 | 19:05 | x86      |
| Txlineage.dll                                            | 2019.150.4043.16 | 152464    | 10-Jun-20 | 19:05 | x64      |
| Txlookup.dll                                             | 2019.150.4043.16 | 467848    | 10-Jun-20 | 19:05 | x86      |
| Txlookup.dll                                             | 2019.150.4043.16 | 541584    | 10-Jun-20 | 19:05 | x64      |
| Txmerge.dll                                              | 2019.150.4043.16 | 201616    | 10-Jun-20 | 19:05 | x86      |
| Txmerge.dll                                              | 2019.150.4043.16 | 246672    | 10-Jun-20 | 19:05 | x64      |
| Txmergejoin.dll                                          | 2019.150.4043.16 | 246664    | 10-Jun-20 | 19:05 | x86      |
| Txmergejoin.dll                                          | 2019.150.4043.16 | 308112    | 10-Jun-20 | 19:05 | x64      |
| Txmulticast.dll                                          | 2019.150.4043.16 | 115600    | 10-Jun-20 | 19:05 | x86      |
| Txmulticast.dll                                          | 2019.150.4043.16 | 144272    | 10-Jun-20 | 19:05 | x64      |
| Txpivot.dll                                              | 2019.150.4043.16 | 205712    | 10-Jun-20 | 19:05 | x86      |
| Txpivot.dll                                              | 2019.150.4043.16 | 238472    | 10-Jun-20 | 19:05 | x64      |
| Txrowcount.dll                                           | 2019.150.4043.16 | 111496    | 10-Jun-20 | 19:05 | x86      |
| Txrowcount.dll                                           | 2019.150.4043.16 | 140168    | 10-Jun-20 | 19:05 | x64      |
| Txsampling.dll                                           | 2019.150.4043.16 | 156552    | 10-Jun-20 | 19:05 | x86      |
| Txsampling.dll                                           | 2019.150.4043.16 | 193416    | 10-Jun-20 | 19:05 | x64      |
| Txscd.dll                                                | 2019.150.4043.16 | 197512    | 10-Jun-20 | 19:05 | x86      |
| Txscd.dll                                                | 2019.150.4043.16 | 234376    | 10-Jun-20 | 19:05 | x64      |
| Txsort.dll                                               | 2019.150.4043.16 | 230280    | 10-Jun-20 | 19:05 | x86      |
| Txsort.dll                                               | 2019.150.4043.16 | 287632    | 10-Jun-20 | 19:05 | x64      |
| Txsplit.dll                                              | 2019.150.4043.16 | 549776    | 10-Jun-20 | 19:05 | x86      |
| Txsplit.dll                                              | 2019.150.4043.16 | 623504    | 10-Jun-20 | 19:05 | x64      |
| Txtermextraction.dll                                     | 2019.150.4043.16 | 8643464   | 10-Jun-20 | 19:05 | x86      |
| Txtermextraction.dll                                     | 2019.150.4043.16 | 8700808   | 10-Jun-20 | 19:05 | x64      |
| Txtermlookup.dll                                         | 2019.150.4043.16 | 4137864   | 10-Jun-20 | 19:05 | x86      |
| Txtermlookup.dll                                         | 2019.150.4043.16 | 4182928   | 10-Jun-20 | 19:05 | x64      |
| Txunionall.dll                                           | 2019.150.4043.16 | 160656    | 10-Jun-20 | 19:05 | x86      |
| Txunionall.dll                                           | 2019.150.4043.16 | 197520    | 10-Jun-20 | 19:05 | x64      |
| Txunpivot.dll                                            | 2019.150.4043.16 | 181128    | 10-Jun-20 | 19:05 | x86      |
| Txunpivot.dll                                            | 2019.150.4043.16 | 213896    | 10-Jun-20 | 19:05 | x64      |
| Xe.dll                                                   | 2019.150.4043.16 | 631696    | 10-Jun-20 | 19:05 | x86      |
| Xe.dll                                                   | 2019.150.4043.16 | 721800    | 10-Jun-20 | 19:05 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1858.0      | 551824    | 10-Jun-20 | 19:41 | x86      |
| Dmsnative.dll                                                        | 2018.150.1858.0  | 139168    | 10-Jun-20 | 19:41 | x64      |
| Dwengineservice.dll                                                  | 15.0.1858.0      | 43928     | 10-Jun-20 | 19:41 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008       | 17142672  | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003       | 146304    | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108        | 2365520   | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272       | 2199120   | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272       | 144976    | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217        | 2408016   | 10-Jun-20 | 19:41 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39         | 2928720   | 10-Jun-20 | 19:41 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109768  | 10-Jun-20 | 19:41 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109832  | 10-Jun-20 | 19:41 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2425288   | 10-Jun-20 | 19:41 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2431880   | 10-Jun-20 | 19:41 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124        | 15488080  | 10-Jun-20 | 19:41 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1775048   | 10-Jun-20 | 19:41 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1783688   | 10-Jun-20 | 19:41 | x64      |
| Instapi150.dll                                                       | 2019.150.4043.16 | 82832     | 10-Jun-20 | 19:41 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10         | 2620304   | 10-Jun-20 | 19:41 | x64      |
| Libcrypto                                                            | 1.1.1.4          | 2953680   | 10-Jun-20 | 19:41 | x64      |
| Libsasl.dll                                                          | 2.1.26.0         | 292224    | 10-Jun-20 | 19:41 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10         | 648080    | 10-Jun-20 | 19:41 | x64      |
| Libssl                                                               | 1.1.1.4          | 798160    | 10-Jun-20 | 19:41 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1858.0      | 66448     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1858.0      | 292248    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1858.0      | 1951120   | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1858.0      | 169376    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1858.0      | 631696    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1858.0      | 243600    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1858.0      | 137616    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1858.0      | 78736     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1858.0      | 50080     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1858.0      | 87440     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1858.0      | 1126288   | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1858.0      | 79768     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1858.0      | 69536     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1858.0      | 34200     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1858.0      | 30112     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1858.0      | 45472     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1858.0      | 20384     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1858.0      | 25496     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1858.0      | 130464    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1858.0      | 85392     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1858.0      | 99728     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1858.0      | 291216    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 118680    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 136592    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 139664    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 136592    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 148880    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 138648    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 133016    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 175000    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 116112    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1858.0      | 135056    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1858.0      | 71568     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1858.0      | 20896     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1858.0      | 36256     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1858.0      | 127896    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1858.0      | 3039120   | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1858.0      | 3952528   | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 117136    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 131984    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 136608    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 132512    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 147360    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 133008    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 129432    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 169872    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 114080    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1858.0      | 130968    | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1858.0      | 65424     | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1858.0      | 2681240   | 10-Jun-20 | 19:41 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1858.0      | 2435472   | 10-Jun-20 | 19:41 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4043.16 | 451480    | 10-Jun-20 | 19:41 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4043.16 | 7394184   | 10-Jun-20 | 19:41 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1     | 2016120   | 10-Jun-20 | 19:41 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1     | 720792    | 10-Jun-20 | 19:41 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1     | 138136    | 10-Jun-20 | 19:41 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1     | 175000    | 10-Jun-20 | 19:41 | x64      |
| Saslplain.dll                                                        | 2.1.26.0         | 170880    | 10-Jun-20 | 19:41 | x64      |
| Secforwarder.dll                                                     | 2019.150.4043.16 | 78736     | 10-Jun-20 | 19:41 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1858.0  | 60320     | 10-Jun-20 | 19:41 | x64      |
| Sqldk.dll                                                            | 2019.150.4043.16 | 3146640   | 10-Jun-20 | 19:41 | x64      |
| Sqldumper.exe                                                        | 2019.150.4043.16 | 181128    | 10-Jun-20 | 19:41 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 1586064   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 4141960   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 3396496   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 4137872   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 4043656   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 2212752   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 2159496   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 3802000   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 3797904   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 1528712   | 10-Jun-20 | 19:36 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4043.16 | 4006800   | 10-Jun-20 | 19:36 | x64      |
| Sqlos.dll                                                            | 2019.150.4043.16 | 41864     | 10-Jun-20 | 19:41 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1858.0  | 4840352   | 10-Jun-20 | 19:41 | x64      |
| Sqltses.dll                                                          | 2019.150.4043.16 | 9073536   | 10-Jun-20 | 19:41 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078     | 14995920  | 10-Jun-20 | 19:41 | x64      |
| Terasso.dll                                                          | 16.20.0.13       | 2158896   | 10-Jun-20 | 19:41 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0         | 281472    | 10-Jun-20 | 19:41 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4043.16 | 29576     | 10-Jun-20 | 18:55 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2019.150.4043.16 | 1631112   | 10-Jun-20 | 19:12 | x86      |
| Dtaengine.exe                                  | 2019.150.4043.16 | 217992    | 10-Jun-20 | 19:12 | x86      |
| Dteparse.dll                                   | 2019.150.4043.16 | 111496    | 10-Jun-20 | 19:12 | x86      |
| Dteparse.dll                                   | 2019.150.4043.16 | 123792    | 10-Jun-20 | 19:12 | x64      |
| Dteparsemgd.dll                                | 2019.150.4043.16 | 115592    | 10-Jun-20 | 19:12 | x86      |
| Dteparsemgd.dll                                | 2019.150.4043.16 | 131976    | 10-Jun-20 | 19:12 | x64      |
| Dtepkg.dll                                     | 2019.150.4043.16 | 131976    | 10-Jun-20 | 19:12 | x86      |
| Dtepkg.dll                                     | 2019.150.4043.16 | 148368    | 10-Jun-20 | 19:12 | x64      |
| Dtexec.exe                                     | 2019.150.4043.16 | 62864     | 10-Jun-20 | 19:12 | x86      |
| Dtexec.exe                                     | 2019.150.4043.16 | 71568     | 10-Jun-20 | 19:12 | x64      |
| Dts.dll                                        | 2019.150.4043.16 | 2761608   | 10-Jun-20 | 19:12 | x86      |
| Dts.dll                                        | 2019.150.4043.16 | 3142544   | 10-Jun-20 | 19:12 | x64      |
| Dtscomexpreval.dll                             | 2019.150.4043.16 | 443280    | 10-Jun-20 | 19:12 | x86      |
| Dtscomexpreval.dll                             | 2019.150.4043.16 | 500616    | 10-Jun-20 | 19:12 | x64      |
| Dtsconn.dll                                    | 2019.150.4043.16 | 435080    | 10-Jun-20 | 19:12 | x86      |
| Dtsconn.dll                                    | 2019.150.4043.16 | 525192    | 10-Jun-20 | 19:12 | x64      |
| Dtshost.exe                                    | 2019.150.4043.16 | 104328    | 10-Jun-20 | 19:12 | x64      |
| Dtshost.exe                                    | 2019.150.4043.16 | 87440     | 10-Jun-20 | 19:12 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4043.16 | 553872    | 10-Jun-20 | 19:12 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4043.16 | 566152    | 10-Jun-20 | 19:12 | x64      |
| Dtspipeline.dll                                | 2019.150.4043.16 | 1119128   | 10-Jun-20 | 19:12 | x86      |
| Dtspipeline.dll                                | 2019.150.4043.16 | 1328024   | 10-Jun-20 | 19:12 | x64      |
| Dtswizard.exe                                  | 15.0.4043.16     | 885640    | 10-Jun-20 | 19:12 | x64      |
| Dtswizard.exe                                  | 15.0.4043.16     | 889744    | 10-Jun-20 | 19:12 | x86      |
| Dtuparse.dll                                   | 2019.150.4043.16 | 86920     | 10-Jun-20 | 19:12 | x86      |
| Dtuparse.dll                                   | 2019.150.4043.16 | 99216     | 10-Jun-20 | 19:12 | x64      |
| Dtutil.exe                                     | 2019.150.4043.16 | 128904    | 10-Jun-20 | 19:12 | x86      |
| Dtutil.exe                                     | 2019.150.4043.16 | 147344    | 10-Jun-20 | 19:12 | x64      |
| Exceldest.dll                                  | 2019.150.4043.16 | 234384    | 10-Jun-20 | 19:12 | x86      |
| Exceldest.dll                                  | 2019.150.4043.16 | 279432    | 10-Jun-20 | 19:12 | x64      |
| Excelsrc.dll                                   | 2019.150.4043.16 | 258952    | 10-Jun-20 | 19:12 | x86      |
| Excelsrc.dll                                   | 2019.150.4043.16 | 308112    | 10-Jun-20 | 19:12 | x64      |
| Flatfiledest.dll                               | 2019.150.4043.16 | 357264    | 10-Jun-20 | 19:12 | x86      |
| Flatfiledest.dll                               | 2019.150.4043.16 | 410512    | 10-Jun-20 | 19:12 | x64      |
| Flatfilesrc.dll                                | 2019.150.4043.16 | 369552    | 10-Jun-20 | 19:12 | x86      |
| Flatfilesrc.dll                                | 2019.150.4043.16 | 426888    | 10-Jun-20 | 19:12 | x64      |
| Microsoft.sqlserver.astasks.dll                | 15.0.4043.16     | 78728     | 10-Jun-20 | 19:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4043.16     | 402312    | 10-Jun-20 | 19:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4043.16     | 402312    | 10-Jun-20 | 19:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4043.16     | 2999176   | 10-Jun-20 | 19:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4043.16     | 2999184   | 10-Jun-20 | 19:12 | x86      |
| Msdtssrvrutil.dll                              | 2019.150.4043.16 | 111496    | 10-Jun-20 | 19:12 | x64      |
| Msdtssrvrutil.dll                              | 2019.150.4043.16 | 99216     | 10-Jun-20 | 19:12 | x86      |
| Msmgdsrv.dll                                   | 2018.150.34.19   | 8277912   | 10-Jun-20 | 18:57 | x86      |
| Oledbdest.dll                                  | 2019.150.4043.16 | 238472    | 10-Jun-20 | 19:12 | x86      |
| Oledbdest.dll                                  | 2019.150.4043.16 | 279432    | 10-Jun-20 | 19:12 | x64      |
| Oledbsrc.dll                                   | 2019.150.4043.16 | 263048    | 10-Jun-20 | 19:12 | x86      |
| Oledbsrc.dll                                   | 2019.150.4043.16 | 312208    | 10-Jun-20 | 19:12 | x64      |
| Sqlscm.dll                                     | 2019.150.4043.16 | 78728     | 10-Jun-20 | 19:12 | x86      |
| Sqlscm.dll                                     | 2019.150.4043.16 | 86912     | 10-Jun-20 | 19:13 | x64      |
| Sqlsvc.dll                                     | 2019.150.4043.16 | 181128    | 10-Jun-20 | 19:12 | x64      |
| Sqlsvc.dll                                     | 2019.150.4043.16 | 148360    | 10-Jun-20 | 19:13 | x86      |
| Sqltaskconnections.dll                         | 2019.150.4043.16 | 168840    | 10-Jun-20 | 19:12 | x86      |
| Sqltaskconnections.dll                         | 2019.150.4043.16 | 201608    | 10-Jun-20 | 19:12 | x64      |
| Txdataconvert.dll                              | 2019.150.4043.16 | 275336    | 10-Jun-20 | 19:12 | x86      |
| Txdataconvert.dll                              | 2019.150.4043.16 | 316304    | 10-Jun-20 | 19:12 | x64      |
| Xe.dll                                         | 2019.150.4043.16 | 631696    | 10-Jun-20 | 19:12 | x86      |
| Xe.dll                                         | 2019.150.4043.16 | 721800    | 10-Jun-20 | 19:12 | x64      |

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
