---
title: Cumulative update 4 for SQL Server 2017 (KB4056498)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 4 (KB4056498).
ms.date: 08/04/2023
ms.custom: KB4056498, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4056498 - Cumulative Update 4 for SQL Server 2017

_Release Date:_ &nbsp; February 20, 2018  
_Version:_ &nbsp; 14.0.3022.28

## Summary

This article describes Cumulative Update package 4 (CU4) for Microsoft SQL Server 2017. This update contains 54 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 3, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3022.28**, file version: **2017.140.3022.28**
- Analysis Services - Product version: **14.0.204.1**, file version: **2017.140.204.1**

## Known issues in this update

When [Cumulative Update 4 (CU4)](cumulativeupdate4.md) is installed, customers may experience the following symptoms on SQL Server on Linux deployments with Pacemaker-managed Availability Groups.

- Pacemaker immediately demotes the primary replica of the AG resource to a secondary replica, then never promotes any secondary replica back to a primary replica.

- '`crm_mon`' shows no errors reported from the 'monitor', 'notify' or 'promote' actions of the '`ocf:mssql:ag`' resource agent for the AG resource.

- '`crm_simulate -sL`' shows a promotion score of '`-1`' on all replicas of the AG resource.

To mitigate the problem, either

1. Apply the [mssql-server-ha.cu4.patch](https://github.com/Microsoft/tigertoolbox/blob/master/mssql-server-ha.cu4.patch) to the `/usr/lib/ocf/resource.d/mssql/ag` file on all nodes of the Pacemaker cluster where the `mssql-server-ha` package is installed.

1. Update to [Cumulative Update 5 (CU5)](cumulativeupdate5.md), which is a recommended option.

1. Revert back to [Cumulative Update 3 (CU3)](cumulativeupdate3.md).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="11466444">[11466444](#11466444)</a> | [Improvement: Increase the parallelism of external queries that can be executed by the modern Get Data experience in SSAS 2017 Tabular model (KB4078301)](https://support.microsoft.com/help/4078301) | Analysis Services | Analysis Services | Windows |
| <a id="11281540">[11281540](#11281540)</a> | [FIX: SSAS 2016 and 2017 crash intermittently when you rename a multidimensional database by using script (KB4052572)](https://support.microsoft.com/help/4052572) | Analysis Services | Analysis Services | Windows |
| <a id="11281541">[11281541](#11281541)</a> | [FIX: Non-admin role can't receive correct ChildCount estimates for parent/child dimension leaf members in SSAS (KB3010148)](https://support.microsoft.com/help/3010148) | Analysis Services | Analysis Services | Windows |
| <a id="11290048">[11290048](#11290048)</a> | [FIX: Processing a tabular model database, table or partition takes longer to process in SSAS 2017 (KB4078302)](https://support.microsoft.com/help/4078302) | Analysis Services | Analysis Services | Windows |
| <a id="11296787">[11296787](#11296787)</a> | [FIX: Access violation error in SSAS when an MDX query is executed in SQL Server 2017 (KB4078303)](https://support.microsoft.com/help/4078303) | Analysis Services | Analysis Services | Windows |
| <a id="11455811">[11455811](#11455811)</a> | [FIX: Internal error when you drill down hierarchy members in SSAS 2016 and 2017 in multidimensional mode (KB4057759)](https://support.microsoft.com/help/4057759) | Analysis Services | Analysis Services | Windows |
| <a id="11281513">[11281513](#11281513)</a> | [FIX: Data-driven subscription fails after you upgrade from SSRS 2008 to SSRS 2016 (KB4042948)](https://support.microsoft.com/help/4042948) | Analysis Services | Reporting Services | Windows |
| <a id="11281547">[11281547](#11281547)</a> | [FIX: "AdomdConnectionException" error when SSRS 2016 and 2017 data source uses msmdpump.dll (KB4049027)](https://support.microsoft.com/help/4049027) | Analysis Services | Reporting Services | Windows |
| <a id="11281570">[11281570](#11281570)</a> | [FIX: Sliding expiration for authentication cookie isn't working and fails to redirect to logon page in SSRS 2016 and 2017 (KB4052123)](https://support.microsoft.com/help/4052123) | Analysis Services | Reporting Services | Windows |
| <a id="11281542">[11281542](#11281542)</a> | FIX: SQL Server Integration Service packages randomly hang if custom logging is enabled (KB4040934) | Integration Services | Engine | Windows |
| <a id="11281550">[11281550](#11281550)</a> | [FIX: "Request timed out" error when you change security options for an MDS security group in SQL Server 2016 and 2017 (KB4044064)](https://support.microsoft.com/help/4044064) | Master Data Services | Client | Windows |
| <a id="11226058">[11226058](#11226058)</a> | [FIX: Unable to restore a database using replace option if the FILENAME contains double slash operator in SQL Server 2017 (KB4057087)](https://support.microsoft.com/help/4057087) | SQL Server Engine | Backup Restore | All |
| <a id="11455809">[11455809](#11455809)</a> | [FIX: A deadlock occurs when you run a parallel query on a clustered columnstore index in SQL Server 2016 and 2017 (KB4057055)](https://support.microsoft.com/help/4057055) | SQL Server Engine | Column Stores | Windows |
| <a id="11457917">[11457917](#11457917)</a> | [FIX: System stored procedure sp_execute_external_script and DMV sys.dm_exec_cached_plans cause memory leaks in SQL Server 2017 (KB4077683)](https://support.microsoft.com/help/4077683) | SQL Server Engine | Extensibility | Windows |
| <a id="11525703">[11525703](#11525703)</a> | [FIX: PREDICT function doesn't return error message for missing columns and doesn't handle learning parameter for Tree/Forest models in SQL Server 2017 ML Services (KB4078288)](https://support.microsoft.com/help/4078288) | SQL Server Engine | Extensibility | Windows |
| <a id="11281548">[11281548](#11281548)</a> | [FIX: Access violation occurs on primary replica of AlwaysOn Availability Group in SQL Server (KB4048943)](https://support.microsoft.com/help/4048943) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11441099">[11441099](#11441099)</a> | [FIX: A REDO thread isn't available in the secondary replica after an availability database is dropped in SQL Server (KB4017445)](https://support.microsoft.com/help/4017445) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11455797">[11455797](#11455797)</a> | [FIX: "Msg 3948" error when you run a query on secondary replica of secondary availability group in SQL Server 2016 and 2017 (KB4055281)](https://support.microsoft.com/help/4055281) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11455799">[11455799](#11455799)</a> | [FIX: Log shipping fails when you use it together with Always On Availability Groups in SQL Server 2016 and 2017 (KB4056821)](https://support.microsoft.com/help/4056821) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11507782">[11507782](#11507782)</a> | [FIX: Pacemaker demotes existing primary replica of an AlwaysOn AG in SQL Server 2017 on Linux and never promotes a new one (KB4076982)](https://support.microsoft.com/help/4076982) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="11281563">[11281563](#11281563)</a> | FIX: Access violation occurs when DMV queries run against a distributed availability group in SQL Server (KB4052121) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11035710">[11035710](#11035710)</a> | [FIX: Recovery of database takes a long time when it contains memory-optimized tables in SQL Server 2016 and 2017 (KB4055727)](https://support.microsoft.com/help/4055727) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11455814">[11455814](#11455814)</a> | [FIX: High CPU usage when large index is used in a query on a memory-optimized table in SQL Server 2016 and 2017 (KB4057280)](https://support.microsoft.com/help/4057280) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11457913">[11457913](#11457913)</a> | [FIX: In-Memory databases in an Availability Group hang during recovery in SQL Server 2017 (KB4077103)](https://support.microsoft.com/help/4077103) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11305031">[11305031](#11305031)</a> | [Improvement: Move master database and error log file to another location in SQL Server 2017 on Linux (KB4053439)](https://support.microsoft.com/help/4053439) | SQL Server Engine | Linux | Linux |
| <a id="11448088">[11448088](#11448088)</a> | [Improvement: Improves the performance of SQL Server 2017 on smaller systems (KB4078095)](https://support.microsoft.com/help/4078095) | SQL Server Engine | Linux | Linux |
| <a id="11317815">[11317815](#11317815)</a> | [FIX: NEWSEQUENTIALID function generates duplicate GUID after SQL Server 2017 on Linux is restarted (KB4078097)](https://support.microsoft.com/help/4078097) | SQL Server Engine | Linux | Linux |
| <a id="11317816">[11317816](#11317816)</a> | [FIX: Unexpected memory consumption when TCP protocol connections are used for SQL Server 2017 on Linux (KB4073045)](https://support.microsoft.com/help/4073045) | SQL Server Engine | Linux | Linux |
| <a id="11448085">[11448085](#11448085)</a> | [FIX: Database schemas aren't upgraded or downgraded when you install or uninstall a cumulative update in SQL Server 2017 on Linux (KB4078098)](https://support.microsoft.com/help/4078098) | SQL Server Engine | Linux | Linux |
| <a id="11454778">[11454778](#11454778)</a> | [FIX: Compatibility level of msdb database remains at 130 by doing slipstream upgrade to SQL Server 2017 (KB4074661)](https://support.microsoft.com/help/4074661) | SQL Server Engine | Management Services | Windows |
| <a id="11455813">[11455813](#11455813)</a> | [FIX: Error 14684 when you reconfigure Management Data Warehouse in a named instance of SQL Server 2016 and 2017 (KB4057190)](https://support.microsoft.com/help/4057190) | SQL Server Engine | Management Services | Windows |
| <a id="11514491">[11514491](#11514491)</a> | [FIX: PolyBase doesn't install because the installer doesn't recognize JRE 9 when you install SQL Server 2017 (KB4077899)](https://support.microsoft.com/help/4077899) | SQL Server Engine | PolyBase | Windows |
| <a id="11405603">[11405603](#11405603)</a> | [FIX: UPDATE statement fails silently when you reference a nonexistent partition function in the WHERE clause in SQL Server 2014 or 2017 (KB4046745)](https://support.microsoft.com/help/4046745) | SQL Server Engine | Programmability | All |
| <a id="11405622">[11405622](#11405622)</a> | [FIX: "Invalid comparison due to NO COLLATION" retail assert occurs in SQL Server 2014 and 2017 (KB4054398)](https://support.microsoft.com/help/4054398) | SQL Server Engine | Programmability | Windows |
| <a id="11455788">[11455788](#11455788)</a> | [FIX: Assertion occurs when you pass memory-optimized table variable into a stored procedure as table-valued parameter in SQL Server 2016 and 2017 (KB4056117)](https://support.microsoft.com/help/4056117) | SQL Server Engine | Programmability | Windows |
| <a id="11307676">[11307676](#11307676)</a> | [FIX: CXPACKET and CXCONSUMER wait types show inconsistent results for some parallel query plans in SQL Server 2017 (KB4057054)](https://support.microsoft.com/help/4057054) | SQL Server Engine | Query Execution | All |
| <a id="11511978">[11511978](#11511978)</a> | [FIX: Assertion error when executing a stored procedure that references a large object in SQL Server 2014 and 2017 (KB4058565)](https://support.microsoft.com/help/4058565) | SQL Server Engine | Query Execution | Windows |
| <a id="8898811">[8898811](#8898811)</a> | [A non-optimal query plan choice causes poor performance when values outside the range represented in statistics are searched in SQL Server 2016 and 2017 (KB3192154)](https://support.microsoft.com/help/3192154) | SQL Server Engine | Query Optimizer | Windows |
| <a id="11281552">[11281552](#11281552)</a> | [FIX: SELECT query that uses batch mode hash aggregate operator that counts multiple nullable columns returns bad results in SQL Server (KB4052633)](https://support.microsoft.com/help/4052633) | SQL Server Engine | Query Optimizer | All |
| <a id="11405613">[11405613](#11405613)</a> | [FIX: Error when you rebuild a single partition of an index online in SQL Server 2014 and 2016 (KB4055556)](https://support.microsoft.com/help/4055556) | SQL Server Engine | Query Optimizer | All |
| <a id="11405608">[11405608](#11405608)</a> | [FIX: Can't enable or disable change data capture for a database after you attach it in SQL Server 2014 or 2017 (KB4048967)](https://support.microsoft.com/help/4048967) | SQL Server Engine | Replication | Windows |
| <a id="11415502">[11415502](#11415502)</a> | [FIX: Change data capture doesn't work in SQL Server 2017 (KB4073684)](https://support.microsoft.com/help/4073684) | SQL Server Engine | Replication | Windows |
| <a id="11455793">[11455793](#11455793)</a> | [FIX: Error when SQL Server replication article contains either GEOGRAPHY_AUTO_GRID or GEOMETRY_AUTO_GRID (KB4037412)](https://support.microsoft.com/help/4037412) | SQL Server Engine | Replication | Windows |
| <a id="11453962">[11453962](#11453962)</a> | [FIX: Can't create a login based on a user that belongs to the parent domain in SQL Server 2017 on Linux (KB4073670)](https://support.microsoft.com/help/4073670) | SQL Server Engine | Security Infrastructure | Linux |
| <a id="11455807">[11455807](#11455807)</a> | [FIX: Queries that cast string or binary data to XML take a long time to compile in SQL Server 2016 and 2017 (KB4056955)](https://support.microsoft.com/help/4056955) | SQL Server Engine | Security Infrastructure | All |
| <a id="11524673">[11524673](#11524673)</a> | [FIX: Many consecutive transactions inserting data into temp table in SQL Server 2016 and 2017 consume more CPU than in SQL Server 2014 (KB3216543)](https://support.microsoft.com/help/3216543) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="11281532">[11281532](#11281532)</a> | [FIX: Processing XML message through Service Broker results in hung session in SQL Server 2016 and 2017 (KB4053550)](https://support.microsoft.com/help/4053550) | SQL Server Engine | Service Broker | All |
| <a id="11281515">[11281515](#11281515)</a> | [FIX: DMV sys.dm_os_windows_info returns wrong values for Windows 10 and Windows Server 2016 (KB4052131)](https://support.microsoft.com/help/4052131) | SQL Server Engine | SQL OS | Windows |
| <a id="11281538">[11281538](#11281538)</a> | [FIX: Memory dumps generated for "Stalled IOCP Listener" and "non-yielding IOCP listener" after SQL Server restart (KB4048942)](https://support.microsoft.com/help/4048942) | SQL Server Engine | SQL OS | All |
| <a id="11457912">[11457912](#11457912)</a> | [FIX: SQL Server shuts down after restart if C2 audit mode is enabled (KB4078096)](https://support.microsoft.com/help/4078096) | SQL Server Engine | SQL OS | All |
| <a id="11467181">[11467181](#11467181)</a> | [FIX: Memory ramp-up phase is too long after TF 834 is enabled in SQL Server 2017 on Linux (KB4075203)](https://support.microsoft.com/help/4075203) | SQL Server Engine | SQL OS | Linux |
| <a id="11511976">[11511976](#11511976)</a> | [FIX: Out of memory error when the virtual address space of the SQL Server process is very low in SQL Server 2014 and 2017 (KB4077105)](https://support.microsoft.com/help/4077105) | SQL Server Engine | SQL OS | Windows |
| <a id="11281551">[11281551](#11281551)</a> | FIX: Thread pool exhaustion and `CMEMTHREAD` contention in AAG with data seeding in SQL Server 2016 and 2017 (KB4045795) | SQL Server Engine | SQL OS | All |
| <a id="11455794">[11455794](#11455794)</a> | [FIX: "Incompletely installed" error on Feature Selection page when you modify the current installation of SQL Server 2016 SP1 or SQL Server 2016 SP1 CU5 (KB4055456)](https://support.microsoft.com/help/4055456) | SQL Setup | Patching | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

> [!NOTE]
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU4 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2018/03/sqlserver2017-kb4056498-x64_d1f84e3cfbda5006301c8e569a66a982777a8a75.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4056498-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4056498-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4056498-x64.exe| 387F9C10E2983F351171250AB0F3F80F58AADCE0139DAF0BD4D704C17E79C566 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.204.1   | 266408    | 26-Jan-18 | 22:13 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.204.1       | 741536    | 26-Jan-18 | 22:14 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.204.1       | 1380520   | 26-Jan-18 | 22:13 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.204.1       | 984232    | 26-Jan-18 | 22:13 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.204.1       | 521384    | 26-Jan-18 | 22:13 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201    | 174816    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201    | 36576     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201    | 48864     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201    | 105184    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201    | 5167328   | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201    | 26336     | 20-Oct-17 | 10:17 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201    | 26848     | 20-Oct-17 | 10:17 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201    | 26848     | 06-Jan-18 | 12:59 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201    | 159456    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201    | 82656     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201    | 67296     | 06-Jan-18 | 12:59 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201    | 25824     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151264    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201    | 13032160  | 20-Oct-17 | 10:17 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484       | 1044672   | 20-Oct-17 | 10:17 | x86      |
| Msmdctr.dll                                        | 2017.140.204.1   | 40096     | 26-Jan-18 | 22:13 | x64      |
| Msmdlocal.dll                                      | 2017.140.204.1   | 60709032  | 26-Jan-18 | 22:13 | x64      |
| Msmdlocal.dll                                      | 2017.140.204.1   | 40377504  | 26-Jan-18 | 22:16 | x86      |
| Msmdpump.dll                                       | 2017.140.204.1   | 9334952   | 26-Jan-18 | 22:13 | x64      |
| Msmdredir.dll                                      | 2017.140.204.1   | 7092384   | 26-Jan-18 | 22:16 | x86      |
| Msmdsrv.exe                                        | 2017.140.204.1   | 60609704  | 26-Jan-18 | 22:13 | x64      |
| Msmgdsrv.dll                                       | 2017.140.204.1   | 9004712   | 26-Jan-18 | 22:13 | x64      |
| Msmgdsrv.dll                                       | 2017.140.204.1   | 7310496   | 26-Jan-18 | 22:16 | x86      |
| Msolap.dll                                         | 2017.140.204.1   | 10258592  | 26-Jan-18 | 22:13 | x64      |
| Msolap.dll                                         | 2017.140.204.1   | 7776928   | 26-Jan-18 | 22:16 | x86      |
| Msolui.dll                                         | 2017.140.204.1   | 310952    | 26-Jan-18 | 22:13 | x64      |
| Msolui.dll                                         | 2017.140.204.1   | 287392    | 26-Jan-18 | 22:16 | x86      |
| Powerbiextensions.dll                              | 2.49.4831.201    | 5316832   | 20-Oct-17 | 10:17 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlboot.dll                                        | 2017.140.3022.28 | 195232    | 10-Feb-18 | 03:43 | x64      |
| Sqlceip.exe                                        | 14.0.3022.28     | 251040    | 10-Feb-18 | 07:38 | x86      |
| Sqldumper.exe                                      | 2017.140.3022.28 | 140448    | 10-Feb-18 | 03:54 | x64      |
| Sqldumper.exe                                      | 2017.140.3022.28 | 118944    | 10-Feb-18 | 04:00 | x86      |
| Tmapi.dll                                          | 2017.140.204.1   | 5822624   | 26-Jan-18 | 22:13 | x64      |
| Tmcachemgr.dll                                     | 2017.140.204.1   | 4164768   | 26-Jan-18 | 22:13 | x64      |
| Tmpersistence.dll                                  | 2017.140.204.1   | 1132200   | 26-Jan-18 | 22:13 | x64      |
| Tmtransactions.dll                                 | 2017.140.204.1   | 1640096   | 26-Jan-18 | 22:13 | x64      |
| Xe.dll                                             | 2017.140.3022.28 | 673440    | 10-Feb-18 | 03:37 | x64      |
| Xmlrw.dll                                          | 2017.140.3022.28 | 257696    | 10-Feb-18 | 08:30 | x86      |
| Xmlrw.dll                                          | 2017.140.3022.28 | 305312    | 10-Feb-18 | 04:01 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3022.28 | 189600    | 10-Feb-18 | 08:30 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3022.28 | 224408    | 10-Feb-18 | 03:43 | x64      |
| Xmsrv.dll                                          | 2017.140.204.1   | 25375400  | 26-Jan-18 | 22:13 | x64      |
| Xmsrv.dll                                          | 2017.140.204.1   | 33350816  | 26-Jan-18 | 22:16 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3022.28 | 160416    | 10-Feb-18 | 03:34 | x86      |
| Batchparser.dll                            | 2017.140.3022.28 | 180896    | 10-Feb-18 | 03:34 | x64      |
| Instapi140.dll                             | 2017.140.3022.28 | 70296     | 10-Feb-18 | 03:34 | x64      |
| Instapi140.dll                             | 2017.140.3022.28 | 61088     | 10-Feb-18 | 03:43 | x86      |
| Isacctchange.dll                           | 2017.140.3022.28 | 29344     | 10-Feb-18 | 07:40 | x86      |
| Isacctchange.dll                           | 2017.140.3022.28 | 30880     | 10-Feb-18 | 04:01 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088680   | 26-Jan-18 | 22:13 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088672   | 26-Jan-18 | 22:15 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.204.1       | 1381536   | 26-Jan-18 | 22:15 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741536    | 26-Jan-18 | 22:13 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741544    | 26-Jan-18 | 22:15 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3022.28     | 37024     | 10-Feb-18 | 04:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3022.28 | 82080     | 10-Feb-18 | 03:34 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3022.28 | 78488     | 10-Feb-18 | 03:43 | x86      |
| Msasxpress.dll                             | 2017.140.204.1   | 36008     | 26-Jan-18 | 22:13 | x64      |
| Msasxpress.dll                             | 2017.140.204.1   | 31904     | 26-Jan-18 | 22:15 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3022.28 | 82080     | 10-Feb-18 | 08:33 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3022.28 | 67744     | 10-Feb-18 | 08:35 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqldumper.exe                              | 2017.140.3022.28 | 140448    | 10-Feb-18 | 03:54 | x64      |
| Sqldumper.exe                              | 2017.140.3022.28 | 118944    | 10-Feb-18 | 04:00 | x86      |
| Sqlftacct.dll                              | 2017.140.3022.28 | 54432     | 10-Feb-18 | 07:40 | x86      |
| Sqlftacct.dll                              | 2017.140.3022.28 | 62112     | 10-Feb-18 | 08:33 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 06-Jan-18 | 15:02 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 06-Jan-18 | 15:05 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3022.28 | 415904    | 10-Feb-18 | 08:33 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3022.28 | 372384    | 10-Feb-18 | 08:35 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3022.28 | 34976     | 10-Feb-18 | 08:35 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3022.28 | 37536     | 10-Feb-18 | 04:01 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3022.28 | 356000    | 10-Feb-18 | 08:33 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3022.28 | 273056    | 10-Feb-18 | 08:35 | x86      |
| Sqltdiagn.dll                              | 2017.140.3022.28 | 60576     | 10-Feb-18 | 03:28 | x86      |
| Sqltdiagn.dll                              | 2017.140.3022.28 | 67744     | 10-Feb-18 | 03:34 | x64      |
| Svrenumapi140.dll                          | 2017.140.3022.28 | 1173152   | 10-Feb-18 | 08:33 | x64      |
| Svrenumapi140.dll                          | 2017.140.3022.28 | 893600    | 10-Feb-18 | 08:35 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3022.28 | 120992    | 10-Feb-18 | 08:34 | x86      |
| Dreplaycommon.dll              | 2017.140.3022.28 | 698016    | 10-Feb-18 | 07:40 | x86      |
| Dreplayserverps.dll            | 2017.140.3022.28 | 32928     | 10-Feb-18 | 03:34 | x86      |
| Dreplayutil.dll                | 2017.140.3022.28 | 309920    | 10-Feb-18 | 08:34 | x86      |
| Instapi140.dll                 | 2017.140.3022.28 | 70296     | 10-Feb-18 | 03:34 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlresourceloader.dll          | 2017.140.3022.28 | 29344     | 10-Feb-18 | 03:34 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3022.28 | 698016    | 10-Feb-18 | 07:40 | x86      |
| Dreplaycontroller.exe              | 2017.140.3022.28 | 350368    | 10-Feb-18 | 08:34 | x86      |
| Dreplayprocess.dll                 | 2017.140.3022.28 | 171680    | 10-Feb-18 | 08:34 | x86      |
| Dreplayserverps.dll                | 2017.140.3022.28 | 32928     | 10-Feb-18 | 03:34 | x86      |
| Instapi140.dll                     | 2017.140.3022.28 | 70296     | 10-Feb-18 | 03:34 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlresourceloader.dll              | 2017.140.3022.28 | 29344     | 10-Feb-18 | 03:34 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3022.28 | 180896    | 10-Feb-18 | 03:34 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 17-Dec-17 | 01:59 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 06-Jan-18 | 12:48 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 17-Dec-17 | 01:59 | x64      |
| Datacollectorcontroller.dll                  | 2017.140.3022.28 | 225952    | 10-Feb-18 | 07:39 | x64      |
| Dcexec.exe                                   | 2017.140.3022.28 | 74400     | 10-Feb-18 | 08:32 | x64      |
| Fssres.dll                                   | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Hadrres.dll                                  | 2017.140.3022.28 | 187552    | 10-Feb-18 | 04:01 | x64      |
| Hkcompile.dll                                | 2017.140.3022.28 | 1423008   | 10-Feb-18 | 04:01 | x64      |
| Hkengine.dll                                 | 2017.140.3022.28 | 5858976   | 10-Feb-18 | 07:40 | x64      |
| Hkruntime.dll                                | 2017.140.3022.28 | 161952    | 10-Feb-18 | 07:40 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 06-Jan-18 | 12:48 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.204.1       | 741024    | 26-Jan-18 | 22:13 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3022.28     | 237216    | 10-Feb-18 | 08:32 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3022.28     | 79520     | 10-Feb-18 | 07:35 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3022.28 | 71328     | 10-Feb-18 | 03:43 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3022.28 | 65184     | 10-Feb-18 | 03:37 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3022.28 | 152224    | 10-Feb-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3022.28 | 159392    | 10-Feb-18 | 03:54 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3022.28 | 303776    | 10-Feb-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3022.28 | 74912     | 10-Feb-18 | 07:58 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 17-Dec-17 | 01:59 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 17-Dec-17 | 01:59 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 17-Dec-17 | 01:59 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 17-Dec-17 | 01:59 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 17-Dec-17 | 01:59 | x64      |
| Odsole70.dll                                 | 2017.140.3022.28 | 92832     | 10-Feb-18 | 04:01 | x64      |
| Opends60.dll                                 | 2017.140.3022.28 | 32928     | 10-Feb-18 | 03:34 | x64      |
| Qds.dll                                      | 2017.140.3022.28 | 1168032   | 10-Feb-18 | 07:59 | x64      |
| Rsfxft.dll                                   | 2017.140.3022.28 | 34464     | 10-Feb-18 | 03:33 | x64      |
| Secforwarder.dll                             | 2017.140.3022.28 | 37536     | 10-Feb-18 | 03:57 | x64      |
| Sqagtres.dll                                 | 2017.140.3022.28 | 74400     | 10-Feb-18 | 04:01 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlaamss.dll                                 | 2017.140.3022.28 | 89752     | 10-Feb-18 | 08:16 | x64      |
| Sqlaccess.dll                                | 2017.140.3022.28 | 474784    | 10-Feb-18 | 04:01 | x64      |
| Sqlagent.exe                                 | 2017.140.3022.28 | 579744    | 10-Feb-18 | 07:39 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3022.28 | 61088     | 10-Feb-18 | 07:34 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3022.28 | 52896     | 10-Feb-18 | 07:40 | x86      |
| Sqlagentlog.dll                              | 2017.140.3022.28 | 32920     | 10-Feb-18 | 03:34 | x64      |
| Sqlagentmail.dll                             | 2017.140.3022.28 | 53920     | 10-Feb-18 | 03:28 | x64      |
| Sqlboot.dll                                  | 2017.140.3022.28 | 195232    | 10-Feb-18 | 03:43 | x64      |
| Sqlceip.exe                                  | 14.0.3022.28     | 251040    | 10-Feb-18 | 07:38 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3022.28 | 72352     | 10-Feb-18 | 07:39 | x64      |
| Sqlctr140.dll                                | 2017.140.3022.28 | 111776    | 10-Feb-18 | 07:40 | x86      |
| Sqlctr140.dll                                | 2017.140.3022.28 | 129184    | 10-Feb-18 | 04:01 | x64      |
| Sqldk.dll                                    | 2017.140.3022.28 | 2792608   | 10-Feb-18 | 07:58 | x64      |
| Sqldtsss.dll                                 | 2017.140.3022.28 | 107168    | 10-Feb-18 | 08:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 1495712   | 10-Feb-18 | 03:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3396256   | 10-Feb-18 | 03:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3908768   | 10-Feb-18 | 03:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3911328   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3475104   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3779232   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3208864   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3285664   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3332768   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3772064   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 1442976   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3669664   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3778720   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3361432   | 10-Feb-18 | 03:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3591328   | 10-Feb-18 | 03:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3814560   | 10-Feb-18 | 03:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 2033312   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3582624   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3291296   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 4018336   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 2086560   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3022.28 | 3628704   | 10-Feb-18 | 03:43 | x64      |
| Sqliosim.com                                 | 2017.140.3022.28 | 313504    | 10-Feb-18 | 07:35 | x64      |
| Sqliosim.exe                                 | 2017.140.3022.28 | 3019936   | 10-Feb-18 | 04:01 | x64      |
| Sqllang.dll                                  | 2017.140.3022.28 | 41217184  | 10-Feb-18 | 07:59 | x64      |
| Sqlmin.dll                                   | 2017.140.3022.28 | 40260256  | 10-Feb-18 | 07:59 | x64      |
| Sqlolapss.dll                                | 2017.140.3022.28 | 107672    | 10-Feb-18 | 07:39 | x64      |
| Sqlos.dll                                    | 2017.140.3022.28 | 26272     | 10-Feb-18 | 04:00 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3022.28 | 67744     | 10-Feb-18 | 07:39 | x64      |
| Sqlrepss.dll                                 | 2017.140.3022.28 | 64160     | 10-Feb-18 | 07:39 | x64      |
| Sqlresld.dll                                 | 2017.140.3022.28 | 30880     | 10-Feb-18 | 03:34 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3022.28 | 32416     | 10-Feb-18 | 03:34 | x64      |
| Sqlscm.dll                                   | 2017.140.3022.28 | 70816     | 10-Feb-18 | 03:43 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3022.28 | 27808     | 10-Feb-18 | 03:28 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3022.28 | 5871776   | 10-Feb-18 | 03:34 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3022.28 | 732832    | 10-Feb-18 | 04:01 | x64      |
| Sqlservr.exe                                 | 2017.140.3022.28 | 487072    | 10-Feb-18 | 07:59 | x64      |
| Sqlsvc.dll                                   | 2017.140.3022.28 | 161440    | 10-Feb-18 | 07:39 | x64      |
| Sqltses.dll                                  | 2017.140.3022.28 | 9537184   | 10-Feb-18 | 07:58 | x64      |
| Sqsrvres.dll                                 | 2017.140.3022.28 | 260256    | 10-Feb-18 | 07:40 | x64      |
| Svl.dll                                      | 2017.140.3022.28 | 153760    | 10-Feb-18 | 07:40 | x64      |
| Xe.dll                                       | 2017.140.3022.28 | 673440    | 10-Feb-18 | 03:37 | x64      |
| Xmlrw.dll                                    | 2017.140.3022.28 | 305312    | 10-Feb-18 | 04:01 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3022.28 | 224408    | 10-Feb-18 | 03:43 | x64      |
| Xpadsi.exe                                   | 2017.140.3022.28 | 89760     | 10-Feb-18 | 04:01 | x64      |
| Xplog70.dll                                  | 2017.140.3022.28 | 75936     | 10-Feb-18 | 07:59 | x64      |
| Xpqueue.dll                                  | 2017.140.3022.28 | 74912     | 10-Feb-18 | 04:01 | x64      |
| Xprepl.dll                                   | 2017.140.3022.28 | 101536    | 10-Feb-18 | 04:01 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3022.28 | 32416     | 10-Feb-18 | 04:01 | x64      |
| Xpstar.dll                                   | 2017.140.3022.28 | 437408    | 10-Feb-18 | 04:01 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3022.28 | 160416    | 10-Feb-18 | 03:34 | x86      |
| Batchparser.dll                                             | 2017.140.3022.28 | 180896    | 10-Feb-18 | 03:34 | x64      |
| Bcp.exe                                                     | 2017.140.3022.28 | 119968    | 10-Feb-18 | 07:40 | x64      |
| Commanddest.dll                                             | 2017.140.3022.28 | 245920    | 10-Feb-18 | 04:01 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3022.28 | 116384    | 10-Feb-18 | 04:01 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3022.28 | 187552    | 10-Feb-18 | 04:01 | x64      |
| Distrib.exe                                                 | 2017.140.3022.28 | 202400    | 10-Feb-18 | 04:01 | x64      |
| Dteparse.dll                                                | 2017.140.3022.28 | 111264    | 10-Feb-18 | 04:01 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtepkg.dll                                                  | 2017.140.3022.28 | 137888    | 10-Feb-18 | 07:39 | x64      |
| Dtexec.exe                                                  | 2017.140.3022.28 | 73888     | 10-Feb-18 | 07:39 | x64      |
| Dts.dll                                                     | 2017.140.3022.28 | 2998944   | 10-Feb-18 | 04:01 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3022.28 | 475296    | 10-Feb-18 | 04:01 | x64      |
| Dtsconn.dll                                                 | 2017.140.3022.28 | 497304    | 10-Feb-18 | 04:01 | x64      |
| Dtshost.exe                                                 | 2017.140.3022.28 | 103584    | 10-Feb-18 | 07:40 | x64      |
| Dtslog.dll                                                  | 2017.140.3022.28 | 120480    | 10-Feb-18 | 08:32 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3022.28 | 545440    | 10-Feb-18 | 03:43 | x64      |
| Dtspipeline.dll                                             | 2017.140.3022.28 | 1266336   | 10-Feb-18 | 07:39 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3022.28 | 48288     | 10-Feb-18 | 08:32 | x64      |
| Dtuparse.dll                                                | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtutil.exe                                                  | 2017.140.3022.28 | 147104    | 10-Feb-18 | 07:39 | x64      |
| Exceldest.dll                                               | 2017.140.3022.28 | 260768    | 10-Feb-18 | 04:01 | x64      |
| Excelsrc.dll                                                | 2017.140.3022.28 | 282784    | 10-Feb-18 | 04:01 | x64      |
| Execpackagetask.dll                                         | 2017.140.3022.28 | 168096    | 10-Feb-18 | 04:01 | x64      |
| Flatfiledest.dll                                            | 2017.140.3022.28 | 384160    | 10-Feb-18 | 04:01 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3022.28 | 396448    | 10-Feb-18 | 04:01 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3022.28 | 96416     | 10-Feb-18 | 04:01 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3022.28 | 59552     | 10-Feb-18 | 04:01 | x64      |
| Logread.exe                                                 | 2017.140.3022.28 | 634016    | 10-Feb-18 | 07:40 | x64      |
| Mergetxt.dll                                                | 2017.140.3022.28 | 63136     | 10-Feb-18 | 04:01 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.204.1       | 1381536   | 26-Jan-18 | 22:13 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 06-Nov-17 | 20:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3022.28     | 89760     | 10-Feb-18 | 08:33 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3022.28 | 1650336   | 10-Feb-18 | 07:39 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3022.28 | 152224    | 10-Feb-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3022.28 | 159392    | 10-Feb-18 | 03:54 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3022.28 | 103072    | 10-Feb-18 | 04:01 | x64      |
| Msgprox.dll                                                 | 2017.140.3022.28 | 269984    | 10-Feb-18 | 07:40 | x64      |
| Msxmlsql.dll                                                | 2017.140.3022.28 | 1448096   | 10-Feb-18 | 07:59 | x64      |
| Oledbdest.dll                                               | 2017.140.3022.28 | 261280    | 10-Feb-18 | 04:01 | x64      |
| Oledbsrc.dll                                                | 2017.140.3022.28 | 288928    | 10-Feb-18 | 04:01 | x64      |
| Osql.exe                                                    | 2017.140.3022.28 | 75424     | 10-Feb-18 | 03:43 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3022.28 | 472736    | 10-Feb-18 | 07:40 | x64      |
| Rawdest.dll                                                 | 2017.140.3022.28 | 206496    | 10-Feb-18 | 04:01 | x64      |
| Rawsource.dll                                               | 2017.140.3022.28 | 194208    | 10-Feb-18 | 04:01 | x64      |
| Rdistcom.dll                                                | 2017.140.3022.28 | 856224    | 10-Feb-18 | 07:40 | x64      |
| Recordsetdest.dll                                           | 2017.140.3022.28 | 184480    | 10-Feb-18 | 04:01 | x64      |
| Replagnt.dll                                                | 2017.140.3022.28 | 30872     | 10-Feb-18 | 08:33 | x64      |
| Repldp.dll                                                  | 2017.140.3022.28 | 290456    | 10-Feb-18 | 03:43 | x64      |
| Replerrx.dll                                                | 2017.140.3022.28 | 153760    | 10-Feb-18 | 03:43 | x64      |
| Replisapi.dll                                               | 2017.140.3022.28 | 361632    | 10-Feb-18 | 04:01 | x64      |
| Replmerg.exe                                                | 2017.140.3022.28 | 524960    | 10-Feb-18 | 07:40 | x64      |
| Replprov.dll                                                | 2017.140.3022.28 | 801440    | 10-Feb-18 | 07:40 | x64      |
| Replrec.dll                                                 | 2017.140.3022.28 | 975008    | 10-Feb-18 | 07:40 | x64      |
| Replsub.dll                                                 | 2017.140.3022.28 | 445600    | 10-Feb-18 | 07:40 | x64      |
| Replsync.dll                                                | 2017.140.3022.28 | 153760    | 10-Feb-18 | 04:01 | x64      |
| Spresolv.dll                                                | 2017.140.3022.28 | 252064    | 10-Feb-18 | 07:40 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3022.28 | 248992    | 10-Feb-18 | 04:01 | x64      |
| Sqldiag.exe                                                 | 2017.140.3022.28 | 1257632   | 10-Feb-18 | 04:01 | x64      |
| Sqldistx.dll                                                | 2017.140.3022.28 | 224928    | 10-Feb-18 | 03:43 | x64      |
| Sqllogship.exe                                              | 14.0.3022.28     | 105632    | 10-Feb-18 | 03:43 | x64      |
| Sqlmergx.dll                                                | 2017.140.3022.28 | 360608    | 10-Feb-18 | 04:01 | x64      |
| Sqlresld.dll                                                | 2017.140.3022.28 | 30880     | 10-Feb-18 | 03:34 | x64      |
| Sqlresld.dll                                                | 2017.140.3022.28 | 28832     | 10-Feb-18 | 04:00 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3022.28 | 29344     | 10-Feb-18 | 03:34 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3022.28 | 32416     | 10-Feb-18 | 03:34 | x64      |
| Sqlscm.dll                                                  | 2017.140.3022.28 | 70816     | 10-Feb-18 | 03:43 | x64      |
| Sqlscm.dll                                                  | 2017.140.3022.28 | 60064     | 10-Feb-18 | 04:00 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3022.28 | 161440    | 10-Feb-18 | 07:39 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3022.28 | 134296    | 10-Feb-18 | 07:40 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3022.28 | 183960    | 10-Feb-18 | 04:01 | x64      |
| Sqlwep140.dll                                               | 2017.140.3022.28 | 105632    | 10-Feb-18 | 07:40 | x64      |
| Ssdebugps.dll                                               | 2017.140.3022.28 | 33440     | 10-Feb-18 | 04:01 | x64      |
| Ssisoledb.dll                                               | 2017.140.3022.28 | 216224    | 10-Feb-18 | 04:01 | x64      |
| Ssradd.dll                                                  | 2017.140.3022.28 | 74912     | 10-Feb-18 | 04:01 | x64      |
| Ssravg.dll                                                  | 2017.140.3022.28 | 74912     | 10-Feb-18 | 04:01 | x64      |
| Ssrdown.dll                                                 | 2017.140.3022.28 | 60064     | 10-Feb-18 | 04:01 | x64      |
| Ssrmax.dll                                                  | 2017.140.3022.28 | 72864     | 10-Feb-18 | 04:01 | x64      |
| Ssrmin.dll                                                  | 2017.140.3022.28 | 73376     | 10-Feb-18 | 04:01 | x64      |
| Ssrpub.dll                                                  | 2017.140.3022.28 | 60576     | 10-Feb-18 | 04:01 | x64      |
| Ssrup.dll                                                   | 2017.140.3022.28 | 60064     | 10-Feb-18 | 04:01 | x64      |
| Txagg.dll                                                   | 2017.140.3022.28 | 362144    | 10-Feb-18 | 04:01 | x64      |
| Txbdd.dll                                                   | 2017.140.3022.28 | 175264    | 10-Feb-18 | 04:01 | x64      |
| Txdatacollector.dll                                         | 2017.140.3022.28 | 360608    | 10-Feb-18 | 04:01 | x64      |
| Txdataconvert.dll                                           | 2017.140.3022.28 | 293024    | 10-Feb-18 | 04:01 | x64      |
| Txderived.dll                                               | 2017.140.3022.28 | 604320    | 10-Feb-18 | 07:40 | x64      |
| Txlookup.dll                                                | 2017.140.3022.28 | 528032    | 10-Feb-18 | 04:01 | x64      |
| Txmerge.dll                                                 | 2017.140.3022.28 | 230048    | 10-Feb-18 | 04:01 | x64      |
| Txmergejoin.dll                                             | 2017.140.3022.28 | 275616    | 10-Feb-18 | 08:33 | x64      |
| Txmulticast.dll                                             | 2017.140.3022.28 | 127648    | 10-Feb-18 | 04:01 | x64      |
| Txrowcount.dll                                              | 2017.140.3022.28 | 125600    | 10-Feb-18 | 04:01 | x64      |
| Txsort.dll                                                  | 2017.140.3022.28 | 256672    | 10-Feb-18 | 04:01 | x64      |
| Txsplit.dll                                                 | 2017.140.3022.28 | 596640    | 10-Feb-18 | 07:40 | x64      |
| Txunionall.dll                                              | 2017.140.3022.28 | 181920    | 10-Feb-18 | 07:40 | x64      |
| Xe.dll                                                      | 2017.140.3022.28 | 673440    | 10-Feb-18 | 03:37 | x64      |
| Xmlrw.dll                                                   | 2017.140.3022.28 | 305312    | 10-Feb-18 | 04:01 | x64      |
| Xmlsub.dll                                                  | 2017.140.3022.28 | 260256    | 10-Feb-18 | 04:01 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3022.28 | 1123488   | 10-Feb-18 | 07:59 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlsatellite.dll              | 2017.140.3022.28 | 921248    | 10-Feb-18 | 07:59 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3022.28 | 667296    | 10-Feb-18 | 07:40 | x64      |
| Fdhost.exe               | 2017.140.3022.28 | 114336    | 10-Feb-18 | 07:59 | x64      |
| Fdlauncher.exe           | 2017.140.3022.28 | 62112     | 10-Feb-18 | 04:01 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlft140ph.dll           | 2017.140.3022.28 | 67744     | 10-Feb-18 | 03:43 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3022.28     | 23704     | 10-Feb-18 | 04:01 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 20-Oct-17 | 10:17 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 06-Jan-18 | 14:01 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 06-Jan-18 | 14:01 | x86      |
| Commanddest.dll                                               | 2017.140.3022.28 | 200864    | 10-Feb-18 | 07:40 | x86      |
| Commanddest.dll                                               | 2017.140.3022.28 | 245920    | 10-Feb-18 | 04:01 | x64      |
| Dteparse.dll                                                  | 2017.140.3022.28 | 101024    | 10-Feb-18 | 07:40 | x86      |
| Dteparse.dll                                                  | 2017.140.3022.28 | 111264    | 10-Feb-18 | 04:01 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3022.28 | 83616     | 10-Feb-18 | 07:40 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtepkg.dll                                                    | 2017.140.3022.28 | 137888    | 10-Feb-18 | 07:39 | x64      |
| Dtepkg.dll                                                    | 2017.140.3022.28 | 116896    | 10-Feb-18 | 07:40 | x86      |
| Dtexec.exe                                                    | 2017.140.3022.28 | 73888     | 10-Feb-18 | 07:39 | x64      |
| Dtexec.exe                                                    | 2017.140.3022.28 | 67744     | 10-Feb-18 | 08:34 | x86      |
| Dts.dll                                                       | 2017.140.3022.28 | 2549400   | 10-Feb-18 | 07:40 | x86      |
| Dts.dll                                                       | 2017.140.3022.28 | 2998944   | 10-Feb-18 | 04:01 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3022.28 | 417952    | 10-Feb-18 | 07:40 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3022.28 | 475296    | 10-Feb-18 | 04:01 | x64      |
| Dtsconn.dll                                                   | 2017.140.3022.28 | 399008    | 10-Feb-18 | 07:40 | x86      |
| Dtsconn.dll                                                   | 2017.140.3022.28 | 497304    | 10-Feb-18 | 04:01 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3022.28 | 95392     | 10-Feb-18 | 07:40 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3022.28 | 111264    | 10-Feb-18 | 04:01 | x64      |
| Dtshost.exe                                                   | 2017.140.3022.28 | 103584    | 10-Feb-18 | 07:40 | x64      |
| Dtshost.exe                                                   | 2017.140.3022.28 | 89760     | 10-Feb-18 | 07:40 | x86      |
| Dtslog.dll                                                    | 2017.140.3022.28 | 103072    | 10-Feb-18 | 07:40 | x86      |
| Dtslog.dll                                                    | 2017.140.3022.28 | 120480    | 10-Feb-18 | 08:32 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3022.28 | 545440    | 10-Feb-18 | 03:43 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3022.28 | 541344    | 10-Feb-18 | 04:00 | x86      |
| Dtspipeline.dll                                               | 2017.140.3022.28 | 1266336   | 10-Feb-18 | 07:39 | x64      |
| Dtspipeline.dll                                               | 2017.140.3022.28 | 1058976   | 10-Feb-18 | 07:40 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3022.28 | 42656     | 10-Feb-18 | 07:40 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3022.28 | 48288     | 10-Feb-18 | 08:32 | x64      |
| Dtuparse.dll                                                  | 2017.140.3022.28 | 80544     | 10-Feb-18 | 07:40 | x86      |
| Dtuparse.dll                                                  | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtutil.exe                                                    | 2017.140.3022.28 | 147104    | 10-Feb-18 | 07:39 | x64      |
| Dtutil.exe                                                    | 2017.140.3022.28 | 126112    | 10-Feb-18 | 08:34 | x86      |
| Exceldest.dll                                                 | 2017.140.3022.28 | 214688    | 10-Feb-18 | 07:40 | x86      |
| Exceldest.dll                                                 | 2017.140.3022.28 | 260768    | 10-Feb-18 | 04:01 | x64      |
| Excelsrc.dll                                                  | 2017.140.3022.28 | 230560    | 10-Feb-18 | 07:40 | x86      |
| Excelsrc.dll                                                  | 2017.140.3022.28 | 282784    | 10-Feb-18 | 04:01 | x64      |
| Execpackagetask.dll                                           | 2017.140.3022.28 | 135328    | 10-Feb-18 | 07:40 | x86      |
| Execpackagetask.dll                                           | 2017.140.3022.28 | 168096    | 10-Feb-18 | 04:01 | x64      |
| Flatfiledest.dll                                              | 2017.140.3022.28 | 330904    | 10-Feb-18 | 08:34 | x86      |
| Flatfiledest.dll                                              | 2017.140.3022.28 | 384160    | 10-Feb-18 | 04:01 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3022.28 | 342176    | 10-Feb-18 | 07:40 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3022.28 | 396448    | 10-Feb-18 | 04:01 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3022.28 | 80544     | 10-Feb-18 | 07:40 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3022.28 | 96416     | 10-Feb-18 | 04:01 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3022.28     | 466592    | 10-Feb-18 | 08:32 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3022.28     | 467104    | 10-Feb-18 | 08:34 | x86      |
| Isserverexec.exe                                              | 14.0.3022.28     | 148640    | 10-Feb-18 | 07:39 | x64      |
| Isserverexec.exe                                              | 14.0.3022.28     | 149144    | 10-Feb-18 | 08:34 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1       | 1381536   | 26-Jan-18 | 22:13 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1       | 1381536   | 26-Jan-18 | 22:15 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 06-Nov-17 | 20:05 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3022.28     | 70304     | 10-Feb-18 | 07:39 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3022.28 | 107168    | 10-Feb-18 | 07:40 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3022.28 | 112288    | 10-Feb-18 | 04:01 | x64      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3022.28     | 89760     | 10-Feb-18 | 08:33 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3022.28     | 89760     | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3022.28     | 494744    | 10-Feb-18 | 03:34 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3022.28     | 494752    | 10-Feb-18 | 03:34 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3022.28     | 83616     | 10-Feb-18 | 07:39 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3022.28     | 83616     | 10-Feb-18 | 07:40 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3022.28     | 415904    | 10-Feb-18 | 08:33 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3022.28     | 415904    | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3022.28 | 152224    | 10-Feb-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3022.28 | 141984    | 10-Feb-18 | 07:30 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3022.28 | 159392    | 10-Feb-18 | 03:54 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3022.28 | 145568    | 10-Feb-18 | 03:55 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3022.28     | 219808    | 10-Feb-18 | 07:39 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3022.28 | 90272     | 10-Feb-18 | 07:40 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3022.28 | 103072    | 10-Feb-18 | 04:01 | x64      |
| Msmdpp.dll                                                    | 2017.140.204.1   | 9194144   | 26-Jan-18 | 22:13 | x64      |
| Oledbdest.dll                                                 | 2017.140.3022.28 | 214688    | 10-Feb-18 | 07:40 | x86      |
| Oledbdest.dll                                                 | 2017.140.3022.28 | 261280    | 10-Feb-18 | 04:01 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3022.28 | 233120    | 10-Feb-18 | 07:40 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3022.28 | 288928    | 10-Feb-18 | 04:01 | x64      |
| Rawdest.dll                                                   | 2017.140.3022.28 | 166560    | 10-Feb-18 | 07:40 | x86      |
| Rawdest.dll                                                   | 2017.140.3022.28 | 206496    | 10-Feb-18 | 04:01 | x64      |
| Rawsource.dll                                                 | 2017.140.3022.28 | 153248    | 10-Feb-18 | 07:40 | x86      |
| Rawsource.dll                                                 | 2017.140.3022.28 | 194208    | 10-Feb-18 | 04:01 | x64      |
| Recordsetdest.dll                                             | 2017.140.3022.28 | 149152    | 10-Feb-18 | 07:40 | x86      |
| Recordsetdest.dll                                             | 2017.140.3022.28 | 184480    | 10-Feb-18 | 04:01 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlceip.exe                                                   | 14.0.3022.28     | 251040    | 10-Feb-18 | 07:38 | x86      |
| Sqldest.dll                                                   | 2017.140.3022.28 | 213656    | 10-Feb-18 | 07:40 | x86      |
| Sqldest.dll                                                   | 2017.140.3022.28 | 260768    | 10-Feb-18 | 04:01 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3022.28 | 155288    | 10-Feb-18 | 07:40 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3022.28 | 183960    | 10-Feb-18 | 04:01 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3022.28 | 176800    | 10-Feb-18 | 07:40 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3022.28 | 216224    | 10-Feb-18 | 04:01 | x64      |
| Txagg.dll                                                     | 2017.140.3022.28 | 302240    | 10-Feb-18 | 07:40 | x86      |
| Txagg.dll                                                     | 2017.140.3022.28 | 362144    | 10-Feb-18 | 04:01 | x64      |
| Txbdd.dll                                                     | 2017.140.3022.28 | 139424    | 10-Feb-18 | 07:40 | x86      |
| Txbdd.dll                                                     | 2017.140.3022.28 | 175264    | 10-Feb-18 | 04:01 | x64      |
| Txbestmatch.dll                                               | 2017.140.3022.28 | 493216    | 10-Feb-18 | 07:40 | x86      |
| Txbestmatch.dll                                               | 2017.140.3022.28 | 605344    | 10-Feb-18 | 04:01 | x64      |
| Txcache.dll                                                   | 2017.140.3022.28 | 180384    | 10-Feb-18 | 07:40 | x64      |
| Txcache.dll                                                   | 2017.140.3022.28 | 149152    | 10-Feb-18 | 07:40 | x86      |
| Txcharmap.dll                                                 | 2017.140.3022.28 | 286880    | 10-Feb-18 | 07:40 | x64      |
| Txcharmap.dll                                                 | 2017.140.3022.28 | 248992    | 10-Feb-18 | 07:40 | x86      |
| Txcopymap.dll                                                 | 2017.140.3022.28 | 145568    | 10-Feb-18 | 07:40 | x86      |
| Txcopymap.dll                                                 | 2017.140.3022.28 | 180384    | 10-Feb-18 | 04:01 | x64      |
| Txdataconvert.dll                                             | 2017.140.3022.28 | 253088    | 10-Feb-18 | 07:40 | x86      |
| Txdataconvert.dll                                             | 2017.140.3022.28 | 293024    | 10-Feb-18 | 04:01 | x64      |
| Txderived.dll                                                 | 2017.140.3022.28 | 604320    | 10-Feb-18 | 07:40 | x64      |
| Txderived.dll                                                 | 2017.140.3022.28 | 515744    | 10-Feb-18 | 07:40 | x86      |
| Txfileextractor.dll                                           | 2017.140.3022.28 | 198816    | 10-Feb-18 | 07:40 | x64      |
| Txfileextractor.dll                                           | 2017.140.3022.28 | 160928    | 10-Feb-18 | 07:40 | x86      |
| Txfileinserter.dll                                            | 2017.140.3022.28 | 159392    | 10-Feb-18 | 07:40 | x86      |
| Txfileinserter.dll                                            | 2017.140.3022.28 | 196768    | 10-Feb-18 | 08:33 | x64      |
| Txgroupdups.dll                                               | 2017.140.3022.28 | 231072    | 10-Feb-18 | 07:40 | x86      |
| Txgroupdups.dll                                               | 2017.140.3022.28 | 290464    | 10-Feb-18 | 04:01 | x64      |
| Txlineage.dll                                                 | 2017.140.3022.28 | 136864    | 10-Feb-18 | 07:40 | x64      |
| Txlineage.dll                                                 | 2017.140.3022.28 | 110240    | 10-Feb-18 | 07:40 | x86      |
| Txlookup.dll                                                  | 2017.140.3022.28 | 446624    | 10-Feb-18 | 07:40 | x86      |
| Txlookup.dll                                                  | 2017.140.3022.28 | 528032    | 10-Feb-18 | 04:01 | x64      |
| Txmerge.dll                                                   | 2017.140.3022.28 | 176800    | 10-Feb-18 | 07:40 | x86      |
| Txmerge.dll                                                   | 2017.140.3022.28 | 230048    | 10-Feb-18 | 04:01 | x64      |
| Txmergejoin.dll                                               | 2017.140.3022.28 | 221856    | 10-Feb-18 | 07:40 | x86      |
| Txmergejoin.dll                                               | 2017.140.3022.28 | 275616    | 10-Feb-18 | 08:33 | x64      |
| Txmulticast.dll                                               | 2017.140.3022.28 | 103072    | 10-Feb-18 | 07:40 | x86      |
| Txmulticast.dll                                               | 2017.140.3022.28 | 127648    | 10-Feb-18 | 04:01 | x64      |
| Txpivot.dll                                                   | 2017.140.3022.28 | 224928    | 10-Feb-18 | 07:40 | x64      |
| Txpivot.dll                                                   | 2017.140.3022.28 | 180384    | 10-Feb-18 | 07:40 | x86      |
| Txrowcount.dll                                                | 2017.140.3022.28 | 102048    | 10-Feb-18 | 07:40 | x86      |
| Txrowcount.dll                                                | 2017.140.3022.28 | 125600    | 10-Feb-18 | 04:01 | x64      |
| Txsampling.dll                                                | 2017.140.3022.28 | 135840    | 10-Feb-18 | 07:40 | x86      |
| Txsampling.dll                                                | 2017.140.3022.28 | 172704    | 10-Feb-18 | 04:01 | x64      |
| Txscd.dll                                                     | 2017.140.3022.28 | 170144    | 10-Feb-18 | 07:40 | x86      |
| Txscd.dll                                                     | 2017.140.3022.28 | 220832    | 10-Feb-18 | 04:01 | x64      |
| Txsort.dll                                                    | 2017.140.3022.28 | 208032    | 10-Feb-18 | 07:40 | x86      |
| Txsort.dll                                                    | 2017.140.3022.28 | 256672    | 10-Feb-18 | 04:01 | x64      |
| Txsplit.dll                                                   | 2017.140.3022.28 | 596640    | 10-Feb-18 | 07:40 | x64      |
| Txsplit.dll                                                   | 2017.140.3022.28 | 510624    | 10-Feb-18 | 07:40 | x86      |
| Txtermextraction.dll                                          | 2017.140.3022.28 | 8676512   | 10-Feb-18 | 07:40 | x64      |
| Txtermextraction.dll                                          | 2017.140.3022.28 | 8615072   | 10-Feb-18 | 07:40 | x86      |
| Txtermlookup.dll                                              | 2017.140.3022.28 | 4157088   | 10-Feb-18 | 07:40 | x64      |
| Txtermlookup.dll                                              | 2017.140.3022.28 | 4106912   | 10-Feb-18 | 07:40 | x86      |
| Txunionall.dll                                                | 2017.140.3022.28 | 181920    | 10-Feb-18 | 07:40 | x64      |
| Txunionall.dll                                                | 2017.140.3022.28 | 139424    | 10-Feb-18 | 08:35 | x86      |
| Txunpivot.dll                                                 | 2017.140.3022.28 | 160416    | 10-Feb-18 | 07:40 | x86      |
| Txunpivot.dll                                                 | 2017.140.3022.28 | 199840    | 10-Feb-18 | 04:01 | x64      |
| Xe.dll                                                        | 2017.140.3022.28 | 673440    | 10-Feb-18 | 03:37 | x64      |
| Xe.dll                                                        | 2017.140.3022.28 | 595616    | 10-Feb-18 | 03:55 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 24-Jan-18 | 15:05 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 24-Jan-18 | 15:05 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 24-Jan-18 | 15:05 | x86      |
| Instapi140.dll                                                       | 2017.140.3022.28 | 70296     | 10-Feb-18 | 03:34 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 24-Jan-18 | 15:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 24-Jan-18 | 15:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 24-Jan-18 | 15:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 24-Jan-18 | 15:21 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 24-Jan-18 | 15:02 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 24-Jan-18 | 15:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 24-Jan-18 | 15:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 24-Jan-18 | 15:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 24-Jan-18 | 15:21 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 24-Jan-18 | 15:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 24-Jan-18 | 15:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 24-Jan-18 | 15:05 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 24-Jan-18 | 15:05 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3022.28 | 407200    | 10-Feb-18 | 08:04 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3022.28 | 7323808   | 10-Feb-18 | 08:04 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3022.28 | 2263200   | 10-Feb-18 | 07:40 | x64      |
| Secforwarder.dll                                                     | 2017.140.3022.28 | 37536     | 10-Feb-18 | 03:57 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 24-Jan-18 | 15:05 | x64      |
| Sqldk.dll                                                            | 2017.140.3022.28 | 2709504   | 10-Feb-18 | 04:00 | x64      |
| Sqldumper.exe                                                        | 2017.140.3022.28 | 140448    | 10-Feb-18 | 03:54 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 1495712   | 10-Feb-18 | 03:37 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3908768   | 10-Feb-18 | 03:37 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3208864   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3911328   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3814560   | 10-Feb-18 | 03:41 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 2086560   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 2033312   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3582624   | 10-Feb-18 | 03:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3591328   | 10-Feb-18 | 03:41 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 1442976   | 10-Feb-18 | 03:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3022.28 | 3778720   | 10-Feb-18 | 03:40 | x64      |
| Sqlos.dll                                                            | 2017.140.3022.28 | 26272     | 10-Feb-18 | 04:00 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 24-Jan-18 | 15:05 | x64      |
| Sqltses.dll                                                          | 2017.140.3022.28 | 9690624   | 10-Feb-18 | 07:29 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3022.28     | 23712     | 10-Feb-18 | 03:43 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |

SQL Server 2017 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2017.140.3022.28 | 1448608   | 10-Feb-18 | 07:40 | x86      |
| Dtaengine.exe                                  | 2017.140.3022.28 | 204448    | 10-Feb-18 | 07:40 | x86      |
| Dteparse.dll                                   | 2017.140.3022.28 | 101024    | 10-Feb-18 | 07:40 | x86      |
| Dteparse.dll                                   | 2017.140.3022.28 | 111264    | 10-Feb-18 | 04:01 | x64      |
| Dteparsemgd.dll                                | 2017.140.3022.28 | 83616     | 10-Feb-18 | 07:40 | x86      |
| Dteparsemgd.dll                                | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtepkg.dll                                     | 2017.140.3022.28 | 137888    | 10-Feb-18 | 07:39 | x64      |
| Dtepkg.dll                                     | 2017.140.3022.28 | 116896    | 10-Feb-18 | 07:40 | x86      |
| Dtexec.exe                                     | 2017.140.3022.28 | 73888     | 10-Feb-18 | 07:39 | x64      |
| Dtexec.exe                                     | 2017.140.3022.28 | 67744     | 10-Feb-18 | 08:34 | x86      |
| Dts.dll                                        | 2017.140.3022.28 | 2549400   | 10-Feb-18 | 07:40 | x86      |
| Dts.dll                                        | 2017.140.3022.28 | 2998944   | 10-Feb-18 | 04:01 | x64      |
| Dtscomexpreval.dll                             | 2017.140.3022.28 | 417952    | 10-Feb-18 | 07:40 | x86      |
| Dtscomexpreval.dll                             | 2017.140.3022.28 | 475296    | 10-Feb-18 | 04:01 | x64      |
| Dtsconn.dll                                    | 2017.140.3022.28 | 399008    | 10-Feb-18 | 07:40 | x86      |
| Dtsconn.dll                                    | 2017.140.3022.28 | 497304    | 10-Feb-18 | 04:01 | x64      |
| Dtshost.exe                                    | 2017.140.3022.28 | 103584    | 10-Feb-18 | 07:40 | x64      |
| Dtshost.exe                                    | 2017.140.3022.28 | 89760     | 10-Feb-18 | 07:40 | x86      |
| Dtslog.dll                                     | 2017.140.3022.28 | 103072    | 10-Feb-18 | 07:40 | x86      |
| Dtslog.dll                                     | 2017.140.3022.28 | 120480    | 10-Feb-18 | 08:32 | x64      |
| Dtsmsg140.dll                                  | 2017.140.3022.28 | 545440    | 10-Feb-18 | 03:43 | x64      |
| Dtsmsg140.dll                                  | 2017.140.3022.28 | 541344    | 10-Feb-18 | 04:00 | x86      |
| Dtspipeline.dll                                | 2017.140.3022.28 | 1266336   | 10-Feb-18 | 07:39 | x64      |
| Dtspipeline.dll                                | 2017.140.3022.28 | 1058976   | 10-Feb-18 | 07:40 | x86      |
| Dtspipelineperf140.dll                         | 2017.140.3022.28 | 42656     | 10-Feb-18 | 07:40 | x86      |
| Dtspipelineperf140.dll                         | 2017.140.3022.28 | 48288     | 10-Feb-18 | 08:32 | x64      |
| Dtuparse.dll                                   | 2017.140.3022.28 | 80544     | 10-Feb-18 | 07:40 | x86      |
| Dtuparse.dll                                   | 2017.140.3022.28 | 89248     | 10-Feb-18 | 04:01 | x64      |
| Dtutil.exe                                     | 2017.140.3022.28 | 147104    | 10-Feb-18 | 07:39 | x64      |
| Dtutil.exe                                     | 2017.140.3022.28 | 126112    | 10-Feb-18 | 08:34 | x86      |
| Exceldest.dll                                  | 2017.140.3022.28 | 214688    | 10-Feb-18 | 07:40 | x86      |
| Exceldest.dll                                  | 2017.140.3022.28 | 260768    | 10-Feb-18 | 04:01 | x64      |
| Excelsrc.dll                                   | 2017.140.3022.28 | 230560    | 10-Feb-18 | 07:40 | x86      |
| Excelsrc.dll                                   | 2017.140.3022.28 | 282784    | 10-Feb-18 | 04:01 | x64      |
| Flatfiledest.dll                               | 2017.140.3022.28 | 330904    | 10-Feb-18 | 08:34 | x86      |
| Flatfiledest.dll                               | 2017.140.3022.28 | 384160    | 10-Feb-18 | 04:01 | x64      |
| Flatfilesrc.dll                                | 2017.140.3022.28 | 342176    | 10-Feb-18 | 07:40 | x86      |
| Flatfilesrc.dll                                | 2017.140.3022.28 | 396448    | 10-Feb-18 | 04:01 | x64      |
| Foreachfileenumerator.dll                      | 2017.140.3022.28 | 80544     | 10-Feb-18 | 07:40 | x86      |
| Foreachfileenumerator.dll                      | 2017.140.3022.28 | 96416     | 10-Feb-18 | 04:01 | x64      |
| Microsoft.sqlserver.astasks.dll                | 14.0.3022.28     | 70304     | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.astasksui.dll              | 14.0.3022.28     | 184480    | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3022.28     | 406688    | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3022.28     | 406688    | 10-Feb-18 | 04:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3022.28     | 2093216   | 10-Feb-18 | 08:34 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3022.28     | 2093216   | 10-Feb-18 | 04:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3022.28 | 152224    | 10-Feb-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3022.28 | 141984    | 10-Feb-18 | 07:30 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3022.28 | 159392    | 10-Feb-18 | 03:54 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3022.28 | 145568    | 10-Feb-18 | 03:55 | x86      |
| Msdtssrvrutil.dll                              | 2017.140.3022.28 | 90272     | 10-Feb-18 | 07:40 | x86      |
| Msdtssrvrutil.dll                              | 2017.140.3022.28 | 103072    | 10-Feb-18 | 04:01 | x64      |
| Msmgdsrv.dll                                   | 2017.140.204.1   | 7310496   | 26-Jan-18 | 22:16 | x86      |
| Oledbdest.dll                                  | 2017.140.3022.28 | 214688    | 10-Feb-18 | 07:40 | x86      |
| Oledbdest.dll                                  | 2017.140.3022.28 | 261280    | 10-Feb-18 | 04:01 | x64      |
| Oledbsrc.dll                                   | 2017.140.3022.28 | 233120    | 10-Feb-18 | 07:40 | x86      |
| Oledbsrc.dll                                   | 2017.140.3022.28 | 288928    | 10-Feb-18 | 04:01 | x64      |
| Sql_tools_extensions_keyfile.dll               | 2017.140.3022.28 | 100512    | 10-Feb-18 | 03:34 | x64      |
| Sqlresld.dll                                   | 2017.140.3022.28 | 30880     | 10-Feb-18 | 03:34 | x64      |
| Sqlresld.dll                                   | 2017.140.3022.28 | 28832     | 10-Feb-18 | 04:00 | x86      |
| Sqlresourceloader.dll                          | 2017.140.3022.28 | 29344     | 10-Feb-18 | 03:34 | x86      |
| Sqlresourceloader.dll                          | 2017.140.3022.28 | 32416     | 10-Feb-18 | 03:34 | x64      |
| Sqlscm.dll                                     | 2017.140.3022.28 | 70816     | 10-Feb-18 | 03:43 | x64      |
| Sqlscm.dll                                     | 2017.140.3022.28 | 60064     | 10-Feb-18 | 04:00 | x86      |
| Sqlsvc.dll                                     | 2017.140.3022.28 | 161440    | 10-Feb-18 | 07:39 | x64      |
| Sqlsvc.dll                                     | 2017.140.3022.28 | 134296    | 10-Feb-18 | 07:40 | x86      |
| Sqltaskconnections.dll                         | 2017.140.3022.28 | 155288    | 10-Feb-18 | 07:40 | x86      |
| Sqltaskconnections.dll                         | 2017.140.3022.28 | 183960    | 10-Feb-18 | 04:01 | x64      |
| Txdataconvert.dll                              | 2017.140.3022.28 | 253088    | 10-Feb-18 | 07:40 | x86      |
| Txdataconvert.dll                              | 2017.140.3022.28 | 293024    | 10-Feb-18 | 04:01 | x64      |
| Xe.dll                                         | 2017.140.3022.28 | 673440    | 10-Feb-18 | 03:37 | x64      |
| Xe.dll                                         | 2017.140.3022.28 | 595616    | 10-Feb-18 | 03:55 | x86      |
| Xmlrw.dll                                      | 2017.140.3022.28 | 257696    | 10-Feb-18 | 08:30 | x86      |
| Xmlrw.dll                                      | 2017.140.3022.28 | 305312    | 10-Feb-18 | 04:01 | x64      |
| Xmlrwbin.dll                                   | 2017.140.3022.28 | 189600    | 10-Feb-18 | 08:30 | x86      |
| Xmlrwbin.dll                                   | 2017.140.3022.28 | 224408    | 10-Feb-18 | 03:43 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2017.

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

This article also provides important information about the following situations:

- [**Pacemaker**](#pacemaker): A behavioral change is made in distributions that use the latest available version of Pacemaker. Mitigation methods are provided.

- [**Query Store**](#query-store): You must run this script if you use the Query Store and you have previously installed Microsoft SQL Server 2017 Cumulative Update 2 (CU2).

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2017 is available at the Download Center.

CU packages for Linux are available at https://packages.microsoft.com.

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Pacemaker notice</b></summary><a id="pacemaker"></a>

**IMPORTANT**

All distributions (including RHEL 7.3 and 7.4) that use the latest available **Pacemaker package 1.1.18-11.el7** introduce a behavior change for the `start-failure-is-fatal` cluster setting if its value is `false`. This change affects the failover workflow. If a primary replica experiences an outage, the cluster is expected to fail over to one of the available secondary replicas. Instead, users will notice that the cluster keeps trying to start the failed primary replica. If that primary never comes online (because of a permanent outage), the cluster never fails over to another available secondary replica.

This issue affects all SQL Server versions, regardless of the cumulative update version that they are on.

To mitigate the issue, use either of the following methods.

### Method 1

Follow these steps:

1. Remove the `start-failure-is-fatal` override from the existing cluster.

    \# RHEL, Ubuntu pcs property unset start-failure-is-fatal # or pcs property set start-failure-is-fatal=true # SLES crm configure property start-failure-is-fatal=true

1. Decrease the `cluster-recheck-interval` value.

    \# RHEL, Ubuntu pcs property set cluster-recheck-interval=\<Xmin> # SLES crm configure property cluster-recheck-interval=\<Xmin>

1. Add the `failure-timeout` meta property to each AG resource.

    \# RHEL, Ubuntu pcs resource update ag1 meta failure-timeout=60s # SLES crm configure edit ag1 # In the text editor, add \`meta failure-timeout=60s\` after any \`param\`s and before any \`op\`s

    > [!NOTE]
    > In this code, substitute the value for \<Xmin> as appropriate. If a replica goes down, the cluster tries to restart the replica at an interval that is bound by the `failure-timeout` value and the `cluster-recheck-interval` value. For example, if `failure-timeout` is set to 60 seconds and `cluster-recheck-interval` is set to 120 seconds, the restart is tried at an interval that is greater than 60 seconds but less than 120 seconds. We recommend that you set `failure-timeout` to `60s` and `cluster-recheck-interval` to a value that is greater than 60 seconds. We recommend that you do not set `cluster-recheck-interval` to a small value. For more information, refer to the Pacemaker documentation or consult the system provider.

### Method 2

Revert to Pacemaker version 1.1.16.

</details>

<details>
<summary><b>Query Store notice</b></summary><a id="query-store"></a>

**IMPORTANT**

You must run this script if you use Query Store and you're updating from SQL Server 2017 Cumulative Update 2 (CU2) directly to SQL Server 2017 Cumulative Update 3 (CU3) or any later cumulative update. You don't have to run this script if you have previously installed SQL Server 2017 Cumulative Update 3 (CU3) or any later SQL Server 2017 cumulative update.

```sql
SET NOCOUNT ON;
DROP TABLE IF EXISTS #tmpUserDBs;

SELECT [database_id], 0 AS [IsDone]
INTO #tmpUserDBs
FROM master.sys.databases
WHERE [database_id] > 4
 AND [state] = 0 -- must be ONLINE
 AND is_read_only = 0 -- cannot be READ_ONLY
 AND [database_id] NOT IN (SELECT dr.database_id FROM sys.dm_hadr_database_replica_states dr -- Except all local Always On secondary replicas
  INNER JOIN sys.dm_hadr_availability_replica_states rs ON dr.group_id = rs.group_id
  INNER JOIN sys.databases d ON dr.database_id = d.database_id
  WHERE rs.role = 2 -- Is Secondary
   AND dr.is_local = 1
   AND rs.is_local = 1)

DECLARE @userDB sysname;

WHILE (SELECT COUNT([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0) > 0
BEGIN
 SELECT TOP 1 @userDB = DB_NAME([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0

 -- PRINT 'Working on database ' + @userDB

 EXEC ('USE [' + @userDB + '];
DECLARE @clearPlan bigint, @clearQry bigint;
IF EXISTS (SELECT [actual_state] FROM sys.database_query_store_options WHERE [actual_state] IN (1,2))
BEGIN
 IF EXISTS (SELECT plan_id FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27'')
 BEGIN
  DROP TABLE IF EXISTS #tmpclearPlans;

  SELECT plan_id, query_id, 0 AS [IsDone]
  INTO #tmpclearPlans
  FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27''

  WHILE (SELECT COUNT(plan_id) FROM #tmpclearPlans WHERE [IsDone] = 0) > 0
  BEGIN
   SELECT TOP 1 @clearPlan = plan_id, @clearQry = query_id FROM #tmpclearPlans WHERE [IsDone] = 0
   EXECUTE sys.sp_query_store_unforce_plan @clearQry, @clearPlan;
   EXECUTE sys.sp_query_store_remove_plan @clearPlan;

   UPDATE #tmpclearPlans
   SET [IsDone] = 1
   WHERE plan_id = @clearPlan AND query_id = @clearQry
  END;

  PRINT ''- Cleared possibly affected plans in database [' + @userDB + ']''
 END
 ELSE
 BEGIN
  PRINT ''- No affected plans in database [' + @userDB + ']''
 END
END
ELSE
BEGIN
 PRINT ''- Query Store not enabled in database [' + @userDB + ']''
END')
  UPDATE #tmpUserDBs
  SET [IsDone] = 1
  WHERE [database_id] = DB_ID(@userDB)
END
```

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

One CU package includes all available updates for all SQL Server 2017 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2017**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

**Third-party information disclaimer**

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
