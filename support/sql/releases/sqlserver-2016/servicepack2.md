---
title: SQL Server 2016 Service Pack 2 release information (KB4052908)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 release information (KB4052908).
ms.date: 10/26/2023
ms.custom: KB4052908
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
---

# KB4052908 - SQL Server 2016 Service Pack 2 release information

_Release Date:_ &nbsp; April 24, 2018  
_Version:_ &nbsp; 13.0.5026.0

This article contains important information to read before you install Microsoft SQL Server 2016 Service Pack 2 (SP2). It describes how to get the service pack, the list of fixes that are included in the service pack, known issues, and a list of copyright attributions for the product.

> [!NOTE]
> This article serves as a single source of information to locate all documentation that's related to this service pack. It includes all the information that you previously found in the release notes and *Readme.txt* files.

## List of fixes included in SQL Server 2016 SP2

Microsoft SQL Server 2016 service packs are cumulative updates. SQL Server 2016 SP2 upgrades all editions and service levels of SQL Server 2016 to SQL Server 2016 SP2. In addition to the fixes that are listed in this article, SQL Server 2016 SP2 includes hotfixes that were included in [SQL Server 2016 Cumulative Update 1 (CU1)](rtm-cumulativeupdate1.md) to [SQL Server 2016 SP1 CU8](servicepack1-cumulativeupdate8.md).

For more information about the cumulative updates that are available in SQL Server 2016, see [SQL Server 2016 build versions](build-versions.md).

> [!NOTE]
>
> - Additional fixes that aren't documented here may also be included in the service pack.
> - This list will be updated when more articles are released.

For more information about the bugs that are fixed in SQL Server 2016 SP2, go to the following Microsoft Knowledge Base articles.

