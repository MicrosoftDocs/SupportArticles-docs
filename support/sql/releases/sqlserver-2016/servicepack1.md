---
title: SQL Server 2016 Service Pack 1 release information (KB3182545)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 release information (KB3182545).
ms.date: 10/26/2023
ms.custom: KB3182545
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB3182545 - SQL Server 2016 Service Pack 1 release information

_Release Date:_ &nbsp; November 16, 2016  
_Version:_ &nbsp; 13.0.4001.0

This article contains important information to read before you install Microsoft SQL Server 2016 Service Pack 1 (SP1). It describes how to get the service pack, the list of fixes that are included in the service pack, known issues, and a list of copyright attributions for the product.

> [!NOTE]
> This article serves as a single source of information to locate all documentation that's related to this service pack. It includes all the information that you previously found in the release notes and *Readme.txt* files.

## Known issues in this service pack

### SQL Server Reporting Services

After you install SQL Server 2016 SP1, you may encounter the following issues when you use SQL Server Reporting Services:

- If Reporting Services is set to use a secure (https/SSL) connection, a warning about security content may be displayed.

- In certain scenarios, the Print button stops working.

Install the hotfix in [KB 3207512](https://support.microsoft.com/help/3207512) to address these issues.

### SQL Server Integration Services (SSIS)

After you install SQL Server 2016 SP1, the DCOM permissions for launching and accessing Integration Services service are reset to default permissions. If you have customized DCOM permissions, you'll need to reapply the customization.

### ODBC Driver 13.1

With the default installation of SQL Server 2016, ODBC Driver 13.0 is installed on the server which is used by SQL Agent and SSMS (installed on server) to connect to the SQL Server instance. If you have installed ODBC Driver 13.1 on your server for any reason, SQL Server 2016 SP1 installation overrides the ODBC Driver 13.1 installation and the fixes introduced in 13.1 like [KB 3185365](../../ssms/error-you-try-to-read-error-log.md) may be lost. In this case post installation of SQL Server 2016 SP1, it's recommended to uninstall the ODBC Driver installed by SQL Server 2016 SP1 and install [ODBC Driver 13.1](https://www.microsoft.com/download/details.aspx?id=53339).

To check for ODBC Driver installed on the server, you can go to Control Panel of the server -> Programs and Features -> Search for ODBC. The version number of ODBC Driver 13.1 is 13.1.811.168 as shown below:

:::image type="content" source="../media/servicepack1/odbc-driver.png" alt-text="Screenshot of the Microsoft ODBC Driver 13 for SQL Server.":::

## List of fixes included in SQL Server 2016 SP1

Microsoft SQL Server 2016 service packs are cumulative updates. SQL Server 2016 SP1 upgrades all editions and service levels of SQL Server 2016 to SQL Server 2016 SP1. In addition to the fixes that are listed in this article, SQL Server 2016 SP1 includes hotfixes that were included in [SQL Server 2016 Cumulative Update 1 (CU1)](rtm-cumulativeupdate1.md) to [SQL Server 2016 CU3](rtm-cumulativeupdate3.md).

For more information about the cumulative updates that are available in SQL Server 2016, see [SQL Server 2016 build versions](build-versions.md).

> [!NOTE]
>
> - Additional fixes that aren't documented here may also be included in the service pack.
> - This list will be updated when more articles are released.

For more information about the bugs that are fixed in SQL Server 2016 SP1, go to the following Microsoft Knowledge Base articles.

| Bug reference | Description |
|---|---|
| <a id=7778636>[7778636](#7778636)</a> | [An update is available that extends the Trace extended event with security protocol handshake information in SQL Server 2016 (KB3191296)](https://support.microsoft.com/help/3191296) |
| <a id=7898693>[7898693](#7898693)</a> | [How to use DBCC CLONEDATABASE to generate a schema and statistics-only copy of a user database in SQL Server 2014 SP2 and SQL Server 2016 SP1 (KB3177838)](https://support.microsoft.com/help/3177838) |
| <a id=7994008>[7994008](#7994008)</a> | [Supports DROP TABLE DDL for articles that are included in transactional replication in SQL Server 2014 or in SQL Server 2016 SP1 (KB3170123)](https://support.microsoft.com/help/3170123) |
| <a id=8024963>[8024963](#8024963)</a> | [Update to add a memory grant warning to the Showplan XML in SQL Server 2014 or 2016 (KB3172997)](https://support.microsoft.com/help/3172997) |
| <a id=8024978>[8024978](#8024978)</a> | [Update to add DMF sys.dm_db_incremental_stats_properties in SQL Server 2014 or 2016 (KB3170114)](https://support.microsoft.com/help/3170114) |
| <a id=8024984>[8024984](#8024984)</a> | [Update to expose maximum memory enabled for a single query in Showplan XML in SQL Server 2014 or 2016 (KB3170112)](https://support.microsoft.com/help/3170112) |
| <a id=8024985>[8024985](#8024985)</a> | [Information about enabled trace flags is added to the showplan XML in SQL Server 2014 SP2 or 2016 (KB3170115)](https://support.microsoft.com/help/3170115) |
| <a id=8025018>[8025018](#8025018)</a> | [Improved diagnostics for query execution plans that involve residual predicate pushdown in SQL Server (KB3107397)](https://support.microsoft.com/help/3107397) |
| <a id=8025088>[8025088](#8025088)</a> | [Update adds AlwaysOn extended events and performance counters in SQL Server 2014 or 2016 (KB3173156)](https://support.microsoft.com/help/3173156) |
| <a id=8025128>[8025128](#8025128)</a> | [Adds a stored procedure for the manual cleanup of the change tracking side table in SQL Server 2014 SP2 or 2016 SP1 (KB3173157)](https://support.microsoft.com/help/3173157) |
| <a id=8103248>[8103248](#8103248)</a> | [An update is available that introduces a new query hint USE HINT in SQL Server 2016 (KB3189813)](https://support.microsoft.com/help/3189813) |
| <a id=8103261>[8103261](#8103261)</a> | [An update to introduce a new Transact-SQL statement CREATE OR ALTER in SQL Server 2016 (KB3190548)](https://support.microsoft.com/help/3190548) |
| <a id=8103265>[8103265](#8103265)</a> | [Update to improve diagnostics by exposing data type of the parameters for parameterized queries in showplan XML output in SQL Server 2016 (KB3190761)](https://support.microsoft.com/help/3190761) |
| <a id=8110745>[8110745](#8110745)</a> | [An update is available that adds support for self-referential constraints in the new Referential Integrity Operator in SQL Server 2016 (KB3191273)](https://support.microsoft.com/help/3191273) |
| <a id=8149617>[8149617](#8149617)</a> | [Update to improve diagnostics for query execution plans that involve residual predicate pushdown in SQL Server 2016 (KB3190762)](https://support.microsoft.com/help/3190762) |
| <a id=8155425>[8155425](#8155425)</a> | [A new DynamicManagement Function "sys.dm_exec_query_statistics_xml" is available in SQL Server 2016 Service Pack 1 (KB3190871)](https://support.microsoft.com/help/3190871) |
| <a id=8349500>[8349500](#8349500)</a> | [An update is available that adds overall query execution statistics information to the STATISTICS XML output in SQL Server 2016 (KB3201552)](https://support.microsoft.com/help/3201552) |
| <a id=7062744>[7062744](#7062744)</a> | [FIX: "'Salt' attribute for Password is missing in the project manifest" error when you close and reopen an SSIS BI project in SQL Server 2016 (KB3189687)](https://support.microsoft.com/help/3189687) |
| <a id=8024967>[8024967](#8024967)</a> | [FIX: A severe error when you use the sys.dm_db_uncontained_entities DMV in SQL Server 2014 or 2016 (KB3172998)](https://support.microsoft.com/help/3172998) |
| <a id=8024976>[8024976](#8024976)</a> | ["Log provider "Microsoft.LogProviderSQLServer" is not installed correctly" error when you open the Configure SSIS Logs window (KB3100256)](https://support.microsoft.com/help/3100256) |
| <a id=8025041>[8025041](#8025041)</a> | [FIX: "Unable to create restore plan due to break in the LSN chain" error when you restore differential backup in SSMS (KB3065060)](https://support.microsoft.com/help/3065060) |
| <a id=8025045>[8025045](#8025045)</a> | [Error when you execute SSIS package on FIPS-enabled Windows (KB2925865)](https://support.microsoft.com/help/2925865) |
| <a id=8025056>[8025056](#8025056)</a> | [FIX: Memory grant that's required to run optimized nested loop join isn't reflected in Showplan XML in SQL Server 2014 or 2016 (KB3170116)](https://support.microsoft.com/help/3170116) |
| <a id=8025125>[8025125](#8025125)</a> | [FIX: SQL Server error log incorrectly mentions logical processors when soft-NUMA is enabled (KB3189663)](https://support.microsoft.com/help/3189663) |
| <a id=8025131>[8025131](#8025131)</a> | [DMV sys.dm_os_memory_nodes returns a non-zero value for the pages_kb value for the DAC node in SQL Server 2016 (KB3170015)](https://support.microsoft.com/help/3170015) |
| <a id=8025149>[8025149](#8025149)</a> | [FIX: DBCC CHECKDB or CHECKTABLE returns false positives for data corruption and assertion failures in SQL Server 2014 or 2016 (KB3173766)](https://support.microsoft.com/help/3173766) |
| <a id=8265472>[8265472](#8265472)</a> | [FIX: Installation of Cumulative Update 1 for SQL Server 2016 fails on a named instance (KB3189709)](https://support.microsoft.com/help/3189709) |
| <a id=8273495>[8273495](#8273495)</a> | [FIX: Deadlock when you execute a query plan with a nested loop join in batch mode in SQL Server 2014 or 2016 (KB3195825)](https://support.microsoft.com/help/3195825) |
| <a id=8274352>[8274352](#8274352)</a> | [FIX: Long compilation time for a query that contains many distinct operators in SQL Server 2016 (KB3201554)](https://support.microsoft.com/help/3201554) |
| <a id=8338496>[8338496](#8338496)</a> | [FIX: FileTable directory stops responding when you create multiple files concurrently in SQL Server 2014 or 2016 (KB3191062)](https://support.microsoft.com/help/3191062) |
| <a id=8343868>[8343868](#8343868)</a> | [FIX: Queries that use CHANGETABLE use much more CPU in SQL Server 2014 SP1 or in SQL Server 2016 (KB3180060)](https://support.microsoft.com/help/3180060) |
| <a id=8451202>[8451202](#8451202)</a> | [FIX: SQL Server 2016 doesn't log error messages that have a severity level of 21 for checksum mismatches found in In-Memory OLTP checkpoint files (KB4019715)](https://support.microsoft.com/help/4019715) |
| <a id=8528563>[8528563](#8528563)</a> | [FIX: SQL Server 2016 stops responding when you restore databases that contain memory-optimized tables (KB3197605)](https://support.microsoft.com/help/3197605) |
| <a id=8529432>[8529432](#8529432)</a> | [FIX: SQL Server Managed Backup to Windows Azure tries to back up database snapshots in SQL Server (KB3168708)](https://support.microsoft.com/help/3168708) |
| | [New performance feature that accelerates transaction commit times (latency) by up to 2-4X, when employing Storage Class Memory (NVDIMM-N nonvolatile storage)](/archive/blogs/sqlserverstorageengine/transaction-commit-latency-acceleration-using-storage-class-memory-in-windows-server-2016sql-server-2016-sp1) |
| | [Poor performance when you run INSERT.. SELECT operations in SQL Server 2016 (KB3180087)](https://support.microsoft.com/help/3180087) |
| | ["A digitally signed driver is required" warning when you install SQL Server packages in Windows Server 2016 and Windows 10 (KB3203693)](https://support.microsoft.com/help/3203693) |
| <a id=8024991>[8024991](#8024991)</a> | FIX: Missing columns aren't specified in the error message when you import data by using the Import and Export Wizard (KB3112704) |

### Additional resolutions

Resolutions to the following issues are also included in SQL Server 2016 SP1.

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=6867499>[6867499](#6867499)</a></br><a id=8024974>[8024974](#8024974)</a> | NULL values are ignored when altering the data type of a column from **text** to **varchar(max)**. | Engine |
| <a id=8024962>[8024962](#8024962)</a> | **Sqlcmd** quits without error if the query text contains both embedded comments and curly braces `("{"` or `"}")`. | Engine |
| <a id=8024968>[8024968](#8024968)</a> | Batch sort and optimized nested loop may cause stability and performance issues. | Engine |
| <a id=8024987>[8024987](#8024987)</a> | Table scans and index scans with push-down predicate tend to overestimate memory grant for the parent operator. | Engine |
| <a id=8024997>[8024997](#8024997)</a> | The Full-Text Search feature doesn't work as expected for Dutch language. | Engine |
| <a id=8025069>[8025069](#8025069)</a> | The `CREATE NONCLUSTERED INDEX` statement may fail if the database name begins with a '`#`' character. | Engine |
| <a id=8025097>[8025097](#8025097)</a> | Add informational messages for `tempdb` configurations in the SQL Server error log. | Engine |
| <a id=8267453>[8267453](#8267453)</a> | `MERGE` statements that contain both `UPDATE` and `INSERT` statements fail with "Cannot insert duplicate key row" if the destination table contains unique index. | Engine |
| <a id=8279683>[8279683](#8279683)</a> | SQL Server crashes when a Tuple Mover task is terminated unexpectedly. | Engine |
| <a id=8025058>[8025058](#8025058)</a> | Add the table name and Primary Key value information for error 20598 in the `msdistribution_history` table (SQL Server Replication). | Improvement |
| <a id=8025059>[8025059](#8025059)</a> | When a replication agent fails with query timeout, the query text is logged without verbose logging enabled. | Replication |
| <a id=8025081>[8025081](#8025081)</a> | The Replication Log Reader Agent may fail when destination table is an empty string. | Replication |
| <a id=4300066>[4300066](#4300066)</a> | Update the copyright information to '&copy; 2016 Microsoft' in the SQL Server command prompt installation. | Setup |
| <a id=5610151>[5610151](#5610151)</a> | Unnecessary warning message is returned in the command line output when slipstream installs SQL Server with command line option. | Setup |
| <a id=7270486>[7270486](#7270486)</a> | After you removed one or more updates for SQL Server, when you repair SQL Server, the repair operation fails with errors. | Setup |
| <a id=7350315>[7350315](#7350315)</a> | Install SQL Server on a computer that has a non-English domain name will fail with error 'Illegal characters in path'. | Setup |
| <a id=7439317>[7439317](#7439317)</a> | The string 'Setup Discovery Report' in the 'Installed SQL Server features discovery report' isn't localized. | Setup |
| <a id=7439502>[7439502](#7439502)</a> | SQL Server 2016 installation wizard incorrectly mentioned SQL Server 2008 SP3 while SQL 2008 R2 SP3 is required. | Setup |
| <a id=8024994>[8024994](#8024994)</a> | On the Complete tab, the link to the 'Surface Area Configuration' MSDN documentation is missing from the Document and Links section in a slipstream installation. | Setup |
| <a id=8051010>[8051010](#8051010)</a> | The setup of SQL Server 2016 may fail if ODBC Driver 11 for SQL Server is installed during the setup. | Setup |
| <a id=8343905>[8343905](#8343905)</a> | A slipstream installation may fail with the 'Strong name validation failed' error. | Setup |
| <a id=8348718>[8348718](#8348718)</a> | If `UpdateEnabled` is set to `False` in a slipstream installation, the setup summary log doesn't contain the information of the updates installed during the installation. | Setup |
| <a id=8024972>[8024972](#8024972)</a> | BCP fails with error when parsing date format `YYYY/MM/DD` into a `DATE` column. | SQL connectivity |
| <a id=5128484>[5128484](#5128484)</a> | Standard edition of SQL Server 2016 Analysis Services (Tabular mode) ignores the 16 GB memory limit. | SSAS |
| <a id=7487320>[7487320](#7487320)</a> | Queries that contain Row-Level Security (RLS) may fail even if the DataView is set to Sample. | SSAS |
| <a id=8210484>[8210484](#8210484)</a> | Affinity mask doesn't work correctly for NUMA nodes in SQL Server 2016 Analysis Services. | SSAS |
| <a id=8281121>[8281121](#8281121)</a> | Improve SSAS Tabular performance scalability by implementing NUMA awareness in SSAS Tabular mode. | SSAS |
| <a id=8430619>[8430619](#8430619)</a> | Improve SSAS Tabular performance scalability by using Intel&reg; Threading Building Blocks (Intel&reg; TBB). | SSAS |
| <a id=8024998>[8024998](#8024998)</a> | Error "Log provider 'Microsoft.LogProviderEventLog' is not installed" occurs when you open the Configure SSIS Logs: Package dialog in an SSIS package that already has a log. | SSIS |
| <a id=8025032>[8025032](#8025032)</a> | This update changes the behavior that when the XML Task can't get encoding from the XML documents, Unicode encoding will be used. | SSIS |
| <a id=7330691>[7330691](#7330691)</a> | Adds additional information to indicate whether a report is a Mobile report to the SSRS report server execution logs. | SSRS |
| <a id=7807395>[7807395](#7807395)</a> | You may need to retry reauthorization if data reconciliation fails on a Stretch Database enabled table. | Stretch DB |
| <a id=8196154>[8196154](#8196154)</a> | Query execution may fail on a Stretch Database enabled table that has filter predicate specified. | Stretch DB |
| <a id=8292093>[8292093](#8292093)</a> | Creating, altering or dropping indexes on a table with Stretch Database enabled may fail. | Stretch DB |

For more information about how to upgrade your SQL Server installation to SQL Server 2016 SP1, see [Supported version and edition upgrades](/sql/database-engine/install-windows/supported-version-and-edition-upgrades).

## How to get SQL Server 2016 SP1

SQL Server 2016 SP1 is available for download at the [SQL Server 2016 SP1 download page](https://www.catalog.update.microsoft.com/Search.aspx?q=KB3182545).

> [!NOTE]
> After you install the service pack, the SQL Server service version should be reflected as 13.0.4422.0.

## Uninstalling SQL Server 2016 SP1 (not recommended)

If for any reason you choose to uninstall SQL Server 2016 SP1, the uninstallation of SQL Server 2016 SP1 isn't blocked and you'll be able to uninstall SQL Server 2016 SP1 like any other service pack. However, if you're running Standard, Web, Express edition of SQL Server and leveraging some of the new features which are unlocked only starting SQL Server 2016 SP1, you might see some unforeseen errors or databases might even be left in suspect state after uninstallation of SQL Server 2016 SP1. Even worse would be if the system databases are using new features for example, partitioned table in master database, it can lead to SQL Server instance unable to start after uninstalling SQL Server 2016 SP1. Hence it's recommended to validate all the new features are disabled or dropped before you choose to uninstall SQL Server 2016 SP1 on editions other than Enterprise Edition. It isn't possible to drop [memory_optimized_data](/sql/relational-databases/in-memory-oltp/the-memory-optimized-filegroup) filegroup. Hence if you have setup `memory_optimized_data` filegroup on your database with SP1, you shouldn't uninstall SQL Server 2016 SP1 in that case else the database will get in suspect mode with following error message logged in the error log:

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
