---
title: Cumulative update 2 for SQL Server 2016 SP1 (KB4013106)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 2 (KB4013106).
ms.date: 10/26/2023
ms.custom: KB4013106
appliesto:
- SQL Server 2016 Service Pack 1
---

# KB4013106 - Cumulative Update 2 for SQL Server 2016 SP1

_Release Date:_ &nbsp; March 20, 2017  
_Version:_ &nbsp; 13.0.4422.0

This article describes cumulative update package 2 (build number: **13.0.4422.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Known issues in this update

After installing this CU, Change Data Capture (CDC) functionality might break if:

- The databases enabled for CDC are part of Always On availability group (or)
- SQL Server replication components are not installed on the server

For more information, see:

- [CDC functionality may break after upgrading to the latest CU for SQL Server 2012, 2014 and 2016](https://techcommunity.microsoft.com/t5/sql-server-blog/cdc-functionality-may-break-after-upgrading-to-the-latest-cu-for/ba-p/385297)
- [Special steps for change data capture or replication](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances#special-steps-for-change-data-capture-or-replication)

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=9456824>[9456824](#9456824)</a> | [Improvement: Performance improvement for the "sequence point algorithm" step in an SSAS 2016 Tabular Model transaction (KB4013122)](https://support.microsoft.com/help/4013122) | Analysis Services |
| <a id=9237364>[9237364](#9237364)</a> | [FIX: MDX query returns errors if the value of MaxRolapOrConditions is greater than 256 in SQL Server Analysis Services (KB3208179)](https://support.microsoft.com/help/3208179) | Analysis Services |
| <a id=9287975>[9287975](#9287975)</a> | [FIX: Unexpected error occurs when you process a table in a tabular model in SSAS 2016 (KB4014013)](https://support.microsoft.com/help/4014013) | Analysis Services |
| <a id=9367862>[9367862](#9367862)</a> | [FIX: Access violation occurs when you run and then cancel a query on distinct count partitions in SSAS (KB3025408)](https://support.microsoft.com/help/3025408) | Analysis Services |
| <a id=9367868>[9367868](#9367868)</a> | [FIX: SSAS may crash on query execution if a predefined role is specified in the connection string (KB3212916)](https://support.microsoft.com/help/3212916) | Analysis Services |
| <a id=9367872>[9367872](#9367872)</a> | [FIX: Error when you execute an MDX query on a Tabular model database in SQL Server 2016 Analysis Services (KB3198356)](https://support.microsoft.com/help/3198356) | Analysis Services |
| <a id=9367901>[9367901](#9367901)</a> | [FIX: Can't cancel queries with SORT conditions on cells or measure values in SQL Server Analysis Services (KB3198826)](https://support.microsoft.com/help/3198826) | Analysis Services |
| <a id=9367911>[9367911](#9367911)</a> | [FIX: Error occurs for queries on global measures that have previously been referenced by query scoped measures in SSAS 2016 tabular mode (KB3211605)](https://support.microsoft.com/help/3211605) | Analysis Services |
| <a id=9367925>[9367925](#9367925)</a> | [FIX: SSAS stored connection strings become corrupted if extended properties are used incorrectly (KB3209520)](https://support.microsoft.com/help/3209520) | Analysis Services |
| <a id=9467732>[9467732](#9467732)</a> | [FIX: SQL Server 2016 Analysis Services crashes or hangs during processing of data in a Tabular instance (KB4013206)](https://support.microsoft.com/help/4013206) | Analysis Services |
| <a id=9503252>[9503252](#9503252)</a> | [FIX: An MDX query returns incorrect results in SSAS 2014 or 2016 Tabular mode (KB4009839)](https://support.microsoft.com/help/4009839) | Analysis Services |
| <a id=9237384>[9237384](#9237384)</a> | [FIX: Deadlock causes deferred transaction on the secondary replica in an Always On environment (KB3189959)](https://support.microsoft.com/help/3189959) | High Availability |
| <a id=9237401>[9237401](#9237401)</a> | [FIX: Availability databases in incorrect initializing/synchronizing state after failover of SQL Server 2014 or 2016 Always On availability group (KB3206299)](https://support.microsoft.com/help/3206299) | High Availability |
| <a id=9237403>[9237403](#9237403)</a> | [FIX: On failover, the new secondary replica stops accepting transaction log records until the instance is restarted in SQL Server (KB3207327)](https://support.microsoft.com/help/3207327) | High Availability |
| <a id=9237409>[9237409](#9237409)</a> | [FIX: You can't select any replica when you fail over from an availability group that's in the resolving state (KB3208524)](https://support.microsoft.com/help/3208524) | High Availability |
| <a id=9367814>[9367814](#9367814)</a> | [FIX: Assert memory dump on a mirror server in SQL Server (KB3192692)](https://support.microsoft.com/help/3192692) | High Availability |
| <a id=9367892>[9367892](#9367892)</a> | [FIX: Queries that run against secondary databases always get recompiled in SQL Server (KB3181444)](https://support.microsoft.com/help/3181444) | High Availability |
| <a id=9367917>[9367917](#9367917)</a> | [FIX: No automatic failover after database mirroring stops unexpectedly in SQL Server (KB3177238)](https://support.microsoft.com/help/3177238) | High Availability |
| <a id=9367937>[9367937](#9367937)</a> | [FIX: DMV sys.dm_hadr_availability_replica_states returns an incorrect synchronization health state for a distributed availability group (KB3213288)](https://support.microsoft.com/help/3213288) | High Availability |
| <a id=9368264>[9368264](#9368264)</a> | [FIX: Error 5262 when you execute DBCC CHECKDB on the primary replica in SQL Server 2012, 2014 or 2016 (KB3211304)](https://support.microsoft.com/help/3211304) | High Availability |
| <a id=9379260>[9379260](#9379260)</a> | [FIX: Bad query plan created on secondary replicas after FULLSCAN statistics update on primary replica in SQL Server 2016 (KB4016657)](https://support.microsoft.com/help/4016657) | High Availability |
| <a id=8861790>[8861790](#8861790)</a> | [FIX: Checkpoint files grow excessively when you insert data into memory-optimized tables in SQL Server 2016 (KB3206584)](https://support.microsoft.com/help/3206584) | In-Memory OLTP |
| <a id=9379508>[9379508](#9379508)</a> | [FIX: ALTER TABLE, ADD CONSTRAINT, and PRIMARY KEY statements don't detect a duplicate key in SQL Server 2016 (KB4013116)](https://support.microsoft.com/help/4013116) | In-Memory OLTP |
| <a id=9460219>[9460219](#9460219)</a> | [FIX: An access violation occurs when natively compiled stored procedures are executed concurrently in SQL Server 2016 (KB4013124)](https://support.microsoft.com/help/4013124) | In-Memory OLTP |
| <a id=9367891>[9367891](#9367891)</a> | [FIX: "The process cannot access the file" error when an XML task fails in SQL Server (KB3115741)](https://support.microsoft.com/help/3115741) | Integration Services |
| <a id=9514259>[9514259](#9514259)</a> | [FIX: Hadoop File System Task fails after 10 minutes when you open and run a saved SSIS 2016 package (KB4013936)](https://support.microsoft.com/help/4013936) | Integration Services |
| <a id=9237354>[9237354](#9237354)</a> | [FIX: "No Data Available" in the SQL Server Memory Usage page in the SQL Server 2014 or 2016 MDM report (KB3209442)](https://support.microsoft.com/help/3209442) | Management Tools |
| <a id=9367429>[9367429](#9367429)</a> | [FIX: Snapshot Agent fails when you publish UDF's to SQL Server 2016 Distributor in Transactional Replication (KB3197883)](https://support.microsoft.com/help/3197883) | Management Tools |
| <a id=9367867>[9367867](#9367867)</a> | [FIX: SQL Server 2016 Database Mail causes high CPU usage after many email messages are sent (KB3197879)](https://support.microsoft.com/help/3197879) | Management Tools |
| <a id=9395865>[9395865](#9395865)</a> | [FIX: SQL Server 2016 Database Mail doesn't work on a computer that doesn't have the .NET Framework 3.5 installed (KB3186435)](https://support.microsoft.com/help/3186435) | Management Tools |
| <a id=9503259>[9503259](#9503259)</a> | [FIX: The sp_msx_enlist stored procedure fails to enlist a target server into a master server in SQL Server 2014 or 2016 if the server name is too long (KB4010344)](https://support.microsoft.com/help/4010344) | Management Tools |
| <a id=9503261>[9503261](#9503261)</a> | [FIX: "Invoke-sqlcmd" cmdlet executes a query statement multiple times if an error occurs in SQL Server 2014 or 2016 (KB4010159)](https://support.microsoft.com/help/4010159) | Management Tools |
| <a id=9439184>[9439184](#9439184)</a> | [SQL Server 2016 Service Pack 1 release information (KB3182545)](servicepack1.md) | Master Data Services (MDS) |
| <a id=9269601>[9269601](#9269601)</a> | [GDR update package for SQL Server 2016 SP1 (KB3210089)](https://support.microsoft.com/help/3210089) | Reporting Services |
| <a id=9367822>[9367822](#9367822)</a> | [MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015 (KB3045321)](https://support.microsoft.com/help/3045321) | Reporting Services |
| <a id=9367818>[9367818](#9367818)</a> | [FIX: Can't save the SSRS report after you change a parameter in Report Builder or the SQL Server Data Tool (KB3212193)](https://support.microsoft.com/help/3212193) | Reporting Services |
| <a id=9367882>[9367882](#9367882)</a> | [FIX: Image maps not rendered as expected in SSRS custom report item (KB3204265)](https://support.microsoft.com/help/3204265) | Reporting Services |
| <a id=9367894>[9367894](#9367894)</a> | [Can't export a report as an Excel workbook when the "Interpret HTML Tags as Styles" option is selected (KB3180980)](https://support.microsoft.com/help/3180980) | Reporting Services |
| <a id=9367903>[9367903](#9367903)</a> | [FIX: Error when you open Data Alert Manager in SQL Server 2014 or 2016 Reporting Services in SharePoint integrated mode (KB3197950)](https://support.microsoft.com/help/3197950) | Reporting Services |
| <a id=9368268>[9368268](#9368268)</a> | [FIX: RDL report that's generated programmatically fails to run in SSRS (KB3157016)](https://support.microsoft.com/help/3157016) | Reporting Services |
| <a id=9389933>[9389933](#9389933)</a> | [FIX: User authentication failure in SSRS 2016 under the custom security extensions deployment (KB4013248)](https://support.microsoft.com/help/4013248) | Reporting Services |
| <a id=9398927>[9398927](#9398927)</a> | [FIX: Intermittent failure with System.NullReferenceException when you use custom authentication in SSRS 2016 (KB4014862)](https://support.microsoft.com/help/4014862) | Reporting Services |
| <a id=9125813>[9125813](#9125813)</a> | FIX: SSRS 2016 mobile report that contains a shared dataset times out and doesn't load (KB4013110) | Reporting Services |
| <a id=9503272>[9503272](#9503272)</a> | [FIX: SQL Server is stopped when you install patches on an instance of SQL Server that contains many databases (KB4010990)](https://support.microsoft.com/help/4010990) | Setup & Install |
| <a id=9367879>[9367879](#9367879)</a> | [Improvement: Improves the query performance for SQL Server 2016 by changing the use of histograms on UNIQUE columns (KB3202425)](https://support.microsoft.com/help/3202425) | SQL performance |
| <a id=9230882>[9230882](#9230882)</a> | [FIX: More CPU consumption when many consecutive transactions insert data into a temp table in SQL Server 2016 than in SQL Server 2014 (KB3216543)](https://support.microsoft.com/help/3216543) | SQL performance |
| <a id=9237319>[9237319](#9237319)</a> | [FIX: Incremental statistics run with higher sample rate than regular statistics when statistics are created or updated in SQL Server 2014 or 2016 (KB3196877)](https://support.microsoft.com/help/3196877) | SQL performance |
| <a id=9237342>[9237342](#9237342)</a> | [FIX: Incorrect query result when you use varchar(max) variable in the search condition in SQL Server 2014 or 2016 (KB3208245)](https://support.microsoft.com/help/3208245) | SQL performance |
| <a id=9237347>[9237347](#9237347)</a> | [FIX: Error 2809 when you execute a stored procedure that takes a table-valued parameter from RPC calls in SQL Server 2014 or 2016 (KB3205935)](https://support.microsoft.com/help/3205935) | SQL performance |
| <a id=9330686>[9330686](#9330686)</a> | [FIX: Assertion error when dm_exec_query_statistics_xml is used in a query plan that contains certain operators in SQL Server 2016 (KB4010984)](https://support.microsoft.com/help/4010984) | SQL performance |
| <a id=9367877>[9367877](#9367877)</a> | [FIX: Can't insert data into a table that uses a clustered columnstore index in SQL Server 2016 (KB3211602)](https://support.microsoft.com/help/3211602) | SQL performance |
| <a id=9367885>[9367885](#9367885)</a> | [Statistics are removed after rebuilding a specific partition of a partitioned aligned index on a partitioned table in SQL Server (KB3194959)](https://support.microsoft.com/help/3194959) | SQL performance |
| <a id=9367888>[9367888](#9367888)</a> | [FIX: Deadlock when you execute a query plan with a nested loop join in batch mode in SQL Server 2014 or 2016 (KB3195825)](https://support.microsoft.com/help/3195825) | SQL performance |
| <a id=9367898>[9367898](#9367898)</a> | [FIX: Rebuilding a nonclustered index to add columns by using CREATE INDEX with DROP_EXISTING=ON and ONLINE=ON causes blocking (KB3194365)](https://support.microsoft.com/help/3194365) | SQL performance |
| <a id=9367929>[9367929](#9367929)</a> | [FIX: Unable to rebuild the partition online for a table that contains a computed partitioning column in SQL Server 2016 (KB3213683)](https://support.microsoft.com/help/3213683) | SQL performance |
| <a id=9503250>[9503250](#9503250)</a> | [FIX: AFTER DELETE triggers occur in the wrong order in the ON DELETE CASCADE action chain in SQL Server 2014 and 2016 (KB4009823)](https://support.microsoft.com/help/4009823) | SQL performance |
| <a id=9367897>[9367897](#9367897)</a> | [FIX: TDE encrypted Databases go in suspect state during the recovery phase when you restart SQL Server (KB3197631)](https://support.microsoft.com/help/3197631) | SQL security |
| <a id=9503270>[9503270](#9503270)</a> | [FIX: Memory leak when you run a query that you don't have sufficient permissions for in SQL Server 2014 or 2016 (KB4010710)](https://support.microsoft.com/help/4010710) | SQL security |
| <a id=9237417>[9237417](#9237417)</a> | [Updates to DBCC CLONEDATABASE functionality in SQL Server 2014 and 2016 (KB3208246)](https://support.microsoft.com/help/3208246) | SQL service |
| <a id=9367895>[9367895](#9367895)</a> | [Improvement: Enhance VDI Protocol with VDC_Complete command in SQL Server (KB3188454)](https://support.microsoft.com/help/3188454) | SQL service |
| <a id=9452932>[9452932](#9452932)</a> | [Improvement: Enable SQL Server Managed Backup to back up databases that are larger than 50 GB to Microsoft Azure in SQL Server 2016 (KB4014002)](https://support.microsoft.com/help/4014002) | SQL service |
| <a id=9452934>[9452934](#9452934)</a> | [Improvement: Enable DBCC CLONEDATABASE to clone a full-text object in SQL Server 2016 SP1 (KB4013120)](https://support.microsoft.com/help/4013120) | SQL service |
| <a id=9473330>[9473330](#9473330)</a> | [Update improves DMV sys.dm_os_sys_info and sys.dm_os_sys_info in SQL Server 2016 (KB4013125)](https://support.microsoft.com/help/4013125) | SQL service |
| <a id=9503182>[9503182](#9503182)</a> | [Update improves handling of documents too large for Full-Text Search indexing in SQL Server 2014 or 2016 (KB3208276)](https://support.microsoft.com/help/3208276) | SQL service |
| <a id=8532466>[8532466](#8532466)</a> | [FIX: Internal error 'FAC_HK_INTERNAL' when you insert or update large numbers of rows of data into or in a memory-optimized table in SQL Server 2016 (KB4009794)](https://support.microsoft.com/help/4009794) | SQL service |
| <a id=8845976>[8845976](#8845976)</a> | [A memory leak occurs when you use Azure Storage in SQL Server 2014 or 2016 (KB3174370)](https://support.microsoft.com/help/3174370) | SQL service |
| <a id=9061115>[9061115](#9061115)</a> | [FIX: Can't install SQL Server R Services during an offline installation of SQL Server 2016 updates (KB3210708)](https://support.microsoft.com/help/3210708) | SQL service |
| <a id=9069693>[9069693](#9069693)</a> | [FIX: Wrong number of rows returned in sys.partitions for Columnstore index in SQL Server 2016 (KB3195752)](https://support.microsoft.com/help/3195752) | SQL service |
| <a id=9193209>[9193209](#9193209)</a> | [FIX: Data type conversion error in a query that involves a column store index in SQL Server 2016 (KB4013883)](https://support.microsoft.com/help/4013883) | SQL service |
| <a id=9234045>[9234045](#9234045)</a> | [FIX: "(0x80004002) No such interface supported" error when you use RMO to run Web Synchronization for Merge Replication in SQL Server 2016 (KB4014719)](https://support.microsoft.com/help/4014719) | SQL service |
| <a id=9237302>[9237302](#9237302)</a> | [FIX: The change table is ordered incorrectly for updated rows after you enable change data capture for a Microsoft SQL Server database (KB3030352)](https://support.microsoft.com/help/3030352) | SQL service |
| <a id=9237313>[9237313](#9237313)</a> | [FIX: Memory is paged out when columnstore index query consumes lots of memory in SQL Server 2014 or 2016 (KB3067968)](https://support.microsoft.com/help/3067968) | SQL service |
| <a id=9237369>[9237369](#9237369)</a> | [FIX: Incorrect full-text keys are recorded for the rows that aren't indexed correctly by a full-text index in SQL Server (KB3196012)](https://support.microsoft.com/help/3196012) | SQL service |
| <a id=9237390>[9237390](#9237390)</a> | [FIX: Intra-query deadlock when values are inserted into a partitioned clustered columnstore index in SQL Server 2014 or 2016 (KB3204769)](https://support.microsoft.com/help/3204769) | SQL service |
| <a id=9237395>[9237395](#9237395)</a> | [FIX: Distribution Agent fails for a SQL Server 2014 publisher and a SQL Server 2012 subscriber in Transactional Replication (KB3204469)](https://support.microsoft.com/help/3204469) | SQL service |
| <a id=9237399>[9237399](#9237399)</a> | [FIX: Memory leak when you query sys.dm_sql_referenced_entities view in SQL Server 2014 or 2016 (KB3205994)](https://support.microsoft.com/help/3205994) | SQL service |
| <a id=9237405>[9237405](#9237405)</a> | [FIX: Error 21050 when you remove a table that's not part of a publication in SQL Server 2014 or 2016 (KB3209459)](https://support.microsoft.com/help/3209459) | SQL service |
| <a id=9237407>[9237407](#9237407)</a> | [FIX: Adding a subscription to an Oracle transactional publication or an Oracle snapshot publication fails in SQL Server 2014 or 2016 (KB3208243)](https://support.microsoft.com/help/3208243) | SQL service |
| <a id=9324510>[9324510](#9324510)</a> | [FIX: Error when you add a NOT NULL column with default values to a non-empty clustered columnstore index in SQL Server 2016 Standard and Express edition (KB4013851)](https://support.microsoft.com/help/4013851) | SQL service |
| <a id=9367828>[9367828](#9367828)</a> | [FIX: Changing the data type and then updating the table with more than 4,000 records causes database corruption (KB3213240)](https://support.microsoft.com/help/3213240) | SQL service |
| <a id=9367873>[9367873](#9367873)</a> | [FIX: "Non-yielding Scheduler" condition when you parallel-load data into a columnstore index in SQL Server 2016 (KB3205411)](https://support.microsoft.com/help/3205411) | SQL service |
| <a id=9367887>[9367887](#9367887)</a> | [SQL Server crashes with an access violation when you use the TRY…CATCH construct for bulk copy (KB3184099)](https://support.microsoft.com/help/3184099) | SQL service |
| <a id=9367909>[9367909](#9367909)</a> | [FIX: An access violation occurs when you execute DBCC CHECKDB on a database in SQL Server 2016 (KB3212482)](https://support.microsoft.com/help/3212482) | SQL service |
| <a id=9367910>[9367910](#9367910)</a> | [FIX: Out-of-memory errors when you execute DBCC CHECKDB on database that contains columnstore indexes in SQL Server 2014 or 2016 (KB3201416)](https://support.microsoft.com/help/3201416) | SQL service |
| <a id=9367921>[9367921](#9367921)</a> | [FIX: SQL Server crashes when you execute a spatial data query that has been compiled in SQL Server 2016 (KB3212789)](https://support.microsoft.com/help/3212789) | SQL service |
| <a id=9367922>[9367922](#9367922)</a> | [FIX: Error when creating a stored procedure that uses a synonym together with an index hint in SQL Server 2016 (KB3213263)](https://support.microsoft.com/help/3213263) | SQL service |
| <a id=9367923>[9367923](#9367923)</a> | [FIX: SQL Server crashes when you execute the OPENJSON function in a contained database in SQL Server 2016 (KB3210597)](https://support.microsoft.com/help/3210597) | SQL service |
| <a id=9367931>[9367931](#9367931)</a> | [FIX: A memory leak occurs when SQL Server procedure cache consumes too much memory (KB3212523)](https://support.microsoft.com/help/3212523) | SQL service |
| <a id=9367933>[9367933](#9367933)</a> | [FIX: An assert error occurs when you insert data into a memory-optimized table that contains a clustered columnstore index in SQL Server 2016 (KB3211338)](https://support.microsoft.com/help/3211338) | SQL service |
| <a id=9367939>[9367939](#9367939)</a> | [FIX: Error 3628 when you create or rebuild a columnstore index in SQL Server 2016 (KB3213283)](https://support.microsoft.com/help/3213283) | SQL service |
| <a id=9371007>[9371007](#9371007)</a> | [FIX: "ADD PERIOD FOR SYSTEM_TIME failed" error when you add period columns to a memory-optimized table in SQL Server 2016 (KB4013112)](https://support.microsoft.com/help/4013112) | SQL service |
| <a id=9379510>[9379510](#9379510)</a> | [FIX: CREATE OR ALTER statement applied on a DDL trigger fails on the next execution in SQL Server 2016 (KB4013115)](https://support.microsoft.com/help/4013115) | SQL service |
| <a id=9398869>[9398869](#9398869)</a> | [FIX: The sys.column_store_segments catalog view displays incorrect values in the column_id column in SQL Server 2016 (KB4013118)](https://support.microsoft.com/help/4013118) | SQL service |
| <a id=9403683>[9403683](#9403683)</a> | [FIX: SQL Server 2014 or 2016 crashes on the execution of the DBCC CLONEDATABASE command (KB5852300)](https://support.microsoft.com/help/5852300) | SQL service |
| <a id=9452905>[9452905](#9452905)</a> | [FIX: DBCC CLONEDATABASE doesn't copy the runtime cache of the query store to the clone in SQL Server 2016 SP1 (KB4013119)](https://support.microsoft.com/help/4013119) | SQL service |
| <a id=9468558>[9468558](#9468558)</a> | [FIX: "Incorrect syntax for definition of the 'default' constraint" error when you add an arbitrary columnstore column in SQL Server 2016 (KB4013207)](https://support.microsoft.com/help/4013207) | SQL service |
| <a id=9491976>[9491976](#9491976)</a> | [FIX: SQL Server Launchpad service fails to start if the installed version of R Services (In-Database) is different from the Database Engine in SQL Server 2016 (KB4014734)](https://support.microsoft.com/help/4014734) | SQL service |
| <a id=9503255>[9503255](#9503255)</a> | [FIX: Can't set a database to partial containment if SQL Server change tracking was ever enabled on that database (KB3212318)](https://support.microsoft.com/help/3212318) | SQL service |
| <a id=9503266>[9503266](#9503266)</a> | [FIX: A system assert occurs when a Transact-SQL stored procedure with a TVP argument is called from a SQLCLR procedure (KB4010162)](https://support.microsoft.com/help/4010162) | SQL service |
| <a id=9619420>[9619420](#9619420)</a> | [FIX: Significantly increased PAGELATCH_EX contentions in sys.sysobjvalues in SQL Server 2016 (KB4013999)](https://support.microsoft.com/help/4013999) | SQL service |
| <a id=9367920>[9367920](#9367920)</a> | FIX: `DBCC CHECKFILEGROUP` reports false inconsistency error 5283 on a database that contains a partitioned table in SQL Server (KB3108537) | SQL service |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP1 now](https://www.microsoft.com/download/details.aspx?id=54613)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 SP1 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.
- Microsoft recommends ongoing, proactive installation of CUs as they become available:
  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.
- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply a CU or SP:
    >
    > - Install the service pack on the passive node.
    > - Install the service pack on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply a CU or SP in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.
- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

    > [!NOTE]
    > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

1. Locate the entry that corresponds to this cumulative update package.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP1.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

## File information

<details>
<summary><b>Cumulative update package file information</b></summary>

This cumulative update package might not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.edition.dll      | 13.0.4422.0     | 37056     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.instapi.dll      | 13.0.4422.0     | 46272     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4422.0 | 72896     | 07-Mar-17 | 00:17 | x86      |
| Pbsvcacctsync.dll                    | 2015.130.4422.0 | 60096     | 07-Mar-17 | 00:16 | x86      |
| Sql_common_core_keyfile.dll          | 2015.130.4422.0 | 88768     | 07-Mar-17 | 00:17 | x86      |
| Sqlmgmprovider.dll                   | 2015.130.4422.0 | 364224    | 07-Mar-17 | 00:16 | x86      |
| Sqlsvcsync.dll                       | 2015.130.4422.0 | 267456    | 07-Mar-17 | 00:16 | x86      |
| Sqltdiagn.dll                        | 2015.130.4422.0 | 60608     | 07-Mar-17 | 00:16 | x86      |
| Svrenumapi130.dll                    | 2015.130.4422.0 | 854208    | 07-Mar-17 | 00:16 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4422.0  | 1876672   | 07-Mar-17 | 00:17 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4422.0 | 2023104   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4422.0     | 433856    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4422.0     | 2044616   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4422.0     | 33480     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4422.0     | 249536    | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4422.0 | 6507712   | 07-Mar-17 | 00:17 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4422.0 | 88768     | 07-Mar-17 | 00:17 | x86      |
| Xmsrv.dll                                      | 2015.130.4422.0 | 32715456  | 07-Mar-17 | 00:17 | x86      |

x64-based versions

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlvdi.dll            | 2015.130.4422.0 | 168640    | 07-Mar-17 | 00:16 | x86      |
| Sqlvdi.dll            | 2015.130.4422.0 | 197312    | 07-Mar-17 | 00:17 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 Analysis Services

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msmdsrv.exe        | 2015.130.4422.0 | 56698048  | 07-Mar-17 | 01:34 | x64      |
| Msmgdsrv.dll       | 2015.130.4422.0 | 6507712   | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll       | 2015.130.4422.0 | 7506624   | 07-Mar-17 | 00:17 | x64      |
| Sql_as_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlceip.exe        | 13.0.4422.0     | 246976    | 07-Mar-17 | 01:34 | x86      |
| Tmapi.dll          | 2015.130.4422.0 | 4346056   | 07-Mar-17 | 00:16 | x64      |
| Tmcachemgr.dll     | 2015.130.4422.0 | 2825920   | 07-Mar-17 | 00:16 | x64      |
| Tmpersistence.dll  | 2015.130.4422.0 | 1071304   | 07-Mar-17 | 00:16 | x64      |
| Tmtransactions.dll | 2015.130.4422.0 | 1351368   | 07-Mar-17 | 00:16 | x64      |
| Xmsrv.dll          | 2015.130.4422.0 | 24039104  | 07-Mar-17 | 00:16 | x64      |
| Xmsrv.dll          | 2015.130.4422.0 | 32715456  | 07-Mar-17 | 00:17 | x86      |

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.edition.dll      | 13.0.4422.0     | 37056     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.instapi.dll      | 13.0.4422.0     | 46272     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4422.0 | 75456     | 07-Mar-17 | 00:16 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4422.0 | 72896     | 07-Mar-17 | 00:17 | x86      |
| Pbsvcacctsync.dll                    | 2015.130.4422.0 | 60096     | 07-Mar-17 | 00:16 | x86      |
| Pbsvcacctsync.dll                    | 2015.130.4422.0 | 72896     | 07-Mar-17 | 00:17 | x64      |
| Sql_common_core_keyfile.dll          | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlmgmprovider.dll                   | 2015.130.4422.0 | 364224    | 07-Mar-17 | 00:16 | x86      |
| Sqlmgmprovider.dll                   | 2015.130.4422.0 | 404160    | 07-Mar-17 | 00:16 | x64      |
| Sqlsvcsync.dll                       | 2015.130.4422.0 | 267456    | 07-Mar-17 | 00:16 | x86      |
| Sqlsvcsync.dll                       | 2015.130.4422.0 | 348864    | 07-Mar-17 | 00:16 | x64      |
| Sqltdiagn.dll                        | 2015.130.4422.0 | 60608     | 07-Mar-17 | 00:16 | x86      |
| Sqltdiagn.dll                        | 2015.130.4422.0 | 67776     | 07-Mar-17 | 00:16 | x64      |
| Svrenumapi130.dll                    | 2015.130.4422.0 | 854208    | 07-Mar-17 | 00:16 | x86      |
| Svrenumapi130.dll                    | 2015.130.4422.0 | 1115840   | 07-Mar-17 | 00:16 | x64      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4422.0  | 1876672   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4422.0  | 1876680   | 07-Mar-17 | 00:17 | x86      |

SQL Server 2016 Database Services Core Instance

|                File name                |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Databasemail.exe                        | 13.0.16100.4    | 29888     | 09-Dec-16 | 00:46 | x64      |
| Hkcompile.dll                           | 2015.130.4422.0 | 1297096   | 07-Mar-17 | 00:17 | x64      |
| Hkengine.dll                            | 2015.130.4422.0 | 5599936   | 07-Mar-17 | 00:18 | x64      |
| Hkruntime.dll                           | 2015.130.4422.0 | 158912    | 07-Mar-17 | 00:18 | x64      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll | 13.0.4422.0     | 79552     | 07-Mar-17 | 01:34 | x86      |
| Microsoft.sqlserver.types.dll           | 2015.130.4422.0 | 391872    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.vdiinterface.dll    | 2015.130.4422.0 | 71360     | 07-Mar-17 | 00:17 | x64      |
| Qds.dll                                 | 2015.130.4422.0 | 843968    | 07-Mar-17 | 00:17 | x64      |
| Sql_engine_core_inst_keyfile.dll        | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlaccess.dll                           | 2015.130.4422.0 | 462528    | 07-Mar-17 | 00:16 | x64      |
| Sqlagent.exe                            | 2015.130.4422.0 | 565952    | 07-Mar-17 | 01:33 | x64      |
| Sqlceip.exe                             | 13.0.4422.0     | 246976    | 07-Mar-17 | 01:34 | x86      |
| Sqldk.dll                               | 2015.130.4422.0 | 2584768   | 07-Mar-17 | 00:17 | x64      |
| Sqllang.dll                             | 2015.130.4422.0 | 39375552  | 07-Mar-17 | 00:17 | x64      |
| Sqlmin.dll                              | 2015.130.4422.0 | 37597896  | 07-Mar-17 | 00:16 | x64      |
| Sqlos.dll                               | 2015.130.4422.0 | 26304     | 07-Mar-17 | 00:17 | x64      |
| Sqlscriptdowngrade.dll                  | 2015.130.4422.0 | 27840     | 07-Mar-17 | 00:16 | x64      |
| Sqlscriptupgrade.dll                    | 2015.130.4422.0 | 5797056   | 07-Mar-17 | 00:17 | x64      |
| Sqlservr.exe                            | 2015.130.4422.0 | 392896    | 07-Mar-17 | 01:33 | x64      |
| Sqltses.dll                             | 2015.130.4422.0 | 8897216   | 07-Mar-17 | 00:16 | x64      |
| Stretchcodegen.exe                      | 13.0.4422.0     | 56000     | 07-Mar-17 | 01:34 | x86      |
| Xpstar.dll                              | 2015.130.4422.0 | 422592    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 Database Services Core Shared

|                            File name                            |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll | 13.0.4422.0     | 70848     | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll          | 13.0.4422.0     | 73408     | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll       | 13.0.4422.0     | 63680     | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                    | 13.0.4422.0     | 215232    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                | 13.0.14510.3    | 30912     | 12-Oct-16 | 10:35 | x86      |
| Microsoft.sqlserver.replication.dll                             | 2015.130.4422.0 | 1639104   | 07-Mar-17 | 00:17 | x64      |
| Sql_engine_core_shared_keyfile.dll                              | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlmergx.dll                                                    | 2015.130.4422.0 | 346824    | 07-Mar-17 | 00:16 | x64      |
| Txdatacollector.dll                                             | 2015.130.4422.0 | 367296    | 07-Mar-17 | 00:16 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4422.0 | 1013960   | 07-Mar-17 | 00:17 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlsatellite.dll              | 2015.130.4422.0 | 837312    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.130.4422.0 | 660160    | 07-Mar-17 | 00:17 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4422.0     | 23744     | 07-Mar-17 | 01:34 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 Integration Services

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.integrationservice.hadooptasks.dll | 13.0.4422.0     | 73408     | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll | 13.0.4422.0     | 73408     | 07-Mar-17 | 00:17 | x86      |
| Msdtssrvr.exe                                          | 13.0.4422.0     | 216768    | 07-Mar-17 | 01:34 | x64      |
| Sql_is_keyfile.dll                                     | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Sqlceip.exe                                            | 13.0.4422.0     | 246976    | 07-Mar-17 | 01:34 | x86      |

SQL Server 2016 Reporting Services

|                     File name                     |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.datarendering.dll     | 13.0.4422.0     | 166088    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.diagnostics.dll       | 13.0.4422.0     | 1621184   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.excelrendering.dll    | 13.0.4422.0     | 657608    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.htmlrendering.dll     | 13.0.4422.0     | 1069760   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll | 13.0.4422.0     | 125128    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.portal.services.dll   | 13.0.4422.0     | 4920512   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.portal.web.dll        | 13.0.4422.0     | 10417344  | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.portal.webhost.exe    | 13.0.4422.0     | 93888     | 07-Mar-17 | 01:34 | x64      |
| Microsoft.reportingservices.processingcore.dll    | 13.0.4422.0     | 5951168   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll | 13.0.4422.0     | 245952    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.reportingservices.spbprocessing.dll     | 13.0.4422.0     | 298176    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.reportingservices.upgradescripts.dll    | 13.0.4422.0     | 501960    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.types.dll                     | 2015.130.4422.0 | 391872    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.types.dll                     | 2015.130.4422.0 | 396992    | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll                                      | 2015.130.4422.0 | 6507712   | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll                                      | 2015.130.4422.0 | 7506624   | 07-Mar-17 | 00:17 | x64      |
| Reportingserviceslibrary.dll                      | 13.0.4422.0     | 2521800   | 07-Mar-17 | 00:17 | x86      |
| Reportingservicesnativeclient.dll                 | 2015.130.4422.0 | 114368    | 07-Mar-17 | 00:16 | x86      |
| Reportingservicesnativeclient.dll                 | 2015.130.4422.0 | 108744    | 07-Mar-17 | 00:17 | x64      |
| Reportingservicesnativeserver.dll                 | 2015.130.4422.0 | 99008     | 07-Mar-17 | 00:17 | x64      |
| Reportingserviceswebserver.dll                    | 13.0.4422.0     | 2707648   | 07-Mar-17 | 00:17 | x86      |
| Sql_rs_keyfile.dll                                | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Xmsrv.dll                                         | 2015.130.4422.0 | 24039104  | 07-Mar-17 | 00:16 | x64      |
| Xmsrv.dll                                         | 2015.130.4422.0 | 32715456  | 07-Mar-17 | 00:17 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4422.0     | 23752     | 07-Mar-17 | 00:17 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4422.0 | 2023104   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4422.0     | 433856    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4422.0     | 433856    | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4422.0     | 2044608   | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4422.0     | 2044616   | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4422.0     | 33472     | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4422.0     | 33480     | 07-Mar-17 | 00:17 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4422.0     | 249536    | 07-Mar-17 | 00:16 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4422.0     | 249536    | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4422.0 | 6507712   | 07-Mar-17 | 00:17 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4422.0 | 7506624   | 07-Mar-17 | 00:17 | x64      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4422.0 | 100544    | 07-Mar-17 | 00:17 | x64      |
| Xmsrv.dll                                      | 2015.130.4422.0 | 24039104  | 07-Mar-17 | 00:16 | x64      |
| Xmsrv.dll                                      | 2015.130.4422.0 | 32715456  | 07-Mar-17 | 00:17 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
