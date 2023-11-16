---
title: Cumulative update 8 for SQL Server 2016 SP1 (KB4077064)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 8 (KB4077064).
ms.date: 10/26/2023
ms.custom: KB4077064
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB4077064 - Cumulative Update 8 for SQL Server 2016 SP1

_Release Date:_ &nbsp; March 19, 2018  
_Version:_ &nbsp; 13.0.4474.0

This article describes cumulative update package 8 (build number: **13.0.4474.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area |
|----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| <a id=11190572>[11190572](#11190572) </a>| FIX: Drillthrough operation fails and returns an error for row-level non-administrators in SSAS 2016 (Tabular model) (KB4074696) | Analysis Services|
| <a id=11403782>[11403782](#11403782) </a>| [FIX: Assertion error when executing a stored procedure that references a large object in SQL Server 2014, 2016, and 2017 (KB4058565)](https://support.microsoft.com/help/4058565) | SQL performance|
| <a id=11455726>[11455726](#11455726) </a>| [FIX: Unexpected error when you create a subcube in SQL Server 2016 Analysis Services (Multidimensional model) (KB4074862)](https://support.microsoft.com/help/4074862)| Analysis Services|
| <a id=11444126>[11444126](#11444126) </a>| [FIX: Assertion error when data is bulk-inserted into a table that contains nonclustered and clustered columnstore indexes in SQL Server 2016 (KB4074881)](https://support.microsoft.com/help/4074881) | SQL Engine |
| <a id=11441098>[11441098](#11441098) </a>| [FIX: A REDO thread is not available in the secondary replica after an availability database is dropped in SQL Server (KB4017445)](https://support.microsoft.com/help/4017445) | High Availability|
| <a id=10988062>[10988062](#10988062) </a>| FIX: Change Data Capture functionality doesn't work in SQL Server (KB4038932) | Integration Services |
| <a id=11405602>[11405602](#11405602) </a>| [FIX: UPDATE statement fails silently when you reference a nonexistent partition function in the WHERE clause in SQL Server 2014, 2016, or 2017 (KB4046745)](https://support.microsoft.com/help/4046745) | SQL Engine |
| <a id=11405606>[11405606](#11405606) </a>| [FIX: Can't enable or disable change data capture for a database after you attach it in SQL Server 2014, 2016, or 2017 (KB4048967)](https://support.microsoft.com/help/4048967)| SQL Engine |
| <a id=11405621>[11405621](#11405621) </a>| [FIX: "Invalid comparison due to NO COLLATION" retail assert occurs in SQL Server 2014, 2016, and 2017 (KB4054398)](https://support.microsoft.com/help/4054398)| SQL Engine |
| <a id=11297169>[11297169](#11297169) </a>| [FIX: SSRS subscriptions fail to run for a report that connects to a SharePoint External list (KB4013247)](https://support.microsoft.com/help/4013247) | Reporting Services |
| <a id=11396933>[11396933](#11396933) </a>| [FIX: Totals are wrong after you filter on a pivot table item and remove the filter in SSAS (KB2932559)](https://support.microsoft.com/help/2932559) | Analysis Services|
| <a id=11511975>[11511975](#11511975) </a>| [FIX: Out of memory error when the virtual address space of the SQL Server process is very low in SQL Server (KB4077105)](https://support.microsoft.com/help/4077105)| SQL Engine |
| <a id=11455724>[11455724](#11455724) </a>| [FIX: SSAS crashes when a query is executed on a large partitioned table in SQL Server 2016 (KB4082865)](https://support.microsoft.com/help/4082865) | Analysis Services|
| <a id=11456360>[11456360](#11456360) </a>| [FIX: SSAS may crash when you execute a DAX query by using a non-admin Windows user in SQL Server 2016 (KB4083949)](https://support.microsoft.com/help/4083949)| Analysis Services|
| <a id=11511973>[11511973](#11511973) </a>| [FIX: Multidimensional mode randomly crashes and an access violation occurs in SSAS 2016 or in SSAS 2014 (KB4057307)](https://support.microsoft.com/help/4057307)| Analysis Services|
| <a id=11509590>[11509590](#11509590) </a>| [FIX: SSAS stops responding when you execute an MDX query in SQL Server 2016 Analysis Services (Multidimensional model) (KB4086136)](https://support.microsoft.com/help/4086136) | Analysis Services|
| <a id=11426456>[11426456](#11426456) </a>| [FIX: Expression-based connection string is cleared out when you configure data sources for the report in SSRS 2016 (KB4087358)](https://support.microsoft.com/help/4087358) | Reporting Services |
| <a id=11508542>[11508542](#11508542) </a>| [FIX: Assertion failure when sys.dm_db_log_space_usage statement is run on a database snapshot in SQL Server 2016 (KB4088901)](https://support.microsoft.com/help/4088901) | High Availability|
| <a id=11183472>[11183472](#11183472) </a>| [FIX: Error 15665 when you call sp_set_session_context repeatedly with null key value in SQL Server 2016 (KB4089324)](https://support.microsoft.com/help/4089324)| SQL Engine |
| <a id=11565899>[11565899](#11565899) </a>| [FIX: It takes a long time to restore a TDE encrypted database backup in SQL Server (KB4089099)](https://support.microsoft.com/help/4089099) | SQL Engine |
| <a id=11529110>[11529110](#11529110) </a>| [FIX: Out of memory occurs and query fails when you run MDX query with NON EMPTY option in SSAS 2016 and SSAS 2014 (KB4089623)](https://support.microsoft.com/help/4089623)| Analysis Services|
| <a id=11053682>[11053682](#11053682) </a>| [Update to support partition elimination in query plans that have spatial indexes in SQL Server 2016 (KB4089950)](https://support.microsoft.com/help/4089950)| SQL performance|
| <a id=11323371>[11323371](#11323371) </a>| FIX: Random masking doesn't mask BIGINT values correctly in SQL Server (KB4090025)| SQL security |
| <a id=11456072>[11456072](#11456072) </a>| [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2016 multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032) | Analysis Services|
| <a id=11569422>[11569422](#11569422) </a>| [FIX: Intra-query deadlock when values are inserted into a partitioned clustered columnstore index in SQL Server 2016 (KB4089948)](https://support.microsoft.com/help/4089948) | SQL Engine |
| <a id=11281514>[11281514](#11281514) </a>| [FIX: DMV sys.dm_os_windows_info returns wrong values for Windows 10 and Windows Server 2016 (KB4052131)](https://support.microsoft.com/help/4052131)| SQL Engine |
| <a id=11301441>[11301441](#11301441) </a>| [FIX: Intermittent 9004 error when a backup is restored via Standby Mode in SQL Server 2014 (KB4058700)](https://support.microsoft.com/help/4058700) | SQL Engine |
| <a id=11336087>[11336087](#11336087) </a>| [FIX: "Incorrect syntax near the keyword 'KEY'" error when you add an Oracle table with primary column named 'KEY' in SQL Server 2016 (KB4057615)](https://support.microsoft.com/help/4057615) | Integration Services |
| <a id=11339410>[11339410](#11339410) </a>| [FIX: ALTER PROCEDURE WITH ENCRYPTION statement fails when you encrypt a non-published stored procedure in SQL Server 2016 (KB4058289)](https://support.microsoft.com/help/4058289)| SQL Engine |
| <a id=11420793>[11420793](#11420793) </a>| [FIX: Error when upgrading SSIS catalog database in SQL Server 2016 Standard Edition (KB4058747)](https://support.microsoft.com/help/4058747)| Integration Services |
| <a id=11457917>[11457917](#11457917) </a>| [FIX: System stored procedure sp_execute_external_script and DMV sys.dm_exec_cached_plans cause memory leaks in SQL Server 2016 and 2017 (KB4077683)](https://support.microsoft.com/help/4077683)| SQL Engine |
| <a id=11447600>[11447600](#11447600) </a>| [FIX: Unexpected exception occurs when you process dimensions by using Process Update in SSAS 2016 (KB4038881)](https://support.microsoft.com/help/4038881)| Analysis Services|
| <a id=11309597>[11309597](#11309597) </a>| [FIX: "The data area passed to a system call is too small" error when you start a Desktop Bridge application on a SQL Server 2014, 2016, and 2017 (KB4073393)](https://support.microsoft.com/help/4073393) | SQL Engine |
| <a id=11446129>[11446129](#11446129) </a>| [A non-optimal query plan choice causes poor performance when values outside the range represented in statistics are searched in SQL Server 2016 and 2017 (KB3192154)](https://support.microsoft.com/help/3192154) | SQL performance|
| <a id=11548517>[11548517](#11548517) </a>| [FIX: Large disk checkpoint usage occurs for an In-Memory optimized filegroup during heavy non-In-Memory workloads (KB3147012)](https://support.microsoft.com/help/3147012)| In-Memory OLTP |
| <a id=11559191>[11559191](#11559191) </a>| [FIX: Heavy tempdb contention occurs in SQL Server 2016 (KB4058174)](https://support.microsoft.com/help/4058174) | SQL Engine |
| <a id=11516257>[11516257](#11516257) </a>| [FIX: Error 9002 when there is no sufficient disk space for critical log growth in SQL Server 2014 and 2016 (KB4087406)](https://support.microsoft.com/help/4087406) | SQL Engine |
| <a id=11444654>[11444654](#11444654) </a>| [FIX: Managed Backup does not handle renaming database name to a new name with trailing spaces in SQL Server 2016 (KB4090486)](https://support.microsoft.com/help/4090486) | Management Tools |
| <a id=11704293>[11704293](#11704293) </a>| [FIX: Random access violations occur when you run monitoring stored procedure in SQL Server 2016 (KB4078596)](https://support.microsoft.com/help/4078596)| SQL Engine |
| <a id=11545426>[11545426](#11545426) </a>| [Improves the query performance when an optimized bitmap filter is applied to a query plan in SQL Server 2016 and 2017 (KB4089276)](https://support.microsoft.com/help/4089276)| SQL Engine |
| <a id=11532381>[11532381](#11532381) </a>| [FIX: "A time-out occurred while waiting for buffer latch -- type 4" error when you use Availability Groups in SQL Server 2016 or 2017 (KB4089819)](https://support.microsoft.com/help/4089819)| High Availability|
| <a id=11293280>[11293280](#11293280) </a>| Fixes SQL Server Assertion (File: <DbCopyTask.cpp>, line = 141 Failed Assertion = 'false' Not allowed to throw to Task) while configuring a replica for manual seeding mode. | High Availability|
| <a id=11544417>[11544417](#11544417) </a>| SQL Datatype mappings configured for replication get deleted when you apply CU7 update.| SQL Engine |
| <a id=11550191>[11550191](#11550191) </a>| Incorrect query output and poor query performance after taking the backup of the tabular database or performing synchronization. | Analysis Services|
| <a id=11183971>[11183971](#11183971) </a>| Fixes Polybase engine service encountering ErrorCode (NullReferenceException; Message: Object reference not set to an instance of an object) when PolyBase Perfmon Counters are missing. | SQL Engine |
| <a id=11567640>[11567640](#11567640) </a>| Fixes the issue of trend line for the KPI doesn't get refreshed whenever the data set gets updated with the latest values.| Reporting Services |

## Additonal resolutions

Resolutions to the following issues are also included in SQL Server 2016 SP1 CU8.

| Bug reference | Description|
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| 11701162 | An assertion failure occurs when you stop automatic seeding for an availability group. |
| 11704344 | DAX queries run slower than before after you back up an SSAS tabular database. |
| 11704240 </a> | PolyBase crashes if PolyBase counters are missing or corrupted in Windows Performance Monitor. |
| 11704339 | Improves the query performance when an optimized bitmap filter is applied to the query plan. |
| 11704329 | Parallel recovery fails with a buffer latch time-out on a secondary replica of an Always On availability group.|
| 11701219 | The trend line of KPI is not refreshed when the dataset is updated.|
| 11704269 | Adds the support of using a SQL Server 2017 database as a data source of a tabular DirectQuery model in SSAS 2016. |
| 11704293 | Random access violations occur when you run [dbo].[usp_CollectWhoIsActiveData] in SQL Server 2016. |
| 11704335 | Data replication from Oracle to SQL fails when you update CU7 for SQL Server 2016 SP1. |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP1 now](https://www.microsoft.com/download/details.aspx?id=54613)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.

- Microsoft recommends ongoing, proactive installation of CUs as they become available:

  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.

  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.

  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.

- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.

- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

  > [!NOTE]
  > If you don't want to use the rolling update process, follow these steps to apply an update: </br></br>1. Install the service pack on the passive node. </br></br>2. Install the update on the active node (requires a service restart).

- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On with SSISDB catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply an update in these environments.

- [Apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)

- [Apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

- [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One Cumulative Update package includes all available updates for ALL SQL Server 2016 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance you select to be serviced. If a SQL Server feature (e.g. Analysis Services) is added to the instance after this CU is applied, you must re-apply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **View installed updates** under **Programs and Features**.

2. Locate the entry that corresponds to this cumulative update package under **Microsoft SQL Server 2016**.

3. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP1.

</details>

<details>
<summary><b>Restart information</b></summary>

You may have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

## File information

<details>
<summary><b>Cumulative update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

| File   name            | File version    | File size | Date      | Time  | Platform |
|------------------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll         | 2015.130.4474.0 | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Msmdredir.dll          | 2015.130.4474.0 | 6421680   | 24-Feb-2018 | 23:35 | x86      |
| Msmdsrv.rll            | 2015.130.4474.0 | 1296560   | 24-Feb-2018 | 23:35 | x86      |
| Msmdsrvi.rll           | 2015.130.4474.0 | 1293488   | 24-Feb-2018 | 23:35 | x86      |
| Sqlbrowser.exe         | 2015.130.4474.0 | 276656    | 24-Feb-2018 | 23:35 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Sqldumper.exe          | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4474.0  | 160424    | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                              | 2015.130.4474.0  | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Isacctchange.dll                            | 2015.130.4474.0  | 29360     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4474.0      | 1027248   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4474.0      | 1348784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4474.0      | 702640    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4474.0      | 765616    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4474.0      | 520880    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4474.0      | 711856    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4474.0      | 37032     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4474.0      | 46256     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4474.0  | 72872     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4474.0      | 598704    | 24-Feb-2018 | 23:37 | x86      |
| Msasxpress.dll                              | 2015.130.4474.0  | 31920     | 24-Feb-2018 | 23:35 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4474.0  | 60080     | 24-Feb-2018 | 23:35 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4474.0  | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Sqldumper.exe                               | 2015.130.4474.0  | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Sqlftacct.dll                               | 2015.130.4474.0  | 46768     | 24-Feb-2018 | 23:35 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04  | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4474.0  | 364208    | 24-Feb-2018 | 23:35 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4474.0  | 34992     | 24-Feb-2018 | 23:35 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4474.0  | 267440    | 24-Feb-2018 | 23:35 | x86      |
| Sqltdiagn.dll                               | 2015.130.4474.0  | 60592     | 24-Feb-2018 | 23:35 | x86      |
| Svrenumapi130.dll                           | 2015.130.4474.0  | 854192    | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4474.0  | 1876656   | 24-Feb-2018 | 23:37 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4474.0 | 121008    | 24-Feb-2018 | 23:35 | x86      |
| Dreplaycommon.dll              | 2015.130.4474.0 | 690864    | 24-Feb-2018 | 23:36 | x86      |
| Dreplayserverps.dll            | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x86      |
| Dreplayutil.dll                | 2015.130.4474.0 | 309936    | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                 | 2015.130.4474.0 | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Sqlresourceloader.dll          | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.130.4474.0 | 690864    | 24-Feb-2018 | 23:36 | x86      |
| Dreplaycontroller.exe              | 2015.130.4474.0 | 350384    | 24-Feb-2018 | 23:35 | x86      |
| Dreplayprocess.dll                 | 2015.130.4474.0 | 171696    | 24-Feb-2018 | 23:35 | x86      |
| Dreplayserverps.dll                | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                     | 2015.130.4474.0 | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Sqlresourceloader.dll              | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4474.0 | 1311920   | 24-Feb-2018 | 23:35 | x86      |
| Ddsshapes.dll                                   | 2015.130.4474.0 | 135856    | 24-Feb-2018 | 23:35 | x86      |
| Dtaengine.exe                                   | 2015.130.4474.0 | 167088    | 24-Feb-2018 | 23:35 | x86      |
| Dteparse.dll                                    | 2015.130.4474.0 | 99504     | 24-Feb-2018 | 23:35 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4474.0 | 83632     | 24-Feb-2018 | 23:36 | x86      |
| Dtepkg.dll                                      | 2015.130.4474.0 | 115888    | 24-Feb-2018 | 23:35 | x86      |
| Dtexec.exe                                      | 2015.130.4474.0 | 66736     | 24-Feb-2018 | 23:35 | x86      |
| Dts.dll                                         | 2015.130.4474.0 | 2632880   | 24-Feb-2018 | 23:35 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4474.0 | 418984    | 24-Feb-2018 | 23:35 | x86      |
| Dtsconn.dll                                     | 2015.130.4474.0 | 392368    | 24-Feb-2018 | 23:35 | x86      |
| Dtshost.exe                                     | 2015.130.4474.0 | 76464     | 24-Feb-2018 | 23:35 | x86      |
| Dtslog.dll                                      | 2015.130.4474.0 | 103088    | 24-Feb-2018 | 23:35 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4474.0 | 541360    | 24-Feb-2018 | 23:35 | x86      |
| Dtspipeline.dll                                 | 2015.130.4474.0 | 1059504   | 24-Feb-2018 | 23:35 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4474.0 | 42160     | 24-Feb-2018 | 23:35 | x86      |
| Dtswizard.exe                                   | 13.0.4474.0     | 896176    | 24-Feb-2018 | 23:28 | x86      |
| Dtuparse.dll                                    | 2015.130.4474.0 | 80048     | 24-Feb-2018 | 23:35 | x86      |
| Dtutil.exe                                      | 2015.130.4474.0 | 115376    | 24-Feb-2018 | 23:35 | x86      |
| Exceldest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Excelsrc.dll                                    | 2015.130.4474.0 | 232624    | 24-Feb-2018 | 23:35 | x86      |
| Flatfiledest.dll                                | 2015.130.4474.0 | 334512    | 24-Feb-2018 | 23:35 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4474.0 | 345264    | 24-Feb-2018 | 23:35 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4474.0 | 80560     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4474.0     | 1313456   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4474.0     | 696496    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4474.0     | 763568    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4474.0 | 2023088   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4474.0 | 42160     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4474.0     | 72368     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4474.0     | 186544    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4474.0     | 433840    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4474.0     | 2044592   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4474.0     | 33456     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4474.0     | 249520    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4474.0     | 501928    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4474.0     | 106160    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4474.0 | 138928    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4474.0 | 144560    | 24-Feb-2018 | 23:37 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4474.0 | 89776     | 24-Feb-2018 | 23:35 | x86      |
| Msmdlocal.dll                                   | 2015.130.4474.0 | 37097648  | 24-Feb-2018 | 23:35 | x86      |
| Msmdpp.dll                                      | 2015.130.4474.0 | 6370480   | 24-Feb-2018 | 23:35 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4474.0 | 6507696   | 24-Feb-2018 | 23:37 | x86      |
| Msolap130.dll                                   | 2015.130.4474.0 | 7008432   | 24-Feb-2018 | 23:35 | x86      |
| Msolui130.dll                                   | 2015.130.4474.0 | 287408    | 24-Feb-2018 | 23:35 | x86      |
| Oledbdest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Oledbsrc.dll                                    | 2015.130.4474.0 | 235696    | 24-Feb-2018 | 23:35 | x86      |
| Profiler.exe                                    | 2015.130.4474.0 | 804528    | 24-Feb-2018 | 23:28 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Sqldumper.exe                                   | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Sqlresld.dll                                    | 2015.130.4474.0 | 28848     | 24-Feb-2018 | 23:35 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |
| Sqlscm.dll                                      | 2015.130.4474.0 | 52912     | 24-Feb-2018 | 23:35 | x86      |
| Sqlsvc.dll                                      | 2015.130.4474.0 | 127144    | 24-Feb-2018 | 23:35 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4474.0 | 151216    | 24-Feb-2018 | 23:35 | x86      |
| Txdataconvert.dll                               | 2015.130.4474.0 | 255152    | 24-Feb-2018 | 23:36 | x86      |
| Xe.dll                                          | 2015.130.4474.0 | 558768    | 24-Feb-2018 | 23:35 | x86      |
| Xmlrw.dll                                       | 2015.130.4474.0 | 259760    | 24-Feb-2018 | 23:36 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4474.0 | 191664    | 24-Feb-2018 | 23:36 | x86      |
| Xmsrv.dll                                       | 2015.130.4474.0 | 32720560  | 24-Feb-2018 | 23:36 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time  | Platform |
|----------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll | 2015.130.4474.0 | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Keyfile.dll    | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:35 | x86      |
| Msmdredir.dll  | 2015.130.4474.0 | 6421680   | 24-Feb-2018 | 23:35 | x86      |
| Msmdsrv.rll    | 2015.130.4474.0 | 1296560   | 24-Feb-2018 | 23:35 | x86      |
| Msmdsrvi.rll   | 2015.130.4474.0 | 1293488   | 24-Feb-2018 | 23:35 | x86      |
| Sqlbrowser.exe | 2015.130.4474.0 | 276656    | 24-Feb-2018 | 23:35 | x86      |
| Sqldumper.exe  | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll        | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sqlboot.dll           | 2015.130.4474.0 | 186544    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe         | 2015.130.4474.0 | 127152    | 24-Feb-2018 | 23:35 | x64      |
| Sqlvdi.dll            | 2015.130.4474.0 | 168624    | 24-Feb-2018 | 23:35 | x86      |
| Sqlvdi.dll            | 2015.130.4474.0 | 197296    | 24-Feb-2018 | 23:35 | x64      |
| Sqlwriter.exe         | 2015.130.4474.0 | 131760    | 24-Feb-2018 | 23:35 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlwvss.dll           | 2015.130.4474.0 | 336560    | 24-Feb-2018 | 23:34 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4474.0 | 26288     | 24-Feb-2018 | 23:34 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4474.0     | 1347760   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4474.0     | 765616    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4474.0     | 521392    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4474.0     | 989872    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4474.0     | 989872    | 24-Feb-2018 | 23:36 | x86      |
| Msmdctr130.dll                                     | 2015.130.4474.0 | 40112     | 24-Feb-2018 | 23:35 | x64      |
| Msmdlocal.dll                                      | 2015.130.4474.0 | 37097648  | 24-Feb-2018 | 23:35 | x86      |
| Msmdlocal.dll                                      | 2015.130.4474.0 | 56205488  | 24-Feb-2018 | 23:35 | x64      |
| Msmdpump.dll                                       | 2015.130.4474.0 | 7798960   | 24-Feb-2018 | 23:35 | x64      |
| Msmdredir.dll                                      | 2015.130.4474.0 | 6421680   | 24-Feb-2018 | 23:35 | x86      |
| Msmdsrv.exe                                        | 2015.130.4474.0 | 56743600  | 24-Feb-2018 | 23:35 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4474.0 | 7507120   | 24-Feb-2018 | 23:35 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4474.0 | 6507696   | 24-Feb-2018 | 23:37 | x86      |
| Msolap130.dll                                      | 2015.130.4474.0 | 7008432   | 24-Feb-2018 | 23:35 | x86      |
| Msolap130.dll                                      | 2015.130.4474.0 | 8639152   | 24-Feb-2018 | 23:35 | x64      |
| Msolui130.dll                                      | 2015.130.4474.0 | 287408    | 24-Feb-2018 | 23:35 | x86      |
| Msolui130.dll                                      | 2015.130.4474.0 | 310448    | 24-Feb-2018 | 23:35 | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlboot.dll                                        | 2015.130.4474.0 | 186544    | 24-Feb-2018 | 23:35 | x64      |
| Sqlceip.exe                                        | 13.0.4474.0     | 247984    | 24-Feb-2018 | 23:37 | x86      |
| Sqldumper.exe                                      | 2015.130.4474.0 | 127152    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                                      | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Tmapi.dll                                          | 2015.130.4474.0 | 4346032   | 24-Feb-2018 | 23:34 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4474.0 | 2826416   | 24-Feb-2018 | 23:34 | x64      |
| Tmpersistence.dll                                  | 2015.130.4474.0 | 1071280   | 24-Feb-2018 | 23:34 | x64      |
| Tmtransactions.dll                                 | 2015.130.4474.0 | 1352368   | 24-Feb-2018 | 23:34 | x64      |
| Xe.dll                                             | 2015.130.4474.0 | 626352    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                          | 2015.130.4474.0 | 319152    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                          | 2015.130.4474.0 | 259760    | 24-Feb-2018 | 23:36 | x86      |
| Xmlrwbin.dll                                       | 2015.130.4474.0 | 227504    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrwbin.dll                                       | 2015.130.4474.0 | 191664    | 24-Feb-2018 | 23:36 | x86      |
| Xmsrv.dll                                          | 2015.130.4474.0 | 24044720  | 24-Feb-2018 | 23:34 | x64      |
| Xmsrv.dll                                          | 2015.130.4474.0 | 32720560  | 24-Feb-2018 | 23:36 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4474.0  | 160424    | 24-Feb-2018 | 23:35 | x86      |
| Batchparser.dll                             | 2015.130.4474.0  | 180912    | 24-Feb-2018 | 23:35 | x64      |
| Instapi130.dll                              | 2015.130.4474.0  | 53424     | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                              | 2015.130.4474.0  | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Isacctchange.dll                            | 2015.130.4474.0  | 30896     | 24-Feb-2018 | 23:35 | x64      |
| Isacctchange.dll                            | 2015.130.4474.0  | 29360     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4474.0      | 1027248   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4474.0      | 1027248   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4474.0      | 1348784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4474.0      | 702640    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4474.0      | 765616    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4474.0      | 520880    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4474.0      | 711856    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4474.0      | 711856    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4474.0      | 37032     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4474.0      | 46256     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4474.0  | 75440     | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4474.0  | 72872     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4474.0      | 598704    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4474.0      | 598704    | 24-Feb-2018 | 23:37 | x86      |
| Msasxpress.dll                              | 2015.130.4474.0  | 31920     | 24-Feb-2018 | 23:35 | x86      |
| Msasxpress.dll                              | 2015.130.4474.0  | 36016     | 24-Feb-2018 | 23:35 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4474.0  | 60080     | 24-Feb-2018 | 23:35 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4474.0  | 72880     | 24-Feb-2018 | 23:35 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4474.0  | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                               | 2015.130.4474.0  | 127152    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                               | 2015.130.4474.0  | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Sqlftacct.dll                               | 2015.130.4474.0  | 46768     | 24-Feb-2018 | 23:35 | x86      |
| Sqlftacct.dll                               | 2015.130.4474.0  | 51888     | 24-Feb-2018 | 23:35 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04  | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 4:18  | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4474.0  | 404144    | 24-Feb-2018 | 23:34 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4474.0  | 364208    | 24-Feb-2018 | 23:35 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4474.0  | 37552     | 24-Feb-2018 | 23:34 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4474.0  | 34992     | 24-Feb-2018 | 23:35 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4474.0  | 348848    | 24-Feb-2018 | 23:34 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4474.0  | 267440    | 24-Feb-2018 | 23:35 | x86      |
| Sqltdiagn.dll                               | 2015.130.4474.0  | 67760     | 24-Feb-2018 | 23:34 | x64      |
| Sqltdiagn.dll                               | 2015.130.4474.0  | 60592     | 24-Feb-2018 | 23:35 | x86      |
| Svrenumapi130.dll                           | 2015.130.4474.0  | 1115824   | 24-Feb-2018 | 23:34 | x64      |
| Svrenumapi130.dll                           | 2015.130.4474.0  | 854192    | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4474.0  | 1876656   | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4474.0  | 1876656   | 24-Feb-2018 | 23:37 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4474.0 | 121008    | 24-Feb-2018 | 23:35 | x86      |
| Dreplaycommon.dll              | 2015.130.4474.0 | 690864    | 24-Feb-2018 | 23:36 | x86      |
| Dreplayserverps.dll            | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x86      |
| Dreplayutil.dll                | 2015.130.4474.0 | 309936    | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                 | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlresourceloader.dll          | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.130.4474.0 | 690864    | 24-Feb-2018 | 23:36 | x86      |
| Dreplaycontroller.exe              | 2015.130.4474.0 | 350384    | 24-Feb-2018 | 23:35 | x86      |
| Dreplayprocess.dll                 | 2015.130.4474.0 | 171696    | 24-Feb-2018 | 23:35 | x86      |
| Dreplayserverps.dll                | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x86      |
| Instapi130.dll                     | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlresourceloader.dll              | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4474.0     | 41136     | 24-Feb-2018 | 23:35 | x64      |
| Batchparser.dll                              | 2015.130.4474.0 | 180912    | 24-Feb-2018 | 23:35 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925360    | 24-Feb-2018 | 23:36 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341360   | 24-Feb-2018 | 23:36 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192176    | 24-Feb-2018 | 23:35 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4474.0 | 225448    | 24-Feb-2018 | 23:35 | x64      |
| Dcexec.exe                                   | 2015.130.4474.0 | 74416     | 24-Feb-2018 | 23:35 | x64      |
| Fssres.dll                                   | 2015.130.4474.0 | 81584     | 24-Feb-2018 | 23:35 | x64      |
| Hadrres.dll                                  | 2015.130.4474.0 | 177840    | 24-Feb-2018 | 23:35 | x64      |
| Hkcompile.dll                                | 2015.130.4474.0 | 1298096   | 24-Feb-2018 | 23:35 | x64      |
| Hkengine.dll                                 | 2015.130.4474.0 | 5600944   | 24-Feb-2018 | 23:36 | x64      |
| Hkruntime.dll                                | 2015.130.4474.0 | 158896    | 24-Feb-2018 | 23:36 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017520   | 24-Feb-2018 | 23:35 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4474.0     | 235184    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4474.0     | 79536     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4474.0 | 391856    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4474.0 | 71344     | 24-Feb-2018 | 23:34 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4474.0 | 65192     | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4474.0 | 150192    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4474.0 | 158896    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4474.0 | 272048    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4474.0 | 74928     | 24-Feb-2018 | 23:36 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129712    | 24-Feb-2018 | 23:36 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559280    | 24-Feb-2018 | 23:36 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559280    | 24-Feb-2018 | 23:36 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661160    | 24-Feb-2018 | 23:36 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964784    | 24-Feb-2018 | 23:36 | x64      |
| Odsole70.dll                                 | 2015.130.4474.0 | 92848     | 24-Feb-2018 | 23:35 | x64      |
| Opends60.dll                                 | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x64      |
| Qds.dll                                      | 2015.130.4474.0 | 845488    | 24-Feb-2018 | 23:35 | x64      |
| Rsfxft.dll                                   | 2015.130.4474.0 | 34472     | 24-Feb-2018 | 23:35 | x64      |
| Sqagtres.dll                                 | 2015.130.4474.0 | 64688     | 24-Feb-2018 | 23:35 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlaamss.dll                                 | 2015.130.4474.0 | 80560     | 24-Feb-2018 | 23:35 | x64      |
| Sqlaccess.dll                                | 2015.130.4474.0 | 462512    | 24-Feb-2018 | 23:36 | x64      |
| Sqlagent.exe                                 | 2015.130.4474.0 | 566448    | 24-Feb-2018 | 23:35 | x64      |
| Sqlagentctr130.dll                           | 2015.130.4474.0 | 44208     | 24-Feb-2018 | 23:35 | x86      |
| Sqlagentctr130.dll                           | 2015.130.4474.0 | 51888     | 24-Feb-2018 | 23:35 | x64      |
| Sqlagentlog.dll                              | 2015.130.4474.0 | 32944     | 24-Feb-2018 | 23:35 | x64      |
| Sqlagentmail.dll                             | 2015.130.4474.0 | 47792     | 24-Feb-2018 | 23:35 | x64      |
| Sqlboot.dll                                  | 2015.130.4474.0 | 186544    | 24-Feb-2018 | 23:35 | x64      |
| Sqlceip.exe                                  | 13.0.4474.0     | 247984    | 24-Feb-2018 | 23:37 | x86      |
| Sqlcmdss.dll                                 | 2015.130.4474.0 | 60080     | 24-Feb-2018 | 23:35 | x64      |
| Sqlctr130.dll                                | 2015.130.4474.0 | 103600    | 24-Feb-2018 | 23:35 | x86      |
| Sqlctr130.dll                                | 2015.130.4474.0 | 118448    | 24-Feb-2018 | 23:35 | x64      |
| Sqldk.dll                                    | 2015.130.4474.0 | 2586800   | 24-Feb-2018 | 23:35 | x64      |
| Sqldtsss.dll                                 | 2015.130.4474.0 | 97456     | 24-Feb-2018 | 23:35 | x64      |
| Sqliosim.com                                 | 2015.130.4474.0 | 307888    | 24-Feb-2018 | 23:35 | x64      |
| Sqliosim.exe                                 | 2015.130.4474.0 | 3014320   | 24-Feb-2018 | 23:35 | x64      |
| Sqllang.dll                                  | 2015.130.4474.0 | 39431344  | 24-Feb-2018 | 23:35 | x64      |
| Sqlmin.dll                                   | 2015.130.4474.0 | 37582512  | 24-Feb-2018 | 23:34 | x64      |
| Sqlolapss.dll                                | 2015.130.4474.0 | 97968     | 24-Feb-2018 | 23:35 | x64      |
| Sqlos.dll                                    | 2015.130.4474.0 | 26288     | 24-Feb-2018 | 23:35 | x64      |
| Sqlpowershellss.dll                          | 2015.130.4474.0 | 58544     | 24-Feb-2018 | 23:34 | x64      |
| Sqlrepss.dll                                 | 2015.130.4474.0 | 54960     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresld.dll                                 | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresourceloader.dll                        | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlscm.dll                                   | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4474.0 | 27824     | 24-Feb-2018 | 23:34 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4474.0 | 5798064   | 24-Feb-2018 | 23:35 | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4474.0 | 732848    | 24-Feb-2018 | 23:35 | x64      |
| Sqlservr.exe                                 | 2015.130.4474.0 | 392880    | 24-Feb-2018 | 23:35 | x64      |
| Sqlsvc.dll                                   | 2015.130.4474.0 | 152240    | 24-Feb-2018 | 23:34 | x64      |
| Sqltses.dll                                  | 2015.130.4474.0 | 8896688   | 24-Feb-2018 | 23:34 | x64      |
| Sqsrvres.dll                                 | 2015.130.4474.0 | 251056    | 24-Feb-2018 | 23:34 | x64      |
| Stretchcodegen.exe                           | 13.0.4474.0     | 55984     | 24-Feb-2018 | 23:37 | x86      |
| Xe.dll                                       | 2015.130.4474.0 | 626352    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                    | 2015.130.4474.0 | 319152    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrwbin.dll                                 | 2015.130.4474.0 | 227504    | 24-Feb-2018 | 23:35 | x64      |
| Xpadsi.exe                                   | 2015.130.4474.0 | 79024     | 24-Feb-2018 | 23:38 | x64      |
| Xplog70.dll                                  | 2015.130.4474.0 | 65712     | 24-Feb-2018 | 23:35 | x64      |
| Xpqueue.dll                                  | 2015.130.4474.0 | 74928     | 24-Feb-2018 | 23:34 | x64      |
| Xprepl.dll                                   | 2015.130.4474.0 | 91312     | 24-Feb-2018 | 23:34 | x64      |
| Xpsqlbot.dll                                 | 2015.130.4474.0 | 33456     | 24-Feb-2018 | 23:35 | x64      |
| Xpstar.dll                                   | 2015.130.4474.0 | 422576    | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4474.0 | 160424    | 24-Feb-2018 | 23:35 | x86      |
| Batchparser.dll                                                    | 2015.130.4474.0 | 180912    | 24-Feb-2018 | 23:35 | x64      |
| Bcp.exe                                                            | 2015.130.4474.0 | 119984    | 24-Feb-2018 | 23:35 | x64      |
| Commanddest.dll                                                    | 2015.130.4474.0 | 249008    | 24-Feb-2018 | 23:35 | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4474.0 | 115888    | 24-Feb-2018 | 23:35 | x64      |
| Datacollectortasks.dll                                             | 2015.130.4474.0 | 188080    | 24-Feb-2018 | 23:35 | x64      |
| Distrib.exe                                                        | 2015.130.4474.0 | 191152    | 24-Feb-2018 | 23:35 | x64      |
| Dteparse.dll                                                       | 2015.130.4474.0 | 109744    | 24-Feb-2018 | 23:35 | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:37 | x64      |
| Dtepkg.dll                                                         | 2015.130.4474.0 | 137392    | 24-Feb-2018 | 23:35 | x64      |
| Dtexec.exe                                                         | 2015.130.4474.0 | 72880     | 24-Feb-2018 | 23:35 | x64      |
| Dts.dll                                                            | 2015.130.4474.0 | 3146928   | 24-Feb-2018 | 23:35 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4474.0 | 477360    | 24-Feb-2018 | 23:35 | x64      |
| Dtsconn.dll                                                        | 2015.130.4474.0 | 492720    | 24-Feb-2018 | 23:35 | x64      |
| Dtshost.exe                                                        | 2015.130.4474.0 | 86704     | 24-Feb-2018 | 23:35 | x64      |
| Dtslog.dll                                                         | 2015.130.4474.0 | 120496    | 24-Feb-2018 | 23:35 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4474.0 | 545456    | 24-Feb-2018 | 23:35 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4474.0 | 1279152   | 24-Feb-2018 | 23:35 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4474.0 | 48304     | 24-Feb-2018 | 23:35 | x64      |
| Dtswizard.exe                                                      | 13.0.4474.0     | 895664    | 24-Feb-2018 | 23:37 | x64      |
| Dtuparse.dll                                                       | 2015.130.4474.0 | 87728     | 24-Feb-2018 | 23:35 | x64      |
| Dtutil.exe                                                         | 2015.130.4474.0 | 134832    | 24-Feb-2018 | 23:35 | x64      |
| Exceldest.dll                                                      | 2015.130.4474.0 | 263344    | 24-Feb-2018 | 23:35 | x64      |
| Excelsrc.dll                                                       | 2015.130.4474.0 | 285360    | 24-Feb-2018 | 23:35 | x64      |
| Execpackagetask.dll                                                | 2015.130.4474.0 | 166576    | 24-Feb-2018 | 23:35 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4474.0 | 389296    | 24-Feb-2018 | 23:35 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4474.0 | 401584    | 24-Feb-2018 | 23:35 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4474.0 | 96432     | 24-Feb-2018 | 23:35 | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4474.0 | 59056     | 24-Feb-2018 | 23:35 | x64      |
| Logread.exe                                                        | 2015.130.4474.0 | 617136    | 24-Feb-2018 | 23:35 | x64      |
| Mergetxt.dll                                                       | 2015.130.4474.0 | 53936     | 24-Feb-2018 | 23:35 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4474.0     | 1313456   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4474.0     | 696496    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4474.0     | 763568    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 24-Feb-2018 | 01:00  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4474.0     | 54448     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4474.0     | 89776     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4474.0     | 49840     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4474.0     | 43184     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4474.0     | 70832     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4474.0     | 35504     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4474.0     | 73392     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4474.0     | 63664     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4474.0     | 31408     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4474.0     | 131248    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4474.0     | 43696     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4474.0     | 57520     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4474.0     | 215216    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 22:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4474.0 | 1639088   | 24-Feb-2018 | 23:34 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4474.0 | 150192    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4474.0 | 158896    | 24-Feb-2018 | 23:36 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4474.0 | 101040    | 24-Feb-2018 | 23:35 | x64      |
| Msgprox.dll                                                        | 2015.130.4474.0 | 275632    | 24-Feb-2018 | 23:35 | x64      |
| Msxmlsql.dll                                                       | 2015.130.4474.0 | 1494704   | 24-Feb-2018 | 23:35 | x64      |
| Oledbdest.dll                                                      | 2015.130.4474.0 | 264368    | 24-Feb-2018 | 23:35 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4474.0 | 290992    | 24-Feb-2018 | 23:35 | x64      |
| Osql.exe                                                           | 2015.130.4474.0 | 75440     | 24-Feb-2018 | 23:35 | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4474.0 | 469168    | 24-Feb-2018 | 23:35 | x64      |
| Rawdest.dll                                                        | 2015.130.4474.0 | 209584    | 24-Feb-2018 | 23:35 | x64      |
| Rawsource.dll                                                      | 2015.130.4474.0 | 196784    | 24-Feb-2018 | 23:35 | x64      |
| Rdistcom.dll                                                       | 2015.130.4474.0 | 893616    | 24-Feb-2018 | 23:35 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4474.0 | 187056    | 24-Feb-2018 | 23:35 | x64      |
| Replagnt.dll                                                       | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:35 | x64      |
| Repldp.dll                                                         | 2015.130.4474.0 | 277168    | 24-Feb-2018 | 23:35 | x64      |
| Replerrx.dll                                                       | 2015.130.4474.0 | 144560    | 24-Feb-2018 | 23:35 | x64      |
| Replisapi.dll                                                      | 2015.130.4474.0 | 354480    | 24-Feb-2018 | 23:35 | x64      |
| Replmerg.exe                                                       | 2015.130.4474.0 | 518832    | 24-Feb-2018 | 23:35 | x64      |
| Replprov.dll                                                       | 2015.130.4474.0 | 812208    | 24-Feb-2018 | 23:35 | x64      |
| Replrec.dll                                                        | 2015.130.4474.0 | 1018544   | 24-Feb-2018 | 23:34 | x64      |
| Replsub.dll                                                        | 2015.130.4474.0 | 467632    | 24-Feb-2018 | 23:35 | x64      |
| Replsync.dll                                                       | 2015.130.4474.0 | 144048    | 24-Feb-2018 | 23:35 | x64      |
| Spresolv.dll                                                       | 2015.130.4474.0 | 245424    | 24-Feb-2018 | 23:35 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlcmd.exe                                                         | 2015.130.4474.0 | 249520    | 24-Feb-2018 | 23:35 | x64      |
| Sqldiag.exe                                                        | 2015.130.4474.0 | 1257648   | 24-Feb-2018 | 23:35 | x64      |
| Sqldistx.dll                                                       | 2015.130.4474.0 | 215728    | 24-Feb-2018 | 23:35 | x64      |
| Sqllogship.exe                                                     | 13.0.4474.0     | 100528    | 24-Feb-2018 | 23:37 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4474.0 | 346800    | 24-Feb-2018 | 23:34 | x64      |
| Sqlps.exe                                                          | 13.0.4474.0     | 60080     | 24-Feb-2018 | 23:36 | x86      |
| Sqlresld.dll                                                       | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresld.dll                                                       | 2015.130.4474.0 | 28848     | 24-Feb-2018 | 23:35 | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |
| Sqlscm.dll                                                         | 2015.130.4474.0 | 52912     | 24-Feb-2018 | 23:35 | x86      |
| Sqlscm.dll                                                         | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4474.0 | 152240    | 24-Feb-2018 | 23:34 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4474.0 | 127144    | 24-Feb-2018 | 23:35 | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4474.0 | 180912    | 24-Feb-2018 | 23:34 | x64      |
| Sqlwep130.dll                                                      | 2015.130.4474.0 | 105648    | 24-Feb-2018 | 23:34 | x64      |
| Ssdebugps.dll                                                      | 2015.130.4474.0 | 33456     | 24-Feb-2018 | 23:34 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4474.0 | 216240    | 24-Feb-2018 | 23:34 | x64      |
| Ssradd.dll                                                         | 2015.130.4474.0 | 65200     | 24-Feb-2018 | 23:34 | x64      |
| Ssravg.dll                                                         | 2015.130.4474.0 | 65200     | 24-Feb-2018 | 23:34 | x64      |
| Ssrdown.dll                                                        | 2015.130.4474.0 | 50864     | 24-Feb-2018 | 23:34 | x64      |
| Ssrmax.dll                                                         | 2015.130.4474.0 | 63664     | 24-Feb-2018 | 23:34 | x64      |
| Ssrmin.dll                                                         | 2015.130.4474.0 | 63664     | 24-Feb-2018 | 23:34 | x64      |
| Ssrpub.dll                                                         | 2015.130.4474.0 | 51376     | 24-Feb-2018 | 23:34 | x64      |
| Ssrup.dll                                                          | 2015.130.4474.0 | 50864     | 24-Feb-2018 | 23:34 | x64      |
| Txagg.dll                                                          | 2015.130.4474.0 | 364720    | 24-Feb-2018 | 23:34 | x64      |
| Txbdd.dll                                                          | 2015.130.4474.0 | 172720    | 24-Feb-2018 | 23:34 | x64      |
| Txdatacollector.dll                                                | 2015.130.4474.0 | 367792    | 24-Feb-2018 | 23:34 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4474.0 | 296624    | 24-Feb-2018 | 23:34 | x64      |
| Txderived.dll                                                      | 2015.130.4474.0 | 607920    | 24-Feb-2018 | 23:34 | x64      |
| Txlookup.dll                                                       | 2015.130.4474.0 | 532144    | 24-Feb-2018 | 23:34 | x64      |
| Txmerge.dll                                                        | 2015.130.4474.0 | 230064    | 24-Feb-2018 | 23:34 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4474.0 | 278704    | 24-Feb-2018 | 23:34 | x64      |
| Txmulticast.dll                                                    | 2015.130.4474.0 | 128176    | 24-Feb-2018 | 23:34 | x64      |
| Txrowcount.dll                                                     | 2015.130.4474.0 | 126640    | 24-Feb-2018 | 23:34 | x64      |
| Txsort.dll                                                         | 2015.130.4474.0 | 258736    | 24-Feb-2018 | 23:34 | x64      |
| Txsplit.dll                                                        | 2015.130.4474.0 | 600752    | 24-Feb-2018 | 23:34 | x64      |
| Txunionall.dll                                                     | 2015.130.4474.0 | 181936    | 24-Feb-2018 | 23:34 | x64      |
| Xe.dll                                                             | 2015.130.4474.0 | 626352    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                                          | 2015.130.4474.0 | 319152    | 24-Feb-2018 | 23:35 | x64      |
| Xmlsub.dll                                                         | 2015.130.4474.0 | 251056    | 24-Feb-2018 | 23:34 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.4474.0 | 1013936   | 24-Feb-2018 | 23:35 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlsatellite.dll              | 2015.130.4474.0 | 837296    | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.4474.0 | 660144    | 24-Feb-2018 | 23:35 | x64      |
| Fdhost.exe               | 2015.130.4474.0 | 105136    | 24-Feb-2018 | 23:35 | x64      |
| Fdlauncher.exe           | 2015.130.4474.0 | 51376     | 24-Feb-2018 | 23:35 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlft130ph.dll           | 2015.130.4474.0 | 58024     | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.4474.0     | 23728     | 24-Feb-2018 | 23:37 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 23-Feb-2018 | 23:05 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 24-Feb-2018 | 01:00  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 23-Feb-2018 | 23:05 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 24-Feb-2018 | 01:00  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 23-Feb-2018 | 23:05 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 24-Feb-2018 | 01:00  | x86      |
| Commanddest.dll                                                    | 2015.130.4474.0 | 249008    | 24-Feb-2018 | 23:35 | x64      |
| Commanddest.dll                                                    | 2015.130.4474.0 | 202928    | 24-Feb-2018 | 23:35 | x86      |
| Dteparse.dll                                                       | 2015.130.4474.0 | 109744    | 24-Feb-2018 | 23:35 | x64      |
| Dteparse.dll                                                       | 2015.130.4474.0 | 99504     | 24-Feb-2018 | 23:35 | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4474.0 | 83632     | 24-Feb-2018 | 23:36 | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:37 | x64      |
| Dtepkg.dll                                                         | 2015.130.4474.0 | 137392    | 24-Feb-2018 | 23:35 | x64      |
| Dtepkg.dll                                                         | 2015.130.4474.0 | 115888    | 24-Feb-2018 | 23:35 | x86      |
| Dtexec.exe                                                         | 2015.130.4474.0 | 72880     | 24-Feb-2018 | 23:35 | x64      |
| Dtexec.exe                                                         | 2015.130.4474.0 | 66736     | 24-Feb-2018 | 23:35 | x86      |
| Dts.dll                                                            | 2015.130.4474.0 | 3146928   | 24-Feb-2018 | 23:35 | x64      |
| Dts.dll                                                            | 2015.130.4474.0 | 2632880   | 24-Feb-2018 | 23:35 | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4474.0 | 477360    | 24-Feb-2018 | 23:35 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4474.0 | 418984    | 24-Feb-2018 | 23:35 | x86      |
| Dtsconn.dll                                                        | 2015.130.4474.0 | 492720    | 24-Feb-2018 | 23:35 | x64      |
| Dtsconn.dll                                                        | 2015.130.4474.0 | 392368    | 24-Feb-2018 | 23:35 | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4474.0 | 109744    | 24-Feb-2018 | 23:35 | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4474.0 | 93872     | 24-Feb-2018 | 23:35 | x86      |
| Dtshost.exe                                                        | 2015.130.4474.0 | 86704     | 24-Feb-2018 | 23:35 | x64      |
| Dtshost.exe                                                        | 2015.130.4474.0 | 76464     | 24-Feb-2018 | 23:35 | x86      |
| Dtslog.dll                                                         | 2015.130.4474.0 | 120496    | 24-Feb-2018 | 23:35 | x64      |
| Dtslog.dll                                                         | 2015.130.4474.0 | 103088    | 24-Feb-2018 | 23:35 | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4474.0 | 545456    | 24-Feb-2018 | 23:35 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4474.0 | 541360    | 24-Feb-2018 | 23:35 | x86      |
| Dtspipeline.dll                                                    | 2015.130.4474.0 | 1279152   | 24-Feb-2018 | 23:35 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4474.0 | 1059504   | 24-Feb-2018 | 23:35 | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4474.0 | 48304     | 24-Feb-2018 | 23:35 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4474.0 | 42160     | 24-Feb-2018 | 23:35 | x86      |
| Dtswizard.exe                                                      | 13.0.4474.0     | 896176    | 24-Feb-2018 | 23:28 | x86      |
| Dtswizard.exe                                                      | 13.0.4474.0     | 895664    | 24-Feb-2018 | 23:37 | x64      |
| Dtuparse.dll                                                       | 2015.130.4474.0 | 87728     | 24-Feb-2018 | 23:35 | x64      |
| Dtuparse.dll                                                       | 2015.130.4474.0 | 80048     | 24-Feb-2018 | 23:35 | x86      |
| Dtutil.exe                                                         | 2015.130.4474.0 | 134832    | 24-Feb-2018 | 23:35 | x64      |
| Dtutil.exe                                                         | 2015.130.4474.0 | 115376    | 24-Feb-2018 | 23:35 | x86      |
| Exceldest.dll                                                      | 2015.130.4474.0 | 263344    | 24-Feb-2018 | 23:35 | x64      |
| Exceldest.dll                                                      | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Excelsrc.dll                                                       | 2015.130.4474.0 | 285360    | 24-Feb-2018 | 23:35 | x64      |
| Excelsrc.dll                                                       | 2015.130.4474.0 | 232624    | 24-Feb-2018 | 23:35 | x86      |
| Execpackagetask.dll                                                | 2015.130.4474.0 | 166576    | 24-Feb-2018 | 23:35 | x64      |
| Execpackagetask.dll                                                | 2015.130.4474.0 | 135344    | 24-Feb-2018 | 23:35 | x86      |
| Flatfiledest.dll                                                   | 2015.130.4474.0 | 389296    | 24-Feb-2018 | 23:35 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4474.0 | 334512    | 24-Feb-2018 | 23:35 | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4474.0 | 401584    | 24-Feb-2018 | 23:35 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4474.0 | 345264    | 24-Feb-2018 | 23:35 | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4474.0 | 96432     | 24-Feb-2018 | 23:35 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4474.0 | 80560     | 24-Feb-2018 | 23:35 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4474.0     | 439984    | 24-Feb-2018 | 23:28 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4474.0     | 438960    | 24-Feb-2018 | 23:37 | x64      |
| Isserverexec.exe                                                   | 13.0.4474.0     | 132784    | 24-Feb-2018 | 23:28 | x86      |
| Isserverexec.exe                                                   | 13.0.4474.0     | 132272    | 24-Feb-2018 | 23:37 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4474.0     | 1313456   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4474.0     | 1313456   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4474.0     | 696496    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4474.0     | 696496    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4474.0     | 763568    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4474.0     | 763568    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 24-Feb-2018 | 01:00  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 24-Feb-2018 | 10:18 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4474.0     | 72368     | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4474.0 | 112304    | 24-Feb-2018 | 23:34 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4474.0 | 107184    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4474.0     | 54448     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4474.0     | 54448     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4474.0     | 89776     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4474.0     | 89776     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4474.0     | 43184     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4474.0     | 43184     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4474.0     | 35504     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4474.0     | 35504     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4474.0     | 73392     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4474.0     | 73392     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4474.0     | 31408     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4474.0     | 31408     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4474.0     | 469680    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4474.0     | 469680    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4474.0     | 43696     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4474.0     | 43696     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4474.0     | 57520     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4474.0     | 57520     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4474.0     | 52912     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4474.0     | 52912     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4474.0 | 150192    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4474.0 | 138928    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4474.0 | 158896    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4474.0 | 144560    | 24-Feb-2018 | 23:37 | x86      |
| Msdtssrvr.exe                                                      | 13.0.4474.0     | 216752    | 24-Feb-2018 | 23:37 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4474.0 | 89776     | 24-Feb-2018 | 23:35 | x86      |
| Msdtssrvrutil.dll                                                  | 2015.130.4474.0 | 101040    | 24-Feb-2018 | 23:35 | x64      |
| Msmdpp.dll                                                         | 2015.130.4474.0 | 7646896   | 24-Feb-2018 | 23:35 | x64      |
| Oledbdest.dll                                                      | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Oledbdest.dll                                                      | 2015.130.4474.0 | 264368    | 24-Feb-2018 | 23:35 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4474.0 | 235696    | 24-Feb-2018 | 23:35 | x86      |
| Oledbsrc.dll                                                       | 2015.130.4474.0 | 290992    | 24-Feb-2018 | 23:35 | x64      |
| Rawdest.dll                                                        | 2015.130.4474.0 | 168624    | 24-Feb-2018 | 23:35 | x86      |
| Rawdest.dll                                                        | 2015.130.4474.0 | 209584    | 24-Feb-2018 | 23:35 | x64      |
| Rawsource.dll                                                      | 2015.130.4474.0 | 155312    | 24-Feb-2018 | 23:35 | x86      |
| Rawsource.dll                                                      | 2015.130.4474.0 | 196784    | 24-Feb-2018 | 23:35 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4474.0 | 151728    | 24-Feb-2018 | 23:35 | x86      |
| Recordsetdest.dll                                                  | 2015.130.4474.0 | 187056    | 24-Feb-2018 | 23:35 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqlceip.exe                                                        | 13.0.4474.0     | 247984    | 24-Feb-2018 | 23:37 | x86      |
| Sqldest.dll                                                        | 2015.130.4474.0 | 215728    | 24-Feb-2018 | 23:35 | x86      |
| Sqldest.dll                                                        | 2015.130.4474.0 | 263856    | 24-Feb-2018 | 23:35 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4474.0 | 180912    | 24-Feb-2018 | 23:34 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4474.0 | 151216    | 24-Feb-2018 | 23:35 | x86      |
| Ssisoledb.dll                                                      | 2015.130.4474.0 | 216240    | 24-Feb-2018 | 23:34 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4474.0 | 176816    | 24-Feb-2018 | 23:35 | x86      |
| Txagg.dll                                                          | 2015.130.4474.0 | 364720    | 24-Feb-2018 | 23:34 | x64      |
| Txagg.dll                                                          | 2015.130.4474.0 | 304816    | 24-Feb-2018 | 23:36 | x86      |
| Txbdd.dll                                                          | 2015.130.4474.0 | 172720    | 24-Feb-2018 | 23:34 | x64      |
| Txbdd.dll                                                          | 2015.130.4474.0 | 137904    | 24-Feb-2018 | 23:36 | x86      |
| Txbestmatch.dll                                                    | 2015.130.4474.0 | 611504    | 24-Feb-2018 | 23:34 | x64      |
| Txbestmatch.dll                                                    | 2015.130.4474.0 | 496304    | 24-Feb-2018 | 23:36 | x86      |
| Txcache.dll                                                        | 2015.130.4474.0 | 183472    | 24-Feb-2018 | 23:34 | x64      |
| Txcache.dll                                                        | 2015.130.4474.0 | 148144    | 24-Feb-2018 | 23:36 | x86      |
| Txcharmap.dll                                                      | 2015.130.4474.0 | 289968    | 24-Feb-2018 | 23:34 | x64      |
| Txcharmap.dll                                                      | 2015.130.4474.0 | 250544    | 24-Feb-2018 | 23:36 | x86      |
| Txcopymap.dll                                                      | 2015.130.4474.0 | 182960    | 24-Feb-2018 | 23:34 | x64      |
| Txcopymap.dll                                                      | 2015.130.4474.0 | 147632    | 24-Feb-2018 | 23:36 | x86      |
| Txdataconvert.dll                                                  | 2015.130.4474.0 | 296624    | 24-Feb-2018 | 23:34 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4474.0 | 255152    | 24-Feb-2018 | 23:36 | x86      |
| Txderived.dll                                                      | 2015.130.4474.0 | 607920    | 24-Feb-2018 | 23:34 | x64      |
| Txderived.dll                                                      | 2015.130.4474.0 | 519344    | 24-Feb-2018 | 23:36 | x86      |
| Txfileextractor.dll                                                | 2015.130.4474.0 | 201896    | 24-Feb-2018 | 23:34 | x64      |
| Txfileextractor.dll                                                | 2015.130.4474.0 | 162992    | 24-Feb-2018 | 23:36 | x86      |
| Txfileinserter.dll                                                 | 2015.130.4474.0 | 199856    | 24-Feb-2018 | 23:34 | x64      |
| Txfileinserter.dll                                                 | 2015.130.4474.0 | 160944    | 24-Feb-2018 | 23:36 | x86      |
| Txgroupdups.dll                                                    | 2015.130.4474.0 | 290992    | 24-Feb-2018 | 23:34 | x64      |
| Txgroupdups.dll                                                    | 2015.130.4474.0 | 231600    | 24-Feb-2018 | 23:36 | x86      |
| Txlineage.dll                                                      | 2015.130.4474.0 | 137384    | 24-Feb-2018 | 23:34 | x64      |
| Txlineage.dll                                                      | 2015.130.4474.0 | 109232    | 24-Feb-2018 | 23:36 | x86      |
| Txlookup.dll                                                       | 2015.130.4474.0 | 532144    | 24-Feb-2018 | 23:34 | x64      |
| Txlookup.dll                                                       | 2015.130.4474.0 | 449712    | 24-Feb-2018 | 23:36 | x86      |
| Txmerge.dll                                                        | 2015.130.4474.0 | 230064    | 24-Feb-2018 | 23:34 | x64      |
| Txmerge.dll                                                        | 2015.130.4474.0 | 176304    | 24-Feb-2018 | 23:36 | x86      |
| Txmergejoin.dll                                                    | 2015.130.4474.0 | 278704    | 24-Feb-2018 | 23:34 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4474.0 | 223912    | 24-Feb-2018 | 23:36 | x86      |
| Txmulticast.dll                                                    | 2015.130.4474.0 | 128176    | 24-Feb-2018 | 23:34 | x64      |
| Txmulticast.dll                                                    | 2015.130.4474.0 | 102064    | 24-Feb-2018 | 23:36 | x86      |
| Txpivot.dll                                                        | 2015.130.4474.0 | 228016    | 24-Feb-2018 | 23:34 | x64      |
| Txpivot.dll                                                        | 2015.130.4474.0 | 181936    | 24-Feb-2018 | 23:36 | x86      |
| Txrowcount.dll                                                     | 2015.130.4474.0 | 126640    | 24-Feb-2018 | 23:34 | x64      |
| Txrowcount.dll                                                     | 2015.130.4474.0 | 101552    | 24-Feb-2018 | 23:36 | x86      |
| Txsampling.dll                                                     | 2015.130.4474.0 | 172208    | 24-Feb-2018 | 23:34 | x64      |
| Txsampling.dll                                                     | 2015.130.4474.0 | 134832    | 24-Feb-2018 | 23:36 | x86      |
| Txscd.dll                                                          | 2015.130.4474.0 | 220336    | 24-Feb-2018 | 23:34 | x64      |
| Txscd.dll                                                          | 2015.130.4474.0 | 169640    | 24-Feb-2018 | 23:36 | x86      |
| Txsort.dll                                                         | 2015.130.4474.0 | 258736    | 24-Feb-2018 | 23:34 | x64      |
| Txsort.dll                                                         | 2015.130.4474.0 | 210608    | 24-Feb-2018 | 23:36 | x86      |
| Txsplit.dll                                                        | 2015.130.4474.0 | 600752    | 24-Feb-2018 | 23:34 | x64      |
| Txsplit.dll                                                        | 2015.130.4474.0 | 513200    | 24-Feb-2018 | 23:36 | x86      |
| Txtermextraction.dll                                               | 2015.130.4474.0 | 8678064   | 24-Feb-2018 | 23:34 | x64      |
| Txtermextraction.dll                                               | 2015.130.4474.0 | 8615600   | 24-Feb-2018 | 23:36 | x86      |
| Txtermlookup.dll                                                   | 2015.130.4474.0 | 4158640   | 24-Feb-2018 | 23:34 | x64      |
| Txtermlookup.dll                                                   | 2015.130.4474.0 | 4106928   | 24-Feb-2018 | 23:36 | x86      |
| Txunionall.dll                                                     | 2015.130.4474.0 | 181936    | 24-Feb-2018 | 23:34 | x64      |
| Txunionall.dll                                                     | 2015.130.4474.0 | 138928    | 24-Feb-2018 | 23:36 | x86      |
| Txunpivot.dll                                                      | 2015.130.4474.0 | 201904    | 24-Feb-2018 | 23:34 | x64      |
| Txunpivot.dll                                                      | 2015.130.4474.0 | 162480    | 24-Feb-2018 | 23:36 | x86      |
| Xe.dll                                                             | 2015.130.4474.0 | 558768    | 24-Feb-2018 | 23:35 | x86      |
| Xe.dll                                                             | 2015.130.4474.0 | 626352    | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 00:09  | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 00:09  | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 00:09  | x86      |
| Instapi130.dll                                                       | 2015.130.4474.0  | 61104     | 24-Feb-2018 | 23:34 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.43     | 74416     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.43     | 201896    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.43     | 2347184   | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.43     | 102064    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.43     | 378544    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.43     | 185512    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.43     | 127144    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.43     | 63152     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.43     | 52400     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.43     | 87208     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.43     | 721584    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.43     | 87208     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.43     | 78000     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.43     | 41640     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.43     | 36528     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.43     | 47792     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.43     | 27304     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.43     | 32936     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.43     | 118952    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.43     | 94384     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.43     | 108208    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.43     | 256680    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 102056    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 118952    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 125608    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 117928    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 113328    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 145576    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 100016    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 114864    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.43     | 69296     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.43     | 28336     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.43     | 43696     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.43     | 82096     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.43     | 136872    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.43     | 2155688   | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.43     | 3818672   | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 107688    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119976    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 124592    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121008    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 133296    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121000    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 118448    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 152240    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 105136    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119472    | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.43     | 66736     | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.43     | 2756272   | 02-Feb-2018  | 00:09  | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.43     | 752296    | 02-Feb-2018  | 00:09  | x86      |
| Mpdwinterop.dll                                                      | 2015.130.4474.0  | 394416    | 24-Feb-2018 | 23:36 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4474.0  | 6614192   | 24-Feb-2018 | 23:38 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4474.0  | 2155184   | 24-Feb-2018 | 23:34 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 00:09  | x64      |
| Sqldk.dll                                                            | 2015.130.4474.0  | 2529968   | 24-Feb-2018 | 23:34 | x64      |
| Sqldumper.exe                                                        | 2015.130.4474.0  | 127152    | 24-Feb-2018 | 23:38 | x64      |
| Sqlos.dll                                                            | 2015.130.4474.0  | 26288     | 24-Feb-2018 | 23:34 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 00:09  | x64      |
| Sqltses.dll                                                          | 2015.130.4474.0  | 9064624   | 24-Feb-2018 | 23:34 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.4474.0     | 79024     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4474.0     | 210608    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4474.0     | 168624    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4474.0     | 1620144   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4474.0     | 657584    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4474.0     | 329904    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4474.0     | 1071792   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532136    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4474.0     | 532144    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4474.0     | 161968    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4474.0     | 76464     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4474.0     | 76464     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4474.0     | 126128    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4474.0     | 106160    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4474.0     | 5959344   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420272   | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4421296   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4421296   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4421296   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4421808   | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420264   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4474.0     | 4420784   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4474.0     | 10886320  | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4474.0     | 98992     | 24-Feb-2018 | 23:37 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4474.0     | 72880     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4474.0     | 5951664   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4474.0     | 245936    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4474.0     | 298160    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4474.0     | 208560    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 44720     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48808     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 52912     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 52912     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 44720     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4474.0     | 48816     | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4474.0     | 510640    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4474.0 | 47792     | 24-Feb-2018 | 23:34 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4474.0     | 496816    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4474.0 | 396976    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4474.0 | 391856    | 24-Feb-2018 | 23:36 | x86      |
| Msmdlocal.dll                                             | 2015.130.4474.0 | 37097648  | 24-Feb-2018 | 23:35 | x86      |
| Msmdlocal.dll                                             | 2015.130.4474.0 | 56205488  | 24-Feb-2018 | 23:35 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4474.0 | 7507120   | 24-Feb-2018 | 23:35 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4474.0 | 6507696   | 24-Feb-2018 | 23:37 | x86      |
| Msolap130.dll                                             | 2015.130.4474.0 | 7008432   | 24-Feb-2018 | 23:35 | x86      |
| Msolap130.dll                                             | 2015.130.4474.0 | 8639152   | 24-Feb-2018 | 23:35 | x64      |
| Msolui130.dll                                             | 2015.130.4474.0 | 287408    | 24-Feb-2018 | 23:35 | x86      |
| Msolui130.dll                                             | 2015.130.4474.0 | 310448    | 24-Feb-2018 | 23:35 | x64      |
| Reportingservicescompression.dll                          | 2015.130.4474.0 | 62640     | 24-Feb-2018 | 23:35 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4474.0     | 84656     | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4474.0     | 2543792   | 24-Feb-2018 | 23:35 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4474.0 | 108720    | 24-Feb-2018 | 23:35 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4474.0 | 114352    | 24-Feb-2018 | 23:35 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4474.0 | 98992     | 24-Feb-2018 | 23:35 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4474.0 | 2573488   | 24-Feb-2018 | 23:35 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4474.0     | 2709680   | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 868016    | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:36 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:37 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:37 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 876208    | 24-Feb-2018 | 23:36 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:36 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 880304    | 24-Feb-2018 | 23:36 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 868016    | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4474.0     | 872112    | 24-Feb-2018 | 23:36 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4474.0 | 3590832   | 24-Feb-2018 | 23:35 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4474.0 | 3663024   | 24-Feb-2018 | 23:35 | x64      |
| Rsconfigtool.exe                                          | 13.0.4474.0     | 1405616   | 24-Feb-2018 | 23:28 | x86      |
| Rsctr.dll                                                 | 2015.130.4474.0 | 51376     | 24-Feb-2018 | 23:35 | x86      |
| Rsctr.dll                                                 | 2015.130.4474.0 | 58544     | 24-Feb-2018 | 23:35 | x64      |
| Rshttpruntime.dll                                         | 2015.130.4474.0 | 99504     | 24-Feb-2018 | 23:35 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                                             | 2015.130.4474.0 | 127152    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                                             | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Sqlrsos.dll                                               | 2015.130.4474.0 | 26288     | 24-Feb-2018 | 23:34 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4474.0 | 584368    | 24-Feb-2018 | 23:35 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.4474.0 | 732848    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                                 | 2015.130.4474.0 | 319152    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                                 | 2015.130.4474.0 | 259760    | 24-Feb-2018 | 23:36 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4474.0 | 227504    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4474.0 | 191664    | 24-Feb-2018 | 23:36 | x86      |
| Xmsrv.dll                                                 | 2015.130.4474.0 | 24044720  | 24-Feb-2018 | 23:34 | x64      |
| Xmsrv.dll                                                 | 2015.130.4474.0 | 32720560  | 24-Feb-2018 |       |          |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.4474.0     | 23728     | 24-Feb-2018 | 23:35 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4474.0 | 1311920   | 24-Feb-2018 | 23:35 | x86      |
| Ddsshapes.dll                                   | 2015.130.4474.0 | 135856    | 24-Feb-2018 | 23:35 | x86      |
| Dtaengine.exe                                   | 2015.130.4474.0 | 167088    | 24-Feb-2018 | 23:35 | x86      |
| Dteparse.dll                                    | 2015.130.4474.0 | 109744    | 24-Feb-2018 | 23:35 | x64      |
| Dteparse.dll                                    | 2015.130.4474.0 | 99504     | 24-Feb-2018 | 23:35 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4474.0 | 83632     | 24-Feb-2018 | 23:36 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4474.0 | 88752     | 24-Feb-2018 | 23:37 | x64      |
| Dtepkg.dll                                      | 2015.130.4474.0 | 137392    | 24-Feb-2018 | 23:35 | x64      |
| Dtepkg.dll                                      | 2015.130.4474.0 | 115888    | 24-Feb-2018 | 23:35 | x86      |
| Dtexec.exe                                      | 2015.130.4474.0 | 72880     | 24-Feb-2018 | 23:35 | x64      |
| Dtexec.exe                                      | 2015.130.4474.0 | 66736     | 24-Feb-2018 | 23:35 | x86      |
| Dts.dll                                         | 2015.130.4474.0 | 3146928   | 24-Feb-2018 | 23:35 | x64      |
| Dts.dll                                         | 2015.130.4474.0 | 2632880   | 24-Feb-2018 | 23:35 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4474.0 | 477360    | 24-Feb-2018 | 23:35 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4474.0 | 418984    | 24-Feb-2018 | 23:35 | x86      |
| Dtsconn.dll                                     | 2015.130.4474.0 | 492720    | 24-Feb-2018 | 23:35 | x64      |
| Dtsconn.dll                                     | 2015.130.4474.0 | 392368    | 24-Feb-2018 | 23:35 | x86      |
| Dtshost.exe                                     | 2015.130.4474.0 | 86704     | 24-Feb-2018 | 23:35 | x64      |
| Dtshost.exe                                     | 2015.130.4474.0 | 76464     | 24-Feb-2018 | 23:35 | x86      |
| Dtslog.dll                                      | 2015.130.4474.0 | 120496    | 24-Feb-2018 | 23:35 | x64      |
| Dtslog.dll                                      | 2015.130.4474.0 | 103088    | 24-Feb-2018 | 23:35 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4474.0 | 545456    | 24-Feb-2018 | 23:35 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4474.0 | 541360    | 24-Feb-2018 | 23:35 | x86      |
| Dtspipeline.dll                                 | 2015.130.4474.0 | 1279152   | 24-Feb-2018 | 23:35 | x64      |
| Dtspipeline.dll                                 | 2015.130.4474.0 | 1059504   | 24-Feb-2018 | 23:35 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4474.0 | 48304     | 24-Feb-2018 | 23:35 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4474.0 | 42160     | 24-Feb-2018 | 23:35 | x86      |
| Dtswizard.exe                                   | 13.0.4474.0     | 896176    | 24-Feb-2018 | 23:28 | x86      |
| Dtswizard.exe                                   | 13.0.4474.0     | 895664    | 24-Feb-2018 | 23:37 | x64      |
| Dtuparse.dll                                    | 2015.130.4474.0 | 87728     | 24-Feb-2018 | 23:35 | x64      |
| Dtuparse.dll                                    | 2015.130.4474.0 | 80048     | 24-Feb-2018 | 23:35 | x86      |
| Dtutil.exe                                      | 2015.130.4474.0 | 134832    | 24-Feb-2018 | 23:35 | x64      |
| Dtutil.exe                                      | 2015.130.4474.0 | 115376    | 24-Feb-2018 | 23:35 | x86      |
| Exceldest.dll                                   | 2015.130.4474.0 | 263344    | 24-Feb-2018 | 23:35 | x64      |
| Exceldest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Excelsrc.dll                                    | 2015.130.4474.0 | 285360    | 24-Feb-2018 | 23:35 | x64      |
| Excelsrc.dll                                    | 2015.130.4474.0 | 232624    | 24-Feb-2018 | 23:35 | x86      |
| Flatfiledest.dll                                | 2015.130.4474.0 | 389296    | 24-Feb-2018 | 23:35 | x64      |
| Flatfiledest.dll                                | 2015.130.4474.0 | 334512    | 24-Feb-2018 | 23:35 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4474.0 | 401584    | 24-Feb-2018 | 23:35 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4474.0 | 345264    | 24-Feb-2018 | 23:35 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4474.0 | 96432     | 24-Feb-2018 | 23:35 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4474.0 | 80560     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4474.0     | 1313456   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4474.0     | 696496    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4474.0     | 763568    | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4474.0 | 2023088   | 24-Feb-2018 | 23:36 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4474.0 | 42160     | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4474.0     | 72368     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4474.0     | 186544    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4474.0     | 433840    | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4474.0     | 433840    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4474.0     | 2044592   | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4474.0     | 2044592   | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4474.0     | 33456     | 24-Feb-2018 | 23:34 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4474.0     | 33456     | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4474.0     | 249520    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4474.0     | 249520    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4474.0     | 501928    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:35 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4474.0     | 606384    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4474.0     | 106160    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4474.0 | 150192    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4474.0 | 138928    | 24-Feb-2018 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4474.0 | 158896    | 24-Feb-2018 | 23:36 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4474.0 | 144560    | 24-Feb-2018 | 23:37 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4474.0 | 89776     | 24-Feb-2018 | 23:35 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4474.0 | 101040    | 24-Feb-2018 | 23:35 | x64      |
| Msmdlocal.dll                                   | 2015.130.4474.0 | 37097648  | 24-Feb-2018 | 23:35 | x86      |
| Msmdlocal.dll                                   | 2015.130.4474.0 | 56205488  | 24-Feb-2018 | 23:35 | x64      |
| Msmdpp.dll                                      | 2015.130.4474.0 | 6370480   | 24-Feb-2018 | 23:35 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4474.0 | 7507120   | 24-Feb-2018 | 23:35 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4474.0 | 6507696   | 24-Feb-2018 | 23:37 | x86      |
| Msolap130.dll                                   | 2015.130.4474.0 | 7008432   | 24-Feb-2018 | 23:35 | x86      |
| Msolap130.dll                                   | 2015.130.4474.0 | 8639152   | 24-Feb-2018 | 23:35 | x64      |
| Msolui130.dll                                   | 2015.130.4474.0 | 287408    | 24-Feb-2018 | 23:35 | x86      |
| Msolui130.dll                                   | 2015.130.4474.0 | 310448    | 24-Feb-2018 | 23:35 | x64      |
| Oledbdest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-2018 | 23:35 | x86      |
| Oledbdest.dll                                   | 2015.130.4474.0 | 264368    | 24-Feb-2018 | 23:35 | x64      |
| Oledbsrc.dll                                    | 2015.130.4474.0 | 235696    | 24-Feb-2018 | 23:35 | x86      |
| Oledbsrc.dll                                    | 2015.130.4474.0 | 290992    | 24-Feb-2018 | 23:35 | x64      |
| Profiler.exe                                    | 2015.130.4474.0 | 804528    | 24-Feb-2018 | 23:28 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4474.0 | 100528    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                                   | 2015.130.4474.0 | 127152    | 24-Feb-2018 | 23:35 | x64      |
| Sqldumper.exe                                   | 2015.130.4474.0 | 107696    | 24-Feb-2018 | 23:35 | x86      |
| Sqlresld.dll                                    | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresld.dll                                    | 2015.130.4474.0 | 28848     | 24-Feb-2018 | 23:35 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4474.0 | 30896     | 24-Feb-2018 | 23:34 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4474.0 | 28336     | 24-Feb-2018 | 23:35 | x86      |
| Sqlscm.dll                                      | 2015.130.4474.0 | 52912     | 24-Feb-2018 | 23:35 | x86      |
| Sqlscm.dll                                      | 2015.130.4474.0 | 61104     | 24-Feb-2018 | 23:35 | x64      |
| Sqlsvc.dll                                      | 2015.130.4474.0 | 152240    | 24-Feb-2018 | 23:34 | x64      |
| Sqlsvc.dll                                      | 2015.130.4474.0 | 127144    | 24-Feb-2018 | 23:35 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4474.0 | 180912    | 24-Feb-2018 | 23:34 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4474.0 | 151216    | 24-Feb-2018 | 23:35 | x86      |
| Txdataconvert.dll                               | 2015.130.4474.0 | 296624    | 24-Feb-2018 | 23:34 | x64      |
| Txdataconvert.dll                               | 2015.130.4474.0 | 255152    | 24-Feb-2018 | 23:36 | x86      |
| Xe.dll                                          | 2015.130.4474.0 | 558768    | 24-Feb-2018 | 23:35 | x86      |
| Xe.dll                                          | 2015.130.4474.0 | 626352    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                       | 2015.130.4474.0 | 319152    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrw.dll                                       | 2015.130.4474.0 | 259760    | 24-Feb-2018 | 23:36 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4474.0 | 227504    | 24-Feb-2018 | 23:35 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4474.0 | 191664    | 24-Feb-2018 | 23:36 | x86      |
| Xmsrv.dll                                       | 2015.130.4474.0 | 24044720  | 24-Feb-2018 | 23:34 | x64      |
| Xmsrv.dll                                       | 2015.130.4474.0 | 32720560  | 24-Feb-2018 | 23:36 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
