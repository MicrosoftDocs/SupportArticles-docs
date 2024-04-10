---
title: Cumulative Update 2 for SQL Server 2019 (KB4536075)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 2 (KB4536075).
ms.date: 06/30/2023
ms.custom: KB4536075
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4536075 - Cumulative Update 2 for SQL Server 2019

_Release Date:_ &nbsp; February 13, 2020  
_Version:_ &nbsp; 15.0.4013.40

## Summary

This article describes Cumulative Update package 2 (CU2) for Microsoft SQL Server 2019. This update contains 81 [fixes](#improvements-and-fixes-included-in-this-cumulative-update) that were issued after the release of SQL Server 2019 Cumulative Update 1, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4013.40**, file version: **2019.150.4013.40**
- Analysis Services - Product version: **15.0.34.1**, file version: **2018.150.34.1**

## Known issues in this update

There's a known issue in SQL Server Agent in SQL Server 2019 CU2. This will be fixed in the next CU release (SQL Server 2019 CU3).

- If you're using SQL Server 2019 SQL Server Agent, we recommend that you skip the CU2 update, and install SQL Server 2019 CU3 ([KB4538853](cumulativeupdate3.md)) instead.

- If you have already applied SQL Server 2019 CU2, and you're experiencing issues that affect SQL Server Agent, please install SQL Server 2019 CU3 ([KB4538853](cumulativeupdate3.md)).

## Improvements and fixes included in this cumulative update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|-------------------------------------------------------------------------------------------|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|----------|
| <a id="13322585">[13322585](#13322585)</a> | [FIX: Calculation with summarizecolumn returns unexpected results after upgrading to SSAS 2019 with compatibility level 1500 (KB4538159)](https://support.microsoft.com/help/4538159) | Analysis Services | Analysis Services | Windows |
| <a id="13323995">[13323995](#13323995)</a> | [FIX: Synchronized job may fail when the target servers start to synchronize the database in SQL Server 2016 and 2017 (KB4527355)](https://support.microsoft.com/help/4527355) | Analysis Services | Analysis Services | Windows |
| <a id="13324007">[13324007](#13324007)</a> | [FIX: Memory may not get released when you process partitions with data in SQL Server (KB4529876)](https://support.microsoft.com/help/4529876) | Analysis Services | Analysis Services | Windows |
| <a id="13324021">[13324021](#13324021)</a> | [FIX: IsError function fails to detect error in Excel XIRR function when MDX query is executed from SSIS (KB4530475)](https://support.microsoft.com/help/4530475) | Analysis Services | Analysis Services | Windows |
| <a id="13324038">[13324038](#13324038)</a> | [FIX: User hierarchy is not hidden when you run DISCOVER_CSDL_METADATA in SQL Server 2017 and 2019 (KB4527510)](https://support.microsoft.com/help/4527510) | Analysis Services | Analysis Services | Windows |
| <a id="13299413">[13299413](#13299413)</a> | [FIX: Package execution may be impacted in SQL Server 2019 Integration Services (KB4530097)](https://support.microsoft.com/help/4530097) | Integration Services | Integration Services | Windows |
| <a id="13324029">[13324029](#13324029)</a> | [FIX: Menu and scroll bar are missing in "Changes" section when large number of changesets are added in Excel add-in for MDS in SQL Server 2017 and 2019 (KB4524191)](https://support.microsoft.com/help/4524191) | Master Data Services | Client | Windows |
| <a id="13345413">[13345413](#13345413)</a> | [FIX: Custom date format with time doesn't work properly in SQL Server 2019 Master Data Services (KB4537401)](https://support.microsoft.com/help/4537401) | Master Data Services | Server | Windows |
| <a id="13257853">[13257853](#13257853)</a> | [FIX: SQLDiag fails to generate output due to missing stored procedure tempdb.dbo.sp_sqldiag14 in SQL Server 2017 and 2019 (KB4531736)](https://support.microsoft.com/help/4531736) | SQL Server Client Tools | SQLDiag | Windows |
| <a id="13277345">[13277345](#13277345)</a> | [Improvement: Enable DNN feature in SQL Server 2019 FCI (KB4537868)](https://support.microsoft.com/help/4537868) | SQL Server Connectivity | Protocols | Windows |
| <a id="13200686">[13200686](#13200686)</a> | [FIX: SQL Server database remains in frozen I/O state indefinitely when backed up by VSS (KB4523102)](https://support.microsoft.com/help/4523102) | SQL Server Engine | Backup Restore | Windows |
| <a id="13294980">[13294980](#13294980)</a> | [FIX: Non-yielding scheduler condition occurs when you run batch mode query with multiple joins in SQL Server 2017 and 2019 (KB4538377)](https://support.microsoft.com/help/4538377) | SQL Server Engine | Column Stores | Windows |
| <a id="13324013">[13324013](#13324013)</a> | [FIX: Error 8959 may occur on IAM page when you query sys.dm_db_index_physical_stats against partitioned columnstore table after partition switch in SQL Server (KB4528067)](https://support.microsoft.com/help/4528067) |  SQL Server Engine | Column Stores | Windows |
| <a id="13324015">[13324015](#13324015)</a> | [FIX: Unable to restore SQL Server 2012 databases on SQL Server 2016, 2017 or 2019 because of NCCI (KB4528066)](https://support.microsoft.com/help/4528066) | SQL Server Engine | Column Stores | Windows |
| <a id="13355673">[13355673](#13355673)</a> | [FIX: Access violation occurs when you run DBCC CHECKTABLE against a table with Clustered Columnstore Index in SQL Server 2017 and 2019 (KB4537350)](https://support.microsoft.com/help/4537350) | SQL Server Engine | Column Stores | Windows |
| <a id="13356844">[13356844](#13356844)</a> | [FIX: Changes made using ALTER DATABASE...SQL Server 2019 fails to log changes in SQL Error log or raise database trigger (KB4538573)](https://support.microsoft.com/help/4538573) | SQL Server Engine | DB Management | All |
| <a id="13252064">[13252064](#13252064)</a> | [Improvement: New features included in library management for external languages in SQL Server 2019 (KB4538595)](https://support.microsoft.com/help/4538595) | SQL Server Engine | Extensibility | All |
| <a id="13329355">[13329355](#13329355)</a> | [Improvement: Download new CAB files that have fixes for R/Python runtime features (KB4538205)](https://support.microsoft.com/help/4538205) | SQL Server Engine | Extensibility | Windows |
| <a id="13299424">[13299424](#13299424)</a> | [FIX: External satellite process scripts like R, Python are unable to access any directories outside of their working directory in SQL Server 2019 (KB4533497)](https://support.microsoft.com/help/4533497) | SQL Server Engine | Extensibility | All |
| <a id="13309415">[13309415](#13309415)</a> | [FIX: Unable to execute sys.dm_exec_requests when you install SQL Server 2019 or when you upgrade from prior versions of SQL Server (KB4534249)](https://support.microsoft.com/help/4534249) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13328937">[13328937](#13328937)</a> | [FIX: Log shipping agent is not able to log history and error information to SQL Server 2019 (KB4537869)](https://support.microsoft.com/help/4537869) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13343052">[13343052](#13343052)</a> | [FIX: Error occurs and AG will be in non-synchronizing state when failover happens in primary AG of Distributed Availability Group in SQL Server 2017 on Linux (KB4538174)](https://support.microsoft.com/help/4538174) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="13323987">[13323987](#13323987)</a> | [FIX: Assertion error occurs when you use IDENT_CURRENT on view that has identity columns in SQL Server (KB4528250)](https://support.microsoft.com/help/4528250) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13234378">[13234378](#13234378)</a> | [Improvement: Module and offset information is sent as output for dumps in SQL Server 2019 (KB4538759)](https://support.microsoft.com/help/4538759) | SQL Server Engine | Linux | Linux |
| <a id="13323991">[13323991](#13323991)</a> </br><a id="13324024">[13324024](#13324024)</a> | [FIX: UPDATE STATISTICS takes very long time to generate maintenance plan for large databases in SQL Server (KB4527229)](https://support.microsoft.com/help/4527229) | SQL Server Engine | Management Services | Windows |
| <a id="13317221">[13317221](#13317221)</a> | [Improvement: Port additional two system tables in Tempdb Memory-Optimized Metadata feature in SQL Server 2019 (KB4537749)](https://support.microsoft.com/help/4537749) | SQL Server Engine | Metadata | All |
| <a id="13323218">[13323218](#13323218)</a> | [FIX: Error due to explicit transaction isolation level hint when accessing Memory-Optimized Tempdb catalog views in SQL Server 2019 (KB4537751)](https://support.microsoft.com/help/4537751) | SQL Server Engine | Metadata | Windows |
| <a id="13250169">[13250169](#13250169)</a> | [FIX: Query on Clustered Columnstore Index in SQL Server 2019 uses more CPU time than in SQL Server 2016 (KB4540371)](https://support.microsoft.com/help/4540371) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13324033">[13324033](#13324033)</a> | [FIX: You may receive incorrect object_id after you switch a partition in SQL Server 2017 and 2019 (KB4527916)](https://support.microsoft.com/help/4527916) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13324036">[13324036](#13324036)</a> | [FIX: Exception error 3628 may occur when you run stored procedure in SQL Server (KB4525483)](https://support.microsoft.com/help/4525483) | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13356198">[13356198](#13356198)</a> | [Implement support for Kerberos constrained delegation in SQL Server 2019 on Linux (KB4538382)](https://support.microsoft.com/help/4538382) | SQL Server Engine | PolyBase | Linux |
| <a id="13262515">[13262515](#13262515)</a> | [FIX: PolyBase query may hang if you cancel the query after it is started in SQL Server 2019 (KB4534148)](https://support.microsoft.com/help/4534148) | SQL Server Engine | PolyBase | All |
| <a id="13262847">[13262847](#13262847)</a> | [FIX: PolyBase Engine Service may dump if an error occurs during retrieval of Data Pool metadata in SQL Server 2019 (KB4531232)](https://support.microsoft.com/help/4531232) | SQL Server Engine | PolyBase | Linux |
| <a id="13325916">[13325916](#13325916)</a> | [FIX: XML PATH queries in PolyBase fail with an error in SQL Server 2019 (KB4540372)](https://support.microsoft.com/help/4540372) | SQL Server Engine | PolyBase | Windows |
| <a id="13325930">[13325930](#13325930)</a> | [FIX: XML queries in PolyBase fail with an unknown type error in SQL Server 2019 (KB4539201)](https://support.microsoft.com/help/4539201) | SQL Server Engine | PolyBase | Windows |
| <a id="13326430">[13326430](#13326430)</a> | [FIX: Error occurs when you use PolyBase Generic ODBC connector with backend that has unsupported quote character in SQL Server 2019 (KB4539203)](https://support.microsoft.com/help/4539203) | SQL Server Engine | PolyBase | Windows |
| <a id="13327197">[13327197](#13327197)</a> | [FIX: Error occurs when you run queries in PolyBase scale-out groups in SQL Server 2019 (KB4538161)](https://support.microsoft.com/help/4538161) | SQL Server Engine | PolyBase | Windows |
| <a id="13333719">[13333719](#13333719)</a> | [FIX: Unable to start PolyBase services when TCP/IP is not enabled in SQL Server 2019 Developer Edition (KB4538162)](https://support.microsoft.com/help/4538162) | SQL Server Engine | PolyBase | Windows |
| <a id="13333721">[13333721](#13333721)</a> | [FIX: Error occurs when QDS is turned on or you generate query plan for Polybase queries in SQL Server 2019 (KB4536684)](https://support.microsoft.com/help/4536684) | SQL Server Engine | PolyBase | All |
| <a id="13333730">[13333730](#13333730)</a> | [FIX: Creating an external table against an Oracle database in SQL Server 2019 may fail if using Oracle database 12.2 or later versions (KB4537072)](https://support.microsoft.com/help/4537072) | SQL Server Engine | PolyBase | All |
| <a id="13333743">[13333743](#13333743)</a> | [FIX: PolyBase may fail to generate dumps if an error occurs during the distributed query optimization phase in SQL Server 2019 (KB4538163)](https://support.microsoft.com/help/4538163) | SQL Server Engine | PolyBase | All |
| <a id="13334474">[13334474](#13334474)</a> | [FIX: Error occurs when you run the same PolyBase query multiple times in SQL Server 2019 (KB4538164)](https://support.microsoft.com/help/4538164) | SQL Server Engine | PolyBase | All |
| <a id="13356782">[13356782](#13356782)</a> | [FIX: PolyBase query execution time may increase exponentially when you run concurrent queries in SQL Server 2019 (KB4538968)](https://support.microsoft.com/help/4538968) | SQL Server Engine | PolyBase | All |
| <a id="13356818">[13356818](#13356818)</a> | [FIX: Map large fixed width types to variable width types in PolyBase in SQL Server 2019 (KB4539198)](https://support.microsoft.com/help/4539198) | SQL Server Engine | PolyBase | All |
| <a id="13356967">[13356967](#13356967)</a> | [FIX: PolyBase defaults string mapping for Microsoft Spark ODBC driver in SQL Server 2019 (KB4539199)](https://support.microsoft.com/help/4539199) | SQL Server Engine | PolyBase | All |
| <a id="13356977">[13356977](#13356977)</a> | [FIX: Internal DMS error when you use PolyBase Generic ODBC connector in SQL Server 2019 (KB4539200)](https://support.microsoft.com/help/4539200) | SQL Server Engine | PolyBase | All |
| <a id="13373021">[13373021](#13373021)</a> | [FIX: Issue occurs when using PolyBase for SQL Server 2019 generic ODBC with drivers from Microsoft Access Database Engine Redistributable package (KB4539340)](https://support.microsoft.com/help/4539340) | SQL Server Engine | PolyBase | All |
| <a id="13262635">[13262635](#13262635)</a> | [FIX: Queries may fail in SQL Server 2019 when PolyBase is under stress and heavy cancellations (KB4531384)](https://support.microsoft.com/help/4531384) | SQL Server Engine | Programmability | All |
| <a id="13314681">[13314681](#13314681)</a> | [FIX: Access violation occurs when you create remote stored procedure with one of the system variable (@@servername, @@servicename) in SQL Server 2019 (KB4538495)](https://support.microsoft.com/help/4538495) | SQL Server Engine | Programmability | Windows |
| <a id="13342963">[13342963](#13342963)</a> | [FIX: Error 544 occurs when you use SET IDENTITY_INSERT on temp table in SQL Server 2019 (KB4537347)](https://support.microsoft.com/help/4537347) | SQL Server Engine | Programmability | All |
| <a id="13345912">[13345912](#13345912)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="13323997">[13323997](#13323997)</a> | [FIX: Access violation occurs when you use sys.dm_os_memory_objects in SQL Server (KB4530212)](https://support.microsoft.com/help/4530212) | SQL Server Engine | Query Execution | Linux |
| <a id="13324000">[13324000](#13324000)</a> | [FIX: Error 8601 occurs when you run a query with partition function in SQL Server (KB4530251)](https://support.microsoft.com/help/4530251) | SQL Server Engine | Query Execution | Windows |
| <a id="13324003">[13324003](#13324003)</a> | [FIX: Non-yielding scheduler issue occurs in SQL Server when you run an online build for an index that's not partition-aligned (KB4530443)](https://support.microsoft.com/help/4530443) | SQL Server Engine | Query Execution | Windows |
| <a id="13324009">[13324009](#13324009)</a> | [FIX: You may encounter a non-yielding scheduler condition when you run query with parallel batch-mode sort operator in SQL Server (KB4527716)](https://support.microsoft.com/help/4527716) | SQL Server Engine | Query Execution | Windows |
| <a id="13303147">[13303147](#13303147)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Query Optimizer | Windows |
| <a id="13323989">[13323989](#13323989)</a> | [FIX: CREATE INDEX with new CE reads the partition table and results in huge row count higher than the total table row count in SQL Server (KB4531010)](https://support.microsoft.com/help/4531010) | SQL Server Engine | Query Optimizer | Windows |
| <a id="13330439">[13330439](#13330439)</a> | [FIX: Logreader doesn't execute when you upgrade from SQL Server 2017 to 2019 (KB4537452)](https://support.microsoft.com/help/4537452) | SQL Server Engine | Replication | Windows |
| <a id="13324026">[13324026](#13324026)</a> | [FIX: sp_describe_parameter_encryption returns different results if you switch parameter positions in SQL Server 2017 and 2019 (KB4529833)](https://support.microsoft.com/help/4529833) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13347083">[13347083](#13347083)</a> | [FIX: Unable to encrypt data when using column encryption with symmetric keys in SQL Server 2019 (KB4538496)](https://support.microsoft.com/help/4538496) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13355058">[13355058](#13355058)</a> | [FIX: Latest drivers fail to work with in-memory compiled queries in SQL Server 2019 (KB4538342)](https://support.microsoft.com/help/4538342) | SQL Server Engine | Security Infrastructure | All |
| <a id="13355108">[13355108](#13355108)</a> | [FIX: Passwords are masked in audit logs in SQL Server 2019 (KB4538344)](https://support.microsoft.com/help/4538344) | SQL Server Engine | Security Infrastructure | All |
| <a id="13356850">[13356850](#13356850)</a> | [FIX: Exception occurs when you run UNION ALL+ORDER BY/MERGE UNION ALL queries on table that contains randomized encrypted data in SQL Server 2019 (KB4538481)](https://support.microsoft.com/help/4538481) | SQL Server Engine | Security Infrastructure | All |
| <a id="13358159">[13358159](#13358159)</a> | [FIX: Login and logout failures occur while auditing data classification attributes in SQL Server 2019 (KB4538575)](https://support.microsoft.com/help/4538575) | SQL Server Engine | Security Infrastructure | All |
| <a id="13333564">[13333564](#13333564)</a> | [Improvement: Add BDC storage pool cache in SQL Server 2019 (KB4538978)](https://support.microsoft.com/help/4538978) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13333572">[13333572](#13333572)</a> | [FIX: Error occurs while creating External Data Source for Data Pool that has nondefault name for LOCATION in SQL Server 2019 (KB4536841)](https://support.microsoft.com/help/4536841) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13334483">[13334483](#13334483)</a> | [FIX: SSMS showplan error occurs for BDC query in SQL Server 2019 (KB4539000)](https://support.microsoft.com/help/4539000) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13336003">[13336003](#13336003)</a> | [FIX: Dumps occur because of OOM condition in SQL Server 2019 (KB4538858)](https://support.microsoft.com/help/4538858) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13343690">[13343690](#13343690)</a> | [FIX: Error occurs when you query storage pool external table that contains column with money data type in SQL Server 2019 BDC (KB4538036)](https://support.microsoft.com/help/4538036) | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13443207">[13443207](#13443207)</a> | [FIX: Memory leak by Controller container in SQL Server 2019 BDC (KB4551838)](https://support.microsoft.com/help/4551838) | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13262799">[13262799](#13262799)</a> | [Improvement: Use QUOTENAME with EXECUTE AT to query on table that has column name with quotes in SQL Server 2019 (KB4538112)](https://support.microsoft.com/help/4538112) | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13356829">[13356829](#13356829)</a> | [Improvement: Add BDC data/storage pool nodes DMVs in SQL Server 2019 (KB4538689)](https://support.microsoft.com/help/4538689) | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="13324019">[13324019](#13324019)</a> | [FIX: Scripts generated by SSMS collect different wait types after you install SQL Server (KB4530259)](https://support.microsoft.com/help/4530259) | SQL Server Engine | SQL OS | Windows |
| <a id="13329379">[13329379](#13329379)</a> | [FIX: Fix incorrect memory page accounting that causes out-of-memory errors in SQL Server 2019 (KB4536005)](https://support.microsoft.com/help/4536005) | SQL Server Engine | SQL OS | All |
| <a id="13336034">[13336034](#13336034)</a> | [FIX: Severe spinlock contention occurs in SQL Server 2019 (KB4538688)](https://support.microsoft.com/help/4538688) | SQL Server Engine | SQL OS | All |
| <a id="13346172">[13346172](#13346172)</a> | [FIX: SOS_BLOCKALLOCPARTIALLIST spin lock contention may occur when TF 834 is enabled in SQL Server 2019 (KB4537710)](https://support.microsoft.com/help/4537710) | SQL Server Engine | SQL OS | All |
| <a id="13359683">[13359683](#13359683)</a> | [FIX: Null pointer exception error occurs when "latch_suspend_end" XEvent is enabled in SQL Server 2019 (KB4539197)](https://support.microsoft.com/help/4539197) | SQL Server Engine | SQL OS | All |
| <a id="13281112">[13281112](#13281112)</a> | `DBCC STACKDUMP` command was extended to support generating dumps of different types: mini, filtered, full dumps. It also allows you to limit the text output in the additional text file that gets generated with the memory dump. </br></br>DBCC STACKDUMP WITH MINI_DUMP \| FILTERED_DUMP \| FULL_DUMP [, TEXT_DUMP = LIMITED \| DETAILED] | SQL Server Engine | SQL OS | All |
| <a id="13343031">[13343031](#13343031)</a> | [FIX: The "is_media_read_only" value remains unchanged for a SQL Server data file even though the media is no longer read-only (KB4538378)](https://support.microsoft.com/help/4538378) | SQL Server Engine | Storage Management | Windows |
| <a id="13314029">[13314029](#13314029)</a> | [FIX: Severe contention on LOGCACHE_ACCESS spinlock in SQL Server 2019 (KB4538017)](https://support.microsoft.com/help/4538017) | SQL Server Engine | Transaction Services | All |
| <a id="13357903">[13357903](#13357903)</a> | [FIX: Error occurs in sp_xml_preparedocument where MSXMLSQL tries to access virtual address space beyond limit in SQL Server 2017 and 2019 (KB4540449)](https://support.microsoft.com/help/4540449) | SQL Server Engine | XML | All |
| <a id="13323999">[13323999](#13323999)</a> | [FIX: MDS and/or LocalDB patch installation fails if you patch SQL Server with a next CU (KB4524542)](https://support.microsoft.com/help/4524542) | SQL Setup | Patching | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU2 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/02/sqlserver2019-kb4536075-x64_b6c415cb0ce781e3e40e263d68dca6e3bc70a07d.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4536075-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4536075-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4536075-x64.exe|C22C3FE73AB0AB18F3E86BE77E26A21B8E929101B94A99044084166DDD6098E9|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.1    | 291728    | 03-Feb-20 | 17:16 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 03-Feb-20 | 17:16 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.1        | 757136    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 174480    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 198544    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 201104    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 197520    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 213904    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 196496    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 192400    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 251280    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 172944    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.1        | 195984    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.1        | 1096584   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.1        | 479624    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 53648     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 58256     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 58256     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 57744     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 60816     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 57232     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 57224     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 66448     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 52624     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.1        | 57232     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16776     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16776     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 17808     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.1        | 16784     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 03-Feb-20 | 17:16 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 03-Feb-20 | 17:16 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 03-Feb-20 | 17:16 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 03-Feb-20 | 17:16 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 03-Feb-20 | 17:16 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 03-Feb-20 | 17:16 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 03-Feb-20 | 17:16 | x86      |
| Msmdctr.dll                                               | 2018.150.34.1    | 37264     | 03-Feb-20 | 17:16 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.1    | 66198408  | 03-Feb-20 | 17:16 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.1    | 47711632  | 03-Feb-20 | 17:16 | x86      |
| Msmdpump.dll                                              | 2018.150.34.1    | 10187664  | 03-Feb-20 | 17:16 | x64      |
| Msmdredir.dll                                             | 2018.150.34.1    | 7955336   | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 15760     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 15760     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 16272     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 15760     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 16272     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 16272     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 16272     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 17296     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 15760     | 03-Feb-20 | 17:16 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.1        | 15760     | 03-Feb-20 | 17:16 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.1    | 65733008  | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 832400    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1627024   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1452936   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1641872   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1607560   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1000336   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 991120    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1535888   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1520528   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 809872    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.1    | 1595280   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 831376    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1623440   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1449872   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1636752   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1603472   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 997776    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 990088    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1531792   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1516944   | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 808848    | 03-Feb-20 | 17:16 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.1    | 1590672   | 03-Feb-20 | 17:16 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.1    | 10184584  | 03-Feb-20 | 17:16 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.1    | 8278416   | 03-Feb-20 | 17:16 | x86      |
| Msolap.dll                                                | 2018.150.34.1    | 11014544  | 03-Feb-20 | 17:16 | x64      |
| Msolap.dll                                                | 2018.150.34.1    | 8607120   | 03-Feb-20 | 17:16 | x86      |
| Msolui.dll                                                | 2018.150.34.1    | 305552    | 03-Feb-20 | 17:16 | x64      |
| Msolui.dll                                                | 2018.150.34.1    | 285064    | 03-Feb-20 | 17:16 | x86      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 03-Feb-20 | 17:16 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 03-Feb-20 | 17:16 | x64      |
| Sqlceip.exe                                               | 15.0.4013.40     | 283528    | 03-Feb-20 | 17:16 | x86      |
| Sqldumper.exe                                             | 2019.150.4013.40 | 152664    | 03-Feb-20 | 17:16 | x86      |
| Sqldumper.exe                                             | 2019.150.4013.40 | 185432    | 03-Feb-20 | 17:16 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 03-Feb-20 | 17:16 | x86      |
| Tmapi.dll                                                 | 2018.150.34.1    | 6177168   | 03-Feb-20 | 17:16 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.1    | 4916624   | 03-Feb-20 | 17:16 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.1    | 1183632   | 03-Feb-20 | 17:16 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.1    | 6802312   | 03-Feb-20 | 17:16 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.1    | 26021264  | 03-Feb-20 | 17:16 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.1    | 35457928  | 03-Feb-20 | 17:16 | x86      |

SQL Server 2019 Database Services Common Core

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll | 2019.150.4013.40 | 74840     | 03-Feb-20 | 17:16 | x86      |
| Instapi150.dll | 2019.150.4013.40 | 87128     | 03-Feb-20 | 17:16 | x64      |
| Msasxpress.dll | 2018.150.34.1    | 26000     | 03-Feb-20 | 17:16 | x86      |
| Msasxpress.dll | 2018.150.34.1    | 31120     | 03-Feb-20 | 17:16 | x64      |
| Sqldumper.exe  | 2019.150.4013.40 | 152664    | 03-Feb-20 | 17:16 | x86      |
| Sqldumper.exe  | 2019.150.4013.40 | 185432    | 03-Feb-20 | 17:16 | x64      |
| Sqlmanager.dll | 2019.150.4013.40 | 742280    | 03-Feb-20 | 17:16 | x86      |
| Sqlmanager.dll | 2019.150.4013.40 | 873352    | 03-Feb-20 | 17:16 | x64      |

SQL Server 2019 sql_dreplay_client

|     File name     |   File version   | File size |    Date   |  Time | Platform |
|:-----------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll | 2019.150.4013.40 | 665176    | 03-Feb-20 | 17:16 | x86      |
| Dreplayutil.dll   | 2019.150.4013.40 | 304008    | 03-Feb-20 | 17:17 | x86      |
| Instapi150.dll    | 2019.150.4013.40 | 87128     | 03-Feb-20 | 17:16 | x64      |

SQL Server 2019 sql_dreplay_controller

|     File name     |   File version   | File size |    Date   |  Time | Platform |
|:-----------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll | 2019.150.4013.40 | 665176    | 03-Feb-20 | 17:16 | x86      |
| Instapi150.dll    | 2019.150.4013.40 | 87128     | 03-Feb-20 | 17:16 | x64      |

SQL Server 2019 Database Services Core Instance

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll     | 2019.150.4013.40 | 4653168   | 03-Feb-20 | 18:16 | x64      |
| Aetm-enclave.dll               | 2019.150.4013.40 | 4603744   | 03-Feb-20 | 18:16 | x64      |
| Aetm-sgx-enclave-simulator.dll | 2019.150.4013.40 | 4924648   | 03-Feb-20 | 18:16 | x64      |
| Aetm-sgx-enclave.dll           | 2019.150.4013.40 | 4866464   | 03-Feb-20 | 18:16 | x64      |
| Azureattest.dll                | 10.0.18965.1000  | 255056    | 03-Feb-20 | 17:19 | x64      |
| Azureattestmanager.dll         | 10.0.18965.1000  | 97528     | 03-Feb-20 | 17:19 | x64      |
| Hkcompile.dll                  | 2019.150.4013.40 | 1291352   | 03-Feb-20 | 18:16 | x64      |
| Hkengine.dll                   | 2019.150.4013.40 | 5784456   | 03-Feb-20 | 18:16 | x64      |
| Hkruntime.dll                  | 2019.150.4013.40 | 181128    | 03-Feb-20 | 18:16 | x64      |
| Hktempdb.dll                   | 2019.150.4013.40 | 62344     | 03-Feb-20 | 18:16 | x64      |
| Qds.dll                        | 2019.150.4013.40 | 1176456   | 03-Feb-20 | 18:16 | x64      |
| Rsfxft.dll                     | 2019.150.4013.40 | 50264     | 03-Feb-20 | 18:16 | x64      |
| Secforwarder.dll               | 2019.150.4013.40 | 78728     | 03-Feb-20 | 18:16 | x64      |
| Sqlaamss.dll                   | 2019.150.4013.40 | 107400    | 03-Feb-20 | 18:16 | x64      |
| Sqlaccess.dll                  | 2019.150.4013.40 | 492424    | 03-Feb-20 | 18:16 | x64      |
| Sqlagent.exe                   | 2019.150.4013.40 | 721800    | 03-Feb-20 | 18:16 | x64      |
| Sqlceip.exe                    | 15.0.4013.40     | 283528    | 03-Feb-20 | 18:16 | x86      |
| Sqlcmdss.dll                   | 2019.150.4013.40 | 86920     | 03-Feb-20 | 18:16 | x64      |
| Sqlctr150.dll                  | 2019.150.4013.40 | 140168    | 03-Feb-20 | 18:16 | x64      |
| Sqlctr150.dll                  | 2019.150.4013.40 | 115592    | 03-Feb-20 | 18:16 | x86      |
| Sqldk.dll                      | 2019.150.4013.40 | 3138440   | 03-Feb-20 | 18:16 | x64      |
| Sqldtsss.dll                   | 2019.150.4013.40 | 107400    | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 1586056   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3482504   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3675016   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 4142168   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 4256864   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3396696   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3560536   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 4133768   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3990408   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 4039560   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 2208856   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 2159704   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3847256   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3523464   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3994504   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3802200   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3797896   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3593304   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3482712   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 1528928   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 3888008   | 03-Feb-20 | 18:16 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4013.40 | 4007000   | 03-Feb-20 | 18:16 | x64      |
| Sqllang.dll                    | 2019.150.4013.40 | 39523208  | 03-Feb-20 | 18:17 | x64      |
| Sqlmin.dll                     | 2019.150.4013.40 | 40123784  | 03-Feb-20 | 18:16 | x64      |
| Sqlolapss.dll                  | 2019.150.4013.40 | 103512    | 03-Feb-20 | 18:16 | x64      |
| Sqlos.dll                      | 2019.150.4013.40 | 45960     | 03-Feb-20 | 18:16 | x64      |
| Sqlpowershellss.dll            | 2019.150.4013.40 | 83056     | 03-Feb-20 | 18:16 | x64      |
| Sqlrepss.dll                   | 2019.150.4013.40 | 83032     | 03-Feb-20 | 18:16 | x64      |
| Sqlscriptdowngrade.dll         | 2019.150.4013.40 | 41864     | 03-Feb-20 | 18:16 | x64      |
| Sqlscriptupgrade.dll           | 2019.150.4013.40 | 5903448   | 03-Feb-20 | 18:16 | x64      |
| Sqlservr.exe                   | 2019.150.4013.40 | 623496    | 03-Feb-20 | 18:16 | x64      |
| Sqlsvc.dll                     | 2019.150.4013.40 | 181336    | 03-Feb-20 | 18:16 | x64      |
| Sqltses.dll                    | 2019.150.4013.40 | 9069448   | 03-Feb-20 | 18:16 | x64      |
| Svl.dll                        | 2019.150.4013.40 | 160648    | 03-Feb-20 | 18:16 | x64      |
| Xpstar.dll                     | 2019.150.4013.40 | 471944    | 03-Feb-20 | 18:16 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                  | 2019.150.4013.40 | 3142536   | 03-Feb-20 | 17:16 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4013.40 | 566360    | 03-Feb-20 | 17:15 | x64      |
| Dtspipeline.dll                                          | 2019.150.4013.40 | 1328216   | 03-Feb-20 | 17:16 | x64      |
| Flatfiledest.dll                                         | 2019.150.4013.40 | 410504    | 03-Feb-20 | 17:15 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4013.40 | 427104    | 03-Feb-20 | 17:15 | x64      |
| Logread.exe                                              | 2019.150.4013.40 | 717704    | 03-Feb-20 | 17:15 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4013.40     | 58248     | 03-Feb-20 | 17:15 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4013.40     | 390024    | 03-Feb-20 | 17:16 | x86      |
| Msoledbsql.dll                                           | 2018.182.3.0     | 148432    | 03-Feb-20 | 17:16 | x64      |
| Msxmlsql.dll                                             | 2019.150.4013.40 | 1496152   | 03-Feb-20 | 17:16 | x64      |
| Osql.exe                                                 | 2019.150.4013.40 | 91224     | 03-Feb-20 | 17:16 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4013.40 | 496520    | 03-Feb-20 | 17:15 | x64      |
| Rdistcom.dll                                             | 2019.150.4013.40 | 914520    | 03-Feb-20 | 17:16 | x64      |
| Replmerg.exe                                             | 2019.150.4013.40 | 562264    | 03-Feb-20 | 17:16 | x64      |
| Replprov.dll                                             | 2019.150.4013.40 | 852872    | 03-Feb-20 | 17:16 | x64      |
| Replrec.dll                                              | 2019.150.4013.40 | 1029208   | 03-Feb-20 | 17:15 | x64      |
| Replsub.dll                                              | 2019.150.4013.40 | 471944    | 03-Feb-20 | 17:16 | x64      |
| Spresolv.dll                                             | 2019.150.4013.40 | 275336    | 03-Feb-20 | 17:16 | x64      |
| Sqldiag.exe                                              | 2019.150.4013.40 | 1139800   | 03-Feb-20 | 17:16 | x64      |
| Sqllogship.exe                                           | 15.0.4013.40     | 103304    | 03-Feb-20 | 17:16 | x64      |
| Sqlsvc.dll                                               | 2019.150.4013.40 | 148568    | 03-Feb-20 | 17:15 | x86      |
| Sqlsvc.dll                                               | 2019.150.4013.40 | 181336    | 03-Feb-20 | 17:15 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4013.40 | 91016     | 03-Feb-20 | 17:17 | x64      |
| Exthost.exe        | 2019.150.4013.40 | 230280    | 03-Feb-20 | 17:17 | x64      |
| Launchpad.exe      | 2019.150.4013.40 | 1225608   | 03-Feb-20 | 17:17 | x64      |
| Sqlsatellite.dll   | 2019.150.4013.40 | 1020808   | 03-Feb-20 | 17:17 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4013.40 | 29576     | 03-Feb-20 | 17:16 | x86      |

SQL Server 2019 Integration Services

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                  | 2019.150.4013.40 | 3142536   | 03-Feb-20 | 17:34 | x64      |
| Dts.dll                                                  | 2019.150.4013.40 | 2765704   | 03-Feb-20 | 17:34 | x86      |
| Dtsmsg150.dll                                            | 2019.150.4013.40 | 553864    | 03-Feb-20 | 17:34 | x86      |
| Dtsmsg150.dll                                            | 2019.150.4013.40 | 566360    | 03-Feb-20 | 17:34 | x64      |
| Dtspipeline.dll                                          | 2019.150.4013.40 | 1328216   | 03-Feb-20 | 17:34 | x64      |
| Dtspipeline.dll                                          | 2019.150.4013.40 | 1119112   | 03-Feb-20 | 17:34 | x86      |
| Flatfiledest.dll                                         | 2019.150.4013.40 | 410504    | 03-Feb-20 | 17:34 | x64      |
| Flatfiledest.dll                                         | 2019.150.4013.40 | 357464    | 03-Feb-20 | 17:34 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4013.40 | 369544    | 03-Feb-20 | 17:34 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4013.40 | 427104    | 03-Feb-20 | 17:34 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4013.40     | 58480     | 03-Feb-20 | 17:34 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4013.40     | 58248     | 03-Feb-20 | 17:34 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4013.40     | 390024    | 03-Feb-20 | 17:34 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4013.40     | 140376    | 03-Feb-20 | 17:34 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4013.40     | 140376    | 03-Feb-20 | 17:34 | x86      |
| Msdtssrvr.exe                                            | 15.0.4013.40     | 217992    | 03-Feb-20 | 17:34 | x64      |
| Msmdpp.dll                                               | 2018.150.34.1    | 10062224  | 03-Feb-20 | 17:16 | x64      |
| Odbcdest.dll                                             | 2019.150.4013.40 | 369752    | 03-Feb-20 | 17:34 | x64      |
| Odbcdest.dll                                             | 2019.150.4013.40 | 316296    | 03-Feb-20 | 17:34 | x86      |
| Odbcsrc.dll                                              | 2019.150.4013.40 | 382040    | 03-Feb-20 | 17:34 | x64      |
| Odbcsrc.dll                                              | 2019.150.4013.40 | 328584    | 03-Feb-20 | 17:34 | x86      |
| Sqlceip.exe                                              | 15.0.4013.40     | 283528    | 03-Feb-20 | 17:34 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1826.0      | 557904    | 03-Feb-20 | 18:10 | x86      |
| Dmsnative.dll                                                        | 2018.150.1826.0  | 138880    | 03-Feb-20 | 18:10 | x64      |
| Dwengineservice.dll                                                  | 15.0.1826.0      | 50512     | 03-Feb-20 | 18:10 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008       | 17142672  | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003       | 146304    | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108        | 2365520   | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272       | 2199120   | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272       | 144976    | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217        | 2408016   | 03-Feb-20 | 18:10 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39         | 2928720   | 03-Feb-20 | 18:10 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109768  | 03-Feb-20 | 18:10 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109832  | 03-Feb-20 | 18:10 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2425288   | 03-Feb-20 | 18:10 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2431880   | 03-Feb-20 | 18:10 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124        | 15488080  | 03-Feb-20 | 18:10 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1775048   | 03-Feb-20 | 18:10 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1783688   | 03-Feb-20 | 18:10 | x64      |
| Instapi150.dll                                                       | 2019.150.4013.40 | 87128     | 03-Feb-20 | 18:10 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10         | 2620304   | 03-Feb-20 | 18:10 | x64      |
| Libcrypto                                                            | 1.1.1.4          | 2953680   | 03-Feb-20 | 18:10 | x64      |
| Libsasl.dll                                                          | 2.1.26.0         | 292224    | 03-Feb-20 | 18:10 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10         | 648080    | 03-Feb-20 | 18:10 | x64      |
| Libssl                                                               | 1.1.1.4          | 798160    | 03-Feb-20 | 18:10 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1826.0      | 73344     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1826.0      | 299344    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1826.0      | 1956688   | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1826.0      | 176256    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1826.0      | 626304    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1826.0      | 249472    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1826.0      | 144504    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1826.0      | 85840     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1826.0      | 56960     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1826.0      | 94336     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1826.0      | 1134720   | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1826.0      | 86656     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1826.0      | 76416     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1826.0      | 41296     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1826.0      | 36992     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1826.0      | 52048     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1826.0      | 27472     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1826.0      | 32384     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1826.0      | 137344    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1826.0      | 92496     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1826.0      | 106832    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1826.0      | 295248    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 124752    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 141952    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 145256    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 141648    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 153728    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 143696    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 138368    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 178816    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 122192    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1826.0      | 140416    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1826.0      | 78672     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1826.0      | 27776     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1826.0      | 43136     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1826.0      | 134480    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1826.0      | 3034240   | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1826.0      | 3959120   | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 124032    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 138880    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 143488    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 139384    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 154240    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 139904    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 136320    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 176976    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 121168    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1826.0      | 137856    | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1826.0      | 72528     | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1826.0      | 2688128   | 03-Feb-20 | 18:10 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1826.0      | 2442360   | 03-Feb-20 | 18:10 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4013.40 | 451672    | 03-Feb-20 | 18:10 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4013.40 | 7394184   | 03-Feb-20 | 18:10 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1     | 2016120   | 03-Feb-20 | 18:10 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1     | 720792    | 03-Feb-20 | 18:10 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1     | 138136    | 03-Feb-20 | 18:10 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1     | 175000    | 03-Feb-20 | 18:10 | x64      |
| Saslplain.dll                                                        | 2.1.26.0         | 170880    | 03-Feb-20 | 18:10 | x64      |
| Secforwarder.dll                                                     | 2019.150.4013.40 | 78728     | 03-Feb-20 | 18:10 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1826.0  | 66688     | 03-Feb-20 | 18:10 | x64      |
| Sqldk.dll                                                            | 2019.150.4013.40 | 3138440   | 03-Feb-20 | 18:10 | x64      |
| Sqldumper.exe                                                        | 2019.150.4013.40 | 185432    | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 1586056   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 4142168   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 3396696   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 4133768   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 4039560   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 2208856   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 2159704   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 3802200   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 3797896   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 1528928   | 03-Feb-20 | 18:10 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4013.40 | 4007000   | 03-Feb-20 | 18:10 | x64      |
| Sqlos.dll                                                            | 2019.150.4013.40 | 45960     | 03-Feb-20 | 18:10 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1826.0  | 4846928   | 03-Feb-20 | 18:10 | x64      |
| Sqltses.dll                                                          | 2019.150.4013.40 | 9069448   | 03-Feb-20 | 18:10 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078     | 14995920  | 03-Feb-20 | 18:10 | x64      |
| Terasso.dll                                                          | 16.20.0.13       | 2158896   | 03-Feb-20 | 18:10 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0         | 281472    | 03-Feb-20 | 18:10 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4013.40 | 29576     | 03-Feb-20 | 17:16 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                        | 2019.150.4013.40 | 2765704   | 03-Feb-20 | 17:29 | x86      |
| Dts.dll                                        | 2019.150.4013.40 | 3142536   | 03-Feb-20 | 17:29 | x64      |
| Dtsmsg150.dll                                  | 2019.150.4013.40 | 553864    | 03-Feb-20 | 17:28 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4013.40 | 566360    | 03-Feb-20 | 17:28 | x64      |
| Dtspipeline.dll                                | 2019.150.4013.40 | 1119112   | 03-Feb-20 | 17:29 | x86      |
| Dtspipeline.dll                                | 2019.150.4013.40 | 1328216   | 03-Feb-20 | 17:29 | x64      |
| Flatfiledest.dll                               | 2019.150.4013.40 | 357464    | 03-Feb-20 | 17:28 | x86      |
| Flatfiledest.dll                               | 2019.150.4013.40 | 410504    | 03-Feb-20 | 17:28 | x64      |
| Flatfilesrc.dll                                | 2019.150.4013.40 | 369544    | 03-Feb-20 | 17:28 | x86      |
| Flatfilesrc.dll                                | 2019.150.4013.40 | 427104    | 03-Feb-20 | 17:28 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4013.40     | 402312    | 03-Feb-20 | 17:29 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4013.40     | 2999176   | 03-Feb-20 | 17:29 | x86      |
| Msmgdsrv.dll                                   | 2018.150.34.1    | 8278416   | 03-Feb-20 | 17:29 | x86      |
| Sqlsvc.dll                                     | 2019.150.4013.40 | 148568    | 03-Feb-20 | 17:28 | x86      |
| Sqlsvc.dll                                     | 2019.150.4013.40 | 181336    | 03-Feb-20 | 17:29 | x64      |

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
