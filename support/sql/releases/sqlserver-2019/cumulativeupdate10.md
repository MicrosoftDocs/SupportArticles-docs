---
title: Cumulative update 10 for SQL Server 2019 (KB5001090)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 10 (KB5001090).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5001090
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5001090 - Cumulative Update 10 for SQL Server 2019

_Release Date:_ &nbsp; April 06, 2021  
_Version:_ &nbsp; 15.0.4123.1

## Summary

This article describes Cumulative Update package 10 (CU10) for Microsoft SQL Server 2019. This update contains 40 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 9, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4123.1**, file version: **2019.150.4123.1**
- Analysis Services - Product version: **15.0.34.32**, file version: **2018.150.34.32**

## Known issues in this update

After changes that are related to Scalar UDF Inlining were made in Cumulative Update 9 (CU9) for Microsoft SQL Server 2019, a defect was introduced in the CU 9 and CU 10 updates in which an access violation can occur when an object invokes a scalar inlineable UDF (UDF1) together with a scalar inlineable UDF (UDF2) that's used as an input parameter:

```sql
OBJECT DEFINITION(view/UDF/TVF/procedure)
…
SELECT UDF1(UDF2());
…
```

To mitigate this problem, disable Scalar UDF inlining by using either of the following options:

- Change the definition of UDF2 by adding `WITH INLINE = OFF` to the definition.

- Disable inlining on the database by using `ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = OFF`.

