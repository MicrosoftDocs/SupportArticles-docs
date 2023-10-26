---
title: Cumulative update 4 for SQL Server 2016 SP1 (KB4024305)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 4 (KB4024305).
ms.date: 10/26/2023
ms.custom: KB4024305
appliesto:
- SQL Server 2016 Service Pack 1
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Developer
- SQL Server 2016 Standard
- SQL Server 2016 Enterprise
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4024305 - Cumulative Update 4 for SQL Server 2016 SP1

_Release Date:_ &nbsp; August 8, 2017  
_Version:_ &nbsp; 13.0.4446.0

Cumulative Update 4 (CU4) for Microsoft SQL Server 2016 Service Pack 1 (SP1) was also released as a SQL Server Security Bulletin on 8/8/2017, [KB4019095](https://support.microsoft.com/help/4019095). See [CVE-2017-8516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=cve-2017-8516) for more information. Because of this, you may already have CU4 installed as part of that security bulletin release and installation of this CU is unnecessary. If you do try to install CU4 after CVE-2017-8516, you may receive the following message:

> There are no SQL Server instances or shared features that can be updated on this computer

This indicates that CU4 is already installed and no further action is required.

> [!NOTE]
> The package name for CU4, "SQLServer2016SP1-KB4024305-<x86/x64>.exe", contains the CVE-2017-8516 KB number (4019095), not the CU4 KB number, (4024305). This can be ignored as a single package services both release channels.

This article describes cumulative update package 4 (build number: **13.0.4446.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=9876036>[9876036](#9876036)</a> | [FIX: Dimension security is ignored by Power BI Desktop in SQL Server Analysis Services (Multidimensional model) (KB4018908)](https://support.microsoft.com/help/4018908) | Analysis Services |
| <a id=10049124>[10049124](#10049124)</a> | [FIX: SQL Server Analysis Service proactive caching processes a partition but doesn't run an SQL query, causing stale data (KB4013585)](https://support.microsoft.com/help/4013585) | Analysis Services |
| <a id=10049128>[10049128](#10049128)</a> | [FIX: SSAS crashes when an MDX query that refers to parent-child dimensions runs in SQL Server 2014 or 2016 (KB4019603)](https://support.microsoft.com/help/4019603) | Analysis Services |
| <a id=10106167>[10106167](#10106167)</a> | [FIX: SSAS crashes when you access .vmp files in SQL Server 2016 (KB4024023)](https://support.microsoft.com/help/4024023) | Analysis Services |
| <a id=10162127>[10162127](#10162127)</a> | [FIX: It takes a long time to perform Process Update operations on SSAS databases in SQL Server 2016 (KB4024548)](https://support.microsoft.com/help/4024548) | Analysis Services |
| <a id=10296144>[10296144](#10296144)</a> | [FIX: Security Bulletin MS16-136 breaks the SSRS data source type in PowerPivot in SQL Server 2016 (KB4025402)](https://support.microsoft.com/help/4025402) | Analysis Services |
| <a id=10331381>[10331381](#10331381)</a> | [FIX: SSAS crashes when you run a DAX or MDX query in SSAS 2016 in Tabular mode (KB4032543)](https://support.microsoft.com/help/4032543) | Analysis Services |
| <a id=10017583>[10017583](#10017583)</a> | FIX: MDX query returns incorrect results if the table has a table attribute cross-join with the same attribute in a table hierarchy in SSAS 2016 (KB4022594) | Analysis Services |
| <a id=10052301>[10052301](#10052301)</a> | FIX: SSAS crashes when a measure is added that refers to null values in Power BI (KB4021994) | Analysis Services |
| <a id=10195260>[10195260](#10195260)</a> | FIX: SSAS crashes when a numeric calculated column must change its encoding scheme during the `ProcessRecalc` phase (KB3212541) | Analysis Services |
| <a id=10867554>[10867554](#10867554)</a> | FIX: Remote instance of SQL Server crashes while executing a stored procedure that bulk loads an incomplete data file into a temporary table (KB4043459) | Analysis Services |
| <a id=10087679>[10087679](#10087679)</a> | [FIX: Expanding the Entities folder on the Manage Groups page takes a long time in SQL Server 2016 MDS (KB4023865)](https://support.microsoft.com/help/4023865) | Data Quality Services (DQS) |
| <a id=10018470>[10018470](#10018470)</a> | [FIX: Databases on secondary replica show "NOT SYNCHRONIZING" status after failover in SQL Server 2016 (KB4024449)](https://support.microsoft.com/help/4024449) | High Availability |
| <a id=10029657>[10029657](#10029657)</a> | [FIX: Transaction log backup failure on the secondary replica in SQL Server Always-On Availability Groups (KB4017080)](https://support.microsoft.com/help/4017080) | High Availability |
| <a id=10029684>[10029684](#10029684)</a> | [FIX: A stored procedure may fail after an automatic failover occurs on a mirrored database in SQL Server (KB4018227)](https://support.microsoft.com/help/4018227) | High Availability |
| <a id=10200392>[10200392](#10200392)</a> | [FIX: "Non-yielding Scheduler" condition occurs when you change the BUCKET_COUNT value for large memory-optimized tables in Microsoft SQL Server 2016 (KB4024392)](https://support.microsoft.com/help/4024392) | In-Memory OLTP |
| <a id=10280055>[10280055](#10280055)</a> | [FIX: Memory leak occurs when you use memory-optimized tables in Microsoft SQL Server 2016 Standard edition (KB4025208)](https://support.microsoft.com/help/4025208) | In-Memory OLTP |
| <a id=10048666>[10048666](#10048666)</a> | [FIX: Deadlocks occur in SSISDB when you run multiple SSIS packages in SQL Server 2014 or 2016 (KB4016804)](https://support.microsoft.com/help/4016804) | Integration Services |
| <a id=9874233>[9874233](#9874233)</a> | [Cumulative Update 2 for SQL Server 2016 SP1 (KB4013106)](servicepack1-cumulativeupdate2.md) | Reporting Services |
| <a id=9879793>[9879793](#9879793)</a> | [FIX: SharePoint sites that contain the Report Viewer Web Part fail to load after you upgrade from SharePoint 2013 to 2016 in SSRS 2016 (KB4024715)](https://support.microsoft.com/help/4024715) | Reporting Services |
| <a id=9953962>[9953962](#9953962)</a> | [FIX: "Error occurred during rendering" when you export a report as a PowerPoint presentation in SQL Server 2016 Reporting Services (KB4019978)](https://support.microsoft.com/help/4019978) | Reporting Services |
| <a id=10022111>[10022111](#10022111)</a> | [FIX: Cast error when you open a local mode report in SharePoint Integrated mode in SSRS 2016 (KB4033178)](https://support.microsoft.com/help/4033178) | Reporting Services |
| <a id=10185322>[10185322](#10185322)</a> | [FIX: Blank spaces in the parameter area when you open SSRS report that contains Hidden or Internal parameters in SQL Server 2016 (KB4025021)](https://support.microsoft.com/help/4025021) | Reporting Services |
| <a id=10193902>[10193902](#10193902)</a> | [FIX: Search result isn't highlighted in SSRS 2016 report in SharePoint Integrated Mode (KB4032686)](https://support.microsoft.com/help/4032686) | Reporting Services |
| <a id=9991435>[9991435](#9991435)</a> | Fixes assertion (File: <"sharedxactstate.cpp">, line=480 Failed Assertion = 'pnasxal->FOwnedByXact()') during bulk insert of incorrect file. | SQL Engine |
| <a id=10018554>[10018554](#10018554)</a> | [FIX: Parallel query execution returns incorrect results for merge join operations in SQL Server 2016 (KB4022435)](https://support.microsoft.com/help/4022435) | SQL performance |
| <a id=10049113>[10049113](#10049113)</a> | [FIX: DMF sys.dm_db_incremental_stats_properties doesn't show all partitions if partitioning column is set to character or binary data type (KB4011477)](https://support.microsoft.com/help/4011477) | SQL performance |
| <a id=10067711>[10067711](#10067711)</a> | [FIX: SQL Server 2016 stops responding when the "Latch_Suspend_End" extended event is incorrectly triggered (KB4019446)](https://support.microsoft.com/help/4019446) | SQL performance |
| <a id=10107258>[10107258](#10107258)</a> | [FIX: Query with UNION ALL and a row goal may run slower in SQL Server 2014 or later versions when it's compared to SQL Server 2008 R2 (KB4023419)](https://support.microsoft.com/help/4023419) | SQL performance |
| <a id=10143390>[10143390](#10143390)</a> | [FIX: An access violation occurs when you update a partitioned table that contains PERSISTED computed columns in SQL Server 2016 (KB4024840)](https://support.microsoft.com/help/4024840) | SQL performance |
| <a id=9919215>[9919215](#9919215)</a> | [FIX: SUSER_SNAME function returns different results between SQL Server 2014 and SQL Server 2016 (KB4025020)](https://support.microsoft.com/help/4025020) | SQL security |
| <a id=10167609>[10167609](#10167609)</a> | [FIX: Data mask on a floating points column is removed unexpectedly in SQL Server 2016 (KB4023995)](https://support.microsoft.com/help/4023995) | SQL security |
| <a id=9704947>[9704947](#9704947)</a> | [Enhancement: New keyword added to CREATE and UPDATE STATISTICS statements to persist sampling rate for future statistics updates in SQL Server 2016 (KB4039284)](https://support.microsoft.com/help/4039284) | SQL service |
| <a id=9882162>[9882162](#9882162)</a> | [Update adds the "CLR strict security" feature to SQL Server 2016 (KB4018930)](https://support.microsoft.com/help/4018930) | SQL service |
| <a id=9983975>[9983975](#9983975)</a> | [FIX: System-generated stored procedures are created incorrectly in P2P publication if the schema name of published table contains a period (.) in SQL Server 2014 or 2016 (KB4021580)](https://support.microsoft.com/help/4021580) | SQL service |
| <a id=9995483>[9995483](#9995483)</a> | [FIX: "Incorrect syntax" error when you add a subscription by using the "sp_addpullsubscription_agent" stored procedure in SQL Server (KB4023138)](https://support.microsoft.com/help/4023138) | SQL Service |
| <a id=10015190>[10015190](#10015190)</a> | [FIX: Change Data Capture stops working after a recent cumulative update for SQL Server is installed (KB4038210)](https://support.microsoft.com/help/4038210) | SQL Service |
| <a id=10033530>[10033530](#10033530)</a> | [FIX: An access violation occurs when you create an index with page compression in SQL Server (KB4021405)](https://support.microsoft.com/help/4021405) | SQL service |
| <a id=10049134>[10049134](#10049134)</a> | [FIX: SQL Server 2014 or 2016 Backup to Microsoft Azure Blob storage service URL isn't compatible for TLS 1.2 (KB4017023)](https://support.microsoft.com/help/4017023) | SQL service |
| <a id=10067693>[10067693](#10067693)</a> | [FIX: Deadlock when you use sys.column_store_row_groups and sys.dm_db_column_store_row_group_physical_stats DMV with large DDL operations in SQL Server 2016 (KB4016946)](https://support.microsoft.com/help/4016946) | SQL service |
| <a id=10099394>[10099394](#10099394)</a> | [FIX: "FILESTREAM feature is disabled" error when you use the FILESTREAM feature for SQL Server 2014 or 2016 in Windows 10 Creators Update (KB4022873)](https://support.microsoft.com/help/4022873) | SQL service |
| <a id=10099394>[10099394](#10099394)</a> | [FIX: The FILESTREAM feature in SQL Server is disabled after you install Windows 10 Creators Update (KB4022874)](https://support.microsoft.com/help/4022874) | SQL service |
| <a id=10162582>[10162582](#10162582)</a> | [FIX: Assertion error occurs on the secondary replica when you resume a suspended availability database in SQL Server 2016 (KB4024393)](https://support.microsoft.com/help/4024393) | SQL service |
| <a id=10205059>[10205059](#10205059)</a> | [FIX: Couldn't truncate a partition of the partitioned table if it contains an extended or XML index in SQL Server 2016 (KB4024622)](https://support.microsoft.com/help/4024622) | SQL service |
| <a id=10242542>[10242542](#10242542)</a> | [FIX: Access violation with query to retrieve data from a clustered columnstore index in SQL Server 2014 or 2016 (KB4024184)](https://support.microsoft.com/help/4024184) | SQL service |
| <a id=10268790>[10268790](#10268790)</a> | [FIX: Restore fails when you do backup by using compression and checksum on a TDE-enabled database in SQL Server 2016 (KB4019893)](https://support.microsoft.com/help/4019893) | SQL service |
| <a id=10273869>[10273869](#10273869)</a> | [FIX: "EXCEPTION_INVALID_CRT_PARAMETER" error with BULK INSERT statement in SQL Server 2016 (KB4024989)](https://support.microsoft.com/help/4024989) | SQL service |
| <a id=10352073>[10352073](#10352073)</a> | [FIX: Fail to compress the backup file when INIT and COMPRESSION option is used in a TDE-enabled database in SQL Server 2016 (KB4032200)](https://support.microsoft.com/help/4032200) | SQL service |
| <a id=10375276>[10375276](#10375276)</a> | [FIX: Access violation occurs when you execute a query in SQL Server 2016 (KB4034056)](https://support.microsoft.com/help/4034056) | SQL service |
| <a id=9313605>[9313605](#9313605)</a> | FIX: Assertion failure when backing up large TDE encrypted database in SQL Server (KB4024868) | SQL service |
| <a id=10029671>[10029671](#10029671)</a> | [FIX: System Center Configuration Manager replication process by using BCP APIs fails when there's a large value in an XML column (KB4019125)](https://support.microsoft.com/help/4019125) | XML |

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

SQL Server 2016 Browser Service

|        File name       |   File version  | File size |    Date   |  Time | Platform |
|:----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msmdsrv.rll            | 2015.130.4446.0 | 1296576   | 17-Jul-17 | 04:52 | x86      |
| Msmdsrvi.rll           | 2015.130.4446.0 | 1293504   | 17-Jul-17 | 04:52 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4446.0 | 88768     | 17-Jul-17 | 04:52 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll         | 13.0.4446.0     | 1348288   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4446.0     | 702656    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4446.0     | 765632    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4446.0     | 520896    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4446.0     | 37056     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4446.0     | 46272     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4446.0 | 72896     | 17-Jul-17 | 04:53 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4446.0 | 60096     | 17-Jul-17 | 04:52 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4446.0 | 88768     | 17-Jul-17 | 04:52 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4446.0 | 364224    | 17-Jul-17 | 04:52 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4446.0 | 267456    | 17-Jul-17 | 04:52 | x86      |
| Sqltdiagn.dll                               | 2015.130.4446.0 | 60608     | 17-Jul-17 | 04:52 | x86      |
| Svrenumapi130.dll                           | 2015.130.4446.0 | 853696    | 17-Jul-17 | 04:52 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4446.0  | 1876672   | 17-Jul-17 | 04:53 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4446.0 | 2023104   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4446.0     | 433856    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4446.0     | 2044608   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4446.0     | 33472     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4446.0     | 249536    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.olapenum.dll               | 13.0.4446.0     | 106176    | 17-Jul-17 | 04:53 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4446.0 | 6507712   | 17-Jul-17 | 04:53 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4446.0 | 88768     | 17-Jul-17 | 04:52 | x86      |
| Xmsrv.dll                                      | 2015.130.4446.0 | 32717504  | 17-Jul-17 | 04:53 | x86      |

x64-based versions

SQL Server 2016 Browser Service

|   File name  |   File version  | File size |    Date   |  Time | Platform |
|:------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Keyfile.dll  | 2015.130.4446.0 | 88768     | 17-Jul-17 | 04:52 | x86      |
| Msmdsrv.rll  | 2015.130.4446.0 | 1296576   | 17-Jul-17 | 04:52 | x86      |
| Msmdsrvi.rll | 2015.130.4446.0 | 1293504   | 17-Jul-17 | 04:52 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlvdi.dll            | 2015.130.4446.0 | 197312    | 17-Jul-17 | 04:52 | x64      |
| Sqlvdi.dll            | 2015.130.4446.0 | 168640    | 17-Jul-17 | 04:52 | x86      |
| Sqlwriter_keyfile.dll | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll         | 13.0.4446.0     | 1347264   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4446.0     | 765632    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4446.0     | 521408    | 17-Jul-17 | 04:53 | x86      |
| Msmdsrv.exe                                        | 2015.130.4446.0 | 56728256  | 17-Jul-17 | 04:53 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4446.0 | 7507136   | 17-Jul-17 | 04:52 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4446.0 | 6507712   | 17-Jul-17 | 04:53 | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlceip.exe                                        | 13.0.4446.0     | 246976    | 17-Jul-17 | 05:04 | x86      |
| Tmapi.dll                                          | 2015.130.4446.0 | 4346048   | 17-Jul-17 | 04:52 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4446.0 | 2826432   | 17-Jul-17 | 04:52 | x64      |
| Tmpersistence.dll                                  | 2015.130.4446.0 | 1071296   | 17-Jul-17 | 04:52 | x64      |
| Tmtransactions.dll                                 | 2015.130.4446.0 | 1352384   | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                          | 2015.130.4446.0 | 24041152  | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                          | 2015.130.4446.0 | 32717504  | 17-Jul-17 | 04:53 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll         | 13.0.4446.0     | 1348288   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4446.0     | 702656    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4446.0     | 765632    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4446.0     | 520896    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4446.0     | 37056     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4446.0     | 46272     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4446.0 | 75456     | 17-Jul-17 | 04:52 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4446.0 | 72896     | 17-Jul-17 | 04:53 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4446.0 | 72896     | 17-Jul-17 | 04:52 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4446.0 | 60096     | 17-Jul-17 | 04:52 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4446.0 | 404160    | 17-Jul-17 | 04:52 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4446.0 | 364224    | 17-Jul-17 | 04:52 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4446.0 | 348864    | 17-Jul-17 | 04:52 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4446.0 | 267456    | 17-Jul-17 | 04:52 | x86      |
| Sqltdiagn.dll                               | 2015.130.4446.0 | 67776     | 17-Jul-17 | 04:52 | x64      |
| Sqltdiagn.dll                               | 2015.130.4446.0 | 60608     | 17-Jul-17 | 04:52 | x86      |
| Svrenumapi130.dll                           | 2015.130.4446.0 | 1115840   | 17-Jul-17 | 04:52 | x64      |
| Svrenumapi130.dll                           | 2015.130.4446.0 | 853696    | 17-Jul-17 | 04:52 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4446.0  | 1876672   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4446.0  | 1876672   | 17-Jul-17 | 04:53 | x86      |

SQL Server 2016 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                            | 13.0.4446.0     | 41152     | 17-Jul-17 | 04:53 | x64      |
| Databasemail.exe                           | 13.0.16100.4    | 29888     | 09-Dec-16 | 01:46 | x64      |
| Hkcompile.dll                              | 2015.130.4446.0 | 1297088   | 17-Jul-17 | 04:52 | x64      |
| Hkengine.dll                               | 2015.130.4446.0 | 5601472   | 17-Jul-17 | 04:55 | x64      |
| Hkruntime.dll                              | 2015.130.4446.0 | 158912    | 17-Jul-17 | 04:55 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 13.0.4446.0     | 232128    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll    | 13.0.4446.0     | 79552     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.types.dll              | 2015.130.4446.0 | 391872    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.vdiinterface.dll       | 2015.130.4446.0 | 71360     | 17-Jul-17 | 04:52 | x64      |
| Qds.dll                                    | 2015.130.4446.0 | 843968    | 17-Jul-17 | 04:52 | x64      |
| Rsfxft.dll                                 | 2015.130.4446.0 | 34496     | 17-Jul-17 | 04:52 | x64      |
| Sql_engine_core_inst_keyfile.dll           | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlaccess.dll                              | 2015.130.4446.0 | 462528    | 17-Jul-17 | 04:52 | x64      |
| Sqlagent.exe                               | 2015.130.4446.0 | 565952    | 17-Jul-17 | 04:53 | x64      |
| Sqlceip.exe                                | 13.0.4446.0     | 246976    | 17-Jul-17 | 05:04 | x86      |
| Sqldk.dll                                  | 2015.130.4446.0 | 2585792   | 17-Jul-17 | 04:52 | x64      |
| Sqllang.dll                                | 2015.130.4446.0 | 39386816  | 17-Jul-17 | 04:52 | x64      |
| Sqlmin.dll                                 | 2015.130.4446.0 | 37519552  | 17-Jul-17 | 04:52 | x64      |
| Sqlos.dll                                  | 2015.130.4446.0 | 26304     | 17-Jul-17 | 04:52 | x64      |
| Sqlscriptdowngrade.dll                     | 2015.130.4446.0 | 27840     | 17-Jul-17 | 04:52 | x64      |
| Sqlscriptupgrade.dll                       | 2015.130.4446.0 | 5797568   | 17-Jul-17 | 04:52 | x64      |
| Sqlservr.exe                               | 2015.130.4446.0 | 392896    | 17-Jul-17 | 04:53 | x64      |
| Sqltses.dll                                | 2015.130.4446.0 | 8896704   | 17-Jul-17 | 04:52 | x64      |
| Stretchcodegen.exe                         | 13.0.4446.0     | 56000     | 17-Jul-17 | 05:04 | x86      |
| Xpstar.dll                                 | 2015.130.4446.0 | 422592    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 Database Services Core Shared

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4446.0     | 70848     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4446.0     | 73408     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4446.0     | 63680     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4446.0     | 31424     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4446.0     | 131264    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4446.0     | 43712     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4446.0     | 57536     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4446.0     | 215232    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4446.0 | 1639104   | 17-Jul-17 | 04:52 | x64      |
| Spresolv.dll                                                       | 2015.130.4446.0 | 245440    | 17-Jul-17 | 04:52 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4446.0 | 346816    | 17-Jul-17 | 04:52 | x64      |
| Sqlps.exe                                                          | 13.0.4446.0     | 60096     | 17-Jul-17 | 04:52 | x86      |
| Sqlwep130.dll                                                      | 2015.130.4446.0 | 105664    | 17-Jul-17 | 04:52 | x64      |
| Ssradd.dll                                                         | 2015.130.4446.0 | 65216     | 17-Jul-17 | 04:52 | x64      |
| Ssravg.dll                                                         | 2015.130.4446.0 | 65216     | 17-Jul-17 | 04:52 | x64      |
| Ssrdown.dll                                                        | 2015.130.4446.0 | 50880     | 17-Jul-17 | 04:52 | x64      |
| Ssrmax.dll                                                         | 2015.130.4446.0 | 63680     | 17-Jul-17 | 04:52 | x64      |
| Ssrmin.dll                                                         | 2015.130.4446.0 | 63680     | 17-Jul-17 | 04:52 | x64      |
| Ssrpub.dll                                                         | 2015.130.4446.0 | 51392     | 17-Jul-17 | 04:52 | x64      |
| Ssrup.dll                                                          | 2015.130.4446.0 | 50880     | 17-Jul-17 | 04:52 | x64      |
| Txdatacollector.dll                                                | 2015.130.4446.0 | 367296    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4446.0 | 1013952   | 17-Jul-17 | 04:52 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlsatellite.dll              | 2015.130.4446.0 | 837312    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.130.4446.0 | 660160    | 17-Jul-17 | 04:52 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4446.0     | 23744     | 17-Jul-17 | 05:04 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 Integration Services

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.0         | 77936     | 15-Jul-17 | 09:21 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.0         | 77936     | 16-Jul-17 | 17:42 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.0         | 37488     | 15-Jul-17 | 09:21 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.0         | 37488     | 16-Jul-17 | 17:42 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.0         | 78448     | 15-Jul-17 | 09:21 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.0         | 78448     | 16-Jul-17 | 17:42 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4446.0     | 73408     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4446.0     | 73408     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4446.0     | 31424     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4446.0     | 31424     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4446.0     | 469696    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4446.0     | 469696    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4446.0     | 43712     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4446.0     | 43712     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4446.0     | 57536     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4446.0     | 57536     | 17-Jul-17 | 04:53 | x86      |
| Msdtssrvr.exe                                                      | 13.0.4446.0     | 216768    | 17-Jul-17 | 05:04 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Sqlceip.exe                                                        | 13.0.4446.0     | 246976    | 17-Jul-17 | 05:04 | x86      |

SQL Server 2016 Reporting Services

|                      File name                      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.datarendering.dll       | 13.0.4446.0     | 168640    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.diagnostics.dll         | 13.0.4446.0     | 1619648   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.excelrendering.dll      | 13.0.4446.0     | 657600    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll       | 13.0.4446.0     | 329920    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.htmlrendering.dll       | 13.0.4446.0     | 1070272   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.imagerendering.dll      | 13.0.4446.0     | 161984    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll   | 13.0.4446.0     | 126144    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll  | 13.0.4446.0     | 106176    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.portal.services.dll     | 13.0.4446.0     | 5959360   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.portal.web.dll          | 13.0.4446.0     | 10880192  | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.portal.webhost.exe      | 13.0.4446.0     | 97472     | 17-Jul-17 | 05:04 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll | 13.0.4446.0     | 72896     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.processingcore.dll      | 13.0.4446.0     | 5951168   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll   | 13.0.4446.0     | 245952    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.reportingservices.spbprocessing.dll       | 13.0.4446.0     | 298176    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.reportingservices.storage.dll             | 13.0.4446.0     | 208576    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 44736     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 52928     | 17-Jul-17 | 04:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 52928     | 17-Jul-17 | 04:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 44736     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll   | 13.0.4446.0     | 48832     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.reportingservices.upgradescripts.dll      | 13.0.4446.0     | 509120    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.types.dll                       | 2015.130.4446.0 | 391872    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.types.dll                       | 2015.130.4446.0 | 396992    | 17-Jul-17 | 04:52 | x86      |
| Msmgdsrv.dll                                        | 2015.130.4446.0 | 7507136   | 17-Jul-17 | 04:52 | x64      |
| Msmgdsrv.dll                                        | 2015.130.4446.0 | 6507712   | 17-Jul-17 | 04:53 | x86      |
| Reportingservicesemaildeliveryprovider.dll          | 13.0.4446.0     | 83648     | 17-Jul-17 | 04:52 | x86      |
| Reportingserviceslibrary.dll                        | 13.0.4446.0     | 2543296   | 17-Jul-17 | 04:52 | x86      |
| Reportingservicesnativeclient.dll                   | 2015.130.4446.0 | 108736    | 17-Jul-17 | 04:52 | x64      |
| Reportingservicesnativeclient.dll                   | 2015.130.4446.0 | 114368    | 17-Jul-17 | 04:53 | x86      |
| Reportingservicesnativeserver.dll                   | 2015.130.4446.0 | 99008     | 17-Jul-17 | 04:52 | x64      |
| Reportingserviceswebserver.dll                      | 13.0.4446.0     | 2708672   | 17-Jul-17 | 04:52 | x86      |
| Sql_rs_keyfile.dll                                  | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                           | 2015.130.4446.0 | 24041152  | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                           | 2015.130.4446.0 | 32717504  | 17-Jul-17 | 04:53 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4446.0     | 23744     | 17-Jul-17 | 04:52 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4446.0 | 2023104   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4446.0     | 433856    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4446.0     | 433856    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4446.0     | 2044608   | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4446.0     | 2044608   | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4446.0     | 33472     | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4446.0     | 33472     | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4446.0     | 249536    | 17-Jul-17 | 04:52 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4446.0     | 249536    | 17-Jul-17 | 04:53 | x86      |
| Microsoft.sqlserver.olapenum.dll               | 13.0.4446.0     | 106176    | 17-Jul-17 | 04:53 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4446.0 | 7507136   | 17-Jul-17 | 04:52 | x64      |
| Msmgdsrv.dll                                   | 2015.130.4446.0 | 6507712   | 17-Jul-17 | 04:53 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4446.0 | 100544    | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                      | 2015.130.4446.0 | 24041152  | 17-Jul-17 | 04:52 | x64      |
| Xmsrv.dll                                      | 2015.130.4446.0 | 32717504  | 17-Jul-17 | 04:53 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
