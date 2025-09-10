---
title: Cumulative update 4 for SQL Server 2016 (KB3205052)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 4 (KB3205052).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB3205052
appliesto:
- Microsoft SQL Server
---

# KB3205052 - Cumulative Update 4 for SQL Server 2016

_Release Date:_ &nbsp; January 18, 2017  
_Version:_ &nbsp; 13.0.2193.0

This article describes cumulative update package 4 (build number: **13.0.2193.0**) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=8524774>[8524774](#8524774)</a> | [FIX: SSAS may crash on query execution if a predefined role is specified in the connection string (KB3212916)](https://support.microsoft.com/help/3212916) | Analysis Services |
| <a id=8624205>[8624205](#8624205)</a> | [FIX: Error when you execute an MDX query on a Tabular model database in SQL Server 2016 Analysis Services (KB3198356)](https://support.microsoft.com/help/3198356) | Analysis Services |
| <a id=8850767>[8850767](#8850767)</a> | [FIX: MDX LastChild function returns incorrect result after ProcessUpdate a dimension in SSAS (KB3183686)](https://support.microsoft.com/help/3183686) | Analysis Services |
| <a id=8850834>[8850834](#8850834)</a> | [FIX: KPIs return a non-translated caption when an MDSCHEMA_MEASURES request is issued and the restrictions request hidden members (KB3198827)](https://support.microsoft.com/help/3198827) | Analysis Services |
| <a id=8850837>[8850837](#8850837)</a> | [FIX: Can't cancel queries with SORT conditions on cells or measure values in SQL Server Analysis Services (KB3198826)](https://support.microsoft.com/help/3198826) | Analysis Services |
| <a id=8957770>[8957770](#8957770)</a> | [FIX: Error for queries on global measures that have previously been referenced by query-scoped measures in SSAS 2016 (KB3211605)](https://support.microsoft.com/help/3211605) | Analysis Services |
| <a id=8959045>[8959045](#8959045)</a> | [FIX: Access violation when invalid credentials or connection string is specified in SQL Server 2016 Analysis Services (KB3208178)](https://support.microsoft.com/help/3208178) | Analysis Services |
| <a id=8985893>[8985893](#8985893)</a> | [FIX: Processing a partition in SSAS 2016 drops all data from other partitions that are in the "incomplete" state (KB3209426)](https://support.microsoft.com/help/3209426) | Analysis Services |
| <a id=8986624>[8986624](#8986624)</a> | [FIX: SSAS stored connection strings become corrupted if extended properties are used incorrectly (KB3209520)](https://support.microsoft.com/help/3209520) | Analysis Services |
| <a id=8924163>[8924163](#8924163)</a> | FIX: Credential settings are lost when you schedule data refresh for PowerPivot workbooks (KB3206912) | Analysis Services |
| <a id=8958832>[8958832](#8958832)</a> | FIX: SSAS may crash when a numeric calculated column must change its encoding scheme during the `ProcessRecalc` phase (KB3212541) | Analysis Services |
| <a id=8800213>[8800213](#8800213)</a> | [FIX: Error messages are logged if database mirroring is configured by Transact-SQL in SQL Server 2016 and no database activity occurs for more than 90 seconds (KB3210699)](https://support.microsoft.com/help/3210699) | High Availability |
| <a id=8850790>[8850790](#8850790)</a> | [FIX: Queries that run against secondary databases always get recompiled in SQL Server (KB3181444)](https://support.microsoft.com/help/3181444) | High Availability |
| <a id=8960940>[8960940](#8960940)</a> | [FIX: No automatic failover after database mirroring stops unexpectedly in SQL Server (KB3177238)](https://support.microsoft.com/help/3177238) | High Availability |
| <a id=9126111>[9126111](#9126111)</a> | [FIX: DMV sys.dm_hadr_availability_replica_states returns an incorrect synchronization health state for a distributed availability group (KB3213288)](https://support.microsoft.com/help/3213288) | High Availability |
| <a id=8771518>[8771518](#8771518)</a> | [FIX: Checkpoint files grow excessively when you insert data into memory-optimized tables in SQL Server 2016 (KB3206584)](https://support.microsoft.com/help/3206584) | In-Memory OLTP |
| <a id=8918531>[8918531](#8918531)</a> | [FIX: Out of memory occurs when you use long Hekaton transactions in SQL Server 2016 (KB3206401)](https://support.microsoft.com/help/3206401) | In-Memory OLTP |
| <a id=9008430>[9008430](#9008430)</a> | [FIX: SQL Server runs out of memory when you query data from memory-optimized tables if Resource Governor is enabled (KB3209878)](https://support.microsoft.com/help/3209878) | In-Memory OLTP |
| <a id=8850774>[8850774](#8850774)</a> | [FIX: "The process cannot access the file" error when an XML task fails in SQL Server (KB3115741)](https://support.microsoft.com/help/3115741) | Integration Services |
| <a id=8058952>[8058952](#8058952)</a> | [FIX: "No Data Available" in the SQL Server Memory Usage page in the SQL Server MDM report (KB3209442)](https://support.microsoft.com/help/3209442) | Management Tools |
| <a id=8500831>[8500831](#8500831)</a> | [FIX: SQL Server 2016 Database Mail causes high CPU usage after many email messages are sent (KB3197879)](https://support.microsoft.com/help/3197879) | Management Tools |
| <a id=8531160>[8531160](#8531160)</a> | [FIX: Snapshot Agent fails when you publish UDF's to SQL Server 2016 Distributor in Transactional Replication (KB3197883)](https://support.microsoft.com/help/3197883) | Management Tools |
| <a id=8532767>[8532767](#8532767)</a> | [FIX: You can't run a data cleanse against a view in SQL Server 2016 Data Quality Services (KB3212227)](https://support.microsoft.com/help/3212227) | Master Data Services (MDS) |
| <a id=8960943>[8960943](#8960943)</a> | [FIX: MDS business rule doesn't work if the Code value contains a leading space in SQL Server MDS Add-in for Excel (KB3198261)](https://support.microsoft.com/help/3198261) | MDS |
| <a id=8840639>[8840639](#8840639)</a> | [FIX: Image maps in an SSRS custom report item aren't rendered as expected (KB3204265)](https://support.microsoft.com/help/3204265) | Reporting Services |
| <a id=8850799>[8850799](#8850799)</a> | [Can't export a report as an Excel workbook when the "Interpret HTML Tags as Styles" option is selected (KB3180980)](https://support.microsoft.com/help/3180980) | Reporting Services |
| <a id=8850862>[8850862](#8850862)</a> | [FIX: Error when you open Data Alert Manager in SQL Server 2014 or 2016 Reporting Services in SharePoint integrated mode (KB3197950)](https://support.microsoft.com/help/3197950) | Reporting Services |
| <a id=8850851>[8850851](#8850851)</a> | Fixes SQL Native client 11 failures connecting to connect mirror named instance without UDP. | SQL Connectivity |
| <a id=9000069>[9000069](#9000069)</a> | This fix allows customers to change service accounts of Polybase engine and Polybase data movement service without uninstalling the services. | SQL Engine |
| <a id=8798949>[8798949](#8798949)</a> | [Improvement: Improves the query performance for SQL Server 2016 by changing the use of histograms on UNIQUE columns (KB3202425)](https://support.microsoft.com/help/3202425) | SQL performance |
| <a id=8782518>[8782518](#8782518)</a> | [FIX: Can't insert data into a table that uses a clustered columnstore index in SQL Server 2016 (KB3211602)](https://support.microsoft.com/help/3211602) | SQL performance |
| <a id=8845918>[8845918](#8845918)</a> | [Statistics are removed after rebuilding a specific partition of a partitioned aligned index on a partitioned table in SQL Server (KB3194959)](https://support.microsoft.com/help/3194959) | SQL performance |
| <a id=8846115>[8846115](#8846115)</a> | [FIX: Deadlock when you execute a query plan with a nested loop join in batch mode in SQL Server 2014 or 2016 (KB3195825)](https://support.microsoft.com/help/3195825) | SQL performance |
| <a id=8850831>[8850831](#8850831)</a> | [FIX: Rebuilding a nonclustered index to add columns by using CREATE INDEX with DROP_EXISTING=ON and ONLINE=ON causes blocking (KB3194365)](https://support.microsoft.com/help/3194365) | SQL performance |
| <a id=9011162>[9011162](#9011162)</a> | [FIX: Unable to rebuild the partition online for a table that contains a computed partitioning column in SQL Server 2016 (KB3213683)](https://support.microsoft.com/help/3213683) | SQL performance |
| <a id=8850821>[8850821](#8850821)</a> | [FIX: TDE encrypted Databases go in suspect state during the recovery phase when you restart SQL Server (KB3197631)](https://support.microsoft.com/help/3197631) | SQL security |
| <a id=8850805>[8850805](#8850805)</a> | [Improvement: Enhance VDI Protocol with VDC_Complete command in SQL Server (KB3188454)](https://support.microsoft.com/help/3188454) | SQL service |
| <a id=8492061>[8492061](#8492061)</a> | [FIX: Incorrect full-text keys are recorded for the rows that aren't indexed correctly by a full-text index in SQL Server (KB3196012)](https://support.microsoft.com/help/3196012) | SQL service |
| <a id=8683711>[8683711](#8683711)</a> | [FIX: "Non-yielding Scheduler" condition when you parallel-load data into a columnstore index in SQL Server 2016 (KB3205411)](https://support.microsoft.com/help/3205411) | SQL service |
| <a id=8788034>[8788034](#8788034)</a> | [FIX: The Target Recovery Time of a database set to a nonzero value causes an assertion and a lease timeout in SQL Server (KB3201865)](https://support.microsoft.com/help/3201865) | SQL service |
| <a id=8812302>[8812302](#8812302)</a> | [FIX: An assertion occurs when you bulk insert data into a table from multiple connections in SQL Server 2016 (KB3205964)](https://support.microsoft.com/help/3205964) | SQL service |
| <a id=8845916>[8845916](#8845916)</a> | [FIX: FileTable directory stops responding when you create multiple files concurrently in SQL Server 2014 or 2016 (KB3191062)](https://support.microsoft.com/help/3191062) | SQL service |
| <a id=8846114>[8846114](#8846114)</a> | [SQL Server crashes with an access violation when you use the TRY…CATCH construct for bulk copy (KB3184099)](https://support.microsoft.com/help/3184099) | SQL service |
| <a id=8888809>[8888809](#8888809)</a> | ["A digitally signed driver is required" warning when you install SQL Server packages in Windows Server 2016 and Windows 10 (KB3203693)](https://support.microsoft.com/help/3203693) | SQL service |
| <a id=8931649>[8931649](#8931649)</a> | [FIX: A dump file is generated when you enable system-versioning on a table in SQL Server 2016 (KB3210395)](https://support.microsoft.com/help/3210395) | SQL service |
| <a id=8931650>[8931650](#8931650)</a> | [FIX: An access violation occurs when you execute DBCC CHECKDB on a database in SQL Server 2016 (KB3212482)](https://support.microsoft.com/help/3212482) | SQL service |
| <a id=8956283>[8956283](#8956283)</a> | [FIX: Out-of-memory errors when you execute DBCC CHECKDB on database that contains columnstore indexes in SQL Server 2016 (KB3201416)](https://support.microsoft.com/help/3201416) | SQL service |
| <a id=8965128>[8965128](#8965128)</a> | [FIX: SQL Server crashes when you execute a spatial data query that has been compiled in SQL Server 2016 (KB3212789)](https://support.microsoft.com/help/3212789) | SQL service |
| <a id=8980766>[8980766](#8980766)</a> | [FIX: Error when you create a stored procedure that uses a synonym together with an index hint in SQL Server 2016 (KB3213263)](https://support.microsoft.com/help/3213263) | SQL service |
| <a id=8980767>[8980767](#8980767)</a> | [FIX: SQL Server crashes when you execute the OPENJSON function in a contained database in SQL Server 2016 (KB3210597)](https://support.microsoft.com/help/3210597) | SQL service |
| <a id=9000014>[9000014](#9000014)</a> | [FIX: A query that contains a hint against a view that references at least one temporal table in a different database can generate a dump file in SQL Server 2016 (KB3212723)](https://support.microsoft.com/help/3212723) | SQL service |
| <a id=9056654>[9056654](#9056654)</a> | [FIX: Can't install SQL Server R Services during an offline installation of SQL Server 2016 updates (KB3210708)](https://support.microsoft.com/help/3210708) | SQL service |
| <a id=9071152>[9071152](#9071152)</a> | [FIX: A memory leak occurs when SQL Server procedure cache consumes too much memory (KB3212523)](https://support.microsoft.com/help/3212523) | SQL service |
| <a id=9075248>[9075248](#9075248)</a> | [FIX: Latch Contention may occur on execution of parallel queries on database that has Snapshot Isolation enabled in SQL Server 2016 (KB3211646)](https://support.microsoft.com/help/3211646) | SQL service |
| <a id=9077497>[9077497](#9077497)</a> | [FIX: An assert error occurs when you insert data into a memory-optimized table that contains a clustered columnstore index in SQL Server 2016 (KB3211338)](https://support.microsoft.com/help/3211338) | SQL service |
| <a id=9129803>[9129803](#9129803)</a> | [FIX: Kernel crash when you create a database after you drop a database that contains FILESTEAM data in SQL Server 2016 (KB3213291)](https://support.microsoft.com/help/3213291) | SQL service |
| <a id=9136765>[9136765](#9136765)</a> | [FIX: Error 3628 when you create or rebuild a columnstore index in SQL Server 2016 (KB3213283)](https://support.microsoft.com/help/3213283) | SQL service |
| <a id=8960949>[8960949](#8960949)</a> | FIX: `DBCC CHECKFILEGROUP` reports false inconsistency error 5283 on a database that contains a partitioned table in SQL Server (KB3108537) | SQL service |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

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

To apply this cumulative update package, you must be running SQL Server 2016.

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

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2193.0     | 1023168   | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2193.0     | 1344192   | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2193.0     | 702656    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2193.0     | 765632    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2193.0     | 707264    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2193.0     | 37064     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2193.0     | 46280     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2193.0 | 72904     | 06-Jan-17 | 23:30 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2193.0 | 60104     | 06-Jan-17 | 23:30 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2193.0 | 88776     | 06-Jan-17 | 23:31 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2193.0 | 364224    | 06-Jan-17 | 23:30 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2193.0 | 267464    | 06-Jan-17 | 23:30 | x86      |
| Sqltdiagn.dll                              | 2015.130.2193.0 | 60616     | 06-Jan-17 | 23:30 | x86      |
| Svrenumapi130.dll                          | 2015.130.2193.0 | 854216    | 06-Jan-17 | 23:30 | x86      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2193.0  | 473280    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2193.0  | 1876672   | 07-Jan-17 | 00:49 | x86      |

SQL Server 2016 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2193.0 | 2631872   | 06-Jan-17 | 23:31 | x86      |
| Dtspipeline.dll                                              | 2015.130.2193.0 | 1059528   | 06-Jan-17 | 23:31 | x86      |
| Dtswizard.exe                                                | 13.0.2193.0     | 895680    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2193.0     | 432840    | 06-Jan-17 | 23:32 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2193.0     | 2043592   | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2193.0     | 33480     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2193.0     | 250056    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2193.0     | 33992     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:30 | x86      |
| Msmdlocal.dll                                                | 2015.130.2193.0 | 37015240  | 06-Jan-17 | 23:30 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2193.0 | 6501568   | 07-Jan-17 | 00:49 | x86      |
| Msolap130.dll                                                | 2015.130.2193.0 | 6968008   | 06-Jan-17 | 23:30 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2193.0 | 88776     | 06-Jan-17 | 23:31 | x86      |
| Xmsrv.dll                                                    | 2015.130.2193.0 | 32693952  | 07-Jan-17 | 00:49 | x86      |

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlsqm_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlboot.dll           | 2015.130.2193.0 | 186560    | 07-Jan-17 | 00:50 | x64      |
| Sqlvdi.dll            | 2015.130.2193.0 | 197320    | 06-Jan-17 | 23:29 | x64      |
| Sqlvdi.dll            | 2015.130.2193.0 | 168640    | 06-Jan-17 | 23:30 | x86      |
| Sqlwriter_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |

SQL Server 2016 Analysis Services

|                   File name                   |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll    | 13.0.2193.0     | 1343688   | 06-Jan-17 | 23:30 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2193.0     | 765640    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 16-Jun-16 | 18:42 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 16-Jun-16 | 20:12 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 16-Jun-16 | 18:42 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 16-Jun-16 | 20:12 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 18:42 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 20:12 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 18:42 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 20:12 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 16-Jun-16 | 18:42 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 16-Jun-16 | 20:12 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 16-Jun-16 | 18:42 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 16-Jun-16 | 20:12 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 16-Jun-16 | 18:42 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 16-Jun-16 | 20:12 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 16-Jun-16 | 20:12 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 16-Jun-16 | 18:42 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 16-Jun-16 | 20:12 | x86      |
| Msmdlocal.dll                                 | 2015.130.2193.0 | 37015240  | 06-Jan-17 | 23:30 | x86      |
| Msmdlocal.dll                                 | 2015.130.2193.0 | 56079040  | 07-Jan-17 | 00:50 | x64      |
| Msmdsrv.exe                                   | 2015.130.2193.0 | 56624328  | 06-Jan-17 | 23:30 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2193.0 | 7500488   | 06-Jan-17 | 23:29 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2193.0 | 6501568   | 07-Jan-17 | 00:49 | x86      |
| Msolap130.dll                                 | 2015.130.2193.0 | 6968008   | 06-Jan-17 | 23:30 | x86      |
| Msolap130.dll                                 | 2015.130.2193.0 | 8590016   | 07-Jan-17 | 00:50 | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlboot.dll                                   | 2015.130.2193.0 | 186560    | 07-Jan-17 | 00:50 | x64      |
| Sqlceip.exe                                   | 13.0.2193.0     | 249024    | 07-Jan-17 | 00:50 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 16-Jun-16 | 18:42 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 16-Jun-16 | 20:12 | x86      |
| Tmapi.dll                                     | 2015.130.2193.0 | 4344520   | 06-Jan-17 | 23:29 | x64      |
| Tmcachemgr.dll                                | 2015.130.2193.0 | 2825416   | 06-Jan-17 | 23:29 | x64      |
| Tmpersistence.dll                             | 2015.130.2193.0 | 1069768   | 06-Jan-17 | 23:29 | x64      |
| Tmtransactions.dll                            | 2015.130.2193.0 | 1349824   | 06-Jan-17 | 23:29 | x64      |
| Xmsrv.dll                                     | 2015.130.2193.0 | 24013504  | 06-Jan-17 | 23:29 | x64      |
| Xmsrv.dll                                     | 2015.130.2193.0 | 32693952  | 07-Jan-17 | 00:49 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2193.0     | 1023168   | 06-Jan-17 | 23:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2193.0     | 1023168   | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2193.0     | 1344192   | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2193.0     | 702656    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2193.0     | 765632    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2193.0     | 707272    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2193.0     | 707264    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2193.0     | 37064     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2193.0     | 46280     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2193.0 | 75464     | 06-Jan-17 | 23:30 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2193.0 | 72904     | 06-Jan-17 | 23:30 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2193.0 | 60104     | 06-Jan-17 | 23:30 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2193.0 | 72896     | 07-Jan-17 | 00:50 | x64      |
| Sql_common_core_keyfile.dll                | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2193.0 | 404168    | 06-Jan-17 | 23:29 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2193.0 | 364224    | 06-Jan-17 | 23:30 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2193.0 | 349384    | 06-Jan-17 | 23:29 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2193.0 | 267464    | 06-Jan-17 | 23:30 | x86      |
| Sqltdiagn.dll                              | 2015.130.2193.0 | 67776     | 06-Jan-17 | 23:29 | x64      |
| Sqltdiagn.dll                              | 2015.130.2193.0 | 60616     | 06-Jan-17 | 23:30 | x86      |
| Svrenumapi130.dll                          | 2015.130.2193.0 | 1115848   | 06-Jan-17 | 23:29 | x64      |
| Svrenumapi130.dll                          | 2015.130.2193.0 | 854216    | 06-Jan-17 | 23:30 | x86      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2193.0  | 473288    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2193.0  | 473280    | 07-Jan-17 | 00:49 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2193.0  | 1876680   | 06-Jan-17 | 23:29 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2193.0  | 1876672   | 07-Jan-17 | 00:49 | x86      |

SQL Server 2016 Database Services Core Instance

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Databasemail.exe                     | 13.0.16100.4    | 29888     | 09-Dec-16 | 00:46 | x64      |
| Hadrres.dll                          | 2015.130.2193.0 | 177864    | 06-Jan-17 | 23:29 | x64      |
| Hkcompile.dll                        | 2015.130.2193.0 | 1297608   | 06-Jan-17 | 23:29 | x64      |
| Hkengine.dll                         | 2015.130.2193.0 | 5600456   | 06-Jan-17 | 23:31 | x64      |
| Hkruntime.dll                        | 2015.130.2193.0 | 158920    | 06-Jan-17 | 23:31 | x64      |
| Microsoft.sqlserver.types.dll        | 2015.130.2193.0 | 391880    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.vdiinterface.dll | 2015.130.2193.0 | 71368     | 06-Jan-17 | 23:29 | x64      |
| Qds.dll                              | 2015.130.2193.0 | 844992    | 07-Jan-17 | 00:50 | x64      |
| Rsfxft.dll                           | 2015.130.2193.0 | 34496     | 06-Jan-17 | 23:29 | x64      |
| Sql_engine_core_inst_keyfile.dll     | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlaccess.dll                        | 2015.130.2193.0 | 461512    | 06-Jan-17 | 23:30 | x64      |
| Sqlagent.exe                         | 2015.130.2193.0 | 565960    | 06-Jan-17 | 23:30 | x64      |
| Sqlboot.dll                          | 2015.130.2193.0 | 186560    | 07-Jan-17 | 00:50 | x64      |
| Sqlceip.exe                          | 13.0.2193.0     | 249024    | 07-Jan-17 | 00:50 | x86      |
| Sqldk.dll                            | 2015.130.2193.0 | 2586304   | 07-Jan-17 | 00:50 | x64      |
| Sqllang.dll                          | 2015.130.2193.0 | 39323840  | 07-Jan-17 | 00:50 | x64      |
| Sqlmin.dll                           | 2015.130.2193.0 | 37339848  | 06-Jan-17 | 23:29 | x64      |
| Sqlos.dll                            | 2015.130.2193.0 | 26312     | 06-Jan-17 | 23:29 | x64      |
| Sqlscriptdowngrade.dll               | 2015.130.2193.0 | 27848     | 06-Jan-17 | 23:29 | x64      |
| Sqlscriptupgrade.dll                 | 2015.130.2193.0 | 5797064   | 06-Jan-17 | 23:29 | x64      |
| Sqlserverspatial130.dll              | 2015.130.2193.0 | 732872    | 06-Jan-17 | 23:29 | x64      |
| Sqlservr.exe                         | 2015.130.2193.0 | 392904    | 06-Jan-17 | 23:30 | x64      |
| Sqltses.dll                          | 2015.130.2193.0 | 8896712   | 06-Jan-17 | 23:29 | x64      |
| Stretchcodegen.exe                   | 13.0.2193.0     | 55488     | 06-Jan-17 | 23:30 | x86      |

SQL Server 2016 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2193.0 | 3145408   | 07-Jan-17 | 00:50 | x64      |
| Dtspipeline.dll                                              | 2015.130.2193.0 | 1278144   | 07-Jan-17 | 00:50 | x64      |
| Dtswizard.exe                                                | 13.0.2193.0     | 895168    | 07-Jan-17 | 00:50 | x64      |
| Logread.exe                                                  | 2015.130.2193.0 | 616648    | 06-Jan-17 | 23:30 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2193.0     | 33984     | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.14510.3    | 30912     | 12-Oct-16 | 10:35 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:29 | x86      |
| Repldp.dll                                                   | 2015.130.2193.0 | 276160    | 07-Jan-17 | 00:50 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Txdatacollector.dll                                          | 2015.130.2193.0 | 367304    | 06-Jan-17 | 23:29 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.2193.0 | 1012928   | 07-Jan-17 | 00:50 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlsatellite.dll              | 2015.130.2193.0 | 836808    | 06-Jan-17 | 23:29 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 16-Jun-16 | 18:44 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 16-Jun-16 | 18:44 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 16-Jun-16 | 18:44 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 16-Jun-16 | 18:44 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.2193.0     | 23752     | 06-Jan-17 | 23:30 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |

SQL Server 2016 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                       | 2015.130.2193.0 | 2631872   | 06-Jan-17 | 23:31 | x86      |
| Dts.dll                                                       | 2015.130.2193.0 | 3145408   | 07-Jan-17 | 00:50 | x64      |
| Dtspipeline.dll                                               | 2015.130.2193.0 | 1059528   | 06-Jan-17 | 23:31 | x86      |
| Dtspipeline.dll                                               | 2015.130.2193.0 | 1278144   | 07-Jan-17 | 00:50 | x64      |
| Dtswizard.exe                                                 | 13.0.2193.0     | 895680    | 07-Jan-17 | 00:49 | x86      |
| Dtswizard.exe                                                 | 13.0.2193.0     | 895168    | 07-Jan-17 | 00:50 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2193.0     | 469704    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2193.0     | 469704    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2193.0     | 33984     | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2193.0     | 33992     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:30 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2193.0     | 216768    | 07-Jan-17 | 00:50 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlceip.exe                                                   | 13.0.2193.0     | 249024    | 07-Jan-17 | 00:50 | x86      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.2193.0     | 79048     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2193.0     | 567496    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2193.0     | 166088    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2193.0     | 1620672   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2193.0     | 657600    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2193.0     | 329408    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2193.0     | 1069760   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2193.0     | 161984    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2193.0     | 76488     | 06-Jan-17 | 23:32 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2193.0     | 76480     | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2193.0     | 122560    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2193.0     | 104128    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2193.0     | 4904128   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2193.0     | 9644224   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2193.0     | 92864     | 07-Jan-17 | 00:50 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2193.0     | 5951168   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2193.0     | 245952    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2193.0     | 207552    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2193.0     | 500928    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2193.0 | 391880    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2193.0 | 396992    | 06-Jan-17 | 23:33 | x86      |
| Msmdlocal.dll                                             | 2015.130.2193.0 | 37015240  | 06-Jan-17 | 23:30 | x86      |
| Msmdlocal.dll                                             | 2015.130.2193.0 | 56079040  | 07-Jan-17 | 00:50 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2193.0 | 7500488   | 06-Jan-17 | 23:29 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2193.0 | 6501568   | 07-Jan-17 | 00:49 | x86      |
| Msolap130.dll                                             | 2015.130.2193.0 | 6968008   | 06-Jan-17 | 23:30 | x86      |
| Msolap130.dll                                             | 2015.130.2193.0 | 8590016   | 07-Jan-17 | 00:50 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2193.0     | 2518208   | 06-Jan-17 | 23:29 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2193.0 | 108736    | 06-Jan-17 | 23:29 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.2193.0 | 114368    | 07-Jan-17 | 00:49 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.2193.0 | 99008     | 06-Jan-17 | 23:29 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2193.0     | 2698440   | 06-Jan-17 | 23:29 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2193.0 | 732872    | 06-Jan-17 | 23:29 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2193.0 | 584392    | 06-Jan-17 | 23:30 | x86      |
| Xmsrv.dll                                                 | 2015.130.2193.0 | 24013504  | 06-Jan-17 | 23:29 | x64      |
| Xmsrv.dll                                                 | 2015.130.2193.0 | 32693952  | 07-Jan-17 | 00:49 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.2193.0     | 23744     | 06-Jan-17 | 23:29 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |

SQL Server 2016 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2193.0 | 2631872   | 06-Jan-17 | 23:31 | x86      |
| Dts.dll                                                      | 2015.130.2193.0 | 3145408   | 07-Jan-17 | 00:50 | x64      |
| Dtspipeline.dll                                              | 2015.130.2193.0 | 1059528   | 06-Jan-17 | 23:31 | x86      |
| Dtspipeline.dll                                              | 2015.130.2193.0 | 1278144   | 07-Jan-17 | 00:50 | x64      |
| Dtswizard.exe                                                | 13.0.2193.0     | 895680    | 07-Jan-17 | 00:49 | x86      |
| Dtswizard.exe                                                | 13.0.2193.0     | 895168    | 07-Jan-17 | 00:50 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2193.0     | 432840    | 06-Jan-17 | 23:32 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2193.0     | 432832    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2193.0     | 2043592   | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2193.0     | 2043584   | 07-Jan-17 | 00:50 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2193.0     | 33480     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2193.0     | 33472     | 07-Jan-17 | 00:50 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2193.0     | 250056    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2193.0     | 250048    | 07-Jan-17 | 00:50 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2193.0     | 33984     | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2193.0     | 33992     | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2193.0     | 606408    | 06-Jan-17 | 23:30 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:29 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2193.0     | 445128    | 06-Jan-17 | 23:30 | x86      |
| Msmdlocal.dll                                                | 2015.130.2193.0 | 37015240  | 06-Jan-17 | 23:30 | x86      |
| Msmdlocal.dll                                                | 2015.130.2193.0 | 56079040  | 07-Jan-17 | 00:50 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2193.0 | 7500488   | 06-Jan-17 | 23:29 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2193.0 | 6501568   | 07-Jan-17 | 00:49 | x86      |
| Msolap130.dll                                                | 2015.130.2193.0 | 6968008   | 06-Jan-17 | 23:30 | x86      |
| Msolap130.dll                                                | 2015.130.2193.0 | 8590016   | 07-Jan-17 | 00:50 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2193.0 | 100544    | 07-Jan-17 | 00:50 | x64      |
| Xmsrv.dll                                                    | 2015.130.2193.0 | 24013504  | 06-Jan-17 | 23:29 | x64      |
| Xmsrv.dll                                                    | 2015.130.2193.0 | 32693952  | 07-Jan-17 | 00:49 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
