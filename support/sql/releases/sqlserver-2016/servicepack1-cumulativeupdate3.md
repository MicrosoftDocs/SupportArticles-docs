---
title: Cumulative update 3 for SQL Server 2016 SP1 (KB4019916)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 3 (KB4019916).
ms.date: 10/26/2023
ms.custom: KB4019916
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB4019916 - Cumulative Update 3 for SQL Server 2016 SP1

_Release Date:_ &nbsp; May 15, 2017  
_Version:_ &nbsp; 13.0.4435.0

This article describes cumulative update package 3 (build number: **13.0.4435.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=9367899>[9367899](#9367899)</a> | [FIX: KPIs return a non-translated caption when an MDSCHEMA_MEASURES request is issued and the restrictions request hidden members (KB3198827)](https://support.microsoft.com/help/3198827) | Analysis Services |
| <a id=9730123>[9730123](#9730123)</a> | [FIX: The SQL Server Analysis Service encounters an internal error when it processes a Tabular model (KB4016805)](https://support.microsoft.com/help/4016805) | Analysis Services |
| <a id=9782406>[9782406](#9782406)</a> | [FIX: Error when you process a calculated column on a database with compatibility level 1200 in SSAS 2016 tabular mode (KB4018955)](https://support.microsoft.com/help/4018955) | Analysis Services |
| <a id=9782644>[9782644](#9782644)</a> | [FIX: SSAS fails to start if the MemoryHeapType and HeapTypeForObjects properties are set to -1 (KB4019511)](https://support.microsoft.com/help/4019511) | Analysis Services |
| <a id=9813872>[9813872](#9813872)</a> | [FIX: "Partition cannot contain column segments of different data versions" error when you process data on a partition in SSAS Tabular model (KB4013208)](https://support.microsoft.com/help/4013208) | Analysis Services |
| <a id=9646715>[9646715](#9646715)</a> | FIX: MDX query returns an error in SQL Server Analysis Service if the dimension table contains members that don't exist in the fact table (KB4018741) | Analysis Services |
| <a id=9690463>[9690463](#9690463)</a> | FIX: SSAS 2016 crashes with an access violation when many partitions and their aggregations/indexes are processed together concurrently (KB4019988) | Analysis Services |
| <a id=9875165>[9875165](#9875165)</a> | FIX: SSAS crashes when you retrieve KPIs as hidden members by using schema rowsets in SQL Server (KB4019048) | Analysis Services |
| <a id=9813829>[9813829](#9813829)</a> | [FIX: DMV sys.dm_hadr_availability_group_states displays "NOT_HEALTHY" in synchronization_health_desc column on secondary replicas in SQL Server (KB4013111)](https://support.microsoft.com/help/4013111) | High Availability |
| <a id=9813880>[9813880](#9813880)</a> | [Update enables DML query plan to scan query memory-optimized tables in parallel in SQL Server 2016 (KB4013877)](https://support.microsoft.com/help/4013877) | In-Memory OLTP |
| <a id=9813879>[9813879](#9813879)</a> | [FIX: Out-of-memory error when you run a query to access LOB columns through In-Memory OLTP in SQL Server 2016 (KB3198751)](https://support.microsoft.com/help/3198751) | In-Memory OLTP |
| <a id=9741797>[9741797](#9741797)</a> | [Sqlps utility fails to run when the "Turn on Script Execution" policy is set to "Allow all scripts" in SQL Server (KB3122088)](https://support.microsoft.com/help/3122088) | Management Tools |
| <a id=9813014>[9813014](#9813014)</a> | [FIX: You receive incorrect results when you use SQL Server Management Objects to generate a script for a full-text Search index (KB4016850)](https://support.microsoft.com/help/4016850) | Management Tools |
| <a id=9367870>[9367870](#9367870)</a> | [FIX: You can't run a data cleanse against a view in SQL Server 2016 Data Quality Services (KB3212227)](https://support.microsoft.com/help/3212227) | Master Data Services (MDS) |
| <a id=9704803>[9704803](#9704803)</a> | [FIX: MDS entity sync fails if the Name or Code attribute contains non-default values in SQL Server 2016 (KB4017737)](https://support.microsoft.com/help/4017737) | Master Data Services (MDS) |
| <a id=9731830>[9731830](#9731830)</a> | [FIX: Domain entity drop-down displays an incorrect value when you connect to MDS by using MDS Add-in for Excel in SQL Server 2016 (KB4018954)](https://support.microsoft.com/help/4018954) | Master Data Services (MDS) |
| <a id=8528715>[8528715](#8528715)</a> | FIX: Transactions aren't recorded after you deactivate leaf members in a leaf members staging table in Master Data Services (KB3197976) | Master Data Services (MDS) |
| <a id=9813853>[9813853](#9813853)</a> | [GDR update package for SQL Server 2016 SP1 (KB3210089)](https://support.microsoft.com/help/3210089) | Reporting Services |
| <a id=9875963>[9875963](#9875963)</a> | [Improvement: Improves the performance in opening a mobile report that contains a large dataset in SSRS 2016 (KB4019917)](https://support.microsoft.com/help/4019917) | Reporting Services |
| <a id=9616836>[9616836](#9616836)</a> | [FIX: Deadlock when you run the "CleanOrphanedPolicies" and "DeleteDataSources" built-in stored procedures together in SSRS 2016 (KB4019799)](https://support.microsoft.com/help/4019799) | Reporting Services |
| <a id=9622324>[9622324](#9622324)</a> | [FIX: Incorrect data returned by a subscription that accepts a DateTime type parameter run on a computer using a time zone that differs from the SSRS report server (KB4014031)](https://support.microsoft.com/help/4014031) | Reporting Services |
| <a id=9632792>[9632792](#9632792)</a> | [FIX: SQL Server 2016 Reporting Service subscription sends a PDF attachment as an incorrect MIME type "Application/Octet-Stream" (KB4019286)](https://support.microsoft.com/help/4019286) | Reporting Services |
| <a id=9710227>[9710227](#9710227)</a> | [FIX: "rsUnknownReportParameter" error when you click a report from search results in SSRS 2016 (KB4015093)](https://support.microsoft.com/help/4015093) | Reporting Services |
| <a id=9781129>[9781129](#9781129)</a> | [FIX: KPIs appear in a random order on adding them to the Favorites page in SSRS 2016 web portal (KB4019803)](https://support.microsoft.com/help/4019803) | Reporting Services |
| <a id=9813881>[9813881](#9813881)</a> | [FIX: "Adjust height to fit zone" setting of the SSRS 2016 Report Viewer Web Part isn't respected on a SharePoint webpage (KB3211948)](https://support.microsoft.com/help/3211948) | Reporting Services |
| <a id=9827309>[9827309](#9827309)</a> | [FIX: Mobile report doesn't display correct formatting when regional setting is set to Non-English in SSRS 2016 (KB4018882)](https://support.microsoft.com/help/4018882) | Reporting Services |
| <a id=9904352>[9904352](#9904352)</a> | [FIX: Pie chart legend doesn't format percentage values properly in SSRS 2016 mobile report (KB4019445)](https://support.microsoft.com/help/4019445) | Reporting Services |
| <a id=9575781>[9575781](#9575781)</a> | FIX: Can't sort subscriptions by column in SSRS 2016 web portal (KB4013609) | Reporting Services |
| <a id=9783888>[9783888](#9783888)</a> | FIX: Reporting Services web portal stops responding when you edit a subscription if a parameter has many available values in SQL Server (KB4016613) | Reporting Services |
| <a id=9805970>[9805970](#9805970)</a> | FIX: Reporting Services "SortExpression" results in `rsComparisonError` when there's a NULL value in a column set as "`DataTimeOffset`" data type (KB4017827) | Reporting Services |
| <a id=9704568>[9704568](#9704568)</a> | [FIX: An assertion occurs when you run an UPDATE statement on a clustered columnstore index in SQL Server 2016 (KB4015034)](https://support.microsoft.com/help/4015034) | SQL performance |
| <a id=9722266>[9722266](#9722266)</a> | [FIX: Access violation occurs when you use SELECT TOP query to retrieve data from clustered columnstore index in SQL Server 2016 (KB4016902)](https://support.microsoft.com/help/4016902) | SQL performance |
| <a id=9749308>[9749308](#9749308)</a> | [FIX: SQL Server 2016 stops responding when the "Latch_Suspend_End" extended event is triggered incorrectly (KB4019446)](https://support.microsoft.com/help/4019446) | SQL performance |
| <a id=9578382>[9578382](#9578382)</a> | FIX: Error 608 when a stored procedure that inserts rows into a temporary table on which a spatial index is created is run in SQL Server (KB4019097) | SQL performance |
| <a id=9813858>[9813858](#9813858)</a> | [Update reduces the execution frequency of the sp_MSsubscription_cleanup stored procedure in SQL Server (KB4014798)](https://support.microsoft.com/help/4014798) | SQL service |
| <a id=9627366>[9627366](#9627366)</a> | [FIX: "The custom resolver for this article requires OLEAUT32.DLL with a minimum version of 2.40.4276" error with merge publication in SQL Server (KB4016945)](https://support.microsoft.com/help/4016945) | SQL service |
| <a id=9647267>[9647267](#9647267)</a> | [FIX: Deadlock when you use sys.column_store_row_groups and sys.dm_db_column_store_row_group_physical_stats DMV with large DDL operations in SQL Server 2016 (KB4016946)](https://support.microsoft.com/help/4016946) | SQL service |
| <a id=9719202>[9719202](#9719202)</a> | [FIX: Service Broker endpoint connections aren't closed after an availability group failover in SQL Server (KB4016361)](https://support.microsoft.com/help/4016361) | SQL service |
| <a id=9735541>[9735541](#9735541)</a> | [FIX: Parallel redo causes high memory usage in SQL Server 2016 when compared to SQL Server 2014 or earlier versions (KB4018866)](https://support.microsoft.com/help/4018866) | SQL service |
| <a id=9813825>[9813825](#9813825)</a> | [FIX: A memory leak in SQLWEP causes the host process Wmiprvse.exe to crash in SQL Server (KB4014732)](https://support.microsoft.com/help/4014732) | SQL service |
| <a id=9813837>[9813837](#9813837)</a> | [FIX: SQL Server Profiler fails to obfuscate sp_setapprole when it's executed from a remote procedure call in SQL Server (KB4014756)](https://support.microsoft.com/help/4014756) | SQL service |
| <a id=9813862>[9813862](#9813862)</a> | [FIX: Failed assertion and many access violation dump files after the sp_replcmds stored procedure is canceled in SQL Server (KB4014706)](https://support.microsoft.com/help/4014706) | SQL service |
| <a id=9813868>[9813868](#9813868)</a> | [FIX: Error occurs when you drop a subscription by using a non-sysadmin account in SQL Server (KB4014738)](https://support.microsoft.com/help/4014738) | SQL service |
| <a id=9813873>[9813873](#9813873)</a> | [FIX: Wrong number of rows returned in sys.partitions for Columnstore index in SQL Server 2016 (KB3195752)](https://support.microsoft.com/help/3195752) | SQL service |
| <a id=9813889>[9813889](#9813889)</a> | [FIX: The sys.column_store_segments catalog view displays incorrect values in the column_id column in SQL Server 2016 (KB4013118)](https://support.microsoft.com/help/4013118) | SQL service |
| <a id=9818412>[9818412](#9818412)</a> | [FIX: The setting for deadlock priority doesn't work when you run the ALTER PARTITION FUNCTION statement in SQL Server 2016 (KB4025261)](https://support.microsoft.com/help/4025261) | SQL service |
| <a id=9822240>[9822240](#9822240)</a> | [FIX: Intra-query deadlock occurs when you execute parallel query that contains outer join operators in SQL Server 2016 (KB4019718)](https://support.microsoft.com/help/4019718) | SQL service |
| <a id=9853847>[9853847](#9853847)</a> | [FIX: SQL Server 2016 consumes more memory when columnstore index is reorganized (KB4019028)](https://support.microsoft.com/help/4019028) | SQL service |
| <a id=9855185>[9855185](#9855185)</a> | [FIX: Error when you execute DBCC CLONEDATABASE on an "Always Encrypted" enabled database in SQL Server 2016 (KB4019285)](https://support.microsoft.com/help/4019285) | SQL service |
| <a id=9876061>[9876061](#9876061)</a> | [FIX: Access violation when a stored procedure is dropped before you execute END TRY section in SQL Server 2012 or 2016 (KB4015561)](https://support.microsoft.com/help/4015561) | SQL service |
| <a id=9892608>[9892608](#9892608)</a> | [FIX: DBCC CLONEDATABASE is unsuccessful if the source database has an object originally created in SQL Server 2000 (KB4016238)](https://support.microsoft.com/help/4016238) | SQL service |
| <a id=9901863>[9901863](#9901863)</a> | [FIX: Database schema is corrupted when you restore a database from a snapshot in SQL Server (KB4019701)](https://support.microsoft.com/help/4019701) | SQL service |
| <a id=9902336>[9902336](#9902336)</a> | [FIX: Restore fails when you do backup with compression and checksum on a TDE-enabled database in SQL Server 2016 (KB4019893)](https://support.microsoft.com/help/4019893) | SQL service |
| <a id=9917140>[9917140](#9917140)</a> | [FIX: Query against sys.dm_db_partition_stats DMV is slow if the database contains many partitions in SQL Server 2016 (KB4019903)](https://support.microsoft.com/help/4019903) | SQL service |
| <a id=9917206>[9917206](#9917206)</a> | [FIX: An assertion occurs when you execute an ALTER TABLE SWITCH statement on a partitioned temporal history table in SQL Server 2016 (KB4019863)](https://support.microsoft.com/help/4019863) | SQL service |
| <a id=9635707>[9635707](#9635707)</a> | FIX: Large memory allocations of type `MEMOBJ_XSTMT` occur when you run the `sys.dm_exec_query_stats` script in SQL Server (KB4017013) | SQL service |
| <a id=9846459>[9846459](#9846459)</a> | Intra-query deadlock on communication buffer when you run a bulk load against a clustered columnstore index in SQL Server 2016 (KB4017154) | SQL service |
| <a id=9906185>[9906185](#9906185)</a> | FIX: A severe error occurs when you create a spatial index with the `GEOMETRY_GRID` or `GEOGRAPHY_GRID` option in SQL Server (KB4019671) | SQL service |

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

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll         | 13.0.4435.0     | 1348288   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4435.0     | 702664    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4435.0     | 765632    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4435.0     | 520896    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4435.0     | 37056     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4435.0     | 46272     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4435.0 | 72896     | 28-Apr-17 | 08:43 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4435.0 | 60096     | 28-Apr-17 | 08:41 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4435.0 | 88768     | 28-Apr-17 | 08:42 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4435.0 | 364232    | 28-Apr-17 | 08:41 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4435.0 | 267456    | 28-Apr-17 | 08:41 | x86      |
| Sqltdiagn.dll                               | 2015.130.4435.0 | 60608     | 28-Apr-17 | 08:41 | x86      |
| Svrenumapi130.dll                           | 2015.130.4435.0 | 853696    | 28-Apr-17 | 08:41 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4435.0  | 1876672   | 28-Apr-17 | 08:43 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4435.0 | 2023112   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4435.0     | 433856    | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4435.0     | 2044608   | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4435.0     | 33472     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4435.0     | 249536    | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.olapenum.dll               | 13.0.4435.0     | 106176    | 28-Apr-17 | 08:43 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4435.0 | 6507720   | 28-Apr-17 | 08:43 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4435.0 | 88768     | 28-Apr-17 | 08:42 | x86      |
| Xmsrv.dll                                      | 2015.130.4435.0 | 32717512  | 28-Apr-17 | 08:43 | x86      |

x64-based versions

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlvdi.dll            | 2015.130.4435.0 | 168640    | 28-Apr-17 | 08:41 | x86      |
| Sqlvdi.dll            | 2015.130.4435.0 | 197320    | 28-Apr-17 | 08:42 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll         | 13.0.4435.0     | 1347264   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4435.0     | 765632    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4435.0     | 521416    | 28-Apr-17 | 08:42 | x86      |
| Msmdsrv.exe                                        | 2015.130.4435.0 | 56726720  | 28-Apr-17 | 08:42 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4435.0 | 7506624   | 28-Apr-17 | 08:41 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4435.0 | 6507720   | 28-Apr-17 | 08:43 | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlceip.exe                                        | 13.0.4435.0     | 246976    | 28-Apr-17 | 08:42 | x86      |
| Tmapi.dll                                          | 2015.130.4435.0 | 4346048   | 28-Apr-17 | 08:39 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4435.0 | 2826432   | 28-Apr-17 | 08:39 | x64      |
| Tmpersistence.dll                                  | 2015.130.4435.0 | 1071296   | 28-Apr-17 | 08:39 | x64      |
| Tmtransactions.dll                                 | 2015.130.4435.0 | 1352384   | 28-Apr-17 | 08:39 | x64      |
| Xmsrv.dll                                          | 2015.130.4435.0 | 24041152  | 28-Apr-17 | 08:39 | x64      |
| Xmsrv.dll                                          | 2015.130.4435.0 | 32717512  | 28-Apr-17 | 08:43 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.core.dll         | 13.0.4435.0     | 1348288   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4435.0     | 702664    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4435.0     | 765632    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4435.0     | 520896    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4435.0     | 37056     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4435.0     | 46272     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4435.0 | 75456     | 28-Apr-17 | 08:41 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4435.0 | 72896     | 28-Apr-17 | 08:43 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4435.0 | 60096     | 28-Apr-17 | 08:41 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4435.0 | 72896     | 28-Apr-17 | 08:42 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4435.0 | 404160    | 28-Apr-17 | 08:39 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4435.0 | 364232    | 28-Apr-17 | 08:41 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4435.0 | 348864    | 28-Apr-17 | 08:39 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4435.0 | 267456    | 28-Apr-17 | 08:41 | x86      |
| Sqltdiagn.dll                               | 2015.130.4435.0 | 67776     | 28-Apr-17 | 08:39 | x64      |
| Sqltdiagn.dll                               | 2015.130.4435.0 | 60608     | 28-Apr-17 | 08:41 | x86      |
| Svrenumapi130.dll                           | 2015.130.4435.0 | 1115840   | 28-Apr-17 | 08:39 | x64      |
| Svrenumapi130.dll                           | 2015.130.4435.0 | 853696    | 28-Apr-17 | 08:41 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4435.0  | 1876672   | 28-Apr-17 | 08:41 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4435.0  | 1876672   | 28-Apr-17 | 08:43 | x86      |

SQL Server 2016 Database Services Core Instance

|                File name                |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Databasemail.exe                        | 13.0.16100.4    | 29888     | 09-Dec-16 | 01:46 | x64      |
| Hkcompile.dll                           | 2015.130.4435.0 | 1297088   | 28-Apr-17 | 08:42 | x64      |
| Hkengine.dll                            | 2015.130.4435.0 | 5600960   | 28-Apr-17 | 08:42 | x64      |
| Hkruntime.dll                           | 2015.130.4435.0 | 158912    | 28-Apr-17 | 08:42 | x64      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll | 13.0.4435.0     | 79552     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.types.dll           | 2015.130.4435.0 | 391872    | 28-Apr-17 | 08:41 | x86      |
| Microsoft.sqlserver.vdiinterface.dll    | 2015.130.4435.0 | 71360     | 28-Apr-17 | 08:41 | x64      |
| Qds.dll                                 | 2015.130.4435.0 | 843968    | 28-Apr-17 | 08:42 | x64      |
| Sql_engine_core_inst_keyfile.dll        | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlaccess.dll                           | 2015.130.4435.0 | 462528    | 28-Apr-17 | 08:41 | x64      |
| Sqlagent.exe                            | 2015.130.4435.0 | 565960    | 28-Apr-17 | 08:42 | x64      |
| Sqlceip.exe                             | 13.0.4435.0     | 246976    | 28-Apr-17 | 08:42 | x86      |
| Sqldk.dll                               | 2015.130.4435.0 | 2584768   | 28-Apr-17 | 08:42 | x64      |
| Sqllang.dll                             | 2015.130.4435.0 | 39378624  | 28-Apr-17 | 08:42 | x64      |
| Sqlmin.dll                              | 2015.130.4435.0 | 37515968  | 28-Apr-17 | 08:39 | x64      |
| Sqlos.dll                               | 2015.130.4435.0 | 26304     | 28-Apr-17 | 08:42 | x64      |
| Sqlscriptdowngrade.dll                  | 2015.130.4435.0 | 27840     | 28-Apr-17 | 08:39 | x64      |
| Sqlscriptupgrade.dll                    | 2015.130.4435.0 | 5797056   | 28-Apr-17 | 08:42 | x64      |
| Sqlservr.exe                            | 2015.130.4435.0 | 392896    | 28-Apr-17 | 08:42 | x64      |
| Sqltses.dll                             | 2015.130.4435.0 | 8896704   | 28-Apr-17 | 08:39 | x64      |
| Stretchcodegen.exe                      | 13.0.4435.0     | 56000     | 28-Apr-17 | 08:42 | x86      |
| Xpstar.dll                              | 2015.130.4435.0 | 422600    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 Database Services Core Shared

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4435.0     | 70848     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4435.0     | 73408     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4435.0     | 63680     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4435.0     | 31424     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4435.0     | 131264    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4435.0     | 43712     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4435.0     | 57536     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4435.0     | 215240    | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4435.0 | 1639104   | 28-Apr-17 | 08:41 | x64      |
| Spresolv.dll                                                       | 2015.130.4435.0 | 245440    | 28-Apr-17 | 08:42 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4435.0 | 346816    | 28-Apr-17 | 08:39 | x64      |
| Sqlps.exe                                                          | 13.0.4435.0     | 60096     | 28-Apr-17 | 08:42 | x86      |
| Sqlwep130.dll                                                      | 2015.130.4435.0 | 105664    | 28-Apr-17 | 08:39 | x64      |
| Ssradd.dll                                                         | 2015.130.4435.0 | 65216     | 28-Apr-17 | 08:39 | x64      |
| Ssravg.dll                                                         | 2015.130.4435.0 | 65216     | 28-Apr-17 | 08:39 | x64      |
| Ssrdown.dll                                                        | 2015.130.4435.0 | 50880     | 28-Apr-17 | 08:39 | x64      |
| Ssrmax.dll                                                         | 2015.130.4435.0 | 63680     | 28-Apr-17 | 08:39 | x64      |
| Ssrmin.dll                                                         | 2015.130.4435.0 | 63680     | 28-Apr-17 | 08:39 | x64      |
| Ssrpub.dll                                                         | 2015.130.4435.0 | 51392     | 28-Apr-17 | 08:39 | x64      |
| Ssrup.dll                                                          | 2015.130.4435.0 | 50880     | 28-Apr-17 | 08:39 | x64      |
| Txdatacollector.dll                                                | 2015.130.4435.0 | 367296    | 28-Apr-17 | 08:39 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4435.0 | 1013952   | 28-Apr-17 | 08:42 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlsatellite.dll              | 2015.130.4435.0 | 837312    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.130.4435.0 | 660160    | 28-Apr-17 | 08:42 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4435.0     | 23744     | 28-Apr-17 | 08:42 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 Integration Services

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.0         | 77936     | 14-Apr-17 | 17:22 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.0         | 77936     | 20-Apr-17 | 12:11 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.0         | 37488     | 14-Apr-17 | 17:22 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.0         | 37488     | 20-Apr-17 | 12:11 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.0         | 78448     | 14-Apr-17 | 17:22 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.0         | 78448     | 20-Apr-17 | 12:11 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4435.0     | 73408     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4435.0     | 73408     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4435.0     | 31424     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4435.0     | 31432     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4435.0     | 43712     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4435.0     | 43720     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4435.0     | 57536     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4435.0     | 57544     | 28-Apr-17 | 08:43 | x86      |
| Msdtssrvr.exe                                                      | 13.0.4435.0     | 216776    | 28-Apr-17 | 08:42 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Sqlceip.exe                                                        | 13.0.4435.0     | 246976    | 28-Apr-17 | 08:42 | x86      |

SQL Server 2016 Reporting Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.datarendering.dll      | 13.0.4435.0     | 168648    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.diagnostics.dll        | 13.0.4435.0     | 1621696   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.excelrendering.dll     | 13.0.4435.0     | 657608    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll      | 13.0.4435.0     | 329408    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.htmlrendering.dll      | 13.0.4435.0     | 1070280   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.imagerendering.dll     | 13.0.4435.0     | 161984    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll  | 13.0.4435.0     | 126144    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll | 13.0.4435.0     | 106176    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.portal.services.dll    | 13.0.4435.0     | 5958856   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.portal.web.dll         | 13.0.4435.0     | 10881728  | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.portal.webhost.exe     | 13.0.4435.0     | 97480     | 28-Apr-17 | 08:42 | x64      |
| Microsoft.reportingservices.processingcore.dll     | 13.0.4435.0     | 5951168   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll  | 13.0.4435.0     | 245952    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.spbprocessing.dll      | 13.0.4435.0     | 298184    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.storage.dll            | 13.0.4435.0     | 208576    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 44736     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48832     | 28-Apr-17 | 08:41 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48832     | 28-Apr-17 | 08:41 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48840     | 28-Apr-17 | 08:44 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 52936     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48832     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48832     | 28-Apr-17 | 08:41 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 52936     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 44736     | 28-Apr-17 | 08:44 | x86      |
| Microsoft.reportingservices.storage.resources.dll  | 13.0.4435.0     | 48832     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.reportingservices.upgradescripts.dll     | 13.0.4435.0     | 510656    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.types.dll                      | 2015.130.4435.0 | 391872    | 28-Apr-17 | 08:41 | x86      |
| Microsoft.sqlserver.types.dll                      | 2015.130.4435.0 | 396992    | 28-Apr-17 | 08:43 | x86      |
| Msmgdsrv.dll                                       | 2015.130.4435.0 | 7506624   | 28-Apr-17 | 08:41 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4435.0 | 6507720   | 28-Apr-17 | 08:43 | x86      |
| Reportingservicesemaildeliveryprovider.dll         | 13.0.4435.0     | 83648     | 28-Apr-17 | 08:41 | x86      |
| Reportingserviceslibrary.dll                       | 13.0.4435.0     | 2544320   | 28-Apr-17 | 08:41 | x86      |
| Reportingservicesnativeclient.dll                  | 2015.130.4435.0 | 108736    | 28-Apr-17 | 08:41 | x64      |
| Reportingservicesnativeclient.dll                  | 2015.130.4435.0 | 114368    | 28-Apr-17 | 08:43 | x86      |
| Reportingservicesnativeserver.dll                  | 2015.130.4435.0 | 99008     | 28-Apr-17 | 08:41 | x64      |
| Reportingserviceswebserver.dll                     | 13.0.4435.0     | 2708672   | 28-Apr-17 | 08:41 | x86      |
| Sql_rs_keyfile.dll                                 | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Xmsrv.dll                                          | 2015.130.4435.0 | 24041152  | 28-Apr-17 | 08:39 | x64      |
| Xmsrv.dll                                          | 2015.130.4435.0 | 32717512  | 28-Apr-17 | 08:43 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4435.0     | 23744     | 28-Apr-17 | 08:41 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.project.dll         | 2015.130.4435.0 | 2023112   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4435.0     | 433856    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.4435.0     | 433856    | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4435.0     | 2044608   | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.4435.0     | 2044608   | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4435.0     | 33472     | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll  | 13.0.4435.0     | 33472     | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4435.0     | 249536    | 28-Apr-17 | 08:42 | x86      |
| Microsoft.sqlserver.deployment.dll             | 13.0.4435.0     | 249536    | 28-Apr-17 | 08:43 | x86      |
| Microsoft.sqlserver.olapenum.dll               | 13.0.4435.0     | 106176    | 28-Apr-17 | 08:43 | x86      |
| Msmgdsrv.dll                                   | 2015.130.4435.0 | 7506624   | 28-Apr-17 | 08:41 | x64      |
| Msmgdsrv.dll                                   | 2015.130.4435.0 | 6507720   | 28-Apr-17 | 08:43 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.130.4435.0 | 100544    | 28-Apr-17 | 08:42 | x64      |
| Xmsrv.dll                                      | 2015.130.4435.0 | 24041152  | 28-Apr-17 | 08:39 | x64      |
| Xmsrv.dll                                      | 2015.130.4435.0 | 32717512  | 28-Apr-17 | 08:43 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
