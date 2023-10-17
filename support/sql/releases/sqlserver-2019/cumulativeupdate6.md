---
title: Cumulative update 6 for SQL Server 2019 (KB4563110)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 6 (KB4563110).
ms.date: 06/30/2023
ms.custom: KB4563110
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4563110 - Cumulative Update 6 for SQL Server 2019

_Release Date:_ &nbsp; August 04, 2020  
_Version:_ &nbsp; 15.0.4053.23

## Summary

This article describes Cumulative Update package 6 (CU6) for Microsoft SQL Server 2019. This update contains 44 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 5, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4053.23**, file version: **2019.150.4053.23**
- Analysis Services - Product version: **15.0.34.21**, file version: **2018.150.34.21**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13491013">[13491013](#13491013)</a> | DMV query `$system.DISCOVER_STORAGE_TABLES` can execute slowly against in-memory model which contains many tables and large table row counts in SQL Server 2019. | Analysis Services | Analysis Services | Windows |
| <a id="13521097">[13521097](#13521097)</a> | Excel MDX queries running against an SSAS Tabular instance may return incorrect result when you convert PivotTable Filters to formulas. | Analysis Services | Analysis Services | Windows |
| <a id="13500184">[13500184](#13500184)</a> | [FIX: ISDBUpgradeWizard.exe throws error when you try to upgrade SSISDB after restoring from earlier versions in SQL Server 2019 (KB4547890)](https://support.microsoft.com/help/4547890) | Integration Services | DTS | Windows |
| <a id="13540086">[13540086](#13540086)</a> | This update contains an improvement for XML Validation in SSIS XML Tasks. This improvement allows validation of `INCLUDED` schemas in XML task. | Integration Services | Tasks_Components | Windows |
| <a id="13528240">[13528240](#13528240)</a> | Corrects a regression to allow Recursive Hierarchies to display child items correctly. | Master Data Services | Client | Windows |
| <a id="13584506">[13584506](#13584506)</a> | [FIX: INSERT EXEC doesn't work when you insert row containing explicit identity value into table with IDENTITY column and IDENTITY_INSERT is OFF by default in SQL Server 2019 (KB4568653)](https://support.microsoft.com/help/4568653) | SQL Server Engine | Extensibility | All |
| <a id="13571478">[13571478](#13571478)</a> | Updates the Zulu JRE version to `zulu11.37.18-sa-jre11.0.6.101`. | SQL Server Engine | Extensibility | Windows |
| <a id="13575426">[13575426](#13575426)</a> | Adds support to communicate with a private network from `sp_execute_external_script` query in SQL Server 2019 "OSError: [WinError 10013] An attempt was made to access a socket in a way forbidden by its access permissions". | SQL Server Engine | Extensibility | All |
| <a id="13594832">[13594832](#13594832)</a> | The external satellite processes in SQL Server have a restriction to not use more than 8 cores on the system for satellite worker threads, but in case of highly parallel execution all the process are restricted to same set of 8 cores on the machine and don't use the other cores available on the system. This issue only happens on Windows and slows down highly parallel queries. The fix is to allow the processes to use 8 cores rather than the fixed set of cores on the system. | SQL Server Engine | Extensibility | Windows |
| <a id="13544859">[13544859](#13544859)</a> | When using FileTables in SQL Server, you may notice dumps being generated periodically that contain an assertion in function `FFtFileObject::ProcessPostCreate`. In some environments, these dumps may trigger a failover "FtFileObject::ProcessPostCreate file = fftfo.cpp line = \<LineNumber> expression = FALSE". | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="13407621">[13407621](#13407621)</a> | [FIX: Transaction commit delay time is higher under low usage workloads in SQL Server 2017 and 2019 (KB4538849)](https://support.microsoft.com/help/4538849) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13491006">[13491006](#13491006)</a> | [FIX: Error occurs when you try to create a differential backup on secondary replica in SQL Server (KB4551221)](https://support.microsoft.com/help/4551221) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13563157">[13563157](#13563157)</a> | [FIX: Query slowness occurs when CPU-intensive SQL Server system tasks run in SQL Server 2019 (KB4570571)](https://support.microsoft.com/help/4570571) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13534591">[13534591](#13534591)</a> | This improvement changes the behavior of Availability Group informational messages to not be printed to the log by default: </br></br>UpdateHadronTruncationLsn(X) (force=Y): Primary: Z:Z:Z Secondary: A:A:A Partial Quorum : B:B:B Aggregation: C:C:C Persistent: D:D:D | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13554274">[13554274](#13554274)</a> | This update contains an improvement for object level lock optimization on secondary replicas of Always On Availability Groups. This improvement addresses the schema lock contention on secondary replica redo, especially when the number of logical processors is large. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13582824">[13582824](#13582824)</a> | Fixes high CPU consumption on Availability Group secondary database when using multiple redo threads and uninitialized LSN, leading to extra reads under some rare scenarios. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13592713">[13592713](#13592713)</a> | Fixes access violation exception that occurs when plan cache involves `sys.dm_hadr_ag_threads` and `sys.dm_hadr_db_threads` DMVs. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13588307">[13588307](#13588307)</a> | [FIX: Access violation occurs when MSTVF references an In-Memory OLTP large-value data type with interleaved execution enabled in SQL Server 2019 (KB4575275)](https://support.microsoft.com/help/4575275) | SQL Server Engine | Metadata | Windows |
| <a id="13480950">[13480950](#13480950)</a> | [FIX: Support for REJECTED_ROW_LOCATION parameter in CREATE EXTERNAL TABLE in SQL Server 2019 box product (KB4568448)](https://support.microsoft.com/help/4568448) | SQL Server Engine | PolyBase | All |
| <a id="13571700">[13571700](#13571700)</a> | [FIX: Error occurs when you insert data from one replicated BDC data pool table to another in SQL Server 2019 (KB4570355)](https://support.microsoft.com/help/4570355) | SQL Server Engine | PolyBase | Linux |
| <a id="13592120">[13592120](#13592120)</a> | [FIX: Remote Hadoop bridge fails when using Hadoop connectivity levels other than seven in SQL Server 2019 on Linux (KB4570679)](https://support.microsoft.com/help/4570679) | SQL Server Engine | PolyBase | Linux |
| <a id="13592393">[13592393](#13592393)</a> | [FIX: "Culture is not supported" error occurs when you execute PolyBase query in SQL Server 2019 (KB4570433)](https://support.microsoft.com/help/4570433) | SQL Server Engine | PolyBase | Windows |
| <a id="13551991">[13551991](#13551991)</a> | Fixes the following numeric overflow error when you attempt to create a PolyBase external table targeting a Teradata table with more than 2,147,483,647 rows, the Teradata system's default session mode is 'Teradata', and you didn't change the session mode of the PolyBase connection by including '`SessionMode=ANSI`' in the `CONNECTION_OPTIONS` of the external data source that's used in the `CREATE EXTERNAL TABLE` statement. </br></br>Error: 105082;Generic ODBC error: [Microsoft][ODBC Teradata Driver]\[Teradata Database]\(-2616)Numeric overflow occurred during computation. | SQL Server Engine | PolyBase | All |
| <a id="13554533">[13554533](#13554533)</a> | When you execute a `SELECT` query against a PolyBase external data source and the query contains columns whose names only differ by case (such as ID and Id), you notice that PDW engine may generate an incorrect landing table schema which results in following error: </br></br>Msg 7320: Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Column names in each table must be unique. Column name '\<ID>' in table '\<TableName>' is specified more than once. | SQL Server Engine | PolyBase | All |
| <a id="13575481">[13575481](#13575481)</a> | Adds a new `dsqlplan` XEvent in PDW to collect `dsql` plan. | SQL Server Engine | PolyBase | Linux |
| <a id="13576520">[13576520](#13576520)</a> | This update allows PolyBase external tables for Teradata database to map `ByteInt` data type to `TinyInt` data type. | SQL Server Engine | PolyBase | Linux |
| <a id="13581481">[13581481](#13581481)</a> | Fixes a case where an error for a failed PolyBase query may not always get propagated to the user, instead returning the partial result set. | SQL Server Engine | PolyBase | All |
| <a id="13584821">[13584821](#13584821)</a> | Fixes error "Field not found in the applicable tables" when you query external table with `DATE`/`TIMESTAMP` literals in `WHERE` clause and the external data source ODBC driver does support not ANSI format. | SQL Server Engine | PolyBase | All |
| <a id="13586194">[13586194](#13586194)</a> | Removes unrelated warning message that's generated during PolyBase engine start or when PolyBase XEvent config environment variable isn't set "is not a rooted path. Expect a rooted path for XE config file from envrionment variable.". | SQL Server Engine | PolyBase | Linux |
| <a id="13592980">[13592980](#13592980)</a> | This update fixes a rare race condition in PolyBase query cancellation. | SQL Server Engine | PolyBase | All |
| <a id="13590483">[13590483](#13590483)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="13633260">[13633260](#13633260)</a> | Fixes errors that occur in SCOM 2019, when you upgrade from SQL Server 2016 or 2017 to SQL Server 2019 CU5 with UDF inlining `ON`. | SQL Server Engine | Programmability | Windows |
| <a id="13491005">[13491005](#13491005)</a> | [FIX: Assertion error occurs when you run resumable index build statement in SQL Server (KB4551220)](https://support.microsoft.com/help/4551220) | SQL Server Engine | Query Optimizer | All |
| <a id="13520896">[13520896](#13520896)</a> | Fixes issue with access violation exception when you execute query with UDF and multiple grouping. After applying this update, SQL Server blocks UDF inlining if `GROUP BY` includes multiple groupings. | SQL Server Engine | Query Optimizer | Linux |
| <a id="13562930">[13562930](#13562930)</a> | Fixes an unexpected result issue for variables when you use multiple variable assignments from `SELECT` statement that has scalar UDF inlining. After you apply this update, SQL Server blocks UDF inlining in special cases of `select-with-assignment` queries. | SQL Server Engine | Query Optimizer | Window |
| <a id="13516056">[13516056](#13516056)</a> | This improvement can force the Query Store option to be turned off by specifying the additional option `FORCED` in the `ALTER DB` command. `FORCED` option allows you to turn off Query Store immediately by aborting all background tasks. `ALTER DATABASE {0} SET QUERY_STORE = OFF (FORCED)` | SQL Server Engine | Query Store | Windows |
| <a id="13525673">[13525673](#13525673)</a> | [FIX: Assertion dump occurs when Implicit Transactions are enabled in SQL Server 2016, 2017, and 2019 (KB4563597)](https://support.microsoft.com/help/4563597) | SQL Server Engine | Replication | Windows |
| <a id="13593722">[13593722](#13593722)</a> | Fixes an access violation that occurs when executing system function `sys.fn_get_audit_file` to read Audit file in SQL Server 2019. | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13594414">[13594414](#13594414)</a> | Fixes an access violation error that might occur when auditing commands that require password masking. | SQL Server Engine | Security Infrastructure | All |
| <a id="13601596">[13601596](#13601596)</a> | [FIX: Istio proxy fails as automountServiceAccountToken is set to FALSE in CU5 for SQL Server 2019 (KB4577562)](https://support.microsoft.com/help/4577562) | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13580008">[13580008](#13580008)</a> | Fixes race condition where a PolyBase query might hang when the corresponding execution plan involves a query against an external data source that fails right after submission. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13603758">[13603758](#13603758)</a> | Fixes an issue in agent join during deployment due to pod IP address mismatch in SQL Server 2019. | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13518086">[13518086](#13518086)</a> | Fixes an issue with an orphaned spinlock due to access violation and results in the repeatedly printed in messages log: "getspinlock pre-Sleep() after AV". | SQL Server Engine | SQL OS | Linux |
| <a id="13563533">[13563533](#13563533)</a> | Assertion exception occurs when the system function `sys.fn_xe_file_target_read_file` is executed in SQL Server 2019 Assert reference (Location: \<FileName>:\<LineNumber>, Expression: pvb->FInUse ()) or (Location: \<FileName>:\<LineNumber>, Expression: !"No exceptions should be raised by this code"). | SQL Server Engine | SQL OS | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU6 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/08/sqlserver2019-kb4563110-x64_505c6d0a8773909e87a0456978ffb43449a92309.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4563110-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4563110-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4563110-x64.exe| 398934EAAC156F6E4784C23DDEEE4E635585C7C29AEDB5E2BEF1E6F0B8422DC4 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.21   | 291736    | 25-Jul-20 | 12:19 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 25-Jul-20 | 12:19 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.21       | 757136    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 174480    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 198544    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 201104    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 197520    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 213912    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 196488    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 192392    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 251288    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 172952    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.21       | 195984    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.21       | 1097112   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.21       | 479632    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 53656     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 58248     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 58776     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 57752     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 60816     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 57240     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 57240     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 66448     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 52632     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.21       | 57240     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16776     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 17816     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16792     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.21       | 16784     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 25-Jul-20 | 12:19 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 25-Jul-20 | 12:19 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 25-Jul-20 | 12:19 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 25-Jul-20 | 12:19 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 25-Jul-20 | 12:19 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 25-Jul-20 | 12:19 | x86      |
| Msmdctr.dll                                               | 2018.150.34.21   | 37272     | 25-Jul-20 | 12:19 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.21   | 47777688  | 25-Jul-20 | 12:19 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.21   | 66283416  | 25-Jul-20 | 12:19 | x64      |
| Msmdpump.dll                                              | 2018.150.34.21   | 10187144  | 25-Jul-20 | 12:19 | x64      |
| Msmdredir.dll                                             | 2018.150.34.21   | 7955848   | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 15760     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 15760     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 16280     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 15760     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 16264     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 16272     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 16272     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 17296     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 15768     | 25-Jul-20 | 12:19 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.21       | 15760     | 25-Jul-20 | 12:19 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.21   | 65818512  | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 832408    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1627032   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1452952   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1641872   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1607576   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1000344   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 991640    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1535896   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1520536   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 809880    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.21   | 1595288   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 831368    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1623448   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1449880   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1636760   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1603472   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 997776    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 990104    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1531800   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1516952   | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 808840    | 25-Jul-20 | 12:19 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.21   | 1590672   | 25-Jul-20 | 12:19 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.21   | 10185112  | 25-Jul-20 | 12:19 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.21   | 8277912   | 25-Jul-20 | 12:19 | x86      |
| Msolap.dll                                                | 2018.150.34.21   | 11015056  | 25-Jul-20 | 12:19 | x64      |
| Msolap.dll                                                | 2018.150.34.21   | 8607128   | 25-Jul-20 | 12:19 | x86      |
| Msolui.dll                                                | 2018.150.34.21   | 285080    | 25-Jul-20 | 12:19 | x86      |
| Msolui.dll                                                | 2018.150.34.21   | 305560    | 25-Jul-20 | 12:19 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 25-Jul-20 | 12:19 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 25-Jul-20 | 12:19 | x64      |
| Sqlboot.dll                                               | 2019.150.4053.23 | 213912    | 25-Jul-20 | 12:19 | x64      |
| Sqlceip.exe                                               | 15.0.4053.23     | 283536    | 25-Jul-20 | 12:19 | x86      |
| Sqldumper.exe                                             | 2019.150.4053.23 | 152472    | 25-Jul-20 | 12:19 | x86      |
| Sqldumper.exe                                             | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:19 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 25-Jul-20 | 12:19 | x86      |
| Tmapi.dll                                                 | 2018.150.34.21   | 6177168   | 25-Jul-20 | 12:19 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.21   | 4916624   | 25-Jul-20 | 12:19 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.21   | 1183640   | 25-Jul-20 | 12:19 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.21   | 6802320   | 25-Jul-20 | 12:19 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.21   | 26024848  | 25-Jul-20 | 12:19 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.21   | 35459480  | 25-Jul-20 | 12:19 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4053.23 | 74640     | 25-Jul-20 | 12:18 | x86      |
| Instapi150.dll                       | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:18 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4053.23 | 99208     | 25-Jul-20 | 12:25 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4053.23 | 86928     | 25-Jul-20 | 12:25 | x86      |
| Msasxpress.dll                       | 2018.150.34.21   | 26008     | 25-Jul-20 | 12:18 | x86      |
| Msasxpress.dll                       | 2018.150.34.21   | 31128     | 25-Jul-20 | 12:18 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4053.23 | 78736     | 25-Jul-20 | 12:25 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4053.23 | 86928     | 25-Jul-20 | 12:25 | x64      |
| Sqldumper.exe                        | 2019.150.4053.23 | 152472    | 25-Jul-20 | 12:18 | x86      |
| Sqldumper.exe                        | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:18 | x64      |
| Sqlftacct.dll                        | 2019.150.4053.23 | 58256     | 25-Jul-20 | 12:25 | x86      |
| Sqlftacct.dll                        | 2019.150.4053.23 | 74640     | 25-Jul-20 | 12:25 | x64      |
| Sqlmanager.dll                       | 2019.150.4053.23 | 742288    | 25-Jul-20 | 12:25 | x86      |
| Sqlmanager.dll                       | 2019.150.4053.23 | 873360    | 25-Jul-20 | 12:25 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4053.23 | 377752    | 25-Jul-20 | 12:25 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4053.23 | 430992    | 25-Jul-20 | 12:25 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4053.23 | 357256    | 25-Jul-20 | 12:25 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4053.23 | 275344    | 25-Jul-20 | 12:25 | x86      |
| Svrenumapi150.dll                    | 2019.150.4053.23 | 1160080   | 25-Jul-20 | 12:25 | x64      |
| Svrenumapi150.dll                    | 2019.150.4053.23 | 910224    | 25-Jul-20 | 12:25 | x86      |

SQL Server 2019 sql_dreplay_client

|     File name     |   File version   | File size |    Date   |  Time | Platform |
|:-----------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe | 2019.150.4053.23 | 136072    | 25-Jul-20 | 12:19 | x86      |
| Dreplaycommon.dll | 2019.150.4053.23 | 664968    | 25-Jul-20 | 12:19 | x86      |
| Dreplayutil.dll   | 2019.150.4053.23 | 304016    | 25-Jul-20 | 12:19 | x86      |
| Instapi150.dll    | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:19 | x64      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4053.23 | 664968    | 25-Jul-20 | 12:19 | x86      |
| Dreplaycontroller.exe | 2019.150.4053.23 | 365456    | 25-Jul-20 | 12:19 | x86      |
| Instapi150.dll        | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:19 | x64      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4053.23 | 4652944   | 25-Jul-20 | 13:03 | x64      |
| Aetm-enclave.dll                           | 2019.150.4053.23 | 4603752   | 25-Jul-20 | 13:03 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4053.23 | 4930320   | 25-Jul-20 | 13:03 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4053.23 | 4866256   | 25-Jul-20 | 13:03 | x64      |
| Azureattest.dll                            | 10.0.18965.1000  | 255056    | 25-Jul-20 | 13:03 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000  | 97528     | 25-Jul-20 | 13:03 | x64      |
| C1.dll                                     | 19.16.27034.0    | 2438520   | 25-Jul-20 | 13:03 | x64      |
| C2.dll                                     | 19.16.27034.0    | 7239032   | 25-Jul-20 | 13:03 | x64      |
| Cl.exe                                     | 19.16.27034.0    | 424360    | 25-Jul-20 | 13:03 | x64      |
| Clui.dll                                   | 19.16.27034.0    | 541048    | 25-Jul-20 | 13:03 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4053.23 | 279440    | 25-Jul-20 | 13:03 | x64      |
| Dcexec.exe                                 | 2019.150.4053.23 | 86928     | 25-Jul-20 | 13:03 | x64      |
| Fssres.dll                                 | 2019.150.4053.23 | 95112     | 25-Jul-20 | 13:03 | x64      |
| Hadrres.dll                                | 2019.150.4053.23 | 201608    | 25-Jul-20 | 13:03 | x64      |
| Hkcompile.dll                              | 2019.150.4053.23 | 1291152   | 25-Jul-20 | 13:03 | x64      |
| Hkengine.dll                               | 2019.150.4053.23 | 5784456   | 25-Jul-20 | 13:03 | x64      |
| Hkruntime.dll                              | 2019.150.4053.23 | 181128    | 25-Jul-20 | 13:03 | x64      |
| Hktempdb.dll                               | 2019.150.4053.23 | 62344     | 25-Jul-20 | 13:03 | x64      |
| Link.exe                                   | 14.16.27034.0    | 1707936   | 25-Jul-20 | 13:03 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4053.23     | 234376    | 25-Jul-20 | 13:03 | x86      |
| Msobj140.dll                               | 14.16.27034.0    | 134008    | 25-Jul-20 | 13:03 | x64      |
| Mspdb140.dll                               | 14.16.27034.0    | 632184    | 25-Jul-20 | 13:03 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0    | 632184    | 25-Jul-20 | 13:03 | x64      |
| Msvcp140.dll                               | 14.16.27034.0    | 628200    | 25-Jul-20 | 13:03 | x64      |
| Qds.dll                                    | 2019.150.4053.23 | 1184648   | 25-Jul-20 | 13:03 | x64      |
| Rsfxft.dll                                 | 2019.150.4053.23 | 50056     | 25-Jul-20 | 13:03 | x64      |
| Secforwarder.dll                           | 2019.150.4053.23 | 78736     | 25-Jul-20 | 13:03 | x64      |
| Sqagtres.dll                               | 2019.150.4053.23 | 86936     | 25-Jul-20 | 13:03 | x64      |
| Sqlaamss.dll                               | 2019.150.4053.23 | 107400    | 25-Jul-20 | 13:03 | x64      |
| Sqlaccess.dll                              | 2019.150.4053.23 | 492432    | 25-Jul-20 | 13:03 | x64      |
| Sqlagent.exe                               | 2019.150.4053.23 | 729992    | 25-Jul-20 | 13:03 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4053.23 | 78728     | 25-Jul-20 | 13:03 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4053.23 | 66440     | 25-Jul-20 | 13:03 | x86      |
| Sqlboot.dll                                | 2019.150.4053.23 | 213912    | 25-Jul-20 | 13:03 | x64      |
| Sqlceip.exe                                | 15.0.4053.23     | 283536    | 25-Jul-20 | 13:03 | x86      |
| Sqlcmdss.dll                               | 2019.150.4053.23 | 86928     | 25-Jul-20 | 13:03 | x64      |
| Sqlctr150.dll                              | 2019.150.4053.23 | 140168    | 25-Jul-20 | 13:03 | x64      |
| Sqlctr150.dll                              | 2019.150.4053.23 | 115592    | 25-Jul-20 | 13:03 | x86      |
| Sqldk.dll                                  | 2019.150.4053.23 | 3146632   | 25-Jul-20 | 13:03 | x64      |
| Sqldtsss.dll                               | 2019.150.4053.23 | 107400    | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 1586064   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3482504   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3679112   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 4141960   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 4260752   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3396488   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3564424   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 4137864   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3990408   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 4043664   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 2212752   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 2159496   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3851152   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3527568   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3994504   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3802000   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3797904   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3597200   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3482512   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 1528712   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 3888008   | 25-Jul-20 | 13:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4053.23 | 4006792   | 25-Jul-20 | 13:03 | x64      |
| Sqllang.dll                                | 2019.150.4053.23 | 39793544  | 25-Jul-20 | 13:03 | x64      |
| Sqlmin.dll                                 | 2019.150.4053.23 | 40240000  | 25-Jul-20 | 13:03 | x64      |
| Sqlolapss.dll                              | 2019.150.4053.23 | 103312    | 25-Jul-20 | 13:03 | x64      |
| Sqlos.dll                                  | 2019.150.4053.23 | 41872     | 25-Jul-20 | 13:03 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4053.23 | 82824     | 25-Jul-20 | 13:03 | x64      |
| Sqlrepss.dll                               | 2019.150.4053.23 | 82832     | 25-Jul-20 | 13:03 | x64      |
| Sqlscm.dll                                 | 2019.150.4053.23 | 86920     | 25-Jul-20 | 13:03 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4053.23 | 37776     | 25-Jul-20 | 13:03 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4053.23 | 5792648   | 25-Jul-20 | 13:03 | x64      |
| Sqlservr.exe                               | 2019.150.4053.23 | 623504    | 25-Jul-20 | 13:03 | x64      |
| Sqlsvc.dll                                 | 2019.150.4053.23 | 181136    | 25-Jul-20 | 13:03 | x64      |
| Sqltses.dll                                | 2019.150.4053.23 | 9073544   | 25-Jul-20 | 13:03 | x64      |
| Sqsrvres.dll                               | 2019.150.4053.23 | 279440    | 25-Jul-20 | 13:03 | x64      |
| Svl.dll                                    | 2019.150.4053.23 | 160656    | 25-Jul-20 | 13:03 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0    | 85992     | 25-Jul-20 | 13:03 | x64      |
| Xe.dll                                     | 2019.150.4053.23 | 721816    | 25-Jul-20 | 13:03 | x64      |
| Xpadsi.exe                                 | 2019.150.4053.23 | 115592    | 25-Jul-20 | 13:03 | x64      |
| Xplog70.dll                                | 2019.150.4053.23 | 91016     | 25-Jul-20 | 13:03 | x64      |
| Xprepl.dll                                 | 2019.150.4053.23 | 119688    | 25-Jul-20 | 13:03 | x64      |
| Xpstar.dll                                 | 2019.150.4053.23 | 471944    | 25-Jul-20 | 13:03 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                          | 2019.150.4053.23 | 263056    | 25-Jul-20 | 12:19 | x64      |
| Datacollectortasks.dll                                   | 2019.150.4053.23 | 226184    | 25-Jul-20 | 12:19 | x64      |
| Distrib.exe                                              | 2019.150.4053.23 | 234392    | 25-Jul-20 | 12:19 | x64      |
| Dteparse.dll                                             | 2019.150.4053.23 | 123792    | 25-Jul-20 | 12:19 | x64      |
| Dteparsemgd.dll                                          | 2019.150.4053.23 | 131984    | 25-Jul-20 | 12:19 | x64      |
| Dtepkg.dll                                               | 2019.150.4053.23 | 148368    | 25-Jul-20 | 12:19 | x64      |
| Dtexec.exe                                               | 2019.150.4053.23 | 71568     | 25-Jul-20 | 12:19 | x64      |
| Dts.dll                                                  | 2019.150.4053.23 | 3142536   | 25-Jul-20 | 12:19 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4053.23 | 500632    | 25-Jul-20 | 12:19 | x64      |
| Dtsconn.dll                                              | 2019.150.4053.23 | 525200    | 25-Jul-20 | 12:19 | x64      |
| Dtshost.exe                                              | 2019.150.4053.23 | 104320    | 25-Jul-20 | 12:19 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4053.23 | 566160    | 25-Jul-20 | 12:19 | x64      |
| Dtspipeline.dll                                          | 2019.150.4053.23 | 1328016   | 25-Jul-20 | 12:19 | x64      |
| Dtswizard.exe                                            | 15.0.4053.23     | 885640    | 25-Jul-20 | 12:19 | x64      |
| Dtuparse.dll                                             | 2019.150.4053.23 | 99216     | 25-Jul-20 | 12:19 | x64      |
| Dtutil.exe                                               | 2019.150.4053.23 | 147344    | 25-Jul-20 | 12:19 | x64      |
| Exceldest.dll                                            | 2019.150.4053.23 | 279440    | 25-Jul-20 | 12:19 | x64      |
| Excelsrc.dll                                             | 2019.150.4053.23 | 308104    | 25-Jul-20 | 12:19 | x64      |
| Execpackagetask.dll                                      | 2019.150.4053.23 | 185232    | 25-Jul-20 | 12:19 | x64      |
| Flatfiledest.dll                                         | 2019.150.4053.23 | 410512    | 25-Jul-20 | 12:19 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4053.23 | 426888    | 25-Jul-20 | 12:19 | x64      |
| Logread.exe                                              | 2019.150.4053.23 | 717704    | 25-Jul-20 | 12:19 | x64      |
| Mergetxt.dll                                             | 2019.150.4053.23 | 74640     | 25-Jul-20 | 12:19 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4053.23     | 58256     | 25-Jul-20 | 12:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4053.23     | 390032    | 25-Jul-20 | 12:19 | x86      |
| Microsoft.sqlserver.xmltask.dll                          | 15.0.4053.23     | 156552    | 25-Jul-20 | 12:19 | x86      |
| Msdtssrvrutil.dll                                        | 2019.150.4053.23 | 111512    | 25-Jul-20 | 12:19 | x64      |
| Msgprox.dll                                              | 2019.150.4053.23 | 299920    | 25-Jul-20 | 12:19 | x64      |
| Msoledbsql.dll                                           | 2018.182.3.0     | 148432    | 25-Jul-20 | 12:19 | x64      |
| Msxmlsql.dll                                             | 2019.150.4053.23 | 1495952   | 25-Jul-20 | 12:19 | x64      |
| Oledbdest.dll                                            | 2019.150.4053.23 | 279432    | 25-Jul-20 | 12:19 | x64      |
| Oledbsrc.dll                                             | 2019.150.4053.23 | 312200    | 25-Jul-20 | 12:19 | x64      |
| Osql.exe                                                 | 2019.150.4053.23 | 91016     | 25-Jul-20 | 12:19 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4053.23 | 496536    | 25-Jul-20 | 12:19 | x64      |
| Rawdest.dll                                              | 2019.150.4053.23 | 226192    | 25-Jul-20 | 12:19 | x64      |
| Rawsource.dll                                            | 2019.150.4053.23 | 209808    | 25-Jul-20 | 12:19 | x64      |
| Rdistcom.dll                                             | 2019.150.4053.23 | 914320    | 25-Jul-20 | 12:19 | x64      |
| Recordsetdest.dll                                        | 2019.150.4053.23 | 201608    | 25-Jul-20 | 12:19 | x64      |
| Repldp.dll                                               | 2019.150.4053.23 | 312200    | 25-Jul-20 | 12:19 | x64      |
| Replerrx.dll                                             | 2019.150.4053.23 | 181144    | 25-Jul-20 | 12:19 | x64      |
| Replisapi.dll                                            | 2019.150.4053.23 | 394128    | 25-Jul-20 | 12:19 | x64      |
| Replmerg.exe                                             | 2019.150.4053.23 | 562064    | 25-Jul-20 | 12:19 | x64      |
| Replprov.dll                                             | 2019.150.4053.23 | 852880    | 25-Jul-20 | 12:19 | x64      |
| Replrec.dll                                              | 2019.150.4053.23 | 1029008   | 25-Jul-20 | 12:19 | x64      |
| Replsub.dll                                              | 2019.150.4053.23 | 471952    | 25-Jul-20 | 12:19 | x64      |
| Replsync.dll                                             | 2019.150.4053.23 | 164744    | 25-Jul-20 | 12:19 | x64      |
| Spresolv.dll                                             | 2019.150.4053.23 | 275344    | 25-Jul-20 | 12:19 | x64      |
| Sqldiag.exe                                              | 2019.150.4053.23 | 1139600   | 25-Jul-20 | 12:19 | x64      |
| Sqldistx.dll                                             | 2019.150.4053.23 | 246664    | 25-Jul-20 | 12:19 | x64      |
| Sqllogship.exe                                           | 15.0.4053.23     | 103312    | 25-Jul-20 | 12:19 | x64      |
| Sqlmergx.dll                                             | 2019.150.4053.23 | 398232    | 25-Jul-20 | 12:19 | x64      |
| Sqlscm.dll                                               | 2019.150.4053.23 | 78736     | 25-Jul-20 | 11:27 | x86      |
| Sqlscm.dll                                               | 2019.150.4053.23 | 86920     | 25-Jul-20 | 12:19 | x64      |
| Sqlsvc.dll                                               | 2019.150.4053.23 | 148368    | 25-Jul-20 | 11:26 | x86      |
| Sqlsvc.dll                                               | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:19 | x64      |
| Sqltaskconnections.dll                                   | 2019.150.4053.23 | 201616    | 25-Jul-20 | 12:19 | x64      |
| Ssradd.dll                                               | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:19 | x64      |
| Ssravg.dll                                               | 2019.150.4053.23 | 82832     | 25-Jul-20 | 12:19 | x64      |
| Ssrdown.dll                                              | 2019.150.4053.23 | 74632     | 25-Jul-20 | 12:19 | x64      |
| Ssrmax.dll                                               | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:19 | x64      |
| Ssrmin.dll                                               | 2019.150.4053.23 | 82832     | 25-Jul-20 | 12:19 | x64      |
| Ssrpub.dll                                               | 2019.150.4053.23 | 74640     | 25-Jul-20 | 12:19 | x64      |
| Ssrup.dll                                                | 2019.150.4053.23 | 74632     | 25-Jul-20 | 12:19 | x64      |
| Txagg.dll                                                | 2019.150.4053.23 | 390032    | 25-Jul-20 | 12:19 | x64      |
| Txbdd.dll                                                | 2019.150.4053.23 | 189328    | 25-Jul-20 | 12:19 | x64      |
| Txdatacollector.dll                                      | 2019.150.4053.23 | 471960    | 25-Jul-20 | 12:19 | x64      |
| Txdataconvert.dll                                        | 2019.150.4053.23 | 316304    | 25-Jul-20 | 12:19 | x64      |
| Txderived.dll                                            | 2019.150.4053.23 | 639880    | 25-Jul-20 | 12:19 | x64      |
| Txlookup.dll                                             | 2019.150.4053.23 | 541584    | 25-Jul-20 | 12:19 | x64      |
| Txmerge.dll                                              | 2019.150.4053.23 | 246672    | 25-Jul-20 | 12:19 | x64      |
| Txmergejoin.dll                                          | 2019.150.4053.23 | 308104    | 25-Jul-20 | 12:19 | x64      |
| Txmulticast.dll                                          | 2019.150.4053.23 | 144280    | 25-Jul-20 | 12:19 | x64      |
| Txrowcount.dll                                           | 2019.150.4053.23 | 140176    | 25-Jul-20 | 12:19 | x64      |
| Txsort.dll                                               | 2019.150.4053.23 | 287632    | 25-Jul-20 | 12:19 | x64      |
| Txsplit.dll                                              | 2019.150.4053.23 | 623504    | 25-Jul-20 | 12:19 | x64      |
| Txunionall.dll                                           | 2019.150.4053.23 | 197520    | 25-Jul-20 | 12:19 | x64      |
| Xe.dll                                                   | 2019.150.4053.23 | 721816    | 25-Jul-20 | 12:19 | x64      |
| Xmlsub.dll                                               | 2019.150.4053.23 | 295824    | 25-Jul-20 | 12:19 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4053.23 | 91016     | 25-Jul-20 | 12:19 | x64      |
| Exthost.exe        | 2019.150.4053.23 | 230280    | 25-Jul-20 | 12:19 | x64      |
| Launchpad.exe      | 2019.150.4053.23 | 1229712   | 25-Jul-20 | 12:19 | x64      |
| Sqlsatellite.dll   | 2019.150.4053.23 | 1029016   | 25-Jul-20 | 12:19 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4053.23 | 684944    | 25-Jul-20 | 12:19 | x64      |
| Fdhost.exe     | 2019.150.4053.23 | 127888    | 25-Jul-20 | 12:19 | x64      |
| Fdlauncher.exe | 2019.150.4053.23 | 78736     | 25-Jul-20 | 12:19 | x64      |
| Sqlft150ph.dll | 2019.150.4053.23 | 91024     | 25-Jul-20 | 12:19 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4053.23 | 29576     | 25-Jul-20 | 12:19 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4053.23 | 226192    | 25-Jul-20 | 12:31 | x86      |
| Commanddest.dll                                               | 2019.150.4053.23 | 263056    | 25-Jul-20 | 12:31 | x64      |
| Dteparse.dll                                                  | 2019.150.4053.23 | 111504    | 25-Jul-20 | 12:31 | x86      |
| Dteparse.dll                                                  | 2019.150.4053.23 | 123792    | 25-Jul-20 | 12:31 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4053.23 | 131984    | 25-Jul-20 | 12:31 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4053.23 | 115608    | 25-Jul-20 | 12:31 | x86      |
| Dtepkg.dll                                                    | 2019.150.4053.23 | 131976    | 25-Jul-20 | 12:31 | x86      |
| Dtepkg.dll                                                    | 2019.150.4053.23 | 148368    | 25-Jul-20 | 12:31 | x64      |
| Dtexec.exe                                                    | 2019.150.4053.23 | 71568     | 25-Jul-20 | 12:31 | x64      |
| Dtexec.exe                                                    | 2019.150.4053.23 | 62864     | 25-Jul-20 | 12:31 | x86      |
| Dts.dll                                                       | 2019.150.4053.23 | 2761608   | 25-Jul-20 | 12:31 | x86      |
| Dts.dll                                                       | 2019.150.4053.23 | 3142536   | 25-Jul-20 | 12:31 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4053.23 | 443272    | 25-Jul-20 | 12:31 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4053.23 | 500632    | 25-Jul-20 | 12:31 | x64      |
| Dtsconn.dll                                                   | 2019.150.4053.23 | 435096    | 25-Jul-20 | 12:31 | x86      |
| Dtsconn.dll                                                   | 2019.150.4053.23 | 525200    | 25-Jul-20 | 12:31 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4053.23 | 92560     | 25-Jul-20 | 12:31 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4053.23 | 111000    | 25-Jul-20 | 12:31 | x64      |
| Dtshost.exe                                                   | 2019.150.4053.23 | 104320    | 25-Jul-20 | 12:31 | x64      |
| Dtshost.exe                                                   | 2019.150.4053.23 | 87448     | 25-Jul-20 | 12:31 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4053.23 | 553872    | 25-Jul-20 | 12:31 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4053.23 | 566160    | 25-Jul-20 | 12:31 | x64      |
| Dtspipeline.dll                                               | 2019.150.4053.23 | 1119112   | 25-Jul-20 | 12:31 | x86      |
| Dtspipeline.dll                                               | 2019.150.4053.23 | 1328016   | 25-Jul-20 | 12:31 | x64      |
| Dtswizard.exe                                                 | 15.0.4053.23     | 885640    | 25-Jul-20 | 12:31 | x64      |
| Dtswizard.exe                                                 | 15.0.4053.23     | 889736    | 25-Jul-20 | 12:31 | x86      |
| Dtuparse.dll                                                  | 2019.150.4053.23 | 86936     | 25-Jul-20 | 12:31 | x86      |
| Dtuparse.dll                                                  | 2019.150.4053.23 | 99216     | 25-Jul-20 | 12:31 | x64      |
| Dtutil.exe                                                    | 2019.150.4053.23 | 147344    | 25-Jul-20 | 12:31 | x64      |
| Dtutil.exe                                                    | 2019.150.4053.23 | 128904    | 25-Jul-20 | 12:31 | x86      |
| Exceldest.dll                                                 | 2019.150.4053.23 | 234384    | 25-Jul-20 | 12:31 | x86      |
| Exceldest.dll                                                 | 2019.150.4053.23 | 279440    | 25-Jul-20 | 12:31 | x64      |
| Excelsrc.dll                                                  | 2019.150.4053.23 | 258952    | 25-Jul-20 | 12:31 | x86      |
| Excelsrc.dll                                                  | 2019.150.4053.23 | 308104    | 25-Jul-20 | 12:31 | x64      |
| Execpackagetask.dll                                           | 2019.150.4053.23 | 185232    | 25-Jul-20 | 12:31 | x64      |
| Execpackagetask.dll                                           | 2019.150.4053.23 | 148376    | 25-Jul-20 | 12:31 | x86      |
| Flatfiledest.dll                                              | 2019.150.4053.23 | 357264    | 25-Jul-20 | 12:31 | x86      |
| Flatfiledest.dll                                              | 2019.150.4053.23 | 410512    | 25-Jul-20 | 12:31 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4053.23 | 369544    | 25-Jul-20 | 12:31 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4053.23 | 426888    | 25-Jul-20 | 12:31 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4053.23     | 119688    | 25-Jul-20 | 12:31 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4053.23     | 119696    | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4053.23     | 78736     | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4053.23     | 58256     | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4053.23     | 58248     | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4053.23     | 500616    | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4053.23     | 500624    | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4053.23     | 390032    | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4053.23     | 140168    | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4053.23     | 156552    | 25-Jul-20 | 12:31 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4053.23     | 218000    | 25-Jul-20 | 12:31 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4053.23 | 111512    | 25-Jul-20 | 12:31 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4053.23 | 99224     | 25-Jul-20 | 12:31 | x86      |
| Msmdpp.dll                                                    | 2018.150.34.21   | 10062232  | 25-Jul-20 | 12:19 | x64      |
| Odbcdest.dll                                                  | 2019.150.4053.23 | 316304    | 25-Jul-20 | 12:31 | x86      |
| Odbcdest.dll                                                  | 2019.150.4053.23 | 369536    | 25-Jul-20 | 12:31 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4053.23 | 328592    | 25-Jul-20 | 12:31 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4053.23 | 381848    | 25-Jul-20 | 12:31 | x64      |
| Oledbdest.dll                                                 | 2019.150.4053.23 | 238480    | 25-Jul-20 | 12:31 | x86      |
| Oledbdest.dll                                                 | 2019.150.4053.23 | 279432    | 25-Jul-20 | 12:31 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4053.23 | 263056    | 25-Jul-20 | 12:31 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4053.23 | 312200    | 25-Jul-20 | 12:31 | x64      |
| Rawdest.dll                                                   | 2019.150.4053.23 | 226192    | 25-Jul-20 | 12:31 | x64      |
| Rawdest.dll                                                   | 2019.150.4053.23 | 189328    | 25-Jul-20 | 12:31 | x86      |
| Rawsource.dll                                                 | 2019.150.4053.23 | 177048    | 25-Jul-20 | 12:31 | x86      |
| Rawsource.dll                                                 | 2019.150.4053.23 | 209808    | 25-Jul-20 | 12:31 | x64      |
| Recordsetdest.dll                                             | 2019.150.4053.23 | 201608    | 25-Jul-20 | 12:31 | x64      |
| Recordsetdest.dll                                             | 2019.150.4053.23 | 172936    | 25-Jul-20 | 12:31 | x86      |
| Sqlceip.exe                                                   | 15.0.4053.23     | 283536    | 25-Jul-20 | 12:31 | x86      |
| Sqldest.dll                                                   | 2019.150.4053.23 | 275352    | 25-Jul-20 | 12:31 | x64      |
| Sqldest.dll                                                   | 2019.150.4053.23 | 238480    | 25-Jul-20 | 12:31 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4053.23 | 168848    | 25-Jul-20 | 12:31 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4053.23 | 201616    | 25-Jul-20 | 12:31 | x64      |
| Txagg.dll                                                     | 2019.150.4053.23 | 328592    | 25-Jul-20 | 12:31 | x86      |
| Txagg.dll                                                     | 2019.150.4053.23 | 390032    | 25-Jul-20 | 12:31 | x64      |
| Txbdd.dll                                                     | 2019.150.4053.23 | 189328    | 25-Jul-20 | 12:31 | x64      |
| Txbdd.dll                                                     | 2019.150.4053.23 | 152464    | 25-Jul-20 | 12:31 | x86      |
| Txbestmatch.dll                                               | 2019.150.4053.23 | 545680    | 25-Jul-20 | 12:31 | x86      |
| Txbestmatch.dll                                               | 2019.150.4053.23 | 652168    | 25-Jul-20 | 12:31 | x64      |
| Txcache.dll                                                   | 2019.150.4053.23 | 209808    | 25-Jul-20 | 12:31 | x64      |
| Txcache.dll                                                   | 2019.150.4053.23 | 164744    | 25-Jul-20 | 12:31 | x86      |
| Txcharmap.dll                                                 | 2019.150.4053.23 | 271248    | 25-Jul-20 | 12:31 | x86      |
| Txcharmap.dll                                                 | 2019.150.4053.23 | 312208    | 25-Jul-20 | 12:31 | x64      |
| Txcopymap.dll                                                 | 2019.150.4053.23 | 164752    | 25-Jul-20 | 12:31 | x86      |
| Txcopymap.dll                                                 | 2019.150.4053.23 | 197512    | 25-Jul-20 | 12:31 | x64      |
| Txdataconvert.dll                                             | 2019.150.4053.23 | 275344    | 25-Jul-20 | 12:31 | x86      |
| Txdataconvert.dll                                             | 2019.150.4053.23 | 316304    | 25-Jul-20 | 12:31 | x64      |
| Txderived.dll                                                 | 2019.150.4053.23 | 639880    | 25-Jul-20 | 12:31 | x64      |
| Txderived.dll                                                 | 2019.150.4053.23 | 557976    | 25-Jul-20 | 12:31 | x86      |
| Txfileextractor.dll                                           | 2019.150.4053.23 | 181128    | 25-Jul-20 | 12:31 | x86      |
| Txfileextractor.dll                                           | 2019.150.4053.23 | 218008    | 25-Jul-20 | 12:31 | x64      |
| Txfileinserter.dll                                            | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:31 | x86      |
| Txfileinserter.dll                                            | 2019.150.4053.23 | 213896    | 25-Jul-20 | 12:31 | x64      |
| Txgroupdups.dll                                               | 2019.150.4053.23 | 254856    | 25-Jul-20 | 12:31 | x86      |
| Txgroupdups.dll                                               | 2019.150.4053.23 | 312208    | 25-Jul-20 | 12:31 | x64      |
| Txlineage.dll                                                 | 2019.150.4053.23 | 152464    | 25-Jul-20 | 12:31 | x64      |
| Txlineage.dll                                                 | 2019.150.4053.23 | 127880    | 25-Jul-20 | 12:31 | x86      |
| Txlookup.dll                                                  | 2019.150.4053.23 | 467848    | 25-Jul-20 | 12:31 | x86      |
| Txlookup.dll                                                  | 2019.150.4053.23 | 541584    | 25-Jul-20 | 12:31 | x64      |
| Txmerge.dll                                                   | 2019.150.4053.23 | 246672    | 25-Jul-20 | 12:31 | x64      |
| Txmerge.dll                                                   | 2019.150.4053.23 | 201616    | 25-Jul-20 | 12:31 | x86      |
| Txmergejoin.dll                                               | 2019.150.4053.23 | 308104    | 25-Jul-20 | 12:31 | x64      |
| Txmergejoin.dll                                               | 2019.150.4053.23 | 246664    | 25-Jul-20 | 12:31 | x86      |
| Txmulticast.dll                                               | 2019.150.4053.23 | 115600    | 25-Jul-20 | 12:31 | x86      |
| Txmulticast.dll                                               | 2019.150.4053.23 | 144280    | 25-Jul-20 | 12:31 | x64      |
| Txpivot.dll                                                   | 2019.150.4053.23 | 238480    | 25-Jul-20 | 12:31 | x64      |
| Txpivot.dll                                                   | 2019.150.4053.23 | 205712    | 25-Jul-20 | 12:31 | x86      |
| Txrowcount.dll                                                | 2019.150.4053.23 | 111504    | 25-Jul-20 | 12:31 | x86      |
| Txrowcount.dll                                                | 2019.150.4053.23 | 140176    | 25-Jul-20 | 12:31 | x64      |
| Txsampling.dll                                                | 2019.150.4053.23 | 193432    | 25-Jul-20 | 12:31 | x64      |
| Txsampling.dll                                                | 2019.150.4053.23 | 156552    | 25-Jul-20 | 12:31 | x86      |
| Txscd.dll                                                     | 2019.150.4053.23 | 197504    | 25-Jul-20 | 12:31 | x86      |
| Txscd.dll                                                     | 2019.150.4053.23 | 234384    | 25-Jul-20 | 12:31 | x64      |
| Txsort.dll                                                    | 2019.150.4053.23 | 287632    | 25-Jul-20 | 12:31 | x64      |
| Txsort.dll                                                    | 2019.150.4053.23 | 230296    | 25-Jul-20 | 12:31 | x86      |
| Txsplit.dll                                                   | 2019.150.4053.23 | 623504    | 25-Jul-20 | 12:31 | x64      |
| Txsplit.dll                                                   | 2019.150.4053.23 | 549768    | 25-Jul-20 | 12:31 | x86      |
| Txtermextraction.dll                                          | 2019.150.4053.23 | 8643472   | 25-Jul-20 | 12:31 | x86      |
| Txtermextraction.dll                                          | 2019.150.4053.23 | 8700816   | 25-Jul-20 | 12:31 | x64      |
| Txtermlookup.dll                                              | 2019.150.4053.23 | 4182920   | 25-Jul-20 | 12:31 | x64      |
| Txtermlookup.dll                                              | 2019.150.4053.23 | 4137872   | 25-Jul-20 | 12:31 | x86      |
| Txunionall.dll                                                | 2019.150.4053.23 | 197520    | 25-Jul-20 | 12:31 | x64      |
| Txunionall.dll                                                | 2019.150.4053.23 | 160656    | 25-Jul-20 | 12:31 | x86      |
| Txunpivot.dll                                                 | 2019.150.4053.23 | 181128    | 25-Jul-20 | 12:31 | x86      |
| Txunpivot.dll                                                 | 2019.150.4053.23 | 213896    | 25-Jul-20 | 12:31 | x64      |
| Xe.dll                                                        | 2019.150.4053.23 | 631688    | 25-Jul-20 | 12:31 | x86      |
| Xe.dll                                                        | 2019.150.4053.23 | 721816    | 25-Jul-20 | 12:31 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1873.0      | 551824    | 25-Jul-20 | 12:49 | x86      |
| Dmsnative.dll                                                        | 2018.150.1873.0  | 139168    | 25-Jul-20 | 12:49 | x64      |
| Dwengineservice.dll                                                  | 15.0.1873.0      | 43928     | 25-Jul-20 | 12:49 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008       | 17142672  | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003       | 146304    | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108        | 2365520   | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272       | 2199120   | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272       | 144976    | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217        | 2408016   | 25-Jul-20 | 12:49 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39         | 2928720   | 25-Jul-20 | 12:49 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109768  | 25-Jul-20 | 12:49 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109832  | 25-Jul-20 | 12:49 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2425288   | 25-Jul-20 | 12:49 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2431880   | 25-Jul-20 | 12:49 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124        | 15488080  | 25-Jul-20 | 12:49 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1775048   | 25-Jul-20 | 12:49 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1783688   | 25-Jul-20 | 12:49 | x64      |
| Instapi150.dll                                                       | 2019.150.4053.23 | 82824     | 25-Jul-20 | 12:49 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10         | 2620304   | 25-Jul-20 | 12:49 | x64      |
| Libcrypto                                                            | 1.1.1.4          | 2953680   | 25-Jul-20 | 12:49 | x64      |
| Libsasl.dll                                                          | 2.1.26.0         | 292224    | 25-Jul-20 | 12:49 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10         | 648080    | 25-Jul-20 | 12:49 | x64      |
| Libssl                                                               | 1.1.1.4          | 798160    | 25-Jul-20 | 12:49 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1873.0      | 66464     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1873.0      | 292256    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1873.0      | 1951128   | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1873.0      | 169376    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1873.0      | 634272    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1873.0      | 243616    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1873.0      | 137624    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1873.0      | 78752     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1873.0      | 50080     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1873.0      | 87448     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1873.0      | 1127824   | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1873.0      | 79768     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1873.0      | 69520     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1873.0      | 34208     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1873.0      | 30112     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1873.0      | 45472     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1873.0      | 20368     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1873.0      | 25504     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1873.0      | 130456    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1873.0      | 85408     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1873.0      | 99728     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1873.0      | 291224    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 118688    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 136608    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 139672    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 136608    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 148896    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 138656    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 133024    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 175008    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 116128    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1873.0      | 135064    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1873.0      | 71576     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1873.0      | 20888     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1873.0      | 36256     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1873.0      | 127896    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1873.0      | 3041688   | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1873.0      | 3952536   | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 117152    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 131992    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 136592    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 132512    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 147360    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 133024    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 129440    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 169880    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 114080    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1873.0      | 130976    | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1873.0      | 66464     | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1873.0      | 2681248   | 25-Jul-20 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1873.0      | 2435488   | 25-Jul-20 | 12:49 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4053.23 | 451472    | 25-Jul-20 | 12:49 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4053.23 | 7394192   | 25-Jul-20 | 12:49 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1     | 2016120   | 25-Jul-20 | 12:49 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1     | 720792    | 25-Jul-20 | 12:49 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1     | 138136    | 25-Jul-20 | 12:49 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1     | 175000    | 25-Jul-20 | 12:49 | x64      |
| Saslplain.dll                                                        | 2.1.26.0         | 170880    | 25-Jul-20 | 12:49 | x64      |
| Secforwarder.dll                                                     | 2019.150.4053.23 | 78736     | 25-Jul-20 | 12:49 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1873.0  | 60304     | 25-Jul-20 | 12:49 | x64      |
| Sqldk.dll                                                            | 2019.150.4053.23 | 3146632   | 25-Jul-20 | 12:49 | x64      |
| Sqldumper.exe                                                        | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 1586064   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 4141960   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 3396488   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 4137864   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 4043664   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 2212752   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 2159496   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 3802000   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 3797904   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 1528712   | 25-Jul-20 | 12:49 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4053.23 | 4006792   | 25-Jul-20 | 12:49 | x64      |
| Sqlos.dll                                                            | 2019.150.4053.23 | 41872     | 25-Jul-20 | 12:49 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1873.0  | 4840352   | 25-Jul-20 | 12:49 | x64      |
| Sqltses.dll                                                          | 2019.150.4053.23 | 9073544   | 25-Jul-20 | 12:49 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078     | 14995920  | 25-Jul-20 | 12:49 | x64      |
| Terasso.dll                                                          | 16.20.0.13       | 2158896   | 25-Jul-20 | 12:49 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0         | 281472    | 25-Jul-20 | 12:49 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4053.23 | 29576     | 25-Jul-20 | 12:19 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2019.150.4053.23 | 1631120   | 25-Jul-20 | 12:47 | x86      |
| Dtaengine.exe                                  | 2019.150.4053.23 | 218000    | 25-Jul-20 | 12:47 | x86      |
| Dteparse.dll                                   | 2019.150.4053.23 | 111504    | 25-Jul-20 | 12:31 | x86      |
| Dteparse.dll                                   | 2019.150.4053.23 | 123792    | 25-Jul-20 | 12:31 | x64      |
| Dteparsemgd.dll                                | 2019.150.4053.23 | 131984    | 25-Jul-20 | 12:31 | x64      |
| Dteparsemgd.dll                                | 2019.150.4053.23 | 115608    | 25-Jul-20 | 12:31 | x86      |
| Dtepkg.dll                                     | 2019.150.4053.23 | 131976    | 25-Jul-20 | 12:31 | x86      |
| Dtepkg.dll                                     | 2019.150.4053.23 | 148368    | 25-Jul-20 | 12:31 | x64      |
| Dtexec.exe                                     | 2019.150.4053.23 | 71568     | 25-Jul-20 | 12:31 | x64      |
| Dtexec.exe                                     | 2019.150.4053.23 | 62864     | 25-Jul-20 | 12:31 | x86      |
| Dts.dll                                        | 2019.150.4053.23 | 2761608   | 25-Jul-20 | 12:31 | x86      |
| Dts.dll                                        | 2019.150.4053.23 | 3142536   | 25-Jul-20 | 12:31 | x64      |
| Dtscomexpreval.dll                             | 2019.150.4053.23 | 443272    | 25-Jul-20 | 12:31 | x86      |
| Dtscomexpreval.dll                             | 2019.150.4053.23 | 500632    | 25-Jul-20 | 12:31 | x64      |
| Dtsconn.dll                                    | 2019.150.4053.23 | 435096    | 25-Jul-20 | 12:31 | x86      |
| Dtsconn.dll                                    | 2019.150.4053.23 | 525200    | 25-Jul-20 | 12:31 | x64      |
| Dtshost.exe                                    | 2019.150.4053.23 | 104320    | 25-Jul-20 | 12:31 | x64      |
| Dtshost.exe                                    | 2019.150.4053.23 | 87448     | 25-Jul-20 | 12:31 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4053.23 | 553872    | 25-Jul-20 | 12:31 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4053.23 | 566160    | 25-Jul-20 | 12:31 | x64      |
| Dtspipeline.dll                                | 2019.150.4053.23 | 1119112   | 25-Jul-20 | 12:31 | x86      |
| Dtspipeline.dll                                | 2019.150.4053.23 | 1328016   | 25-Jul-20 | 12:31 | x64      |
| Dtswizard.exe                                  | 15.0.4053.23     | 885640    | 25-Jul-20 | 12:31 | x64      |
| Dtswizard.exe                                  | 15.0.4053.23     | 889736    | 25-Jul-20 | 12:31 | x86      |
| Dtuparse.dll                                   | 2019.150.4053.23 | 86936     | 25-Jul-20 | 12:31 | x86      |
| Dtuparse.dll                                   | 2019.150.4053.23 | 99216     | 25-Jul-20 | 12:31 | x64      |
| Dtutil.exe                                     | 2019.150.4053.23 | 147344    | 25-Jul-20 | 12:31 | x64      |
| Dtutil.exe                                     | 2019.150.4053.23 | 128904    | 25-Jul-20 | 12:31 | x86      |
| Exceldest.dll                                  | 2019.150.4053.23 | 234384    | 25-Jul-20 | 12:31 | x86      |
| Exceldest.dll                                  | 2019.150.4053.23 | 279440    | 25-Jul-20 | 12:31 | x64      |
| Excelsrc.dll                                   | 2019.150.4053.23 | 258952    | 25-Jul-20 | 12:31 | x86      |
| Excelsrc.dll                                   | 2019.150.4053.23 | 308104    | 25-Jul-20 | 12:31 | x64      |
| Flatfiledest.dll                               | 2019.150.4053.23 | 357264    | 25-Jul-20 | 12:31 | x86      |
| Flatfiledest.dll                               | 2019.150.4053.23 | 410512    | 25-Jul-20 | 12:31 | x64      |
| Flatfilesrc.dll                                | 2019.150.4053.23 | 369544    | 25-Jul-20 | 12:31 | x86      |
| Flatfilesrc.dll                                | 2019.150.4053.23 | 426888    | 25-Jul-20 | 12:31 | x64      |
| Microsoft.sqlserver.astasks.dll                | 15.0.4053.23     | 78736     | 25-Jul-20 | 12:31 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4053.23     | 402320    | 25-Jul-20 | 12:47 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4053.23     | 402312    | 25-Jul-20 | 12:47 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4053.23     | 2999184   | 25-Jul-20 | 12:47 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4053.23     | 2999184   | 25-Jul-20 | 12:47 | x86      |
| Msdtssrvrutil.dll                              | 2019.150.4053.23 | 111512    | 25-Jul-20 | 12:31 | x64      |
| Msdtssrvrutil.dll                              | 2019.150.4053.23 | 99224     | 25-Jul-20 | 12:31 | x86      |
| Msmgdsrv.dll                                   | 2018.150.34.21   | 8277912   | 25-Jul-20 | 12:19 | x86      |
| Oledbdest.dll                                  | 2019.150.4053.23 | 238480    | 25-Jul-20 | 12:31 | x86      |
| Oledbdest.dll                                  | 2019.150.4053.23 | 279432    | 25-Jul-20 | 12:31 | x64      |
| Oledbsrc.dll                                   | 2019.150.4053.23 | 263056    | 25-Jul-20 | 12:31 | x86      |
| Oledbsrc.dll                                   | 2019.150.4053.23 | 312200    | 25-Jul-20 | 12:31 | x64      |
| Sqlscm.dll                                     | 2019.150.4053.23 | 78736     | 25-Jul-20 | 12:47 | x86      |
| Sqlscm.dll                                     | 2019.150.4053.23 | 86920     | 25-Jul-20 | 12:47 | x64      |
| Sqlsvc.dll                                     | 2019.150.4053.23 | 181136    | 25-Jul-20 | 12:47 | x64      |
| Sqlsvc.dll                                     | 2019.150.4053.23 | 148368    | 25-Jul-20 | 12:47 | x86      |
| Sqltaskconnections.dll                         | 2019.150.4053.23 | 168848    | 25-Jul-20 | 12:31 | x86      |
| Sqltaskconnections.dll                         | 2019.150.4053.23 | 201616    | 25-Jul-20 | 12:31 | x64      |
| Txdataconvert.dll                              | 2019.150.4053.23 | 275344    | 25-Jul-20 | 12:31 | x86      |
| Txdataconvert.dll                              | 2019.150.4053.23 | 316304    | 25-Jul-20 | 12:31 | x64      |
| Xe.dll                                         | 2019.150.4053.23 | 631688    | 25-Jul-20 | 12:31 | x86      |
| Xe.dll                                         | 2019.150.4053.23 | 721816    | 25-Jul-20 | 12:31 | x64      |

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
