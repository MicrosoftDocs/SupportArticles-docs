---
title: Cumulative update 5 for SQL Server 2022 (KB5026806)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 5 (KB5026806).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5026806
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5026806 - Cumulative Update 5 for SQL Server 2022

_Release Date:_ &nbsp; June 15, 2023  
_Version:_ &nbsp; 16.0.4045.3

## Summary

This article describes Cumulative Update package 5 (CU5) for Microsoft SQL Server 2022. This update contains 32 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 4, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4045.3**, file version: **2022.160.4045.3**
- Analysis Services - Product version: **16.0.43.218**, file version: **2022.160.43.218**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

|Bug reference | Description| Fix area| Component | Platform |
|:------------------------------------------------:|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|-------------------------------------------|----------|
| <a id="2369044">[2369044](#2369044)</a> | Adds additional enforcement of write operations to the encryption algorithm that's used to encrypt data sources and connection strings in SQL Server Analysis Services (SSAS) models. For more information, see [Upgrade encryption](https://go.microsoft.com/fwlink/?linkid=2224274). | Analysis Services | Analysis Services | Windows |
| <a id="2400346">[2400346](#2400346)</a> | Fixes an issue where a hierarchy created in Master Data Services (MDS) doesn't expand correctly (on both the **Edit Derived Hierarchy** page and the **Hierarchy** page in the Explorer area). | Master Data Services | Master Data Services | Windows |
| <a id="2400389">[2400389](#2400389)</a> | Adds an option for the Master Data Services (MDS) configuration tool to decide whether to enable the **PerformanceImprovementEnable** performance improvement setting. |Master Data Services | Master Data Services | Windows|
| <a id="2400415">[2400415](#2400415)</a> | Fixes the following error that you may encounter when selecting any cell of a domain-based attribute column that has a different name and display name in a Master Data Services (MDS) entity and then selecting the drop-down arrow: </br></br>The current cell column title was not found. If the column title was changed, close the sheet and try again. | Master Data Services | Master Data Services | Windows |
| <a id="2342416">[2342416](#2342416)</a>| Adds the `sp_validate_certificate_ca_chain` stored procedure for checking the validity of the certificate chain used for certificate-based authentication on endpoints of Service Broker, availability groups, and Managed Instance link. | SQL Server Engine | Security infrastructure| All |
| <a id="2384656">[2384656](#2384656)</a>| Updates the support for predicate pushdown when filtering on the `session_id` column of the `sys.dm_exec_connections` dynamic management view (DMV). | SQL Connectivity | SQL Connectivity| All |
| <a id="2396496">[2396496](#2396496)</a> | Fixes a network socket crash that affects SQL connectivity during a large number of connections. |SQL Connectivity |SQL Connectivity | Linux |
| <a id="2402260">[2402260](#2402260)</a> | Updates the version of the Microsoft ODBC driver to 17.10.4.1. For more information, see [Release Notes for Microsoft ODBC Driver for SQL Server on Windows](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows). | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2402263">[2402263](#2402263)</a> | Updates the version of the Microsoft OLE DB driver to 18.6.6. For more information, see [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server). | SQL Connectivity | SQL Connectivity | Windows |
| <a id="2402141">[2402141](#2402141)</a> | Fixes an issue where applying the option `ONLINE` in the `ALTER INDEX REBUILD` statement is invalid when running the index rebuild task created in an index maintenance plan. | SQL Server Client Tools | Management Services | All |
|  <a id="2399781">[2399781](#2399781)</a> | Fixes a memory leak issue that you encounter when you run queries that use an equals (`=`) string predicate on a clustered columnstore index (CCI). | SQL Server Engine | Column Stores | All |
|  <a id="2399843">[2399843](#2399843)</a> | Fixes a performance issue that you may encounter when the String Min/Max for Rowgroup Elimination feature is enabled, and you query a clustered columnstore index (CCI) that's built with the feature disabled. The queries that contain simple string predicates may incorrectly qualify a rowgroup. | SQL Server Engine | Column Stores | All |
| <a id="2417114">[2417114](#2417114)</a> | Consider the following scenario: </br></br>- You have an instance of SQL Server that connects to Microsoft Entra ID. </br></br>- You enable Transport Layer Security (TLS) encryption on this instance of SQL Server. </br></br>In this scenario, you may receive the following error 39011 if you run the `sp_execute_external_script` query against the instance: </br></br>Msg 39011, Level 16, State 7, Line \<LineNumber> </br>SQL Server was unable to communicate with the LaunchPad service for request id: \<ID>. Please verify the configuration of the service. | SQL Server Engine | Extensibility | Linux |
|<a id="2375473">[2375473](#2375473)</a> | Fixes an issue where the following error occurs when you disable the FILESTREAM feature on a SQL Server failover cluster instance (FCI) by using SQL Server Configuration Manager (SSCM): </br></br>There was an unknown error applying FILESTREAM settings. </br>Check the parameters are valid. (0x800713d6) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="2391164">[2391164](#2391164)</a> | Fixes an issue where messages in the `sys.transmission_queue` of the initiator database in a SQL Server Service Broker conversation are missing or stuck after a failover of the target database. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="2268493">[2268493](#2268493)</a> | Fixes an issue where restoring an In-Memory OLTP database backup that has Transparent data encryption (TDE) enabled fails and returns the following error message: </br></br>Error: 33126, Severity: 16, State: 1. </br>Database encryption key is corrupted and cannot be read. </br></br>**Note**: To apply this fix, you need to enable a trace flag (TF) to relax TDE checks for In-Memory tables and disable the TF after the restoration is completed. For more information, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support).| SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2370134">[2370134](#2370134)</a> | Fixes an assertion dump issue (Location: "sql\\\ntdbms\\\hekaton\\\engine\\\core\\\tx.cpp":4753; Expression: 0 == Dependencies.CommitDepCountOut) that causes an availability group failover. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2396747">[2396747](#2396747)</a> | Fixes a dump issue where a huge number of concurrent In-Memory OLTP transactions cause a stack overflow.| SQL Server Engine | In-Memory OLTP | All |
| <a id="2402985">[2402985](#2402985)</a> | Removes the need for running the `sys.sp_xtp_force_gc` stored procedure twice to free up allocated and used XTP memory, and running it once is enough. You need at least the `ALTER SERVER STATE` permission to run this procedure.| SQL Server Engine | In-Memory OLTP|All |
| <a id="2005656">[2005656](#2005656)</a> | Adds support for Azure Data Lake Storage (ADLS) Gen2 as a storage location in `CREATE EXTERNAL TABLE AS SELECT` (CETAS), which fixes the following error 15883 that you encounter when you try to use them: </br></br>Msg 15883, Level 16, State 1, Line \<LineNumber> </br>Access check for 'CREATE/WRITE' operation against '\<Location>' failed with HRESULT = '0x80070057'. | SQL Server Engine | PolyBase | All |
| <a id="2398344">[2398344](#2398344)</a> | Fixes an issue where external data sources that use the generic ODBC connector may not work after you install SQL Server 2022 CU2 or later versions. You may encounter the following scenarios: </br></br>- When you try to query an external table that was created before you install this fix on a generic ODBC data source, and the `CONNECTION_OPTIONS` argument uses a `DSN` parameter without the `Driver` keyword, you receive the following error message: </br></br>Msg 7320, Level 16, State 110, Line \<LineNumber> </br>Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object. </br></br>- If you try to create a new external table, you receive the following error message: </br></br>Msg 110813, Level 16, State 1, Line \<LineNumber> </br>Object reference not set to an instance of an object. </br></br>**Note**: Before you apply this fix, you can uninstall SQL Server 2022 CU2 or later versions, or add the `Driver` keyword to the `CONNECTION_OPTIONS` argument as a workaround. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873). | SQL Server Engine |PolyBase |Windows |
| <a id="2357623">[2357623](#2357623)</a> | Fixes an access violation caused by transient race conditions in certain scenarios when parameter sensitive plan (PSP) optimization has Query Store integration enabled. | SQL Server Engine | Query Execution | All |
| <a id="2417020">[2417020](#2417020)</a> | [FIX: Incorrect results may occur when you run queries against tables that contain indexes using a descending sort order (KB5027811)](incorrect-results-run-queries.md) | SQL Server Engine | Query Optimizer | All |
| <a id="2371755">[2371755](#2371755)</a> | Fixes a dump issue where the Cardinality Estimation (CE) feedback validation flag is set on statements that come after the statement analyzed by CE Feedback within a batch. | SQL Server Engine | Query Optimizer | All |
| <a id="2320880">[2320880](#2320880)</a> | Fixes an issue where applying an update on a secondary replica or performing an in-place upgrade fails when the distribution database is in an availability group. The following error is returned: </br></br>Error: There was an error executing the Replication upgrade scripts. See the SQL Server error log for details. </br></br>You can see the following error details in the SQL Server error log: </br></br>Executing sp_vupgrade_replication. </br>Could not open distribution database distribution because it is offline or being recovered. Replication settings and system objects could not be upgraded. Be sure this database is available and run sp_vupgrade_replication again. | SQL Server Engine | Replication | Windows |
| <a id="2357336">[2357336](#2357336)</a> | Fixes an issue that you encounter in the following scenario: </br></br>- A SQL Server 2017 instance is configured as the Publisher, and a SQL Server 2022 instance is configured as the Distributor. </br></br>- The Publication database is configured as a part of an availability group. </br></br>In this configuration, the Log Reader Agent fails together with the following error: </br></br>\<DateTime> Status: 0, code: 20011, text: 'The process could not execute 'sp_replcmds' on 'publisherserver'. </br>\<DateTime> Status: 0, code: 18751, text: 'sp_replcmds procedure was called with the wrong number of parameters.'. | SQL Server Engine | Replication | Windows |
| <a id="2351584">[2351584](#2351584)</a> | Fixes an issue where high PREEMPTIVE_OS_QUERYREGISTRY waits occur. To apply this fix, you need to turn on trace flag 12502, which is used to disable external authorization policies for on-premises SQL Server instances. | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2401498">[2401498](#2401498)</a> | Consider the following scenario: </br></br>- You connect to SQL Server as user A. </br></br>- In the meantime, user B's password is changed in the background. </br></br>In this scenario, the following error may occur when you create a database and then try to use it: </br></br>Msg 916, Level 14, State 2, Line \<LineNumber> </br>The server principal "\<LoginName>" is not able to access the database "\<DatabaseName>" under the current security context. | SQL Server Engine | Security Infrastructure | All |
| <a id="2429240">[2429240](#2429240)</a> | Fixes an issue where upgrading to SQL Server 2022 database mirroring fails and returns the following errors: </br></br>Error: 37526, Severity: 16, State: 1. </br>A ledger table cannot be created while database mirroring is enabled. </br></br>Error: 928, Severity: 20, State: 1. </br>During upgrade, database raised exception 3602, severity 25, state 51, address 00007FFFC67A3614. Use the exception number to determine the cause. | SQL Server Engine | Security Infrastructure | Windows |
| <a id="2357203">[2357203](#2357203)</a> | Fixes an issue where the following error occurs when you try to manually enter the product key while configuring SQL Server by using the command `/opt/mssql/bin/mssql-conf setup` or `sudo /opt/mssql/bin/sqlservr --pid XXXXX-XXXXX-XXXXX-XXXXX-XXXXX`: </br></br>The provided PID [XXXXX-XXXXX-XXXXX-XXXXX-XXXXX] is invalid.The PID must be in the form #####-#####-#####-#####-##### where '#' is a number or letter. | SQL Server Engine | SQL Agent | Linux |
| <a id="2391385">[2391385](#2391385)</a> | Fixes a non-yielding dump issue that you encounter when creating an Extended Events (XEvents) session that captures the `sql_text` field and has several kilobytes of T-SQL queries. | SQL Server Engine | SQL OS | All |
| <a id="2355184">[2355184](#2355184)</a> | After applying this update, `master` databases that are part of contained availability groups will no longer incorrectly report errors when `DBCC CHECKDB` is being run against them outside of the contained context. | SQL Server Engine | Storage Management | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU5 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2023/06/sqlserver2022-kb5026806-x64_acb1d3f77f574f335ac4315aadd8feaf6dfc2d4d.exe)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5026806-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5026806-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5026806-x64.exe| B78292D674D9499A3DCE15D5628E7E5226873FD015F9EEE382CA0197D7C60BAD |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.218 | 336792    | 26-May-23 | 13:17 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.218     | 2903464   | 26-May-23 | 13:17 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 26-May-23 | 13:18 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 26-May-23 | 13:18 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 26-May-23 | 13:18 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 26-May-23 | 13:18 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 26-May-23 | 13:18 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 26-May-23 | 13:18 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 26-May-23 | 13:18 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 26-May-23 | 13:18 | x86      |
| Msmdctr.dll                                         | 2022.160.43.218 | 38864     | 26-May-23 | 13:17 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.218 | 53925272  | 26-May-23 | 13:17 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.218 | 71763904  | 26-May-23 | 13:17 | x64      |
| Msmdpump.dll                                        | 2022.160.43.218 | 10335184  | 26-May-23 | 13:17 | x64      |
| Msmdredir.dll                                       | 2022.160.43.218 | 8132040   | 26-May-23 | 13:17 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.218 | 71309760  | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 956360    | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1884104   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1671120   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1880528   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1847752   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1146824   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1139656   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1768912   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1748432   | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 932248    | 26-May-23 | 13:17 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.218 | 1837008   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 954816    | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1882064   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1668048   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1875920   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1844176   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1144784   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1138128   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1764816   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1744840   | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 932304    | 26-May-23 | 13:17 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.218 | 1832400   | 26-May-23 | 13:17 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.218 | 10083776  | 26-May-23 | 13:17 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.218 | 8265640   | 26-May-23 | 13:17 | x86      |
| Msolap.dll                                          | 2022.160.43.218 | 10970064  | 26-May-23 | 13:17 | x64      |
| Msolap.dll                                          | 2022.160.43.218 | 8744912   | 26-May-23 | 13:17 | x86      |
| Msolui.dll                                          | 2022.160.43.218 | 289704    | 26-May-23 | 13:17 | x86      |
| Msolui.dll                                          | 2022.160.43.218 | 308160    | 26-May-23 | 13:17 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 26-May-23 | 13:18 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 26-May-23 | 13:18 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4045.3 | 137104    | 26-May-23 | 13:17 | x64      |
| Sqlceip.exe                                         | 16.0.4045.3     | 300944    | 26-May-23 | 13:18 | x86      |
| Sqldumper.exe                                       | 2022.160.4045.3 | 227272    | 26-May-23 | 13:18 | x86      |
| Sqldumper.exe                                       | 2022.160.4045.3 | 260048    | 26-May-23 | 13:18 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 26-May-23 | 13:18 | x86      |
| Tmapi.dll                                           | 2022.160.43.218 | 5884328   | 26-May-23 | 13:17 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.218 | 5575072   | 26-May-23 | 13:17 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.218 | 1481128   | 26-May-23 | 13:17 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.218 | 7198160   | 26-May-23 | 13:17 | x64      |
| Xmsrv.dll                                           | 2022.160.43.218 | 26594256  | 26-May-23 | 13:17 | x64      |
| Xmsrv.dll                                           | 2022.160.43.218 | 35896272  | 26-May-23 | 13:17 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4045.3 | 104344    | 26-May-23 | 13:18 | x64      |
| Instapi150.dll                             | 2022.160.4045.3 | 79808     | 26-May-23 | 13:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.218     | 2633640   | 26-May-23 | 13:17 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.218     | 2633640   | 26-May-23 | 13:17 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.218     | 2933144   | 26-May-23 | 13:17 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.218     | 2323368   | 26-May-23 | 13:17 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.218     | 2323408   | 26-May-23 | 13:17 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4045.3     | 554960    | 26-May-23 | 13:18 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4045.3     | 554944    | 26-May-23 | 13:18 | x86      |
| Msasxpress.dll                             | 2022.160.43.218 | 27584     | 26-May-23 | 13:17 | x86      |
| Msasxpress.dll                             | 2022.160.43.218 | 32680     | 26-May-23 | 13:17 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4045.3 | 137104    | 26-May-23 | 13:17 | x64      |
| Sqldumper.exe                              | 2022.160.4045.3 | 227272    | 26-May-23 | 13:18 | x86      |
| Sqldumper.exe                              | 2022.160.4045.3 | 260048    | 26-May-23 | 13:19 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4045.3 | 456600    | 26-May-23 | 13:18 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4045.3 | 395200    | 26-May-23 | 13:18 | x86      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4045.3     | 2066320   | 26-May-23 | 13:18 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4045.3 | 137104    | 26-May-23 | 13:18 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4045.3  | 599952    | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4045.3  | 599960    | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4045.3  | 173976    | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4045.3  | 174032    | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4045.3  | 1857488   | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4045.3  | 1857472   | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4045.3  | 370584    | 26-May-23 | 13:18 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4045.3  | 370592    | 26-May-23 | 13:18 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 26-May-23 | 15:02 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 26-May-23 | 15:02 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4045.3 | 4719056   | 26-May-23 | 15:02 | x64      |
| Aetm-enclave.dll                             | 2022.160.4045.3 | 4673464   | 26-May-23 | 15:02 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4045.3 | 4909136   | 26-May-23 | 15:02 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4045.3 | 4874496   | 26-May-23 | 15:02 | x64      |
| Hadrres.dll                                  | 2022.160.4045.3 | 227264    | 26-May-23 | 15:02 | x64      |
| Hkcompile.dll                                | 2022.160.4045.3 | 1411008   | 26-May-23 | 15:02 | x64      |
| Hkengine.dll                                 | 2022.160.4045.3 | 5760920   | 26-May-23 | 15:02 | x64      |
| Hkruntime.dll                                | 2022.160.4045.3 | 190360    | 26-May-23 | 15:02 | x64      |
| Hktempdb.dll                                 | 2022.160.4045.3 | 71616     | 26-May-23 | 15:02 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.218     | 2322376   | 26-May-23 | 15:02 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4045.3 | 333760    | 26-May-23 | 15:02 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4045.3 | 96208     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 30624     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 38808     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 34712     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 38816     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 38808     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 30624     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 30608     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 34720     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 38808     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 30624     | 26-May-23 | 15:02 | x64      |
| `Odsole70.rll`                                 | 16.0.4045.3     | 38816     | 26-May-23 | 15:02 | x64      |
| Qds.dll                                      | 2022.160.4045.3 | 1791904   | 26-May-23 | 15:02 | x64      |
| Rsfxft.dll                                   | 2022.160.4045.3 | 55192     | 26-May-23 | 15:02 | x64      |
| Secforwarder.dll                             | 2022.160.4045.3 | 83920     | 26-May-23 | 14:21 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4045.3 | 137104    | 26-May-23 | 15:02 | x64      |
| Sqlaccess.dll                                | 2022.160.4045.3 | 444312    | 26-May-23 | 15:02 | x64      |
| Sqlagent.exe                                 | 2022.160.4045.3 | 726944    | 26-May-23 | 15:02 | x64      |
| Sqlceip.exe                                  | 16.0.4045.3     | 300944    | 26-May-23 | 15:02 | x86      |
| Sqlctr160.dll                                | 2022.160.4045.3 | 128976    | 26-May-23 | 15:02 | x86      |
| Sqlctr160.dll                                | 2022.160.4045.3 | 157632    | 26-May-23 | 15:02 | x64      |
| Sqldk.dll                                    | 2022.160.4045.3 | 4028352   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 1746840   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3844000   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4061088   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4568976   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4700048   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3745696   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3934112   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4568984   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4401056   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4470680   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 2443168   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 2385824   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4257688   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3893152   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4409232   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4204448   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4188064   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3970968   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 3848096   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 1685408   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4294552   | 26-May-23 | 14:21 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4045.3 | 4437920   | 26-May-23 | 14:21 | x64      |
| Sqllang.dll                                  | 2022.160.4045.3 | 48605136  | 26-May-23 | 15:02 | x64      |
| Sqlmin.dll                                   | 2022.160.4045.3 | 51337120  | 26-May-23 | 15:02 | x64      |
| Sqlos.dll                                    | 2022.160.4045.3 | 51136     | 26-May-23 | 14:21 | x64      |
| Sqlrepss.dll                                 | 2022.160.4045.3 | 137152    | 26-May-23 | 15:02 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4045.3 | 51104     | 26-May-23 | 15:02 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4045.3 | 5830552   | 26-May-23 | 15:02 | x64      |
| Sqlservr.exe                                 | 2022.160.4045.3 | 722896    | 26-May-23 | 15:02 | x64      |
| Sqltses.dll                                  | 2022.160.4045.3 | 9389984   | 26-May-23 | 14:21 | x64      |
| Sqsrvres.dll                                 | 2022.160.4045.3 | 305104    | 26-May-23 | 15:02 | x64      |
| Svl.dll                                      | 2022.160.4045.3 | 247744    | 26-May-23 | 15:02 | x64      |
| Xe.dll                                       | 2022.160.4045.3 | 718800    | 26-May-23 | 15:02 | x64      |
| Xpstar.dll                                   | 2022.160.4045.3 | 534464    | 26-May-23 | 15:02 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version  | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4045.3 | 268224    | 26-May-2023 | 13:19 | x64      |
| Dts.dll                                              | 2022.160.4045.3 | 3266456   | 26-May-2023 | 13:19 | x64      |
| Logread.exe                                          | 2022.160.4045.3 | 788416    | 26-May-2023 | 13:18 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.218     | 2933656   | 26-May-2023 | 13:19 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 26-May-2023 | 13:18 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4045.3     | 30624     | 26-May-2023 | 13:18 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 26-May-2023 | 13:18 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 26-May-2023 | 13:18 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 26-May-2023 | 13:18 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 26-May-2023 | 13:18 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 26-May-2023 | 13:18 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 26-May-2023 | 13:18 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4045.3     | 391072    | 26-May-2023 | 13:19 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4045.3 | 1714080   | 26-May-2023 | 13:19 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4045.3     | 554960    | 26-May-2023 | 13:18 | x86      |
| Msgprox.dll                                          | 2022.160.4045.3 | 313280    | 26-May-2023 | 13:19 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 2729992   | 26-May-2023 | 13:18 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 153608    | 26-May-2023 | 13:19 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 26-May-2023 | 13:19 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4045.3 | 530336    | 26-May-2023 | 13:18 | x64      |
| Rdistcom.dll                                         | 2022.160.4045.3 | 939968    | 26-May-2023 | 13:18 | x64      |
| Repldp.dll                                           | 2022.160.4045.3 | 337872    | 26-May-2023 | 13:19 | x64      |
| Replisapi.dll                                        | 2022.160.4045.3 | 419768    | 26-May-2023 | 13:19 | x64      |
| Replmerg.exe                                         | 2022.160.4045.3 | 604112    | 26-May-2023 | 13:19 | x64      |
| Replprov.dll                                         | 2022.160.4045.3 | 890832    | 26-May-2023 | 13:18 | x64      |
| Replrec.dll                                          | 2022.160.4045.3 | 1058720   | 26-May-2023 | 13:18 | x64      |
| Replsub.dll                                          | 2022.160.4045.3 | 501712    | 26-May-2023 | 13:18 | x64      |
| Spresolv.dll                                         | 2022.160.4045.3 | 301008    | 26-May-2023 | 13:18 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4045.3 | 137104    | 26-May-2023 | 13:18 | x64      |
| Sqlcmd.exe                                           | 2022.160.4045.3 | 276376    | 26-May-2023 | 13:18 | x64      |
| Sqldistx.dll                                         | 2022.160.4045.3 | 268224    | 26-May-2023 | 13:18 | x64      |
| Sqlmergx.dll                                         | 2022.160.4045.3 | 423872    | 26-May-2023 | 13:19 | x64      |
| Xe.dll                                               | 2022.160.4045.3 | 718800    | 26-May-2023 | 13:19 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4045.3 | 100288    | 26-May-23 | 13:18 | x64      |
| Exthost.exe                   | 2022.160.4045.3 | 247760    | 26-May-23 | 13:18 | x64      |
| Launchpad.exe                 | 2022.160.4045.3 | 1460176   | 26-May-23 | 13:18 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4045.3 | 137104    | 26-May-23 | 13:18 | x64      |
| Sqlsatellite.dll              | 2022.160.4045.3 | 1267608   | 26-May-23 | 13:18 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4045.3 | 710592    | 26-May-23 | 13:18 | x64      |
| Fdhost.exe               | 2022.160.4045.3 | 153504    | 26-May-23 | 13:18 | x64      |
| Fdlauncher.exe           | 2022.160.4045.3 | 100288    | 26-May-23 | 13:18 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4045.3 | 137104    | 26-May-23 | 13:17 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 26-May-23 | 13:22 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 26-May-23 | 13:22 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 26-May-23 | 13:22 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 26-May-23 | 13:22 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 26-May-23 | 13:22 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 26-May-23 | 13:22 | x86      |
| Dts.dll                                                       | 2022.160.4045.3 | 3266456   | 26-May-23 | 13:22 | x64      |
| Dts.dll                                                       | 2022.160.4045.3 | 2860960   | 26-May-23 | 13:22 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4045.3     | 120720    | 26-May-23 | 13:22 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4045.3     | 120736    | 26-May-23 | 13:22 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.218     | 2933656   | 26-May-23 | 13:17 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.218     | 2933712   | 26-May-23 | 13:17 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4045.3     | 509904    | 26-May-23 | 13:22 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4045.3     | 509888    | 26-May-23 | 13:22 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4045.3     | 391072    | 26-May-23 | 13:22 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4045.3     | 219032    | 26-May-23 | 13:22 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.218 | 10165704  | 26-May-23 | 13:17 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-May-23 | 13:22 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-May-23 | 13:22 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 26-May-23 | 13:22 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4045.3 | 137104    | 26-May-23 | 13:17 | x64      |
| Sqlceip.exe                                                   | 16.0.4045.3     | 300944    | 26-May-23 | 13:22 | x86      |
| Xe.dll                                                        | 2022.160.4045.3 | 640976    | 26-May-23 | 13:22 | x86      |
| Xe.dll                                                        | 2022.160.4045.3 | 718800    | 26-May-23 | 13:22 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1026.0     | 559520    | 26-May-23 | 14:22 | x86      |
| Dmsnative.dll                                                        | 2022.160.1026.0 | 152480    | 26-May-23 | 14:22 | x64      |
| Dwengineservice.dll                                                  | 16.0.1026.0     | 45008     | 26-May-23 | 14:22 | x86      |
| Instapi150.dll                                                       | 2022.160.4045.3 | 104344    | 26-May-23 | 14:22 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1026.0     | 67536     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1026.0     | 293280    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1026.0     | 1957792   | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1026.0     | 169432    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1026.0     | 647112    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1026.0     | 246216    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1026.0     | 139184    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1026.0     | 79776     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1026.0     | 51152     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1026.0     | 88496     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1026.0     | 1129432   | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1026.0     | 80800     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1026.0     | 70560     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1026.0     | 35288     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1026.0     | 30680     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1026.0     | 46536     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1026.0     | 21424     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1026.0     | 26584     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1026.0     | 131488    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1026.0     | 86448     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1026.0     | 100816    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1026.0     | 293296    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 120240    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 138160    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 141256    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 137648    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 150488    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 139696    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 134616    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 176592    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 117720    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1026.0     | 136624    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1026.0     | 72624     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1026.0     | 21936     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1026.0     | 37320     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1026.0     | 128984    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1026.0     | 3064776   | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1026.0     | 3955616   | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 118192    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 133040    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 137632    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 133536    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 148400    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 134064    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 130480    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 170928    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 115120    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1026.0     | 132000    | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1026.0     | 67544     | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1026.0     | 2682784   | 26-May-23 | 14:22 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1026.0     | 2436568   | 26-May-23 | 14:22 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4045.3 | 296912    | 26-May-23 | 14:22 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4045.3 | 7817104   | 26-May-23 | 14:22 | x64      |
| Secforwarder.dll                                                     | 2022.160.4045.3 | 83920     | 26-May-23 | 14:22 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1026.0 | 61384     | 26-May-23 | 14:22 | x64      |
| Sqldk.dll                                                            | 2022.160.4045.3 | 4028352   | 26-May-23 | 14:22 | x64      |
| Sqldumper.exe                                                        | 2022.160.4045.3 | 260048    | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 1746840   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4568976   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 3745696   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4568984   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4470680   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 2443168   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 2385824   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4204448   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4188064   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 1685408   | 26-May-23 | 14:22 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4045.3 | 4437920   | 26-May-23 | 14:22 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 26-May-23 | 14:22 | x64      |
| Sqlos.dll                                                            | 2022.160.4045.3 | 51136     | 26-May-23 | 14:22 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1026.0 | 4841432   | 26-May-23 | 14:22 | x64      |
| Sqltses.dll                                                          | 2022.160.4045.3 | 9389984   | 26-May-23 | 14:22 | x64      |

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
