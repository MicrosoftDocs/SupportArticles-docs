---
title: Cumulative update 1 for SQL Server 2016 SP1 (KB3208177)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 1 (KB3208177).
ms.date: 10/26/2023
ms.custom: KB3208177
appliesto:
- Microsoft SQL Server
---

# KB3208177 - Cumulative Update 1 for SQL Server 2016 SP1

_Release Date:_ &nbsp; January 18, 2017  
_Version:_ &nbsp; 13.0.4411.0

This article describes cumulative update package 1 (build number: **13.0.4411.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=8198025>[8198025](#8198025)</a> | [FIX: Access violation occurs when you run and then cancel a query on distinct count partitions in SSAS (KB3025408)](https://support.microsoft.com/help/3025408) | Analysis Services |
| <a id=8808992>[8808992](#8808992)</a> | [FIX: Processing a partition in SSAS 2016 drops all data from other partitions that are in the "incomplete" state (KB3209426)](https://support.microsoft.com/help/3209426) | Analysis Services |
| <a id=8986617>[8986617](#8986617)</a> | [FIX: SSAS stored connection strings become corrupted if extended properties are used incorrectly (KB3209520)](https://support.microsoft.com/help/3209520) | Analysis Services |
| <a id=9078847>[9078847](#9078847)</a> | [FIX: The SAMEPERIODLASTYEAR function doesn't work in DAX queries in SQL Server 2016 Analysis Services (KB3213709)](https://support.microsoft.com/help/3213709) | Analysis Services |
| <a id=9097248>[9097248](#9097248)</a> | [FIX: KPIs return a non-translated caption when an MDSCHEMA_MEASURES request is issued and the restrictions request hidden members (KB3198827)](https://support.microsoft.com/help/3198827) | Analysis Services |
| <a id=9097254>[9097254](#9097254)</a> | [FIX: MDX LastChild function returns incorrect result after ProcessUpdate a dimension in SSAS (KB3183686)](https://support.microsoft.com/help/3183686) | Analysis Services |
| <a id=9097256>[9097256](#9097256)</a> | [FIX: Can't cancel queries with SORT conditions on cells or measure values in SQL Server Analysis Services (KB3198826)](https://support.microsoft.com/help/3198826) | Analysis Services |
| <a id=9098040>[9098040](#9098040)</a> | [FIX: SSAS may crash on query execution if a predefined role is specified in the connection string (KB3212916)](https://support.microsoft.com/help/3212916) | Analysis Services |
| <a id=9099937>[9099937](#9099937)</a> | [FIX: Access violation when invalid credentials or connection string is specified in SQL Server 2016 Analysis Services (KB3208178)](https://support.microsoft.com/help/3208178) | Analysis Services |
| <a id=9100068>[9100068](#9100068)</a> | [FIX: Error occurs for queries on global measures that have previously been referenced by query scoped measures in SSAS 2016 tabular mode (KB3211605)](https://support.microsoft.com/help/3211605) | Analysis Services |
| <a id=9100261>[9100261](#9100261)</a> | [FIX: Error when you execute an MDX query on a Tabular model database in SQL Server 2016 Analysis Services (KB3198356)](https://support.microsoft.com/help/3198356) | Analysis Services |
| <a id=9098036>[9098036](#9098036)</a> | FIX: Credential settings are lost when you schedule data refresh for PowerPivot workbooks (KB3206912) | Analysis Services |
| <a id=9100139>[9100139](#9100139)</a> | FIX: SSAS may crash when a numeric calculated column must change its encoding scheme during the `ProcessRecalc` phase (KB3212541) | Analysis Services |
| <a id=8997069>[8997069](#8997069)</a> | [FIX: Error messages are logged if database mirroring is configured by Transact-SQL in SQL Server 2016 and no database activity occurs for more than 90 seconds (KB3210699)](https://support.microsoft.com/help/3210699) | High Availability |
| <a id=9126113>[9126113](#9126113)</a> | [FIX: DMV sys.dm_hadr_availability_replica_states returns an incorrect synchronization health state for a distributed availability group (KB3213288)](https://support.microsoft.com/help/3213288) | High Availability |
| <a id=9148639>[9148639](#9148639)</a> | [FIX: An Always On secondary replica goes into a disconnecting state (KB3213703)](https://support.microsoft.com/help/3213703) | High Availability |
| <a id=9076276>[9076276](#9076276)</a> | [FIX: Out of memory occurs when you use long Hekaton transactions in SQL Server 2016 (KB3206401)](https://support.microsoft.com/help/3206401) | In-Memory OLTP |
| <a id=9076281>[9076281](#9076281)</a> | [FIX: SQL Server runs out of memory when you query data from memory-optimized tables if Resource Governor is enabled (KB3209878)](https://support.microsoft.com/help/3209878) | In-Memory OLTP |
| <a id=8197984>[8197984](#8197984)</a> | [FIX: A valid derived column expression may fail in SSIS 2012, 2014 and 2016 (KB3164404)](https://support.microsoft.com/help/3164404) | Integration Services |
| <a id=8500828>[8500828](#8500828)</a> | [FIX: SQL Server 2016 Database Mail causes high CPU usage after many email messages are sent (KB3197879)](https://support.microsoft.com/help/3197879) | Management Tools |
| <a id=9012612>[9012612](#9012612)</a> | [FIX: Errors when you try to save MDS business rules in SQL Server 2016 (KB3210087)](https://support.microsoft.com/help/3210087) | Master Data Services (MDS) |
| <a id=9012711>[9012711](#9012711)</a> | [FIX: Can't save a business rule when the condition and action refer to different parent entities in SQL Server 2016 Master Data Services (KB3188151)](https://support.microsoft.com/help/3188151) | MDS |
| <a id=9133096>[9133096](#9133096)</a> | FIX: MDS business rule doesn't trigger on an attribute value change if the attribute belongs to a change tracking group (KB3213778) | MDS |
| <a id=8197975>[8197975](#8197975)</a> | [The file size of the PDF file generated by SSRS 2014 or 2016 is larger when compared to the earlier versions of SQL Server (KB3161403)](https://support.microsoft.com/help/3161403) | Reporting Services |
| <a id=8835366>[8835366](#8835366)</a> | [FIX: "Adjust height to fit zone" setting of the SSRS 2016 Report Viewer Web Part isn't respected on a SharePoint webpage (KB3211948)](https://support.microsoft.com/help/3211948) | Reporting Services |
| <a id=8981777>[8981777](#8981777)</a> | [FIX: Fail to view report with Edge or Chrome when you use a blank space parameter on SSRS 2016 (KB3211641)](https://support.microsoft.com/help/3211641) | Reporting Services |
| <a id=9049062>[9049062](#9049062)</a> | [FIX: List view layout of the SSRS 2016 web portal reverts to Tiles view layout in Google Chrome when the page is refreshed (KB3211990)](https://support.microsoft.com/help/3211990) | Reporting Services |
| <a id=9049360>[9049360](#9049360)</a> | [FIX: SQL Server 2016 Reporting Services mobile reports can't be rendered in your browser through Active Directory Application Proxy (KB3211991)](https://support.microsoft.com/help/3211991) | Reporting Services |
| <a id=9085786>[9085786](#9085786)</a> | [FIX: Text box is missing when the toggle action is enabled in SSRS 2016 (KB3213524)](https://support.microsoft.com/help/3213524) | Reporting Services |
| <a id=8668206>[8668206](#8668206)</a> | FIX: Parameter values aren't contained in the URL when the parameter is used multiple times in a drillthrough custom URL (KB3212252) | Reporting Services |
| <a id=9049060>[9049060](#9049060)</a> | FIX: Can't save a subscription when you browse to SSRS 2016 web portal by using Internet Explorer (KB3213496) | Reporting Services |
| <a id=9071649>[9071649](#9071649)</a> | FIX: KPIs bound to a dataset together with parameters aren't updated during cache refresh (KB3211220) | Reporting Services |
| <a id=8198028>[8198028](#8198028)</a> | [An error occurs when you use ODBC driver to retrieve sql_variant data in SQL Server 2014 or 2016 (KB3178526)](https://support.microsoft.com/help/3178526) | SQL connectivity |
| <a id=8918532>[8918532](#8918532)</a> | Enable out of row (offrow) insert for bcp invoked during replication process to fix problems when reinitializing replication configured with re-publisher. | SQL Engine |
| <a id=9071520>[9071520](#9071520)</a> | This fix allows customers to change service accounts of Polybase engine and Polybase data movement service without uninstalling the services. | SQL Engine |
| <a id=8198022>[8198022](#8198022)</a> | [Decrease in performance and "non-yielding scheduler" errors caused by unnecessary spinlocks in SQL Server (KB3175883)](https://support.microsoft.com/help/3175883) | SQL performance |
| <a id=8987408>[8987408](#8987408)</a> | FIX: Automatic update of statistics feature doesn't run after you truncate a table that has a clustered columnstore index (KB3210652) | SQL performance |
| <a id=8103261>[8103261](#8103261)</a> | [Update introduces CREATE OR ALTER Transact-SQL statement in SQL Server 2016 (KB3190548)](https://support.microsoft.com/help/3190548) | SQL service |
| <a id=8812307>[8812307](#8812307)</a> | [FIX: An assertion occurs when you bulk insert data into a table from multiple connections in SQL Server 2016 (KB3205964)](https://support.microsoft.com/help/3205964) | SQL service |
| <a id=8977749>[8977749](#8977749)</a> | [FIX: DMV sys.dm_os_spinlock_stats returns incorrect results after you install SQL Server 2016 RTM CU2 (KB3208460)](https://support.microsoft.com/help/3208460) | SQL service |
| <a id=8977751>[8977751](#8977751)</a> | [FIX: The Target Recovery Time of a database set to a nonzero value causes an assertion and a lease timeout in SQL Server 2014 or 2016 (KB3201865)](https://support.microsoft.com/help/3201865) | SQL service |
| <a id=8977752>[8977752](#8977752)</a> | [FIX: SQL Server crashes when you execute a spatial data query that has been compiled in SQL Server 2016 (KB3212789)](https://support.microsoft.com/help/3212789) | SQL service |
| <a id=8999706>[8999706](#8999706)</a> | [FIX: A dump file is generated when you enable system-versioning on a table in SQL Server 2016 (KB3210395)](https://support.microsoft.com/help/3210395) | SQL service |
| <a id=8999707>[8999707](#8999707)</a> | [FIX: An access violation occurs when you execute DBCC CHECKDB on a database in SQL Server 2016 (KB3212482)](https://support.microsoft.com/help/3212482) | SQL service |
| <a id=8999708>[8999708](#8999708)</a> | [FIX: Error when you create a stored procedure that uses a synonym together with an index hint in SQL Server 2016 (KB13213263)](https://support.microsoft.com/help/3213263) | SQL service |
| <a id=9000017>[9000017](#9000017)</a> | [FIX: A query that contains a hint against a view that references at least one temporal table in a different database can generate a dump file in SQL Server 2016 (KB3212723)](https://support.microsoft.com/help/3212723) | SQL service |
| <a id=9008442>[9008442](#9008442)</a> | [FIX: The "sys.dm_db_column_store_row_group_physical_stats" query runs slowly on SQL Server 2016 (KB3210747)](https://support.microsoft.com/help/3210747) | SQL service |
| <a id=9049063>[9049063](#9049063)</a> | [FIX: SQL Server crashes when you execute the OPENJSON function in a contained database in SQL Server 2016 (KB3210597)](https://support.microsoft.com/help/3210597) | SQL service |
| <a id=9056673>[9056673](#9056673)</a> | [FIX: Can't install SQL Server R Services during an offline installation of SQL Server 2016 updates (KB3210708)](https://support.microsoft.com/help/3210708) | SQL service |
| <a id=9069486>[9069486](#9069486)</a> | [FIX: Latch Contention may occur on execution of parallel queries on database that has Snapshot Isolation enabled in SQL Server 2016 (KB3211646)](https://support.microsoft.com/help/3211646) | SQL service |
| <a id=9069858>[9069858](#9069858)</a> | [FIX: Can't execute the DBCC CLONEDATABASE command on an instance of SQL Server 2016 SP1 after an in-place upgrade (KB3212214)](https://support.microsoft.com/help/3212214) | SQL service |
| <a id=9071302>[9071302](#9071302)</a> | [FIX: A memory leak occurs when SQL Server procedure cache consumes too much memory (KB3212523)](https://support.microsoft.com/help/3212523) | SQL service |
| <a id=9092558>[9092558](#9092558)</a> | [FIX: An assert error occurs when you insert data into a memory-optimized table that contains a clustered columnstore index in SQL Server 2016 (KB3211338)](https://support.microsoft.com/help/3211338) | SQL service |
| <a id=9128313>[9128313](#9128313)</a> | [FIX: Kernel crash when you create a database after you drop a database that contains FILESTEAM data in SQL Server 2016 (KB3213291)](https://support.microsoft.com/help/3213291) | SQL service |
| <a id=9136777>[9136777](#9136777)</a> | [FIX: Error 3628 when you create or rebuild a columnstore index in SQL Server 2016 (KB3213283)](https://support.microsoft.com/help/3213283) | SQL service |

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

> [!NOTE]
> After you apply this update, Database Mail does not work on computers that do not have the .NET Framework 3.5 installed. Microsoft is currently working on addressing this in a future cumulative update. See the following KB article for more information about affected builds and suggested workarounds:
>
> [FIX: SQL Server 2016 Database Mail does not work on a computer that does not have the .NET Framework 3.5 installed](https://support.microsoft.com/help/3186435)

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

SQL Server 2016 Browser Service

|        File name       |   File version  | File size |    Date   |  Time | Platform |
|:----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msmdsrv.rll            | 2015.130.4001.0 | 1296576   | 29-Oct-16 | 05:18 | x86      |
| Msmdsrvi.rll           | 2015.130.4001.0 | 1293512   | 29-Oct-16 | 05:18 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4001.0 | 88776     | 29-Oct-16 | 05:19 | x86      |

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.edition.dll      | 13.0.4411.0     | 37056     | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.instapi.dll      | 13.0.4411.0     | 46280     | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4411.0 | 72904     | 07-Jan-17 | 01:14 | x86      |
| Pbsvcacctsync.dll                    | 2015.130.4411.0 | 60104     | 07-Jan-17 | 01:13 | x86      |
| Sql_common_core_keyfile.dll          | 2015.130.4411.0 | 88776     | 07-Jan-17 | 01:15 | x86      |
| Sqlmgmprovider.dll                   | 2015.130.4411.0 | 364232    | 07-Jan-17 | 01:13 | x86      |
| Sqlsvcsync.dll                       | 2015.130.4411.0 | 267464    | 07-Jan-17 | 01:13 | x86      |
| Sqltdiagn.dll                        | 2015.130.4411.0 | 60616     | 07-Jan-17 | 01:13 | x86      |
| Svrenumapi130.dll                    | 2015.130.4411.0 | 854216    | 07-Jan-17 | 01:13 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4411.0  | 1876680   | 07-Jan-17 | 01:14 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4411.0 | 2023104   | 07-Jan-17 | 01:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4411.0     | 433864    | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4411.0     | 2044104   | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4411.0     | 33480     | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4411.0     | 249544    | 07-Jan-17 | 01:14 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4411.0 | 6507720   | 07-Jan-17 | 01:14 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4411.0 | 88776     | 07-Jan-17 | 01:15 | x86      |
| Xmsrv.dll                                      | 2015.130.4411.0 | 32715456  | 07-Jan-17 | 01:13 | x86      |

x64-based versions

SQL Server 2016 Browser Service

|   File name  |   File version  | File size |    Date   |  Time | Platform |
|:------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Keyfile.dll  | 2015.130.4001.0 | 88776     | 29-Oct-16 | 05:19 | x86      |
| Msmdsrv.rll  | 2015.130.4001.0 | 1296576   | 29-Oct-16 | 05:18 | x86      |
| Msmdsrvi.rll | 2015.130.4001.0 | 1293512   | 29-Oct-16 | 05:18 | x86      |

SQL Server 2016 Business Intelligence Development Studio

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlsqm_keyfile.dll | 2015.130.4001.0 | 100544    | 29-Oct-16 | 05:20 | x64      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlwriter_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |

SQL Server 2016 Analysis Services

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msmdsrv.exe        | 2015.130.4411.0 | 56699584  | 07-Jan-17 | 01:53 | x64      |
| Msmgdsrv.dll       | 2015.130.4411.0 | 7507144   | 07-Jan-17 | 01:14 | x64      |
| Msmgdsrv.dll       | 2015.130.4411.0 | 6507720   | 07-Jan-17 | 01:14 | x86      |
| Sql_as_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Sqlceip.exe        | 13.0.4411.0     | 246984    | 07-Jan-17 | 01:13 | x86      |
| Tmapi.dll          | 2015.130.4411.0 | 4346056   | 07-Jan-17 | 01:13 | x64      |
| Tmcachemgr.dll     | 2015.130.4411.0 | 2825928   | 07-Jan-17 | 01:13 | x64      |
| Tmpersistence.dll  | 2015.130.4411.0 | 1071304   | 07-Jan-17 | 01:13 | x64      |
| Tmtransactions.dll | 2015.130.4411.0 | 1351360   | 07-Jan-17 | 01:13 | x64      |
| Xmsrv.dll          | 2015.130.4411.0 | 32715456  | 07-Jan-17 | 01:13 | x86      |
| Xmsrv.dll          | 2015.130.4411.0 | 24038600  | 07-Jan-17 | 01:13 | x64      |

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.edition.dll      | 13.0.4411.0     | 37056     | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.instapi.dll      | 13.0.4411.0     | 46280     | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4411.0 | 72904     | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.130.4411.0 | 75456     | 07-Jan-17 | 01:53 | x64      |
| Pbsvcacctsync.dll                    | 2015.130.4411.0 | 60104     | 07-Jan-17 | 01:13 | x86      |
| Pbsvcacctsync.dll                    | 2015.130.4411.0 | 72904     | 07-Jan-17 | 01:15 | x64      |
| Sql_common_core_keyfile.dll          | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Sqlmgmprovider.dll                   | 2015.130.4411.0 | 404168    | 07-Jan-17 | 01:13 | x64      |
| Sqlmgmprovider.dll                   | 2015.130.4411.0 | 364232    | 07-Jan-17 | 01:13 | x86      |
| Sqlsvcsync.dll                       | 2015.130.4411.0 | 349384    | 07-Jan-17 | 01:13 | x64      |
| Sqlsvcsync.dll                       | 2015.130.4411.0 | 267464    | 07-Jan-17 | 01:13 | x86      |
| Sqltdiagn.dll                        | 2015.130.4411.0 | 67784     | 07-Jan-17 | 01:13 | x64      |
| Sqltdiagn.dll                        | 2015.130.4411.0 | 60616     | 07-Jan-17 | 01:13 | x86      |
| Svrenumapi130.dll                    | 2015.130.4411.0 | 1115848   | 07-Jan-17 | 01:13 | x64      |
| Svrenumapi130.dll                    | 2015.130.4411.0 | 854216    | 07-Jan-17 | 01:13 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4411.0  | 1876680   | 07-Jan-17 | 01:13 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4411.0  | 1876680   | 07-Jan-17 | 01:14 | x86      |

SQL Server 2016 Database Services Core Instance

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Databasemail.exe                 | 13.0.16100.4    | 29888     | 09-Dec-16 | 00:46 | x64      |
| Microsoft.sqlserver.types.dll    | 2015.130.4411.0 | 391872    | 07-Jan-17 | 01:53 | x86      |
| Qds.dll                          | 2015.130.4411.0 | 843976    | 07-Jan-17 | 01:15 | x64      |
| Sql_engine_core_inst_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Sqlaccess.dll                    | 2015.130.4411.0 | 461504    | 07-Jan-17 | 01:53 | x64      |
| Sqlagent.exe                     | 2015.130.4411.0 | 565952    | 07-Jan-17 | 01:53 | x64      |
| Sqlceip.exe                      | 13.0.4411.0     | 246984    | 07-Jan-17 | 01:13 | x86      |
| Sqldk.dll                        | 2015.130.4411.0 | 2585800   | 07-Jan-17 | 01:15 | x64      |
| Sqllang.dll                      | 2015.130.4411.0 | 39355592  | 07-Jan-17 | 01:15 | x64      |
| Sqlmin.dll                       | 2015.130.4411.0 | 37569224  | 07-Jan-17 | 01:13 | x64      |
| Sqlos.dll                        | 2015.130.4411.0 | 26304     | 07-Jan-17 | 01:51 | x64      |
| Sqlservr.exe                     | 2015.130.4411.0 | 392896    | 07-Jan-17 | 01:53 | x64      |
| Sqltses.dll                      | 2015.130.4411.0 | 8896712   | 07-Jan-17 | 01:13 | x64      |
| Stretchcodegen.exe               | 13.0.4411.0     | 56008     | 07-Jan-17 | 01:13 | x86      |

SQL Server 2016 Database Services Core Shared

|                            File name                            |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll | 13.0.4411.0     | 70856     | 07-Jan-17 | 01:13 | x86      |
| Sql_engine_core_shared_keyfile.dll                              | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4411.0 | 1015496   | 07-Jan-17 | 01:15 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Sqlsatellite.dll              | 2015.130.4411.0 | 837312    | 07-Jan-17 | 01:51 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sql_fulltext_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4411.0     | 23752     | 07-Jan-17 | 01:13 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |

SQL Server 2016 Integration Services

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msdtssrvr.exe      | 13.0.4411.0     | 216776    | 07-Jan-17 | 01:13 | x64      |
| Sql_is_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Sqlceip.exe        | 13.0.4411.0     | 246984    | 07-Jan-17 | 01:13 | x86      |

SQL Server 2016 Reporting Services

|                     File name                     |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.datarendering.dll     | 13.0.4411.0     | 166080    | 07-Jan-17 | 01:14 | x86      |
| Microsoft.reportingservices.diagnostics.dll       | 13.0.4411.0     | 1621184   | 07-Jan-17 | 01:14 | x86      |
| Microsoft.reportingservices.htmlrendering.dll     | 13.0.4411.0     | 1069768   | 07-Jan-17 | 01:14 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll | 13.0.4411.0     | 125128    | 07-Jan-17 | 01:14 | x86      |
| Microsoft.reportingservices.portal.services.dll   | 13.0.4411.0     | 4920000   | 07-Jan-17 | 01:14 | x86      |
| Microsoft.reportingservices.portal.web.dll        | 13.0.4411.0     | 10416328  | 07-Jan-17 | 01:14 | x86      |
| Microsoft.sqlserver.types.dll                     | 2015.130.4411.0 | 396992    | 07-Jan-17 | 01:52 | x86      |
| Microsoft.sqlserver.types.dll                     | 2015.130.4411.0 | 391872    | 07-Jan-17 | 01:53 | x86      |
| Msmgdsrv.dll                                      | 2015.130.4411.0 | 7507144   | 07-Jan-17 | 01:14 | x64      |
| Msmgdsrv.dll                                      | 2015.130.4411.0 | 6507720   | 07-Jan-17 | 01:14 | x86      |
| Reportingserviceslibrary.dll                      | 13.0.4411.0     | 2521792   | 07-Jan-17 | 01:14 | x86      |
| Reportingservicesnativeclient.dll                 | 2015.130.4411.0 | 114376    | 07-Jan-17 | 01:13 | x86      |
| Reportingservicesnativeclient.dll                 | 2015.130.4411.0 | 108744    | 07-Jan-17 | 01:14 | x64      |
| Reportingservicesnativeserver.dll                 | 2015.130.4411.0 | 99008     | 07-Jan-17 | 01:14 | x64      |
| Reportingserviceswebserver.dll                    | 13.0.4411.0     | 2706632   | 07-Jan-17 | 01:14 | x86      |
| Sql_rs_keyfile.dll                                | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Xmsrv.dll                                         | 2015.130.4411.0 | 32715456  | 07-Jan-17 | 01:13 | x86      |
| Xmsrv.dll                                         | 2015.130.4411.0 | 24038600  | 07-Jan-17 | 01:13 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4411.0     | 23752     | 07-Jan-17 | 01:14 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4411.0 | 2023104   | 07-Jan-17 | 01:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4411.0     | 433864    | 07-Jan-17 | 01:13 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4411.0     | 433864    | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4411.0     | 2044104   | 07-Jan-17 | 01:13 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4411.0     | 2044104   | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4411.0     | 33480     | 07-Jan-17 | 01:13 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4411.0     | 33480     | 07-Jan-17 | 01:15 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4411.0     | 249544    | 07-Jan-17 | 01:13 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4411.0     | 249544    | 07-Jan-17 | 01:14 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4411.0 | 7507144   | 07-Jan-17 | 01:14 | x64      |
| Msmgdsrv.dll                                   | 2015.130.4411.0 | 6507720   | 07-Jan-17 | 01:14 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4411.0 | 100552    | 07-Jan-17 | 01:15 | x64      |
| Xmsrv.dll                                      | 2015.130.4411.0 | 32715456  | 07-Jan-17 | 01:13 | x86      |
| Xmsrv.dll                                      | 2015.130.4411.0 | 24038600  | 07-Jan-17 | 01:13 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
