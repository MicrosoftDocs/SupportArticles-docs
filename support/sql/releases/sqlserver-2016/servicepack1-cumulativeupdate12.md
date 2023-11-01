---
title: Cumulative update 12 for SQL Server 2016 SP1 (KB4464343)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 12 (KB4464343).
ms.date: 10/26/2023
ms.custom: KB4464343
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
---

# KB4464343 - Cumulative Update 12 for SQL Server 2016 SP1

_Release Date:_ &nbsp; November 13, 2018  
_Version:_ &nbsp; 13.0.4541.0

This article describes cumulative update package 12 (build number: **13.0.4541.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference   | Description   | Fix area  |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=12176017>[12176017](#12176017) </a> | [FIX: Deadlock when run the   "CleanOrphanedPolicies" and "DeleteDataSources" built-in   stored procedures together in SSRS   2016 (KB4019799)](https://support.microsoft.com/help/4019799)   | Reporting   Services  |
| <a id=12180164>[12180164](#12180164) </a> | [FIX: Access violation when you   try to access a table when page compression is enabled on the table in SQL   Server (KB4294694)](https://support.microsoft.com/help/4294694)| SQL Engine|
| <a id=12361234>[12361234](#12361234) </a> | [FIX: Incorrect results occur   when you convert "pollinginterval" parameter from seconds to hours   in sys.sp_cdc_scan in SQL Server (KB4459220)](https://support.microsoft.com/help/4459220)| SQL Engine|
| <a id=12458030>[12458030](#12458030) </a> | [FIX: Access violation occurs   and SSAS crashes when you process an SSAS database in SQL Server 2014 and   2016 (KB4459981)](https://support.microsoft.com/help/4459981) | Analysis Services |
| <a id=12458027>[12458027](#12458027) </a> | [FIX: Overestimations when using   default Cardinality Estimator to query table with many null   values (KB4460116)](https://support.microsoft.com/help/4460116)  | SQL performance   |
| <a id=12199266>[12199266](#12199266) </a> | FIX: The   "modification_counter" in DMV `sys.dm_db_stats_properties` shows   incorrect value when partitions are merged through `ALTER PARTITION` in SQL   Server 2016 (KB4465443) | SQL Engine|
| <a id=11179896>[11179896](#11179896) </a> | [FIX: Assertion error occurs   when you run a MERGE statement with an OUTPUT clause in SQL Server 2016 and   2017 (KB4465745)](https://support.microsoft.com/help/4465745)| SQL Engine|
| <a id=12399978>[12399978](#12399978) </a> | FIX: Snapshot Agent fails when   you publish many tables using snapshot or transactional   replication (KB4465747) | Management Tools  |
| <a id=12458041>[12458041](#12458041) </a>  | [FIX: "ran out of   memory" error when executing a query on a table that has a large   full-text index in SQL Server 2014 and   2016 (KB4465867)](https://support.microsoft.com/help/4465867) | SQL Engine|
| <a id=12357742>[12357742](#12357742) </a> | [FIX: Access violation occurs in   Distribution Agent in SQL Server 2016 and   2017 (KB4468103)](https://support.microsoft.com/help/4468103)  | SQL Engine|
| <a id=12366819>[12366819](#12366819) </a> | [FIX: VSS backup fails in SQL   Server 2008 after you install CU10 for SQL Server 2016 SP1 in the same   virtual machine (KB4469349)](https://support.microsoft.com/help/4469349) | SQL Engine|
| <a id=12431343>[12431343](#12431343) </a> | [FIX: Assertion error occurs   during restore of TDE compressed backups in SQL Server   2016 (KB4469554)](https://support.microsoft.com/help/4469554) | SQL Engine|
| <a id=12151799>[12151799](#12151799) </a> | [FIX: Peer-to-peer replication   fails in SQL Server 2016 when the host name is not   uppercase (KB4469600)](https://support.microsoft.com/help/4469600)  | SQL Engine|
| <a id=12466466>[12466466](#12466466) </a> | FIX: Cannot add data to a new   users attribute in an MDS database in SQL   Server (KB4469815)  | Data Quality   Services (DQS) |
| <a id=12323885>[12323885](#12323885) </a> | [FIX: Error 41168 occurs when   you try to alter DAG SEEDING_MODE in SQL Server   2016 (KB4470057)](https://support.microsoft.com/help/4470057)   | High Availability |
| <a id=12361676>[12361676](#12361676) </a> | FIX: SSAS 2016 processing fails   in a Multidimensional dimension that has Proactive Caching feature   enabled (KB4470546)  | Analysis Services |
| <a id=11677919>[11677919](#11677919) </a> | [FIX: Error 5901 occurs on the   same offset in SQL Server 2016 until server is   restarted (KB4476977)](https://support.microsoft.com/help/4476977)  | SQL Engine|

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

| File   name            | File version    | File size | Date      | Time | Platform |
|------------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll         | 2015.130.4541.0 | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Msmdredir.dll          | 2015.130.4541.0 | 6422304   | 27-Oct-2018 | 04:09 | x86      |
| Msmdsrv.rll            | 2015.130.4541.0 | 1296472   | 27-Oct-2018 | 04:09 | x86      |
| Msmdsrvi.rll           | 2015.130.4541.0 | 1293400   | 27-Oct-2018 | 04:09 | x86      |
| Sqlbrowser.exe         | 2015.130.4541.0 | 276768    | 27-Oct-2018 | 04:10 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4541.0 | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Sqldumper.exe          | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4541.0  | 160544    | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                              | 2015.130.4541.0  | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Isacctchange.dll                            | 2015.130.4541.0  | 29472     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4541.0      | 1027360   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4541.0      | 1348896   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4541.0      | 702752    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4541.0      | 765728    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4541.0      | 521024    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4541.0      | 711968    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4541.0      | 37184     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4541.0      | 46368     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4541.0  | 73024     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4541.0      | 598816    | 27-Oct-2018 | 04:10 | x86      |
| Msasxpress.dll                              | 2015.130.4541.0  | 32032     | 27-Oct-2018 | 04:09 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4541.0  | 60192     | 27-Oct-2018 | 04:09 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4541.0  | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Sqldumper.exe                               | 2015.130.4541.0  | 107840    | 27-Oct-2018 | 04:10 | x86      |
| Sqlftacct.dll                               | 2015.130.4541.0  | 46880     | 27-Oct-2018 | 04:09 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4541.0  | 364320    | 27-Oct-2018 | 04:09 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4541.0  | 35104     | 27-Oct-2018 | 04:09 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4541.0  | 267552    | 27-Oct-2018 | 04:09 | x86      |
| Sqltdiagn.dll                               | 2015.130.4541.0  | 60704     | 27-Oct-2018 | 04:09 | x86      |
| Svrenumapi130.dll                           | 2015.130.4541.0  | 854336    | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4541.0  | 1876560   | 27-Oct-2018 | 04:13 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4541.0 | 121120    | 27-Oct-2018 | 04:10 | x86      |
| Dreplaycommon.dll              | 2015.130.4541.0 | 691008    | 27-Oct-2018 | 04:09 | x86      |
| Dreplayserverps.dll            | 2015.130.4541.0 | 33056     | 27-Oct-2018 | 04:10 | x86      |
| Dreplayutil.dll                | 2015.130.4541.0 | 310048    | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                 | 2015.130.4541.0 | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4541.0 | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Sqlresourceloader.dll          | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4541.0 | 691008    | 27-Oct-2018 | 04:09 | x86      |
| Dreplaycontroller.exe              | 2015.130.4541.0 | 350496    | 27-Oct-2018 | 04:10 | x86      |
| Dreplayprocess.dll                 | 2015.130.4541.0 | 171808    | 27-Oct-2018 | 04:10 | x86      |
| Dreplayserverps.dll                | 2015.130.4541.0 | 33056     | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                     | 2015.130.4541.0 | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4541.0 | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Sqlresourceloader.dll              | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4541.0 | 1312032   | 27-Oct-2018 | 04:10 | x86      |
| Ddsshapes.dll                                   | 2015.130.4541.0 | 136000    | 27-Oct-2018 | 04:10 | x86      |
| Dtaengine.exe                                   | 2015.130.4541.0 | 167200    | 27-Oct-2018 | 04:10 | x86      |
| Dteparse.dll                                    | 2015.130.4541.0 | 99616     | 27-Oct-2018 | 04:10 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4541.0 | 83744     | 27-Oct-2018 | 04:09 | x86      |
| Dtepkg.dll                                      | 2015.130.4541.0 | 116000    | 27-Oct-2018 | 04:10 | x86      |
| Dtexec.exe                                      | 2015.130.4541.0 | 66848     | 27-Oct-2018 | 04:10 | x86      |
| Dts.dll                                         | 2015.130.4541.0 | 2632992   | 27-Oct-2018 | 04:10 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4541.0 | 419136    | 27-Oct-2018 | 04:10 | x86      |
| Dtsconn.dll                                     | 2015.130.4541.0 | 392480    | 27-Oct-2018 | 04:10 | x86      |
| Dtshost.exe                                     | 2015.130.4541.0 | 76576     | 27-Oct-2018 | 04:10 | x86      |
| Dtslog.dll                                      | 2015.130.4541.0 | 103200    | 27-Oct-2018 | 04:10 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4541.0 | 541472    | 27-Oct-2018 | 04:10 | x86      |
| Dtspipeline.dll                                 | 2015.130.4541.0 | 1059616   | 27-Oct-2018 | 04:10 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4541.0 | 42272     | 27-Oct-2018 | 04:10 | x86      |
| Dtswizard.exe                                   | 13.0.4541.0     | 896288    | 27-Oct-2018 | 03:59 | x86      |
| Dtuparse.dll                                    | 2015.130.4541.0 | 80192     | 27-Oct-2018 | 04:10 | x86      |
| Dtutil.exe                                      | 2015.130.4541.0 | 115520    | 27-Oct-2018 | 04:10 | x86      |
| Exceldest.dll                                   | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:10 | x86      |
| Excelsrc.dll                                    | 2015.130.4541.0 | 232736    | 27-Oct-2018 | 04:10 | x86      |
| Flatfiledest.dll                                | 2015.130.4541.0 | 334624    | 27-Oct-2018 | 04:10 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4541.0 | 345376    | 27-Oct-2018 | 04:10 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4541.0 | 80672     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4541.0     | 92448     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4541.0     | 1313568   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4541.0     | 696608    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4541.0     | 763680    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4541.0 | 2023200   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4541.0 | 42072     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4541.0     | 71440     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4541.0     | 186640    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4541.0     | 433936    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4541.0     | 2044688   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4541.0     | 33568     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4541.0     | 249632    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4541.0     | 502048    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4541.0     | 106272    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4541.0 | 138832    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4541.0 | 144464    | 27-Oct-2018 | 04:11 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4541.0 | 89888     | 27-Oct-2018 | 04:09 | x86      |
| Msmdlocal.dll                                   | 2015.130.4541.0 | 37103392  | 27-Oct-2018 | 04:09 | x86      |
| Msmdpp.dll                                      | 2015.130.4541.0 | 6370592   | 27-Oct-2018 | 04:09 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4541.0 | 6507600   | 27-Oct-2018 | 04:13 | x86      |
| Msolap130.dll                                   | 2015.130.4541.0 | 7008544   | 27-Oct-2018 | 04:09 | x86      |
| Msolui130.dll                                   | 2015.130.4541.0 | 287520    | 27-Oct-2018 | 04:09 | x86      |
| Oledbdest.dll                                   | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:09 | x86      |
| Oledbsrc.dll                                    | 2015.130.4541.0 | 235808    | 27-Oct-2018 | 04:09 | x86      |
| Profiler.exe                                    | 2015.130.4541.0 | 804640    | 27-Oct-2018 | 04:09 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4541.0 | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Sqldumper.exe                                   | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10 | x86      |
| Sqlresld.dll                                    | 2015.130.4541.0 | 28960     | 27-Oct-2018 | 04:09 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |
| Sqlscm.dll                                      | 2015.130.4541.0 | 53024     | 27-Oct-2018 | 04:09 | x86      |
| Sqlsvc.dll                                      | 2015.130.4541.0 | 127264    | 27-Oct-2018 | 04:09 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4541.0 | 151328    | 27-Oct-2018 | 04:09 | x86      |
| Txdataconvert.dll                               | 2015.130.4541.0 | 255056    | 27-Oct-2018 | 04:09 | x86      |
| Xe.dll                                          | 2015.130.4541.0 | 558880    | 27-Oct-2018 | 04:10 | x86      |
| Xmlrw.dll                                       | 2015.130.4541.0 | 259664    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4541.0 | 191568    | 27-Oct-2018 | 04:09 | x86      |
| Xmsrv.dll                                       | 2015.130.4541.0 | 32727632  | 27-Oct-2018 | 04:09 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4541.0 | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Keyfile.dll    | 2015.130.4541.0 | 88864     | 27-Oct-2018 | 04:09 | x86      |
| Msmdredir.dll  | 2015.130.4541.0 | 6422304   | 27-Oct-2018 | 04:09 | x86      |
| Msmdsrv.rll    | 2015.130.4541.0 | 1296472   | 27-Oct-2018 | 04:09 | x86      |
| Msmdsrvi.rll   | 2015.130.4541.0 | 1293400   | 27-Oct-2018 | 04:09 | x86      |
| Sqlbrowser.exe | 2015.130.4541.0 | 276768    | 27-Oct-2018 | 04:10 | x86      |
| Sqldumper.exe  | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Sqlboot.dll           | 2015.130.4541.0 | 186448    | 27-Oct-2018 | 04:10 | x64      |
| Sqldumper.exe         | 2015.130.4541.0 | 127056    | 27-Oct-2018 | 04:10 | x64      |
| Sqlvdi.dll            | 2015.130.4541.0 | 197392    | 27-Oct-2018 | 04:09 | x64      |
| Sqlvdi.dll            | 2015.130.4541.0 | 168736    | 27-Oct-2018 | 04:09 | x86      |
| Sqlwriter.exe         | 2015.130.4541.0 | 131672    | 27-Oct-2018 | 04:11 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqlwvss.dll           | 2015.130.4541.0 | 342808    | 27-Oct-2018 | 04:09 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4541.0 | 26384     | 27-Oct-2018 | 04:09 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4541.0     | 1347672   | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4541.0     | 765528    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4541.0     | 521304    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4541.0     | 989968    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4541.0     | 989784    | 27-Oct-2018 | 04:12  | x86      |
| Msmdctr130.dll                                     | 2015.130.4541.0 | 40016     | 27-Oct-2018 | 04:10  | x64      |
| Msmdlocal.dll                                      | 2015.130.4541.0 | 37103392  | 27-Oct-2018 | 04:09  | x86      |
| Msmdlocal.dll                                      | 2015.130.4541.0 | 56207952  | 27-Oct-2018 | 04:10  | x64      |
| Msmdpump.dll                                       | 2015.130.4541.0 | 7799376   | 27-Oct-2018 | 04:10  | x64      |
| Msmdredir.dll                                      | 2015.130.4541.0 | 6422304   | 27-Oct-2018 | 04:09  | x86      |
| Msmdsrv.exe                                        | 2015.130.4541.0 | 56746584  | 27-Oct-2018 | 04:11  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4541.0 | 7507232   | 27-Oct-2018 | 04:09  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4541.0 | 6507600   | 27-Oct-2018 | 04:13  | x86      |
| Msolap130.dll                                      | 2015.130.4541.0 | 7008544   | 27-Oct-2018 | 04:09  | x86      |
| Msolap130.dll                                      | 2015.130.4541.0 | 8639568   | 27-Oct-2018 | 04:10  | x64      |
| Msolui130.dll                                      | 2015.130.4541.0 | 287520    | 27-Oct-2018 | 04:09  | x86      |
| Msolui130.dll                                      | 2015.130.4541.0 | 310352    | 27-Oct-2018 | 04:10  | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10  | x64      |
| Sqlboot.dll                                        | 2015.130.4541.0 | 186448    | 27-Oct-2018 | 04:10  | x64      |
| Sqlceip.exe                                        | 13.0.4541.0     | 252496    | 27-Oct-2018 | 04:11  | x86      |
| Sqldumper.exe                                      | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10  | x86      |
| Sqldumper.exe                                      | 2015.130.4541.0 | 127056    | 27-Oct-2018 | 04:10  | x64      |
| Tmapi.dll                                          | 2015.130.4541.0 | 4346128   | 27-Oct-2018 | 04:09  | x64      |
| Tmcachemgr.dll                                     | 2015.130.4541.0 | 2826512   | 27-Oct-2018 | 04:09  | x64      |
| Tmpersistence.dll                                  | 2015.130.4541.0 | 1071376   | 27-Oct-2018 | 04:09  | x64      |
| Tmtransactions.dll                                 | 2015.130.4541.0 | 1352464   | 27-Oct-2018 | 04:09  | x64      |
| Xe.dll                                             | 2015.130.4541.0 | 626448    | 27-Oct-2018 | 04:09  | x64      |
| Xmlrw.dll                                          | 2015.130.4541.0 | 259664    | 27-Oct-2018 | 04:09  | x86      |
| Xmlrw.dll                                          | 2015.130.4541.0 | 319248    | 27-Oct-2018 | 04:09  | x64      |
| Xmlrwbin.dll                                       | 2015.130.4541.0 | 191568    | 27-Oct-2018 | 04:09  | x86      |
| Xmlrwbin.dll                                       | 2015.130.4541.0 | 227600    | 27-Oct-2018 | 04:09  | x64      |
| Xmsrv.dll                                          | 2015.130.4541.0 | 32727632  | 27-Oct-2018 | 04:09  | x86      |
| Xmsrv.dll                                          | 2015.130.4541.0 | 24050968  | 27-Oct-2018 | 04:09  | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4541.0  | 181008    | 27-Oct-2018 | 04:09 | x64      |
| Batchparser.dll                             | 2015.130.4541.0  | 160544    | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                              | 2015.130.4541.0  | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Instapi130.dll                              | 2015.130.4541.0  | 53536     | 27-Oct-2018 | 04:10 | x86      |
| Isacctchange.dll                            | 2015.130.4541.0  | 29472     | 27-Oct-2018 | 04:10 | x86      |
| Isacctchange.dll                            | 2015.130.4541.0  | 30800     | 27-Oct-2018 | 04:10 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4541.0      | 1027360   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4541.0      | 1027160   | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4541.0      | 1348896   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4541.0      | 702752    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4541.0      | 765728    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4541.0      | 521024    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4541.0      | 711968    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4541.0      | 711768    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4541.0      | 37184     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4541.0      | 46368     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4541.0  | 73024     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4541.0  | 75352     | 27-Oct-2018 | 04:11 | x64      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4541.0      | 598816    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4541.0      | 598816    | 27-Oct-2018 | 04:10 | x86      |
| Msasxpress.dll                              | 2015.130.4541.0  | 32032     | 27-Oct-2018 | 04:09 | x86      |
| Msasxpress.dll                              | 2015.130.4541.0  | 35920     | 27-Oct-2018 | 04:10 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4541.0  | 60192     | 27-Oct-2018 | 04:09 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4541.0  | 72784     | 27-Oct-2018 | 04:10 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4541.0  | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqldumper.exe                               | 2015.130.4541.0  | 107840    | 27-Oct-2018 | 04:10 | x86      |
| Sqldumper.exe                               | 2015.130.4541.0  | 127056    | 27-Oct-2018 | 04:10 | x64      |
| Sqlftacct.dll                               | 2015.130.4541.0  | 46880     | 27-Oct-2018 | 04:09 | x86      |
| Sqlftacct.dll                               | 2015.130.4541.0  | 51792     | 27-Oct-2018 | 04:10 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 04:18 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4541.0  | 404240    | 27-Oct-2018 | 04:09 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4541.0  | 364320    | 27-Oct-2018 | 04:09 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4541.0  | 37648     | 27-Oct-2018 | 04:09 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4541.0  | 35104     | 27-Oct-2018 | 04:09 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4541.0  | 348944    | 27-Oct-2018 | 04:09 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4541.0  | 267552    | 27-Oct-2018 | 04:09 | x86      |
| Sqltdiagn.dll                               | 2015.130.4541.0  | 67856     | 27-Oct-2018 | 04:09 | x64      |
| Sqltdiagn.dll                               | 2015.130.4541.0  | 60704     | 27-Oct-2018 | 04:09 | x86      |
| Svrenumapi130.dll                           | 2015.130.4541.0  | 1115920   | 27-Oct-2018 | 04:09 | x64      |
| Svrenumapi130.dll                           | 2015.130.4541.0  | 854336    | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4541.0  | 1876768   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4541.0  | 1876560   | 27-Oct-2018 | 04:13 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4541.0 | 121120    | 27-Oct-2018 | 04:10 | x86      |
| Dreplaycommon.dll              | 2015.130.4541.0 | 691008    | 27-Oct-2018 | 04:09 | x86      |
| Dreplayserverps.dll            | 2015.130.4541.0 | 33056     | 27-Oct-2018 | 04:10 | x86      |
| Dreplayutil.dll                | 2015.130.4541.0 | 310048    | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                 | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqlresourceloader.dll          | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4541.0 | 691008    | 27-Oct-2018 | 04:09 | x86      |
| Dreplaycontroller.exe              | 2015.130.4541.0 | 350496    | 27-Oct-2018 | 04:10 | x86      |
| Dreplayprocess.dll                 | 2015.130.4541.0 | 171808    | 27-Oct-2018 | 04:10 | x86      |
| Dreplayserverps.dll                | 2015.130.4541.0 | 33056     | 27-Oct-2018 | 04:10 | x86      |
| Instapi130.dll                     | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqlresourceloader.dll              | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4541.0     | 41048     | 27-Oct-2018 | 04:11  | x64      |
| Batchparser.dll                              | 2015.130.4541.0 | 181008    | 27-Oct-2018 | 04:09  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925456    | 27-Oct-2018 | 04:09  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341456   | 27-Oct-2018 | 04:09  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192080    | 27-Oct-2018 | 04:10  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4541.0 | 225360    | 27-Oct-2018 | 04:10  | x64      |
| Dcexec.exe                                   | 2015.130.4541.0 | 74328     | 27-Oct-2018 | 04:11  | x64      |
| Fssres.dll                                   | 2015.130.4541.0 | 81488     | 27-Oct-2018 | 04:10  | x64      |
| Hadrres.dll                                  | 2015.130.4541.0 | 177936    | 27-Oct-2018 | 04:09  | x64      |
| Hkcompile.dll                                | 2015.130.4541.0 | 1298192   | 27-Oct-2018 | 04:09  | x64      |
| Hkengine.dll                                 | 2015.130.4541.0 | 5601040   | 27-Oct-2018 | 04:09  | x64      |
| Hkruntime.dll                                | 2015.130.4541.0 | 158992    | 27-Oct-2018 | 04:09  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017424   | 27-Oct-2018 | 04:10  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4541.0     | 235096    | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4541.0     | 79632     | 27-Oct-2018 | 04:08  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4541.0 | 391768    | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4541.0 | 71456     | 27-Oct-2018 | 04:09  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4541.0 | 65112     | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4541.0 | 150104    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4541.0 | 158808    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4541.0 | 271960    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4541.0 | 74840     | 27-Oct-2018 | 04:11  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129808    | 27-Oct-2018 | 04:09  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559376    | 27-Oct-2018 | 04:09  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559376    | 27-Oct-2018 | 04:09  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661264    | 27-Oct-2018 | 04:09  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964880    | 27-Oct-2018 | 04:09  | x64      |
| Odsole70.dll                                 | 2015.130.4541.0 | 92752     | 27-Oct-2018 | 04:10  | x64      |
| Opends60.dll                                 | 2015.130.4541.0 | 33040     | 27-Oct-2018 | 04:09  | x64      |
| Qds.dll                                      | 2015.130.4541.0 | 845392    | 27-Oct-2018 | 04:10  | x64      |
| Rsfxft.dll                                   | 2015.130.4541.0 | 34576     | 27-Oct-2018 | 04:09  | x64      |
| Sqagtres.dll                                 | 2015.130.4541.0 | 64592     | 27-Oct-2018 | 04:10  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10  | x64      |
| Sqlaamss.dll                                 | 2015.130.4541.0 | 80704     | 27-Oct-2018 | 04:09  | x64      |
| Sqlaccess.dll                                | 2015.130.4541.0 | 462424    | 27-Oct-2018 | 04:11  | x64      |
| Sqlagent.exe                                 | 2015.130.4541.0 | 566360    | 27-Oct-2018 | 04:11  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4541.0 | 44112     | 27-Oct-2018 | 04:10  | x86      |
| Sqlagentctr130.dll                           | 2015.130.4541.0 | 51792     | 27-Oct-2018 | 04:10  | x64      |
| Sqlagentlog.dll                              | 2015.130.4541.0 | 32848     | 27-Oct-2018 | 04:10  | x64      |
| Sqlagentmail.dll                             | 2015.130.4541.0 | 47936     | 27-Oct-2018 | 04:09  | x64      |
| Sqlboot.dll                                  | 2015.130.4541.0 | 186448    | 27-Oct-2018 | 04:10  | x64      |
| Sqlceip.exe                                  | 13.0.4541.0     | 252496    | 27-Oct-2018 | 04:11  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4541.0 | 59984     | 27-Oct-2018 | 04:10  | x64      |
| Sqlctr130.dll                                | 2015.130.4541.0 | 118544    | 27-Oct-2018 | 04:09  | x64      |
| Sqlctr130.dll                                | 2015.130.4541.0 | 103712    | 27-Oct-2018 | 04:09  | x86      |
| Sqldk.dll                                    | 2015.130.4541.0 | 2585680   | 27-Oct-2018 | 04:10  | x64      |
| Sqldtsss.dll                                 | 2015.130.4541.0 | 97568     | 27-Oct-2018 | 04:09  | x64      |
| Sqliosim.com                                 | 2015.130.4541.0 | 307792    | 27-Oct-2018 | 04:10  | x64      |
| Sqliosim.exe                                 | 2015.130.4541.0 | 3014232   | 27-Oct-2018 | 04:11  | x64      |
| Sqllang.dll                                  | 2015.130.4541.0 | 39451216  | 27-Oct-2018 | 04:10  | x64      |
| Sqlmin.dll                                   | 2015.130.4541.0 | 37713680  | 27-Oct-2018 | 04:09  | x64      |
| Sqlolapss.dll                                | 2015.130.4541.0 | 98080     | 27-Oct-2018 | 04:09  | x64      |
| Sqlos.dll                                    | 2015.130.4541.0 | 26384     | 27-Oct-2018 | 04:09  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4541.0 | 58640     | 27-Oct-2018 | 04:09  | x64      |
| Sqlrepss.dll                                 | 2015.130.4541.0 | 55056     | 27-Oct-2018 | 04:09  | x64      |
| Sqlresld.dll                                 | 2015.130.4541.0 | 30992     | 27-Oct-2018 | 04:09  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4541.0 | 31000     | 27-Oct-2018 | 04:09  | x64      |
| Sqlscm.dll                                   | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4541.0 | 27920     | 27-Oct-2018 | 04:09  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4541.0 | 5798680   | 27-Oct-2018 | 04:09  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4541.0 | 732952    | 27-Oct-2018 | 04:09  | x64      |
| Sqlservr.exe                                 | 2015.130.4541.0 | 392792    | 27-Oct-2018 | 04:11  | x64      |
| Sqlsvc.dll                                   | 2015.130.4541.0 | 152336    | 27-Oct-2018 | 04:09  | x64      |
| Sqltses.dll                                  | 2015.130.4541.0 | 8922384   | 27-Oct-2018 | 04:09  | x64      |
| Sqsrvres.dll                                 | 2015.130.4541.0 | 251152    | 27-Oct-2018 | 04:09  | x64      |
| Stretchcodegen.exe                           | 13.0.4541.0     | 55888     | 27-Oct-2018 | 04:11  | x86      |
| Xe.dll                                       | 2015.130.4541.0 | 626448    | 27-Oct-2018 | 04:09  | x64      |
| Xmlrw.dll                                    | 2015.130.4541.0 | 319248    | 27-Oct-2018 | 04:09  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4541.0 | 227600    | 27-Oct-2018 | 04:09  | x64      |
| Xpadsi.exe                                   | 2015.130.4541.0 | 78928     | 27-Oct-2018 | 04:13  | x64      |
| Xplog70.dll                                  | 2015.130.4541.0 | 65808     | 27-Oct-2018 | 04:09  | x64      |
| Xpqueue.dll                                  | 2015.130.4541.0 | 75024     | 27-Oct-2018 | 04:09  | x64      |
| Xprepl.dll                                   | 2015.130.4541.0 | 91408     | 27-Oct-2018 | 04:09  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4541.0 | 33552     | 27-Oct-2018 | 04:09  | x64      |
| Xpstar.dll                                   | 2015.130.4541.0 | 422672    | 27-Oct-2018 | 04:09  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4541.0 | 181008    | 27-Oct-2018 | 04:09  | x64      |
| Batchparser.dll                                                    | 2015.130.4541.0 | 160544    | 27-Oct-2018 | 04:10  | x86      |
| Bcp.exe                                                            | 2015.130.4541.0 | 119888    | 27-Oct-2018 | 04:10  | x64      |
| Commanddest.dll                                                    | 2015.130.4541.0 | 248912    | 27-Oct-2018 | 04:10  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4541.0 | 115792    | 27-Oct-2018 | 04:10  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4541.0 | 187984    | 27-Oct-2018 | 04:10  | x64      |
| Distrib.exe                                                        | 2015.130.4541.0 | 191064    | 27-Oct-2018 | 04:11  | x64      |
| Dteparse.dll                                                       | 2015.130.4541.0 | 109648    | 27-Oct-2018 | 04:10  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4541.0 | 88664     | 27-Oct-2018 | 04:12  | x64      |
| Dtepkg.dll                                                         | 2015.130.4541.0 | 137296    | 27-Oct-2018 | 04:10  | x64      |
| Dtexec.exe                                                         | 2015.130.4541.0 | 72792     | 27-Oct-2018 | 04:11  | x64      |
| Dts.dll                                                            | 2015.130.4541.0 | 3146832   | 27-Oct-2018 | 04:10  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4541.0 | 477264    | 27-Oct-2018 | 04:10  | x64      |
| Dtsconn.dll                                                        | 2015.130.4541.0 | 492624    | 27-Oct-2018 | 04:10  | x64      |
| Dtshost.exe                                                        | 2015.130.4541.0 | 86608     | 27-Oct-2018 | 04:11  | x64      |
| Dtslog.dll                                                         | 2015.130.4541.0 | 120400    | 27-Oct-2018 | 04:10  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4541.0 | 545360    | 27-Oct-2018 | 04:10  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4541.0 | 1279056   | 27-Oct-2018 | 04:10  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4541.0 | 48208     | 27-Oct-2018 | 04:10  | x64      |
| Dtswizard.exe                                                      | 13.0.4541.0     | 895568    | 27-Oct-2018 | 04:11  | x64      |
| Dtuparse.dll                                                       | 2015.130.4541.0 | 87632     | 27-Oct-2018 | 04:10  | x64      |
| Dtutil.exe                                                         | 2015.130.4541.0 | 134744    | 27-Oct-2018 | 04:11  | x64      |
| Exceldest.dll                                                      | 2015.130.4541.0 | 263760    | 27-Oct-2018 | 04:10  | x64      |
| Excelsrc.dll                                                       | 2015.130.4541.0 | 285264    | 27-Oct-2018 | 04:10  | x64      |
| Execpackagetask.dll                                                | 2015.130.4541.0 | 166480    | 27-Oct-2018 | 04:10  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4541.0 | 389200    | 27-Oct-2018 | 04:10  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4541.0 | 401488    | 27-Oct-2018 | 04:10  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4541.0 | 96336     | 27-Oct-2018 | 04:10  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4541.0 | 59152     | 27-Oct-2018 | 04:09  | x64      |
| Logread.exe                                                        | 2015.130.4541.0 | 617048    | 27-Oct-2018 | 04:11  | x64      |
| Mergetxt.dll                                                       | 2015.130.4541.0 | 53840     | 27-Oct-2018 | 04:10  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4541.0     | 1313368   | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4541.0     | 696408    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4541.0     | 763480    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 25-Oct-2018 | 18:43 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4541.0     | 54360     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4541.0     | 89688     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4541.0     | 49752     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4541.0     | 43096     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4541.0     | 70744     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4541.0     | 35416     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4541.0     | 73304     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4541.0     | 63576     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4541.0     | 31320     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4541.0     | 131360    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4541.0     | 43808     | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4541.0     | 57632     | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4541.0     | 215328    | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4541.0 | 1639200   | 27-Oct-2018 | 04:09  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4541.0 | 150104    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4541.0 | 158808    | 27-Oct-2018 | 04:11  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4541.0 | 100944    | 27-Oct-2018 | 04:10  | x64      |
| Msgprox.dll                                                        | 2015.130.4541.0 | 275536    | 27-Oct-2018 | 04:10  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4541.0 | 1494800   | 27-Oct-2018 | 04:09  | x64      |
| Oledbdest.dll                                                      | 2015.130.4541.0 | 264272    | 27-Oct-2018 | 04:10  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4541.0 | 290896    | 27-Oct-2018 | 04:10  | x64      |
| Osql.exe                                                           | 2015.130.4541.0 | 75344     | 27-Oct-2018 | 04:10  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4541.0 | 469080    | 27-Oct-2018 | 04:11  | x64      |
| Rawdest.dll                                                        | 2015.130.4541.0 | 209488    | 27-Oct-2018 | 04:10  | x64      |
| Rawsource.dll                                                      | 2015.130.4541.0 | 196688    | 27-Oct-2018 | 04:10  | x64      |
| Rdistcom.dll                                                       | 2015.130.4541.0 | 894032    | 27-Oct-2018 | 04:10  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4541.0 | 187472    | 27-Oct-2018 | 04:10  | x64      |
| Replagnt.dll                                                       | 2015.130.4541.0 | 30800     | 27-Oct-2018 | 04:10  | x64      |
| Repldp.dll                                                         | 2015.130.4541.0 | 277072    | 27-Oct-2018 | 04:10  | x64      |
| Replerrx.dll                                                       | 2015.130.4541.0 | 144464    | 27-Oct-2018 | 04:10  | x64      |
| Replisapi.dll                                                      | 2015.130.4541.0 | 354384    | 27-Oct-2018 | 04:10  | x64      |
| Replmerg.exe                                                       | 2015.130.4541.0 | 518744    | 27-Oct-2018 | 04:11  | x64      |
| Replprov.dll                                                       | 2015.130.4541.0 | 812112    | 27-Oct-2018 | 04:10  | x64      |
| Replrec.dll                                                        | 2015.130.4541.0 | 1018656   | 27-Oct-2018 | 04:09  | x64      |
| Replsub.dll                                                        | 2015.130.4541.0 | 467536    | 27-Oct-2018 | 04:10  | x64      |
| Replsync.dll                                                       | 2015.130.4541.0 | 143952    | 27-Oct-2018 | 04:10  | x64      |
| Spresolv.dll                                                       | 2015.130.4541.0 | 245328    | 27-Oct-2018 | 04:10  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4541.0 | 249424    | 27-Oct-2018 | 04:10  | x64      |
| Sqldiag.exe                                                        | 2015.130.4541.0 | 1257560   | 27-Oct-2018 | 04:11  | x64      |
| Sqldistx.dll                                                       | 2015.130.4541.0 | 215632    | 27-Oct-2018 | 04:10  | x64      |
| Sqllogship.exe                                                     | 13.0.4541.0     | 100432    | 27-Oct-2018 | 04:11  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4541.0 | 346896    | 27-Oct-2018 | 04:09  | x64      |
| Sqlps.exe                                                          | 13.0.4541.0     | 60192     | 27-Oct-2018 | 04:09  | x86      |
| Sqlresld.dll                                                       | 2015.130.4541.0 | 30992     | 27-Oct-2018 | 04:09  | x64      |
| Sqlresld.dll                                                       | 2015.130.4541.0 | 28960     | 27-Oct-2018 | 04:09  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4541.0 | 31000     | 27-Oct-2018 | 04:09  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09  | x86      |
| Sqlscm.dll                                                         | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09  | x64      |
| Sqlscm.dll                                                         | 2015.130.4541.0 | 53024     | 27-Oct-2018 | 04:09  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4541.0 | 152336    | 27-Oct-2018 | 04:09  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4541.0 | 127264    | 27-Oct-2018 | 04:09  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4541.0 | 181008    | 27-Oct-2018 | 04:09  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4541.0 | 105744    | 27-Oct-2018 | 04:09  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4541.0 | 33552     | 27-Oct-2018 | 04:09  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4541.0 | 216344    | 27-Oct-2018 | 04:09  | x64      |
| Ssradd.dll                                                         | 2015.130.4541.0 | 65296     | 27-Oct-2018 | 04:09  | x64      |
| Ssravg.dll                                                         | 2015.130.4541.0 | 65296     | 27-Oct-2018 | 04:09  | x64      |
| Ssrdown.dll                                                        | 2015.130.4541.0 | 50960     | 27-Oct-2018 | 04:09  | x64      |
| Ssrmax.dll                                                         | 2015.130.4541.0 | 63760     | 27-Oct-2018 | 04:09  | x64      |
| Ssrmin.dll                                                         | 2015.130.4541.0 | 63760     | 27-Oct-2018 | 04:09  | x64      |
| Ssrpub.dll                                                         | 2015.130.4541.0 | 51480     | 27-Oct-2018 | 04:09  | x64      |
| Ssrup.dll                                                          | 2015.130.4541.0 | 50960     | 27-Oct-2018 | 04:09  | x64      |
| Txagg.dll                                                          | 2015.130.4541.0 | 364816    | 27-Oct-2018 | 04:09  | x64      |
| Txbdd.dll                                                          | 2015.130.4541.0 | 172824    | 27-Oct-2018 | 04:09  | x64      |
| Txdatacollector.dll                                                | 2015.130.4541.0 | 367888    | 27-Oct-2018 | 04:09  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4541.0 | 296720    | 27-Oct-2018 | 04:09  | x64      |
| Txderived.dll                                                      | 2015.130.4541.0 | 608016    | 27-Oct-2018 | 04:09  | x64      |
| Txlookup.dll                                                       | 2015.130.4541.0 | 532752    | 27-Oct-2018 | 04:09  | x64      |
| Txmerge.dll                                                        | 2015.130.4541.0 | 230160    | 27-Oct-2018 | 04:09  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4541.0 | 278808    | 27-Oct-2018 | 04:09  | x64      |
| Txmulticast.dll                                                    | 2015.130.4541.0 | 128784    | 27-Oct-2018 | 04:09  | x64      |
| Txrowcount.dll                                                     | 2015.130.4541.0 | 126736    | 27-Oct-2018 | 04:09  | x64      |
| Txsort.dll                                                         | 2015.130.4541.0 | 258832    | 27-Oct-2018 | 04:09  | x64      |
| Txsplit.dll                                                        | 2015.130.4541.0 | 600848    | 27-Oct-2018 | 04:09  | x64      |
| Txunionall.dll                                                     | 2015.130.4541.0 | 182032    | 27-Oct-2018 | 04:09  | x64      |
| Xe.dll                                                             | 2015.130.4541.0 | 626448    | 27-Oct-2018 | 04:09  | x64      |
| Xmlrw.dll                                                          | 2015.130.4541.0 | 319248    | 27-Oct-2018 | 04:09  | x64      |
| Xmlsub.dll                                                         | 2015.130.4541.0 | 251152    | 27-Oct-2018 | 04:09  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4541.0 | 1013840   | 27-Oct-2018 | 04:10 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqlsatellite.dll              | 2015.130.4541.0 | 837400    | 27-Oct-2018 | 04:09 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4541.0 | 660240    | 27-Oct-2018 | 04:09 | x64      |
| Fdhost.exe               | 2015.130.4541.0 | 105040    | 27-Oct-2018 | 04:10 | x64      |
| Fdlauncher.exe           | 2015.130.4541.0 | 51280     | 27-Oct-2018 | 04:10 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqlft130ph.dll           | 2015.130.4541.0 | 58128     | 27-Oct-2018 | 04:09 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4541.0     | 23640     | 27-Oct-2018 | 04:12 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 19-Aug-2018 | 0:48  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 03-Sep-2018  | 15:02 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 19-Aug-2018 | 0:48  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 03-Sep-2018  | 15:02 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 19-Aug-2018 | 0:48  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 03-Sep-2018  | 15:02 | x86      |
| Commanddest.dll                                                    | 2015.130.4541.0 | 203040    | 27-Oct-2018 | 04:10  | x86      |
| Commanddest.dll                                                    | 2015.130.4541.0 | 248912    | 27-Oct-2018 | 04:10  | x64      |
| Dteparse.dll                                                       | 2015.130.4541.0 | 99616     | 27-Oct-2018 | 04:10  | x86      |
| Dteparse.dll                                                       | 2015.130.4541.0 | 109648    | 27-Oct-2018 | 04:10  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4541.0 | 83744     | 27-Oct-2018 | 04:09  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4541.0 | 88664     | 27-Oct-2018 | 04:12  | x64      |
| Dtepkg.dll                                                         | 2015.130.4541.0 | 116000    | 27-Oct-2018 | 04:10  | x86      |
| Dtepkg.dll                                                         | 2015.130.4541.0 | 137296    | 27-Oct-2018 | 04:10  | x64      |
| Dtexec.exe                                                         | 2015.130.4541.0 | 66848     | 27-Oct-2018 | 04:10  | x86      |
| Dtexec.exe                                                         | 2015.130.4541.0 | 72792     | 27-Oct-2018 | 04:11  | x64      |
| Dts.dll                                                            | 2015.130.4541.0 | 2632992   | 27-Oct-2018 | 04:10  | x86      |
| Dts.dll                                                            | 2015.130.4541.0 | 3146832   | 27-Oct-2018 | 04:10  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4541.0 | 419136    | 27-Oct-2018 | 04:10  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4541.0 | 477264    | 27-Oct-2018 | 04:10  | x64      |
| Dtsconn.dll                                                        | 2015.130.4541.0 | 392480    | 27-Oct-2018 | 04:10  | x86      |
| Dtsconn.dll                                                        | 2015.130.4541.0 | 492624    | 27-Oct-2018 | 04:10  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4541.0 | 93984     | 27-Oct-2018 | 04:10  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4541.0 | 109656    | 27-Oct-2018 | 04:11  | x64      |
| Dtshost.exe                                                        | 2015.130.4541.0 | 76576     | 27-Oct-2018 | 04:10  | x86      |
| Dtshost.exe                                                        | 2015.130.4541.0 | 86608     | 27-Oct-2018 | 04:11  | x64      |
| Dtslog.dll                                                         | 2015.130.4541.0 | 103200    | 27-Oct-2018 | 04:10  | x86      |
| Dtslog.dll                                                         | 2015.130.4541.0 | 120400    | 27-Oct-2018 | 04:10  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4541.0 | 541472    | 27-Oct-2018 | 04:10  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4541.0 | 545360    | 27-Oct-2018 | 04:10  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4541.0 | 1059616   | 27-Oct-2018 | 04:10  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4541.0 | 1279056   | 27-Oct-2018 | 04:10  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4541.0 | 42272     | 27-Oct-2018 | 04:10  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4541.0 | 48208     | 27-Oct-2018 | 04:10  | x64      |
| Dtswizard.exe                                                      | 13.0.4541.0     | 896288    | 27-Oct-2018 | 03:59  | x86      |
| Dtswizard.exe                                                      | 13.0.4541.0     | 895568    | 27-Oct-2018 | 04:11  | x64      |
| Dtuparse.dll                                                       | 2015.130.4541.0 | 80192     | 27-Oct-2018 | 04:10  | x86      |
| Dtuparse.dll                                                       | 2015.130.4541.0 | 87632     | 27-Oct-2018 | 04:10  | x64      |
| Dtutil.exe                                                         | 2015.130.4541.0 | 115520    | 27-Oct-2018 | 04:10  | x86      |
| Dtutil.exe                                                         | 2015.130.4541.0 | 134744    | 27-Oct-2018 | 04:11  | x64      |
| Exceldest.dll                                                      | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:10  | x86      |
| Exceldest.dll                                                      | 2015.130.4541.0 | 263760    | 27-Oct-2018 | 04:10  | x64      |
| Excelsrc.dll                                                       | 2015.130.4541.0 | 232736    | 27-Oct-2018 | 04:10  | x86      |
| Excelsrc.dll                                                       | 2015.130.4541.0 | 285264    | 27-Oct-2018 | 04:10  | x64      |
| Execpackagetask.dll                                                | 2015.130.4541.0 | 135488    | 27-Oct-2018 | 04:10  | x86      |
| Execpackagetask.dll                                                | 2015.130.4541.0 | 166480    | 27-Oct-2018 | 04:10  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4541.0 | 334624    | 27-Oct-2018 | 04:10  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4541.0 | 389200    | 27-Oct-2018 | 04:10  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4541.0 | 345376    | 27-Oct-2018 | 04:10  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4541.0 | 401488    | 27-Oct-2018 | 04:10  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4541.0 | 80672     | 27-Oct-2018 | 04:10  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4541.0 | 96336     | 27-Oct-2018 | 04:10  | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4541.0     | 440128    | 27-Oct-2018 | 03:59  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4541.0     | 438864    | 27-Oct-2018 | 04:11  | x64      |
| Isserverexec.exe                                                   | 13.0.4541.0     | 132928    | 27-Oct-2018 | 03:59  | x86      |
| Isserverexec.exe                                                   | 13.0.4541.0     | 132176    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4541.0     | 1313568   | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4541.0     | 1313368   | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4541.0     | 696608    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4541.0     | 696408    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4541.0     | 763680    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4541.0     | 763480    | 27-Oct-2018 | 04:12  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 24-Oct-2018 | 23:54 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 25-Oct-2018 | 18:43 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4541.0     | 73304     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4541.0 | 107280    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4541.0 | 112216    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4541.0     | 54560     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4541.0     | 54360     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4541.0     | 89888     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4541.0     | 89688     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4541.0     | 43296     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4541.0     | 43096     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4541.0     | 35616     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4541.0     | 35416     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4541.0     | 73504     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4541.0     | 73304     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4541.0     | 31520     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4541.0     | 31320     | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4541.0     | 469792    | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4541.0     | 469592    | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4541.0     | 43808     | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4541.0     | 43808     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4541.0     | 57632     | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4541.0     | 57664     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4541.0     | 53056     | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4541.0     | 53024     | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:09  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:10  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4541.0 | 150104    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4541.0 | 138832    | 27-Oct-2018 | 04:11  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4541.0 | 158808    | 27-Oct-2018 | 04:11  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4541.0 | 144464    | 27-Oct-2018 | 04:11  | x86      |
| Msdtssrvr.exe                                                      | 13.0.4541.0     | 216656    | 27-Oct-2018 | 04:11  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4541.0 | 89888     | 27-Oct-2018 | 04:09  | x86      |
| Msdtssrvrutil.dll                                                  | 2015.130.4541.0 | 100944    | 27-Oct-2018 | 04:10  | x64      |
| Msmdpp.dll                                                         | 2015.130.4541.0 | 7647312   | 27-Oct-2018 | 04:10  | x64      |
| Oledbdest.dll                                                      | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:09  | x86      |
| Oledbdest.dll                                                      | 2015.130.4541.0 | 264272    | 27-Oct-2018 | 04:10  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4541.0 | 235808    | 27-Oct-2018 | 04:09  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4541.0 | 290896    | 27-Oct-2018 | 04:10  | x64      |
| Rawdest.dll                                                        | 2015.130.4541.0 | 168736    | 27-Oct-2018 | 04:09  | x86      |
| Rawdest.dll                                                        | 2015.130.4541.0 | 209488    | 27-Oct-2018 | 04:10  | x64      |
| Rawsource.dll                                                      | 2015.130.4541.0 | 155424    | 27-Oct-2018 | 04:09  | x86      |
| Rawsource.dll                                                      | 2015.130.4541.0 | 196688    | 27-Oct-2018 | 04:10  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4541.0 | 151840    | 27-Oct-2018 | 04:09  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4541.0 | 187472    | 27-Oct-2018 | 04:10  | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10  | x64      |
| Sqlceip.exe                                                        | 13.0.4541.0     | 252496    | 27-Oct-2018 | 04:11  | x86      |
| Sqldest.dll                                                        | 2015.130.4541.0 | 215840    | 27-Oct-2018 | 04:09  | x86      |
| Sqldest.dll                                                        | 2015.130.4541.0 | 263760    | 27-Oct-2018 | 04:10  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4541.0 | 181008    | 27-Oct-2018 | 04:09  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4541.0 | 151328    | 27-Oct-2018 | 04:09  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4541.0 | 216344    | 27-Oct-2018 | 04:09  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4541.0 | 176928    | 27-Oct-2018 | 04:09  | x86      |
| Txagg.dll                                                          | 2015.130.4541.0 | 304720    | 27-Oct-2018 | 04:09  | x86      |
| Txagg.dll                                                          | 2015.130.4541.0 | 364816    | 27-Oct-2018 | 04:09  | x64      |
| Txbdd.dll                                                          | 2015.130.4541.0 | 138320    | 27-Oct-2018 | 04:09  | x86      |
| Txbdd.dll                                                          | 2015.130.4541.0 | 172824    | 27-Oct-2018 | 04:09  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4541.0 | 496208    | 27-Oct-2018 | 04:09  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4541.0 | 611600    | 27-Oct-2018 | 04:09  | x64      |
| Txcache.dll                                                        | 2015.130.4541.0 | 148048    | 27-Oct-2018 | 04:09  | x86      |
| Txcache.dll                                                        | 2015.130.4541.0 | 183568    | 27-Oct-2018 | 04:09  | x64      |
| Txcharmap.dll                                                      | 2015.130.4541.0 | 250448    | 27-Oct-2018 | 04:09  | x86      |
| Txcharmap.dll                                                      | 2015.130.4541.0 | 290064    | 27-Oct-2018 | 04:09  | x64      |
| Txcopymap.dll                                                      | 2015.130.4541.0 | 147536    | 27-Oct-2018 | 04:09  | x86      |
| Txcopymap.dll                                                      | 2015.130.4541.0 | 183568    | 27-Oct-2018 | 04:09  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4541.0 | 255056    | 27-Oct-2018 | 04:09  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4541.0 | 296720    | 27-Oct-2018 | 04:09  | x64      |
| Txderived.dll                                                      | 2015.130.4541.0 | 519248    | 27-Oct-2018 | 04:09  | x86      |
| Txderived.dll                                                      | 2015.130.4541.0 | 608016    | 27-Oct-2018 | 04:09  | x64      |
| Txfileextractor.dll                                                | 2015.130.4541.0 | 162896    | 27-Oct-2018 | 04:09  | x86      |
| Txfileextractor.dll                                                | 2015.130.4541.0 | 202000    | 27-Oct-2018 | 04:09  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4541.0 | 160848    | 27-Oct-2018 | 04:09  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4541.0 | 199960    | 27-Oct-2018 | 04:09  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4541.0 | 231504    | 27-Oct-2018 | 04:09  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4541.0 | 291088    | 27-Oct-2018 | 04:09  | x64      |
| Txlineage.dll                                                      | 2015.130.4541.0 | 109136    | 27-Oct-2018 | 04:09  | x86      |
| Txlineage.dll                                                      | 2015.130.4541.0 | 137488    | 27-Oct-2018 | 04:09  | x64      |
| Txlookup.dll                                                       | 2015.130.4541.0 | 449616    | 27-Oct-2018 | 04:09  | x86      |
| Txlookup.dll                                                       | 2015.130.4541.0 | 532752    | 27-Oct-2018 | 04:09  | x64      |
| Txmerge.dll                                                        | 2015.130.4541.0 | 176208    | 27-Oct-2018 | 04:09  | x86      |
| Txmerge.dll                                                        | 2015.130.4541.0 | 230160    | 27-Oct-2018 | 04:09  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4541.0 | 223824    | 27-Oct-2018 | 04:09  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4541.0 | 278808    | 27-Oct-2018 | 04:09  | x64      |
| Txmulticast.dll                                                    | 2015.130.4541.0 | 101968    | 27-Oct-2018 | 04:09  | x86      |
| Txmulticast.dll                                                    | 2015.130.4541.0 | 128784    | 27-Oct-2018 | 04:09  | x64      |
| Txpivot.dll                                                        | 2015.130.4541.0 | 181840    | 27-Oct-2018 | 04:09  | x86      |
| Txpivot.dll                                                        | 2015.130.4541.0 | 228112    | 27-Oct-2018 | 04:09  | x64      |
| Txrowcount.dll                                                     | 2015.130.4541.0 | 101456    | 27-Oct-2018 | 04:09  | x86      |
| Txrowcount.dll                                                     | 2015.130.4541.0 | 126736    | 27-Oct-2018 | 04:09  | x64      |
| Txsampling.dll                                                     | 2015.130.4541.0 | 134736    | 27-Oct-2018 | 04:09  | x86      |
| Txsampling.dll                                                     | 2015.130.4541.0 | 172304    | 27-Oct-2018 | 04:09  | x64      |
| Txscd.dll                                                          | 2015.130.4541.0 | 169552    | 27-Oct-2018 | 04:09  | x86      |
| Txscd.dll                                                          | 2015.130.4541.0 | 220432    | 27-Oct-2018 | 04:09  | x64      |
| Txsort.dll                                                         | 2015.130.4541.0 | 210512    | 27-Oct-2018 | 04:09  | x86      |
| Txsort.dll                                                         | 2015.130.4541.0 | 258832    | 27-Oct-2018 | 04:09  | x64      |
| Txsplit.dll                                                        | 2015.130.4541.0 | 513616    | 27-Oct-2018 | 04:09  | x86      |
| Txsplit.dll                                                        | 2015.130.4541.0 | 600848    | 27-Oct-2018 | 04:09  | x64      |
| Txtermextraction.dll                                               | 2015.130.4541.0 | 8615504   | 27-Oct-2018 | 04:09  | x86      |
| Txtermextraction.dll                                               | 2015.130.4541.0 | 8678160   | 27-Oct-2018 | 04:09  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4541.0 | 4107344   | 27-Oct-2018 | 04:09  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4541.0 | 4158736   | 27-Oct-2018 | 04:09  | x64      |
| Txunionall.dll                                                     | 2015.130.4541.0 | 138832    | 27-Oct-2018 | 04:09  | x86      |
| Txunionall.dll                                                     | 2015.130.4541.0 | 182032    | 27-Oct-2018 | 04:09  | x64      |
| Txunpivot.dll                                                      | 2015.130.4541.0 | 162384    | 27-Oct-2018 | 04:09  | x86      |
| Txunpivot.dll                                                      | 2015.130.4541.0 | 202512    | 27-Oct-2018 | 04:09  | x64      |
| Xe.dll                                                             | 2015.130.4541.0 | 626448    | 27-Oct-2018 | 04:09  | x64      |
| Xe.dll                                                             | 2015.130.4541.0 | 558880    | 27-Oct-2018 | 04:10  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 00:09 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 00:09 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 00:09 | x86      |
| Instapi130.dll                                                       | 2015.130.4541.0  | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.43     | 74416     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.43     | 201896    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.43     | 2347184   | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.43     | 102064    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.43     | 378544    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.43     | 185512    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.43     | 127144    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.43     | 63152     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.43     | 52400     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.43     | 87208     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.43     | 721584    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.43     | 87208     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.43     | 78000     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.43     | 41640     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.43     | 36528     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.43     | 47792     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.43     | 27304     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.43     | 32936     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.43     | 118952    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.43     | 94384     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.43     | 108208    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.43     | 256680    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 102056    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 118952    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 125608    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 117928    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 113328    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 145576    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 100016    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 114864    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.43     | 69296     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.43     | 28336     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.43     | 43696     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.43     | 82096     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.43     | 136872    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.43     | 2155688   | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.43     | 3818672   | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 107688    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119976    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 124592    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121008    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 133296    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121000    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 118448    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 152240    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 105136    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119472    | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.43     | 66736     | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.43     | 2756272   | 02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.43     | 752296    | 02-Feb-2018  | 00:09 | x86      |
| Mpdwinterop.dll                                                      | 2015.130.4541.0  | 394328    | 27-Oct-2018 | 04:11 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4541.0  | 6614096   | 27-Oct-2018 | 04:13 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4541.0  | 2155280   | 27-Oct-2018 | 04:09 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 00:09 | x64      |
| Sqldk.dll                                                            | 2015.130.4541.0  | 2530576   | 27-Oct-2018 | 04:09 | x64      |
| Sqldumper.exe                                                        | 2015.130.4541.0  | 127056    | 27-Oct-2018 | 04:13 | x64      |
| Sqlos.dll                                                            | 2015.130.4541.0  | 26384     | 27-Oct-2018 | 04:09 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 00:09 | x64      |
| Sqltses.dll                                                          | 2015.130.4541.0  | 9091344   | 27-Oct-2018 | 04:09 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.4541.0     | 610904    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.authorization.dll             | 13.0.4541.0     | 78936     | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4541.0     | 210520    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4541.0     | 168536    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4541.0     | 1620056   | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4541.0     | 657488    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4541.0     | 329816    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4541.0     | 1072216   | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532240    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532048    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532256    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532256    | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532048    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532240    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532056    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532048    | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532048    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4541.0     | 532240    | 27-Oct-2018 | 04:08 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4541.0     | 48728     | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4541.0     | 162904    | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4541.0     | 76560     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4541.0     | 76376     | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4541.0     | 126040    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4541.0     | 106072    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4541.0     | 5959256   | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420368   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420688   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4421408   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420896   | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4421200   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4421392   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420696   | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4421712   | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420176   | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4541.0     | 4420880   | 27-Oct-2018 | 04:08 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4541.0     | 10886232  | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4541.0     | 100944    | 27-Oct-2018 | 04:11 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4541.0     | 72792     | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4541.0     | 5951576   | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4541.0     | 245848    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4541.0     | 298072    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4541.0     | 208472    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 44816     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48928     | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48720     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48928     | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 52816     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48728     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48720     | 27-Oct-2018 | 04:12 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 52816     | 27-Oct-2018 | 04:13 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 44624     | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4541.0     | 48912     | 27-Oct-2018 | 04:08 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4541.0     | 510552    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4541.0 | 47704     | 27-Oct-2018 | 04:11 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4541.0     | 496728    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4541.0 | 396880    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4541.0 | 391768    | 27-Oct-2018 | 04:11 | x86      |
| Msmdlocal.dll                                             | 2015.130.4541.0 | 37103392  | 27-Oct-2018 | 04:09 | x86      |
| Msmdlocal.dll                                             | 2015.130.4541.0 | 56207952  | 27-Oct-2018 | 04:10 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4541.0 | 7507232   | 27-Oct-2018 | 04:09 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4541.0 | 6507600   | 27-Oct-2018 | 04:13 | x86      |
| Msolap130.dll                                             | 2015.130.4541.0 | 7008544   | 27-Oct-2018 | 04:09 | x86      |
| Msolap130.dll                                             | 2015.130.4541.0 | 8639568   | 27-Oct-2018 | 04:10 | x64      |
| Msolui130.dll                                             | 2015.130.4541.0 | 287520    | 27-Oct-2018 | 04:09 | x86      |
| Msolui130.dll                                             | 2015.130.4541.0 | 310352    | 27-Oct-2018 | 04:10 | x64      |
| Reportingservicescompression.dll                          | 2015.130.4541.0 | 62544     | 27-Oct-2018 | 04:10 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4541.0     | 84768     | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4541.0     | 2543904   | 27-Oct-2018 | 04:09 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4541.0 | 108832    | 27-Oct-2018 | 04:09 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4541.0 | 114256    | 27-Oct-2018 | 04:13 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4541.0 | 99104     | 27-Oct-2018 | 04:09 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4541.0 | 2573400   | 27-Oct-2018 | 04:11 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4541.0     | 2710848   | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 868112    | 27-Oct-2018 | 04:08 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872016    | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872024    | 27-Oct-2018 | 04:10 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872208    | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 876112    | 27-Oct-2018 | 04:10 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872016    | 27-Oct-2018 | 4:14 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872224    | 27-Oct-2018 | 04:10 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 884312    | 27-Oct-2018 | 04:11 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 868160    | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4541.0     | 872224    | 27-Oct-2018 | 04:12 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4541.0 | 3590944   | 27-Oct-2018 | 04:09 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4541.0 | 3662928   | 27-Oct-2018 | 04:10 | x64      |
| Rsconfigtool.exe                                          | 13.0.4541.0     | 1405728   | 27-Oct-2018 | 04:09 | x86      |
| Rsctr.dll                                                 | 2015.130.4541.0 | 51488     | 27-Oct-2018 | 04:09 | x86      |
| Rsctr.dll                                                 | 2015.130.4541.0 | 58448     | 27-Oct-2018 | 04:10 | x64      |
| Rshttpruntime.dll                                         | 2015.130.4541.0 | 99616     | 27-Oct-2018 | 04:09 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqldumper.exe                                             | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10 | x86      |
| Sqldumper.exe                                             | 2015.130.4541.0 | 127056    | 27-Oct-2018 | 04:10 | x64      |
| Sqlrsos.dll                                               | 2015.130.4541.0 | 26384     | 27-Oct-2018 | 04:09 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4541.0 | 732952    | 27-Oct-2018 | 04:09 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4541.0 | 584480    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrw.dll                                                 | 2015.130.4541.0 | 259664    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrw.dll                                                 | 2015.130.4541.0 | 319248    | 27-Oct-2018 | 04:09 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4541.0 | 191568    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4541.0 | 227600    | 27-Oct-2018 | 04:09 | x64      |
| Xmsrv.dll                                                 | 2015.130.4541.0 | 32727632  | 27-Oct-2018 | 04:09 | x86      |
| Xmsrv.dll                                                 | 2015.130.4541.0 | 24050968  | 27-Oct-2018 | 04:09 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.4541.0     | 23840     | 27-Oct-2018 | 04:09 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4541.0 | 1312032   | 27-Oct-2018 | 04:10 | x86      |
| Ddsshapes.dll                                   | 2015.130.4541.0 | 136000    | 27-Oct-2018 | 04:10 | x86      |
| Dtaengine.exe                                   | 2015.130.4541.0 | 167200    | 27-Oct-2018 | 04:10 | x86      |
| Dteparse.dll                                    | 2015.130.4541.0 | 99616     | 27-Oct-2018 | 04:10 | x86      |
| Dteparse.dll                                    | 2015.130.4541.0 | 109648    | 27-Oct-2018 | 04:10 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4541.0 | 83744     | 27-Oct-2018 | 04:09 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4541.0 | 88664     | 27-Oct-2018 | 04:12 | x64      |
| Dtepkg.dll                                      | 2015.130.4541.0 | 116000    | 27-Oct-2018 | 04:10 | x86      |
| Dtepkg.dll                                      | 2015.130.4541.0 | 137296    | 27-Oct-2018 | 04:10 | x64      |
| Dtexec.exe                                      | 2015.130.4541.0 | 66848     | 27-Oct-2018 | 04:10 | x86      |
| Dtexec.exe                                      | 2015.130.4541.0 | 72792     | 27-Oct-2018 | 04:11 | x64      |
| Dts.dll                                         | 2015.130.4541.0 | 2632992   | 27-Oct-2018 | 04:10 | x86      |
| Dts.dll                                         | 2015.130.4541.0 | 3146832   | 27-Oct-2018 | 04:10 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4541.0 | 419136    | 27-Oct-2018 | 04:10 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4541.0 | 477264    | 27-Oct-2018 | 04:10 | x64      |
| Dtsconn.dll                                     | 2015.130.4541.0 | 392480    | 27-Oct-2018 | 04:10 | x86      |
| Dtsconn.dll                                     | 2015.130.4541.0 | 492624    | 27-Oct-2018 | 04:10 | x64      |
| Dtshost.exe                                     | 2015.130.4541.0 | 76576     | 27-Oct-2018 | 04:10 | x86      |
| Dtshost.exe                                     | 2015.130.4541.0 | 86608     | 27-Oct-2018 | 04:11 | x64      |
| Dtslog.dll                                      | 2015.130.4541.0 | 103200    | 27-Oct-2018 | 04:10 | x86      |
| Dtslog.dll                                      | 2015.130.4541.0 | 120400    | 27-Oct-2018 | 04:10 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4541.0 | 541472    | 27-Oct-2018 | 04:10 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4541.0 | 545360    | 27-Oct-2018 | 04:10 | x64      |
| Dtspipeline.dll                                 | 2015.130.4541.0 | 1059616   | 27-Oct-2018 | 04:10 | x86      |
| Dtspipeline.dll                                 | 2015.130.4541.0 | 1279056   | 27-Oct-2018 | 04:10 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4541.0 | 42272     | 27-Oct-2018 | 04:10 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4541.0 | 48208     | 27-Oct-2018 | 04:10 | x64      |
| Dtswizard.exe                                   | 13.0.4541.0     | 896288    | 27-Oct-2018 | 03:59 | x86      |
| Dtswizard.exe                                   | 13.0.4541.0     | 895568    | 27-Oct-2018 | 04:11 | x64      |
| Dtuparse.dll                                    | 2015.130.4541.0 | 80192     | 27-Oct-2018 | 04:10 | x86      |
| Dtuparse.dll                                    | 2015.130.4541.0 | 87632     | 27-Oct-2018 | 04:10 | x64      |
| Dtutil.exe                                      | 2015.130.4541.0 | 115520    | 27-Oct-2018 | 04:10 | x86      |
| Dtutil.exe                                      | 2015.130.4541.0 | 134744    | 27-Oct-2018 | 04:11 | x64      |
| Exceldest.dll                                   | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:10 | x86      |
| Exceldest.dll                                   | 2015.130.4541.0 | 263760    | 27-Oct-2018 | 04:10 | x64      |
| Excelsrc.dll                                    | 2015.130.4541.0 | 232736    | 27-Oct-2018 | 04:10 | x86      |
| Excelsrc.dll                                    | 2015.130.4541.0 | 285264    | 27-Oct-2018 | 04:10 | x64      |
| Flatfiledest.dll                                | 2015.130.4541.0 | 334624    | 27-Oct-2018 | 04:10 | x86      |
| Flatfiledest.dll                                | 2015.130.4541.0 | 389200    | 27-Oct-2018 | 04:10 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4541.0 | 345376    | 27-Oct-2018 | 04:10 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4541.0 | 401488    | 27-Oct-2018 | 04:10 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4541.0 | 80672     | 27-Oct-2018 | 04:10 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4541.0 | 96336     | 27-Oct-2018 | 04:10 | x64      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4541.0     | 92448     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4541.0     | 1313568   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4541.0     | 696608    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4541.0     | 763680    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4541.0 | 2023200   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4541.0 | 42072     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4541.0     | 71440     | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4541.0     | 186640    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4541.0     | 433936    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4541.0     | 433752    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4541.0     | 2044688   | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4541.0     | 2044504   | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4541.0     | 33568     | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4541.0     | 33368     | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4541.0     | 249632    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4541.0     | 249432    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4541.0     | 502048    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:09 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4541.0     | 606496    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4541.0     | 106272    | 27-Oct-2018 | 04:10 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4541.0 | 150104    | 27-Oct-2018 | 04:11 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4541.0 | 138832    | 27-Oct-2018 | 04:11 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4541.0 | 158808    | 27-Oct-2018 | 04:11 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4541.0 | 144464    | 27-Oct-2018 | 04:11 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4541.0 | 89888     | 27-Oct-2018 | 04:09 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4541.0 | 100944    | 27-Oct-2018 | 04:10 | x64      |
| Msmdlocal.dll                                   | 2015.130.4541.0 | 37103392  | 27-Oct-2018 | 04:09 | x86      |
| Msmdlocal.dll                                   | 2015.130.4541.0 | 56207952  | 27-Oct-2018 | 04:10 | x64      |
| Msmdpp.dll                                      | 2015.130.4541.0 | 6370592   | 27-Oct-2018 | 04:09 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4541.0 | 7507232   | 27-Oct-2018 | 04:09 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4541.0 | 6507600   | 27-Oct-2018 | 04:13 | x86      |
| Msolap130.dll                                   | 2015.130.4541.0 | 7008544   | 27-Oct-2018 | 04:09 | x86      |
| Msolap130.dll                                   | 2015.130.4541.0 | 8639568   | 27-Oct-2018 | 04:10 | x64      |
| Msolui130.dll                                   | 2015.130.4541.0 | 287520    | 27-Oct-2018 | 04:09 | x86      |
| Msolui130.dll                                   | 2015.130.4541.0 | 310352    | 27-Oct-2018 | 04:10 | x64      |
| Oledbdest.dll                                   | 2015.130.4541.0 | 216864    | 27-Oct-2018 | 04:09 | x86      |
| Oledbdest.dll                                   | 2015.130.4541.0 | 264272    | 27-Oct-2018 | 04:10 | x64      |
| Oledbsrc.dll                                    | 2015.130.4541.0 | 235808    | 27-Oct-2018 | 04:09 | x86      |
| Oledbsrc.dll                                    | 2015.130.4541.0 | 290896    | 27-Oct-2018 | 04:10 | x64      |
| Profiler.exe                                    | 2015.130.4541.0 | 804640    | 27-Oct-2018 | 04:09 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4541.0 | 100432    | 27-Oct-2018 | 04:10 | x64      |
| Sqldumper.exe                                   | 2015.130.4541.0 | 107840    | 27-Oct-2018 | 04:10 | x86      |
| Sqldumper.exe                                   | 2015.130.4541.0 | 127056    | 27-Oct-2018 | 04:10 | x64      |
| Sqlresld.dll                                    | 2015.130.4541.0 | 30992     | 27-Oct-2018 | 04:09 | x64      |
| Sqlresld.dll                                    | 2015.130.4541.0 | 28960     | 27-Oct-2018 | 04:09 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4541.0 | 31000     | 27-Oct-2018 | 04:09 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4541.0 | 28448     | 27-Oct-2018 | 04:09 | x86      |
| Sqlscm.dll                                      | 2015.130.4541.0 | 61200     | 27-Oct-2018 | 04:09 | x64      |
| Sqlscm.dll                                      | 2015.130.4541.0 | 53024     | 27-Oct-2018 | 04:09 | x86      |
| Sqlsvc.dll                                      | 2015.130.4541.0 | 152336    | 27-Oct-2018 | 04:09 | x64      |
| Sqlsvc.dll                                      | 2015.130.4541.0 | 127264    | 27-Oct-2018 | 04:09 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4541.0 | 181008    | 27-Oct-2018 | 04:09 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4541.0 | 151328    | 27-Oct-2018 | 04:09 | x86      |
| Txdataconvert.dll                               | 2015.130.4541.0 | 255056    | 27-Oct-2018 | 04:09 | x86      |
| Txdataconvert.dll                               | 2015.130.4541.0 | 296720    | 27-Oct-2018 | 04:09 | x64      |
| Xe.dll                                          | 2015.130.4541.0 | 626448    | 27-Oct-2018 | 04:09 | x64      |
| Xe.dll                                          | 2015.130.4541.0 | 558880    | 27-Oct-2018 | 04:10 | x86      |
| Xmlrw.dll                                       | 2015.130.4541.0 | 259664    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrw.dll                                       | 2015.130.4541.0 | 319248    | 27-Oct-2018 | 04:09 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4541.0 | 191568    | 27-Oct-2018 | 04:09 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4541.0 | 227600    | 27-Oct-2018 | 04:09 | x64      |
| Xmsrv.dll                                       | 2015.130.4541.0 | 32727632  | 27-Oct-2018 | 04:09 | x86      |
| Xmsrv.dll                                       | 2015.130.4541.0 | 24050968  | 27-Oct-2018 | 04:09 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