| Bug reference | Description |
|---|---|
| <a id="3507192">[3507192](#3507192)</a> | [Optimizer row goal information in query execution plan added in SQL Server 2017 CU3 and SQL Server 2016 SP2 (KB4051361)](https://support.microsoft.com/help/4051361) |
| <a id="5660983">[5660983](#5660983)</a> | [Update adds new columns to SYS.DM_EXEC_QUERY_STATS DMV in SQL Server 2016 SP2 (KB4051358)](https://support.microsoft.com/help/4051358) |
| <a id="8742052">[8742052](#8742052)</a> | [Improvement: General improvements to the change tracking cleanup process in SQL Server 2016 and 2017 (KB4054842)](https://support.microsoft.com/help/4054842) |
| <a id="9443219">[9443219](#9443219)</a> | [Update to add a new column to DMV sys.dm_sql_referenced_entities in SQL Server 2016 SP2 (KB4038418)](https://support.microsoft.com/help/4038418) |
| <a id="9824203">[9824203](#9824203)</a> | [Improves the Distribution Agent cleanup procedure to increase the transactional replication performance in SQL Server 2016 (KB4092069)](https://support.microsoft.com/help/4092069) |
| <a id="9956170">[9956170](#9956170)</a> | [Update adds the "CLR strict security" feature to SQL Server 2016 (KB4018930)](https://support.microsoft.com/help/4018930) |
| <a id="10385772">[10385772](#10385772)</a> | [Improve tempdb spill diagnostics in DMV and Extended Events in SQL Server 2017 and SQL Server 2016 SP2 (KB4041814)](https://support.microsoft.com/help/4041814) |
| <a id="10696815">[10696815](#10696815)</a> | [Update adds CPU timeout setting to Resource Governor workgroup REQUEST_MAX_CPU_TIME_SEC in SQL Server 2016 and 2017 (KB4038419)](https://support.microsoft.com/help/4038419) |
| <a id="10726760">[10726760](#10726760)</a> | [Update for manual change tracking cleanup procedure in SQL Server 2016 and 2017 (KB4052129)](https://support.microsoft.com/help/4052129) |
| <a id="10727775">[10727775](#10727775)</a> | [Update adds support for MAXDOP option for CREATE STATISTICS and UPDATE STATISTICS statements in SQL Server 2016 and 2017 (KB4041809)](https://support.microsoft.com/help/4041809) |
| <a id="10732726">[10732726](#10732726)</a> | [Improve query performance on a partitioned table in SQL Server 2016 SP2 (KB4052137)](https://support.microsoft.com/help/4052137) |
| <a id="10871974">[10871974](#10871974)</a> | [Unified Showplan Schema for SQL Server starting in SQL Server 2012 SP4 and SQL Server 2016 SP2 (KB4016949)](https://support.microsoft.com/help/4016949) |
| <a id="11555288">[11555288](#11555288)</a> | [Better intra-query parallelism deadlocks troubleshooting in SQL Server 2017 and 2016 (KB4089473)](https://support.microsoft.com/help/4089473) |
| <a id="11578523">[11578523](#11578523)</a> | [Improvement: Performance issue when upgrading MDS from SQL Server 2012 to 2016 (KB4089718)](https://support.microsoft.com/help/4089718) |
| <a id="6884989">[6884989](#6884989)</a> | [FIX: Automatic update of incremental statistics is delayed in SQL Server 2016 and 2017 (KB4041811)](https://support.microsoft.com/help/4041811) |
| <a id="7990665">[7990665](#7990665)</a> | ["The log backup chain is broken" error when the log backup process fails in SQL Server (KB3162858)](https://support.microsoft.com/help/3162858) |
| <a id="8025121">[8025121](#8025121)</a> | [FIX: Copy Database Wizard fails when a table contains a sparse column set in SQL Server (KB3157575)](https://support.microsoft.com/help/3157575) |
| <a id="8846046">[8846046](#8846046)</a> | [FIX: LogPool cache MEMORYCLERK_SQLLOGPOOL consumes more memory when you do online transactions in SQL Server 2016 SP1 Express Edition (KB4046909)](https://support.microsoft.com/help/4046909) |
| <a id="9191595">[9191595](#9191595)</a> | [FIX: LSN truncation occurs in AG when disabling the change data capture feature in SQL Server 2016 (KB4092045)](https://support.microsoft.com/help/4092045) |
| <a id="9912272">[9912272](#9912272)</a> | [FIX: Execution stats of scalar user-defined function is added to Showplan XML file in SQL Server 2016 SP2 (KB4051360)](https://support.microsoft.com/help/4051360) |
| <a id="10065114">[10065114](#10065114)</a> | [FIX: Access violation occurs when a query references an SQLCLR function through a synonym in SQL Server 2016 (KB3136496)](https://support.microsoft.com/help/3136496) |
| <a id="10077001">[10077001](#10077001)</a> | [FIX: Parallel queries are slower when they're run with high DOP in SQL Server 2016 (KB4052138)](https://support.microsoft.com/help/4052138) |
| <a id="10456101">[10456101](#10456101)</a> | [FIX: Add CXPACKET wait type in showplan XML in SQL Server 2016 and 2017 (KB4046914)](https://support.microsoft.com/help/4046914) |
| <a id="10571989">[10571989](#10571989)</a> | [FIX: The SQL Server 2016 setup page contains nonsecure tool-download links (KB4046885)](https://support.microsoft.com/help/4046885) |
| <a id="10697582">[10697582](#10697582)</a> | [FIX: SQL Server Profiler fails to obfuscate sp_setapprole when it's executed from a remote procedure call in SQL Server (KB4014756)](https://support.microsoft.com/help/4014756) |
| <a id="10704351">[10704351](#10704351)</a> | [FIX: The tempdb system database (sys.databases) is still encrypted even though all other databases on the instance of SQL Server aren't encrypted (KB4042788)](https://support.microsoft.com/help/4042788) |
| <a id="10727149">[10727149](#10727149)</a> | [FIX: Memory grant that's required to run optimized nested loop join isn't reflected in Showplan XML in SQL Server (KB3170116)](https://support.microsoft.com/help/3170116) |
| <a id="10817173">[10817173](#10817173)</a> | [FIX: Indirect checkpoints on tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 or 2017 (KB4040276)](https://support.microsoft.com/help/4040276) |
| <a id="10871961">[10871961](#10871961)</a> | [FIX: Decreased performance and long waits for CLR_AUTO_EVENT and CMEMTHREAD when SQLCLR UDT is used as a stored procedure parameter for a SQL RPC call (KB4013128)](https://support.microsoft.com/help/4013128) |
| <a id="10871968">[10871968](#10871968)</a> | [FIX: Access violation when you create or configure an Always On availability group for an availability database in SQL Server 2012 and 2016 (KB4021243)](https://support.microsoft.com/help/4021243) |
| <a id="10871976">[10871976](#10871976)</a> | [FIX: Service Broker endpoint connections aren't closed after an availability group failover in SQL Server (KB4016361)](https://support.microsoft.com/help/4016361) |
| <a id="10872004">[10872004](#10872004)</a> | [FIX: "sp_special_columns" returns incorrect result in SQL Server 2016 (KB4056008)](https://support.microsoft.com/help/4056008) |
| <a id="10914360">[10914360](#10914360)</a> | [FIX: Deadlock occurs on single-user mode database when many connections access it simultaneously in SQL Server 2016 (KB4042415)](https://support.microsoft.com/help/4042415) |
| <a id="10932023">[10932023](#10932023)</a> | [FIX: Change tracking manual cleanup fails with table non-existence error in SQL Server (KB4043624)](https://support.microsoft.com/help/4043624) |
| <a id="10937127">[10937127](#10937127)</a> | [FIX: SQL Server runs out of memory when table-valued parameters are captured in Extended Events sessions in SQL Server 2016 even if collecting statement or data stream isn't enabled (KB4051359)](https://support.microsoft.com/help/4051359) |
| <a id="10973046">[10973046](#10973046)</a> | [FIX: Execution fails when a SQL CLR function invokes Transact-SQL statements through impersonation calls in SQL Server 2016 and 2017 (KB4046918)](https://support.microsoft.com/help/4046918) |
| <a id="11032173">[11032173](#11032173)</a> | [FIX: Memory dumps generated for "Stalled IOCP Listener" and "non-yielding IOCP listener" after SQL Server restart (KB4048942)](https://support.microsoft.com/help/4048942) |
| <a id="11086264">[11086264](#11086264)</a> | [FIX: SQL Server Audit Events fail to write to the security log (KB4052136)](https://support.microsoft.com/help/4052136) |
| <a id="11454650">[11454650](#11454650)</a> | [FIX: QRY_PROFILE_LIST_MUTEX is blocked when TF 7412 is enabled in SQL Server 2016 (KB4089239)](https://support.microsoft.com/help/4089239) |
| <a id="11523867">[11523867](#11523867)</a> | [FIX: It takes a long time to roll back a batch that updates a large amount of data in SQL Server 2016 (KB4090279)](https://support.microsoft.com/help/4090279) |
| <a id="11542281">[11542281](#11542281)</a> | [FIX: CXPACKET and CXCONSUMER wait types show inconsistent results for some parallel query plans in SQL Server 2016 and 2017 (KB4057054)](https://support.microsoft.com/help/4057054) |
| <a id="12519464">[12519464](#12519464)</a> | [FIX: Access violation exception occurs during Query Optimization of a query that accesses a table with Filtered Indexes or Statistics (KB4475794)](https://support.microsoft.com/help/4475794) |
| <a id="9653457">[9653457](#9653457)</a> | Update enables XML Showplans to provide a list of statistics used during query optimization in SQL Server 2016 and 2017 (KB4041817) |
| <a id="10895916">[10895916](#10895916)</a> | Improvement: Adds Service Broker support for `DBCC CLONEDATABASE` in SQL Server 2016 (KB4092075) |
| <a id="9832539">[9832539](#9832539)</a> | FIX: `TRY…CATCH` block rolls back too many transactions in some in-memory OLTP error handling scenarios in SQL Server 2016 (KB4039846) |
| <a id="10288012">[10288012](#10288012)</a> | FIX: Can't restart SQL Server 2016 after you use `ALTER DATABASE ADD FILE` or `ADD LOG` commands to add files with the same logical name (KB4092046) |
| <a id="10761398">[10761398](#10761398)</a> | FIX: "TempDB file size exceeds 1024 MB" error when you try to set the initial size for a `TempDB` file to a value greater than 1024 MB (KB4046902) |
| <a id="11032146">[11032146](#11032146)</a> | FIX: Thread pool exhaustion and CMEMTHREAD contention in AAG with data seeding in SQL Server 2016 and 2017 (KB4045795) |
| <a id="11334467">[11334467](#11334467)</a> | FIX: Boolean values not localized correctly in the parameters pane of a report in SSRS 2016 (SharePoint mode) (KB4075158) |
| <a id="11543252">[11543252](#11543252)</a> | FIX: Replication isn't enabled when database collation uses '`_SC`' collation extension in SQL Server 2016 and 2017 (KB4092066) |
| <a id="11566335">[11566335](#11566335)</a> | FIX: Access Violation when you use QDS and specify a query plan to resolve a performance regression (KB4089509) |

### Additional resolutions

Resolutions to the following issues are also included in SQL Server 2016 SP2.

| Bug reference | Description | Area |
|---|---|---|
| <a id="8523231">[8523231](#8523231)</a> | Adds durable memory-optimized tables that can have foreign key reference to nondurable memory-optimized tables. | In-Memory OLTP |
| <a id="9146914">[9146914](#9146914)</a> | Adds the `SpLevel and ReleaseProductVersion` properties to SQL Server 2016 SP1. | Setup & Install |
| <a id="10365365">[10365365](#10365365)</a> | Fixes an issue by installing a SQL Server security update on the passive node in a customized cluster. | Setup & Install |
| <a id="9480942">[9480942](#9480942)</a> | Fixes an issue to avoid null reference in `GetNextAllHoBts`. | SQL Engine |
| <a id="9737945">[9737945](#9737945)</a> | Adds a DVM `sys.dm_tran_version_store_space_usage` that can track the `tempdb` version store usage in each database. | SQL Engine |
| <a id="9742982">[9742982](#9742982)</a> | Fixes an issue in which the plan cache memory usage is high when the `MAXDOP` is set to `1`. | SQL Engine |
| <a id="10698782">[10698782](#10698782)</a> | Adds a new DMV `sys.dm_db_log_stats` that returns summary level attributes and information about transaction log files of databases. | SQL Engine |
| <a id="10698786">[10698786](#10698786)</a> | Adds a new DMV `sys.dm_db_log_info` that returns the Virtual Log File (VLF) information about the transaction log files. | SQL Engine |
| <a id="10698823">[10698823](#10698823)</a> | Exposes the percentage of differential changes in the databases to help determine whether full database backup or differential backup is useful. | SQL Engine |
| <a id="10698846">[10698846](#10698846)</a> | Adds a new DMV `sys.dm_tran_version_store_space_usage` that returns a table to display total space in tempdb used by version store records for each database. | SQL Engine |
| <a id="10698847">[10698847](#10698847)</a> | Fixes an issue in which restoring a compressed backup for a Transparent Data Encryption (TDE) enabled database through the Virtual Device Interface (VDI) interface may fail with the operating system error 38. | SQL Engine |
| <a id="10755072">[10755072](#10755072)</a> | Adds the filegroup support to the `SELECT INTO` statement. This allows you to specify the name of the filegroup in which a new table will be created. The filegroup specified should exist on the database else the SQL Server engine throws an error. | SQL Engine |
| <a id="10756412">[10756412](#10756412)</a> | Adds the `WITH VERIFY_CLONE` option and the `WITH BACKUP_CLONE` option to the `DBCC CLONEDATABASE` management command that allows you to verify and back up cloned databases. | SQL Engine |
| <a id="10760480">[10760480](#10760480)</a> | Exposes the processor information such as core count, sockets, and NUMA information in DMV `sys.dm_server_services` and the `SERVERPROPERTY` function. | SQL Engine |
| <a id="10823015">[10823015](#10823015)</a> | Improves the backup performance on computers that have large memory. | SQL Engine |
| <a id="10914366">[10914366](#10914366)</a> | Adds a database name attribute in the process-list and `executionStack` in the extended event `xml_deadlock_report` to expose the database name. | SQL Engine |
| <a id="10925573">[10925573](#10925573)</a> | Adds a new extended event `marked_transaction_latch_trace` that shows the state of the global latches that are used by marked transactions. | SQL Engine |
| <a id="10973764">[10973764](#10973764)</a> | Improves the Distributed Transaction Coordinators (DTC) service support for AlwaysOn availability groups (AG) databases. | SQL Engine |
| <a id="11559743">[11559743](#11559743)</a> | Fixes an issue in which you're unable to run the `ADDNODE` step when the Polybase feature is installed in ScaleOut deployment mode. | SQL Engine |
| <a id="11565681">[11565681](#11565681)</a> | Exposes the last-known good `DBCC CHECKDB` date and time for a database. | SQL Engine |
| <a id="11583626">[11583626](#11583626)</a> | Fixes an issue by removing a node from a failover cluster that has Polybase installed. | SQL Engine |
| <a id="8837822">[8837822](#8837822)</a> | Fixes an issue in which the DMV `sys.dm_exec_query_profiles` shows an incorrect result that's inconsistent with the estimated or actual query plan. | SQL Performance |
| <a id="9437530">[9437530](#9437530)</a> | Fixes the memory grant usage (`InputMemoryGrant`, `OutputMemoryGrant` and `UsedMemoryGrant` properties) in Showplan XML for parallel queries. | SQL Performance |
| <a id="10697461">[10697461](#10697461)</a> | Fixes an issue in which the `MAX_GRANT_PERCENT` query hint isn't always being respected. | SQL Performance |
| <a id="10723493">[10723493](#10723493)</a> | Fixes an issue in which an assertion error might occur when you query the DMV `sys.dm_db_stats_histogram` if the `TIMESTAMP` column contains values. | SQL Performance |

For more information about how to upgrade your SQL Server installation to SQL Server 2016 SP2, see [Supported version and edition upgrades](/sql/database-engine/install-windows/supported-version-and-edition-upgrades).

## How to get SQL Server 2016 SP2

SQL Server 2016 SP2, Microsoft SQL Server 2016 SP2 Express, and Microsoft SQL Server 2016 SP2 Feature Pack are available for manual download and installation at the following Microsoft Download Center websites.

- [SQL Server 2016 SP2](https://www.microsoft.com/download/details.aspx?id=56836)
- [SQL Server 2016 SP2 Express](https://www.microsoft.com/download/details.aspx?id=56840)
- [SQL Server 2016 SP2 Feature Pack](https://www.microsoft.com/download/details.aspx?id=56833)

> [!NOTE]
> After you install the service pack, the SQL Server service version should be **13.0.5026.0** Microsoft SQL Server 2016 service packs are cumulative updates. SQL Server 2016 SP2 upgrades all editions and service levels of SQL Server 2016 to SQL Server 2016 SP2.

## Uninstalling SQL Server 2016 SP2 (not recommended)

If, for any reason, you choose to uninstall SQL Server 2016 SP2, the uninstallation of SQL Server 2016 SP2 will not be blocked, and you will be able to uninstall SQL Server 2016 SP2 in the same manner as any other service packs. However, if you are running the Standard, Web, or Express edition of SQL Server, and you are using some new features that are unlocked only when you start SQL Server 2016 SP2, you might experience errors or see databases left in a suspect state after the uninstallation of SQL Server 2016 SP2. Even worse, if the system databases are using new features (for example, partitioned tables in master databases), this could prevent SQL Server instances from starting after you uninstall SQL Server 2016 SP2.

We recommend that you verify that all the new features are disabled or dropped before you choose to uninstall SQL Server 2016 SP2 on editions other than the Enterprise edition. You can't drop the [memory_optimized_data](/sql/relational-databases/in-memory-oltp/the-memory-optimized-filegroup) filegroup. Therefore, if you have set up the `memory_optimized_data` filegroup on your database with SP2, you should not uninstall SQL Server 2016 SP2. Otherwise, the database will get into a suspect state, and the following entry will be logged in the error log:

> \<DateTime> spid15s Error: 41381, Severity: 21, State: 1.  
> \<DateTime> spid15s The database cannot be started in this edition of SQL Server because it contains a MEMORY_OPTIMIZED_DATA filegroup. See Books Online for more details on feature support in different SQL Server editions.

## Copyright attributions

- This product contains software derived from the Xerox Secure Hash Function.
- This product includes software from the zlib general purpose compression library.
- Parts of this software are based in part on the work of RSA Data Security, Inc. Because Microsoft has included the RSA Data Security, Inc., software in this product, Microsoft is required to include the text below that accompanied such software:
  - Copyright 1990, RSA Data Security, Inc. All rights reserved.
  - License to copy and use this software is granted provided that it's identified as the "RSA Data Security, Inc., MD5 Message-Digest Algorithm" in all material mentioning or referencing this software or this function. License is also granted to make and use derivative works provided that such works are identified as "derived from the RSA Data Security, Inc., MD5 Message-Digest Algorithm" in all material mentioning or referencing the derived work.
  - RSA Data Security, Inc., makes no representations concerning either the merchantability of this software or the suitability of this software for any particular purpose. It's provided "as is" without express or implied warranty of any kind.

  These notices must be retained in any copies of any part of this documentation or software.
- The Reporting Services mapping feature uses data from TIGER/Line Shapefiles that are provided courtesy of the [United States Census Bureau](https://www.census.gov/). TIGER/Line Shapefiles are an extract of selected geographic and cartographic information from the Census MAF/TIGER database. TIGER/Line Shapefiles are available without charge from the United States Census Bureau. To get more information about the TIGER/Line shapefiles, go to [TIGER/Line shapefiles](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html). The boundary information in the TIGER/Line Shapefiles is for statistical data collection and tabulation purposes only; its depiction and designation for statistical purposes doesn't constitute a determination of jurisdictional authority, rights of ownership, or entitlement, and doesn't reflect legal land descriptions. Census TIGER and TIGER/Line are registered trademarks of the United States Census Bureau.

Copyright 2012 Microsoft. All rights reserved.

## References

For more information about how to determine the current SQL Server version and edition, select the following article number to go to the article in the Microsoft Knowledge Base:

[321185](../../releases/download-and-install-latest-updates.md) How to identify your SQL Server version and edition

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.