For examples of disabling Scalar UDF inlining, see [Disable Scalar UDF Inlining without changing the compatibility level](/sql/relational-databases/user-defined-functions/scalar-udf-inlining#disable-scalar-udf-inlining-without-changing-the-compatibility-level).

This issue is fixed in [SQL Server 2019 CU11](cumulativeupdate11.md#14066089).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13949609">[13949609](#13949609)</a> | Fixes an issue where `synchronizeSecurity` setting of AMO method '`Microsoft.AnalysisServices.Tabular.Server.Synchronize`' shown in [Server.Synchronize Method](/dotnet/api/microsoft.analysisservices.core.server.synchronize) is ignored. | Analysis Services | Analysis Services | Windows |
| <a id="13957945">[13957945](#13957945)</a> | Fixes an issue with performance when tabular queries in SSAS 2019 take more time to execute compared to SSAS 2016. | Analysis Services | Analysis Services | Windows |
| <a id="13987291">[13987291](#13987291)</a> | Fixes the unexpected date conversion on some special date format. | Master Data Services | Client | Windows |
| <a id="13746935">[13746935](#13746935)</a> | When a VSS backup tries to back up SQL Server databases that are hosted on the forwarder replica of a Distributed Availability Group, the backup operation fails. </br></br>This BACKUP or RESTORE command is not supported on a database mirror or secondary replica. </br>BACKUP DATABASE is terminating abnormally. </br></br>In the error log, you may see the following error: </br></br>\<DateTime> Backup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 3041, Severity: 16, State: 1. </br>\<DateTime> Backup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BACKUP failed to complete the command BACKUP DATABASE \<DatabaseName>. Check the backup application log for detailed messages. | SQL Server Engine | Backup Restore | Windows |
| <a id="13953267">[13953267](#13953267)</a> | [FIX: Assertion failure occurs when Online Clustered Columnstore Index Rebuild reuses truncated hobt instead of new hobt in SQL Server 2019 (KB5001159)](https://support.microsoft.com/help/5001159) | SQL Server Engine | Column Stores | Windows |
| <a id="13880249">[13880249](#13880249)</a> | Query execution may experience an intra-query deadlock if the query plan is using a single threaded batch mode `sort` operator before a Repartition Streams `Parallelism` operator. | SQL Server Engine | Column Stores | Windows |
| <a id="13491008">[13491008](#13491008)</a> | [FIX: Database creation to Azure blob storage from SQL Server 2017 or 2019 on Linux may fail with error (KB4548523)](https://support.microsoft.com/help/4548523) | SQL Server Engine | DB Management | All |
| <a id="13959547">[13959547](#13959547)</a> | Fixes an Access Violation (AV) that occurs when error is being collected for Availability Group (AG) DB Failover while there's an AG failover undergoing. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13965423">[13965423](#13965423)</a> | Fixes an issue where out of memory occurs when you take a log backup frequently and `Stolen Server Memory` grows at a synchronous secondary in Availability Groups. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13980400">[13980400](#13980400)</a> | Fixes the following dump exception after login failures in SQL Server 2019: </br></br>ex_raise2: Unhandled exception raised, major=36, minor=2, state=52, severity=25 | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13959554">[13959554](#13959554)</a> | [FIX: Incorrect results occur when you run query on In-memory optimized table that has clustered columnstore index in SQL Server 2016 or 2019 (KB5000650)](https://support.microsoft.com/help/5000650) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13974729">[13974729](#13974729)</a> | [FIX: Wrong results occur when you run a query on In-memory optimized tables in SQL Server (KB5001044)](https://support.microsoft.com/help/5001044) | SQL Server Engine | In-Memory OLTP | All |
| <a id="13712974">[13712974](#13712974)</a> | Disables FQDNs in AD usernames when creating/modifying SQL Logins/users for SQL Server 2019 on Linux. | SQL Server Engine | Linux | Linux |
| <a id="13717019">[13717019](#13717019)</a> | Fixes an issue where a failed network connection results in a socket leak. | SQL Server Engine | Linux | Linux |
| <a id="13955889">[13955889](#13955889)</a> | Improves AD keytab rotation by properly handling the keytab entries with future KVNOs when SSSD is disabled. | SQL Server Engine | Linux | Linux |
| <a id="13974750">[13974750](#13974750)</a> | [FIX: "Login failed for user" error occurs when you run Maintenance plan with SQL login account in SQL Server (KB4486936)](https://support.microsoft.com/help/4486936) | SQL Server Engine | Management Services | Windows |
| <a id="13771907">[13771907](#13771907)</a> | Allows pushdown of filter predicate for PolyBase query that utilizes `FORMAT` or `TRIM` functions in the `SELECT` clause if the query is otherwise qualified for pushdown. | SQL Server Engine | PolyBase | Windows |
| <a id="13959574">[13959574](#13959574)</a> | Fixes an Access Violation error that can occur when you import large amount of data to Windows Azure Blob storage. This can occur if PolyBase Data Movement Service encounters out-of-memory condition during large data insert transaction. | SQL Server Engine | PolyBase | Windows |
| <a id="13980600">[13980600](#13980600)</a> | Fixes an issue where you notice that spurious `CAST` operations in PolyBase external pushdown queries can dramatically affect the performance with some backends. | SQL Server Engine | PolyBase | All |
| <a id="13959545">[13959545](#13959545)</a> | [FIX: MERGE statement fails with Access Violation at BTreeRow::DisableAccessReleaseOnWait in SQL Server (KB4589350)](https://support.microsoft.com/help/4589350) | SQL Server Engine | Query Execution | Windows |
| <a id="13959551">[13959551](#13959551)</a> </br><a id="13974726">[13974726](#13974726)</a> | [FIX: Wrong results due to undetected concatenation parameters from scalar expression (KB5000649)](https://support.microsoft.com/help/5000649) | SQL Server Engine | Query Execution | All |
| <a id="13912551">[13912551](#13912551)</a> | Fixes to keep '`PERSIST_SAMPLE_PERCENT`' value for statistics on an indexed column after index rebuild. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13972985">[13972985](#13972985)</a> | Fixes an issue where query compilation that involves auto create statistics fails with the following error log: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 3628, Severity: 16, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Database Engine received a floating point exception from the operating system while processing a user request. Try the transaction again. If the problem persists, contact your system administrator. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13959563">[13959563](#13959563)</a> | [FIX: Failures with log reader agent occur when you create and drop publication on CDC enabled database in SQL Server 2016 and 2019 (KB5000715)](https://support.microsoft.com/help/5000715) | SQL Server Engine | Replication | Windows |
| <a id="13959543">[13959543](#13959543)</a> | Fixes an issue with the Foreign Key added to a table that's referencing a table's column which is part of a unique index with included columns. When the table's `ALTER` command is replicated, Distribution Agent fails with the following error message: </br></br>Number of referencing columns in foreign key differs from number of referenced columns, table '\<TableName>'. (Source: MSSQLServer, Error number: 8139) | SQL Server Engine | Replication | Windows |
| <a id="13959560">[13959560](#13959560)</a> | Fixes an issue where the query based on full-text indexes isn't returning the expected values. | SQL Server Engine | Search | Windows |
| <a id="13988916">[13988916](#13988916)</a> | [FIX: Access violation occurs when Dynamic Data Masking and nested UDFs are used in SQL Server 2019 (KB5001526)](https://support.microsoft.com/help/5001526) | SQL Server Engine | Security Infrastructure | All |
| <a id="13988918">[13988918](#13988918)</a> | [FIX: Metadata deadlock causes availability issues when changing auditing properties in SQL Server 2019 (KB5001517)](https://support.microsoft.com/help/5001517) | SQL Server Engine | Security Infrastructure | All |
| <a id="13953270">[13953270](#13953270)</a> | [Improvement: Performance improvements of several spatial built-in properties and methods in SQL Server (KB5001260)](https://support.microsoft.com/help/5001260) | SQL Server Engine | Spatial | All |
| <a id="13979796">[13979796](#13979796)</a> | Fixes an issue in SQL Server 2019 where `kubeadm-prod` install hangs on `compute`/`master` pods when netbios name and `ouDistinguishedName` have mismatch. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13981606">[13981606](#13981606)</a> | SQL Server Service isn't starting and failing with core dump after applying SQL Server 2019 CU8. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13975249">[13975249](#13975249)</a> | [FIX: Access Violation occurs when hybrid buffer pool is enabled in SQL Server 2019 (KB5001266)](https://support.microsoft.com/help/5001266) | SQL Server Engine | SQL OS | All |
| <a id="13947703">[13947703](#13947703)</a> | Fixes an issue that enables Block Caching for `MMLarge` memory model in SQL Server 2019. | SQL Server Engine | SQL OS | All |
| <a id="13959557">[13959557](#13959557)</a> | Improvement: Records stage of failure and error during stack copy for better diagnostics. | SQL Server Engine | SQL OS | All |
| <a id="13974743">[13974743](#13974743)</a> | Fixes a high `HADR_SYNC_COMMIT` waits which may show on SQL Server with heavy workload after you apply CU7. | SQL Server Engine | SQL OS | Linux |
| <a id="13980551">[13980551](#13980551)</a> | SQL Server Service isn't starting and failing with core dump after applying SQL Server 2019 CU8. | SQL Server Engine | SQL OS | Linux |
| <a id="13970216">[13970216](#13970216)</a> | Fixes an issue where `DBCC PAGE` with option `3` generates access violation dumps after dropping a unique identifier column from the table in SQL Server 2019. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Server Engine | Storage Management | Windows |
| <a id="13974728">[13974728](#13974728)</a> | Fixes an issue where performance counter `Data File(s) Size (KB)` doesn't report the correct total size of database files if one file is created with initial size > 4 TB or grown by more than 4 TB. | SQL Server Engine | Storage Management | Windows |
| <a id="13974746">[13974746](#13974746)</a> | Adds a new option to free the `LogPool` cache only: `DBCC FREESYSTEMCACHE('LogPool')`. | SQL Server Engine | Transaction Services | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU10 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2021/04/sqlserver2019-kb5001090-x64_be37187855cc06466f38d4161ba6b9da24f2d2c6.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5001090-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5001090-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5001090-x64.exe| 1564D98CA6FE08DE31E33896CE16BD85F061AA19A9F36EAA97E5B89D34E36718 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.0   | 291744    | 22-Mar-21 | 18:57 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 22-Mar-21 | 18:57 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.0       | 757128    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 174496    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 198536    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 201096    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 197512    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 213896    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 196512    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 192416    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 251272    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 172960    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.0       | 195976    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.0       | 1096608   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.0       | 479624    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 53664     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 58248     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 58272     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 57736     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 60832     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 57248     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 57248     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 66464     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 52640     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.0       | 57248     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16800     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 17800     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16800     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.0       | 16776     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 22-Mar-21 | 18:57 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 22-Mar-21 | 18:57 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 22-Mar-21 | 18:57 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 22-Mar-21 | 18:57 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 22-Mar-21 | 18:57 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 22-Mar-21 | 18:57 | x86      |
| Msmdctr.dll                                               | 2018.150.35.0   | 37256     | 22-Mar-21 | 18:57 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.0   | 66288032  | 22-Mar-21 | 18:57 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.0   | 47781280  | 22-Mar-21 | 18:58 | x86      |
| Msmdpump.dll                                              | 2018.150.35.0   | 10187656  | 22-Mar-21 | 18:57 | x64      |
| Msmdredir.dll                                             | 2018.150.35.0   | 7955848   | 22-Mar-21 | 18:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 15752     | 22-Mar-21 | 18:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 15752     | 22-Mar-21 | 18:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 16264     | 22-Mar-21 | 18:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 15752     | 22-Mar-21 | 18:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 16264     | 22-Mar-21 | 18:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 16288     | 22-Mar-21 | 18:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 16264     | 22-Mar-21 | 18:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 17288     | 22-Mar-21 | 18:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 15752     | 22-Mar-21 | 18:58 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.0       | 15752     | 22-Mar-21 | 18:57 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.0   | 65824160  | 22-Mar-21 | 18:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 832392    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1627016   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1452960   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1641864   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1607584   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1000352   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 991136    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1535880   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1520520   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 809864    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.0   | 1595272   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 831392    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1623456   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1449864   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1636744   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1603464   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 997792    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 990112    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1531784   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1516960   | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 808840    | 22-Mar-21 | 18:58 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.0   | 1590688   | 22-Mar-21 | 18:58 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.0   | 10185120  | 22-Mar-21 | 18:57 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.0   | 8277920   | 22-Mar-21 | 18:58 | x86      |
| Msolap.dll                                                | 2018.150.35.0   | 11014560  | 22-Mar-21 | 18:57 | x64      |
| Msolap.dll                                                | 2018.150.35.0   | 8607136   | 22-Mar-21 | 18:58 | x86      |
| Msolui.dll                                                | 2018.150.35.0   | 305568    | 22-Mar-21 | 18:57 | x64      |
| Msolui.dll                                                | 2018.150.35.0   | 285064    | 22-Mar-21 | 18:58 | x86      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 22-Mar-21 | 18:58 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 22-Mar-21 | 18:58 | x64      |
| Sqlboot.dll                                               | 2019.150.4123.1 | 213904    | 22-Mar-21 | 18:57 | x64      |
| Sqlceip.exe                                               | 15.0.4123.1     | 283520    | 22-Mar-21 | 18:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4123.1 | 152480    | 22-Mar-21 | 18:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4123.1 | 185248    | 22-Mar-21 | 18:57 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 22-Mar-21 | 18:58 | x86      |
| Tmapi.dll                                                 | 2018.150.35.0   | 6177160   | 22-Mar-21 | 18:58 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.0   | 4916616   | 22-Mar-21 | 18:58 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.0   | 1183648   | 22-Mar-21 | 18:58 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.0   | 6802336   | 22-Mar-21 | 18:58 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.0   | 26024328  | 22-Mar-21 | 18:58 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.0   | 35459464  | 22-Mar-21 | 18:58 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4123.1 | 74640     | 22-Mar-21 | 18:51 | x86      |
| Instapi150.dll                       | 2019.150.4123.1 | 86928     | 22-Mar-21 | 18:51 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4123.1 | 86912     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4123.1 | 99216     | 22-Mar-21 | 18:57 | x64      |
| Msasxpress.dll                       | 2018.150.35.0   | 31136     | 22-Mar-21 | 18:51 | x64      |
| Msasxpress.dll                       | 2018.150.35.0   | 25992     | 22-Mar-21 | 18:51 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4123.1 | 74640     | 22-Mar-21 | 18:57 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4123.1 | 86944     | 22-Mar-21 | 18:57 | x64      |
| Sqldumper.exe                        | 2019.150.4123.1 | 152480    | 22-Mar-21 | 18:51 | x86      |
| Sqldumper.exe                        | 2019.150.4123.1 | 185248    | 22-Mar-21 | 18:51 | x64      |
| Sqlftacct.dll                        | 2019.150.4123.1 | 58256     | 22-Mar-21 | 18:57 | x86      |
| Sqlftacct.dll                        | 2019.150.4123.1 | 78720     | 22-Mar-21 | 18:57 | x64      |
| Sqlmanager.dll                       | 2019.150.4123.1 | 742288    | 22-Mar-21 | 18:57 | x86      |
| Sqlmanager.dll                       | 2019.150.4123.1 | 877456    | 22-Mar-21 | 18:57 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4123.1 | 377728    | 22-Mar-21 | 18:57 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4123.1 | 431008    | 22-Mar-21 | 18:57 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4123.1 | 275344    | 22-Mar-21 | 18:57 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4123.1 | 357264    | 22-Mar-21 | 18:57 | x64      |
| Svrenumapi150.dll                    | 2019.150.4123.1 | 1160080   | 22-Mar-21 | 18:57 | x64      |
| Svrenumapi150.dll                    | 2019.150.4123.1 | 910224    | 22-Mar-21 | 18:57 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4123.1 | 136080    | 22-Mar-21 | 18:58 | x86      |
| Dreplaycommon.dll     | 2019.150.4123.1 | 665488    | 22-Mar-21 | 18:58 | x86      |
| Dreplayutil.dll       | 2019.150.4123.1 | 304000    | 22-Mar-21 | 18:58 | x86      |
| Instapi150.dll        | 2019.150.4123.1 | 86928     | 22-Mar-21 | 18:55 | x64      |
| Sqlresourceloader.dll | 2019.150.4123.1 | 37760     | 22-Mar-21 | 18:58 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4123.1 | 665488    | 22-Mar-21 | 18:57 | x86      |
| Dreplaycontroller.exe | 2019.150.4123.1 | 365456    | 22-Mar-21 | 18:57 | x86      |
| Instapi150.dll        | 2019.150.4123.1 | 86928     | 22-Mar-21 | 18:51 | x64      |
| Sqlresourceloader.dll | 2019.150.4123.1 | 37760     | 22-Mar-21 | 18:57 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4123.1 | 4657024   | 22-Mar-21 | 20:05 | x64      |
| Aetm-enclave.dll                           | 2019.150.4123.1 | 4611464   | 22-Mar-21 | 20:05 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4123.1 | 4931336   | 22-Mar-21 | 20:05 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4123.1 | 4871976   | 22-Mar-21 | 20:05 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 22-Mar-21 | 18:51 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 22-Mar-21 | 18:51 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 22-Mar-21 | 20:05 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 22-Mar-21 | 20:05 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 22-Mar-21 | 20:05 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 22-Mar-21 | 20:05 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4123.1 | 279456    | 22-Mar-21 | 20:05 | x64      |
| Dcexec.exe                                 | 2019.150.4123.1 | 86912     | 22-Mar-21 | 20:05 | x64      |
| Fssres.dll                                 | 2019.150.4123.1 | 95136     | 22-Mar-21 | 20:05 | x64      |
| Hadrres.dll                                | 2019.150.4123.1 | 201632    | 22-Mar-21 | 20:05 | x64      |
| Hkcompile.dll                              | 2019.150.4123.1 | 1291168   | 22-Mar-21 | 20:05 | x64      |
| Hkengine.dll                               | 2019.150.4123.1 | 5784464   | 22-Mar-21 | 20:05 | x64      |
| Hkruntime.dll                              | 2019.150.4123.1 | 181120    | 22-Mar-21 | 20:05 | x64      |
| Hktempdb.dll                               | 2019.150.4123.1 | 62336     | 22-Mar-21 | 20:05 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 22-Mar-21 | 20:05 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4123.1     | 234400    | 22-Mar-21 | 20:05 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4123.1 | 324480    | 22-Mar-21 | 20:05 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4123.1 | 91008     | 22-Mar-21 | 20:05 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 22-Mar-21 | 20:05 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 22-Mar-21 | 20:05 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 22-Mar-21 | 20:05 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 22-Mar-21 | 20:05 | x64      |
| Qds.dll                                    | 2019.150.4123.1 | 1184656   | 22-Mar-21 | 20:05 | x64      |
| Rsfxft.dll                                 | 2019.150.4123.1 | 50048     | 22-Mar-21 | 20:05 | x64      |
| Secforwarder.dll                           | 2019.150.4123.1 | 78752     | 22-Mar-21 | 20:05 | x64      |
| Sqagtres.dll                               | 2019.150.4123.1 | 86912     | 22-Mar-21 | 20:05 | x64      |
| Sqlaamss.dll                               | 2019.150.4123.1 | 107424    | 22-Mar-21 | 20:05 | x64      |
| Sqlaccess.dll                              | 2019.150.4123.1 | 492432    | 22-Mar-21 | 20:05 | x64      |
| Sqlagent.exe                               | 2019.150.4123.1 | 730016    | 22-Mar-21 | 20:05 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4123.1 | 66432     | 22-Mar-21 | 20:05 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4123.1 | 78752     | 22-Mar-21 | 20:05 | x64      |
| Sqlboot.dll                                | 2019.150.4123.1 | 213904    | 22-Mar-21 | 20:05 | x64      |
| Sqlceip.exe                                | 15.0.4123.1     | 283520    | 22-Mar-21 | 20:05 | x86      |
| Sqlcmdss.dll                               | 2019.150.4123.1 | 86928     | 22-Mar-21 | 20:05 | x64      |
| Sqlctr150.dll                              | 2019.150.4123.1 | 115600    | 22-Mar-21 | 20:05 | x86      |
| Sqlctr150.dll                              | 2019.150.4123.1 | 140160    | 22-Mar-21 | 20:05 | x64      |
| Sqldk.dll                                  | 2019.150.4123.1 | 3150720   | 22-Mar-21 | 20:05 | x64      |
| Sqldtsss.dll                               | 2019.150.4123.1 | 107408    | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 1590144   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3490688   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3687296   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4150144   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4268928   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3404672   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3568512   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4146048   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3998592   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4051840   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 2216832   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 2163584   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3859328   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3535744   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4002688   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3810176   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3806080   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3601280   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3490688   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 1532800   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 3896192   | 22-Mar-21 | 20:05 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4123.1 | 4014976   | 22-Mar-21 | 20:05 | x64      |
| Sqllang.dll                                | 2019.150.4123.1 | 39920528  | 22-Mar-21 | 20:05 | x64      |
| Sqlmin.dll                                 | 2019.150.4123.1 | 40432016  | 22-Mar-21 | 20:05 | x64      |
| Sqlolapss.dll                              | 2019.150.4123.1 | 103328    | 22-Mar-21 | 20:05 | x64      |
| Sqlos.dll                                  | 2019.150.4123.1 | 41888     | 22-Mar-21 | 20:05 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4123.1 | 82832     | 22-Mar-21 | 20:05 | x64      |
| Sqlrepss.dll                               | 2019.150.4123.1 | 82848     | 22-Mar-21 | 20:05 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4123.1 | 50080     | 22-Mar-21 | 19:27 | x64      |
| Sqlscm.dll                                 | 2019.150.4123.1 | 86912     | 22-Mar-21 | 19:27 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4123.1 | 37760     | 22-Mar-21 | 20:05 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4123.1 | 5804928   | 22-Mar-21 | 20:05 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4123.1 | 672672    | 22-Mar-21 | 20:05 | x64      |
| Sqlservr.exe                               | 2019.150.4123.1 | 627584    | 22-Mar-21 | 20:05 | x64      |
| Sqlsvc.dll                                 | 2019.150.4123.1 | 181120    | 22-Mar-21 | 19:27 | x64      |
| Sqltses.dll                                | 2019.150.4123.1 | 9081760   | 22-Mar-21 | 20:05 | x64      |
| Sqsrvres.dll                               | 2019.150.4123.1 | 279440    | 22-Mar-21 | 20:05 | x64      |
| Svl.dll                                    | 2019.150.4123.1 | 160672    | 22-Mar-21 | 20:05 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 22-Mar-21 | 20:05 | x64      |
| Xe.dll                                     | 2019.150.4123.1 | 721808    | 22-Mar-21 | 19:27 | x64      |
| Xpadsi.exe                                 | 2019.150.4123.1 | 115584    | 22-Mar-21 | 20:05 | x64      |
| Xplog70.dll                                | 2019.150.4123.1 | 91024     | 22-Mar-21 | 20:05 | x64      |
| Xprepl.dll                                 | 2019.150.4123.1 | 119712    | 22-Mar-21 | 20:05 | x64      |
| Xpstar.dll                                 | 2019.150.4123.1 | 471952    | 22-Mar-21 | 20:05 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4123.1 | 263040    | 22-Mar-21 | 18:58 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4123.1 | 230288    | 22-Mar-21 | 18:58 | x64      |
| Distrib.exe                                                  | 2019.150.4123.1 | 234384    | 22-Mar-21 | 18:57 | x64      |
| Dteparse.dll                                                 | 2019.150.4123.1 | 123776    | 22-Mar-21 | 18:57 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4123.1 | 131968    | 22-Mar-21 | 18:58 | x64      |
| Dtepkg.dll                                                   | 2019.150.4123.1 | 148352    | 22-Mar-21 | 18:58 | x64      |
| Dtexec.exe                                                   | 2019.150.4123.1 | 71568     | 22-Mar-21 | 18:57 | x64      |
| Dts.dll                                                      | 2019.150.4123.1 | 3142544   | 22-Mar-21 | 18:58 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4123.1 | 500624    | 22-Mar-21 | 18:58 | x64      |
| Dtsconn.dll                                                  | 2019.150.4123.1 | 521088    | 22-Mar-21 | 18:58 | x64      |
| Dtshost.exe                                                  | 2019.150.4123.1 | 104336    | 22-Mar-21 | 18:58 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4123.1 | 566160    | 22-Mar-21 | 18:58 | x64      |
| Dtspipeline.dll                                              | 2019.150.4123.1 | 1328032   | 22-Mar-21 | 18:58 | x64      |
| Dtswizard.exe                                                | 15.0.4123.1     | 885664    | 22-Mar-21 | 18:58 | x64      |
| Dtuparse.dll                                                 | 2019.150.4123.1 | 99216     | 22-Mar-21 | 18:58 | x64      |
| Dtutil.exe                                                   | 2019.150.4123.1 | 147328    | 22-Mar-21 | 18:58 | x64      |
| Exceldest.dll                                                | 2019.150.4123.1 | 279424    | 22-Mar-21 | 18:58 | x64      |
| Excelsrc.dll                                                 | 2019.150.4123.1 | 308112    | 22-Mar-21 | 18:58 | x64      |
| Execpackagetask.dll                                          | 2019.150.4123.1 | 185216    | 22-Mar-21 | 18:58 | x64      |
| Flatfiledest.dll                                             | 2019.150.4123.1 | 410496    | 22-Mar-21 | 18:58 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4123.1 | 426896    | 22-Mar-21 | 18:58 | x64      |
| Logread.exe                                                  | 2019.150.4123.1 | 717728    | 22-Mar-21 | 18:57 | x64      |
| Mergetxt.dll                                                 | 2019.150.4123.1 | 74624     | 22-Mar-21 | 18:57 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4123.1     | 58272     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4123.1     | 41856     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4123.1     | 390048    | 22-Mar-21 | 18:58 | x86      |
| Microsoft.sqlserver.xmltask.dll                              | 15.0.4123.1     | 156560    | 22-Mar-21 | 18:58 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4123.1 | 111504    | 22-Mar-21 | 18:58 | x64      |
| Msgprox.dll                                                  | 2019.150.4123.1 | 299904    | 22-Mar-21 | 18:57 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 22-Mar-21 | 18:57 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4123.1 | 1495936   | 22-Mar-21 | 18:57 | x64      |
| Oledbdest.dll                                                | 2019.150.4123.1 | 279424    | 22-Mar-21 | 18:58 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4123.1 | 312192    | 22-Mar-21 | 18:58 | x64      |
| Osql.exe                                                     | 2019.150.4123.1 | 91024     | 22-Mar-21 | 18:57 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4123.1 | 496528    | 22-Mar-21 | 18:57 | x64      |
| Rawdest.dll                                                  | 2019.150.4123.1 | 226176    | 22-Mar-21 | 18:58 | x64      |
| Rawsource.dll                                                | 2019.150.4123.1 | 209792    | 22-Mar-21 | 18:58 | x64      |
| Rdistcom.dll                                                 | 2019.150.4123.1 | 914320    | 22-Mar-21 | 18:57 | x64      |
| Recordsetdest.dll                                            | 2019.150.4123.1 | 201616    | 22-Mar-21 | 18:58 | x64      |
| Repldp.dll                                                   | 2019.150.4123.1 | 312208    | 22-Mar-21 | 18:57 | x64      |
| Replerrx.dll                                                 | 2019.150.4123.1 | 181120    | 22-Mar-21 | 18:57 | x64      |
| Replisapi.dll                                                | 2019.150.4123.1 | 394112    | 22-Mar-21 | 18:57 | x64      |
| Replmerg.exe                                                 | 2019.150.4123.1 | 562048    | 22-Mar-21 | 18:57 | x64      |
| Replprov.dll                                                 | 2019.150.4123.1 | 852864    | 22-Mar-21 | 18:57 | x64      |
| Replrec.dll                                                  | 2019.150.4123.1 | 1028992   | 22-Mar-21 | 18:57 | x64      |
| Replsub.dll                                                  | 2019.150.4123.1 | 471936    | 22-Mar-21 | 18:57 | x64      |
| Replsync.dll                                                 | 2019.150.4123.1 | 164768    | 22-Mar-21 | 18:57 | x64      |
| Spresolv.dll                                                 | 2019.150.4123.1 | 275328    | 22-Mar-21 | 18:57 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4123.1 | 263040    | 22-Mar-21 | 18:57 | x64      |
| Sqldiag.exe                                                  | 2019.150.4123.1 | 1139600   | 22-Mar-21 | 18:58 | x64      |
| Sqldistx.dll                                                 | 2019.150.4123.1 | 246672    | 22-Mar-21 | 18:57 | x64      |
| Sqllogship.exe                                               | 15.0.4123.1     | 103312    | 22-Mar-21 | 18:57 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4123.1 | 398208    | 22-Mar-21 | 18:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4123.1 | 50080     | 22-Mar-21 | 18:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4123.1 | 37760     | 22-Mar-21 | 18:58 | x86      |
| Sqlscm.dll                                                   | 2019.150.4123.1 | 78720     | 22-Mar-21 | 18:57 | x86      |
| Sqlscm.dll                                                   | 2019.150.4123.1 | 86912     | 22-Mar-21 | 18:57 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4123.1 | 148352    | 22-Mar-21 | 18:57 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4123.1 | 181120    | 22-Mar-21 | 18:57 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4123.1 | 205696    | 22-Mar-21 | 18:58 | x64      |
| Ssradd.dll                                                   | 2019.150.4123.1 | 82816     | 22-Mar-21 | 18:57 | x64      |
| Ssravg.dll                                                   | 2019.150.4123.1 | 82832     | 22-Mar-21 | 18:57 | x64      |
| Ssrdown.dll                                                  | 2019.150.4123.1 | 74640     | 22-Mar-21 | 18:57 | x64      |
| Ssrmax.dll                                                   | 2019.150.4123.1 | 82816     | 22-Mar-21 | 18:57 | x64      |
| Ssrmin.dll                                                   | 2019.150.4123.1 | 82816     | 22-Mar-21 | 18:57 | x64      |
| Ssrpub.dll                                                   | 2019.150.4123.1 | 74640     | 22-Mar-21 | 18:57 | x64      |
| Ssrup.dll                                                    | 2019.150.4123.1 | 74640     | 22-Mar-21 | 18:57 | x64      |
| Txagg.dll                                                    | 2019.150.4123.1 | 390016    | 22-Mar-21 | 18:58 | x64      |
| Txbdd.dll                                                    | 2019.150.4123.1 | 189328    | 22-Mar-21 | 18:58 | x64      |
| Txdatacollector.dll                                          | 2019.150.4123.1 | 471936    | 22-Mar-21 | 18:58 | x64      |
| Txdataconvert.dll                                            | 2019.150.4123.1 | 316288    | 22-Mar-21 | 18:58 | x64      |
| Txderived.dll                                                | 2019.150.4123.1 | 639872    | 22-Mar-21 | 18:58 | x64      |
| Txlookup.dll                                                 | 2019.150.4123.1 | 541568    | 22-Mar-21 | 18:58 | x64      |
| Txmerge.dll                                                  | 2019.150.4123.1 | 258944    | 22-Mar-21 | 18:58 | x64      |
| Txmergejoin.dll                                              | 2019.150.4123.1 | 308112    | 22-Mar-21 | 18:58 | x64      |
| Txmulticast.dll                                              | 2019.150.4123.1 | 148352    | 22-Mar-21 | 18:58 | x64      |
| Txrowcount.dll                                               | 2019.150.4123.1 | 140160    | 22-Mar-21 | 18:58 | x64      |
| Txsort.dll                                                   | 2019.150.4123.1 | 287616    | 22-Mar-21 | 18:58 | x64      |
| Txsplit.dll                                                  | 2019.150.4123.1 | 623504    | 22-Mar-21 | 18:58 | x64      |
| Txunionall.dll                                               | 2019.150.4123.1 | 205696    | 22-Mar-21 | 18:58 | x64      |
| Xe.dll                                                       | 2019.150.4123.1 | 721808    | 22-Mar-21 | 18:58 | x64      |
| Xmlsub.dll                                                   | 2019.150.4123.1 | 295808    | 22-Mar-21 | 18:57 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4123.1 | 91040     | 22-Mar-21 | 18:57 | x64      |
| Exthost.exe        | 2019.150.4123.1 | 238496    | 22-Mar-21 | 18:57 | x64      |
| Launchpad.exe      | 2019.150.4123.1 | 1217424   | 22-Mar-21 | 18:57 | x64      |
| Sqlsatellite.dll   | 2019.150.4123.1 | 1016704   | 22-Mar-21 | 18:57 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4123.1 | 684944    | 22-Mar-21 | 18:57 | x64      |
| Fdhost.exe     | 2019.150.4123.1 | 127888    | 22-Mar-21 | 18:57 | x64      |
| Fdlauncher.exe | 2019.150.4123.1 | 78752     | 22-Mar-21 | 18:57 | x64      |
| Sqlft150ph.dll | 2019.150.4123.1 | 91024     | 22-Mar-21 | 18:57 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4123.1  | 29568     | 22-Mar-21 | 18:57 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4123.1 | 226208    | 22-Mar-21 | 18:57 | x86      |
| Commanddest.dll                                               | 2019.150.4123.1 | 263040    | 22-Mar-21 | 18:57 | x64      |
| Dteparse.dll                                                  | 2019.150.4123.1 | 111488    | 22-Mar-21 | 18:57 | x86      |
| Dteparse.dll                                                  | 2019.150.4123.1 | 123776    | 22-Mar-21 | 18:57 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4123.1 | 115584    | 22-Mar-21 | 18:57 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4123.1 | 131968    | 22-Mar-21 | 18:57 | x64      |
| Dtepkg.dll                                                    | 2019.150.4123.1 | 131968    | 22-Mar-21 | 18:57 | x86      |
| Dtepkg.dll                                                    | 2019.150.4123.1 | 148352    | 22-Mar-21 | 18:57 | x64      |
| Dtexec.exe                                                    | 2019.150.4123.1 | 62848     | 22-Mar-21 | 18:57 | x86      |
| Dtexec.exe                                                    | 2019.150.4123.1 | 71568     | 22-Mar-21 | 18:57 | x64      |
| Dts.dll                                                       | 2019.150.4123.1 | 2761600   | 22-Mar-21 | 18:57 | x86      |
| Dts.dll                                                       | 2019.150.4123.1 | 3142544   | 22-Mar-21 | 18:57 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4123.1 | 443264    | 22-Mar-21 | 18:57 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4123.1 | 500624    | 22-Mar-21 | 18:57 | x64      |
| Dtsconn.dll                                                   | 2019.150.4123.1 | 431008    | 22-Mar-21 | 18:57 | x86      |
| Dtsconn.dll                                                   | 2019.150.4123.1 | 521088    | 22-Mar-21 | 18:57 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4123.1 | 110976    | 22-Mar-21 | 18:57 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4123.1 | 92576     | 22-Mar-21 | 18:57 | x86      |
| Dtshost.exe                                                   | 2019.150.4123.1 | 104336    | 22-Mar-21 | 18:57 | x64      |
| Dtshost.exe                                                   | 2019.150.4123.1 | 87456     | 22-Mar-21 | 18:57 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4123.1 | 553888    | 22-Mar-21 | 18:57 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4123.1 | 566160    | 22-Mar-21 | 18:57 | x64      |
| Dtspipeline.dll                                               | 2019.150.4123.1 | 1119136   | 22-Mar-21 | 18:57 | x86      |
| Dtspipeline.dll                                               | 2019.150.4123.1 | 1328032   | 22-Mar-21 | 18:57 | x64      |
| Dtswizard.exe                                                 | 15.0.4123.1     | 885664    | 22-Mar-21 | 18:57 | x64      |
| Dtswizard.exe                                                 | 15.0.4123.1     | 889728    | 22-Mar-21 | 18:57 | x86      |
| Dtuparse.dll                                                  | 2019.150.4123.1 | 86912     | 22-Mar-21 | 18:57 | x86      |
| Dtuparse.dll                                                  | 2019.150.4123.1 | 99216     | 22-Mar-21 | 18:57 | x64      |
| Dtutil.exe                                                    | 2019.150.4123.1 | 128928    | 22-Mar-21 | 18:57 | x86      |
| Dtutil.exe                                                    | 2019.150.4123.1 | 147328    | 22-Mar-21 | 18:57 | x64      |
| Exceldest.dll                                                 | 2019.150.4123.1 | 234400    | 22-Mar-21 | 18:57 | x86      |
| Exceldest.dll                                                 | 2019.150.4123.1 | 279424    | 22-Mar-21 | 18:57 | x64      |
| Excelsrc.dll                                                  | 2019.150.4123.1 | 258944    | 22-Mar-21 | 18:57 | x86      |
| Excelsrc.dll                                                  | 2019.150.4123.1 | 308112    | 22-Mar-21 | 18:57 | x64      |
| Execpackagetask.dll                                           | 2019.150.4123.1 | 148384    | 22-Mar-21 | 18:57 | x86      |
| Execpackagetask.dll                                           | 2019.150.4123.1 | 185216    | 22-Mar-21 | 18:57 | x64      |
| Flatfiledest.dll                                              | 2019.150.4123.1 | 357280    | 22-Mar-21 | 18:57 | x86      |
| Flatfiledest.dll                                              | 2019.150.4123.1 | 410496    | 22-Mar-21 | 18:57 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4123.1 | 369568    | 22-Mar-21 | 18:57 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4123.1 | 426896    | 22-Mar-21 | 18:57 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4123.1     | 119696    | 22-Mar-21 | 18:57 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4123.1     | 119696    | 22-Mar-21 | 18:57 | x86      |
| Isserverexec.exe                                              | 15.0.4123.1     | 144272    | 22-Mar-21 | 18:57 | x64      |
| Isserverexec.exe                                              | 15.0.4123.1     | 148368    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4123.1     | 78752     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4123.1     | 58256     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4123.1     | 58272     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4123.1     | 508800    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4123.1     | 508816    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4123.1     | 41856     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4123.1     | 41856     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4123.1     | 390048    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4123.1     | 58240     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4123.1     | 58272     | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4123.1     | 140176    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4123.1     | 140192    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4123.1     | 156560    | 22-Mar-21 | 18:57 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4123.1     | 156576    | 22-Mar-21 | 18:57 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4123.1     | 218016    | 22-Mar-21 | 18:57 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4123.1 | 111504    | 22-Mar-21 | 18:57 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4123.1 | 99232     | 22-Mar-21 | 18:57 | x86      |
| Msmdpp.dll                                                    | 2018.150.35.0   | 10062240  | 22-Mar-21 | 18:51 | x64      |
| Odbcdest.dll                                                  | 2019.150.4123.1 | 316304    | 22-Mar-21 | 18:57 | x86      |
| Odbcdest.dll                                                  | 2019.150.4123.1 | 369536    | 22-Mar-21 | 18:57 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4123.1 | 328592    | 22-Mar-21 | 18:57 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4123.1 | 381824    | 22-Mar-21 | 18:57 | x64      |
| Oledbdest.dll                                                 | 2019.150.4123.1 | 238496    | 22-Mar-21 | 18:57 | x86      |
| Oledbdest.dll                                                 | 2019.150.4123.1 | 279424    | 22-Mar-21 | 18:57 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4123.1 | 263056    | 22-Mar-21 | 18:57 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4123.1 | 312192    | 22-Mar-21 | 18:57 | x64      |
| Rawdest.dll                                                   | 2019.150.4123.1 | 189336    | 22-Mar-21 | 18:57 | x86      |
| Rawdest.dll                                                   | 2019.150.4123.1 | 226176    | 22-Mar-21 | 18:57 | x64      |
| Rawsource.dll                                                 | 2019.150.4123.1 | 177056    | 22-Mar-21 | 18:57 | x86      |
| Rawsource.dll                                                 | 2019.150.4123.1 | 209792    | 22-Mar-21 | 18:57 | x64      |
| Recordsetdest.dll                                             | 2019.150.4123.1 | 172960    | 22-Mar-21 | 18:57 | x86      |
| Recordsetdest.dll                                             | 2019.150.4123.1 | 201616    | 22-Mar-21 | 18:57 | x64      |
| Sqlceip.exe                                                   | 15.0.4123.1     | 283520    | 22-Mar-21 | 18:57 | x86      |
| Sqldest.dll                                                   | 2019.150.4123.1 | 238488    | 22-Mar-21 | 18:57 | x86      |
| Sqldest.dll                                                   | 2019.150.4123.1 | 275344    | 22-Mar-21 | 18:57 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4123.1 | 168832    | 22-Mar-21 | 18:57 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4123.1 | 205696    | 22-Mar-21 | 18:57 | x64      |
| Txagg.dll                                                     | 2019.150.4123.1 | 328576    | 22-Mar-21 | 18:57 | x86      |
| Txagg.dll                                                     | 2019.150.4123.1 | 390016    | 22-Mar-21 | 18:57 | x64      |
| Txbdd.dll                                                     | 2019.150.4123.1 | 152448    | 22-Mar-21 | 18:57 | x86      |
| Txbdd.dll                                                     | 2019.150.4123.1 | 189328    | 22-Mar-21 | 18:57 | x64      |
| Txbestmatch.dll                                               | 2019.150.4123.1 | 545664    | 22-Mar-21 | 18:57 | x86      |
| Txbestmatch.dll                                               | 2019.150.4123.1 | 652176    | 22-Mar-21 | 18:57 | x64      |
| Txcache.dll                                                   | 2019.150.4123.1 | 164768    | 22-Mar-21 | 18:57 | x86      |
| Txcache.dll                                                   | 2019.150.4123.1 | 197520    | 22-Mar-21 | 18:57 | x64      |
| Txcharmap.dll                                                 | 2019.150.4123.1 | 271264    | 22-Mar-21 | 18:57 | x86      |
| Txcharmap.dll                                                 | 2019.150.4123.1 | 312192    | 22-Mar-21 | 18:57 | x64      |
| Txcopymap.dll                                                 | 2019.150.4123.1 | 164768    | 22-Mar-21 | 18:57 | x86      |
| Txcopymap.dll                                                 | 2019.150.4123.1 | 201600    | 22-Mar-21 | 18:57 | x64      |
| Txdataconvert.dll                                             | 2019.150.4123.1 | 275360    | 22-Mar-21 | 18:57 | x86      |
| Txdataconvert.dll                                             | 2019.150.4123.1 | 316288    | 22-Mar-21 | 18:57 | x64      |
| Txderived.dll                                                 | 2019.150.4123.1 | 557984    | 22-Mar-21 | 18:57 | x86      |
| Txderived.dll                                                 | 2019.150.4123.1 | 639872    | 22-Mar-21 | 18:57 | x64      |
| Txfileextractor.dll                                           | 2019.150.4123.1 | 181152    | 22-Mar-21 | 18:57 | x86      |
| Txfileextractor.dll                                           | 2019.150.4123.1 | 217984    | 22-Mar-21 | 18:57 | x64      |
| Txfileinserter.dll                                            | 2019.150.4123.1 | 213888    | 22-Mar-21 | 18:57 | x64      |
| Txfileinserter.dll                                            | 2019.150.4123.1 | 181120    | 22-Mar-21 | 18:57 | x86      |
| Txgroupdups.dll                                               | 2019.150.4123.1 | 254880    | 22-Mar-21 | 18:57 | x86      |
| Txgroupdups.dll                                               | 2019.150.4123.1 | 312208    | 22-Mar-21 | 18:57 | x64      |
| Txlineage.dll                                                 | 2019.150.4123.1 | 127904    | 22-Mar-21 | 18:57 | x86      |
| Txlineage.dll                                                 | 2019.150.4123.1 | 152464    | 22-Mar-21 | 18:57 | x64      |
| Txlookup.dll                                                  | 2019.150.4123.1 | 467872    | 22-Mar-21 | 18:57 | x86      |
| Txlookup.dll                                                  | 2019.150.4123.1 | 541568    | 22-Mar-21 | 18:57 | x64      |
| Txmerge.dll                                                   | 2019.150.4123.1 | 258944    | 22-Mar-21 | 18:57 | x64      |
| Txmerge.dll                                                   | 2019.150.4123.1 | 201600    | 22-Mar-21 | 18:57 | x86      |
| Txmergejoin.dll                                               | 2019.150.4123.1 | 308112    | 22-Mar-21 | 18:57 | x64      |
| Txmergejoin.dll                                               | 2019.150.4123.1 | 246656    | 22-Mar-21 | 18:57 | x86      |
| Txmulticast.dll                                               | 2019.150.4123.1 | 148352    | 22-Mar-21 | 18:57 | x64      |
| Txmulticast.dll                                               | 2019.150.4123.1 | 115616    | 22-Mar-21 | 18:57 | x86      |
| Txpivot.dll                                                   | 2019.150.4123.1 | 205728    | 22-Mar-21 | 18:57 | x86      |
| Txpivot.dll                                                   | 2019.150.4123.1 | 238464    | 22-Mar-21 | 18:57 | x64      |
| Txrowcount.dll                                                | 2019.150.4123.1 | 140160    | 22-Mar-21 | 18:57 | x64      |
| Txrowcount.dll                                                | 2019.150.4123.1 | 111520    | 22-Mar-21 | 18:57 | x86      |
| Txsampling.dll                                                | 2019.150.4123.1 | 160672    | 22-Mar-21 | 18:57 | x86      |
| Txsampling.dll                                                | 2019.150.4123.1 | 193424    | 22-Mar-21 | 18:57 | x64      |
| Txscd.dll                                                     | 2019.150.4123.1 | 197504    | 22-Mar-21 | 18:57 | x86      |
| Txscd.dll                                                     | 2019.150.4123.1 | 234368    | 22-Mar-21 | 18:57 | x64      |
| Txsort.dll                                                    | 2019.150.4123.1 | 287616    | 22-Mar-21 | 18:57 | x64      |
| Txsort.dll                                                    | 2019.150.4123.1 | 230304    | 22-Mar-21 | 18:57 | x86      |
| Txsplit.dll                                                   | 2019.150.4123.1 | 549792    | 22-Mar-21 | 18:57 | x86      |
| Txsplit.dll                                                   | 2019.150.4123.1 | 623504    | 22-Mar-21 | 18:57 | x64      |
| Txtermextraction.dll                                          | 2019.150.4123.1 | 8643456   | 22-Mar-21 | 18:57 | x86      |
| Txtermextraction.dll                                          | 2019.150.4123.1 | 8700800   | 22-Mar-21 | 18:57 | x64      |
| Txtermlookup.dll                                              | 2019.150.4123.1 | 4182912   | 22-Mar-21 | 18:57 | x64      |
| Txtermlookup.dll                                              | 2019.150.4123.1 | 4137856   | 22-Mar-21 | 18:57 | x86      |
| Txunionall.dll                                                | 2019.150.4123.1 | 205696    | 22-Mar-21 | 18:57 | x64      |
| Txunionall.dll                                                | 2019.150.4123.1 | 160672    | 22-Mar-21 | 18:57 | x86      |
| Txunpivot.dll                                                 | 2019.150.4123.1 | 181120    | 22-Mar-21 | 18:57 | x86      |
| Txunpivot.dll                                                 | 2019.150.4123.1 | 213904    | 22-Mar-21 | 18:57 | x64      |
| Xe.dll                                                        | 2019.150.4123.1 | 631696    | 22-Mar-21 | 18:57 | x86      |
| Xe.dll                                                        | 2019.150.4123.1 | 721808    | 22-Mar-21 | 18:57 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1914.0     | 552336    | 22-Mar-21 | 19:40 | x86      |
| Dmsnative.dll                                                        | 2018.150.1914.0 | 145832    | 22-Mar-21 | 19:40 | x64      |
| Dwengineservice.dll                                                  | 15.0.1914.0     | 43920     | 22-Mar-21 | 19:40 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 22-Mar-21 | 19:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 22-Mar-21 | 19:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 22-Mar-21 | 19:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 22-Mar-21 | 19:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 22-Mar-21 | 19:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 22-Mar-21 | 19:40 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 22-Mar-21 | 19:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 22-Mar-21 | 19:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 22-Mar-21 | 19:40 | x64      |
| Instapi150.dll                                                       | 2019.150.4123.1 | 86928     | 22-Mar-21 | 19:40 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 22-Mar-21 | 19:40 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 22-Mar-21 | 19:40 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 22-Mar-21 | 19:40 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 22-Mar-21 | 19:40 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 22-Mar-21 | 19:40 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1914.0     | 66472     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1914.0     | 292264    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1914.0     | 1954704   | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1914.0     | 168360    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1914.0     | 640936    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1914.0     | 245136    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1914.0     | 138152    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1914.0     | 78760     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1914.0     | 50088     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1914.0     | 87464     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1914.0     | 1128872   | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1914.0     | 79784     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1914.0     | 69520     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1914.0     | 34216     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1914.0     | 30096     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1914.0     | 45456     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1914.0     | 20368     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1914.0     | 25512     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1914.0     | 130472    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1914.0     | 85392     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1914.0     | 99728     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1914.0     | 291728    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 118672    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 137104    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 140176    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 136592    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 149392    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 138640    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 133008    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 175504    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 116112    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1914.0     | 135056    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1914.0     | 71568     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1914.0     | 20880     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1914.0     | 36264     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1914.0     | 127912    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1914.0     | 3054480   | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1914.0     | 3954576   | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 117136    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 131984    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 136592    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 132496    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 147344    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 133008    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 129424    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 169872    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 114064    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1914.0     | 130960    | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1914.0     | 66448     | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1914.0     | 2681768   | 22-Mar-21 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1914.0     | 2435472   | 22-Mar-21 | 19:40 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4123.1 | 451472    | 22-Mar-21 | 19:40 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4123.1 | 7386000   | 22-Mar-21 | 19:40 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 22-Mar-21 | 19:40 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 22-Mar-21 | 19:40 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 22-Mar-21 | 19:40 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 22-Mar-21 | 19:40 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 22-Mar-21 | 19:40 | x64      |
| Secforwarder.dll                                                     | 2019.150.4123.1 | 78752     | 22-Mar-21 | 19:40 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1914.0 | 60304     | 22-Mar-21 | 19:40 | x64      |
| Sqldk.dll                                                            | 2019.150.4123.1 | 3150720   | 22-Mar-21 | 19:40 | x64      |
| Sqldumper.exe                                                        | 2019.150.4123.1 | 185248    | 22-Mar-21 | 19:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 1590144   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 4150144   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 3404672   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 4146048   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 4051840   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 2216832   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 2163584   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 3810176   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 3806080   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 1532800   | 22-Mar-21 | 19:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4123.1 | 4014976   | 22-Mar-21 | 19:33 | x64      |
| Sqlos.dll                                                            | 2019.150.4123.1 | 41888     | 22-Mar-21 | 19:40 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1914.0 | 4840336   | 22-Mar-21 | 19:40 | x64      |
| Sqltses.dll                                                          | 2019.150.4123.1 | 9081760   | 22-Mar-21 | 19:40 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 22-Mar-21 | 19:40 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 22-Mar-21 | 19:40 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 22-Mar-21 | 19:40 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4123.1  | 29568     | 22-Mar-21 | 18:57 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4123.1 | 1631104   | 22-Mar-21 | 19:27 | x86      |
| Dtaengine.exe                                                | 2019.150.4123.1 | 218000    | 22-Mar-21 | 19:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4123.1 | 111488    | 22-Mar-21 | 19:27 | x86      |
| Dteparse.dll                                                 | 2019.150.4123.1 | 123776    | 22-Mar-21 | 19:27 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4123.1 | 115584    | 22-Mar-21 | 19:27 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4123.1 | 131968    | 22-Mar-21 | 19:27 | x64      |
| Dtepkg.dll                                                   | 2019.150.4123.1 | 131968    | 22-Mar-21 | 19:27 | x86      |
| Dtepkg.dll                                                   | 2019.150.4123.1 | 148352    | 22-Mar-21 | 19:27 | x64      |
| Dtexec.exe                                                   | 2019.150.4123.1 | 62848     | 22-Mar-21 | 19:27 | x86      |
| Dtexec.exe                                                   | 2019.150.4123.1 | 71568     | 22-Mar-21 | 19:27 | x64      |
| Dts.dll                                                      | 2019.150.4123.1 | 2761600   | 22-Mar-21 | 19:27 | x86      |
| Dts.dll                                                      | 2019.150.4123.1 | 3142544   | 22-Mar-21 | 19:27 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4123.1 | 443264    | 22-Mar-21 | 19:27 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4123.1 | 500624    | 22-Mar-21 | 19:27 | x64      |
| Dtsconn.dll                                                  | 2019.150.4123.1 | 521088    | 22-Mar-21 | 19:27 | x64      |
| Dtsconn.dll                                                  | 2019.150.4123.1 | 431008    | 22-Mar-21 | 19:27 | x86      |
| Dtshost.exe                                                  | 2019.150.4123.1 | 104336    | 22-Mar-21 | 19:27 | x64      |
| Dtshost.exe                                                  | 2019.150.4123.1 | 87456     | 22-Mar-21 | 19:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4123.1 | 553888    | 22-Mar-21 | 19:27 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4123.1 | 566160    | 22-Mar-21 | 19:27 | x64      |
| Dtspipeline.dll                                              | 2019.150.4123.1 | 1119136   | 22-Mar-21 | 19:27 | x86      |
| Dtspipeline.dll                                              | 2019.150.4123.1 | 1328032   | 22-Mar-21 | 19:27 | x64      |
| Dtswizard.exe                                                | 15.0.4123.1     | 885664    | 22-Mar-21 | 19:27 | x64      |
| Dtswizard.exe                                                | 15.0.4123.1     | 889728    | 22-Mar-21 | 19:27 | x86      |
| Dtuparse.dll                                                 | 2019.150.4123.1 | 86912     | 22-Mar-21 | 19:27 | x86      |
| Dtuparse.dll                                                 | 2019.150.4123.1 | 99216     | 22-Mar-21 | 19:27 | x64      |
| Dtutil.exe                                                   | 2019.150.4123.1 | 128928    | 22-Mar-21 | 19:27 | x86      |
| Dtutil.exe                                                   | 2019.150.4123.1 | 147328    | 22-Mar-21 | 19:27 | x64      |
| Exceldest.dll                                                | 2019.150.4123.1 | 234400    | 22-Mar-21 | 19:27 | x86      |
| Exceldest.dll                                                | 2019.150.4123.1 | 279424    | 22-Mar-21 | 19:27 | x64      |
| Excelsrc.dll                                                 | 2019.150.4123.1 | 258944    | 22-Mar-21 | 19:27 | x86      |
| Excelsrc.dll                                                 | 2019.150.4123.1 | 308112    | 22-Mar-21 | 19:27 | x64      |
| Flatfiledest.dll                                             | 2019.150.4123.1 | 357280    | 22-Mar-21 | 19:27 | x86      |
| Flatfiledest.dll                                             | 2019.150.4123.1 | 410496    | 22-Mar-21 | 19:27 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4123.1 | 369568    | 22-Mar-21 | 19:27 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4123.1 | 426896    | 22-Mar-21 | 19:27 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4123.1     | 78752     | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4123.1     | 402304    | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4123.1     | 2999168   | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4123.1     | 2999200   | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4123.1     | 41856     | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4123.1     | 58272     | 22-Mar-21 | 19:27 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 22-Mar-21 | 19:27 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4123.1 | 111504    | 22-Mar-21 | 19:27 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4123.1 | 99232     | 22-Mar-21 | 19:27 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.0   | 8277920   | 22-Mar-21 | 18:51 | x86      |
| Oledbdest.dll                                                | 2019.150.4123.1 | 279424    | 22-Mar-21 | 19:27 | x64      |
| Oledbdest.dll                                                | 2019.150.4123.1 | 238496    | 22-Mar-21 | 19:27 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4123.1 | 263056    | 22-Mar-21 | 19:27 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4123.1 | 312192    | 22-Mar-21 | 19:27 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4123.1 | 50080     | 22-Mar-21 | 19:27 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4123.1 | 37760     | 22-Mar-21 | 19:27 | x86      |
| Sqlscm.dll                                                   | 2019.150.4123.1 | 78720     | 22-Mar-21 | 19:27 | x86      |
| Sqlscm.dll                                                   | 2019.150.4123.1 | 86912     | 22-Mar-21 | 19:27 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4123.1 | 148352    | 22-Mar-21 | 19:27 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4123.1 | 181120    | 22-Mar-21 | 19:27 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4123.1 | 168832    | 22-Mar-21 | 19:27 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4123.1 | 205696    | 22-Mar-21 | 19:27 | x64      |
| Txdataconvert.dll                                            | 2019.150.4123.1 | 316288    | 22-Mar-21 | 19:27 | x64      |
| Txdataconvert.dll                                            | 2019.150.4123.1 | 275360    | 22-Mar-21 | 19:27 | x86      |
| Xe.dll                                                       | 2019.150.4123.1 | 631696    | 22-Mar-21 | 19:27 | x86      |
| Xe.dll                                                       | 2019.150.4123.1 | 721808    | 22-Mar-21 | 19:27 | x64      |

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
